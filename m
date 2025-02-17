Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9A1C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk48n-00014Z-DD; Mon, 17 Feb 2025 11:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tk48m-0000ys-1Q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tk48i-0007HP-Lr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsG5WkBUSHhnlbbV7Wp53MqkLhuAKX+CBzyXQNBeBUw=;
 b=P3QTpfWgTAb+yHBXUpEsyAPh/uyUL8hXeEUYQnfUfUU1lNPQFyNYNU2wYqdwKT44oWC9cM
 RP+1Ec9G2HIZn3jgxTqSBHyA/0F2nYsBLPFE/Pe4P74hotFH1GYG7+0rzsNYSXaVU79IF2
 BYUa6QlKRffBbUa259nLHSHkjmPIHqQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-XsVANGnrPHKagJHa6CkQuQ-1; Mon,
 17 Feb 2025 11:38:30 -0500
X-MC-Unique: XsVANGnrPHKagJHa6CkQuQ-1
X-Mimecast-MFC-AGG-ID: XsVANGnrPHKagJHa6CkQuQ_1739810308
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B15F01800268; Mon, 17 Feb 2025 16:38:26 +0000 (UTC)
Received: from gezellig.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38FD519560AB; Mon, 17 Feb 2025 16:38:14 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, sebott@redhat.com, maz@kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Eric Auger <eric.auger@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH v2 3/3] docs: Fix "Arm" capitalization
Date: Mon, 17 Feb 2025 22:07:29 +0530
Message-ID: <20250217163732.3718617-4-kchamart@redhat.com>
In-Reply-To: <20250217163732.3718617-1-kchamart@redhat.com>
References: <20250217163732.3718617-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

This is based on Peter's suggestion here[1].

I simply addrressed the occurrences that I found with `git grep "ARM "`
in the docs/ directory.  I didn't touch stuff like these "StrongARM",
ARM926EJ-S, ARM1176JZS, etc.  Related commit[2].

[1] https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg05137.html
    - docs/cpu-features: Update "PAuth" (Pointer Authentication) details

[2] 6fe6d6c9a9 (docs: Be consistent about capitalization of 'Arm',
    2020-03-09)

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 docs/devel/testing/qgraph.rst        |  8 ++++----
 docs/devel/vfio-iommufd.rst          |  2 +-
 docs/specs/fsi.rst                   |  2 +-
 docs/system/arm/aspeed.rst           |  6 +++---
 docs/system/arm/b-l475e-iot01a.rst   |  2 +-
 docs/system/arm/nrf.rst              |  4 ++--
 docs/system/arm/nuvoton.rst          |  4 ++--
 docs/system/arm/stm32.rst            | 12 ++++++------
 docs/system/arm/xlnx-versal-virt.rst | 12 ++++++------
 docs/system/arm/xlnx-zynq.rst        |  2 +-
 docs/system/guest-loader.rst         |  2 +-
 11 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/docs/devel/testing/qgraph.rst b/docs/devel/testing/qgraph.rst
index 43342d9d65..30ff055fae 100644
--- a/docs/devel/testing/qgraph.rst
+++ b/docs/devel/testing/qgraph.rst
@@ -8,7 +8,7 @@ take care of booting QEMU with the right machine and devices.
 This makes each test "hardcoded" for a specific configuration, reducing
 the possible coverage that it can reach.
 
-For example, the sdhci device is supported on both x86_64 and ARM boards,
+For example, the sdhci device is supported on both x86_64 and Arm boards,
 therefore a generic sdhci test should test all machines and drivers that
 support that device.
 Using only libqos APIs, the test has to manually take care of
@@ -195,7 +195,7 @@ there.
 The ``arm/raspi2b`` machine node is listed as "UNAVAILABLE". Although it is
 reachable from the root via '' -> 'arm/raspi2b' the node is unavailable because
 the QEMU binary did not list it when queried by the framework. This is expected
-because we used the ``qemu-system-x86_64`` binary which does not support ARM
+because we used the ``qemu-system-x86_64`` binary which does not support Arm
 machine types.
 
 If a test is unexpectedly listed as "UNAVAILABLE", first check that the "ALL
@@ -214,9 +214,9 @@ Here we continue the ``sdhci`` use case, with the following scenario:
 
 - ``sdhci-test`` aims to test the ``read[q,w], writeq`` functions
   offered by the ``sdhci`` drivers.
-- The current ``sdhci`` device is supported by both ``x86_64/pc`` and ``ARM``
+- The current ``sdhci`` device is supported by both ``x86_64/pc`` and ``Arm``
   (in this example we focus on the ``arm-raspi2b``) machines.
-- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for ``ARM`` and
+- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for ``Arm`` and
   ``QSDHCI_PCI`` for ``x86_64/pc``. Both implement the
   ``read[q,w], writeq`` functions.
 
diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..fe8a7365e3 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -122,7 +122,7 @@ container:
 Supported platform
 ==================
 
-Supports x86, ARM and s390x currently.
+Supports x86, Arm, and s390x currently.
 
 Caveats
 =======
diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
index af87822531..f7d86d3e37 100644
--- a/docs/specs/fsi.rst
+++ b/docs/specs/fsi.rst
@@ -40,7 +40,7 @@ for the implementation are: (see the `FSI specification`_ for more details)
    MMIO-mapping of the CFAM address straight onto a sub-region of the OPB
    address space.
 
-5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in the
+5. An APB-to-OPB bridge enabling access to the OPB from the Arm core in the
    AST2600. Hardware limitations prevent the OPB from being directly mapped
    into APB, so all accesses are indirect through the bridge.
 
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index fa4aa28eef..42096fb941 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -5,8 +5,8 @@ The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
 Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
 AST2500 with an ARM1176JZS CPU (800MHz), the AST2600
-with dual cores ARM Cortex-A7 CPUs (1.2GHz) and more recently the AST2700
-with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz)
+with dual cores Arm Cortex-A7 CPUs (1.2GHz) and more recently the AST2700
+with quad cores Arm Cortex-A35 64 bits CPUs (1.6GHz)
 
 The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
 etc.
@@ -275,7 +275,7 @@ Aspeed minibmc family boards (``ast1030-evb``)
 
 The QEMU Aspeed machines model mini BMCs of various Aspeed evaluation
 boards. They are based on different releases of the
-Aspeed SoC : the AST1030 integrating an ARM Cortex M4F CPU (200MHz).
+Aspeed SoC : the AST1030 integrating an Arm Cortex M4F CPU (200MHz).
 
 The SoC comes with SRAM, SPI, I2C, etc.
 
diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
index 2adcc4b4c1..7f891719d5 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -2,7 +2,7 @@ B-L475E-IOT01A IoT Node (``b-l475e-iot01a``)
 ============================================
 
 The B-L475E-IOT01A IoT Node uses the STM32L475VG SoC which is based on
-ARM Cortex-M4F core. It is part of STMicroelectronics
+Arm Cortex-M4F core. It is part of STMicroelectronics
 :doc:`STM32 boards </system/arm/stm32>` and more specifically the STM32L4
 ultra-low power series. The STM32L4x5 chip runs at up to 80 MHz and
 integrates 128 KiB of SRAM and up to 1MiB of Flash. The B-L475E-IOT01A board
diff --git a/docs/system/arm/nrf.rst b/docs/system/arm/nrf.rst
index eda87bd760..e0ea6a8b7e 100644
--- a/docs/system/arm/nrf.rst
+++ b/docs/system/arm/nrf.rst
@@ -1,7 +1,7 @@
 Nordic nRF boards (``microbit``)
 ================================
 
-The `Nordic nRF`_ chips are a family of ARM-based System-on-Chip that
+The `Nordic nRF`_ chips are a family of Arm-based System-on-Chip that
 are designed to be used for low-power and short-range wireless solutions.
 
 .. _Nordic nRF: https://www.nordicsemi.com/Products
@@ -18,7 +18,7 @@ supported by QEMU.
 Supported devices
 -----------------
 
- * ARM Cortex-M0 (ARMv6-M)
+ * Arm Cortex-M0 (ARMv6-M)
  * Serial ports (UART)
  * Clock controller
  * Timers
diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 05059378e5..e0da2297ff 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -1,9 +1,9 @@
 Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
 =====================================================================================================
 
-The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
+The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of Arm-based SoCs that are
 designed to be used as Baseboard Management Controllers (BMCs) in various
-servers. They all feature one or two ARM Cortex-A9 CPU cores, as well as an
+servers. They all feature one or two Arm Cortex-A9 CPU cores, as well as an
 assortment of peripherals targeted for either Enterprise or Data Center /
 Hyperscale applications. The former is a superset of the latter, so NPCM750 has
 all the peripherals of NPCM730 and more.
diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 511e3eb9ac..381d2c4386 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -1,24 +1,24 @@
 STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``olimex-stm32-h405``, ``stm32vldiscovery``)
 ===============================================================================================================
 
-The `STM32`_ chips are a family of 32-bit ARM-based microcontroller by
+The `STM32`_ chips are a family of 32-bit Arm-based microcontroller by
 STMicroelectronics.
 
 .. _STM32: https://www.st.com/en/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus.html
 
-The STM32F1 series is based on ARM Cortex-M3 core. The following machines are
+The STM32F1 series is based on Arm Cortex-M3 core. The following machines are
 based on this chip :
 
 - ``stm32vldiscovery``  STM32VLDISCOVERY board with STM32F100RBT6 microcontroller
 
-The STM32F2 series is based on ARM Cortex-M3 core. The following machines are
+The STM32F2 series is based on Arm Cortex-M3 core. The following machines are
 based on this chip :
 
 - ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontroller
 
-The STM32F4 series is based on ARM Cortex-M4F core, as well as the STM32L4
+The STM32F4 series is based on Arm Cortex-M4F core, as well as the STM32L4
 ultra-low-power series. The STM32F4 series is pin-to-pin compatible with STM32F2 series.
-The following machines are based on this ARM Cortex-M4F chip :
+The following machines are based on this Arm Cortex-M4F chip :
 
 - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller
 - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcontroller
@@ -29,7 +29,7 @@ There are many other STM32 series that are currently not supported by QEMU.
 Supported devices
 -----------------
 
- * ARM Cortex-M3, Cortex M4F
+ * Arm Cortex-M3, Cortex M4F
  * Analog to Digital Converter (ADC)
  * EXTI interrupt
  * Serial ports (USART)
diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index c5f35f28e4..1b3a0ad6a5 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -19,12 +19,12 @@ limitations. Currently, we support the following cores and devices:
 
 Implemented CPU cores:
 
-- 2 ACPUs (ARM Cortex-A72)
+- 2 ACPUs (Arm Cortex-A72)
 
 Implemented devices:
 
-- Interrupt controller (ARM GICv3)
-- 2 UARTs (ARM PL011)
+- Interrupt controller (Arm GICv3)
+- 2 UARTs (Arm PL011)
 - An RTC (Versal built-in)
 - 2 GEMs (Cadence MACB Ethernet MACs)
 - 8 ADMA (Xilinx zDMA) channels
@@ -70,7 +70,7 @@ provides EL3 firmware to handle PSCI.
 
 A few examples:
 
-Direct Linux boot of a generic ARM64 upstream Linux kernel:
+Direct Linux boot of a generic Arm64 upstream Linux kernel:
 
 .. code-block:: bash
 
@@ -95,7 +95,7 @@ Direct Linux boot of PetaLinux 2019.2:
       -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
       -object rng-random,filename=/dev/urandom,id=rng0
 
-Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
+Boot PetaLinux 2019.2 via Arm Trusted Firmware (2018.3 because the 2019.2
 version of ATF tries to configure the CCI which we don't model) and U-boot:
 
 .. code-block:: bash
@@ -149,7 +149,7 @@ Run the following at the U-Boot prompt:
   fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
   booti 30000000 - 20000000
 
-Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
+Boot Linux as Dom0 on Xen via Arm Trusted Firmware and U-Boot:
 
 .. code-block:: bash
 
diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
index ade18a3fe1..94eedf0e81 100644
--- a/docs/system/arm/xlnx-zynq.rst
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -29,7 +29,7 @@ QEMU xilinx-zynq-a9 board supports following devices:
 
 Running
 """""""
-Direct Linux boot of a generic ARM upstream Linux kernel:
+Direct Linux boot of a generic Arm upstream Linux kernel:
 
 .. code-block:: bash
 
diff --git a/docs/system/guest-loader.rst b/docs/system/guest-loader.rst
index 304ee5d531..12436cc791 100644
--- a/docs/system/guest-loader.rst
+++ b/docs/system/guest-loader.rst
@@ -32,7 +32,7 @@ size. Additional information can be passed with by using additional
 arguments.
 
 Currently the only supported machines which use FDT data to boot are
-the ARM and RiscV ``virt`` machines.
+the Arm and RiscV ``virt`` machines.
 
 Arguments
 ^^^^^^^^^
-- 
2.48.1


