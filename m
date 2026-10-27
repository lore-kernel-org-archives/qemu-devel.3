Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E97606A328
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=YwgmDvnp;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=T4X7Fh/D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLehf-0006H9-AF; Tue, 27 Oct 2026 06:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg1-0005N0-Te
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:11 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg0-0007wO-5b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=YER18Mk
 WRB+h7e1355nm7E42ZXFtx0nFFYySBlaLxry42LsaqwOtT4EhvDePSGYGaigK0qP1RagdT
 C9oodUVvLBFaD6C4b4I6TnAQS3K/t+sXgboOnBvRR0zhERVY5A0RjE/c43hrlx576rwPsd
 MHlYbm1GIGaHKcaEznQ2skNCHLetLUi2LiSFHXKjZ33Kx8YYK07O64EMKRnlzYflg4DvaS
 CVapxsvGH6HxxTPtRFEErqVsE6lG42USq4NfP8rgHXek1EF76SYDd8t1TPcZq+h1YyIshp
 +GPplHKLxQWROerJyl23lluOrB+ix8TVVCM3tTpU7gGONdXYGjjCo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=8
 lKMphOpb3SOSSGq4ZfqUsEvrJ/g1YVr07z4O+qVTaw=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Y32aczl0/tg0AvZZv+vshSupCMA17yGXdF39rXVa+WP6ZCAI13JnqmPx6FiFakpX+GrY
 iJOccYp63tUqxmgbyGXKFl8/TWS7/zWau2pXVM1pVp2dPp3X64RlPgQSGsRT0dYsUGMoon
 SYNM99X2dIndJWW8/qsGJjRSz78tuyak2nBdx2GN73KK8WevFvRYmDLuhg779lOpFGW8pr
 FOsPoRd8iJI0KTzAKopmiPztC5M4Xj2bYlFvICArlUiTjjP/0SsW0PDiTWeXVQKW0pDq0C
 JFhyPp7r3hzUzh2hdI3SNqJkxuES4ywBpWcbilpo6Rj/Q4KuBh5SyCay94/K78+g==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=YwgmDvnp; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=T4X7Fh/D;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=8lKMphOp
 b3SOSSGq4ZfqUsEvrJ/g1YVr07z4O+qVTaw=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=YwgmDvnpX/vNbsHbL8bw5iwTqbMVHfuP4Ye
 vOFQwPVqHdjm9mnsYCRi+pg61z6VDL8tk+9vOmK0V56R0Vn6XrHpb80+8Ap0yZ+VsMeeQF
 GIrSwCwMWwrW/rqXQLpGEdWl41VYKOT0SCEwL0y7x/CDw97Wf+1MimWEjcJkHmqgssW1nP
 pnrepfLxlafc0phYRDSiqiQZkLfwffKq6vo9j4KqtarfaRLjwrzlS7ptWxPkfWUmvkd2YF
 96x/EojO2p4bmQoefaqcMidjKdSvKcDAA5LU3vqeCvDLhQPzK+EIgVCyCTlMYJkFe6F9tR
 /k6ZoVbKzs7563lW6MBSv47OJFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=8lKMphOpb3SOSSGq4ZfqUsEvrJ/g1YVr07z4O+qVTaw=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=T4X7Fh/DepX38xQCmN
 fZOuOKXWGuiChQlaauZwiQGLoM1r2Kw+8SHkYdTLVsKStL8CF5T/7tVHgKrlkj8R/5Cg==
Received: by mx2.catap.net (OpenSMTPD) id cd4c87b7;
 Tue, 27 Oct 2026 11:44:56 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 20871e62;
 Tue, 27 Oct 2026 11:44:51 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 07/25] target/mips: allow Octeon unaligned accesses
Date: Tue, 27 Oct 2026 11:41:31 +0100
Message-ID: <20261027104433.25720-8-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Octeon firmware performs unaligned memory accesses during early DDR
setup.

Use QEMU's unaligned memory operation mode for Octeon translations,
matching the existing treatment for MIPS R6 and Loongson3A.
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


