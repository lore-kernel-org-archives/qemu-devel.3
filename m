Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB800606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=pSXnWGMt;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=YqBow/iT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX0z-0008A2-Ab; Thu, 29 Oct 2026 16:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0w-00086a-Bo
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:22 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0u-0007Tg-Mf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Hz/bYqA
 2YXPhYOV7oqXHgikNGaNgBJevgp1zD+LXlpDk1Be+BkWIGXMRS0HhPDuqEb2u5EqdmIztg
 Pl2qydWM6o/gz+p77iL7G+b2i+9UZWsoMo32c9dBZbVd/EsUGkVpRsbMK4bTZGL8z6yXX/
 2HsHrycZ63uOVfI11zEDP61jmauV8FG9GmdY4Lb1/Qjt2PD0OJD3s1ZwtwJe3xkHwmHzQF
 Ob3I9Ae+NFA1q8nYm7/Jht5qd4uP7t8Wn8qWLOpx06CFdo2IqlPTUlqGuDDYUM21KDhqcB
 Fp3qY39RuVhyzog0bTdbWUNYCXX8K4YCzkjDuSQg4Ffp0RUQqhK2yww==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=A
 vQqO9B+9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=gorpGj4xvF0TRS4glO5+2lUvjIn3rdVR3i8vWd9UyXsOBQOD6xo/4UBOnADimvKZTFJa
 fPflATGP4TqChxtBs6SHFbNZUnwyEu8WV30h+KNYP2Vn3ukWaNRFv/OBsgYtLl2SJSSFHU
 52lDP39MkTk+pdcIsae70EAKEYC1/f46UiWLZHJ4wuwlB81yeBUDY2f0Ge5X2lgHiVFEJd
 5tSCvqFHiyt47w8QDI9stFEKn7T4aIK2m0ERPZHXpHYpT/ncPeSzBJ7XgoMfT2QQNe4Yif
 Z13zGhej/2c8ckBKQIZXJLa7nE2RTWNk5vPz1v15z9dONQ5oOPTzG5L8Rnx43llg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=pSXnWGMt; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=YqBow/iT;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=AvQqO9B+
 9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=pSXnWGMtw+sk+hq+yi/NuYUp4JTbGX+M378
 y1UFGwrY+rNbYh0wUheSNorSLRO6lXLzBZaqhVv4p//BTN9Nm81WJ1u0lTG/js2yd/xb1X
 z1Hi9KPFujjBhiDdPsGn0nbwVnHwhK0EKgi7UZQiWGAV7SAcpPdMP2O2fkbrmJiLBVhuqJ
 hl7+KwPzARF9vC+yd7IPbW7Ltga9iP2Wo79HCFCwJj0TXHdXooUFkseF/JSP/kBw+xN43X
 qk5fyPlwMJ/7LBtbqx2PlzgVMfQe38wma2mEqVoZg1gI1580gDA9n1UMXJlVeNmZEmzt6e
 KfmNG+4tDtHoNShvL+iUgoX6WLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=AvQqO9B+9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=YqBow/iTQ3eGAZqavj
 iOjsxTR8zZT9PIjW6903bnka96AUKlQUcg1XaGo1YiaK/eZFZ3Ab9xjFoaSvIH++VIAg==
Received: by mx1.catap.net (OpenSMTPD) id 92953e56;
 Thu, 29 Oct 2026 21:46:15 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 9db7945f;
 Thu, 29 Oct 2026 21:46:12 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 03/26] target/mips: drop hidden TLB shadowing for tlbwr
Date: Thu, 29 Oct 2026 21:43:48 +0100
Message-ID: <20261029204609.38989-4-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
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
index 9e01c07609..08b978b3f5 100644
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
2.56.0


