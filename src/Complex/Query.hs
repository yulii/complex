{-# LANGUAGE FlexibleInstances #-}
module Complex.Query where

import Data.Word (Word32, Word64)
import Data.Text (Text, pack)
import Data.List

data Entity  = MTagEntity

-- SQLで利用する基本型を定義
class Show e => SQLType e where
  showL :: e -> [Char]

instance SQLType [Char] where
  showL e = "'" ++ e ++ "'"


-- SQL 文の節を定義
-- SELECT の projection
-- WHERE の condition
-- ORDER BY / LIMIT / OFFSET などの option
class SQLClause e where
  -- 文節の構築式を定義する
  express :: e -> [Char]

-- SELECT 節の定義
-- TODO: 別名定義 (AS) の対応 / c1, c2 の連番で設定する？
data SQLProjection = SQLProjection { projectionEntity :: Entity
                                   , projectionField  :: [Char]
                                   }

instance SQLClause SQLProjection where
  express = projectionField


-- WHERE 節の定義
data SQLCondition a = SQLCondition { conditionField     :: SQLProjection
                                   , conditionOperation :: SQLProjection -> a -> [Char]
                                   , conditionValue     :: a
                                   }

instance SQLClause (SQLCondition a) where
  express e = conditionOperation e (conditionField e) (conditionValue e)
-- <END>

-------------------------------------------------------------------
data MTag = MTag { mTagId          :: Word64
                 , mTagPids        :: Maybe Text
                 , mTagName        :: Text
                 , mTagDescription :: Text
                 } deriving (Eq, Show)

data MTagField = MTagId | MTagPids | MTagName | MTagDescription


entityDef MTagEntity = "m_tag"

fieldDef :: MTagField -> SQLProjection
fieldDef MTagId          = SQLProjection { projectionEntity = MTagEntity ,projectionField = "id"          }
fieldDef MTagPids        = SQLProjection { projectionEntity = MTagEntity ,projectionField = "pids"        }
fieldDef MTagName        = SQLProjection { projectionEntity = MTagEntity ,projectionField = "name"        }
fieldDef MTagDescription = SQLProjection { projectionEntity = MTagEntity ,projectionField = "description" }


-- SQL 構文の節を構築する
-- NOT の定義式は？？？
(.=) f v = SQLCondition { conditionField = (fieldDef f), conditionOperation = operate, conditionValue = v }
  where
    operate :: SQLType a => SQLProjection -> a -> [Char]
    operate fn val = (projectionField fn) ++ " = " ++ (showL val)


select' ps = (++) " SELECT " $ intercalate ", " $ map (express . fieldDef) ps
from' t = (++) " FROM " $ entityDef t
where' :: [SQLCondition a] -> [Char]
where'  cs = (++) " WHERE " $ intercalate " AND " $ map express cs

test_exec = select' [ MTagId
                    , MTagPids
                    , MTagName
                    , MTagDescription
            ]
            ++ from' MTagEntity
            ++ where' [ MTagId   .= "2"
                      , MTagName .= "KEYWORD"
                      ]

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
  



-- テスト用モデル
--data MTag = MTag { mTagId          :: Word64
--                 , mTagPids        :: Maybe Text
--                 , mTagName        :: Text
--                 , mTagDescription :: Text
--                 } deriving (Eq, Show)
--
--instance Entity MTag where
--  entityName _ = "m_tag"
--  newEntity = MTag { mTagId   = undefined
--                   , mTagPids = undefined
--                   , mTagName = undefined
--                   , mTagDescription = (pack "DEFAULT")
--                   }

