Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE10CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3TLG-0008AK-BN; Tue, 30 Sep 2025 01:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TLC-00089b-Mi
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:55:59 -0400
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TL5-0003nx-9H
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:55:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.52])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4cbS343fD5z5ybj;
 Tue, 30 Sep 2025 05:55:44 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 07:55:43 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006769c88b4-5ec2-4ba6-a8aa-bce0c466b76d,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <dbea5c97-071e-4d7c-a022-8cd5d9cf6171@kaod.org>
Date: Tue, 30 Sep 2025 07:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Add Supermicro X11 SPI machine type
To: Guenter Roeck <linux@roeck-us.net>
CC: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
References: <20221025165109.1226001-1-linux@roeck-us.net>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20221025165109.1226001-1-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 5fa9478f-4d0b-4213-bff6-a6ceca42dd6b
X-Ovh-Tracer-Id: 8133500929976339238
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFP0lZMU762VLmzYOc9+eYd/t/xn+R9+O25J2TQXkFFUVmIOVtNNQXYLiYI5HIXphpeMf8kxBcxJvIcqK3FtT1iNOsklIWkBzNflys3Oy3TsDF1F3xgsQ0fs2LxQ+iNw2LaE9F8CMlsJ6LzgpBozw96Az87NAsMF6mhjkBX0NhVEb/Yb4s1WsVmFT+EIOBEsEjtIAGnlEv/A/Mq/dSQy9Ger8/7Nf0DmQAa3gnoWbdaP75yYPhh1lBIuOnYYOj9f0UmctIqkfdizFhO7IFcCaO3s++WV6eDGDN8w5jIfcQCXkazdqku7iSI34es4BjsOQVlBdczPVv2wzBL5iTsH9FAgoZ0ZrqbwjXwcr9m8uVkNVm1avtSrrA3m12gu6wcLTybVNWpPRc4Y5wGKyRagEv0AxOSeBJJ4Rgpt82jcRGGObBunBK/sAgEZRuW/YNCqd2vjznzKEqX1C/RI2cku4HhZNi6dptwXv5DxwkOYaJo/WExypg2CDMOO+tMNF4gZidytcAMfnEZh8IZuDe0ZXIIlnLDjRro7vjA2tdg4r1qWz+mYOTtvqQMSYxAiE4H8hyVbBDs3xx6aGmB1kETCmINNhBILOMCCE3o/aYmXofF1OE8WFpd7mS1r+MBRO+W6qtUWgwaErZNweDOOcGLipjN/ot5cQ4El3OwenyxEBkxeQ
DKIM-Signature: a=rsa-sha256; bh=qIjdsBWQR74vlUha8sSzNUkJmoK/Kdk3CTp7vgo3VjM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759211745; v=1;
 b=pAOCbWT+PrI1sllYn6BChp+Edktir05FJ/IUi+pvLQTPiI55bEdNIBNrjkgDX3Y0OnHK68KE
 oSlY7O65ar+cy9Pd6pDUI6E/iqFvx4nHXm7DLvmuWeBXtb3oUAoy4ELOUi4WkixtrqFpwvFVcYF
 LFATaPdoisJYqJAU85c0kU4pVA/vw0ng+g8po5DlvDiQvU3mqh8w5KBYnWjfcXenx73mADplXAc
 ywNVrqOuFaHZepYV5dYhHWS19eX5/Pyl2j/au2zmYriH4sCXODI2wq9tc4Gc8nyadzaINp6BSES
 bowMxTgU2jsP8my4+uohY9LqKHW013jAnnQ49IupuoUig==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/22 18:51, Guenter Roeck wrote:
> supermicrox11-bmc is configured with ast2400-a1 SoC. This does not match
> the Supermicro documentation for X11 BMCs, and it does not match the
> devicetree file in the Linux kernel.
> 
> As it turns out, some Supermicro X11 motherboards use AST2400 SoCs,
> while others use AST2500.
> 
> Introduce new machine type supermicrox11-spi-bmc with AST2500 SoC
> to match the devicetree description in the Linux kernel. Hardware
> configuration details for this machine type are guesswork and taken
> from defaults as well as from the Linux kernel devicetree file.
> 
> The new machine type was tested with aspeed-bmc-supermicro-x11spi.dts
> from the Linux kernel and with Linux versions 6.0.3 and 6.1-rc2.
> Linux booted successfully from initrd and from both SPI interfaces.
> Ethernet interfaces were confirmed to be operational.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Hello Guenter

Would it be possible to contribute a functional test for this
machine ?

Since this machine contributes little to the Aspeed models,
its value lies in the firmware it can run to exercise the
models. Without functional tests, I plan to schedule the
removal in the QEMU 10.2 cycle.


Thanks,

C.



> ---
>   hw/arm/aspeed.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index c282ead38f..56d007de5a 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -71,6 +71,16 @@ struct AspeedMachineState {
>           SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
>           SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
>   
> +/* TODO: Find the actual hardware value */
> +#define SUPERMICROX11_SPI_BMC_HW_STRAP1 (                               \
> +        AST2500_HW_STRAP1_DEFAULTS |                                    \
> +        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
> +        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
> +        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
> +        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
> +        SCU_HW_STRAP_SPI_WIDTH |                                        \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN))
> +
>   /* AST2500 evb hardware value: 0xF100C2E6 */
>   #define AST2500_EVB_HW_STRAP1 ((                                        \
>           AST2500_HW_STRAP1_DEFAULTS |                                    \
> @@ -1172,6 +1182,25 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
>       mc->default_ram_size = 256 * MiB;
>   }
>   
> +static void aspeed_machine_supermicrox11_spi_bmc_class_init(ObjectClass *oc,
> +                                                            void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Supermicro X11 SPI BMC (ARM1176)";
> +    amc->soc_name  = "ast2500-a1";
> +    amc->hw_strap1 = SUPERMICROX11_SPI_BMC_HW_STRAP1;
> +    amc->fmc_model = "mx25l25635e";
> +    amc->spi_model = "mx25l25635e";
> +    amc->num_cs    = 1;
> +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
> +    amc->i2c_init  = palmetto_bmc_i2c_init;
> +    mc->default_ram_size = 512 * MiB;
> +    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> +        aspeed_soc_num_cpus(amc->soc_name);
> +}
> +
>   static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1546,6 +1575,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("supermicrox11-spi-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_supermicrox11_spi_bmc_class_init,
>       }, {
>           .name          = MACHINE_TYPE_NAME("ast2500-evb"),
>           .parent        = TYPE_ASPEED_MACHINE,


