Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85D606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=e3Lz/iaZ;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=7UZxGJ94
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWYR-0007Ng-SX; Sun, 01 Nov 2026 09:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX7-0006aa-BE
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:42 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX5-00084M-6C
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=DIVO53f
 iuxuSk0UsKVKh1RkTwl9WVbNk80jwyfUYJAz4RvT8wZuRB2tCl1m39Xus+/kvljGgmHhHF
 JfLuW0lOXxpYbsqj6Sj3j6ZZGBvYDmoaYvTMAJyTtuCabc02TZDZaSBohzHBdfeqEfDQXl
 nep7ScN1REHOhpQlX1xsf7Av3a79gZusnwJtSZI9zMyA1gnym+o6sl812NWFsYn+6G3M/O
 T2kMiFoder90lChVfQHUU0c/+tXU6Yjy3qgur+qbuIg52044WZKDO6w9S7bAm5ugXXcUtg
 N54+d8Hxe9CBDz/z61Cr6m+bI8kYiKxOlE6KbJkcNjGnv0NgYEWmZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=A
 vQqO9B+9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=YDTuof4yHal1On0PcSDvRJQBf6VAmdGx2QXNqr/JHuga3rsctjUkB5tWVzyBkvmzs0T3
 LxlKqDVKBJnSbqlHNEXNCE4ky4RwBYg6+QXjUpGmc1S6RgiWgAMSByxkXZQ4lyS0JMUTN1
 AUlfLApo7e+mzieCi1qYPXmbkOuYDDaoKRSLyOvMW6nn+WAZuStl4efxtEKc1IZEVuvMI9
 JWAnRi+IfHb5fVYO5eZLRdg9WLbMNzYrnRDHkesDXfRTsGIURGQvaH8SWpi1qf/VkbRJ3N
 J+rr/QYWa3WSGaOKJy4MYbBWstI+/mWde1HtxGZqHH/PuZ5dVQBK+7YzrTpFZbMw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=e3Lz/iaZ; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=7UZxGJ94;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=AvQqO9B+
 9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=e3Lz/iaZSPUCEVBW3YHq+T6LWiIddPeT5xI
 NR8omWDtTkZaX9SUfSrPIRnExppOMKMggwGVpeXx/FhIVU5dKgmMGx4vf4JMvTRXREFPm0
 WKAa/11xM2OSAljab5NiOthYMWyWHw750FOVPOX23fkhuJ/TJEUHnBaMb4qCAWMt0hu/bj
 u0s4r1WLyXZMK5MdPK2AT0O2nuGs7M6sIF5Tf+G9B1fgoZGcNKU4eHyg3BYThXIqgPze1J
 mkuXy+N/HlayS3ksvf7YldDy/FYL6ALOm9ALlMP69CNUvGkfHzslhtlJ1DXA9uLNZbILII
 PjYlBwYoeVZAlOBKGLPzA/s668w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=AvQqO9B+9z2wC4qqJ1AjC6Gj8Wd5bz4fjkAepdoqxqo=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=7UZxGJ94gxUMXJG05Z
 rx4DRc5luO6wJrgq4EbBDTbk2u74f98WWlIlDDzod7HELswE6iEzs5SO4M2tY8AqmbAg==
Received: by mx1.catap.net (OpenSMTPD) id 08a3f56b;
 Sun, 1 Nov 2026 15:27:33 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 77b3ed00;
 Sun, 1 Nov 2026 15:27:30 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 03/26] target/mips: drop hidden TLB shadowing for tlbwr
Date: Sun,  1 Nov 2026 15:23:19 +0100
Message-ID: <20261101142723.41346-4-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
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


