Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE0606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wym8E23n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEM-0005zy-ST; Mon, 02 Nov 2026 08:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDM-0003g4-BI
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDK-0002MF-Ib
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so19617195e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626601; x=1794231401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIhRE7vMft1/Mq1QNvUjG8b+bbnYzBS350td2U+zfcs=;
 b=wym8E23ntzd4TZnvK9kEtSNB4XBf31vhECQ2ZswZZ5BNv1OHBaLbEWGfeshSZng8h9
 yrE2vy79BtcwmDYtlUoqbms4xsqKZ/QpgVoOBlOQyuxxdLa3q5VCX8IDnCXGZV9XoAR3
 Z8ZbdjGGYt0mkprq38awaiZGK3j/+6dF0Jab2JCBmhJkXWFOzRN92/Lpn53NxT3aTfLA
 0YKqCvxpLu29+6ZQwHjvCr3QCQjBOUlptk3UPC/RV8Fk279teDL+laojZr3/BpuO12s5
 q+ZT08+M+100FcDc+7SfPzyM/CpITmgkKtnORuG6ITSkPjbpCQH6VYq7isuYYZZ0j5IH
 eEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626601; x=1794231401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pIhRE7vMft1/Mq1QNvUjG8b+bbnYzBS350td2U+zfcs=;
 b=kk16GkDGNQYjfJAxTOTNzDOUnrODqrx+S92HcXeL74nH1UFzvjlYO6J7q1fpmQHJWK
 sn8jHzTDShiFdccrVIXus8tvnGUm/8kuX4cf1r7A8JcLebmR7SZEpFvyijQAqs0GhuVa
 fK6vkiY3x/pYwFnohuvqkbP0uiU9hd4ajd/a/Z+uNHqQ2+/Dy7LvZCdpJ9gQEYcgFegh
 jGTI+j0duGyROc7nAlrZ5FVN4y7+mj2fneJ+HY8ELFTCX8eENZVqyq4DHjRe/XjJFCr4
 Okz386okqPCI5NEMbeXk9ERx5xZpgvULGHRUOSHkHKDYJv6FtcTJwS9/20QpAWESVJW1
 rhHQ==
X-Gm-Message-State: AFq9FYJu3Ys9d7DE/OI9sBjaHpXnXRwwDtSn2s9G75tPvqaklR9XiWmf
 KuUPS9Q/5X1r17XGvCuVdCDXYuhPM3g1mK8yLhJb63oJWCmxPr21MSgPGvp5AAZ41VmIEtS+I8n
 iVkRCKjo=
X-Gm-Gg: AYBFou0jU9a1ytEarcuU2Envm8VOV6QS1L1CZ4E/XQAYE15UtnwXbwZqNKh/K34QsTi
 xuyN054g+pYHRIoIL6lcCd9VkET6w5rJZ3eDmEC3pUAyFKz/uGknyYhDlf8Oi7hRi34omAvDdQf
 gHRWtnGE015v+jED89YptAgpFA7lw8um3K6eJf02DPX8ZAzDjAZO/779DxRq1K6zmd5zHBuJVcO
 aWPE1iUgbmmDkxKVq8W1qNejh7nk4R9yIets7aqBrTgB3i4W/aGWeKcsPxjmnj2PMnC2Mcaw30f
 jf7WDIQlsw7dRD4HcOq9KMBIVav37967CiczL8Y+j63ygG4srT7kubK+2npci//4exGgIMirPW5
 43Og8YJziT/5+JFia0Fk1AAreIBgZ0hhmwaILVJmxT2O3ZYeXsaUS8R3feFLWyU9f5y7TSRyQcj
 IwLOXS7Pd5BSoue1NHD/BFwDk93lLwagkhdPP1dzbDPZLcgxWPily6zWWoHZ1T1MpkxmVzkVP1x
 FPSF+EFXo1i68FXlCSSeCzSjmC8BreiJzsz0GslHgY/W9+XHcuMGtwOSUNXf3fT+Q//Xx5wD0Su
 8HzrTiwBTt6S09qgwOMMn55qPY2I9x8LgkPe9Iac1nLfZoERE3QTGzhbo5Bd44XwzmJC/2umLSv
 Ua20D/rKalUHEOzXtLdAYJAbgfN5julRl3A==
X-Received: by 2002:a05:600c:470d:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4ac1899378bmr222512895e9.17.1793626601078; 
 Mon, 02 Nov 2026 05:36:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/47] target/arm: don't pass env to the sev helper
Date: Mon,  2 Nov 2026 13:35:46 +0000
Message-ID: <20261102133547.1375701-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

It was pointed out during reviewing a recent fix that cs is only
needed as a loop variable for CPU_FOREACH so passing env is just
wasteful.

Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20261030141046.2710206-3-alex.bennee@linaro.org
Message-ID: <20261029161310.2065290-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


