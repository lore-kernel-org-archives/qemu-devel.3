Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B97C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEL-0000Mr-Vh; Fri, 04 Jul 2025 12:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEJ-0000IS-Do
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:39 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEH-0006Di-5Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso967080f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646335; x=1752251135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7/ljGr/lmtJGdM4g/TCIPoJ8wA9RphCsNczVJCfmoCQ=;
 b=vbGjpw9PItaDXb8NAyWloTDP2fd63jxqpuk7Iq1BvoTMzYozGcEqC87aRIIwBlX4JZ
 vU9z2IuZxSKmAUdR4LSIIU+rIYubH3o0nPsra8Laa+biXJEviJOlAwJjIedqzss9+BsR
 yaTvmobI4z35s5e6QV1FA9vrJPTE6C+LySl8cSU9kyYshu/fDesmOMwZbrMGrR9DtecO
 DBjKGbPVqfe5UKeCEkmpQdztO8SH6AJBDTNayieGaE4P7U3UZDTKkJLTLH6Fw/UXo7fm
 V2QEGcg4Y/5gm3G9V1EH8vClkfSEGUe36kyQK1mb50LAbzq+wVedE3V3dtkdwmS+nTUJ
 QoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646335; x=1752251135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/ljGr/lmtJGdM4g/TCIPoJ8wA9RphCsNczVJCfmoCQ=;
 b=W+N+6QG3Hj6BH86u7VnR6+bsJEmJ12GBlqOd92dfdk/DrnrZO/lGe6gLW8R78Jz2G2
 Epe/1plzc3//L+pgGnWoJthrvyoMnpw+Jk0c95sbZmBgnZF0vceEjqCqtsZgrL7sDsxG
 pSz8JpmV44UJ5/5tRZ/Mw48Nqg0tSBhVlpe8QGYYUuv0RuiNx68+N4Ee1i2bVi6kb3Ya
 KYxZxZ0Pe4cxTjcU8sSYfgrmbExbw2sAUItFn/HX6msiuPHi1pLoQ1/SHSFXyLmwEvHI
 8VB6MjNK8cQdjA+QvdNRrUpfNU++BdV0V/BwujVsrTixGdxVIe730GILVbAIq7Tm2JMV
 okWA==
X-Gm-Message-State: AOJu0Ywqf+0dKey3+sPIeOtCuBKUHk8+AlZr1v56YrTZ0iprWMKTlC4d
 97GdrgKTE+f61G/aNO1Mv7tqhoUavtsGFxyn1laeNC+eCVJVFm0p88EW6Ef8oU0HKL8OKXz9m+6
 lOB4i
X-Gm-Gg: ASbGncvcpUUAWp6XiLQtal8lSWe3Km3nNKAlTnZCn4wGrjRA/wG2a2buOrnBhTIpauK
 Sn4fQA7exitEpK1ZRWMQ0pWCKejNFTmNRBXS6ba0a6astDSbDZdN2VjzP1jCuqzNtpEDcDVpzXN
 HJON1o4U8v9XtRbUE31CQACeOryRg9Uq2m6wI51OMP8ZHJPskNZN9oO9G2CRRnW0a/xAoe9sW9/
 oKc9ofv/EcGn54aAkp/a3ckeAiUafAcK0fu2W0fFbksQEVaxcqWBR8Jz2AnpOtjzozV3bq1m5CR
 yG3+uX1XhwZWMymkXNaEU186OCmRIIg3lEgrLsoCI+9IXPp53wGzwXEj9P6NVT7XwqEL
X-Google-Smtp-Source: AGHT+IFXJpgOf92yeXfNy6srqEu+HAezhbndX0Azm5iX4dt/R1b3WKHuf7y+VU1ET0Y7eykdo756lw==
X-Received: by 2002:a5d:59c4:0:b0:3a3:6595:9209 with SMTP id
 ffacd0b85a97d-3b4970294afmr2502235f8f.36.1751646335272; 
 Fri, 04 Jul 2025 09:25:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 035/119] target/arm: Split out get_zarray
Date: Fri,  4 Jul 2025 17:23:35 +0100
Message-ID: <20250704162501.249138-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Prepare for MOVA array to/from vector with multiple registers
by adding a div_len parameter, herein always 1, and a vec_mod
parameter, herein always 0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sme.c | 47 +++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 2c8cb24b7cd..ea0e5a7cb5b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -43,7 +43,8 @@ static bool sme2_zt0_enabled_check(DisasContext *s)
 
 /* Resolve tile.size[rs+imm] to a host pointer. */
 static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
-                                int tile, int imm, bool vertical)
+                                int tile, int imm, int div_len,
+                                int vec_mod, bool vertical)
 {
     int pos, len, offset;
     TCGv_i32 tmp;
@@ -52,10 +53,23 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     /* Compute the final index, which is Rs+imm. */
     tmp = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(tmp, cpu_reg(s, rs));
+    /*
+     * Round the vector index down to a multiple of vec_mod if necessary.
+     * We do this before adding the offset, to handle cases like
+     * MOVA (tile to vector, 2 registers) where we want to call this
+     * several times in a loop with an increasing offset. We rely on
+     * the instruction encodings always forcing the initial offset in
+     * [rs + offset] to be a multiple of vec_mod. The pseudocode usually
+     * does the round-down after adding the offset rather than before,
+     * but MOVA is an exception.
+     */
+    if (vec_mod > 1) {
+        tcg_gen_andc_i32(tmp, tmp, tcg_constant_i32(vec_mod - 1));
+    }
     tcg_gen_addi_i32(tmp, tmp, imm);
 
     /* Prepare a power-of-two modulo via extraction of @len bits. */
-    len = ctz32(streaming_vec_reg_size(s)) - esz;
+    len = ctz32(streaming_vec_reg_size(s) / div_len) - esz;
 
     if (!len) {
         /*
@@ -111,6 +125,14 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     return addr;
 }
 
+/* Resolve ZArray[rs+imm] to a host pointer. */
+static TCGv_ptr get_zarray(DisasContext *s, int rs, int imm,
+                           int div_len, int vec_mod)
+{
+    /* ZA[n] equates to ZA0H.B[n]. */
+    return get_tile_rowcol(s, MO_8, rs, 0, imm, div_len, vec_mod, false);
+}
+
 /*
  * Resolve tile.size[0] to a host pointer.
  * Used by e.g. outer product insns where we require the entire tile.
@@ -177,7 +199,7 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, 0, a->v);
     t_zr = vec_full_reg_ptr(s, a->zr);
     t_pg = pred_full_reg_ptr(s, a->pg);
 
@@ -259,7 +281,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, 0, a->v);
     t_pg = pred_full_reg_ptr(s, a->pg);
     addr = tcg_temp_new_i64();
 
@@ -281,19 +303,14 @@ typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int, MemOp);
 
 static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 {
-    int svl = streaming_vec_reg_size(s);
-    int imm = a->imm;
-    TCGv_ptr base;
+    if (sme_za_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int imm = a->imm;
+        TCGv_ptr base = get_zarray(s, a->rv, imm, 1, 0);
 
-    if (!sme_za_enabled_check(s)) {
-        return true;
+        fn(s, base, 0, svl, a->rn, imm * svl,
+           s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     }
-
-    /* ZA[n] equates to ZA0H.B[n]. */
-    base = get_tile_rowcol(s, MO_8, a->rv, 0, imm, false);
-
-    fn(s, base, 0, svl, a->rn, imm * svl,
-       s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     return true;
 }
 
-- 
2.43.0


