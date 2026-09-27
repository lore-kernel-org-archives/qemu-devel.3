Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E416606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRX4x-00078i-RT; Thu, 12 Nov 2026 10:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKh-0005hN-Er; Thu, 12 Nov 2026 10:03:30 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKb-0004Ph-A8; Thu, 12 Nov 2026 10:03:22 -0500
DKIM-Signature: a=rsa-sha256; bh=w4wnsWNmpjHfqF7YHlORkJXNT2CoNY0hOIRgLP+ffuY=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1794495790; v=1;
 b=HV/+H8lOdscggwu6WWQ7f31wG7swnDFZEk/aSEDN32IJsMXyctyOdYpHH2rFN3jBBXAqW5b2
 NMVKHNaW9x1yqrF/TJikMaTzuwaN9N0LiZThxnrt9r8dlbiToHWnGscQUdNNjNlYEQpeG/sSCp1
 Cx/EPTFcezdk40Oiteqc9j8mYYzl7YGEm5jXRjvJtsYOCr1C4agc26YrEJxA1z9oHu1/1x7sq38
 l3QC4E2eTpVJCeiU4IWAHl8TOYyvz39iU4AZjqujXjzejcG3S+fGWXl5GqbWgeVLvF+4vCdjaUg
 rMTzr4rCRutQxcvzxVLmfiEhHE9JLJSZUU67sf/K+mXeQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 5F9D922F0E;
 Thu, 12 Nov 2026 15:03:10 +0000 (UTC)
From: ~mohammadodeh <mohammadodeh@git.sr.ht>
Date: Sun, 27 Sep 2026 10:32:38 +0300
Subject: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine
Message-ID: <179449578952.8382.2790865629085512841-3@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <179449578952.8382.2790865629085512841-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samuel Tardieu <sam@rfc1149.net>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Bin Meng <bin.meng@processmission.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 10:51:09 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~mohammadodeh <Mohammad.Odeh@exalt.ps>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Odeh <mohammad.odeh@exalt.ps>

Add a machine model for the STM32L496G-DISCO Discovery kit.

Introduce the STM32L496xG SoC variant with its flash and SRAM sizes.
Attach the on-board MX25R6435F flash to the QuadSPI controller and add
qtests for identification, SFDP access, and data transfer.

Signed-off-by: Mohammad Odeh <zephyr@exalt.ps>
---
 MAINTAINERS                          |   8 +
 docs/system/arm/stm32.rst            |   1 +
 docs/system/arm/stm32l496g-disco.rst |  43 ++
 docs/system/target-arm.rst           |   1 +
 hw/arm/Kconfig                       |   7 +
 hw/arm/meson.build                   |   1 +
 hw/arm/stm32l496g-disco.c            |  95 ++++
 hw/arm/stm32l4x5_soc.c               |  25 +-
 include/hw/arm/stm32l4x5_soc.h       |   3 +
 tests/qtest/meson.build              |   1 +
 tests/qtest/stm32l496g-disco-test.c  | 693 +++++++++++++++++++++++++++
 11 files changed, 874 insertions(+), 4 deletions(-)
 create mode 100644 docs/system/arm/stm32l496g-disco.rst
 create mode 100644 hw/arm/stm32l496g-disco.c
 create mode 100644 tests/qtest/stm32l496g-disco-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a820703f8..cb1cad7f5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1123,6 +1123,14 @@ F: hw/ssi/stm32l4x5_quadspi.c
 F: include/hw/*/stm32l4x5_*.h
 F: tests/qtest/stm32l4x5*
=20
+STM32L496G-DISCO
+M: Mohammad Odeh <zephyr@exalt.ps>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/stm32l496g-disco.c
+F: docs/system/arm/stm32l496g-disco.rst
+F: tests/qtest/stm32l496g-disco-test.c
+
 STM32VLDISCOVERY
 M: Alexandre Iooss <erdnaxe@crans.org>
 L: qemu-arm@nongnu.org
diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 23b03f9029..70746f8e79 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -23,6 +23,7 @@ The following machines are based on this Arm Cortex-M4F chi=
p :
 - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontro=
ller
 - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcont=
roller
 - ``b-l475e-iot01a``     :doc:`B-L475E-IOT01A IoT Node </system/arm/b-l475e-=
iot01a>` board with STM32L475VG microcontroller
+- ``stm32l496g-disco``   :doc:`STM32L496G-DISCO Discovery Kit </system/arm/s=
tm32l496g-disco>` board with STM32L496AG microcontroller
=20
 There are many other STM32 series that are currently not supported by QEMU.
=20
diff --git a/docs/system/arm/stm32l496g-disco.rst b/docs/system/arm/stm32l496=
g-disco.rst
new file mode 100644
index 0000000000..732f98b202
--- /dev/null
+++ b/docs/system/arm/stm32l496g-disco.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+STM32L496G-DISCO Discovery Kit (``stm32l496g-disco``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+The STM32L496G-DISCO Discovery Kit uses an STM32L496AG microcontroller with
+an Arm Cortex-M4F core, 1 MiB of internal flash, 256 KiB of SRAM1, and 64 KiB
+of SRAM2.
+
+Supported devices
+-----------------
+
+The machine initially supports the devices shared with the STM32L4x5 model:
+
+- Cortex-M4F processor
+- Internal flash and SRAM
+- Reset and clock control
+- EXTI and system configuration controllers
+- GPIO ports A through H
+- USART1, USART2, USART3, UART4, UART5, and LPUART1
+- QuadSPI controller in indirect mode
+- MX25R6435F QuadSPI flash
+
+Missing devices
+---------------
+
+The following board features are not currently modeled:
+
+- GPIO port I
+- Timers, RTC, watchdogs, ADC, and DAC
+- I2C, SPI, SDMMC, USB, and FMC controllers
+- On-board display, joystick, and sensors
+
+Boot options
+------------
+
+USART2 is the console used by the Zephyr board configuration. It is QEMU's
+second serial backend, so start a Zephyr image with:
+
+.. code-block:: bash
+
+   qemu-system-arm -M stm32l496g-disco -kernel zephyr.elf \
+     -nographic -serial null -serial stdio
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 260cd7e4d6..c7d9947655 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -82,6 +82,7 @@ Board-specific documentation
    arm/aspeed
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
+   arm/stm32l496g-disco.rst
    arm/sabrelite
    arm/digic
    arm/cubieboard
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 94a01c412b..5faa5d4ee1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -389,6 +389,13 @@ config B_L475E_IOT01A
     select STM32L4X5_SOC
     imply DM163
=20
+config STM32L496G_DISCO
+    bool
+    default y
+    depends on TCG && ARM
+    select STM32L4X5_SOC
+    select SSI_M25P80
+
 config STM32L4X5_SOC
     bool
     select ARM_V7M
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f3c1b0e00f..bc6d8ff86b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -35,6 +35,7 @@ arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: fi=
les('stm32f100_soc.c'
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_so=
c.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_so=
c.c'))
 arm_common_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot=
01a.c'))
+arm_common_ss.add(when: 'CONFIG_STM32L496G_DISCO', if_true: files('stm32l496=
g-disco.c'))
 arm_common_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_so=
c.c'))
 arm_common_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqm=
p.c', 'xlnx-zcu102.c'))
 arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c'=
, 'xlnx-versal-virt.c'))
diff --git a/hw/arm/stm32l496g-disco.c b/hw/arm/stm32l496g-disco.c
new file mode 100644
index 0000000000..9f3ad6e043
--- /dev/null
+++ b/hw/arm/stm32l496g-disco.c
@@ -0,0 +1,95 @@
+/*
+ * STM32L496G-DISCO Discovery Kit machine
+ *
+ * Copyright (c) 2026 EXALT Technologies
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * The reference used is the STMicroelectronics UM2160 user manual for the
+ * Discovery kit with STM32L496AG MCU and the RM0351 reference manual.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/armv7m.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/stm32l4x5_soc.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/irq.h"
+#include "hw/ssi/ssi.h"
+#include "system/blockdev.h"
+
+#define TYPE_STM32L496G_DISCO MACHINE_TYPE_NAME("stm32l496g-disco")
+OBJECT_DECLARE_SIMPLE_TYPE(Stm32l496gDiscoMachineState,
+                           STM32L496G_DISCO)
+
+typedef struct Stm32l496gDiscoMachineState {
+    MachineState parent_obj;
+
+    Stm32l4x5SocState soc;
+} Stm32l496gDiscoMachineState;
+
+static void stm32l496g_disco_init(MachineState *machine)
+{
+    Stm32l496gDiscoMachineState *s =3D STM32L496G_DISCO(machine);
+    const Stm32l4x5SocClass *sc;
+    DeviceState *flash;
+    DriveInfo *dinfo;
+    BusState *bus;
+    qemu_irq flash_cs;
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_STM32L496XG_SOC);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+
+    bus =3D qdev_get_child_bus(DEVICE(&s->soc.quadspi), "ssi");
+    flash =3D qdev_new("mx25r6435");
+    dinfo =3D drive_get(IF_MTD, 0, 0);
+    if (dinfo) {
+        qdev_prop_set_drive_err(flash, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+    }
+    qdev_realize_and_unref(flash, bus, &error_fatal);
+
+    flash_cs =3D qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(&s->soc.quadspi), "cs", 0,
+                                flash_cs);
+    qemu_set_irq(flash_cs, 1);
+
+    sc =3D STM32L4X5_SOC_GET_CLASS(&s->soc);
+    armv7m_load_kernel(s->soc.armv7m.cpu, machine->kernel_filename, 0,
+                       sc->flash_size);
+}
+
+static void stm32l496g_disco_machine_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    static const char *machine_valid_cpu_types[] =3D {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+
+    mc->desc =3D "STM32L496G-DISCO Discovery Kit (Cortex-M4)";
+    mc->init =3D stm32l496g_disco_init;
+    mc->valid_cpu_types =3D machine_valid_cpu_types;
+
+    /* SRAM is allocated by the SoC. */
+    mc->default_ram_size =3D 0;
+}
+
+static void stm32l496g_disco_machine_register_types(void)
+{
+    static const TypeInfo machine_type =3D {
+        .name =3D TYPE_STM32L496G_DISCO,
+        .parent =3D TYPE_MACHINE,
+        .instance_size =3D sizeof(Stm32l496gDiscoMachineState),
+        .class_init =3D stm32l496g_disco_machine_init,
+    };
+
+    type_register_static(&machine_type);
+}
+
+type_init(stm32l496g_disco_machine_register_types)
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index d91d18e88b..bd05a837fa 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -35,9 +35,7 @@
=20
 #define FLASH_BASE_ADDRESS 0x08000000
 #define SRAM1_BASE_ADDRESS 0x20000000
-#define SRAM1_SIZE (96 * KiB)
 #define SRAM2_BASE_ADDRESS 0x10000000
-#define SRAM2_SIZE (32 * KiB)
=20
 #define EXTI_ADDR 0x40010400
 #define SYSCFG_ADDR 0x40010000
@@ -189,13 +187,15 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash=
);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
=20
-    if (!memory_region_init_ram(&s->sram1, OBJECT(dev_soc), "SRAM1", SRAM1_S=
IZE,
+    if (!memory_region_init_ram(&s->sram1, OBJECT(dev_soc), "SRAM1",
+                                sc->sram1_size,
                                 errp)) {
         return;
     }
     memory_region_add_subregion(system_memory, SRAM1_BASE_ADDRESS, &s->sram1=
);
=20
-    if (!memory_region_init_ram(&s->sram2, OBJECT(dev_soc), "SRAM2", SRAM2_S=
IZE,
+    if (!memory_region_init_ram(&s->sram2, OBJECT(dev_soc), "SRAM2",
+                                sc->sram2_size,
                                 errp)) {
         return;
     }
@@ -456,11 +456,15 @@ static void stm32l4x5_soc_class_init(ObjectClass *klass=
, const void *data)
 {
=20
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    Stm32l4x5SocClass *ssc =3D STM32L4X5_SOC_CLASS(klass);
=20
     dc->realize =3D stm32l4x5_soc_realize;
     /* Reason: Mapped at fixed location on the system bus */
     dc->user_creatable =3D false;
     /* No vmstate or reset required: device has no internal state */
+
+    ssc->sram1_size =3D 96 * KiB;
+    ssc->sram2_size =3D 32 * KiB;
 }
=20
 static void stm32l4x5xc_soc_class_init(ObjectClass *oc, const void *data)
@@ -484,6 +488,15 @@ static void stm32l4x5xg_soc_class_init(ObjectClass *oc, =
const void *data)
     ssc->flash_size =3D 1 * MiB;
 }
=20
+static void stm32l496xg_soc_class_init(ObjectClass *oc, const void *data)
+{
+    Stm32l4x5SocClass *ssc =3D STM32L4X5_SOC_CLASS(oc);
+
+    ssc->flash_size =3D 1 * MiB;
+    ssc->sram1_size =3D 256 * KiB;
+    ssc->sram2_size =3D 64 * KiB;
+}
+
 static const TypeInfo stm32l4x5_soc_types[] =3D {
     {
         .name           =3D TYPE_STM32L4X5XC_SOC,
@@ -497,6 +510,10 @@ static const TypeInfo stm32l4x5_soc_types[] =3D {
         .name           =3D TYPE_STM32L4X5XG_SOC,
         .parent         =3D TYPE_STM32L4X5_SOC,
         .class_init     =3D stm32l4x5xg_soc_class_init,
+    }, {
+        .name           =3D TYPE_STM32L496XG_SOC,
+        .parent         =3D TYPE_STM32L4X5_SOC,
+        .class_init     =3D stm32l496xg_soc_class_init,
     }, {
         .name           =3D TYPE_STM32L4X5_SOC,
         .parent         =3D TYPE_SYS_BUS_DEVICE,
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index 5b5e817ee7..a10bc10cb4 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -39,6 +39,7 @@
 #define TYPE_STM32L4X5XC_SOC "stm32l4x5xc-soc"
 #define TYPE_STM32L4X5XE_SOC "stm32l4x5xe-soc"
 #define TYPE_STM32L4X5XG_SOC "stm32l4x5xg-soc"
+#define TYPE_STM32L496XG_SOC "stm32l496xg-soc"
 OBJECT_DECLARE_TYPE(Stm32l4x5SocState, Stm32l4x5SocClass, STM32L4X5_SOC)
=20
 #define NUM_EXTI_OR_GATES 4
@@ -71,6 +72,8 @@ struct Stm32l4x5SocClass {
     SysBusDeviceClass parent_class;
=20
     size_t flash_size;
+    size_t sram1_size;
+    size_t sram2_size;
 };
=20
 #endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 7994696086..29febd1a08 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -271,6 +271,7 @@ qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []=
) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) +=
 \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : [=
]) + \
+  (config_all_devices.has_key('CONFIG_STM32L496G_DISCO') ? ['stm32l496g-disc=
o-test'] : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-te=
st'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : [])=
 + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
diff --git a/tests/qtest/stm32l496g-disco-test.c b/tests/qtest/stm32l496g-dis=
co-test.c
new file mode 100644
index 0000000000..9529618fa7
--- /dev/null
+++ b/tests/qtest/stm32l496g-disco-test.c
@@ -0,0 +1,693 @@
+/*
+ * QTest testcase for the STM32L496G-DISCO machine
+ *
+ * Copyright (c) 2026 EXALT Technologies
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "qobject/qdict.h"
+
+#define QUADSPI_BASE 0xa0001000
+
+#define QUADSPI_CR  (QUADSPI_BASE + 0x00)
+#define QUADSPI_DCR (QUADSPI_BASE + 0x04)
+#define QUADSPI_SR  (QUADSPI_BASE + 0x08)
+#define QUADSPI_FCR (QUADSPI_BASE + 0x0c)
+#define QUADSPI_DLR (QUADSPI_BASE + 0x10)
+#define QUADSPI_CCR (QUADSPI_BASE + 0x14)
+#define QUADSPI_AR  (QUADSPI_BASE + 0x18)
+#define QUADSPI_DR  (QUADSPI_BASE + 0x20)
+#define QUADSPI_ABR (QUADSPI_BASE + 0x1c)
+#define DCR_FSIZE(bits) (((bits) - 1) << 16)
+
+#define CR_EN BIT(0)
+#define CR_ABORT BIT(1)
+#define CR_TEIE BIT(16)
+#define CR_FTHRES(bytes) (((bytes) - 1) << 8)
+#define CR_TCIE BIT(17)
+#define CR_FTIE BIT(18)
+
+#define SR_TCF BIT(1)
+#define SR_TEF BIT(0)
+#define SR_FTF BIT(2)
+#define SR_BUSY BIT(5)
+#define SR_FLEVEL(sr) extract32((sr), 8, 5)
+
+#define FCR_CTCF BIT(1)
+
+#define CCR_IMODE_SINGLE         (1 << 8)
+#define CCR_ADMODE_SINGLE        (1 << 10)
+#define CCR_ADSIZE_24BIT         (2 << 12)
+#define CCR_DCYC(cycles)         ((cycles) << 18)
+#define CCR_DMODE_SINGLE         (1 << 24)
+#define CCR_FMODE_INDIRECT_READ  (1 << 26)
+#define CCR_ADMODE_DUAL          (2 << 10)
+#define CCR_ADMODE_QUAD          (3 << 10)
+#define CCR_DMODE_DUAL           (2 << 24)
+#define CCR_DMODE_QUAD           (3 << 24)
+#define CCR_ABMODE_QUAD          (3 << 14)
+#define FCR_ALL                  0x1b
+
+#define CMD_WRITE_ENABLE 0x06
+#define CMD_WRITE_DISABLE 0x04
+#define CMD_READ_STATUS   0x05
+#define CMD_READ          0x03
+#define CMD_PAGE_PROGRAM  0x02
+#define CMD_READ_ID       0x9f
+#define CMD_READ_SFDP     0x5a
+
+static QTestState *qts;
+
+static void qspi_command(uint8_t command)
+{
+    qtest_writel(qts, QUADSPI_FCR, FCR_CTCF);
+    qtest_writel(qts, QUADSPI_CCR, CCR_IMODE_SINGLE | command);
+}
+
+static void qspi_start_read(uint8_t command, uint32_t address,
+                            bool address_phase, unsigned int dummy_cycles,
+                            unsigned int length)
+{
+    uint32_t ccr =3D CCR_IMODE_SINGLE | CCR_DMODE_SINGLE |
+                   CCR_FMODE_INDIRECT_READ | command;
+
+    if (address_phase) {
+        ccr |=3D CCR_ADMODE_SINGLE | CCR_ADSIZE_24BIT;
+    }
+    ccr |=3D CCR_DCYC(dummy_cycles);
+
+    qtest_writel(qts, QUADSPI_FCR, FCR_CTCF);
+    qtest_writel(qts, QUADSPI_CCR, 0);
+    qtest_writel(qts, QUADSPI_DLR, length - 1);
+    qtest_writel(qts, QUADSPI_CCR, ccr);
+    if (address_phase) {
+        qtest_writel(qts, QUADSPI_AR, address);
+    }
+}
+
+static uint32_t qspi_read(uint8_t command, uint32_t address,
+                          bool address_phase, unsigned int dummy_cycles,
+                          unsigned int length)
+{
+    qspi_start_read(command, address, address_phase, dummy_cycles, length);
+    return qtest_readl(qts, QUADSPI_DR);
+}
+
+static void qspi_start_write(uint32_t address, unsigned int length)
+{
+    uint32_t ccr =3D CMD_PAGE_PROGRAM | CCR_IMODE_SINGLE |
+                   CCR_ADMODE_SINGLE | CCR_ADSIZE_24BIT |
+                   CCR_DMODE_SINGLE;
+
+    qspi_command(CMD_WRITE_ENABLE);
+    qtest_writel(qts, QUADSPI_FCR, FCR_CTCF);
+    qtest_writel(qts, QUADSPI_CCR, 0);
+    qtest_writel(qts, QUADSPI_AR, address);
+    qtest_writel(qts, QUADSPI_DLR, length - 1);
+    qtest_writel(qts, QUADSPI_CCR, ccr);
+}
+
+static void qspi_page_program(uint32_t address, uint32_t value)
+{
+    qspi_start_write(address, sizeof(value));
+    qtest_writel(qts, QUADSPI_DR, value);
+}
+
+static void test_quadspi_identification(void)
+{
+    uint32_t id =3D qspi_read(CMD_READ_ID, 0, false, 0, 3);
+
+    g_assert_cmphex(id & 0x00ffffff, =3D=3D, 0x001728c2);
+}
+
+static void test_quadspi_sfdp(void)
+{
+    uint32_t signature =3D qspi_read(CMD_READ_SFDP, 0, true, 8, 4);
+
+    g_assert_cmphex(signature, =3D=3D, 0x50444653);
+}
+
+static void test_quadspi_program_read(void)
+{
+    const uint32_t address =3D 0x100;
+    const uint32_t value =3D 0x5aa55aa5;
+    uint32_t actual;
+
+    qspi_page_program(address, value);
+    actual =3D qspi_read(CMD_READ, address, true, 0, sizeof(value));
+
+    g_assert_cmphex(actual, =3D=3D, value);
+}
+
+/* Verify FIFO capacity, RX backpressure, threshold IRQs, and byte ordering.=
 */
+static void test_quadspi_fifo_refill(void)
+{
+    const uint32_t address =3D 0x200;
+    const unsigned int length =3D 40;
+    uint32_t sr;
+
+    qspi_start_write(address, length);
+    for (unsigned int i =3D 0; i < length; i++) {
+        qtest_writeb(qts, QUADSPI_DR, i);
+    }
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_FTHRES(16) | CR_FTIE);
+    qspi_start_read(CMD_READ, address, true, 0, length);
+    sr =3D qtest_readl(qts, QUADSPI_SR);
+    g_assert_cmpuint(SR_FLEVEL(sr), =3D=3D, 16);
+    g_assert_true(sr & SR_BUSY);
+    g_assert_true(sr & SR_FTF);
+    g_assert_false(sr & SR_TCF);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_DR), =3D=3D, 0x03020100);
+    sr =3D qtest_readl(qts, QUADSPI_SR);
+    g_assert_cmpuint(SR_FLEVEL(sr), =3D=3D, 12);
+    g_assert_false(sr & SR_FTF);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, 4);
+    g_assert_cmpuint(SR_FLEVEL(qtest_readl(qts, QUADSPI_SR)), =3D=3D, 16);
+    g_assert_true(qtest_get_irq(qts, 0));
+    for (unsigned int i =3D 5; i < length; i++) {
+        g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, i);
+        sr =3D qtest_readl(qts, QUADSPI_SR);
+        g_assert_cmpuint(SR_FLEVEL(sr), <=3D, 16);
+        if (i + 1 < length) {
+            g_assert_true(sr & SR_BUSY);
+        }
+    }
+    g_assert_cmpuint(SR_FLEVEL(sr), =3D=3D, 0);
+    g_assert_true(sr & SR_TCF);
+    g_assert_false(sr & (SR_BUSY | SR_FTF));
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+}
+
+/* A short final RX fragment must remain readable below the FIFO threshold. =
*/
+static void test_quadspi_fifo_tail(void)
+{
+    uint32_t sr;
+
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_FTHRES(16) | CR_FTIE);
+    qspi_start_read(CMD_READ_ID, 0, false, 0, 3);
+    sr =3D qtest_readl(qts, QUADSPI_SR);
+    g_assert_cmpuint(SR_FLEVEL(sr), =3D=3D, 3);
+    g_assert_true(sr & SR_TCF);
+    g_assert_true(sr & SR_BUSY);
+    g_assert_true(sr & SR_FTF);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, QUADSPI_FCR, FCR_CTCF);
+    g_assert_cmphex(qtest_readw(qts, QUADSPI_DR), =3D=3D, 0x28c2);
+    g_assert_cmpuint(SR_FLEVEL(qtest_readl(qts, QUADSPI_SR)), =3D=3D, 1);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(qtest_readb(qts, QUADSPI_DR), =3D=3D, 0x17);
+    sr =3D qtest_readl(qts, QUADSPI_SR);
+    g_assert_false(sr & (SR_BUSY | SR_FTF | SR_TCF));
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, 0);
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+}
+
+/* Byte, halfword, and word accesses must preserve the FIFO byte sequence. */
+static void test_quadspi_fifo_mixed_access(void)
+{
+    qspi_start_write(0x300, 7);
+    qtest_writeb(qts, QUADSPI_DR, 0xa1);
+    qtest_writew(qts, QUADSPI_DR, 0xc3b2);
+    qtest_writel(qts, QUADSPI_DR, 0x07f6e5d4);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    g_assert_cmpuint(SR_FLEVEL(qtest_readl(qts, QUADSPI_SR)), =3D=3D, 0);
+    qspi_start_read(CMD_READ, 0x300, true, 0, 7);
+    g_assert_cmphex(qtest_readb(qts, QUADSPI_DR), =3D=3D, 0xa1);
+    g_assert_cmphex(qtest_readw(qts, QUADSPI_DR), =3D=3D, 0xc3b2);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_DR), =3D=3D, 0x07f6e5d4);
+}
+
+/* Extra bytes in a final word write must not be programmed beyond DLR. */
+static void test_quadspi_fifo_write_excess(void)
+{
+    qspi_start_write(0x400, 3);
+    qtest_writel(qts, QUADSPI_DR, 0x44332211);
+    g_assert_cmpuint(SR_FLEVEL(qtest_readl(qts, QUADSPI_SR)), =3D=3D, 0);
+    g_assert_cmphex(qspi_read(CMD_READ, 0x400, true, 0, 4), =3D=3D, 0xff3322=
11);
+}
+
+/* Aborting a paused RX transfer must discard its FIFO and permit a new read=
. */
+static void test_quadspi_fifo_abort(void)
+{
+    uint32_t sr;
+
+    qspi_start_read(CMD_READ, 0x200, true, 0, 40);
+    g_assert_cmpuint(SR_FLEVEL(qtest_readl(qts, QUADSPI_SR)), =3D=3D, 16);
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_ABORT);
+    sr =3D qtest_readl(qts, QUADSPI_SR);
+    g_assert_cmpuint(SR_FLEVEL(sr), =3D=3D, 0);
+    g_assert_false(sr & (SR_BUSY | SR_FTF));
+    g_assert_true(sr & SR_TCF);
+    g_assert_false(qtest_readl(qts, QUADSPI_CR) & CR_ABORT);
+    g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, 0);
+    g_assert_cmphex(qspi_read(CMD_READ_ID, 0, false, 0, 3), =3D=3D, 0x001728=
c2);
+}
+
+/* Reset must discard buffered RX data and deassert the threshold interrupt.=
 */
+static void test_quadspi_fifo_reset(void)
+{
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_FTIE);
+    qspi_start_read(CMD_READ, 0x200, true, 0, 40);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_CR), =3D=3D, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_DLR), =3D=3D, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(23));
+    g_assert_cmphex(qspi_read(CMD_READ_ID, 0, false, 0, 3), =3D=3D, 0x001728=
c2);
+}
+
+/* Disabled command writes must not set the flash's write-enable latch. */
+static void test_quadspi_disabled_command(void)
+{
+    qspi_command(CMD_WRITE_DISABLE);
+    qtest_writel(qts, QUADSPI_FCR, FCR_CTCF);
+    qtest_writel(qts, QUADSPI_CR, CR_TCIE | CR_FTIE);
+    qspi_command(CMD_WRITE_ENABLE);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_CCR), =3D=3D,
+                    CCR_IMODE_SINGLE | CMD_WRITE_ENABLE);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    g_assert_cmphex(qspi_read(CMD_READ_STATUS, 0, false, 0, 1) & 2, =3D=3D, =
0);
+    qspi_command(CMD_WRITE_ENABLE);
+    g_assert_cmphex(qspi_read(CMD_READ_STATUS, 0, false, 0, 1) & 2, =3D=3D, =
2);
+    qspi_command(CMD_WRITE_DISABLE);
+}
+
+/* CCR, AR, and DR accesses must not exchange flash data while disabled. */
+static void test_quadspi_disabled_data(void)
+{
+    qtest_writel(qts, QUADSPI_FCR, FCR_CTCF);
+    qtest_writel(qts, QUADSPI_CR, CR_TCIE | CR_FTIE);
+    qspi_start_read(CMD_READ_ID, 0, false, 0, 3);
+    g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+    qspi_start_read(CMD_READ, 0x500, true, 0, 4);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_AR), =3D=3D, 0x500);
+    g_assert_cmpuint(qtest_readl(qts, QUADSPI_DLR), =3D=3D, 3);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_DR), =3D=3D, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+
+    qspi_start_write(0x500, 4);
+    qtest_writel(qts, QUADSPI_DR, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    qtest_writel(qts, QUADSPI_DR, 0x12345678);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    g_assert_cmphex(qspi_read(CMD_READ, 0x500, true, 0, 4), =3D=3D, 0xffffff=
ff);
+    g_assert_cmphex(qspi_read(CMD_READ_ID, 0, false, 0, 3), =3D=3D, 0x001728=
c2);
+}
+
+/* Disable clears RX state without synthesizing completion or replaying CCR.=
 */
+static void test_quadspi_disable_read(void)
+{
+    uint32_t ccr;
+
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_FTIE | CR_TCIE);
+    qspi_start_read(CMD_READ, 0, true, 0, 40);
+    ccr =3D qtest_readl(qts, QUADSPI_CCR);
+    g_assert_cmpuint(SR_FLEVEL(qtest_readl(qts, QUADSPI_SR)), =3D=3D, 16);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, QUADSPI_CR, CR_FTIE | CR_TCIE);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_CCR), =3D=3D, ccr);
+    g_assert_cmpuint(qtest_readl(qts, QUADSPI_DLR), =3D=3D, 39);
+    g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, 0);
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_FTIE | CR_TCIE);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qspi_start_read(CMD_READ_ID, 0, false, 0, 3);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    qtest_writel(qts, QUADSPI_CR, CR_TCIE);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, SR_TCF);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, QUADSPI_FCR, FCR_CTCF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+}
+
+/* Disable stops a partial write without replaying data on re-enable. */
+static void test_quadspi_disable_write(void)
+{
+    uint32_t ccr;
+
+    qspi_start_write(0x600, 4);
+    qtest_writeb(qts, QUADSPI_DR, 0xa5);
+    ccr =3D qtest_readl(qts, QUADSPI_CCR);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_BUSY);
+    qtest_writel(qts, QUADSPI_CR, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_SR), =3D=3D, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_CCR), =3D=3D, ccr);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_AR), =3D=3D, 0x600);
+    qtest_writel(qts, QUADSPI_DR, 0);
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    qtest_writel(qts, QUADSPI_DR, 0);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    g_assert_cmphex(qspi_read(CMD_READ, 0x600, true, 0, 4), =3D=3D, 0xffffff=
a5);
+}
+
+/* Reject out-of-range reads/writes before exchanging any flash payload. */
+static void test_quadspi_address_bounds(void)
+{
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(12));
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_TEIE);
+    qspi_start_read(CMD_READ, 0x1000, true, 0, 1);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TEF);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & (SR_BUSY | SR_TCF));
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writeb(qts, QUADSPI_FCR, SR_TEF);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qspi_start_read(CMD_READ, 0xfff, true, 0, 2);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TEF);
+    qtest_writel(qts, QUADSPI_FCR, FCR_ALL);
+    qspi_start_write(0xfff, 2);
+    qtest_writew(qts, QUADSPI_DR, 0x1234);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TEF);
+    qtest_writel(qts, QUADSPI_FCR, FCR_ALL);
+    g_assert_cmphex(qspi_read(CMD_READ, 0xffc, true, 0, 4), =3D=3D, 0xffffff=
ff);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(32));
+    qspi_start_read(0x13, UINT32_MAX, true, 0, 2);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TEF);
+    qtest_writel(qts, QUADSPI_FCR, FCR_ALL);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(23));
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+}
+
+/* Undefined length ends at FSIZE, or continues until abort for FSIZE =3D 31=
. */
+static void test_quadspi_undefined_length(void)
+{
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(12));
+    qspi_start_read(CMD_READ, 0xffc, true, 0, 0);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    g_assert_cmpuint(SR_FLEVEL(qtest_readl(qts, QUADSPI_SR)), =3D=3D, 4);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_DR), =3D=3D, 0xffffffff);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_BUSY);
+    qspi_start_write(0xffc, 0);
+    qtest_writel(qts, QUADSPI_DR, 0x78563412);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    g_assert_cmphex(qspi_read(CMD_READ, 0xffc, true, 0, 4), =3D=3D, 0x785634=
12);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(32));
+    qspi_start_read(CMD_READ, 0, true, 0, 0);
+    for (unsigned int i =3D 0; i < 12; i++) {
+        qtest_readl(qts, QUADSPI_DR);
+        g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_BUSY);
+        g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    }
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_ABORT);
+    qspi_start_write(0x900, 0);
+    qtest_writel(qts, QUADSPI_DR, 0x12345678);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_BUSY);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_ABORT);
+    g_assert_cmphex(qspi_read(CMD_READ, 0x900, true, 0, 4), =3D=3D, 0x123456=
78);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(23));
+}
+
+/* Subword register accesses preserve adjacent bytes and write-one clears. */
+static void test_quadspi_partial_registers(void)
+{
+    qtest_writel(qts, QUADSPI_ABR, 0x12345678);
+    qtest_writeb(qts, QUADSPI_ABR + 1, 0xab);
+    qtest_writew(qts, QUADSPI_ABR + 2, 0xcdef);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_ABR), =3D=3D, 0xcdefab78);
+    g_assert_cmphex(qtest_readb(qts, QUADSPI_ABR + 1), =3D=3D, 0xab);
+    g_assert_cmphex(qtest_readw(qts, QUADSPI_ABR + 2), =3D=3D, 0xcdef);
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_TCIE);
+    qtest_writeb(qts, QUADSPI_CR + 1, 0x03);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_CR), =3D=3D,
+                    CR_EN | CR_TCIE | CR_FTHRES(4));
+    qspi_command(CMD_WRITE_DISABLE);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    qtest_writeb(qts, QUADSPI_FCR + 1, 0xff);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    qtest_writeb(qts, QUADSPI_FCR, FCR_CTCF);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+}
+
+/* A busy controller must not reinterpret its active command configuration. =
*/
+static void test_quadspi_busy_registers(void)
+{
+    uint32_t ccr;
+
+    qspi_start_read(CMD_READ, 0, true, 0, 40);
+    ccr =3D qtest_readl(qts, QUADSPI_CCR);
+    qtest_writel(qts, QUADSPI_CCR, CCR_IMODE_SINGLE | CMD_WRITE_ENABLE);
+    qtest_writel(qts, QUADSPI_DLR, 1);
+    qtest_writel(qts, QUADSPI_AR, 0x800);
+    qtest_writel(qts, QUADSPI_DCR, 0);
+    qtest_writel(qts, QUADSPI_ABR, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_CCR), =3D=3D, ccr);
+    g_assert_cmpuint(qtest_readl(qts, QUADSPI_DLR), =3D=3D, 39);
+    g_assert_cmpuint(qtest_readl(qts, QUADSPI_AR), =3D=3D, 0);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_DCR), =3D=3D, DCR_FSIZE(23));
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_FTHRES(16) | CR_FTIE);
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_CR), =3D=3D, CR_EN | CR_FTIE);
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_ABORT);
+}
+
+/* Deferred modes must never issue an accidental WREN command. */
+static void test_quadspi_unsupported_modes(void)
+{
+    static const uint32_t configs[] =3D {
+        (2 << 26), (3 << 26), BIT(28), BIT(31),
+    };
+
+    qspi_command(CMD_WRITE_DISABLE);
+    for (unsigned int i =3D 0; i < ARRAY_SIZE(configs); i++) {
+        qtest_writel(qts, QUADSPI_FCR, FCR_ALL);
+        qtest_writel(qts, QUADSPI_CCR,
+                     configs[i] | CCR_IMODE_SINGLE | CMD_WRITE_ENABLE);
+        g_assert_false(qtest_readl(qts, QUADSPI_SR) & (SR_TCF | SR_BUSY));
+        g_assert_cmphex(qspi_read(CMD_READ_STATUS, 0, false, 0, 1) & 2, =3D=
=3D, 0);
+    }
+    qtest_writel(qts, QUADSPI_CR, CR_EN | BIT(6));
+    qtest_writel(qts, QUADSPI_FCR, FCR_ALL);
+    qtest_writel(qts, QUADSPI_CCR, CCR_IMODE_SINGLE | CMD_WRITE_ENABLE);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & (SR_TCF | SR_BUSY));
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    g_assert_cmphex(qspi_read(CMD_READ_STATUS, 0, false, 0, 1) & 2, =3D=3D, =
0);
+}
+
+/* Exercise fast-read opcodes and single/dual/quad byte prefixes. */
+static void test_quadspi_lane_modes(void)
+{
+    static const struct {
+        uint8_t opcode;
+        uint32_t admode;
+        uint32_t dmode;
+        unsigned int dummy;
+        bool alternate;
+    } modes[] =3D {
+        { 0x0b, CCR_ADMODE_SINGLE, CCR_DMODE_SINGLE, 8, false },
+        { 0x3b, CCR_ADMODE_SINGLE, CCR_DMODE_DUAL, 8, false },
+        { 0x6b, CCR_ADMODE_SINGLE, CCR_DMODE_QUAD, 8, false },
+        { 0xbb, CCR_ADMODE_DUAL, CCR_DMODE_DUAL, 4, false },
+        { 0xeb, CCR_ADMODE_QUAD, CCR_DMODE_QUAD, 6, false },
+        { 0xeb, CCR_ADMODE_QUAD, CCR_DMODE_QUAD, 4, true },
+    };
+
+    qspi_page_program(0x800, 0x76543210);
+    for (unsigned int i =3D 0; i < ARRAY_SIZE(modes); i++) {
+        uint32_t ccr =3D CCR_IMODE_SINGLE | CCR_ADSIZE_24BIT |
+                       CCR_FMODE_INDIRECT_READ | modes[i].admode |
+                       modes[i].dmode | CCR_DCYC(modes[i].dummy) |
+                       modes[i].opcode;
+
+        qtest_writel(qts, QUADSPI_ABR, 0);
+        if (modes[i].alternate) {
+            ccr |=3D CCR_ABMODE_QUAD;
+        }
+        qtest_writel(qts, QUADSPI_DLR, 3);
+        qtest_writel(qts, QUADSPI_CCR, ccr);
+        qtest_writel(qts, QUADSPI_AR, 0x800);
+        g_assert_cmphex(qtest_readl(qts, QUADSPI_DR), =3D=3D, 0x76543210);
+    }
+}
+
+static void qspi_wait_migration(QTestState *state)
+{
+    int64_t deadline =3D g_get_monotonic_time() + 10 * G_TIME_SPAN_SECOND;
+
+    do {
+        QDict *response =3D qtest_qmp(state, "{'execute': 'query-migrate'}");
+        QDict *result =3D qdict_get_qdict(response, "return");
+        const char *status =3D qdict_get_str(result, "status");
+        bool complete =3D !strcmp(status, "completed");
+
+        if (!strcmp(status, "failed")) {
+            g_error("Migration failed: %s",
+                    qdict_get_try_str(result, "error-desc"));
+        }
+        qobject_unref(response);
+        if (complete) {
+            return;
+        }
+        g_usleep(1000);
+    } while (g_get_monotonic_time() < deadline);
+    g_error("Migration did not complete within 10 seconds");
+}
+
+static void qspi_migrate(void)
+{
+    char *path =3D NULL;
+    int fd =3D g_file_open_tmp("qspi-migration-XXXXXX", &path, NULL);
+    g_autofree char *uri =3D g_strdup_printf("file:%s", path);
+    QTestState *source =3D qts;
+
+    g_assert_cmpint(fd, >=3D, 0);
+    close(fd);
+    qtest_qmp_assert_success(source,
+        "{'execute': 'migrate', 'arguments': {'uri': %s}}", uri);
+    qspi_wait_migration(source);
+    qts =3D qtest_init("-machine stm32l496g-disco -incoming defer");
+    qtest_qmp_assert_success(qts,
+        "{'execute': 'migrate-incoming', 'arguments': {'uri': %s}}", uri);
+    qspi_wait_migration(qts);
+    qtest_quit(source);
+    unlink(path);
+    g_free(path);
+}
+
+/* SFDP data exposes lost FIFO bytes or a reset flash-parser cursor. */
+static void test_quadspi_migration_read(void)
+{
+    QTestState *original =3D qts;
+    uint8_t expected[40];
+
+    qts =3D qtest_init("-machine stm32l496g-disco");
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(23));
+    qspi_start_read(CMD_READ_SFDP, 0, true, 8, sizeof(expected));
+    for (unsigned int i =3D 0; i < sizeof(expected); i++) {
+        expected[i] =3D qtest_readb(qts, QUADSPI_DR);
+    }
+    qspi_start_read(CMD_READ_SFDP, 0, true, 8, sizeof(expected));
+    for (unsigned int i =3D 0; i < 3; i++) {
+        g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, expected[i]);
+    }
+    qspi_migrate();
+    for (unsigned int i =3D 3; i < sizeof(expected); i++) {
+        g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, expected[i]);
+    }
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_BUSY);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(32));
+    qspi_start_read(CMD_READ_SFDP, 0, true, 8, 0);
+    for (unsigned int i =3D 0; i < 3; i++) {
+        g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, expected[i]);
+    }
+    qspi_migrate();
+    for (unsigned int i =3D 3; i < sizeof(expected); i++) {
+        g_assert_cmpuint(qtest_readb(qts, QUADSPI_DR), =3D=3D, expected[i]);
+    }
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_BUSY);
+    g_assert_false(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    qtest_writel(qts, QUADSPI_CR, CR_EN | CR_ABORT);
+    qtest_quit(qts);
+    qts =3D original;
+}
+
+/* Restore an unread final fragment and an in-flight register write. */
+static void test_quadspi_migration_write(void)
+{
+    QTestState *original =3D qts;
+
+    qts =3D qtest_init("-machine stm32l496g-disco");
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(23));
+    qspi_start_read(CMD_READ_ID, 0, false, 0, 3);
+    qspi_migrate();
+    g_assert_cmphex(qtest_readl(qts, QUADSPI_DR), =3D=3D, 0x001728c2);
+    qspi_command(CMD_WRITE_ENABLE);
+    qtest_writel(qts, QUADSPI_DLR, 1);
+    qtest_writel(qts, QUADSPI_CCR,
+                 CCR_IMODE_SINGLE | CCR_DMODE_SINGLE | 0x01);
+    qspi_migrate();
+    qtest_writeb(qts, QUADSPI_DR, 0x40);
+    qspi_migrate();
+    qtest_writeb(qts, QUADSPI_DR, 0);
+    g_assert_true(qtest_readl(qts, QUADSPI_SR) & SR_TCF);
+    g_assert_cmphex(qspi_read(CMD_READ_STATUS, 0, false, 0, 1) & 0x40,
+                    =3D=3D, 0x40);
+    qtest_quit(qts);
+    qts =3D original;
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qts =3D qtest_init("-machine stm32l496g-disco");
+    qtest_irq_intercept_out_named(qts, "/machine/soc/quadspi",
+                                  "sysbus-irq");
+    qtest_writel(qts, QUADSPI_CR, CR_EN);
+    qtest_writel(qts, QUADSPI_DCR, DCR_FSIZE(23));
+
+    qtest_add_func("stm32l496g-disco/quadspi/identification",
+                   test_quadspi_identification);
+    qtest_add_func("stm32l496g-disco/quadspi/sfdp", test_quadspi_sfdp);
+    qtest_add_func("stm32l496g-disco/quadspi/program-read",
+                   test_quadspi_program_read);
+    qtest_add_func("stm32l496g-disco/quadspi/fifo-refill",
+                   test_quadspi_fifo_refill);
+    qtest_add_func("stm32l496g-disco/quadspi/fifo-tail",
+                   test_quadspi_fifo_tail);
+    qtest_add_func("stm32l496g-disco/quadspi/fifo-mixed-access",
+                   test_quadspi_fifo_mixed_access);
+    qtest_add_func("stm32l496g-disco/quadspi/fifo-write-excess",
+                   test_quadspi_fifo_write_excess);
+    qtest_add_func("stm32l496g-disco/quadspi/fifo-abort",
+                   test_quadspi_fifo_abort);
+    qtest_add_func("stm32l496g-disco/quadspi/fifo-reset",
+                   test_quadspi_fifo_reset);
+    qtest_add_func("stm32l496g-disco/quadspi/disabled-command",
+                   test_quadspi_disabled_command);
+    qtest_add_func("stm32l496g-disco/quadspi/disabled-data",
+                   test_quadspi_disabled_data);
+    qtest_add_func("stm32l496g-disco/quadspi/disable-read",
+                   test_quadspi_disable_read);
+    qtest_add_func("stm32l496g-disco/quadspi/disable-write",
+                   test_quadspi_disable_write);
+    qtest_add_func("stm32l496g-disco/quadspi/address-bounds",
+                   test_quadspi_address_bounds);
+    qtest_add_func("stm32l496g-disco/quadspi/undefined-length",
+                   test_quadspi_undefined_length);
+    qtest_add_func("stm32l496g-disco/quadspi/partial-registers",
+                   test_quadspi_partial_registers);
+    qtest_add_func("stm32l496g-disco/quadspi/busy-registers",
+                   test_quadspi_busy_registers);
+    qtest_add_func("stm32l496g-disco/quadspi/unsupported-modes",
+                   test_quadspi_unsupported_modes);
+    qtest_add_func("stm32l496g-disco/quadspi/lane-modes",
+                   test_quadspi_lane_modes);
+    qtest_add_func("stm32l496g-disco/quadspi/migration-read",
+                   test_quadspi_migration_read);
+    qtest_add_func("stm32l496g-disco/quadspi/migration-write",
+                   test_quadspi_migration_write);
+
+    ret =3D g_test_run();
+    qtest_quit(qts);
+
+    return ret;
+}
--=20
2.49.1

