Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948B606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=m23DhSUL;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=JQvDF/br
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9R5-0000zh-6x; Wed, 11 Nov 2026 09:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qw-0000sn-3u
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:20 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qu-0002P8-7y
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=vbzv6tX
 pP/j1TCrY02Ksp4F55wFLOftVm04MYTIX6u3lOkzebt7EgSo8FwLYFXjcAcgTYJ42yvJv5
 iJ0RDndq1SNr+Sataq0wCmfIgf99dfv1xENLffHn52i3EIecZmmJyCZQ+ZDn7V5078r3Iw
 WZbFKKWcshYKi+QEh9tXScapdu55bZbXkSg7AH+uThohepkSZV72HIf0vqfnQP5uW5yww/
 pbhyfss62GZdU7cETTRztAzhM9B4NUau5f4vTYDpI4ThLl9jD/02ovwxrERDtr0hcXq1UI
 hSKMxiMGDt8d2k4QqFr4k2ZCESbyg4UAMGdc6084ngqbfb2TEY6iwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=x
 3D6BlaKTou49KFSDgDVr1KT+cE7DCa/Z0LYFJ5vpow=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=thIbfVM8cOgRaW6w6pcMtfSavaW24g+sBD3XWZhJ41ClYqoSqE0TH79uzuvu28BkNSa1
 6EeN4oYBNpiEpZyBm8+AyH0cTXfa97xB+2iRAJ0uAqNGnqaI/F5SOVxiOzzlLgpJz+G8hi
 AdN6VIUfGJFBrIuOpV9rTIuI+VnCw7/Q8Mx5fsDC8bHPpN7Fen8I7GawwchpByRCZ37Hxm
 5rt+5/F5FVM6Wp13WBoW8Jkw2gK4kUyiBNe6FnQxO2C56J9Pe2CvFqWNL/lOi/O2KJ5mzb
 3VRn5qORLOfaOBnmiZbKjOBXzrA5YI3LeRajlBBUbxNVfK5bL9cCGbjZP6TC55jw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=m23DhSUL; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=JQvDF/br;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=x3D6BlaK
 Tou49KFSDgDVr1KT+cE7DCa/Z0LYFJ5vpow=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=m23DhSULqy+NpRnZ9oo+cMJZNWlWrAZqdm7
 NcZXZZyFNUhO2HdJwZImQddIXXXm6V8Jj8eZvRQ6jQR5uhgVrbFiHa6dbvWNxeeD+gDxQU
 HKc00VSpmbpuRox4R07skLxI9q2n9PEcTRlCvWCaSUDI3MK46Up5rOL21sJgKpFPJZqoyY
 ncZbnsSQDzRdUmyw0p05Ybtx6p8ozedl6HAVO+Z0Wm//CmEtS3FCnmnr3BKezHWJ9+3Vuc
 NcPiOwoTPJoo+jz42ErKkTEqrEMerEIZnpfAuerMFxY9bRA1sc66gHhWxw7xhSqnyKLobf
 AiZf0d8CHv8wqVcF2JLcEe0e7gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=x3D6BlaKTou49KFSDgDVr1KT+cE7DCa/Z0LYFJ5vpow=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=JQvDF/brDIpCK0Lx4t
 IWcnftwidsruDibmvzqPv0CeIQOYMFc8LkYF1ICvPvgWn7reHPNI7u9Lgno2brAXd3Dg==
Received: by mx2.catap.net (OpenSMTPD) id 51dd5997;
 Wed, 11 Nov 2026 15:36:06 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 2363cdbf;
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
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v7 08/26] target/mips: allow Octeon unaligned accesses
Date: Wed, 11 Nov 2026 15:32:08 +0100
Message-ID: <20261111143533.1775-9-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

Octeon firmware performs unaligned memory accesses during early DDR
setup.

Use QEMU's unaligned memory operation mode for Octeon translations,
matching the existing treatment for MIPS R6 and Loongson3A.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 0f89f76ac0..91d53d5108 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15208,6 +15208,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #endif
     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
+                                  INSN_OCTEON |
                                   INSN_LOONGSON3A))) ? MO_UNALN : MO_ALIGN;
     if (tb_flags & TB_FLAG_MIPS_FIXADE) {
         ctx->default_tcg_memop_mask = MO_UNALN;
-- 
2.56.0


