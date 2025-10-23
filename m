Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DA5CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs9I-0001KD-T3; Thu, 23 Oct 2025 06:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs8w-0001Gb-HH; Thu, 23 Oct 2025 06:02:05 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs8u-00039r-8P; Thu, 23 Oct 2025 06:02:02 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Oct
 2025 18:01:50 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Oct 2025 18:01:50 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 00/13] Split AST2500 SoC machines into separate source
 files for maintainability
Date: Thu, 23 Oct 2025 18:01:33 +0800
Message-ID: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
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
 1. Move "AspeedMachineState" definition to a shared header.
 2. Make common helper functions globally accessible.
 3. Split each AST2500 machine into its own source file:
   - FP5280G2
   - G220A
   - Tiogapass
   - YosemiteV2
   - Witherspoon
   - Sonorapass
   - Romulus
   - Supermicro X11SPI
   - AST2500 EVB
 
Jamin Lin (13):
  hw/arm/aspeed: Move AspeedMachineState definition to common header for
    reuse
  hw/arm/aspeed: Make aspeed_machine_class_init_cpus_defaults() globally
    accessible
  hw/arm/aspeed: Make create_pca9552() globally accessible for reuse
  hw/arm/aspeed: Make create_pca9554() available for use by other Aspeed
    machines
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

 hw/arm/aspeed_eeprom.h                    |   7 -
 include/hw/arm/aspeed.h                   |  17 +
 hw/arm/aspeed.c                           | 508 +---------------------
 hw/arm/aspeed_ast2500_evb.c               |  66 +++
 hw/arm/aspeed_ast2500_fp5280g2.c          |  87 ++++
 hw/arm/aspeed_ast2500_g220a.c             |  91 ++++
 hw/arm/aspeed_ast2500_romulus.c           |  61 +++
 hw/arm/aspeed_ast2500_sonorapass.c        | 101 +++++
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  76 ++++
 hw/arm/aspeed_ast2500_tiogapass.c         |  89 ++++
 hw/arm/aspeed_ast2500_witherspoon.c       | 111 +++++
 hw/arm/aspeed_ast2500_yosemitev2.c        |  90 ++++
 hw/arm/aspeed_eeprom.c                    |  44 --
 hw/arm/meson.build                        |   9 +
 14 files changed, 801 insertions(+), 556 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_evb.c
 create mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c
 create mode 100644 hw/arm/aspeed_ast2500_g220a.c
 create mode 100644 hw/arm/aspeed_ast2500_romulus.c
 create mode 100644 hw/arm/aspeed_ast2500_sonorapass.c
 create mode 100644 hw/arm/aspeed_ast2500_supermicro-x11spi.c
 create mode 100644 hw/arm/aspeed_ast2500_tiogapass.c
 create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c
 create mode 100644 hw/arm/aspeed_ast2500_yosemitev2.c

-- 
2.43.0


