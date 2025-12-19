Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC0DD7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 17:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdxp-00066D-Cw; Fri, 19 Dec 2025 12:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdxn-0005zV-EX
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 12:08:23 -0500
Received: from 9.mo548.mail-out.ovh.net ([46.105.48.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdxk-0000wc-7H
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 12:08:23 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.133])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dXvB953FDz6Nqy;
 Fri, 19 Dec 2025 17:08:17 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 19 Dec
 2025 18:08:16 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004055052fd-1800-4411-a424-abdcde4da547,
 13AF5B8175AA3308F51DC8C03696883D036152F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <e1121115-f88e-4864-9dc3-a0c823f6cbbd@kaod.org>
Date: Fri, 19 Dec 2025 18:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 16/18] hw/arm/aspeed: Attach PWM device to
 AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-17-kane_chen@aspeedtech.com>
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
In-Reply-To: <20251208074436.1871180-17-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: cb62aa64-b3f4-4f72-8f91-c6039f920754
X-Ovh-Tracer-Id: 9692027874162871218
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEz6xa6cZCOtsYDru9pNQfx7CbqSXsm71NNe35PK6uYQZEjM8hapjkitWN6aVCV0IeTZQ6RlvWLVr25VGCScVQ3NGHYbPLP1+S5+Yxe7IXKRKayGLhVFcMbFgJ9zkRPCZAzZXhuicSKgE8AJkT6gtKzKwvwerrdLuXwv4gP9CVXl8aXOdsdmBvhgZ0cShoizOaL/MzmhOPLkU4XgwI8nBpsO9bvdfVU6HXfI4B1NPJSuKrksCmawWhOKHRumAA65sFc7cAe+PW8C+oRWvw7wYjHrKFxxLGFr+DM9vt07opJr7ODBDhg9pSIJMZlgSmC9fYoFsfnA3M79ADAWuYE/h71IK3q7zFcyUW9NGw7kvPqhm8Qg7FE7vHNKRm1JPmQ6FHAHxBzpPovrX7JAdRSUGv8TJ09jLFaLob22cVFjPWxWr28ef1HcEP/En1kU4nqD2mq3a5jUk845KB6SBixLZJn3lqgqOc0Cr91NNJRbfkbu8DIUurJyt2awyUPx6kv+IySY/fSZtrnl1M8zcgUbWtCupcAswrbcGfzT2pHwSeX1ZUyayfDldeusfL1EhjjROsm0N3pb12tIdrBAiCStz0h4oTXOLQ4UqTYu5Wh/Ztal+4indHNdhdkKgPKUkm3zJK1aBFWND2STxwbZNBILR/Vuswe0B7+XNLX5uQnSykoSg
DKIM-Signature: a=rsa-sha256; bh=BYdIT2Qi0p+Dwr2k2vN32TTeFfcjvhbBIXlpeeOOJPI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766164097; v=1;
 b=R234KocRVE2NQOJfR+TPQBlN2FyD/vZrv+OlGhQSVxy6ZQLshCr30JStz9Is6mkaKCeiZgt7
 7Zgzim7wri5i8aVyT6pXJTqoeDT7dXbagrw7ATnl/+68gjspyyvqx1N7y2DD89DMwjBcKEM2au5
 qyg6H5cD1XvI28nKj/Jj+xjVExRGl7HbQi/h+a5zu0gyY1GNUGqQjedmhITcKa0eztRtTge/E9I
 fHFgq/98kyVL0TcsU411zmUTf+2fuUP4zyjqN8h1jF4C+S2HZ7aJ9hVXXPxYvxXLFONYOVzmqFp
 jagDwPtBlOr9a6EfasMGVWgznby+KPFmdIDpEj6TZJM4g==
Received-SPF: pass client-ip=46.105.48.137; envelope-from=clg@kaod.org;
 helo=9.mo548.mail-out.ovh.net
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

On 12/8/25 08:44, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Connect the PWM device to AST1700 model.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_ast1700.h |  2 ++
>   hw/arm/aspeed_ast1700.c         | 13 +++++++++++++
>   2 files changed, 15 insertions(+)



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index f43c0c5475..7292719dc2 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -14,6 +14,7 @@
>   #include "hw/gpio/aspeed_gpio.h"
>   #include "hw/i2c/aspeed_i2c.h"
>   #include "hw/misc/aspeed_ltpi.h"
> +#include "hw/misc/aspeed_pwm.h"
>   #include "hw/ssi/aspeed_smc.h"
>   #include "hw/watchdog/wdt_aspeed.h"
>   #include "hw/char/serial-mm.h"
> @@ -39,6 +40,7 @@ struct AspeedAST1700SoCState {
>       AspeedSCUState scu;
>       AspeedGPIOState gpio;
>       AspeedI2CState i2c;
> +    AspeedPWMState pwm;
>       AspeedWDTState wdt[AST1700_WDT_NUM];
>   };
>   
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index 289c65749a..c9d7a97a80 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -18,6 +18,7 @@
>   
>   enum {
>       ASPEED_AST1700_DEV_SPI0,
> +    ASPEED_AST1700_DEV_PWM,
>       ASPEED_AST1700_DEV_SRAM,
>       ASPEED_AST1700_DEV_ADC,
>       ASPEED_AST1700_DEV_SCU,
> @@ -31,6 +32,7 @@ enum {
>   
>   static const hwaddr aspeed_ast1700_io_memmap[] = {
>       [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
> +    [ASPEED_AST1700_DEV_PWM]       =  0x000C0000,
>       [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
>       [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
>       [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
> @@ -124,6 +126,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                           aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I2C],
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), 0));
>   
> +    /* PWM */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pwm), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_PWM],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pwm), 0));
> +
>       /* LTPI controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>           return;
> @@ -177,6 +187,9 @@ static void aspeed_ast1700_instance_init(Object *obj)
>       object_initialize_child(obj, "ioexp-i2c[*]", &s->i2c,
>                               "aspeed.i2c-ast2700");
>   
> +    /* PWM */
> +    object_initialize_child(obj, "pwm", &s->pwm, TYPE_ASPEED_PWM);
> +
>       /* LTPI controller */
>       object_initialize_child(obj, "ltpi-ctrl",
>                               &s->ltpi, TYPE_ASPEED_LTPI);


