Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A294EE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSJ-0000Ru-KQ; Wed, 11 Dec 2024 11:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSH-0000Oh-2m
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSF-0007lt-DQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:52 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f796586so8313945e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934050; x=1734538850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8QtRpOUDdXPykNSh2kSGznv4CfLLLfE60kE3MXT1yOA=;
 b=M9yWJlEwukpshEj1U/ur3z3IYS1UtPiNoC6M6q8zJOTkUw7Q2y8EMK25WV9H/S/Qxd
 5H5g5AIPWUIAKQBGKCFRGDDOvJDGmf3t+A7t8PgsqgGNurF2ZIG2ILdwoF2chcoAfy03
 EF7MqickGN3tZEVNsDsuROLnjOtAC0QuptRwWylEuWGCOXSN1C100fJmB+TJl5KKiMDi
 mweU10w17dyfanyV6WcF/jefbGl1MUlnKzzKeLdEzMF2BKZpMeO2Z814gHyYAPlp0xyr
 uxoaXMrtdTe1el/Sdv0x6jhv2L8arJNoFqkrbDLyFmZkfNawsGAuE9Xq2tS5ZW35jyih
 l/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934050; x=1734538850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QtRpOUDdXPykNSh2kSGznv4CfLLLfE60kE3MXT1yOA=;
 b=LXhPbH7AzC4bHIPyr/bkAUWkE2L6HKqtqo3az6D3nqdyj7okfBdr8JxZx3Z9jnZvuS
 55x4c4tXYp5dJ/xFd5BHBae0uOd2zDur1jfjw6lPJZY3z36UvsfRPR+zGTAkEGgZ3vKr
 i1vJduToaKzd9UKkCtBqo5ujTVIt7HrVzOJfDuGqyGjv9log5qr3zt03R7iGWBr1LMd2
 d5n/fxn+z5ZLukdzQMOuVeNpqCzr+T7UMAcc4+rear9oPyJXdq/UbfF4mLMXc4uKRYfB
 q1NpBS7c5gMWPDr8/bxvWwh+f7z7lGTFONjMwub2z8/5FU20r9x+Sgb1P/1h9gxGOhAQ
 9L2Q==
X-Gm-Message-State: AOJu0YwSfIlr+KR1XNxxO3EHXZU5g2FE+Yp374A6p0wyYCMEhqep1DGq
 +TOT2nQxGVP1KVzXJ5NRyA0Qz6Q1J3iZNI8IQvJWHL8KlldMnHIIwswc6bxBVjLSaagi1mCsp3h
 Z
X-Gm-Gg: ASbGncsdsmtXMG6zXUEG8Iik0G1v3wI1IjDKrKtwO4/hlxm4JsKXiJNfW4Ig8r6SgvX
 vOh3QGBm9mjkUye+C8HzpT8ff96hKZMWfcCdyc4hAWqXV5wIua6kI0GMz8xg+18pkD/MBBtGVo+
 JaVsfRFtE58+4Ow7+kwOBPYLpgcf5g5gFq+BftNvTTdZt1n4DZtJEBpvi31o0BGLoQJtnItH2Od
 62LV0BUVQGSdDF/BHv3zPO8OSg2IXVzSTBwG4UvGJZxx+gUfsUFslNKTVIf
X-Google-Smtp-Source: AGHT+IGqe2Jk3lhh2qLkyM5RMDAP9f2H1rkBZ9KLKERjGbP9zuqck1KpOTmb+r83N39oEVs0sG1I1Q==
X-Received: by 2002:a05:600c:4450:b0:434:f5c0:329f with SMTP id
 5b1f17b1804b1-4361c3bd9e8mr34947935e9.14.1733934050014; 
 Wed, 11 Dec 2024 08:20:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/72] target/sparc: Initialize local scratch float_status from
 env->fp_status
Date: Wed, 11 Dec 2024 16:19:29 +0000
Message-Id: <20241211162004.2795499-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In the helper functions flcmps and flcmpd we use a scratch float_status
so that we don't change the CPU state if the comparison raises any
floating point exception flags. Instead of zero-initializing this
scratch float_status, initialize it as a copy of env->fp_status. This
avoids the need to explicitly initialize settings like the NaN
propagation rule or others we might add to softfloat in future.

To do this we need to pass the CPU env pointer in to the helper.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-33-peter.maydell@linaro.org
---
 target/sparc/helper.h     | 4 ++--
 target/sparc/fop_helper.c | 8 ++++----
 target/sparc/translate.c  | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 134e519a377..1ae3f0c467d 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -51,8 +51,8 @@ DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, i32, env, i128, i128)
-DEF_HELPER_FLAGS_2(flcmps, TCG_CALL_NO_RWG_SE, i32, f32, f32)
-DEF_HELPER_FLAGS_2(flcmpd, TCG_CALL_NO_RWG_SE, i32, f64, f64)
+DEF_HELPER_FLAGS_3(flcmps, TCG_CALL_NO_RWG_SE, i32, env, f32, f32)
+DEF_HELPER_FLAGS_3(flcmpd, TCG_CALL_NO_RWG_SE, i32, env, f64, f64)
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 6f9ccc008a0..236d27b19c1 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -490,13 +490,13 @@ uint32_t helper_fcmpeq(CPUSPARCState *env, Int128 src1, Int128 src2)
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_flcmps(float32 src1, float32 src2)
+uint32_t helper_flcmps(CPUSPARCState *env, float32 src1, float32 src2)
 {
     /*
      * FLCMP never raises an exception nor modifies any FSR fields.
      * Perform the comparison with a dummy fp environment.
      */
-    float_status discard = { };
+    float_status discard = env->fp_status;
     FloatRelation r;
 
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
@@ -518,9 +518,9 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
     g_assert_not_reached();
 }
 
-uint32_t helper_flcmpd(float64 src1, float64 src2)
+uint32_t helper_flcmpd(CPUSPARCState *env, float64 src1, float64 src2)
 {
-    float_status discard = { };
+    float_status discard = env->fp_status;
     FloatRelation r;
 
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cdd0a95c03d..322319a1288 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5584,7 +5584,7 @@ static bool trans_FLCMPs(DisasContext *dc, arg_FLCMPs *a)
 
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
-    gen_helper_flcmps(cpu_fcc[a->cc], src1, src2);
+    gen_helper_flcmps(cpu_fcc[a->cc], tcg_env, src1, src2);
     return advance_pc(dc);
 }
 
@@ -5601,7 +5601,7 @@ static bool trans_FLCMPd(DisasContext *dc, arg_FLCMPd *a)
 
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-    gen_helper_flcmpd(cpu_fcc[a->cc], src1, src2);
+    gen_helper_flcmpd(cpu_fcc[a->cc], tcg_env, src1, src2);
     return advance_pc(dc);
 }
 
-- 
2.34.1


