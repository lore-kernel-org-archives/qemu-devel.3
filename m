Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4ACCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 03:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ1C6-0000rj-4h; Tue, 11 Nov 2025 22:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ1C1-0000py-08; Tue, 11 Nov 2025 22:06:45 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ1Bz-00048F-Mj; Tue, 11 Nov 2025 22:06:44 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Nov
 2025 11:05:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Nov 2025 11:05:57 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 12/12] docs/system/arm/aspeed: Update Aspeed MiniBMC
 section to include AST1060 processor
Date: Wed, 12 Nov 2025 11:05:49 +0800
Message-ID: <20251112030553.291734-13-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
References: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
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

Added details describing AST1060 as a Platform Root of Trust processor board alongside
AST1030 MiniBMC, and extended the list of missing devices to include
SMBus Filter and QSPI Monitor controllers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 docs/system/arm/aspeed.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 81a9699455..4fa1739cb5 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -448,23 +448,24 @@ Use ``tio`` or another terminal emulator to connect to the consoles:
    $ tio /dev/pts/57
 
 
-Aspeed minibmc family boards (``ast1030-evb``)
-==================================================================
+Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast1030-evb``, ``ast1060-evb``)
+====================================================================================================
 
-The QEMU Aspeed machines model mini BMCs of various Aspeed evaluation
-boards. They are based on different releases of the
-Aspeed SoC : the AST1030 integrating an ARM Cortex M4F CPU (200MHz).
+The QEMU Aspeed machines model mini BMCs and Platform Root of Trust processors of various Aspeed
+evaluation boards. They are based on different releases of the Aspeed SoC : the AST1030 (MiniBMC)
+and AST1060 (Platform Root of Trust Processor), both integrating an ARM Cortex M4F CPU (200MHz).
 
 The SoC comes with SRAM, SPI, I2C, etc.
 
-AST1030 SoC based machines :
+AST10x0 SoC based machines :
 
 - ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)
+- ``ast1060-evb``          Aspeed AST1060 Evaluation board (Cortex-M4F)
 
 Supported devices
 -----------------
 
- * SMP (for the AST1030 Cortex-M4F)
+ * SMP (for the Cortex-M4F)
  * Interrupt Controller (VIC)
  * Timer Controller
  * I2C Controller
@@ -492,6 +493,8 @@ Missing devices
  * Virtual UART
  * eSPI Controller
  * I3C Controller
+ * SMBus Filter Controller
+ * QSPI Monitor Controller
 
 Boot options
 ------------
@@ -507,4 +510,4 @@ To boot a kernel directly from a Zephyr build tree:
 .. code-block:: bash
 
   $ qemu-system-arm -M ast1030-evb -nographic \
-        -kernel zephyr.elf
+        -kernel zephyr.bin
-- 
2.43.0


