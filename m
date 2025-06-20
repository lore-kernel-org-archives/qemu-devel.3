Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19CCC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTO-0002Za-Dj; Fri, 20 Jun 2025 09:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTM-0002YG-NE
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTK-0004a6-VG
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4530921461aso15623115e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424877; x=1751029677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyHQEfn6inWyZRMUVI/8b1HegzN318xDx/IKxFDD3c0=;
 b=reQtFOxdZrO2AIStYH0aWZCh1TJOcskhZPBWMnOLhfty/lUoEGlSwigAXToc8ngw3m
 Om+nC8u4eYjH3EdQgeobe9f9c4GgbVciBKI5F1N03KTiAjBHF6Pj+LK+ZVctmA6/uUkH
 wl6A7jeKqxCHWZ2E0+8n8dC/ERX9oaMemhOCjg2ZMIe/UlVA/v7QbKzakPqVuq1xC6QH
 u1C+0/W9LB2ABHtrR2gxSu/CC0M7xsPLkt2mrQ6OsojSJprjXOIBCgoH66egUFiyBuWN
 zMUGlxFXWsnB3opCewYOqF09jFWT+mfId1QbSQY5kME5miwhSHfiztXpMpeLmwMjyZu3
 ysDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424877; x=1751029677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyHQEfn6inWyZRMUVI/8b1HegzN318xDx/IKxFDD3c0=;
 b=RiJlgFHbTrDllqkADWwcxzQObj/Jhu+bQICJ/GXtQyZYN/S/edqKtEmc0nUiucwm2C
 OffNHonNBH9fLp7tJ8I6qYKnPOxgjJ+Z9ynmLMYNDrKsMlPeGZ6r4MZqLCTm+hziSveW
 M1WV0MkcWLDlm2WxB4TaDb08oiklMXYA+mVaEPPZiT+KZSDC+KVq+spUM64xMOQQ9nYu
 sGNvBtLsVCoDk9CzY2IK2HHCjx0+JsOFYdt2/KRCFPg6FVaZ0kz0ZKOfI8aXvGbUwjTh
 9/utX61JbK5Ncl/2vO//N6bqrdbU8YNbTRKX3lbleqnXbVbq0WccgS9soJ+8wprVCwHw
 nAXQ==
X-Gm-Message-State: AOJu0YyK0q44wgzTqzH9ph5uyagGwca8yJBxIBcuO2q/417fefz3Sqr4
 t4NimUHLDPsOhCJaOTnG5MDMvPkCaKXUWOJYocF0SS6YWqEcpzuU7xwaGsqKQVKAdaPapUBJbWR
 AgLpRCZI=
X-Gm-Gg: ASbGncuHP3BCbOeG6/Sa2UN/4OMJPlAnJpqeR9G6+y+mAnoiIFk5zKJyqc5F0gyMgS7
 UUyf44RTGJou3PqqVdipXTvmkG/f31KbJmPDFqcE9T1te7N6FpOtah+pn9uxrMJQ1pymUCO9qvN
 6RlQIa4vD0BhFdY1hM/fTrL/6LE9LLSpNJeRXjFRMoi6vr0GXLcQV+enjZ8Wwr9AS7H9bvSHJG5
 dcljXaM+lHc2SyKV0tSwTLmtF0VPTGYW3VvY6/LFENFqIrecbQ66vRsP9mu7aELpzNpvg7b12Oz
 42XGDzoCqH/XdHD26Y+6PsGXKKSRtbQgR4nshbT/6xgJy0TMq078t5PSqP17YErzG+Op6Z3eZIR
 TMoVjM2701PV7+WG+xgjRa93Gzu6FpNqQ1pJ9
X-Google-Smtp-Source: AGHT+IGkXs40WMIJKGNMuEiJnfxX7/z7m/pHzk9ne+NytzMGvZpK0RzUyqBP8SLCEpCnawa9dPBjrg==
X-Received: by 2002:a05:600c:3b14:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-4536539c469mr27259205e9.12.1750424876897; 
 Fri, 20 Jun 2025 06:07:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8c16sm58396345e9.19.2025.06.20.06.07.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 08/26] target/arm/hvf: Log $pc in hvf_unknown_hvc() trace
 event
Date: Fri, 20 Jun 2025 15:06:51 +0200
Message-ID: <20250620130709.31073-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Tracing $PC for unknown HVC instructions to not have to
look at the disassembled flow of instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 4 ++--
 target/arm/hvf/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index cc5bbc155d2..d4c58516e8b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2071,12 +2071,12 @@ int hvf_vcpu_exec(CPUState *cpu)
         cpu_synchronize_state(cpu);
         if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
             if (!hvf_handle_psci_call(cpu)) {
-                trace_hvf_unknown_hvc(env->xregs[0]);
+                trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
         } else {
-            trace_hvf_unknown_hvc(env->xregs[0]);
+            trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
         }
         break;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index a4870e0a5c4..b49746f28d1 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -5,10 +5,10 @@ hvf_inject_irq(void) "injecting IRQ"
 hvf_data_abort(uint64_t pc, uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [pc=0x%"PRIx64" va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
 hvf_sysreg_read(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg read 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d) = 0x%016"PRIx64
 hvf_sysreg_write(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg write 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d, val=0x%016"PRIx64")"
-hvf_unknown_hvc(uint64_t x0) "unknown HVC! 0x%016"PRIx64
+hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PRIx64
 hvf_unknown_smc(uint64_t x0) "unknown SMC! 0x%016"PRIx64
 hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%x pc=0x%"PRIx64"]"
-hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpu=0x%x"
+hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
-- 
2.49.0


