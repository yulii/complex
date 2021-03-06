{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
module Complex.Query where
import Complex.Entity

import Data.String           (IsString)
import Data.ByteString.Char8 (ByteString, append, intercalate)
import Data.Word             (Word32, Word64)
import Data.Text             (Text, pack)


--(.=) :: Literal e => f -> e -> String
--(.=) UserId a = express UserId ++ " = " ++ express a -- インスタンンスの関数にしない方が良いのでは？？中身が一緒なので。

--class Field e => StringQuery e where
--  (.=) :: e -> e -> Dummy
--
--class Field e => NullQuery e where

--instance Field Int where
--instance NumberQuery Int where
--  (.=) a b = Dummy 1


-- Clause ---------------------------------------------------------------------------
--class SQLClause e where
--  -- 文節の構築式を定義する
--  express :: e -> ByteString
--  isProjection :: s -> Bool -- SELECT 節の判別
--  isCondition  :: s -> Bool -- WHERE 節の判別
--  isOption     :: s -> Bool -- ORDER BY 節, LIMIT 節, OFFSET 節の判別

--class SQLClause e => SQLProjection e where
--
--
--instance SQLClause SQLField where
--
--instance SQLProjection SQLField where



-- SQL 文の節を定義

-- FROM 節
-- TODO: 別名定義 (AS) の対応 / t1, t2 の連番で設定する？
--data SQLBase = SQLBase { baseId     :: ByteString
--                       , baseEntity :: SQLEntity
--                       , baseJoin   :: [SQLJoin]
--                       }
--
--instance SQLClause SQLBase where
--  express = (append " FROM ") . entityId . baseEntity
--  isProjection _ = False
--  isCondition  _ = False
--  isOption     _ = False
--
---- JOIN 節の定義
----data SQLJoin = SQLJoin { joinId        :: ByteString
----                       , joinEntity    :: SQLEntity
----                       , joinCondition :: [SQLCondition]
----                       }
----
----instance SQLClause SQLJoin where
----  express = (append " JOIN ") . entityId . joinEntity
----  isProjection _ = False
----  isCondition  _ = False
----  isOption     _ = False
--
--
-- SELECT 節の定義
-- TODO: 別名定義 (AS) の対応 / c1, c2 の連番で設定する？
-- TODO: 定数項が内包されるようにする
--data SQLProjection t = SQLProjection { projectionId    :: ByteString
--                                    , projectionField :: SQLField t
--                                    }
--
--instance SQLClause (SQLProjection t) where
--  express = fieldId . projectionField
--  -- express = fieldId . projectionField
--  --isProjection _ = True
--  --isCondition  _ = False
--  --isOption     _ = False

--instance SQLClause [SQLProjection] where
--  express = (append " SELECT ") . (intercalate ", ") . (map express)
--  isProjection _ = False
--  isCondition  _ = False
--  isOption     _ = False

-- WHERE 節の定義
--data SQLCondition = SQLCondition { conditionField     :: SQLProjection
--                                 , conditionOperation :: SQLProjection -> SQLValue -> ByteString
--                                 , conditionValue     :: SQLValue
--                                 }
--
--instance SQLClause SQLCondition where
--  express e = conditionOperation e (conditionField e) (conditionValue e)
--  isProjection _ = False
--  isCondition  _ = True
--  isOption     _ = False

--expressWhere  :: SQLClause a => [a] -> [Char]
--expressWhere  cs = (++) " WHERE "  $ intercalate " AND " $ map express cs
-- <END>
---------------------------------------------------------------------------

--class QuerySet c where
--
--instance QuerySet SQLEntity where

-- SQL 構文の節を構築する
-- NOT の定義式は？？？
--(.<) :: (SQLClause s1, SQLClause s2) => s1 -> s2 -> ByteString
--(.<) s1 s2 = BS.concat [(express s1), " < ", (express s2)]

--(.=) :: (Entity e, SQLType c) => Field e -> c -> SQLCondition e c
--(.=) f v = SQLCondition { conditionField = (fieldDef f), conditionOperation = operate, conditionValue = v }
--  where
--    operate :: SQLType a => SQLProjection e -> a -> [Char]
--    operate fn val = (projectionField fn) ++ " = " ++ (showL val)

-- TODO: 別名を振る方法も検討
-- カンマ、AND 演算子で配列をjoin するロジックと、別名を振るロジックを抽象化してまとめられないか？
--select' ps = express $ map toProjection ps
--  where
--    toProjection f = SQLProjection { projectionId = undefined, projectionField = (fieldDef f) }
----from'   t  = (++) " FROM " $ entityId $ entityDef t
--
--
--expressSQL :: SQLBase -> [SQLProjection] -> [SQLCondition] -> ByteString
--expressSQL base ps cs = append (express ps) (express base)
--
---- TODO: 無理矢理感があるので、もう少し記述方法を検討
---- SLECT 文の節は以下の形で分解する
----   FROM <-> base
----   JOIN <-> unions
----   WHERE <-> conditions
----   SELECT <-> projections
----   ORDER BY / LIMIT <-> options
--
---- INSERT 文の節は以下の形で分解する
---- TODO: bulk も検討
---- UPDATE 文の節は以下の形で分解する
---- TODO: bulk も検討
---- DELETE 文の節は以下の形で分解する
--
---- FROM 節とJOIN 節による基底集合の定義
--(>:<<) :: Entity e => Table e -> [SQLJoin] -> SQLBase
--(>:<<) base join = SQLBase { baseId = undefined, baseEntity = (entityDef base), baseJoin = join }
--(<:=<) set bounds = append (express ps) (express set)
--  where
--    ps = filter (isProjection) bounds
--    cs = filter (isCondition)  bounds
--    os = filter (isOption)     bounds


