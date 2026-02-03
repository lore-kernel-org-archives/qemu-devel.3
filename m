Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A45AE8B383
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPOo-0006DX-4x; Tue, 03 Feb 2026 18:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOj-0006B1-PP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOg-0006Bn-Dd
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:28 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso2467785e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770159685; x=1770764485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKaFN3q0wPWXS4ZXIhJmL9LeiOuDpU5p0P8W5pL1SLk=;
 b=JNHmAMmsuFlxJbG6G6obsDD1Xi/JcwINor5oONqZDDe3X0/TAoKI5/pNy+aacpl+/o
 wpoY1duoBoWMwFUNxJmcrmmAFMGr7hazISfSIOXu56NQz4Jim9OD0UTnwNgZluEdksij
 0dGEl0nUHtm5M3T9TjQEI7erwG0n5KaCK3JzfZIeHhp1Mcw8FR6bwZ0QClEZqmBc1Zdr
 7sNg4i3hnQwJllX5xF455WDYe9JnpLIsydY1Eu4wMhz69uBHVdvMiwzIZV+ylUEexJkf
 booLO2FvqSknirU6q5Kp2ro5bMof8YJTRRrZwVkdNTS84Hiu4Y8NLGOtyBGEVs+mhrr/
 oxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159685; x=1770764485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pKaFN3q0wPWXS4ZXIhJmL9LeiOuDpU5p0P8W5pL1SLk=;
 b=SfWEK88ldRmF2Uxjim8gvIbnJ/JYTW05sNFmpmKRNVZWG5mYm5gHCqShWJTE7K+hSQ
 9VAR7OeDT+CHHlC5R6PPaia6CE6/cG4NvdShoS3BuR5JLvR/tZDR2I9rpGqpTU/KzFfi
 cN5orSeG0/F2aMxpDEbHsh+2JAgqKxyoy70muEPtMSMGlwaAND7M4afnhOsbBWVFS6ll
 bYH6l0iBiVM73OLGPNE419yg+bQOaYgFNKMtXjR+Qk57gtW6mQWNFa4m3lLk/e5zvusE
 El+UwQk2ePixCKF/dO02qmthKBza+NxazLc3aeEB1CwfBoEyb+88/bpy1GE5Y9a/rV0i
 E8cg==
X-Gm-Message-State: AOJu0YzsGqd9XQqTzRh5uEi3HbX8wQqwx5v1vqtbahcMNxeFJu5HfzS+
 UL3dI7Y5U8oOzhdfrqhzmOC9Bkt7NcfBzQGyNM65blYNX6GBlnZhQKnePwgFEQhNjFNTLmTisyK
 N/n9JQwg=
X-Gm-Gg: AZuq6aKeThAUGXxra22vm963YT7B4eKRhh2IEYC9Ik8Ja6P+9H7QGlEyRoQ4MjHlBxo
 aBE/sHPFmOVQr1oIS7ovoqa+cwgx7OuSVli7Bk29VUd53ffvMNXZCfa4wdu7Nf4L6PfRTBOPAz5
 jGRmVJTBHrc6aFUiPR0Ijm/Chpw+bXKIDgQyA0EW8/whIh6geGgKjgxjpDB+XCMn/cMl8MYzGPe
 b6N9cNby+E33Hlz/UkLBV/6ESBao9vFJgm45hMeViNpL7y3pgATuJK0F2YvZiJwioYGKj6pLWNe
 7t1xHwQImq/ZAHxhSm1/HGTnBvWrEFpSppM0NTPaLU1VxGdA0pCyc3x4OUXJWiQ96RhEkpa/V8B
 F2mtSCuARblNchF1mfs9vksMogHxo1S41ziIrIa2hEDHZ2R1epHVM6FOIelC+PYKPJ93wZkTdyy
 dJoFcEc9qC59FBRHV6U4O5fV0XL3e66sSSpxCgWRPyf7JLwD2gaWRP7XfRWDc9
X-Received: by 2002:a05:600c:458c:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-4830eb58934mr14967755e9.11.1770159684569; 
 Tue, 03 Feb 2026 15:01:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38fbbsm2307042f8f.13.2026.02.03.15.01.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 15:01:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 4/5] target/sparc: Replace MO_TE -> MO_BE
Date: Wed,  4 Feb 2026 00:00:53 +0100
Message-ID: <20260203230054.23667-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203230054.23667-1-philmd@linaro.org>
References: <20260203230054.23667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


