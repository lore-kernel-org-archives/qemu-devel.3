Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDF0E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaAm-0000Ih-Sx; Wed, 04 Feb 2026 05:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAl-0000IY-Ic
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:31:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAj-0003uw-Ft
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=edOKIh/xily7c9Zpea/8inUmbspyHggjGeENNzqE4RM=;
 b=CFM6KlaV0htCQRvIn2PskhWtPpcoShnJDv0tF3DoJLitRoFq9wYdmDgw3h5wzXXqvByEs4
 mswEBdAaIcR3qpgUC0SqgYRJGUya3vtiJx6lpRvcLqWbDFHfQOCJXZ3Bl1OPqei5XceGjJ
 sRGVb9gi5KoP9oKEIqm4CI2zExaRwDk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-yjj4f4MgMTiUxxo81jELyA-1; Wed,
 04 Feb 2026 05:31:41 -0500
X-MC-Unique: yjj4f4MgMTiUxxo81jELyA-1
X-Mimecast-MFC-AGG-ID: yjj4f4MgMTiUxxo81jELyA_1770201100
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EBCE1956061; Wed,  4 Feb 2026 10:31:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 285AC18003F6; Wed,  4 Feb 2026 10:31:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/45] aspeed queue
Date: Wed,  4 Feb 2026 11:30:51 +0100
Message-ID: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 28a6ca268c2cd3718b5bf24c2d97e3d1e95fc604:

  Merge tag 'single-binary-20260203' of https://github.com/philmd/qemu into staging (2026-02-04 01:57:26 +1000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260204

for you to fetch changes up to e56e45d5bdc808ed52f943d1a785e4d885b6f18f:

  tests/functional/aarch64: Add I2C test for AST1700 IO expanders (2026-02-04 10:10:57 +0100)

----------------------------------------------------------------
aspeed queue:

* Added support for the new AST1700 IO expander, including several
  device models (LTPI, PWM, I2C, GPIO, etc.).
* Updated the AST2700 SoC with LTPI support, EHCI IRQ fixes, and other
  improvements.
* Updated test images and test cases for various Aspeed platforms.
* Fixed issues in the Aspeed I2C and ADC models.
* Added support for pca9535 GPIO expander.
* Updated documentation for Aspeed boards.

----------------------------------------------------------------
Cédric Le Goater (3):
      Merge tag 'pull-vbootrom-20260116-v3' into aspeed-next
      tests/functional/arm/aspeed: Update buildroot images to 2025.11
      hw/adc: Fix out-of-bounds write in Aspeed ADC model

Jamin Lin (17):
      pc-bios: Update vbootrom image to commit 1c8e9510b22c
      MAINTAINERS: Update ASPEED entry
      tests/functional/arm/test_aspeed_ast2500: Update test ASPEED SDK v10.00
      hw/pci-host/aspeed_pcie: Drop AST2600 PCIe root device
      hw/pci-host/aspeed_pcie: Drop AST2600 RC_H root-bus remap and bus-nr property
      hw/arm/aspeed_ast2600: Expand RC_H PCIe MMIO window to 0x60000000 - 0x80000000
      tests/functional/arm/test_aspeed_ast2600_sdk: Update test ASPEED SDK v11.00
      tests/functional/arm/test_aspeed_ast1060: Update test aspeed-zephyr-project v03.04
      tests/functional/arm/test_aspeed_ast1030: Update test ASPEED Zephyr SDK v03.05
      hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
      hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap tables by address
      hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
      hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
      tests/functional/aarch64/test_aspeed_ast2700: Enable PCIe2 DTS status for AST2700 tests
      tests/functional/aarch64/test_aspeed_ast2700: Update test ASPEED SDK v11.00 for A1
      tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED SDK v11.00 for A1
      docs/system/arm/aspeed: Load raw U-Boot image in AST2700 boot example

Kane Chen (22):
      hw/misc: Add LTPI controller
      hw/arm/aspeed: Attach LTPI controller to AST27X0 platform
      hw/misc: Add basic Aspeed PWM model
      hw/arm/aspeed: Add AST1700 LTPI expander device model
      hw/arm/aspeed: Integrate AST1700 device into AST27X0
      hw/arm/aspeed: Integrate interrupt controller for AST1700
      hw/arm/aspeed: Attach LTPI controller to AST1700 model
      hw/arm/aspeed: Attach UART device to AST1700 model
      hw/arm/aspeed: Attach SRAM device to AST1700 model
      hw/arm/aspeed: Attach SPI device to AST1700 model
      hw/arm/aspeed: Attach ADC device to AST1700 model
      hw/arm/aspeed: Attach SCU device to AST1700 model
      hw/arm/aspeed: Attach GPIO device to AST1700 model
      hw/arm/aspeed: attach I2C device to AST1700 model
      hw/arm/aspeed: Attach WDT device to AST1700 model
      hw/arm/aspeed: Attach PWM device to AST1700 model
      hw/arm/aspeed: Attach SGPIOM device to AST1700 model
      hw/arm/aspeed: Model AST1700 I3C block as unimplemented device
      hw/arm/aspeed: Enable AST1700 IO expander support
      tests/functional/aarch64: Parameterize I2C bus ID in AST2700 test
      tests/functional/aarch64: Parameterize PCIe2 initialization in AST2700
      tests/functional/aarch64: Add I2C test for AST1700 IO expanders

Kane-Chen-AS (1):
      hw/i2c/aspeed: Introduce 'bus-label' to customize bus naming

Nabih Estefan (1):
      hw/i2c/aspeed_i2c.c: Add a check for dma_read

Patrick Williams (2):
      hw/gpio/pca9552: add pca9535 support
      hw/arm/aspeed: catalina: use pca9535

 MAINTAINERS                                        |   2 +
 docs/system/arm/aspeed.rst                         |   8 +-
 include/hw/arm/aspeed_ast1700.h                    |  54 ++++
 include/hw/arm/aspeed_soc.h                        |  25 +-
 include/hw/gpio/pca9552.h                          |   1 +
 include/hw/gpio/pca9552_regs.h                     |  10 +
 include/hw/i2c/aspeed_i2c.h                        |   2 +
 include/hw/intc/aspeed_intc.h                      |   2 +
 include/hw/misc/aspeed_ltpi.h                      |  33 +++
 include/hw/misc/aspeed_pwm.h                       |  30 +++
 include/hw/pci-host/aspeed_pcie.h                  |  11 -
 hw/adc/aspeed_adc.c                                |   3 +-
 hw/arm/aspeed_ast1700.c                            | 276 +++++++++++++++++++++
 hw/arm/aspeed_ast2600.c                            |   8 +-
 hw/arm/aspeed_ast2600_catalina.c                   |   4 +-
 hw/arm/aspeed_ast27x0-ssp.c                        |  14 +-
 hw/arm/aspeed_ast27x0-tsp.c                        |  14 +-
 hw/arm/aspeed_ast27x0.c                            | 169 ++++++++++++-
 hw/gpio/pca9552.c                                  | 176 +++++++++----
 hw/i2c/aspeed_i2c.c                                | 120 ++++++---
 hw/intc/aspeed_intc.c                              |  60 +++++
 hw/misc/aspeed_ltpi.c                              | 193 ++++++++++++++
 hw/misc/aspeed_pwm.c                               | 120 +++++++++
 hw/pci-host/aspeed_pcie.c                          |  76 +-----
 hw/arm/meson.build                                 |   1 +
 hw/misc/meson.build                                |   2 +
 hw/misc/trace-events                               |   4 +
 pc-bios/ast27x0_bootrom.bin                        | Bin 16408 -> 28564 bytes
 pc-bios/npcm7xx_bootrom.bin                        | Bin 672 -> 736 bytes
 pc-bios/npcm8xx_bootrom.bin                        | Bin 672 -> 672 bytes
 roms/vbootrom                                      |   2 +-
 tests/functional/aarch64/test_aspeed_ast2700.py    | 137 ++++++----
 tests/functional/aarch64/test_aspeed_ast2700fc.py  |  54 ++--
 tests/functional/arm/test_aspeed_ast1030.py        |  12 +-
 tests/functional/arm/test_aspeed_ast1060.py        |  14 +-
 tests/functional/arm/test_aspeed_ast2500.py        |  16 +-
 .../arm/test_aspeed_ast2600_buildroot.py           |   8 +-
 tests/functional/arm/test_aspeed_ast2600_sdk.py    |  22 +-
 38 files changed, 1352 insertions(+), 331 deletions(-)
 create mode 100644 include/hw/arm/aspeed_ast1700.h
 create mode 100644 include/hw/misc/aspeed_ltpi.h
 create mode 100644 include/hw/misc/aspeed_pwm.h
 create mode 100644 hw/arm/aspeed_ast1700.c
 create mode 100644 hw/misc/aspeed_ltpi.c
 create mode 100644 hw/misc/aspeed_pwm.c


