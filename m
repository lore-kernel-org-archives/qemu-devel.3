Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70487D0BB64
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 06:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3rRM-0002B3-NB; Thu, 24 Oct 2024 02:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRK-0002AD-N6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRH-0003Ni-Ef
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729751718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gDyN81GG/SlZBjHxjbJ1emtC0s2m4m1L48hRVxtrkkw=;
 b=A7nKRx2b+ymcqU1/klPmHqCXPVSqsum0JiuggBmitQ9rsC2doIhl4waZQD1VUH1WNtTpQB
 2riz+vH5TEykiTM+kPws+9t0ynHyVzUZjjTCCv18vM1mW0gKkSQDpK3fpmXnB3XAF5n3xG
 BzWOvxZIxkfx+/vTaSI/ixA6xdU87Qw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-_O2zTeOgM2qdF66VFmEIjA-1; Thu,
 24 Oct 2024 02:35:14 -0400
X-MC-Unique: _O2zTeOgM2qdF66VFmEIjA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4255B19560B7; Thu, 24 Oct 2024 06:35:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B0E41956056; Thu, 24 Oct 2024 06:35:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/17] aspeed queue
Date: Thu, 24 Oct 2024 08:34:50 +0200
Message-ID: <20241024063507.1585765-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:

  Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20241024

for you to fetch changes up to 1df52a9ac0897687cff7c38705007b2b58065042:

  test/qtest/aspeed_smc-test: Fix coding style (2024-10-24 07:57:47 +0200)

----------------------------------------------------------------
aspeed queue:

* Fixed GPIO interrupt status when in index mode
* Added GPIO support for the AST2700 SoC and specific test cases
* Fixed crypto controller (HACE) Accumulative hash function
* Converted Aspeed machine avocado tests to the new functional
  framework. SDK tests still to be addressed.
* Fixed issue in the SSI controller when doing writes in user mode
* Added support for the WRSR2 register of Winbond flash devices
* Added SFDP table for the Windbond w25q80bl flash device
* Changed flash device models for the ast1030-a1 EVB

----------------------------------------------------------------
Alejandro Zeise (1):
      hw/misc/aspeed_hace: Fix SG Accumulative hashing

Cédric Le Goater (1):
      tests/functional: Convert most Aspeed machine tests

Jamin Lin (15):
      hw/gpio/aspeed: Fix coding style
      hw/gpio/aspeed: Support to set the different memory size
      hw/gpio/aspeed: Support different memory region ops
      hw/gpio/aspeed: Fix clear incorrect interrupt status for GPIO index mode
      hw/gpio/aspeed: Add AST2700 support
      aspeed/soc: Correct GPIO irq 130 for AST2700
      aspeed/soc: Support GPIO for AST2700
      tests/qtest:ast2700-gpio-test: Add GPIO test case for AST2700
      aspeed/smc: Fix write incorrect data into flash in user mode
      hw/block:m25p80: Fix coding style
      hw/block:m25p80: Support write status register 2 command (0x31) for w25q01jvq
      hw/block/m25p80: Add SFDP table for w25q80bl flash
      hw/arm/aspeed: Correct spi_model w25q256 for ast1030-a1 EVB.
      hw/arm/aspeed: Correct fmc_model w25q80bl for ast1030-a1 EVB
      test/qtest/aspeed_smc-test: Fix coding style

 MAINTAINERS                         |   1 +
 hw/block/m25p80_sfdp.h              |   2 +-
 include/hw/gpio/aspeed_gpio.h       |   4 +-
 include/hw/misc/aspeed_hace.h       |   4 +
 include/hw/ssi/aspeed_smc.h         |   1 +
 hw/arm/aspeed.c                     |   4 +-
 hw/arm/aspeed_ast27x0.c             |  18 +-
 hw/block/m25p80.c                   |  63 +++++-
 hw/block/m25p80_sfdp.c              |  36 +++
 hw/gpio/aspeed_gpio.c               | 427 ++++++++++++++++++++++++++++++++++--
 hw/misc/aspeed_hace.c               | 104 +++++----
 hw/ssi/aspeed_smc.c                 |  40 +++-
 tests/qtest/aspeed_smc-test.c       |   6 +-
 tests/qtest/ast2700-gpio-test.c     |  95 ++++++++
 tests/avocado/machine_aspeed.py     | 292 ------------------------
 tests/functional/meson.build        |   2 +
 tests/functional/test_arm_aspeed.py | 282 ++++++++++++++++++++++++
 tests/qtest/meson.build             |   3 +
 18 files changed, 1002 insertions(+), 382 deletions(-)
 create mode 100644 tests/qtest/ast2700-gpio-test.c
 create mode 100644 tests/functional/test_arm_aspeed.py


