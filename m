Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2AFC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8d1-0004mY-Vm; Thu, 06 Mar 2025 05:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8d0-0004mG-5w; Thu, 06 Mar 2025 05:38:58 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8cw-0000St-9p; Thu, 06 Mar 2025 05:38:57 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 6 Mar
 2025 18:38:46 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 6 Mar 2025 18:38:46 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v5 00/29] Support AST2700 A1
Date: Thu, 6 Mar 2025 18:38:08 +0800
Message-ID: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
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

v1:
 1. Refactor INTC model to support both INTC0 and INTC1.
 2. Support AST2700 A1.
 3. Create ast2700a0-evb machine.
 
v2:
  To streamline the review process, split the following patch series into
  three parts.
  https://patchwork.kernel.org/project/qemu-devel/cover/20250121070424.2465942-1-jamin_lin@aspeedtech.com/
  This patch series focuses on cleaning up the INTC model to
  facilitate future support for the INTC_IO model.

v3:
 1. Update and add functional test for AST2700
 2. Add AST2700 INTC design guidance and its block diagram.
 3. Retaining the INTC naming and introducing a new INTCIO model to support the AST2700 A1.
 4. Create ast2700a1-evb machine and rename ast2700a0-evb machine
 5. Fix silicon revision issue and support AST2700 A1.

v4:
 1. rework functional test for AST2700
 2. the initial machine "ast2700-evb" is aliased to "ast2700a0-evb.
 3. intc: Reduce regs array size by adding a register sub-region
 4. intc: split patch for Support setting different register sizes
 5. update ast2700a1-evb machine parent to TYPE_ASPEED_MACHINE

v5:
 1. Rename status_addr and addr to status_reg and reg for clarity
 2. Introduce dynamic allocation for regs array
 3. Sort the memmap table by mapping address
 4. ast27x0.c split patch for Support two levels of INTC controllers for AST2700 A1
 5. tests/functional/aspped split patch for Introduce start_ast2700_test API
 6. keep variable naming for reviewer suggestion.
 7. Add reviewer suggestion and split patch to make more readable.
 
With the patch applied, QEMU now supports two machines for running AST2700 SoCs:
ast2700a0-evb: Designed for AST2700 A0
ast2700a1-evb: Designed for AST2700 A1

Test information
1. QEMU version: https://github.com/qemu/qemu/commit/50d38b8921837827ea397d4b20c8bc5efe186e53
2. ASPEED SDK v09.05 pre-built image
   https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.05
   ast2700-default-obmc.tar.gz (AST2700 A1)
   https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz
   ast2700-a0-default-obmc.tar.gz (AST2700 A0)
   https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-a0-default-obmc.tar.gz
   
This patch series depends on the following patch series:
https://patchwork.kernel.org/project/qemu-devel/cover/20250303073547.1145080-1-jamin_lin@aspeedtech.com/
https://patchwork.kernel.org/project/qemu-devel/cover/20250225075622.305515-1-jamin_lin@aspeedtech.com/

Jamin Lin (29):
  hw/intc/aspeed: Support setting different memory size
  hw/intc/aspeed: Rename status_addr and addr to status_reg and reg for
    clarity
  hw/intc/aspeed: Introduce dynamic allocation for regs array
  hw/intc/aspeed: Support setting different register size
  hw/intc/aspeed: Reduce regs array size by adding a register sub-region
  hw/intc/aspeed: Introduce helper functions for enable and status
    registers
  hw/intc/aspeed: Add object type name to trace events for better
    debugging
  hw/arm/aspeed: Rename IRQ table and machine name for AST2700 A0
  hw/arm/aspeed_ast27x0: Sort the IRQ table by IRQ number
  hw/intc/aspeed: Support different memory region ops
  hw/intc/aspeed: Rename num_ints to num_inpins for clarity
  hw/intc/aspeed: Add support for multiple output pins in INTC
  hw/intc/aspeed: Refactor INTC to support separate input and output pin
    indices
  hw/intc/aspeed: Introduce AspeedINTCIRQ structure to save the irq
    index and register address
  hw/intc/aspeed: Introduce IRQ handler function to reduce code
    duplication
  hw/intc/aspeed: Add Support for Multi-Output IRQ Handling
  hw/intc/aspeed: Add Support for AST2700 INTCIO Controller
  hw/misc/aspeed_scu: Add Support for AST2700/AST2750 A1 Silicon
    Revisions
  hw/arm/aspeed_ast27x0.c Support AST2700 A1 GIC Interrupt Mapping
  hw/arm/aspeed_ast27x0: Define an Array of AspeedINTCState with Two
    Instances
  hw/arm/aspeed_ast27x0: Support two levels of INTC controllers for
    AST2700 A1
  hw/arm/aspeed_ast27x0: Add SoC Support for AST2700 A1
  hw/arm/aspeed: Add Machine Support for AST2700 A1
  hw/arm/aspeed_ast27x0: Sort the memmap table by mapping address
  tests/functional/aspeed: Introduce start_ast2700_test API
  tests/functional/aspeed: Update temperature hwmon path
  tests/functional/aspeed: Update test ASPEED SDK v09.05
  tests/functional/aspeed: Add test case for AST2700 A1
  docs/specs: Add aspeed-intc

 docs/specs/aspeed-intc.rst              | 136 +++++
 docs/specs/index.rst                    |   1 +
 include/hw/arm/aspeed_soc.h             |   3 +-
 include/hw/intc/aspeed_intc.h           |  36 +-
 include/hw/misc/aspeed_scu.h            |   2 +
 hw/arm/aspeed.c                         |  33 +-
 hw/arm/aspeed_ast27x0.c                 | 329 ++++++++----
 hw/intc/aspeed_intc.c                   | 667 ++++++++++++++++++------
 hw/misc/aspeed_scu.c                    |   2 +
 hw/intc/trace-events                    |  25 +-
 tests/functional/test_aarch64_aspeed.py |  47 +-
 11 files changed, 978 insertions(+), 303 deletions(-)
 create mode 100644 docs/specs/aspeed-intc.rst

-- 
2.43.0


