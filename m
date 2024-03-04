Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5CCC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhAPt-0001og-TY; Mon, 04 Mar 2024 10:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rhAPr-0001ng-Km; Mon, 04 Mar 2024 10:39:47 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rhAPo-0000Jm-J9; Mon, 04 Mar 2024 10:39:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpNDG1KR9z4wcK;
 Tue,  5 Mar 2024 02:39:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpNDC21JDz4wcJ;
 Tue,  5 Mar 2024 02:39:38 +1100 (AEDT)
Message-ID: <eeda8073-a8bb-4f33-b69d-20dec408e8ed@kaod.org>
Date: Mon, 4 Mar 2024 16:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] aspeed: Add an AST2700 eval board
Content-Language: en-US, fr
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <20240304092934.1953198-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240304092934.1953198-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=daq9=KK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 3/4/24 10:29, Jamin Lin wrote:
> AST2700 CPU is ARM Cortex-A35 which is 64 bits.
> Add TARGET_AARCH64 to build this machine.
> 
> According to the design of ast2700, it has a bootmcu(riscv-32) which
> is used for executing SPL.
> Then, CPUs(cortex-a35) execute u-boot, kernel and rofs.
> 
> Currently, qemu not support emulate two CPU architectures
> at the same machine. Therefore, qemu will only support
> to emulate CPU(cortex-a35) side for ast2700
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 8854581ca8..4544026d14 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -178,6 +178,12 @@ struct AspeedMachineState {
>   #define AST2600_EVB_HW_STRAP1 0x000000C0
>   #define AST2600_EVB_HW_STRAP2 0x00000003
>   
> +#ifdef TARGET_AARCH64
> +/* AST2700 evb hardware value */
> +#define AST2700_EVB_HW_STRAP1 0x000000C0
> +#define AST2700_EVB_HW_STRAP2 0x00000003
> +#endif
> +
>   /* Tacoma hardware value */
>   #define TACOMA_BMC_HW_STRAP1  0x00000000
>   #define TACOMA_BMC_HW_STRAP2  0x00000040
> @@ -1588,6 +1594,26 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> +#ifdef TARGET_AARCH64
> +static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc = "Aspeed AST2700 EVB (Cortex-A35)";
> +    amc->soc_name  = "ast2700-a0";
> +    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
> +    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
> +    amc->fmc_model = "w25q01jvq";
> +    amc->spi_model = "w25q512jv";
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
> +    amc->uart_default = ASPEED_DEV_UART12;
> +    mc->default_ram_size = 1 * GiB;

This seems low. What's the size on real HW  ?

Anyhow,


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +#endif
> +
>   static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
>                                                        void *data)
>   {
> @@ -1711,6 +1737,12 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name           = MACHINE_TYPE_NAME("ast1030-evb"),
>           .parent         = TYPE_ASPEED_MACHINE,
>           .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
> +#ifdef TARGET_AARCH64
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("ast2700-evb"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_ast2700_evb_class_init,
> +#endif
>       }, {
>           .name          = TYPE_ASPEED_MACHINE,
>           .parent        = TYPE_MACHINE,


