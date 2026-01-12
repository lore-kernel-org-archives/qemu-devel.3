Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE347C9EC63
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDe-0004Kc-Ai; Mon, 12 Jan 2026 05:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDc-00048E-1v
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDa-0001rV-IH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so33800895e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213933; x=1768818733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjaoEA0EYqF5t3dZz3vxcYiQNespCzrnVtF3goBx/A8=;
 b=uN+ERW6f8oFkM9ypruC6ESi3uqTWZ1Dhi2dUOKOShg8SD8Rw009PSVGjEDCfeL6v11
 U1WsxK8Uf18EeSkOzaapLfWRUkeZjTiV9FzfH32bBb5es3kByLtZsYNpwiHAtzYWOOXQ
 Q02x7x/dYbXeuAPLEeC83X8pPSlOy9Vsil9e3OYpNWTDUM/6jAFJAzmEBWLgh86lwouD
 mDTV+hUSXtim34oeTVgVz/tmC+4ixtZ8opeNDIrja5A4hjUlrXms5fbB67MTffYiLmGB
 D2Xr9Vx6ZEPBPHA/qqYkoCjaxzy1mYAjFOZj0ZLWwa2IeVdTPGpkvdYjxjkUfp697IMO
 8O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213933; x=1768818733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rjaoEA0EYqF5t3dZz3vxcYiQNespCzrnVtF3goBx/A8=;
 b=paDLqMAIh1qE5TVMy/atSg0Yjr4xm9oUHruwFWIz+9DfJyjwJVw+Cuv3x5t4oXNhbb
 xDzxkmPrhTn1z+qdoPsoz6CZLiEyoJo42xNqmQtBTm4Z9PurELBtkR5eWxr3OF3ipX/z
 F6f6Osr6HdOwbmN+jNYoD4hwGN8wdOzjK2G3T0Amntmcs9YQ79UEpxUjEitNwV/dNznc
 JbkLIUy9lM18yKc5yddjl8i93/64Cn44nO8P0A1f8h3rV6dR/uFLRLIBJJh2Y+N7pvsu
 ZbNBAlzhhHSGqkHl+v2p1eJFUBRtCuyJmKsSN984COg7r+cC1gkxr8fSfvFFtEfI52HL
 Mn/A==
X-Gm-Message-State: AOJu0YxngY20/kWQ2lUcMBYvzmP1iTmdKN1YL3Pa+tCWtfZEfkPuOKWl
 W/aYEDNNaSLg9sAGEtCZOG89MSx4DmH/DMVWWs3S2EZNEpJUfjwcJ7cua8hzBGwwZqMboIQmOlp
 FqNuQ5aI=
X-Gm-Gg: AY/fxX4bDWTc9YJamm7MZf94WV9vpLtsHkf7p/3FCac2/noqQ/tf3A6KIzq1jXJzZpQ
 dCdcRLAh6y0cDp32wQ/xezCbcm+UBlH5WmJ5TiTRGxUQ14LEST21UaZjYGYKTUZQqcTdUyYJYKW
 YSwPS+jQ2VF0JWl542WCJUod+GFqIxwJhcjn/UFd6OMAu2cto9UWf/KcVjzXq/sNc7mq++sNIIc
 VgIWXcuBptRsLUTXFudVUnBbwNrqZAs36Hq/+CIRq0SkVKsRXnPM9rejbZW1085oHckepkljPYB
 rnelRSphoQn2WvpTe8U5SRmULThXfAdUUGl7TMwVST3mCYYK94nd6iA90EwjKAYJMiwH5IVYm1D
 63zPS3c9JkMM4OJrgxxbrRnnGLJBehb8yY3o52pr1QFaaqPWBPeQXlOs7e0cFLggoLl+Ng+XX4y
 qJdBZZODLaSePNhCcChMVmXm3MtjoED0CrDQNTAyqRHQ59H0Op/KWS35Ij38fm
X-Google-Smtp-Source: AGHT+IEMjMzNaieUA9OkBkUtVScBvDnU91mR5fqPmcrycAex2vTHoPUSaj+ydDzqxO7u19mBmRf6fg==
X-Received: by 2002:a05:600c:3b05:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-47d84877e51mr211876665e9.13.1768213932812; 
 Mon, 12 Jan 2026 02:32:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6f0e15sm345226605e9.10.2026.01.12.02.32.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:32:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 14/19] accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
Date: Mon, 12 Jan 2026 11:30:28 +0100
Message-ID: <20260112103034.65310-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Return EXCP_HLT to the main loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/hvf/hvf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b936098d257..718414cc53c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -301,8 +301,6 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
-static int hvf_wfi(CPUState *cpu);
-
 static uint32_t chosen_ipa_bit_size;
 
 typedef struct HVFVTimer {
@@ -1008,7 +1006,7 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
  * Returns 0 on success
  *         -1 when the PSCI call is unknown,
  */
-static bool hvf_handle_psci_call(CPUState *cpu)
+static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1091,9 +1089,8 @@ static bool hvf_handle_psci_call(CPUState *cpu)
             ret = QEMU_PSCI_RET_INVALID_PARAMS;
             break;
         }
-        /* Powerdown is not supported, we always go into WFI */
         env->xregs[0] = 0;
-        hvf_wfi(cpu);
+        *excp_ret = EXCP_HLT;
         break;
     case QEMU_PSCI_0_1_FN_MIGRATE:
     case QEMU_PSCI_0_2_FN_MIGRATE:
@@ -1910,7 +1907,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         cpu_synchronize_state(cpu);
         if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
             /* Do NOT advance $pc for HVC */
-            if (!hvf_handle_psci_call(cpu)) {
+            if (!hvf_handle_psci_call(cpu, &ret)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
@@ -1927,7 +1924,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
-            if (!hvf_handle_psci_call(cpu)) {
+            if (!hvf_handle_psci_call(cpu, &ret)) {
                 trace_hvf_unknown_smc(env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
-- 
2.52.0


