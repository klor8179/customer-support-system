package com.utp.soporte.digital.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "asignacion")
public class Asignacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_asignacion", nullable = false)
    private Integer id;

    @ColumnDefault("0")
    @Column(name = "coordinador")
    private Boolean coordinador;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "fk_solicitud", nullable = false)
    private Solicitud fkSolicitud;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "fk_colaborador", nullable = false)
    private Colaborador fkColaborador;

    @OneToMany(mappedBy = "fkAsignacion")
    private Set<Actividad> actividads = new LinkedHashSet<>();

}