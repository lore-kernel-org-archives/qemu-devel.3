Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0468CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 16:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxo7-0005a4-RX; Sun, 30 Jun 2024 12:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxo6-0005Zf-Sa; Sun, 30 Jun 2024 12:53:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxo4-0005H0-Ur; Sun, 30 Jun 2024 12:53:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 428967575D;
 Sun, 30 Jun 2024 19:53:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1445BFAD5A;
 Sun, 30 Jun 2024 19:53:27 +0300 (MSK)
Received: (nullmailer pid 38199 invoked by uid 1000);
 Sun, 30 Jun 2024 16:53:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/16] Trivial patches for 2024-06-30
Date: Sun, 30 Jun 2024 19:53:10 +0300
Message-Id: <20240630165327.38153-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3665dd6bb9043bef181c91e2dce9e1efff47ed51:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-06-28 16:09:38 -0700)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to f22855dffdbc2906f744b5bcfea869cbb66b8fb2:

  hw/core/loader: gunzip(): fix memory leak on error path (2024-06-30 19:51:44 +0300)

----------------------------------------------------------------
trivial patches for 2024-06-30

It's been some time since the previous trivial-patches pullreq,
and the queue grew a bit

----------------------------------------------------------------
Dr. David Alan Gilbert (4):
      linux-user: cris: Remove unused struct 'rt_signal_frame'
      linux-user: sparc: Remove unused struct 'target_mc_fq'
      hw/arm/bcm2836: Remove unusued struct 'BCM283XClass'
      net/can: Remove unused struct 'CanBusState'

Hyeongtak Ji (1):
      docs/cxl: fix some typos

Martin Joerg (1):
      hmp-commands-info.hx: Add missing info command for stats subcommand

Matheus Tavares Bernardino (1):
      cpu: fix memleak of 'halt_cond' and 'thread'

Philippe Mathieu-Daudé (1):
      monitor: Remove obsolete stubs

Thomas Huth (1):
      docs/system/devices/usb: Replace the non-existing "qemu" binary

Trent Huber (1):
      os-posix: Expand setrlimit() syscall compatibility

Vladimir Sementsov-Ogievskiy (4):
      vl.c: select_machine(): use ERRP_GUARD instead of error propagation
      vl.c: select_machine(): use g_autoptr
      vl.c: select_machine(): add selected machine type to error message
      hw/core/loader: gunzip(): fix memory leak on error path

Zide Chen (2):
      vl: Allow multiple -overcommit commands
      target/i386: Advertise MWAIT iff host supports

 accel/tcg/tcg-accel-ops-rr.c |  1 +
 docs/system/devices/cxl.rst  |  6 +++---
 docs/system/devices/usb.rst  |  2 +-
 hmp-commands-info.hx         |  2 +-
 hw/arm/bcm2836.c             | 12 ------------
 hw/core/cpu-common.c         |  3 +++
 hw/core/loader.c             |  1 +
 include/hw/loader.h          |  1 -
 include/monitor/hmp.h        |  3 ---
 linux-user/cris/signal.c     |  8 --------
 linux-user/sparc/signal.c    |  5 -----
 net/can/can_host.c           |  6 ------
 os-posix.c                   |  4 ++++
 system/vl.c                  | 21 ++++++++++-----------
 target/i386/host-cpu.c       | 12 ------------
 target/i386/kvm/kvm-cpu.c    | 11 +++++++++--
 16 files changed, 33 insertions(+), 65 deletions(-)

