Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D499CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WoI-0001ml-QA; Wed, 08 Oct 2025 12:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v6WoE-0001mA-JG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:14:35 -0400
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v6Wo4-0004gr-Ai
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:14:34 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.128])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4chdNy3K5Yz5vqn;
 Wed,  8 Oct 2025 16:14:09 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 8 Oct
 2025 18:14:09 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001108fd7b1-4cdc-43d3-a742-be5c593f9b66,
 8C34243C2A945F502B3A5846113D703BCD413F3E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <73c1f147-8251-48ff-8b3d-84afeb6b3186@kaod.org>
Date: Wed, 8 Oct 2025 18:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 09/16] hw/arm/aspeed: Introduce
 AspeedCoprocessor class and base implementation
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
 <20251008032207.593353-10-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251008032207.593353-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 04b9511f-9912-4d7d-bb25-c437cf804383
X-Ovh-Tracer-Id: 10218949031546882994
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF+szbxCYun8zm+kSnnpY5y/tsdGaIMTZM+v6htFmktxolXkbRF10khI0CwWN+WUIOZf3oxTS1ghk46+RuI+0LyrJ6SP6545OU0l5an6uinMwmeqq3/MXITvzxtcfRAeUqN3EfPQa347Jy8899XQeOS1fjYIF+cslPbm3L/08jIVwqZKvZ7vf9qZJvMJNVu6jTzBSbOaPw6zmMfVwfcNgDSnvrqw0PzFVsBkFDoGKdX/baHvdh3PDQJig4+sGos2FSkSXKUgEiF+1O0Pq0Tfq3gGZSIbDRGrj3UR+zQGX8nnPO8Sr/uIGSp6WQeYroIKHFCltoQymItSbRxogiPonTQJ0lhuq1oIzrqqObdEHJisUH84jqTVQ9xFDvMCr7aB6MBxbdMEb2RkOCo0Rh3ca4oNfb+pd0ltzX4+uB0V5vE2JcOZuT6HyyjyaGj6EzzJ1uhqK+BbGxXQB8szLH9HLDp3r6YSzZri8LGt/Gy+TCGahZIbRwsu+/O8+LGps4MdyaDMrsIknVb2TQkkxCiPuDIsirD+rPtdxrnK4bI5z2BmeY+1//GD5c33+bKYFGc2gAAWM1tkIJ0ciTrA5PJQDOhkDAmfMaaeyLWQ2/zigInLMU17JG8uRIFAUFZ3AD24fxzzxJ1poN9KZGck7AU4F4nVXH0jKbeb86YJwZ2kJuK2w
DKIM-Signature: a=rsa-sha256; bh=jAsj9OmQuDGAzHQEyxfLitHOKVl6bVSaAypTZlMunqw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759940051; v=1;
 b=YIMAGl6hGPosSmyrx44cmzW8Pj1W85ZeTqiKC5ostllY4F+a7pSlvE+SrupR2qhjxlP9dW/W
 9qSt+iH/D41cndrcYjcFyHSLwbbdWm6DcJHCKO2u56ZlRmDwpUEoTukVwI9bFSt+lH0nZdeLvWk
 c2jouawY3pSXRnE2lIixczfwx8zPkPK6kg/ryz9pH06sQrghtUTPlE0N22o3lEY7CwR2ZKpOC3m
 kghM537MFezTrSA47/ZOnlt8eA+hSaytXo46T50OrdhEhL16TekeNsrFD/DtrcAks9CL+DpITZT
 EtTqxs7/PYTxJz8ZZaKsuGeZDvEVoDMZds1F4Y0sflqxw==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Jamin,

On 10/8/25 05:21, Jamin Lin wrote:
> Add a new AspeedCoprocessor class that defines the foundational structure for
> ASPEED coprocessor models. This class encapsulates a base DeviceState with
> links to system memory, clock, and peripheral components such as SCU, SCUIO,
> Timer Controller, and UARTs.
> 
> Introduce the corresponding implementation file
> aspeed_coprocessor_common.c, which provides the aspeed_coprocessor_realize()
> method, property registration, and QOM type registration. The class is marked
> as abstract and intended to serve as a common base for specific coprocessor
> variants (e.g. SSP/TSP subsystems).
> 
> This establishes a reusable and extensible framework for modeling ASPEED
> coprocessor devices.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h | 45 ++++++++++++++++++++++++++
>   hw/arm/aspeed_coprocessor_common.c  | 49 +++++++++++++++++++++++++++++
>   hw/arm/meson.build                  |  3 +-
>   3 files changed, 96 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/arm/aspeed_coprocessor.h
>   create mode 100644 hw/arm/aspeed_coprocessor_common.c
> 
> diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
> new file mode 100644
> index 0000000000..6938dfe24c
> --- /dev/null
> +++ b/include/hw/arm/aspeed_coprocessor.h
> @@ -0,0 +1,45 @@
> +/*
> + * ASPEED Coprocessor
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ASPEED_COPROCESSOR_H
> +#define ASPEED_COPROCESSOR_H
> +
> +#include "qom/object.h"
> +#include "hw/arm/aspeed_soc.h"
> +
> +struct AspeedCoprocessorState {
> +    DeviceState parent;
> +
> +    MemoryRegion *memory;
> +    MemoryRegion sram;
> +    Clock *sysclk;
> +
> +    AspeedSCUState scu;
> +    AspeedSCUState scuio;
> +    AspeedTimerCtrlState timerctrl;
> +    SerialMM uart[ASPEED_UARTS_NUM];
> +};
> +
> +#define TYPE_ASPEED_COPROCESSOR "aspeed-coprocessor"
> +OBJECT_DECLARE_TYPE(AspeedCoprocessorState, AspeedCoprocessorClass,
> +                    ASPEED_COPROCESSOR)
> +
> +struct AspeedCoprocessorClass {
> +    DeviceClass parent_class;
> +
> +    /** valid_cpu_types: NULL terminated array of a single CPU type. */
> +    const char * const *valid_cpu_types;
> +    uint32_t silicon_rev;
> +    const hwaddr *memmap;
> +    const int *irqmap;
> +    int uarts_base;
> +    int uarts_num;
> +    qemu_irq (*get_irq)(void *ctx, int dev);
> +};
> +
> +#endif /* ASPEED_COPROCESSOR_H */
> diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
> new file mode 100644
> index 0000000000..8a94b44f07
> --- /dev/null
> +++ b/hw/arm/aspeed_coprocessor_common.c
> @@ -0,0 +1,49 @@
> +/*
> + * ASPEED Coprocessor
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "system/memory.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/arm/aspeed_coprocessor.h"
> +
> +static void aspeed_coprocessor_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev);
> +
> +    if (!s->memory) {
> +        error_setg(errp, "'memory' link is not set");
> +        return;
> +    }
> +}
> +
> +static const Property aspeed_coprocessor_properties[] = {
> +    DEFINE_PROP_LINK("memory", AspeedCoprocessorState, memory,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +};
> +
> +static void aspeed_coprocessor_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = aspeed_coprocessor_realize;
> +    device_class_set_props(dc, aspeed_coprocessor_properties);
> +}
> +
> +static const TypeInfo aspeed_coprocessor_types[] = {
> +    {
> +        .name           = TYPE_ASPEED_COPROCESSOR,
> +        .parent         = TYPE_DEVICE,
> +        .instance_size  = sizeof(AspeedCoprocessorState),
> +        .class_size     = sizeof(AspeedCoprocessorClass),
> +        .class_init     = aspeed_coprocessor_class_init,
> +        .abstract       = true,
> +    },
> +};
> +
> +DEFINE_TYPES(aspeed_coprocessor_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index dc68391305..0b2c66e391 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -52,7 +52,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'fby35.c'))
>   arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
>     'aspeed_ast27x0.c',
> -  'aspeed_ast27x0-fc.c',))
> +  'aspeed_ast27x0-fc.c',
> +  'aspeed_coprocessor_common.c',))

I don't think we need to keep the ending comma ','.


More important, this list lacks source files :

   'aspeed_ast27x0-ssp.c',
   'aspeed_ast27x0-tsp.c',

which are aarch64 specific and with the following changes of this
series, 'make check' fails with :

   Type 'aspeed27x0ssp-soc' is missing its parent 'aspeed-coprocessor'

A preliminary fix is needed.

Please run  'make check'  before sending.

Thanks,

C.




>   arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
>   arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
>   arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))


