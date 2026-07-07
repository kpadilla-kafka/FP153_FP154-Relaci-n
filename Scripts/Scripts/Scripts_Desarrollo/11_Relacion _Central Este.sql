/* =========================================================
RELACIÓN COMPLETA FP153 ↔ FP154
REGIÓN: CENTRAL ESTE
TRÁMITE: 20
FECHA: 2026-06-19

Objetivo:
Crear las tareas correspondientes en la familia propia
FP154 (Ramas de Usuarios) para la Región Central Este
y establecer las relaciones con los usuarios delegados
existentes en la FP153.

Usuarios incluidos:

* ID 25: Ana Gabriela Monestel Brenes
* ID 26: Mariela Díaz Ríos
* ID 27: Nuria Isela Villalta Solano

Alcance:

* 7 Áreas Rectoras de Salud (ARS).
* 3 roles por ARS:
  • Funcionario revisor PSF
  • Funcionario firmante PSF
  • Funcionario reportería PSF
* 21 tareas por usuario.
* 63 tareas totales para la Región Central Este.

Resultado esperado:

* Creación de registros en FP154 para cada rol y ARS.
* Creación de relaciones FP153 ↔ FP154 (RelationId = 25).
* Visualización de 21 ramas asociadas para cada usuario
  dentro de la FP153 (Usuarios Delegados).

Consideraciones:

* La configuración de ramas y cargos fue construida
  utilizando la estructura oficial del árbol de empleados
  suministrado por MINSA.
* Se respeta la nomenclatura y distribución existente
  de las ramas organizacionales para garantizar
  consistencia con la configuración actual del sistema.

========================================================= */
USE [AuraPortal_BPMS_DES];
GO

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRAN;

    DECLARE @IdUsuario153 INT = 25; -- Ana Gabriela Monestel Brenes
    -- Para Mariela: DECLARE @IdUsuario153 INT = 26; -- Mariela Díaz Ríos
    -- Para Nuria:   DECLARE @IdUsuario153 INT = 27; -- Nuria Isela Villalta Solano

    DECLARE @NuevasRamas TABLE (IdRama154 INT);

    DECLARE @RamasCentralEste TABLE (
        Rama NVARCHAR(50),
        UnidadOrganizativa NVARCHAR(250),
        Cargo NVARCHAR(100)
    );

    INSERT INTO @RamasCentralEste VALUES
    ('7.6.5.1.1.','Región Central Este - ARS Cartago','Funcionario revisor PSF'),
    ('7.6.5.1.2.','Región Central Este - ARS Cartago','Funcionario firmante PSF'),
    ('7.6.5.1.3.','Región Central Este - ARS Cartago','Funcionario reportería PSF'),

    ('7.6.5.2.1.','Región Central Este - ARS El Guarco','Funcionario revisor PSF'),
    ('7.6.5.2.2.','Región Central Este - ARS El Guarco','Funcionario firmante PSF'),
    ('7.6.5.2.3.','Región Central Este - ARS El Guarco','Funcionario reportería PSF'),

    ('7.6.5.3.1.','Región Central Este - ARS La Unión','Funcionario revisor PSF'),
    ('7.6.5.3.2.','Región Central Este - ARS La Unión','Funcionario firmante PSF'),
    ('7.6.5.3.3.','Región Central Este - ARS La Unión','Funcionario reportería PSF'),

    ('7.6.5.4.1.','Región Central Este - ARS Los Santos','Funcionario revisor PSF'),
    ('7.6.5.4.2.','Región Central Este - ARS Los Santos','Funcionario firmante PSF'),
    ('7.6.5.4.3.','Región Central Este - ARS Los Santos','Funcionario reportería PSF'),

    ('7.6.5.5.1.','Región Central Este - ARS Oreamuno','Funcionario revisor PSF'),
    ('7.6.5.5.2.','Región Central Este - ARS Oreamuno','Funcionario firmante PSF'),
    ('7.6.5.5.3.','Región Central Este - ARS Oreamuno','Funcionario reportería PSF'),

    ('7.6.5.6.1.','Región Central Este - ARS Paraíso','Funcionario revisor PSF'),
    ('7.6.5.6.2.','Región Central Este - ARS Paraíso','Funcionario firmante PSF'),
    ('7.6.5.6.3.','Región Central Este - ARS Paraíso','Funcionario reportería PSF'),

    ('7.6.5.7.1.','Región Central Este - ARS Turrialba','Funcionario revisor PSF'),
    ('7.6.5.7.2.','Región Central Este - ARS Turrialba','Funcionario firmante PSF'),
    ('7.6.5.7.3.','Región Central Este - ARS Turrialba','Funcionario reportería PSF');

    IF (SELECT COUNT(*) FROM @RamasCentralEste) <> 21
        THROW 50001, 'La cantidad de ramas Central Este no es 21.', 1;

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
    FROM @RamasCentralEste r;

    IF (SELECT COUNT(*) FROM @NuevasRamas) <> 21
        THROW 50002, 'No se crearon 21 tareas FP154 para el usuario.', 1;

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
    ) <> 21
        THROW 50003, 'No se crearon 21 relaciones para el usuario.', 1;

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
      AND f154.[3_Institución a la que pertenece] LIKE 'Región Central Este%'
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
