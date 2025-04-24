Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58D7C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rNQ-0001Qw-8i; Thu, 24 Apr 2025 03:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7rNO-0001QX-Mj; Thu, 24 Apr 2025 03:52:06 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7rNN-0006ez-3j; Thu, 24 Apr 2025 03:52:06 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 24 Apr
 2025 15:51:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 24 Apr 2025 15:51:37 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v6 6/6] docs/system/arm/aspeed: Support vbootrom for AST2700
Date: Thu, 24 Apr 2025 15:51:34 +0800
Message-ID: <20250424075135.3715128-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424075135.3715128-1-jamin_lin@aspeedtech.com>
References: <20250424075135.3715128-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Using the vbootrom image support and the boot ROM binary is
now passed via the -bios option, using the image located in
pc-bios/ast27x0_bootrom.bin.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 08a33b7008..014545f444 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -306,7 +306,14 @@ Images can be downloaded from the ASPEED Forked OpenBMC GitHub release repositor
 Booting the ast2700-evb machine
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Boot the AST2700 machine from the flash image, use an MTD drive :
+Boot the AST2700 machine from the flash image.
+
+There are two supported methods for booting the AST2700 machine with a flash image:
+
+Manual boot using ``-device loader``:
+
+It causes all 4 CPU cores to start execution from address ``0x430000000``, which
+corresponds to the BL31 image load address.
 
 .. code-block:: bash
 
@@ -326,6 +333,26 @@ Boot the AST2700 machine from the flash image, use an MTD drive :
        -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd \
        -nographic
 
+Boot using a virtual boot ROM (``-bios``):
+
+If users do not specify the ``-bios option``, QEMU will attempt to load the
+default vbootrom image ``ast27x0_bootrom.bin`` from either the current working
+directory or the ``pc-bios`` directory within the QEMU source tree.
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M ast2700-evb \
+      -drive file=image-bmc,format=raw,if=mtd \
+      -nographic
+
+The ``-bios`` option allows users to specify a custom path for the vbootrom
+image to be loaded during boot. This will load the vbootrom image from the
+specified path in the ${HOME} directory.
+
+.. code-block:: bash
+
+  -bios ${HOME}/ast27x0_bootrom.bin
+
 Aspeed minibmc family boards (``ast1030-evb``)
 ==================================================================
 
-- 
2.43.0


