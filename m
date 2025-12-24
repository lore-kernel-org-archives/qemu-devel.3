Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04976E7544F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 10:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMG5-00040W-En; Wed, 24 Dec 2025 05:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMG4-000405-3O
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:38:20 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMG2-0005bv-4Q
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:38:19 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.104])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dbpHp1694z5xDL;
 Wed, 24 Dec 2025 10:38:13 +0000 (UTC)
Received: from DAG3EX1.mxp5.local (172.16.2.21) by DAG6EX2.mxp5.local
 (172.16.2.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:38:13 +0100
Received: from kaod.org (37.59.142.108) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:38:12 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0026cd567fb-824c-43fe-9be6-044cd43ad859,
 9377EA31308664D21D54FC0151EBFE1D7AAB8817) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <588006d4-f157-4272-9267-9bb71dd9c00b@kaod.org>
Date: Wed, 24 Dec 2025 11:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] hw/arm/aspeed: Add AST1700 LTPI expander device
 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-5-kane_chen@aspeedtech.com>
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
In-Reply-To: <20251224014203.756264-5-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: ff3bc73b-7d55-41aa-b6bd-23ccba4cb3fa
X-Ovh-Tracer-Id: 14021113016163339253
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFavCbvqjk+JbRyW293gNKwYfx3cwb8AZgurNFN4bvmmy20EZpiMjDY81Vf04xhXqoxgQOn3Mi5QaVKaBDU3nXPZD7ZnPfTId4EEvmt4IV082cVKja231O3mZslvkUfu4FFJcFut6DYoZCU5u0KTc+X/Q88ojq83iwmHZHQ9sp/AHw9rEkRf8gmIOoVwDMbkXSvyEuQ17bO8k/7Vq6issAwFIQWsMQqDOJpE+FBxvY8bkFlNo+lh5w0w+Kk2h0mgWJue1dnuymKUq937QpwwIhs3mxI91yW+AtU9+iC8FgruDo3tdzVwqOCv04tkLgRglGkcy8ooVUfe5NKuzrEAjJioWAbWwlyz4fhigCSodOVdVpgrZerr/qGL1msN3WalGykbVHuKiwXKihrvkrhr21VdipJpb4XUJ081H/wHUt9bC68apEklCWR56/wwjTvzfHTFpb3AH4kanqxlEmczvLQ6CeOPzAmPYHFlGdknSr3wk1L6Z9tBox23OVRHFdNXgVJP+CsIa5z02Q5altls15Ai/Iaw7vInyPcZvqU84KV/cUbLeLT4SF2nTY2lOOqCyTm+08m+pO0aH2Xap20pLKCMXe0Ld8VW7EUwKoOSegLz3vxF2BWsDKhC9XqQ8nt9t3fiADax8StGcSCGkL0Vwsnuf/RxUO8ZQjqqaftE764PA
DKIM-Signature: a=rsa-sha256; bh=kaA66pEY+4XXnF6Mo33zXOHeRLpILhfnXFxr0Fv+BUQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766572695; v=1;
 b=AaBxDFtRN8gv1FnXgmd9oKCKQiSle6n851JWhax4jki68LP40SLnVCpcx7Ve3eYngiOBySny
 WLw3XOhPz5fQV/CNX7jLCKEoAADtZRHVobo5ZKyRtTCfY90An1sHrMaRH09Y7ctv81t3aoULNik
 6Z6jiQ765QkJnu1z+06ZaJMMSLRyYK4K9ISwR6VtbwUZT0hsh+Ja5ZxTfuZeAeZHXcrQwfBA2DW
 qNeEXcjRfwIozT6R6YsJr7JYhYDlXID0QNCnbcudp0t2V4MW6kXp2BIg127JDuKqr6F/rtZPxqO
 a9ftL21Pe6W3BlDj1uHc9mUHfMQmJkXKNZqhJgsSzJkHQ==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/24/25 02:41, Kane Chen via wrote:
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_ast1700.h | 23 ++++++++++++++++
>   hw/arm/aspeed_ast1700.c         | 47 +++++++++++++++++++++++++++++++++
>   hw/arm/meson.build              |  1 +
>   3 files changed, 71 insertions(+)
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
> index 0000000000..bb6ca2ce9e
> --- /dev/null
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -0,0 +1,47 @@
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
> +};
> +
> +static void aspeed_ast1700_register_types(void)
> +{
> +    type_register_static(&aspeed_ast1700_info);
> +}
> +
> +type_init(aspeed_ast1700_register_types);
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index aeaf654790..175942263d 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -70,6 +70,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast10x0_evb.c',
>     'fby35.c'))
>   arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
> +  'aspeed_ast1700.c',
>     'aspeed_ast27x0.c',
>     'aspeed_ast27x0_evb.c',
>     'aspeed_ast27x0-fc.c',


