Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BFECD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8je-0006Za-LU; Sun, 24 May 2026 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jd-0006Yz-6q
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:17 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jb-0005XS-EH
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB797429EB;
 Sun, 24 May 2026 13:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE471F000E9;
 Sun, 24 May 2026 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779628752;
 bh=J71lmpQ1Inbv6j2JQt92BaTazOoFiKOR/kHx7CQf58g=;
 h=From:To:Cc:Subject:Date;
 b=OdHrfN8gwuX6UiNEsdSYhTLF1LVYIrhvzxEJQoI0JBQDIJFqWK7x2ebMNHtUGLR2O
 Mo5qdWFgksOhMXYvaUNODhuET6o+qWmTYAEMc9RDTJmiVCf/pr5lpTI5woWwFSSq2K
 VNPKEqrMOK5/pULPpF1Mi4DRjgzZ3zlabqLz2HA21vfWQP7bDYSJqCgcnPt6UVM9Uf
 zLLyiai6Hgr9+CkT4WtqOECwzRdsGvli5bxKZO5Y+G1hoLWmZDx4uy/9tstEt+N/5R
 dz3tR5lt6Hp2zXChYHlw2x+LriDianbGXDn2W6RC5P9opVMkBvNwTVt881awVm1+b8
 bjBXQzUwOwN/w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/6] Linux user next patches
Date: Sun, 24 May 2026 15:19:02 +0200
Message-ID: <20260524131909.162990-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

The following changes since commit f5a2438405d4ae8b62de7c9b39fac0b2155ee544:

  Merge tag 'pull-qapi-2026-05-21' of https://repo.or.cz/qemu/armbru into staging (2026-05-21 09:00:22 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 975bd51a88792cb6a3596c7127a1009bb3a17f08:

  linux-user/sh4: add VDSO support for sh4 and sh4eb (2026-05-24 15:07:28 +0200)

----------------------------------------------------------------
linux-user updates from Matt Turner

Various linux-user updates and fixes from Matt Turner regarding VDSO and
coredump support for hppa, mips, mips64, riscv and sh4.

----------------------------------------------------------------

Matt Turner (6):
  linux-user/hppa: add coredump support
  linux-user/mips64: fix elf_core_copy_regs register layout in core
    files
  linux-user/mips64: fix mipsn32 elf_core_copy_regs entry width
  linux-user/mips: use tswap32 in elf_core_copy_regs
  linux-user/riscv: add coredump support
  linux-user/sh4: add VDSO support for sh4 and sh4eb

 linux-user/hppa/elfload.c       |  13 +++
 linux-user/hppa/target_elf.h    |  21 +++++
 linux-user/mips/elfload.c       |  16 ++--
 linux-user/mips64/elfload.c     |  44 ++++++++++
 linux-user/riscv/elfload.c      |   9 ++
 linux-user/riscv/target_elf.h   |   7 ++
 linux-user/sh4/Makefile.vdso    |  18 ++++
 linux-user/sh4/elfload.c        |  14 ++++
 linux-user/sh4/meson.build      |  12 +++
 linux-user/sh4/target_elf.h     |   1 +
 linux-user/sh4/vdso-asmoffset.h |  45 ++++++++++
 linux-user/sh4/vdso-be.so       | Bin 0 -> 2704 bytes
 linux-user/sh4/vdso-le.so       | Bin 0 -> 2704 bytes
 linux-user/sh4/vdso.S           | 142 ++++++++++++++++++++++++++++++++
 linux-user/sh4/vdso.ld          |  67 +++++++++++++++
 15 files changed, 402 insertions(+), 7 deletions(-)
 create mode 100644 linux-user/sh4/Makefile.vdso
 create mode 100644 linux-user/sh4/vdso-asmoffset.h
 create mode 100755 linux-user/sh4/vdso-be.so
 create mode 100755 linux-user/sh4/vdso-le.so
 create mode 100644 linux-user/sh4/vdso.S
 create mode 100644 linux-user/sh4/vdso.ld

-- 
2.54.0


