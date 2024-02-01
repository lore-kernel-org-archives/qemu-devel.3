Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E82C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXp6-00014C-N8; Thu, 01 Feb 2024 09:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Qo6T=JK=kaod.org=clg@ozlabs.org>)
 id 1rVXoX-0000vM-Nx; Thu, 01 Feb 2024 09:13:13 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Qo6T=JK=kaod.org=clg@ozlabs.org>)
 id 1rVXoR-0007kI-1S; Thu, 01 Feb 2024 09:13:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TQgq138hSz4wcQ;
 Fri,  2 Feb 2024 01:13:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQgq018Kmz4wcM;
 Fri,  2 Feb 2024 01:12:59 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL v2 00/17] aspeed queue
Date: Thu,  1 Feb 2024 15:12:36 +0100
Message-ID: <20240201141253.806055-1-clg@kaod.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Qo6T=JK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit bd2e12310b18b51aefbf834e6d54989fd175976f:

  Merge tag 'qga-pull-2024-01-30' of https://github.com/kostyanf14/qemu into staging (2024-01-30 15:53:46 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20240201

for you to fetch changes up to 649b8ed20543f1b7f7e3dd8fd409092639bb345e:

  hw/fsi: Update MAINTAINER list (2024-02-01 08:33:18 +0100)

----------------------------------------------------------------
aspeed queue:

* Update of buildroot images to 2023.11 (6.6.3 kernel)
* Check of the valid CPU type supported by aspeed machines
* Simplified models for the IBM's FSI bus and the Aspeed
  controller bridge

Changes since v1:

- Endianness fix
- Renamed test file to match other filenames
- Fixed file list in MAINTAINER
 
----------------------------------------------------------------
Cédric Le Goater (1):
      tests/avocado/machine_aspeed.py: Update buildroot images to 2023.11

Ninad Palsule (11):
      hw/fsi: Introduce IBM's Local bus
      hw/fsi: Introduce IBM's scratchpad device
      hw/fsi: Introduce IBM's FSI Bus
      hw/fsi: Introduce IBM's fsi-slave model
      hw/fsi: Introduce IBM's cfam
      hw/fsi: Introduce IBM's FSI master
      hw/fsi: Aspeed APB2OPB & On-chip peripheral bus
      hw/arm: Hook up FSI module in AST2600
      hw/fsi: Added qtest
      hw/fsi: Added FSI documentation
      hw/fsi: Update MAINTAINER list

Philippe Mathieu-Daudé (5):
      hw/arm/aspeed: Remove dead code
      hw/arm/aspeed: Set default CPU count using aspeed_soc_num_cpus()
      hw/arm/aspeed: Init CPU defaults in a common helper
      hw/arm/aspeed: Introduce aspeed_soc_cpu_type() helper
      hw/arm/aspeed: Check for CPU types in machine_run_board_init()

 MAINTAINERS                     |   9 +
 docs/specs/fsi.rst              | 122 +++++++++++++
 docs/specs/index.rst            |   1 +
 meson.build                     |   1 +
 hw/fsi/trace.h                  |   1 +
 include/hw/arm/aspeed_soc.h     |   8 +-
 include/hw/fsi/aspeed_apb2opb.h |  46 +++++
 include/hw/fsi/cfam.h           |  34 ++++
 include/hw/fsi/fsi-master.h     |  32 ++++
 include/hw/fsi/fsi.h            |  37 ++++
 include/hw/fsi/lbus.h           |  43 +++++
 hw/arm/aspeed.c                 |  70 ++++----
 hw/arm/aspeed_ast10x0.c         |   8 +-
 hw/arm/aspeed_ast2400.c         |  15 +-
 hw/arm/aspeed_ast2600.c         |  28 ++-
 hw/arm/aspeed_soc_common.c      |   8 +
 hw/fsi/aspeed_apb2opb.c         | 367 ++++++++++++++++++++++++++++++++++++++++
 hw/fsi/cfam.c                   | 168 ++++++++++++++++++
 hw/fsi/fsi-master.c             | 170 +++++++++++++++++++
 hw/fsi/fsi.c                    | 102 +++++++++++
 hw/fsi/lbus.c                   | 117 +++++++++++++
 tests/qtest/aspeed_fsi-test.c   | 205 ++++++++++++++++++++++
 hw/Kconfig                      |   1 +
 hw/arm/Kconfig                  |   1 +
 hw/fsi/Kconfig                  |   7 +
 hw/fsi/meson.build              |   2 +
 hw/fsi/trace-events             |  13 ++
 hw/meson.build                  |   1 +
 tests/avocado/machine_aspeed.py |  18 +-
 tests/qtest/meson.build         |   1 +
 30 files changed, 1578 insertions(+), 58 deletions(-)
 create mode 100644 docs/specs/fsi.rst
 create mode 100644 hw/fsi/trace.h
 create mode 100644 include/hw/fsi/aspeed_apb2opb.h
 create mode 100644 include/hw/fsi/cfam.h
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 include/hw/fsi/fsi.h
 create mode 100644 include/hw/fsi/lbus.h
 create mode 100644 hw/fsi/aspeed_apb2opb.c
 create mode 100644 hw/fsi/cfam.c
 create mode 100644 hw/fsi/fsi-master.c
 create mode 100644 hw/fsi/fsi.c
 create mode 100644 hw/fsi/lbus.c
 create mode 100644 tests/qtest/aspeed_fsi-test.c
 create mode 100644 hw/fsi/Kconfig
 create mode 100644 hw/fsi/meson.build
 create mode 100644 hw/fsi/trace-events

