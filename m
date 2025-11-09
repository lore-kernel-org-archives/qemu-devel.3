Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10556CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDYw-0007c6-Is; Sun, 09 Nov 2025 17:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYu-0007aJ-Sl
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:04 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYs-0005sk-IE
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 20C79437E4;
 Sun,  9 Nov 2025 22:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBCFC4CEF8;
 Sun,  9 Nov 2025 22:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762726021;
 bh=RJJib2w6GC9LobFAqWjbssP3wkcGzztB3jlbcsTCuwo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I3w2uKoQXsPUBnh6nBAdqDytOzenM0/EJra2BfBzGUKkMmVqK/kxOZPdGP8dWWLoJ
 HVGMbHsbsk1y6vHXuM2EuB/Lx3y92yiqUa8pDeXGF3Or5LKDv2wAo4OC951wcm322Y
 sGrJ328Ey9DJYReBl41vKfHWGCCAb+3CxXpZnM8P61YuYo+8dlvEOqrWuSqWlvjKAZ
 nU+zx+ryqTUt3ETTFJCOi/H8FZPXz37G1ebCbPdsdQoaXU6VMWwZItuXIVRnXr7yTO
 tqsBcV9EGif0S2rMjb3OFZC+ZQMPzVL5LTIipU7zxoQZ4mTexLamgAesjGeaCtrjwE
 2u0g4VE48oERw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 2/7] ncr710: Drop leftover debug code
Date: Sun,  9 Nov 2025 23:06:49 +0100
Message-ID: <20251109220654.46718-3-deller@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109220654.46718-1-deller@kernel.org>
References: <20251109220654.46718-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

That code was part of some debugging code. Now it has no effect any
longer, so let's drop it.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index a35c41b67f..aaac31cbb9 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1361,11 +1361,6 @@ again:
         case PHASE_DI:
             s->waiting = NCR710_WAIT_DMA;
             ncr710_do_dma(s, 0);
-            if (s->waiting != NCR710_WAIT_NONE) {
-                /* Async - stop and wait */
-                break;
-            }
-            /* Sync - continue execution */
             break;
         case PHASE_CO:
             ncr710_do_command(s);
-- 
2.51.1


