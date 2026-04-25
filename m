Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0170AFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGfIm-00085X-6W; Sat, 25 Apr 2026 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIW-00081C-Ne
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:52:04 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIS-00011n-Dg
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:52:00 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D364407B3;
 Sat, 25 Apr 2026 15:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97FDC2BCB0;
 Sat, 25 Apr 2026 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777132304;
 bh=raFpLgIEqGU084H1yeMIxpfupW3hrl/NYsy6ufmLfTQ=;
 h=From:To:Cc:Subject:Date:From;
 b=WYQwHhIpO5FhXULwDK2qlEVWFcaqTMUHMM6b9f8IiGSKJPj6+rAEGZ/M/L5zVm7gl
 SRhh3yYsdtzgW8OvIc+aTetJrTM037Rs5n1h0g58f+P6qe6mKBPwT2zaz65/DKHABs
 M7PhrokbaU7x94BWxuCZSIhF57uMTZaTq9Jp92Dio1f3CD88jzTpHhZLzMCeN+Gjqt
 n6z3RKgfRqMWDspaoJ32a+SxAgp2Q+Dv6GenFyorgLCcBlOe+QfMWacNT5fh12IuUK
 Lgjgj/KxLPpvn1HDAjBpW+QnTuMJ2ylGBD3zGgZzjIf66hBfGVCV+YIdIVRtJaXWQ2
 6O4aNB9eF7Vww==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/14] Linux user next patches
Date: Sat, 25 Apr 2026 17:51:26 +0200
Message-ID: <20260425155140.50186-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

The following changes since commit 98b060da3a4f92b2a994ead5b16a87e783baf77c:

  Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 9e7734ead149d73f1d25f61d0b7f075d4b2cb07d:

  linux-user: Flush errors by using exit() instead of _exit() in error path (2026-04-25 16:38:39 +0200)

----------------------------------------------------------------
linux-user: Pull request

This patch series adds myself as linux-user maintainer, and includes some
patches which have piled up for linux-user during the last few weeks.

Please apply.
Thanks!
Helge

----------------------------------------------------------------

Alistair Francis (1):
  linux-user/strace: Use pointer type for read and write values

Gyorgy Tamasi (1):
  linux-user: Don't define target_stat64 struct for loongarch64

Helge Deller (7):
  MAINTAINERS: Add myself as maintainer for linux-user
  linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
  linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
  linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
  linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
  linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
  linux-user: Flush errors by using exit() instead of _exit() in error
    path

James Hilliard (1):
  linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands

Matt Turner (1):
  linux-user/ppc: Fix ppc64 rt_sigframe stack offset

Richard Henderson (2):
  linux-user/arm/nwfpe: Replace user_registers with current_cpu
  linux-user/arm/nwfpe: Use thread-local storage for qemufpa

Yixin Wei (1):
  linux-user: fix off-by-one in host_to_target_for_each_rtattr()

 MAINTAINERS                   |  1 +
 linux-user/alpha/sockbits.h   |  7 +++++
 linux-user/arm/cpu_loop.c     |  2 +-
 linux-user/arm/nwfpe/fpa11.c  | 12 ++-------
 linux-user/arm/nwfpe/fpa11.h  | 25 ++++++------------
 linux-user/elfload.c          |  3 +++
 linux-user/fd-trans.c         |  2 +-
 linux-user/generic/sockbits.h |  8 ++++++
 linux-user/hppa/sockbits.h    |  7 +++++
 linux-user/main.c             |  2 +-
 linux-user/mips/sockbits.h    |  7 +++++
 linux-user/mips/target_cpu.h  |  5 ++++
 linux-user/ppc/signal.c       | 16 ++++++++++--
 linux-user/qemu.h             |  1 +
 linux-user/sparc/sockbits.h   |  7 +++++
 linux-user/strace.list        |  4 +--
 linux-user/syscall.c          | 49 +++++++++++++++++++++++++++--------
 linux-user/syscall_defs.h     |  4 +--
 18 files changed, 115 insertions(+), 47 deletions(-)

-- 
2.53.0


