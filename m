Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s7Q3KSPk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnJy-0006W0-H1; Fri, 30 Oct 2026 10:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJp-0006Bu-Se
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJo-0002Dz-43
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so7671485e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793369454; x=1793974254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i3ewVD0XqjJnKLOhDKPQ2xLdqcFlOTBh0kaoafSBw6g=;
 b=s7Q3KSPkY+TMFcjN6iuJmpYxgBwnnDMZXissPdZdh1Uy7R/XBDfRoNcmbBBU/qi/IU
 Do6xur1Zy6WGAIibxt4+BXPP0kbqUmUhf6o9RJAjE7ViLzj9zJLuDrkYmeNZO8SCN9pG
 H+xxYPV5NtT38XdiElyrdFkMBRFYfDIjhMTkLRQ21AOB5AltuFsSktnTCZgate0zaYv0
 6hRqXYMqg+09QZdK32IeM01itnXpGc3wg+rxt9mGZm0iJIlit9nwhlI6W775I7UFBAiY
 d+BOdrposvDxIrUPNzq4ADG3sV23DmciuxE6supnL7nclm4dQKxeVBsgR9L0PgKsAOr2
 OjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369454; x=1793974254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i3ewVD0XqjJnKLOhDKPQ2xLdqcFlOTBh0kaoafSBw6g=;
 b=Yv5N3f3Gwhrg/IbWPRhPD88rnveIu2cZc5paC0hr8KIXhSTOhq/EeOnv61T7+V5JjA
 zgy5EbV2VvTIVymgwpYEP4PMnySUCHUnjFKlDMo5phdKE99ePrVXeCfnSqKwNmkJm3BL
 mIdZnSdA6iWnzOFYXv8mZAkYTGeByXs5xtvv28oheyJPwVQsPLCzy1tAzI1YtpICJiow
 smDakRl3ttPbyuGiaB5NXqykBLE2lUHYNmIdESPA/3+tA2ZUanDEK3T2b0wSFCwbAV1i
 GzD2t6dQKvUKhd2iUAjEFs1G0wEJMfpcFVdP+y9mGrxkTHLZi2zl/PJfLx5WrtbKwDQd
 R+fg==
X-Gm-Message-State: AFq9FYIsNYZc+luZRl9oKS8B8bS/LpTKMScCU5iXB5HfW/6wGKe7EXVH
 UytDTg53VmXeSnDptFtfvZbhSdIYB/9hXtKLJiixApb0ynPI1s2fXzvbE3tjGcfbTD0=
X-Gm-Gg: AYBFou0Cp/SrC1Vb/GsU0jKqVHpJuoBNlZmUgMDM7OMB2f4kssUpxwE7qps0pSAbGxS
 j5j0CiHcZ+7ZBMxuaULtccj51Xix2dlOG7hDaK68ByBCMjwvnusUrn72LamYLV6ZZjSLyXZbnud
 S4jOJAMfdJQhXRb4aUFugYf90EZCRxMQA7QVA/pbAxfbwwL+1bYWzArd2f9rf9kKFfJawWKdbSd
 oNBre3kF5ZqHT3jhJw5P2TcNt0dEc9J9rHy5iwl10gqualr35rP43fBHNas6ArYLESSN318zKLw
 1f03qXtqOcruskQfYegxEFsU33i+NCdpcxr10/GgQ1UHhXFfCDjVT7UGZe8Up6I9bSryg/AgPFO
 WkbwMmX0d/x9TpRQSvQlgPOwiZwi7n3iQ36lIfobE1EHKYQbuH9iXeR2xrlwzDMqjPKMgqN4maf
 XkjY2ZJYDjlAkyXrhsgBxqD6zpSzvd27fKY8K8ppf2bfy/qT/kX+oouEyYB1Tw6rpd+mq5Xo8Po
 Zq38xH7b0LQlLu+dxKSDOaHzBgu/OUhDaNBqbmxVI5j3pnUZgm3exDK7i6kitTyKuLwg0gVWe3D
 HvC2O0q1zyG7CLV8FSvIoDgp/hcT
X-Received: by 2002:a05:600c:4f0f:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4ac17b2cde9mr60167055e9.7.1793369454537; 
 Fri, 30 Oct 2026 07:10:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm3488559f8f.10.2026.10.30.07.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:10:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57F615F904;
 Fri, 30 Oct 2026 14:10:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] target/arm: don't pass env to the sev helper
Date: Fri, 30 Oct 2026 14:10:44 +0000
Message-ID: <20261030141046.2710206-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030141046.2710206-1-alex.bennee@linaro.org>
References: <20261030141046.2710206-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It was pointed out during reviewing a recent fix that cs is only
needed as a loop variable for CPU_FOREACH so passing env is just
wasteful.

Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261029161310.2065290-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/helper-defs.h   | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 269ac515065..4f9736e6796 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -60,7 +60,7 @@ DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
 DEF_HELPER_1(vesb, void, env)
-DEF_HELPER_1(sev, void, env)
+DEF_HELPER_0(sev, void)
 
 DEF_HELPER_3(cpsr_write, void, env, i32, i32)
 DEF_HELPER_2(cpsr_write_eret, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 5788a094123..4a31ce979c6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -468,7 +468,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 #endif
 }
 
-void HELPER(sev)(CPUARMState *env)
+void HELPER(sev)(void)
 {
     CPUState *cs;
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0c712e7ac2e..941254983e9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2148,7 +2148,7 @@ static bool trans_SEV(DisasContext *s, arg_SEV *a)
      * SEV is a NOP for user-mode emulation.
      */
 #ifndef CONFIG_USER_ONLY
-    gen_helper_sev(tcg_env);
+    gen_helper_sev();
 #endif
     return true;
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 6983153ffc6..c1970f93c8f 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3282,7 +3282,7 @@ static bool trans_SEV(DisasContext *s, arg_SEV *a)
 #ifndef CONFIG_USER_ONLY
     if (arm_dc_feature(s, ARM_FEATURE_M) ||
         arm_dc_feature(s, ARM_FEATURE_V6K)) {
-        gen_helper_sev(tcg_env);
+        gen_helper_sev();
     }
 #endif
     return true;
-- 
2.47.3


