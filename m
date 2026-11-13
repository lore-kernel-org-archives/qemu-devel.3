Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179C606A33E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=ixQuMFDF;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=DV9r5JLD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzA9-0008WG-0S; Fri, 13 Nov 2026 16:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9g-0008BX-Fs
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:59 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9e-0005Q1-UN
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=iMKNUro
 /GRd7IOJhz7cHw5Ysu9jJG+TrWpoBJcqakeWiL3QoPGoByKZpGcRC5wCa9NDpTveQ92qHW
 ludeVd2NwvQks7p0HyzUL1ZZLaXffGl207A1IQK6KwktCaIUXjQ9cnqKE12dI3Zqk9qrZF
 AERx4za8vyoFzOXcCzaMzugettJbTn2MXg2vJzRMx/Vl5bFWHzE/2FNFVFbTkKAtFcEbKM
 xwbZJVPkm+PFgNQa4dLWfhAO6t0AOqM/IzfkSzJzwxu/gSO8xXCk7J85B0B1jw+34yEJUs
 iUcLSkt9x33U5hZ/VsJu7yOBkiqZA2RmYsFQ57qZUPD5iluatCC0yAg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=x
 3D6BlaKTou49KFSDgDVr1KT+cE7DCa/Z0LYFJ5vpow=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=syZ7GKF2yCC0Gs7y3RYTBVPrVwH7e9xuGbTe2EzBVpvfOUyVQcye5Ss2k5boj1ebWmi7
 s4DjqhTCnFZrzEPzMf1Txw+e6fln8pCO7us5MWAmPR/+hGqZgn3ClWIbGnuPLjr3wG+Oag
 kfMg7aDXdK/4oslNmMQHSI6Jd6m8haRvjuCfSjbOkxhOVpvhpMDPUXkpKQTDc2uQJWbULE
 5cxzFt3NzUTGHXb3ii8Fbz6zf8osMGsx2JL7k/U21EaR24PICswzON0NCvc/fnxXKcEjBq
 qIWYt0E1KB6CzYNioJNIU2GKFps1xN2NPSxOSKo7IR5EUE9uXd6RnrOEBFCJEwNw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ixQuMFDF; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=DV9r5JLD;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=x3D6BlaK
 Tou49KFSDgDVr1KT+cE7DCa/Z0LYFJ5vpow=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=ixQuMFDFY9vvbD9qw3IDTC2S+pwIT+fI0Vr
 Xshuq0dp4OxP77+XgawBYSh6u78mB7oy9D5Dh4dHEWZ5BIgZeBJjf56Q+D0hj5ZNjqkUEn
 vpFD8K2hGUVM4mvOlo+yPO+X+ssr+bzt24C1AoPUf4cdVNwzLlp2KrkGT8XGrtVN0R+n/p
 FS4O+1cQh+1Sdmf67CPMOoWa1797Cv0UNo4bEWO0ZsvTh4qRhxn7BukDoRjYLgtkHcb6G/
 MMuzLs4GhTYU1VzeI3QEo/MzAq4HUeLkn5XCcyb5c3E+46VuIVUQK8nEEHf+DK87z5Kg3a
 r2XuG2Cqgba0rV/IfyqnbU3yBwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=x3D6BlaKTou49KFSDgDVr1KT+cE7DCa/Z0LYFJ5vpow=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=DV9r5JLDYrY0E29n0k
 gEIbmB6Z31yOteWTo+6bNa/C/0t/57nZkOrTZLS/zlt0S5V+hhFZnWhi2/UIY26A2jAw==
Received: by mx2.catap.net (OpenSMTPD) id d4d98996;
 Fri, 13 Nov 2026 22:49:49 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 79834859;
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
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v8 08/26] target/mips: allow Octeon unaligned accesses
Date: Fri, 13 Nov 2026 22:45:22 +0100
Message-ID: <20261113214926.98536-9-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
References: <20261113214926.98536-1-kirill@korins.ky>
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


