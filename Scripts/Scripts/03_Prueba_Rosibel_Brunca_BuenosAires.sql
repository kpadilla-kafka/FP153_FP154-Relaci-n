/* =========================================================
PRUEBA CONTROLADA FP153 ↔ FP154
USUARIO: ROSIBEL CASCANTE FALLAS
REGIÓN: BRUNCA
ARS: BUENOS AIRES
TRÁMITE: 20
FECHA: 2026-06-19

Objetivo:
Validar la creación de relaciones entre la familia
FP153 (Usuarios Delegados) y FP154 (Ramas Gestor de Usuarios)
para un usuario existente.

Alcance de la prueba:

* Usuario FP153:
  Rosibel Cascante Fallas
  ID FP153 = 22

* Región:
  Brunca

* Área Rectora:
  ARS Buenos Aires

* Roles asociados:
  7.6.7.1.1 → Funcionario revisor PSF
  7.6.7.1.2 → Funcionario firmante PSF
  7.6.7.1.3 → Funcionario reportería PSF

Resultado esperado:

La FP153 debe mostrar tres relaciones activas
correspondientes a los tres roles definidos para
ARS Buenos Aires.

Resultado obtenido:

✓ Relación creada con rama 7.6.7.1.1
✓ Relación creada con rama 7.6.7.1.2
✓ Relación creada con rama 7.6.7.1.3

Total relaciones creadas: 3

Validación funcional:

Desde la FP153 de Rosibel Cascante Fallas se
visualizan correctamente las tres ramas
relacionadas en la sección "Ramas de usuarios".

Esta prueba se considera exitosa y sirve como
base para la carga masiva de los demás usuarios
de la Región Brunca.
========================================================= */
