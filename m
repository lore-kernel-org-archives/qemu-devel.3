Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245B0C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 05:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbOS-0004pF-6s; Thu, 13 Mar 2025 01:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbNz-0004mp-CT; Thu, 13 Mar 2025 01:45:47 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbNv-0005Ve-C3; Thu, 13 Mar 2025 01:45:37 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 13 Mar
 2025 13:40:20 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 13 Mar 2025 13:40:20 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <yunlin.tang@aspeedtech.com>
Subject: [PATCH v2 00/13] Introduce AST27x0 multi-SoC machine
Date: Thu, 13 Mar 2025 13:40:04 +0800
Message-ID: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series introduces full core support for the AST27x0 SoC, along with necessary updates to the ASPEED AST27x0 SOC.
The AST27x0 SoC is a new family of ASPEED SoCs featuring 4 Cortex-A35 cores and 2 Cortex-M4 cores.

v1:
  - Map unimplemented devices in SoC memory
  - Intruduce AST2700 CM4 SoC
  - Introduce AST27x0FC Machine

v2:
  - Remove unused functions
  - Correct hex notation for device addresses in AST27x0 SoC
  - Add AST2700 SSP INTC and AST2700 TSP INTC
  - Split AST27x0 CM4 SoC to AST27x0 SSP SoC and AST27x0 TSP SoC
  - Add AST27x0 A0 SSP SoC and AST27x0 A1 SSP SoC
  - Add AST27x0 A0 TSP SoC and AST27x0 A1 TSP SoC
  - Add functional tests for AST2700FC A0 and AST2700FC A1
  - Add Documentation for AST2700FC

Steven Lee (13):
  aspeed: ast27x0: Map unimplemented devices in SoC memory
  aspeed: ast27x0: Correct hex notation for device addresses
  hw/intc/aspeed: Add support for AST2700 SSP INTC
  hw/intc/aspeed: Add support for AST2700 TSP INTC
  hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A0 SSP SoC
  hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1 SSP SoC
  hw/arm/aspeed_ast27x0-tsp: Introduce AST27x0 A0 TSP SoC
  hw/arm/aspeed_ast27x0-tsp: Introduce AST27x0 A1 TSP SoC
  hw/arm: Introduce ASPEED AST2700 a0 full core machine
  hw/arm: Introduce ASPEED AST2700 a1 full core machine
  tests/function/aspeed: Add functional test for AST2700FC
  tests/function/aspeed: Add functional test for AST2700FC A1
  docs: Add support for ast2700fc machine

 docs/system/arm/aspeed.rst                 |  61 ++-
 include/hw/arm/aspeed_soc.h                |  32 ++
 include/hw/intc/aspeed_intc.h              |   5 +
 hw/arm/aspeed_ast27x0-fc.c                 | 340 +++++++++++++++++
 hw/arm/aspeed_ast27x0-ssp.c                | 400 +++++++++++++++++++
 hw/arm/aspeed_ast27x0-tsp.c                | 400 +++++++++++++++++++
 hw/arm/aspeed_ast27x0.c                    |  79 +++-
 hw/intc/aspeed_intc.c                      | 424 +++++++++++++++++++++
 hw/arm/meson.build                         |   6 +-
 tests/functional/test_aarch64_ast2700fc.py | 161 ++++++++
 10 files changed, 1884 insertions(+), 24 deletions(-)
 create mode 100644 hw/arm/aspeed_ast27x0-fc.c
 create mode 100644 hw/arm/aspeed_ast27x0-ssp.c
 create mode 100644 hw/arm/aspeed_ast27x0-tsp.c
 create mode 100755 tests/functional/test_aarch64_ast2700fc.py

-- 
2.34.1


