Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA82BC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCVn-0003Du-60; Fri, 24 Jul 2026 05:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVl-0003DR-RC; Fri, 24 Jul 2026 05:48:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVj-00058X-IO; Fri, 24 Jul 2026 05:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784886463; bh=kEVf5jWqvNxySi76U3fA2znzRYltajvYlaWRcMqJ6Ps=;
 h=From:To:Cc:Subject:Date;
 b=pkAcTepYzg5cWenpT695EYEOh8IlFJW3Vu0ASnkL5OxGuqJsN1Fp7Z7DmaSMDKK2D
 IY55Id4UweruxlpOs16ardn6g/lZyg58M5BQw5kBwVEb2+8iPnSjmIQ9Pb8fJ0oonY
 hDSlgiae9m18fi5SD9OqNmwTkD/mHiJhhucbpMft34j0vYtL9sKQrtaqwOk4hUGjLv
 s9rbr8mfY3YFt4vv/VAeWtCKW1K9dpbNU5vRYlEtPSatYFqEjbrigLd4iCxH+2O4OA
 We10gHob6/qn/wBFLIBuZKxYr0fmNMPvasphAaXQRdzitqCbCRXfamPl4SOkJNnDcC
 r7ufZAgzj+VCg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 404591C4571;
 Fri, 24 Jul 2026 12:47:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3B1BD3F46B0;
 Fri, 24 Jul 2026 12:48:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4167E18540; Fri, 24 Jul 2026 12:47:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/7] Trivial patches for 2026-07-24
Date: Fri, 24 Jul 2026 12:47:42 +0300
Message-ID: <20260724094754.1053970-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 006a22cb26998998385b104db1ff9466ef2f3153:

  Merge tag 'firmware-20260722-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-07-22 11:17:49 -0400)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 443e02410695b35a27fad18217424b6370358be7:

  hw/ide: replace assert with proper error handling (2026-07-24 12:42:11 +0300)

----------------------------------------------------------------
trivial patches for 2026-07-24

Nothing fancy, a few fixups here and there, some were
queued for a long time.

----------------------------------------------------------------
Artem Nasonov (1):
      hw/ide: replace assert with proper error handling

Evgeny Kolmakov (1):
      hw/hyperv/vmbus: Use QEMU_LOCK_GUARD()

Filip Hejsek (1):
      char-win-stdio: fix typo in spelling of 'stdio'

Michael Tokarev (1):
      spelling: happend

Thomas Huth (1):
      hw/display/vmware_vga: Don't allow guest to trigger long running loop in host

Vladimir Lobanov (1):
      block/curl: set User-Agent header

Ziyi Fu (1):
      hw/usb: record async control completion for parameter transfers

 block/curl.c                    |  2 ++
 chardev/char-win-stdio.c        |  6 +++---
 docs/about/removed-features.rst |  2 +-
 hw/display/vmware_vga.c         |  6 +++++-
 hw/hyperv/vmbus.c               | 16 +++++-----------
 hw/ide/core.c                   |  8 ++++++--
 hw/usb/core.c                   |  1 +
 migration/migration.c           |  2 +-
 qapi/migration.json             |  4 ++--
 9 files changed, 26 insertions(+), 21 deletions(-)

