{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
module Complex.Query where

import Data.Word (Word32, Word64)
import Data.Text (Text, pack)
import Data.List

-- SQLで利用する基本型を定義
class Show e => SQLType e where
  showL :: e -> [Char]

instance SQLType [Char] where
  showL e = "'" ++ e ++ "'"

-- TODO: class 指定で一括定義できないか？？
instance SQLType Word64 where
  showL = show

-- Entity ---------------------------------------------------------------------------
data SQLEntity = SQLEntity { entityId :: [Char] }

class Entity e where
  data Field e 

  -- Default 制約をインスタンスで定義する
  -- Default 定義がないフィールドは undefined で、参照時まで評価をされないようにする
  newEntity :: e

  entityDef :: e -> SQLEntity
  fieldDef  :: Field e -> SQLProjection e


-- SQL 文の節を定義
-- SELECT の projection
-- WHERE の condition
-- ORDER BY / LIMIT / OFFSET などの option
class SQLClause e where
  -- 文節の構築式を定義する
  express :: e -> [Char]

-- SELECT 節の定義
-- TODO: 別名定義 (AS) の対応 / c1, c2 の連番で設定する？
data SQLProjection e = SQLProjection { projectionEntity :: e
                                     , projectionField  :: [Char]
                                     }

instance SQLClause (SQLProjection a) where
  express = projectionField


-- WHERE 節の定義
data SQLCondition e c = SQLCondition { conditionField     :: SQLProjection e
                                     , conditionOperation :: SQLProjection e -> c -> [Char]
                                     , conditionValue     :: c
                                     }

instance SQLClause (SQLCondition a b) where
  express e = conditionOperation e (conditionField e) (conditionValue e)
-- <END>

-- SQL 構文の節を構築する
-- NOT の定義式は？？？
(.=) :: (Entity e, SQLType c) => Field e -> c -> SQLCondition e c
(.=) f v = SQLCondition { conditionField = (fieldDef f), conditionOperation = operate, conditionValue = v }
  where
    operate :: SQLType a => SQLProjection e -> a -> [Char]
    operate fn val = (projectionField fn) ++ " = " ++ (showL val)

-- TODO: 以下の節は、SQLClause インスタンスのリストから射影して構築する？
-- TODO: [SQLClause] の表現で、副問い合わせが記述できるか？？？
select' ps = (++) " SELECT " $ intercalate ", " $ map (express . fieldDef) ps
from' t = (++) " FROM " $ entityId $ entityDef t
where'  cs = (++) " WHERE " $ intercalate " AND " $ map express cs


-- TODO: 無理矢理感があるので、もう少し記述方法を検討
-- SLECT 文の節は以下の形で分解する
--   FROM <-> base
--   JOIN <-> unions
--   WHERE <-> conditions
--   SELECT <-> projections
--   ORDER BY / LIMIT <-> options

-- INSERT 文の節は以下の形で分解する
-- TODO: bulk も検討
-- UPDATE 文の節は以下の形で分解する
-- TODO: bulk も検討
-- DELETE 文の節は以下の形で分解する

--(>:<) base unions = from' base
--(<:=<) set conditions = set

-- サンプル
--SELECT
--  t1.id
--  ,t1.pids
--  ,t1.name
--  ,t1.description
--FROM
--  tags as t1
--WHERE
--  t1.pids IS NULL
--  AND t1.id > 0
--OREDER BY
--  t1.name ASC
--LIMIT
--  0, 10

--(SELECT
--  [(FIELD "id"), (FIELD "pids"), (FIELD "name"), (FIELD "description")]
--  (FROM
--    (Table "tags")
--    (WHERE
--      (AND [(IS_NULL (FIELD "pids")), (> (FIELD "id") 0)])
--    )
--  )
--  (ORDER [ASC (FIELD "name")])
--  (LIMIT 0 10)
--)
  

