Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603B9E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRhy-0007gH-Ni; Wed, 24 Dec 2025 11:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhi-0007c2-Uh
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhg-0003hj-Rx
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so59299765e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593631; x=1767198431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pPXI/RNd4YhskZ4GDGLaQPSNUsmTt2IQzm/8dEFuWw=;
 b=BWS+mlk5Hv7fXgcd5i5vtL7xJoJFzpjsocFYLt9BSetp7j53tyuCrbzZ0gvN0aKPOU
 NhHDfytr+MYrbmB3qj1Vr17ci4w619428xtInb7NMq6X7oTHSEFHSS1wdyWp06oewk28
 o348ueu2bVat5kTAWlH+DIm7Ub4anWX1rZcR/jSOQSdnNlnMsZ4tfAj5xq+gyvb6/COz
 dG4AMUQ0CvEtEQdXVJEwl6Q57KdASJ34wu/x/M3KDRg7nMpDRjXM2jyfsFjN9kgJs5aS
 MHaV+ys/VcuyUsdxbBQGt96yK2KRUYNosvqR2njc1zymXWXm/bxwru/5zEL7zp6mceOQ
 eAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593631; x=1767198431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pPXI/RNd4YhskZ4GDGLaQPSNUsmTt2IQzm/8dEFuWw=;
 b=THTrBeTnYH5onWOQLF+02oDG4cs5p5evkEqhEV5AGfrh1ebohBWW4GYGXX7PehAoy2
 O3jN34WVrozNO4lVlee3fy3bu06WDeTHjgk1XVB1itORVB/qQNVxYx9ZLRfHfpRE+ixo
 9IMHXyJ7m2kq+4npF7X62x7vymJuy51+8lN+xPxjJGGXh2f56D8pXbGNdHUnbXdc6o6x
 uKODCWsoFdbIlhUpUIkTfcegCuK/vJ+rM7Zgwqfr3tzASYQYm9cQ4ed3g2zJzePlZ9jr
 pZ5xPCBDx6MHDWBnOB9f7UvZVRnBwU9uJ1zhVdDrJ2mjuPqOMb0zMngMsrhlCG4b9Yer
 xicA==
X-Gm-Message-State: AOJu0Yw8iKP3tzdTtUhutjvj3rCi539sMi4SP7aHG48dHnYLCa9ceNVp
 XW+pxG/u3abQkbmpW0z3K7xlAqaQoipZHS2V+qF0cZqBlN9fOpyfyVCtac8g2vqjkc2qaJbn+pe
 LNSeai4Q=
X-Gm-Gg: AY/fxX7qlLr5B8UiqzG91ReFP24sZ9nYzFWx1XN2jF8jwO8MyGWw/O4Lzl6m1+JVguD
 jmrokO4uWFPu3DCDmpj7hvVJScaAh3IYHA6RJaiKVB4llfzrst0q+QLk+KgEMOtda798X8+gUHg
 9C5BK/6YRD2pKoX1JRE26n9bkeCm81ROwS01JZhKYIZFHA4vRuyt1gWZjSZy1Jq7HOk1JufkIvY
 jVRiuyEsLZ4Aix9VWsfUISvHJYT+TC5Xk+Vr7qEPfTGP+RBTcK/lykk5Ejs/JiQ3ytIk1V9wCG5
 fUu7eGPeaJf0l125DU6Kh5XoMiUAuGT7Py6+n9evQVl/+EDCDo3/syJcTMnch+Co/ySXiD7ubjz
 hriKdlr0cBXko3y+I/9LmO5mbYcB9i4XyepQR+2Fp+03EKHK4sMTllT1LHqy7yPfl/1+WSereB9
 FhsuqOWljjgxtXKgPOpo35Mg+LS7SissgmxSqq9Yx7yH2PxS1E+u2PyM0=
X-Google-Smtp-Source: AGHT+IFnwlGS2129abSIWPoc79ckkJLCBd7dyngQyqsSK3gGAloQICKu95WSgRUb5PkAYYdCT5qs2w==
X-Received: by 2002:a05:600c:310c:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-47d19549f9bmr162683145e9.11.1766593630914; 
 Wed, 24 Dec 2025 08:27:10 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm35443256f8f.42.2025.12.24.08.27.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:27:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/9] target/sparc: Replace MO_TE -> MO_BE
Date: Wed, 24 Dec 2025 17:26:35 +0100
Message-ID: <20251224162642.90857-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

We only build the SPARC targets using big endianness order,
therefore the MO_TE definitions expand to the big endian
one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_BE/ \
        $(git grep -wl MO_TE target/sparc/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c |  6 ++--
 target/sparc/translate.c   | 58 +++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..a87a0b3eee0 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1169,7 +1169,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_16:
         ret = cpu_ldw_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
+        if ((mop & MO_BSWAP) != MO_BE) {
             ret = bswap16(ret);
         }
         if (mop & MO_SIGN) {
@@ -1178,7 +1178,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_32:
         ret = cpu_ldl_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
+        if ((mop & MO_BSWAP) != MO_BE) {
             ret = bswap32(ret);
         }
         if (mop & MO_SIGN) {
@@ -1187,7 +1187,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_64:
         ret = cpu_ldq_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
+        if ((mop & MO_BSWAP) != MO_BE) {
             ret = bswap64(ret);
         }
         break;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d6b599b71fe..23079697f52 100644
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


