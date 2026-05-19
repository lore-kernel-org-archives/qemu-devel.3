Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE8DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 05:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCmv-0003TM-NZ; Tue, 19 May 2026 01:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPCmt-0003St-C7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 01:14:39 -0400
Received: from 12.mo534.mail-out.ovh.net ([46.105.38.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPCmp-0005Kn-Jp
 for qemu-devel@nongnu.org; Tue, 19 May 2026 01:14:39 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gKNBw3Jckz5vPX;
 Tue, 19 May 2026 05:14:32 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 19 May 2026 05:14:32 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.2])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gKNBw2Znhz1xqF;
 Tue, 19 May 2026 05:14:32 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E6CDF203B55; 
 Tue, 19 May 2026 05:14:30 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004c1572813-afae-4464-b235-fd8f3a7557e8,
 A1C5BDF50025601E7F63D663DE463AD2E6007479) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a503aa1a-e6e1-4884-9abe-9bf5309c7fba@kaod.org>
Date: Tue, 19 May 2026 07:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/aspeed: add anacapa-bmc machine
To: William de Abreu Pinho <williamdapinho@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260515-add-anacapa-machine-v1-0-9765ce0b9426@gmail.com>
 <20260515-add-anacapa-machine-v1-1-9765ce0b9426@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260515-add-anacapa-machine-v1-1-9765ce0b9426@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17417671559854468107
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGEA7+UybVpXsKG+RSGE14+FYsuIe4li1WCZubyRgFVfRMYJuWogNyH42hm20yF/PtHuQzh5pLUFAlg9Iy3JzxJqY8Prb6XMCvnaMwChgqlvb6LEOJz0byIyQJflXg5HFN4VkVuvgjCd0AMVDOROSywat8Ks49ehmZ0XrnRuJ8g4SPB4icqnjsZ+M+ML9MxnOTTCZUmrgoqcxoTCJcc+qHkKHcos+MEXrBUmaF2xkQyEURv2VIBSyU33cu9xI4eEnXdAQCEIMVDzGOGw+avLdsVjtKBV3wqoUvwGXnLgxgFQc26A26+6VN6E9xzpk6QwJJrEcUhHUADp/bJn00FubJ5t5UfMaqYdMQn8qgy2x3HZjhJ7unRm7cnwgPbn2nOQYofrsonnGO7pkcxC+CNg8RZRd5kHivYEvA//rvE6WEPkhAElCSz8B3G3QNK6Z5JFDDT4DeVMvCsirm5Och9V1z8lCabo/C4hPgY9RPX4u246PsYPrwkTfH8CV+MIFsOFIoCm7CBZdfUxPmQ06oQDSHY+UPYmhZNeL3VytN1p9sf38tW3EuLwcPp9NVY20vBMzFwbDhRB0+6RDuvRhbFmTJyxSPPMoDOEr75ruksRpwGWa5AiXizA+GHz0T0XPtp21zsbv8HezK/bj6yLSuIdqT+KEfwCxFCYDjIgVvyewetsw
DKIM-Signature: a=rsa-sha256; bh=4dcoV2RCxXj1lUpyLfrZ1LZuo56hJOB0ST/eBQfpdJo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779167672; v=1;
 b=OT7be/OMdMMJm+i+4EWbhd1Fldfwlil/XAxuESKsaNoibSGnJedkkpc0zu782Gqzar+imMP2
 FhalykehA1gVwd582FoULyUFDywOZK/UgVOLVDHdwpymymhQ3bLhBBpN9CdSB8uqAVK/1QsEkS/
 /OIeupuKc92wqn/Y/Tky9pCTHZNEtD3zjt9RHtF37q2K+r3mdROqO8fSgt3GAjvPT2UVdhR57NP
 46BCRhRL+oITuxUUf7CQyDdzEMrBl30A9RaL1yCNk8ichBPMP7we+3tzijYQyI50r1r8OZNSrD9
 r6e+3bnmeEt0ud1pDIHJnYHKziMRu2xOBURJehViIpW5A==
Received-SPF: pass client-ip=46.105.38.145; envelope-from=clg@kaod.org;
 helo=12.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/15/26 18:55, William de Abreu Pinho wrote:
> Add the Facebook Anacapa BMC machine.  The I2C topology is based on the
> Linux kernel device tree [1].  Hardware strap register values are taken
> from real hardware.
> 
> A functional test is included using the OpenBMC image built from [2],
> similar to the tests for bletchley-bmc and catalina-bmc.
> 
> Facebook OpenBMC images include an early script [3] that lowers the
> console log level to warning.  This suppresses the "Hostname set to"
> message from the serial console.  Introduce FacebookAspeedTest (a
> subclass of AspeedTest), that waits for the login prompt instead.
> 
> [1]: https://github.com/torvalds/linux/blob/76b4ec8efdc3887cdbf730da2e55881fc1a18770/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> [2]: https://github.com/openbmc/openbmc/commit/8e22df918eaaa5d83143471d24ef0eeb1c1e3c7c
> [3]: https://github.com/openbmc/openbmc/blob/6a56a45931fb7015a3fc18553415909105b484d6/meta-facebook/recipes-phosphor/initrdscripts/phosphor-static-norootfs-init/999-reduce-printk
> 
> Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
> ---
>   hw/arm/aspeed_ast2600_anacapa.c             | 153 ++++++++++++++++++++++++++++
>   hw/arm/meson.build                          |   1 +
>   tests/functional/arm/meson.build            |   2 +
>   tests/functional/arm/test_aspeed_anacapa.py |  25 +++++
>   tests/functional/aspeed.py                  |   8 ++

Could you please send the functional test changes in separate patches ?

>   5 files changed, 189 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
> new file mode 100644
> index 0000000000..c24f00d44c
> --- /dev/null
> +++ b/hw/arm/aspeed_ast2600_anacapa.c
> @@ -0,0 +1,153 @@
> +/*
> + * Facebook Anacapa
> + *
> + * Copyright (c) Meta Platforms, Inc. and affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/arm/machines-qom.h"
> +#include "hw/arm/aspeed.h"
> +#include "hw/arm/aspeed_soc.h"
> +#include "hw/i2c/i2c_mux_pca954x.h"
> +#include "hw/gpio/pca9552.h"
> +#include "hw/nvram/eeprom_at24c.h"
> +
> +/* Anacapa hardware value */
> +#define ANACAPA_BMC_HW_STRAP1 0x00002002
> +#define ANACAPA_BMC_HW_STRAP2 0x00000000
> +#define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +
> +static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    /* Reference: aspeed-bmc-facebook-anacapa.dts */
> +
> +    AspeedSoCState *soc = bmc->soc;
> +    I2CBus *i2c[16] = {};
> +    I2CSlave *i2c_mux;
> +
> +    for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
> +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
> +    }
> +
> +    /* &i2c0 */
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[0], 0x50, 256 * KiB);
> +    /* i2c-mux@70 */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x70);
> +
> +    /* &i2c1 */
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[1], 0x50, 256 * KiB);
> +    /* i2c-mux@70 (PCA9546) — 4 channels, empty */
> +    i2c_slave_create_simple(i2c[1], TYPE_PCA9546, 0x70);
> +
> +    /* &i2c4 */
> +    /* i2c-mux@70 (PCA9548) */
> +    i2c_slave_create_simple(i2c[4], TYPE_PCA9548, 0x70);
> +
> +    /* &i2c6 */
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[6], 0x50, 32 * KiB);
> +
> +    /* &i2c8 */
> +    /* i2c-mux@72 (PCA9546) */
> +    i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
> +
> +    /* i2c8mux ch0 */
> +    /* adc128d818@1f — no model */
> +    /* pca9555@22 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> +                            TYPE_PCA9552, 0x22);
> +    /* pca9555@24 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> +                            TYPE_PCA9552, 0x24);
> +    /* eeprom@50 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB);
> +
> +    /* i2c8mux ch1 */
> +    /* pca9555@22 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> +                            TYPE_PCA9552, 0x22);
> +    /* pca9555@24 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> +                            TYPE_PCA9552, 0x24);
> +    /* eeprom@50 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB);
> +
> +    /* &i2c9 */
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[9], 0x50, 16 * KiB);
> +    /* eeprom@56 */
> +    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
> +
> +    /* &i2c10 */
> +    /* i2c-mux@71 (PCA9548) */
> +    i2c_mux = i2c_slave_create_simple(i2c[10], TYPE_PCA9548, 0x71);
> +
> +    /* i2c10mux ch5 */
> +    /* pca9555@22*/
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> +                            TYPE_PCA9552, 0x22);
> +    /* eeprom@52 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
> +
> +    /* &i2c11 */
> +    /* i2c-mux@71 (PCA9548) */
> +    i2c_mux = i2c_slave_create_simple(i2c[11], TYPE_PCA9548, 0x71);
> +
> +    /* i2c11mux ch0-ch4 — empty */
> +
> +    /* i2c11mux ch5 */
> +    /* pca9555@22 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> +                            TYPE_PCA9552, 0x22);
> +    /* eeprom@52 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
> +
> +    /* &i2c13 */
> +    /* i2c-mux@70 (PCA9548) */
> +    i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
> +
> +    /* i2c13mux ch3 */
> +    /* adc128d818@1f - no model */
> +
> +    /* i2c13mux ch4 */
> +    /* eeprom@51 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB);
> +
> +    /* i2c13mux ch7 */
> +    /* nfc@28 — no model */
> +}
> +
> +static void aspeed_machine_anacapa_class_init(ObjectClass *oc,
> +                                               const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Facebook Anacapa BMC (Cortex-A7)";
> +    amc->soc_name  = "ast2600-a3";
> +    amc->hw_strap1 = ANACAPA_BMC_HW_STRAP1;
> +    amc->hw_strap2 = ANACAPA_BMC_HW_STRAP2;
> +    amc->fmc_model = "mx66l1g45g";
> +    amc->spi_model = NULL;
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC2_ON;
> +    amc->i2c_init  = anacapa_bmc_i2c_init;
> +    mc->default_ram_size = ANACAPA_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
> +static const TypeInfo aspeed_ast2600_anacapa_types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_anacapa_class_init,
> +        .interfaces    = arm_machine_interfaces,
> +    }
> +};
> +
> +DEFINE_TYPES(aspeed_ast2600_anacapa_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 84b8ec5fb5..3de3dca8a9 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -56,6 +56,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast2500_witherspoon.c',
>     'aspeed_ast2500_yosemitev2.c',
>     'aspeed_ast2600.c',
> +  'aspeed_ast2600_anacapa.c',
>     'aspeed_ast2600_bletchley.c',
>     'aspeed_ast2600_catalina.c',
>     'aspeed_ast2600_evb.c',
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
> index 2f538f29a2..959179a56f 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -12,6 +12,7 @@ test_arm_timeouts = {
>     'aspeed_ast2600_sdk' : 720,
>     'aspeed_ast2600_sdk_515' : 720,
>     'aspeed_ast2600_sdk_otp' : 720,
> +  'aspeed_anacapa' : 480,
>     'aspeed_bletchley' : 480,
>     'aspeed_catalina' : 480,
>     'aspeed_gb200nvl_bmc' : 480,
> @@ -45,6 +46,7 @@ tests_arm_system_thorough = [
>     'aspeed_ast2600_sdk',
>     'aspeed_ast2600_sdk_515',
>     'aspeed_ast2600_sdk_otp',
> +  'aspeed_anacapa',
>     'aspeed_bletchley',
>     'aspeed_catalina',
>     'aspeed_gb200nvl_bmc',
> diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
> new file mode 100755
> index 0000000000..27f8bd8b56
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_anacapa.py
> @@ -0,0 +1,25 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import FacebookAspeedTest
> +
> +
> +class AnacapaMachine(FacebookAspeedTest):
> +
> +    ASSET_ANACAPA_FLASH = Asset(
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
> +        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
> +
> +    def test_arm_ast2600_anacapa_openbmc(self):
> +        image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
> +
> +        self.do_test_arm_aspeed_openbmc('anacapa-bmc', image=image_path,
> +                                        uboot='2019.04', cpu_id='0xf00',
> +                                        soc='AST2600 rev A3')
> +
> +if __name__ == '__main__':
> +    FacebookAspeedTest.main()
> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
> index 47e84e035b..88b6590934 100644
> --- a/tests/functional/aspeed.py
> +++ b/tests/functional/aspeed.py
> @@ -28,6 +28,9 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
>           self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
>           self.wait_for_console_pattern(f'ASPEED {soc}')
>           self.wait_for_console_pattern('/init as init process')
> +        self.wait_for_boot_complete(hostname)
> +
> +    def wait_for_boot_complete(self, hostname):
>           self.wait_for_console_pattern(f'systemd[1]: Hostname set to <{hostname}>.')

Since this change is modifying all machines, it should sent
separately. When you do so, please check that the timeouts
still apply.

The rest looks good.

Thanks,

C.

>   
>       def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
> @@ -69,3 +72,8 @@ def generate_otpmem_image(self):
>               f.write(pattern)
>           return path
>   
> +
> +class FacebookAspeedTest(AspeedTest):
> +
> +    def wait_for_boot_complete(self, hostname):
> +        self.wait_for_console_pattern(f'{hostname} login:')
> 


