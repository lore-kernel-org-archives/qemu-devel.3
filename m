Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4680E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGFk-0004ON-RC; Wed, 11 Dec 2024 01:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGFh-0004Md-MR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGFd-0008Qu-1m
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MYpf6UnIeN/JFmsP9X5f+Yz9Sho7pY10olvEfzYrIOA=;
 b=YbnAdnDRHlMJvzQik1Mmmyc5/qgL4cH1vEIYJTRp5K7H04mTDOji+CcU52oRc09x0UwAAU
 0a3LONdYpIZRRHhnRPhJgSDoahf6Kqpm5RNSffs0yPYKbzj0/LIKoRWE5qIh0TSTAIa+uP
 cyhIpSEc3fT3fhjwZU9nApygoDWCWg4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-PPOTtdU8P-mpU2AguoIDYQ-1; Wed,
 11 Dec 2024 01:31:04 -0500
X-MC-Unique: PPOTtdU8P-mpU2AguoIDYQ-1
X-Mimecast-MFC-AGG-ID: PPOTtdU8P-mpU2AguoIDYQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC4B11955F44; Wed, 11 Dec 2024 06:31:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A422E1956054; Wed, 11 Dec 2024 06:31:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/24] aspeed queue
Date: Wed, 11 Dec 2024 07:30:34 +0100
Message-ID: <20241211063058.1222038-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ae35f033b874c627d81d51070187fbf55f0bf1a7:

  Update version for v9.2.0 release (2024-12-10 16:20:54 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20241211

for you to fetch changes up to 124f4dc0d832c1bf3a4513c05a2b93bac0a5fac0:

  test/qtest/ast2700-smc-test: Support to test AST2700 (2024-12-11 07:25:53 +0100)

----------------------------------------------------------------
aspeed queue:

* Removed tacoma-bmc machine
* Added support for SDHCI on AST2700 SoC
* Improved functional tests
* Extended SMC qtest to all Aspeed SoCs

----------------------------------------------------------------
Cédric Le Goater (8):
      arm: Remove tacoma-bmc machine
      tests/functional: Introduce a specific test for ast1030 SoC
      tests/functional: Introduce a specific test for palmetto-bmc machine
      tests/functional: Introduce a specific test for romulus-bmc machine
      tests/functional: Introduce a specific test for ast2500 SoC
      tests/functional: Introduce a specific test for ast2600 SoC
      tests/functional: Introduce a specific test for rainier-bmc machine
      tests/functional: Move debian boot test from avocado

Jamin Lin (16):
      hw/sd/aspeed_sdhci: Fix coding style
      hw/arm/aspeed: Fix coding style
      hw:sdhci: Introduce a new "capareg" class member to set the different Capability Registers
      hw/sd/aspeed_sdhci: Add AST2700 Support
      aspeed/soc: Support SDHCI for AST2700
      aspeed/soc: Support eMMC for AST2700
      test/qtest/aspeed_smc-test: Move testcases to test_palmetto_bmc function
      test/qtest/aspeed_smc-test: Introduce a new TestData to test different BMC SOCs
      test/qtest/aspeed_smc-test: Support to test all CE pins
      test/qtest/aspeed_smc-test: Introducing a "page_addr" data field
      test/qtest/aspeed_smc-test: Support to test AST2500
      test/qtest/aspeed_smc-test: Support to test AST2600
      test/qtest/aspeed_smc-test: Support to test AST1030
      test/qtest/aspeed_smc-test: Support write page command with QPI mode
      test/qtest: Introduce a new aspeed-smc-utils.c to place common testcases
      test/qtest/ast2700-smc-test: Support to test AST2700

 docs/about/deprecated.rst                    |   8 -
 docs/about/removed-features.rst              |  10 +
 docs/system/arm/aspeed.rst                   |   1 -
 include/hw/sd/aspeed_sdhci.h                 |  13 +-
 tests/qtest/aspeed-smc-utils.h               |  95 ++++
 hw/arm/aspeed.c                              |  28 -
 hw/arm/aspeed_ast2400.c                      |   3 +-
 hw/arm/aspeed_ast2600.c                      |  10 +-
 hw/arm/aspeed_ast27x0.c                      |  35 ++
 hw/sd/aspeed_sdhci.c                         |  67 ++-
 tests/qtest/aspeed-smc-utils.c               | 686 ++++++++++++++++++++++++
 tests/qtest/aspeed_smc-test.c                | 775 ++++++---------------------
 tests/qtest/ast2700-smc-test.c               |  71 +++
 tests/avocado/boot_linux_console.py          |  26 -
 tests/functional/aspeed.py                   |  56 ++
 tests/functional/meson.build                 |  13 +-
 tests/functional/test_arm_aspeed.py          | 351 ------------
 tests/functional/test_arm_aspeed_ast1030.py  |  81 +++
 tests/functional/test_arm_aspeed_ast2500.py  |  59 ++
 tests/functional/test_arm_aspeed_ast2600.py  | 143 +++++
 tests/functional/test_arm_aspeed_palmetto.py |  24 +
 tests/functional/test_arm_aspeed_rainier.py  |  64 +++
 tests/functional/test_arm_aspeed_romulus.py  |  24 +
 tests/qtest/meson.build                      |   5 +-
 24 files changed, 1623 insertions(+), 1025 deletions(-)
 create mode 100644 tests/qtest/aspeed-smc-utils.h
 create mode 100644 tests/qtest/aspeed-smc-utils.c
 create mode 100644 tests/qtest/ast2700-smc-test.c
 create mode 100644 tests/functional/aspeed.py
 delete mode 100755 tests/functional/test_arm_aspeed.py
 create mode 100644 tests/functional/test_arm_aspeed_ast1030.py
 create mode 100644 tests/functional/test_arm_aspeed_ast2500.py
 create mode 100644 tests/functional/test_arm_aspeed_ast2600.py
 create mode 100644 tests/functional/test_arm_aspeed_palmetto.py
 create mode 100644 tests/functional/test_arm_aspeed_rainier.py
 create mode 100644 tests/functional/test_arm_aspeed_romulus.py


