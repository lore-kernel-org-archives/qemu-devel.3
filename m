Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7BFC25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5l-0006xY-CG; Sun, 26 May 2024 19:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5G-000627-2F; Sun, 26 May 2024 19:15:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5B-0003pt-Lw; Sun, 26 May 2024 19:15:21 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B3AFE4E64E4;
 Mon, 27 May 2024 01:13:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id i7rFnXj5rWfc; Mon, 27 May 2024 01:13:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C7DD24E642D; Mon, 27 May 2024 01:13:08 +0200 (CEST)
Message-Id: <cf3dca03400d059de3dab761b11439d38e71d621.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 32/43] target/ppc: Remove includes from mmu-book3s-v3.h
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:08 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Drop includes from header that is not needed by the header itself and
only include them from C files that really need it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-book3s-v3.h | 3 ---
 target/ppc/mmu-hash64.c    | 1 +
 target/ppc/mmu-radix64.c   | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 263ce55c1f..be66e26604 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -20,9 +20,6 @@
 #ifndef PPC_MMU_BOOK3S_V3_H
 #define PPC_MMU_BOOK3S_V3_H
 
-#include "mmu-hash64.h"
-#include "mmu-books.h"
-
 #ifndef CONFIG_USER_ONLY
 
 /*
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 7bc0323f26..5e1983e334 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -31,6 +31,7 @@
 #include "hw/hw.h"
 #include "internal.h"
 #include "mmu-book3s-v3.h"
+#include "mmu-books.h"
 #include "helper_regs.h"
 
 #ifdef CONFIG_TCG
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index cf9619e847..be7a45f254 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -28,6 +28,7 @@
 #include "internal.h"
 #include "mmu-radix64.h"
 #include "mmu-book3s-v3.h"
+#include "mmu-books.h"
 
 /* Radix Partition Table Entry Fields */
 #define PATE1_R_PRTB           0x0FFFFFFFFFFFF000
-- 
2.30.9


