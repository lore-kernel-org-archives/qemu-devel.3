Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0BCCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqrM-0000i7-O3; Mon, 03 Nov 2025 04:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqrK-0000hm-LI; Mon, 03 Nov 2025 04:28:18 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqrH-0001jn-0A; Mon, 03 Nov 2025 04:28:18 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 17:28:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 17:28:01 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 00/30] Split AST2400, AST2500, AST2600,
 AST2700 and AST1030 SoC machines into separate source files for
 maintainability
Date: Mon, 3 Nov 2025 17:27:11 +0800
Message-ID: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
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
 1. Split each Aspeed machine into its own source file for better
    readability and maintainability:
    - Quanta-Q71L
    - Supermicro X11
    - Palmetto
    - Bletchley
    - fby35 BMC
    - Facebook Fuji
    - QCOM Firework
    - QCOM DC-SCM V1
    - GB200NVL
    - Rainier
    - Catalina
    - AST2600 EVB
    - AST2700 EVB
    - AST1030 EVB
 2. Make aspeed_machine_ast2600_class_emmc_init() a shared API
    for eMMC boot setup.
 3. Promote connect_serial_hds_to_uarts() to a public machine API
    for reuse across platforms.

v2:
 1. Restore ASPEED_RAM_SIZE() macro

v3:
  1. Merged AST2500 SoC machine changes into this patch series.
   Split each AST2500 machine into its own source file:
   - FP5280G2
   - G220A
   - Tiogapass
   - YosemiteV2
   - Witherspoon
   - Sonorapass
   - Romulus
   - Supermicro X11SPI
   - AST2500 EVB
  2. Renamed common API functions with the aspeed_ prefix for consistency.
  3. Added detailed descriptions for the common API functions.

Jamin Lin (30):
  hw/arm/aspeed: Move AspeedMachineState definition to common header for
    reuse
  hw/arm/aspeed: Make aspeed_machine_class_init_cpus_defaults() globally
    accessible
  hw/arm/aspeed: Export and rename create_pca9552() for reuse
  hw/arm/aspeed: Rename and export create_pca9554() as
    aspeed_create_pca9554()
  hw/arm/aspeed: Split FP5280G2 machine into a separate source file for
    maintenance
  hw/arm/aspeed: Split G220A machine into a separate source file for
    better maintenance
  hw/arm/aspeed: Split Tiogapass machine into a separate source file for
    cleanup
  hw/arm/aspeed: Split YosemiteV2 machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split Witherspoon machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split Sonorapass machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split Romulus machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split Supermicro X11SPI machine into a separate file
    for maintainability
  hw/arm/aspeed: Split AST2500 EVB machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split Quanta-Q71L machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split Supermicro X11 machine into a separate source
    file for maintainability
  hw/arm/aspeed: Split Palmetto machine into a separate source file for
    maintainability
  hw/arm/aspeed: Move ASPEED_RAM_SIZE() macro to common header for reuse
  hw/arm/aspeed: Split Bletchley machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split FBY35 BMC machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split Fuji machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split QCOM Firework machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split QCOM DC-SCM V1 machine into a separate source
    file for maintainability
  hw/arm/aspeed: Make aspeed_machine_ast2600_class_emmc_init() a common
    API for eMMC boot setup
  hw/arm/aspeed: Split GB200NVL machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split Rainier machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split Catalina machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split AST2600 EVB machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split AST2700 EVB machine into a separate source file
    for maintainability
  hw/arm/aspeed: Rename and export connect_serial_hds_to_uarts() as
    aspeed_connect_serial_hds_to_uarts()
  hw/arm/aspeed: Split AST1030 EVB machine into a separate source file
    for maintainability

 hw/arm/aspeed_eeprom.h                    |   32 -
 include/hw/arm/aspeed.h                   |   79 +
 hw/arm/aspeed.c                           | 1678 +--------------------
 hw/arm/aspeed_ast10x0_evb.c               |  109 ++
 hw/arm/aspeed_ast2400_palmetto.c          |   81 +
 hw/arm/aspeed_ast2400_quanta-q71l.c       |   87 ++
 hw/arm/aspeed_ast2400_supermicrox11.c     |   82 +
 hw/arm/aspeed_ast2500_evb.c               |   68 +
 hw/arm/aspeed_ast2500_fp5280g2.c          |   89 ++
 hw/arm/aspeed_ast2500_g220a.c             |   93 ++
 hw/arm/aspeed_ast2500_romulus.c           |   63 +
 hw/arm/aspeed_ast2500_sonorapass.c        |  103 ++
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |   78 +
 hw/arm/aspeed_ast2500_tiogapass.c         |   91 ++
 hw/arm/aspeed_ast2500_witherspoon.c       |  113 ++
 hw/arm/aspeed_ast2500_yosemitev2.c        |   92 ++
 hw/arm/aspeed_ast2600_bletchley.c         |   98 ++
 hw/arm/aspeed_ast2600_catalina.c          |  226 +++
 hw/arm/aspeed_ast2600_evb.c               |   66 +
 hw/arm/aspeed_ast2600_fby35.c             |  179 +++
 hw/arm/aspeed_ast2600_fuji.c              |  141 ++
 hw/arm/aspeed_ast2600_gb200nvl.c          |  112 ++
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c    |   56 +
 hw/arm/aspeed_ast2600_qcom-firework.c     |   92 ++
 hw/arm/aspeed_ast2600_rainier.c           |  199 +++
 hw/arm/aspeed_ast27x0_evb.c               |   89 ++
 hw/arm/aspeed_eeprom.c                    |  192 ---
 hw/arm/meson.build                        |   24 +-
 28 files changed, 2515 insertions(+), 1897 deletions(-)
 delete mode 100644 hw/arm/aspeed_eeprom.h
 create mode 100644 hw/arm/aspeed_ast10x0_evb.c
 create mode 100644 hw/arm/aspeed_ast2400_palmetto.c
 create mode 100644 hw/arm/aspeed_ast2400_quanta-q71l.c
 create mode 100644 hw/arm/aspeed_ast2400_supermicrox11.c
 create mode 100644 hw/arm/aspeed_ast2500_evb.c
 create mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c
 create mode 100644 hw/arm/aspeed_ast2500_g220a.c
 create mode 100644 hw/arm/aspeed_ast2500_romulus.c
 create mode 100644 hw/arm/aspeed_ast2500_sonorapass.c
 create mode 100644 hw/arm/aspeed_ast2500_supermicro-x11spi.c
 create mode 100644 hw/arm/aspeed_ast2500_tiogapass.c
 create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c
 create mode 100644 hw/arm/aspeed_ast2500_yosemitev2.c
 create mode 100644 hw/arm/aspeed_ast2600_bletchley.c
 create mode 100644 hw/arm/aspeed_ast2600_catalina.c
 create mode 100644 hw/arm/aspeed_ast2600_evb.c
 create mode 100644 hw/arm/aspeed_ast2600_fby35.c
 create mode 100644 hw/arm/aspeed_ast2600_fuji.c
 create mode 100644 hw/arm/aspeed_ast2600_gb200nvl.c
 create mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
 create mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c
 create mode 100644 hw/arm/aspeed_ast2600_rainier.c
 create mode 100644 hw/arm/aspeed_ast27x0_evb.c
 delete mode 100644 hw/arm/aspeed_eeprom.c

-- 
2.43.0


