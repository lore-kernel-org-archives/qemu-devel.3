Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E29C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodvY-0001MJ-Lf; Tue, 28 Jul 2026 05:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvW-0001Lx-Fd
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:42 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvU-0002FY-84
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 328BC43D1C;
 Tue, 28 Jul 2026 09:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483331F000E9;
 Tue, 28 Jul 2026 09:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785230197;
 bh=6II3iP708LjsxS6vnrz/1YQr2puW0ngCsNa61/11t6I=;
 h=From:To:Cc:Subject:Date;
 b=igjYnLjsNl/SYn6K5qJm+fk2y3Kxh1CKMNkKLCkWCCQjcVYQfglsc4CqISFKA/Ss5
 8FziShAO6/UpErwDoi9tx+OWmby3K7y5YrW2KLcXsXrW/SIEKwqtP5RRCa0tyFksRQ
 GLIEeWE48F8Lzn427dOr6ECHJT9CLmTQ1XKHFz3klJUpSecfHzBunweQ6Oy0q47FDM
 MLDFsT3bJ457D0frpXh4/W7ZuYDYIx2jLBuDWHwKY589dmlF4ZhJL2nOygvVeFu571
 Pnh7uQs4C5vr01Jep2qH4HHpHY42YR4mYgklNBqk/R5e/c78np59BRvqmR/vD2j8pJ
 nNCzQFUNmXE6A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/3] Linux user patches
Date: Tue, 28 Jul 2026 11:16:30 +0200
Message-ID: <20260728091633.29765-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

The following changes since commit 300438ffbb8d9430cac2fcc15cba6f482b2c0587:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-07-24 09:13:49 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to db3abd36e4c7c2a72e00e5806cf4c47f5aa5c491:

  linux-user/sh4: allow full 32-bit address space (2026-07-28 11:12:37 +0200)

----------------------------------------------------------------
linux-user patches

Enable fsmount() syscalls, fix build with Linux 7.2 kernel headers and
allow full 32-bit address space on sh4.

----------------------------------------------------------------

Cédric Le Goater (1):
  linux-user: Guard local FUTEX_CMD_MASK definition

Laurent Vivier (1):
  linux-user/sh4: allow full 32-bit address space

Matt Turner (1):
  linux-user: fix guards for the fsmount(2) syscall series

 linux-user/sh4/target_mman.h | 2 +-
 linux-user/strace.c          | 2 +-
 linux-user/strace.list       | 2 +-
 linux-user/syscall.c         | 4 ++--
 linux-user/syscall_defs.h    | 2 ++
 target/sh4/cpu-param.h       | 8 +++-----
 6 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.54.0


