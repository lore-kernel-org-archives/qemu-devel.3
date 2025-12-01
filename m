Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C56BD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAUC-0007d9-7U; Mon, 01 Dec 2025 15:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQATw-0007bM-VU
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:26:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQATu-0002J3-1B
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:26:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so1464304f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620804; x=1765225604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fDtjI7a0Oqge7yI4/wLFX0iM/QnkuAdwHt2CsvEWEPE=;
 b=GQfqUYExnq3EdhnHc6h50VZQMpV5xgUYl9PsI4nS/8dOU0kCz821ksfUQ4h0F5feXJ
 emwE5u7JAjrSGSKXKjyND0kwLL4OcSD5G7oQjNa/cfzhhVwCL5A4x7lIN3jGIlLleGQs
 f2psIV3FC2RZlMbIkHKfLABEGkMXu9L+8dGKre58Nm03uSjZvLwmSLWCB+xTNCHPQHGY
 LiM4TVxOjYoceR6wGE/wnmWY/gc8QyMDpTCG4dkILaGDNLJJbiph0VLuKSDlIjdlDDmt
 vit1k/8Q7N7QQx/4EBHBh/NaNWjpxRfqjiGkGdA6neAOJxjl5mub55Lu3FNbtSbBM3xS
 sddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620804; x=1765225604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fDtjI7a0Oqge7yI4/wLFX0iM/QnkuAdwHt2CsvEWEPE=;
 b=l/0V2ex8J28XW/pbtAgd6+4OdZg3xP5vI/Coy0Dactu1ETk+GKl1iRA/wxChyaGrqA
 k9TwzUoE7UYpYKXbi+sMhuHbZXbw5tlGn32kyrEnZU9FH+4J2Okq4KL79zmRAfWg2mp6
 ovWpGxFIO+RjXyqT5BD5vDTtAeunRfE7NZvtdPnuUsbXCZ5LItj1S0xME0l4gSyHH3Gy
 B/WExdn8Niqd32tZxC43xaMGYHHcAFuZjfOd1MteOs3ZfFN6YVho8BvRePyaa5suJkwm
 y4/ac2lYgdCLSywzyR5UCCj9ZMO1cEUUsMH0jqA1eHSYk+LlVtEcvYIAG5C9pc5EIhmx
 mE8g==
X-Gm-Message-State: AOJu0YzHdrtKNAGeV06QwEBg6WWIuavgHiRVSsVohIMXAegzJXSdoOXH
 CbSoZdWUeoNAm+DYSQeA2PwiLP/kRUI8ZG0U/lmNsJZPsipbFxFd30aIVbCBPonC0kSDTvtYGkA
 KOP0zrPhZ0w==
X-Gm-Gg: ASbGncvSNAAHhW5getx96yN4dzGZLkn2cr99npP2pRT2vOv1RYe5PW27NqvSNKd9qdh
 mPIeSkJ42SEHcoTYII+1BWgHBzZLBcRAeko/OmZ8R5VcJsX+fniPMRO6Fu2wMlacG0uE06YlszE
 85Kl09vwcA6iAfIcGr2gnkK8xB19lsbUjskzVxaE+zSFvkRe42kXGk8INCgV7loARxH+k/L3n0E
 qMYEscIG4WaTs7bhbRMgWIcPi8X/DVvXVKFoMs2gSCboJ3ewidPPpv2Ll7nhMwkyid3zs63p0X9
 wKJG/8aPGjcHoUHtxKCYpRrhzSzQFbQP6UaHzcMcf47wUPDpQVPZCw0gHHuPYXZV73dXO+lfZP4
 jNHBjbyTlSQtw6Z3hnEjmm0JOO9fjFiFNWC0cUvqpYCRZrIE2SoEGVurlZjefy+uBFlvvM15I7X
 A7+zZlUWcSLTHXmWTgop203RcMq/WAMFSGQyCrRHF9Ys0SbBFKpTkwXBOV1kK9
X-Google-Smtp-Source: AGHT+IHmHnYcBUtVdDO86nss0q2wzBKR3xgfRaRBcxtj6NxHAEWWrsF27EN4nEWNpQB97p9d0Yjqkg==
X-Received: by 2002:a05:6000:4203:b0:429:c851:69bc with SMTP id
 ffacd0b85a97d-42e0f1fcecdmr27636233f8f.8.1764620803746; 
 Mon, 01 Dec 2025 12:26:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a4bbsm27439721f8f.21.2025.12.01.12.26.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Dec 2025 12:26:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] accel/hvf: Fix i386 HVF compilation failures
Date: Mon,  1 Dec 2025 21:26:34 +0100
Message-ID: <20251201202634.98188-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201202634.98188-1-philmd@linaro.org>
References: <20251201202634.98188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Recent changes introduced build errors in the i386 HVF backend:

 - ../accel/hvf/hvf-accel-ops.c:163:17: error: no member named 'guest_debug_enabled' in 'struct AccelCPUState'
   163 |     cpu->accel->guest_debug_enabled = false;

 - ../accel/hvf/hvf-accel-ops.c:151:51
   error: no member named 'unblock_ipi_mask' in 'struct AccelCPUState'

 - ../target/i386/hvf/hvf.c:736:5
   error: use of undeclared identifier 'rip'

 - ../target/i386/hvf/hvf.c:737:5
   error: use of undeclared identifier 'env'

This patch corrects the field usage and move identifier to correct
function ensuring successful compilation of the i386 HVF backend.

These issues were caused by:

Fixes: 2ad756383e1b (“accel/hvf: Restrict ARM-specific fields of AccelCPUState”)
Fixes: 2a21c9244740 (“target/i386/hvf: Factor hvf_handle_vmexit() out”)

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20251126094601.56403-1-phind.uet@gmail.com>
[PMD: Keep setting vcpu_dirty on AArch64]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Message-Id: <20251128085854.53539-1-phind.uet@gmail.com>
---
 accel/hvf/hvf-accel-ops.c | 5 ++---
 target/i386/hvf/hvf.c     | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3e5feecd8a7..e4c62522e10 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -148,10 +148,11 @@ static int hvf_init_vcpu(CPUState *cpu)
     sigact.sa_handler = dummy_signal;
     sigaction(SIG_IPI, &sigact, NULL);
 
+#ifdef __aarch64__
     pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
     sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
+    cpu->accel->guest_debug_enabled = false;
 
-#ifdef __aarch64__
     r = hv_vcpu_create(&cpu->accel->fd,
                        (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
 #else
@@ -160,8 +161,6 @@ static int hvf_init_vcpu(CPUState *cpu)
     assert_hvf_ok(r);
     cpu->vcpu_dirty = true;
 
-    cpu->accel->guest_debug_enabled = false;
-
     return hvf_arch_init_vcpu(cpu);
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 16febbac48f..2023a7bfbb0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -728,7 +728,8 @@ static int hvf_handle_vmexit(CPUState *cpu)
     uint64_t exit_qual = rvmcs(cpu->accel->fd, VMCS_EXIT_QUALIFICATION);
     uint32_t ins_len = (uint32_t)rvmcs(cpu->accel->fd,
                                        VMCS_EXIT_INSTRUCTION_LENGTH);
-
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t rip = 0;
     uint64_t idtvec_info = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
     int ret = 0;
 
@@ -966,10 +967,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
 
 int hvf_arch_vcpu_exec(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
     int ret = 0;
-    uint64_t rip = 0;
 
     if (hvf_process_events(cpu)) {
         return EXCP_HLT;
-- 
2.51.0


