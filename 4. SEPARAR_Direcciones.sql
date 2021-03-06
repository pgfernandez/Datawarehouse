USE ODS;

ALTER TABLE ODS_HC_DIRECCIONES ADD NOMBRE_VIA VARCHAR(512);
ALTER TABLE ODS_HC_DIRECCIONES ADD NUM_VIA VARCHAR(10);

SET SQL_SAFE_UPDATES = 0;

UPDATE ODS_HC_DIRECCIONES TMP1
INNER JOIN (SELECT ID_DIRECCION, SUBSTRING(DE_DIRECCION, POSITION(' ' IN DE_DIRECCION)) AS CALLE FROM ODS_HC_DIRECCIONES) AS TMP2 ON TMP2.ID_DIRECCION = TMP1.ID_DIRECCION
SET TMP1.NOMBRE_VIA = TRIM(TMP2.CALLE);

SET SQL_SAFE_UPDATES = 0;

UPDATE ODS_HC_DIRECCIONES TMP1
INNER JOIN (SELECT ID_DIRECCION, LEFT(DE_DIRECCION,(POSITION(' ' IN DE_DIRECCION))) AS NUMERO FROM ODS.ODS_HC_DIRECCIONES) AS TMP2 ON TMP2.ID_DIRECCION = TMP1.ID_DIRECCION
SET TMP1.NUM_VIA = TRIM(TMP2.NUMERO);

#PARECE QUE NO SE PIDE ELIMINAR EL CAMPO DE_DIRECCION, SI FUESE ASÍ
#ALTER TABLE ODS_HC_DIRECCIONES DROP COLUMN DE_DIRECCION;

COMMIT;
SET SQL_SAFE_UPDATES = 1;
