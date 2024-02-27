Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB6AC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 12:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rewwZ-0008VA-Qr; Tue, 27 Feb 2024 07:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hhKj=KE=kaod.org=clg@ozlabs.org>)
 id 1rewwX-0008Un-Q2; Tue, 27 Feb 2024 07:52:21 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hhKj=KE=kaod.org=clg@ozlabs.org>)
 id 1rewwV-0002iN-U2; Tue, 27 Feb 2024 07:52:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tkcnj6PgDz4wcF;
 Tue, 27 Feb 2024 23:52:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tkcnh1YsSz4wc1;
 Tue, 27 Feb 2024 23:52:07 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 0/2] aspeed queue
Date: Tue, 27 Feb 2024 13:51:59 +0100
Message-ID: <20240227125201.414060-1-clg@kaod.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=hhKj=KE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 1b330dafcdc34315f6837ff3af34dbb4b3106373:

  Merge tag 'edk2-stable202402-20240226-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-02-26 21:28:11 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20240227

for you to fetch changes up to db052d0eafe86c336d512dba99a1ec7c5c553f63:

  aspeed: fix hardcode boot address 0 (2024-02-27 13:47:05 +0100)

----------------------------------------------------------------
aspeed queue:

* Add support for UART0, in preparation of AST2700 models

----------------------------------------------------------------
Jamin Lin (2):
      aspeed: introduce a new UART0 device name
      aspeed: fix hardcode boot address 0

 include/hw/arm/aspeed_soc.h | 19 +++++++++++++++++--
 hw/arm/aspeed.c             | 17 +++++++++++------
 hw/arm/aspeed_ast10x0.c     |  1 +
 hw/arm/aspeed_ast2400.c     |  6 ++++--
 hw/arm/aspeed_ast2600.c     |  3 ++-
 hw/arm/aspeed_soc_common.c  |  6 ++++--
 6 files changed, 39 insertions(+), 13 deletions(-)

