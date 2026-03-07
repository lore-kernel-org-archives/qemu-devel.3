Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7C8F55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyxhl-000820-EM; Sat, 07 Mar 2026 14:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxhj-00081e-5b
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:52:51 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxhh-0008Tf-MD
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:52:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 31C2560051;
 Sat,  7 Mar 2026 19:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A39C19422;
 Sat,  7 Mar 2026 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772913167;
 bh=fe9YyMLWT/fL/F+s+3fYcOMXRjETGkd6+MoXdGeL0SI=;
 h=From:To:Cc:Subject:Date:From;
 b=e29v8L0KJLKKZGKkEi5jzY19CY5W8CmPqgni/Xvog1ow508wuWj1xsMt2Ybgyo0Ns
 aMOUGjQa/woihgzgaUIY2iRa870vG1KFH6/rYrhIuTw7UAgc2uDVSq/P8Ri9F6SL5F
 5DG5+pD2AL4BdwmZCsPBMUVS1CLvR6FcgXjZffksEugN+2OynDx4p/sTRN076uH4Cs
 5Gx7cEoqbId8QCseG1JbYa+UrqyrM659eNiJz4bmaHHlbaBQqDYNaP2GQIFNVDCCtu
 FwMGi5kSS5ojNC7+5lNmvQGWEn0dCGSuQuDhHhphJi40qa/SQImCaTer2ZILFa+0c/
 zIVs8g7WFzw5A==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 00/12] linux-user and hppa patches
Date: Sat,  7 Mar 2026 20:52:31 +0100
Message-ID: <20260307195243.8813-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Two patches which prevent memleaks when using Diva PCI
cards, all other patches are for linux-user emulation.

Please check...

Helge

Andreas Schwab (3):
  linux-user: properly check flags in openat2
  linux-user: fix matching ioctl numbers in print_ioctl
  linux-user: fix TIOCGSID ioctl

Bingwu Zhang (4):
  linux-user: Deal with mmap where start > reserved_va
  bsd-user: Deal with mmap where start > reserved_va
  tests/tcg/multiarch/test-mmap: Print more details
  tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va

Frank Chang (1):
  linux-user: Check if RESOLVE_CACHED flag is defined before using it

Helge Deller (3):
  hw/hppa: Avoid leaking a diva-gsp device
  hw/char: Drop disable property of Diva GSP card
  linux-user: Improve formatting for mremap()

Jean-Christian CÎRSTEA (1):
  linux-user/strace: fix printing of file offsets

 bsd-user/mmap.c                 |  8 ++++--
 hw/char/diva-gsp.c              |  7 ++---
 hw/hppa/machine.c               | 19 ++++++------
 linux-user/ioctls.h             |  2 +-
 linux-user/mmap.c               |  9 ++++--
 linux-user/strace.c             | 51 +++++++++++++++++++++++----------
 linux-user/strace.list          |  2 +-
 linux-user/syscall.c            |  4 +++
 tests/tcg/multiarch/test-mmap.c | 27 +++++++++++++++--
 9 files changed, 87 insertions(+), 42 deletions(-)

-- 
2.53.0


