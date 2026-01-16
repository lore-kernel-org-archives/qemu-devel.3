Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F241D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghst-0003Qa-5b; Fri, 16 Jan 2026 06:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsb-0002Oi-Pa
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:42 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsW-000742-3W
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1000663f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562430; x=1769167230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1AA9O3Oy1LC1a26OjN56Jb2vi15fizc8/aL/r4eofks=;
 b=ZuyWhUOyguuLZOStiae4K8GaF44VpLBKPinx27dub8Tjv8s+nFsOvtI9dkMUopuDkZ
 cjBNxpmUlIjWPPu7oepkcLRTy7ZvrHWuYjCm3AK7qeLVtFWtTMpo8ZNjbDpmQq/zcyqM
 06PwFnV7cd1xUX8PmeZB4Bl9ayDerZ9wRHVpa3IZ6kl++a7++in+Xyab6Or9cqjIWN/B
 RL6qy+FYxch5Z0TYd/OJXwy7cWHk0uBAnhwxKtaoXiBBSAaOSIT5AC+DkNyBOvV99B+T
 Vq8i1Miot4l1TeqAWzpvAUYGPQhX/285GxtnGMdC6Gzig+PYdD3zJu3qw7gTSJfNV0Br
 6SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562430; x=1769167230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1AA9O3Oy1LC1a26OjN56Jb2vi15fizc8/aL/r4eofks=;
 b=UJPjENBprRsz4xo0VzhMmICwhqDpKclpsZR6gQusWZ4plyeAvfL4PMXU3kcrXEiUg2
 pOOTEl1x5csaitMjeqhiEpSkYZY/uMOotOoM8Kma503V29dhH9E+jL4Q7MRDSSHyMTMO
 BMWw50NfgvIehrufC0DliwCb6otsqpPzyoMqh/zkTC0+68iaybn7f8lWZnG/lfjssvPB
 Re1d51Vz7sgYbh99mD9pOlnAksoEoDds9cpgO+bwgIEneRlRGPyBZsp5M9VGYLd2Jduf
 wC5c9NV3eZcnTlqnHvo8RT8sYsNF1ZBJ5Ph2DYnAgmnP+y+eoMYi7irtFpW4bwnnjfvr
 RV5A==
X-Gm-Message-State: AOJu0YwbtKIF1cKRvPHjws6E98O1wBZc68EHRjMpt9rKQjyaRVm0lTPR
 uf+1wd9GjNHishO3gJ2vOihDz+4wK3AhKlOoBg7Su8H2FnQRmBYaHPx3dSydPhQ7CUvYS2lrzUJ
 PQsWC/jc=
X-Gm-Gg: AY/fxX6Q1n5dXXflXRNJLBf3yro03vF8Q50/2mTmMUkmNCZcCAB4utMLEyOyoLnv2Ki
 IjfztpAeTJn00bSqTa90RhOGNkYdMk8Sqns+JHucCt2lEyb4HtXvSAdXbyvqFcD/B59fhhDyx46
 aLg2/pzkg7l+nZzp/QpdhZMIbTnDXfYc/spynt5oHrtrIahWP8WIFGrOAL4fgZ7sLBPAOysqmxX
 PdvGNLGFw1OZGX98XZYGc1wl9Glgl+KFoPneYttMvYktu2qKfO/+f0YB01Yys8cUblovULM0gU+
 4A70MIYMhMJy+ZeSsPsRwk9O0huEJR8ZTZVnINaC6R6R7Sm9d9Uci+MNny5K7+fFawtOsP8fY0+
 tGR4aqh1jwGtVa9lVVkNaMIMLRXzhCiyYNGbVB6u5W0y6/2r1jOogBegU5Nu6BxZL8WfP9lWwmp
 olX7coEhDbpZ8Qk1KG0i8CaylOW/kCMh7YCC/ldE6/nnMJwlKaTNkq+eD9R9tH
X-Received: by 2002:a05:6000:428a:b0:430:f23f:4bc5 with SMTP id
 ffacd0b85a97d-43569bc77a2mr3109141f8f.45.1768562430221; 
 Fri, 16 Jan 2026 03:20:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921facsm4594048f8f.5.2026.01.16.03.20.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/30] accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
Date: Fri, 16 Jan 2026 12:17:58 +0100
Message-ID: <20260116111807.36053-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-ID: <20260112103034.65310-15-philmd@linaro.org>
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


