Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49619CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMF4-0006eo-3o; Fri, 07 Nov 2025 08:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vHMF1-0006cV-Tl; Fri, 07 Nov 2025 08:11:00 -0500
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vHMEy-0005KB-GC; Fri, 07 Nov 2025 08:10:58 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.211])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d2zvb6g4dz6PfS;
 Fri,  7 Nov 2025 13:10:51 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 7 Nov
 2025 14:10:50 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008e489d15c-82a4-40a4-96c1-2e13a9947b23,
 22B515FCB2325FA901564F8AB94FB8FB00D14EB6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <e0bbc9f7-1efa-477c-a0ec-daba2c1618c5@kaod.org>
Date: Fri, 7 Nov 2025 14:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] hw/arm/aspeed: Add AST1700 LTPI expander device
 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-4-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251105035859.3709907-4-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 4558769c-880c-460e-8016-c7fa59fe9084
X-Ovh-Tracer-Id: 17283407995707231154
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF/UrHDY8d4IIxdbmXBGwszSsYF/0rUHkpXAicY5UgA0mdPbcEzEJ6Cdu4jlM4xSldu8CYFQeuTqs8MjJ0x1OLlVNr6GKkEIBBURT/ILgNQ+bORT2ZD7Q0lXltx6PYqUdctzK+fyR+6L8AMxdyA8QDIUfpSPhdtfT8s715B5geRnsBmZ3JrfS0hnR+4u8bOfefCWGUI0cpXwX01lTa2kMdWp06Zu9gVMUFjPOPGRkE9FcczY/VZ3iG9cYKOQn7gjhsj5sqcQIF/JUXYg7k1fEWX4qjn9YHPnRscIZ2UA8No2fPYXmEnlOoTm8f7jUaKXG9XjxUChxuIeir7libLjfncHFhiDrY6szpKsZJwqF7W2T4y8daimZBwOg84vuKvDh61Tcw7ezUk639mFVUYBa5FRXVRcigIrFBHLlaMolTywqOS9GswqD/cxGiRsEuaFpEpI9P/fqGbGYtXF2VXQbPiNNbkvCrKO1el85vYZBa/3hcwEBslJIvrbqmnBj484rUuS4n+5ajuNIoDx4JIyzQw8+ZOC20NOZRuSxrSz9SYLFYK5bj9fAtvNHroMAxM3dlh8FWPDJErMMFf3Cj8xe4e24BglPmWrgHix49f7FykSHt+ZWK3mXUBSG90n4umyPuwpMQhNfeJM05GrBqtyqzTark/9oxr+qmoswntJbYvQw
DKIM-Signature: a=rsa-sha256; bh=smnuXg2HlAgwqYKbvakz4SaP0p48hwyoblNS5eUgU74=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762521053; v=1;
 b=UTC/d8iX6R8vttL1OYhTTrl0bq7iQUvf+pOBm3DmZIhC6aeQsvKa3zglqX7+C9FVYyk6bqtG
 PQo1YUw6RcRClbxB1+mD61ROeHmiX65M5af7YWadGpkNNjFEciJcV5XfpFCbz880CDynP70tRcy
 cLmjwqR05TJt34wRGpgJpSh8TggbETPc+a7cFfBDyks4qTGPoQU9Ny3jfmPkcoeZHKHKqUw9Rfj
 j7zEnnU+0f+2Ljf+Uhl7XuJsvKVu+vuwu3xRs6t5blrxxfW4Zo5X/WOaqGu3qFrFDBPqDidU6jq
 eCxj5LaZIBwZBy8CBpDvZHUZ1p+yjZghryco9pY1oM3+Q==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Introduce a minimal QEMU device model for the ASPEED AST1700, an
> MCU-less I/O expander used in the LTPI topology defined by the
> DC-SCM 2.0 specification (see figure 2):
> https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
> 
> This initial implementation includes:
> 
> * Definition of aspeed.ast1700 as a SysBusDevice
> 
> * Setup of a basic memory region to reserve I/O space for future
>    peripheral modeling
> 
> This stub establishes the foundation for LTPI-related device emulation,
> without implementing any functional peripherals at this stage.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_ast1700.h | 32 ++++++++++++++++++
>   hw/misc/aspeed_ast1700.c         | 57 ++++++++++++++++++++++++++++++++
>   hw/misc/meson.build              |  1 +
>   3 files changed, 90 insertions(+)
>   create mode 100644 include/hw/misc/aspeed_ast1700.h
>   create mode 100644 hw/misc/aspeed_ast1700.c
> 
> diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
> new file mode 100644
> index 0000000000..b7c666eef2
> --- /dev/null
> +++ b/include/hw/misc/aspeed_ast1700.h
> @@ -0,0 +1,32 @@
> +/*
> + * ASPEED AST1700 IO Expander
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ASPEED_AST1700_H
> +#define ASPEED_AST1700_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/misc/aspeed_scu.h"
> +#include "hw/adc/aspeed_adc.h"
> +#include "hw/gpio/aspeed_gpio.h"
> +#include "hw/i2c/aspeed_i2c.h"
> +#include "hw/misc/aspeed_ltpi.h"
> +#include "hw/ssi/aspeed_smc.h"
> +#include "hw/watchdog/wdt_aspeed.h"
> +#include "hw/char/serial-mm.h"
> +#include "hw/misc/unimp.h"

There are too much includes. Please introduce the minimum each time.
  > +
> +#define TYPE_ASPEED_AST1700 "aspeed.ast1700"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
> +
> +struct AspeedAST1700SoCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +};
> +
> +#endif /* ASPEED_AST1700_H */
> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
> new file mode 100644
> index 0000000000..bb05e392f4
> --- /dev/null
> +++ b/hw/misc/aspeed_ast1700.c
> @@ -0,0 +1,57 @@
> +/*
> + * ASPEED AST1700 IO Expander
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-core.h"
> +#include "qom/object.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/log.h"
> +#include "migration/vmstate.h"

No vmstate ?

> +#include "hw/misc/aspeed_ast1700.h"
> +> +#define AST2700_SOC_LTPI_SIZE        0x01000000
> +static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    /* Occupy memory space for all controllers in AST1700 */
> +    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
> +                       AST2700_SOC_LTPI_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +}
> +
> +static void aspeed_ast1700_instance_init(Object *obj)
> +{
> +    return;
> +}

It's better to introduce a routine when needed.


Thanks,

C.



> +static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = aspeed_ast1700_realize;
> +}
> +
> +static const TypeInfo aspeed_ast1700_info = {
> +    .name          = TYPE_ASPEED_AST1700,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AspeedAST1700SoCState),
> +    .class_init    = aspeed_ast1700_class_init,
> +    .instance_init = aspeed_ast1700_instance_init,
> +};
> +
> +
> +static void aspeed_ast1700_register_types(void)
> +{
> +    type_register_static(&aspeed_ast1700_info);
> +}
> +
> +type_init(aspeed_ast1700_register_types);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 45b16e7797..9477e63cdf 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -133,6 +133,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
>   system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
>   system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
> +  'aspeed_ast1700.c',
>     'aspeed_hace.c',
>     'aspeed_i3c.c',
>     'aspeed_lpc.c',



