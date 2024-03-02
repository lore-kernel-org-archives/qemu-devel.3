Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4EAC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjn-0002Vo-F3; Sat, 02 Mar 2024 00:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjl-0002Uw-B7
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:41 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHji-0007YP-IB
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:40 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29b31254820so403411a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356597; x=1709961397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+nsfbkq/6DuQu47ZwF+ORMIIrl2dVJeM+BgUxIZLGY=;
 b=rQ4QCx0u3LV4LabAR5SUmjMD1xymlIrF6+D9DkRyqGqPBAlzr8mi3Wn+hwAZ+HY6fL
 5Z7vYm7rWnRuvZz7Vv60Sg5mXCXOS8wjWZnhAd3537xW7SbJ9O6AA2AOyF8CxrrFf3FT
 mZMcwCS6kuyFhnBnyTEIRDWZETCaOgTtJX0hvr/C9C1JJuXf25Jl/SeyLctSY1OczVxY
 rGZQLQAHV3L+fHgWPae1Od3xlfEB97LTV1C17LTDuSTcV1/yKxrd7lKND5ycAIgHEP19
 MEZuAZNT2eoUJ+GZswe5yoLrFSzfI/dXRu24tMMLtnHdheA/fyWNKUggk691Vb/jCPx2
 pEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356597; x=1709961397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+nsfbkq/6DuQu47ZwF+ORMIIrl2dVJeM+BgUxIZLGY=;
 b=PZVYjrpfddncfESMwVpJUv+CnDPoNDam9fz3Bvm8/7pDLVouXxRHyXfVJmfcS3UnN2
 jP6zfHI5lOpGOhbQRiPK6WSdyxQWWedxXia8YuW2nq4shietqsaxFnJT4p0P5Ld2jol4
 vebOnSP/kr9AJp8lr6KRAHfzNvWzLLR4bH1Pg5zRVpdTf2QExetzqkWfXYPjFN3JOOvp
 iExPDxc0mXG8YM6ZekTXa8ZmksepIkp12J/Z3v0FOvru86qYP8QkdMbHhKQqdUNBvWE4
 zhy0H0CCIKWJUz/oWRBWgkSoxU+wElJOIK2Ux6UipFBt7Yy50KFsFOMWYH+kYSZgLARD
 8H3Q==
X-Gm-Message-State: AOJu0YzfZfMpb4gEa+tpf18J5xFHXLnMUZYkXHQA+XX+8s9p65DCvV8b
 2EhjqLqN0kx0wfnebawCbJSntBmFp7ttKKIYyNcKXFEkH64Hlg2VPILkteNRorAd+lOXKsk8b83
 5
X-Google-Smtp-Source: AGHT+IEMgeGUoz+HwNI2dBAszC8nFqP3E0cO8Ys8wjX7WJxzc6bNELTQiRDmS1d/lFGOha1BEmdHSg==
X-Received: by 2002:a17:90a:8c8c:b0:299:522d:9158 with SMTP id
 b12-20020a17090a8c8c00b00299522d9158mr3153921pjo.13.1709356597175; 
 Fri, 01 Mar 2024 21:16:37 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 18/41] target/sparc: Implement FNMUL
Date: Fri,  1 Mar 2024 19:15:38 -1000
Message-Id: <20240302051601.53649-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Unlike FNADD, we cannot (ab)use muladd for this operation because

    -0.0 * +0.0 == -0.0
    -0.0 + +0.0 == +0.0

the addition step will lose the -0.0 product result before negation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  3 +++
 target/sparc/fop_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 target/sparc/translate.c  | 21 +++++++++++++++++++++
 target/sparc/insns.decode |  3 +++
 4 files changed, 63 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 37b22afd7f..926b579e97 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -54,6 +54,7 @@ DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_5(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, i32)
+DEF_HELPER_FLAGS_3(fnmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 
 DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_WG, i128, env, i128, i128)
 DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_WG, i128, env, i128, i128)
@@ -65,8 +66,10 @@ DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_5(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, i32)
+DEF_HELPER_FLAGS_3(fnmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_WG, f64, env, f32, f32)
+DEF_HELPER_FLAGS_3(fnsmuld, TCG_CALL_NO_WG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_WG, i128, env, f64, f64)
 
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_WG, f64, env, s32)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 1de44d79c1..ea9d4ec235 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -359,6 +359,42 @@ float64 helper_fmaddd(CPUSPARCState *env, float64 s1,
     return ret;
 }
 
+float32 helper_fnmuls(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float32 ret = float32_mul(src1, src2, &env->fp_status);
+
+    /* NaN inputs or result do not get a sign change. */
+    if (!(get_float_exception_flags(&env->fp_status) & float_flag_invalid)) {
+        ret = float32_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fnmuld(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    float64 ret = float64_mul(src1, src2, &env->fp_status);
+
+    if (!(get_float_exception_flags(&env->fp_status) & float_flag_invalid)) {
+        ret = float64_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fnsmuld(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float64 ret = float64_mul(float32_to_float64(src1, &env->fp_status),
+                              float32_to_float64(src2, &env->fp_status),
+                              &env->fp_status);
+
+    if (!(get_float_exception_flags(&env->fp_status) & float_flag_invalid)) {
+        ret = float64_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
 static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
 {
     check_ieee_exceptions(env, ra);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 877847b884..b3714ada6a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4776,6 +4776,7 @@ TRANS(FADDs, ALL, do_env_fff, a, gen_helper_fadds)
 TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
 TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
 TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
+TRANS(FNMULs, VIS3, do_env_fff, a, gen_helper_fnmuls)
 
 static bool do_dff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i32))
@@ -4923,6 +4924,7 @@ TRANS(FADDd, ALL, do_env_ddd, a, gen_helper_faddd)
 TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
 TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
 TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
+TRANS(FNMULd, VIS3, do_env_ddd, a, gen_helper_fnmuld)
 
 static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
 {
@@ -4944,6 +4946,25 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
     return advance_pc(dc);
 }
 
+static bool trans_FNsMULd(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst;
+    TCGv_i32 src1, src2;
+
+    if (!avail_VIS3(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    dst = tcg_temp_new_i64();
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    gen_helper_fnsmuld(dst, tcg_env, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_ffff(DisasContext *dc, arg_r_r_r_r *a,
                     void (*func)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index dc524f5b8f..8c0df3004d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -309,6 +309,8 @@ FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @d_d_d
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @q_q_q
 FNADDs      10 ..... 110100 ..... 0 0101 0001 .....        @r_r_r
 FNADDd      10 ..... 110100 ..... 0 0101 0010 .....        @d_d_d
+FNMULs      10 ..... 110100 ..... 0 0101 1001 .....        @r_r_r
+FNMULd      10 ..... 110100 ..... 0 0101 1010 .....        @d_d_d
 FHADDs      10 ..... 110100 ..... 0 0110 0001 .....        @r_r_r
 FHADDd      10 ..... 110100 ..... 0 0110 0010 .....        @d_d_d
 FHSUBs      10 ..... 110100 ..... 0 0110 0101 .....        @r_r_r
@@ -317,6 +319,7 @@ FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @d_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
 FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
 FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
+FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
-- 
2.34.1


