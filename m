Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0FAD0E6C3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqhX-0003xs-Q7; Tue, 25 Nov 2025 05:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqhN-0003j8-EO
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:09 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqhK-0001Qj-0n
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:04 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-429c7869704so4457953f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068099; x=1764672899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVumjk0F6Tq93V240FNbMOnFtVOEoBWTLGnL0WT9/nA=;
 b=IlTwdXmkY45ydg66iilqx+bOGLC0ywl2qnjjFJ/orAYpF5DEtpTEgoXRIr+nbeSJY/
 MaMG6WEmEEAzzT7xNEmzCPj7vs+WSEKYKRmBqM+MZHDhdNWr0U+Z1hi0oo+toB8i0gaC
 nNV3FYtNZ0Mucs1XaWXnGGIJdLWC82iHoOUU96fXo5XJPoIa04c4NY8Syqwbu3KpNO8S
 rdUqib+vp3N3LlMHPuFclFViPX1KTPm0iIr/ZufMGkhan2h7zhcWJ+0SKFe5iAnLJCjq
 qyHZoFubO3I5YICJLk+FYnQilgeSuPXPmzsU+93xcrRLMPNK9RS5s8FvgsKnEaksZC8Z
 TfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068099; x=1764672899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVumjk0F6Tq93V240FNbMOnFtVOEoBWTLGnL0WT9/nA=;
 b=Eeue2wQwax9YQQF3792pH2lB1glUTtKVVG7inqLlYCdWDqFbT3bRxowxATPYukNQH0
 m2qJ8Jc5pZv8NEPk7FhHqSkX2/5f6kh1SQHo052GQfZu5wK7FMjoTHtf2tW+vIqzaePP
 O0688rj9vRTSuwf7micc8W0FLB1pgpZZmLPsVjfnz/2L6tFAdfsOl6bIDK4nPMSAtQsT
 A46i3d3XPsxNvtRZrSElulLlYUVFy8FCBdifhI65YVoBVi+5xj19KhWK/12OGDirqJUs
 UWEyI3hZK5I65A6CAh78JMbv5JlLSqLbdTq4LGOFMfeMNJzXJW+7HWaxh79Xku6s13m4
 jkcQ==
X-Gm-Message-State: AOJu0Yx3/Km5XyRIkWBrDuc6WOAL7+QZDG6Kj6IVNHA6xMYUFwEaQUYv
 IC4Xy+8nA0kj8oSdv3ICH2qLt6G35HAB3CMMrYyZUn+QuArYfZpzknREa9gnUs+zGYPAgUrswd0
 Y7hKCkt6nmw==
X-Gm-Gg: ASbGncsB4vmYIJ3SQ+QV0Fy3kjCw3/dURhTaTmxSIAHTN22BFQU2SiqC4pbM8K+bPdW
 1c7+U+jUBI4eaJ5veG3l5r2DLjh5l6SRrImrhBqPmGj6JWAkaZiSfMuufKK/rbBFgeHaIhJnk4B
 j3tfKUQ/eMEpqMiW39cV8KYUzJer5DereSVaEDkVoDhnvupiMF2F/xL/cS4mYgTSRZ1xu4ydwId
 96iLHMrz8sc3MRNWhXoZVCXyWcGgBjsq5FcOeVMFyfWfcNRZ3NgVCiHmedxpg+y4tKTV7F0WGjh
 wCrbMtaKiNtqjF30tT93pzZ254iYBIBOyIwe4DI+XN6mzf7PkIOqARVstzJERHzN4xGAKDrp3Wy
 VX4vSHxSx+TZMH/9WO0WssF5UKTtMzQ+L2gf/4A9ReR3BZH4EcULhzgaErkg2Q+740MKzHZ+GSF
 mi5Ctf+mtU3B9aF/0oglPmPn0+wFTJivCIKCMyk+pUdd/nDuXiJiVIYPGBybC+d3Pf48qcogs=
X-Google-Smtp-Source: AGHT+IEiVpF5o+SfyjWN7bCv64a0BsvPVLLknCQNWUQyyXwxLPUetlS8IgypNYrMqQE9+aneNqCs1Q==
X-Received: by 2002:a05:6000:2210:b0:42b:4961:eb4c with SMTP id
 ffacd0b85a97d-42e0f1d57f9mr2509092f8f.1.1764068098723; 
 Tue, 25 Nov 2025 02:54:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363e4sm34060597f8f.12.2025.11.25.02.54.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 02:54:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH-for-11.0 03/12] target/rx: Use little-endian variant of
 cpu_ld/st_data*()
Date: Tue, 25 Nov 2025 11:54:24 +0100
Message-ID: <20251125105434.92355-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125105434.92355-1-philmd@linaro.org>
References: <20251125105434.92355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

We only build the RX target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=rx; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/helper.c    | 14 +++++++-------
 target/rx/op_helper.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index e9a7aaf610d..83cd491eb4a 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -68,10 +68,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
     } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
-        env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
+        cpu_stl_le_data(env, env->isp, env->pc);
+        env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
         env->psw_ipl = env->ack_ipl;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         qemu_set_irq(env->ack, env->ack_irq);
@@ -82,14 +82,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         const char *expname = "unknown exception";
 
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
+        cpu_stl_le_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
+            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
         } else {
-            env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
+            env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         }
 
         if (vec == 30) {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 2b190a4b2cf..ca3e9e85fc7 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -217,20 +217,20 @@ void helper_scmpu(CPURXState *env)
 static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static void (* const cpu_stfn[])(CPUArchState *env,
                                  abi_ptr ptr,
                                  uint32_t val,
                                  uintptr_t retaddr) = {
-    cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
+    cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
 };
 
 void helper_sstr(CPURXState *env, uint32_t sz)
-- 
2.51.0


