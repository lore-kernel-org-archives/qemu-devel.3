Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC55C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpMc-0007OP-7R; Tue, 11 Aug 2026 12:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMN-0007Ii-CZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMK-00008Q-SY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FNCbyNifK4aYjMWqiC8BbqPjMYQgCkxb/7LLE+5L/2s=;
 b=XWthKijbIMtzbNEvV1krqkS/J/JYLT8eOlVCT54VzKctLRt/B8uvW1ozrxqmx8Z2ZusNgH
 nzEYh7iLiE8xzzaS03AkWLoxfuWIlfZETufYruJIraaN75M5cGmCoH1a36OYPe3nR7ISsg
 6lvt50MxWnLgfedW3/JvxZKu+jVYMww=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-qoFXX93iOXaM_PmXBG1ZTg-1; Tue,
 11 Aug 2026 12:29:43 -0400
X-MC-Unique: qoFXX93iOXaM_PmXBG1ZTg-1
X-Mimecast-MFC-AGG-ID: qoFXX93iOXaM_PmXBG1ZTg_1786465783
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE41F1800876; Tue, 11 Aug 2026 16:29:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B569195DF98; Tue, 11 Aug 2026 16:29:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/83] aspeed queue
Date: Tue, 11 Aug 2026 18:28:15 +0200
Message-ID: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:

  Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260811

for you to fetch changes up to 0375f6498eee6188089924bb766c653492ff8857:

  tests/qtest/aspeed-hace: Test the crypto command on the AST2700 (2026-08-11 18:25:58 +0200)

----------------------------------------------------------------
aspeed queue:

* Fixes missing Kconfig dependencies for Aspeed boards
* Adds 64-bit addressing support to the EHCI USB controller model.
  Enable it on the AST2700
* Extends Aspeed SMC qtest coverage with fast-read, DOR and QOR
  read modes
* Introduces a separate Aspeed2700SCUState type and shares the SCUIO,
  FMC and SCU instances across the AST2700 PSP, SSP and TSP
  coprocessors
* Adds Data FIFO-based flash access for the AST2700 FMC controller
* Adds the ADC128D818 12-bit 8-channel ADC sensor device with tests,
  wired up on the Anacapa board
* Reworks the PCA9552/PCA9555 GPIO/LED driver: polarity inversion,
  datasheet-conformant command handling, GPIO QOM properties, reset
  via the Resettable interface, and extensive qtest coverage
* Reworks the PCA9554 GPIO driver: output-to-input reflection,
  PCA9536 support, pin direction property, and qtest coverage
* Adds PCA9555 IO expanders and temperature sensors to the Catalina
  board
* Adds AST2700 I2C master buffer mode support
* Updates ASPEED functional tests to SDK v11.03 and Zephyr SDK v03.08
* Adds AES-GCM support to the QEMU crypto cipher layer (gcrypt,
  nettle, gnutls backends) with unit tests
* Adds crypto (AES) command emulation to the Aspeed HACE model:
  direct access, scatter-gather, CTR, GCM modes, 64-bit DMA, with
  qtest coverage on AST2500, AST2600, AST1030 and AST2700

----------------------------------------------------------------
Carlo Marcelo Arenas Belón (1):
      hw/arm/aspeed: avoid sign mismatch on sscanf for uart property

Cédric Le Goater (4):
      tests/qtest: aspeed_smc: Introduce read_page_mem_fn for page read helpers
      tests/qtest: aspeed_smc: Add fast-read test coverage
      tests/qtest: aspeed_smc: Add Dual Output Read (DOR) test coverage
      tests/qtest: aspeed_smc: Add Quad Output Read (QOR) test coverage

Emmanuel Blot (32):
      hw/sensor: adc128d818: add 12-bit 8-channel ADC device
      tests/qtest: adc128d818: add test harness and register access
      tests/qtest: adc128d818: test voltage and temperature conversion
      tests/qtest: adc128d818: test limit interrupts
      tests/qtest: adc128d818: test operating modes and power control
      hw/arm/aspeed: anacapa: use ASCII in comments
      hw/arm: anacapa: add ADC128D818 devices
      hw/gpio: pca9552: register types with DEFINE_TYPES()
      hw/gpio: pca9552: move PCA955xState definition out of the header
      hw/gpio: pca9552: rename I2CSlave member to parent_obj
      hw/gpio: pca9552: default description to the instantiated type name
      hw/gpio: pca9552: declare pca9555 device as an alias of pca9535 device
      hw/gpio: pca9552: use the Resettable interface instead of legacy reset
      hw/gpio: pca9552: apply input polarity inversion on read
      hw/gpio: pca9552: conform GPIO command handling to the datasheet
      hw/gpio: pca9552: expose GPIO pins as pin%d QOM properties
      tests/qtest: add PCA9555 register access tests
      tests/qtest: pca9555: test output-to-input reflection and pull-ups
      tests/qtest: pca9555: test polarity inversion
      tests/qtest: pca9555: test auto-increment and command wrapping
      tests/qtest: pca9552: test behaviour specific to the LED variant
      hw/gpio: pca9554: add PCA9536 support
      hw/gpio: pca9554: add hw-dir property honoring the configured pin direction
      hw/gpio: pca9554: reflect push-pull outputs in the input register
      hw/gpio: pca9554: expose pin%d as a string property
      tests/qtest: add PCA9554 register access tests
      tests/qtest: pca9554: test output-to-input reflection and pull-ups
      tests/qtest: pca9554: test polarity inversion
      tests/qtest: pca9554: test absence of command auto-increment
      tests/qtest: pca9554: test the PCA9536 4-bit variant
      hw/arm: catalina: model PCA9555 IO expanders with their own type
      hw/arm: catalina: add NIC and FIO temperature sensors

Jamin Lin (43):
      hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with migration compatibility
      hw/usb/hcd-ehci: Add property to advertise 64-bit addressing capability
      hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing
      hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing
      hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing
      hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing
      hw/usb/hcd-ehci: Add ctrldssegment-default property
      hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
      hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing
      tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for AST2700 A1/A2
      hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
      hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
      hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors
      hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
      hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP initialization
      hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP
      hw/arm/ast27x0: Share FMC controller with SSP and TSP
      hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for AST2700
      tests/qtest/ast2700-smc-test: Add Data FIFO mode test
      hw/i2c/aspeed_i2c: Support the AST2700 master buffer mode
      tests/functional/aarch64/test_aspeed_ast2700a2: Update ASPEED SDK v11.03
      tests/functional/aarch64/test_aspeed_ast2700a1: Update ASPEED SDK v11.03
      tests/functional/aarch64/test_aspeed_ast2700fc: Update ASPEED SDK v11.03
      tests/functional/arm/test_aspeed_ast2600_sdk: Update ASPEED SDK v11.03
      tests/functional/arm/test_aspeed_ast2500_sdk: Update ASPEED SDK v11.03
      tests/functional/arm/test_aspeed_ast1030: Update ASPEED Zephyr SDK v03.08
      tests/functional/arm/test_aspeed_ast1060: Update ASPEED ZEPHYR PROJECT v03.07
      hw/misc/aspeed_hace: Support the crypto command in direct access mode
      tests/qtest/aspeed-hace: Test the crypto command on the AST2500
      hw/misc/aspeed_hace: Support scatter-gather mode for the crypto command
      hw/misc/aspeed_hace: Support the CTR mode for the crypto command
      tests/qtest/aspeed-hace: Test the crypto command on the AST2600
      tests/qtest/aspeed-hace: Test the crypto command on the AST1030
      crypto/cipher: Add GCM to QCryptoCipherMode
      crypto/cipher: Add setaad/gettag for AEAD modes
      crypto/cipher-gcrypt: Implement AES-GCM
      crypto/cipher-nettle: Implement AES-GCM
      crypto/cipher-gnutls: Implement AES-GCM
      tests/unit/test-crypto-cipher: Test AES-GCM mode
      hw/misc/aspeed_hace: Support 64-bit DMA for the crypto command
      hw/misc/aspeed_hace: Support the AES-GCM mode for the crypto command
      hw/misc/aspeed_hace: Enable the crypto command on the AST2700
      tests/qtest/aspeed-hace: Test the crypto command on the AST2700

Philippe Mathieu-Daudé (3):
      hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT Kconfig dependency
      hw/arm/aspeed: Add missing Kconfig dependencies on required components
      hw/arm/aspeed: Add missing Kconfig dependencies on optional components

 qapi/crypto.json                                   |   4 +-
 crypto/cipherpriv.h                                |   8 +
 hw/usb/hcd-ehci.h                                  |  42 +-
 include/crypto/cipher.h                            |  36 +
 include/hw/arm/aspeed_ast1700.h                    |   2 +-
 include/hw/arm/aspeed_coprocessor.h                |  16 +-
 include/hw/arm/aspeed_soc.h                        |   1 +
 include/hw/gpio/pca9552.h                          |  31 +-
 include/hw/gpio/pca9554.h                          |   3 +
 include/hw/i2c/aspeed_i2c.h                        |   2 +
 include/hw/misc/aspeed_hace.h                      |   1 -
 include/hw/misc/aspeed_scu.h                       |   5 +
 include/hw/sensor/adc128d818.h                     |  14 +
 include/hw/ssi/aspeed_smc.h                        |   3 +-
 tests/qtest/aspeed-hace-utils.h                    |  20 +
 tests/qtest/aspeed-smc-utils.h                     |  35 +-
 crypto/cipher.c                                    |  32 +
 hw/arm/aspeed.c                                    |   2 +-
 hw/arm/aspeed_ast2600_anacapa.c                    |  27 +-
 hw/arm/aspeed_ast2600_catalina.c                   |  54 +-
 hw/arm/aspeed_ast27x0-fc.c                         |  38 +-
 hw/arm/aspeed_ast27x0-ssp.c                        |  56 +-
 hw/arm/aspeed_ast27x0-tsp.c                        |  56 +-
 hw/arm/aspeed_ast27x0.c                            |  21 +-
 hw/arm/aspeed_coprocessor_common.c                 |   2 -
 hw/core/machine.c                                  |   2 +
 hw/gpio/pca9552.c                                  | 256 ++++--
 hw/gpio/pca9554.c                                  | 175 +++--
 hw/i2c/aspeed_i2c.c                                |  79 ++
 hw/misc/aspeed_hace.c                              | 461 ++++++++++-
 hw/misc/aspeed_scu.c                               |  20 +-
 hw/sensor/adc128d818.c                             | 696 +++++++++++++++++
 hw/ssi/aspeed_smc.c                                | 117 ++-
 hw/usb/hcd-ehci.c                                  | 214 ++++--
 tests/qtest/adc128d818-test.c                      | 856 +++++++++++++++++++++
 tests/qtest/aspeed-hace-utils.c                    | 693 +++++++++++++++++
 tests/qtest/aspeed-smc-utils.c                     | 294 ++++++-
 tests/qtest/aspeed_hace-test.c                     |  18 +
 tests/qtest/aspeed_smc-test.c                      |  71 +-
 tests/qtest/ast2700-hace-test.c                    |   9 +
 tests/qtest/ast2700-smc-test.c                     |  16 +
 tests/qtest/pca9552-test.c                         |  76 ++
 tests/qtest/pca9554-test.c                         | 223 ++++++
 tests/qtest/pca9555-test.c                         | 251 ++++++
 tests/unit/test-crypto-cipher.c                    | 240 ++++++
 crypto/cipher-gcrypt.c.inc                         | 101 +++
 crypto/cipher-gnutls.c.inc                         | 154 ++++
 crypto/cipher-nettle.c.inc                         | 128 +++
 hw/arm/Kconfig                                     |   7 +-
 hw/pci-host/Kconfig                                |   1 +
 hw/sensor/Kconfig                                  |   4 +
 hw/sensor/meson.build                              |   1 +
 hw/sensor/trace-events                             |   8 +
 hw/usb/trace-events                                |  26 +-
 tests/functional/aarch64/test_aspeed_ast2700a1.py  |  34 +-
 tests/functional/aarch64/test_aspeed_ast2700a2.py  |  34 +-
 tests/functional/aarch64/test_aspeed_ast2700fc.py  |  21 +-
 tests/functional/arm/test_aspeed_ast1030.py        |  12 +-
 tests/functional/arm/test_aspeed_ast1060.py        |  14 +-
 tests/functional/arm/test_aspeed_ast2500_sdk.py    |   8 +-
 .../functional/arm/test_aspeed_ast2500_sdk_515.py  |   8 +-
 tests/functional/arm/test_aspeed_ast2600_sdk.py    |   8 +-
 .../functional/arm/test_aspeed_ast2600_sdk_515.py  |   8 +-
 .../functional/arm/test_aspeed_ast2600_sdk_otp.py  |   8 +-
 tests/qtest/meson.build                            |   9 +-
 65 files changed, 5404 insertions(+), 468 deletions(-)
 create mode 100644 include/hw/sensor/adc128d818.h
 create mode 100644 hw/sensor/adc128d818.c
 create mode 100644 tests/qtest/adc128d818-test.c
 create mode 100644 tests/qtest/pca9554-test.c
 create mode 100644 tests/qtest/pca9555-test.c


