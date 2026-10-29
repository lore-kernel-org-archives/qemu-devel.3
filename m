Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0F606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vAXiw1XS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSlC-0005o3-8t; Thu, 29 Oct 2026 12:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkk-0005cI-N2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSke-0000XT-D1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so1805302f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290394; x=1793895194; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C6gEIGSn1fbeHbuTGwNVwS8Xb0RMqOlj0GQbPLR/fOU=;
 b=vAXiw1XSTUWYYbfsM8ZkvKPmUDPE4lvvS+lY56XiRRl14uucMere6gamCCXav1S4RX
 wx1JcmPXyqv+NeDXqGH+AprgQvzLv0AVFGEx2f+698dITKwuHlRsZPgwcZkdAiEAeIBh
 INpPZtFtd9hfeIS6AF1ueszYx5BrqNigtjtLdns1iHwsgQ7/bmWxR9G6mxZHFbkIgYda
 1jk6JMf2yCHCgJ7eV8qGYmZuWxOkS6wuvomhCAZtE/PcZreeOTpXuyavt0XAAG5heFJ+
 9iVMdL4CQSam5vnurtXfLtr4Nqk9oTARA2r7m0ATF9vOAKDNn1cozphEXdm56DDE1SJh
 mQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290394; x=1793895194;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C6gEIGSn1fbeHbuTGwNVwS8Xb0RMqOlj0GQbPLR/fOU=;
 b=lywIe62p4nWpZXAns4+MtGxn2SdNzJA/EHn8uugsxR6YcTAdIiyHkWyi9BPgGtBPdG
 O+Fmu8rZniUFnh3VWE5DqXVtinN2+E1IFWisGuURcHMJRqdfu5HlawhQNxlmGdWmoPBi
 U0ODde8Hqf+IHmp+HIRGrIqYxqQYJf3TTb22N5sk6w9Rb8Djx4MoDKpKRot/uc+oSntd
 BBKEf5tXvOxrkMyP8Lji4WirrJhGWPQcrMvZIbk08X0B0LOdq7EARAXx8Kde9Px408v7
 Zyy0dF9Qn9BNmOb5CE4xtWzDk4NCjIxEKr4BrlWGzOmeCR/FF8S9fWXSWsi0PjX62NnP
 JH7g==
X-Gm-Message-State: AFq9FYJK0xQgxJACnPxG/5xdarYvcm0ed6C17HsSLjRISiA/jQn8Cp1T
 nJWYxSo2/Mz44ofxeAHzv5X8R+dzs/zRXH/WOGLoXCM2omIV+6ToB7I6x7Di1VGNPSo=
X-Gm-Gg: AYBFou17KgSU80u4+2xXQ4cNg68Twwfu4T73YcXL4qBFq7gaodJPsS86tmQeHlC5FYv
 WWwIVTJLh7gpDoE5p6DJxJJ6Xov1adxFjR8MUS3gO4x1qoiICLMU33nY6dcCJv7xHaxa7emiOke
 XKsKHbwvFmap0g3dMyKBhktYlMHDvS2E0Tb5lWEOg1Ka8XbM/v7j4/oPik+UPASLRZ5mxXQavSB
 8jRZYWDSEuuUN2pU8y7d9YHUcAMc4YEMABbEIZ/owKUIaZUDRasD/wkinBlkJBWPliaId06h619
 myGXSHdqu/qszoy5p1pwl6WSC51CWwzIKynFeKsH9odSmH8XzSCkywW2HeRMCc4+O6mDrhOu8KL
 oiwr2RPt9EqcS62V3dfVerQOiAQ9pRIA53yjZPnouke3WHysfi3Km6EY7Nx6xAZIDjLRig15pKt
 7pRpJScat1mBAuOQ6sSRwfr9SiQjbZP+edxtOXuZoqKTpMfYBrXoNoWeChB7FPVmvtjm2jdWZFd
 WXgMIQlRLwOlNQOLUuWYtRjEfTdZzKlFCZsi37xybtxSJ7u8CQwuUtSBIZhDhT8W33I2Sllbw26
 5jBqUQzxVBaZ0s1zZtoMinT9uyriD7UmH1BlqNSh1zofDOe7gw==
X-Received: by 2002:a05:6000:2284:b0:48e:69ff:b8a3 with SMTP id
 ffacd0b85a97d-48e69ffbb32mr3297087f8f.38.1793290394252; 
 Thu, 29 Oct 2026 09:13:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfac9d9sm88425f8f.44.2026.10.29.09.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:13:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 877285FA05;
 Thu, 29 Oct 2026 16:13:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/8] target/arm: don't pass env to the sev helper
Date: Thu, 29 Oct 2026 16:13:06 +0000
Message-ID: <20261029161310.2065290-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029161310.2065290-1-alex.bennee@linaro.org>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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


