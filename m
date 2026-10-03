Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FB0CA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 06:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCtCl-000757-Mq; Sat, 03 Oct 2026 02:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xCtCi-00074i-6J
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 02:26:40 -0400
Received: from smtpout1.mo538.mail-out.ovh.net ([51.210.91.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xCtCe-0001z8-Uj
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 02:26:39 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hxbJb4lXGz6FB0;
 Sat,  3 Oct 2026 06:26:23 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sat,  3 Oct 2026 06:26:22 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.252])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hxbJZ6Td6z1xqR; Sat,  3 Oct 2026 06:26:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A4FB41B42C2F;
 Sat,  3 Oct 2026 06:26:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S00821e3ab6b-b8ed-4898-810d-ca7b2098087d,
 EF3BAB35031320AEE1F3939107F7654D0985B97F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0fcdfcb5-6f56-4030-ba01-f350accb0412@kaod.org>
Date: Sat, 3 Oct 2026 08:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] fsi/cfam: Add common CFAM base class
To: Mikail Sadic <mikail.sadic@ibm.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260813193040.669533-1-mikail.sadic@ibm.com>
 <20260813193040.669533-2-mikail.sadic@ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260813193040.669533-2-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 11533155696595152003
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG0Muoh/QLqQm8C6YImcQ7NMtFUhBUWENyNEvE3N29mO/O1r+cRmOBi67l3MimT/z6yHXF0U/ekKhGN8YN345smeSOyAKdAmXuQXOLdls3bAS07LRrCpYQ7Nor4KA4WFIScTbf2K8FevzRm2/H7nYomQMCSv8tRuJ2qWRZpJ+MzwmEE0EfN36SWv+dmnNyXKcywCiEoZMGbe4zM104buPrPgyNprb+CkZlvRDkUN9s0SGngiteit7X7GZ9jCnvw4puz5iOydeb2TfRscsNYSRpwVjKsbKtEzT62it8z05KkhOgbzOXrdlw7QCTS/sR27vrk+3pTg0LifZcn1uaRzzbwVeUgHzgozAHLV6KbD9lPvDjKV8YK63Lv1J0UxgsAq31K0bPTxgGGim0imggP0G9ZMGtIr7ifefVmmoMPRXTtwRZDNlxVATy5VaLIhsfn44iRwxjr0g7BBZgGZVebDOvJv7cVVlg6sATGBZUOEw2vsdfRC+c7yd1v7P5zE9Fy+Hf8FW3AV/64VQz5pCSk0w5joryDrv8/566kRLBfDKGx17n2gAjYK2NxNkSi/WytndqmEsz1AkKyf5ibWDOkshTJVYfMt9SAuR6JAR8LuBp3TC0DPrcaEHusjBydqX4J5Bx2GD8WkRVdAC6fckePn/ylant4sunPJUB1MF7iHz0Ljw
DKIM-Signature: a=rsa-sha256; bh=+ssclU/xiksrnetyi9Z5RJhc8IJF/m38wihSExD80wU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791008785; v=1;
 b=vq9Bw1Yq3XmDRLiRdybOXUVHATGIjNs1jginXt173aE1LiHZVHLbav7A2merZ0p/ovg6crxH
 yLvoue2AC7G3qKmWIVfL33L4uo2Xmwdma4GPA2KHhO5Tb5DgMPfjjW7887B8xCoLqBau2HfdgkK
 CbvFyV0f51p2AU2nU7HiGe5qxSqa5vS/0pD/JzZCYT2w5AuC9rHoDRlVNA4Zuyh7pOsJsjeoKqD
 O17BGXcBM2wNf/HaTpP8jgu+ietXGd8MDsbWZlW43wuDOqK1yV2603bx+LzOcFhI52YywfH0RN8
 MgvMfoh2o02Ovd7cWKbFDI+Rh1c4tMOIk7OGgaAM4aMSQ==
Received-SPF: pass client-ip=51.210.91.30; envelope-from=clg@kaod.org;
 helo=smtpout1.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 8/13/26 21:30, Mikail Sadic wrote:
> Prepare a common CFAM parent class for CFAM-S implementation.
> 
> Add an abstract TYPE_FSI_CFAM_COMMON with an FSICFAMCommonClass holding
> what varies between types: the config table, the offsets of the FSI
> responder and the local bus within the register slot, and a
> realize_engines() hook for the engines on the local bus. Its realize is
> driven by those fields, so one realize serves every type. TYPE_FSI_CFAM
> keeps its name and becomes the first derived type, supplying the P9
> config table, its slot offsets and the scratchpad engine. The config
> table becomes data, still written with the same CFAM_CONFIG_REG()
> expressions, which move to the header so a derived type can describe its
> own table the same way.
> 
> Name the new instance struct without a State suffix and rename
> FSICFAMState to FSICFAM to match.
> 
> No functional change: same memory map, same config words, same type and
> child names. aspeed_fsi-test verified.
> 
> Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   include/hw/fsi/cfam.h       |  58 ++++++++++++++++-
>   include/hw/fsi/fsi-master.h |   2 +-
>   hw/fsi/cfam.c               | 125 +++++++++++++++++++++---------------
>   hw/fsi/fsi-master.c         |   2 +-
>   4 files changed, 130 insertions(+), 57 deletions(-)
> 
> diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
> index cceb4bd6f1..bdf579b4fe 100644
> --- a/include/hw/fsi/cfam.h
> +++ b/include/hw/fsi/cfam.h
> @@ -7,18 +7,44 @@
>   #ifndef FSI_CFAM_H
>   #define FSI_CFAM_H
>   
> +#include "qemu/units.h"
>   #include "system/memory.h"
>   
>   #include "hw/fsi/fsi.h"
>   #include "hw/fsi/lbus.h"
>   
> +/*
> + * All CFAM flavors present a register slot holding a config table, an FSI
> + * responder and a local bus carrying the engines the config table describes.
> + * That is the common model; each flavor supplies its own table, slot layout
> + * and engines.
> + */
> +#define TYPE_FSI_CFAM_COMMON "cfam-common"
> +OBJECT_DECLARE_TYPE(FSICFAMCommon, FSICFAMCommonClass, FSI_CFAM_COMMON)
> +
>   #define TYPE_FSI_CFAM "cfam"
> -#define FSI_CFAM(obj) OBJECT_CHECK(FSICFAMState, (obj), TYPE_FSI_CFAM)
> +OBJECT_DECLARE_SIMPLE_TYPE(FSICFAM, FSI_CFAM)
>   
>   /* P9-ism */
>   #define CFAM_CONFIG_NR_REGS 0x28
>   
> -typedef struct FSICFAMState {
> +#define FSI_CFAM_SLOT_SIZE   (2 * MiB)
> +#define FSI_CFAM_CONFIG_SIZE 0x400
> +
> +#define ENGINE_CONFIG_NEXT            BIT(31)
> +#define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
> +#define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
> +#define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
> +
> +/* Valid, slots, version, type, crc */
> +#define CFAM_CONFIG_REG(__VER, __TYPE, __CRC)   \
> +    (ENGINE_CONFIG_NEXT       |   \
> +     0x00010000               |   \
> +     (__VER)                  |   \
> +     (__TYPE)                 |   \
> +     (__CRC))
> +
> +struct FSICFAMCommon {
>       /* < private > */
>       FSISlaveState parent;
>   
> @@ -28,7 +54,33 @@ typedef struct FSICFAMState {
>       MemoryRegion mr;
>   
>       FSILBus lbus;
> +};
> +
> +struct FSICFAMCommonClass {
> +    /* < private > */
> +    DeviceClass parent_class;
> +
> +    /* < public > */
> +    /* Config table served by the common ops, one word per 4-byte offset */
> +    const uint32_t *config;
> +    unsigned config_nr;
> +
> +    /* Layout of the register slot */
> +    hwaddr responder_offset;
> +    hwaddr lbus_offset;
> +
> +    /* Realize and map this flavor's local bus engines */
> +    bool (*realize_engines)(FSICFAMCommon *cfam, Error **errp);


This seems redundant.
Each subclass can just do the engine init/realize in its own
instance_init and realize. Please do it that way instead.

> +};
> +
> +struct FSICFAM {
> +    /* < private > */
> +    FSICFAMCommon parent;
> +
>       FSIScratchPad scratchpad;
> -} FSICFAMState;
> +};
> +
> +bool fsi_cfam_add_engine(FSICFAMCommon *cfam, DeviceState *engine,
> +                         hwaddr offset, Error **errp);
>   
>   #endif /* FSI_CFAM_H */
> diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
> index 60ddaa994f..87c11ec3dc 100644
> --- a/include/hw/fsi/fsi-master.h
> +++ b/include/hw/fsi/fsi-master.h
> @@ -25,7 +25,7 @@ typedef struct FSIMasterState {
>       FSIBus bus;
>   
>       uint32_t regs[FSI_MASTER_NR_REGS];
> -    FSICFAMState cfam;
> +    FSICFAM cfam;
>   } FSIMasterState;
>   
>   
> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
> index 54c0b05769..5d4d0622d0 100644
> --- a/hw/fsi/cfam.c
> +++ b/hw/fsi/cfam.c
> @@ -16,19 +16,6 @@
>   
>   #include "hw/core/qdev-properties.h"
>   
> -#define ENGINE_CONFIG_NEXT            BIT(31)
> -#define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
> -#define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
> -#define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
> -
> -/* Valid, slots, version, type, crc */
> -#define CFAM_CONFIG_REG(__VER, __TYPE, __CRC)   \
> -    (ENGINE_CONFIG_NEXT       |   \
> -     0x00010000               |   \
> -     (__VER)                  |   \
> -     (__TYPE)                 |   \
> -     (__CRC))
> -
>   #define TO_REG(x)                          ((x) >> 2)
>   
>   #define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
> @@ -36,34 +23,33 @@
>   #define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
>   #define CFAM_CONFIG_CHIP_ID_BREAK          0xc0de0000
>   
> +/*
> + * Config table of the P9 CFAM: the chip ID followed by one entry per engine,
> + * entry n describing the engine at address n * 4. We need to add future
> + * engines from address 0x10 onwards.
> + */
> +static const uint32_t cfam_p9_config[] = {
> +    CFAM_CONFIG_CHIP_ID_P9,
> +    CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_PEEK, 0xc),
> +    CFAM_CONFIG_REG(0x5000, ENGINE_CONFIG_TYPE_FSI, 0xa),
> +    CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_SCRATCHPAD, 0x7),
> +};
> +
>   static uint64_t fsi_cfam_config_read(void *opaque, hwaddr addr, unsigned size)
>   {
> +    FSICFAMCommonClass *cc = FSI_CFAM_COMMON_GET_CLASS(opaque);
> +    unsigned int reg = TO_REG(addr);
> +
>       trace_fsi_cfam_config_read(addr, size);
>   
> -    switch (addr) {
> -    case 0x00:
> -        return CFAM_CONFIG_CHIP_ID_P9;
> -    case 0x04:
> -        return CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_PEEK, 0xc);
> -    case 0x08:
> -        return CFAM_CONFIG_REG(0x5000, ENGINE_CONFIG_TYPE_FSI, 0xa);
> -    case 0xc:
> -        return CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_SCRATCHPAD, 0x7);
> -    default:
> -        /*
> -         * The config table contains different engines from 0xc onwards.
> -         * The scratch pad is already added at address 0xc. We need to add
> -         * future engines from address 0x10 onwards. Returning 0 as engine
> -         * is not implemented.
> -         */
> -        return 0;
> -    }
> +    /* Engines past the end of the table are not implemented */
> +    return reg < cc->config_nr ? cc->config[reg] : 0;
>   }
>   
>   static void fsi_cfam_config_write(void *opaque, hwaddr addr, uint64_t data,
>                                     unsigned size)
>   {
> -    FSICFAMState *cfam = FSI_CFAM(opaque);
> +    FSICFAMCommon *cfam = FSI_CFAM_COMMON(opaque);
>   
>       trace_fsi_cfam_config_write(addr, size, data);
>   
> @@ -109,59 +95,94 @@ static const struct MemoryRegionOps fsi_cfam_unimplemented_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> -static void fsi_cfam_instance_init(Object *obj)
> +bool fsi_cfam_add_engine(FSICFAMCommon *cfam, DeviceState *engine,
> +                         hwaddr offset, Error **errp)
>   {
> -    FSICFAMState *s = FSI_CFAM(obj);
> +    if (!qdev_realize(engine, BUS(&cfam->lbus), errp)) {
> +        return false;
> +    }
>   
> -    object_initialize_child(obj, "scratchpad", &s->scratchpad,
> -                            TYPE_FSI_SCRATCHPAD);
> +    memory_region_add_subregion(&cfam->lbus.mr, offset,
> +                                &FSI_LBUS_DEVICE(engine)->iomem);
> +    return true;
>   }
>   
> -static void fsi_cfam_realize(DeviceState *dev, Error **errp)
> +static void fsi_cfam_common_realize(DeviceState *dev, Error **errp)
>   {
> -    FSICFAMState *cfam = FSI_CFAM(dev);
> +    FSICFAMCommon *cfam = FSI_CFAM_COMMON(dev);
> +    FSICFAMCommonClass *cc = FSI_CFAM_COMMON_GET_CLASS(dev);
>       FSISlaveState *slave = FSI_SLAVE(dev);
> +    const char *type = object_get_typename(OBJECT(dev));
> +    g_autofree char *config_name = g_strdup_printf("%s.config", type);
>   
>       /* Each slave has a 2MiB address space */
>       memory_region_init_io(&cfam->mr, OBJECT(cfam), &fsi_cfam_unimplemented_ops,
> -                          cfam, TYPE_FSI_CFAM, 2 * MiB);
> +                          cfam, type, FSI_CFAM_SLOT_SIZE);
>   
>       qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_FSI_LBUS, DEVICE(cfam),
>                 NULL);
>   
>       memory_region_init_io(&cfam->config_iomem, OBJECT(cfam), &cfam_config_ops,
> -                          cfam, TYPE_FSI_CFAM ".config", 0x400);
> +                          cfam, config_name, FSI_CFAM_CONFIG_SIZE);
>   
>       memory_region_add_subregion(&cfam->mr, 0, &cfam->config_iomem);
> -    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
> -    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
> +    memory_region_add_subregion(&cfam->mr, cc->responder_offset, &slave->iomem);
> +    memory_region_add_subregion(&cfam->mr, cc->lbus_offset, &cfam->lbus.mr);
>   
> -    /* Add scratchpad engine */
> -    if (!qdev_realize(DEVICE(&cfam->scratchpad), BUS(&cfam->lbus), errp)) {
> +    if (!cc->realize_engines(cfam, errp)) {
>           return;
>       }
> -
> -    FSILBusDevice *fsi_dev = FSI_LBUS_DEVICE(&cfam->scratchpad);
> -    memory_region_add_subregion(&cfam->lbus.mr, 0, &fsi_dev->iomem);
>   }
>   
> -static void fsi_cfam_class_init(ObjectClass *klass, const void *data)
> +static void fsi_cfam_common_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +
>       dc->bus_type = TYPE_FSI_BUS;
> -    dc->realize = fsi_cfam_realize;
> +    dc->realize = fsi_cfam_common_realize;
> +}
> +
> +static bool fsi_cfam_realize_engines(FSICFAMCommon *cfam, Error **errp)
> +{
> +    FSICFAM *s = FSI_CFAM(cfam);
> +
> +    /* Add scratchpad engine */
> +    object_initialize_child(OBJECT(s), "scratchpad", &s->scratchpad,
> +                            TYPE_FSI_SCRATCHPAD);
> +

This is a violation of the QOM cycle.

C.


> +    return fsi_cfam_add_engine(cfam, DEVICE(&s->scratchpad), 0, errp);
>   }
>   
> +static void fsi_cfam_class_init(ObjectClass *klass, const void *data)
> +{
> +    FSICFAMCommonClass *cc = FSI_CFAM_COMMON_CLASS(klass);
> +
> +    cc->config = cfam_p9_config;
> +    cc->config_nr = ARRAY_SIZE(cfam_p9_config);
> +    cc->responder_offset = 0x800;
> +    cc->lbus_offset = 0xc00;
> +    cc->realize_engines = fsi_cfam_realize_engines;
> +}
> +
> +static const TypeInfo fsi_cfam_common_info = {
> +    .name = TYPE_FSI_CFAM_COMMON,
> +    .parent = TYPE_FSI_SLAVE,
> +    .instance_size = sizeof(FSICFAMCommon),
> +    .class_size = sizeof(FSICFAMCommonClass),
> +    .class_init = fsi_cfam_common_class_init,
> +    .abstract = true,
> +};
> +
>   static const TypeInfo fsi_cfam_info = {
>       .name = TYPE_FSI_CFAM,
> -    .parent = TYPE_FSI_SLAVE,
> -    .instance_init = fsi_cfam_instance_init,
> -    .instance_size = sizeof(FSICFAMState),
> +    .parent = TYPE_FSI_CFAM_COMMON,
> +    .instance_size = sizeof(FSICFAM),
>       .class_init = fsi_cfam_class_init,
>   };
>   
>   static void fsi_cfam_register_types(void)
>   {
> +    type_register_static(&fsi_cfam_common_info);
>       type_register_static(&fsi_cfam_info);
>   }
>   
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> index 083a5507ab..d82df1c094 100644
> --- a/hw/fsi/fsi-master.c
> +++ b/hw/fsi/fsi-master.c
> @@ -130,7 +130,7 @@ static void fsi_master_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* address ? */
> -    memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.mr);
> +    memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.parent.mr);
>   }
>   
>   static void fsi_master_reset(DeviceState *dev)


