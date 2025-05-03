package com.utp.soporte.digital.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "solicitud")
public class Solicitud {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_solicitud", nullable = false)
    private Integer id;

    @Column(name = "fecha_registro", nullable = false)
    private LocalDate fechaRegistro;

    @Lob
    @Column(name = "tipo", nullable = false)
    private String tipo;

    @Lob
    @Column(name = "motivo", nullable = false)
    private String motivo;

    @ColumnDefault("'ABIERTA'")
    @Lob
    @Column(name = "estado")
    private String estado;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "fk_cliente", nullable = false)
    private Cliente fkCliente;

    @OneToMany(mappedBy = "fkSolicitud")
    private Set<Asignacion> asignacions = new LinkedHashSet<>();

}