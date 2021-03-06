
/* CURSORES

CURSORES EXPLÍCITOS (Retornam 0 ou mais linhas)

Sintaxe básica para declaração de de um cursor.
CURSOR NOME_DO_CURSOR IS
SELECT COLUNA_1, COLUNA_2, COLUNA_N FROM NOME_TABELA

OPEN abre o cursor ,FETCH posiciona cursor na próxima linha.
CLOSE fecha o cursor.
*/

-- Exemplo  de utilização de um cursor explícito

-- Exemplo_1 de utilização de um cursor
SET SERVEROUTPUT ON
DECLARE
CURSOR CRS_ALUNOS IS
SELECT MATRICULA,NOME FROM ALUNOS;
VRL_ALUNO CRS_ALUNOS%ROWTYPE;
BEGIN
OPEN CRS_ALUNOS;
LOOP
FETCH CRS_ALUNOS INTO VRL_ALUNO;
EXIT WHEN CRS_ALUNOS%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Aluno: '||VRL_ALUNO.NOME||' - MATRICULA: '||VRL_ALUNO.MATRICULA);
END LOOP;
CLOSE CRS_ALUNOS;
END;
/

--Utilizando FOR...LOOP para visualização dos dados

SET SERVEROUTPUT ON
DECLARE
CURSOR CRS_ALUNOS IS
SELECT MATRICULA,NOME FROM ALUNOS;
BEGIN
FOR VRL_ALUNO IN CRS_ALUNOS
LOOP
IF VRL_ALUNO.MATRICULA > 2217202016 THEN
CLOSE CRS_ALUNOS;
ELSE
DBMS_OUTPUT.PUT_LINE('Aluno: '||VRL_ALUNO.NOME||' - Matricula '||VRL_ALUNO.MATRICULA);
END IF;
END LOOP;
END;
/

/* CURSORES IMPLÍCITOS (Retornam apenas uma linha)
Processa instruções (SELECT … INTO, INSERT, UPDATE e DELETE).
OPEN, FETCH e CLOSE,não podem ser aplicados a este tipo de cursor.
*/

-- Exemplo de utilzação de cursores implícitos usando %NOTFOUND
-- para verificar a existência de um registro.

DECLARE
VRL_MATRICULA ALUNOS.MATRICULA%TYPE := 2217202019;
VRL_NOME ALUNOS.NOME%TYPE := 'Adriana Andrade';
BEGIN
UPDATE ALUNOS SET NOME = VRL_NOME WHERE MATRICULA = VRL_MATRICULA;
IF SQL%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE('Atualização não realizada!');
ELSE
DBMS_OUTPUT.PUT_LINE('Atualização realizada com sucesso!');
END IF;
COMMIT;
END;
/

-- Passando uma variável para o cursor.
--
SET SERVEROUTPUT ON
DECLARE
CURSOR CRS_ALUNOS(VAR_RA NUMBER) IS
        SELECT MATRICULA,NOME FROM ALUNOS WHERE MATRICULA = VAR_RA
        FOR UPDATE OF NOME NOWAIT;
                VRL_ALUNO CRS_ALUNOS%ROWTYPE;
            BEGIN
                OPEN CRS_ALUNOS(&CODIGO);
                LOOP
                FETCH CRS_ALUNOS INTO VRL_ALUNO;
                EXIT WHEN CRS_ALUNOS%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('Aluno: '||VRL_ALUNO.NOME||'
                - MATRICULA: '||VRL_ALUNO.MATRICULA);
            END LOOP;
            CLOSE CRS_ALUNOS;
            END;
/            
