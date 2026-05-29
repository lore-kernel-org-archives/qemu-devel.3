Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C38BCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDi-0002pQ-1C; Thu, 28 May 2026 18:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDg-0002om-6x; Thu, 28 May 2026 18:28:52 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDe-0006tr-2q; Thu, 28 May 2026 18:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007320; x=1780612120; i=deller@gmx.de;
 bh=WTd4XkVNA46IfA3ilqCj/kIrTpfEQ2kH+oiCRWpoGuo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hcPem6aNB41zsWFBA6PYezhCrk8EgvV1LWwc7bl+Qmg9MVBONSW8MLBAeBDNWkfS
 f7zQ50Uvve8Yf9HDhWFq1yDDN5jZA1krZBheUJaRj4jcIfE9DQoTpR8fze7f9pWAd
 GfDpYA5ILGwkybwoI1O4QlXzLfG3zcZdFiz54eAn4MkgB0wha2w2sfdE4xGhWkcpU
 uuXK8Dfwq+Ho0CHWSQK7CAhyfsh7HICIyfJpbyEzEOLK/c7YGc7lI62AOj7Uqb1P7
 j4tXwKHft1hKtSELKQq/V5vfOWMD8EmMQ6zZLtuvRTBYGHX1UtwviA2P2j4iD84pF
 QWSExGpr6Lw5UBJ4fQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1xH7wl3bDc-00vah4; Fri, 29
 May 2026 00:28:40 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 00/10] Linux user next patches
Date: Fri, 29 May 2026 02:25:37 +0200
Message-ID: <20260529002548.19293-1-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YiqOam7TPcXoB6quYocOMs1oRhV5ddKMHwfwK4EamZ7oEyh6Qk1
 E51hY32Oa/et1kyZmVSDGNCno1be2prZQJRtX1bas89HjXtGkAtASgqcP86vYhG7qTzaR3t
 PMCh6ooVVWVNCRPgKN0WAuOZ+ZNiifB/IKZzXMcJS7GSswnltqHLcVCPX0sS/VbvJ5v5jgB
 1Rkj0ce23zwXcmI0Drcrw==
UI-OutboundReport: notjunk:1;M01:P0:ac2FBL+0lwk=;5eTgiljsKqkUkHO0dUq/jhfnaR+
 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
 sp0Bchr6FxMYeGih+JB7iHq7PSI=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 2db91528542672cf0db78b3f2cc0e22b36302b3=
8:

  Merge tag 'pull-vfio-20260527' of https://github.com/legoater/qemu into =
staging (2026-05-27 14:45:58 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-reque=
st

for you to fetch changes up to 35583b85327e0e7288e36feb38bc57e7d795ed72:

  linux-user: Move cpu_copy() to user-internals.h (2026-05-29 02:18:45 +02=
00)

=2D---------------------------------------------------------------
linux user patches

A series of patches for linux-user, specifically many FPU fixes in signal
handling code for sh4, mips, ppc and s390x (from Matt Turner), a
madvise() improvement and a ARM cortex-m55 program loading fix (from me),
and qemu header cleanups (from Peter Maydell).

=2D--
v2: Dropped the "ARM cortex-m55 program loading fix" and the FPU alpha pat=
ch

=2D---------------------------------------------------------------

Helge Deller (2):
  linux-user: Implement finer grained madivse() syscall
  linux-user: Fix typo in function documentation for pgb_addr_set()

Matt Turner (6):
  linux-user/ppc: restore fp_status from FPSCR on sigreturn
  linux-user/mips: save/restore FCSR across signal delivery
  linux-user/sh4: preserve T/M/Q bits across signal delivery
  linux-user/sh4: restore FP rounding mode on sigreturn
  target/sh4: sync fp_status when gdb writes FPSCR
  linux-user/s390x: restore fpu_status rounding mode from FPC on
    sigreturn

Peter Maydell (2):
  linux-user: Move init_main_thread() prototype to user-internals.h
  linux-user: Move cpu_copy() to user-internals.h

 linux-user/elfload.c          |  2 +-
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
 16 files changed, 112 insertions(+), 27 deletions(-)

=2D-=20
2.54.0


