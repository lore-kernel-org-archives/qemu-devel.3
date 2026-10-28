Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABB606A32F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ICddozvV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6a8-0006R3-8N; Wed, 28 Oct 2026 12:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a5-0006PM-Da
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:53 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a3-0007VV-N0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:53 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-843a4ca671eso630368a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205170; x=1793809970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQPFkovSv9zq2I+4/DbquLMsQ0khFjLjqlTRGlecGtk=;
 b=ICddozvVWZ31d+ErnmFU028uLhDohQbHCjrMKLPylarTFeyH/VHVAnjAO5S7HQbwPU
 4hb9jufgjApkbJwt6FLm8tctQGDI6xunL1KMDM03Kn4bYLtfqVLwiIkyiTo1LmF9vsGy
 RXH9Ap0ZJ9JM0IxeoUSTDeSsn0vRuF1NdgsIj7ZLLcoe1FB3wD1erDKxZiO7cbZdXu32
 i6x77f4NcOuFhETkx9ORQgGj/bgA5kqfT0YKjg8HA+6ECCmYJ9dMdJ3QGUcQbbptBXPw
 R/ud2k2qp5cKixLe3qeT4t0ldMptjzwTN3DQHmQel2KX4jgPGkRV7iZB+wYM8/Q8hrx6
 PJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205170; x=1793809970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rQPFkovSv9zq2I+4/DbquLMsQ0khFjLjqlTRGlecGtk=;
 b=uVCMardjgKL8e8NwtK1uD+rUCi9GsrKIGCz5f1iwHp7rIfv1eXvdSM1eT2TcDuMsl5
 t8m8VGgz5nO+kP1WjZPi932gLy4nBPolFcSWXdoZH0+yp+pl010wu1CNawtO8fPzzkSb
 vWBIZps7u28JNKoVeE55pO3VKvnOyA+G7FhWG8BkwjZRDr6H27qFxLCJd5j1fctnHzEk
 JuFicsIs/Ju9YRFXPSkaKvAy3iW88g4WKAhFGWcjqKR/hPKb8C0C/Ia1mB5T+GDGPwKF
 HULaaqXB69HGmfQ4M+Jrcrgmoc3EukvBhXuPmNV6ToGZpjSZbkD9mrZq/AV7UOA9kZ31
 khzA==
X-Gm-Message-State: AFq9FYJ832s4Ck6givXWZIhorIdYiAobp1WY5w+IJ/7WnJuuijpDmLYF
 73GDEJcSRruE13ZsRoKKIH158cKZ/AGmSOJvAmJwVGGIhY2ITsHN0FG9COGBJA9csE440V2g/PT
 aHxvP
X-Gm-Gg: AYBFou2zu2gaW58xwrB5RoR3m+eqtWPK6dGxE7lc7HLUxGG05j3skIPLIUapujhAPL5
 vB6iKvjkPPZSo3TNfxc8e4fy2ZS3Q4X95lWYDPDqOHumBkGgTFIFsubfR5d9eZudc7mqaR2l6CU
 jPhymaWY2o0Huf+OmvvV9xl7LLXYTDyErCdEQ44UpGgC5O4fGngGt5fxKxidcAkKbrdx5VM5Mtr
 YX1pItBcuXMZhvO2LBWsLfdxNrrVW0Uc0iZZ7FqM1w9RDvAuF+nPiTrg1iJHf8LV1mWPrxlR+yK
 o48J5d9uVC6D5ES8tMK2DGw3bIbv79AYW40/ZD+qrZyI96AeXOeo62BYLBL9+1n6OqL139GqT5+
 e7PpZYTvh4vjU6iS0To5b74cJBaBBUYbmIaZQAIUb0wKdbm/OtQVk12foE2v7i3p33EmWVihvqz
 jgBoyd4YNaBhwzQszyy5vKgsLVC7Zw9xhJpyeXsy+7PSEK1jmqlOzWQToQ2hpWiKGyrB9g6gZPI
 /URxKlOF2ahMNfjDtDawh4SydLnkMpnMXwdoYSDVfGxHOsOMeBZwXXFX6soZyKvArIEZf+PuCJs
 M9aftO8gWmyhs+TwB/KVeZbo2xG+gEFfUw==
X-Received: by 2002:a05:6830:44aa:b0:81b:9d18:75c with SMTP id
 46e09a7af769-85ac08fe08cmr2715213a34.20.1793205170270; 
 Wed, 28 Oct 2026 09:32:50 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 02/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
Date: Wed, 28 Oct 2026 11:32:31 -0500
Message-ID: <20261028163245.1031673-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h         |  2 ++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 43 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 3721164236..a7d001c959 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -83,6 +83,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i64
 #define tcg_gen_sar_tl tcg_gen_sar_i64
 #define tcg_gen_sari_tl tcg_gen_sari_i64
+#define tcg_gen_lea_tl tcg_gen_lea_i64
 #define tcg_gen_brcond_tl tcg_gen_brcond_i64
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
 #define tcg_gen_setcond_tl tcg_gen_setcond_i64
@@ -209,6 +210,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i32
 #define tcg_gen_sar_tl tcg_gen_sar_i32
 #define tcg_gen_sari_tl tcg_gen_sari_i32
+#define tcg_gen_lea_tl tcg_gen_lea_i32
 #define tcg_gen_brcond_tl tcg_gen_brcond_i32
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
 #define tcg_gen_setcond_tl tcg_gen_setcond_i32
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e694f0e38c..c9caab2138 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -37,6 +37,7 @@ DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16u, TCGV, TCGv_ptr, tcg_target_long)
+DEF5(lea, TCGV, TCGV, TCGV, unsigned, TINT)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4814a493c0..29b6049650 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -820,6 +820,49 @@ void tcg_gen_ld16u(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld16u, type, dst, base, ofs);
 }
 
+void tcg_gen_lea(TCGType type, TCGTemp *dst, TCGTemp *base,
+                 TCGTemp *index, unsigned sh, int64_t imm)
+{
+    g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+    if (imm != 0) {
+        if (TCG_TARGET_lea_imm_valid(type, imm)) {
+            /*
+             * The immediate is non-zero and valid.
+             * If the shift is out of range, perform the shift first
+             * so that we can still emit (base + t + imm) as one insn.
+             */
+            if (!TCG_TARGET_lea_sh_valid(type, sh)) {
+                tcg_gen_shli(type, t, index, sh);
+                index = t;
+                sh = 0;
+            }
+            tcg_gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, imm);
+            return;
+        }
+
+        /*
+         * If we can make the immediate smaller by folding it
+         * into index before the shift, do so.
+         */
+        if (sh != 0 && imm == (imm >> sh) << sh) {
+            tcg_gen_addi(type, t, index, imm >> sh);
+            index = t;
+            imm = 0;
+        }
+    }
+
+    if (sh == 0) {
+        tcg_gen_add(type, dst, base, index);
+    } else if (TCG_TARGET_lea_sh_valid(TCG_TYPE_I32, sh)) {
+        tcg_gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, 0);
+    } else {
+        tcg_gen_shli(type, t, index, sh);
+        tcg_gen_add(type, dst, base, t);
+    }
+    tcg_gen_addi(type, dst, dst, imm);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
-- 
2.53.0


