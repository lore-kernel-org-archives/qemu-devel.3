Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD44606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zAtGMv/j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFr-0004cg-U6; Wed, 21 Oct 2026 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDQ-0001aJ-4U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002B7-IM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so546686f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592566; x=1793197366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SKdSLzbXB3Bgy4vq1dJNIBMwHuODNkIBdJ5VX+sP0J4=;
 b=zAtGMv/jJSk4fhpYFbusLUUnnD0PYaOi/ssTr18HafHAkMTXZjaYEhus0ULE0rF1qH
 zx6FdQ8x/5oA9zizMQuiozVP0xOfN9SK69znhWljeVp8aG57sqb2Q3dkRgaHrFonQ2dp
 rJVODbTFmFR9l6UHhmuPv0R1jecyU9+FnF0YOAhkBBP5dNFLr+gfZrKm6BK3T6+sUP5k
 AsPgCmMM2KItoSQ0rjujwgbB22UqPzorq5H3c53WmihoQJm9JjVfokq0fvsF7IeGAnZH
 mXbxxtxoxoK8fU+fpEJVWXmZdTpoNVBsakaLRAdeqnIPBGhw4qv7DA7L8wLM5ive9mBo
 i8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592566; x=1793197366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SKdSLzbXB3Bgy4vq1dJNIBMwHuODNkIBdJ5VX+sP0J4=;
 b=jq63H/djy/cHmvL+UOj9nr/UG44Zcegluphyrxf0ve9CzjHdG2SW6LAsfr5EoNgVGB
 HSXNTxQ9apD1cevVAf+qBsBaswetgYsrlXzZvcdhdPsu9zEQZX05NCDQ+Y/ei6xxshkh
 Cx+8JlNvCcA10BagirQEQNWo7UMmdyBkBQ4Temn7o5nIiAfU0K7bENe1MXnzhN5K915F
 vOp2GYU/nBMu0EaScmOrDSX7mYPW9Hs2Amr3btvRCzgwKrm0Y6YfAxawzza7n7RiP6kN
 urIU0R8V4bopwDaqkoEybE6azvcqOWAyp1zDYFhheltwJp8t3qfZWw944Kl4aFosP6bq
 ITDg==
X-Gm-Message-State: AFq9FYIgfFFW2YWCnrTtK636mFvkjakmXbqbOLiW755yDsfEpvfF9y58
 D52go3eVaG7IELbLVQWnVIZNg6n7U3r+cNMl1wcpQxi5ia4IgL3DIXRv7aPDB7W78kLakbyyaKh
 p6QEtDjA=
X-Gm-Gg: AYBFou0ZJ3nNFKkDEcfuiCGCvAZLIvo1Biumbl0BJLUZEPuhgz89NzMDJVE2fivg+TX
 TF47WE8zCyDkh/aLXfj8WK23PHCmG5UDp7VOdqCP3KyGU2gYg72/od62mm7+N81wuFi/WVSgN6f
 Us0F0yG1qugh2ubc4PnylES2azO9tjx1RuF/vt5gmmJKFnyRMq8TYRbkn6t/dz3Zu4qelWxjdGi
 vYn6rJGltF/a4LCiyx9Mv82EvHsNIq7RJZFV+vQNzzLHyKJkb8MDupyIjbMrdEFYrvj/AsxzbqY
 nUIQ/hCyT1LNMBV/YS2VZ09koLPu6lPeuSLGsDgpwTl+1Gx2s4OUmjq4nlmGPtglGMNFtIRC8UY
 vXXXZ/fjl9k9t9xs/zqrTzbmQALBOOmqs48dHnQmuSo8IqthA5kNCRVzxtOCI/dEpCO2vhzuAzw
 CMl1qIPWcZOH+F4a02jFmVo0fIxn5GQ2ySNtN35RXOYH+EaBNam1jLdvCWd0lbI3Rgh04iBulnS
 5HcXluZ4AMqRxMFAA47OV3v6o5za9g3bX0VtYj9FQZ9zu3UgwSZnsHVTDUn4K4YrFlLLMvabOuM
 sC8tGqq+A26ZdN7nS0gaxzssdx4=
X-Received: by 2002:a05:6000:200c:b0:48a:f8fb:cd49 with SMTP id
 ffacd0b85a97d-48e264d53efmr4656091f8f.22.1792592566197; 
 Wed, 21 Oct 2026 07:22:46 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 067/100] tcg: Generic expansion of tcg_gen_ext16s_*
Date: Wed, 21 Oct 2026 16:16:19 +0200
Message-ID: <20261021141652.363109-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 798785bc7b..cbeae67794 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -185,7 +184,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1cdcf3aeec..4c1fc9633c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,6 +21,7 @@ DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
+DEF2(ext16s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 120dbe11dd..55bd8ccf8f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -609,6 +609,11 @@ void tcg_gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_extract(type, dst, src, 0, 8);
 }
 
+void tcg_gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_sextract(type, dst, src, 0, 16);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1174,11 +1179,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1470,11 +1470,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
-- 
2.53.0


