Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6805C3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 08:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVRiT-0001Af-6W; Sun, 21 Jul 2024 04:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRhx-0000hy-Q0
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRhv-0001Mb-It
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721549652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1wzLzCscshtHDHvwyRkvpGP6+NyNsPtsxpc3wvfrY6I=;
 b=ABNnxBkJrOMiY1JxYt4ra4ni4DZ71zA+rD0nDMyhAmrRJlt9Xkn2pb/E1eun8UYYZcAf2e
 RYre++kFoJLfybH5wPU07wX0c4eGwHhvqk7KZCQIA7Pq5dSRanDwpAKYeBcshXojCceTE9
 LInRDT5S0fqPoadFZo49lsFIot/txuQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-7MH9mvo-OQ2H-ZvmPpALRg-1; Sun,
 21 Jul 2024 04:14:06 -0400
X-MC-Unique: 7MH9mvo-OQ2H-ZvmPpALRg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D662B19560A1; Sun, 21 Jul 2024 08:14:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 222651955D47; Sun, 21 Jul 2024 08:14:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/15] aspeed queue
Date: Sun, 21 Jul 2024 10:13:46 +0200
Message-ID: <20240721081401.425588-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit a87a7c449e532130d4fa8faa391ff7e1f04ed660:

  Merge tag 'pull-loongarch-20240719' of https://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 +1000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20240721

for you to fetch changes up to 4db1c16441923fc152142ae4bcc1cba23064cb8b:

  aspeed: fix coding style (2024-07-21 07:46:38 +0200)

----------------------------------------------------------------
aspeed queue:

* SMC model fix (Coverity)
* AST2600 boot for eMMC support and test
* AST2700 ADC model
* I2C model changes preparing AST2700 I2C support

----------------------------------------------------------------
Cédric Le Goater (10):
      aspeed/smc: Fix possible integer overflow
      aspeed: Change type of eMMC device
      aspeed: Load eMMC first boot area as a boot rom
      aspeed/scu: Add boot-from-eMMC HW strapping bit for AST2600 SoC
      aspeed: Introduce a AspeedSoCClass 'boot_from_emmc' handler
      aspeed: Tune eMMC device properties to reflect HW strapping
      aspeed: Add boot-from-eMMC HW strapping bit to rainier-bmc machine
      aspeed: Introduce a 'hw_strap1' machine attribute
      aspeed: Introduce a 'boot-emmc' machine option
      tests/avocado/machine_aspeed.py: Add eMMC boot tests

Jamin Lin (5):
      aspeed/adc: Add AST2700 support
      aspeed/soc: support ADC for AST2700
      hw/i2c/aspeed: support to set the different memory size
      hw/i2c/aspeed: rename the I2C class pool attribute to share_pool
      aspeed: fix coding style

 docs/system/arm/aspeed.rst      |  2 +
 include/hw/adc/aspeed_adc.h     |  1 +
 include/hw/arm/aspeed_soc.h     |  1 +
 include/hw/i2c/aspeed_i2c.h     |  6 +--
 include/hw/misc/aspeed_scu.h    |  4 ++
 hw/adc/aspeed_adc.c             | 16 ++++++++
 hw/arm/aspeed.c                 | 83 +++++++++++++++++++++++++++++++++--------
 hw/arm/aspeed_ast2600.c         |  8 ++++
 hw/arm/aspeed_ast27x0.c         | 12 ++++++
 hw/arm/aspeed_soc_common.c      |  7 ++++
 hw/i2c/aspeed_i2c.c             | 45 ++++++++++++----------
 hw/ssi/aspeed_smc.c             |  3 +-
 tests/avocado/machine_aspeed.py | 39 +++++++++++++++++++
 13 files changed, 188 insertions(+), 39 deletions(-)


