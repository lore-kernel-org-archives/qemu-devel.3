Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3F6C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdE-0004zr-Ew; Tue, 21 Jan 2025 06:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdB-0004xh-5v
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:17 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCd5-0003LN-2f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so3533497f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459667; x=1738064467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3HlKJr0e+T3QTj2gDcsUT1Px2dX5i+yFz6MQF4ebrA=;
 b=mz8T6jYw/d8GZ3b/EqoHokECOyWY8EjmsAVzNuavU92ilP+6mmPsWRwIN963za2sRy
 QGzkoy1433rnFCmGXbOZOkgCvRuAQBGbDH5CuihGlaKSadfyDp3b0vTcnKi9dRz4UGgo
 rAGlU41SzZAfJ0hFY6yMF81k2V0It+/SckDmvUwSEotNKVJmOvL81IrgFi9h5sBKzRnP
 n5hy/dfOaidcQbyLDVTUckjR9PpPVWztAH7YtxStVFdvpHjdCptwcXvYyCBWJ+uoQrga
 6JQ3lu+wNFTAP5ZC1i3uSH3ehNLkftD2aGNyeOC3pqP4y4AHMd4PngkV5Mxx7/CVuPVN
 ju8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459667; x=1738064467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3HlKJr0e+T3QTj2gDcsUT1Px2dX5i+yFz6MQF4ebrA=;
 b=pKjilkHE84TkNl53p8opa++gzAo7iP4G2r9t/2VY3UoiHR55vtPwuh8SmxSNbK0qK8
 5Dsw2kwJtOY8yN+zFZET7EXvVYk1rTiRg4yMQx2RVMUSXFHXTpJfzxA0ERoc+t4gkY8L
 S4WGCo4dRX4Y3WYYhwzbZoPxc8OmtXOm98HHD8sT8TL3NVGfCibz65Z5AKNnWfuJWwO2
 52Z6iWH36uQfIxT/t7OaTSTwy1CGUHVTiM4JWlYnORLsoMfZ+/7cUuBcYLKSv3W1NB63
 CX1O0pd1+E+Sd07Qj03ehOPW9cmMHrA2cMg//4uXas62KPHq1Jt3ZApft1jc2tCqrfU/
 0siw==
X-Gm-Message-State: AOJu0YzDTpXL2qxUji01EZRL1wRSy5gKtOhuvIIlOPEO248JGbD/cDnA
 5VlKLDEOkOj1TttS3yzsa3BkFPpau0lX8WjECXnojg8z82n3+eA88mNgbmZ4sKMiavLfYvPR6gn
 5Uhs=
X-Gm-Gg: ASbGncuBFwg3E2GLaBrxWC1Erzi6U2fgAbp4WlV3aQRAzQDgLQJMrLa7v8vc9hYsjXT
 Tx2gB2Ss1XCTxbrVuq+9njfr5UCZQkhdY7TtjoivYSoIZ9ZCRM743wHSxezHnZh1T0n5FEgDUtC
 l1vQoY6ja9/uDFktkCN84JFHFdx8nL9heHI5Yh+rlrM+c831T4xCJxbwBhlKbdQtLxJALN9hIWY
 xSrcxXOS086a7WXq9WCdq2jm/BZhBuvRmD3rU6duAj/O4YGUmDY7P68DCz0P9vgWrGvJNmE0ecy
 7z9Tt4qvCkHWhyfmczJkoOOEIsBzBxG/aWHzcVnUm0Xm
X-Google-Smtp-Source: AGHT+IGs/ATla//lQ2AtPoPkcgm+ShlMsf7RR27CE1JH3r1iRxS5tELAIaHWMxn4/3oiZmjM0gynjA==
X-Received: by 2002:adf:ef4f:0:b0:38a:418e:bee with SMTP id
 ffacd0b85a97d-38bf57a2843mr10469117f8f.42.1737459667407; 
 Tue, 21 Jan 2025 03:41:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327decbsm13358853f8f.90.2025.01.21.03.41.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/11] cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Tue, 21 Jan 2025 12:40:47 +0100
Message-ID: <20250121114056.53949-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
---
 include/hw/core/cpu.h | 10 +++-----
 cpu-common.c          | 10 ++++----
 cpu-target.c          |  6 ++---
 hw/core/cpu-common.c  | 13 ++++------
 hw/core/cpu-system.c  | 55 +++++++++++++++----------------------------
 5 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fb397cdfc53..b7367f6d808 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -824,10 +824,8 @@ const char *parse_cpu_option(const char *cpu_option);
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
@@ -966,9 +964,7 @@ void cpu_interrupt(CPUState *cpu, int mask);
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


