Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3090BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEiE-0000G2-Fk; Mon, 13 Jul 2026 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi3-0008Qi-88
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:27 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi1-00080G-6o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=w0SUyWf
 dUrBsqjIznC2CTeR4iTNV3SzUBHCTsZ4zdOzou3A0pc3UKvJ5GRFH3/OkmegyKK2Z1Wr29
 DqvZWegMUagF43H5wypz6/bL4Dba5O6LlYRZqEi8jE7V8wJmv5MM2KJB6MxM/Bk+EGaPq/
 RB7gWGwZGr1FU0h26CcTfTeaggIZ+OII2uJDI6fvnGlz9z8srnnSHddF8aQ1gHApdUcrie
 MlUSeovbTd2qOAE7pjCgtAOv9Wr+V1iPjJ+WD4b7HEwvf/+1tebDV5jMaodpqni8QUpfQq
 EVLy/Rjk4Fje+gc0UE5A5WIwDStamUJx258yhxz/ZOfVQgbdS7eLEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=N
 QW2Tp5UOyc0O7Lf6TEsWBk57ColeWZGG5gKNEPI2yo=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ism6jvdWl1jY8WY/Z66hxatl4FTbC5g69MZd4CN9hKftLIcIMAuQC0jGR9mkI8NMAwRV
 B42uE8//9a3Na6stkpm4d4Q2iAbJA+cDYhTYSHWUEUzImt37bm1rifq84X7om/7enIx7e4
 sIMgiL72X8PIzuYharMMPuG1kqu28e8SSxOmfCtL0HtzqI5Le450ObAUrJj2ME1G326dDm
 ZD52r0hRjZ4B3FssuhB2SSv9vrMTr8xa/CBbMd3SfaQFhiw2x4m1EHL3r3K1YdIHdwZHSd
 xIRsIuRL7NL1rqds42GT+vJlna8NH6WoMCrc71xrQ/XpCwyWmipdl71aJNuTIdEA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ikoK9ZIJ; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=a4/Fmk0U;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=NQW2Tp5U
 Oyc0O7Lf6TEsWBk57ColeWZGG5gKNEPI2yo=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=ikoK9ZIJgrMyYoeI2s23YKBwbRzcnA/COoq
 2YkfyxtSNOBT0JemtBUGDwKnmFi9jDXfpjX9wZ/Z8tF8Uq+kl19LvisIriSgnJC08+MY9c
 V6ImjZ2GhUFV7u0EWhLdsUnxQPayFOA1jhwQnnBxpyNZP74nML2A8fOCAy2hu3YY8sFrPh
 Wc4L/EN0iXaZVh/GnSDglU3NZi0DK3CY848QlSW0nldRExNEyla/yQ6Y1weDwxSZCu07KP
 5AL/BmBNy44FqSX0uKl0eLJw9847QSb8NUv9pRE+9yzQCm7yZPDlz/dUGl9Qz9va1gS4Pw
 h4SucBUK/aPdDuqrtEydPyQvhsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=NQW2Tp5UOyc0O7Lf6TEsWBk57ColeWZGG5gKNEPI2yo=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=a4/Fmk0UCjAAtGIykJ
 5k/6T/qZnZSnYp3rWfCkMw0f5jf3XoZLM9Y+DGftGbcr+NVTPoJ2VAi668a1ivxZv6BA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id f6712342
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 13 Jul 2026 13:20:16 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 5f29de08;
 Mon, 13 Jul 2026 13:20:14 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 4/9] target/mips: drop hidden TLB shadowing for tlbwr
Date: Mon, 13 Jul 2026 13:16:32 +0200
Message-ID: <20260713112004.4956-5-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713112004.4956-1-kirill@korins.ky>
References: <20260713112004.4956-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

tlbwr replaces a random architectural TLB entry. Once that happens, the
evicted entry must stop translating guest virtual addresses.

The current helper keeps the evicted entry in QEMU-only extra TLB state.
That makes the old mapping survive until some later operation discards
the extra entries. A guest can observe this directly by writing through
a TLB mapping, replacing that entry with tlbwr, and writing through the
old virtual address again.

Invalidate the replaced entry instead of shadowing it. This keeps the
translated TLB state aligned with the architectural TLB contents.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/tcg/system/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 9772df5d6c..4c0a25e622 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -165,7 +165,7 @@ static void r4k_helper_tlbwr(CPUMIPSState *env)
 {
     int r = cpu_mips_get_random(env);
 
-    r4k_invalidate_tlb(env, r, 1);
+    r4k_invalidate_tlb(env, r, 0);
     r4k_fill_tlb(env, r);
 }
 
-- 
2.54.0


