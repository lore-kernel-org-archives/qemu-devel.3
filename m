Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D41CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6Ij-0003cs-SL; Mon, 01 Jun 2026 13:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU6Id-0003aB-Uo; Mon, 01 Jun 2026 13:19:39 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU6Ib-0002hp-BN; Mon, 01 Jun 2026 13:19:39 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gTggP6pVlz4CJ3;
 Mon,  1 Jun 2026 17:19:29 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:19:29 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.137])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTggP47Drz7vQd; Mon,  1 Jun 2026 17:19:29 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id EB33C203041; 
 Mon,  1 Jun 2026 17:19:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00101c704de-8256-4b8e-94e1-7083206a8c59,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3e22bece-b6b5-4980-9d20-d38c6685361a@kaod.org>
Date: Mon, 1 Jun 2026 19:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] hw/arm/aspeed_ast27x0: Add unimplemented
 Privilege Controller MMIO regions for SSP/TSP
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-13-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13772289136505760907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG11xkYjVc7pQ60C4X1ARPNSR7czKXT9p5cn/Wl47NcnaLYjmQ0sJleCnDEkzILpt+51H+z8nEQyYie+WIQDHUUaH8vO3ZyjUVJbH9NPmqon+b+IEwi8U7XM8MpTaUlf25NrcB28mcLjlnzsdFregVxhhcaFjwkdSgWIsn9hOrXKFe//sMxr5srWqMa4MfX23z/U6zN7756WTAp6MyFeoHx4MB+t6+luLf8D/q0xPS5BTkoK+JwEpidoBAk2+qEuE/+GbgD8dreWx3jHPNf0/40yxCbePNcMH7pNwCRYIUyq1/QHsJht01NlYO8RC0DyEJcdflqGhdjcvOgP4+FYuTkE6PZ/NLjyC1trx+mnGZaIpF0/jeBuM6a0CrTmvVkg6PTzSKrzzY8UI3LTQTKXoJkSd2B+E03asNSaxnE0mTzvHGyUlWWh0UJ1pOnKivTcfmUGsAa9UZ9TDaKkip4HvkseIL/Yt87cewfwvl3nnFGHhJvUDywuxd9JXeTaKLYrJYVHi6wpKCwkS7AlxG55UTrrwwAUjjKERQke3EHzQm4g7Qd8y042+04dNvkL3yrlER4Ntxmd5kj3pevRLoYupNTt+GEM33EIHXSUukk7781S+6GXKiKLWPjFoSo7bzaau32F9HNgKjaQ0nBNYznLn6MKOXDW5lI6kU4PrCixO5A1w
DKIM-Signature: a=rsa-sha256; bh=riw5ThzDCG0mKZTh0uiSKclEKbq+bekWYIMjpV3cFR0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780334370; v=1;
 b=js6w5wzaA6dwfDm4qZlahCmHbt3zVmwUZYZcKqSLSO3uD9TFkNpdM0fNWUtD8DdvOGgUth53
 kYaigIZY0n/8X04P91jhmEguzXQgp6sGFlq2/n6PKSx9dm5P2oV0QvlxZnx2AfIIRw3DWe+nGUS
 LOWQy+7mtKiK/GeQXKq+006hHBVZgaMk3ykmAnS3VoA3AmsXjWaCzeoZjaJmUIXKjHYoUvB/1BE
 uK3QD+2C4sT9wIdff9+N4YzyyhvyRNhuktxik2YMdwlnBzcRz2liqACaS5Dwx2O+XnyA61XTbjG
 5VbKWu9buv26qw4oN8zD7seEcDdwkQ7tXWkO7Vnc6ajIA==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/17/26 05:28, Jamin Lin wrote:
> The AST2700 SSP/TSP firmware accesses Privilege Controller MMIO regions that
> are not yet implemented in QEMU.
> 
> This change adds unimplemented MMIO devices for the Privilege Controller
> blocks and maps them to their corresponding physical addresses in the SSP/TSP
> address space. These stub devices allow QEMU to safely handle firmware
> accesses and prevent spurious exceptions, while accurately reflecting
> the hardware memory map.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  1 +
>   include/hw/arm/aspeed_soc.h         |  2 ++
>   hw/arm/aspeed_ast27x0-ssp.c         | 12 ++++++++++++
>   hw/arm/aspeed_ast27x0-tsp.c         | 12 ++++++++++++
>   4 files changed, 27 insertions(+)

please send first.

Thanks,

C.

> 
> diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
> index 2460a11401..084040bbed 100644
> --- a/include/hw/arm/aspeed_coprocessor.h
> +++ b/include/hw/arm/aspeed_coprocessor.h
> @@ -46,6 +46,7 @@ struct Aspeed27x0CoprocessorState {
>       AspeedINTCState intc[2];
>       UnimplementedDeviceState ipc[2];
>       UnimplementedDeviceState scuio;
> +    UnimplementedDeviceState pric[2];
>   
>       ARMv7MState armv7m;
>   
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index adf2f2898a..d39e4f7553 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -297,6 +297,8 @@ enum {
>       ASPEED_DEV_IOEXP1_INTCIO,
>       ASPEED_DEV_IOEXP0_I3C,
>       ASPEED_DEV_IOEXP1_I3C,
> +    ASPEED_DEV_PRIC0,
> +    ASPEED_DEV_PRIC1,
>   };
>   
>   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index bfd6fe4485..467fdea9db 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -22,11 +22,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
>       [ASPEED_DEV_SDRAM]     =  0x00000000,
>       [ASPEED_DEV_SRAM]      =  0x70000000,
>       [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_PRIC0]     =  0x72140000,
>       [ASPEED_DEV_SCU]       =  0x72C02000,
>       [ASPEED_DEV_TIMER1]    =  0x72C10000,
>       [ASPEED_DEV_UART4]     =  0x72C1A000,
>       [ASPEED_DEV_IPC0]      =  0x72C1C000,
>       [ASPEED_DEV_FMC]       =  0x74000000,
> +    [ASPEED_DEV_PRIC1]     =  0x74100000,
>       [ASPEED_DEV_SCUIO]     =  0x74C02000,
>       [ASPEED_DEV_INTCIO]    =  0x74C18000,
>       [ASPEED_DEV_UART0]     =  0x74C33000,
> @@ -142,6 +144,10 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "scuio", &a->scuio,
>                               TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "pric0", &a->pric[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "pric1", &a->pric[1],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
>   }
>   
>   static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
> @@ -276,6 +282,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
>                                     "aspeed.scuio",
>                                     sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
> +                                  "aspeed.pric0",
> +                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),
> +                                  "aspeed.pric1",
> +                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);
>   }
>   
>   static const Property aspeed_27x0_coprocessor_properties[] = {
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index 166dcb14ed..3a90bbec51 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -22,11 +22,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
>       [ASPEED_DEV_SDRAM]     =  0x00000000,
>       [ASPEED_DEV_SRAM]      =  0x70000000,
>       [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_PRIC0]     =  0x72140000,
>       [ASPEED_DEV_SCU]       =  0x72C02000,
>       [ASPEED_DEV_TIMER1]    =  0x72C10000,
>       [ASPEED_DEV_UART4]     =  0x72C1A000,
>       [ASPEED_DEV_IPC0]      =  0x72C1C000,
>       [ASPEED_DEV_FMC]       =  0x74000000,
> +    [ASPEED_DEV_PRIC1]     =  0x74100000,
>       [ASPEED_DEV_SCUIO]     =  0x74C02000,
>       [ASPEED_DEV_INTCIO]    =  0x74C18000,
>       [ASPEED_DEV_UART0]     =  0x74C33000,
> @@ -142,6 +144,10 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "scuio", &a->scuio,
>                               TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "pric0", &a->pric[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "pric1", &a->pric[1],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
>   }
>   
>   static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
> @@ -273,6 +279,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
>                                     "aspeed.scuio",
>                                     sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
> +                                  "aspeed.pric0",
> +                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
> +    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),
> +                                  "aspeed.pric1",
> +                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);
>   }
>   
>   static const Property aspeed_27x0_coprocessor_properties[] = {


