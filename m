Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660EECAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3TGx-0006dJ-MG; Tue, 30 Sep 2025 01:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TGt-0006d4-Ub
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:51:31 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3TGp-0003LV-In
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:51:31 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.85])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cbRxx1gcHz5xkl;
 Tue, 30 Sep 2025 05:51:17 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 07:51:16 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001abb24051-7f39-41f6-b498-32577c69948a,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0165086d-3ab4-4986-84ff-452984d16153@kaod.org>
Date: Tue, 30 Sep 2025 07:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
To: Patrick Williams <patrick@stwcx.xyz>
CC: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Amithash Prasad <amithash@fb.com>, "open list:All patches
 CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley
 <joel@jms.id.au>, Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>, Peter
 Delevoryas <pdel@fb.com>
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
 <20200506183219.2166987-1-patrick@stwcx.xyz>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20200506183219.2166987-1-patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: c77987f1-7f25-433f-b2ec-df6345588912
X-Ovh-Tracer-Id: 8058347112511343538
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGVz4ws4F7kIHG9MG+GSpUno1zsDoUS41ln38iS9OOUK0TwMl20OepYaG8Ru3AwdG0ROEc/8Wy0p8HXR0/DTgC7pqIg7h6JDG9U7LDWtyUH4MMp2Rv8onrHOJ7UV7T4yDeM7TmyOOFAdpYEH+IEQ1B8SvQX7mzxchU3FIwCFNtlt6UKaKLf0Czum4rD58O/Bl/QqQpz67Ljsk+3BaNw3vDTgI+WeE1O+6+Sgn03SkZaLenOAbyp8YkHQt+N8RdJYOegD6uvRgZVYm4zYkx0oWCPOw0bfOxd+bzLPm5KPkdCnF1UGu0Krd6jLUmUpqBiEf1k+gbHHazvPeqUIrPEpu6RBp0Y+0VkH5rL3LLj10BGauCGpXenVrzSfrs7C8xYi9uW0+rES/julOqcGuzIJHC9ZMukJcPQbP/9eb6KHIPiExhbPENo6rE0irWuCaWponxUBxL5Th3Kya1MqXlaaIP4WIHiVKDXcTf+plkFtQBLdLtLKJJcMO4kIBzL0tcPDxg4PqquYZZHPosM27YvgxrV6zMlFtrA6BUpe3aPz2I5dNXa4JIVSQ2NZ8vA9l3zXkgIDI/mxROR+RuZFGneSQFyfV74Jvz96o1VbpKbFhlpbKn1MTN+rBCcraiEP3Jd6vbSPUB/cmHbhT1ZC35TmYbt8t5vcuyHi07DAsSj/RbHDg
DKIM-Signature: a=rsa-sha256; bh=yDUqoOiiy7Hj28q6Be/E3953fSQB5+FS8wBOX/T2QYM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759211478; v=1;
 b=VjVt/50QEq2RiaSmOE5Tpp2DnwXa/YYvYsSrhk9/vVapWdqWxq6DaaL16s1TsJky7ZSRRyl3
 72I9QL3YboY/uSaYpgn3oylC3kkiuQf1LcpG/mTcApONcS08Zbphv59osv7pfLwGyp9KjmX/YkQ
 xqmXIt7wtuq4zRFRpVBJ3ItHZq/jZjUEoaJGKNg0ISNafbEyAcUbtuj9OL77Xgl9k0zuWlyxvzG
 ghQr9DMWucHMKF491ZSv4FV9rFpR8NPZP+A9uOuVaKeqmozo1q8Dkgzrw1kcPEg9CGJ38xUJIHl
 perFA4W9pg42oEcl5N44vdVuemp56Hgr43xBSauXeA0Ow==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Patrick

On 5/6/20 20:32, Patrick Williams wrote:
> Sonora Pass is a 2 socket x86 motherboard designed by Facebook
> and supported by OpenBMC.  Strapping configuration was obtained
> from hardware and i2c configuration is based on dts found at:
> 
> https://github.com/facebook/openbmc-linux/blob/1633c87b8ba7c162095787c988979b748ba65dc8/arch/arm/boot/dts/aspeed-bmc-facebook-sonorapass.dts
> 
> Booted a test image of http://github.com/facebook/openbmc to login
> prompt.
> 
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> Reviewed-by: Amithash Prasad <amithash@fb.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)


Would it be possible to contribute a functional test for this
machine ?

The request applies to these Facebook machines :

   sonorapass-bmc
   yosemitev2-bmc
   tiogapass-bmc
   fuji-bmc
   fby35-bmc

Since these machines contribute little to the Aspeed models,
their value lies in the firmware they can run to exercise the
models. Without functional tests, I plan to schedule their
removal in the QEMU 10.2 cycle.

The fby35-bmc value is in its multisoc nature. We now have the
ast2700fc available as its replacement

Thanks,

C.

> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 6f4d7075c4..74c46681e8 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -74,6 +74,21 @@ struct AspeedBoardState {
>           SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
>           SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
>   
> +/* Sonorapass hardware value: 0xF100D216 */
> +#define SONORAPASS_BMC_HW_STRAP1 (                                      \
> +        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
> +        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
> +        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
> +        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
> +        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
> +        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
> +        SCU_HW_STRAP_VGA_BIOS_ROM |                                     \
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
> +        SCU_AST2500_HW_STRAP_RESERVED1)
> +
>   /* Swift hardware value: 0xF11AD206 */
>   #define SWIFT_BMC_HW_STRAP1 (                                           \
>           AST2500_HW_STRAP1_DEFAULTS |                                    \
> @@ -434,6 +449,49 @@ static void swift_bmc_i2c_init(AspeedBoardState *bmc)
>       i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
>   }
>   
> +static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
> +{
> +    AspeedSoCState *soc = &bmc->soc;
> +
> +    /* bus 2 : */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x49);
> +    /* bus 2 : pca9546 @ 0x73 */
> +
> +    /* bus 3 : pca9548 @ 0x70 */
> +
> +    /* bus 4 : */
> +    uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), 0x54,
> +                          eeprom4_54);
> +    /* PCA9539 @ 0x76, but PCA9552 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x76);
> +    /* PCA9539 @ 0x77, but PCA9552 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x77);
> +
> +    /* bus 6 : */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x49);
> +    /* bus 6 : pca9546 @ 0x73 */
> +
> +    /* bus 8 : */
> +    uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), 0x56,
> +                          eeprom8_56);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x61);
> +    /* bus 8 : adc128d818 @ 0x1d */
> +    /* bus 8 : adc128d818 @ 0x1f */
> +
> +    /* bus 13 : pca9548 @ 0x71
> +     *      - channel 3:
> +     *          - tmm421 @ 0x4c
> +     *          - tmp421 @ 0x4e
> +     *          - tmp421 @ 0x4f
> +     */
> +
> +}
> +
>   static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>   {
>       AspeedSoCState *soc = &bmc->soc;
> @@ -552,6 +610,21 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size       = 512 * MiB;
>   };
>   
> +static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "OCP SonoraPass BMC (ARM1176)";
> +    amc->soc_name  = "ast2500-a1";
> +    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
> +    amc->fmc_model = "mx66l1g45g";
> +    amc->spi_model = "mx66l1g45g";
> +    amc->num_cs    = 2;
> +    amc->i2c_init  = sonorapass_bmc_i2c_init;
> +    mc->default_ram_size       = 512 * MiB;
> +};
> +
>   static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -631,6 +704,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("swift-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_swift_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_sonorapass_class_init,
>       }, {
>           .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,


