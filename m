Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93766606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=ziA1zKZ7;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=Yk2n8i9Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1B-0008Ds-Gw; Thu, 29 Oct 2026 16:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0y-00089N-Og
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:24 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0w-0007Tg-ND
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=cAZwxpV
 K4lQ7agMu6geSkTNyTWa1YP3nyad0cHs4ExMxeB9/VOtPjVyAT1lx8pyO9BDlLjbdaRUT0
 lV0erscnHe1+XYiyVb+/yJMUILE+mXh4wXKvcQIBBGk89KeB9u28jyUnNpdaPbu37YSaLt
 H51gzkr1DCEgBCzIRUL2P4kEpzpicm6gIZYwZzE0qBFcCrg5edY03LQNzfUWygYNUqESkD
 ykxJb+i+uynDD4siWw42bN6q8a3Ks4aareKdleLfEMvibpxOTVc2NfP/B0/ZOubvm+Gn97
 m1cmqx/6n7EXiygdWWBjl9xeKuiUnUFYcfnkzJ0s7VofepMrn7PJ5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=x
 FxBLW/Dcz3qV/PjurtMccA1U5uz7AHLSX7kd5Ieggg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=sOB8Vah1w/LIHVxTVA+e8lueCSXxGQFvQjdTH7FMMz8OP3nMbv91cRHYlRir9Dk8B9Pj
 5YO0N+XX1jst8q56cYKrb5oDzyQBxQc2KA2alpECXDX+VmoQVl48eHzTM+O5mYqbu5Hqz8
 MOJqLxeqeYBBhOpFlW5A4x5iweeoP0ctGAb/vqqzTqsAg2/VWClIhGE2XDdBad0am5EHNy
 muePxG+Z05dgADNYn1dZkmH+X/KxGEYGPWYdCgU8xdrbXivADtYrIxsZ1jqjgwpiFZLu3W
 RorHTYJDZpyLqyT38XPn7oNGpxlnyHVwsczcVlsr1etcRyIHwOcOTwnLdI+Nfkvg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ziA1zKZ7; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=Yk2n8i9Y;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=xFxBLW/D
 cz3qV/PjurtMccA1U5uz7AHLSX7kd5Ieggg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=ziA1zKZ7wz/iGo1Et5bONgRNbW5RFD4wAog
 skZ4KnBCCmeAowTKBgarJB9bHaC4YyyEqTnVZJWHEbaWDFhffgZJoQ6oxHA+DxW9Y9a8G+
 zsWF5epiWoH6HI4CkgBMxaaVyaAK/gqSXSNqB319XNGNlagrhyIsv3ILnuh145T2Lbm+Aw
 +NP8nCxYLjbpd1DSFMjDY/Gmw1K5jJTpZUB/7QlGPZkIQUmyYuVG3cy7IvQ0vDERV2MXT9
 mSvxk/bQZ5Cep0Icw4ocIev02iy1dKeD9RRE2O2k7tOKAFveGK+gsy3ZBB9l6aid9yoUs0
 xH9bE3xJTlPKQbEAXzaz+U937TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=xFxBLW/Dcz3qV/PjurtMccA1U5uz7AHLSX7kd5Ieggg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=Yk2n8i9YABwngD2fOz
 lsLXsSwBUpkHIYS3Iv5Fr0smYFWKCvbLYiYsLzfF2gDgg1z6AckgwbLv5OVpjhgOiEAQ==
Received: by mx1.catap.net (OpenSMTPD) id a979bdf2;
 Thu, 29 Oct 2026 21:46:16 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a824c846;
 Thu, 29 Oct 2026 21:46:12 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 08/26] target/mips: allow Octeon unaligned accesses
Date: Thu, 29 Oct 2026 21:43:53 +0100
Message-ID: <20261029204609.38989-9-kirill@korins.ky>
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

Octeon firmware performs unaligned memory accesses during early DDR
setup.

Use QEMU's unaligned memory operation mode for Octeon translations,
matching the existing treatment for MIPS R6 and Loongson3A.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 7996f35baa..94309915b2 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15194,6 +15194,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #endif
     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
+                                  INSN_OCTEON |
                                   INSN_LOONGSON3A))) ? MO_UNALN : MO_ALIGN;
     if (tb_flags & TB_FLAG_MIPS_FIXADE) {
         ctx->default_tcg_memop_mask = MO_UNALN;
-- 
2.56.0


