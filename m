Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43764CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7S-0008A6-1t; Sat, 30 Aug 2025 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urt9H-0007Dn-Lo
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:03:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urt9D-0004bR-Qj
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:03:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so10363695e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756451022; x=1757055822; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nAVy79qT+VRU3NUV4NcmYczu3zKLjpOZKa36nQp76eo=;
 b=yimbYOeZW1SiIZxeZMWpjDK/GwZt9xhrVrvtfD6W4jq42G6Fl3mD8bfY40lWJTyy4o
 j440B32cZUEM/NNz9z1OTolXzE+U5eCaoWjiFMLSaN/+9nqJxKGgRva/J771TC8VnLkO
 jVZ/QHdo+grdNthUbHWCfgA/5FuhADdsLqiKaepnOlUwHlbAoH9liPPE5oTajJk/rLEo
 rJFq1BVTAa8yGLy2GhNYbv+v+wE8qCyAEtGwA/30Ez6XUBz7YZPhu0J9F9qZkhPYx+eO
 lhXdH9Wr3t2MQWbvPOs3rLHlkfPwC4Jh/vtc/3H09PGGOgQ37pfzCDznfLexIQJ+GZhM
 tUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756451022; x=1757055822;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAVy79qT+VRU3NUV4NcmYczu3zKLjpOZKa36nQp76eo=;
 b=j663+jzxV1go5ckdiBYvo4nhA7TGz1lQLJxgtDTFqI0LjscYo5YDp5LuqCp5O7+b5U
 DulgBScc4RLMPy5DOWbL94sDwcvw/Ui1AbJ5t0gAaq2Gqxfx/0igM2SbXahM1ju2oUuf
 Y39IYJbWt+b7VdX7dTI/AuqX85KZqFH7Jv7gfuiNb2pOSNZJEDT2SQffx9Q6WYfNR8Wg
 Sxk0NNdp8VAqN8ekWvneAMPnRmFN4vF2I57LH1Y+kVrdU1vHDb5GE1+P/D46TKthc7CZ
 ymzIOoOamOUN78Y0c9UEAlnt2DOulxq8Whlm0r6+R09N0UQBY7dpdWLQndQ5G8hJtGxN
 09cw==
X-Gm-Message-State: AOJu0YyqE2SUYE9cnk8dHzAcbPBVLbai0u8363zGC9Z8YAwQAECWEiWO
 J6wEHlV0FX+1MKb/vLlI9VvQBm4SVLVhP/usMy7usS2iM+oEJGnRM0i4SZzTXzHjx+sI2mC7xYw
 PVdugS7I=
X-Gm-Gg: ASbGncscGqnQD5veuLl5L7JWoImDQrKSuC8tuh3hoRSaycg/G4bLMQEUodrYryB1aUy
 bQAfwEC1BT6GJus5NCBcKGH4cA7FI2yBCXohRpPAN6r4z64n0wJfE3U4ePssCfobiPBOKK+blMm
 YsWg/CiE8cbLRFMLgxPQljKseJBhailDbkpqZ/Ze261BQHN/o1WgmysBNphe45O/DtLjsGdjGBp
 3TG7doXhsG5Ke376xI8FyFlFA29y5eQeCc5cxMxbTlwq1xO7JPMpgNLHY4ZzU6dcnnAbJ+RAx6K
 OavpNSxej3zITGn+kYzePSwDv4m5a/9w/JWbPjyZFcAIBCfvl7T7wCuh3OSfs0nvDxNlxQ62NsI
 InPJTB7+4hV59d359JFYM/8ruAhNplE0qKZ8OsJG+o58UVMUml0s3kJN2o9Rbc+5nIzwNR7Q/aq
 lVnQlocoo=
X-Google-Smtp-Source: AGHT+IF0M6v6tWEMQ3+/dIGk6rqWMEzVMDZLzBo2z0mTftjlHCA+Qjn7YC9F812AnUVevX/ewc2k3Q==
X-Received: by 2002:a05:600c:4451:b0:45b:43cc:e558 with SMTP id
 5b1f17b1804b1-45b517cba3bmr218371165e9.35.1756451021607; 
 Fri, 29 Aug 2025 00:03:41 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b81a9e971sm6511175e9.18.2025.08.29.00.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:03:41 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:00:45 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 06/61] target/arm/hvf: Remove hvf_sreg_match.key
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-9-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-9-richard.henderson@linaro.org>
Message-ID: <t1qua4.2jl6eivk2f8kt@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Wed, 27 Aug 2025 04:03, Richard Henderson <richard.henderson@linaro.org> wrote:
>Use conversion functions instead of table lookup.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/hvf/hvf.c | 35 +++++++++++++++++++----------------
> 1 file changed, 19 insertions(+), 16 deletions(-)
>
>diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>index 47165bd29c..5fcfa9a999 100644
>--- a/target/arm/hvf/hvf.c
>+++ b/target/arm/hvf/hvf.c
>@@ -152,9 +152,6 @@ void hvf_arm_init_debug(void)
>         g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
> }
> 
>-#define HVF_SYSREG(crn, crm, op0, op1, op2) \
>-        ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
>-
> #define SYSREG_OP0_SHIFT      20
> #define SYSREG_OP0_MASK       0x3
> #define SYSREG_OP0(sysreg)    ((sysreg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK)
>@@ -399,7 +396,6 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
> 
> struct hvf_sreg_match {
>     int reg;
>-    uint32_t key;
>     uint32_t cp_idx;
> };
> 
>@@ -423,8 +419,7 @@ struct hvf_sreg_match {
> 
> #undef DEF_SYSREG
> 
>-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2) \
>-    { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
>+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  { HVF_ID },
> 
> static struct hvf_sreg_match hvf_sreg_match[] = {
> #include "sysreg.c.inc"
>@@ -469,13 +464,16 @@ int hvf_get_registers(CPUState *cpu)
>     pstate_write(env, val);
> 
>     for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
>+        int hvf_id = hvf_sreg_match[i].reg;
>+        uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
>+
>         if (hvf_sreg_match[i].cp_idx == -1) {
>             continue;
>         }
> 
>         if (cpu->accel->guest_debug_enabled) {
>             /* Handle debug registers */
>-            switch (hvf_sreg_match[i].reg) {
>+            switch (hvf_id) {
>             case HV_SYS_REG_DBGBVR0_EL1:
>             case HV_SYS_REG_DBGBCR0_EL1:
>             case HV_SYS_REG_DBGWVR0_EL1:
>@@ -549,8 +547,10 @@ int hvf_get_registers(CPUState *cpu)
>                  * vCPU but simply keep the values from the previous
>                  * environment.
>                  */
>-                const ARMCPRegInfo *ri;
>-                ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_sreg_match[i].key);
>+                uint32_t key = kvm_to_cpreg_id(kvm_id);
>+                const ARMCPRegInfo *ri =
>+                    get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>+
>                 val = read_raw_cp_reg(env, ri);
> 
>                 arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
>@@ -559,7 +559,7 @@ int hvf_get_registers(CPUState *cpu)
>             }
>         }
> 
>-        ret = hv_vcpu_get_sys_reg(cpu->accel->fd, hvf_sreg_match[i].reg, &val);
>+        ret = hv_vcpu_get_sys_reg(cpu->accel->fd, hvf_id, &val);
>         assert_hvf_ok(ret);
> 
>         arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
>@@ -606,13 +606,15 @@ int hvf_put_registers(CPUState *cpu)
> 
>     assert(write_cpustate_to_list(arm_cpu, false));
>     for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
>+        int hvf_id = hvf_sreg_match[i].reg;
>+
>         if (hvf_sreg_match[i].cp_idx == -1) {
>             continue;
>         }
> 
>         if (cpu->accel->guest_debug_enabled) {
>             /* Handle debug registers */
>-            switch (hvf_sreg_match[i].reg) {
>+            switch (hvf_id) {
>             case HV_SYS_REG_DBGBVR0_EL1:
>             case HV_SYS_REG_DBGBCR0_EL1:
>             case HV_SYS_REG_DBGWVR0_EL1:
>@@ -687,7 +689,7 @@ int hvf_put_registers(CPUState *cpu)
>         }
> 
>         val = arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx];
>-        ret = hv_vcpu_set_sys_reg(cpu->accel->fd, hvf_sreg_match[i].reg, val);
>+        ret = hv_vcpu_set_sys_reg(cpu->accel->fd, hvf_id, val);
>         assert_hvf_ok(ret);
>     }
> 
>@@ -922,14 +924,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> 
>     /* Populate cp list for all known sysregs */
>     for (i = 0; i < sregs_match_len; i++) {
>-        const ARMCPRegInfo *ri;
>-        uint32_t key = hvf_sreg_match[i].key;
>+        int hvf_id = hvf_sreg_match[i].reg;
>+        uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
>+        uint32_t key = kvm_to_cpreg_id(kvm_id);
>+        const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> 
>-        ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>         if (ri) {
>             assert(!(ri->type & ARM_CP_NO_RAW));
>             hvf_sreg_match[i].cp_idx = sregs_cnt;
>-            arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
>+            arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
>         } else {
>             hvf_sreg_match[i].cp_idx = -1;
>         }
>-- 
>2.43.0
>
>

