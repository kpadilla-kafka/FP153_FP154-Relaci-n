/* =========================================================
   RESULTADO DE EJECUCIÓN

   Relaciones eliminadas : 0
   Registros FP154 eliminados : 248
   Registros restantes trámite 20 : 0

   Estado final:
   Trámite 20 preparado para reconstrucción completa
   de ramas y relaciones utilizando la configuración
   validada en ambiente de Desarrollo.

   Fecha ejecución: 19/06/2026
   ========================================================= */


USE [AuraPortal_BPMS_PROD];
GO

/* =========================================================
   LIMPIEZA CONTROLADA FP154 - TRÁMITE 20
   AMBIENTE: PRODUCCIÓN
   FECHA: 2026-06-19

   Objetivo:
   Eliminar la configuración existente del trámite 20 en
   FP154 para reconstruir las tareas y relaciones desde cero,
   usando los scripts validados previamente en DES.

   Requisito previo:
   Haber ejecutado y validado el backup:
   - BKP_FP153_20260619_PROD
   - BKP_FP154_Tramite20_20260619_PROD
   - BKP_Relaciones_Tramite20_20260619_PROD
   ========================================================= */

BEGIN TRAN;

/* 1. Eliminar relaciones asociadas al trámite 20 */
DELETE rel
FROM dbo.AP__FamilyRelational_Data rel
INNER JOIN dbo.AP_Dyn_Familias_154 f154
    ON f154.ID = rel.ElementFamily2Id
WHERE rel.RelationId = 25
  AND f154.[1_VUI - Procesos/Name] = 20;

SELECT @@ROWCOUNT AS RelacionesEliminadas;

/* 2. Eliminar registros FP154 del trámite 20 */
DELETE FROM dbo.AP_Dyn_Familias_154
WHERE [1_VUI - Procesos/Name] = 20;

SELECT @@ROWCOUNT AS Ramas154Eliminadas;

/* 3. Validar que no queden registros del trámite 20 */
SELECT COUNT(*) AS TotalFP154Tramite20Restante
FROM dbo.AP_Dyn_Familias_154
WHERE [1_VUI - Procesos/Name] = 20;

/* Si todo está correcto:
   - RelacionesEliminadas debería ser 0
   - Ramas154Eliminadas debería ser 248
   - TotalFP154Tramite20Restante debería ser 0
*/

COMMIT;

/* Si algo se ve incorrecto antes del COMMIT:
ROLLBACK;
*/
