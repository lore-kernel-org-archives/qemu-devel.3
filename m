Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F78FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5V-0000GU-3S; Mon, 27 Apr 2026 17:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5M-0000Bl-Bs
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:44 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5H-0003Sw-Ff
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 03D6D6015B;
 Mon, 27 Apr 2026 21:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C7CC2BCB7;
 Mon, 27 Apr 2026 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323696;
 bh=8Tbj21BYQilKIwGyG2RC7pJHdcPWAtSC0Gjb0oPCAf4=;
 h=From:To:Cc:Subject:Date:From;
 b=AeKJxPf1Szn4KoPnArpJS9Rnitbb7Q5Ns1FFU6AWcolCl/xCZ4Q9jMZI1MwYS7hrE
 RzX0OUsFtL22yyqHsBPxTxcDy9g4/wLeqVb7ENcwA7M3709uj3S0eCYl7/D53PPTd4
 UYnLDNEK8SLlQrwz3eM6hwqEFVbbxmk+kmr8lqS2Zri8dxKVowHBOc4I1vDTSL7CLT
 8NqYzWXbeVwGyHHC4zaBYIgy8OwaPFeirL6qKf9bp41nW0yYBtuqk4IfXnCi3Dtdwm
 tEcYKyGqc14xwjxJUAevVsRoc2ZrrqgJ19d49ALzkF4XJCpszbdD8Yi7FjasgaCki1
 +bWkiU9//QgmA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 00/15] Linux user next patches
Date: Mon, 27 Apr 2026 23:01:18 +0200
Message-ID: <20260427210133.6016-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

for you to fetch changes up to 0272032af5d7ad6e19305abcd494a5f4f8dd7d58:

  linux-user: Add missing CDROM ioctls (2026-04-27 22:56:07 +0200)

----------------------------------------------------------------
linux-user: Pull various patches

This patch series adds myself as linux-user maintainer, and includes some
patches which have piled up for linux-user during the last few weeks.

v2:
- added various Revied-by tags
- fixed Reported-by tags
- added second exit() call to "Flush errors by using exit() instead of _exit()
  in error path" patch
- added missing CDROM ioctls patch

----------------------------------------------------------------

Alistair Francis (1):
  linux-user/strace: Use pointer type for read and write values

Gyorgy Tamasi (1):
  linux-user: Don't define target_stat64 struct for loongarch64

Helge Deller (8):
  MAINTAINERS: Add myself as maintainer for linux-user
  linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
  linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
  linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
  linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
  linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
  linux-user: Flush errors by using exit() instead of _exit() in error
    path
  linux-user: Add missing CDROM ioctls

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
 linux-user/ioctls.h           | 29 ++++++++++++---------
 linux-user/main.c             |  4 +--
 linux-user/mips/sockbits.h    |  7 +++++
 linux-user/mips/target_cpu.h  |  5 ++++
 linux-user/ppc/signal.c       | 16 ++++++++++--
 linux-user/qemu.h             |  1 +
 linux-user/sparc/sockbits.h   |  7 +++++
 linux-user/strace.list        |  4 +--
 linux-user/syscall.c          | 49 +++++++++++++++++++++++++++--------
 linux-user/syscall_defs.h     |  4 +--
 19 files changed, 133 insertions(+), 60 deletions(-)

-- 
2.53.0


