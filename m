Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B857DCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY49l-00016M-MM; Fri, 12 Jun 2026 11:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wY49j-00015t-QS
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:50:51 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wY49h-00083e-Nk
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:50:51 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 730664343E;
 Fri, 12 Jun 2026 15:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027FB1F000E9;
 Fri, 12 Jun 2026 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781279447;
 bh=5yGmPHU1PVAtwTAieQykahpVXwILS8ZcqQaz8aSZVsQ=;
 h=From:To:Cc:Subject:Date;
 b=bMK8DuFsRnjrAC0fOU/0L/06leTCu74hSgcDdtjnk83sIxRQXc6ixa2ts+TUc8QoM
 NgnSOKT0xXtGuUCFjkPxX1dCOE1YvFbQBizsb2iahHKEdPJIo0roT0lTNo6WQM/pWq
 x+RHSP6u0ClslJb/XbcjWKWlNv5sUl+eW9BvGqNaeHvgUiJYGgMrwf8L7ezVIIfmvg
 y3OyrJkhDlTEKFpU4RyZuob67iSwDTcVSeLJddPXXYd0I7WW19F3j/XydnzeF/Irz2
 rY7G0+Um4UIV9uXd6d88XpAvjxBo68+0lUYMmVLYZ4zRXCZeWF4J1L+ebDd0qvmAfa
 YLEbGLekD8C2g==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/4] Linux user patches
Date: Fri, 12 Jun 2026 17:50:39 +0200
Message-ID: <20260612155043.3552-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

The following changes since commit ec6a1f43989c6bbf2de1ab84959a70ee35fa1b57:

  Merge tag 'linux-user-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-06-11 13:22:50 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to 6858e3a71cc41510937bec0950eb4e42e33ba5f2:

  linux-user/xtensa: save/restore FP registers across signal delivery (2026-06-12 17:47:27 +0200)

----------------------------------------------------------------
linux-user patches

Add preadv2/preadv2 syscalls, fix FP registers across signals on xtensa, and
add emulation for /proc/cpuinfo for ppc CPUs

----------------------------------------------------------------

Dominique Martinet (1):
  linux-user: add preadv2/preadv2

Helge Deller (1):
  linux-user: Implement /proc/cpuinfo for ppc cpus

Matt Turner (2):
  target/xtensa: add cpu_set_fcr/fsr helpers to sync fp_status
  linux-user/xtensa: save/restore FP registers across signal delivery

 linux-user/ppc/cpu_loop.c    |  2 +-
 linux-user/ppc/target_proc.h | 91 +++++++++++++++++++++++++++++++++-
 linux-user/syscall.c         | 38 ++++++++++++++
 linux-user/xtensa/signal.c   | 96 +++++++++++++++++++++++++++++++++---
 target/xtensa/cpu.h          |  4 ++
 target/xtensa/fpu_helper.c   | 71 ++++++++++++++------------
 6 files changed, 261 insertions(+), 41 deletions(-)

-- 
2.54.0


