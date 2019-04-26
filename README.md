# dsxparser
## Antlr4 ``Go`` parser for the IBM DataStage DSX format
# How to build the parser
  ```
  antlr4 -Dlanguage=Go -visitor -package dsxparser DSX.g4
  go install
  ```
# TODO
## - Add support to DSEXECJOB