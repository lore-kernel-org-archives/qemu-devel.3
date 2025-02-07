Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1603AC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVXx-0005Rb-Ro; Fri, 07 Feb 2025 16:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXu-0005QX-R3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:55 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXt-0001u8-Ie
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:54 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id F2617A412EE;
 Fri,  7 Feb 2025 21:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A199C4CEE4;
 Fri,  7 Feb 2025 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738962352;
 bh=mrPagw6SSe5CTtRH8sceU9mjjwvokCW1bYWEL4Kbl3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qyjg8NnLzGMAgqPUwqtmFN+ePl0JFGY5W4DkPM5l+kHHVtXSPe+gdkb2xFyv2S9Xu
 6XMB7JwA3KjVbZjqYX5BadzCcgK9NADcqYXu3sH7hP1QJ909o0B4JIvrszMFH8X+dV
 2llEa663gXkDMmf1+J4HKVSgFUKrexRy40Tg29ZgSE+S7STKQ6b+QZ2YHPtG2yIkWz
 f6Jp+bqx85g5Qgi1sxbo6gbGrCBklN7fuphXM39DN4iYB0PxN/D9vlSNtx9NZZUc4i
 gyEc5dxrwBPNqai40p4JYVdHNrRGNsxTIm3FYqkiiA6U6AzQbvT+ebmiGQh/PUn5MM
 FXz32Jsi64mog==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 6/6] target/hppa: Update SeaBIOS-hppa
Date: Fri,  7 Feb 2025 22:05:40 +0100
Message-ID: <20250207210540.24594-7-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250207210540.24594-1-deller@kernel.org>
References: <20250207210540.24594-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Update to lastest SeaBIOS-hppa which sets up the
LMMIO range for the internal artist graphic card.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 roms/seabios-hppa | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 1c516b4813..3391c58096 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 1c516b481339f511d83a4afba9a48d1ac904e93e
+Subproject commit 3391c580960febcb9fa8f686f9666adaa462c349
-- 
2.47.0


