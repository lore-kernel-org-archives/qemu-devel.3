Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D195606A8A2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=OL78rF9H;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=el1P6dgw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzAA-000050-A4; Fri, 13 Nov 2026 16:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9c-00084E-C0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:52 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9a-0005Q1-NE
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=vk+fEfD
 LUdQvnarBSPHkwf9Xfutd9fR2/IVM1SczrXMcWO8tMY4dFlzCvifg2EhfVoZEl7FIqdahG
 NmfTfTLI1kVf5Y4NczcjAI/jjO4Kx/5zb++Q1hJz/oaUSMRECw6U5adQZyQ78gzvt1zJOY
 Dw2If9j3b/k412pbI/9zWArDtXWrUw7yps0BBy/Veb/+lx7nT+no12BUJWBYUNmQrh9112
 HlnaO4gHzVxHLSRVkqGf+Ee8qwe/ikttPwk6JEtuhelIvWknxZXWS7s/11K4RPnjh8Dn0a
 FxWu+qHQFPME0J25ZO6hIeRqLPqhNOAPq4DhVgcQQ+rU44q+cApt2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=F
 qvOgCmIkDQqxhYnE9RyFGvpOPch56C2DtN0DyG37eI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=UIjh+PGSElXyjnvjBEYonLM17+nq2ifyaobExu+gSaViBHoS7e40yCDstbXetTRNOiCT
 arC4eNjb7j3P5NbiQYs6+Ab1cQmV4uakwOEME6LLWpmAVHnBbL5aFacKh2sK89KLKSWjvt
 5EAz3ss0UW8EPbV5ItbZyA/TBWe40/8yF1xHkwdQxhYT8zmz+htyXqnpw8VHIsD30sTRQs
 GcsAJy6vhWHQo7Obs6fkj+xbjkG79f9+IEKdHLv6TJIIX0XAu+2CN6A9Yklw1HJZgw2+hD
 5Wowtqbj46pBhAa284vuCEfwJuVIep4w6cFD1rD4tsjYt3VqOoWD24Vy3/BXd/aQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=OL78rF9H; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=el1P6dgw;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=FqvOgCmI
 kDQqxhYnE9RyFGvpOPch56C2DtN0DyG37eI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=OL78rF9H1xoGLC0lLnsBmiUB8T76RdTSNhy
 sFBJLGXu5rsV/AoCfrOgddZOmNnpaUE9uerpdyZ9kPssaRv4xbgUj5+KFAgttYzkBxvoP/
 TJKTD9lXiNIUKc9t+u0Teiyo8WtNI96Q0Q+a+oAGYZ2yEzIFgxZMCacwt222pCiSBxCZMm
 7N3HccE2GbznfdxTVTbSzwyE0qgILgaFiMc0n5lKTZjj+Ygk8NueM1zxEFi8IznbkScLwP
 /71zzLxDNZO74LQc6x2jle4Lc1/HPwaBMAUtgYNRM5BGsASs9PyAbpyixJUi7+7ssAduEQ
 WHwRtxghc3kGtJWF4jPxkcWfXDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=FqvOgCmIkDQqxhYnE9RyFGvpOPch56C2DtN0DyG37eI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=el1P6dgwhTKNiQUgIG
 f35II7Q9PqVQfgMP0luZbh2Gk3l0QGpZKiAdXO/uj9+NfROx2WnVAAe+KQsEusgRebDQ==
Received: by mx2.catap.net (OpenSMTPD) id 1ded1389;
 Fri, 13 Nov 2026 22:49:48 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 6446287a;
 Fri, 13 Nov 2026 22:49:32 +0100 (CET)
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
Subject: [PATCH v8 03/26] target/mips: drop hidden TLB shadowing for tlbwr
Date: Fri, 13 Nov 2026 22:45:17 +0100
Message-ID: <20261113214926.98536-4-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
References: <20261113214926.98536-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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


