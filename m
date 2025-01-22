Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89313C0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4b-0001ML-Ev; Wed, 22 Jan 2025 04:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4W-0001GD-Tt
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:53 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4U-0003ER-Ui
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso45967265e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538249; x=1738143049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UV0l1u1VpXGSm89LpbkaA5vSB88+gDPSxyKKjefn6E=;
 b=bE20KuZHuGBN5xPpgheLOWv6Ouo1Jey2BrOXbNK5CdLUDolsFVxipUkdAgbpJRZtRT
 GX8SIWFQXC3JTCVzSl0NHY1J2e6aVCnpEcyh83vTTmpMWUlOsB08678rc/3DidMDpTdj
 1Xmqnx+f3vDB/dh1VWtgDdO9Lt5c+k/WOiN9uZL7u2/MS0x0UNwkOL4b+FSVgktREvqy
 ybwFCE4I/uNheSdt+YUWiaNvbP0SYwFBhcB4f0LS+avk93qLcTzZkny55HsSTSvvaqwO
 ffsWzjVLh68O/me6Sh/pSJLMZFnn5jjF+EvwAU2pUMJ/etTDao2v/Gl+tH++ov8So25d
 hMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538249; x=1738143049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UV0l1u1VpXGSm89LpbkaA5vSB88+gDPSxyKKjefn6E=;
 b=Lu1Sqyx1OHo299lebJJN/OavELUPzbTUBSZvQsyuOOKMdYg9nUOq2Ti3NPHZudnHi7
 /7LX8pS53Mez3SauYPqroJZ7xVGvSw9PCjK7ghaPElSCcMukVVmxLMy0snfMvs0aZHzf
 omcwXg1KacWj3Mq1sWeqyu/6PW3KiLJxMhYzU3/dKG07aR8w7aJopbMPVfSnatg5tTxM
 0C0v6UADc1wIw5pzMDay92HWrfhkIvMA9Nif/bMQ//xm3uvCkAlryyKBUrNk3pUTsbcX
 JFCjL6nOo3QxwRALNOkHWPMkMy00FLdFrQEu6JL9XHMfGuvo6eOKWibbljOZp6CvFo2w
 XVCA==
X-Gm-Message-State: AOJu0Yw8P21xVtQo17Smu5VxqIQrphtIu15dBQwjyZvjN+HWhHk6/pO1
 pmWaZcUrYNkba9WqRjC2JA9BbwW0Sfn2dKRHudi8GCBaCTZOovy20S4HdYfNvekiuTAYiXfgktx
 dAwQ=
X-Gm-Gg: ASbGncsR+DAjNceXWkMTLYeSuTT3z9toKJ58x3GW1CuJc6G8d8uw8g5A7SFf0aq/Jxq
 yA/Quuz6bZb85XUlhQnVN1OhOBtPnq0Ix4Frrj3ZAT7GdLoYIRSdq442ZIU3LvFQbtHZabGCiay
 2gmBs8yQ9qyYx0CKShpyAkwqLTchEzS59xqNIeRlEfAVGS8DgO2kHyeERwV9Hk2LH0Li5j2vcbz
 2BxZVzp1c3+kbcf5/LNUg7mHa7y31qdLLZp8z3qRNTvZCMhYrupyDS/fj1XTQ/D7WV+HP2YXcC9
 oLB4fpG+QRNLxS06BbEhM8wi7Wnf8JOuHhbp8h3T1eno
X-Google-Smtp-Source: AGHT+IG9O4Vaslac/rd22GI8JJjeSuQaSY9J/vZ19MsSESCQirxJFfUqVnRG0W1Jv966HJvoPWtHKw==
X-Received: by 2002:a05:600c:4511:b0:431:60ec:7a96 with SMTP id
 5b1f17b1804b1-438914387ddmr160190935e9.25.1737538248888; 
 Wed, 22 Jan 2025 01:30:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c1a2sm17580255e9.7.2025.01.22.01.30.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:30:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/10] cpus: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Wed, 22 Jan 2025 10:30:22 +0100
Message-ID: <20250122093028.52416-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 10 +++-----
 cpu-common.c          | 10 ++++----
 cpu-target.c          |  6 ++---
 hw/core/cpu-common.c  | 13 ++++------
 hw/core/cpu-system.c  | 55 +++++++++++++++----------------------------
 5 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7b6b22c431b..d9e19d192e4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -826,10 +826,8 @@ const char *parse_cpu_option(const char *cpu_option);
  */
 static inline bool cpu_has_work(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    g_assert(cc->has_work);
-    return cc->has_work(cpu);
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
 }
 
 /**
@@ -968,9 +966,7 @@ void cpu_interrupt(CPUState *cpu, int mask);
  */
 static inline void cpu_set_pc(CPUState *cpu, vaddr addr)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    cc->set_pc(cpu, addr);
+    cpu->cc->set_pc(cpu, addr);
 }
 
 /**
diff --git a/cpu-common.c b/cpu-common.c
index 4248b2d727e..3a409aacb2e 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -389,11 +389,10 @@ void process_queued_cpu_work(CPUState *cpu)
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUBreakpoint *bp;
 
-    if (cc->gdb_adjust_breakpoint) {
-        pc = cc->gdb_adjust_breakpoint(cpu, pc);
+    if (cpu->cc->gdb_adjust_breakpoint) {
+        pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
     bp = g_malloc(sizeof(*bp));
@@ -419,11 +418,10 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 /* Remove a specific breakpoint.  */
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUBreakpoint *bp;
 
-    if (cc->gdb_adjust_breakpoint) {
-        pc = cc->gdb_adjust_breakpoint(cpu, pc);
+    if (cpu->cc->gdb_adjust_breakpoint) {
+        pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
     QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
diff --git a/cpu-target.c b/cpu-target.c
index 89874496a41..98e9e7cc4a1 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -159,10 +159,8 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 void cpu_exec_unrealizefn(CPUState *cpu)
 {
 #ifndef CONFIG_USER_ONLY
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->legacy_vmsd != NULL) {
-        vmstate_unregister(NULL, cc->sysemu_ops->legacy_vmsd, cpu);
+    if (cpu->cc->sysemu_ops->legacy_vmsd != NULL) {
+        vmstate_unregister(NULL, cpu->cc->sysemu_ops->legacy_vmsd, cpu);
     }
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ff605059c15..886aa793c04 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -40,9 +40,7 @@ CPUState *cpu_by_arch_id(int64_t id)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-
-        if (cc->get_arch_id(cpu) == id) {
+        if (cpu->cc->get_arch_id(cpu) == id) {
             return cpu;
         }
     }
@@ -101,11 +99,9 @@ static int cpu_common_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg)
 
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->dump_state) {
+    if (cpu->cc->dump_state) {
         cpu_synchronize_state(cpu);
-        cc->dump_state(cpu, f, flags);
+        cpu->cc->dump_state(cpu, f, flags);
     }
 }
 
@@ -119,11 +115,10 @@ void cpu_reset(CPUState *cpu)
 static void cpu_common_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cpu = CPU(obj);
-    CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
         qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
-        log_cpu_state(cpu, cc->reset_dump_flags);
+        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
     }
 
     cpu->interrupt_request = 0;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 6aae28a349a..37d54d04bf8 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,10 +25,8 @@
 
 bool cpu_paging_enabled(const CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->get_paging_enabled) {
-        return cc->sysemu_ops->get_paging_enabled(cpu);
+    if (cpu->cc->sysemu_ops->get_paging_enabled) {
+        return cpu->cc->sysemu_ops->get_paging_enabled(cpu);
     }
 
     return false;
@@ -37,10 +35,8 @@ bool cpu_paging_enabled(const CPUState *cpu)
 bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->get_memory_mapping) {
-        return cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
+    if (cpu->cc->sysemu_ops->get_memory_mapping) {
+        return cpu->cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
     }
 
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
@@ -50,14 +46,12 @@ bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
 hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->get_phys_page_attrs_debug) {
-        return cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
+    if (cpu->cc->sysemu_ops->get_phys_page_attrs_debug) {
+        return cpu->cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
     }
     /* Fallback for CPUs which don't implement the _attrs_ hook */
     *attrs = MEMTXATTRS_UNSPECIFIED;
-    return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
+    return cpu->cc->sysemu_ops->get_phys_page_debug(cpu, addr);
 }
 
 hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
@@ -81,64 +75,53 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf32_qemunote) {
+    if (!cpu->cc->sysemu_ops->write_elf32_qemunote) {
         return 0;
     }
-    return (*cc->sysemu_ops->write_elf32_qemunote)(f, cpu, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf32_qemunote)(f, cpu, opaque);
 }
 
 int cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
                          int cpuid, void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf32_note) {
+    if (!cpu->cc->sysemu_ops->write_elf32_note) {
         return -1;
     }
-    return (*cc->sysemu_ops->write_elf32_note)(f, cpu, cpuid, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf32_note)(f, cpu, cpuid, opaque);
 }
 
 int cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf64_qemunote) {
+    if (!cpu->cc->sysemu_ops->write_elf64_qemunote) {
         return 0;
     }
-    return (*cc->sysemu_ops->write_elf64_qemunote)(f, cpu, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf64_qemunote)(f, cpu, opaque);
 }
 
 int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                          int cpuid, void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf64_note) {
+    if (!cpu->cc->sysemu_ops->write_elf64_note) {
         return -1;
     }
-    return (*cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
 bool cpu_virtio_is_big_endian(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->virtio_is_big_endian) {
-        return cc->sysemu_ops->virtio_is_big_endian(cpu);
+    if (cpu->cc->sysemu_ops->virtio_is_big_endian) {
+        return cpu->cc->sysemu_ops->virtio_is_big_endian(cpu);
     }
     return target_words_bigendian();
 }
 
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GuestPanicInformation *res = NULL;
 
-    if (cc->sysemu_ops->get_crash_info) {
-        res = cc->sysemu_ops->get_crash_info(cpu);
+    if (cpu->cc->sysemu_ops->get_crash_info) {
+        res = cpu->cc->sysemu_ops->get_crash_info(cpu);
     }
     return res;
 }
-- 
2.47.1


