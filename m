Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0BC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKbP-00018O-Ju; Fri, 07 Aug 2026 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbF-00014i-Uq
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbE-0007gU-1s
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:01 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F9316013A;
 Fri,  7 Aug 2026 13:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0801F000E9;
 Fri,  7 Aug 2026 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786109215;
 bh=xg8J8KhbQK9Q3W6PUzmGRzAJJXwqLIyJ1vTbPWCnsS4=;
 h=From:To:Cc:Subject:Date;
 b=bCRNiKsXoirp2EgX0pVsvcaqCuhOF+isrneBEfqtzXNJEcnPZrB5sG0k9+ymNsDWZ
 7SzYX+Ihqfb+UTRujV9eDHz5om8ljqIEtB4M2jlSlu9LB8j8PWFJZUl/p5R0P5tvrD
 LcfzNVdlnUQKpWpvFElqM/61PDpCHSZc+hlpkhhBnPKwhAWxX4srDfR3JlJkrnwOTj
 H//unj7JNMcqA40L5CgYiVAI+eWb4AvLnMUsuTFmkguGXd2T6zY1bjaXOBCrHLi3Nc
 qL2O5Pfnq1+qGnjcUs6bQMGT2j4sxUwwQxiqjzNa4fqfW5vNCyJfdu5rIBWhtXOoGV
 HKwN5fNeSCdhw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, deller@gmx.de,
 Laurent Vivier <laurent@vivier.eu>, Mikulas Patocka <mpatocka@redhat.com>
Subject: [PULL 0/3] Linux user patches
Date: Fri,  7 Aug 2026 15:26:49 +0200
Message-ID: <20260807132652.9687-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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

The following changes since commit 3e3ccab106f879b1512f8e0d51a827dd4de30e22:

  Update version for v11.1.0-rc3 release (2026-08-04 15:36:08 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to f7ad7b1f8c8148f39bc1f2c984bfc7b7c9c59041:

  linux-user/sh4: Fix crashes on signal delivery in conditional delay slot (2026-08-07 15:13:36 +0200)

----------------------------------------------------------------
linux-user sh4 signal patches

Three important small signal handling fixes for the sh4 architecture from
Mikulas Patocka.

----------------------------------------------------------------

Mikulas Patocka (3):
  linux-user/sh4: Deliver SIGILL on invalid instruction
  linux-user/sh4: Initialize the FPSCR register on signal
  linux-user/sh4: Fix crashes on signal delivery in conditional delay
    slot

 linux-user/sh4/cpu_loop.c | 7 +++++++
 linux-user/sh4/signal.c   | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.54.0


