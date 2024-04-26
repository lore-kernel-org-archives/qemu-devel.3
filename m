Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D49CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RUu-0006c8-43; Fri, 26 Apr 2024 15:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUX-0003sT-Fb
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:17 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUU-0003Yc-CD
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so2601944a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160652; x=1714765452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qa1f/IUXOXDzam0s/oPvMcTs9laXpRm0rBkY9PGU7o4=;
 b=Qz99Ul1auSLLbpesj85n+v7q8ur+r9QQJWbQbRTA8K9gGd2/eNGPc+6Jvg027fA/vR
 LlK6W+w+Jiq8gKWvKJqDED+IvjbR/f0gsxSlbZjJ+kOvSXWM7PhbCXxbg6VS5k0UK7TP
 V3WVA63eW9fnGhRfl5yrnslTzYZq0aAVAi0/VYf8IvJLOrj9zNrAuIYYndK/XuYPaAt1
 Uj9CvcNuG6c1OV0JJZ5aQINacJUSww1NDU+ck1iJM4NNnh/vM7DAp/fy+UykG7Ebv8z6
 Y2uDt3UaGyltaPlbgWvGkSpnXgk9iyDAY1cmm2EgLWrUfk868+ujxJVo0HfVANPEQMVP
 5e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160652; x=1714765452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qa1f/IUXOXDzam0s/oPvMcTs9laXpRm0rBkY9PGU7o4=;
 b=USt0J+NS7oJn3wlCOqJBHoUjElCaLhJILxrWDP8pKQbkwRGF0WFk4s4YMNJJLcslzm
 DTrzytnumDGosmohzqp3C3xnh2JGOtH1GuO+he2Hz9jqywnVjD+mLdxxAuv26DemGfZW
 5pe1JS0/j7uoIUsINv7yIlieqlCLS9N5HyHokgXBYc29GYeY5yiMo9l1FdAaD49ZOLRR
 oMrZzgT3WaVFzymr2n1Wjs+tx+lCO+wgOJF5SvEu2ek6gp1NgwhZU/AZLfoEy9tohxhS
 3RTRLKMKcqs6PVtp/dVwfatLXG7NtLxM0ODYxpjtnnSupQrO7E6RXcO0LlntG6QJeZ1D
 BPCQ==
X-Gm-Message-State: AOJu0YwHpPMED4dmWMv4CeggXBTmAxjRAWcgxgFs5qRe3aVMscGQ84/X
 sbue9ZwFwWQMAwLnAajtbuQLA1QFpkiCjU6/ecLI3BaV3dHW68lcKqkOkEewTJUobaFmnQQz3Mw
 TUY4=
X-Google-Smtp-Source: AGHT+IEWjpdROkVC/dGaUyVHdKRub6lZn7ILmq4HxD3+qnMmZ8YoDYAhb2tuxEYCkhy7CRw/gP9Sjg==
X-Received: by 2002:a17:907:9694:b0:a58:bb3e:937b with SMTP id
 hd20-20020a170907969400b00a58bb3e937bmr3498283ejc.63.1714160652042; 
 Fri, 26 Apr 2024 12:44:12 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 dk21-20020a170907941500b00a55aee4bf74sm6993909ejc.79.2024.04.26.12.44.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:44:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/38] accel/hvf: Use accel-specific per-vcpu @dirty field
Date: Fri, 26 Apr 2024 21:41:42 +0200
Message-ID: <20240426194200.43723-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

HVF has a specific use of the CPUState::vcpu_dirty field
(CPUState::vcpu_dirty is not used by common code).
To make this field accel-specific, add and use a new
@dirty variable in the AccelCPUState structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424174506.326-4-philmd@linaro.org>
---
 include/hw/core/cpu.h     |  3 +--
 include/sysemu/hvf_int.h  |  1 +
 accel/hvf/hvf-accel-ops.c | 10 +++++-----
 target/arm/hvf/hvf.c      |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86hvf.c  |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7f037b158e..cead8f01a6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -525,6 +525,7 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
+    bool vcpu_dirty;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -546,8 +547,6 @@ struct CPUState {
     int32_t exception_index;
 
     AccelCPUState *accel;
-    /* shared by kvm and hvf */
-    bool vcpu_dirty;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
      * autoconverge
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 718beddcdd..4a327fd526 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -55,6 +55,7 @@ struct AccelCPUState {
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
+    bool dirty;
 };
 
 void assert_hvf_ok(hv_return_t ret);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d94d41ab6d..40d4187d9d 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -204,15 +204,15 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->accel->dirty) {
         hvf_get_registers(cpu);
-        cpu->vcpu_dirty = true;
+        cpu->accel->dirty = true;
     }
 }
 
 static void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->accel->dirty) {
         run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -221,7 +221,7 @@ static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
     /* QEMU state is the reference, push it to HVF now and on next entry */
-    cpu->vcpu_dirty = true;
+    cpu->accel->dirty = true;
 }
 
 static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
@@ -402,7 +402,7 @@ static int hvf_init_vcpu(CPUState *cpu)
 #else
     r = hv_vcpu_create((hv_vcpuid_t *)&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
-    cpu->vcpu_dirty = 1;
+    cpu->accel->dirty = true;
     assert_hvf_ok(r);
 
     cpu->accel->guest_debug_enabled = false;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 65a5601804..db628c1cba 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -806,9 +806,9 @@ int hvf_put_registers(CPUState *cpu)
 
 static void flush_cpu_state(CPUState *cpu)
 {
-    if (cpu->vcpu_dirty) {
+    if (cpu->accel->dirty) {
         hvf_put_registers(cpu);
-        cpu->vcpu_dirty = false;
+        cpu->accel->dirty = false;
     }
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 1ed8ed5154..e493452acb 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -419,9 +419,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->vcpu_dirty) {
+        if (cpu->accel->dirty) {
             hvf_put_registers(cpu);
-            cpu->vcpu_dirty = false;
+            cpu->accel->dirty = false;
         }
 
         if (hvf_inject_interrupts(cpu)) {
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index be2c46246e..1569f860eb 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -427,7 +427,7 @@ int hvf_process_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cs->vcpu_dirty) {
+    if (!cs->accel->dirty) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
-- 
2.41.0


