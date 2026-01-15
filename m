Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F03D44C62
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 15:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOvB-0002xN-Jm; Thu, 15 Jan 2026 10:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOv3-0002wz-4u
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:05:54 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOv0-0001bd-Kb
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:05:52 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso9586665e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768489548; x=1769094348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JNOPG0Kg6ZI0EYg0IMuO/kr8Km+rEwdm01AcsnccAiY=;
 b=DVxT+4BkxDBPJmVGvXgMYOJRF+nm8PyvLa/VzCNcJCvNrVi2mTjoo9NXB9y/KnAvnS
 +BR5oDpmUayAlL49UZywDRKrofsg23+roo6kXn3gsYCCMTrXKgjHnxH1AsGIB4pw6jO/
 8Nz+KSnNLrNePh8Sik7I0GWlrazhSV6dUY9ZI3zl3vnnu8j+I2dfWZkvH1X8Sd/INXE1
 p6G9EmgjqTbdQyPTobeg/LMnXQWXTIxyo1xst0I+/QhE0SSsIz5uv1q2GNnRx3TN6DO8
 l1LFu6p6rmO+jWOj+rCo1Zfw/Y0lc8Jsbzcp/G8zodXwrb6Wpzcdg7cYsiI3W9TkWk12
 vs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768489548; x=1769094348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNOPG0Kg6ZI0EYg0IMuO/kr8Km+rEwdm01AcsnccAiY=;
 b=L17FWsdFp1CrXLjPddLA6ZprvCvWJdSmqefDE4TePnPm0azXhFmmQjMwIHjJjjutIu
 ZDZmJNzTD19ZLmq22v05ClqVRB2bVuoHZXxQIGHQt6ZLX8ACsSMHYRNMAutFPcVfPhcc
 b6S/uNn/dl4pX0FfKwtAts6/4EJQ7L8W7HG468a4xD1mSB7OTwyvaQEKVpxq+rxnjxWB
 jL4ZZUtNRqqhzJyKOP/FPt36o6oZmdyWYWeevEkweG8MH3gj4nIjE5CeSEu0mlOMJU/U
 jS54C2GxwJOlpnuPz9ja1iHj63AsmjmWa8ZUgzp3/jaBT+qUSibENJkibu4Zq40XHMSw
 Imhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz3XkG7D1xBFCDm47GKzO1pcNXFObPxN/r+kIMI6p5kVDutw362congu0NhCG6ObF5anKitjNBl43f@nongnu.org
X-Gm-Message-State: AOJu0Yx681Q65hIU8QxP99luLtTT7Q8GVi8I4jPS+CwTr0s5T85tduMi
 nElJjps4Rsa9tntyfmyP44zZCmlhMGmNH5mDDXx7Mm3jgxRAh6zxXUeuX3DEwk2qLFc=
X-Gm-Gg: AY/fxX5FdNGaI2hh9bBy4nmfdFQQPxrBk1tpgows3hyd++dM22G3N6xQe4nThlyXUW9
 2uKcJzfpw3RlY8hwu/jHdqC9qzgNgx+VzBiQAtmqwhPKtWuoO38G8sZdCoQj0mfFSsqU/I4l8kk
 qtxtIW7ldK8ckT+GMXBDY1owze7liZ4lzv1eqe7G9o7tllfzDVaVrHlp14ifg4LXEcMDY9IePGV
 XtmS+1RoWjl+12lVEY1KnfOmAKRvMsAH7cO8EHzicoxXPU1PA1pFNW9XtNQLyu5knCNULHsa3oG
 IEFaVruZTPPXRaY+bZIaRurjhE+aMS/M2U5KbfTnYQz0EpL/74cQTadjqNoloqq6FSaScpmwnXn
 gG/JDEmOvq7QMNzwNW1gqeVQVnSj6VyFFwCt6qoCHH4w4kH96TnTDvmixh0yIAXTW6Yi/qZRT/5
 2PWMcJ4cNLjk2hjFhoM/n86LeUREKvzmNRPAmA62cUwI2xg0SjH52ZkxoJTe+wcmQAoELG2wRFf
 MWDNPbOzSQJmZVTUv9Ln1j+nj9R6SAQQitTaFX8itqemQ==
X-Received: by 2002:a05:600c:4e0a:b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-4801e338ad8mr608265e9.21.1768489547803; 
 Thu, 15 Jan 2026 07:05:47 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee0b4559asm49730895e9.0.2026.01.15.07.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 07:05:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Ninad Palsule <ninad@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] docs: Be consistent about capitalization of 'Arm' (again)
Date: Thu, 15 Jan 2026 15:05:45 +0000
Message-ID: <20260115150545.669444-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

The company 'Arm' went through a rebranding many years back
involving a recapitalization from 'ARM' to 'Arm'. As a result
our documentation is a bit inconsistent between the two forms.
It's not worth trying to update everywhere in QEMU, but it's
easy enough to make docs/ consistent.

We last did this in commit 6fe6d6c9a in 2020, but a few new
uses of the wrong capitalization have crept back in since.

As before, "ARMv8" and similar architecture names, and
older CPU names like "ARM926" still retain all-caps.

In a few places we make minor grammar fixups as we touch
the sentences we're fixing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I have left the uses in xlnx-zynq.rst because I fixed those
in a different patchset that overhauled that file.
---
 docs/devel/testing/qgraph.rst        |  8 ++++----
 docs/devel/vfio-iommufd.rst          |  2 +-
 docs/specs/fsi.rst                   |  2 +-
 docs/system/arm/aspeed.rst           |  6 +++---
 docs/system/arm/b-l475e-iot01a.rst   |  2 +-
 docs/system/arm/nrf.rst              |  4 ++--
 docs/system/arm/stm32.rst            | 12 ++++++------
 docs/system/arm/xlnx-versal-virt.rst | 16 ++++++++--------
 docs/system/guest-loader.rst         |  2 +-
 docs/system/replay.rst               |  2 +-
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/docs/devel/testing/qgraph.rst b/docs/devel/testing/qgraph.rst
index 43342d9d65..ca63d1ea98 100644
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
+- The current ``sdhci`` device is supported by both ``x86_64/pc`` and Arm
   (in this example we focus on the ``arm-raspi2b``) machines.
-- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for ``ARM`` and
+- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for Arm and
   ``QSDHCI_PCI`` for ``x86_64/pc``. Both implement the
   ``read[q,w], writeq`` functions.
 
diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..c29d9f3fb0 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -122,7 +122,7 @@ container:
 Supported platform
 ==================
 
-Supports x86, ARM and s390x currently.
+Supports x86, Arm and s390x currently.
 
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
index 4fa1739cb5..97e14b7d33 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -5,7 +5,7 @@ The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
 Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
 AST2500 with an ARM1176JZS CPU (800MHz), the AST2600
-with dual cores ARM Cortex-A7 CPUs (1.2GHz).
+with dual cores Arm Cortex-A7 CPUs (1.2GHz).
 
 The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
 etc.
@@ -279,7 +279,7 @@ Aspeed 2700 family boards (``ast2700-evb``, ``ast2700fc``)
 
 The QEMU Aspeed machines model BMCs of Aspeed evaluation boards.
 They are based on different releases of the Aspeed SoC :
-the AST2700 with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz).
+the AST2700 with quad cores Arm Cortex-A35 64 bits CPUs (1.6GHz).
 
 The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
 etc.
@@ -453,7 +453,7 @@ Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast1030-evb
 
 The QEMU Aspeed machines model mini BMCs and Platform Root of Trust processors of various Aspeed
 evaluation boards. They are based on different releases of the Aspeed SoC : the AST1030 (MiniBMC)
-and AST1060 (Platform Root of Trust Processor), both integrating an ARM Cortex M4F CPU (200MHz).
+and AST1060 (Platform Root of Trust Processor), both integrating an Arm Cortex M4F CPU (200MHz).
 
 The SoC comes with SRAM, SPI, I2C, etc.
 
diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
index 2adcc4b4c1..31a40e3b3b 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -2,7 +2,7 @@ B-L475E-IOT01A IoT Node (``b-l475e-iot01a``)
 ============================================
 
 The B-L475E-IOT01A IoT Node uses the STM32L475VG SoC which is based on
-ARM Cortex-M4F core. It is part of STMicroelectronics
+an Arm Cortex-M4F core. It is part of STMicroelectronics
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
diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 511e3eb9ac..23b03f9029 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -1,24 +1,24 @@
 STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``olimex-stm32-h405``, ``stm32vldiscovery``)
 ===============================================================================================================
 
-The `STM32`_ chips are a family of 32-bit ARM-based microcontroller by
+The `STM32`_ chips are a family of 32-bit Arm-based microcontrollers by
 STMicroelectronics.
 
 .. _STM32: https://www.st.com/en/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus.html
 
-The STM32F1 series is based on ARM Cortex-M3 core. The following machines are
+The STM32F1 series is based on an Arm Cortex-M3 core. The following machines are
 based on this chip :
 
 - ``stm32vldiscovery``  STM32VLDISCOVERY board with STM32F100RBT6 microcontroller
 
-The STM32F2 series is based on ARM Cortex-M3 core. The following machines are
+The STM32F2 series is based on an Arm Cortex-M3 core. The following machines are
 based on this chip :
 
 - ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontroller
 
-The STM32F4 series is based on ARM Cortex-M4F core, as well as the STM32L4
+The STM32F4 series is based on an Arm Cortex-M4F core, as well as the STM32L4
 ultra-low-power series. The STM32F4 series is pin-to-pin compatible with STM32F2 series.
-The following machines are based on this ARM Cortex-M4F chip :
+The following machines are based on this Arm Cortex-M4F chip :
 
 - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller
 - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcontroller
@@ -29,7 +29,7 @@ There are many other STM32 series that are currently not supported by QEMU.
 Supported devices
 -----------------
 
- * ARM Cortex-M3, Cortex M4F
+ * Arm Cortex-M3, Cortex-M4F
  * Analog to Digital Converter (ADC)
  * EXTI interrupt
  * Serial ports (USART)
diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 640cc07f80..8d31369f71 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -27,12 +27,12 @@ Versal
 """"""
 Implemented CPU cores:
 
-- 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
-- 2 RCPUs (ARM Cortex-R5F) with their GICv2
+- 2 ACPUs (Arm Cortex-A72) with their GICv3 and ITS
+- 2 RCPUs (Arm Cortex-R5F) with their GICv2
 
 Implemented devices:
 
-- 2 UARTs (ARM PL011)
+- 2 UARTs (Arm PL011)
 - An RTC (Versal built-in)
 - 2 GEMs (Cadence MACB Ethernet MACs)
 - 8 ADMA (Xilinx zDMA) channels
@@ -51,12 +51,12 @@ Versal Gen 2
 """"""""""""
 Implemented CPU cores:
 
-- 8 ACPUs (ARM Cortex-A78AE) with their GICv3 and ITS
-- 10 RCPUs (ARM Cortex-R52) with their GICv3 (one per cluster)
+- 8 ACPUs (Arm Cortex-A78AE) with their GICv3 and ITS
+- 10 RCPUs (Arm Cortex-R52) with their GICv3 (one per cluster)
 
 Implemented devices:
 
-- 2 UARTs (ARM PL011)
+- 2 UARTs (Arm PL011)
 - An RTC (Versal built-in)
 - 3 GEMs (Cadence MACB Ethernet MACs)
 - 8 ADMA (Xilinx zDMA) channels
@@ -134,7 +134,7 @@ Direct Linux boot of PetaLinux 2019.2:
       -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
       -object rng-random,filename=/dev/urandom,id=rng0
 
-Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
+Boot PetaLinux 2019.2 via Arm Trusted Firmware (2018.3 because the 2019.2
 version of ATF tries to configure the CCI which we don't model) and U-boot:
 
 .. code-block:: bash
@@ -188,7 +188,7 @@ Run the following at the U-Boot prompt:
   fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
   booti 30000000 - 20000000
 
-Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
+Boot Linux as Dom0 on Xen via Arm Trusted Firmware and U-Boot:
 
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
diff --git a/docs/system/replay.rst b/docs/system/replay.rst
index 28e5772a2b..fd78bd1f73 100644
--- a/docs/system/replay.rst
+++ b/docs/system/replay.rst
@@ -23,7 +23,7 @@ Deterministic replay has the following features:
    the memory, state of the hardware devices, clocks, and screen of the VM.
  * Writes execution log into the file for later replaying for multiple times
    on different machines.
- * Supports i386, x86_64, ARM, AArch64, Risc-V, MIPS, MIPS64, S390X, Alpha,
+ * Supports i386, x86_64, Arm, AArch64, Risc-V, MIPS, MIPS64, S390X, Alpha,
    PowerPC, PowerPC64, M68000, Microblaze, OpenRISC, SPARC,
    and Xtensa hardware platforms.
  * Performs deterministic replay of all operations with keyboard and mouse
-- 
2.47.3


