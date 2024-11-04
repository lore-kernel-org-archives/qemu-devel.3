Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27F3D132A6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7u7C-0000gv-3q; Mon, 04 Nov 2024 05:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u78-0000g9-Ai
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u76-0006W8-PS
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730715312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C98Aoh57Ke8BBUi2KG1jgCHvhbodcB+FV9OOM1H0SoU=;
 b=KfZcrr45csXgeY4eyY31fUZzhms60SoZoZkMb9AHB+MfKFUGPbRzVruI7CD1/P/gT+m2II
 +mpyUwZUuDUHg2nPYJ2btPlSDc497kFvy6FdPo4CsAUGa9szylO5DC2SyRTORq2xPHHVFW
 TC3guJWOqYpaJXbNXuvxx+l15j9vnVA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-9tJrE9DwPxyCG0QntK9b1w-1; Mon,
 04 Nov 2024 05:15:06 -0500
X-MC-Unique: 9tJrE9DwPxyCG0QntK9b1w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3DF91944CEE; Mon,  4 Nov 2024 10:15:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.67])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73DE91956052; Mon,  4 Nov 2024 10:15:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/10] aspeed queue
Date: Mon,  4 Nov 2024 11:14:51 +0100
Message-ID: <20241104101501.2487001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:

  Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20241104

for you to fetch changes up to 8df5fd815e841bf33fb51e1e6e5be9c31d529b94:

  aspeed: Don't set always boot properties of the emmc device (2024-11-04 10:12:02 +0100)

----------------------------------------------------------------
aspeed queue:

* Fixed eMMC size calculation
* Fixed IRQ definitions on AST2700
* Added RTC support to AST2700
* Fixed timer IRQ status on AST2600
* Improved SDHCI model with new registers
* Added -nodefaults support to AST1030
* Provided a way to use an eMMC device without boot partitions

----------------------------------------------------------------
Cédric Le Goater (1):
      aspeed: Don't set always boot properties of the emmc device

Jamin Lin (5):
      aspeed/soc: Support RTC for AST2700
      hw/timer/aspeed: Fix coding style
      hw/timer/aspeed: Fix interrupt status does not be cleared for AST2600
      hw/sd/aspeed_sdhci: Introduce Capabilities Register 2 for SD slot 0 and 1
      aspeed: Support create flash devices via command line for AST1030

Jan Luebbe (1):
      hw/sd/sdcard: Fix calculation of size when using eMMC boot partitions

Patrick Leis (1):
      hw/arm: enable at24c with aspeed

Peter Maydell (2):
      hw/arm/aspeed_ast27x0: Use bsa.h for PPI definitions
      hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ calculation

 hw/arm/aspeed.c         | 38 +++++++++++++++++++++++++-------------
 hw/arm/aspeed_ast27x0.c | 33 ++++++++++++++++++++++-----------
 hw/sd/aspeed_sdhci.c    | 40 +++++++++++++++++++++++++++++-----------
 hw/sd/sd.c              |  4 +++-
 hw/timer/aspeed_timer.c | 15 +++++++++------
 hw/arm/Kconfig          |  1 +
 6 files changed, 89 insertions(+), 42 deletions(-)


