Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970ADC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5CV-0002xW-DE; Mon, 05 May 2025 19:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AZ-0006zI-Bz
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AX-0003yd-2F
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c33677183so59931325ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487455; x=1747092255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWI42H1mGpC+qtJnGTlft49SFGxWloHLdh6QbAbdhzc=;
 b=cmShyxcgr6e4hLDZLelL8HsSz/ht7386yK3e/n7V99fnnVF+9IZC3ynrc3MwBqm1iP
 OAinkdRr7A6xy50JodQMe6Yy8vU/kMVyoaroRRjETv7jdkuaiAd4NcmswsKmnrhQGICa
 qUSWMmuYe5fA+XRQuRqs6hWQ9NMrn7MmA1pjWI1QOurzxN1NeH+p0eKwTG6emp9J84v6
 FMvPSFZnct9KCFKVecEP1mUEh4nYOCN+uzISV0X7UCl2411ohPFL4F3Cmr3t3OnMCfbe
 VvMD8SKHPFITtSD/9QciqNa+Smcyh4amtBb4e/LqvAIXlgB/ryiPSDgE5vmGJ6j04zP8
 Ajnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487455; x=1747092255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWI42H1mGpC+qtJnGTlft49SFGxWloHLdh6QbAbdhzc=;
 b=sbgurNXiQbnCpc/2FAazIm9I8gLxJ4cI0oCmiRNkV72w3Pt8KuFKyxnX/MaOssAmZJ
 Rfs+QtHUYh8w+EvZyHfqrxOEH4lqB5j/q8NQDl2jYrJwjYUz1msJuMN5sD5jere4Tlbi
 1JiFKAyP9KB7wynOG7u50BCI1/y0DZcwN0t6HWOEhWNkGySixiE9/5YtZQECVI+UiT4A
 +akIh/2oNvKvDao02isJY8Nk5vtSMuBcra8SIPGCoALE6aZ5gJfLYl8Yven0vImbzCyq
 B8lT2DTrTiAYp+hhkcAyn0jivDdyiiiv45esku8TkmUaAGbvKhyGcGe2W9z/LqfDY7Ma
 qyHg==
X-Gm-Message-State: AOJu0Ywj9+ysowmiiR3ZjsAfBDb2S/aR7fmG0yAPig1wfJ8Mzt8bWgji
 I98A9DspiULtnl/a1UEriMS5gs+2AKJfch+xBUtQjjvKYmBUrRA+DtuGwpQ5uOe2eunCfWe+ZVy
 XS9A=
X-Gm-Gg: ASbGnctBOxCFQ1DxPcj0wC5665+eE1CYJskpWh/jKhGokSJdc1B+qPTc8ZJ4XxlYJRX
 FzKqlhIfP92/rX/gdC0070EMHkOdGmCfM6LgEEXClMfW991pMv3ck9aSr3S4S4ru3WBzKDKHfmG
 l7mml9Q5KgRWYxDX4IGeYcO4xSbb7aKnVy7NZK7zpH8F1ek4yek/lLwZveDapSCLkNxunna7Rp5
 c078SZyPnFnWp4VfWOVM+Qv/ZNs9OTPuf/u+dWupFx0otzUzIjZ9n83mwt/iO2nOXQjAo5pX678
 MhwA/FHHnh8wcYZCvAVWx9rutdnT0OrSViJSP2zKnlz/BJu3rC8=
X-Google-Smtp-Source: AGHT+IEUQQFAnhHZvpgEW269JjynFC74SxQHriC0mVPlLRJAjytrepF+TKFERHIHr5qYzSkqIHY0bA==
X-Received: by 2002:a17:902:f14d:b0:22e:37b8:7972 with SMTP id
 d9443c01a7336-22e37b881c3mr6291595ad.10.1746487455166; 
 Mon, 05 May 2025 16:24:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 48/50] target/arm/tcg/tlb-insns: compile file once (system)
Date: Mon,  5 May 2025 16:20:13 -0700
Message-ID: <20250505232015.130990-49-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

aarch64 specific code is guarded by cpu_isar_feature(aa64*), so it's
safe to expose it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 7 -------
 target/arm/tcg/meson.build | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 0407ad5542d..95c26c6d463 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -35,7 +35,6 @@ static CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-#ifdef TARGET_AARCH64
 /* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBOS. */
 static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
@@ -46,7 +45,6 @@ static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
     }
     return CP_ACCESS_OK;
 }
-#endif
 
 /* IS variants of TLB operations must affect all cores */
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -802,7 +800,6 @@ static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae3_write },
 };
 
-#ifdef TARGET_AARCH64
 typedef struct {
     uint64_t base;
     uint64_t length;
@@ -1270,8 +1267,6 @@ static const ARMCPRegInfo tlbi_rme_reginfo[] = {
       .writefn = tlbi_aa64_paallos_write },
 };
 
-#endif
-
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1299,7 +1294,6 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         define_arm_cp_regs(cpu, tlbi_el3_cp_reginfo);
     }
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_tlbirange, cpu)) {
         define_arm_cp_regs(cpu, tlbirange_reginfo);
     }
@@ -1309,5 +1303,4 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rme, cpu)) {
         define_arm_cp_regs(cpu, tlbi_rme_reginfo);
     }
-#endif
 }
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 49c8f4390a1..5d326585401 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'tlb-insns.c',
   'arith_helper.c',
   'vfp_helper.c',
 ))
@@ -68,6 +67,7 @@ arm_common_system_ss.add(files(
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'tlb-insns.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
-- 
2.47.2


