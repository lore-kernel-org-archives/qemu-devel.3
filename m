Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47650C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2eW-0001T5-8r; Wed, 02 Jul 2025 14:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eO-0001Bm-7I
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eK-0002gi-3d
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453749af004so40600545e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482657; x=1752087457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbpcjy4o5ZUQnpuXjuYjR5B0wNodIi5DdAoNAkyy2SM=;
 b=GzP47Cs/KjDvZVYhVdlSAoGXCLUCt90GyKPfIimqyWVNtSpPnM0wdyXpY/gdmJukwq
 7f++BAljoEVIxZXAZ9OaK8NgVxw7ljw+Xtjx6hgs95IoFYVvOT81JRl8bAr6osMm8Cjd
 ctgUeotx1z8q++rLmrI7TPgULFq9MdQN/R7a4mRzCj23NvwgWlVuM/gS/40FHJLy7VoJ
 0T9AnFKvTN7ilSY7M+opQI4QCuefp5jnzhMneUGj1GD6vbjhY/YkYZwF7CQ2xBxuO1RJ
 NlMfoxy6sS17cT6w0H29Cz1AaiqV5Ox5+I3iK9ZCQajOQ3+8PgMewZSlDU+/k7oE5dGQ
 brBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482657; x=1752087457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbpcjy4o5ZUQnpuXjuYjR5B0wNodIi5DdAoNAkyy2SM=;
 b=fnfVzkh3VfdtV1othUmkDn7gfLWEt8JepGfYVdCo6OQBIrtJUTOPFLyH1l1xI34+KF
 LM3q0jnAX/mEguAI8nJGC6IKcsgTplUnKFSNCE+bpeEBL5oPXFvR1jrojw8Uras2VVR+
 bpOpeAm6JK6lJ/JNVOleLLMSIzvYHWmjhZ2FpwXGsBK5LEUOauDOZlToskmQZkZmM2JB
 4MpF2VNtjzW7CwxEnCv1Leqs6ZP16acILHuIlOvTgzyvM7+tQ7YDfxgvcbTvtqe4Xftl
 sGsKeV19laOiq9CW5MdWKZLYYwR1d/9dnP4PHJxzzTk9yO7gPZGhLlgPEhXdCShabg2g
 w4Ig==
X-Gm-Message-State: AOJu0Yym3JITlq31XOsvySq3g7k/7kRtyGz50/5hZdHLe4JFnqpT7+ew
 PnydKEXJLuSvIo9TIakH+fMcGukFel6Gvt+97kv2QANwAuX8C23NfIZOp9cQGDqcUt+6lwqiz9x
 MVg6r
X-Gm-Gg: ASbGncvQJtZRxjiCQmIrtd0BSJ9/g+D5cr6qihvm8uFN2BmSfgXJwg5ifoxUM5QDvSx
 aYK9X5zzTYD1Ww4Q+t1i7xZpagMiL2ZGy/k50JIc/aPvI2vfvs/1iD8alBigCjEAewyID+LUwcX
 LCBhWE/gxbBA3V9Go8+vxZ8E/bywpK5agTrgaIT02+1wxPLXJr7gHuyQ1UvXgjYIkIWMWTTZVb7
 G9nvWMti+n/xxev5KVOUnVK4xuhjfT4QP26zOJ2TjVN13MRjsKXLj7MxEyeXUopRz+JpgOj3fmx
 sacwVvmMFrrVHdgfFGoh332ZOYzVIeTyuQELUIZS6vsjC6Av/0bcOR6xtAk0Jc9UbIihnHajHgb
 fhNnDtzSuKVVFmIU35O2479ZyYpaJh9clGKzZ
X-Google-Smtp-Source: AGHT+IEgwotSVda5UvmeFEw7lmS1prrmGDTnN4mzVIUqw6QUVymWZGRsGXQ4Ab+NSjGmrHxIjZNUGQ==
X-Received: by 2002:a05:600c:3504:b0:453:a95:f07d with SMTP id
 5b1f17b1804b1-454a36e6310mr50420695e9.10.1751482656792; 
 Wed, 02 Jul 2025 11:57:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b1c2esm5568285e9.30.2025.07.02.11.57.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH v4 33/65] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Wed,  2 Jul 2025 20:52:55 +0200
Message-ID: <20250702185332.43650-34-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

No need for accel-specific @dirty field when we have
a generic one in CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hvf_int.h  |  1 -
 accel/hvf/hvf-accel-ops.c | 10 +++++-----
 target/arm/hvf/hvf.c      |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86hvf.c  |  2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index ea6730f255d..a8ee7c7dae6 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -62,7 +62,6 @@ struct AccelCPUState {
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
-    bool dirty;
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 319c30f703c..c91e18bc3dd 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -79,15 +79,15 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         hvf_get_registers(cpu);
-        cpu->accel->dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
 static void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -96,7 +96,7 @@ static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
     /* QEMU state is the reference, push it to HVF now and on next entry */
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
@@ -156,8 +156,8 @@ static int hvf_init_vcpu(CPUState *cpu)
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
-    cpu->accel->dirty = true;
     assert_hvf_ok(r);
+    cpu->vcpu_dirty = true;
 
     cpu->accel->guest_debug_enabled = false;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bd19a9f475d..44a831d004f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -813,9 +813,9 @@ int hvf_put_registers(CPUState *cpu)
 
 static void flush_cpu_state(CPUState *cpu)
 {
-    if (cpu->accel->dirty) {
+    if (cpu->vcpu_dirty) {
         hvf_put_registers(cpu);
-        cpu->accel->dirty = false;
+        cpu->vcpu_dirty = false;
     }
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index bcf30662bec..c893aaac1b0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -738,9 +738,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             hvf_put_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         if (hvf_inject_interrupts(cpu)) {
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 2057314892a..17fce1d3cdd 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -427,7 +427,7 @@ int hvf_process_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cs->accel->dirty) {
+    if (!cs->vcpu_dirty) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
-- 
2.49.0


