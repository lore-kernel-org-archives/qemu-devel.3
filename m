Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C79EA8537
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHwm-0003dh-Bv; Sun, 08 Mar 2026 13:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwl-0003dP-Go
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:43 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwj-0003n3-SZ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B79F6600AD;
 Sun,  8 Mar 2026 17:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D96C116C6;
 Sun,  8 Mar 2026 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772990980;
 bh=mcHyL6+8FEVPVdqNxjMxNPmwmFF+mdBGITwiBQtTp4M=;
 h=From:To:Cc:Subject:Date:From;
 b=g8zNfBNz/XuLIaHGvXo81JKAclvnxtNNsz7aiZCDniEzZBf/0ScjLEx6rj4bYe+m/
 pi7vOfHOnCOVyHVCM56KxQzhOfMuMAC2FSQZuIMmx+xOCU7hqCfdf0xCqDEpMU6Yys
 Z4Bn0IYRbxSH0id3vtSKSj7xiH7W+TuVExUUv4Mt0O1H00ZcewcwbXuLaZ//y94tXU
 oTgMdaWQeExmq8AoTraq4CD9mpRtX3GS+mGySMvGwNLjyORyNVUQc2f9QxhTBnn4Rj
 k91ddI/RQeMV5LHfgqQYSzDBgp1aEUeqxBatv7y9kecfV8uFgouy7uW4TEaunibs1l
 Cqjqrn6r97Y2Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 00/12] For next patches
Date: Sun,  8 Mar 2026 18:29:24 +0100
Message-ID: <20260308172936.2835-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The following changes since commit 900682c57287ea308850af4490339455512e92e7:

  Merge tag 'pull-target-arm-20260306-2' of https://gitlab.com/pm215/qemu into staging (2026-03-06 15:58:24 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/for-next-pull-request

for you to fetch changes up to 9e8501ba72d5136ee5e6622f8863ce8ea252c29a:

  linux-user: Improve formatting for mremap() (2026-03-07 22:58:27 +0100)

----------------------------------------------------------------
linux-user and hppa patches

Two patches which prevent memleaks when using Diva PCI
cards on the parisc architecture.
All other patches are for linux-user emulation.

----------------------------------------------------------------

Andreas Schwab (3):
  linux-user: properly check flags in openat2
  linux-user: fix matching ioctl numbers in print_ioctl
  linux-user: fix TIOCGSID ioctl

Bingwu Zhang (4):
  linux-user: Deal with mmap where start > reserved_va
  bsd-user: Deal with mmap where start > reserved_va
  tests/tcg/multiarch/test-mmap: Print more details
  tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va

Frank Chang (1):
  linux-user: Check if RESOLVE_CACHED flag is defined before using it

Helge Deller (3):
  hw/hppa: Avoid leaking a diva-gsp device
  hw/char: Drop disable property of Diva GSP card
  linux-user: Improve formatting for mremap()

Jean-Christian CÎRSTEA (1):
  linux-user/strace: fix printing of file offsets

 bsd-user/mmap.c                 |  8 ++++--
 hw/char/diva-gsp.c              |  7 ++---
 hw/hppa/machine.c               | 19 ++++++------
 linux-user/ioctls.h             |  2 +-
 linux-user/mmap.c               |  9 ++++--
 linux-user/strace.c             | 51 +++++++++++++++++++++++----------
 linux-user/strace.list          |  2 +-
 linux-user/syscall.c            |  4 +++
 tests/tcg/multiarch/test-mmap.c | 27 +++++++++++++++--
 9 files changed, 87 insertions(+), 42 deletions(-)

-- 
2.53.0


