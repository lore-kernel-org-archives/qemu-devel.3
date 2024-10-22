Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39932D1CDA2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38BD-0005l6-I1; Tue, 22 Oct 2024 02:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t38BA-0005im-EQ; Tue, 22 Oct 2024 02:15:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t38B8-0001tQ-Ce; Tue, 22 Oct 2024 02:15:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 714E19AC9F;
 Tue, 22 Oct 2024 09:15:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8EC36159B61;
 Tue, 22 Oct 2024 09:15:33 +0300 (MSK)
Received: (nullmailer pid 1304517 invoked by uid 1000);
 Tue, 22 Oct 2024 06:15:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 0/5] Trivial patches for 2024-10-22
Date: Tue, 22 Oct 2024 09:15:28 +0300
Message-Id: <20241022061533.1304493-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit cc5adbbd50d81555b8eb73602ec16fde40b55be4:

  Merge tag 'pull-tpm-2024-10-18-1' of https://github.com/stefanberger/qemu-tpm into staging (2024-10-18 15:45:02 +0100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 5ae3ec63631a907ba474094df99594cd545590df:

  replace error_setg(&error_fatal, ...) with error_report() (2024-10-21 22:40:47 +0300)

----------------------------------------------------------------
trivial patches for 2024-10-22

----------------------------------------------------------------
Brad Smith (1):
      meson.build: Remove ncurses workaround for OpenBSD

Gustavo Romero (1):
      linux-user: Clean up unused header

Kevin Wolf (1):
      configure: Replace literally printed '\n' with newline

Thomas Huth (1):
      ui/console-vc: Silence warning about sprintf() on OpenBSD

Tudor Gheorghiu (1):
      replace error_setg(&error_fatal, ...) with error_report()

 configure                 | 3 ++-
 hw/arm/allwinner-a10.c    | 6 +++---
 hw/arm/allwinner-h3.c     | 5 ++---
 hw/arm/allwinner-r40.c    | 5 ++---
 hw/arm/xlnx-versal-virt.c | 4 ++--
 hw/audio/soundhw.c        | 3 ++-
 linux-user/syscall.c      | 1 -
 meson.build               | 2 +-
 system/vl.c               | 3 ++-
 ui/console-vc.c           | 4 ++--
 ui/curses.c               | 2 +-
 11 files changed, 19 insertions(+), 19 deletions(-)

