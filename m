Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70BCC79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GO4-0003KX-RD; Sun, 06 Sep 2026 13:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GO3-0003K7-Nl
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GO1-0008UM-5W
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JL544OwrSE8TOte04vzSmTrJlZeD0ZpTupY2T+oo860=;
 b=DfvrGuSLOov21boVXQ282JkrDaa4oUV/82sXRj1exa6lgxlPl3Abrx/+md7tehRQuHHd91
 cboUm0KXM5EJBtG9rwKWz+8VC39y4Dg4pd1WdOgOP9dUZCKtek/WfHkPlK8d1ZMc188DsH
 K93PjApiO0M7EfxUfH+CGrHrnHsAHxw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-Bo7-mT-7PcuF56WtfnHlcQ-1; Sun,
 06 Sep 2026 13:10:28 -0400
X-MC-Unique: Bo7-mT-7PcuF56WtfnHlcQ-1
X-Mimecast-MFC-AGG-ID: Bo7-mT-7PcuF56WtfnHlcQ_1788714628
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9FB81954AE7; Sun,  6 Sep 2026 17:10:27 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46E621955F06; Sun,  6 Sep 2026 17:10:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/40] aspeed queue
Date: Sun,  6 Sep 2026 19:09:41 +0200
Message-ID: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ff1d2d19d7e24893e2012d879f8e73077e17b9bd:

  Merge tag 'pull-11.1-check-tcg-meson-040926-2' of https://gitlab.com/stsquad/qemu into staging (2026-09-04 16:52:58 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260906

for you to fetch changes up to 1c05d7e94da04129ea16147074fe73158fb85ff9:

  tests/functional: aspeed: optionally check the device tree model on boot (2026-09-05 07:05:11 +0200)

----------------------------------------------------------------
aspeed queue:

* Fixes AST2600 SCU protection key registers on reset
* Fixes I2C byte latching for SMBus block reads
* Hardens EHCI get_dwords()/put_dwords() with DMA error checking
* Adds a second random number generator to the AST2600 SCU
* Adds the ASPEED ACRY RSA accelerator model with ModExp qtest coverage
* Adds ECDSA sign/verify support to the QEMU crypto akcipher layer
  (gcrypt, nettle backends) with tests
* Adds ECDSA verify command to the ASPEED SBC model with qtest  coverage
* Adds the ASPEED UDC (USB Device Controller) with gadget device
  and programmable endpoint DMA, wired on the AST2600
* Reworks the TMP105 temperature sensor: Resettable reset, fault
  queue enforcement, TMP75/TMP175/LM75B variants, and qtest coverage
* Adds the Facebook SanMiguel BMC machine with EEPROM data
* Uses real TMP75/LM75B models on the Catalina and Fuji boards
* Adds optional device tree model checking to functional boot tests

----------------------------------------------------------------
Andrew Jeffery (1):
      hw/misc/aspeed_scu: Set both AST2600 protection key registers on reset

Emmanuel Blot (16):
      hw/sensor: tmp105: make device state private to the implementation
      hw/sensor: tmp105: name the parent object field parent_obj
      hw/sensor: tmp105: implement Resettable reset
      hw/sensor: tmp105: enforce the configurable fault queue
      hw/sensor: tmp105: describe the temperature property
      hw/arm: aspeed: guard board-local temperature-sensor aliases
      hw/sensor: tmp105: add TMP75, TMP175 and LM75B variants
      tests/qtest: tmp105: cover the ALERT fault queue
      tests/qtest: tmp105: cover the TMP75, TMP175 and LM75B variants
      tests/qtest: tmp105: cover one-shot and fault-queue write immunity
      tests/qtest: tmp105: cover shutdown clearing the ALERT across variants
      hw/arm: sanmiguel: add Facebook SanMiguel BMC machine
      hw/arm: sanmiguel: populate EEPROM data
      hw/arm: catalina: use the real TMP75 model
      hw/arm: fuji: use the real TMP75 and LM75B temperature sensors
      tests/functional: aspeed: optionally check the device tree model on boot

Jamin Lin (23):
      hw/i2c/aspeed_i2c: Latch received bytes for SMBus block reads
      hw/usb/hcd-ehci: Check for DMA errors in get_dwords()/put_dwords()
      hw/usb/hcd-ehci: Make get_dwords() return bool
      hw/usb/hcd-ehci: Handle get_dwords() failures in async writeback
      hw/misc/aspeed_scu: Support the second random number generator
      tests/qtest/aspeed-hace-utils: Replace g_printerr() with g_test_skip()
      hw/misc/aspeed_acry: Add ASPEED ACRY model
      hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
      hw/arm/aspeed_ast2600: Wire up the ACRY model
      tests/qtest/aspeed-acry-test: Add RSA ModExp tests
      qapi/crypto: Add ECDSA algorithm and curve id
      crypto/akcipher: Support ECDSA sign/verify with gcrypt
      crypto/akcipher: Support ECDSA sign/verify with nettle
      tests/crypto: Add ECDSA sign/verify tests
      hw/arm/aspeed_ast10x0: Remove obsolete unimplemented SBC mapping
      hw/misc/aspeed_sbc: Increase register space to 0x1000
      hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model
      hw/misc/aspeed_sbc: Support the ECDSA verify command
      tests/qtest: Add ASPEED SBC ECDSA engine test
      hw/usb/aspeed-udc: Add ASPEED UDC device controller
      hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
      hw/usb/aspeed-udc: Add programmable endpoint DMA transfers
      hw/arm/aspeed_ast2600: Wire up the UDC

 qapi/crypto.json                  |   33 +-
 include/hw/arm/aspeed_soc.h       |    9 +-
 include/hw/i2c/aspeed_i2c.h       |    3 +
 include/hw/misc/aspeed_acry.h     |   39 ++
 include/hw/misc/aspeed_sbc.h      |    6 +-
 include/hw/sensor/tmp105.h        |   46 +-
 include/hw/usb/aspeed-udc.h       |   85 +++
 hw/arm/aspeed_ast10x0.c           |   14 +-
 hw/arm/aspeed_ast2600.c           |   71 ++-
 hw/arm/aspeed_ast2600_catalina.c  |    1 -
 hw/arm/aspeed_ast2600_fuji.c      |   16 +-
 hw/arm/aspeed_ast2600_sanmiguel.c |  403 ++++++++++++++
 hw/i2c/aspeed_i2c.c               |   38 +-
 hw/misc/aspeed_acry.c             |  481 +++++++++++++++++
 hw/misc/aspeed_sbc.c              |  158 +++++-
 hw/misc/aspeed_scu.c              |   21 +-
 hw/sensor/tmp105.c                |  300 ++++++++---
 hw/usb/aspeed-udc.c               | 1058 +++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ehci.c                 |   90 ++--
 tests/qtest/aspeed-acry-test.c    |  406 ++++++++++++++
 tests/qtest/aspeed-hace-utils.c   |   24 +-
 tests/qtest/aspeed-sbc-test.c     |  194 +++++++
 tests/qtest/tmp105-test.c         |  359 +++++++++++++
 tests/unit/test-crypto-akcipher.c |  236 +++++++++
 crypto/akcipher-gcrypt.c.inc      |  340 +++++++++++-
 crypto/akcipher-nettle.c.inc      |  272 ++++++++++
 hw/arm/Kconfig                    |    1 +
 hw/arm/meson.build                |    1 +
 hw/misc/meson.build               |    1 +
 hw/misc/trace-events              |    8 +
 hw/usb/Kconfig                    |    4 +
 hw/usb/meson.build                |    1 +
 hw/usb/trace-events               |   16 +
 tests/functional/aspeed.py        |    5 +-
 tests/qtest/meson.build           |    7 +-
 35 files changed, 4552 insertions(+), 195 deletions(-)
 create mode 100644 include/hw/misc/aspeed_acry.h
 create mode 100644 include/hw/usb/aspeed-udc.h
 create mode 100644 hw/arm/aspeed_ast2600_sanmiguel.c
 create mode 100644 hw/misc/aspeed_acry.c
 create mode 100644 hw/usb/aspeed-udc.c
 create mode 100644 tests/qtest/aspeed-acry-test.c
 create mode 100644 tests/qtest/aspeed-sbc-test.c


