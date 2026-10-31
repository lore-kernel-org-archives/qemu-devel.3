Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68023606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YFH2JzYh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN336-0002ZR-KP; Sat, 31 Oct 2026 02:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN334-0002Yi-MO
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN332-0002i6-Ob
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Oh/VCsme+5JuR2ZCUD9+uQqhMjzR6BHXhR4NyNW1NM0=;
 b=YFH2JzYhFYQG97jz6l/EWPTKSlmoHTIDBg2MDopWpo/oZCrkvlPyDh4UqQBvAQZi8oEPst
 wftr+Ra0oXC6Yxl21Y+0vQUzcMSeYyFWT7Eylm/jMpT4mXJFwodChrREUz7EtFiWpVMH6l
 D4zHZaoblxnhQsuv5+Jx0kiJvSXRO8s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-FgWnHoT4O4miLPz2UatD3g-1; Sat,
 31 Oct 2026 02:58:36 -0400
X-MC-Unique: FgWnHoT4O4miLPz2UatD3g-1
X-Mimecast-MFC-AGG-ID: FgWnHoT4O4miLPz2UatD3g_1793429915
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F01891800352; Sat, 31 Oct 2026 06:58:34 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 511661800677; Sat, 31 Oct 2026 06:58:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/34] aspeed queue
Date: Sat, 31 Oct 2026 07:57:49 +0100
Message-ID: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4075aa42daecf701cd3869da8b3271dc3c04a4b1:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-30 15:26:36 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20261031

for you to fetch changes up to d83158a1e9f6fa74cc7ae3bdac9e4fd5077909a2:

  hw/rtc: ds1338: parameterise the register map via a device class (2026-10-31 06:52:19 +0100)

----------------------------------------------------------------
aspeed queue:

* Fix AST2700 SMC segment end address decoding and DMA flash address mask
* Add Winbond W25Q33PW flash SFDP data
* Correct AST1040 A0 revision ID
* Add AST1040 FMC and SPI controllers with SMC qtests, and stub
  unimplemented devices
* Bump AST1040 functional test image version to v01.00
* Add the AST1080 Platform Root of Trust SoC and EVB machine,
  with functional test
* Adjust Aspeed documentation with catalina-bmc and sanmiguel-bmc
* Remove unused SPI flash controller from the SanMiguel board
* Add PCA9545 4-channel I2C mux with qtest coverage
* Rework the DS1338 RTC

----------------------------------------------------------------
Emmanuel Blot (12):
      docs/system/arm/aspeed: add the catalina-bmc machine
      docs/system/arm/aspeed: add the sanmiguel-bmc machine
      hw/arm: sanmiguel: remove the second SPI flash controller
      hw/i2c: pca954x: drop unused header inclusions
      hw/i2c: pca954x: add PCA9545 4-channel mux model
      hw/i2c: pca954x: migrate mux state
      tests/qtest: pca9545: add mux test
      hw/rtc: ds1338: move TYPE_DS1338 to a public header
      hw: ds1338: use the TYPE_DS1338 constant instead of the "ds1338" string
      hw/rtc: ds1338: implement Resettable reset
      hw/rtc: ds1338: prefix the file-local helpers with ds1338_
      hw/rtc: ds1338: parameterise the register map via a device class

Jamin Lin (22):
      hw/ssi/aspeed_smc: Fix AST2700 segment end address decoding
      hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask
      hw/block/m25p80: Add Winbond W25Q33PW flash
      hw/misc/aspeed_scu: Correct AST1040 A0 revision ID
      hw/ssi/aspeed_smc: Add AST1040 FMC and SPI controllers
      hw/arm/aspeed_ast1040: Add FMC and SPI controllers
      hw/arm/aspeed_ast1040: Add FMC and SPI filters as unimplemented devices
      hw/arm/aspeed_ast1040: Add OTP as an unimplemented device
      hw/arm/aspeed_ast1040: Add Anti-Tamper Controller (ATC) as an unimplemented device
      hw/arm/aspeed_ast1040: Add I3C as an unimplemented device
      hw/arm/aspeed_ast1040: Add Caliptra as an unimplemented device
      tests/qtest/aspeed_smc: Add AST1040 SMC tests
      tests/functional/arm/test_aspeed_ast1040: Update AST1040 image to aspeed-mcu-fw-hub v01.00
      hw/arm/aspeed_ast1040: Add common init function for AST1040/AST1080 SoCs
      hw/arm/aspeed_ast1040: Add common realize function for AST1040/AST1080 SoCs
      hw/misc/aspeed_scu: Add AST1080 A0 silicon revision definition
      hw/arm/aspeed_ast1040: Add AST1080 SoC support
      hw/arm/aspeed_ast1040: Add AST1080 QSPI filters as unimplemented device
      hw/arm/aspeed_ast1040: Add AST1080 I2C filter as an unimplemented device
      hw/arm/aspeed_ast1040_evb: Add AST1080 EVB machine support
      tests/functional/arm/aspeed: Add AST1080 test with ASPEED MCU FW Hub v01.00
      docs/system/arm/aspeed: Add AST1080 Platform Root of Trust evaluation board

 docs/system/arm/aspeed.rst                  |  14 ++-
 hw/block/m25p80_sfdp.h                      |   1 +
 include/hw/i2c/i2c_mux_pca954x.h            |   1 +
 include/hw/misc/aspeed_scu.h                |   3 +-
 include/hw/rtc/ds1338.h                     |  20 +++
 hw/arm/aspeed_ast1040.c                     | 183 +++++++++++++++++++++++-----
 hw/arm/aspeed_ast1040_evb.c                 |  23 ++++
 hw/arm/aspeed_ast2400_palmetto.c            |   4 +-
 hw/arm/aspeed_ast2400_supermicrox11.c       |   4 +-
 hw/arm/aspeed_ast2500_romulus.c             |   4 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c   |   4 +-
 hw/arm/aspeed_ast2500_witherspoon.c         |   4 +-
 hw/arm/aspeed_ast2600_bletchley.c           |   3 +-
 hw/arm/aspeed_ast2600_catalina.c            |   2 +-
 hw/arm/aspeed_ast2600_sanmiguel.c           |   7 +-
 hw/arm/realview.c                           |   3 +-
 hw/arm/versatilepb.c                        |   3 +-
 hw/block/m25p80.c                           |   2 +
 hw/block/m25p80_sfdp.c                      |  36 ++++++
 hw/i2c/i2c_mux_pca954x.c                    |  98 ++++++++++++++-
 hw/misc/aspeed_scu.c                        |   1 +
 hw/ppc/e500.c                               |   3 +-
 hw/riscv/tt_atlantis.c                      |   3 +-
 hw/rtc/ds1338.c                             |  92 +++++++++-----
 hw/ssi/aspeed_smc.c                         | 131 +++++++++++++++++++-
 tests/qtest/aspeed_smc-test.c               |  61 ++++++++++
 tests/qtest/pca9545-test.c                  | 116 ++++++++++++++++++
 tests/functional/arm/meson.build            |   1 +
 tests/functional/arm/test_aspeed_ast1040.py |  12 +-
 tests/functional/arm/test_aspeed_ast1080.py |  37 ++++++
 tests/qtest/meson.build                     |   1 +
 31 files changed, 784 insertions(+), 93 deletions(-)
 create mode 100644 include/hw/rtc/ds1338.h
 create mode 100644 tests/qtest/pca9545-test.c
 create mode 100644 tests/functional/arm/test_aspeed_ast1080.py


