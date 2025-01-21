Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C64C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFEF-0006lT-Rg; Tue, 21 Jan 2025 09:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCF-0002Qj-TX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCC-0003b4-Ky
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:39 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso39947775e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469533; x=1738074333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5Osj/Xm8a9n3farOlX+BcfUKPr+xmHC/WIuo/LHRro=;
 b=RWjh0YQ3VckF3VazggSMMAGkRGw6xkDKltedpocGjkSgWo97imqH4zRYR9RFM79lID
 y3XBcqVK2XLHam4sYxPKJeAkr28rQhESnJMlfeafUUzlKaScJmA5Riysd0WrLuY2Qqqk
 Q0UZC7BHY3O5G7/VLQFM0r7qMDDgyo4s0a1/U/Esbzwg4jkrSfYAwqOJWe/DB+QpIcSc
 8aB/K6bjTj3JRIqN5vdMQfVWHS1tGKah58X02BCV0m/5g5y0IUeLi4LAoLANM5fqki47
 uiJtqTbBgLlIFSSlgIhVdpbD5+ZTYN9rH9O6RTBjOGK0xud/v9JJCz7J0/nnqeDwap3A
 APLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469533; x=1738074333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5Osj/Xm8a9n3farOlX+BcfUKPr+xmHC/WIuo/LHRro=;
 b=ulMj/GNIeEcED4iSDwHhdEsL4aiERlA8ONRMDYiM7ancBBmjbSHvNTsUcoyA70UX+A
 UWFra3q09gsJaS0SDcyfNhzrVlqLvqgwqaZrc9wESDWQKfSq/uE04oo/CF4bqXDO57JU
 RNfQXYF7IFeHvMD33MRtvWkxEDbBVT86Rgk4YlAukvLwmx8iAfr8+1xJvAOc6m5lkj67
 5uPB0iKaJRq0G8UbjJHSdyj6LGiQ6hSk44SsQpO0uMgC5J+nFJf+JtpGtNA6VDkSgwgY
 sfZ4RdZQaCDHrMXLVwHtaDsbttSfcTlAGBdN6ajK905Z0ZJVVBkF+HEQmSjA/T5hBblV
 M8mg==
X-Gm-Message-State: AOJu0YzZgczTtGpY48s0BUPFe956blUHfmbwldVr/1fKTkAFaZyH5Eh0
 iqPYW+x/2R+0BTgREnQ0jW5O2rgDDL2rmxcbKje9xdWRCXuafuJ9+mxKLmj5Mo+xxTSWSBYeQ8h
 5NwQ=
X-Gm-Gg: ASbGncurLnaft6aFMNX+o1VT8y5s5kHEMJ6BiAN+yFNN70KpZ9vtbCtHXhQveFLVbVK
 6yeRhS2pWXnMN6Dq5EXZ6w7/o+jNTdiqG/X68UzNY5EIc2X9yMbzEMMFJuhwL7iOtmF4ocaAElL
 y6kfXD6jajQC/TmDLh7rLmHwAE6FMq6UCe3zfgrSveclsi9wQiaW/czAUNFoaj+D6eAU6sOa/kV
 l8WkuWYL2FWEsKL3AyVesVIWu/5t5a+Uw6a5DNSNc9X90jtHATjQz1scPd34NjJryvULS8TRUZX
 45mUJYCE0F2h70gRLkKeay8CbOlcCweCQ8qjSY33p1rr
X-Google-Smtp-Source: AGHT+IFy475/36H2ngsXVZqfotRfT3spRy/Q+K2ilZTYIEAsI9KYg5NCPKl5KgR4uvaDNCcS5GALIA==
X-Received: by 2002:a05:600c:1f86:b0:436:faeb:2a1b with SMTP id
 5b1f17b1804b1-438913db2cfmr154848375e9.13.1737469533314; 
 Tue, 21 Jan 2025 06:25:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890462195sm179610405e9.30.2025.01.21.06.25.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 23/28] target/s390x: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:36 +0100
Message-ID: <20250121142341.17001-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
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

Move has_work() from CPUClass to SysemuCPUOps, move
s390_cpu_has_work() to cpu-system.c so it is only build
for system emulation binaries, restrict functions not
used anymore on user emulation in interrupt.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h |  3 +++
 target/s390x/cpu-system.c     | 18 ++++++++++++++++++
 target/s390x/cpu.c            | 18 ------------------
 target/s390x/interrupt.c      |  8 ++------
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 6e2c98de97a..a4ba6227ab4 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -245,6 +245,7 @@ bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
 void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
+bool s390_cpu_has_work(CPUState *cs);
 
 #else
 static inline unsigned int s390_cpu_halt(S390CPU *cpu)
@@ -341,6 +342,7 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 
 /* interrupt.c */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code);
+#ifndef CONFIG_USER_ONLY
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
@@ -353,6 +355,7 @@ bool s390_cpu_has_restart_int(S390CPU *cpu);
 bool s390_cpu_has_stop_int(S390CPU *cpu);
 void cpu_inject_restart(S390CPU *cpu);
 void cpu_inject_stop(S390CPU *cpu);
+#endif /* CONFIG_USER_ONLY */
 
 
 /* ioinst.c */
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index e9f8e7cc72f..9b380e343c2 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -39,6 +39,23 @@
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
+bool s390_cpu_has_work(CPUState *cs)
+{
+    S390CPU *cpu = S390_CPU(cs);
+
+    /* STOPPED cpus can never wake up */
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
+        s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
+        return false;
+    }
+
+    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        return false;
+    }
+
+    return s390_cpu_has_int(cpu);
+}
+
 /* S390CPUClass::load_normal() */
 static void s390_cpu_load_normal(CPUState *s)
 {
@@ -158,6 +175,7 @@ void s390_cpu_finalize(Object *obj)
 }
 
 static const struct SysemuCPUOps s390_sysemu_ops = {
+    .has_work = s390_cpu_has_work,
     .get_phys_page_debug = s390_cpu_get_phys_page_debug,
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 97d41c23de7..eb2c6650989 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -126,23 +126,6 @@ static vaddr s390_cpu_get_pc(CPUState *cs)
     return cpu->env.psw.addr;
 }
 
-static bool s390_cpu_has_work(CPUState *cs)
-{
-    S390CPU *cpu = S390_CPU(cs);
-
-    /* STOPPED cpus can never wake up */
-    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
-        s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
-        return false;
-    }
-
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
-        return false;
-    }
-
-    return s390_cpu_has_int(cpu);
-}
-
 static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     return s390x_env_mmu_index(cpu_env(cs), ifetch);
@@ -394,7 +377,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name,
-    cc->has_work = s390_cpu_has_work;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index d68d8955b1a..4ae6e2ddeaa 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -30,6 +30,7 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
     /* env->int_pgm_ilen is already set, or will be set during unwinding */
 }
 
+#if !defined(CONFIG_USER_ONLY)
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
 {
     if (kvm_enabled()) {
@@ -41,7 +42,6 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
     }
 }
 
-#if !defined(CONFIG_USER_ONLY)
 void cpu_inject_clock_comparator(S390CPU *cpu)
 {
     CPUS390XState *env = &cpu->env;
@@ -225,11 +225,9 @@ bool s390_cpu_has_stop_int(S390CPU *cpu)
 
     return env->pending_int & INTERRUPT_STOP;
 }
-#endif
 
 bool s390_cpu_has_int(S390CPU *cpu)
 {
-#ifndef CONFIG_USER_ONLY
     if (!tcg_enabled()) {
         return false;
     }
@@ -238,7 +236,5 @@ bool s390_cpu_has_int(S390CPU *cpu)
            s390_cpu_has_io_int(cpu) ||
            s390_cpu_has_restart_int(cpu) ||
            s390_cpu_has_stop_int(cpu);
-#else
-    return false;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


