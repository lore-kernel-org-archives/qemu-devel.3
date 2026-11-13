Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD499606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=vFVGzTWo;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=YFTbZLmo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzAU-0001Wj-0U; Fri, 13 Nov 2026 16:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9h-0008BZ-FN
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:59 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9f-0005Cz-P2
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=L/utdQ2
 YbeAHLDoKwMDA9gHtff7XS8a7CPJ3T3B2WFaiSni89AvIV9Pk1DnO+NRTIiyLSp1PRpEBp
 uCCXLI28Fd81tILu0fmFyGiTXOei99cLG0FGF0rnCZFT8UT4gxkgfOS7zOX3NAJCsyelir
 BVeW3sEr4HOmFrhL1Bl7BSNWoIA5M8W3dHHDz5dO0IwhMS68lcotRZAsnqrYhQKxG/EGCh
 ny8hCKX8dkiBsYJNjj2dgEjpOrEdwVJKJlNMTktc68oCtruIaQ8fXk1JlX5gYUm0HrXtdb
 l6eoLUsKOf3VRLYSFWqLIl9O6mNm2Nog1ZlIIcYX8N5RRIOOzaN5aIA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=E
 XtxmjxRjywOGfgMVk2aytYI6QwoCbqfbJ2OEYNn/ek=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=xDJBWFrVKAW6nlK0Ck/TvaeDKxQ9PpDoze+8ebTC/RPjIMm1/R63RaHadZ38Yd1URkrJ
 BPT6kZ2pZYi4Jf2Dfw9INVwYA9lchJg6PyfBTm7Wm8W/tRy1UJtiRvpDLDmbsNXpDQjwpW
 VlCvSZh8lFaXkS8PwNDuvoLzPzRKwDc5WyXU4JzUl0MJ14RqyPQzEGhqKIX0+5vCQbmyjc
 UuQe55MiJmTlwfLBMT6LQHtYs/T0tQfX3sW0XV3AH5We9dTCPIek44MuJIRPOIua//AQFs
 hT418b5eZWegUkyb4YaBs3z/zZ9hrj9rhH6UAyyhJGSrnoZNFQUWhtAlQYtHY9mg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=vFVGzTWo; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=YFTbZLmo;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=EXtxmjxR
 jywOGfgMVk2aytYI6QwoCbqfbJ2OEYNn/ek=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=vFVGzTWou191oADacqpbYBFK5WiJH4KzkO5
 QqV+cwYrA103Ejb4Ovjq46ztEIO3sjAXtzlFXIrQGfvxmyDCnDF0lR0xnBCJLFdOstv7u8
 jmTsiRhQNU6utvcriDNgJERB7FoCdiUnPj4ZzZ1yb7MhpPVfiN6NILd6bHVwSHKh6HA+je
 Rj59eB1KjtIbBjH3bf3dccsa5oG/b4j8QwgQ4epe+J1bSbXymA4OyrgCus5FC/imkKa1vw
 uGn5Ix1e+l3f4AntBdDB6xjNxO7x80+rplqnJOB5or5GVi7/AwM+qYmophe7f7EzEUsVzE
 Nnci3/uSdwckAVlMbBmrZ19+tWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=EXtxmjxRjywOGfgMVk2aytYI6QwoCbqfbJ2OEYNn/ek=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=YFTbZLmoOpTuuyeKDL
 0jjVUc5aAL8jzzx3Z4XUpbe9cZZipmYD2jy5tFexYL3qkxMuhqCFiyqE+NY4EVBjazCg==
Received: by mx1.catap.net (OpenSMTPD) id dc5831be;
 Fri, 13 Nov 2026 22:49:49 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id f17ce7de;
 Fri, 13 Nov 2026 22:49:33 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v8 07/26] target/mips: accept Octeon PageMask encodings
Date: Fri, 13 Nov 2026 22:45:21 +0100
Message-ID: <20261113214926.98536-8-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
References: <20261113214926.98536-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

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
index dd4f06bd8e..e71c41aee4 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -885,11 +885,17 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
 uint32_t compute_pagemask(const CPUMIPSState *env, uint32_t val)
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


