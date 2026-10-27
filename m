Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoOv0fte
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjWh-00087R-TI; Tue, 27 Oct 2026 11:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLjWY-000865-01
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:55:43 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLjWV-0005a4-Rh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:55:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0058060239;
 Tue, 27 Oct 2026 15:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E198F1F031E0;
 Tue, 27 Oct 2026 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793116530;
 bh=sdhmb5tmOBzROoVved/CFyQ1FY9/q6RErNf+wk2b9LY=;
 h=From:To:Cc:Subject:Date;
 b=UoOv0fteboZZio+yMFiKLzX7TMonskQzvuP+Nd2qdJh4tc8NZVol3mdytJflwd2bG
 7lduZz3qjl5nWzFCT6svhWB83b7me7ZGCg1GyoMgkUNatEsw6xhIGJEfSYty5u6cbs
 BEtnxju3zGhqpvax4PsiA9r9t5mhsBWodZWqYUOWk2e4XRp5SvJuWT9bP6ozEXLHK0
 2z9HCjJ44cqBQHFQlm1/jnoN7f95dw1SZIJ/7cLfbI3dvzD/zxyOecqnmfOFT675Bp
 GVGJNFT7MWSHcyIePdwYhiJnya66cuxdDRSffx2TfsVdjzkcmQTM1gmEEH65khoyH3
 t5LtxFw49I9lA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/2] Linux user next patches
Date: Tue, 27 Oct 2026 16:55:26 +0100
Message-ID: <20261027155528.5040-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:

  Merge tag 'pull-request-2026-10-22' of https://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 2b1b98f003325761b839b4bbd5af653416d05f72:

  linux-user: Use QemuSemaphore to wait for clone child thread (2026-10-24 17:44:48 +0200)

----------------------------------------------------------------
linux user patches

Two patches from Peter Maydell for linux-user:
One fixes the signal context on loongarch64 and the other replaces an old
pthread implementation by an QemuSemaphore implementation which better mimics
the wanted semantics.

----------------------------------------------------------------

Peter Maydell (2):
  linux-user/loongarch64: In extframe_alloc, align before subtracting
    sctx_info size
  linux-user: Use QemuSemaphore to wait for clone child thread

 linux-user/loongarch64/signal.c |  3 ++-
 linux-user/syscall.c            | 17 +++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)

-- 
2.54.0


