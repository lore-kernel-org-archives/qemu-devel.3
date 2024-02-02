Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AA1C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWC-0005Uo-JA; Fri, 02 Feb 2024 00:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWA-0005QA-JN
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmW8-0002vw-Hl
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:14 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso13085555ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853311; x=1707458111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dGYAfcgax5YHIoo7vejf9aHAeaL4GPpSPEIsOOmIaA=;
 b=MewDmPFqnm2ato1vvV2kTbptlWTZgXvbyPP/1H1C+fYNQJtDuJWp3yEUXTbUDHdVUd
 qotqdoPGOpt22fKxMYtGlCTlidmFZNeqIx5XvBFS0u94YjgmbCRUtcWwznjPsnNnG9NQ
 VeHw6zw6n3tgLYHtGdfoG3K4iR1RZLfOkqs8yHI8SOBvzS32V3nnxqnHitxlDttHBAOF
 /nz4IAiWvrntT7rxTjL9Tn5sGqpe/VvK5uvL08o1lqJFrT0bIz+1Xejzf7VLi7S0GEgH
 4reNQdjWjlqnli3sJRGC/ENLOCiTZxOnaW99+/pkjAAdb26nGg4LeuWQg0FeFx/RQYd8
 0S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853311; x=1707458111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dGYAfcgax5YHIoo7vejf9aHAeaL4GPpSPEIsOOmIaA=;
 b=jPNJnsGBTYUIPs+c9ZBOQYK8mu/9rlGnogLUwtKAOVoW2uax0ZNzUc/WI4WV+owf+2
 usXMZdxbX/C8ULUinJD6Fxmxgj4/ibCW8iclAa05HBXwLAxEwaw0LeVlo0TSki1RFXMp
 P+rhVK8+TUZPHd673L7LQbCgqokvePJIQumowbt/dT9E74ACfqWZWsvPlwOH7Ui566Ff
 Bmex+WCqr6XUt51L3URbujMOCg26coWQMErpYLM2icZD8MFl8+9sunuuobE+9mvtH3Jd
 fD5gETovK74gilgOTDq1fD82C427VjJYWG0dupifP2Q5tj6SmMCPhiCUAs5f0/qBj+Pn
 u9ew==
X-Gm-Message-State: AOJu0Yx0DZXzJvCcqc7441OoSvNXotpZ9QgTfzlcXoBkJ6hX2EM/B4RO
 N386d1mLDAXcqEexLkYujd2qdanCL6s5RK2RRz0OKguI6IPhYzJ2EqaS22XPX0h6hUZG5y2r9cp
 zwx8=
X-Google-Smtp-Source: AGHT+IGg+XJlNoTDtL+uAHM2Pe4MXto82urwX1XfIoFMCvY37gZCvC00kTJ3eTFHt0p74QkfH897TA==
X-Received: by 2002:a17:902:da92:b0:1d8:b8df:79f4 with SMTP id
 j18-20020a170902da9200b001d8b8df79f4mr1583345plx.17.1706853310945; 
 Thu, 01 Feb 2024 21:55:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWqisI70b9F1SBz7BHTOES1wpvPw71wuSV7Yht4inVNacsG+Bz00ZTMrhoUkZpYlpzVkXOrgHTOes7q7ixExqGpurK6KTI70kbN048mKw==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 40/57] target/sparc: Inline FNEG, FABS
Date: Fri,  2 Feb 2024 15:50:19 +1000
Message-Id: <20240202055036.684176-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are simple bit manipulation insns.
Begin using i128 for float128.
Implement FMOVq with do_qq.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-6-richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  6 ----
 target/sparc/fop_helper.c | 34 ---------------------
 target/sparc/translate.c  | 62 +++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 72 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 55eff66283..74a1575d21 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -37,7 +37,6 @@ DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(check_ieee_exceptions, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_2(set_fsr, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_1(fabss, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_RWG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_RWG, f64, env, f64)
 DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, tl, env, f32, f32)
@@ -48,7 +47,6 @@ DEF_HELPER_FLAGS_1(fsqrtq, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(fcmpq, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpeq, TCG_CALL_NO_WG, tl, env)
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_1(fabsd, TCG_CALL_NO_RWG_SE, f64, f64)
 DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmps_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
@@ -61,7 +59,6 @@ DEF_HELPER_FLAGS_3(fcmpes_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped_fcc1, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc2, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc3, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_1(fabsq, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(fcmpq_fcc1, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpq_fcc2, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpq_fcc3, TCG_CALL_NO_WG, tl, env)
@@ -90,15 +87,12 @@ DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_RWG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, void, env, f64, f64)
 
-DEF_HELPER_FLAGS_1(fnegs, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_RWG_SE, f64, env, s32)
 DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, void, env, s32)
 
 DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_RWG, f32, env, s32)
 
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_1(fnegd, TCG_CALL_NO_RWG_SE, f64, f64)
-DEF_HELPER_FLAGS_1(fnegq, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(fxtos, TCG_CALL_NO_RWG, f32, env, s64)
 DEF_HELPER_FLAGS_2(fxtod, TCG_CALL_NO_RWG, f64, env, s64)
 DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 0f8aa3abcd..d6fb769769 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -114,23 +114,6 @@ void helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
                        &env->fp_status);
 }
 
-float32 helper_fnegs(float32 src)
-{
-    return float32_chs(src);
-}
-
-#ifdef TARGET_SPARC64
-float64 helper_fnegd(float64 src)
-{
-    return float64_chs(src);
-}
-
-F_HELPER(neg, q)
-{
-    QT0 = float128_chs(QT1);
-}
-#endif
-
 /* Integer to float conversion.  */
 float32 helper_fitos(CPUSPARCState *env, int32_t src)
 {
@@ -229,23 +212,6 @@ int64_t helper_fqtox(CPUSPARCState *env)
 }
 #endif
 
-float32 helper_fabss(float32 src)
-{
-    return float32_abs(src);
-}
-
-#ifdef TARGET_SPARC64
-float64 helper_fabsd(float64 src)
-{
-    return float64_abs(src);
-}
-
-void helper_fabsq(CPUSPARCState *env)
-{
-    QT0 = float128_abs(QT1);
-}
-#endif
-
 float32 helper_fsqrts(CPUSPARCState *env, float32 src)
 {
     return float32_sqrt(src, &env->fp_status);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c68f6ca94e..41952281dc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -43,9 +43,7 @@
 #else
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_done(E)                     qemu_build_not_reached()
-# define gen_helper_fabsd(D, S)                 qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
-# define gen_helper_fnegd(D, S)                 qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
@@ -61,7 +59,6 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
-# define gen_helper_fabsq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
@@ -79,7 +76,6 @@
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fnegq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
@@ -1239,13 +1235,13 @@ static void gen_op_fmovs(TCGv_i32 dst, TCGv_i32 src)
 static void gen_op_fnegs(TCGv_i32 dst, TCGv_i32 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fnegs(dst, src);
+    tcg_gen_xori_i32(dst, src, 1u << 31);
 }
 
 static void gen_op_fabss(TCGv_i32 dst, TCGv_i32 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fabss(dst, src);
+    tcg_gen_andi_i32(dst, src, ~(1u << 31));
 }
 
 static void gen_op_fmovd(TCGv_i64 dst, TCGv_i64 src)
@@ -1257,13 +1253,33 @@ static void gen_op_fmovd(TCGv_i64 dst, TCGv_i64 src)
 static void gen_op_fnegd(TCGv_i64 dst, TCGv_i64 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fnegd(dst, src);
+    tcg_gen_xori_i64(dst, src, 1ull << 63);
 }
 
 static void gen_op_fabsd(TCGv_i64 dst, TCGv_i64 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fabsd(dst, src);
+    tcg_gen_andi_i64(dst, src, ~(1ull << 63));
+}
+
+static void gen_op_fnegq(TCGv_i128 dst, TCGv_i128 src)
+{
+    TCGv_i64 l = tcg_temp_new_i64();
+    TCGv_i64 h = tcg_temp_new_i64();
+
+    tcg_gen_extr_i128_i64(l, h, src);
+    tcg_gen_xori_i64(h, h, 1ull << 63);
+    tcg_gen_concat_i64_i128(dst, l, h);
+}
+
+static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
+{
+    TCGv_i64 l = tcg_temp_new_i64();
+    TCGv_i64 h = tcg_temp_new_i64();
+
+    tcg_gen_extr_i128_i64(l, h, src);
+    tcg_gen_andi_i64(h, h, ~(1ull << 63));
+    tcg_gen_concat_i64_i128(dst, l, h);
 }
 
 #ifdef TARGET_SPARC64
@@ -4629,13 +4645,11 @@ TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
 TRANS(FsTOd, ALL, do_env_df, a, gen_helper_fstod)
 TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
 
-static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
+static bool do_qq(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i128, TCGv_i128))
 {
     TCGv_i128 t;
 
-    if (!avail_64(dc)) {
-        return false;
-    }
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4645,30 +4659,14 @@ static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
 
     gen_op_clear_ieee_excp_and_FTT();
     t = gen_load_fpr_Q(dc, a->rs);
+    func(t, t);
     gen_store_fpr_Q(dc, a->rd, t);
     return advance_pc(dc);
 }
 
-static bool do_qq(DisasContext *dc, arg_r_r *a,
-                  void (*func)(TCGv_env))
-{
-    if (gen_trap_ifnofpu(dc)) {
-        return true;
-    }
-    if (gen_trap_float128(dc)) {
-        return true;
-    }
-
-    gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
-    func(tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
-    return advance_pc(dc);
-}
-
-TRANS(FNEGq, 64, do_qq, a, gen_helper_fnegq)
-TRANS(FABSq, 64, do_qq, a, gen_helper_fabsq)
+TRANS(FMOVq, 64, do_qq, a, tcg_gen_mov_i128)
+TRANS(FNEGq, 64, do_qq, a, gen_op_fnegq)
+TRANS(FABSq, 64, do_qq, a, gen_op_fabsq)
 
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
                        void (*func)(TCGv_env))
-- 
2.34.1


