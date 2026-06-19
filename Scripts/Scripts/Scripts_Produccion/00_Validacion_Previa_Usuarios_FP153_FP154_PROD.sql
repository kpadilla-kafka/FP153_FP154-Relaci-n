/* =========================================================
   VALIDACIÓN PREVIA A IMPLEMENTACIÓN EN PRODUCCIÓN

   Proyecto: MINSA - Permiso Sanitario de Funcionamiento
   Ambiente: Producción
   Fecha: 19/06/2026

   ========================================================= */
/* =========================================================
   VALIDACIÓN DE USUARIOS FP153

   Objetivo:
   Obtener los IDs reales de los usuarios delegados
   registrados en Producción para utilizarlos durante la
   reconstrucción de relaciones FP153 ↔ FP154.

   Resultado:
   Generación del mapeo oficial de usuarios e IDs para la
   ejecución de scripts regionales.
   ========================================================= */

SELECT
    ID,
    [1_Super usuario institucion/Name] AS Usuario
FROM dbo.AP_Dyn_Familias_153
ORDER BY ID;

/* Mapeo obtenido:
   Rosibel = 8
   Ronny = 9
   Michael = 10
   ...
*/

/* =========================================================
   VALIDACIÓN DE RAMAS FP154

   Objetivo:
   Verificar la estructura existente de ramas asociadas al
   trámite 20 en Producción, incluyendo códigos de rama,
   unidades organizativas y cargos configurados.

   Resultado:
   Confirmación de la estructura actual antes de realizar
   procesos de limpieza y reconstrucción.
   ========================================================= */

SELECT
    ID,
    [_Name] AS Rama,
    [3_Institución a la que pertenece] AS UnidadOrganizativa,
    [3_Nombre de cargo] AS Cargo
FROM dbo.AP_Dyn_Familias_154
WHERE [1_VUI - Procesos/Name] = 20
ORDER BY [_Name];

/* =========================================================
   VALIDACIÓN DE RELACIONES EXISTENTES

   Objetivo:
   Verificar la existencia de relaciones activas entre las
   familias FP153 y FP154 mediante RelationId = 25.

   Resultado:
   Determinar la cantidad de relaciones existentes previo
   a la implementación y validar si el trámite 20 posee
   asignaciones activas.
   ========================================================= */

SELECT
    rel.ElementFamily1Id,
    f153.[1_Super usuario institucion/Name] AS Usuario,
    COUNT(*) AS TotalRelaciones
FROM dbo.AP__FamilyRelational_Data rel
INNER JOIN dbo.AP_Dyn_Familias_153 f153
    ON f153.ID = rel.ElementFamily1Id
WHERE rel.RelationId = 25
GROUP BY
    rel.ElementFamily1Id,
    f153.[1_Super usuario institucion/Name]
ORDER BY Usuario;


/*Mapeo:

Rosibel  = 8
Ronny    = 9
Michael  = 10

Ana      = 11
Mariela  = 12
Nuria    = 13

Dayana   = 14
Hugo     = 15
Wilder   = 16

Bibiana  = 17
Danny    = 18

Leidy    = 19
Carlos   = 20

Roger    = 21
Jenory   = 22
José M.  = 23

Alfredo  = 24
Rolando  = 25
Dayanna  = 33
Marcela  = 34
Freddy   = 35
Juan P.  = 36*/

------------------------------------
