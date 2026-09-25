Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36109C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2ON-0000NN-Bz; Fri, 25 Sep 2026 05:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OK-0000Mx-B8
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:53 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OI-0006D7-Ky
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:52 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0828D6022E;
 Fri, 25 Sep 2026 09:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AA71F000FF;
 Fri, 25 Sep 2026 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329127;
 bh=LktQ6GVJUIbiPEm7EQOkG6Jr/QJ2GZ5f7GYEouqjFtY=;
 h=From:To:Cc:Subject:Date;
 b=CK+B49SNCX00orUeCcjS5gnHxE9UDM7n9Mz3Ee3odaHe96BJ9ztkA4NZIyiA/BJjA
 OWQ4KUcRYCXXUFgX4PsSQV+MKH3KGrGNICoa18a0hYwhDCBRSN0AdamQKQ1eZO2iWl
 MsmLQjGuu/DaPACtLg+8EM/mwxdUWeHKirYEfx6Gc0LI5Ep48EYTyCyt+okK93SiLc
 +Ly0P5QjdDulEY9XONAMnw6/z0dQRxXtbPY4oFWLcziei3gIuFv8VuBhuMh+3fqPKb
 lTEkDKCOMW04fQh8yy6ReIvL0NipQeUdPPZlC0bN+tcVTfY8JJiJGMn5hVpfxybnhW
 gu99fAyZyFGaA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/8] Linux user next patches
Date: Fri, 25 Sep 2026 11:38:36 +0200
Message-ID: <20260925093844.5685-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit a97f90fcf8029af253a2ba274b9bda9acabc5b23:

  Merge tag 'pull-tcg-20260924' of https://gitlab.com/rth7680/qemu into staging (2026-09-24 08:24:59 -0700)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 926d6cf4036102e3e0bc9e7f92291ee2277c3215:

  target/sh4: Drop use_exit_tb (2026-09-25 11:23:44 +0200)

----------------------------------------------------------------
linux user patches

A series of patches, which
- fix a race in atomic variables on sh4 guest
- fix unwinding through vdso signal trampolines on sh4 guests
- improve the parameter checks for setsockopt()/getsockopt() syscalls
- improves the parameter checks for the mincore() syscall

----------------------------------------------------------------

Igor Shevlyakov (2):
  linux-user: report EBADF for setsockopt()/getsockopt() on a bad fd
  linux-user: report EINVAL for a misaligned mincore() start

Matt Turner (3):
  linux-user/sh4: use the kernel's sigreturn trampoline sequence in the
    vdso
  linux-user/sh4: fix vdso CFA for rt_sigreturn frames
  linux-user/sh4: align the vdso sigreturn trampolines

Richard Henderson (3):
  accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
  target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC
  target/sh4: Drop use_exit_tb

 accel/tcg/cpu-exec.c             |   4 ++-
 include/exec/translation-block.h |   1 +
 linux-user/sh4/vdso-be.so        | Bin 2704 -> 2724 bytes
 linux-user/sh4/vdso-le.so        | Bin 2704 -> 2724 bytes
 linux-user/sh4/vdso.S            |  31 ++++++++++++++------
 linux-user/syscall.c             |  25 +++++++++++++++-
 target/sh4/cpu.h                 |   6 ++--
 target/sh4/translate.c           |  48 ++++++++++++++-----------------
 8 files changed, 74 insertions(+), 41 deletions(-)

-- 
2.54.0


