Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F5EC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 19:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjOi4-0006BL-C8; Sun, 10 Mar 2024 15:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org>)
 id 1rjOi2-0006BC-ON
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:19:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org>)
 id 1rjOhy-0001Qt-87
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:19:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tt8q72M6gz4wyk;
 Mon, 11 Mar 2024 06:19:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tt8q60fmtz4wcl;
 Mon, 11 Mar 2024 06:19:29 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/2] vfio queue
Date: Sun, 10 Mar 2024 20:19:22 +0100
Message-ID: <20240310191924.201680-1-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The following changes since commit cbccded4a2b5d685a426a437e25f67d3a375b292:

  Merge tag 'pull-riscv-to-apply-20240308-1' of https://github.com/alistair23/qemu into staging (2024-03-08 11:47:01 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240310

for you to fetch changes up to 0cb51c183a91e882b10ead4ddf2321296a537c47:

  vfio: allow cpr-reboot migration if suspended (2024-03-08 22:10:13 +0100)

----------------------------------------------------------------
vfio queue:

* Allow cpr-reboot for vfio

----------------------------------------------------------------
Steve Sistare (2):
      vfio: register container for cpr
      vfio: allow cpr-reboot migration if suspended

 include/hw/vfio/vfio-common.h         |  3 +++
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      |  2 +-
 hw/vfio/container.c                   | 11 +++++++++-
 hw/vfio/cpr.c                         | 39 +++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c                     |  6 ++++++
 hw/vfio/migration.c                   |  2 +-
 hw/vfio/meson.build                   |  1 +
 8 files changed, 62 insertions(+), 3 deletions(-)
 create mode 100644 hw/vfio/cpr.c

