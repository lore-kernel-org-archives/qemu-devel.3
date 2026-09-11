Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A18DC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yw2-0004Ws-4n; Fri, 11 Sep 2026 06:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yvx-0004WF-1D; Fri, 11 Sep 2026 06:56:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yvu-0003CQ-GB; Fri, 11 Sep 2026 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789124162; bh=sdQbg1pybtRiBzcyoybmSAK48IbZ8KnOhWIb4Cul5lw=;
 h=From:To:Cc:Subject:Date;
 b=fmox/ODFlEo6E5fCLfNUz2DWgahNBqRBeUrcoFsHCWf36vXEmGXEa5J8GIHmforjw
 Z8H/Ei1wAMzJc7PQTM75rP+yqgdMBAl6jaCsLcnGb/uA5rRimJXoKV+F7khxOddttd
 1RmeRqbVW6wE3FpK0XmJP/q0yhOKX4Ee20vik7nYj2tqWb+iuaviHoT1u34N05px09
 vrYrd7Ct5/lnolIVBYgVENl2PT0kI57h+j/1JTAo/SsI78iBS/2Pb13i3Jo8aLjckS
 s+6wxFgvJ3B0352Wh7nEzXFIPT/FaT9zQoRC6NBXD/tz3ZEu0jWYFWbbzcvDRfhEDq
 FxEwEJdBE9JyA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E8A851D3B82;
 Fri, 11 Sep 2026 13:56:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AF26A425DF9;
 Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A388C40F09; Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/4] Trivial patches for 2026-09-11
Date: Fri, 11 Sep 2026 13:56:28 +0300
Message-ID: <20260911105635.955937-1-mjt@tls.msk.ru>
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

The following changes since commit 92c82d0d2e71ab6e39fd799b035bae98b375bfd5:

  Merge tag 'linux-user-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-09-10 20:59:05 -1000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 4b93253f6d15642c934e33fbd96bf761a2f0efd9:

  hw/ppc/vof: Use qemu_tolower() instead of tolower() (2026-09-11 12:07:44 +0300)

----------------------------------------------------------------
trivial patches for 2026-09-11

Just 4 small changes, the rest went through other trees.

----------------------------------------------------------------
Rohitashv Kumar (1):
      qapi/net: gate user/vde/netmap netdev backends behind their CONFIG symbols

Thomas Huth (2):
      util/cutils: Use qemu_isdigit() instead of isdigit()
      hw/ppc/vof: Use qemu_tolower() instead of tolower()

Zhang Chen (1):
      qapi/misc: Fix missed query-iothreads items

 hw/ppc/vof.c   |  3 ++-
 net/hub.c      |  4 ++++
 qapi/misc.json | 12 ++++++++++--
 qapi/net.json  | 19 +++++++++++++------
 util/cutils.c  |  2 +-
 5 files changed, 30 insertions(+), 10 deletions(-)

