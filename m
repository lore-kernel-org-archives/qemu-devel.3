Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E63CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRex-0002fE-Ta; Thu, 15 Oct 2026 16:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xHRet-0002eo-5W
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:02:35 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xHRer-0003Aw-Ex
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:02:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1642602C5;
 Thu, 15 Oct 2026 20:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEC11F000C4;
 Thu, 15 Oct 2026 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792094548;
 bh=HjYjrAeIaYSH4Zg5Z30tZIVBRf3Q/VI+XWDQhBzJybA=;
 h=From:To:Cc:Subject:Date;
 b=ZQgWQYkP+lrHENbbiiCeVKbhO5FU/XxhZ1Wd5TGwB2jCP7SzDzrGrxSf0CUTAMclR
 VRaGSySwCnlkiLG8wZVz5qBffT36tqlNoHTDaaB1s69CDGtRXdkWuYkUjMBiMVwgon
 fiNYaQ1A5bY7Zpy4eTit3muSmc9px+Nmx1ma3AGL9aYGGSwWeh+ESEQJ1avEQ5Vg2g
 VxADcPh+978B/HapYC5vNHfQ3iaD4d546B8kLp4v512MJuwk8idoXl6vYkWCIePcj+
 Ch1Op2GP+GL/jLHmEs5FkB0Rn8uxpdszBxKvz2XewaXwJtY58/gQnze5i2HjiK5Cdp
 a2rClmhrtMCIg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/2] Linux user next patches
Date: Thu, 15 Oct 2026 22:02:23 +0200
Message-ID: <20261015200225.6314-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The following changes since commit 8ee6c77176cfee03be0ec7665b6652b2f31f1531:

  Merge tag 'pull-ufs-20261012' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-10-13 22:01:07 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to fdd414709dea458794e03dc64b2495e579133ead:

  linux-user/riscv: preserve rs1 address for cbo.zero fault reporting (2026-10-14 21:16:41 +0200)

----------------------------------------------------------------
linux user patches

Two linus user patches:
- Show correct fault address on riscv
- Do not trash stderr on unhandled core dump, but instead log it into guest_errors log

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: don't print core dump message by default

wangyang (1):
  linux-user/riscv: preserve rs1 address for cbo.zero fault reporting

 accel/tcg/user-exec.c         |  7 ++++++-
 include/hw/core/cpu.h         |  2 ++
 linux-user/riscv/cpu_loop.c   |  3 +++
 linux-user/signal.c           |  4 ++--
 target/riscv/tcg/cpu_helper.c | 27 ++++++++++++++++++++++++---
 target/riscv/tcg/debug.c      |  3 +++
 target/riscv/tcg/op_helper.c  |  5 +++++
 7 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.54.0


