Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F7C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 08:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rat9w-00031T-51; Fri, 16 Feb 2024 03:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=8DrN=JZ=kaod.org=clg@ozlabs.org>)
 id 1rat9t-00030U-Cf; Fri, 16 Feb 2024 03:01:21 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=8DrN=JZ=kaod.org=clg@ozlabs.org>)
 id 1rat9r-0008KC-2l; Fri, 16 Feb 2024 03:01:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tbks019crz4wys;
 Fri, 16 Feb 2024 19:01:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tbkrw71Wtz4wcg;
 Fri, 16 Feb 2024 19:01:02 +1100 (AEDT)
Message-ID: <806b512c-aaa1-4284-a18b-6a129cf901d2@kaod.org>
Date: Fri, 16 Feb 2024 09:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] aspeed: introduce a new UART0 device name
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20240215075914.2544262-1-jamin_lin@aspeedtech.com>
 <20240215075914.2544262-2-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240215075914.2544262-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=8DrN=JZ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/15/24 08:59, Jamin Lin wrote:
> The Aspeed datasheet refers to the UART controllers
> as UART1 - UART13 for the ast10x0, ast2600, ast2500
> and ast2400 SoCs and the Aspeed ast2700 introduces an UART0
> and the UART controllers as UART0 - UART12.
> 
> To keep the naming in the QEMU models
> in sync with the datasheet, let's introduce a new  UART0 device name
> and do the required adjustements.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

One comment below,

> ---
>   hw/arm/aspeed.c             | 13 ++++++++-----
>   hw/arm/aspeed_ast10x0.c     |  1 +
>   hw/arm/aspeed_ast2400.c     |  2 ++
>   hw/arm/aspeed_ast2600.c     |  1 +
>   hw/arm/aspeed_soc_common.c  | 10 ++++++----
>   include/hw/arm/aspeed_soc.h | 17 +++++++++++++++++
>   6 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 09b1e823ba..aa165d583b 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -342,7 +342,7 @@ static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>       int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>   
>       aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
> -    for (int i = 1, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
> +    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
>           if (uart == uart_chosen) {
>               continue;
>           }
> @@ -1094,7 +1094,7 @@ static char *aspeed_get_bmc_console(Object *obj, Error **errp)
>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>       int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>   
> -    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 + 1);
> +    return g_strdup_printf("uart%d", aspeed_uart_index(uart_chosen));
>   }
>   
>   static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
> @@ -1103,6 +1103,8 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>       AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
>       int val;
> +    int uart_first = aspeed_uart_first(sc);
> +    int uart_last = aspeed_uart_last(sc);
>   
>       if (sscanf(value, "uart%u", &val) != 1) {
>           error_setg(errp, "Bad value for \"uart\" property");
> @@ -1110,11 +1112,12 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
>       }
>   
>       /* The number of UART depends on the SoC */
> -    if (val < 1 || val > sc->uarts_num) {
> -        error_setg(errp, "\"uart\" should be in range [1 - %d]", sc->uarts_num);
> +    if (val < uart_first || val > uart_last) {
> +        error_setg(errp, "\"uart\" should be in range [%d - %d]",
> +                   uart_first, uart_last);
>           return;
>       }
> -    bmc->uart_chosen = ASPEED_DEV_UART1 + val - 1;
> +    bmc->uart_chosen = val + ASPEED_DEV_UART0;
>   }
>   
>   static void aspeed_machine_class_props_init(ObjectClass *oc)
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index c3b5116a6a..2634e0f654 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -436,6 +436,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
>       sc->wdts_num = 4;
>       sc->macs_num = 1;
>       sc->uarts_num = 13;
> +    sc->uarts_base = ASPEED_DEV_UART1;
>       sc->irqmap = aspeed_soc_ast1030_irqmap;
>       sc->memmap = aspeed_soc_ast1030_memmap;
>       sc->num_cpus = 1;
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index 8829561bb6..95da85fee0 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -523,6 +523,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 2;
>       sc->macs_num     = 2;
>       sc->uarts_num    = 5;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2400_irqmap;
>       sc->memmap       = aspeed_soc_ast2400_memmap;
>       sc->num_cpus     = 1;
> @@ -551,6 +552,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 3;
>       sc->macs_num     = 2;
>       sc->uarts_num    = 5;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2500_irqmap;
>       sc->memmap       = aspeed_soc_ast2500_memmap;
>       sc->num_cpus     = 1;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 4ee32ea99d..f74561ecdc 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -666,6 +666,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 4;
>       sc->macs_num     = 4;
>       sc->uarts_num    = 13;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2600_irqmap;
>       sc->memmap       = aspeed_soc_ast2600_memmap;
>       sc->num_cpus     = 2;
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index 123a0c432c..95d0c0aba9 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -36,7 +36,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       SerialMM *smm;
>   
> -    for (int i = 0, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
> +    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
>           smm = &s->uart[i];
>   
>           /* Chardev property is set by the machine. */
> @@ -58,10 +58,12 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
>   void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
>   {
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> -    int i = dev - ASPEED_DEV_UART1;
> +    int uart_index = aspeed_uart_index(dev);
> +    int uart_first = aspeed_uart_first(sc);
> +    int index = uart_index - uart_first;
>   
> -    g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);

I will change the patch to keep the original assert. No need to resend.

Thanks,

C.



> -    qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
> +    g_assert(index < ARRAY_SIZE(s->uart));
> +    qdev_prop_set_chr(DEVICE(&s->uart[index]), "chardev", chr);
>   }
>   
>   /*
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 9d0af84a8c..e1a023be53 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -140,6 +140,7 @@ struct AspeedSoCClass {
>       int wdts_num;
>       int macs_num;
>       int uarts_num;
> +    int uarts_base;
>       const int *irqmap;
>       const hwaddr *memmap;
>       uint32_t num_cpus;
> @@ -151,6 +152,7 @@ const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
>   enum {
>       ASPEED_DEV_SPI_BOOT,
>       ASPEED_DEV_IOMEM,
> +    ASPEED_DEV_UART0,
>       ASPEED_DEV_UART1,
>       ASPEED_DEV_UART2,
>       ASPEED_DEV_UART3,
> @@ -235,4 +237,19 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
>   void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>                                  unsigned int count, int unit0);
>   
> +static inline int aspeed_uart_index(int uart_dev)
> +{
> +    return uart_dev - ASPEED_DEV_UART0;
> +}
> +
> +static inline int aspeed_uart_first(AspeedSoCClass *sc)
> +{
> +    return aspeed_uart_index(sc->uarts_base);
> +}
> +
> +static inline int aspeed_uart_last(AspeedSoCClass *sc)
> +{
> +    return aspeed_uart_first(sc) + sc->uarts_num - 1;
> +}
> +
>   #endif /* ASPEED_SOC_H */


