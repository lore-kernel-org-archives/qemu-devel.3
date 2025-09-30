Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A38BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3P5N-0000WE-3b; Mon, 29 Sep 2025 21:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3P5K-0000Vq-0h
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:23:18 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3P57-0006su-Kt
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:23:17 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b30ead58e0cso998885166b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759195382; x=1759800182; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gh6yeQtJGP4uYw/c8Om1ZTEjufNOxnxykWGLJPd2/M=;
 b=m9XTYe3bJAxSajJpUw5083rEgf9b/TMnquLqqX/DDv0TwuTPPpy3PTREFAfdEFAdqE
 LaOU9HZSUIqwv8IHzF3g6/MVuQzBA5VOJV0enodCQw45xztB/IqDamdbJOuktrFSp7tZ
 4VeIeVRW5vdMXBUzIKM89N4/+aO5tggEHMDbSeLVV8m5jG1JyF+XdmTqcMC0dmRlWcbf
 35gVb7Zwp0ff25D7TwGDPPfQHztfAlBuiV7gIoH1J2H6oI3uufPAeVOzLs6a59tKhsUz
 vdo9XcBTThti2Di2+IPlnCh6WSkz9L3k4cvg60UwgSBd/rbO1JEoUaXruJW0vFhKVSIM
 EpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759195382; x=1759800182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gh6yeQtJGP4uYw/c8Om1ZTEjufNOxnxykWGLJPd2/M=;
 b=IvJE3GK5ojq3rNyyX7nDCCPpKYvgjI6Y1U4Zl1wRubROv/cM8Mk3ycM9oz5orTl3/n
 XPASvy3qnhyumwat/CVpACRStQRm1XS8A3bMV4qR81BoxZ10J+TsLBJuqc/k4Ftm2Gwj
 uvVDD4uwPu96Xoe8jKqJO4m1GfmHTo7+S7BzuejsxLoGcuH9FRgAsqyOR8/FC0Vh7NGZ
 RiN93Ars5z7D0LCzzEoW3MA6QeWyyqi6v/NE/THj/mYhQGIAbEMLpnmkC8N0aMyavhro
 l/PFsZcRxfa7kmS1370PCsM1szmpD8kUWfnG0UVzmi+R64QRDAn8Yqp+++HEiZl0F6u9
 mqIw==
X-Gm-Message-State: AOJu0Yxc61Un3m8Z2KAirbLA4O+pFU31r1Rd4MwTtH/jmSbK9pqvHEsp
 sRMRz8AzIgEgJ2uED/p3fnh2Hzkns6pBs2Z/ogGzYbJ2DSxusYTwtnzaENfuNpXBFwNTQyqPAp0
 VT7GPv2TtNOLKqfEVXSZsrFItdLXznXE=
X-Gm-Gg: ASbGncunND2BoCX8pi8mgoTH9Y7KBwwGnqTuh3UtQmTNv6MhbJyy2fejodCmvZuhTlZ
 zzkfKDFDsKpERUr4nhh8i7hpP6sp9qOI1tijgW/NxfdtTiXO9tnyApSnBcnupmm6cVPGZ/a8VUT
 sViUkJMiJQaxdGik9nNoGn5C5yE1n5uOW0ChnhaWvb5ERUGKVhV135S3frxShs39hN0o0E3KKM6
 Q5v5v3hfAyvsFhXOgd2r1Qd+qQtYV7cC6Wsi5qDycWxte7YNN9/9xcABQpl6A==
X-Google-Smtp-Source: AGHT+IHyMxLBmhIbyCigvs8crRez0q6c5Gbr4I6NKgShHiKu8xy9vr9k4BbUNKSc+BM3y0bXPPEnuDrJt/mRA343zYA=
X-Received: by 2002:a17:907:d93:b0:b3f:cc6d:e0a8 with SMTP id
 a640c23a62f3a-b3fcc7d24f9mr545582766b.17.1759195381965; Mon, 29 Sep 2025
 18:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-9-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-9-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 11:22:35 +1000
X-Gm-Features: AS18NWDNTclWZz_wJxycnipvQbBCOSDGPpY00inhTFFoc2YZ4sZpIX_WgXWtpeU
Message-ID: <CAKmqyKOrE9cj8wY51RNgP4YVP_3ZyVFD89=UrRT0PZUrn27pnw@mail.gmail.com>
Subject: Re: [PATCH v8 08/14] hw/misc: Add RISC-V CMGCR device implementation
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 24, 2025 at 7:25=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add RISC-V implementation of the Coherent Manager Global Control
> Register (CMGCR) device. It is based on the existing MIPS CMGCR
> implementation but adapted for RISC-V systems.
>
> The CMGCR device provides global system control for multi-core
> configurations in RISC-V systems.
>
> This is needed for the MIPS BOSTON AIA board.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/misc/Kconfig               |   9 ++
>  hw/misc/meson.build           |   2 +
>  hw/misc/riscv_cmgcr.c         | 246 ++++++++++++++++++++++++++++++++++
>  include/hw/misc/riscv_cmgcr.h |  50 +++++++
>  4 files changed, 307 insertions(+)
>  create mode 100644 hw/misc/riscv_cmgcr.c
>  create mode 100644 include/hw/misc/riscv_cmgcr.h
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 4e35657468..c72927c3ff 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -121,6 +121,15 @@ config MIPS_ITU
>      bool
>      depends on TCG
>
> +config RISCV_CMGCR
> +    bool
> +
> +config MIPS_BOSTON_AIA
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_CMGCR
> +
>  config MPS2_FPGAIO
>      bool
>      select LED
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b1d8d8e5d2..ef891e465b 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: file=
s('mac_via.c'))
>  specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', =
'mips_cpc.c'))
>  specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
>
> +specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.=
c'))
> +
>  system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>
>  # HPPA devices
> diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
> new file mode 100644
> index 0000000000..cb8351a3bf
> --- /dev/null
> +++ b/hw/misc/riscv_cmgcr.c
> @@ -0,0 +1,246 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General P=
ublic
> + * License.  See the file "COPYING" in the main directory of this archiv=
e
> + * for more details.
> + *
> + * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
> + * Authors: Sanjay Lal <sanjayl@kymasys.com>
> + *
> + * Copyright (C) 2015 Imagination Technologies
> + *
> + * Copyright (C) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later

Can you link to a datasheet

> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/riscv_cmgcr.h"
> +#include "hw/qdev-properties.h"
> +
> +#include "cpu.h"
> +
> +#define CM_RESET_VEC 0x1FC00000
> +#define GCR_ADDRSPACE_SZ        0x8000
> +
> +/* Offsets to register blocks */
> +#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
> +#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
> +#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regi=
sters */
> +
> +/* Global Control Block Register Map */
> +#define GCR_CONFIG_OFS      0x0000
> +#define GCR_BASE_OFS        0x0008
> +#define GCR_REV_OFS         0x0030
> +#define GCR_CPC_STATUS_OFS  0x00F0
> +#define GCR_L2_CONFIG_OFS   0x0130
> +
> +/* GCR_L2_CONFIG register fields */
> +#define GCR_L2_CONFIG_BYPASS_SHF    20
> +#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SH=
F)
> +
> +/* GCR_BASE register fields */
> +#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
> +
> +/* GCR_CPC_BASE register fields */
> +#define GCR_CPC_BASE_CPCEN_MSK   1
> +#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
> +#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_=
MSK)
> +
> +/* GCR_CL_RESETBASE_OFS register fields */
> +#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
> +#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
> +
> +static inline bool is_cpc_connected(RISCVGCRState *s)
> +{
> +    return s->cpc_mr !=3D NULL;
> +}
> +
> +static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
> +{
> +    if (is_cpc_connected(gcr)) {
> +        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
> +        memory_region_transaction_begin();
> +        memory_region_set_address(gcr->cpc_mr,
> +                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_M=
SK);
> +        memory_region_set_enabled(gcr->cpc_mr,
> +                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK=
);
> +        memory_region_transaction_commit();
> +    }
> +}
> +
> +static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
> +{
> +    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
> +    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
> +
> +    /*
> +     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
> +     * cpc automatically.
> +     */
> +    update_cpc_base(gcr, val + 0x8001);

Will this break with future boards?

Alistair

> +}
> +
> +/* Read GCR registers */
> +static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
> +
> +    switch (addr) {
> +    /* Global Control Block Register */
> +    case GCR_CONFIG_OFS:
> +        /* Set PCORES to 0 */
> +        return 0;
> +    case GCR_BASE_OFS:
> +        return gcr->gcr_base;
> +    case GCR_REV_OFS:
> +        return gcr->gcr_rev;
> +    case GCR_CPC_STATUS_OFS:
> +        return is_cpc_connected(gcr);
> +    case GCR_L2_CONFIG_OFS:
> +        /* L2 BYPASS */
> +        return GCR_L2_CONFIG_BYPASS_MSK;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADD=
R_PRIx
> +                      "\n", size, addr);
> +    }
> +    return 0;
> +}
> +
> +static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
> +{
> +    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
> +}
> +
> +/* Write GCR registers */
> +static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned=
 size)
> +{
> +    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
> +    RISCVGCRVPState *current_vps;
> +    int cpu_index, c, h;
> +
> +    for (c =3D 0; c < gcr->num_core; c++) {
> +        for (h =3D 0; h < gcr->num_hart; h++) {
> +            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE +=
 h * 8) {
> +                cpu_index =3D c * gcr->num_hart + h;
> +                current_vps =3D &gcr->vps[cpu_index];
> +                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK=
;
> +                cpu_set_exception_base(cpu_index + gcr->cluster_id *
> +                                       gcr->num_core * gcr->num_hart,
> +                                       get_exception_base(current_vps));
> +                return;
> +            }
> +        }
> +    }
> +
> +    switch (addr) {
> +    case GCR_BASE_OFS:
> +        update_gcr_base(gcr, data);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWAD=
DR_PRIx
> +                      " 0x%" PRIx64 "\n", size, addr, data);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps gcr_ops =3D {
> +    .read =3D gcr_read,
> +    .write =3D gcr_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .max_access_size =3D 8,
> +    },
> +};
> +
> +static void riscv_gcr_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RISCVGCRState *s =3D RISCV_GCR(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
> +                          "riscv-gcr", GCR_ADDRSPACE_SZ);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void riscv_gcr_reset(DeviceState *dev)
> +{
> +    RISCVGCRState *s =3D RISCV_GCR(dev);
> +    int i;
> +
> +    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically.=
 */
> +    update_cpc_base(s, s->gcr_base + 0x8001);
> +
> +    for (i =3D 0; i < s->num_vps; i++) {
> +        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
> +        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
> +    }
> +}
> +
> +static const VMStateDescription vmstate_riscv_gcr =3D {
> +    .name =3D "riscv-gcr",
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(cpc_base, RISCVGCRState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const Property riscv_gcr_properties[] =3D {
> +    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
> +    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
> +    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
> +    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
> +    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
> +    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADD=
R),
> +    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +};
> +
> +static void riscv_gcr_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVGCRState *s =3D RISCV_GCR(dev);
> +
> +    /* Validate num_vps */
> +    if (s->num_vps =3D=3D 0) {
> +        error_setg(errp, "num-vp must be at least 1");
> +        return;
> +    }
> +    if (s->num_vps > GCR_MAX_VPS) {
> +        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
> +        return;
> +    }
> +
> +    /* Create local set of registers for each VP */
> +    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
> +}
> +
> +static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    device_class_set_props(dc, riscv_gcr_properties);
> +    dc->vmsd =3D &vmstate_riscv_gcr;
> +    device_class_set_legacy_reset(dc, riscv_gcr_reset);
> +    dc->realize =3D riscv_gcr_realize;
> +}
> +
> +static const TypeInfo riscv_gcr_info =3D {
> +    .name          =3D TYPE_RISCV_GCR,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RISCVGCRState),
> +    .instance_init =3D riscv_gcr_init,
> +    .class_init    =3D riscv_gcr_class_init,
> +};
> +
> +static void riscv_gcr_register_types(void)
> +{
> +    type_register_static(&riscv_gcr_info);
> +}
> +
> +type_init(riscv_gcr_register_types)
> diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.=
h
> new file mode 100644
> index 0000000000..c57d4ada1c
> --- /dev/null
> +++ b/include/hw/misc/riscv_cmgcr.h
> @@ -0,0 +1,50 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General P=
ublic
> + * License.  See the file "COPYING" in the main directory of this archiv=
e
> + * for more details.
> + *
> + * Copyright (C) 2015 Imagination Technologies
> + *
> + * Copyright (C) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef RISCV_CMGCR_H
> +#define RISCV_CMGCR_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_GCR "riscv-gcr"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
> +
> +#define GCR_BASE_ADDR           0x1fb80000ULL
> +#define GCR_MAX_VPS             256
> +
> +typedef struct RISCVGCRVPState RISCVGCRVPState;
> +struct RISCVGCRVPState {
> +    uint64_t reset_base;
> +};
> +
> +typedef struct RISCVGCRState RISCVGCRState;
> +struct RISCVGCRState {
> +    SysBusDevice parent_obj;
> +
> +    int32_t gcr_rev;
> +    uint32_t cluster_id;
> +    uint32_t num_vps;
> +    uint32_t num_hart;
> +    uint32_t num_core;
> +    hwaddr gcr_base;
> +    MemoryRegion iomem;
> +    MemoryRegion *cpc_mr;
> +
> +    uint64_t cpc_base;
> +
> +    /* VP Local/Other Registers */
> +    RISCVGCRVPState *vps;
> +};
> +
> +#endif /* RISCV_CMGCR_H */
> --
> 2.34.1
>

