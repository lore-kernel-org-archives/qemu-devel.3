Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86B4CC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfN3-0007Iz-Lv; Tue, 13 Oct 2026 12:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGfLa-0005IF-NF; Tue, 13 Oct 2026 12:27:27 -0400
Received: from 7.mo528.mail-out.ovh.net ([46.105.34.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGfLV-0005BZ-Sn; Tue, 13 Oct 2026 12:27:25 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4j409L3dqyz66DQ;
 Tue, 13 Oct 2026 16:27:18 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 16:27:18 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.6])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4j409L2sRkz46Zw;
 Tue, 13 Oct 2026 16:27:18 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 15CD1202CA2; 
 Tue, 13 Oct 2026 16:27:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003992f763f-3f85-4176-84a9-98d1938be919,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ea100e7e-e3e5-48df-bcad-02e10ad5de5a@kaod.org>
Date: Tue, 13 Oct 2026 18:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/50] hw: ds1338: use the TYPE_DS1338 constant instead
 of the "ds1338" string
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-9-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-9-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6621980305192561709
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEy2TVmIGdJz9wb2lZxs6ZOYk0T6DuDjUbu8/zXGYTH4fUECEqloGjFfQQCwGTA+Qh7f8ykczPwXj/0yRHFk+ke0Oq8cqPzvgWUWqE52q4F8K7KHMRomHayz0KSPI3Kj1OS1RB4ltUXcr9VLwn8YMxu6kumcdPsPn14jLrFeI22oREKqPhMU2SvVrQ8KaXHRxjVPvt64nha3KIPtHpiy9r9K5jkCxjkBrKxyaee8ty7LwZMq0oVcVbO7WlIGgJOp6cyTRlPBQhZa3PdT41/UEK/QPowtMJd7DrnTJlu2XG9nN1MD1oRi9XLbB1T/tzjDKh80+WtaijTeEgascMvqUOAEZExwyDDyZDLw9A7xnsL1r3j6uV9UzDLoZTFGD0bxV3npuUjjUss5xFYaPUqvHkfdMUZmwV/R+7cbrgaMXILWFbE8mCBf9FHiTqfgNAXivx7lneVdhOjeS2zs57J1CssK/I3OmKXSe3dmsS78PtL+AqgbRq9NRVsH32FMLoHmR3S6e0HrdYWK/SRm67Dceb1Ws8dEwKqJY4LdgtVGwUjGFV5Duxs+R/crHIdmsIDi4jneONkHp6Dh9CoJDjAfZccuLqS6gqPGNbe35RGqS1Z7bxV8FkqGatWjZkuPwgD2d+j+m71hFF2jpE5quFkxloqMaLsOQM3duEZ6RlhKgfqVw
DKIM-Signature: a=rsa-sha256; bh=j6mLet/jTDHLu1fL0oETOCbJoU56Oej5KDFx7JB06n8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791908839; v=1;
 b=m8gGkLwVe7F7wcmAa1BtHGdRAtSwI8Grh+3FtaiKuDP+h8Y0Tq3WqJ5Bie2yGfo3YiWfWvGM
 fJUqtFnDYoiDlCBSeAthCeykUw9Z17D1YRHrzuz6YxkRGeC//RSqu3z9oC0BEYszfJCRoyROV3O
 fMdhYLclha1dD26r3afj61Cim3iiBK6Iexwddjaqk8jPkveFEQ8ap+LIQ/MuQx4CogDrXfa2V/Y
 Y6QGTzT9FzzZ/cHQ5NKpjlmH5k8SzLh8fqOjcUxn6EahsIvLRz211rZLgEN4fsTN6xcT+d+gCK0
 dbPbaAt86I+f8ezKsD6RoZzt8nIm9HtF6aKB8g8K+R3/g==
Received-SPF: pass client-ip=46.105.34.81; envelope-from=clg@kaod.org;
 helo=7.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/12/26 16:32, Emmanuel Blot wrote:
> Now that TYPE_DS1338 is exposed by include/hw/rtc/ds1338.h, use it in
> the machines that instantiate the RTC by its raw type name string.
> 
> No functional change.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/arm/aspeed_ast2400_palmetto.c          | 4 +++-
>   hw/arm/aspeed_ast2400_supermicrox11.c     | 4 +++-
>   hw/arm/aspeed_ast2500_romulus.c           | 4 +++-
>   hw/arm/aspeed_ast2500_supermicro-x11spi.c | 4 +++-
>   hw/arm/aspeed_ast2500_witherspoon.c       | 4 +++-
>   hw/arm/aspeed_ast2600_bletchley.c         | 3 ++-
>   hw/arm/aspeed_ast2600_catalina.c          | 2 +-
>   hw/arm/aspeed_ast2600_sanmiguel.c         | 3 +--
>   hw/arm/realview.c                         | 3 ++-
>   hw/arm/versatilepb.c                      | 3 ++-
>   hw/ppc/e500.c                             | 3 ++-
>   hw/riscv/tt_atlantis.c                    | 3 ++-
>   12 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
> index e2350e5b6c..185185f0bb 100644
> --- a/hw/arm/aspeed_ast2400_palmetto.c
> +++ b/hw/arm/aspeed_ast2400_palmetto.c
> @@ -11,6 +11,7 @@
>   #include "hw/arm/aspeed.h"
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/rtc/ds1338.h"
>   
>   /* Palmetto hardware value: 0x120CE416 */
>   #define PALMETTO_BMC_HW_STRAP1 (                                        \
> @@ -36,7 +37,8 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
>        * The palmetto platform expects a ds3231 RTC but a ds1338 is
>        * enough to provide basic RTC features. Alarms will be missing
>        */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
> +                            0x68);
>   
>       smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                             eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
> index c75898cc6d..051e072c5a 100644
> --- a/hw/arm/aspeed_ast2400_supermicrox11.c
> +++ b/hw/arm/aspeed_ast2400_supermicrox11.c
> @@ -11,6 +11,7 @@
>   #include "hw/arm/aspeed.h"
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/rtc/ds1338.h"
>   
>   /* TODO: Find the actual hardware value */
>   #define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
> @@ -36,7 +37,8 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
>        * The palmetto platform expects a ds3231 RTC but a ds1338 is
>        * enough to provide basic RTC features. Alarms will be missing
>        */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
> +                            0x68);
>   
>       smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                             eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
> index 340a74408b..87f90ed361 100644
> --- a/hw/arm/aspeed_ast2500_romulus.c
> +++ b/hw/arm/aspeed_ast2500_romulus.c
> @@ -10,6 +10,7 @@
>   #include "qapi/error.h"
>   #include "hw/arm/aspeed.h"
>   #include "hw/arm/aspeed_soc.h"
> +#include "hw/rtc/ds1338.h"
>   
>   /* Romulus hardware value: 0xF10AD206 */
>   #define ROMULUS_BMC_HW_STRAP1 (                                         \
> @@ -29,7 +30,8 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
>        * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
>        * good enough
>        */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS1338,
> +                            0x32);
>   }
>   
>   static void aspeed_machine_romulus_class_init(ObjectClass *oc,
> diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> index 5a7e49d6cc..dc0248422d 100644
> --- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> +++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> @@ -11,6 +11,7 @@
>   #include "hw/arm/aspeed.h"
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/rtc/ds1338.h"
>   
>   /* TODO: Find the actual hardware value */
>   #define SUPERMICRO_X11SPI_BMC_HW_STRAP1 (                               \
> @@ -32,7 +33,8 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
>        * The palmetto platform expects a ds3231 RTC but a ds1338 is
>        * enough to provide basic RTC features. Alarms will be missing
>        */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
> +                            0x68);
>   
>       smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                             eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
> index 26ddb67347..c69065846c 100644
> --- a/hw/arm/aspeed_ast2500_witherspoon.c
> +++ b/hw/arm/aspeed_ast2500_witherspoon.c
> @@ -14,6 +14,7 @@
>   #include "hw/sensor/tmp105.h"
>   #include "hw/i2c/smbus_eeprom.h"
>   #include "hw/gpio/pca9552.h"
> +#include "hw/rtc/ds1338.h"
>   
>   /* Witherspoon hardware value: 0xF10AD216 */
>   #define WITHERSPOON_BMC_HW_STRAP1 (                                     \
> @@ -70,7 +71,8 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>        * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
>        * good enough
>        */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS1338,
> +                            0x32);
>   
>       smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                             eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
> index 6fa606c047..0e746055a2 100644
> --- a/hw/arm/aspeed_ast2600_bletchley.c
> +++ b/hw/arm/aspeed_ast2600_bletchley.c
> @@ -12,6 +12,7 @@
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/gpio/pca9552.h"
>   #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
>   
>   #define TYPE_TMP421 "tmp421"
>   /* Bletchley hardware value */
> @@ -44,7 +45,7 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
>       /* Bus 6 */
>       at24c_eeprom_init(i2c[6], 0x56, 65536);
>       /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
> -    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
> +    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x51);
>   
>   
>       /* Bus 7 */
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index 4f2b396f6f..b15d932086 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -14,6 +14,7 @@
>   #include "hw/gpio/pca9552.h"
>   #include "hw/gpio/pca9554.h"
>   #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
>   #include "hw/sensor/tmp105.h"
>   
>   /* Catalina hardware value */
> @@ -22,7 +23,6 @@
>   #define CATALINA_BMC_RAM_SIZE (2 * GiB)
>   
>   #define TYPE_TMP421 "tmp421"
> -#define TYPE_DS1338 "ds1338"
>   
>   /*
>    * "BMC Storage Module" FRU data.  Generated with frugen.
> diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
> index ac2aef740a..b0935683e2 100644
> --- a/hw/arm/aspeed_ast2600_sanmiguel.c
> +++ b/hw/arm/aspeed_ast2600_sanmiguel.c
> @@ -13,6 +13,7 @@
>   #include "hw/gpio/pca9552.h"
>   #include "hw/gpio/pca9554.h"
>   #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
>   #include "hw/sensor/tmp105.h"
>   
>   /* SanMiguel hardware values */
> @@ -20,8 +21,6 @@
>   #define SANMIGUEL_BMC_HW_STRAP2 0x00000000
>   #define SANMIGUEL_BMC_RAM_SIZE (2 * GiB)
>   
> -#define TYPE_DS1338 "ds1338"
> -
>   /*
>    * "Front IO" FRU data. Generated with frugen.
>    *
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index ceba0331b0..4cdf939511 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -28,6 +28,7 @@
>   #include "hw/intc/realview_gic.h"
>   #include "hw/core/irq.h"
>   #include "hw/i2c/arm_sbcon_i2c.h"
> +#include "hw/rtc/ds1338.h"
>   #include "hw/sd/sd.h"
>   #include "target/arm/cpu-qom.h"
>   
> @@ -323,7 +324,7 @@ static void realview_init(MachineState *machine,
>   
>       dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>       i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
>   
>       /* Memory map for RealView Emulation Baseboard:  */
>       /* 0x10000000 System registers.  */
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index f94bf96599..737cd21c27 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -18,6 +18,7 @@
>   #include "hw/pci/pci.h"
>   #include "hw/i2c/i2c.h"
>   #include "hw/i2c/arm_sbcon_i2c.h"
> +#include "hw/rtc/ds1338.h"
>   #include "hw/core/irq.h"
>   #include "hw/core/boards.h"
>   #include "hw/block/flash.h"
> @@ -346,7 +347,7 @@ static void versatile_init(MachineState *machine, int board_id)
>   
>       dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>       i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
>   
>       /* Add PL041 AACI Interface to the LM4549 codec */
>       pl041 = qdev_new("pl041");
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 1876882a04..469cef9d2f 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -50,6 +50,7 @@
>   #include "hw/core/platform-bus.h"
>   #include "hw/net/fsl_etsec/etsec.h"
>   #include "hw/i2c/i2c.h"
> +#include "hw/rtc/ds1338.h"
>   #include "hw/core/irq.h"
>   #include "hw/sd/sdhci.h"
>   #include "hw/misc/unimp.h"
> @@ -1025,7 +1026,7 @@ void ppce500_init(MachineState *machine)
>       memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
>                                   sysbus_mmio_get_region(s, 0));
>       i2c = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
> -    i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
> +    i2c_slave_create_simple(i2c, TYPE_DS1338, RTC_REGS_OFFSET);
>   
>       /* eSDHC */
>       if (pmc->has_esdhc) {
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 8a219afef7..910713c6bb 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -27,6 +27,7 @@
>   #include "hw/char/serial-mm.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/misc/unimp.h"
> +#include "hw/rtc/ds1338.h"
>   
>   #include "system/system.h"
>   #include "system/device_tree.h"
> @@ -657,7 +658,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
>       qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>   
>       /* I2C peripherals: qemu specific */
> -    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
> +    i2c_slave_create_simple(i2c_get_bus(s, 0), TYPE_DS1338, 0x6f);
>       i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
>   
>       /* Load or create device tree */
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


