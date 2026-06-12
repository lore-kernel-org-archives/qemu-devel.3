Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98856CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5Et-00053r-4g; Fri, 12 Jun 2026 13:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Ek-00051u-P9; Fri, 12 Jun 2026 13:00:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Eg-0005s0-4d; Fri, 12 Jun 2026 13:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781283582; bh=jf+LqF354WIcd0Q9aHL/iR3YqHUyqXbyNzoQ0gowshI=;
 h=From:To:Cc:Subject:Date;
 b=EpgATw+VzKGLFQZDY5tF06xzoPQsCstCunGbYz1SQBh+IKjyNl0D68TmYUMMIURYz
 dN1JgcNuEMZkhPW728KekAKqJuGs8tqbCjIQ5T5eIRh1GTAlIKLNOjttKR7HzZd5EQ
 RL0m8VdfNge/M2RqWoHgJDTrU/1mVuOXJderIeNZR1wsLLfeImYgpYgTYrUGhcD4Uo
 yIchT/Kd04T61rMYbmf79mkBgSTAFMbHUj3EkfXbN+jser+pWqasWj7ty2gaoraN3y
 mn/12bBMJkfNq0OIlYJQbfFQG1kpvKpT60IE8EXxlXdaDKMfPf+L96LPHSSsB2LF4v
 AOgf8QwhRPSUA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0BAFF1B6BC5;
 Fri, 12 Jun 2026 19:59:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A7593CE162;
 Fri, 12 Jun 2026 19:59:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/8] Trivial patches for 2026-06-12
Date: Fri, 12 Jun 2026 19:59:44 +0300
Message-ID: <20260612165957.1779082-1-mjt@tls.msk.ru>
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

The following changes since commit 193963218accbcf65f28ab1efa773ac6d1cc634c:

  Merge tag 'pull-ufs-20260612' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-06-12 09:01:07 -0400)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 2a57339f89f47b4b1686f419fa2bbd6c0ea6e016:

  qemu-options: fix typo in spelling of 'scheduler' (2026-06-12 19:43:21 +0300)

----------------------------------------------------------------
trivial patches for 2026-06-12

a few small things here and there.

the hostfwd one hasn't been reviewed for a few months, but it's
simple enough.
----------------------------------------------------------------
Ajinkya Udgirkar (1):
      hw/xtensa: replace calloc with g_new0 in mx_pic

Ani Sinha (1):
      igvm: spit out region size on error

BALATON Zoltan (1):
      hw/display/vga: Fix debug message

Evgeny Kolmakov (2):
      net/colo-compare: Use QEMU_LOCK_GUARD to simplify mutex handling
      block/io: Use QEMU_LOCK_GUARD to simplify mutex handling

Fiona Ebner (1):
      qemu-options: fix typo in spelling of 'scheduler'

Michael Tokarev (1):
      net/slirp: allow hostfwd socket paths with dashes

Thomas Huth (1):
      system/rtc: Fix a possible year-2038 integer overflow problem

 backends/igvm.c    | 4 ++--
 block/io.c         | 4 +---
 hw/display/vga.c   | 2 +-
 hw/xtensa/mx_pic.c | 2 +-
 net/colo-compare.c | 8 ++------
 net/slirp.c        | 5 +++--
 qemu-options.hx    | 4 ++--
 system/rtc.c       | 4 ++--
 8 files changed, 14 insertions(+), 19 deletions(-)

