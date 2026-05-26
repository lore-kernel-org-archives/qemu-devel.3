Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19012CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxzE-0004ZN-Gh; Tue, 26 May 2026 16:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxyk-0004X5-V4; Tue, 26 May 2026 16:02:18 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxyj-0002VP-5M; Tue, 26 May 2026 16:02:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C9C9600AB;
 Tue, 26 May 2026 20:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D661F000E9;
 Tue, 26 May 2026 20:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779825732;
 bh=11cK/N1dyEAOpS4nPioXZ6+e4u/b3GAU4J5LilP1+8c=;
 h=From:To:Cc:Subject:Date;
 b=jGXY6uLePmSn0Iz8f4WFgd2T7HF7TMsc2LlbFjyZMOmmMc3+DojOANgKXLQqz6U3T
 /RETQXgvsfPtgTafo3cKsBiS42VLD+aed2WU0GJHeqZOrpXLgc4paXeMM7Dd0/bzEQ
 AtjPgG4/25zX6jlDplvJ9IO84XQ6SfVpQ8LtQ6gsiOdWn2N6+Ltuyr4ipwzZZfz3bR
 BDIs6a8Xt6JFnZii3juyL1fGPoNr18fMD9JFM7Gl6wIIU1o7VsRjFU6suygOayDCNK
 Ha7rfZRqwtJF3l852k21hRuh25awuBfKrNkYktaZ8QoWfU3XaPUT3MB3POAPeh5yKf
 HzzdYRJr+sfQg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Cornelia Huck <cohuck@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 00/12] Linux user next patches
Date: Tue, 26 May 2026 22:01:55 +0200
Message-ID: <20260526200207.79738-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The following changes since commit 554cbfb1cf4601d2762f5315c884319e361b24cb:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-26 10:38:13 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to b501a44d26be4cf70ba77500365aadbf21494e74:

  linux-user: Move cpu_copy() to user-internals.h (2026-05-26 20:56:29 +0200)

----------------------------------------------------------------
linux user patches

A series of patches for linux-user, specifically many FPU fixes in signal
handling code for sh4, mips, ppc, alpha and s390x (from Matt Turner), a
madvise() improvement and a ARM cortex-m55 program loading fix (from me),
and qemu header cleanups (from Peter Maydell).

----------------------------------------------------------------

Helge Deller (3):
  linux-user: Implement finer grained madivse() syscall
  linux-user: Fix typo in function documentation for pgb_addr_set()
  linux-user: Fix loading static ARM cortex-m55 binaries

Matt Turner (7):
  linux-user/ppc: restore fp_status from FPSCR on sigreturn
  linux-user/mips: save/restore FCSR across signal delivery
  linux-user/alpha: add coredump support
  linux-user/sh4: preserve T/M/Q bits across signal delivery
  linux-user/sh4: restore FP rounding mode on sigreturn
  target/sh4: sync fp_status when gdb writes FPSCR
  linux-user/s390x: restore fpu_status rounding mode from FPC on
    sigreturn

Peter Maydell (2):
  linux-user: Move init_main_thread() prototype to user-internals.h
  linux-user: Move cpu_copy() to user-internals.h

 linux-user/alpha/elfload.c    | 12 ++++++++++++
 linux-user/alpha/target_elf.h | 13 +++++++++++++
 linux-user/elfload.c          |  4 ++--
 linux-user/mips/signal.c      |  7 +++++++
 linux-user/mmap.c             | 32 +++++++++++++++++++++++++++++++-
 linux-user/ppc/signal.c       |  2 +-
 linux-user/qemu.h             |  5 -----
 linux-user/s390x/signal.c     |  6 +++++-
 linux-user/sh4/signal.c       | 19 ++++++++++++++++---
 linux-user/user-internals.h   | 18 ++++++++++++++++++
 target/mips/cpu.h             |  3 +++
 target/mips/fpu.c             |  5 +++++
 target/s390x/cpu.h            |  1 +
 target/s390x/tcg/fpu_helper.c | 20 ++++++++++++++------
 target/sh4/cpu.h              |  3 +++
 target/sh4/gdbstub.c          |  2 +-
 target/sh4/op_helper.c        |  7 ++++++-
 tests/tcg/sh4/Makefile.target |  7 -------
 18 files changed, 138 insertions(+), 28 deletions(-)

-- 
2.54.0


