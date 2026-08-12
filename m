Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C114C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhm-0007Wi-Hs; Wed, 12 Aug 2026 16:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhj-0007S5-1F
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:39 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhh-0001EL-6e
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:38 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9F98600AF;
 Wed, 12 Aug 2026 20:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368D01F000E9;
 Wed, 12 Aug 2026 20:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567048;
 bh=501ZxrlyblIQ1h1McRWbS4xSN9a3lM3C17VvSRWKLsU=;
 h=From:To:Cc:Subject:Date;
 b=chugPWXfZ8Fa+44OnWLYZuBsILnY0shegWyBNfbvbBsywjRKZb41lg/OESQJEWHl3
 nWe0gprmI7JCCoB5fIfOnVewGU9IR5Xa4iO9BVyjiLtqvl915/9nCBBCa0MMDfXQOD
 prTv/NYonrfsc5XeYq0hg0Qybpd2GOfieeT9OYpgj7dLvzYdTplc+yVNpJFIlR2FHG
 n69xN4TIK2PwJAkaO30fGQ95tQlKZ5JB9uI+h/21IdzSeV3OOIo1wUpV9gYr5xCkON
 WOcu1UbHYNaAQi7d0yL78ocrg84WU/1Kih/XCTM+Amtoyej//AvPI+m4ua6GdNZ8BI
 h5YVomDNi3AMg==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/7] Linux user patches
Date: Wed, 12 Aug 2026 22:37:18 +0200
Message-ID: <20260812203725.10694-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

The following changes since commit 3e3ccab106f879b1512f8e0d51a827dd4de30e22:

  Update version for v11.1.0-rc3 release (2026-08-04 15:36:08 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to ce276ab1a92cad460930fada1bc2e2e4a96f7595:

  linux-user/sh4: write the floating-point registers to a core dump (2026-08-07 18:14:13 +0200)

----------------------------------------------------------------
linux-user patches

Patches from Mat Turner to support the mount_setattr() syscall and to add
floating-point registers to core dumps on alpha, mips, hppa, riscv and sh4.

----------------------------------------------------------------

Matt Turner (7):
  linux-user: implement mount_setattr(2)
  linux-user: support writing floating-point registers to a core dump
  linux-user/alpha: write the floating-point registers to a core dump
  linux-user/mips: write the floating-point registers to a core dump
  linux-user/hppa: write the floating-point registers to a core dump
  linux-user/riscv: write the floating-point registers to a core dump
  linux-user/sh4: write the floating-point registers to a core dump

 linux-user/alpha/elfload.c     | 10 ++++++++
 linux-user/alpha/target_elf.h  | 11 +++++++++
 linux-user/elfload.c           | 19 +++++++++++++++
 linux-user/hppa/elfload.c      |  7 ++++++
 linux-user/hppa/target_elf.h   |  9 +++++++
 linux-user/loader.h            |  3 +++
 linux-user/mips/elfload.c      |  8 +++++++
 linux-user/mips/target_elf.h   | 13 ++++++++++
 linux-user/mips64/target_elf.h | 13 ++++++++++
 linux-user/riscv/elfload.c     |  9 +++++++
 linux-user/riscv/target_elf.h  | 11 +++++++++
 linux-user/sh4/elfload.c       | 10 ++++++++
 linux-user/sh4/target_elf.h    | 12 ++++++++++
 linux-user/strace.list         |  3 +++
 linux-user/syscall.c           | 44 ++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h      | 13 ++++++++++
 16 files changed, 195 insertions(+)

-- 
2.54.0


