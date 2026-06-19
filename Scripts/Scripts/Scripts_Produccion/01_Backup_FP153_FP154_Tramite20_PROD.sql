/* =========================================================
   RESPALDO PREVIO A IMPLEMENTACIÓN EN PRODUCCIÓN

   Proyecto: MINSA - Permiso Sanitario de Funcionamiento
   Fecha: 19/06/2026

   Descripción:
   Se realiza respaldo preventivo de las familias FP153,
   FP154 y relaciones asociadas al trámite 20 antes de
   ejecutar el proceso de reconstrucción de ramas y
   asignaciones de usuarios delegados.

   Objetivo:
   Garantizar la recuperación de la información original
   en caso de requerir reversión durante la implementación.

   Respaldos generados:
   - BKP_FP153_20260619_PROD
   - BKP_FP154_Tramite20_20260619_PROD
   - BKP_Relaciones_Tramite20_20260619_PROD
   ========================================================= */


USE [AuraPortal_BPMS_PROD];
GO

/* =========================================================
   BACKUP FP153 - FP154 - RELACIONES
   AMBIENTE: PRODUCCIÓN
   PROYECTO MINSA - TRÁMITE 20
   FECHA: 2026-06-19
   ========================================================= */

-- 1. Backup completo FP153
SELECT *
INTO dbo.BKP_FP153_20260619_PROD
FROM dbo.AP_Dyn_Familias_153;

-- 2. Backup FP154 únicamente trámite 20
SELECT *
INTO dbo.BKP_FP154_Tramite20_20260619_PROD
FROM dbo.AP_Dyn_Familias_154
WHERE [1_VUI - Procesos/Name] = 20;

-- 3. Backup relaciones actuales asociadas al trámite 20
SELECT rel.*
INTO dbo.BKP_Relaciones_Tramite20_20260619_PROD
FROM dbo.AP__FamilyRelational_Data rel
INNER JOIN dbo.AP_Dyn_Familias_154 f154
    ON f154.ID = rel.ElementFamily2Id
WHERE rel.RelationId = 25
  AND f154.[1_VUI - Procesos/Name] = 20;

-- 4. Validación de respaldos
SELECT COUNT(*) AS TotalBKP_FP153
FROM dbo.BKP_FP153_20260619_PROD;

SELECT COUNT(*) AS TotalBKP_FP154_Tramite20
FROM dbo.BKP_FP154_Tramite20_20260619_PROD;

SELECT COUNT(*) AS TotalBKP_Relaciones_Tramite20
FROM dbo.BKP_Relaciones_Tramite20_20260619_PROD;
