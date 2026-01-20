Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365ABD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAyf-0001Rr-B3; Tue, 20 Jan 2026 07:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1viAya-0001OH-Mo; Tue, 20 Jan 2026 07:36:53 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1viAyY-0002U6-FA; Tue, 20 Jan 2026 07:36:52 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F7231802BF;
 Tue, 20 Jan 2026 15:21:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1331B351748;
 Tue, 20 Jan 2026 15:21:51 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/9] Trivial patches for 2026-01-20
Date: Tue, 20 Jan 2026 15:21:37 +0300
Message-ID: <20260120122150.2254321-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
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

The following changes since commit 38879a667fbb4ef54c70de71494882615f600a64:

  Merge tag 'pull-tcg-20260119' of https://gitlab.com/rth7680/qemu into staging (2026-01-19 09:04:31 +1100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 83017c4aaa9e3ef80161443019764196dffdb654:

  linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE definition (2026-01-20 15:21:08 +0300)

----------------------------------------------------------------
trivial patches for 2026-01-20

----------------------------------------------------------------
Florian Hofhammer (1):
      configure: add ppc target back to container tests

Julian Ganz (1):
      tests: fix comment declaring runtime in rv64 interruptedmemory test

Michael Tokarev (3):
      Revert "gdbstub: Try unlinking the unix socket before binding"
      gdbstub: unlink the unix socket before bind()
      qemu-options.hx: use KiB, MiB, GiB for power-of-2 units

Pierrick Bouvier (1):
      linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE definition

Thomas Huth (3):
      configure: Set $PYTHON in the configuration of the optionroms
      tests/qemu-iotests: Use "gsed" for expressions that require GNU sed
      MAINTAINERS: Add docs/system/i386/ to the general x86 architecture section

 MAINTAINERS                           |  1 +
 configure                             |  3 ++-
 gdbstub/user.c                        | 30 +++++++++++++++++++++++++++---
 linux-user/aarch64/target_fcntl.h     |  1 +
 qemu-options.hx                       | 20 ++++++++++----------
 stubs/meson.build                     |  2 --
 tests/qemu-iotests/286                |  2 +-
 tests/qemu-iotests/common.rc          |  2 +-
 tests/tcg/riscv64/interruptedmemory.S |  2 +-
 util/meson.build                      |  2 --
 10 files changed, 44 insertions(+), 21 deletions(-)

