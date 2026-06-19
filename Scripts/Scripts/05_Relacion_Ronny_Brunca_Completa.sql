/* =========================================================
   RELACIÓN COMPLETA FP153 ↔ FP154
   USUARIO: RONNY FONSECA FALLAS
   REGIÓN: BRUNCA
   TRÁMITE: 20
   FECHA: 2026-06-19

   Objetivo:
   Crear 18 tareas nuevas en FP154 para el usuario
   Ronny Fonseca Fallas y relacionarlas con su registro
   existente en FP153.

   Alcance:
   6 Áreas Rectoras de Salud x 3 roles = 18 relaciones.

   Usuario FP153:
   ID 23 - Ronny Fonseca Fallas

   Resultado esperado:
   - FP154 debe incrementar en 18 registros para Región Brunca.
   - FP153 de Ronny debe mostrar 18 ramas asociadas.
   - Las relaciones deben quedar registradas con RelationId = 25.

   Observación:
   A diferencia de la primera prueba, este script crea
   nuevas tareas FP154 para el usuario, evitando reutilizar
   las tareas ya creadas para Rosibel.
   ========================================================= */
USE [AuraPortal_BPMS_DES];
GO

SET XACT_ABORT ON;
BEGIN TRAN;

DECLARE @IdUsuario153 INT = 23; -- Ronny Fonseca Fallas

DECLARE @NuevasRamas TABLE (IdRama154 INT);

DECLARE @RamasBrunca TABLE (
    Rama NVARCHAR(50),
    UnidadOrganizativa NVARCHAR(250),
    Cargo NVARCHAR(100)
);

INSERT INTO @RamasBrunca VALUES
('7.6.7.1.1.', 'Región Brunca - ARS Buenos Aires', 'Funcionario revisor PSF'),
('7.6.7.1.2.', 'Región Brunca - ARS Buenos Aires', 'Funcionario firmante PSF'),
('7.6.7.1.3.', 'Región Brunca - ARS Buenos Aires', 'Funcionario reportería PSF'),

('7.6.7.2.1.', 'Región Brunca - ARS Corredores', 'Funcionario revisor PSF'),
('7.6.7.2.2.', 'Región Brunca - ARS Corredores', 'Funcionario firmante PSF'),
('7.6.7.2.3.', 'Región Brunca - ARS Corredores', 'Funcionario reportería PSF'),

('7.6.7.3.1.', 'Región Brunca - ARS Coto Brus', 'Funcionario revisor PSF'),
('7.6.7.3.2.', 'Región Brunca - ARS Coto Brus', 'Funcionario firmante PSF'),
('7.6.7.3.3.', 'Región Brunca - ARS Coto Brus', 'Funcionario reportería PSF'),

('7.6.7.4.1.', 'Región Brunca - ARS Golfito', 'Funcionario revisor PSF'),
('7.6.7.4.2.', 'Región Brunca - ARS Golfito', 'Funcionario firmante PSF'),
('7.6.7.4.3.', 'Región Brunca - ARS Golfito', 'Funcionario reportería PSF'),

('7.6.7.5.1.', 'Región Brunca - ARS Osa', 'Funcionario revisor PSF'),
('7.6.7.5.2.', 'Región Brunca - ARS Osa', 'Funcionario firmante PSF'),
('7.6.7.5.3.', 'Región Brunca - ARS Osa', 'Funcionario reportería PSF'),

('7.6.7.6.1.', 'Región Brunca - ARS Pérez Zeledón', 'Funcionario revisor PSF'),
('7.6.7.6.2.', 'Región Brunca - ARS Pérez Zeledón', 'Funcionario firmante PSF'),
('7.6.7.6.3.', 'Región Brunca - ARS Pérez Zeledón', 'Funcionario reportería PSF');

-- 1. Crear 18 tareas nuevas en FP154 para Ronny
INSERT INTO dbo.AP_Dyn_Familias_154
(
    [_ElementID], [Creado], [IdCreador], [TipoCreador],
    [Modificado], [IdModificador], [TipoModificador],
    [_FamilyClass], [_Name], [_SecureRoomID],
    [3_Institución a la que pertenece],
    [3_Nombre de cargo],
    [3_Nombre institución login],
    [2_Página a asignar/IdPágina],
    [3_IdPortal],
    [1_Página a asignar],
    [1_Página a asignar/Name],
    [2_Página a asignar/IdPortal],
    [3_Instituciones en la VUI],
    [3_Acrónimo],
    [1_VUI - Procesos],
    [1_VUI - Procesos/Name],
    [2_VUI - Procesos/_Nm-VUI - Listado de procesos en producción],
    [2_VUI - Procesos/Nombre de proceso]
)
OUTPUT INSERTED.ID INTO @NuevasRamas
SELECT
    0, GETDATE(), 35, 0,
    GETDATE(), 35, 0,
    157, r.Rama, 0,
    r.UnidadOrganizativa,
    r.Cargo,
    NULL,
    378,
    94,
    1,
    'Página genérica de empleados VUI',
    94,
    12386,
    'MINSA',
    3,
    20,
    20,
    'MINSA - Permiso Sanitario de Funcionamiento'
FROM @RamasBrunca r;

-- 2. Relacionar esas 18 tareas nuevas con Ronny
INSERT INTO dbo.AP__FamilyRelational_Data
(
    CreatorId, Created, CreatorType,
    ModifierId, Modified, ModifierType,
    RelationId, ElementFamily1Id, ElementFamily2Id
)
SELECT
    35, GETDATE(), 0,
    35, GETDATE(), 0,
    25,
    @IdUsuario153,
    nr.IdRama154
FROM @NuevasRamas nr;

-- 3. Validar resultado
SELECT
    f153.[1_Super usuario institucion/Name] AS Usuario,
    f154.ID AS IdRama154,
    f154.[_Name] AS Rama,
    f154.[3_Institución a la que pertenece] AS UnidadOrganizativa,
    f154.[3_Nombre de cargo] AS Cargo
FROM dbo.AP__FamilyRelational_Data rel
INNER JOIN dbo.AP_Dyn_Familias_153 f153
    ON f153.ID = rel.ElementFamily1Id
INNER JOIN dbo.AP_Dyn_Familias_154 f154
    ON f154.ID = rel.ElementFamily2Id
WHERE rel.RelationId = 25
  AND rel.ElementFamily1Id = @IdUsuario153
  AND f154.[1_VUI - Procesos/Name] = 20
  AND f154.[3_Institución a la que pertenece] LIKE 'Región Brunca%'
ORDER BY f154.[_Name], f154.ID;

-- Si devuelve 18 filas correctas:
COMMIT;

-- Si algo sale raro:
-- ROLLBACK;
