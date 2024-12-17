Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E41FE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEs-0007xy-Nz; Tue, 17 Dec 2024 12:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEq-0007ww-72
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:04 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEg-0006CE-Uv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361c705434so40539675e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455990; x=1735060790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Hsh5oYkK0qGRNGYgfI/fGPKBabcD1hBH/Yj4A7Q0+w=;
 b=iG5GGXO5PavB/SH1Qdf+tCmPO5M1hq53UbtXvVRFDeGnThk/tYAj3CT2fHxKztdeqI
 fIgu87qWPh1d7nq6KVQNwcW4vcQGGHmNleN7+YlZluwCWLr9yNP41YOD2XkvqV2e9dX3
 dIL/RMP3sUOBCHGEKuSJ7MZDFcjhPizLKk+MXq5m6/wrwJJtk2FW+mBAKzUZNaEvClb4
 NWJ3+hUL5CHnbOQYWRfA46OgE1Bmg3IkWZMD5MZpHzPbkLhp3nyxKYDoFxJNncQ6A7RD
 AAnPhSdA4Iz2wQ9S06tZyifGzY1hLD4+lJKjAdkGBdOzQ7Ouep1/NbxT1t+UnC1ocf0v
 d1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455990; x=1735060790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Hsh5oYkK0qGRNGYgfI/fGPKBabcD1hBH/Yj4A7Q0+w=;
 b=UnOJWNjzGXe0mQWvVArqzVByEpi6rOLeIPU5/Vm4LzZKw9BPCl3262yjHkpjc98E3J
 Osai7xklRzkkXbnBKyaSBBvSZF5/VeOghbBwpg51eQUVMQdMN4g/LllqKfsZTupBSC8v
 R/ZV7n+v8mNjVxCDELcuJt/0r0U1XsfgOt6XXxP0DlTLQQN6s5lQbrN3MdE+5mWCx/yy
 MgeT3WJxZgqYuDjg5QtgI3h9ilODgYv5rouHsr1yyP+aNYIeb/HriTu89Pc2uGEayq1s
 HTC5L1pidngN15m/HhLUWS4zOj7stf7Re9z88oEjerOU8se6YDEe5fDCnmMC0/bZnsrg
 lP4A==
X-Gm-Message-State: AOJu0YwBpWEhYwfu/r92Ooq/9zk6PQojuYxClfBDn2N3dUkqx0uHoVWj
 FuzJK5geiFLcZuRjK7XUn009uvMG8xvyWcg8DMoGY5nX/4eDxp1MRjBpkuSJz7/MjwwtehhZuTv
 r
X-Gm-Gg: ASbGncsdLxOBdPhyMlvHipG5+91PIkAg1PMkvcrttazE44aG5LwXGyR9DfnQJgpyFr9
 7SwFAuoAPWEQLva1vcq6PoIXiJEm/Vq0Sa9YcYjARpp/6r7+fPkResaig72/Tab9G51ApRsvb8j
 nCnC7LjhOAXGtrlHXtDXIkj3AH61zXriYrdcxwxGVIW73qQURVjxACyhHqRlolHZuXtqNl5fHG7
 Owy6uoJbPZB9FYbAsEyonV859+khSbBNWHGmOUkGKTUv2wSN5p6EhJZsnEU5QI=
X-Google-Smtp-Source: AGHT+IGWoDKeNcp29JPHXf9EE78OsF4oeQ1TBkM6HqZfK5FHHcQTwiJJKStUpiy2D9T/PWSeKNeg+Q==
X-Received: by 2002:a05:6000:4714:b0:385:e8f9:e839 with SMTP id
 ffacd0b85a97d-388da5b7ccfmr3088182f8f.56.1734455990125; 
 Tue, 17 Dec 2024 09:19:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] target/arm: Use float_status in helper_fcvtx_f64_to_f32
Date: Tue, 17 Dec 2024 17:19:28 +0000
Message-Id: <20241217171937.3899947-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Pass float_status not env to match other functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031952.78776-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    | 2 +-
 target/arm/tcg/helper-a64.c    | 3 +--
 target/arm/tcg/translate-a64.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 26e327af3a2..0c120bf3883 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -44,7 +44,7 @@ DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
-DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, env)
+DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, fpst)
 DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ff48bac1a8e..35dce4bef3c 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -384,10 +384,9 @@ float64 HELPER(frecpx_f64)(float64 a, float_status *fpst)
     }
 }
 
-float32 HELPER(fcvtx_f64_to_f32)(float64 a, CPUARMState *env)
+float32 HELPER(fcvtx_f64_to_f32)(float64 a, float_status *fpst)
 {
     float32 r;
-    float_status *fpst = &env->vfp.fp_status;
     int old = get_float_rounding_mode(fpst);
 
     set_float_rounding_mode(float_round_to_odd, fpst);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e57b98c27f..fda1176b3f4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9102,7 +9102,7 @@ static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
      * with von Neumann rounding (round to odd)
      */
     TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_fcvtx_f64_to_f32(tmp, n, tcg_env);
+    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_FPCR));
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
-- 
2.34.1


