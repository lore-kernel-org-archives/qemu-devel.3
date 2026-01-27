Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E761ED13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfPg-0005TX-PU; Tue, 27 Jan 2026 04:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfPY-0004v7-Vx; Tue, 27 Jan 2026 04:31:03 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfPX-0005A1-40; Tue, 27 Jan 2026 04:31:00 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 17:29:47 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 17:29:47 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 11/11] docs: Add support vbootrom and update Manual boot
 for ast2700fc
Date: Tue, 27 Jan 2026 17:29:40 +0800
Message-ID: <20260127092943.3731635-12-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127092943.3731635-1-jamin_lin@aspeedtech.com>
References: <20260127092943.3731635-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 docs/system/arm/aspeed.rst | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 97e14b7d33..e8d8a85ec4 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -391,6 +391,14 @@ Booting the ast2700fc machine
 AST2700 features four Cortex-A35 primary processors and two Cortex-M4 coprocessors.
 **ast2700-evb** machine focuses on emulating the four Cortex-A35 primary processors,
 **ast2700fc** machine extends **ast2700-evb** by adding support for the two Cortex-M4 coprocessors.
+There are two methods to boot the ast2700fc machine.
+
+Manual boot using ``-device loader``:
+
+In this approach, users manually load firmware and assign entry points via QEMU loader devices.
+By default, the PSP begins execution at address ``0x430000000``, the load address of the bl31
+firmware. The SSP and TSP start in the powered-off state and must be explicitly enabled by the
+PSP through writes to SCU registers.
 
 Steps to boot the AST2700fc machine:
 
@@ -401,8 +409,8 @@ Steps to boot the AST2700fc machine:
  * bl31.bin
  * optee/tee-raw.bin
  * image-bmc
- * zephyr-aspeed-ssp.elf (for SSP firmware, CPU 5)
- * zephyr-aspeed-tsp.elf (for TSP firmware, CPU 6)
+ * zephyr-aspeed-ssp.bin (for SSP firmware, CPU 5)
+ * zephyr-aspeed-tsp.bin (for TSP firmware, CPU 6)
 
 2. Execute the following command to start ``ast2700fc`` machine:
 
@@ -416,17 +424,38 @@ Steps to boot the AST2700fc machine:
        -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
        -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
        -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin \
+       -device loader,addr=0x42C000000,file=${IMGDIR}/zephyr-aspeed-ssp.bin,force-raw=on \
+       -device loader,addr=0x42E000000,file=${IMGDIR}/zephyr-aspeed-tsp.bin,force-raw=on \
        -device loader,cpu-num=0,addr=0x430000000 \
        -device loader,cpu-num=1,addr=0x430000000 \
        -device loader,cpu-num=2,addr=0x430000000 \
        -device loader,cpu-num=3,addr=0x430000000 \
        -drive file=${IMGDIR}/image-bmc,if=mtd,format=raw \
-       -device loader,file=${IMGDIR}/zephyr-aspeed-ssp.elf,cpu-num=4 \
-       -device loader,file=${IMGDIR}/zephyr-aspeed-tsp.elf,cpu-num=5 \
        -serial pty -serial pty -serial pty \
        -snapshot \
        -S -nographic
 
+Boot using a virtual boot ROM (-bios):
+
+In this method, the virtual boot ROM (vbootrom) handles the full initialization sequence.
+It starts the PSP, which then enables the SSP and TSP by programming the appropriate SCU
+registers, following the hardware behavior.
+
+Execute the following command to start ``ast2700fc`` machine:
+
+.. code-block:: bash
+
+  IMGDIR=ast2700-default
+
+  $ qemu-system-aarch64 -M ast2700fc \
+      -bios ast27x0_bootrom.bin \
+      -drive file=${IMGDIR}/image-bmc,if=mtd,format=raw \
+      -serial pty -serial pty -serial pty \
+      -snapshot \
+      -S -nographic
+
+Serial Console Redirection:
+
 After launching QEMU, serial devices will be automatically redirected.
 Example output:
 
-- 
2.43.0


