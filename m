Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FA3CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQIE-0001Gh-9P; Mon, 10 Nov 2025 06:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIPzf-0003vR-Di
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:23:36 -0500
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIPzb-000679-Qj
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:23:31 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCE77202DB4;
 Mon, 10 Nov 2025 12:23:25 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FE45201524;
 Mon, 10 Nov 2025 12:23:25 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8DE9A180008F;
 Mon, 10 Nov 2025 19:23:24 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
Date: Mon, 10 Nov 2025 16:52:45 +0530
Message-Id: <20251110112257.184578-2-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Implemented CPUs, RAM, UARTs and Interrupt Controller
Other peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE
Complete memory map of the SoC is provided.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  70 +++++++
 docs/system/target-arm.rst     |   1 +
 hw/arm/Kconfig                 |  12 ++
 hw/arm/fsl-imx8mm.c            | 363 +++++++++++++++++++++++++++++++++
 hw/arm/imx8mm-evk.c            | 107 ++++++++++
 hw/arm/meson.build             |   2 +
 include/hw/arm/fsl-imx8mm.h    | 156 ++++++++++++++
 7 files changed, 711 insertions(+)
 create mode 100644 docs/system/arm/imx8mm-evk.rst
 create mode 100644 hw/arm/fsl-imx8mm.c
 create mode 100644 hw/arm/imx8mm-evk.c
 create mode 100644 include/hw/arm/fsl-imx8mm.h

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
new file mode 100644
index 0000000000..61d28ebf72
--- /dev/null
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -0,0 +1,70 @@
+NXP i.MX 8MM Evaluation Kit (``imx8mm-evk``)
+================================================
+
+The ``imx8mm-evk`` machine models the i.MX 8M Plus Evaluation Kit, based on an
+i.MX 8MM SoC.
+
+Supported devices
+-----------------
+
+The ``imx8mm-evk`` machine implements the following devices:
+
+ * Up to 4 Cortex-A53 cores
+ * Generic Interrupt Controller (GICv3)
+ * 4 UARTs
+
+Boot options
+------------
+
+The ``imx8mm-evk`` machine can start a Linux kernel directly using the standard
+``-kernel`` functionality.
+
+Direct Linux Kernel Boot
+''''''''''''''''''''''''
+
+Probably the easiest way to get started with a whole Linux system on the machine
+is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
+of writing and involves two steps. First run the following commands in the
+toplevel directory of the Buildroot source tree:
+
+.. code-block:: bash
+
+  $ make freescale_imx8mmevk_defconfig
+  $ make
+
+Once finished successfully there is an ``output/image`` subfolder. Navigate into
+it and resize the SD card image to a power of two:
+
+.. code-block:: bash
+
+  $ qemu-img resize sdcard.img 256M
+
+Now that everything is prepared the machine can be started as follows:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \
+      -display none -serial null -serial stdio \
+      -kernel Image \
+      -dtb imx8mm-evk.dtb \
+      -append "root=/dev/mmcblk2p2" \
+      -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
+
+
+KVM Acceleration
+----------------
+
+To enable hardware-assisted acceleration via KVM, append
+``-accel kvm -cpu host`` to the command line. While this speeds up performance
+significantly, be aware of the following limitations:
+
+* The ``imx8mm-evk`` machine is not included under the "virtualization use case"
+  of :doc:`QEMU's security policy </system/security>`. This means that you
+  should not trust that it can contain malicious guests, whether it is run
+  using TCG or KVM. If you don't trust your guests and you're relying on QEMU to
+  be the security boundary, you want to choose another machine such as ``virt``.
+* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be used.
+  This is a limitation of KVM and may not work with guests with a tight
+  dependency on Cortex-A53.
+* No EL2 and EL3 exception levels are available which is also a KVM limitation.
+  Direct kernel boot should work but running U-Boot, TF-A, etc. won't succeed.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index a96d1867df..d6a4b5bb00 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -97,6 +97,7 @@ Board-specific documentation
    arm/mcimx6ul-evk
    arm/mcimx7d-sabre
    arm/imx8mp-evk
+   arm/imx8mm-evk
    arm/orangepi
    arm/raspi
    arm/collie
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0cdeb60f1f..7c66f3c3cd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -626,6 +626,18 @@ config FSL_IMX8MP_EVK
     depends on TCG || KVM
     select FSL_IMX8MP
 
+config FSL_IMX8MM
+    bool
+    select ARM_GIC
+    select IMX
+
+config FSL_IMX8MM_EVK
+    bool
+    default y
+    depends on AARCH64
+    depends on TCG || KVM
+    select FSL_IMX8MM
+
 config ARM_SMMUV3
     bool
 
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
new file mode 100644
index 0000000000..9c8acc1e99
--- /dev/null
+++ b/hw/arm/fsl-imx8mm.c
@@ -0,0 +1,363 @@
+/*
+ * i.MX 8MM SoC Implementation
+ *
+ * Based on hw/arm/fsl-imx6.c
+ *
+ * Copyright (c) 2025, Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/fsl-imx8mm.h"
+#include "hw/misc/unimp.h"
+#include "hw/boards.h"
+#include "system/kvm.h"
+#include "system/system.h"
+#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
+#include "target/arm/kvm_arm.h"
+#include "qapi/error.h"
+#include "qobject/qlist.h"
+
+static const struct {
+    hwaddr addr;
+    size_t size;
+    const char *name;
+} fsl_imx8mm_memmap[] = {
+    [FSL_IMX8MM_RAM] = { FSL_IMX8MM_RAM_START, FSL_IMX8MM_RAM_SIZE_MAX, "ram" },
+    [FSL_IMX8MM_DDR_PHY_BROADCAST] = { 0x3dc00000, 4 * MiB, "ddr_phy_broadcast" },
+    [FSL_IMX8MM_DDR_PERF_MON] = { 0x3d800000, 4 * MiB, "ddr_perf_mon" },
+    [FSL_IMX8MM_DDR_CTL] = { 0x3d400000, 4 * MiB, "ddr_ctl" },
+    [FSL_IMX8MM_DDR_PHY] = { 0x3c000000, 16 * MiB, "ddr_phy" },
+    [FSL_IMX8MM_GIC_DIST] = { 0x38800000, 512 * KiB, "gic_dist" },
+    [FSL_IMX8MM_GIC_REDIST] = { 0x38880000, 512 * KiB, "gic_redist" },
+    [FSL_IMX8MM_VPU] = { 0x38340000, 2 * MiB, "vpu" },
+    [FSL_IMX8MM_VPU_BLK_CTRL] = { 0x38330000, 2 * MiB, "vpu_blk_ctrl" },
+    [FSL_IMX8MM_VPU_G2_DECODER] = { 0x38310000, 1 * MiB, "vpu_g2_decoder" },
+    [FSL_IMX8MM_VPU_G1_DECODER] = { 0x38300000, 1 * MiB, "vpu_g1_decoder" },
+    [FSL_IMX8MM_USB2_OTG] = { 0x32e50200, 0x200, "usb2_otg" },
+    [FSL_IMX8MM_USB2] = { 0x32e50000, 0x200, "usb2" },
+    [FSL_IMX8MM_USB1_OTG] = { 0x32e40200, 0x200, "usb1_otg" },
+    [FSL_IMX8MM_USB1] = { 0x32e40000, 0x200, "usb1" },
+    [FSL_IMX8MM_GPU2D] = { 0x38000000, 64 * KiB, "gpu2d" },
+    [FSL_IMX8MM_QSPI1_RX_BUFFER] = { 0x34000000, 32 * MiB, "qspi1_rx_buffer" },
+    [FSL_IMX8MM_PCIE1] = { 0x33800000, 4 * MiB, "pcie1" },
+    [FSL_IMX8MM_QSPI1_TX_BUFFER] = { 0x33008000, 32 * KiB, "qspi1_tx_buffer" },
+    [FSL_IMX8MM_APBH_DMA] = { 0x33000000, 32 * KiB, "apbh_dma" },
+
+    /* AIPS-4 Begin */
+    [FSL_IMX8MM_TZASC] = { 0x32f80000, 64 * KiB, "tzasc" },
+    [FSL_IMX8MM_PCIE_PHY1] = { 0x32f00000, 64 * KiB, "pcie_phy1" },
+    [FSL_IMX8MM_MEDIA_BLK_CTL] = { 0x32e28000, 256, "media_blk_ctl" },
+    [FSL_IMX8MM_LCDIF] = { 0x32e00000, 64 * KiB, "lcdif" },
+    [FSL_IMX8MM_MIPI_DSI] = { 0x32e10000, 64 * KiB, "mipi_dsi" },
+    [FSL_IMX8MM_MIPI_CSI] = { 0x32e30000, 64 * KiB, "mipi_csi" },
+    [FSL_IMX8MM_AIPS4_CONFIGURATION] = { 0x32df0000, 64 * KiB, "aips4_configuration" },
+    /* AIPS-4 End */
+
+    [FSL_IMX8MM_INTERCONNECT] = { 0x32700000, 1 * MiB, "interconnect" },
+
+    /* AIPS-3 Begin */
+    [FSL_IMX8MM_ENET1] = { 0x30be0000, 64 * KiB, "enet1" },
+    [FSL_IMX8MM_SDMA1] = { 0x30bd0000, 64 * KiB, "sdma1" },
+    [FSL_IMX8MM_QSPI] = { 0x30bb0000, 64 * KiB, "qspi" },
+    [FSL_IMX8MM_USDHC3] = { 0x30b60000, 64 * KiB, "usdhc3" },
+    [FSL_IMX8MM_USDHC2] = { 0x30b50000, 64 * KiB, "usdhc2" },
+    [FSL_IMX8MM_USDHC1] = { 0x30b40000, 64 * KiB, "usdhc1" },
+    [FSL_IMX8MM_SEMAPHORE_HS] = { 0x30ac0000, 64 * KiB, "semaphore_hs" },
+    [FSL_IMX8MM_MU_B] = { 0x30ab0000, 64 * KiB, "mu_b" },
+    [FSL_IMX8MM_MU_A] = { 0x30aa0000, 64 * KiB, "mu_a" },
+    [FSL_IMX8MM_UART4] = { 0x30a60000, 64 * KiB, "uart4" },
+    [FSL_IMX8MM_I2C4] = { 0x30a50000, 64 * KiB, "i2c4" },
+    [FSL_IMX8MM_I2C3] = { 0x30a40000, 64 * KiB, "i2c3" },
+    [FSL_IMX8MM_I2C2] = { 0x30a30000, 64 * KiB, "i2c2" },
+    [FSL_IMX8MM_I2C1] = { 0x30a20000, 64 * KiB, "i2c1" },
+    [FSL_IMX8MM_AIPS3_CONFIGURATION] = { 0x309f0000, 64 * KiB, "aips3_configuration" },
+    [FSL_IMX8MM_CAAM] = { 0x30900000, 256 * KiB, "caam" },
+    [FSL_IMX8MM_SPBA1] = { 0x308f0000, 64 * KiB, "spba1" },
+    [FSL_IMX8MM_UART2] = { 0x30890000, 64 * KiB, "uart2" },
+    [FSL_IMX8MM_UART3] = { 0x30880000, 64 * KiB, "uart3" },
+    [FSL_IMX8MM_UART1] = { 0x30860000, 64 * KiB, "uart1" },
+    [FSL_IMX8MM_ECSPI3] = { 0x30840000, 64 * KiB, "ecspi3" },
+    [FSL_IMX8MM_ECSPI2] = { 0x30830000, 64 * KiB, "ecspi2" },
+    [FSL_IMX8MM_ECSPI1] = { 0x30820000, 64 * KiB, "ecspi1" },
+    /* AIPS-3 End */
+
+    /* AIPS-2 Begin */
+    [FSL_IMX8MM_QOSC] = { 0x307f0000, 64 * KiB, "qosc" },
+    [FSL_IMX8MM_PERFMON2] = { 0x307d0000, 64 * KiB, "perfmon2" },
+    [FSL_IMX8MM_PERFMON1] = { 0x307c0000, 64 * KiB, "perfmon1" },
+    [FSL_IMX8MM_GPT4] = { 0x30700000, 64 * KiB, "gpt4" },
+    [FSL_IMX8MM_GPT5] = { 0x306f0000, 64 * KiB, "gpt5" },
+    [FSL_IMX8MM_GPT6] = { 0x306e0000, 64 * KiB, "gpt6" },
+    [FSL_IMX8MM_SYSCNT_CTRL] = { 0x306c0000, 64 * KiB, "syscnt_ctrl" },
+    [FSL_IMX8MM_SYSCNT_CMP] = { 0x306b0000, 64 * KiB, "syscnt_cmp" },
+    [FSL_IMX8MM_SYSCNT_RD] = { 0x306a0000, 64 * KiB, "syscnt_rd" },
+    [FSL_IMX8MM_PWM4] = { 0x30690000, 64 * KiB, "pwm4" },
+    [FSL_IMX8MM_PWM3] = { 0x30680000, 64 * KiB, "pwm3" },
+    [FSL_IMX8MM_PWM2] = { 0x30670000, 64 * KiB, "pwm2" },
+    [FSL_IMX8MM_PWM1] = { 0x30660000, 64 * KiB, "pwm1" },
+    [FSL_IMX8MM_AIPS2_CONFIGURATION] = { 0x305f0000, 64 * KiB, "aips2_configuration" },
+    /* AIPS-2 End */
+
+    /* AIPS-1 Begin */
+    [FSL_IMX8MM_CSU] = { 0x303e0000, 64 * KiB, "csu" },
+    [FSL_IMX8MM_RDC] = { 0x303d0000, 64 * KiB, "rdc" },
+    [FSL_IMX8MM_SEMAPHORE2] = { 0x303c0000, 64 * KiB, "semaphore2" },
+    [FSL_IMX8MM_SEMAPHORE1] = { 0x303b0000, 64 * KiB, "semaphore1" },
+    [FSL_IMX8MM_GPC] = { 0x303a0000, 64 * KiB, "gpc" },
+    [FSL_IMX8MM_SRC] = { 0x30390000, 64 * KiB, "src" },
+    [FSL_IMX8MM_CCM] = { 0x30380000, 64 * KiB, "ccm" },
+    [FSL_IMX8MM_SNVS_HP] = { 0x30370000, 64 * KiB, "snvs_hp" },
+    [FSL_IMX8MM_ANA_PLL] = { 0x30360000, 64 * KiB, "ana_pll" },
+    [FSL_IMX8MM_OCOTP_CTRL] = { 0x30350000, 64 * KiB, "ocotp_ctrl" },
+    [FSL_IMX8MM_IOMUXC_GPR] = { 0x30340000, 64 * KiB, "iomuxc_gpr" },
+    [FSL_IMX8MM_IOMUXC] = { 0x30330000, 64 * KiB, "iomuxc" },
+    [FSL_IMX8MM_GPT3] = { 0x302f0000, 64 * KiB, "gpt3" },
+    [FSL_IMX8MM_GPT2] = { 0x302e0000, 64 * KiB, "gpt2" },
+    [FSL_IMX8MM_GPT1] = { 0x302d0000, 64 * KiB, "gpt1" },
+    [FSL_IMX8MM_SDMA2] = { 0x302c0000, 64 * KiB, "sdma2" },
+    [FSL_IMX8MM_SDMA3] = { 0x302b0000, 64 * KiB, "sdma3" },
+    [FSL_IMX8MM_WDOG3] = { 0x302a0000, 64 * KiB, "wdog3" },
+    [FSL_IMX8MM_WDOG2] = { 0x30290000, 64 * KiB, "wdog2" },
+    [FSL_IMX8MM_WDOG1] = { 0x30280000, 64 * KiB, "wdog1" },
+    [FSL_IMX8MM_ANA_OSC] = { 0x30270000, 64 * KiB, "ana_osc" },
+    [FSL_IMX8MM_ANA_TSENSOR] = { 0x30260000, 64 * KiB, "ana_tsensor" },
+    [FSL_IMX8MM_GPIO5] = { 0x30240000, 64 * KiB, "gpio5" },
+    [FSL_IMX8MM_GPIO4] = { 0x30230000, 64 * KiB, "gpio4" },
+    [FSL_IMX8MM_GPIO3] = { 0x30220000, 64 * KiB, "gpio3" },
+    [FSL_IMX8MM_GPIO2] = { 0x30210000, 64 * KiB, "gpio2" },
+    [FSL_IMX8MM_GPIO1] = { 0x30200000, 64 * KiB, "gpio1" },
+    [FSL_IMX8MM_AIPS1_CONFIGURATION] = { 0x301f0000, 64 * KiB, "aips1_configuration" },
+    [FSL_IMX8MM_SAI6] = { 0x30060000, 64 * KiB, "sai6" },
+    [FSL_IMX8MM_SAI5] = { 0x30050000, 64 * KiB, "sai5" },
+    [FSL_IMX8MM_SAI3] = { 0x30030000, 64 * KiB, "sai3" },
+    [FSL_IMX8MM_SAI2] = { 0x30020000, 64 * KiB, "sai2" },
+    [FSL_IMX8MM_SAI1] = { 0x30010000, 64 * KiB, "sai1" },
+
+    /* AIPS-1 End */
+
+    [FSL_IMX8MM_A53_DAP] = { 0x28000000, 16 * MiB, "a53_dap" },
+    [FSL_IMX8MM_PCIE1_MEM] = { 0x18000000, 128 * MiB, "pcie1_mem" },
+    [FSL_IMX8MM_QSPI_MEM] = { 0x08000000, 256 * MiB, "qspi_mem" },
+    [FSL_IMX8MM_OCRAM] = { 0x00900000, 256 * KiB, "ocram" },
+    [FSL_IMX8MM_TCM_DTCM] = { 0x00800000, 128 * KiB, "tcm_dtcm" },
+    [FSL_IMX8MM_TCM_ITCM] = { 0x007e0000, 128 * KiB, "tcm_itcm" },
+    [FSL_IMX8MM_OCRAM_S] = { 0x00180000, 32 * KiB, "ocram_s" },
+    [FSL_IMX8MM_CAAM_MEM] = { 0x00100000, 32 * KiB, "caam_mem" },
+    [FSL_IMX8MM_BOOT_ROM_PROTECTED] = { 0x0003f000, 4 * KiB, "boot_rom_protected" },
+    [FSL_IMX8MM_BOOT_ROM] = { 0x00000000, 252 * KiB, "boot_rom" },
+};
+
+static void fsl_imx8mm_init(Object *obj)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    FslImx8mmState *s = FSL_IMX8MM(obj);
+    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
+    int i;
+
+    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
+
+    for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i + 1);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
+    }
+
+}
+
+static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    FslImx8mmState *s = FSL_IMX8MM(dev);
+    DeviceState *gicdev = DEVICE(&s->gic);
+    int i;
+
+    if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
+                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms->smp.cpus);
+        return;
+    }
+
+    /* CPUs */
+    for (i = 0; i < ms->smp.cpus; i++) {
+        /* On uniprocessor, the CBAR is set to 0 */
+        if (ms->smp.cpus > 1 &&
+                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
+                                    fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr,
+                                    &error_abort);
+        }
+
+        /*
+         * CNTFID0 base frequency in Hz of system counter
+         */
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
+                                &error_abort);
+
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
+                                     !kvm_enabled(), &error_abort);
+        }
+
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
+                                     !kvm_enabled(), &error_abort);
+        }
+
+        if (i) {
+            /*
+             * Secondary CPUs start in powered-down state (and can be
+             * powered up via the SRC system reset controller)
+             */
+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
+                                     true, &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC */
+    {
+        SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
+        QList *redist_region_count;
+        bool pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
+
+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
+        qdev_prop_set_uint32(gicdev, "num-irq",
+                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
+        redist_region_count = qlist_new();
+        qlist_append_int(redist_region_count, ms->smp.cpus);
+        qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+        object_property_set_link(OBJECT(&s->gic), "sysmem",
+                                 OBJECT(get_system_memory()), &error_fatal);
+        if (!sysbus_realize(gicsbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(gicsbd, 0, fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr);
+        sysbus_mmio_map(gicsbd, 1, fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDIST].addr);
+
+        /*
+         * Wire the outputs from each CPU's generic timer and the GICv3
+         * maintenance interrupt signal to the appropriate GIC PPI inputs, and
+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
+         */
+        for (i = 0; i < ms->smp.cpus; i++) {
+            DeviceState *cpudev = DEVICE(&s->cpu[i]);
+            int intidbase = FSL_IMX8MM_NUM_IRQS + i * GIC_INTERNAL;
+            qemu_irq irq;
+
+            /*
+             * Mapping from the output timer irq lines from the CPU to the
+             * GIC PPI inputs.
+             */
+            static const int timer_irqs[] = {
+                [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+                [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+                [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+                [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            };
+
+            for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+                irq = qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]);
+                qdev_connect_gpio_out(cpudev, j, irq);
+            }
+
+            irq = qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+
+            irq = qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0, irq);
+
+            sysbus_connect_irq(gicsbd, i,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+            if (kvm_enabled()) {
+                if (pmu) {
+                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE_PMU));
+                    if (kvm_irqchip_in_kernel()) {
+                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IRQ);
+                    }
+                    kvm_arm_pmu_init(&s->cpu[i]);
+                }
+            }
+        }
+    }
+
+    /* UARTs */
+    for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } serial_table[FSL_IMX8MM_NUM_UARTS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1].addr, FSL_IMX8MM_UART1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2].addr, FSL_IMX8MM_UART2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3].addr, FSL_IMX8MM_UART3_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4].addr, FSL_IMX8MM_UART4_IRQ },
+        };
+
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(gicdev, serial_table[i].irq));
+    }
+
+    /* Unimplemented devices */
+    for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
+        switch (i) {
+        case FSL_IMX8MM_GIC_DIST:
+        case FSL_IMX8MM_GIC_REDIST:
+        case FSL_IMX8MM_RAM:
+        case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
+            /* device implemented and treated above */
+            break;
+
+        default:
+            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
+                                        fsl_imx8mm_memmap[i].addr,
+                                        fsl_imx8mm_memmap[i].size);
+            break;
+        }
+    }
+}
+
+static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = fsl_imx8mm_realize;
+
+    dc->desc = "i.MX 8MM SoC";
+}
+
+static const TypeInfo fsl_imx8mm_types[] = {
+    {
+        .name = TYPE_FSL_IMX8MM,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FslImx8mmState),
+        .instance_init = fsl_imx8mm_init,
+        .class_init = fsl_imx8mm_class_init,
+    },
+};
+
+DEFINE_TYPES(fsl_imx8mm_types)
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
new file mode 100644
index 0000000000..cfb42fe464
--- /dev/null
+++ b/hw/arm/imx8mm-evk.c
@@ -0,0 +1,107 @@
+/*
+ * NXP i.MX 8MM Evaluation Kit System Emulation
+ *
+ * Copyright (c) 2025, Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/fsl-imx8mm.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "system/kvm.h"
+#include "system/qtest.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include <libfdt.h>
+
+static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+    int i, offset;
+
+    /* Temporarily disable following nodes until they are implemented */
+    const char *nodes_to_remove[] = {
+        "nxp,imx8mm-fspi",
+    };
+
+    for (i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
+        const char *dev_str = nodes_to_remove[i];
+
+        offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        while (offset >= 0) {
+            fdt_nop_node(fdt, offset);
+            offset = fdt_node_offset_by_compatible(fdt, offset, dev_str);
+        }
+    }
+
+    /* Remove cpu-idle-states property from CPU nodes */
+    offset = fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53");
+    while (offset >= 0) {
+        fdt_nop_property(fdt, offset, "cpu-idle-states");
+        offset = fdt_node_offset_by_compatible(fdt, offset, "arm,cortex-a53");
+    }
+
+    if (kvm_enabled()) {
+        /* Use system counter frequency from host CPU to fix time in guest */
+        offset = fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-timer");
+        while (offset >= 0) {
+            fdt_nop_property(fdt, offset, "clock-frequency");
+            offset = fdt_node_offset_by_compatible(fdt, offset, "arm,armv8-timer");
+        }
+    }
+}
+
+static void imx8mm_evk_init(MachineState *machine)
+{
+    static struct arm_boot_info boot_info;
+    FslImx8mmState *s;
+
+    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08" PRIx64 ")",
+                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
+        exit(1);
+    }
+
+    boot_info = (struct arm_boot_info) {
+        .loader_start = FSL_IMX8MM_RAM_START,
+        .board_id = -1,
+        .ram_size = machine->ram_size,
+        .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
+        .modify_dtb = imx8mm_evk_modify_dtb,
+    };
+
+    s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+
+    memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START,
+                                machine->ram);
+
+    if (!qtest_enabled()) {
+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+    }
+}
+
+static const char *imx8mm_evk_get_default_cpu_type(const MachineState *ms)
+{
+    if (kvm_enabled()) {
+        return ARM_CPU_TYPE_NAME("host");
+    }
+
+    return ARM_CPU_TYPE_NAME("cortex-a53");
+}
+
+static void imx8mm_evk_machine_init(MachineClass *mc)
+{
+    mc->desc = "NXP i.MX 8MM EVK Board";
+    mc->init = imx8mm_evk_init;
+    mc->max_cpus = FSL_IMX8MM_NUM_CPUS;
+    mc->default_ram_id = "imx8mm-evk.ram";
+    mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
+}
+
+DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index aeaf654790..12ecb824cc 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -84,6 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM', if_true: files('fsl-imx8mm.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true: files('imx8mm-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
new file mode 100644
index 0000000000..aa954ea00b
--- /dev/null
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -0,0 +1,156 @@
+/*
+ * i.MX 8MM SoC Definitions
+ *
+ * Copyright (c) 2025, Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef FSL_IMX8MM_H
+#define FSL_IMX8MM_H
+
+#include "cpu.h"
+#include "hw/char/imx_serial.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "qom/object.h"
+#include "qemu/units.h"
+
+#define TYPE_FSL_IMX8MM "fsl-imx8mm"
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
+
+#define FSL_IMX8MM_RAM_START        0x40000000
+#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
+
+enum FslImx8mmConfiguration {
+    FSL_IMX8MM_NUM_CPUS         = 4,
+    FSL_IMX8MM_NUM_IRQS         = 128,
+    FSL_IMX8MM_NUM_UARTS        = 4,
+};
+
+struct FslImx8mmState {
+    SysBusDevice   parent_obj;
+
+    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
+    GICv3State         gic;
+    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
+};
+
+enum FslImx8mmMemoryRegions {
+    FSL_IMX8MM_A53_DAP,
+    FSL_IMX8MM_AIPS1_CONFIGURATION,
+    FSL_IMX8MM_AIPS2_CONFIGURATION,
+    FSL_IMX8MM_AIPS3_CONFIGURATION,
+    FSL_IMX8MM_AIPS4_CONFIGURATION,
+    FSL_IMX8MM_ANA_OSC,
+    FSL_IMX8MM_ANA_PLL,
+    FSL_IMX8MM_ANA_TSENSOR,
+    FSL_IMX8MM_APBH_DMA,
+    FSL_IMX8MM_BOOT_ROM,
+    FSL_IMX8MM_BOOT_ROM_PROTECTED,
+    FSL_IMX8MM_CAAM,
+    FSL_IMX8MM_CAAM_MEM,
+    FSL_IMX8MM_CCM,
+    FSL_IMX8MM_CSU,
+    FSL_IMX8MM_DDR_CTL,
+    FSL_IMX8MM_DDR_PERF_MON,
+    FSL_IMX8MM_DDR_PHY,
+    FSL_IMX8MM_DDR_PHY_BROADCAST,
+    FSL_IMX8MM_ECSPI1,
+    FSL_IMX8MM_ECSPI2,
+    FSL_IMX8MM_ECSPI3,
+    FSL_IMX8MM_ENET1,
+    FSL_IMX8MM_GIC_DIST,
+    FSL_IMX8MM_GIC_REDIST,
+    FSL_IMX8MM_GPC,
+    FSL_IMX8MM_GPIO1,
+    FSL_IMX8MM_GPIO2,
+    FSL_IMX8MM_GPIO3,
+    FSL_IMX8MM_GPIO4,
+    FSL_IMX8MM_GPIO5,
+    FSL_IMX8MM_GPT1,
+    FSL_IMX8MM_GPT2,
+    FSL_IMX8MM_GPT3,
+    FSL_IMX8MM_GPT4,
+    FSL_IMX8MM_GPT5,
+    FSL_IMX8MM_GPT6,
+    FSL_IMX8MM_GPU2D,
+    FSL_IMX8MM_I2C1,
+    FSL_IMX8MM_I2C2,
+    FSL_IMX8MM_I2C3,
+    FSL_IMX8MM_I2C4,
+    FSL_IMX8MM_INTERCONNECT,
+    FSL_IMX8MM_IOMUXC,
+    FSL_IMX8MM_IOMUXC_GPR,
+    FSL_IMX8MM_MEDIA_BLK_CTL,
+    FSL_IMX8MM_LCDIF,
+    FSL_IMX8MM_MIPI_CSI,
+    FSL_IMX8MM_MIPI_DSI,
+    FSL_IMX8MM_MU_A,
+    FSL_IMX8MM_MU_B,
+    FSL_IMX8MM_OCOTP_CTRL,
+    FSL_IMX8MM_OCRAM,
+    FSL_IMX8MM_OCRAM_S,
+    FSL_IMX8MM_PCIE1,
+    FSL_IMX8MM_PCIE1_MEM,
+    FSL_IMX8MM_PCIE_PHY1,
+    FSL_IMX8MM_PERFMON1,
+    FSL_IMX8MM_PERFMON2,
+    FSL_IMX8MM_PWM1,
+    FSL_IMX8MM_PWM2,
+    FSL_IMX8MM_PWM3,
+    FSL_IMX8MM_PWM4,
+    FSL_IMX8MM_QOSC,
+    FSL_IMX8MM_QSPI,
+    FSL_IMX8MM_QSPI1_RX_BUFFER,
+    FSL_IMX8MM_QSPI1_TX_BUFFER,
+    FSL_IMX8MM_QSPI_MEM,
+    FSL_IMX8MM_RAM,
+    FSL_IMX8MM_RDC,
+    FSL_IMX8MM_SAI1,
+    FSL_IMX8MM_SAI2,
+    FSL_IMX8MM_SAI3,
+    FSL_IMX8MM_SAI5,
+    FSL_IMX8MM_SAI6,
+    FSL_IMX8MM_SDMA1,
+    FSL_IMX8MM_SDMA2,
+    FSL_IMX8MM_SDMA3,
+    FSL_IMX8MM_SEMAPHORE1,
+    FSL_IMX8MM_SEMAPHORE2,
+    FSL_IMX8MM_SEMAPHORE_HS,
+    FSL_IMX8MM_SNVS_HP,
+    FSL_IMX8MM_SPBA1,
+    FSL_IMX8MM_SRC,
+    FSL_IMX8MM_SYSCNT_CMP,
+    FSL_IMX8MM_SYSCNT_CTRL,
+    FSL_IMX8MM_SYSCNT_RD,
+    FSL_IMX8MM_TCM_DTCM,
+    FSL_IMX8MM_TCM_ITCM,
+    FSL_IMX8MM_TZASC,
+    FSL_IMX8MM_UART1,
+    FSL_IMX8MM_UART2,
+    FSL_IMX8MM_UART3,
+    FSL_IMX8MM_UART4,
+    FSL_IMX8MM_USB1,
+    FSL_IMX8MM_USB2,
+    FSL_IMX8MM_USB1_OTG,
+    FSL_IMX8MM_USB2_OTG,
+    FSL_IMX8MM_USDHC1,
+    FSL_IMX8MM_USDHC2,
+    FSL_IMX8MM_USDHC3,
+    FSL_IMX8MM_VPU,
+    FSL_IMX8MM_VPU_BLK_CTRL,
+    FSL_IMX8MM_VPU_G1_DECODER,
+    FSL_IMX8MM_VPU_G2_DECODER,
+    FSL_IMX8MM_WDOG1,
+    FSL_IMX8MM_WDOG2,
+    FSL_IMX8MM_WDOG3,
+};
+
+enum FslImx8mmIrqs {
+    FSL_IMX8MM_UART1_IRQ    = 26,
+    FSL_IMX8MM_UART2_IRQ    = 27,
+    FSL_IMX8MM_UART3_IRQ    = 28,
+    FSL_IMX8MM_UART4_IRQ    = 29,
+};
+
+#endif /* FSL_IMX8MM_H */
-- 
2.34.1


