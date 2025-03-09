Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FACC2BA1B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH4M-0007Ui-K7; Sun, 09 Mar 2025 09:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4F-0007SA-Qf
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4C-00020k-Oe
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9oRki701ywVe74aAgi4rXIz6tlgDwEE0laaBr/xwh2w=;
 b=Q4xBGwS4nceOQ1bf5vHX1UcXM9E1nh55dB6k3Fis41aiAAdnA3zdjbXnlWCWyAddnmzziz
 tudQ6R3YY97cGSVYrQoVivuKTqkcSAMb71FjPfpIPVsMSwb0TBecmHMp1DHsIS2uitLe4m
 hPoVSiHu8y4pK0HmT933FeqCLwKHGDc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-X4wzxI2CNWyAodT9wjpoTg-1; Sun,
 09 Mar 2025 09:51:39 -0400
X-MC-Unique: X4wzxI2CNWyAodT9wjpoTg-1
X-Mimecast-MFC-AGG-ID: X4wzxI2CNWyAodT9wjpoTg_1741528297
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02D8D1800361; Sun,  9 Mar 2025 13:51:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84EBE1956094; Sun,  9 Mar 2025 13:51:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/46] aspeed queue
Date: Sun,  9 Mar 2025 14:50:44 +0100
Message-ID: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit d9a4282c4b690e45d25c2b933f318bb41eeb271d:

  Merge tag 'pull-tcg-20250308' of https://gitlab.com/rth7680/qemu into staging (2025-03-09 11:45:00 +0800)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250309

for you to fetch changes up to 5ab179db11ca297c9e89a6d57f954d31965cbd7b:

  docs/specs: Add aspeed-intc (2025-03-09 14:36:53 +0100)

----------------------------------------------------------------
aspeed queue:

* Updated Aspeed OpenBMC functional test images
* Introduced functional tests for witherspoon and bletchley machines
* Added support for Non-maskable Interrupt on AST2700 SoC
* Fixed HW strapping on AST2700 SoC
* Added AST2700 HACE support
* Added AST2700 A1 SoC support
* Intoduced new ast2700a1-evb machine

----------------------------------------------------------------
Cédric Le Goater (6):
      tests/functional: Introduce a new test routine for OpenBMC images
      tests/functional: Update OpenBMC image of palmetto machine
      tests/functional: Update OpenBMC image of romulus machine
      tests/functional: Introduce a witherspoon machine test
      tests/functional: Introduce a bletchley machine test
      aspeed: Remove duplicate typename in AspeedSoCClass

Jamin Lin (40):
      aspeed/soc: Support Non-maskable Interrupt for AST2700
      hw/misc/aspeed_hace: Fix coding style
      hw/misc/aspeed_hace: Add AST2700 support
      hw/arm/aspeed_ast27x0: Add HACE support for AST2700
      hw/misc/aspeed_hace: Fix boot issue in the Crypto Manager Self Test
      hw/misc/aspeed_scu: Skipping dram_init in u-boot
      hw/misc/aspeed_scu: Fix the revision ID cannot be set in the SOC layer for AST2700
      hw/arm/aspeed Update HW Strap Default Values for AST2700
      hw/misc/aspeed_scu: Fix the hw-strap1 cannot be set in the SOC layer for AST2700
      hw/arm/aspeed_ast27x0.c Separate HW Strap Registers for SCU and SCUIO
      hw/arm/aspeed_ast27x0.c Fix boot issue for AST2700
      hw/intc/aspeed: Support setting different memory size
      hw/intc/aspeed: Rename status_addr and addr to status_reg and reg for clarity
      hw/intc/aspeed: Introduce dynamic allocation for regs array
      hw/intc/aspeed: Support setting different register size
      hw/intc/aspeed: Reduce regs array size by adding a register sub-region
      hw/intc/aspeed: Introduce helper functions for enable and status registers
      hw/intc/aspeed: Add object type name to trace events for better debugging
      hw/arm/aspeed: Rename IRQ table and machine name for AST2700 A0
      hw/arm/aspeed_ast27x0: Sort the IRQ table by IRQ number
      hw/intc/aspeed: Support different memory region ops
      hw/intc/aspeed: Rename num_ints to num_inpins for clarity
      hw/intc/aspeed: Add support for multiple output pins in INTC
      hw/intc/aspeed: Refactor INTC to support separate input and output pin indices
      hw/intc/aspeed: Introduce AspeedINTCIRQ structure to save the irq index and register address
      hw/intc/aspeed: Introduce IRQ handler function to reduce code duplication
      hw/intc/aspeed: Add Support for Multi-Output IRQ Handling
      hw/intc/aspeed: Add Support for AST2700 INTCIO Controller
      hw/misc/aspeed_scu: Add Support for AST2700/AST2750 A1 Silicon Revisions
      hw/arm/aspeed_ast27x0.c Support AST2700 A1 GIC Interrupt Mapping
      hw/arm/aspeed_ast27x0: Define an Array of AspeedINTCState with Two Instances
      hw/arm/aspeed_ast27x0: Support two levels of INTC controllers for AST2700 A1
      hw/arm/aspeed_ast27x0: Add SoC Support for AST2700 A1
      hw/arm/aspeed: Add Machine Support for AST2700 A1
      hw/arm/aspeed_ast27x0: Sort the memmap table by mapping address
      tests/functional/aspeed: Introduce start_ast2700_test API
      tests/functional/aspeed: Update temperature hwmon path
      tests/functional/aspeed: Update test ASPEED SDK v09.05
      tests/functional/aspeed: Add test case for AST2700 A1
      docs/specs: Add aspeed-intc

 docs/specs/aspeed-intc.rst                      | 136 +++++
 docs/specs/index.rst                            |   1 +
 include/hw/arm/aspeed_soc.h                     |   4 +-
 include/hw/intc/aspeed_intc.h                   |  36 +-
 include/hw/misc/aspeed_hace.h                   |   2 +
 include/hw/misc/aspeed_scu.h                    |   2 +
 hw/arm/aspeed.c                                 |  39 +-
 hw/arm/aspeed_ast10x0.c                         |   3 +-
 hw/arm/aspeed_ast2400.c                         |   4 +-
 hw/arm/aspeed_ast2600.c                         |   3 +-
 hw/arm/aspeed_ast27x0.c                         | 359 +++++++++----
 hw/intc/aspeed_intc.c                           | 667 ++++++++++++++++++------
 hw/misc/aspeed_hace.c                           |  55 +-
 hw/misc/aspeed_scu.c                            |  10 +-
 hw/intc/trace-events                            |  25 +-
 tests/functional/aspeed.py                      |  24 +-
 tests/functional/meson.build                    |   4 +
 tests/functional/test_aarch64_aspeed.py         |  47 +-
 tests/functional/test_arm_aspeed_bletchley.py   |  25 +
 tests/functional/test_arm_aspeed_palmetto.py    |  13 +-
 tests/functional/test_arm_aspeed_romulus.py     |  13 +-
 tests/functional/test_arm_aspeed_witherspoon.py |  25 +
 22 files changed, 1150 insertions(+), 347 deletions(-)
 create mode 100644 docs/specs/aspeed-intc.rst
 create mode 100644 tests/functional/test_arm_aspeed_bletchley.py
 create mode 100644 tests/functional/test_arm_aspeed_witherspoon.py


