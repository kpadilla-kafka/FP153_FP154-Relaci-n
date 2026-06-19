/* =========================================================
VALIDACIÓN DE USUARIOS FP153
PROYECTO MINSA - TRÁMITE 20
FECHA: 2026-06-19

Objetivo:
Validar los usuarios existentes en la familia propia
FP153 (Usuarios Delegados) y obtener su ID interno
para utilizarlo posteriormente en los scripts de
creación de relaciones FP153 ↔ FP154.

Observación:
Los IDs obtenidos en esta consulta deben utilizarse
en la variable @IdUsuario153 de los scripts de carga.
========================================================= */

SELECT
ID,
[1_Super usuario institucion/Name] AS Usuario
FROM dbo.AP_Dyn_Familias_153
ORDER BY ID;
GO
