Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D732CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXM43-0003Gg-QG; Wed, 10 Jun 2026 12:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wXM3y-0003Fr-3B
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:45:58 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wXM3v-0000ig-Ua
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:45:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0B04601DC;
 Wed, 10 Jun 2026 16:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556121F00893;
 Wed, 10 Jun 2026 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781109953;
 bh=L2vwRNf8oYbUrdVxqRg4C55cQjUo916Dd+nC/fxuzaA=;
 h=From:To:Cc:Subject:Date;
 b=VAAtLUCvZGeM1AY4t7p2Se1grlfTp2lLsKZcQvGsIYVXQDmfpYNn6L+fB7X9LK8o1
 0ngkCO3v1yU6MQD5HotLXY4sZe+qFe5Yc2J6IY3bBHckfQXrG11hSmDspk2lMFUIST
 ZPebR3wtghbEZL85tJ1Q/5JTORSfd3Y2pg2PoewGkKaHPPI9Kyb7YAucZueB7HzPn+
 B5eoBZMJJr7As04TvgpMdzsbTN8LUjPvOYkU1Z1+0IOJOiDRkwxi2pb7vJ3FNUkj4p
 2+f4pSnb8NmWciUxlhU4+gpMP8CKkSL1XQK9HmUvIzCgfdOjQVfQauyR3KTeOav/Lu
 0NHTad/LWyUNQ==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL v3 0/8] Linux user patches
Date: Wed, 10 Jun 2026 18:45:41 +0200
Message-ID: <20260610164549.5699-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The following changes since commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc:

  lcitool: remove Cirrus CI support (2026-06-03 12:45:38 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to 2d0ef7323ea0f80d169b27858260ce590ca95a34:

  target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn (2026-06-10 18:42:59 +0200)

----------------------------------------------------------------
linux-user patches for alpha, sparc and sh4

Various linux-user related patches from Matt Turner with coredump support for
alpha and sparc, as well as some fixes for the signal handler in sparc.

The patches from Xinhui Yang add the missing fsmount series syscalls support
for systemd.

----------------------------------------------------------------

Matt Turner (6):
  linux-user/alpha: add coredump support
  linux-user/sparc: add coredump support
  linux-user/sparc: restore L/I registers from RSA in
    sparc64_set_context
  linux-user/sparc: call block_signals() before set_sigmask() in
    setcontext
  linux-user/sparc: flush register windows before core dump
  target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn

Xinhui Yang (2):
  linux-user: implement fsmount(2) series of syscalls
  linux-user/strace: add fsmount series of syscalls

 linux-user/alpha/elfload.c    |  12 ++++
 linux-user/alpha/target_elf.h |  13 +++++
 linux-user/elfload.c          |   9 +++
 linux-user/sparc/cpu_loop.c   |   3 +-
 linux-user/sparc/cpu_loop.h   |   7 +++
 linux-user/sparc/elfload.c    |  54 +++++++++++++++++
 linux-user/sparc/signal.c     |  27 +++++++++
 linux-user/sparc/target_elf.h |  20 +++++++
 linux-user/strace.c           | 105 ++++++++++++++++++++++++++++++++++
 linux-user/strace.list        |  15 +++++
 linux-user/syscall.c          | 104 +++++++++++++++++++++++++++++++++
 target/sh4/translate.c        |   2 +-
 12 files changed, 369 insertions(+), 2 deletions(-)
 create mode 100644 linux-user/sparc/cpu_loop.h

-- 
2.54.0


