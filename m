Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D143FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrhx-0001zD-Gl; Mon, 03 Nov 2025 05:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vFrht-0001yP-NQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:22:38 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vFrhl-0004a9-KS
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:22:37 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.234])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d0SLp6TD0z5yFR;
 Mon,  3 Nov 2025 10:22:10 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 3 Nov
 2025 11:21:44 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002f4edab5b-1cd0-4cc8-8f2f-8594b7010812,
 25720A756895FCE40C516A1A344E2045610AA209) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ed68114b-30f0-4901-8617-9f7b1219b855@kaod.org>
Date: Mon, 3 Nov 2025 11:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 03/30] hw/arm/aspeed: Export and rename
 create_pca9552() for reuse
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
 <20251103092801.1282602-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251103092801.1282602-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 7d19fdaf-d24d-4ec0-8c01-40df3d413ffd
X-Ovh-Tracer-Id: 9383531302318934962
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFk+Q3VVslDUspKmaECWQXYdHwntWVwIJQfz1THRwGU0XMYq+U8G/mY6w2socNCm8RQ8xzASdbAOD2D6wwrlncjP2nALy9IbGYot/YYBOP1SDbVN10US/m80paeebgrCPgRSMWCTq8xnVg5yHfi9PZ9Ip1YUxn+w/bYP5PZ+wimHpxEJJA88znDWx/OsTmU5Rdxp85xa7m0DlwlW3aYu91lTz3aWm487eilGZ1ATGsz+/2+voXPmRirJsTmunVGToHnV1h4hgUJa+V3lozt9vylhONuiDVsbJdOZuYLGwxKNmyzsQaDVAQCUSV0DiEmmbf/r7pY8RyeKZCRfjljMak6aN8ojX6CVhgROX6EyB+1iHJ+YyzL+XykOGMmLvwnUcFc9+s5UWCcmQPgVSH/uY3rLBB+meiR02/FV37/LERnnK/RoHtBntZWONLqwBavU2jDQDF++kc+KA/65/u7JBEMH7UCdGL+UnMsoTsp5rtiIAGj0Pa1pWCDEmnP/1O7sF10S0aCQlxkC7gxxGcZlMEy2y19kEVIU1TFOdA/Hs4BANFRWjcV5TIOemLv3CxP17uWFADmQHE+kxWRjRa1yy5C64RADmJXcOg/FnzonBMFUiDXyOVqCCrRCyckr6csT0mTi/n1TeUJ5vKZ3Off/TPv9NtruDnbONkFbaRJMu2Htw
DKIM-Signature: a=rsa-sha256; bh=VymJpoKe6brEGNX/ypcmzF6NyPksK/AM1H3Vkx/HEzc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762165341; v=1;
 b=o4qd9fVAb5Hj0JGtjPjciCePxi/96mnp4XI2k9UveIcmlDFTZ5tm+JXgw4vOen6tz3Ahw0EZ
 KfNPjZLW6MebcWoYMcRljckABY063AbFrP8+CScqCzhOjMrCJ0KKZ6lEWejFeaf1yC1NIeh1u/Z
 eapxxMdQEffK6Ks4UPxZ9uA4zqJS5YGXbdTfBnQ2VGOcAdKgZe3zSQ+zJ1oU8Ib6sVUNVlVdYVE
 lx2xQY3TMtO7XHY4AgKBDtiCh8UoALifg64qs1F6ZACWXy2fRbRR5upYYzcaY8W1nX8c1bTmqjQ
 u8hHSJ/qWC8dw4x2zPhNzM6OmGl5+Z9LNMxFw+H05lwGQ==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/3/25 10:27, Jamin Lin wrote:
> The helper function create_pca9552() has been renamed to
> aspeed_create_pca9552() and made non-static for reuse by other Aspeed
> machine source files. A corresponding prototype is now declared in
> aspeed.h.
> 
> This allows multiple Aspeed platforms to share PCA9552 I²C LED controller
> initialization logic, improving code reuse and reducing duplication.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed.h | 12 +++++++++++
>   hw/arm/aspeed.c         | 44 ++++++++++++++++++++---------------------
>   2 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 712014497e..3afb964088 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -68,4 +68,16 @@ struct AspeedMachineClass {
>    */
>   void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
>   
> +/*
> + * aspeed_create_pca9552:
> + * @soc: pointer to the #AspeedSoCState.
> + * @bus_id: the I²C bus index to attach the device.
> + * @addr: the I²C address of the PCA9552 device.

Please use I2C instead.


Thanks,

C.


> + *
> + * Create and attach a PCA9552 LED controller device to the specified I²C bus
> + * of the given Aspeed SoC. The device is instantiated using
> + * i2c_slave_create_simple() with the PCA9552 device type.
> + */
> +void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
> +
>   #endif
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index f23af5bf8c..c6f272d986 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -537,7 +537,7 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
>   }
>   
> -static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
> +void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
>   {
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
>                               TYPE_PCA9552, addr);
> @@ -565,9 +565,9 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>       smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
>                             eeprom4_54);
>       /* PCA9539 @ 0x76, but PCA9552 is compatible */
> -    create_pca9552(soc, 4, 0x76);
> +    aspeed_create_pca9552(soc, 4, 0x76);
>       /* PCA9539 @ 0x77, but PCA9552 is compatible */
> -    create_pca9552(soc, 4, 0x77);
> +    aspeed_create_pca9552(soc, 4, 0x77);
>   
>       /* bus 6 : */
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
> @@ -578,8 +578,8 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>       uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
>       smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
>                             eeprom8_56);
> -    create_pca9552(soc, 8, 0x60);
> -    create_pca9552(soc, 8, 0x61);
> +    aspeed_create_pca9552(soc, 8, 0x60);
> +    aspeed_create_pca9552(soc, 8, 0x61);
>       /* bus 8 : adc128d818 @ 0x1d */
>       /* bus 8 : adc128d818 @ 0x1f */
>   
> @@ -710,7 +710,7 @@ static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
>   
>       /* It expects a pca9555 but a pca9552 is compatible */
> -    create_pca9552(soc, 8, 0x30);
> +    aspeed_create_pca9552(soc, 8, 0x30);
>   }
>   
>   static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
> @@ -720,7 +720,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>   
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
>   
> -    create_pca9552(soc, 3, 0x61);
> +    aspeed_create_pca9552(soc, 3, 0x61);
>   
>       /* The rainier expects a TMP275 but a TMP105 is compatible */
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
> @@ -734,14 +734,14 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
> -    create_pca9552(soc, 4, 0x60);
> +    aspeed_create_pca9552(soc, 4, 0x60);
>   
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
>                        0x48);
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
>                        0x49);
> -    create_pca9552(soc, 5, 0x60);
> -    create_pca9552(soc, 5, 0x61);
> +    aspeed_create_pca9552(soc, 5, 0x60);
> +    aspeed_create_pca9552(soc, 5, 0x61);
>       i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>                                         "pca9546", 0x70);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
> @@ -760,12 +760,12 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x50, 64 * KiB);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 3), 0x51, 64 * KiB);
>   
> -    create_pca9552(soc, 7, 0x30);
> -    create_pca9552(soc, 7, 0x31);
> -    create_pca9552(soc, 7, 0x32);
> -    create_pca9552(soc, 7, 0x33);
> -    create_pca9552(soc, 7, 0x60);
> -    create_pca9552(soc, 7, 0x61);
> +    aspeed_create_pca9552(soc, 7, 0x30);
> +    aspeed_create_pca9552(soc, 7, 0x31);
> +    aspeed_create_pca9552(soc, 7, 0x32);
> +    aspeed_create_pca9552(soc, 7, 0x33);
> +    aspeed_create_pca9552(soc, 7, 0x60);
> +    aspeed_create_pca9552(soc, 7, 0x61);
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
>       /* Bus 7: TODO si7021-a20@20 */
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
> @@ -782,8 +782,8 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>                             64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
>       at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
>                             64 * KiB, rainier_bmc_fruid, rainier_bmc_fruid_len);
> -    create_pca9552(soc, 8, 0x60);
> -    create_pca9552(soc, 8, 0x61);
> +    aspeed_create_pca9552(soc, 8, 0x60);
> +    aspeed_create_pca9552(soc, 8, 0x61);
>       /* Bus 8: ucd90320@11 */
>       /* Bus 8: ucd90320@b */
>       /* Bus 8: ucd90320@c */
> @@ -804,17 +804,17 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>                                         "pca9546", 0x70);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
> -    create_pca9552(soc, 11, 0x60);
> +    aspeed_create_pca9552(soc, 11, 0x60);
>   
>   
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 13), 0x50, 64 * KiB);
> -    create_pca9552(soc, 13, 0x60);
> +    aspeed_create_pca9552(soc, 13, 0x60);
>   
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 14), 0x50, 64 * KiB);
> -    create_pca9552(soc, 14, 0x60);
> +    aspeed_create_pca9552(soc, 14, 0x60);
>   
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 15), 0x50, 64 * KiB);
> -    create_pca9552(soc, 15, 0x60);
> +    aspeed_create_pca9552(soc, 15, 0x60);
>   }
>   
>   static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,


