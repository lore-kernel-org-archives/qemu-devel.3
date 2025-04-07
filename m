Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DD0C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oHD-00024F-25; Mon, 07 Apr 2025 11:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CcIW=WZ=kaod.org=clg@ozlabs.org>)
 id 1u1oEX-0006nt-MH; Mon, 07 Apr 2025 11:18:03 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CcIW=WZ=kaod.org=clg@ozlabs.org>)
 id 1u1oEL-0006LA-Uq; Mon, 07 Apr 2025 11:17:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZWXrk1hH4z4wnp;
 Tue,  8 Apr 2025 01:17:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZWXrf4vrwz4wcZ;
 Tue,  8 Apr 2025 01:17:38 +1000 (AEST)
Message-ID: <58cd05b7-65a1-469a-9497-76e414bdcb4a@kaod.org>
Date: Mon, 7 Apr 2025 17:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1 SSP
 SoC
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
 <20250313054020.2583556-7-steven_lee@aspeedtech.com>
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
In-Reply-To: <20250313054020.2583556-7-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=CcIW=WZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/13/25 06:40, Steven Lee wrote:
> The AST2700 SSP (Secondary Service Processor) is a Cortex-M4 coprocessor.
> This patch adds support for A1 SSP with the following updates:
> 
> - Defined IRQ maps for AST27x0 A1 SSP SoC
> - Implemented initialization functions
> 
> The IRQ mapping is similar to AST2700 CA35 SoC, featuring a two-level
> interrupt controller.
> 
> Difference from AST2700:
> 
>      - AST2700
>        - Support GICINT128 to GICINT136 in INTC
>        - The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
>            Bit 0 -> GIC 192
>            Bit 1 -> GIC 193
>            Bit 2 -> GIC 194
>            Bit 3 -> GIC 195
>            Bit 4 -> GIC 196
> 
>      - AST2700-ssp
>        - Support SSPINT128 to SSPINT136 in INTC
>        - The INTCIO SSPINT_160_169 has 10 output pins, mapped as follows:
>            Bit 0 -> SSPINT 160
>            Bit 1 -> SSPINT 161
>            Bit 2 -> SSPINT 162
>            Bit 3 -> SSPINT 163
>            Bit 4 -> SSPINT 164
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: Ic5121dd78c5dacf1ec4b4e791cc7bf476a8b608f
> ---
>   hw/arm/aspeed_ast27x0-ssp.c | 91 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 88f27b9459..5553190a62 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -60,6 +60,24 @@ static const int aspeed_soc_ast27x0a0ssp_irqmap[] = {
>       [ASPEED_DEV_TIMER1]    = 16,
>   };
>   
> +static const int aspeed_soc_ast27x0a1ssp_irqmap[] = {
> +    [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_UART0]     = 164,
> +    [ASPEED_DEV_UART1]     = 164,
> +    [ASPEED_DEV_UART2]     = 164,
> +    [ASPEED_DEV_UART3]     = 164,
> +    [ASPEED_DEV_UART4]     = 8,
> +    [ASPEED_DEV_UART5]     = 164,
> +    [ASPEED_DEV_UART6]     = 164,
> +    [ASPEED_DEV_UART7]     = 164,
> +    [ASPEED_DEV_UART8]     = 164,
> +    [ASPEED_DEV_UART9]     = 164,
> +    [ASPEED_DEV_UART10]    = 164,
> +    [ASPEED_DEV_UART11]    = 164,
> +    [ASPEED_DEV_UART12]    = 164,
> +    [ASPEED_DEV_TIMER1]    = 16,
> +};
> +
>   /* SSPINT 164 */
>   static const int ast2700_ssp132_ssp164_intcmap[] = {
>       [ASPEED_DEV_UART0]     = 7,
> @@ -167,6 +185,46 @@ static void aspeed_soc_ast27x0a0ssp_init(Object *obj)
>                               TYPE_UNIMPLEMENTED_DEVICE);
>   }
>   
> +static void aspeed_soc_ast27x0a1ssp_init(Object *obj)
> +{
> +    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(obj);
> +    AspeedSoCState *s = ASPEED_SOC(obj);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    char socname[8];
> +    char typename[64];
> +    int i;
> +
> +    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
> +        g_assert_not_reached();
> +    }
> +
> +    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
> +
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +
> +    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
> +    object_initialize_child(obj, "scu", &s->scu, typename);
> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
> +
> +    for (i = 0; i < sc->uarts_num; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
> +    }
> +
> +    object_initialize_child(obj, "intc0", &a->intc[0],
> +                            TYPE_ASPEED_2700SSP_INTC);
> +    object_initialize_child(obj, "intc1", &a->intc[1],
> +                            TYPE_ASPEED_2700SSP_INTCIO);
> +
> +    object_initialize_child(obj, "timerctrl", &s->timerctrl,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc0", &a->ipc[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc1", &a->ipc[1],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "scuio", &a->scuio,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +}
> +
>   static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>   {
>       Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(dev_soc);
> @@ -292,6 +350,34 @@ static void aspeed_soc_ast27x0a0ssp_class_init(ObjectClass *klass, void *data)
>       sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
>   }
>   
> +static void aspeed_soc_ast27x0a1ssp_class_init(ObjectClass *klass, void *data)
> +{
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO: cortex-m4f */
> +        NULL
> +    };
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
> +
> +    /* Reason: The Aspeed SoC can only be instantiated from a board */
> +    dc->user_creatable = false;
> +    dc->realize = aspeed_soc_ast27x0ssp_realize;
> +
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev = AST2700_A1_SILICON_REV;
> +    sc->sram_size = AST2700_SSP_RAM_SIZE;
> +    sc->spis_num = 0;
> +    sc->ehcis_num = 0;
> +    sc->wdts_num = 0;
> +    sc->macs_num = 0;
> +    sc->uarts_num = 13;
> +    sc->uarts_base = ASPEED_DEV_UART0;
> +    sc->irqmap = aspeed_soc_ast27x0a1ssp_irqmap;
> +    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
> +    sc->num_cpus = 1;
> +    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
> +}
> +
>   static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
>       {
>           .name           = TYPE_ASPEED27X0SSP_SOC,
> @@ -303,6 +389,11 @@ static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
>           .parent         = TYPE_ASPEED27X0SSP_SOC,
>           .instance_init  = aspeed_soc_ast27x0a0ssp_init,
>           .class_init     = aspeed_soc_ast27x0a0ssp_class_init,
> +    }, {
> +        .name           = "ast2700ssp-a1",
> +        .parent         = TYPE_ASPEED27X0SSP_SOC,

I see you are relying the A0 definitions.

So what's so important in A0 ?


Thanks,

C.


> +        .instance_init  = aspeed_soc_ast27x0a1ssp_init,
> +        .class_init     = aspeed_soc_ast27x0a1ssp_class_init,
>       },
>   };
>   


