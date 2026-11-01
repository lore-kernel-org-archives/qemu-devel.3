Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F4606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=r1hYEtMJ;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=Lvxj+fVi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWXQ-0006ff-0u; Sun, 01 Nov 2026 09:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX9-0006bd-FH
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:46 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX6-000849-Fu
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=LceOrDr
 Mc6iL9J4KSRJXDK8ruEQqfuRlSXF5UmCsSkaX+tBRDCGRWd/HPOc0tWJpjt4w62HK3wLVS
 Y1w9sTC7HvupotA5xKR2uxk6ZCQgFHD7QZeB74Lmly+E+cp+zuDzb7Nspd1Z5u9fGDErQv
 zKs4MXXWMMIwv2JlczVgbk2sHXbHitpsxkojQAX+zx7nX3H3hMeidNtBdceSrjs8H7iabF
 exJy+hpA4VjWd4T7bmM/d8sYH6GXEqt2pa2EMDKwBmUXGiyd3fbkSD0Iv7eGrXf23SklnV
 L4HHJkbFv7ByYY6dBdDYIhf1MoO/hocE+63PAIDxNGci2lYjtqlQGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=x
 FxBLW/Dcz3qV/PjurtMccA1U5uz7AHLSX7kd5Ieggg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=tiqI8nzLqMkCxnOCJ7WR7KJZgVEQr4ibtIEKWv6M3zAa/bFUWXtO2mVtRGZprQlAy9Dk
 w/zR4+WO/1MH3wWnKoFEdVbZhJi+cdlH8Jcoprd7I8RSTN640mxplQouKLok2hVQrDNR2s
 UxPIDU8wrXaIj9UNXcd4ce4axmWlDOiV9bWl+qCqvzEH4lc35VIsdr1vUA5DSIsLphVmiR
 g6acY94xrmQkOun1kEPzsEhsNxRPvc17LjGhEhziap5hgW7zGh8Odid7us62bOpSD0WzJi
 f2ZdOiMzEkfarxEqVxxuakjKHPdC7ae+XuMEs2nqGN52LdK5JufKGzVAfQhJ5LtA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=r1hYEtMJ; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=Lvxj+fVi;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=xFxBLW/D
 cz3qV/PjurtMccA1U5uz7AHLSX7kd5Ieggg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=r1hYEtMJffnCbCYIEgXihJqrg8q71/hnHis
 4nksTQ34inNvivnHvgQxPaptR+WeSM5Y7axIjWzL6r0Dpn7Yq622PYX6DQURvmHWdo/Jmq
 MgXjmG81+J5Ua7xBvJHjG9HZHQGTSLdxtKwBV4ZtYE0AJkx76j8TtcuUuqZHlmoHWYcS+W
 mfYwP8LPv9rqNtykiCHUTOIRU/P3mXTd2hIjQgaOxIlnqfZtOH1leaERt2P9+dn28OKBwj
 V4Kl87DjCf9ECo1ttocw7/wRuf7hZvj7Dd9ygrVeDsu3zYE22cTiNCytxIXzLK+yKxxflr
 J/BpJ9gCe+DgG7x4fvefV5bifLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=xFxBLW/Dcz3qV/PjurtMccA1U5uz7AHLSX7kd5Ieggg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=Lvxj+fVi+dLZJP6yoh
 wlxit9PdhOnJWa2jzR6B6iqWiRb/osPwIyO3tjF2aXjZ/ZmUWeCvMmX3gNeTLuuNu6BA==
Received: by mx2.catap.net (OpenSMTPD) id 157d1895;
 Sun, 1 Nov 2026 15:27:35 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id e7264556;
 Sun, 1 Nov 2026 15:27:31 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 08/26] target/mips: allow Octeon unaligned accesses
Date: Sun,  1 Nov 2026 15:23:24 +0100
Message-ID: <20261101142723.41346-9-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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


