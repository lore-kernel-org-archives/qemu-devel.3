Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0A1C05023
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf0m-0005O0-Nc; Tue, 16 Apr 2024 05:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwezg-0003cX-K7; Tue, 16 Apr 2024 05:20:51 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rweze-0007iy-MZ; Tue, 16 Apr 2024 05:20:48 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 17:19:12 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 17:19:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 16/16] docs:aspeed: Add AST2700 Evaluation board
Date: Tue, 16 Apr 2024 17:19:03 +0800
Message-ID: <20240416091904.935283-17-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add AST2700 Evaluation board and its boot command.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 docs/system/arm/aspeed.rst | 39 ++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index b2dea54eed..320ff2a4cd 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,11 +1,12 @@
-Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``)
-==================================================================
+Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``)
+===================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
 Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
-AST2500 with an ARM1176JZS CPU (800MHz) and more recently the AST2600
-with dual cores ARM Cortex-A7 CPUs (1.2GHz).
+AST2500 with an ARM1176JZS CPU (800MHz), the AST2600
+with dual cores ARM Cortex-A7 CPUs (1.2GHz) and more recently the AST2700
+with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz)
 
 The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
 etc.
@@ -38,6 +39,10 @@ AST2600 SoC based machines :
 - ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
 - ``qcom-firework-bmc``    Qualcomm Firework BMC
 
+AST2700 SoC based machines :
+
+- ``ast2700-evb``          Aspeed AST2700 Evaluation board (Cortex-A35)
+
 Supported devices
 -----------------
 
@@ -66,6 +71,7 @@ Supported devices
  * eMMC Boot Controller (dummy)
  * PECI Controller (minimal)
  * I3C Controller
+ * Internal Bridge Controller (SLI dummy)
 
 
 Missing devices
@@ -95,6 +101,10 @@ or directly from the OpenBMC GitHub release repository :
 
    https://github.com/openbmc/openbmc/releases
 
+or directly from the ASPEED Forked OpenBMC GitHub release repository :
+
+   https://github.com/AspeedTech-BMC/openbmc/releases
+
 To boot a kernel directly from a Linux build tree:
 
 .. code-block:: bash
@@ -164,6 +174,27 @@ under Linux), use :
 
   -M ast2500-evb,bmc-console=uart3
 
+
+Boot the AST2700 machine from the flash image, use an MTD drive :
+
+.. code-block:: bash
+
+  IMGDIR=ast2700-default
+  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
+
+  $ qemu-system-aarch64 -M ast2700-evb \
+       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
+       -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=u-boot.dtb \
+       -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
+       -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin \
+       -device loader,cpu-num=0,addr=0x430000000 \
+       -device loader,cpu-num=1,addr=0x430000000 \
+       -device loader,cpu-num=2,addr=0x430000000 \
+       -device loader,cpu-num=3,addr=0x430000000 \
+       -smp 4 \
+       -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd \
+       -nographic
+
 Aspeed minibmc family boards (``ast1030-evb``)
 ==================================================================
 
-- 
2.25.1


