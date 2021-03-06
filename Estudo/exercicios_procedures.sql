
-- CRIANDO UMA TABELA DE CURSOS PARA REALIZAÇÃO DOS EXERCÍCIOS.
    CREATE TABLE CURSO(
        COD_CURSO NUMBER (5) CONSTRAINT PK_COD_CURSO PRIMARY KEY,
        NOME VARCHAR(150) NOT NULL,
        VALOR NUMBER(8, 2),
        CARGA_HORARIA NUMBER(3)
        );

  -- INSERE OS CURSOS COM SEUS RESPECTIVOS NOME,VALOR E CARGAHORARIA
    INSERT INTO CURSO VALUES (1, 'ORACLE SQL E PL/SQL', 599.00, 25);
    INSERT INTO CURSO VALUES (2, 'ORACLE DBA', 699.0, 25);
    INSERT INTO CURSO VALUES (3, 'JAVA FUNDAMENTOS E OO', 1599.00, 100);
    INSERT INTO CURSO VALUES (4, 'JAVASERVER FACES', 1749.99, 100);
    INSERT INTO CURSO VALUES (5, 'PHP', 1145, 100);
    INSERT INTO CURSO VALUES (6, 'LÓGICA', 100, 20);

    -- CRIA UMA PROCEDURE PARA ATUALIZAÇÃO DO NOME DO CURSO.
CREATE OR REPLACE PROCEDURE PROC_ATUALIZA_NOME_CURSO
    (P_COD CURSO.COD_CURSO%TYPE,
     P_NOME CURSO.NOME%TYPE)IS
 BEGIN
    UPDATE CURSO SET NOME = P_NOME
 WHERE COD_CURSO = P_COD;
    COMMIT;
    END;
    -- EXECUTA A PROCEDURE
  EXECUTE PROC_ATUALIZA_NOME_CURSO(4,'JAVA SERVER FACES')

    -- CRIANDO UMA PROCEDURE PARA CONSULTA DO CURSO PELO CODIGO.
CREATE OR REPLACE PROCEDURE PROC_CONSULTA_CURSO
    (P_COD IN CURSO.COD_CURSO%TYPE)
        IS
        V_NOME CURSO.NOME%TYPE;
        V_VALOR CURSO.VALOR%TYPE;
        BEGIN
        SELECT NOME,VALOR INTO V_NOME ,V_VALOR FROM CURSO
        WHERE
        COD_CURSO = P_COD;
        DBMS_OUTPUT.PUT_LINE('CURSO: '||V_NOME||' VALOR DO CURSO:R$'||V_VALOR);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('DADOS DO CURSO NÃO ENCONTRADOS');
        END;
        -- EXECUTA A PROCEDURE
    EXECUTE PROC_CONSULTA_CURSO(6)
--------------------------------------------------------------------
-- CRANDO UMA TABELA DE PRODUTOS PARA REALIZAÇÃO DE EXERCÍCIOS
CREATE TABLE PRODUTO(
    CODIGO_PROD NUMBER(4) PRIMARY KEY,
    NOME VARCHAR2(20),
    VALOR NUMBER(7, 2),
    CATEGORIA NUMBER(4)
    );


    INSERT INTO PRODUTO VALUES (1, 'PRODUTO1', 2.5, 10);
    INSERT INTO PRODUTO VALUES (2, 'PRODUTO2', 3.2, 20);
    INSERT INTO PRODUTO VALUES (3, 'PRODUTO3', 5.8, 30);

-- CRIANDO UMA PROCEDURE PARA REALIZAÇÃO DE DELETE
  CREATE OR REPLACE PROCEDURE PROC_DELETE_PRODUTO
  (P_COD IN PRODUTO.CODIGO_PROD%TYPE)
  IS
  BEGIN
  DELETE FROM PRODUTO WHERE CODIGO_PROD = P_COD;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('PRODUTO NÃO EXISTE');
  COMMIT;
  END;
    -- EXECUTA A PROCEDURE
  EXECUTE PROC_DELETE_PRODUTO(3);
