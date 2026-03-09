Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0AAF3C265
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxk-00045j-50; Mon, 09 Mar 2026 09:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxU-0003yR-3M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxO-00066u-48
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BAD756013F
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE67C4CEF7
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064034;
 bh=in1J9OvfequKYZ6Adj9Edfc82PIWo7qLL+OV1Fu3GfM=;
 h=From:To:Subject:Date:From;
 b=LN1XG+tMuAVISDDiZ9NUrWK8HkP4p7pApAX7kWo4BGUiDGeB8E6oR4g94TY/Ya8KQ
 u8JouXqH1R7iEfLkbxhz1k/gmAYQ8HA2zYlLlL088XyuL5NB1oAfqD6W03C16R+z41
 BDFpL59uA+N1GfQi6jw38fwpQjVa6tpZnc7e+88hMayyGD1xM8MImpgMzcvTFouQDh
 PO+1fva2DFhdB446puiaJeUFv+2yvaHeAbNnkshZyi7MZaTbZXf+arywV2VobH7+r0
 jR7T9u/IY/5oZ5mT0LDkS6UegNfhYpQjYyrJlnC8rnNEdvD54XHNEC5hw1ACRG01UR
 yS/b/jhMuHF7g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] Linux user for v11 patches
Date: Mon,  9 Mar 2026 14:47:01 +0100
Message-ID: <20260309134711.5312-1-deller@kernel.org>
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

The following changes since commit 084a6c6e73a8670f3d5144b88d617a76fae207a8:

  Merge tag 'hw-misc-20260308' of https://github.com/philmd/qemu into staging (2026-03-09 09:39:12 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11-pull-request

for you to fetch changes up to e6e84085069ccf2d083223aef67d008fbee20915:

  linux-user: Improve formatting for mremap() (2026-03-09 14:37:01 +0100)

----------------------------------------------------------------
linux-user patches for qemu v11

----------------------------------------------------------------

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

Helge Deller (1):
  linux-user: Improve formatting for mremap()

Jean-Christian CÎRSTEA (1):
  linux-user/strace: fix printing of file offsets

 bsd-user/mmap.c                 |  8 ++++--
 linux-user/ioctls.h             |  2 +-
 linux-user/mmap.c               |  9 ++++--
 linux-user/strace.c             | 51 +++++++++++++++++++++++----------
 linux-user/strace.list          |  2 +-
 linux-user/syscall.c            |  4 +++
 tests/tcg/multiarch/test-mmap.c | 27 +++++++++++++++--
 7 files changed, 77 insertions(+), 26 deletions(-)

-- 
2.53.0


