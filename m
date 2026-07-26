Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1726C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 19:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo4eb-0000QN-U9; Sun, 26 Jul 2026 15:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wo4eY-0000Pn-U9
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:36:50 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wo4eX-0004wB-8y
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:36:50 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EBB3434D5;
 Sun, 26 Jul 2026 19:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1FE1F000E9;
 Sun, 26 Jul 2026 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785094600;
 bh=oXEBuC/uyf026rB3KmXILKJ39uDkB+bhKELDXsm7wmY=;
 h=From:To:Cc:Subject:Date;
 b=eYNCqfUUdPKupGpRcLybn2s05KKBor94WRKsBCx2Y4q7CvA7YLWUiStbNUy03UK3Z
 S+WQyJLj+cLh9cRWJRF/m2QZFsBK1g45xi4dOuJneJ/NtspGFXO1+AJLE8A/MWJdJT
 d8tO+Px0HwvAPm5PXy3GUNuqTldkri+vwrb6gegiob3FB+AZ83OTKC2WnVoa7uSVCw
 UbAL7fmqR09SO2vexs3RZn6Oc+lK5hbnkJ/DYtnvmOkktAhHlFTD61yT+DG3KZstIt
 YpNM1Zn+fyVCMjHh6pbaVkyDCdDXQtXcZwiQoSXesh+tO+1Zi/16VyF6gme3rR7ARJ
 ZDn8ZtuR2RZCw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/2] Linux user patches
Date: Sun, 26 Jul 2026 21:36:34 +0200
Message-ID: <20260726193636.110586-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

The following changes since commit 300438ffbb8d9430cac2fcc15cba6f482b2c0587:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-07-24 09:13:49 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to 4fdc24696cbf1ac6d97075d877cafc9fead4c475:

  linux-user: fix guards for the fsmount(2) syscall series (2026-07-26 15:10:59 +0200)

----------------------------------------------------------------
linux-user patches

Enable fsmount() syscalls and fix build with Linux 7.2 kernel headers.

----------------------------------------------------------------

Cédric Le Goater (1):
  linux-user: Guard local FUTEX_CMD_MASK definition

Matt Turner (1):
  linux-user: fix guards for the fsmount(2) syscall series

 linux-user/strace.c       | 2 +-
 linux-user/strace.list    | 2 +-
 linux-user/syscall.c      | 4 ++--
 linux-user/syscall_defs.h | 2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.54.0


