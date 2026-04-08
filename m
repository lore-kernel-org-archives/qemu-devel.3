Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E9C10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWK-0006SC-Gz; Wed, 08 Apr 2026 15:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wAY6u-0007IT-OU; Wed, 08 Apr 2026 14:58:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wAQbr-0007Uw-DD; Wed, 08 Apr 2026 06:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775645719; bh=YKGbRp6GAGJEFnFsKX4ZuSwMSKBw4GrQnifdDGcck2Y=;
 h=From:To:Cc:Subject:Date;
 b=MmxQUGqskDjiU4KN4LAmFyPxWtKcjCRtCqYxeWa8zKjoIZpUZ8VYuaOjKOhiPqvly
 pWAVj8wYRCILTWdoKSd8oTJ4kSadHJgRdLX1OureaBj1/biCKaGp7b91oNE5CMqVsz
 qSw14gt/jX3+GTxZM56s1dS6la2THZYBhkm2HulAnQglovO9P2/2Y3qVj7rpNSnjtg
 o1xBnFEqd0xEcIkSldbkZ78wXM69bnnWmMaA+2yx8wYcqM6DKOSB1nCVXJ8i157Dsa
 7yn5rWqsdQ00fV1f/vWIkLgwKTEyPCVoK4Dg0KfGKQAlVKqCHNAopKk1GzGDaI75hc
 9H/cJpCwMOPBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D74419C29A;
 Wed, 08 Apr 2026 13:55:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 91A01391674;
 Wed, 08 Apr 2026 13:56:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/3] Trivial build-system patches for 2026-04-08
Date: Wed,  8 Apr 2026 13:55:55 +0300
Message-ID: <20260408105605.172465-1-mjt@tls.msk.ru>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:

  Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 17fbf3e18c3dbc32ec07cfc24853d6654a813e90:

  util: fix missing aio_wait sym in qemu guest agent only build (2026-04-08 13:48:50 +0300)

----------------------------------------------------------------
trivial build-system patches for 2026-04-08

bugfixes, and making possible to build some minimal stuff
on 32bit platforms - pending more permanent solution in 11.1.

----------------------------------------------------------------
Daniel P. Berrangé (1):
      util: fix missing aio_wait sym in qemu guest agent only build

Helge Deller (1):
      Allow building qemu tools on 32-bit hosts

Michael Tokarev (1):
      util/meson.build: do not add cpuinfo-$arch to util_ss for 32bit CPUs

 include/qemu/atomic.h |  6 +++---
 meson.build           | 16 ++++++++++++----
 util/meson.build      |  8 ++++----
 3 files changed, 19 insertions(+), 11 deletions(-)

