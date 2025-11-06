Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472A9CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 08:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGvgY-0002vv-VN; Thu, 06 Nov 2025 03:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGvgW-0002vE-3V; Thu, 06 Nov 2025 03:49:36 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGvgT-0005Sg-So; Thu, 06 Nov 2025 03:49:35 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 6 Nov
 2025 16:49:25 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 6 Nov 2025 16:49:25 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 00/12] hw/arm/aspeed: Add AST1060 SoC and EVB support
Date: Thu, 6 Nov 2025 16:49:09 +0800
Message-ID: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

v1:
  1. Add SFDP table for Winbond W25Q02JVM flash
  2. Add AST1060 SoC and EVB support
  3. Fix missing SPI IRQ connection causing DMA interrupt failure
  4. Fix the revision ID cannot be set in the SOC layer for AST2600 and AST1030

Jamin Lin (12):
  hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA interrupt
    failure
  hw/block/m25p80: Add SFDP table for Winbond W25Q02JVM flash
  hw/misc/aspeed_scu: Fix the revision ID cannot be set in the SOC layer
    for AST2600 and AST1030
  hhw/misc/aspeed_scu: Add AST1060 A2 silicon revision definition
  hw/arm/aspeed_ast10x0: Add common init function for AST10x0 SoCs
  hw/arm/aspeed_ast10x0: Add common realize function for AST10x0 SoCs
  hw/arm/aspeed_ast10x0: Pass SoC name to common init for AST10x0 family
    reuse
  hw/arm/aspeed_ast10x0: Add AST1060 SoC support
  hw/arm/aspeed_ast10x0_evb: Add AST1060 EVB machine support
  tests/functional/arm/test_aspeed_ast1060: Add functional tests for
    Aspeed AST1060 SoC
  docs/system/arm/aspeed: Update Aspeed and 2700 family boards list
  docs/system/arm/aspeed: Update Aspeed MiniBMC section to include
    AST1060 PFR processor

 docs/system/arm/aspeed.rst                  |  28 ++-
 hw/block/m25p80_sfdp.h                      |   1 +
 include/hw/misc/aspeed_scu.h                |   1 +
 hw/arm/aspeed_ast10x0.c                     | 216 +++++++++++++-------
 hw/arm/aspeed_ast10x0_evb.c                 |  23 +++
 hw/arm/aspeed_ast2600.c                     |   2 +
 hw/arm/aspeed_ast27x0.c                     |   2 +
 hw/block/m25p80.c                           |   2 +
 hw/block/m25p80_sfdp.c                      |  36 ++++
 hw/misc/aspeed_scu.c                        |   5 +-
 tests/functional/arm/meson.build            |   1 +
 tests/functional/arm/test_aspeed_ast1060.py |  52 +++++
 12 files changed, 287 insertions(+), 82 deletions(-)
 create mode 100644 tests/functional/arm/test_aspeed_ast1060.py

-- 
2.43.0


