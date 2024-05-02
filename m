Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F39BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 11:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ul8-0003ro-Al; Thu, 02 May 2024 07:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s2Ul5-0003qv-NJ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:37:51 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s2Ul0-0002cc-DZ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:37:51 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f174e316eso712858e87.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1714649863; x=1715254663; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ldx62fUk6DW9vjx7A6/JUmxF4MvQDHvg5zyPZ74a/o=;
 b=AIQcXhHemZuU5Og7Xuz4+c5W0cvyts+8kB9vkRFlg0YTB1o8ohbI6lhhWGbM38Cx+s
 Qiv/2txNmaeEmBT0vfia9rv6In6u/wenIjXCTDB5+9F1Opze21gpgnC/eTc0yHn+njrj
 rZqVd+belhU5ZEpQMkbwExravWwh4dQsNBvgTNnfqr/sDTTCLhAMcrzfcvdFJ7eR618H
 Btih+FP7g249H74DwnIGxWplpJNabLCVKHWmb5oylgeO30L1uRbUYVglLNfa3OBSP1Ta
 7UOnjKiuwBJOMnpEcuKkqJrnzEpk7UhKLxlxXx/58JZEABVPKrFQGcepNGlqThXqCChK
 7dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714649863; x=1715254663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ldx62fUk6DW9vjx7A6/JUmxF4MvQDHvg5zyPZ74a/o=;
 b=qD8ksLsH2peKKnyjxaNScARQwD1ujl8aTkJZ/xRoy2FDbMLq7vCy8QPnE/fWMOb6du
 AaIZRwVl8EffwXWQTRpC9Spb7oQSjbv2XrprqVFXXIDdvIiuBKW7szwi9A8F5tw9UxvZ
 FgFWwtbK4ETk1BFMKgL+u81kTiCm30dc+2kUU1ZBeTq0h8vIP1QhIzP3mEv3I+i7IPP3
 rYoAgXt/uLUOFjtwP+opL3rh1CvUE8QuWc+SyR3RCQThi1Oy4Ilv1D5xSjy1TlSlXrW+
 nODE8nFrF7MN9fVC2H4e87qiAljMtZOIum9TVvTPPUlhQ67+CSmjgCSlfU4KMMmjqjmb
 sV5A==
X-Gm-Message-State: AOJu0YzpNa1FvsIXkjnjs48WMgO7STM5QXakSxwz2WnCNhudMyP3aBUh
 55DatQHxu0WGdMEE3qmp0Z9PqLmx5CnoeZ6lFehI07kOtcy5SJ+YNIyDBtLbCy7RPnGGVS06uKf
 mRrhB2m+binT0bDcBxiicfDFLsq5d7LJLhBdhhRLNMbs2qez9Am67UznokaBxR53fRhw/WRU0c4
 47jfYAypX6k8LZ3fwUpM4GT9U1KJKNbt773Tq/aXHnSQ==
X-Google-Smtp-Source: AGHT+IE791qzLSbWdih/7yYTqLZ5qEerRjiszhkpvWsmNmMzUIu9tYKN99sEBeGpJ81/M9rW2Kaycg==
X-Received: by 2002:a05:6512:1586:b0:51a:f2fb:b13c with SMTP id
 bp6-20020a056512158600b0051af2fbb13cmr4246985lfb.11.1714649862504; 
 Thu, 02 May 2024 04:37:42 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com.
 [209.85.208.169]) by smtp.gmail.com with ESMTPSA id
 b2-20020a056512060200b0051a9dd7508bsm142091lfe.225.2024.05.02.04.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 04:37:41 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2dd19c29c41so97015671fa.3; 
 Thu, 02 May 2024 04:37:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU+qF0Vulr6EwItXYkbt6CT4iItpWhfr/A7td8qkRWI1sTnKex5LC0B+crcZZvahnFbHMBgQzbnfQHU5bcPaq7rnCj1qj4=
X-Received: by 2002:a05:651c:2207:b0:2e0:1349:1eb0 with SMTP id
 y7-20020a05651c220700b002e013491eb0mr4198672ljq.43.1714649860891; Thu, 02 May
 2024 04:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-4-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 2 May 2024 19:37:29 +0800
X-Gmail-Original-Message-ID: <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
Message-ID: <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 Sebastien Boeuf <seb@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The RISC-V IOMMU specification is now ratified as-per the RISC-V
> international process. The latest frozen specifcation can be found
> at:
>
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv=
-iommu.pdf
>
> Add the foundation of the device emulation for RISC-V IOMMU, which
> includes an IOMMU that has no capabilities but MSI interrupt support and
> fault queue interfaces. We'll add add more features incrementally in the
> next patches.
>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/Kconfig         |    4 +
>  hw/riscv/meson.build     |    1 +
>  hw/riscv/riscv-iommu.c   | 1492 ++++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h   |  141 ++++
>  hw/riscv/trace-events    |   11 +
>  hw/riscv/trace.h         |    2 +
>  include/hw/riscv/iommu.h |   36 +
>  meson.build              |    1 +
>  8 files changed, 1688 insertions(+)
>  create mode 100644 hw/riscv/riscv-iommu.c
>  create mode 100644 hw/riscv/riscv-iommu.h
>  create mode 100644 hw/riscv/trace-events
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 include/hw/riscv/iommu.h
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 5d644eb7b1..faf6a10029 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,3 +1,6 @@
> +config RISCV_IOMMU
> +    bool
> +
>  config RISCV_NUMA
>      bool
>
> @@ -38,6 +41,7 @@ config RISCV_VIRT
>      select SERIAL
>      select RISCV_ACLINT
>      select RISCV_APLIC
> +    select RISCV_IOMMU
>      select RISCV_IMSIC
>      select SIFIVE_PLIC
>      select SIFIVE_TEST
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2f7ee81be3..ba9eebd605 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('s=
ifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c')=
)
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> new file mode 100644
> index 0000000000..df534b99b0
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.c
> @@ -0,0 +1,1492 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
> + *
> + * Copyright (C) 2021-2023, Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/timer.h"
> +
> +#include "cpu_bits.h"
> +#include "riscv-iommu.h"
> +#include "riscv-iommu-bits.h"
> +#include "trace.h"
> +
> +#define LIMIT_CACHE_CTX               (1U << 7)
> +#define LIMIT_CACHE_IOT               (1U << 20)
> +
> +/* Physical page number coversions */
> +#define PPN_PHYS(ppn)                 ((ppn) << TARGET_PAGE_BITS)
> +#define PPN_DOWN(phy)                 ((phy) >> TARGET_PAGE_BITS)
> +
> +typedef struct RISCVIOMMUContext RISCVIOMMUContext;
> +typedef struct RISCVIOMMUEntry RISCVIOMMUEntry;
> +
> +/* Device assigned I/O address space */
> +struct RISCVIOMMUSpace {
> +    IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached devic=
e */
> +    AddressSpace iova_as;       /* IOVA address space for attached devic=
e */
> +    RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
> +    uint32_t devid;             /* Requester identifier, AKA device_id *=
/
> +    bool notifier;              /* IOMMU unmap notifier enabled */
> +    QLIST_ENTRY(RISCVIOMMUSpace) list;
> +};
> +
> +/* Device translation context state. */
> +struct RISCVIOMMUContext {
> +    uint64_t devid:24;          /* Requester Id, AKA device_id */
> +    uint64_t pasid:20;          /* Process Address Space ID */
> +    uint64_t __rfu:20;          /* reserved */
> +    uint64_t tc;                /* Translation Control */
> +    uint64_t ta;                /* Translation Attributes */
> +    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
> +    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
> +    uint64_t msiptp;            /* MSI redirection page table pointer */
> +};
> +
> +/* IOMMU index for transactions without PASID specified. */
> +#define RISCV_IOMMU_NOPASID 0
> +
> +static void riscv_iommu_notify(RISCVIOMMUState *s, int vec)
> +{
> +    const uint32_t ipsr =3D
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec), 0);
> +    const uint32_t ivec =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IVE=
C);
> +    if (s->notify && !(ipsr & (1 << vec))) {
> +        s->notify(s, (ivec >> (vec * 4)) & 0x0F);
> +    }

s->notify is assigned to riscv_iommu_pci_notify() only.
There's no way to assert the wire-signaled interrupt.

We should also check fctl.WSI before asserting the interrupt.

> +}
> +
> +static void riscv_iommu_fault(RISCVIOMMUState *s,
> +                              struct riscv_iommu_fq_record *ev)
> +{
> +    uint32_t ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> +    uint32_t head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s-=
>fq_mask;
> +    uint32_t tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQT) & s-=
>fq_mask;
> +    uint32_t next =3D (tail + 1) & s->fq_mask;
> +    uint32_t devid =3D get_field(ev->hdr, RISCV_IOMMU_FQ_HDR_DID);
> +
> +    trace_riscv_iommu_flt(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT=
(devid),
> +                          PCI_FUNC(devid), ev->hdr, ev->iotval);
> +
> +    if (!(ctrl & RISCV_IOMMU_FQCSR_FQON) ||
> +        !!(ctrl & (RISCV_IOMMU_FQCSR_FQOF | RISCV_IOMMU_FQCSR_FQMF))) {
> +        return;
> +    }
> +
> +    if (head =3D=3D next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> +                              RISCV_IOMMU_FQCSR_FQOF, 0);
> +    } else {
> +        dma_addr_t addr =3D s->fq_addr + tail * sizeof(*ev);
> +        if (dma_memory_write(s->target_as, addr, ev, sizeof(*ev),
> +                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> +                                  RISCV_IOMMU_FQCSR_FQMF, 0);
> +        } else {
> +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_FQT, next);
> +        }
> +    }
> +
> +    if (ctrl & RISCV_IOMMU_FQCSR_FIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_FQ);
> +    }
> +}
> +
> +static void riscv_iommu_pri(RISCVIOMMUState *s,
> +    struct riscv_iommu_pq_record *pr)
> +{
> +    uint32_t ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> +    uint32_t head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQH) & s-=
>pq_mask;
> +    uint32_t tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQT) & s-=
>pq_mask;
> +    uint32_t next =3D (tail + 1) & s->pq_mask;
> +    uint32_t devid =3D get_field(pr->hdr, RISCV_IOMMU_PREQ_HDR_DID);
> +
> +    trace_riscv_iommu_pri(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT=
(devid),
> +                          PCI_FUNC(devid), pr->payload);
> +
> +    if (!(ctrl & RISCV_IOMMU_PQCSR_PQON) ||
> +        !!(ctrl & (RISCV_IOMMU_PQCSR_PQOF | RISCV_IOMMU_PQCSR_PQMF))) {
> +        return;
> +    }
> +
> +    if (head =3D=3D next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> +                              RISCV_IOMMU_PQCSR_PQOF, 0);
> +    } else {
> +        dma_addr_t addr =3D s->pq_addr + tail * sizeof(*pr);
> +        if (dma_memory_write(s->target_as, addr, pr, sizeof(*pr),
> +                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> +                                  RISCV_IOMMU_PQCSR_PQMF, 0);
> +        } else {
> +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_PQT, next);
> +        }
> +    }
> +
> +    if (ctrl & RISCV_IOMMU_PQCSR_PIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_PQ);
> +    }
> +}
> +
> +/* Portable implementation of pext_u64, bit-mask extraction. */
> +static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> +{
> +    uint64_t ret =3D 0;
> +    uint64_t rot =3D 1;
> +
> +    while (ext) {
> +        if (ext & 1) {
> +            if (val & 1) {
> +                ret |=3D rot;
> +            }
> +            rot <<=3D 1;
> +        }
> +        val >>=3D 1;
> +        ext >>=3D 1;
> +    }
> +
> +    return ret;
> +}
> +
> +/* Check if GPA matches MSI/MRIF pattern. */
> +static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext =
*ctx,
> +    dma_addr_t gpa)
> +{
> +    if (get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE) !=3D
> +        RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> +        return false; /* Invalid MSI/MRIF mode */
> +    }
> +
> +    if ((PPN_DOWN(gpa) ^ ctx->msi_addr_pattern) & ~ctx->msi_addr_mask) {
> +        return false; /* GPA not in MSI range defined by AIA IMSIC rules=
. */
> +    }
> +
> +    return true;
> +}
> +
> +/* RISCV IOMMU Address Translation Lookup - Page Table Walk */
> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    /* Early check for MSI address match when IOVA =3D=3D GPA */
> +    if (iotlb->perm & IOMMU_WO &&
> +        riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
> +        iotlb->target_as =3D &s->trap_as;
> +        iotlb->translated_addr =3D iotlb->iova;
> +        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        return 0;
> +    }
> +
> +    /* Exit early for pass-through mode. */
> +    iotlb->translated_addr =3D iotlb->iova;
> +    iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +    /* Allow R/W in pass-through mode */
> +    iotlb->perm =3D IOMMU_RW;
> +    return 0;
> +}
> +
> +/* Redirect MSI write for given GPA. */
> +static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
> +    RISCVIOMMUContext *ctx, uint64_t gpa, uint64_t data,
> +    unsigned size, MemTxAttrs attrs)
> +{
> +    MemTxResult res;
> +    dma_addr_t addr;
> +    uint64_t intn;
> +    uint32_t n190;
> +    uint64_t pte[2];
> +
> +    if (!riscv_iommu_msi_check(s, ctx, gpa)) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* Interrupt File Number */
> +    intn =3D _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    if (intn >=3D 256) {
> +        /* Interrupt file number out of range */
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* fetch MSI PTE */
> +    addr =3D PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN))=
;
> +    addr =3D addr | (intn * sizeof(pte));
> +    res =3D dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
> +            MEMTXATTRS_UNSPECIFIED);
> +    if (res !=3D MEMTX_OK) {
> +        return res;

The spec says that:
"If msipte access detects a data corruption (a.k.a. poisoned data),
then stop and report "MSI PT data corruption" (cause =3D 270)."

> +    }
> +
> +    le64_to_cpus(&pte[0]);
> +    le64_to_cpus(&pte[1]);
> +
> +    if (!(pte[0] & RISCV_IOMMU_MSI_PTE_V) || (pte[0] & RISCV_IOMMU_MSI_P=
TE_C)) {
> +        return MEMTX_ACCESS_ERROR;

The spec says that:
"If msipte.V =3D=3D 0, then stop and report "MSI PTE not valid" (cause =3D =
262)."

> +    }
> +
> +    switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
> +    case RISCV_IOMMU_MSI_PTE_M_BASIC:
> +        /* MSI Pass-through mode */
> +        addr =3D PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
> +        addr =3D addr | (gpa & TARGET_PAGE_MASK);
> +
> +        trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
> +                              PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid)=
,
> +                              gpa, addr);
> +
> +        return dma_memory_write(s->target_as, addr, &data, size, attrs);
> +    case RISCV_IOMMU_MSI_PTE_M_MRIF:
> +        /* MRIF mode, continue. */
> +        break;
> +    default:
> +        return MEMTX_ACCESS_ERROR;

The spec says that:
"If msipte.M =3D=3D 0 or msipte.M =3D=3D 2, then stop and report "MSI PTE
misconfigured" (cause =3D 263)."

> +    }
> +
> +    /*
> +     * Report an error for interrupt identities exceeding the maximum al=
lowed
> +     * for an IMSIC interrupt file (2047) or destination address is not =
32-bit
> +     * aligned. See IOMMU Specification, Chapter 2.3. MSI page tables.
> +     */
> +    if ((data > 2047) || (gpa & 3)) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* MSI MRIF mode, non atomic pending bit update */
> +
> +    /* MRIF pending bit address */
> +    addr =3D get_field(pte[0], RISCV_IOMMU_MSI_PTE_MRIF_ADDR) << 9;
> +    addr =3D addr | ((data & 0x7c0) >> 3);
> +
> +    trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
> +                          PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
> +                          gpa, addr);
> +
> +    /* MRIF pending bit mask */
> +    data =3D 1ULL << (data & 0x03f);
> +    res =3D dma_memory_read(s->target_as, addr, &intn, sizeof(intn), att=
rs);
> +    if (res !=3D MEMTX_OK) {
> +        return res;
> +    }
> +    intn =3D intn | data;
> +    res =3D dma_memory_write(s->target_as, addr, &intn, sizeof(intn), at=
trs);
> +    if (res !=3D MEMTX_OK) {
> +        return res;
> +    }
> +
> +    /* Get MRIF enable bits */
> +    addr =3D addr + sizeof(intn);
> +    res =3D dma_memory_read(s->target_as, addr, &intn, sizeof(intn), att=
rs);
> +    if (res !=3D MEMTX_OK) {
> +        return res;
> +    }
> +    if (!(intn & data)) {
> +        /* notification disabled, MRIF update completed. */
> +        return MEMTX_OK;
> +    }
> +
> +    /* Send notification message */
> +    addr =3D PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
> +    n190 =3D get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
> +          (get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID_MSB) << 10);
> +
> +    res =3D dma_memory_write(s->target_as, addr, &n190, sizeof(n190), at=
trs);
> +    if (res !=3D MEMTX_OK) {
> +        return res;
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +/*
> + * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
> + *
> + * @s         : IOMMU Device State
> + * @ctx       : Device Translation Context with devid and pasid set.
> + * @return    : success or fault code.
> + */
> +static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx)
> +{
> +    const uint64_t ddtp =3D s->ddtp;
> +    unsigned mode =3D get_field(ddtp, RISCV_IOMMU_DDTP_MODE);
> +    dma_addr_t addr =3D PPN_PHYS(get_field(ddtp, RISCV_IOMMU_DDTP_PPN));
> +    struct riscv_iommu_dc dc;
> +    /* Device Context format: 0: extended (64 bytes) | 1: base (32 bytes=
) */
> +    const int dc_fmt =3D !s->enable_msi;
> +    const size_t dc_len =3D sizeof(dc) >> dc_fmt;
> +    unsigned depth;
> +    uint64_t de;
> +
> +    switch (mode) {
> +    case RISCV_IOMMU_DDTP_MODE_OFF:
> +        return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +
> +    case RISCV_IOMMU_DDTP_MODE_BARE:
> +        /* mock up pass-through translation context */
> +        ctx->tc =3D RISCV_IOMMU_DC_TC_V;
> +        ctx->ta =3D 0;
> +        ctx->msiptp =3D 0;
> +        return 0;
> +
> +    case RISCV_IOMMU_DDTP_MODE_1LVL:
> +        depth =3D 0;
> +        break;
> +
> +    case RISCV_IOMMU_DDTP_MODE_2LVL:
> +        depth =3D 1;
> +        break;
> +
> +    case RISCV_IOMMU_DDTP_MODE_3LVL:
> +        depth =3D 2;
> +        break;
> +
> +    default:
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +    }
> +
> +    /*
> +     * Check supported device id width (in bits).
> +     * See IOMMU Specification, Chapter 6. Software guidelines.
> +     * - if extended device-context format is used:
> +     *   1LVL: 6, 2LVL: 15, 3LVL: 24
> +     * - if base device-context format is used:
> +     *   1LVL: 7, 2LVL: 16, 3LVL: 24
> +     */
> +    if (ctx->devid >=3D (1 << (depth * 9 + 6 + (dc_fmt && depth !=3D 2))=
)) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +    }
> +
> +    /* Device directory tree walk */
> +    for (; depth-- > 0; ) {
> +        /*
> +         * Select device id index bits based on device directory tree le=
vel
> +         * and device context format.
> +         * See IOMMU Specification, Chapter 2. Data Structures.
> +         * - if extended device-context format is used:
> +         *   device index: [23:15][14:6][5:0]
> +         * - if base device-context format is used:
> +         *   device index: [23:16][15:7][6:0]
> +         */
> +        const int split =3D depth * 9 + 6 + dc_fmt;
> +        addr |=3D ((ctx->devid >> split) << 3) & ~TARGET_PAGE_MASK;
> +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> +        }
> +        le64_to_cpus(&de);
> +        if (!(de & RISCV_IOMMU_DDTE_VALID)) {
> +            /* invalid directory entry */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +        }
> +        if (de & ~(RISCV_IOMMU_DDTE_PPN | RISCV_IOMMU_DDTE_VALID)) {
> +            /* reserved bits set */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +        }
> +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
> +    }
> +
> +    /* index into device context entry page */
> +    addr |=3D (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
> +
> +    memset(&dc, 0, sizeof(dc));
> +    if (dma_memory_read(s->target_as, addr, &dc, dc_len,
> +                        MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> +    }
> +
> +    /* Set translation context. */
> +    ctx->tc =3D le64_to_cpu(dc.tc);
> +    ctx->ta =3D le64_to_cpu(dc.ta);
> +    ctx->msiptp =3D le64_to_cpu(dc.msiptp);
> +    ctx->msi_addr_mask =3D le64_to_cpu(dc.msi_addr_mask);
> +    ctx->msi_addr_pattern =3D le64_to_cpu(dc.msi_addr_pattern);
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +    }
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
> +        if (ctx->pasid !=3D RISCV_IOMMU_NOPASID) {
> +            /* PASID is disabled */
> +            return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> +        }
> +        return 0;
> +    }
> +
> +    /* FSC.TC.PDTV enabled */
> +    if (mode > RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20) {
> +        /* Invalid PDTP.MODE */
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
> +    }
> +
> +    for (depth =3D mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0;=
 ) {
> +        /*
> +         * Select process id index bits based on process directory tree
> +         * level. See IOMMU Specification, 2.2. Process-Directory-Table.
> +         */
> +        const int split =3D depth * 9 + 8;
> +        addr |=3D ((ctx->pasid >> split) << 3) & ~TARGET_PAGE_MASK;
> +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> +        }
> +        le64_to_cpus(&de);
> +        if (!(de & RISCV_IOMMU_PC_TA_V)) {
> +            return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
> +        }
> +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
> +    }
> +
> +    /* Leaf entry in PDT */
> +    addr |=3D (ctx->pasid << 4) & ~TARGET_PAGE_MASK;
> +    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2=
,
> +                        MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> +    }
> +
> +    /* Use FSC and TA from process directory entry. */
> +    ctx->ta =3D le64_to_cpu(dc.ta);
> +
> +    return 0;
> +}
> +
> +/* Translation Context cache support */
> +static gboolean __ctx_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    RISCVIOMMUContext *c1 =3D (RISCVIOMMUContext *) v1;
> +    RISCVIOMMUContext *c2 =3D (RISCVIOMMUContext *) v2;
> +    return c1->devid =3D=3D c2->devid && c1->pasid =3D=3D c2->pasid;
> +}
> +
> +static guint __ctx_hash(gconstpointer v)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) v;
> +    /* Generate simple hash of (pasid, devid), assuming 24-bit wide devi=
d */
> +    return (guint)(ctx->devid) + ((guint)(ctx->pasid) << 24);
> +}
> +
> +static void __ctx_inval_devid_pasid(gpointer key, gpointer value, gpoint=
er data)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> +    RISCVIOMMUContext *arg =3D (RISCVIOMMUContext *) data;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> +        ctx->devid =3D=3D arg->devid &&
> +        ctx->pasid =3D=3D arg->pasid) {
> +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void __ctx_inval_devid(gpointer key, gpointer value, gpointer dat=
a)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> +    RISCVIOMMUContext *arg =3D (RISCVIOMMUContext *) data;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> +        ctx->devid =3D=3D arg->devid) {
> +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void __ctx_inval_all(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V) {
> +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
> +    uint32_t devid, uint32_t pasid)
> +{
> +    GHashTable *ctx_cache;
> +    RISCVIOMMUContext key =3D {
> +        .devid =3D devid,
> +        .pasid =3D pasid,
> +    };
> +    ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> +    g_hash_table_foreach(ctx_cache, func, &key);
> +    g_hash_table_unref(ctx_cache);
> +}
> +
> +/* Find or allocate translation context for a given {device_id, process_=
id} */
> +static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
> +    unsigned devid, unsigned pasid, void **ref)
> +{
> +    GHashTable *ctx_cache;
> +    RISCVIOMMUContext *ctx;
> +    RISCVIOMMUContext key =3D {
> +        .devid =3D devid,
> +        .pasid =3D pasid,
> +    };
> +
> +    ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> +    ctx =3D g_hash_table_lookup(ctx_cache, &key);
> +
> +    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +        *ref =3D ctx_cache;
> +        return ctx;
> +    }
> +
> +    if (g_hash_table_size(s->ctx_cache) >=3D LIMIT_CACHE_CTX) {
> +        ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
> +                                          g_free, NULL);
> +        g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
> +    }
> +
> +    ctx =3D g_new0(RISCVIOMMUContext, 1);
> +    ctx->devid =3D devid;
> +    ctx->pasid =3D pasid;
> +
> +    int fault =3D riscv_iommu_ctx_fetch(s, ctx);
> +    if (!fault) {
> +        g_hash_table_add(ctx_cache, ctx);
> +        *ref =3D ctx_cache;
> +        return ctx;
> +    }
> +
> +    g_hash_table_unref(ctx_cache);
> +    *ref =3D NULL;
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_DTF)) {

riscv_iommu_ctx_fetch() may return:
RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED (256)
RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT (257)
RISCV_IOMMU_FQ_CAUSE_DDT_INVALID (258)
RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED (259)

These faults are reported even when DTF is set to 1.
We should report these faults regardless of DTF setting.

> +        struct riscv_iommu_fq_record ev =3D { 0 };
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, fault);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE,
> +            RISCV_IOMMU_FQ_TTYPE_UADDR_RD);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, devid);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, pasid);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, !!pasid);
> +        riscv_iommu_fault(s, &ev);
> +    }
> +
> +    g_free(ctx);
> +    return NULL;
> +}
> +
> +static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
> +{
> +    if (ref) {
> +        g_hash_table_unref((GHashTable *)ref);
> +    }
> +}
> +
> +/* Find or allocate address space for a given device */
> +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devi=
d)
> +{
> +    RISCVIOMMUSpace *as;
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |=3D s->bus << 8;
> +
> +    qemu_mutex_lock(&s->core_lock);
> +    QLIST_FOREACH(as, &s->spaces, list) {
> +        if (as->devid =3D=3D devid) {
> +            break;
> +        }
> +    }
> +    qemu_mutex_unlock(&s->core_lock);
> +
> +    if (as =3D=3D NULL) {
> +        char name[64];
> +        as =3D g_new0(RISCVIOMMUSpace, 1);
> +
> +        as->iommu =3D s;
> +        as->devid =3D devid;
> +
> +        snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
> +            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->de=
vid));
> +
> +        /* IOVA address space, untranslated addresses */
> +        memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
> +            TYPE_RISCV_IOMMU_MEMORY_REGION,
> +            OBJECT(as), name, UINT64_MAX);
> +        address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr),
> +            TYPE_RISCV_IOMMU_PCI);

Why do we use TYPE_RISCV_IOMMU_PCI as the address space name here?

> +
> +        qemu_mutex_lock(&s->core_lock);
> +        QLIST_INSERT_HEAD(&s->spaces, as, list);
> +        qemu_mutex_unlock(&s->core_lock);
> +
> +        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid),
> +                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> +    }
> +    return &as->iova_as;
> +}
> +
> +static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    bool enable_faults;
> +    bool enable_pasid;
> +    bool enable_pri;
> +    int fault;
> +
> +    enable_faults =3D !(ctx->tc & RISCV_IOMMU_DC_TC_DTF);
> +    /*
> +     * TC[32] is reserved for custom extensions, used here to temporaril=
y
> +     * enable automatic page-request generation for ATS queries.
> +     */
> +    enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_ULL=
(32));
> +    enable_pasid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
> +
> +    /* Translate using device directory / page table information. */
> +    fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
> +
> +    if (enable_pri && fault) {
> +        struct riscv_iommu_pq_record pr =3D {0};
> +        if (enable_pasid) {
> +            pr.hdr =3D set_field(RISCV_IOMMU_PREQ_HDR_PV,
> +                RISCV_IOMMU_PREQ_HDR_PID, ctx->pasid);
> +        }
> +        pr.hdr =3D set_field(pr.hdr, RISCV_IOMMU_PREQ_HDR_DID, ctx->devi=
d);
> +        pr.payload =3D (iotlb->iova & TARGET_PAGE_MASK) |
> +                     RISCV_IOMMU_PREQ_PAYLOAD_M;
> +        riscv_iommu_pri(s, &pr);
> +        return fault;
> +    }
> +
> +    if (enable_faults && fault) {
> +        struct riscv_iommu_fq_record ev;
> +        unsigned ttype;
> +
> +        if (iotlb->perm & IOMMU_RW) {
> +            ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> +        } else {
> +            ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
> +        }
> +        ev.hdr =3D set_field(0, RISCV_IOMMU_FQ_HDR_CAUSE, fault);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, ttype);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, enable_pasid=
);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->pasid)=
;
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid)=
;
> +        ev.iotval    =3D iotlb->iova;
> +        ev.iotval2   =3D iotlb->translated_addr;
> +        ev._reserved =3D 0;
> +        riscv_iommu_fault(s, &ev);
> +        return fault;
> +    }
> +
> +    return 0;
> +}
> +
> +/* IOMMU Command Interface */
> +static MemTxResult riscv_iommu_iofence(RISCVIOMMUState *s, bool notify,
> +    uint64_t addr, uint32_t data)
> +{
> +    /*
> +     * ATS processing in this implementation of the IOMMU is synchronous=
,
> +     * no need to wait for completions here.
> +     */
> +    if (!notify) {
> +        return MEMTX_OK;
> +    }
> +
> +    return dma_memory_write(s->target_as, addr, &data, sizeof(data),
> +        MEMTXATTRS_UNSPECIFIED);

We should also assert the interrupt when IOFENCE.WSI is true
and IOMMU is configured with wire-signaled interrupt.

> +}
> +
> +static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
> +{
> +    uint64_t old_ddtp =3D s->ddtp;
> +    uint64_t new_ddtp =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_DDTP)=
;
> +    unsigned new_mode =3D get_field(new_ddtp, RISCV_IOMMU_DDTP_MODE);
> +    unsigned old_mode =3D get_field(old_ddtp, RISCV_IOMMU_DDTP_MODE);
> +    bool ok =3D false;
> +
> +    /*
> +     * Check for allowed DDTP.MODE transitions:
> +     * {OFF, BARE}        -> {OFF, BARE, 1LVL, 2LVL, 3LVL}
> +     * {1LVL, 2LVL, 3LVL} -> {OFF, BARE}
> +     */
> +    if (new_mode =3D=3D old_mode ||
> +        new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_OFF ||
> +        new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE) {
> +        ok =3D true;
> +    } else if (new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_1LVL ||
> +               new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_2LVL ||
> +               new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_3LVL) {
> +        ok =3D old_mode =3D=3D RISCV_IOMMU_DDTP_MODE_OFF ||
> +             old_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE;
> +    }
> +
> +    if (ok) {
> +        /* clear reserved and busy bits, report back sanitized version *=
/
> +        new_ddtp =3D set_field(new_ddtp & RISCV_IOMMU_DDTP_PPN,
> +                             RISCV_IOMMU_DDTP_MODE, new_mode);
> +    } else {
> +        new_ddtp =3D old_ddtp;
> +    }
> +    s->ddtp =3D new_ddtp;
> +
> +    riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_DDTP, new_ddtp);
> +}
> +
> +/* Command function and opcode field. */
> +#define RISCV_IOMMU_CMD(func, op) (((func) << 7) | (op))
> +
> +static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
> +{
> +    struct riscv_iommu_command cmd;
> +    MemTxResult res;
> +    dma_addr_t addr;
> +    uint32_t tail, head, ctrl;
> +    uint64_t cmd_opcode;
> +    GHFunc func;
> +
> +    ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +    tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
> +    head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQH) & s->cq_mask;
> +
> +    /* Check for pending error or queue processing disabled */
> +    if (!(ctrl & RISCV_IOMMU_CQCSR_CQON) ||
> +        !!(ctrl & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF)))=
 {
> +        return;
> +    }
> +
> +    while (tail !=3D head) {
> +        addr =3D s->cq_addr  + head * sizeof(cmd);
> +        res =3D dma_memory_read(s->target_as, addr, &cmd, sizeof(cmd),
> +                              MEMTXATTRS_UNSPECIFIED);
> +
> +        if (res !=3D MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                                  RISCV_IOMMU_CQCSR_CQMF, 0);
> +            goto fault;
> +        }
> +
> +        trace_riscv_iommu_cmd(s->parent_obj.id, cmd.dword0, cmd.dword1);
> +
> +        cmd_opcode =3D get_field(cmd.dword0,
> +                               RISCV_IOMMU_CMD_OPCODE | RISCV_IOMMU_CMD_=
FUNC);
> +
> +        switch (cmd_opcode) {
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
> +                             RISCV_IOMMU_CMD_IOFENCE_OPCODE):
> +            res =3D riscv_iommu_iofence(s,
> +                cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
> +
> +            if (res !=3D MEMTX_OK) {
> +                riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                                      RISCV_IOMMU_CQCSR_CQMF, 0);
> +                goto fault;
> +            }
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
> +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> +            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> +                /* illegal command arguments IOTINVAL.GVMA & PSCV =3D=3D=
 1 */
> +                goto cmd_ill;
> +            }
> +            /* translation cache not implemented yet */
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
> +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> +            /* translation cache not implemented yet */
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
> +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
> +                /* invalidate all device context cache mappings */
> +                func =3D __ctx_inval_all;
> +            } else {
> +                /* invalidate all device context matching DID */
> +                func =3D __ctx_inval_devid;
> +            }
> +            riscv_iommu_ctx_inval(s, func,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT,
> +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
> +                /* illegal command arguments IODIR_PDT & DV =3D=3D 0 */
> +                goto cmd_ill;
> +            } else {
> +                func =3D __ctx_inval_devid_pasid;
> +            }
> +            riscv_iommu_ctx_inval(s, func,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID),
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
> +            break;
> +
> +        default:
> +        cmd_ill:
> +            /* Invalid instruction, do not advance instruction index. */
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                RISCV_IOMMU_CQCSR_CMD_ILL, 0);
> +            goto fault;
> +        }
> +
> +        /* Advance and update head pointer after command completes. */
> +        head =3D (head + 1) & s->cq_mask;
> +        riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_CQH, head);
> +    }
> +    return;
> +
> +fault:
> +    if (ctrl & RISCV_IOMMU_CQCSR_CIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_CQ);
> +    }
> +}
> +
> +static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR=
);
> +    uint32_t ctrl_clr;
> +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_CQCSR_CQEN);
> +    bool active =3D !!(ctrl_set & RISCV_IOMMU_CQCSR_CQON);
> +
> +    if (enable && !active) {
> +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_CQB);
> +        s->cq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ))=
 - 1;
> +        s->cq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
> +        ctrl_set =3D RISCV_IOMMU_CQCSR_CQON;
> +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
> +            RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_TO;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~0);
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQON;
> +    } else {
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR=
);
> +    uint32_t ctrl_clr;
> +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_FQCSR_FQEN);
> +    bool active =3D !!(ctrl_set & RISCV_IOMMU_FQCSR_FQON);
> +
> +    if (enable && !active) {
> +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_FQB);
> +        s->fq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_FQB_LOG2SZ))=
 - 1;
> +        s->fq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_FQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~s->fq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQT], 0);
> +        ctrl_set =3D RISCV_IOMMU_FQCSR_FQON;
> +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQMF |
> +            RISCV_IOMMU_FQCSR_FQOF;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~0);
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQON;
> +    } else {
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR=
);
> +    uint32_t ctrl_clr;
> +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_PQCSR_PQEN);
> +    bool active =3D !!(ctrl_set & RISCV_IOMMU_PQCSR_PQON);
> +
> +    if (enable && !active) {
> +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_PQB);
> +        s->pq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_PQB_LOG2SZ))=
 - 1;
> +        s->pq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_PQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~s->pq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQT], 0);
> +        ctrl_set =3D RISCV_IOMMU_PQCSR_PQON;
> +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQMF |
> +            RISCV_IOMMU_PQCSR_PQOF;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~0);
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQON;
> +    } else {
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +/* Core IOMMU execution activation */
> +enum {
> +    RISCV_IOMMU_EXEC_DDTP,
> +    RISCV_IOMMU_EXEC_CQCSR,
> +    RISCV_IOMMU_EXEC_CQT,
> +    RISCV_IOMMU_EXEC_FQCSR,
> +    RISCV_IOMMU_EXEC_FQH,
> +    RISCV_IOMMU_EXEC_PQCSR,
> +    RISCV_IOMMU_EXEC_PQH,
> +    RISCV_IOMMU_EXEC_TR_REQUEST,
> +    /* RISCV_IOMMU_EXEC_EXIT must be the last enum value */
> +    RISCV_IOMMU_EXEC_EXIT,
> +};
> +
> +static void *riscv_iommu_core_proc(void* arg)
> +{
> +    RISCVIOMMUState *s =3D arg;
> +    unsigned exec =3D 0;
> +    unsigned mask =3D 0;
> +
> +    while (!(exec & BIT(RISCV_IOMMU_EXEC_EXIT))) {
> +        mask =3D (mask ? mask : BIT(RISCV_IOMMU_EXEC_EXIT)) >> 1;
> +        switch (exec & mask) {
> +        case BIT(RISCV_IOMMU_EXEC_DDTP):
> +            riscv_iommu_process_ddtp(s);
> +            break;
> +        case BIT(RISCV_IOMMU_EXEC_CQCSR):
> +            riscv_iommu_process_cq_control(s);
> +            break;
> +        case BIT(RISCV_IOMMU_EXEC_CQT):
> +            riscv_iommu_process_cq_tail(s);
> +            break;
> +        case BIT(RISCV_IOMMU_EXEC_FQCSR):
> +            riscv_iommu_process_fq_control(s);
> +            break;
> +        case BIT(RISCV_IOMMU_EXEC_FQH):
> +            /* NOP */
> +            break;
> +        case BIT(RISCV_IOMMU_EXEC_PQCSR):
> +            riscv_iommu_process_pq_control(s);
> +            break;
> +        case BIT(RISCV_IOMMU_EXEC_PQH):
> +            /* NOP */
> +            break;
> +        case BIT(RISCV_IOMMU_EXEC_TR_REQUEST):
> +            /* DBG support not implemented yet */
> +            break;
> +        }
> +        exec &=3D ~mask;
> +        if (!exec) {
> +            qemu_mutex_lock(&s->core_lock);
> +            exec =3D s->core_exec;
> +            while (!exec) {
> +                qemu_cond_wait(&s->core_cond, &s->core_lock);
> +                exec =3D s->core_exec;
> +            }
> +            s->core_exec =3D 0;
> +            qemu_mutex_unlock(&s->core_lock);
> +        }
> +    };
> +
> +    return NULL;
> +}
> +
> +static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
> +    uint64_t data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState *s =3D opaque;
> +    uint32_t regb =3D addr & ~3;
> +    uint32_t busy =3D 0;
> +    uint32_t exec =3D 0;
> +
> +    if (size =3D=3D 0 || size > 8 || (addr & (size - 1)) !=3D 0) {

Is it ever possible to have size =3D 0 or size > 8 write access?
This should be guarded by .valid.min_access_size and .valid.max_access_size=
.

> +        /* Unsupported MMIO alignment or access size */
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> +        /* Unsupported MMIO access location. */
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* Track actionable MMIO write. */
> +    switch (regb) {
> +    case RISCV_IOMMU_REG_DDTP:
> +    case RISCV_IOMMU_REG_DDTP + 4:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_DDTP);
> +        regb =3D RISCV_IOMMU_REG_DDTP;
> +        busy =3D RISCV_IOMMU_DDTP_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_CQT:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_CQT);
> +        break;
> +
> +    case RISCV_IOMMU_REG_CQCSR:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_CQCSR);
> +        busy =3D RISCV_IOMMU_CQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_FQH:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_FQH);
> +        break;
> +
> +    case RISCV_IOMMU_REG_FQCSR:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_FQCSR);
> +        busy =3D RISCV_IOMMU_FQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_PQH:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_PQH);
> +        break;
> +
> +    case RISCV_IOMMU_REG_PQCSR:
> +        exec =3D BIT(RISCV_IOMMU_EXEC_PQCSR);
> +        busy =3D RISCV_IOMMU_PQCSR_BUSY;
> +        break;
> +    }
> +
> +    /*
> +     * Registers update might be not synchronized with core logic.
> +     * If system software updates register when relevant BUSY bit is set
> +     * IOMMU behavior of additional writes to the register is UNSPECIFIE=
D
> +     */
> +
> +    qemu_spin_lock(&s->regs_lock);
> +    if (size =3D=3D 1) {
> +        uint8_t ro =3D s->regs_ro[addr];
> +        uint8_t wc =3D s->regs_wc[addr];
> +        uint8_t rw =3D s->regs_rw[addr];
> +        s->regs_rw[addr] =3D ((rw & ro) | (data & ~ro)) & ~(data & wc);
> +    } else if (size =3D=3D 2) {
> +        uint16_t ro =3D lduw_le_p(&s->regs_ro[addr]);
> +        uint16_t wc =3D lduw_le_p(&s->regs_wc[addr]);
> +        uint16_t rw =3D lduw_le_p(&s->regs_rw[addr]);
> +        stw_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data =
& wc));
> +    } else if (size =3D=3D 4) {
> +        uint32_t ro =3D ldl_le_p(&s->regs_ro[addr]);
> +        uint32_t wc =3D ldl_le_p(&s->regs_wc[addr]);
> +        uint32_t rw =3D ldl_le_p(&s->regs_rw[addr]);
> +        stl_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data =
& wc));
> +    } else if (size =3D=3D 8) {
> +        uint64_t ro =3D ldq_le_p(&s->regs_ro[addr]);
> +        uint64_t wc =3D ldq_le_p(&s->regs_wc[addr]);
> +        uint64_t rw =3D ldq_le_p(&s->regs_rw[addr]);
> +        stq_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data =
& wc));
> +    }
> +
> +    /* Busy flag update, MSB 4-byte register. */
> +    if (busy) {
> +        uint32_t rw =3D ldl_le_p(&s->regs_rw[regb]);
> +        stl_le_p(&s->regs_rw[regb], rw | busy);
> +    }
> +    qemu_spin_unlock(&s->regs_lock);
> +
> +    /* Wake up core processing thread. */
> +    if (exec) {
> +        qemu_mutex_lock(&s->core_lock);
> +        s->core_exec |=3D exec;
> +        qemu_cond_signal(&s->core_cond);
> +        qemu_mutex_unlock(&s->core_lock);
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
> +    uint64_t *data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState *s =3D opaque;
> +    uint64_t val =3D -1;
> +    uint8_t *ptr;
> +
> +    if ((addr & (size - 1)) !=3D 0) {
> +        /* Unsupported MMIO alignment. */
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    ptr =3D &s->regs_rw[addr];
> +
> +    if (size =3D=3D 1) {
> +        val =3D (uint64_t)*ptr;
> +    } else if (size =3D=3D 2) {
> +        val =3D lduw_le_p(ptr);
> +    } else if (size =3D=3D 4) {
> +        val =3D ldl_le_p(ptr);
> +    } else if (size =3D=3D 8) {
> +        val =3D ldq_le_p(ptr);
> +    } else {
> +        return MEMTX_ERROR;
> +    }
> +
> +    *data =3D val;
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps riscv_iommu_mmio_ops =3D {
> +    .read_with_attrs =3D riscv_iommu_mmio_read,
> +    .write_with_attrs =3D riscv_iommu_mmio_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +        .unaligned =3D false,
> +    },
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    }

Spec says:
"The IOMMU behavior for register accesses where the address is not aligned
to the size of the access, or if the access spans multiple registers,
or if the size
of the access is not 4 bytes or 8 bytes, is UNSPECIFIED."

Section 6.1. Reading and writing IOMMU registers also says:
"Registers that are 64-bit wide may be accessed using either a 32-bit
or a 64-bit access.
Registers that are 32-bit wide must only be accessed using a 32-bit access.=
"

Should we limit the access sizes to only 4 and 8 bytes?

> +};
> +
> +/*
> + * Translations matching MSI pattern check are redirected to "riscv-iomm=
u-trap"
> + * memory region as untranslated address, for additional MSI/MRIF interc=
eption
> + * by IOMMU interrupt remapping implementation.
> + * Note: Device emulation code generating an MSI is expected to provide =
a valid
> + * memory transaction attributes with requested_id set.
> + */
> +static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
> +    uint64_t data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState* s =3D (RISCVIOMMUState *)opaque;
> +    RISCVIOMMUContext *ctx;
> +    MemTxResult res;
> +    void *ref;
> +    uint32_t devid =3D attrs.requester_id;
> +
> +    if (attrs.unspecified) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |=3D s->bus << 8;
> +
> +    ctx =3D riscv_iommu_ctx(s, devid, 0, &ref);
> +    if (ctx =3D=3D NULL) {
> +        res =3D MEMTX_ACCESS_ERROR;
> +    } else {
> +        res =3D riscv_iommu_msi_write(s, ctx, addr, data, size, attrs);
> +    }
> +    riscv_iommu_ctx_put(s, ref);
> +    return res;
> +}
> +
> +static MemTxResult riscv_iommu_trap_read(void *opaque, hwaddr addr,
> +    uint64_t *data, unsigned size, MemTxAttrs attrs)
> +{
> +    return MEMTX_ACCESS_ERROR;
> +}
> +
> +static const MemoryRegionOps riscv_iommu_trap_ops =3D {
> +    .read_with_attrs =3D riscv_iommu_trap_read,
> +    .write_with_attrs =3D riscv_iommu_trap_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +        .unaligned =3D true,
> +    },
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    }
> +};
> +
> +static void riscv_iommu_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> +
> +    s->cap =3D s->version & RISCV_IOMMU_CAP_VERSION;
> +    if (s->enable_msi) {
> +        s->cap |=3D RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
> +    }
> +    /* Report QEMU target physical address space limits */
> +    s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> +                       TARGET_PHYS_ADDR_SPACE_BITS);
> +
> +    /* TODO: method to report supported PASID bits */
> +    s->pasid_bits =3D 8; /* restricted to size of MemTxAttrs.pasid */
> +    s->cap |=3D RISCV_IOMMU_CAP_PD8;
> +
> +    /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrou=
gh) */
> +    s->ddtp =3D set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
> +                        RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MOD=
E_BARE);
> +
> +    /* register storage */
> +    s->regs_rw =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_ro =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_wc =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +
> +     /* Mark all registers read-only */
> +    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
> +
> +    /*
> +     * Register complete MMIO space, including MSI/PBA registers.
> +     * Note, PCIDevice implementation will add overlapping MR for MSI/PB=
A,
> +     * managed directly by the PCIDevice implementation.
> +     */
> +    memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_op=
s, s,
> +        "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
> +
> +    /* Set power-on register state */
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], s->fctl);
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
> +        ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
> +        ~(RISCV_IOMMU_CQB_LOG2SZ | RISCV_IOMMU_CQB_PPN));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQB],
> +        ~(RISCV_IOMMU_FQB_LOG2SZ | RISCV_IOMMU_FQB_PPN));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQB],
> +        ~(RISCV_IOMMU_PQB_LOG2SZ | RISCV_IOMMU_PQB_PPN));
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQMF =
|
> +        RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_ILL);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQON =
|
> +        RISCV_IOMMU_CQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQMF =
|
> +        RISCV_IOMMU_FQCSR_FQOF);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQON =
|
> +        RISCV_IOMMU_FQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQMF =
|
> +        RISCV_IOMMU_PQCSR_PQOF);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQON =
|
> +        RISCV_IOMMU_PQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IVEC], 0);
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
> +
> +    /* Memory region for downstream access, if specified. */
> +    if (s->target_mr) {
> +        s->target_as =3D g_new0(AddressSpace, 1);
> +        address_space_init(s->target_as, s->target_mr,
> +            "riscv-iommu-downstream");
> +    } else {
> +        /* Fallback to global system memory. */
> +        s->target_as =3D &address_space_memory;
> +    }
> +
> +    /* Memory region for untranslated MRIF/MSI writes */
> +    memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_op=
s, s,
> +            "riscv-iommu-trap", ~0ULL);
> +    address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
> +
> +    /* Device translation context cache */
> +    s->ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
> +                                         g_free, NULL);
> +
> +    s->iommus.le_next =3D NULL;
> +    s->iommus.le_prev =3D NULL;
> +    QLIST_INIT(&s->spaces);
> +    qemu_cond_init(&s->core_cond);
> +    qemu_mutex_init(&s->core_lock);
> +    qemu_spin_init(&s->regs_lock);
> +    qemu_thread_create(&s->core_proc, "riscv-iommu-core",
> +        riscv_iommu_core_proc, s, QEMU_THREAD_JOINABLE);

In our experience, using QEMU thread increases the latency of command
queue processing,
which leads to the potential IOMMU fence timeout in the Linux driver
when using IOMMU with KVM,
e.g. booting the guest Linux.

Is it possible to remove the thread from the IOMMU just like ARM, AMD,
and Intel IOMMU models?

> +}
> +
> +static void riscv_iommu_unrealize(DeviceState *dev)
> +{
> +    RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> +
> +    qemu_mutex_lock(&s->core_lock);
> +    /* cancel pending operations and stop */
> +    s->core_exec =3D BIT(RISCV_IOMMU_EXEC_EXIT);
> +    qemu_cond_signal(&s->core_cond);
> +    qemu_mutex_unlock(&s->core_lock);
> +    qemu_thread_join(&s->core_proc);
> +    qemu_cond_destroy(&s->core_cond);
> +    qemu_mutex_destroy(&s->core_lock);
> +    g_hash_table_unref(s->ctx_cache);
> +}
> +
> +static Property riscv_iommu_properties[] =3D {
> +    DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
> +        RISCV_IOMMU_SPEC_DOT_VER),
> +    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> +    DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> +    DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
> +    DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
> +        TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void riscv_iommu_class_init(ObjectClass *klass, void* data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    /* internal device for riscv-iommu-{pci/sys}, not user-creatable */
> +    dc->user_creatable =3D false;
> +    dc->realize =3D riscv_iommu_realize;
> +    dc->unrealize =3D riscv_iommu_unrealize;
> +    device_class_set_props(dc, riscv_iommu_properties);
> +}
> +
> +static const TypeInfo riscv_iommu_info =3D {
> +    .name =3D TYPE_RISCV_IOMMU,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(RISCVIOMMUState),
> +    .class_init =3D riscv_iommu_class_init,
> +};
> +
> +static const char *IOMMU_FLAG_STR[] =3D {
> +    "NA",
> +    "RO",
> +    "WR",
> +    "RW",
> +};
> +
> +/* RISC-V IOMMU Memory Region - Address Translation Space */
> +static IOMMUTLBEntry riscv_iommu_memory_region_translate(
> +    IOMMUMemoryRegion *iommu_mr, hwaddr addr,
> +    IOMMUAccessFlags flag, int iommu_idx)
> +{
> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, iova=
_mr);
> +    RISCVIOMMUContext *ctx;
> +    void *ref;
> +    IOMMUTLBEntry iotlb =3D {
> +        .iova =3D addr,
> +        .target_as =3D as->iommu->target_as,
> +        .addr_mask =3D ~0ULL,
> +        .perm =3D flag,
> +    };
> +
> +    ctx =3D riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
> +    if (ctx =3D=3D NULL) {
> +        /* Translation disabled or invalid. */
> +        iotlb.addr_mask =3D 0;
> +        iotlb.perm =3D IOMMU_NONE;
> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
> +        /* Translation disabled or fault reported. */
> +        iotlb.addr_mask =3D 0;
> +        iotlb.perm =3D IOMMU_NONE;
> +    }
> +
> +    /* Trace all dma translations with original access flags. */
> +    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devi=
d),
> +                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iomm=
u_idx,
> +                          IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
> +                          iotlb.translated_addr);
> +
> +    riscv_iommu_ctx_put(as->iommu, ref);
> +
> +    return iotlb;
> +}
> +
> +static int riscv_iommu_memory_region_notify(
> +    IOMMUMemoryRegion *iommu_mr, IOMMUNotifierFlag old,
> +    IOMMUNotifierFlag new, Error **errp)
> +{
> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, iova=
_mr);
> +
> +    if (old =3D=3D IOMMU_NOTIFIER_NONE) {
> +        as->notifier =3D true;
> +        trace_riscv_iommu_notifier_add(iommu_mr->parent_obj.name);
> +    } else if (new =3D=3D IOMMU_NOTIFIER_NONE) {
> +        as->notifier =3D false;
> +        trace_riscv_iommu_notifier_del(iommu_mr->parent_obj.name);
> +    }
> +
> +    return 0;
> +}
> +
> +static inline bool pci_is_iommu(PCIDevice *pdev)
> +{
> +    return pci_get_word(pdev->config + PCI_CLASS_DEVICE) =3D=3D 0x0806;
> +}
> +
> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int =
devfn)
> +{
> +    RISCVIOMMUState *s =3D (RISCVIOMMUState *) opaque;
> +    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
> +    AddressSpace *as =3D NULL;
> +
> +    if (pdev && pci_is_iommu(pdev)) {
> +        return s->target_as;
> +    }
> +
> +    /* Find first registered IOMMU device */
> +    while (s->iommus.le_prev) {
> +        s =3D *(s->iommus.le_prev);
> +    }
> +
> +    /* Find first matching IOMMU */
> +    while (s !=3D NULL && as =3D=3D NULL) {
> +        as =3D riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devf=
n));

For pci_bus_num(),
riscv_iommu_find_as() can be called at the very early stage
where software has no chance to enumerate the bus numbers.




> +        s =3D s->iommus.le_next;
> +    }
> +
> +    return as ? as : &address_space_memory;
> +}
> +
> +static const PCIIOMMUOps riscv_iommu_ops =3D {
> +    .get_address_space =3D riscv_iommu_find_as,
> +};
> +
> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> +        Error **errp)
> +{
> +    if (bus->iommu_ops &&
> +        bus->iommu_ops->get_address_space =3D=3D riscv_iommu_find_as) {
> +        /* Allow multiple IOMMUs on the same PCIe bus, link known device=
s */
> +        RISCVIOMMUState *last =3D (RISCVIOMMUState *)bus->iommu_opaque;
> +        QLIST_INSERT_AFTER(last, iommu, iommus);
> +    } else if (bus->iommu_ops =3D=3D NULL) {
> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> +    } else {
> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d=
",
> +            pci_bus_num(bus));
> +    }
> +}
> +
> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
> +    MemTxAttrs attrs)
> +{
> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasid;
> +}
> +
> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_=
mr)
> +{
> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, iova=
_mr);
> +    return 1 << as->iommu->pasid_bits;
> +}
> +
> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *dat=
a)
> +{
> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate =3D riscv_iommu_memory_region_translate;
> +    imrc->notify_flag_changed =3D riscv_iommu_memory_region_notify;
> +    imrc->attrs_to_index =3D riscv_iommu_memory_region_index;
> +    imrc->num_indexes =3D riscv_iommu_memory_region_index_len;
> +}
> +
> +static const TypeInfo riscv_iommu_memory_region_info =3D {
> +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> +    .name =3D TYPE_RISCV_IOMMU_MEMORY_REGION,
> +    .class_init =3D riscv_iommu_memory_region_init,
> +};
> +
> +static void riscv_iommu_register_mr_types(void)
> +{
> +    type_register_static(&riscv_iommu_memory_region_info);
> +    type_register_static(&riscv_iommu_info);
> +}
> +
> +type_init(riscv_iommu_register_mr_types);
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> new file mode 100644
> index 0000000000..6f740de690
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.h
> @@ -0,0 +1,141 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_IOMMU_STATE_H
> +#define HW_RISCV_IOMMU_STATE_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#include "hw/riscv/iommu.h"
> +
> +struct RISCVIOMMUState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    uint32_t version;     /* Reported interface version number */
> +    uint32_t pasid_bits;  /* process identifier width */
> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
> +
> +    uint64_t cap;         /* IOMMU supported capabilities */
> +    uint64_t fctl;        /* IOMMU enabled features */
> +
> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled)=
 */
> +    bool enable_msi;      /* Enable MSI remapping */
> +
> +    /* IOMMU Internal State */
> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointe=
r */
> +
> +    dma_addr_t cq_addr;   /* Command queue base physical address */
> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
> +
> +    uint32_t cq_mask;     /* Command queue index bit mask */
> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
> +    uint32_t pq_mask;     /* Page request queue index bit mask */
> +
> +    /* interrupt notifier */
> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
> +
> +    /* IOMMU State Machine */
> +    QemuThread core_proc; /* Background processing thread */
> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs upda=
tes */
> +    QemuCond core_cond;   /* Background processing wake up signal */
> +    unsigned core_exec;   /* Processing thread execution actions */
> +
> +    /* IOMMU target address space */
> +    AddressSpace *target_as;
> +    MemoryRegion *target_mr;
> +
> +    /* MSI / MRIF access trap */
> +    AddressSpace trap_as;
> +    MemoryRegion trap_mr;
> +
> +    GHashTable *ctx_cache;          /* Device translation Context Cache =
*/
> +
> +    /* MMIO Hardware Interface */
> +    MemoryRegion regs_mr;
> +    QemuSpin regs_lock;
> +    uint8_t *regs_rw;  /* register state (user write) */
> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
> +    uint8_t *regs_ro;  /* read-only mask */
> +
> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
> +};
> +
> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> +         Error **errp);
> +
> +/* private helpers */
> +
> +/* Register helper functions */
> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> +    unsigned idx, uint32_t set, uint32_t clr)
> +{
> +    uint32_t val;
> +    qemu_spin_lock(&s->regs_lock);
> +    val =3D ldl_le_p(s->regs_rw + idx);
> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> +    qemu_spin_unlock(&s->regs_lock);
> +    return val;
> +}
> +
> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
> +    unsigned idx, uint32_t set)
> +{
> +    qemu_spin_lock(&s->regs_lock);
> +    stl_le_p(s->regs_rw + idx, set);
> +    qemu_spin_unlock(&s->regs_lock);
> +}
> +
> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
> +    unsigned idx)
> +{
> +    return ldl_le_p(s->regs_rw + idx);
> +}
> +
> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
> +    unsigned idx, uint64_t set, uint64_t clr)
> +{
> +    uint64_t val;
> +    qemu_spin_lock(&s->regs_lock);
> +    val =3D ldq_le_p(s->regs_rw + idx);
> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
> +    qemu_spin_unlock(&s->regs_lock);
> +    return val;
> +}
> +
> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
> +    unsigned idx, uint64_t set)
> +{
> +    qemu_spin_lock(&s->regs_lock);
> +    stq_le_p(s->regs_rw + idx, set);
> +    qemu_spin_unlock(&s->regs_lock);
> +}
> +
> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
> +    unsigned idx)
> +{
> +    return ldq_le_p(s->regs_rw + idx);
> +}
> +
> +
> +
> +#endif
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> new file mode 100644
> index 0000000000..42a97caffa
> --- /dev/null
> +++ b/hw/riscv/trace-events
> @@ -0,0 +1,11 @@
> +# See documentation at docs/devel/tracing.rst
> +
> +# riscv-iommu.c
> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s:=
 device attached %04x:%02x.%d"
> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iov=
a: 0x%"PRIx64
> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsi=
gned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %=
04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x=
%"PRIx64
> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%=
"PRIx64" 0x%"PRIx64
> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed=
"
> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
> new file mode 100644
> index 0000000000..b88504b750
> --- /dev/null
> +++ b/hw/riscv/trace.h
> @@ -0,0 +1,2 @@
> +#include "trace/trace-hw_riscv.h"
> +
> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> new file mode 100644
> index 0000000000..403b365893
> --- /dev/null
> +++ b/include/hw/riscv/iommu.h
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_IOMMU_H
> +#define HW_RISCV_IOMMU_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_IOMMU "riscv-iommu"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
> +typedef struct RISCVIOMMUState RISCVIOMMUState;
> +
> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
> +
> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> +
> +#endif
> diff --git a/meson.build b/meson.build
> index c59ca496f2..75e56f3282 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3361,6 +3361,7 @@ if have_system
>      'hw/rdma',
>      'hw/rdma/vmw',
>      'hw/rtc',
> +    'hw/riscv',
>      'hw/s390x',
>      'hw/scsi',
>      'hw/sd',
> --
> 2.43.2
>
>

