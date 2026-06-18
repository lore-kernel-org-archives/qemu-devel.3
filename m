Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96500CD98F9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 21:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waKgt-0003ex-In; Thu, 18 Jun 2026 17:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1waKgs-0003ea-39
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 17:54:26 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1waKgq-0002JW-Db
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 17:54:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D1BF41917;
 Thu, 18 Jun 2026 21:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82841F000E9;
 Thu, 18 Jun 2026 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781819655;
 bh=W0KbvSXa0ZAkEKS9cQhP8Bp14oV+KyPfN4WHoByCE4k=;
 h=From:To:Cc:Subject:Date;
 b=HYjxnXrBQYjtjvnY6ecdWXvyUCi968sJHWhZOKD8EcCsriqmE1S0IgZl7+xD37j5Q
 nHvCTY+P/CCx/7Xx0sJlpgtMB1ugdnqjpALw6Xg0+8GmqcOirFscoLXtOHzYfb1WH0
 qPlMa70f2iN6qbX6WHrhWzbLmwNTLBtrSMF2xsPzHb8xsOiVw9f1+oqVxV11BDT3KK
 rliVzxmFmhISwA+CEnCerSuhtxfHJl34WNrnibqlZm4K267alEcuaSbV0yu7laTHV2
 wubUVb4bfs47WD/IGgQv0nl6bQrpp0sRPm7Q3ZOQeE0o96xohOPUGEqNk7rAx2uujb
 aDQ6Ijagz0G3w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de
Subject: [PULL 0/4] Linux user patches
Date: Thu, 18 Jun 2026 23:54:07 +0200
Message-ID: <20260618215411.22057-1-deller@kernel.org>
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

The following changes since commit c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff:

  Merge tag 'firmware-20260617-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-06-17 10:17:29 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to 54e08dbe8f2aeca57e3b1a5eab09a9fec88c1c67:

  linux-user/xtensa: fix unlock of uninitialized frame pointer on sigreturn (2026-06-18 23:43:35 +0200)

----------------------------------------------------------------
linux-user patches

One frame pointer memory locking fix for the xtensa architecture, a generic
loader fix for programs with modified headers, and two patches to emulate
/proc/cpuinfo for loogarch and m68k CPUs.

----------------------------------------------------------------

Akshit Yadav (1):
  linux-user: Fix AT_PHDR when program headers are relocated into their
    own segment

Helge Deller (2):
  linux-user: Implement /proc/cpuinfo for loongarch cpus
  linux-user: Implement /proc/cpuinfo for m68k CPU

Matt Turner (1):
  linux-user/xtensa: fix unlock of uninitialized frame pointer on
    sigreturn

 linux-user/elfload.c                 | 21 +++++++-
 linux-user/loongarch64/elfload.c     | 20 +++++++
 linux-user/loongarch64/target_proc.h | 79 +++++++++++++++++++++++++++-
 linux-user/m68k/target_proc.h        | 46 ++++++++++++++++
 linux-user/qemu.h                    |  1 +
 linux-user/xtensa/signal.c           |  3 +-
 6 files changed, 167 insertions(+), 3 deletions(-)

-- 
2.54.0


