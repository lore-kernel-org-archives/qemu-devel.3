Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B098BEE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfZ-0007KP-Ox; Fri, 06 Feb 2026 16:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTen-00061P-Db
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTek-0002gZ-NQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so23486145e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414385; x=1771019185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtEO8G27nnH7lLWBTbF56NVVj8AARfbkCj36h5G6NAw=;
 b=CRZw3Xz8glYDHM/B77RTRU/0onFEDBHraXCSje+NCfCkOck6G3v/I6mQbpLA/5Gx0q
 4txN19iPKD9njsve+3vnfIkRJvJwV+ZZkF0JPDea08mNs7lOuyGPO8jrbKEYaPrmOfmd
 MQ3J0cGb3FEtqMYjCVRR4ay/3W51W7pJwdYkoAaxSo5mlvM1vGFhYLi8GHahac2ue3Q9
 2Rbr69On6i9cLSuWmDRbNSKDTRH1U47heYHmOIqr42ktfOYR1WX7vEXAd+83anTrkwE0
 rZ3G57kWTVXsGxBFha2jqYbvLHqX3w2NhJQgvL2BIxdZEOPn8st8AZqyIjhhtpbcfWqE
 8Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414385; x=1771019185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UtEO8G27nnH7lLWBTbF56NVVj8AARfbkCj36h5G6NAw=;
 b=xU8vYV8XjXieJIhq5SaekpNcW3xXZLCuWzn8lHyq7q5aCgKlaZapRPDDmosGKQ2YG7
 BcsjR5iG58MUYMujnW3eqgNSVzdB1Ead2QSxnU+IZyEy3+D2DucbmuVTCY6LcWlbI+En
 qhFOaE/RA/uanroLzLum8/2sy/tqx/zuah82OQ4GxkFCDAIWD1fA2R3PP0zDqR5cXy9n
 /KLi1zIb0R9QUGYFWVG36CHCZNRRHATDnOPq6sXLWRqflV2AX47jmytIbYXLC6u6eUog
 2fUD6o1F1hW6GpYaMpPHycBkNUMOq9ep8IjM982qhjDHfqZztXtfbS8LbpvPrw1/TXn7
 e1tQ==
X-Gm-Message-State: AOJu0Yxc5nUBJNUXTPleO5bDoAXrj6KOmIb0DdBrD0XM0+DCR1c8imu1
 pKp4XAzS0Ta3cKJ+ILw0dYkS7G0kEfPbWKgoAc+Bo32VN+mtLvpi2+A6ytHZ2YwcqZZVzAgpazP
 BLm2+2bg=
X-Gm-Gg: AZuq6aImKI32J8Lhkte6HPoy0lqwG1ePImzYrTtIWMaMdXA9cHsAziskrOlzdJS8zhD
 eKTPv/189S3CmhRFG8XSLN0pzd+bLLAYziu0jcGoQTWHpDN8Gl4Xh1OD7RSB3wscdBehtNbVuC8
 ktiwJ9JDT9Vg5X4etwVI2+AzpbAlsm/qUwNpnBXVm6XaPAoNtbe+IKh+opHqM2pjVezeaB9RDHk
 ddpVG5QAR67cBcPzrqs3YvNJ/40OsSiv503UhgkhMDvhL1QeOyPlobLg9qk9r7KwJ7bC4brZ8iF
 2ef73zpAa2ahQto7LeMICJT4SVmZSE66cAy1L5Mth62CaE7zyn490I1/0QLSsePRdgI+wE4cqzh
 KnzPAIefno2zVgtq/hCIOsuSLDIWS0GKTCGCHgSebxhErgdsIwTLuG3m3cs4cl2uz22KnkYGHKZ
 70A8W3JB+9lUnFqi2k3AwkV2j1Vc4JASeHIB2gRVGMAYmAkC8tX3F1aXZ5lZA5
X-Received: by 2002:a05:600d:6447:20b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-4832020dfadmr41823155e9.9.1770414384531; 
 Fri, 06 Feb 2026 13:46:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e37f9sm36091385e9.3.2026.02.06.13.46.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 14/30] target/sparc: Replace MO_TE -> MO_BE
Date: Fri,  6 Feb 2026 22:44:32 +0100
Message-ID: <20260206214448.22008-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We only build the SPARC targets using big endianness order,
therefore the MO_TE definitions expand to the big endian
one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_BE/ \
        $(git grep -wl MO_TE target/sparc/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260203230054.23667-5-philmd@linaro.org>
---
 target/sparc/translate.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1a7e5cc3d73..57b50ff8b9a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1764,7 +1764,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL16_SL:
         case ASI_FL16_P:
         case ASI_FL16_PL:
-            memop = MO_TEUW;
+            memop = MO_BEUW;
             type = GET_ASI_SHORT;
             break;
         }
@@ -2215,7 +2215,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
              * byte swapped.  We perform one 128-bit LE load, so must swap
              * the order of the writebacks.
              */
-            if ((mop & MO_BSWAP) == MO_TE) {
+            if ((mop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i128_i64(lo, hi, t);
             } else {
                 tcg_gen_extr_i128_i64(hi, lo, t);
@@ -2235,7 +2235,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             /* Note that LE ldda acts as if each 32-bit register
                result is byte swapped.  Having just performed one
                64-bit bswap, we need now to swap the writebacks.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2252,7 +2252,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             gen_helper_ld_code(tmp, tcg_env, addr, tcg_constant_i32(oi));
 
             /* See above.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2277,7 +2277,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             gen_helper_ld_asi(tmp, tcg_env, addr, r_asi, r_mop);
 
             /* See above.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2310,7 +2310,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
              * byte swapped.  We perform one 128-bit LE store, so must swap
              * the order of the construction.
              */
-            if ((mop & MO_BSWAP) == MO_TE) {
+            if ((mop & MO_BSWAP) == MO_BE) {
                 tcg_gen_concat_i64_i128(t, lo, hi);
             } else {
                 tcg_gen_concat_i64_i128(t, hi, lo);
@@ -2329,7 +2329,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             /* Note that LE stda acts as if each 32-bit register result is
                byte swapped.  We will perform one 64-bit LE store, so now
                we must swap the order of the construction.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
                 tcg_gen_concat_tl_i64(t64, hi, lo);
@@ -2345,7 +2345,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
          * See comments for GET_ASI_COPY above.
          */
         {
-            MemOp mop = MO_TE | MO_128 | MO_ATOM_IFALIGN_PAIR;
+            MemOp mop = MO_BE | MO_128 | MO_ATOM_IFALIGN_PAIR;
             TCGv_i64 t8 = tcg_temp_new_i64();
             TCGv_i128 t16 = tcg_temp_new_i128();
             TCGv daddr = tcg_temp_new();
@@ -2368,7 +2368,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             TCGv_i64 t64 = tcg_temp_new_i64();
 
             /* See above.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
                 tcg_gen_concat_tl_i64(t64, hi, lo);
@@ -4428,13 +4428,13 @@ static bool do_ld_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(LDUW, ALL, do_ld_gpr, a, MO_TEUL)
+TRANS(LDUW, ALL, do_ld_gpr, a, MO_BEUL)
 TRANS(LDUB, ALL, do_ld_gpr, a, MO_UB)
-TRANS(LDUH, ALL, do_ld_gpr, a, MO_TEUW)
+TRANS(LDUH, ALL, do_ld_gpr, a, MO_BEUW)
 TRANS(LDSB, ALL, do_ld_gpr, a, MO_SB)
-TRANS(LDSH, ALL, do_ld_gpr, a, MO_TESW)
-TRANS(LDSW, 64, do_ld_gpr, a, MO_TESL)
-TRANS(LDX, 64, do_ld_gpr, a, MO_TEUQ)
+TRANS(LDSH, ALL, do_ld_gpr, a, MO_BESW)
+TRANS(LDSW, 64, do_ld_gpr, a, MO_BESL)
+TRANS(LDX, 64, do_ld_gpr, a, MO_BEUQ)
 
 static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
 {
@@ -4451,10 +4451,10 @@ static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(STW, ALL, do_st_gpr, a, MO_TEUL)
+TRANS(STW, ALL, do_st_gpr, a, MO_BEUL)
 TRANS(STB, ALL, do_st_gpr, a, MO_UB)
-TRANS(STH, ALL, do_st_gpr, a, MO_TEUW)
-TRANS(STX, 64, do_st_gpr, a, MO_TEUQ)
+TRANS(STH, ALL, do_st_gpr, a, MO_BEUW)
+TRANS(STX, 64, do_st_gpr, a, MO_BEUQ)
 
 static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
 {
@@ -4468,7 +4468,7 @@ static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
     if (addr == NULL) {
         return false;
     }
-    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    da = resolve_asi(dc, a->asi, MO_BEUQ);
     gen_ldda_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
@@ -4485,7 +4485,7 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
     if (addr == NULL) {
         return false;
     }
-    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    da = resolve_asi(dc, a->asi, MO_BEUQ);
     gen_stda_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
@@ -4516,7 +4516,7 @@ static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
     if (addr == NULL) {
         return false;
     }
-    da = resolve_asi(dc, a->asi, MO_TEUL);
+    da = resolve_asi(dc, a->asi, MO_BEUL);
 
     dst = gen_dest_gpr(dc, a->rd);
     src = gen_load_gpr(dc, a->rd);
@@ -4544,8 +4544,8 @@ static bool do_casa(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(CASA, CASA, do_casa, a, MO_TEUL)
-TRANS(CASXA, 64, do_casa, a, MO_TEUQ)
+TRANS(CASA, CASA, do_casa, a, MO_BEUL)
+TRANS(CASXA, 64, do_casa, a, MO_BEUQ)
 
 static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
 {
@@ -4561,7 +4561,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (sz == MO_128 && gen_trap_float128(dc)) {
         return true;
     }
-    da = resolve_asi(dc, a->asi, MO_TE | sz);
+    da = resolve_asi(dc, a->asi, MO_BE | sz);
     gen_ldf_asi(dc, &da, sz, addr, a->rd);
     gen_update_fprs_dirty(dc, a->rd);
     return advance_pc(dc);
@@ -4590,7 +4590,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (sz == MO_128 && gen_trap_float128(dc)) {
         return true;
     }
-    da = resolve_asi(dc, a->asi, MO_TE | sz);
+    da = resolve_asi(dc, a->asi, MO_BE | sz);
     gen_stf_asi(dc, &da, sz, addr, a->rd);
     return advance_pc(dc);
 }
@@ -4629,7 +4629,7 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
     /* Store the single element from the queue. */
     TCGv_i64 fq = tcg_temp_new_i64();
     tcg_gen_ld_i64(fq, tcg_env, offsetof(CPUSPARCState, fq.d));
-    tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN_4);
+    tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_BEUQ | MO_ALIGN_4);
 
     /* Mark the queue empty, transitioning to fp_execute state. */
     tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
@@ -4655,7 +4655,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
     }
 
     tmp = tcg_temp_new_i32();
-    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_TEUL | MO_ALIGN);
+    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_BEUL | MO_ALIGN);
 
     tcg_gen_extract_i32(cpu_fcc[0], tmp, FSR_FCC0_SHIFT, 2);
     /* LDFSR does not change FCC[1-3]. */
@@ -4679,7 +4679,7 @@ static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri *a, bool entire)
     }
 
     t64 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(t64, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(t64, addr, dc->mem_idx, MO_BEUQ | MO_ALIGN);
 
     lo = tcg_temp_new_i32();
     hi = cpu_fcc[3];
@@ -4722,8 +4722,8 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
-TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
+TRANS(STFSR, ALL, do_stfsr, a, MO_BEUL)
+TRANS(STXFSR, 64, do_stfsr, a, MO_BEUQ)
 
 static bool do_fc(DisasContext *dc, int rd, int32_t c)
 {
-- 
2.52.0


