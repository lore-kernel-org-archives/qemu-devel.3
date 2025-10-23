Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45497CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwM6-0003kc-Ar; Thu, 23 Oct 2025 10:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLm-0003U8-K4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLj-0001wa-UE
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso9838385e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229888; x=1761834688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFhev+ViAFFSzJ1smEp5sPV4YLk7YFAUxT1dvo2z6os=;
 b=Vc8fux/DnvK2CVBEkrofYfoYRjPXrCUfrqGMvjTmjmfAFL36JL2k8EN6AMQy+qPSKJ
 6Rcl0+vkfV+fJz/LAbD+bX9te78CgTvf7p/h4uMLlS9MpdmmhjOSkCO7IkcxqRwla3AF
 7WCKrB/90TU6FJ9Q83VuRVAxCwukjaZXU3kFM2W3Cv9vAFbIkLCWY0x/BA+0J3koRKD8
 jL+gX+8MvQF1cvGfB5xUgonhJpjmpg+d9HTx0DCIxCSVRhRCVD7GX5EwJ+oCCz8zXE/R
 fCsLry832hszI+HZIRkfDo6fB6H+qc4jC1rPZLY6gE3k2zuFXHNpgf3B292zQ9LsGlQj
 DCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229888; x=1761834688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFhev+ViAFFSzJ1smEp5sPV4YLk7YFAUxT1dvo2z6os=;
 b=S+6ZUsReSUl37T5cEClgVpmZPrPhWriJE1GN88KsgwVp9/uBtIRn3IgVW1rnJ+CkZx
 ogEsJw0aVs8bjuHPvd88cs8E9gOJcQd+z0s+4NBvtE53j56mh8GD5RRysnTqheiz47Uk
 9wOMgC/0HZJWK03a0YbabiDEWUJbAvpWuxgawQWE/73ryj4b0CMwbYplDkolB+t0aqmp
 Pho9s2SdJx0DBVmSj05hzs/JhBMM8Jo618kIGfF0dqBX/S7U6lxUk+bSVfzDJ6ZARiGt
 tCxZUn43PrtYf3mmBTV04XM7N/zlD7HCYjlhhT6tca1hEpPYQiAjNX53u+qvQz42T7Ko
 cmgA==
X-Gm-Message-State: AOJu0Yyc+xcsKnhwnM38fjqGxl0DlfOk1CmuInaw3hXToYqDzmkkqL8i
 SOtL+38uJw4Hr00vvAoltdPN3jvLQOORvCAqG6R7zoZtoyJTcpHyDLvZc7k53E1vbVUllCtZT7j
 AZ1gliTs=
X-Gm-Gg: ASbGncsA7na5adjbp0XnYaQhRPGCdfiZLUsOSyf63rb12p1Of3TqrqZPP8PkmFBSPRc
 PDfYXcK+U4ec5U3UccZ+iCrMcpAWC+4uzMVxHcKFk2c/cnn8I4WDFsvN1/6yEuasBon0FkRfCbk
 F5bmfEIGiakiWtOjQqMOxzHPIYylOYoAhGuhChQ75wKguiMSLQ+Cfogr1csUl7L1IMIE8LciT9Y
 EpzeFU0lvVn3DccnfRi3BiVbOlekG+S7RPo8wVLrs95URkQYx9iKn/YF23rgcJ249nG1wjcQ31M
 a6FoUwp5rYet1svRlw+iUhcyxxZvyo0aZJ+0g2h5Lyf0LKrG1RCPffheE5jx50ctF4IZC1PgyJr
 f0HjEkRq/jchhgfQLIXgM8TCyz0QVF4vRgv+uo4yBUL1EaQLf8o5Ynx/KXVuVeNC724BNeyqX4F
 3roncj8Pqd8gWTMjEPJmhbJhV/qFKRRS1b81NZAP0tcErzTN0JmqMWaEYcDqF5
X-Google-Smtp-Source: AGHT+IHLCbPhLK0OETPXNsA0ERP9FAWdgE/yyVv0Ft8DsIb6D6FvGIBsUSqzKt1hfp9wAe9yAHmt0w==
X-Received: by 2002:a05:600c:871a:b0:46e:4882:94c7 with SMTP id
 5b1f17b1804b1-471179177camr197047985e9.28.1761229887851; 
 Thu, 23 Oct 2025 07:31:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caea0468sm42531815e9.8.2025.10.23.07.31.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:31:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 27/58] target/arm/hvf: Rename 'vgic' -> 'emu_reginfo' in
 trace events
Date: Thu, 23 Oct 2025 16:30:48 +0200
Message-ID: <20251023143051.11195-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In order to extend the trace events to other registers,
rename and pass the register group as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c        | 14 ++++++++------
 target/arm/hvf/trace-events |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c882f4c89cf..26bafee259e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1149,7 +1149,8 @@ static uint32_t hvf_reg2cp_reg(uint32_t reg)
                               (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
 }
 
-static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
+static bool hvf_sysreg_read_cp(CPUState *cpu, const char *cpname,
+                               uint32_t reg, uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1172,7 +1173,7 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
         } else {
             *val = raw_read(env, ri);
         }
-        trace_hvf_vgic_read(ri->name, *val);
+        trace_hvf_emu_reginfo_read(cpname, ri->name, *val);
         return true;
     }
 
@@ -1261,7 +1262,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (hvf_sysreg_read_cp(cpu, reg, val)) {
+        if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
         }
         break;
@@ -1432,7 +1433,8 @@ static void pmswinc_write(CPUARMState *env, uint64_t value)
     }
 }
 
-static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
+static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
+                                uint32_t reg, uint64_t val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1455,7 +1457,7 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
             raw_write(env, ri, val);
         }
 
-        trace_hvf_vgic_write(ri->name, val);
+        trace_hvf_emu_reginfo_write(cpname, ri->name, val);
         return true;
     }
 
@@ -1581,7 +1583,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (hvf_sysreg_write_cp(cpu, reg, val)) {
+        if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
         }
         break;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index 538af6e0707..29387780e3f 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -9,7 +9,7 @@ hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PR
 hvf_unknown_smc(uint64_t x0) "unknown SMC! 0x%016"PRIx64
 hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%x pc=0x%"PRIx64"]"
 hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
-hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
-hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
+hvf_emu_reginfo_write(const char *cpname, const char *regname, uint64_t val) "[%s] write to %s [val=0x%016"PRIx64"]"
+hvf_emu_reginfo_read(const char *cpname, const char *regname, uint64_t val) "[%s] read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
 hvf_kick_vcpu_thread(unsigned cpuidx, bool stop) "cpu:%u stop:%u"
-- 
2.51.0


