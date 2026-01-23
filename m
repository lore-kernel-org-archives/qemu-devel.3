Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C517D778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 20:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjO91-0000NM-Ni; Fri, 23 Jan 2026 15:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO8z-0000LR-Kx
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:37 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO8x-0006wd-TW
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D81E600C4;
 Fri, 23 Jan 2026 20:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8385EC4CEF1;
 Fri, 23 Jan 2026 20:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769201553;
 bh=TCmSDK3idDdMCekR47cWU1V2rwgmV/WCyeLE8hqdZDU=;
 h=From:To:Cc:Subject:Date:From;
 b=lmsM17jTJ9qAyjwHdQhAsBso4PEPvrYGfk7z0lDuuo9mA84QVoRlAo0PYX0+Bhtup
 YWtP3iaqDr9IzfZdPR5JsTS0JNWodQv94eQ2FCEXTVQrS3zoXyWr4wl0/2dyNynB1d
 +6+/XhayhddBn3jEWDu7rT4DYYYaAi8Z3V6iyLk/wsqf602asQ6ytG4FMkW4Mz0/Y6
 6LxMbQf8+VeN9Uxl8YIezZjZOPkf5tLGHEVad9zEEMm/pHSTU7jSDleyML+wn/KLwO
 KvA55bvLNoGlSChJmLO+F8XNMOkLX1WFf6GYxC/a8mGmSWu+BBesnmk54ggRTipiFF
 Pu7DuDfn3JlbQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/11] Linux user for v11 patches
Date: Fri, 23 Jan 2026 21:52:19 +0100
Message-ID: <20260123205230.33541-1-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:

  Merge tag 'hw-misc-20260120' of https://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11-pull-request

for you to fetch changes up to 3829bb3f187598501051b582053bed693aced988:

  linux-user: Fix MADV_XXX constants on hppa target (2026-01-23 20:40:15 +0100)

----------------------------------------------------------------
linux-user: statx() syscall, termios2 support and futext() syscall fixes

Please pull if no obvious breakages happen in the testsuite.

Thanks!
Helge

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: update statx emulation

Helge Deller (2):
  linux-user: strace: Fix 5th argument of futex syscall
  linux-user: Fix MADV_XXX constants on hppa target

Icenowy Zheng (1):
  linux-user: fixup termios2 related things on PowerPC

Luca Bonissi (6):
  linux-user: Add termios2 support
  linux-user: Add termios2 support to alpha target
  linux-user: Add termios2 support to hppa target
  linux-user: Add termios2 support to mips target
  linux-user: Add termios2 support to sh4 target
  linux-user: Add termios2 support to sparc target

Vivian Wang (1):
  linux-user: Add missing termios baud rates

 linux-user/alpha/termbits.h   |  30 +++++
 linux-user/generic/termbits.h |   2 +-
 linux-user/hppa/termbits.h    |  45 +++++++-
 linux-user/ioctls.h           |   6 +
 linux-user/mips/termbits.h    |  35 +++++-
 linux-user/ppc/termbits.h     |   1 +
 linux-user/sh4/termbits.h     |  51 ++++++---
 linux-user/sparc/termbits.h   |  33 +++++-
 linux-user/strace.c           |  76 ++++++++++++-
 linux-user/syscall.c          | 199 ++++++++++++++++++++++++++++++----
 linux-user/syscall_defs.h     |   6 +-
 linux-user/syscall_types.h    |   3 +
 linux-user/user-internals.h   |   3 +
 13 files changed, 447 insertions(+), 43 deletions(-)

-- 
2.52.0


