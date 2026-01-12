Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA02D25030
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 05:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfAhx-0002cC-4m; Mon, 12 Jan 2026 00:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfAhg-0002Zb-FA
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 00:43:02 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfAhe-0000di-2R
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 00:43:00 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8722834679so40087866b.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 21:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768196577; x=1768801377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9ZZ+6Sy8VYZI5IfQ1nUH2M3Q2IUqNRv6GYDPjarFX8=;
 b=R0D4DGyXfZA+rJ6zOKtzYuXYbrt2l3kXFZS81jm54GpkQP4hs64VBq+ys4MN1USuYA
 5kXL0JFjqsrt3qRihWRvWTwTuaMrwrVRzYsDNKrS9+NOBL0YWmjCnnpuaxZ6ViiOm5T8
 pQrDVt/ZBO4JDzYdBCF2Bnl/xbJ6IhRb/ODhwwPuxOuZ2MV75Wdya02M2WgxlFqRLGiA
 /UKIhc7XKnlT5At+ddFAr9sQcrZWZja4IsvyfoWu3ysC7sFCOO/3dbvDKfWqXL+9JMYR
 0KdsF54H1ZkyvppA5jKdugvrKzdjTjM+PkJ8WqtjEOGrVpDSrjnhxWhUymacHLWaIDH7
 KBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768196577; x=1768801377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w9ZZ+6Sy8VYZI5IfQ1nUH2M3Q2IUqNRv6GYDPjarFX8=;
 b=TjxF9DTnJ8BWHbRbmB2g11Cf2afyymNV+/qrpb6y/5FerOIwbbkl9uXY182cBQHw8/
 FitP4arTe/LmlxV7hZPUkhMUZrK8GALfomGC813yAJ5B+z2N2qZF4Ff7LI6Ol7XnEbzM
 X0HwKpBV2jvQA8a/XsGQGkwWkhQiaItTkyR0UC8GNP+SXtFA4vKQgYPMHL7X0PpGXUij
 uboGI4ev1BPF7uApbAUWv3o8e0vru+wJFSX8Uaaf1Zc/8TeGz87A88h6in6X79NK0UDT
 ra+9GyiaSpya/bPxEgQ55qOLdk1C5TCKMlgoXKDuFRyJxV0ZrM9utuzT9791PL2DfTjB
 hvCQ==
X-Gm-Message-State: AOJu0YwUrwbJiLiJrbHqCZJSA63pO93PyreoBOx+//FkXAc231HBTYhf
 iMBNh3QVH+KovyxvcFxUAGt+KL/JY1ConeOK8YtXfoGHqarHlMG2JL4DSauHBCxQy3XD4uxhuuE
 5xc43mRd4RUvVXGNI7f9UTM7FgVQpN0M=
X-Gm-Gg: AY/fxX6/YQ/KKzY7AQC7Z4pSTNou8hszOGtuHY8WXSbbB1nBHYcuB1Z9i4qeXC5QXLH
 r15uw5jfY0xVxjT68pTxrwIcmBhofSyouWzU76KNCkfJXtQjtpTtERV178XvZGtBp8EKCrstvQ8
 vmi32zLF35EoAJomKOaN+0uq3++TKcj7rXseBL8OIrP2lDlXdzvSYqoSm0LKdSWKugfsvTpc3Hj
 Pd6xCGUaBr2mPQlvNNbmitKN6TGFpkQgiAHEau3/nu8SDZaxb9a8nqkoUOfKFV8I3ZEKQr1fFYm
 IAScC4ibI8y5m64NQTfnSKp+qtNCMbTHP43f
X-Google-Smtp-Source: AGHT+IG0uudHtg96pwSGlq14OHNwQ5fPkIu7U3O9q9Hbj3GHJoDvqHnkyCJn9Kh0naMlsmVbl+x+af+OZukJaF+p028=
X-Received: by 2002:a17:907:728f:b0:b87:2410:594d with SMTP id
 a640c23a62f3a-b8724105abfmr95576766b.49.1768196576327; Sun, 11 Jan 2026
 21:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
 <20260108134128.2218102-10-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-10-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 12 Jan 2026 15:42:30 +1000
X-Gm-Features: AZwV_QhDLHX8XaHIgHENghiKFzgg-BjKQfmBsw524N9xfkUH157gajWmNTHTkKk
Message-ID: <CAKmqyKNeJXsN1Vkww4PYOFQxbvCwgYWQN+OAm+=OrrQ2rKJvGg@mail.gmail.com>
Subject: Re: [PATCH v16 09/12] hw/riscv: Add support for RISCV CPS
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 8, 2026 at 11:41=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add support for the Coherent Processing System for RISC-V.
> This enables SMP support for RISC-V boards that require
> cache-coherent multiprocessor systems.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/misc/Kconfig        |   4 +
>  hw/riscv/cps.c         | 196 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build   |   2 +
>  include/hw/riscv/cps.h |  66 ++++++++++++++
>  4 files changed, 268 insertions(+)
>  create mode 100644 hw/riscv/cps.c
>  create mode 100644 include/hw/riscv/cps.h
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 38be72b141..4a22d68233 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -127,12 +127,16 @@ config RISCV_MIPS_CMGCR
>  config RISCV_MIPS_CPC
>      bool
>
> +config RISCV_MIPS_CPS
> +    bool
> +
>  config MIPS_BOSTON_AIA
>      bool
>      default y
>      depends on RISCV64
>      select RISCV_MIPS_CMGCR
>      select RISCV_MIPS_CPC
> +    select RISCV_MIPS_CPS
>
>  config MPS2_FPGAIO
>      bool
> diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
> new file mode 100644
> index 0000000000..86172be5b3
> --- /dev/null
> +++ b/hw/riscv/cps.c
> @@ -0,0 +1,196 @@
> +/*
> + * Coherent Processing System emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/riscv/cps.h"
> +#include "hw/core/qdev-properties.h"
> +#include "system/reset.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "hw/pci/msi.h"
> +
> +static void riscv_cps_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RISCVCPSState *s =3D RISCV_CPS(obj);
> +
> +    /*
> +     * Cover entire address space as there do not seem to be any
> +     * constraints for the base address of CPC .
> +     */
> +    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_=
MAX);
> +    sysbus_init_mmio(sbd, &s->container);
> +}
> +
> +static void main_cpu_reset(void *opaque)
> +{
> +    CPUState *cs =3D opaque;
> +
> +    cpu_reset(cs);
> +}
> +
> +static void riscv_cps_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVCPSState *s =3D RISCV_CPS(dev);
> +    RISCVCPU *cpu;
> +    int i;
> +
> +    /* Validate num_vp */
> +    if (s->num_vp =3D=3D 0) {
> +        error_setg(errp, "num-vp must be at least 1");
> +        return;
> +    }
> +    if (s->num_vp > MAX_HARTS) {
> +        error_setg(errp, "num-vp cannot exceed %d", MAX_HARTS);
> +        return;
> +    }
> +
> +    /* Allocate CPU array */
> +    s->cpus =3D g_new0(CPUState *, s->num_vp);
> +
> +    /* Set up cpu_index and mhartid for avaiable CPUs. */
> +    int harts_in_cluster =3D s->num_hart * s->num_core;
> +    int num_of_clusters =3D s->num_vp / harts_in_cluster;
> +    for (i =3D 0; i < s->num_vp; i++) {
> +        cpu =3D RISCV_CPU(object_new(s->cpu_type));
> +
> +        /* All VPs are halted on reset. Leave powering up to CPC. */
> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
> +                                 &error_abort);
> +
> +        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
> +            return;
> +        }
> +
> +        /* Store CPU in array */
> +        s->cpus[i] =3D CPU(cpu);
> +
> +        /* Set up mhartid */
> +        int cluster_id =3D i / harts_in_cluster;
> +        int hart_id =3D (i % harts_in_cluster) % s->num_hart;
> +        int core_id =3D (i % harts_in_cluster) / s->num_hart;
> +        int mhartid =3D (cluster_id << MHARTID_CLUSTER_SHIFT) +
> +                      (core_id << MHARTID_CORE_SHIFT) +
> +                      (hart_id << MHARTID_HART_SHIFT);
> +        cpu->env.mhartid =3D mhartid;
> +        qemu_register_reset(main_cpu_reset, s->cpus[i]);
> +    }
> +
> +    /* Cluster Power Controller */
> +    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC)=
;
> +    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
> +                            &error_abort);
> +
> +    /* Pass CPUs to CPC using link properties */
> +    for (i =3D 0; i < s->num_vp; i++) {
> +        char *propname =3D g_strdup_printf("cpu[%d]", i);
> +        object_property_set_link(OBJECT(&s->cpc), propname,
> +                                OBJECT(s->cpus[i]), &error_abort);
> +        g_free(propname);
> +    }
> +
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->container, 0,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cp=
c), 0));
> +
> +    /* Global Configuration Registers */
> +    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR)=
;
> +    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
> +                            &error_abort);
> +    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->container, s->gcr_base,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gc=
r), 0));
> +
> +    for (i =3D 0; i < num_of_clusters; i++) {
> +        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);

This causes a Coverity issue

*** CID 1644076:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/builds/qemu-project/qemu/hw/riscv/cps.c: 136             in riscv_cps_real=
ize()
130         }
131
132         memory_region_add_subregion(&s->container, s->gcr_base,
133
sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
134
135         for (i =3D 0; i < num_of_clusters; i++) {
>>>     CID 1644076:         Integer handling issues  (OVERFLOW_BEFORE_WIDE=
N)
>>>     Potentially overflowing expression "524288 * i" with type "int" (32=
 bits, signed) is evaluated using 32-bit arithmetic, and then used in a con=
text that expects an expression of type "uint64_t" (64 bits, unsigned).
136             uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
137             uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
138             s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET=
,
139                                           AIA_PLIC_M_SIZE,
140                                           hartid_base, /* hartid_base *=
/
141                                           MAX_HARTS, /* num_harts */


Can you send a patch to fix this issue and link to CID 1644076?

Alistair


> +        uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
> +        s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
> +                                      AIA_PLIC_M_SIZE,
> +                                      hartid_base, /* hartid_base */
> +                                      MAX_HARTS, /* num_harts */
> +                                      APLIC_NUM_SOURCES,
> +                                      APLIC_NUM_PRIO_BITS,
> +                                      false, true, NULL);
> +        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
> +                           AIA_PLIC_S_SIZE,
> +                           hartid_base, /* hartid_base */
> +                           MAX_HARTS, /* num_harts */
> +                           APLIC_NUM_SOURCES,
> +                           APLIC_NUM_PRIO_BITS,
> +                           false, false, s->aplic);
> +        /* PLIC changes msi_nonbroken to ture. We revert the change. */
> +        msi_nonbroken =3D false;
> +        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
> +                                hartid_base, MAX_HARTS, false);
> +        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
> +                                   RISCV_ACLINT_SWI_SIZE,
> +                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                                   hartid_base,
> +                                   MAX_HARTS,
> +                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
> +                                   RISCV_ACLINT_DEFAULT_MTIME,
> +                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, f=
alse);
> +    }
> +}
> +
> +static const Property riscv_cps_properties[] =3D {
> +    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
> +    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
> +    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
> +    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADD=
R),
> +    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
> +};
> +
> +static void riscv_cps_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D riscv_cps_realize;
> +    device_class_set_props(dc, riscv_cps_properties);
> +}
> +
> +static const TypeInfo riscv_cps_info =3D {
> +    .name =3D TYPE_RISCV_CPS,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RISCVCPSState),
> +    .instance_init =3D riscv_cps_init,
> +    .class_init =3D riscv_cps_class_init,
> +};
> +
> +static void riscv_cps_register_types(void)
> +{
> +    type_register_static(&riscv_cps_info);
> +}
> +
> +type_init(riscv_cps_register_types)
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2a8d5b136c..9023b80087 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files=
(
>  riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-g=
eneric.c'))
>  riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangsh=
an_kmh.c'))
>
> +riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
> +
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
> new file mode 100644
> index 0000000000..f33fd7ac86
> --- /dev/null
> +++ b/include/hw/riscv/cps.h
> @@ -0,0 +1,66 @@
> +/*
> + * Coherent Processing System emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef RISCV_CPS_H
> +#define RISCV_CPS_H
> +
> +#include "hw/core/sysbus.h"
> +#include "hw/misc/riscv_cmgcr.h"
> +#include "hw/misc/riscv_cpc.h"
> +#include "target/riscv/cpu.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_CPS "riscv-cps"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
> +
> +/* The model supports up to 64 harts. */
> +#define MAX_HARTS 64
> +
> +/* The global CM base for the boston-aia model. */
> +#define GLOBAL_CM_BASE 0x16100000
> +/* The CM block is 512 KiB. */
> +#define CM_SIZE (1 << 19)
> +
> +/*
> + * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
> + * bit 0.
> + */
> +
> +#define MHARTID_CLUSTER_SHIFT 16
> +#define MHARTID_CORE_SHIFT 4
> +#define MHARTID_HART_SHIFT 0
> +
> +#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts.=
 */
> +#define APLIC_NUM_PRIO_BITS 3
> +#define AIA_PLIC_M_OFFSET 0x40000
> +#define AIA_PLIC_M_SIZE 0x8000
> +#define AIA_PLIC_S_OFFSET 0x60000
> +#define AIA_PLIC_S_SIZE 0x8000
> +#define AIA_CLINT_OFFSET 0x50000
> +
> +typedef struct RISCVCPSState {
> +    SysBusDevice parent_obj;
> +
> +    uint32_t num_vp;
> +    uint32_t num_hart;
> +    uint32_t num_core;
> +    uint64_t gcr_base;
> +    char *cpu_type;
> +
> +    MemoryRegion container;
> +    RISCVGCRState gcr;
> +    RISCVCPCState cpc;
> +
> +    DeviceState *aplic;
> +    CPUState **cpus;
> +} RISCVCPSState;
> +
> +#endif
> --
> 2.34.1

