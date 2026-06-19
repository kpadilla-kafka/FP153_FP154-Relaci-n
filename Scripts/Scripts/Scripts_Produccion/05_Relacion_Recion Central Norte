/* =========================================================
RELACIÓN COMPLETA FP153 ↔ FP154
REGIÓN: CENTRAL NORTE
AMBIENTE: PRODUCCIÓN
TRÁMITE: 20
FECHA: 2026-06-19

Objetivo:
Crear los registros correspondientes en la familia
propia FP154 (Ramas de Usuarios) para la Región
Central Norte y establecer las relaciones con los
usuarios delegados registrados en la FP153.

Usuarios incluidos:

* ID 14: Dayana Melissa Fajardo Aguirre
* ID 15: Hugo Alberto Chavarría Oviedo
* ID 16: Wilder Martínez Álvarez

Alcance:

* 12 Áreas Rectoras de Salud (ARS).
* 3 roles por cada ARS:
  • Funcionario revisor PSF
  • Funcionario firmante PSF
  • Funcionario reportería PSF
* 36 tareas por usuario.
* 108 tareas totales para la Región Central Norte.

  ========================================================= */


USE [AuraPortal_BPMS_PROD];
GO

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRAN;

    DECLARE @IdUsuario153 INT = 14; -- Dayana Melissa Fajardo Aguirre
    -- Para Hugo:   DECLARE @IdUsuario153 INT = 15; -- Hugo Alberto Chavarría Oviedo
    -- Para Wilder: DECLARE @IdUsuario153 INT = 16; -- Wilder Martínez Álvares

    DECLARE @NuevasRamas TABLE (IdRama154 INT);

    DECLARE @RamasCentralNorte TABLE (
        Rama NVARCHAR(50),
        UnidadOrganizativa NVARCHAR(250),
        Cargo NVARCHAR(100)
    );

    INSERT INTO @RamasCentralNorte VALUES
    ('7.6.2.1.1.','Región Central Norte - ARS Alajuela 1','Funcionario revisor PSF'),
    ('7.6.2.1.2.','Región Central Norte - ARS Alajuela 1','Funcionario firmante PSF'),
    ('7.6.2.1.3.','Región Central Norte - ARS Alajuela 1','Funcionario reportería PSF'),

    ('7.6.2.2.1.','Región Central Norte - ARS Alajuela 2','Funcionario revisor PSF'),
    ('7.6.2.2.2.','Región Central Norte - ARS Alajuela 2','Funcionario firmante PSF'),
    ('7.6.2.2.3.','Región Central Norte - ARS Alajuela 2','Funcionario reportería PSF'),

    ('7.6.2.3.1.','Región Central Norte - ARS Atenas','Funcionario revisor PSF'),
    ('7.6.2.3.2.','Región Central Norte - ARS Atenas','Funcionario firmante PSF'),
    ('7.6.2.3.3.','Región Central Norte - ARS Atenas','Funcionario reportería PSF'),

    ('7.6.2.4.1.','Región Central Norte - ARS Grecia','Funcionario revisor PSF'),
    ('7.6.2.4.2.','Región Central Norte - ARS Grecia','Funcionario firmante PSF'),
    ('7.6.2.4.3.','Región Central Norte - ARS Grecia','Funcionario reportería PSF'),

    ('7.6.2.5.1.','Región Central Norte - ARS Belén-Flores','Funcionario revisor PSF'),
    ('7.6.2.5.2.','Región Central Norte - ARS Belén-Flores','Funcionario firmante PSF'),
    ('7.6.2.5.3.','Región Central Norte - ARS Belén-Flores','Funcionario reportería PSF'),

    ('7.6.2.6.1.','Región Central Norte - ARS Heredia','Funcionario revisor PSF'),
    ('7.6.2.6.2.','Región Central Norte - ARS Heredia','Funcionario firmante PSF'),
    ('7.6.2.6.3.','Región Central Norte - ARS Heredia','Funcionario reportería PSF'),

    ('7.6.2.7.1.','Región Central Norte - ARS Poás','Funcionario revisor PSF'),
    ('7.6.2.7.2.','Región Central Norte - ARS Poás','Funcionario firmante PSF'),
    ('7.6.2.7.3.','Región Central Norte - ARS Poás','Funcionario reportería PSF'),

    ('7.6.2.8.1.','Región Central Norte - ARS San Pablo-San Isidro','Funcionario revisor PSF'),
    ('7.6.2.8.2.','Región Central Norte - ARS San Pablo-San Isidro','Funcionario firmante PSF'),
    ('7.6.2.8.3.','Región Central Norte - ARS San Pablo-San Isidro','Funcionario reportería PSF'),

    ('7.6.2.9.1.','Región Central Norte - ARS San Rafael-Barva','Funcionario revisor PSF'),
    ('7.6.2.9.2.','Región Central Norte - ARS San Rafael-Barva','Funcionario firmante PSF'),
    ('7.6.2.9.3.','Región Central Norte - ARS San Rafael-Barva','Funcionario reportería PSF'),

    ('7.6.2.10.1.','Región Central Norte - ARS Santa Bárbara','Funcionario revisor PSF'),
    ('7.6.2.10.2.','Región Central Norte - ARS Santa Bárbara','Funcionario firmante PSF'),
    ('7.6.2.10.3.','Región Central Norte - ARS Santa Bárbara','Funcionario reportería PSF'),

    ('7.6.2.11.1.','Región Central Norte - ARS Santo Domingo','Funcionario revisor PSF'),
    ('7.6.2.11.2.','Región Central Norte - ARS Santo Domingo','Funcionario firmante PSF'),
    ('7.6.2.11.3.','Región Central Norte - ARS Santo Domingo','Funcionario reportería PSF'),

    ('7.6.2.12.1.','Región Central Norte - ARS Sarapiquí','Funcionario revisor PSF'),
    ('7.6.2.12.2.','Región Central Norte - ARS Sarapiquí','Funcionario firmante PSF'),
    ('7.6.2.12.3.','Región Central Norte - ARS Sarapiquí','Funcionario reportería PSF');

    IF (SELECT COUNT(*) FROM @RamasCentralNorte) <> 36
        THROW 50001, 'La cantidad de ramas Central Norte no es 36.', 1;

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
    FROM @RamasCentralNorte r;

    IF (SELECT COUNT(*) FROM @NuevasRamas) <> 36
        THROW 50002, 'No se crearon 36 tareas FP154 para el usuario.', 1;

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

    IF (
        SELECT COUNT(*)
        FROM dbo.AP__FamilyRelational_Data rel
        INNER JOIN @NuevasRamas nr
            ON nr.IdRama154 = rel.ElementFamily2Id
        WHERE rel.RelationId = 25
          AND rel.ElementFamily1Id = @IdUsuario153
    ) <> 36
        THROW 50003, 'No se crearon 36 relaciones para el usuario.', 1;

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
      AND f154.[3_Institución a la que pertenece] LIKE 'Región Central Norte%'
    ORDER BY f154.[_Name], f154.ID;

    COMMIT;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
