Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE68FC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfn-0007Zw-MY; Wed, 02 Jul 2025 08:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfj-0007Xw-PB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:43 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfQ-0000wg-TE
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:43 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so3756052fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459663; x=1752064463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avG4JE0kZnkXMmiA0g2ZhYep6E1Ws+N6t9f5D8hgcYA=;
 b=QO/D+4ZgeGFG2EyDeyE3GoXAyvsNyMaWZpty/vAbcIOpopquvE8Z56spTIwQDO72kX
 PqIm+15t18vdvATt52IttplxWB27xtf0MKZX9nTW8/04zT/Ve4Anv/x38ow0Y0QQgbrs
 dYrBBUEjPn5/J9+EdyrwR5YAvdIN/Q0nGIkaSG8olJbJJBNf1Kjbduzb43/71K89t6l+
 cCaMoZvpik2wnTOcUe7UNUiEZ0svDulTFpgMppUhgbB/P5mTH11rHU1fN1xkavHYN+LK
 zjvBLsQFDnyC8ebtxFnBvluVJgnz386OylazrHDICvV09mVoRQ+MVIr9R+m+YYVsymRU
 qcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459663; x=1752064463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avG4JE0kZnkXMmiA0g2ZhYep6E1Ws+N6t9f5D8hgcYA=;
 b=DlUJ3iX4+cQYDFYsHh+/G9lfyrvaUZSd8vAln61+mePVD3B/6Y8NnvMo5Y8oat2erK
 FljJ/7JsqK77VJ7IOFoKhEH0tk6F4CoDx/WlziukoYj4SbEftfTK4Ctl3V3e1lcbv2XN
 bvuRc1srzeAM3cEJpK6A3UgjzITIZfvjOaCNysP82kLZi3KQ5mNQQhxOsBZysvFAwA5i
 zO5p4VWZlAVidXbWBIqyYS/b6TM7cGUe9GeIRrJMQWa3v9ld9bE5SxhKyTIjBVyaJbl/
 EZhu/CdpyeFXQG3HXNDjuK037bmhHfhZxAeu/4Rgz6VPuLTr+1Zwt3zvIUPRsfgRqWw3
 UAVQ==
X-Gm-Message-State: AOJu0YzhgQQ9FnmOkW5fDyOkMNAO7dlr8axj9Yzd75TQ3YPV5SfhdXML
 2fWtKQVE2XkYqRlas+mBjYQ7jUwc3uX7wNzWnyIg8SxOTA4/F070RwmcEpRU94Efb3r5aeBM6h3
 ZIOoxVBk=
X-Gm-Gg: ASbGncskYybqRBTxhTvQ4J361jMBqZcjGoeGZGbmH3jZ6MPvW0M14oMyoMQigWm0ayT
 uDeHVJIdIWaRj8MPKvXG/OJ0/QjCM6+Hp0Knh/eJ79d2SMlnrgjwQR37oxw+Cv627mnaynXw6Uj
 tmZpzLHMcCRAY+E/XEbicoZOVO/0uJVYLkMSwLJaK7gmzcK4GhFLlw3KM8ZOvuxMfX1dXtul0T/
 zHM2WB4dqIzjlGHpQAXCk6esRU/Iz1jkmZ7U0KqgTCcr8nsQkdxItGQ4tzw7lX2eAAFecVu4a+6
 vwDI6BbFgv9Gfx6Fe3vl0QCBtJfBjbO1rXRtf4sevULf83R0RkmM2TxemkalQ1V5rAfFPQ==
X-Google-Smtp-Source: AGHT+IFAutCK7doV9HyyKFYooSF3RLdQFDsaTXQpKKMBqvCYreddbLo77Z7p6xHikceA+HimKPA+EA==
X-Received: by 2002:a05:6871:820c:b0:2ea:8c15:d6d7 with SMTP id
 586e51a60fabf-2f5a8c3a031mr2047386fac.27.1751459662925; 
 Wed, 02 Jul 2025 05:34:22 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 08/97] target/arm: Add alignment argument to gen_sve_{ldr,
 str}
Date: Wed,  2 Jul 2025 06:32:41 -0600
Message-ID: <20250702123410.761208-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Honor AlignmentEnforced() for LDR/STR (vector),
(predicate), and (array vector).

Within the expansion functions, clear @align when we're
done emitting loads at the largest size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  6 ++--
 target/arm/tcg/translate-sme.c |  5 ++--
 target/arm/tcg/translate-sve.c | 50 ++++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index b2420f59eb..8a9f4b2053 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -225,7 +225,9 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
 
-void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
-void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
+void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs,
+                 int len, int rn, int imm, MemOp align);
+void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs,
+                 int len, int rn, int imm, MemOp align);
 
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 246f191eca..1dbd0199af 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -269,7 +269,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
     return true;
 }
 
-typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int);
+typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int, MemOp);
 
 static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 {
@@ -284,7 +284,8 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
     /* ZA[n] equates to ZA0H.B[n]. */
     base = get_tile_rowcol(s, MO_8, a->rv, imm, false);
 
-    fn(s, base, 0, svl, a->rn, imm * svl);
+    fn(s, base, 0, svl, a->rn, imm * svl,
+       s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     return true;
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8403034a0e..d2cd298b5b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4160,7 +4160,7 @@ TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
  */
 
 void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
-                 int len, int rn, int imm)
+                 int len, int rn, int imm, MemOp align)
 {
     int len_align = QEMU_ALIGN_DOWN(len, 16);
     int len_remain = len % 16;
@@ -4189,12 +4189,15 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
         for (i = 0; i < len_align; i += 16) {
             tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
-                                 MO_LE | MO_128 | MO_ATOM_NONE);
+                                 MO_LE | MO_128 | MO_ATOM_NONE | align);
             tcg_gen_extr_i128_i64(t0, t1, t16);
             tcg_gen_st_i64(t0, base, vofs + i);
             tcg_gen_st_i64(t1, base, vofs + i + 8);
             tcg_gen_addi_i64(clean_addr, clean_addr, 16);
         }
+        if (len_align) {
+            align = MO_UNALN;
+        }
     } else {
         TCGLabel *loop = gen_new_label();
         TCGv_ptr tp, i = tcg_temp_new_ptr();
@@ -4204,7 +4207,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
         t16 = tcg_temp_new_i128();
         tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
-                             MO_LE | MO_128 | MO_ATOM_NONE);
+                             MO_LE | MO_128 | MO_ATOM_NONE | align);
         tcg_gen_addi_i64(clean_addr, clean_addr, 16);
 
         tp = tcg_temp_new_ptr();
@@ -4219,6 +4222,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
         tcg_gen_st_i64(t1, tp, vofs + 8);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
+        align = MO_UNALN;
     }
 
     /*
@@ -4227,7 +4231,9 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
      */
     if (len_remain >= 8) {
         t0 = tcg_temp_new_i64();
-        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
+        tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
+                            MO_LEUQ | MO_ATOM_NONE | align);
+        align = MO_UNALN;
         tcg_gen_st_i64(t0, base, vofs + len_align);
         len_remain -= 8;
         len_align += 8;
@@ -4242,12 +4248,14 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
         case 4:
         case 8:
             tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
-                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
+                                MO_LE | ctz32(len_remain)
+                                | MO_ATOM_NONE | align);
             break;
 
         case 6:
             t1 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
+                                MO_LEUL | MO_ATOM_NONE | align);
             tcg_gen_addi_i64(clean_addr, clean_addr, 4);
             tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
             tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
@@ -4262,7 +4270,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
 /* Similarly for stores.  */
 void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
-                 int len, int rn, int imm)
+                 int len, int rn, int imm, MemOp align)
 {
     int len_align = QEMU_ALIGN_DOWN(len, 16);
     int len_remain = len % 16;
@@ -4294,9 +4302,12 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
             tcg_gen_ld_i64(t1, base, vofs + i + 8);
             tcg_gen_concat_i64_i128(t16, t0, t1);
             tcg_gen_qemu_st_i128(t16, clean_addr, midx,
-                                 MO_LE | MO_128 | MO_ATOM_NONE);
+                                 MO_LE | MO_128 | MO_ATOM_NONE | align);
             tcg_gen_addi_i64(clean_addr, clean_addr, 16);
         }
+        if (len_align) {
+            align = MO_UNALN;
+        }
     } else {
         TCGLabel *loop = gen_new_label();
         TCGv_ptr tp, i = tcg_temp_new_ptr();
@@ -4320,13 +4331,16 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         tcg_gen_addi_i64(clean_addr, clean_addr, 16);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
+        align = MO_UNALN;
     }
 
     /* Predicate register stores can be any multiple of 2.  */
     if (len_remain >= 8) {
         t0 = tcg_temp_new_i64();
         tcg_gen_ld_i64(t0, base, vofs + len_align);
-        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
+        tcg_gen_qemu_st_i64(t0, clean_addr, midx,
+                            MO_LEUQ | MO_ATOM_NONE | align);
+        align = MO_UNALN;
         len_remain -= 8;
         len_align += 8;
         if (len_remain) {
@@ -4342,11 +4356,13 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         case 4:
         case 8:
             tcg_gen_qemu_st_i64(t0, clean_addr, midx,
-                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
+                                MO_LE | ctz32(len_remain)
+                                | MO_ATOM_NONE | align);
             break;
 
         case 6:
-            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx,
+                                MO_LEUL | MO_ATOM_NONE | align);
             tcg_gen_addi_i64(clean_addr, clean_addr, 4);
             tcg_gen_shri_i64(t0, t0, 32);
             tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
@@ -4366,7 +4382,8 @@ static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = vec_full_reg_size(s);
         int off = vec_full_reg_offset(s, a->rd);
-        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     }
     return true;
 }
@@ -4379,7 +4396,8 @@ static bool trans_LDR_pri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = pred_full_reg_size(s);
         int off = pred_full_reg_offset(s, a->rd);
-        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_2 : MO_UNALN);
     }
     return true;
 }
@@ -4392,7 +4410,8 @@ static bool trans_STR_zri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = vec_full_reg_size(s);
         int off = vec_full_reg_offset(s, a->rd);
-        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     }
     return true;
 }
@@ -4405,7 +4424,8 @@ static bool trans_STR_pri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = pred_full_reg_size(s);
         int off = pred_full_reg_offset(s, a->rd);
-        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_2 : MO_UNALN);
     }
     return true;
 }
-- 
2.43.0


