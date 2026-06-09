Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C77DCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzT7-0002cS-3M; Tue, 09 Jun 2026 12:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWzSw-0002bT-Vd
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:38:16 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWzSv-0005AX-0m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:38:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 93D816020B;
 Tue,  9 Jun 2026 16:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C01F00898;
 Tue,  9 Jun 2026 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781023091;
 bh=XpDxvHBbnjclAG9SsDHm6ubLOTWdQkglsG8yhrKR6aA=;
 h=From:To:Cc:Subject:Date;
 b=N53h4p1DoniyLgInnOdHF3n7BKHhtSdAYUhkW+9F0pQ4JWGa8oMcA6E3Ho0ZND7fS
 RQ0g+QY4GPUbQPkWd458NOhmyJhoaqdla9Vt4KIUVaIYWNxdMTX2BU8YOehAtIuSQ3
 C5brSTQBPbyTtWh+k5JjfSzRw09Z4H0VULS0F3rpU4ymkxMqpt1OsdMQAlu2QS9G6B
 zBQUA7uQjiaZrxqDGmtuSvwwLVt8U3FHe/AwSV0qmvDYZ0uS7xE6I/2pEZ2SHyqSiT
 tGhtBl8gWnz1KPpS+4egaU6DEPQqWMsigD0mXsJVEiZORse4BxnGdPMXIbXKuo3cX6
 Ya2XadnQ5qkuQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL v2 0/8] Linux user patches
Date: Tue,  9 Jun 2026 18:37:59 +0200
Message-ID: <20260609163807.6083-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

for you to fetch changes up to 20d77f05b3471efabea821cdd2e8b2bda7d9822e:

  target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn (2026-06-09 18:33:21 +0200)

----------------------------------------------------------------
linux-user patches for alpha, sparc and sh4

Various linux-user related patches from Matt Turner with coredump support for
alpha and sparc, as well as some fixes for the signal handler in sparc.

The patches from Xinhui Yang add the missing fsmount series syscalls support
for systemd.

v2: Fix build failure when build server does not yet support fsmount syscalls.

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


