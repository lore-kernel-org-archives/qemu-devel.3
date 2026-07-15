Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B1CC4450E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzv7-0005ai-9V; Wed, 15 Jul 2026 09:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv3-0005YI-O1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:01 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv1-0007u3-Nc
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ts6aM0m
 WcFLIi/+Jxj9p5mWm/B1sUdsH1lOiEf17h0lakknpm5EDogN93+kdMw2oQGWAK+Bl7w8VD
 40PgvCtbWGznGVt1/MbtXev8fvJvWjJe+2o9Li/7OMvVZw9uO5GfsGhYfVumuSvR/e858w
 +9mxh/5XPRGLo6NIEdlwPxe9ojDKPVexNQkYHS0voAxpq0botncbb5JfFZQatz2mdx3r22
 FnyaZSGW4dYWGDRuJlloi+Au9gubmKa036sXZJxGmIwaEsMtIR9XWZqh6SA1Nt2GVb45dX
 kTPfaeMGh0ahn3NU4VaRHqRWbQbw+KovnTRvm6XX4Jas/jznjB3Q/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=3
 MLQZQuX57ziRIMf9bNLKRlOE2JdgNKjvbZaASZXHtQ=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=q76iLWIdO9IOgSMhtVEmzPBoapWpDzlG67L+XeCHWZjMT1imZQ26ob84k4ap1ZRLKMTX
 JW2xQBYwOYL+dHp6GSpz7+p0bEY+MOIhvLmvLiDBcpnQKUn1+EqVZ5l1Z735qOx7+m+14y
 sZsMxX7WCfESNFuOT66QTWVZ09UZZKEM0iwoj9v+4bEAql04xBlWltAg+e/TmPvCRFWEva
 1Y+Z3xyxP1CbZCawm7f6JtbOC+efFp2YRY6HOhgUUsPqVnSVdBGTFFP5nNUE9HRDZ1rGxa
 2aWKLAuG74rQ8UmIyUG97W40FrNiyD7MV/aJ3KDIHGmLd+L/9UFABL7q9Wbkw3Sw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=m/ycMag2; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=d7/Zx56Q;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=3MLQZQuX
 57ziRIMf9bNLKRlOE2JdgNKjvbZaASZXHtQ=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=m/ycMag23WG3gAu9TUqNvts2XOxpx6CChgG
 m82oNjw9aV87hYOA7txnAW/Oy+LME70gxe/vdiN/uGPbSdS0/GNSWs5fkSs6jI3b9j6L5l
 ESmzbJa5edwpJouNzoWp72EEAEWICwgyKpa1qHiZmLLSOCObPzXR+onUvy5xMq7ryvXOwS
 p7KM4NVhwgbZUb4mq1Pi0lBenl5kN4pE4JEKxInJpvCudsWbOK/i/rSasciN39oqjBqJ0Q
 AiZuJrNuIq7aA+6SMY2uUvSAqxV1yPFlu/xS7HvE6ANr26LCRfCQVJNmmLtAqrcU0dXp8x
 d9GC/oZZ5iaKY4RHuQikINRK9xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=3MLQZQuX57ziRIMf9bNLKRlOE2JdgNKjvbZaASZXHtQ=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=d7/Zx56QqUiFjcYz/f
 934aB2Z+dJi/JWfSrPa9wBmQjmyy2TRVJf8mzpumY4Zf+Jz9UHaycB3pBxFwRe+zlVAg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 8722d684
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:51 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 49fd2b21;
 Wed, 15 Jul 2026 15:44:49 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 07/25] target/mips: allow Octeon unaligned accesses
Date: Wed, 15 Jul 2026 15:43:53 +0200
Message-ID: <20260715134447.56007-8-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Octeon firmware performs unaligned memory accesses during early DDR
setup.

Use QEMU's unaligned memory operation mode for Octeon translations,
matching the existing treatment for MIPS R6 and Loongson3A.
---
 target/mips/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 123ba6aecd..d83f76e514 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15193,6 +15193,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #endif
     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
+                                  INSN_OCTEON |
                                   INSN_LOONGSON3A))) ? MO_UNALN : MO_ALIGN;
     if (tb_flags & TB_FLAG_MIPS_FIXADE) {
         ctx->default_tcg_memop_mask = MO_UNALN;
-- 
2.54.0


