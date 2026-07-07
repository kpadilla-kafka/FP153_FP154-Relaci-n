--Script Date: 07/07/2026

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
