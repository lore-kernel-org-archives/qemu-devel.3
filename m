Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7446C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrba5-0007gf-MM; Tue, 02 Apr 2024 06:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rrba2-0007fx-Dv; Tue, 02 Apr 2024 06:41:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rrbZx-00085S-31; Tue, 02 Apr 2024 06:41:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A46A65B0FC;
 Tue,  2 Apr 2024 13:42:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 89EF9A93E9;
 Tue,  2 Apr 2024 13:41:06 +0300 (MSK)
Received: (nullmailer pid 2933264 invoked by uid 1000);
 Tue, 02 Apr 2024 10:41:06 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL v2 0/4] Trivial patches for 2024-04-02
Date: Tue,  2 Apr 2024 13:41:05 +0300
Message-Id: <20240402104106.2933247-1-mjt@tls.msk.ru>
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

The following changes since commit 6af9d12c88b9720f209912f6e4b01fefe5906d59:

  Merge tag 'migration-20240331-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-04-01 13:12:40 +0100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 7805132bc30b2619355b10bbfb67217ac838c677:

  hmp: Add help information for watchdog action: inject-nmi (2024-04-02 13:38:51 +0300)

----------------------------------------------------------------
trivial patches for 2024-04-02

spelling fixes for the release, minor doc fixes and usb-audio fix.

v2: fix Stefan Weil email

----------------------------------------------------------------
Dayu Liu (1):
      hmp: Add help information for watchdog action: inject-nmi

Joonas Kankaala (1):
      usb-audio: Fix invalid values in AudioControl descriptors

Philippe Mathieu-Daudé (1):
      fpu/softfloat: Remove mention of TILE-Gx target

Stefan Weil (1):
      Fix some typos in documentation (found by codespell)

 docs/devel/atomics.rst         | 2 +-
 docs/devel/ci-jobs.rst.inc     | 2 +-
 docs/devel/clocks.rst          | 2 +-
 docs/system/i386/sgx.rst       | 2 +-
 fpu/softfloat-specialize.c.inc | 2 +-
 hmp-commands.hx                | 2 +-
 hw/usb/dev-audio.c             | 4 +---
 qapi/qom.json                  | 2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

