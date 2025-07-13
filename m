Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6DDC83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 09:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uasjz-0003VG-Gy; Sun, 13 Jul 2025 05:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uasjt-0003Or-Tf; Sun, 13 Jul 2025 05:11:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uasjh-00070u-C5; Sun, 13 Jul 2025 05:11:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A34D71362E1;
 Sun, 13 Jul 2025 12:10:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 65A3A245F4C;
 Sun, 13 Jul 2025 12:10:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/6] Trivial patches for 2025-07-13
Date: Sun, 13 Jul 2025 12:10:42 +0300
Message-ID: <20250713091059.35165-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 0f55ca43cd90eb89193bae45d0907c1b17a1dadd:

  docs/devel/tracing: Update trace.h creation rune to include SPDX (2025-07-13 12:08:07 +0300)

----------------------------------------------------------------
trivial patches for 2025-07-13

There aren't anything fancy here, and the amount of patches is
rather small.  This set has been accumulating for a long time
but there's only 6 patches in it.

----------------------------------------------------------------
Andrew Kreimer (1):
      docs: remove repeated word

Peter Maydell (2):
      hw/uefi: Create and use trace.h wrapper header
      docs/devel/tracing: Update trace.h creation rune to include SPDX

Thomas Huth (2):
      accel/kvm: Adjust the note about the minimum required kernel version
      docs/system/target-i386: Remove the sentence about RHEL 7 being supported

Thomas Lambertz (1):
      hw/usb/dev-hid: Support side and extra mouse buttons for usb-tablet

 accel/kvm/kvm-all.c          | 3 +--
 docs/devel/tracing.rst       | 2 +-
 docs/system/introduction.rst | 2 +-
 docs/system/target-i386.rst  | 4 +---
 hw/uefi/trace.h              | 2 ++
 hw/uefi/var-service-core.c   | 2 +-
 hw/uefi/var-service-policy.c | 2 +-
 hw/uefi/var-service-utils.c  | 2 +-
 hw/uefi/var-service-vars.c   | 2 +-
 hw/usb/dev-hid.c             | 6 +++---
 10 files changed, 13 insertions(+), 14 deletions(-)
 create mode 100644 hw/uefi/trace.h

