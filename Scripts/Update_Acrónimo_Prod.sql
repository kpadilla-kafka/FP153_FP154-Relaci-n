/*
===============================================================
ACTUALIZACIÓN DE ACRÓNIMO - FP154
AMBIENTE: PRODUCCIÓN
FECHA: 2026-07-07

Objetivo:
Actualizar el campo [3_Acrónimo] de las tareas de la
Familia Propia 154 correspondientes al Trámite 20,
cambiando el valor 'MINSA' por 'misalud'.

Alcance:
- Familia Propia 154.
- Trámite 20.
- Registros afectados: 638.

El procedimiento incluye:
- Validación previa.
- Respaldo de los registros afectados.
- Actualización del campo.
- Validación posterior.
===============================================================
*/

--Validar:

    SELECT COUNT(*) AS TotalAActualizar
FROM dbo.AP_Dyn_Familias_154
WHERE [1_VUI - Procesos/Name] = 20
  AND [3_Acrónimo] = 'MINSA';

-----------------------------------------------------------

USE [AuraPortal_BPMS_PROD];
GO

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRAN;

    /* Validación previa */
    SELECT COUNT(*) AS TotalMINSA_Antes
    FROM dbo.AP_Dyn_Familias_154
    WHERE [1_VUI - Procesos/Name] = 20
      AND [3_Acrónimo] = 'MINSA';

    /* Backup solo de los registros que se van a actualizar */
    SELECT *
    INTO dbo.BKP_FP154_Acronimo_MINSA_20260619_PROD
    FROM dbo.AP_Dyn_Familias_154
    WHERE [1_VUI - Procesos/Name] = 20
      AND [3_Acrónimo] = 'MINSA';

    /* Actualización */
    UPDATE dbo.AP_Dyn_Familias_154
    SET [3_Acrónimo] = 'misalud'
    WHERE [1_VUI - Procesos/Name] = 20
      AND [3_Acrónimo] = 'MINSA';

    SELECT @@ROWCOUNT AS RegistrosActualizados;

    /* Validación posterior */
    SELECT COUNT(*) AS TotalMisalud_Despues
    FROM dbo.AP_Dyn_Familias_154
    WHERE [1_VUI - Procesos/Name] = 20
      AND [3_Acrónimo] = 'misalud';

    SELECT COUNT(*) AS TotalMINSA_Despues
    FROM dbo.AP_Dyn_Familias_154
    WHERE [1_VUI - Procesos/Name] = 20
      AND [3_Acrónimo] = 'MINSA';

    COMMIT;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
