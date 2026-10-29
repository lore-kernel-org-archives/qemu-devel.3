Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E265606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=nv1nkAbq;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=Z08XilVt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1B-0008DJ-13; Thu, 29 Oct 2026 16:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0y-00088p-2q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:24 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0w-0007U3-Fj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=bHEI0JG
 uZdjRR5EPT8ryWyhIvZkyr1iM0k6ueCKVnWiHKs9BTkwdgSKAjU0NToYZaPjT8KvB5qM4p
 HBilZy6kpRKZCJWemH/yAuDiJSzji+dv+x7pJSIuS+2TKSQdV8wA0e9We2GemfzPfCiGHb
 bWL/JMJQO+cf5n4/2QBpe6+jY1hfpXuEuFeBkthkULd21ewDIH7T/17+zXZQVtN23qinXX
 dt9kpahFnD0GUZxT1oQu9AKitNSsberd/qXbgrjLzB0gJgFGp0Rqb/dtvq/Gx9WeHfU3aY
 jMTkSaOXKwkNPQGhzIcIRL6KEONgxqn0ReqcMAX2DKWouK2XhDwnN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=N
 so+m+B+gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=fTaEMkz+ONTtxlkCXRRvrqZXGbEOSkUVf6kBUOoD2sa2rqtUoB5GKhSCeRJ6IakDt7Kb
 7/N7o5Rzzl4jnjOiGkSjQcbIcbHFOX5w9L7MmlgsmQ1i1vqjqAEClp6lNNJMlHl04butom
 sGWhnsyM+crGiz5tsOJOytOGGFpymRmY8hAe9cUiCO6RlLmclqhsWy6cpHio+ePlHWBv7p
 bjkBwdEJ8/ec3vf5+itAztYsehE7ZoLZMACe7Ex7aOeXs1huvk6hS/frlQfjJwHv/bLkNv
 PeNAZG6rL0K+dNX38PR7BTitIIe6P3KBhjKsg6+YI7ZgEZ0K6Y/ksL7FznaUa4Hg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=nv1nkAbq; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=Z08XilVt;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Nso+m+B+
 gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=nv1nkAbqXBNEEwZbeoI+dzLyxIpedruaDeR
 KosBAW5ts7XBtrRtUffa5vw4xIu22RL+LFdBOT3otNRCC34F141eQVX9G75uY1/ISir87l
 TqcaGk8AT2bbrH4SWEjcPmTvj4SGT3JDV7YNUiROhMsnJ/4W2ulTOlbHbSMy/rE0e4qN0U
 dHcgVAoEVr6OeN/ON8epeIxRB8bn8r18onimqtmkXigtYs5hfe82jYSIiLE188eQGvDspq
 voPnyMVKYVxOvobBba5C/HqqTR63CvvM/SZFaQiuFxaFZF3x5bZaNwr4qBZqFcq0AqImMF
 n4scsg2dJHzD4wBlpFcvG7jzibw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Nso+m+B+gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=Z08XilVtauge8ucYEn
 29pJwWVwfAdf/YM1kHiQeIqztfUV19GMcgoEN0BiO5YvdiofcC9R/xgNxIOWw0ftDSCA==
Received: by mx1.catap.net (OpenSMTPD) id 1244e174;
 Thu, 29 Oct 2026 21:46:16 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 4f82416d;
 Thu, 29 Oct 2026 21:46:12 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 07/26] target/mips: accept Octeon PageMask encodings
Date: Thu, 29 Oct 2026 21:43:52 +0100
Message-ID: <20261029204609.38989-8-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Octeon firmware programs contiguous PageMask values that do not follow
the generic R4K even maskbits rule.

Keep the generic validation rule for other MIPS CPUs, while allowing
Octeon CPUs to use the contiguous masks accepted by hardware.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/system/cp0_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 3fc55314a8..9f7270d558 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -885,11 +885,17 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
 uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32(val, CP0PM_MASK, 16);
+    uint32_t mask = (env->insn_flags & INSN_OCTEON) ?
+                    val >> CP0PM_MASK : extract32(val, CP0PM_MASK, 16);
     int maskbits = cto32(mask);
 
-    /* Ensure no more set bit after first zero, and maskbits even. */
-    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
+    /*
+     * Generic R4K PageMask values use two mask bits per size step.
+     * Octeon accepts contiguous byte masks such as 0x003fffff for
+     * two 2 MiB pages.
+     */
+    if ((mask & (mask + 1)) == 0 &&
+        ((env->insn_flags & INSN_OCTEON) || maskbits % 2 == 0)) {
         return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
-- 
2.56.0


