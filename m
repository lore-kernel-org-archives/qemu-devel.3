Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B78606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=fiDAg/31;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=ZwpvrIeC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9R4-0000y9-Bf; Wed, 11 Nov 2026 09:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qq-0000qy-0o
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:12 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qn-00025i-La
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=jYwgglF
 lUQet9TOFdEentPZ1Hvl0NNcxlqN6ihTxV8u2bQ7jnyoT2ebvB9F6Z7WRATf1j6axxERVZ
 uMIO5MXaFKjYLqNtsEk0sZlM1ILDgfY4pFe4f/XT8EnDdJi0BrcRFjfU2spbxxRgSInYc4
 pl+rTQZspZ5YwAmRW9ElN7PJ5wuUaekdLHbb+H+iTMgo9hIb1qDe2V2alKsa+KL8G9aZgK
 NsG9kBNJRtacG9cPI5lEoFdzgaidCx06dwTdpdkifutrQRofYwukDM9XZGLD2+uTwFWkTq
 8gN/or30jSdcnxwdpINrqQlP80WR5LBXPe0IYSMyk2TkCKWSVYrAdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=F
 qvOgCmIkDQqxhYnE9RyFGvpOPch56C2DtN0DyG37eI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=a9earqntG1TlwLyIH/sZJkUXTd3eI9OuvQtsGFPXBD9NPeAW5VRiEGBmJ/npr1fO2/fB
 hsi8YSNdKJMU84sRiEBlRhUxxVXd9Ruc6uEVbi22bezzWTLdmrUhdzlNCUK8nmo7GWCphw
 dYSWKG+otPoPoZjhb+Z75ar9exKNNA47DQcOnFreTLKpT6v+DYrwDTq86j+I1g43em48B4
 4ivi+teG0fPOnar+C+3e3Kp83esTnCgflm0fS0shpGbtydy8fvfMsiJqKHarMR6nk6Gqis
 /t4piP34UKU7dJucTbl6qpELlhLaqp7ntWdUlBEAP+e2lszHHkv9AuHyQWt9F4FQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=fiDAg/31; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ZwpvrIeC;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=FqvOgCmI
 kDQqxhYnE9RyFGvpOPch56C2DtN0DyG37eI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=fiDAg/31O9qHqdZBgstk3nYRtMd0YcO+cJ4
 kW23AVhXXDJNgfkKpHn5pAl4ex5QnjLguHHvDLCANn8X/fffArqApC8wc9EUwi+DGuZs+0
 dXW7GNc6iEBx24xYLEzDbDnoMsDWRRJjRFH3SirL4eh1MODlwrMlVEyAE+1F7obyiSUkt0
 YXL/76wF+gjfKpXs4Dk2SRIvnbuCjpIvjkXdpiSNX/aLc2l+ebjK+UD/T4JFLacAalkLVa
 y/eIjaClfl85VPpZZc0hnZotlxLA68e4XUHCBc2bIBnyxdgoF9u+59/eNHENQzMZER+ACF
 CzvJzwvFl94FoayueSHOBUZwuow==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=FqvOgCmIkDQqxhYnE9RyFGvpOPch56C2DtN0DyG37eI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ZwpvrIeCMQsj20xTai
 igBwWLDQjdAnJgluWSac6BcPx1MqiApLpbVjv61ejC+1G6RBQcg1XVEwH/YqjfVTmADw==
Received: by mx1.catap.net (OpenSMTPD) id 933cedea;
 Wed, 11 Nov 2026 15:36:02 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 8c686e8a;
 Wed, 11 Nov 2026 15:35:54 +0100 (CET)
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
Subject: [PATCH v7 03/26] target/mips: drop hidden TLB shadowing for tlbwr
Date: Wed, 11 Nov 2026 15:32:03 +0100
Message-ID: <20261111143533.1775-4-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/system/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 17d5340789..e9416d93a4 100644
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


