Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29B4C02190
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLdt-00068y-Ly; Mon, 27 Jan 2025 04:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLds-00068h-Te
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLdr-0005PE-6t
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737970969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3uGmDiR8fg8DQdIQ7c/BFdCQ7aKzlzLCwkOx8syialo=;
 b=AUhgvQTQUgmJ+5c100A3LD8t2jCVdir0Y3hkjROr5MW6cFFU1ujugAaoXJgGFeWgx3iSpG
 UoPEHdXkEPg8+g98nRbgpclo3Y9rLTo/AdhBdoJPd5ARp//bDrwduRh3HjfdVCIZ6181so
 w48QvLaN0DRxA+Uh2tZVPIkLx69W58g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-WgWW20FGNhChGXzAS-cOmQ-1; Mon,
 27 Jan 2025 04:42:47 -0500
X-MC-Unique: WgWW20FGNhChGXzAS-cOmQ-1
X-Mimecast-MFC-AGG-ID: WgWW20FGNhChGXzAS-cOmQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C62671801F1F; Mon, 27 Jan 2025 09:42:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C09718008C0; Mon, 27 Jan 2025 09:42:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/12] aspeed queue
Date: Mon, 27 Jan 2025 10:42:27 +0100
Message-ID: <20250127094239.636526-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit ed734377ab3f3f3cc15d7aa301a87ab6370f2eed:

  Merge tag 'linux-user-fix-gupnp-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2025-01-24 14:43:07 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250127

for you to fetch changes up to 8b7ccc6ad10cd4a107b4627e9a5606d757607ff2:

  docs/system/arm/aspeed: Remove tacoma-bmc from the documentation (2025-01-27 09:38:15 +0100)

----------------------------------------------------------------
aspeed queue:

* Fixed serial definitions on the command line
* Fixed sdhci write protected pin on AST2600 EVB machine
* Added timer support on AST2700 SoC
* Updated buildroot and SDK images of functional tests
* Removed sd devices creation when -nodefaults is used
* Added software reset mode support on AST2600 SoC

----------------------------------------------------------------
Cédric Le Goater (3):
      test/functional: Update the Aspeed aarch64 test
      test/functional: Update buildroot images to 2024.11
      aspeed: Create sd devices only when defaults are enabled

Jamin Lin (7):
      hw/sd/sdhci: Introduce a new Write Protected pin inverted property
      hw/arm/aspeed: Invert sdhci write protected pin for AST2600 EVB
      hw/timer/aspeed: Refactor Timer Callbacks for SoC-Specific Implementations
      hw/timer/aspeed: Add AST2700 Support
      aspeed/soc: Support Timer for AST2700
      aspeed/wdt: Fix coding style
      aspeed/wdt: Support software reset mode for AST2600

Kenneth Jia (1):
      hw/arm/aspeed: fix connect_serial_hds_to_uarts

Thomas Huth (1):
      docs/system/arm/aspeed: Remove tacoma-bmc from the documentation

 docs/system/arm/aspeed.rst                  |   4 +-
 include/hw/arm/aspeed.h                     |   1 +
 include/hw/sd/sdhci.h                       |   5 +
 include/hw/timer/aspeed_timer.h             |   1 +
 hw/arm/aspeed.c                             |  15 +-
 hw/arm/aspeed_ast27x0.c                     |  17 ++
 hw/sd/sdhci.c                               |   6 +
 hw/timer/aspeed_timer.c                     | 263 ++++++++++++++++++++++++++--
 hw/watchdog/wdt_aspeed.c                    |  19 +-
 hw/timer/trace-events                       |   2 +-
 tests/functional/aspeed.py                  |   2 +-
 tests/functional/test_aarch64_aspeed.py     |  10 +-
 tests/functional/test_arm_aspeed_ast2500.py |   8 +-
 tests/functional/test_arm_aspeed_ast2600.py |   8 +-
 14 files changed, 323 insertions(+), 38 deletions(-)


