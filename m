Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98EBC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFVS-0003dJ-OS; Wed, 16 Jul 2025 23:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUa-0003MV-Ny; Wed, 16 Jul 2025 23:41:09 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUY-0000YT-8K; Wed, 16 Jul 2025 23:41:08 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/21] Control coprocessor reset for AST2700
Date: Thu, 17 Jul 2025 11:40:28 +0800
Message-ID: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

v1
 - Added support for Vboot ROM.
 - Moved coprocessor initialization from machine level to SoC level
 - Unified SCU controllers between PSP and coprocessors
 - Shared the same SRAM between PSP and coprocessors
 - Support PSP DRAM remaps coprocessor SDRAM
 - Added support for controlling coprocessor reset via SCU registers.
 
Jamin Lin (21):
  hw/arm/aspeed_ast27x0-fc: Support VBootRom
  hw/arm/ast27x0: Move SSP coprocessor initialization from machine to
    SoC leve
  hw/arm/ast27x0: Move TSP coprocessor initialization from machine to
    SoC leve
  hw/arm/aspeed_ast27x0-ssp: Switch SSP memory to SDRAM and use
    dram_container for remap support
  hw/arm/aspeed_ast27x0-tsp: Switch TSP memory to SDRAM and use
    dram_container for remap support
  hw/arm/ast27x0: Add SRAM alias for SSP and ensure correct device
    realization order
  hw/arm/ast27x0: Add SRAM alias for TSP and ensure correct device
    realization order
  hw/arm/ast27x0: Add SCU alias for SSP and ensure correct device
    realization order
  hw/arm/ast27x0: Add SCU alias for TSP and ensure correct device
    realization order
  hw/arm/ast27x0: Move DRAM and SDMC initialization earlier to support
    memory aliasing
  hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap and update
    realization order
  hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap and update
    realization order
  hw/arm/ast27x0: Start SSP in powered-off state to match hardware
    behavior
  hw/arm/ast27x0: Start TSP in powered-off state to match hardware
    behavior
  hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap
  hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap
  hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU
    registers
  hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU
    registers
  pc-bios: Update AST27x0 vBootrom with SSP/TSP SCU initialization
    support
  tests/function/aspeed: Replace manual loader with vbootrom for
    ast2700fc test
  docs: Add support vbootrom for ast2700fc

 docs/system/arm/aspeed.rst                    |  41 +++-
 include/hw/arm/aspeed_soc.h                   |  48 +++--
 include/hw/misc/aspeed_scu.h                  |   4 +
 hw/arm/aspeed_ast27x0-fc.c                    | 133 +++++++-----
 hw/arm/aspeed_ast27x0-ssp.c                   |  46 +++--
 hw/arm/aspeed_ast27x0-tsp.c                   |  43 ++--
 hw/arm/aspeed_ast27x0.c                       | 188 +++++++++++++++--
 hw/misc/aspeed_scu.c                          | 194 +++++++++++++++++-
 pc-bios/ast27x0_bootrom.bin                   | Bin 15552 -> 17192 bytes
 .../test_aarch64_aspeed_ast2700fc.py          |  47 +----
 10 files changed, 562 insertions(+), 182 deletions(-)

-- 
2.43.0


