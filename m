Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1933CCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPL4q-0001Su-2q; Tue, 19 May 2026 10:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4l-0001SS-Fq
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:39 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4i-00076p-CQ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 90E8544121;
 Tue, 19 May 2026 14:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C60C2BCB3;
 Tue, 19 May 2026 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779199534;
 bh=9C0nS/NwsnmA0+i/HNaP8sEQKzuA+jxqN/EGAQrZ5sY=;
 h=From:To:Cc:Subject:Date:From;
 b=SbQGE9KhVMigxYu6I6pa5DmCqtXMuDvokD07O7UCCp72IdDkUqkGvjmscrGMf1Lqd
 9eVTKK2GkGZxyL0wUhhb0uWvOR31SamMbNyont0Wl2hXVXUkbZrAGzRebaakFB0QyP
 g9bykC3JbsdIKSXT4Swpne34yK9Mgf5VJ08gMjNiR5rzwy+9mkNkPbrwvYlP0RAHP4
 KqktrPnriw5lh0VnkQyS43hLIoTSdbL++1bh9OiELfr6qeTSQMJA8rBvqomN50sOeg
 t8HMj8axTF2V0YBSn8q/Bx2YdNIdwJPpxcZom6NRnXQd7sgglfdnTzfGm7t0MVnHhZ
 jwNPBJS1m0XpA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/4] Linux user next patches
Date: Tue, 19 May 2026 16:05:27 +0200
Message-ID: <20260519140531.11931-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

The following changes since commit 6d17fd91f6cf88df5cb2205e578640d72605cc43:

  Merge tag 'pull-nvme-20260518' of https://gitlab.com/birkelund/qemu into staging (2026-05-18 08:33:20 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 1e000f9671aed33a3f86d2fdc61f991424628bb4:

  linux-user: Fix a memory leak when pthread_create fails (2026-05-19 15:49:35 +0200)

----------------------------------------------------------------
linux-user patches

pthread_create() failure path cleanups, sh4 libunwind/sigtramp fixes and
a (emulated) dynamic linker fix for AT_EXECFN.

----------------------------------------------------------------

Helge Deller (1):
  linux-user: Fix AT_EXECFN in AUXV for symlinked programs

Matt Turner (2):
  linux-user/sh4: Fix target_ucontext tuc_link field type
  linux-user/sh4: Fix setup_sigtramp to match Linux kernel trampoline
    pattern

Warner Losh (1):
  linux-user: Fix a memory leak when pthread_create fails

 linux-user/main.c           |  6 +++--
 linux-user/sh4/signal.c     | 46 +++++++++++++++++++++++++++----------
 linux-user/syscall.c        | 24 ++++++++++++-------
 linux-user/user-internals.h |  1 +
 4 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.54.0


