Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C56606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jZTokAkx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJc6r-0005qi-Qb; Wed, 21 Oct 2026 15:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshit007k@gmail.com>)
 id 1xJc6q-0005o5-8p
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 15:36:24 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harshit007k@gmail.com>)
 id 1xJc6n-0000sF-Ab
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 15:36:23 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-14394530ec6so1427484c88.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792611380; x=1793216180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=21WVIi/PjHUROW6SHbbEbNpCKS+3a5GqVgwpiUZLdsY=;
 b=jZTokAkxa0AbTgHIIyj2YtEPaGuvVjV53sGFRQ8btBhHhjgKGD5AfWT/w0OqE6JeRz
 5F8kdn3kWuprI1ljAOvhzpTslJQQ+cNJ6T2pGSO/P3UyErkBbTXIDMGlo3YTBvnYWaYx
 MpBTF+iodG1YYFo2zpRyBcsWmSrgctfhPoTG/oGUNb1xPQsMR5H9aA58l+/H9tkRfp9j
 FL3vzDmI1dDYRQO031Ax42DGMNJ2ydEOb5K5c70/nGdE/Lo6zqWpaEGuSj8uOO7sGF5R
 MaajJZM18RMLwERu/YJK515d/FRKbK96APNwkkg+mrGSf6NlRNw98lSJeJcRd4UDgauh
 3a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792611380; x=1793216180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=21WVIi/PjHUROW6SHbbEbNpCKS+3a5GqVgwpiUZLdsY=;
 b=2sTIOmkf/EAD/Oo4UT7qSWawnUVJ+gJSNkdsvKZxXDaP+tSBm1GMR6GPDcEFmEMOV/
 h1Gs2BuQm0uSbINDrc6VV/TVXaqoka2fwXOMG6wuN5pcq0Taa69X+zdMHULU0xyGDv3O
 KEoImSMJdFjFXCJP6R8ukywJc1h/caFB+jijuH8qsAhP0KGPzgik+uCewPPT5DKZPy7P
 gaLrpkmEULv5cDcKRwB0piBWDbfHZSk0Dp+svxV7i11EXPK/sZWr6KFHPG/5/q1W1Mv8
 w3a+vJXiU6YEtlGfcL4elRzcRm2xm0dLeXxGg6ZHjeXAmXqAHmKpy45G7KkPo6SkYjfa
 DtMw==
X-Gm-Message-State: AFq9FYKtc6tXwCFUI0C7hCOJ087INrmK26cYdA27CRufjY/7S0ot/yP0
 SZjdVzRfbACADk6pRFRFb7mPd0uwvGp621pN71GO+GcPLvSWXnbNWoWgK0rNgxhKwJI=
X-Gm-Gg: AYBFou2U37DV1cZ8Z7tIzuWF/qdPXpkJ2CDVlfvwAE6p5H0Ege89/BT+fAG9WT0aEum
 G/xlc7D8ioEru6/nzrcA4vD8G8O3kPlhzdeBmjdS/sGWahiCrhv9pbjUg0U3pFCs1NM8XF6n2hh
 b3NTiW2RD0YJOLVj/y3pqZLLiF6Yv0XQN50cIMSfBMK9Gl1R2FZs+A8GmWLODTGaS2m8OtX+0kP
 HkE1fzM/yFQgF0fhTO9SKlNzzBQ7VChWtab0b1AkZqZoQJMh7hJS1UYSwsyMCLG0rVC+n4njT3w
 X99dMtaMci+5Z6xVswSTTW/BM/i0aqy6jmZzA1Bxsln1yyaDGZmVT7BDtLLQP5SElnGozESkwfl
 PjygwE81UKEZ0RBiDZ6Gmr6km/XHSVlECANqH91QGI5fj/oYJvwGnTn+tGnX2X8BOmbomBpyvht
 lJekKjb4uRWOB397/VdzMdr/jBFXzpWXUpfA0Ak9rnC2dHTGIeW7VpXvVU8qauWvmEnjYImaiQ4
 U4t6fiGflo/ahn03Ji2iwUdWJUSA/S2r3KWPn95RA03LXGwk1VJH8aRQrJM5ELzXEGsUW0QkoIm
 ymbv
X-Received: by 2002:a05:7022:485:b0:18d:9eec:e0be with SMTP id
 a92af1059eb24-190a0612732mr5283381c88.2.1792611379525; 
 Wed, 21 Oct 2026 12:36:19 -0700 (PDT)
Received: from sys0 ([116.72.200.239]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-368b4b8e9c6sm754742eec.1.2026.10.21.12.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 12:36:18 -0700 (PDT)
From: Harshit Mukhedkar <harshit007k@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Harshit Mukhedkar <harshit007k@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH] target/riscv: make sstateen1-3 reserved bits read-only zero
Date: Thu, 22 Oct 2026 01:05:38 +0530
Message-ID: <20261021193538.80383-1-harshit007k@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=harshit007k@gmail.com; helo=mail-dl1-x122a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

write_sstateen_1_3() passes SMSTATEEN_STATEEN (bit 63) as the write
mask to write_sstateen(). That bit is the SE control bit only in
mstateenN/hstateenN, where it gates access to sstateenN. The sstateen1-3
CSRs have no defined bits, and reserved bits must be read-only zero, so
bit 63 must not be writable on RV64.

Use a write mask of 0 for sstateen1-3 until bits are defined there.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4726
Fixes: 3bee0e40106d ("target/riscv: Add smstateen support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
---
 target/riscv/tcg/csr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 063590f56a..d9731421af 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3941,7 +3941,12 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
 static RISCVException write_sstateen_1_3(CPURISCVState *env, int csrno,
                                          target_ulong new_val, uintptr_t ra)
 {
-    return write_sstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
+    /*
+     * sstateen1-3 have no defined bits yet, so they are read only zero.
+     * Bit 63 is the SE bit only in mstateenN/hstateenN, where it gates
+     * access to sstateenN.
+     */
+    return write_sstateen(env, csrno, 0, new_val);
 }
 
 static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
-- 
2.56.0


