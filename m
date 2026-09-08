Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07393C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tLB-0001Rl-Mb; Tue, 08 Sep 2026 06:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x3tLA-0001NU-9L
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:46:12 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x3tL6-0007AE-Mw
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:46:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a9459caac0so336564a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788864366; x=1789469166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m/61nE4RZAQCSiXlvZv8ZPhxDHQ+auYzWrng+fg5aUU=;
 b=huPEZGrW+WapsX7m13zgsWmSmOPXEIPYGTPCS6vb2JjZCf1BJy9cLjUTpfULb56MSK
 1cut+SExz5Qg4QWCH5yTmPYJIKLqlpzcpFgA3oYn3ROvd+675JxunPG8RYUxUOBifNGw
 KnqtnwiMS22lwP0U5CQfWkvoJrT1uxKUaj6KyrIEsfvnayW5Q9r4RG9+XR7OwM+vfHTB
 1ijMECSAojK6KVDV+jcb79/cJPbJAnKfC2a931u1JT6f7W6d4dSqWhOlK5ZTAzrk0Jsu
 /fTi8YoE1RIUeHbeKm+Uo170ZgOQ67S/l75PrMOjrwuCpz7o/3HaBHEeQNmCKZPCFRYF
 pzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864366; x=1789469166;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m/61nE4RZAQCSiXlvZv8ZPhxDHQ+auYzWrng+fg5aUU=;
 b=c+NoQd6Q5f66T8SO1XGhADpGjhDv2o9DIX5AdhVWWs9hyiYSbZB1Qc/QFScj3EYRVo
 s++zdkheAmdHOP8ugKz9+CXSgajS8Ymrz8SA6QXZJQyDaZHTquuvRucCJNrEsn3UzLbr
 KK7OHg6mW6a3xE5+foMl4cGZIDX2RopM4FNg0yu7VhuLnauqHYlVkjXshtHqitzxCh37
 sCz1Kdh5mlq55bCm6gFQCKQnM1yQXfJw3Z81vSv+TKkIDoNCM5UBio+RqClgihF7M0P8
 q32KFx9IBZFjW4gLwnI+9NPHCbkeSX3s6F/dGUYEA6d4LQquF3XEbil4B0akT5CDrccg
 XFNg==
X-Forwarded-Encrypted: i=1;
 AKwUvByOmO8c+i+HtWXjDmKfQlAiLsbM/5s3hm8a1tideTmHbyH+n1ejSg8/E6g1tReoeA5uD1CBWeIf8EBQ@nongnu.org
X-Gm-Message-State: AFuF++k/2eTd0EiEe+Zf1322rsQjwy/sgjEccsRyL8n/PvEIwxVixrnW
 MTFO7vCwHccTrBMblY0Z4LvdUakhObJ9003GVFX++3IICn8Ha8krajP4
X-Gm-Gg: AYBFou0GOWGn2HCOHnkNqUJtRLog8haNaX08XhOxD5gOLxT1R81irOsOOh3DyClghu1
 h74cu6Zqfb4WDue+TxrKY0eTnv5aN8JV7IoJhtg7R/OXhX28KIeNRCDDVEa/5YI9rnyuZm9grvi
 NE/QcE1XkUHyvmtStLq1bCDhpGOyPUN/Y8Gmt3E1F8xNB8J6/5dJA/LRZOvxLyNXIJXd5fQJZk9
 hszqMOjvzTmvjwjUPyQj+30jPSDV68JhtTqI6SDtb2Qbps+Hs8yDQTt9ri04ZvlQZ4v6wWgNYNn
 i3gMoi78PrhmLAbmRhO+YnHUQxjrfwN66PRJ+z+Xb02EfB7XHuQAk31Yl4CNbyhSYB8ZMnjzgEk
 m9myfs6EHwZ7hClP3O2Jjs0F9HEC9PeI625oXIYBRMhMqZfRYNW8uHa3ToPN+WhhcHrE2556T4Q
 78YKM1yFKvH2hX6R+UTxKUkNgWaashC/yNO/QkXQDEtZyVeUZkZm8Q9sfG1ExLrrfQAA==
X-Received: by 2002:a05:6402:a244:10b0:6a7:f2fc:deb7 with SMTP id
 4fb4d7f45d1cf-6a7f2fce000mr11967045a12.14.1788864365993; 
 Tue, 08 Sep 2026 03:46:05 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e68e921esm5359704a12.18.2026.09.08.03.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 03:46:05 -0700 (PDT)
Date: Tue, 08 Sep 2026 10:44:52 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>,
 Emmanuel Blot via qemu development <qemu-devel@nongnu.org>,
 qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_09/50=5D_hw=3A_ds1338=3A_use_the_TYPE=5FD?=
 =?US-ASCII?Q?S1338_constant_instead_of_the_=22ds1338=22_string?=
In-Reply-To: <20260907-bmc-minerva-v1-9-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
 <20260907-bmc-minerva-v1-9-0d83ad610c3b@free.fr>
Message-ID: <55B670A1-7B96-46AF-963F-0E105462AF6B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 7=2E September 2026 16:41:59 UTC schrieb Emmanuel Blot via qemu develop=
ment <qemu-devel@nongnu=2Eorg>:
>Now that TYPE_DS1338 is exposed by include/hw/rtc/ds1338=2Eh, use it in
>the machines that instantiate the RTC by its raw type name string=2E
>
>No functional change=2E
>
>Signed-off-by: Emmanuel Blot <emmanuel=2Eblot@free=2Efr>
>---
> hw/arm/aspeed_ast2400_palmetto=2Ec          | 4 +++-
> hw/arm/aspeed_ast2400_supermicrox11=2Ec     | 4 +++-
> hw/arm/aspeed_ast2500_romulus=2Ec           | 4 +++-
> hw/arm/aspeed_ast2500_supermicro-x11spi=2Ec | 4 +++-
> hw/arm/aspeed_ast2500_witherspoon=2Ec       | 4 +++-
> hw/arm/aspeed_ast2600_bletchley=2Ec         | 3 ++-
> hw/arm/aspeed_ast2600_catalina=2Ec          | 2 +-
> hw/arm/aspeed_ast2600_sanmiguel=2Ec         | 3 +--
> hw/arm/realview=2Ec                         | 3 ++-
> hw/arm/versatilepb=2Ec                      | 3 ++-
> hw/ppc/e500=2Ec                             | 3 ++-
> hw/riscv/tt_atlantis=2Ec                    | 3 ++-
> 12 files changed, 27 insertions(+), 13 deletions(-)
>
>diff --git a/hw/arm/aspeed_ast2400_palmetto=2Ec b/hw/arm/aspeed_ast2400_p=
almetto=2Ec
>index e2350e5b6c=2E=2E185185f0bb 100644
>--- a/hw/arm/aspeed_ast2400_palmetto=2Ec
>+++ b/hw/arm/aspeed_ast2400_palmetto=2Ec
>@@ -11,6 +11,7 @@
> #include "hw/arm/aspeed=2Eh"
> #include "hw/arm/aspeed_soc=2Eh"
> #include "hw/i2c/smbus_eeprom=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
>=20
> /* Palmetto hardware value: 0x120CE416 */
> #define PALMETTO_BMC_HW_STRAP1 (                                        =
\
>@@ -36,7 +37,8 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *b=
mc)
>      * The palmetto platform expects a ds3231 RTC but a ds1338 is
>      * enough to provide basic RTC features=2E Alarms will be missing
>      */
>-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", =
0x68);
>+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS133=
8,
>+                            0x68);
>=20
>     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                           eeprom_buf);
>diff --git a/hw/arm/aspeed_ast2400_supermicrox11=2Ec b/hw/arm/aspeed_ast2=
400_supermicrox11=2Ec
>index c75898cc6d=2E=2E051e072c5a 100644
>--- a/hw/arm/aspeed_ast2400_supermicrox11=2Ec
>+++ b/hw/arm/aspeed_ast2400_supermicrox11=2Ec
>@@ -11,6 +11,7 @@
> #include "hw/arm/aspeed=2Eh"
> #include "hw/arm/aspeed_soc=2Eh"
> #include "hw/i2c/smbus_eeprom=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
>=20
> /* TODO: Find the actual hardware value */
> #define SUPERMICROX11_BMC_HW_STRAP1 (                                   =
\
>@@ -36,7 +37,8 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineSta=
te *bmc)
>      * The palmetto platform expects a ds3231 RTC but a ds1338 is
>      * enough to provide basic RTC features=2E Alarms will be missing
>      */
>-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", =
0x68);
>+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS133=
8,
>+                            0x68);
>=20
>     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                           eeprom_buf);
>diff --git a/hw/arm/aspeed_ast2500_romulus=2Ec b/hw/arm/aspeed_ast2500_ro=
mulus=2Ec
>index 340a74408b=2E=2E87f90ed361 100644
>--- a/hw/arm/aspeed_ast2500_romulus=2Ec
>+++ b/hw/arm/aspeed_ast2500_romulus=2Ec
>@@ -10,6 +10,7 @@
> #include "qapi/error=2Eh"
> #include "hw/arm/aspeed=2Eh"
> #include "hw/arm/aspeed_soc=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
>=20
> /* Romulus hardware value: 0xF10AD206 */
> #define ROMULUS_BMC_HW_STRAP1 (                                         =
\
>@@ -29,7 +30,8 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bm=
c)
>      * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
>      * good enough
>      */
>-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338",=
 0x32);
>+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS13=
38,
>+                            0x32);
> }
>=20
> static void aspeed_machine_romulus_class_init(ObjectClass *oc,
>diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi=2Ec b/hw/arm/aspeed_=
ast2500_supermicro-x11spi=2Ec
>index 5a7e49d6cc=2E=2Edc0248422d 100644
>--- a/hw/arm/aspeed_ast2500_supermicro-x11spi=2Ec
>+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi=2Ec
>@@ -11,6 +11,7 @@
> #include "hw/arm/aspeed=2Eh"
> #include "hw/arm/aspeed_soc=2Eh"
> #include "hw/i2c/smbus_eeprom=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
>=20
> /* TODO: Find the actual hardware value */
> #define SUPERMICRO_X11SPI_BMC_HW_STRAP1 (                               =
\
>@@ -32,7 +33,8 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachin=
eState *bmc)
>      * The palmetto platform expects a ds3231 RTC but a ds1338 is
>      * enough to provide basic RTC features=2E Alarms will be missing
>      */
>-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", =
0x68);
>+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS133=
8,
>+                            0x68);
>=20
>     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                           eeprom_buf);
>diff --git a/hw/arm/aspeed_ast2500_witherspoon=2Ec b/hw/arm/aspeed_ast250=
0_witherspoon=2Ec
>index 26ddb67347=2E=2Ec69065846c 100644
>--- a/hw/arm/aspeed_ast2500_witherspoon=2Ec
>+++ b/hw/arm/aspeed_ast2500_witherspoon=2Ec
>@@ -14,6 +14,7 @@
> #include "hw/sensor/tmp105=2Eh"
> #include "hw/i2c/smbus_eeprom=2Eh"
> #include "hw/gpio/pca9552=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
>=20
> /* Witherspoon hardware value: 0xF10AD216 */
> #define WITHERSPOON_BMC_HW_STRAP1 (                                     =
\
>@@ -70,7 +71,8 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState=
 *bmc)
>      * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 i=
s
>      * good enough
>      */
>-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338",=
 0x32);
>+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS13=
38,
>+                            0x32);
>=20
>     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                           eeprom_buf);
>diff --git a/hw/arm/aspeed_ast2600_bletchley=2Ec b/hw/arm/aspeed_ast2600_=
bletchley=2Ec
>index 2822f6bdf5=2E=2E7bd1f90555 100644
>--- a/hw/arm/aspeed_ast2600_bletchley=2Ec
>+++ b/hw/arm/aspeed_ast2600_bletchley=2Ec
>@@ -12,6 +12,7 @@
> #include "hw/arm/aspeed_soc=2Eh"
> #include "hw/gpio/pca9552=2Eh"
> #include "hw/nvram/eeprom_at24c=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
>=20
> #define TYPE_TMP421 "tmp421"
> /* Bletchley hardware value */
>@@ -44,7 +45,7 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *=
bmc)
>     /* Bus 6 */
>     at24c_eeprom_init(i2c[6], 0x56, 65536);
>     /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
>-    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
>+    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x51);
>=20
>=20
>     /* Bus 7 */
>diff --git a/hw/arm/aspeed_ast2600_catalina=2Ec b/hw/arm/aspeed_ast2600_c=
atalina=2Ec
>index ad2953dfea=2E=2Ee1dc988425 100644
>--- a/hw/arm/aspeed_ast2600_catalina=2Ec
>+++ b/hw/arm/aspeed_ast2600_catalina=2Ec
>@@ -14,6 +14,7 @@
> #include "hw/gpio/pca9552=2Eh"
> #include "hw/gpio/pca9554=2Eh"
> #include "hw/nvram/eeprom_at24c=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
> #include "hw/sensor/tmp105=2Eh"
>=20
> /* Catalina hardware value */
>@@ -22,7 +23,6 @@
> #define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>=20
> #define TYPE_TMP421 "tmp421"
>-#define TYPE_DS1338 "ds1338"
>=20
> /*
>  * "BMC Storage Module" FRU data=2E  Generated with frugen=2E
>diff --git a/hw/arm/aspeed_ast2600_sanmiguel=2Ec b/hw/arm/aspeed_ast2600_=
sanmiguel=2Ec
>index 1dbbef11f2=2E=2E5ab2b43e9c 100644
>--- a/hw/arm/aspeed_ast2600_sanmiguel=2Ec
>+++ b/hw/arm/aspeed_ast2600_sanmiguel=2Ec
>@@ -13,6 +13,7 @@
> #include "hw/gpio/pca9552=2Eh"
> #include "hw/gpio/pca9554=2Eh"
> #include "hw/nvram/eeprom_at24c=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
> #include "hw/sensor/tmp105=2Eh"
>=20
> /* SanMiguel hardware values */
>@@ -20,8 +21,6 @@
> #define SANMIGUEL_BMC_HW_STRAP2 0x00000000
> #define SANMIGUEL_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>=20
>-#define TYPE_DS1338 "ds1338"
>-
> /*
>  * "Front IO" FRU data=2E Generated with frugen=2E
>  *
>diff --git a/hw/arm/realview=2Ec b/hw/arm/realview=2Ec
>index ceba0331b0=2E=2E4cdf939511 100644
>--- a/hw/arm/realview=2Ec
>+++ b/hw/arm/realview=2Ec
>@@ -28,6 +28,7 @@
> #include "hw/intc/realview_gic=2Eh"
> #include "hw/core/irq=2Eh"
> #include "hw/i2c/arm_sbcon_i2c=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
> #include "hw/sd/sd=2Eh"
> #include "target/arm/cpu-qom=2Eh"
>=20
>@@ -323,7 +324,7 @@ static void realview_init(MachineState *machine,
>=20
>     dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>     i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
>-    i2c_slave_create_simple(i2c, "ds1338", 0x68);
>+    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
>=20
>     /* Memory map for RealView Emulation Baseboard:  */
>     /* 0x10000000 System registers=2E  */
>diff --git a/hw/arm/versatilepb=2Ec b/hw/arm/versatilepb=2Ec
>index f94bf96599=2E=2E737cd21c27 100644
>--- a/hw/arm/versatilepb=2Ec
>+++ b/hw/arm/versatilepb=2Ec
>@@ -18,6 +18,7 @@
> #include "hw/pci/pci=2Eh"
> #include "hw/i2c/i2c=2Eh"
> #include "hw/i2c/arm_sbcon_i2c=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
> #include "hw/core/irq=2Eh"
> #include "hw/core/boards=2Eh"
> #include "hw/block/flash=2Eh"
>@@ -346,7 +347,7 @@ static void versatile_init(MachineState *machine, int=
 board_id)
>=20
>     dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>     i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
>-    i2c_slave_create_simple(i2c, "ds1338", 0x68);
>+    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
>=20
>     /* Add PL041 AACI Interface to the LM4549 codec */
>     pl041 =3D qdev_new("pl041");
>diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>index 1876882a04=2E=2E469cef9d2f 100644
>--- a/hw/ppc/e500=2Ec
>+++ b/hw/ppc/e500=2Ec
>@@ -50,6 +50,7 @@
> #include "hw/core/platform-bus=2Eh"
> #include "hw/net/fsl_etsec/etsec=2Eh"
> #include "hw/i2c/i2c=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
> #include "hw/core/irq=2Eh"
> #include "hw/sd/sdhci=2Eh"
> #include "hw/misc/unimp=2Eh"
>@@ -1025,7 +1026,7 @@ void ppce500_init(MachineState *machine)
>     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET=
,
>                                 sysbus_mmio_get_region(s, 0));
>     i2c =3D I2C_BUS(qdev_get_child_bus(dev, "i2c"));
>-    i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
>+    i2c_slave_create_simple(i2c, TYPE_DS1338, RTC_REGS_OFFSET);

Good idea!

For e500:
Acked-by: Bernhard Beschow <sgentey@gmail=2Ecom>

>=20
>     /* eSDHC */
>     if (pmc->has_esdhc) {
>diff --git a/hw/riscv/tt_atlantis=2Ec b/hw/riscv/tt_atlantis=2Ec
>index 8a219afef7=2E=2E910713c6bb 100644
>--- a/hw/riscv/tt_atlantis=2Ec
>+++ b/hw/riscv/tt_atlantis=2Ec
>@@ -27,6 +27,7 @@
> #include "hw/char/serial-mm=2Eh"
> #include "hw/intc/riscv_aclint=2Eh"
> #include "hw/misc/unimp=2Eh"
>+#include "hw/rtc/ds1338=2Eh"
>=20
> #include "system/system=2Eh"
> #include "system/device_tree=2Eh"
>@@ -657,7 +658,7 @@ static void tt_atlantis_machine_init(MachineState *ma=
chine)
>     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>=20
>     /* I2C peripherals: qemu specific */
>-    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
>+    i2c_slave_create_simple(i2c_get_bus(s, 0), TYPE_DS1338, 0x6f);
>     i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
>=20
>     /* Load or create device tree */
>

