Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373F8C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLhW-0006iV-1a; Thu, 03 Jul 2025 11:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=EggC=ZQ=kaod.org=clg@ozlabs.org>)
 id 1uXLhN-0006hN-80; Thu, 03 Jul 2025 11:18:06 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=EggC=ZQ=kaod.org=clg@ozlabs.org>)
 id 1uXLhI-0006T0-FH; Thu, 03 Jul 2025 11:18:03 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bY0kP5XmKz4x43;
 Fri,  4 Jul 2025 01:17:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bY0kL32myz4x07;
 Fri,  4 Jul 2025 01:17:30 +1000 (AEST)
Message-ID: <c67ebcba-ceef-4590-b104-b96ea7f47eb2@kaod.org>
Date: Thu, 3 Jul 2025 17:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/arm/aspeed: Add GB200 BMC target
To: Ed Tanous <etanous@nvidia.com>, qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250703144249.3348879-1-etanous@nvidia.com>
 <20250703144249.3348879-4-etanous@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250703144249.3348879-4-etanous@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=EggC=ZQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/3/25 16:42, Ed Tanous wrote:
> GB200nvl72 is a system for for accelerated compute.  This is a model for
> the BMC target within the system.
> 
> This is based on the device tree aspeed-bmc-nvidia-gb200nvl-bmc.dts
> from:
> 
> [1] https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
> 
> Signed-off-by: Ed Tanous <etanous@nvidia.com>
> ---
>   hw/arm/aspeed.c        | 79 ++++++++++++++++++++++++++++++++++++++++++
>   hw/arm/aspeed_eeprom.c | 21 +++++++++++
>   hw/arm/aspeed_eeprom.h |  3 ++
>   3 files changed, 103 insertions(+)



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 3ef7f6c5b2..98144ced86 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -19,6 +19,7 @@
>   #include "hw/i2c/i2c_mux_pca954x.h"
>   #include "hw/i2c/smbus_eeprom.h"
>   #include "hw/gpio/pca9552.h"
> +#include "hw/gpio/pca9554.h"
>   #include "hw/nvram/eeprom_at24c.h"
>   #include "hw/sensor/tmp105.h"
>   #include "hw/misc/led.h"
> @@ -201,6 +202,10 @@ struct AspeedMachineState {
>   #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
>   #define BLETCHLEY_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
>   
> +/* GB200NVL hardware value */
> +#define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
> +#define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
> +
>   /* Qualcomm DC-SCM hardware value */
>   #define QCOM_DC_SCM_V1_BMC_HW_STRAP1  0x00000000
>   #define QCOM_DC_SCM_V1_BMC_HW_STRAP2  0x00000041
> @@ -647,6 +652,12 @@ static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
>                               TYPE_PCA9552, addr);
>   }
>   
> +static I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
> +{
> +    return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
> +                            TYPE_PCA9554, addr);
> +}
> +
>   static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>   {
>       AspeedSoCState *soc = bmc->soc;
> @@ -1052,6 +1063,45 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
>   }
>   
> +
> +static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = bmc->soc;
> +    I2CBus *i2c[15] = {};
> +    DeviceState *dev;
> +    for (int i = 0; i < sizeof(i2c) / sizeof(i2c[0]); i++) {
> +        if ((i == 11) || (i == 12) || (i == 13)) {
> +            continue;
> +        }
> +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
> +    }
> +
> +    /* Bus 5 Expander */
> +    create_pca9554(soc, 4, 0x21);
> +
> +    /* Mux I2c Expanders */
> +    i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
> +    i2c_slave_create_simple(i2c[5], "pca9546", 0x72);
> +    i2c_slave_create_simple(i2c[5], "pca9546", 0x73);
> +    i2c_slave_create_simple(i2c[5], "pca9546", 0x75);
> +    i2c_slave_create_simple(i2c[5], "pca9546", 0x76);
> +    i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
> +
> +    /* Bus 10 */
> +    dev = DEVICE(create_pca9554(soc, 9, 0x20));
> +
> +    /* Set FPGA_READY */
> +    object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
> +
> +    create_pca9554(soc, 9, 0x21);
> +    at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
> +    at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
> +
> +    /* Bus 11 */
> +    at24c_eeprom_init_rom(i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
> +                          gb200nvl_bmc_fruid_len);
> +}
> +
>   static void fby35_i2c_init(AspeedMachineState *bmc)
>   {
>       AspeedSoCState *soc = bmc->soc;
> @@ -1587,6 +1637,31 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> +#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
> +
> +static void aspeed_machine_gb200nvl_class_init(ObjectClass *oc,
> +                                               const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Nvidia GB200NVL BMC (Cortex-A7)";
> +    amc->soc_name  = "ast2600-a3";
> +    amc->hw_strap1 = GB200NVL_BMC_HW_STRAP1;
> +    amc->hw_strap2 = GB200NVL_BMC_HW_STRAP2;
> +    amc->fmc_model = "mx66u51235f";
> +    amc->spi_model = "mx66u51235f";
> +    amc->num_cs    = 2;
> +
> +    amc->spi2_model = "mx66u51235f";
> +    amc->num_cs2   = 1;
> +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
> +    amc->i2c_init  = gb200nvl_bmc_i2c_init;
> +    mc->default_ram_size = GB200NVL_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +    aspeed_machine_ast2600_class_emmc_init(oc);
> +}
> +
>   static void fby35_reset(MachineState *state, ResetType type)
>   {
>       AspeedMachineState *bmc = ASPEED_MACHINE(state);
> @@ -1879,6 +1954,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_bletchley_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_gb200nvl_class_init,
>       }, {
>           .name          = MACHINE_TYPE_NAME("fby35-bmc"),
>           .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
> diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> index daa3d329d1..8bbbdec834 100644
> --- a/hw/arm/aspeed_eeprom.c
> +++ b/hw/arm/aspeed_eeprom.c
> @@ -162,6 +162,25 @@ const uint8_t rainier_bmc_fruid[] = {
>       0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
>   };
>   
> +const uint8_t gb200nvl_bmc_fruid[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,
> +    0x0f, 0xe6, 0xc6, 0x4e, 0x56, 0x49, 0x44, 0x49, 0x41, 0xc5, 0x50, 0x33,
> +    0x38, 0x30, 0x39, 0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38,
> +    0x30, 0x30, 0x31, 0x35, 0x30, 0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33,
> +    0x38, 0x30, 0x39, 0x2d, 0x30, 0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30,
> +    0xc0, 0x01, 0x01, 0xd6, 0x4d, 0x41, 0x43, 0x3a, 0x20, 0x33, 0x43, 0x3a,
> +    0x36, 0x44, 0x3a, 0x36, 0x36, 0x3a, 0x31, 0x34, 0x3a, 0x43, 0x38, 0x3a,
> +    0x37, 0x41, 0xc1, 0x3b, 0x01, 0x09, 0x19, 0xc6, 0x4e, 0x56, 0x49, 0x44,
> +    0x49, 0x41, 0xc9, 0x50, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x42, 0x4d, 0x43,
> +    0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x30,
> +    0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30, 0xc4, 0x41, 0x45, 0x2e, 0x31,
> +    0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38, 0x30, 0x30, 0x31,
> +    0x35, 0x30, 0xc0, 0xc4, 0x76, 0x30, 0x2e, 0x31, 0xc1, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0xb4, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
> +
> +};
> +
>   const size_t tiogapass_bmc_fruid_len = sizeof(tiogapass_bmc_fruid);
>   const size_t fby35_nic_fruid_len = sizeof(fby35_nic_fruid);
>   const size_t fby35_bb_fruid_len = sizeof(fby35_bb_fruid);
> @@ -169,3 +188,5 @@ const size_t fby35_bmc_fruid_len = sizeof(fby35_bmc_fruid);
>   const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
>   const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
>   const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
> +const size_t gb200nvl_bmc_fruid_len = sizeof(gb200nvl_bmc_fruid);
> +
> diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> index f08c16ef50..3ed9bc1d9a 100644
> --- a/hw/arm/aspeed_eeprom.h
> +++ b/hw/arm/aspeed_eeprom.h
> @@ -26,4 +26,7 @@ extern const size_t rainier_bb_fruid_len;
>   extern const uint8_t rainier_bmc_fruid[];
>   extern const size_t rainier_bmc_fruid_len;
>   
> +extern const uint8_t gb200nvl_bmc_fruid[];
> +extern const size_t gb200nvl_bmc_fruid_len;
> +
>   #endif


