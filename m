Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D25C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 08:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI13D-0007Un-13; Thu, 22 May 2025 04:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI13A-0007UP-Az
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:12 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI137-0003Nk-Nz
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 93F5E5C5514;
 Thu, 22 May 2025 08:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE1C4CEE4;
 Thu, 22 May 2025 08:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747901585;
 bh=N+DQ+pR1em6xpH5TCOPxkT8VXFrneNJacq1D1+zGELM=;
 h=From:To:Cc:Subject:Date:From;
 b=OFmnRLIu0VSJGUgCx+ibAfY4JhtFAdPMMCxAwppzoj9brb1Ifq6U4WDflhux+1HFr
 FGm4rt4sc0Lsdm7neybrr3MT/qzB9bJWye+9oEwPBfbDVx9qy/LGpUYXhZVtHgq07V
 WgpBJZN/N1A+YfEfbZRkFIdpjuW2dDXZtwTDs6O+FZ1KoTNE4I1aSSfLd9LKxgBXrT
 /1oLTo7AOcC1S+knN/Rgdb4kGbaM63BaJvYtdP0/f3c7Zqr6XQ1StnijZllFAob+jn
 4CETbeaWr4lddT393BOTn9YO5vRD1aysLMyFKDXN7fY+G9wvBC8FcAFE4jsrpJ69v5
 cwbH2fgU81aXg==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/3] HPPA FPE fixup patches
Date: Thu, 22 May 2025 10:12:54 +0200
Message-ID: <20250522081257.3409-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

The following changes since commit 7c949c53e936aa3a658d84ab53bae5cadaa5d59c:

  Update version for the v10.0.0 release (2025-04-22 09:32:33 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-fpe-fixup-pull-request

for you to fetch changes up to ebd394948de4e868cb8fc5b265a8a18f0935dce1:

  target/hppa: Fix FPE exceptions (2025-05-17 13:52:40 +0200)

----------------------------------------------------------------
HPPA floating point exception handling fixes

Fixes and improvements in the floating point exception
handling in the hppa system and user emulation.

----------------------------------------------------------------

Helge Deller (3):
  target/hppa: Copy instruction code into fr1 on FPU assist fault
  linux-user/hppa: Send proper si_code on SIGFPE exception
  target/hppa: Fix FPE exceptions

 linux-user/hppa/cpu_loop.c | 12 ++++++++++--
 target/hppa/fpu_helper.c   | 20 +++++++++++++++++---
 target/hppa/int_helper.c   |  4 ++++
 3 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.47.0


