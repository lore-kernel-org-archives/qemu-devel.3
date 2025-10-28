Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92A6CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd7W-0006dg-Tb; Tue, 28 Oct 2025 02:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd76-0006Kv-BR; Tue, 28 Oct 2025 02:23:25 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd72-0000XI-8u; Tue, 28 Oct 2025 02:23:24 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Oct
 2025 14:23:08 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Oct 2025 14:23:08 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 00/16] Split AST2400, AST2600,
 AST2700 and AST1030 SoC machines into separate source files for
 maintainability
Date: Tue, 28 Oct 2025 14:22:44 +0800
Message-ID: <20251028062307.2410346-1-jamin_lin@aspeedtech.com>
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

This series depends on the following patch series:
https://patchwork.kernel.org/project/qemu-devel/cover/20251023100150.295370-1-jamin_lin@aspeedtech.com/

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

Jamin Lin (16):
  hw/arm/aspeed: Split Quanta-Q71L machine into a separate source file
    for maintainability
  hw/arm/aspeed: Split Supermicro X11 machine into a separate source
    file for maintainability
  hw/arm/aspeed: Split Palmetto machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split Bletchley machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split fby35 BMC machine into a separate source file for
    maintainability
  hw/arm/aspeed: Split Facebook Fuji machine into a separate source file
    for maintainability
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
  hw/arm/aspeed: Promote connect_serial_hds_to_uarts() to public machine
    API
  hw/arm/aspeed: Split AST1030 EVB machine into a separate source file
    for maintainability

 hw/arm/aspeed_eeprom.h                        |   25 -
 include/hw/arm/aspeed.h                       |    2 +
 hw/arm/aspeed.c                               | 1144 +----------------
 hw/arm/aspeed_ast10x0_evb.c                   |  107 ++
 hw/arm/aspeed_ast2400_palmetto.c              |   79 ++
 hw/arm/aspeed_ast2400_quanta-q71l.c           |   85 ++
 hw/arm/aspeed_ast2400_supermicrox11.c         |   80 ++
 hw/arm/aspeed_ast2600_bletchley.c             |   95 ++
 hw/arm/aspeed_ast2600_catalina.c              |  223 ++++
 hw/arm/aspeed_ast2600_evb.c                   |   64 +
 ...aspeed_eeprom.c => aspeed_ast2600_fby35.c} |  164 ++-
 hw/arm/aspeed_ast2600_fuji.c                  |  138 ++
 hw/arm/aspeed_ast2600_gb200nvl.c              |  109 ++
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c        |   54 +
 hw/arm/aspeed_ast2600_qcom-firework.c         |   90 ++
 hw/arm/aspeed_ast2600_rainier.c               |  197 +++
 hw/arm/aspeed_ast27x0_evb.c                   |   86 ++
 hw/arm/meson.build                            |   15 +-
 18 files changed, 1521 insertions(+), 1236 deletions(-)
 delete mode 100644 hw/arm/aspeed_eeprom.h
 create mode 100644 hw/arm/aspeed_ast10x0_evb.c
 create mode 100644 hw/arm/aspeed_ast2400_palmetto.c
 create mode 100644 hw/arm/aspeed_ast2400_quanta-q71l.c
 create mode 100644 hw/arm/aspeed_ast2400_supermicrox11.c
 create mode 100644 hw/arm/aspeed_ast2600_bletchley.c
 create mode 100644 hw/arm/aspeed_ast2600_catalina.c
 create mode 100644 hw/arm/aspeed_ast2600_evb.c
 rename hw/arm/{aspeed_eeprom.c => aspeed_ast2600_fby35.c} (51%)
 create mode 100644 hw/arm/aspeed_ast2600_fuji.c
 create mode 100644 hw/arm/aspeed_ast2600_gb200nvl.c
 create mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
 create mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c
 create mode 100644 hw/arm/aspeed_ast2600_rainier.c
 create mode 100644 hw/arm/aspeed_ast27x0_evb.c

-- 
2.43.0


