Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4C7C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcFU-0006IF-Tw; Thu, 27 Aug 2026 11:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFS-0006HG-MS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:38 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFQ-000181-SA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=LbBG++o
 fsdG9xAzRJrtUQ4WJ6uxCSrkkglYzNFtD3FG2CUwDWVGM2pqXxm4c11yhx+7zJDZjTrBvv
 XzTCOP+W/oRa3IoR73ZYdXvNe06LEkOgEI3wEQFO3K3/Nf50FTMELSxwdb/yo2kC7pYQIY
 CxQR9E4F2SRUn2kgdSwgiC6WuLQPXnCcErmYKb0Mgmm/67nPErzOWLz93im3jrs6xgZqnP
 +fMN7fQcjFEy6wiB9AahFc7HfUZTw2uAFozeX03RlqrUFlAug5pg3bmCXzdAoiGJvbrUjR
 2Cehh32fU8b6d+f50t8jDhRBTKRj+O8eEA3P8uZoKclwNO359APlpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=0
 OTWgZjx9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=fUji9AtA0PuKnAKnMfSgd6rdGDbn42XP7DUxdxbPhl8EvKSR3VovgihWFM5ih35FXPja
 d4S8WlCJedNCEJj4ieaNODwyGoJoNUczrhcZBSBqn/xgJDdvB9bIDxNhA9RKhYzC2bHAgF
 8lp8eaYL4Ed+AqNEtZARG7VxjBe1cHCJJ4fTODdu18dqdz+fYVLkWHj5/eP2QZb2DYjgjn
 LD25icMHxF96ne8YT1xgSkBWjWUqp0s51jjiS+mOVqn5h7UeVs9T4Y5fr0wFo5gApKR5DH
 fXFdmerEXIx5gRRbQ8gpEG3N+V9Ye/3Dd+N4YUAsTtc2edOEefgHMpHAXrrxhzZQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=wTLIYhKr; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ggvMntms;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=0OTWgZjx
 9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=wTLIYhKr15zcvJZBrtOH9KsW0s79CTBuUOn
 v9gEveBrIs8I5WuzOnvVot4uQFY/8CUtIcYeKpJdCpoXs+GIP2oFIjvY4QaV6X+5CILg9Q
 /EMpnuAm74WUq+9g4Sz3E1/WqUA/JNX2XQhxZNTrcS/o76mYWJ6HzWWj0u0xjury3pbqBx
 MVjd/N5c2B0G1JS8byz3tGRKnPgZQIjJaRymPy4bEvaPKaX1QjSo/gwwWi+LXdlNJNgysW
 7U7X1UYpQIr0zHkVAN2UZ+mkuyxAQ7b/lj1uRgjSBEIt4ffZ7NJi8aYcmvFGVTQu5i41h7
 uKDqHX3djvtqiGBCX4k1GlBIQ1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=0OTWgZjx9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ggvMntmsXKxLajyWIt
 ua5VtlKBlYwiAzb18Ml6kJ6T4T552AH11N2yjczZWwwFea9Q4Zl7Yf7POVVNc+rnJFAQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id b481d9c1
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:42:32 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a043a7e4;
 Thu, 27 Aug 2026 17:42:32 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 1/5] openpic: Preserve IRQs masked by CTPR
Date: Thu, 27 Aug 2026 17:41:13 +0200
Message-ID: <20260827154220.84845-2-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827154220.84845-1-kirill@korins.ky>
References: <20260827154220.84845-1-kirill@korins.ky>
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

OpenBSD exposes this by raising CTPR while handling interrupts. If an
edge remains pending when EOI lowers the servicing priority, QEMU
reasserts INT without checking CTPR; IACK then returns the spurious
vector and consumes the masked edge before CTPR permits delivery.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/intc/openpic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 99d2a1e65e..6f9a562163 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1033,8 +1033,9 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
         n_IRQ = IRQ_get_next(opp, &dst->raised);
         if (n_IRQ != -1) {
             src = &opp->src[n_IRQ];
-            if (s_IRQ == -1 ||
-                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
+            if (IVPR_PRIORITY(src->ivpr) > dst->ctpr &&
+                (s_IRQ == -1 ||
+                 IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
                 DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
                         idx, n_IRQ);
                 qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
@@ -1070,12 +1071,13 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
     }
 
     src = &opp->src[irq];
-    if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
-            !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
+    if (!(src->ivpr & IVPR_ACTIVITY_MASK)) {
         error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
                 __func__, irq, dst->ctpr, src->ivpr);
         openpic_update_irq(opp, irq);
         retval = opp->spve;
+    } else if (IVPR_PRIORITY(src->ivpr) <= dst->ctpr) {
+        return opp->spve;
     } else {
         /* IRQ enter servicing state */
         IRQ_setbit(&dst->servicing, irq);
-- 
2.55.0


