Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFE7C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNDZ-0008HS-HU; Mon, 29 Jan 2024 03:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=2aNT=JH=redhat.com=clg@ozlabs.org>)
 id 1rUNDV-0008H1-PZ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:42:09 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=2aNT=JH=redhat.com=clg@ozlabs.org>)
 id 1rUNDT-000537-UI
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:42:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TNhcQ5j1Qz4wxx;
 Mon, 29 Jan 2024 19:41:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TNhcP5BWMz4wby;
 Mon, 29 Jan 2024 19:41:57 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/2] vfio queue
Date: Mon, 29 Jan 2024 09:41:48 +0100
Message-ID: <20240129084150.134050-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=2aNT=JH=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

The following changes since commit 7a1dc45af581d2b643cdbf33c01fd96271616fbd:

  Merge tag 'pull-target-arm-20240126' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-26 18:16:35 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240129

for you to fetch changes up to d2b668fca5652760b435ce812a743bba03d2f316:

  vfio/pci: Clear MSI-X IRQ index always (2024-01-29 08:26:25 +0100)

----------------------------------------------------------------
vfio queue:

* Array type cleanup
* Fix for IRQ enablement

----------------------------------------------------------------
Cédric Le Goater (1):
      vfio/pci: Clear MSI-X IRQ index always

Paolo Bonzini (1):
      vfio: use matching sizeof type

 hw/vfio/common.c | 2 +-
 hw/vfio/pci.c    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

