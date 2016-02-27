# cfml_optional
##Class to handle Nulls in CFML

Handling NULL references can be tedious in some situations in CFML, particularly when using the ORM, which may often return NULL references, or using Java libraries which may return NULL. 

cfml_optional is a signle .CFC file which makes instatiating objects & values which may be null, and handling that null possibility gracefully.
