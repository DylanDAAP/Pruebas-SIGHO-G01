-- =====================================================================
-- SISTEMA DE GESTION HOSPITALARIA (SIGHO) - MODELO FISICO ORACLE
-- Autores: GR01. ALVARADO_ALVARADO_ERAZO
-- Fecha: 04/11/2026
-- =====================================================================

-- Tabla: ROL
CREATE TABLE ROL (
id_rol NUMBER(10) NOT NULL,
nombre_rol VARCHAR2(50) NOT NULL,
descripcion VARCHAR2(200) NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_rol PRIMARY KEY (id_rol)
);

-- Tabla: USUARIO
CREATE TABLE USUARIO (
id_usuario NUMBER(10) NOT NULL,
id_rol NUMBER(10) NOT NULL,
nombre_usuario VARCHAR2(50) NOT NULL,
password_hash VARCHAR2(255) NOT NULL,
nombres VARCHAR2(100) NOT NULL,
apellidos VARCHAR2(100) NOT NULL,
correo VARCHAR2(120) NOT NULL,
telefono VARCHAR2(20) NULL,
activo NUMBER(10) NOT NULL,
primer_ingreso NUMBER(10) NOT NULL,
fecha_creacion DATE NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario)
);

-- Tabla: PERMISO
CREATE TABLE PERMISO (
id_permiso NUMBER(10) NOT NULL,
codigo_permiso VARCHAR2(50) NOT NULL,
modulo VARCHAR2(50) NOT NULL,
descripcion VARCHAR2(200) NULL,
    CONSTRAINT pk_permiso PRIMARY KEY (id_permiso)
);

-- Tabla: ROL_PERMISO
CREATE TABLE ROL_PERMISO (
id_rol_permiso NUMBER(10) NOT NULL,
id_rol NUMBER(10) NOT NULL,
id_permiso NUMBER(10) NOT NULL,
    CONSTRAINT pk_rol_permiso PRIMARY KEY (id_rol_permiso)
);

-- Tabla: AUDITORIA
CREATE TABLE AUDITORIA (
id_auditoria NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
accion VARCHAR2(50) NOT NULL,
tabla_afectada VARCHAR2(60) NOT NULL,
id_registro_afectado VARCHAR2(50) NULL,
valores_anteriores CLOB NULL,
valores_nuevos CLOB NULL,
ip_cliente VARCHAR2(45) NULL,
fecha_hora DATE NOT NULL,
    CONSTRAINT pk_auditoria PRIMARY KEY (id_auditoria)
);

-- Tabla: PARAMETRO_SISTEMA
CREATE TABLE PARAMETRO_SISTEMA (
id_parametro NUMBER(10) NOT NULL,
clave VARCHAR2(60) NOT NULL,
valor VARCHAR2(255) NOT NULL,
descripcion VARCHAR2(200) NULL,
tipo_dato VARCHAR2(30) NULL,
fecha_modificacion DATE NULL,
    CONSTRAINT pk_parametro_sistema PRIMARY KEY (id_parametro)
);

-- Tabla: PACIENTE
CREATE TABLE PACIENTE (
id_paciente NUMBER(10) NOT NULL,
tipo_documento VARCHAR2(20) NOT NULL,
numero_documento VARCHAR2(30) NOT NULL,
nombres VARCHAR2(100) NOT NULL,
apellidos VARCHAR2(100) NOT NULL,
fecha_nacimiento DATE NOT NULL,
sexo CHAR(1) NOT NULL,
estado_civil VARCHAR2(20) NULL,
direccion VARCHAR2(200) NULL,
telefono VARCHAR2(20) NULL,
correo VARCHAR2(120) NULL,
contacto_emergencia VARCHAR2(100) NULL,
telefono_emergencia VARCHAR2(20) NULL,
estado CHAR(1) NOT NULL,
fecha_registro DATE NOT NULL,
    CONSTRAINT pk_paciente PRIMARY KEY (id_paciente)
);

-- Tabla: ESPECIALIDAD
CREATE TABLE ESPECIALIDAD (
id_especialidad NUMBER(10) NOT NULL,
nombre_especialidad VARCHAR2(80) NOT NULL,
descripcion VARCHAR2(200) NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_especialidad PRIMARY KEY (id_especialidad)
);

-- Tabla: MEDICO
CREATE TABLE MEDICO (
id_medico NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
id_especialidad NUMBER(10) NOT NULL,
numero_colegiatura VARCHAR2(30) NOT NULL,
nombres VARCHAR2(100) NOT NULL,
apellidos VARCHAR2(100) NOT NULL,
telefono VARCHAR2(20) NULL,
consultorio_defecto VARCHAR2(30) NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_medico PRIMARY KEY (id_medico)
);

-- Tabla: HORARIO_MEDICO
CREATE TABLE HORARIO_MEDICO (
id_horario NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
dia_semana VARCHAR2(15) NOT NULL,
hora_inicio TIME NOT NULL,
hora_fin TIME NOT NULL,
duracion_cita_min NUMBER(10) NOT NULL,
consultorio VARCHAR2(30) NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_horario_medico PRIMARY KEY (id_horario)
);

-- Tabla: CITA
CREATE TABLE CITA (
id_cita NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
fecha_cita DATE NOT NULL,
hora_cita TIME NOT NULL,
motivo_consulta VARCHAR2(250) NULL,
estado_cita VARCHAR2(30) NOT NULL,
fecha_registro DATE NOT NULL,
    CONSTRAINT pk_cita PRIMARY KEY (id_cita)
);

-- Tabla: LLEGADA_PACIENTE
CREATE TABLE LLEGADA_PACIENTE (
id_llegada NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_cita NUMBER(10) NULL,
fecha_hora_llegada DATE NOT NULL,
motivo_visita VARCHAR2(200) NULL,
estado_llegada VARCHAR2(30) NOT NULL,
observaciones VARCHAR2(250) NULL,
    CONSTRAINT pk_llegada_paciente PRIMARY KEY (id_llegada)
);

-- Tabla: HISTORIA_CLINICA
CREATE TABLE HISTORIA_CLINICA (
id_historia NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
numero_expediente VARCHAR2(40) NOT NULL,
fecha_apertura DATE NOT NULL,
antecedentes_personales CLOB NULL,
antecedentes_familiares CLOB NULL,
alergias CLOB NULL,
grupo_sanguineo VARCHAR2(10) NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_historia_clinica PRIMARY KEY (id_historia)
);

-- Tabla: ATENCION_CLINICA
CREATE TABLE ATENCION_CLINICA (
id_atencion NUMBER(10) NOT NULL,
id_historia NUMBER(10) NOT NULL,
id_cita NUMBER(10) NULL,
id_medico NUMBER(10) NOT NULL,
fecha_hora_atencion DATE NOT NULL,
tipo_atencion VARCHAR2(30) NOT NULL,
motivo_consulta CLOB NOT NULL,
examen_fisico CLOB NULL,
diagnostico_presuntivo VARCHAR2(250) NULL,
diagnostico_definitivo VARCHAR2(250) NULL,
codigo_cie10 VARCHAR2(20) NULL,
plan_tratamiento CLOB NULL,
notas_evolucion CLOB NULL,
    CONSTRAINT pk_atencion_clinica PRIMARY KEY (id_atencion)
);

-- Tabla: TRIAJE
CREATE TABLE TRIAJE (
id_triaje NUMBER(10) NOT NULL,
id_atencion NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
nivel_prioridad NUMBER(10) NOT NULL,
motivo_urgencia VARCHAR2(250) NULL,
fecha_hora_triaje DATE NOT NULL,
    CONSTRAINT pk_triaje PRIMARY KEY (id_triaje)
);

-- Tabla: SIGNOS_VITALES
CREATE TABLE SIGNOS_VITALES (
id_signo_vital NUMBER(10) NOT NULL,
id_atencion NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
fecha_hora_registro DATE NOT NULL,
presion_sistolica NUMBER(10) NULL,
presion_diastolica NUMBER(10) NULL,
frecuencia_cardiaca NUMBER(10) NULL,
frecuencia_respiratoria NUMBER(10) NULL,
temperatura NUMBER(4,2) NULL,
saturacion_oxigeno NUMBER(10) NULL,
peso_kg NUMBER(5,2) NULL,
talla_cm NUMBER(5,2) NULL,
imc NUMBER(4,2) NULL,
    CONSTRAINT pk_signos_vitales PRIMARY KEY (id_signo_vital)
);

-- Tabla: TIPO_EXAMEN_LAB
CREATE TABLE TIPO_EXAMEN_LAB (
id_tipo_examen NUMBER(10) NOT NULL,
codigo_examen VARCHAR2(30) NOT NULL,
nombre_examen VARCHAR2(120) NOT NULL,
categoria VARCHAR2(60) NULL,
valores_referencia CLOB NULL,
costo_referencial NUMBER(10,2) NOT NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_tipo_examen_lab PRIMARY KEY (id_tipo_examen)
);

-- Tabla: SOLICITUD_LABORATORIO
CREATE TABLE SOLICITUD_LABORATORIO (
id_solicitud_lab NUMBER(10) NOT NULL,
id_atencion NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
fecha_solicitud DATE NOT NULL,
prioridad VARCHAR2(20) NOT NULL,
estado_solicitud VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_solicitud_laboratorio PRIMARY KEY (id_solicitud_lab)
);

-- Tabla: DETALLE_SOLICITUD_LAB
CREATE TABLE DETALLE_SOLICITUD_LAB (
id_detalle_lab NUMBER(10) NOT NULL,
id_solicitud_lab NUMBER(10) NOT NULL,
id_tipo_examen NUMBER(10) NOT NULL,
observaciones VARCHAR2(200) NULL,
    CONSTRAINT pk_detalle_solicitud_lab PRIMARY KEY (id_detalle_lab)
);

-- Tabla: RESULTADO_LABORATORIO
CREATE TABLE RESULTADO_LABORATORIO (
id_resultado_lab NUMBER(10) NOT NULL,
id_detalle_lab NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
fecha_hora_resultado DATE NOT NULL,
valor_resultado VARCHAR2(250) NOT NULL,
unidad_medida VARCHAR2(30) NULL,
valor_referencial VARCHAR2(100) NULL,
observacion_clinica CLOB NULL,
estado_resultado VARCHAR2(30) NOT NULL,
firmado_por VARCHAR2(100) NULL,
    CONSTRAINT pk_resultado_laboratorio PRIMARY KEY (id_resultado_lab)
);

-- Tabla: TIPO_ESTUDIO_IMAGEN
CREATE TABLE TIPO_ESTUDIO_IMAGEN (
id_tipo_estudio NUMBER(10) NOT NULL,
codigo_estudio VARCHAR2(30) NOT NULL,
nombre_estudio VARCHAR2(120) NOT NULL,
modalidad VARCHAR2(30) NOT NULL,
indicaciones_previas CLOB NULL,
costo_referencial NUMBER(10,2) NOT NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_tipo_estudio_imagen PRIMARY KEY (id_tipo_estudio)
);

-- Tabla: SOLICITUD_IMAGEN
CREATE TABLE SOLICITUD_IMAGEN (
id_solicitud_img NUMBER(10) NOT NULL,
id_atencion NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
fecha_solicitud DATE NOT NULL,
prioridad VARCHAR2(20) NOT NULL,
justificacion_clinica CLOB NULL,
estado_solicitud VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_solicitud_imagen PRIMARY KEY (id_solicitud_img)
);

-- Tabla: INFORME_IMAGEN
CREATE TABLE INFORME_IMAGEN (
id_informe_img NUMBER(10) NOT NULL,
id_solicitud_img NUMBER(10) NOT NULL,
id_tipo_estudio NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
fecha_informe DATE NOT NULL,
hallazgos CLOB NOT NULL,
conclusion CLOB NOT NULL,
ruta_archivo_dicom VARCHAR2(255) NULL,
estado_informe VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_informe_imagen PRIMARY KEY (id_informe_img)
);

-- Tabla: MEDICAMENTO
CREATE TABLE MEDICAMENTO (
id_medicamento NUMBER(10) NOT NULL,
codigo_medicamento VARCHAR2(30) NOT NULL,
nombre_generico VARCHAR2(120) NOT NULL,
nombre_comercial VARCHAR2(120) NULL,
concentracion VARCHAR2(60) NULL,
forma_farmaceutica VARCHAR2(60) NULL,
stock_actual NUMBER(10) NOT NULL,
stock_minimo NUMBER(10) NOT NULL,
precio_unitario NUMBER(10,2) NOT NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_medicamento PRIMARY KEY (id_medicamento)
);

-- Tabla: LOTE_MEDICAMENTO
CREATE TABLE LOTE_MEDICAMENTO (
id_lote NUMBER(10) NOT NULL,
id_medicamento NUMBER(10) NOT NULL,
numero_lote VARCHAR2(40) NOT NULL,
fecha_fabricacion DATE NULL,
fecha_vencimiento DATE NOT NULL,
cantidad_inicial NUMBER(10) NOT NULL,
cantidad_disponible NUMBER(10) NOT NULL,
estado_lote VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_lote_medicamento PRIMARY KEY (id_lote)
);

-- Tabla: PRESCRIPCION
CREATE TABLE PRESCRIPCION (
id_prescripcion NUMBER(10) NOT NULL,
id_atencion NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
fecha_prescripcion DATE NOT NULL,
indicaciones_generales CLOB NULL,
estado VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_prescripcion PRIMARY KEY (id_prescripcion)
);

-- Tabla: DETALLE_PRESCRIPCION
CREATE TABLE DETALLE_PRESCRIPCION (
id_detalle_presc NUMBER(10) NOT NULL,
id_prescripcion NUMBER(10) NOT NULL,
id_medicamento NUMBER(10) NOT NULL,
dosis VARCHAR2(60) NOT NULL,
frecuencia VARCHAR2(60) NOT NULL,
via_administracion VARCHAR2(40) NULL,
duracion_dias NUMBER(10) NOT NULL,
cantidad_prescrita NUMBER(10) NOT NULL,
    CONSTRAINT pk_detalle_prescripcion PRIMARY KEY (id_detalle_presc)
);

-- Tabla: DISPENSACION
CREATE TABLE DISPENSACION (
id_dispensacion NUMBER(10) NOT NULL,
id_prescripcion NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
fecha_hora_dispensacion DATE NOT NULL,
estado_dispensacion VARCHAR2(30) NOT NULL,
observaciones VARCHAR2(250) NULL,
    CONSTRAINT pk_dispensacion PRIMARY KEY (id_dispensacion)
);

-- Tabla: DETALLE_DISPENSACION
CREATE TABLE DETALLE_DISPENSACION (
id_det_disp NUMBER(10) NOT NULL,
id_dispensacion NUMBER(10) NOT NULL,
id_detalle_presc NUMBER(10) NOT NULL,
id_lote NUMBER(10) NOT NULL,
cantidad_dispensada NUMBER(10) NOT NULL,
precio_total NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_detalle_dispensacion PRIMARY KEY (id_det_disp)
);

-- Tabla: SALA
CREATE TABLE SALA (
id_sala NUMBER(10) NOT NULL,
nombre_sala VARCHAR2(60) NOT NULL,
piso VARCHAR2(20) NULL,
pabellon VARCHAR2(60) NULL,
tipo_sala VARCHAR2(40) NOT NULL,
estado CHAR(1) NOT NULL,
    CONSTRAINT pk_sala PRIMARY KEY (id_sala)
);

-- Tabla: CAMA
CREATE TABLE CAMA (
id_cama NUMBER(10) NOT NULL,
id_sala NUMBER(10) NOT NULL,
codigo_cama VARCHAR2(30) NOT NULL,
estado_cama VARCHAR2(30) NOT NULL,
tarifa_diaria NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_cama PRIMARY KEY (id_cama)
);

-- Tabla: ADMISION_HOSPITALARIA
CREATE TABLE ADMISION_HOSPITALARIA (
id_admision_hosp NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
id_cama NUMBER(10) NOT NULL,
fecha_hora_ingreso DATE NOT NULL,
motivo_hospitalizacion CLOB NOT NULL,
diagnostico_ingreso VARCHAR2(250) NULL,
estado_admision VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_admision_hospitalaria PRIMARY KEY (id_admision_hosp)
);

-- Tabla: TRASLADO_CAMA
CREATE TABLE TRASLADO_CAMA (
id_traslado NUMBER(10) NOT NULL,
id_admision_hosp NUMBER(10) NOT NULL,
id_cama_origen NUMBER(10) NOT NULL,
id_cama_destino NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
fecha_hora_traslado DATE NOT NULL,
motivo_traslado VARCHAR2(200) NULL,
    CONSTRAINT pk_traslado_cama PRIMARY KEY (id_traslado)
);

-- Tabla: ALTA_HOSPITALARIA
CREATE TABLE ALTA_HOSPITALARIA (
id_alta NUMBER(10) NOT NULL,
id_admision_hosp NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
fecha_hora_alta DATE NOT NULL,
tipo_alta VARCHAR2(40) NOT NULL,
diagnostico_alta VARCHAR2(250) NULL,
resumen_epicrisis CLOB NULL,
    CONSTRAINT pk_alta_hospitalaria PRIMARY KEY (id_alta)
);

-- Tabla: QUIROFANO
CREATE TABLE QUIROFANO (
id_quirofano NUMBER(10) NOT NULL,
nombre_quirofano VARCHAR2(60) NOT NULL,
equipamiento CLOB NULL,
estado VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_quirofano PRIMARY KEY (id_quirofano)
);

-- Tabla: SOLICITUD_QUIRURGICA
CREATE TABLE SOLICITUD_QUIRURGICA (
id_solicitud_qx NUMBER(10) NOT NULL,
id_atencion NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_medico NUMBER(10) NOT NULL,
procedimiento_propuesto VARCHAR2(200) NOT NULL,
tipo_anestesia VARCHAR2(50) NULL,
fecha_propuesta DATE NOT NULL,
prioridad VARCHAR2(20) NOT NULL,
estado_solicitud VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_solicitud_quirurgica PRIMARY KEY (id_solicitud_qx)
);

-- Tabla: PROCEDIMIENTO_QUIRURGICO
CREATE TABLE PROCEDIMIENTO_QUIRURGICO (
id_procedimiento_qx NUMBER(10) NOT NULL,
id_solicitud_qx NUMBER(10) NOT NULL,
id_quirofano NUMBER(10) NOT NULL,
id_cirujano_principal NUMBER(10) NOT NULL,
fecha_hora_inicio DATE NOT NULL,
fecha_hora_fin DATE NULL,
diagnostico_preoperatorio VARCHAR2(250) NULL,
diagnostico_postoperatorio VARCHAR2(250) NULL,
procedimiento_realizado CLOB NOT NULL,
hallazgos CLOB NULL,
complicaciones CLOB NULL,
estado_qx VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_procedimiento_quirurgico PRIMARY KEY (id_procedimiento_qx)
);

-- Tabla: EQUIPO_QUIRURGICO
CREATE TABLE EQUIPO_QUIRURGICO (
id_equipo_qx NUMBER(10) NOT NULL,
id_procedimiento_qx NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
rol_qx VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_equipo_quirurgico PRIMARY KEY (id_equipo_qx)
);

-- Tabla: CARGO_CUENTA
CREATE TABLE CARGO_CUENTA (
id_cargo NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_atencion NUMBER(10) NULL,
concepto_cargo VARCHAR2(200) NOT NULL,
tipo_servicio VARCHAR2(40) NOT NULL,
cantidad NUMBER(10) NOT NULL,
valor_unitario NUMBER(10,2) NOT NULL,
valor_total NUMBER(10,2) NOT NULL,
estado_cargo VARCHAR2(30) NOT NULL,
fecha_cargo DATE NOT NULL,
    CONSTRAINT pk_cargo_cuenta PRIMARY KEY (id_cargo)
);

-- Tabla: COMPROBANTE_PAGO
CREATE TABLE COMPROBANTE_PAGO (
id_comprobante NUMBER(10) NOT NULL,
id_paciente NUMBER(10) NOT NULL,
id_usuario NUMBER(10) NOT NULL,
tipo_comprobante VARCHAR2(30) NOT NULL,
numero_comprobante VARCHAR2(40) NOT NULL,
fecha_emision DATE NOT NULL,
subtotal NUMBER(10,2) NOT NULL,
iva NUMBER(10,2) NOT NULL,
total NUMBER(10,2) NOT NULL,
estado_comprobante VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_comprobante_pago PRIMARY KEY (id_comprobante)
);

-- Tabla: DETALLE_COMPROBANTE
CREATE TABLE DETALLE_COMPROBANTE (
id_det_comp NUMBER(10) NOT NULL,
id_comprobante NUMBER(10) NOT NULL,
id_cargo NUMBER(10) NOT NULL,
descripcion VARCHAR2(200) NOT NULL,
cantidad NUMBER(10) NOT NULL,
precio_unitario NUMBER(10,2) NOT NULL,
total_linea NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_detalle_comprobante PRIMARY KEY (id_det_comp)
);

-- Tabla: PAGO
CREATE TABLE PAGO (
id_pago NUMBER(10) NOT NULL,
id_comprobante NUMBER(10) NOT NULL,
forma_pago VARCHAR2(40) NOT NULL,
monto_pagado NUMBER(10,2) NOT NULL,
referencia_transaccion VARCHAR2(60) NULL,
fecha_hora_pago DATE NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY (id_pago)
);

ALTER TABLE USUARIO ADD CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES ROL (id_rol);
ALTER TABLE ROL_PERMISO ADD CONSTRAINT fk_rol_permiso_rol FOREIGN KEY (id_rol) REFERENCES ROL (id_rol);
ALTER TABLE ROL_PERMISO ADD CONSTRAINT fk_rol_permiso_permiso FOREIGN KEY (id_permiso) REFERENCES PERMISO (id_permiso);
ALTER TABLE AUDITORIA ADD CONSTRAINT fk_auditoria_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE MEDICO ADD CONSTRAINT fk_medico_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE MEDICO ADD CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES ESPECIALIDAD (id_especialidad);
ALTER TABLE HORARIO_MEDICO ADD CONSTRAINT fk_horario_medico_medico FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE CITA ADD CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE CITA ADD CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE LLEGADA_PACIENTE ADD CONSTRAINT fk_llegada_paciente_paciente FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE LLEGADA_PACIENTE ADD CONSTRAINT fk_llegada_paciente_cita FOREIGN KEY (id_cita) REFERENCES CITA (id_cita);
ALTER TABLE HISTORIA_CLINICA ADD CONSTRAINT fk_historia_clinica_paciente FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE ATENCION_CLINICA ADD CONSTRAINT fk_atencion_clinica_historia FOREIGN KEY (id_historia) REFERENCES HISTORIA_CLINICA (id_historia);
ALTER TABLE ATENCION_CLINICA ADD CONSTRAINT fk_atencion_clinica_cita FOREIGN KEY (id_cita) REFERENCES CITA (id_cita);
ALTER TABLE ATENCION_CLINICA ADD CONSTRAINT fk_atencion_clinica_medico FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE TRIAJE ADD CONSTRAINT fk_triaje_atencion_clinica FOREIGN KEY (id_atencion) REFERENCES ATENCION_CLINICA (id_atencion);
ALTER TABLE SIGNOS_VITALES ADD CONSTRAINT fk_signos_vitales_atencion_c FOREIGN KEY (id_atencion) REFERENCES ATENCION_CLINICA (id_atencion);
ALTER TABLE SIGNOS_VITALES ADD CONSTRAINT fk_signos_vitales_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE SOLICITUD_LABORATORIO ADD CONSTRAINT fk_solicitud_laboratorio_ate FOREIGN KEY (id_atencion) REFERENCES ATENCION_CLINICA (id_atencion);
ALTER TABLE SOLICITUD_LABORATORIO ADD CONSTRAINT fk_solicitud_laboratorio_pac FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE SOLICITUD_LABORATORIO ADD CONSTRAINT fk_solicitud_laboratorio_med FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE DETALLE_SOLICITUD_LAB ADD CONSTRAINT fk_detalle_solicitud_lab_sol FOREIGN KEY (id_solicitud_lab) REFERENCES SOLICITUD_LABORATORIO (id_solicitud_lab);
ALTER TABLE DETALLE_SOLICITUD_LAB ADD CONSTRAINT fk_detalle_solicitud_lab_tip FOREIGN KEY (id_tipo_examen) REFERENCES TIPO_EXAMEN_LAB (id_tipo_examen);
ALTER TABLE RESULTADO_LABORATORIO ADD CONSTRAINT fk_resultado_laboratorio_det FOREIGN KEY (id_detalle_lab) REFERENCES DETALLE_SOLICITUD_LAB (id_detalle_lab);
ALTER TABLE RESULTADO_LABORATORIO ADD CONSTRAINT fk_resultado_laboratorio_usu FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE SOLICITUD_IMAGEN ADD CONSTRAINT fk_solicitud_imagen_atencion FOREIGN KEY (id_atencion) REFERENCES ATENCION_CLINICA (id_atencion);
ALTER TABLE SOLICITUD_IMAGEN ADD CONSTRAINT fk_solicitud_imagen_paciente FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE SOLICITUD_IMAGEN ADD CONSTRAINT fk_solicitud_imagen_medico FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE INFORME_IMAGEN ADD CONSTRAINT fk_informe_imagen_solicitud_ FOREIGN KEY (id_solicitud_img) REFERENCES SOLICITUD_IMAGEN (id_solicitud_img);
ALTER TABLE INFORME_IMAGEN ADD CONSTRAINT fk_informe_imagen_tipo_estud FOREIGN KEY (id_tipo_estudio) REFERENCES TIPO_ESTUDIO_IMAGEN (id_tipo_estudio);
ALTER TABLE INFORME_IMAGEN ADD CONSTRAINT fk_informe_imagen_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE PRESCRIPCION ADD CONSTRAINT fk_prescripcion_atencion_cli FOREIGN KEY (id_atencion) REFERENCES ATENCION_CLINICA (id_atencion);
ALTER TABLE PRESCRIPCION ADD CONSTRAINT fk_prescripcion_medico FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE DETALLE_PRESCRIPCION ADD CONSTRAINT fk_detalle_prescripcion_pres FOREIGN KEY (id_prescripcion) REFERENCES PRESCRIPCION (id_prescripcion);
ALTER TABLE DETALLE_PRESCRIPCION ADD CONSTRAINT fk_detalle_prescripcion_medi FOREIGN KEY (id_medicamento) REFERENCES MEDICAMENTO (id_medicamento);
ALTER TABLE LOTE_MEDICAMENTO ADD CONSTRAINT fk_lote_medicamento_medicame FOREIGN KEY (id_medicamento) REFERENCES MEDICAMENTO (id_medicamento);
ALTER TABLE DISPENSACION ADD CONSTRAINT fk_dispensacion_prescripcion FOREIGN KEY (id_prescripcion) REFERENCES PRESCRIPCION (id_prescripcion);
ALTER TABLE DISPENSACION ADD CONSTRAINT fk_dispensacion_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE DETALLE_DISPENSACION ADD CONSTRAINT fk_detalle_dispensacion_disp FOREIGN KEY (id_dispensacion) REFERENCES DISPENSACION (id_dispensacion);
ALTER TABLE DETALLE_DISPENSACION ADD CONSTRAINT fk_detalle_dispensacion_deta FOREIGN KEY (id_detalle_presc) REFERENCES DETALLE_PRESCRIPCION (id_detalle_presc);
ALTER TABLE DETALLE_DISPENSACION ADD CONSTRAINT fk_detalle_dispensacion_lote FOREIGN KEY (id_lote) REFERENCES LOTE_MEDICAMENTO (id_lote);
ALTER TABLE CAMA ADD CONSTRAINT fk_cama_sala FOREIGN KEY (id_sala) REFERENCES SALA (id_sala);
ALTER TABLE ADMISION_HOSPITALARIA ADD CONSTRAINT fk_admision_hospitalaria_pac FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE ADMISION_HOSPITALARIA ADD CONSTRAINT fk_admision_hospitalaria_med FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE ADMISION_HOSPITALARIA ADD CONSTRAINT fk_admision_hospitalaria_cam FOREIGN KEY (id_cama) REFERENCES CAMA (id_cama);
ALTER TABLE TRASLADO_CAMA ADD CONSTRAINT fk_traslado_cama_admision_ho FOREIGN KEY (id_admision_hosp) REFERENCES ADMISION_HOSPITALARIA (id_admision_hosp);
ALTER TABLE ALTA_HOSPITALARIA ADD CONSTRAINT fk_alta_hospitalaria_admisio FOREIGN KEY (id_admision_hosp) REFERENCES ADMISION_HOSPITALARIA (id_admision_hosp);
ALTER TABLE ALTA_HOSPITALARIA ADD CONSTRAINT fk_alta_hospitalaria_medico FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE SOLICITUD_QUIRURGICA ADD CONSTRAINT fk_solicitud_quirurgica_aten FOREIGN KEY (id_atencion) REFERENCES ATENCION_CLINICA (id_atencion);
ALTER TABLE SOLICITUD_QUIRURGICA ADD CONSTRAINT fk_solicitud_quirurgica_paci FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE SOLICITUD_QUIRURGICA ADD CONSTRAINT fk_solicitud_quirurgica_medi FOREIGN KEY (id_medico) REFERENCES MEDICO (id_medico);
ALTER TABLE PROCEDIMIENTO_QUIRURGICO ADD CONSTRAINT fk_procedimiento_quirurgico_ FOREIGN KEY (id_solicitud_qx) REFERENCES SOLICITUD_QUIRURGICA (id_solicitud_qx);
ALTER TABLE PROCEDIMIENTO_QUIRURGICO ADD CONSTRAINT fk_procedimiento_quirurgico_ FOREIGN KEY (id_quirofano) REFERENCES QUIROFANO (id_quirofano);
ALTER TABLE PROCEDIMIENTO_QUIRURGICO ADD CONSTRAINT fk_procedimiento_quirurgico_ FOREIGN KEY (id_medico) REFERENCES MEDICO (id_cirujano_principal);
ALTER TABLE EQUIPO_QUIRURGICO ADD CONSTRAINT fk_equipo_quirurgico_procedi FOREIGN KEY (id_procedimiento_qx) REFERENCES PROCEDIMIENTO_QUIRURGICO (id_procedimiento_qx);
ALTER TABLE EQUIPO_QUIRURGICO ADD CONSTRAINT fk_equipo_quirurgico_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE CARGO_CUENTA ADD CONSTRAINT fk_cargo_cuenta_paciente FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE CARGO_CUENTA ADD CONSTRAINT fk_cargo_cuenta_atencion_cli FOREIGN KEY (id_atencion) REFERENCES ATENCION_CLINICA (id_atencion);
ALTER TABLE COMPROBANTE_PAGO ADD CONSTRAINT fk_comprobante_pago_paciente FOREIGN KEY (id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE COMPROBANTE_PAGO ADD CONSTRAINT fk_comprobante_pago_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario);
ALTER TABLE DETALLE_COMPROBANTE ADD CONSTRAINT fk_detalle_comprobante_compr FOREIGN KEY (id_comprobante) REFERENCES COMPROBANTE_PAGO (id_comprobante);
ALTER TABLE DETALLE_COMPROBANTE ADD CONSTRAINT fk_detalle_comprobante_cargo FOREIGN KEY (id_cargo) REFERENCES CARGO_CUENTA (id_cargo);
ALTER TABLE PAGO ADD CONSTRAINT fk_pago_comprobante_pago FOREIGN KEY (id_comprobante) REFERENCES COMPROBANTE_PAGO (id_comprobante);