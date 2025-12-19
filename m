Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FA9D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 17:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdqo-0006w1-30; Fri, 19 Dec 2025 12:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdqI-0006p8-In
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 12:00:54 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdqF-0005xP-UG
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 12:00:37 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.221])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dXv1D4RpDz5yVc;
 Fri, 19 Dec 2025 17:00:32 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 19 Dec
 2025 18:00:31 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006159f4e62-3776-43f7-92a6-cd0f202b2448,
 13AF5B8175AA3308F51DC8C03696883D036152F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d21521e6-3480-47bf-8f42-94263a2bb778@kaod.org>
Date: Fri, 19 Dec 2025 18:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 04/18] hw/arm/aspeed: Add AST1700 LTPI expander
 device model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-5-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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
In-Reply-To: <20251208074436.1871180-5-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 21e3e032-1e87-4296-8208-d97002b06a39
X-Ovh-Tracer-Id: 9561142009283972018
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFoSOFGXpaS3yJcBK5bAAyljIu1s3Z/lfCx0CEyweADxTp9dA6tGAFl9hubw3SjyoeLB3mSUO+98OsPIG7ZCJKGtIdHsVlJTeZxJZUBfLGttWXL94WDeAxqaCXWm9satK227gPr1/zuj6K+V6VdNY0plGat5d+IrrowdLFGQy2rBq3hoCwVYcs2va0pMbWXW8sNbbCzCJae/vK2BjsM/c4BJYKHQNFLp9r3CJwZcP6pe7zN7Gi/iHs01FmzmzzNJfuRX8AN4U3+/+GXDo3jYLvBxsTW2/x15IWPKvlI6MK6hPJ/uztLkiGvxWcNJceQaZhxrB1X0h+XgWW5balDI7dhKxN/mUeZO6IMPTAq+p95+a4t46e5NtPxMH+B370Us7dW/pXOpGgaOvIi06ukBGIPXkFnECll/3yyapTFOrbal8Ohie1RB4fed2zNpxA16najyOdeIcp3iP5QOZhLECLgfnV6+QH1MVCjs3dFJNKMY4n2SLs50JsqjNOOHqcWYzvunMntZwxtExAnxogoFpjnTu3nWY9oO4WdxnYB7rF7OX7fjNbEcy1Ezr0P8o8mRwaxu8s4hJhX7BrWl9e+pakBryMlgVDHkplP9dXQIhP/OhSYh55pD4WRu7c76zuadxZtYnnylHzTmMJu2s0fteOnWXLDA9VdtbyVX2CpUvjt+g
DKIM-Signature: a=rsa-sha256; bh=MTAv27IAKjRJ3xAGS1q5ugWjij6xX9tkzK3TjvME/MY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766163632; v=1;
 b=QbiMSuw8SDn1ynG2Uc1WSYPbNU447bxLxTiJbDGLXVKMFxRtjUPtKvRetnBKNAYQbHjHg9Sw
 buq4OWHSwU2zatOSyqHUjPU02OM+1RHIlqWSTafAgGjz1b522knVByaiMbL5GnNgUwn1jNG4Tq4
 9qe6BtYgHvecHOCdOA7svnWkzQZZN8lJxsG3iKvOr6sOKhPAfKDG+OPRaOnbcGIQyUrNaYdGA1j
 jJn99IanEkLqWxyAATJxE3KZ94hj8uvnm5KkmM/Se8wraaT89dJbbaqfOVASpNYkebmI9QoC6RM
 eVabcR1o1W1hXnQnNehoWi+zSnRU+aHfQXk7lQuFE9KKw==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/8/25 08:44, Kane Chen wrote:
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
>   include/hw/arm/aspeed_ast1700.h | 23 ++++++++++++++++
>   hw/arm/aspeed_ast1700.c         | 48 +++++++++++++++++++++++++++++++++
>   hw/arm/meson.build              |  1 +
>   3 files changed, 72 insertions(+)
>   create mode 100644 include/hw/arm/aspeed_ast1700.h
>   create mode 100644 hw/arm/aspeed_ast1700.c
> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> new file mode 100644
> index 0000000000..2a95ebfe89
> --- /dev/null
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -0,0 +1,23 @@
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
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> new file mode 100644
> index 0000000000..f564b9b242
> --- /dev/null
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -0,0 +1,48 @@
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
> +#include "hw/arm/aspeed_ast1700.h"
> +
> +#define AST2700_SOC_LTPI_SIZE        0x01000000
> +
> +static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    /* Occupy memory space for all controllers in AST1700 */
> +    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
> +                       AST2700_SOC_LTPI_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
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
> +    .abstract      = false,

You can drop the .abstract assignment.


> +};
> +
> +static void aspeed_ast1700_register_types(void)
> +{
> +    type_register_static(&aspeed_ast1700_info);
> +}
> +
> +type_init(aspeed_ast1700_register_types);
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index aeaf654790..ee26a05dc9 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -42,6 +42,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
>   arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed.c',
> +  'aspeed_ast1700.c',

This should be under TARGET_AARCH64 ? right ?

Thanks,

C.

>     'aspeed_soc_common.c',
>     'aspeed_ast2400.c',
>     'aspeed_ast2400_palmetto.c',


