Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACF4C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 07:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7VJB-0000p1-S5; Thu, 16 May 2024 03:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s7VJ6-0000oY-Uy
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:13:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s7VIz-0003R4-Oz
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:13:40 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso3958556a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715843612; x=1716448412; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c9Kq/zl20GAVshx2fjEIH/WYY8aS58rOeELwBzxWCrE=;
 b=CdWm6qak7LMBZ0YMuheUZ/y3QzeryzFslY2xY5SevGPdv8i+rOBKs1cRYYQNuZbNwZ
 VMEV9oXCqYd+4DypwJsy90jJVPsT3xmh1dkBBLNTkk7maH4CgIUr3t9mWJIAg72hrh+L
 JwIBLL7VnhFpq0NyMKCH/627tntA6jIELpHfAgQTaUzUfajas6Xm82RdOTQq4RgTiQjh
 /Um80/cj9iJyDX9qhGyswyHrI6iPTYms1hgqqUH7DotpPolq5GY0qsqp4GmG4qIRs0uI
 eIRoYMDBbyW1MMW+irHqKi+Q0zfIHgMal09UimII6nb8EdHQLjOLOFZZ9GOJCdiaQ2bp
 V8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715843612; x=1716448412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9Kq/zl20GAVshx2fjEIH/WYY8aS58rOeELwBzxWCrE=;
 b=KR2iMwkqnx94e+YCiHpcJRT92HVdj9SkSBc6ZIKItaejfrkfCuX2++HKtun2tlXQTp
 QZ49FJ7DG4xgkNj2nm8wi2bd9LHSBii6zTLHvONtDRhJ79T4PThxLGUmFiiZ/uwZ64oB
 bewda+EnE0/dGvaUjGto7E8Pk1bx+CfhcHZKSPYeSSyyBcRJ/ObCIkqVFLBISFpSmSn8
 x5XmTw59+xUMnCJNsoNu54/22O64IGWL9S//3aodHcD2RtQ3PLd7y94IzCTARaewxAkl
 kEhLJL3oaLPzmBBBvfUcUYzfQDrE1anl+0iLElouTAojpDcH11w2qceSyzqV00n0dOj0
 ambg==
X-Gm-Message-State: AOJu0YzH5JoU9u7eBZ4gYEgILapm7u59Cw8G+muPiSXh+uWqQL+sdFXf
 ld1qSih7eBMZPtTmjq2F+eF4K3d7rd+wQNwb0noYIcA3SQxMtQT/jQwK+sQ9gSFfSxA7hUYiEM5
 nu/unGYVoIw8VSfhziN39Lz44GX8rvat1d777aw==
X-Google-Smtp-Source: AGHT+IEg8tto4Tk99ivl8UPS2Zy+UuxEqZvHes8BJ5Pf4Nga98yBrvHJJG6oBK4Mpj66rT02m1ByrNOABF50yhx6pn0=
X-Received: by 2002:a50:a6cf:0:b0:572:9d24:257a with SMTP id
 4fb4d7f45d1cf-5734d5cff4bmr12842244a12.23.1715843611303; Thu, 16 May 2024
 00:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-4-dbarboza@ventanamicro.com>
 <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
 <09dc2e36-741d-44de-aac8-4ed2495eaeb1@ventanamicro.com>
 <abd1e74a-8d74-4ef9-b917-ce1a3c8e6af9@ventanamicro.com>
In-Reply-To: <abd1e74a-8d74-4ef9-b917-ce1a3c8e6af9@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 16 May 2024 15:13:20 +0800
Message-ID: <CAE_xrPhNhxWGT1_MvUJ9Jecz5obRc5tpdk9u_BW57uqC_G1uBA@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 Sebastien Boeuf <seb@rivosinc.com>
Content-Type: multipart/alternative; boundary="000000000000f14db506188cf88b"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f14db506188cf88b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 8:37=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Hi Frank,
>
>
> On 5/8/24 08:15, Daniel Henrique Barboza wrote:
> > Hi Frank,
> >
> > I'll reply with that I've done so far. Still missing some stuff:
> >
> > On 5/2/24 08:37, Frank Chang wrote:
> >> Hi Daniel,
> >>
> >> Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=
=B9=B43=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94
> =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=81=93=EF=BC=9A
> >>>
> >>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> >>>
> >>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
> >>> international process. The latest frozen specifcation can be found
> >>> at:
> >>>
> >>>
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv=
-iommu.pdf
> >>>
> >>> Add the foundation of the device emulation for RISC-V IOMMU, which
> >>> includes an IOMMU that has no capabilities but MSI interrupt support
> and
> >>> fault queue interfaces. We'll add add more features incrementally in
> the
> >>> next patches.
> >>>
> >>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> >>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> >>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> >>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >>> ---
> >>>   hw/riscv/Kconfig         |    4 +
>
> (...)
>
> >>> +
> >>> +    s->iommus.le_next =3D NULL;
> >>> +    s->iommus.le_prev =3D NULL;
> >>> +    QLIST_INIT(&s->spaces);
> >>> +    qemu_cond_init(&s->core_cond);
> >>> +    qemu_mutex_init(&s->core_lock);
> >>> +    qemu_spin_init(&s->regs_lock);
> >>> +    qemu_thread_create(&s->core_proc, "riscv-iommu-core",
> >>> +        riscv_iommu_core_proc, s, QEMU_THREAD_JOINABLE);
> >>
> >> In our experience, using QEMU thread increases the latency of command
> >> queue processing,
> >> which leads to the potential IOMMU fence timeout in the Linux driver
> >> when using IOMMU with KVM,
> >> e.g. booting the guest Linux.
> >>
> >> Is it possible to remove the thread from the IOMMU just like ARM, AMD,
> >> and Intel IOMMU models?
> >
> > Interesting. We've been using this emulation internally in Ventana, wit=
h
> > KVM and VFIO, and didn't experience this issue. Drew is on CC and can
> talk
> > more about it.
> >
> > That said, I don't mind this change, assuming it's feasible to make it
> for this
> > first version.  I'll need to check it how other IOMMUs are doing it.
>
>
> I removed the threading and it seems to be working fine without it. I'll
> commit this
> change for v3.
>
> >
> >
> >
> >>
> >>> +}
> >>> +
> >
> > (...)
> >
> >>> +
> >>> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque,
> int devfn)
> >>> +{
> >>> +    RISCVIOMMUState *s =3D (RISCVIOMMUState *) opaque;
> >>> +    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn=
);
> >>> +    AddressSpace *as =3D NULL;
> >>> +
> >>> +    if (pdev && pci_is_iommu(pdev)) {
> >>> +        return s->target_as;
> >>> +    }
> >>> +
> >>> +    /* Find first registered IOMMU device */
> >>> +    while (s->iommus.le_prev) {
> >>> +        s =3D *(s->iommus.le_prev);
> >>> +    }
> >>> +
> >>> +    /* Find first matching IOMMU */
> >>> +    while (s !=3D NULL && as =3D=3D NULL) {
> >>> +        as =3D riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus),
> devfn));
> >>
> >> For pci_bus_num(),
> >> riscv_iommu_find_as() can be called at the very early stage
> >> where software has no chance to enumerate the bus numbers.
>
> I investigated and this doesn't seem to be a problem. This function is
> called at the
> last step of the realize() steps of both riscv_iommu_pci_realize() and
> riscv_iommu_sys_realize(), and by that time the pci_bus_num() is already
> assigned.
> Other iommus use pci_bus_num() into their own get_address_space()
> callbacks like
> this too.
>

Hi Daniel,

IIUC, pci_bus_num() by default is assigned to pcibus_num():

static int pcibus_num(PCIBus *bus)
{
    if (pci_bus_is_root(bus)) {
        return 0; /* pci host bridge */
    }
    return bus->parent_dev->config[PCI_SECONDARY_BUS];
}

If the bus is not the root bus, it tries to read the bus' parent device's
secondary bus number (PCI_SECONDARY_BUS) field in the PCI configuration
space.
This field should be programmable by the SW during PCIe enumeration.
But I don't think SW has a chance to be executed before
riscv_iommu_sys_realize() is called,
since it's pretty early before CPU's execution unless RISC-V IOMMU is
hot-plugged.
Even if RISC-V IOMMU is hot-plugged, I think riscv_iommu_sys_realize() is
still called
before SW aware of the existence of IOMMU on the PCI topology tree.

Do you think this matches your observation?

Regards,
Frank Chang


>
>
> Thanks,
>
>
> Daniel
>
>
> >
> > I'll see how other IOMMUs are handling their iommu_find_as()
> >
> >
> > Thanks,
> >
> >
> > Daniel
> >
> >
> >>
> >>
> >>
> >>
> >>> +        s =3D s->iommus.le_next;
> >>> +    }
> >>> +
> >>> +    return as ? as : &address_space_memory;
> >>> +}
> >>> +
> >>> +static const PCIIOMMUOps riscv_iommu_ops =3D {
> >>> +    .get_address_space =3D riscv_iommu_find_as,
> >>> +};
> >>> +
> >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus=
,
> >>> +        Error **errp)
> >>> +{
> >>> +    if (bus->iommu_ops &&
> >>> +        bus->iommu_ops->get_address_space =3D=3D riscv_iommu_find_as=
) {
> >>> +        /* Allow multiple IOMMUs on the same PCIe bus, link known
> devices */
> >>> +        RISCVIOMMUState *last =3D (RISCVIOMMUState *)bus->iommu_opaq=
ue;
> >>> +        QLIST_INSERT_AFTER(last, iommu, iommus);
> >>> +    } else if (bus->iommu_ops =3D=3D NULL) {
> >>> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> >>> +    } else {
> >>> +        error_setg(errp, "can't register secondary IOMMU for PCI bus
> #%d",
> >>> +            pci_bus_num(bus));
> >>> +    }
> >>> +}
> >>> +
> >>> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion
> *iommu_mr,
> >>> +    MemTxAttrs attrs)
> >>> +{
> >>> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasi=
d;
> >>> +}
> >>> +
> >>> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion
> *iommu_mr)
> >>> +{
> >>> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace,
> iova_mr);
> >>> +    return 1 << as->iommu->pasid_bits;
> >>> +}
> >>> +
> >>> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void
> *data)
> >>> +{
> >>> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass=
);
> >>> +
> >>> +    imrc->translate =3D riscv_iommu_memory_region_translate;
> >>> +    imrc->notify_flag_changed =3D riscv_iommu_memory_region_notify;
> >>> +    imrc->attrs_to_index =3D riscv_iommu_memory_region_index;
> >>> +    imrc->num_indexes =3D riscv_iommu_memory_region_index_len;
> >>> +}
> >>> +
> >>> +static const TypeInfo riscv_iommu_memory_region_info =3D {
> >>> +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> >>> +    .name =3D TYPE_RISCV_IOMMU_MEMORY_REGION,
> >>> +    .class_init =3D riscv_iommu_memory_region_init,
> >>> +};
> >>> +
> >>> +static void riscv_iommu_register_mr_types(void)
> >>> +{
> >>> +    type_register_static(&riscv_iommu_memory_region_info);
> >>> +    type_register_static(&riscv_iommu_info);
> >>> +}
> >>> +
> >>> +type_init(riscv_iommu_register_mr_types);
> >>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> >>> new file mode 100644
> >>> index 0000000000..6f740de690
> >>> --- /dev/null
> >>> +++ b/hw/riscv/riscv-iommu.h
> >>> @@ -0,0 +1,141 @@
> >>> +/*
> >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
> >>> + *
> >>> + * Copyright (C) 2022-2023 Rivos Inc.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> modify
> >>> + * it under the terms of the GNU General Public License as published
> by
> >>> + * the Free Software Foundation; either version 2 of the License.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + * GNU General Public License for more details.
> >>> + *
> >>> + * You should have received a copy of the GNU General Public License
> along
> >>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> >>> + */
> >>> +
> >>> +#ifndef HW_RISCV_IOMMU_STATE_H
> >>> +#define HW_RISCV_IOMMU_STATE_H
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qom/object.h"
> >>> +
> >>> +#include "hw/riscv/iommu.h"
> >>> +
> >>> +struct RISCVIOMMUState {
> >>> +    /*< private >*/
> >>> +    DeviceState parent_obj;
> >>> +
> >>> +    /*< public >*/
> >>> +    uint32_t version;     /* Reported interface version number */
> >>> +    uint32_t pasid_bits;  /* process identifier width */
> >>> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints =
*/
> >>> +
> >>> +    uint64_t cap;         /* IOMMU supported capabilities */
> >>> +    uint64_t fctl;        /* IOMMU enabled features */
> >>> +
> >>> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA
> disabled) */
> >>> +    bool enable_msi;      /* Enable MSI remapping */
> >>> +
> >>> +    /* IOMMU Internal State */
> >>> +    uint64_t ddtp;        /* Validated Device Directory Tree Root
> Pointer */
> >>> +
> >>> +    dma_addr_t cq_addr;   /* Command queue base physical address */
> >>> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address
> */
> >>> +    dma_addr_t pq_addr;   /* Page request queue base physical addres=
s
> */
> >>> +
> >>> +    uint32_t cq_mask;     /* Command queue index bit mask */
> >>> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
> >>> +    uint32_t pq_mask;     /* Page request queue index bit mask */
> >>> +
> >>> +    /* interrupt notifier */
> >>> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
> >>> +
> >>> +    /* IOMMU State Machine */
> >>> +    QemuThread core_proc; /* Background processing thread */
> >>> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs
> updates */
> >>> +    QemuCond core_cond;   /* Background processing wake up signal */
> >>> +    unsigned core_exec;   /* Processing thread execution actions */
> >>> +
> >>> +    /* IOMMU target address space */
> >>> +    AddressSpace *target_as;
> >>> +    MemoryRegion *target_mr;
> >>> +
> >>> +    /* MSI / MRIF access trap */
> >>> +    AddressSpace trap_as;
> >>> +    MemoryRegion trap_mr;
> >>> +
> >>> +    GHashTable *ctx_cache;          /* Device translation Context
> Cache */
> >>> +
> >>> +    /* MMIO Hardware Interface */
> >>> +    MemoryRegion regs_mr;
> >>> +    QemuSpin regs_lock;
> >>> +    uint8_t *regs_rw;  /* register state (user write) */
> >>> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
> >>> +    uint8_t *regs_ro;  /* read-only mask */
> >>> +
> >>> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
> >>> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
> >>> +};
> >>> +
> >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus=
,
> >>> +         Error **errp);
> >>> +
> >>> +/* private helpers */
> >>> +
> >>> +/* Register helper functions */
> >>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> >>> +    unsigned idx, uint32_t set, uint32_t clr)
> >>> +{
> >>> +    uint32_t val;
> >>> +    qemu_spin_lock(&s->regs_lock);
> >>> +    val =3D ldl_le_p(s->regs_rw + idx);
> >>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> >>> +    qemu_spin_unlock(&s->regs_lock);
> >>> +    return val;
> >>> +}
> >>> +
> >>> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
> >>> +    unsigned idx, uint32_t set)
> >>> +{
> >>> +    qemu_spin_lock(&s->regs_lock);
> >>> +    stl_le_p(s->regs_rw + idx, set);
> >>> +    qemu_spin_unlock(&s->regs_lock);
> >>> +}
> >>> +
> >>> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
> >>> +    unsigned idx)
> >>> +{
> >>> +    return ldl_le_p(s->regs_rw + idx);
> >>> +}
> >>> +
> >>> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
> >>> +    unsigned idx, uint64_t set, uint64_t clr)
> >>> +{
> >>> +    uint64_t val;
> >>> +    qemu_spin_lock(&s->regs_lock);
> >>> +    val =3D ldq_le_p(s->regs_rw + idx);
> >>> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
> >>> +    qemu_spin_unlock(&s->regs_lock);
> >>> +    return val;
> >>> +}
> >>> +
> >>> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
> >>> +    unsigned idx, uint64_t set)
> >>> +{
> >>> +    qemu_spin_lock(&s->regs_lock);
> >>> +    stq_le_p(s->regs_rw + idx, set);
> >>> +    qemu_spin_unlock(&s->regs_lock);
> >>> +}
> >>> +
> >>> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
> >>> +    unsigned idx)
> >>> +{
> >>> +    return ldq_le_p(s->regs_rw + idx);
> >>> +}
> >>> +
> >>> +
> >>> +
> >>> +#endif
> >>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> >>> new file mode 100644
> >>> index 0000000000..42a97caffa
> >>> --- /dev/null
> >>> +++ b/hw/riscv/trace-events
> >>> @@ -0,0 +1,11 @@
> >>> +# See documentation at docs/devel/tracing.rst
> >>> +
> >>> +# riscv-iommu.c
> >>> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f)
> "%s: device attached %04x:%02x.%d"
> >>> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f,
> uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx6=
4"
> iova: 0x%"PRIx64
> >>> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f,
> uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
> >>> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f,
> unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s:
> translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
> >>> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f,
> uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64"
> -> 0x%"PRIx64
> >>> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command
> 0x%"PRIx64" 0x%"PRIx64
> >>> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier
> added"
> >>> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier
> removed"
> >>> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
> >>> new file mode 100644
> >>> index 0000000000..b88504b750
> >>> --- /dev/null
> >>> +++ b/hw/riscv/trace.h
> >>> @@ -0,0 +1,2 @@
> >>> +#include "trace/trace-hw_riscv.h"
> >>> +
> >>> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> >>> new file mode 100644
> >>> index 0000000000..403b365893
> >>> --- /dev/null
> >>> +++ b/include/hw/riscv/iommu.h
> >>> @@ -0,0 +1,36 @@
> >>> +/*
> >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
> >>> + *
> >>> + * Copyright (C) 2022-2023 Rivos Inc.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> modify
> >>> + * it under the terms of the GNU General Public License as published
> by
> >>> + * the Free Software Foundation; either version 2 of the License.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + * GNU General Public License for more details.
> >>> + *
> >>> + * You should have received a copy of the GNU General Public License
> along
> >>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> >>> + */
> >>> +
> >>> +#ifndef HW_RISCV_IOMMU_H
> >>> +#define HW_RISCV_IOMMU_H
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qom/object.h"
> >>> +
> >>> +#define TYPE_RISCV_IOMMU "riscv-iommu"
> >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
> >>> +typedef struct RISCVIOMMUState RISCVIOMMUState;
> >>> +
> >>> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
> >>> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
> >>> +
> >>> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
> >>> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> >>> +
> >>> +#endif
> >>> diff --git a/meson.build b/meson.build
> >>> index c59ca496f2..75e56f3282 100644
> >>> --- a/meson.build
> >>> +++ b/meson.build
> >>> @@ -3361,6 +3361,7 @@ if have_system
> >>>       'hw/rdma',
> >>>       'hw/rdma/vmw',
> >>>       'hw/rtc',
> >>> +    'hw/riscv',
> >>>       'hw/s390x',
> >>>       'hw/scsi',
> >>>       'hw/sd',
> >>> --
> >>> 2.43.2
> >>>
> >>>
>

--000000000000f14db506188cf88b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, May 13, 2024 at 8:37=E2=80=AFPM D=
aniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com">dba=
rboza@ventanamicro.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Frank,<br>
<br>
<br>
On 5/8/24 08:15, Daniel Henrique Barboza wrote:<br>
&gt; Hi Frank,<br>
&gt; <br>
&gt; I&#39;ll reply with that I&#39;ve done so far. Still missing some stuf=
f:<br>
&gt; <br>
&gt; On 5/2/24 08:37, Frank Chang wrote:<br>
&gt;&gt; Hi Daniel,<br>
&gt;&gt;<br>
&gt;&gt; Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicr=
o.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt; =E6=96=BC 2024=
=E5=B9=B43=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:04=E5=
=AF=AB=E9=81=93=EF=BC=9A<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; From: Tomasz Jeznach &lt;<a href=3D"mailto:tjeznach@rivosinc.c=
om" target=3D"_blank">tjeznach@rivosinc.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The RISC-V IOMMU specification is now ratified as-per the RISC=
-V<br>
&gt;&gt;&gt; international process. The latest frozen specifcation can be f=
ound<br>
&gt;&gt;&gt; at:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"https://github.com/riscv-non-isa/riscv-iommu/releas=
es/download/v1.0/riscv-iommu.pdf" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu=
.pdf</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Add the foundation of the device emulation for RISC-V IOMMU, w=
hich<br>
&gt;&gt;&gt; includes an IOMMU that has no capabilities but MSI interrupt s=
upport and<br>
&gt;&gt;&gt; fault queue interfaces. We&#39;ll add add more features increm=
entally in the<br>
&gt;&gt;&gt; next patches.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Co-developed-by: Sebastien Boeuf &lt;<a href=3D"mailto:seb@riv=
osinc.com" target=3D"_blank">seb@rivosinc.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Sebastien Boeuf &lt;<a href=3D"mailto:seb@rivos=
inc.com" target=3D"_blank">seb@rivosinc.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Tomasz Jeznach &lt;<a href=3D"mailto:tjeznach@r=
ivosinc.com" target=3D"_blank">tjeznach@rivosinc.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:d=
barboza@ventanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&g=
t;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; =C2=A0 hw/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +<br>
<br>
(...)<br>
<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;iommus.le_next =3D NULL;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 s-&gt;iommus.le_prev =3D NULL;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QLIST_INIT(&amp;s-&gt;spaces);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_cond_init(&amp;s-&gt;core_cond);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&amp;s-&gt;core_lock);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_init(&amp;s-&gt;regs_lock);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_thread_create(&amp;s-&gt;core_proc, &=
quot;riscv-iommu-core&quot;,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_iommu_core_p=
roc, s, QEMU_THREAD_JOINABLE);<br>
&gt;&gt;<br>
&gt;&gt; In our experience, using QEMU thread increases the latency of comm=
and<br>
&gt;&gt; queue processing,<br>
&gt;&gt; which leads to the potential IOMMU fence timeout in the Linux driv=
er<br>
&gt;&gt; when using IOMMU with KVM,<br>
&gt;&gt; e.g. booting the guest Linux.<br>
&gt;&gt;<br>
&gt;&gt; Is it possible to remove the thread from the IOMMU just like ARM, =
AMD,<br>
&gt;&gt; and Intel IOMMU models?<br>
&gt; <br>
&gt; Interesting. We&#39;ve been using this emulation internally in Ventana=
, with<br>
&gt; KVM and VFIO, and didn&#39;t experience this issue. Drew is on CC and =
can talk<br>
&gt; more about it.<br>
&gt; <br>
&gt; That said, I don&#39;t mind this change, assuming it&#39;s feasible to=
 make it for this<br>
&gt; first version.=C2=A0 I&#39;ll need to check it how other IOMMUs are do=
ing it.<br>
<br>
<br>
I removed the threading and it seems to be working fine without it. I&#39;l=
l commit this<br>
change for v3.<br>
<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt; <br>
&gt; (...)<br>
&gt; <br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *o=
paque, int devfn)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 RISCVIOMMUState *s =3D (RISCVIOMMUState *)=
 opaque;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 PCIDevice *pdev =3D pci_find_device(bus, p=
ci_bus_num(bus), devfn);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 AddressSpace *as =3D NULL;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (pdev &amp;&amp; pci_is_iommu(pdev)) {<=
br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return s-&gt;targe=
t_as;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Find first registered IOMMU device */<b=
r>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 while (s-&gt;iommus.le_prev) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D *(s-&gt;iomm=
us.le_prev);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Find first matching IOMMU */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 while (s !=3D NULL &amp;&amp; as =3D=3D NU=
LL) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as =3D riscv_iommu=
_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));<br>
&gt;&gt;<br>
&gt;&gt; For pci_bus_num(),<br>
&gt;&gt; riscv_iommu_find_as() can be called at the very early stage<br>
&gt;&gt; where software has no chance to enumerate the bus numbers.<br>
<br>
I investigated and this doesn&#39;t seem to be a problem. This function is =
called at the<br>
last step of the realize() steps of both riscv_iommu_pci_realize() and<br>
riscv_iommu_sys_realize(), and by that time the pci_bus_num() is already as=
signed.<br>
Other iommus use pci_bus_num() into their own get_address_space() callbacks=
 like<br>
this too.<br></blockquote><div><br></div><div>Hi Daniel,<br></div><div><br>=
</div><div>IIUC, pci_bus_num() by default is assigned to pcibus_num():</div=
><div><br></div><div>static int pcibus_num(PCIBus *bus)<br>{<br>=C2=A0 =C2=
=A0 if (pci_bus_is_root(bus)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0; /*=
 pci host bridge */<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 return bus-&gt;pare=
nt_dev-&gt;config[PCI_SECONDARY_BUS];<br>}<br></div><div><br></div><div>If =
the bus is not the root bus, it tries to read the bus&#39; parent device&#3=
9;s</div><div>secondary bus number (PCI_SECONDARY_BUS) field in the PCI con=
figuration space.</div><div>This field should be programmable by the SW dur=
ing PCIe enumeration.</div><div>But I don&#39;t think SW has a chance to be=
 executed before riscv_iommu_sys_realize() is called,</div><div>since it&#3=
9;s pretty early before CPU&#39;s execution unless RISC-V IOMMU is hot-plug=
ged.</div><div>Even if RISC-V IOMMU is hot-plugged, I think riscv_iommu_sys=
_realize() is still called</div><div>before SW aware of the existence of IO=
MMU on the PCI topology tree.</div><div><br></div><div>Do you think this ma=
tches your observation?=C2=A0</div><div><br></div><div>Regards,</div><div>F=
rank Chang</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
<br>
Thanks,<br>
<br>
<br>
Daniel<br>
<br>
<br>
&gt; <br>
&gt; I&#39;ll see how other IOMMUs are handling their iommu_find_as()<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; <br>
&gt; Daniel<br>
&gt; <br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D s-&gt;iommus=
.le_next;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return as ? as : &amp;address_space_memory=
;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static const PCIIOMMUOps riscv_iommu_ops =3D {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .get_address_space =3D riscv_iommu_find_as=
,<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIB=
us *bus,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (bus-&gt;iommu_ops &amp;&amp;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus-&gt;iommu_ops-=
&gt;get_address_space =3D=3D riscv_iommu_find_as) {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Allow multiple =
IOMMUs on the same PCIe bus, link known devices */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVIOMMUState *l=
ast =3D (RISCVIOMMUState *)bus-&gt;iommu_opaque;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_AFTER=
(last, iommu, iommus);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 } else if (bus-&gt;iommu_ops =3D=3D NULL) =
{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_setup_iommu(bu=
s, &amp;riscv_iommu_ops, iommu);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, &=
quot;can&#39;t register secondary IOMMU for PCI bus #%d&quot;,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pci_bus_num(bus));<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion =
*iommu_mr,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemTxAttrs attrs)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return attrs.unspecified ? RISCV_IOMMU_NOP=
ASID : (int)attrs.pasid;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static int riscv_iommu_memory_region_index_len(IOMMUMemoryReg=
ion *iommu_mr)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 RISCVIOMMUSpace *as =3D container_of(iommu=
_mr, RISCVIOMMUSpace, iova_mr);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return 1 &lt;&lt; as-&gt;iommu-&gt;pasid_b=
its;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void riscv_iommu_memory_region_init(ObjectClass *klass=
, void *data)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 IOMMUMemoryRegionClass *imrc =3D IOMMU_MEM=
ORY_REGION_CLASS(klass);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;translate =3D riscv_iommu_memory_=
region_translate;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;notify_flag_changed =3D riscv_iom=
mu_memory_region_notify;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;attrs_to_index =3D riscv_iommu_me=
mory_region_index;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 imrc-&gt;num_indexes =3D riscv_iommu_memor=
y_region_index_len;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static const TypeInfo riscv_iommu_memory_region_info =3D {<br=
>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_IOMMU_MEMORY_REGION,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_RISCV_IOMMU_MEMORY_REGION,<=
br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 .class_init =3D riscv_iommu_memory_region_=
init,<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void riscv_iommu_register_mr_types(void)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 type_register_static(&amp;riscv_iommu_memo=
ry_region_info);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 type_register_static(&amp;riscv_iommu_info=
);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +type_init(riscv_iommu_register_mr_types);<br>
&gt;&gt;&gt; diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h<b=
r>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 0000000000..6f740de690<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; +++ b/hw/riscv/riscv-iommu.h<br>
&gt;&gt;&gt; @@ -0,0 +1,141 @@<br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * QEMU emulation of an RISC-V IOMMU (Ziommu)<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Copyright (C) 2022-2023 Rivos Inc.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is free software; you can redistribute it and=
/or modify<br>
&gt;&gt;&gt; + * it under the terms of the GNU General Public License as pu=
blished by<br>
&gt;&gt;&gt; + * the Free Software Foundation; either version 2 of the Lice=
nse.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is distributed in the hope that it will be us=
eful,<br>
&gt;&gt;&gt; + * but WITHOUT ANY WARRANTY; without even the implied warrant=
y of<br>
&gt;&gt;&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0=
 See the<br>
&gt;&gt;&gt; + * GNU General Public License for more details.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * You should have received a copy of the GNU General Public =
License along<br>
&gt;&gt;&gt; + * with this program; if not, see &lt;<a href=3D"http://www.g=
nu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/l=
icenses/</a>&gt;.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#ifndef HW_RISCV_IOMMU_STATE_H<br>
&gt;&gt;&gt; +#define HW_RISCV_IOMMU_STATE_H<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt; +#include &quot;qom/object.h&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#include &quot;hw/riscv/iommu.h&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +struct RISCVIOMMUState {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; private &gt;*/<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 DeviceState parent_obj;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /*&lt; public &gt;*/<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t version;=C2=A0=C2=A0=C2=A0=C2=A0 =
/* Reported interface version number */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t pasid_bits;=C2=A0 /* process iden=
tifier width */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t bus;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* PCI bus mapping for non-root endpoints */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t cap;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* IOMMU supported capabilities */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t fctl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* IOMMU enabled features */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool enable_off;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Enable out-of-reset OFF mode (DMA disabled) */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool enable_msi;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Enable MSI remapping */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* IOMMU Internal State */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t ddtp;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* Validated Device Directory Tree Root Pointer */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_addr_t cq_addr;=C2=A0=C2=A0 /* Command=
 queue base physical address */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_addr_t fq_addr;=C2=A0=C2=A0 /* Fault/e=
vent queue base physical address */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 dma_addr_t pq_addr;=C2=A0=C2=A0 /* Page re=
quest queue base physical address */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t cq_mask;=C2=A0=C2=A0=C2=A0=C2=A0 =
/* Command queue index bit mask */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t fq_mask;=C2=A0=C2=A0=C2=A0=C2=A0 =
/* Fault/event queue index bit mask */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t pq_mask;=C2=A0=C2=A0=C2=A0=C2=A0 =
/* Page request queue index bit mask */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* interrupt notifier */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 void (*notify)(RISCVIOMMUState *iommu, uns=
igned vector);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* IOMMU State Machine */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuThread core_proc; /* Background proces=
sing thread */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuMutex core_lock;=C2=A0 /* Global IOMMU=
 lock, used for cache/regs updates */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuCond core_cond;=C2=A0=C2=A0 /* Backgro=
und processing wake up signal */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned core_exec;=C2=A0=C2=A0 /* Process=
ing thread execution actions */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* IOMMU target address space */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 AddressSpace *target_as;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemoryRegion *target_mr;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* MSI / MRIF access trap */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 AddressSpace trap_as;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemoryRegion trap_mr;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 GHashTable *ctx_cache;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Device translation Context Cache */=
<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* MMIO Hardware Interface */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 MemoryRegion regs_mr;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QemuSpin regs_lock;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t *regs_rw;=C2=A0 /* register state =
(user write) */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t *regs_wc;=C2=A0 /* write-1-to-clea=
r mask */<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint8_t *regs_ro;=C2=A0 /* read-only mask =
*/<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QLIST_ENTRY(RISCVIOMMUState) iommus;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 QLIST_HEAD(, RISCVIOMMUSpace) spaces;<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIB=
us *bus,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp=
);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/* private helpers */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/* Register helper functions */<br>
&gt;&gt;&gt; +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState =
*s,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uint32_t set, uint32_t clr)<=
br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t val;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&amp;s-&gt;regs_lock);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 val =3D ldl_le_p(s-&gt;regs_rw + idx);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stl_le_p(s-&gt;regs_rw + idx, (val &amp; ~=
clr) | set);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(&amp;s-&gt;regs_lock);<br=
>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return val;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,<=
br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uint32_t set)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&amp;s-&gt;regs_lock);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stl_le_p(s-&gt;regs_rw + idx, set);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(&amp;s-&gt;regs_lock);<br=
>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState =
*s,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return ldl_le_p(s-&gt;regs_rw + idx);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState =
*s,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uint64_t set, uint64_t clr)<=
br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t val;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&amp;s-&gt;regs_lock);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 val =3D ldq_le_p(s-&gt;regs_rw + idx);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stq_le_p(s-&gt;regs_rw + idx, (val &amp; ~=
clr) | set);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(&amp;s-&gt;regs_lock);<br=
>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return val;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,<=
br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx, uint64_t set)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_lock(&amp;s-&gt;regs_lock);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 stq_le_p(s-&gt;regs_rw + idx, set);<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 qemu_spin_unlock(&amp;s-&gt;regs_lock);<br=
>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState =
*s,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 unsigned idx)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return ldq_le_p(s-&gt;regs_rw + idx);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#endif<br>
&gt;&gt;&gt; diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events<br>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 0000000000..42a97caffa<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; +++ b/hw/riscv/trace-events<br>
&gt;&gt;&gt; @@ -0,0 +1,11 @@<br>
&gt;&gt;&gt; +# See documentation at docs/devel/tracing.rst<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +# riscv-iommu.c<br>
&gt;&gt;&gt; +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsig=
ned f) &quot;%s: device attached %04x:%02x.%d&quot;<br>
&gt;&gt;&gt; +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsig=
ned f, uint64_t reason, uint64_t iova) &quot;%s: fault %04x:%02x.%u reason:=
 0x%&quot;PRIx64&quot; iova: 0x%&quot;PRIx64<br>
&gt;&gt;&gt; +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsig=
ned f, uint64_t iova) &quot;%s: page request %04x:%02x.%u iova: 0x%&quot;PR=
Ix64<br>
&gt;&gt;&gt; +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsig=
ned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) &quot=
;%s: translate %04x:%02x.%u #%u %s 0x%&quot;PRIx64&quot; -&gt; 0x%&quot;PRI=
x64<br>
&gt;&gt;&gt; +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsig=
ned f, uint64_t iova, uint64_t phys) &quot;%s: translate %04x:%02x.%u MSI 0=
x%&quot;PRIx64&quot; -&gt; 0x%&quot;PRIx64<br>
&gt;&gt;&gt; +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) &quot=
;%s: command 0x%&quot;PRIx64&quot; 0x%&quot;PRIx64<br>
&gt;&gt;&gt; +riscv_iommu_notifier_add(const char *id) &quot;%s: dev-iotlb =
notifier added&quot;<br>
&gt;&gt;&gt; +riscv_iommu_notifier_del(const char *id) &quot;%s: dev-iotlb =
notifier removed&quot;<br>
&gt;&gt;&gt; diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h<br>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 0000000000..b88504b750<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; +++ b/hw/riscv/trace.h<br>
&gt;&gt;&gt; @@ -0,0 +1,2 @@<br>
&gt;&gt;&gt; +#include &quot;trace/trace-hw_riscv.h&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu=
.h<br>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 0000000000..403b365893<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; +++ b/include/hw/riscv/iommu.h<br>
&gt;&gt;&gt; @@ -0,0 +1,36 @@<br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * QEMU emulation of an RISC-V IOMMU (Ziommu)<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Copyright (C) 2022-2023 Rivos Inc.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is free software; you can redistribute it and=
/or modify<br>
&gt;&gt;&gt; + * it under the terms of the GNU General Public License as pu=
blished by<br>
&gt;&gt;&gt; + * the Free Software Foundation; either version 2 of the Lice=
nse.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This program is distributed in the hope that it will be us=
eful,<br>
&gt;&gt;&gt; + * but WITHOUT ANY WARRANTY; without even the implied warrant=
y of<br>
&gt;&gt;&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0=
 See the<br>
&gt;&gt;&gt; + * GNU General Public License for more details.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * You should have received a copy of the GNU General Public =
License along<br>
&gt;&gt;&gt; + * with this program; if not, see &lt;<a href=3D"http://www.g=
nu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/l=
icenses/</a>&gt;.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#ifndef HW_RISCV_IOMMU_H<br>
&gt;&gt;&gt; +#define HW_RISCV_IOMMU_H<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt; +#include &quot;qom/object.h&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#define TYPE_RISCV_IOMMU &quot;riscv-iommu&quot;<br>
&gt;&gt;&gt; +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)<br>
&gt;&gt;&gt; +typedef struct RISCVIOMMUState RISCVIOMMUState;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#define TYPE_RISCV_IOMMU_MEMORY_REGION &quot;riscv-iommu-mr&q=
uot;<br>
&gt;&gt;&gt; +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#define TYPE_RISCV_IOMMU_PCI &quot;riscv-iommu-pci&quot;<br>
&gt;&gt;&gt; +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PC=
I)<br>
&gt;&gt;&gt; +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#endif<br>
&gt;&gt;&gt; diff --git a/meson.build b/meson.build<br>
&gt;&gt;&gt; index c59ca496f2..75e56f3282 100644<br>
&gt;&gt;&gt; --- a/meson.build<br>
&gt;&gt;&gt; +++ b/meson.build<br>
&gt;&gt;&gt; @@ -3361,6 +3361,7 @@ if have_system<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;hw/rdma&#39;,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;hw/rdma/vmw&#39;,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;hw/rtc&#39;,<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 &#39;hw/riscv&#39;,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;hw/s390x&#39;,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;hw/scsi&#39;,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;hw/sd&#39;,<br>
&gt;&gt;&gt; -- <br>
&gt;&gt;&gt; 2.43.2<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
</blockquote></div></div>

--000000000000f14db506188cf88b--

