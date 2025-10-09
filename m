Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B749FCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQT-0008ET-GZ; Thu, 09 Oct 2025 03:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQP-0008DS-SC
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQK-0004NX-MY
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8mgIyUucNwmMx4EjvXo3O9E8ww8tXMy2EwnkJclxwU=;
 b=gX7cVVKJj7FRy38Iv2M1GsTCuUIyTl+/TgKLXat7RdmgjoiYsrR63kGPCXv8ymYo3aKEC7
 PS1oQO8eJmFEWkopAUONMJ0QPJ0srdmrlqBEWD8wxHXXn/4SYbxKIly2o0jE1ZomdKw7BF
 HG70rndWJpJhEtAVrghd3U65QP5SYZo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-WA19fIHLMkOuZSw3BK4OvA-1; Thu, 09 Oct 2025 03:50:49 -0400
X-MC-Unique: WA19fIHLMkOuZSw3BK4OvA-1
X-Mimecast-MFC-AGG-ID: WA19fIHLMkOuZSw3BK4OvA_1759996248
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e473e577eso4024805e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996247; x=1760601047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8mgIyUucNwmMx4EjvXo3O9E8ww8tXMy2EwnkJclxwU=;
 b=DeFpjovlk8zjTukqroLjO31HLoX5CuGkWvWR21Dq6dL5qg0BwPGc00OUpuG/1ozCTu
 xKuxy3crMtGRaxbyDHC5tV3CkZXTdTgmYNTr8zpH80nswF1zEUYTJo2JbpD9bppzCgm4
 HXg+hIYJ3xVxpsjNPwkpkYRt8/xqNCKZ6TPi39UCxGflXR4bg5IC69EckbPzrT15ZhCs
 94Pn3vlHJOjHOwTvq9MLjCQ1McH50mcTExSxEb5otqG2qfZ66L6DDBjitRg6/KT2fTV+
 /rzC7MJl9/MSGCi8T8aAxibDrEs/eQUSD6bXfZATVTeRSc/xw9cGAZB3zKeVFNfQ6zsW
 w2Cg==
X-Gm-Message-State: AOJu0YzV9/iTX+9/SvM/EMouvcxWzXcXPVJ3YQgYEss1+fbpCPjIGkE+
 WTVdoi5ybZ9gXTqDQnoYM33M9aIaiK6CIFfjhxq8d8v46WbcmbvrZcRG343xM4BHh/NHdIsrDNY
 fckdjS2xgu0nB7IAc+qvtYfhyMkuXZ2kT7mW5sexfiGgdGGd7vLQG/Mx5hDmWTzoG5Z8olhB+0Z
 V/hTsqivrM8BhSTS50xggQNkhWYLGlff//pyq0PbcS/Y8=
X-Gm-Gg: ASbGncuIhSCwbAXWFSbRG2IBXYqubi8uiSqABh4C2Wi3OXGPUD+t/84LDAM3CXtVh8+
 DZ9mJUwXeRL+SUmfpcWJCNxyEwmlWJYXOW6bmbOg6dMB+4EuaAS/8Do8OX6JG8eK/iI7mlo13u6
 aKuPtWqf2LVqhgRHvULRaGpWwfghOSvo0sCDmB4eQfqDkwUbv3zCR5GL4TBpYW5DS3H7T/MwPnz
 yVISqesfy1iAt+7gOCTl5RIi1y67pZvgO7IugVBBqQLRZlOswzO3tyc1jaJQJU8b1HRpA4ObluK
 Xj8fEuEQp1MExG/m+NG7bxWRktNaHwcYjHC63CX8Xa6iST6S+/Yz42BePBtDpJdmBGy/0EHQOZ0
 jOisEMBKhoMujSS4uBdPCLTF5HuwC7ias4oFeYe4URH7tbdyJ
X-Received: by 2002:a05:600c:1d11:b0:46e:49dd:525e with SMTP id
 5b1f17b1804b1-46fa9af197fmr50894485e9.21.1759996247224; 
 Thu, 09 Oct 2025 00:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQlBCMFHkvbH7JBE18tmExDJZ0+DtIzNGiZqizye75DB0kOwCBv3O9fb4bUVp1ji/Ipf9jgA==
X-Received: by 2002:a05:600c:1d11:b0:46e:49dd:525e with SMTP id
 5b1f17b1804b1-46fa9af197fmr50894195e9.21.1759996246733; 
 Thu, 09 Oct 2025 00:50:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633badsm31871615e9.3.2025.10.09.00.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 09/35] target/i386/mshv: Add x86 decoder/emu implementation
Date: Thu,  9 Oct 2025 09:49:59 +0200
Message-ID: <20251009075026.505715-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

The MSHV accelerator requires a x86 decoder/emulator in userland to
emulate MMIO instructions. This change contains the implementations for
the generalized i386 instruction decoder/emulator.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-4-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h           |  25 +++
 target/i386/cpu.h               |   2 +-
 target/i386/mshv/x86.c          | 297 ++++++++++++++++++++++++++++++++
 target/i386/emulate/meson.build |   7 +-
 target/i386/meson.build         |   2 +
 target/i386/mshv/meson.build    |   7 +
 6 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100644 include/system/mshv.h
 create mode 100644 target/i386/mshv/x86.c
 create mode 100644 target/i386/mshv/meson.build

diff --git a/include/system/mshv.h b/include/system/mshv.h
new file mode 100644
index 00000000000..342f1ef6a98
--- /dev/null
+++ b/include/system/mshv.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou  <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke <magnuskulke@microsoft.com>
+ *          Jinank Jain  <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef QEMU_MSHV_H
+#define QEMU_MSHV_H
+
+#ifdef COMPILING_PER_TARGET
+#ifdef CONFIG_MSHV
+#define CONFIG_MSHV_IS_POSSIBLE
+#endif
+#else
+#define CONFIG_MSHV_IS_POSSIBLE
+#endif
+
+#endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 42168f1d6d8..3aec8fd41c8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2126,7 +2126,7 @@ typedef struct CPUArchState {
     QEMUTimer *xen_periodic_timer;
     QemuMutex xen_timers_lock;
 #endif
-#if defined(CONFIG_HVF)
+#if defined(CONFIG_HVF) || defined(CONFIG_MSHV)
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/mshv/x86.c b/target/i386/mshv/x86.c
new file mode 100644
index 00000000000..d574b3bc52f
--- /dev/null
+++ b/target/i386/mshv/x86.c
@@ -0,0 +1,297 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Magnus Kulke <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
+#include "qemu/typedefs.h"
+#include "qemu/error-report.h"
+#include "system/mshv.h"
+
+/* RW or Exec segment */
+static const uint8_t RWRX_SEGMENT_TYPE        = 0x2;
+static const uint8_t CODE_SEGMENT_TYPE        = 0x8;
+static const uint8_t EXPAND_DOWN_SEGMENT_TYPE = 0x4;
+
+typedef enum CpuMode {
+    REAL_MODE,
+    PROTECTED_MODE,
+    LONG_MODE,
+} CpuMode;
+
+static CpuMode cpu_mode(CPUState *cpu)
+{
+    enum CpuMode m = REAL_MODE;
+
+    if (x86_is_protected(cpu)) {
+        m = PROTECTED_MODE;
+
+        if (x86_is_long_mode(cpu)) {
+            m = LONG_MODE;
+        }
+    }
+
+    return m;
+}
+
+static bool segment_type_ro(const SegmentCache *seg)
+{
+    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    return (type_ & (~RWRX_SEGMENT_TYPE)) == 0;
+}
+
+static bool segment_type_code(const SegmentCache *seg)
+{
+    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    return (type_ & CODE_SEGMENT_TYPE) != 0;
+}
+
+static bool segment_expands_down(const SegmentCache *seg)
+{
+    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+
+    if (segment_type_code(seg)) {
+        return false;
+    }
+
+    return (type_ & EXPAND_DOWN_SEGMENT_TYPE) != 0;
+}
+
+static uint32_t segment_limit(const SegmentCache *seg)
+{
+    uint32_t limit = seg->limit;
+    uint32_t granularity = (seg->flags & DESC_G_MASK) != 0;
+
+    if (granularity != 0) {
+        limit = (limit << 12) | 0xFFF;
+    }
+
+    return limit;
+}
+
+static uint8_t segment_db(const SegmentCache *seg)
+{
+    return (seg->flags >> DESC_B_SHIFT) & 1;
+}
+
+static uint32_t segment_max_limit(const SegmentCache *seg)
+{
+    if (segment_db(seg) != 0) {
+        return 0xFFFFFFFF;
+    }
+    return 0xFFFF;
+}
+
+static int linearize(CPUState *cpu,
+                     target_ulong logical_addr, target_ulong *linear_addr,
+                     X86Seg seg_idx)
+{
+    enum CpuMode mode;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    SegmentCache *seg = &env->segs[seg_idx];
+    target_ulong base = seg->base;
+    target_ulong logical_addr_32b;
+    uint32_t limit;
+    /* TODO: the emulator will not pass us "write" indicator yet */
+    bool write = false;
+
+    mode = cpu_mode(cpu);
+
+    switch (mode) {
+    case LONG_MODE:
+        if (__builtin_add_overflow(logical_addr, base, linear_addr)) {
+            error_report("Address overflow");
+            return -1;
+        }
+        break;
+    case PROTECTED_MODE:
+    case REAL_MODE:
+        if (segment_type_ro(seg) && write) {
+            error_report("Cannot write to read-only segment");
+            return -1;
+        }
+
+        logical_addr_32b = logical_addr & 0xFFFFFFFF;
+        limit = segment_limit(seg);
+
+        if (segment_expands_down(seg)) {
+            if (logical_addr_32b >= limit) {
+                error_report("Address exceeds limit (expands down)");
+                return -1;
+            }
+
+            limit = segment_max_limit(seg);
+        }
+
+        if (logical_addr_32b > limit) {
+            error_report("Address exceeds limit %u", limit);
+            return -1;
+        }
+        *linear_addr = logical_addr_32b + base;
+        break;
+    default:
+        error_report("Unknown cpu mode: %d", mode);
+        return -1;
+    }
+
+    return 0;
+}
+
+bool x86_read_segment_descriptor(CPUState *cpu,
+                                 struct x86_segment_descriptor *desc,
+                                 x86_segment_selector sel)
+{
+    target_ulong base;
+    uint32_t limit;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    target_ulong gva;
+
+    memset(desc, 0, sizeof(*desc));
+
+    /* valid gdt descriptors start from index 1 */
+    if (!sel.index && GDT_SEL == sel.ti) {
+        return false;
+    }
+
+    if (GDT_SEL == sel.ti) {
+        base = env->gdt.base;
+        limit = env->gdt.limit;
+    } else {
+        base = env->ldt.base;
+        limit = env->ldt.limit;
+    }
+
+    if (sel.index * 8 >= limit) {
+        return false;
+    }
+
+    gva = base + sel.index * 8;
+    emul_ops->read_mem(cpu, desc, gva, sizeof(*desc));
+
+    return true;
+}
+
+bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
+                        int gate)
+{
+    target_ulong base;
+    uint32_t limit;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    target_ulong gva;
+
+    base = env->idt.base;
+    limit = env->idt.limit;
+
+    memset(idt_desc, 0, sizeof(*idt_desc));
+    if (gate * 8 >= limit) {
+        perror("call gate exceeds idt limit");
+        return false;
+    }
+
+    gva = base + gate * 8;
+    emul_ops->read_mem(cpu, idt_desc, gva, sizeof(*idt_desc));
+
+    return true;
+}
+
+bool x86_is_protected(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t cr0 = env->cr[0];
+
+    return cr0 & CR0_PE_MASK;
+}
+
+bool x86_is_real(CPUState *cpu)
+{
+    return !x86_is_protected(cpu);
+}
+
+bool x86_is_v8086(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    return x86_is_protected(cpu) && (env->eflags & VM_MASK);
+}
+
+bool x86_is_long_mode(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t efer = env->efer;
+    uint64_t lme_lma = (MSR_EFER_LME | MSR_EFER_LMA);
+
+    return ((efer & lme_lma) == lme_lma);
+}
+
+bool x86_is_long64_mode(CPUState *cpu)
+{
+    error_report("unimplemented: is_long64_mode()");
+    abort();
+}
+
+bool x86_is_paging_mode(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t cr0 = env->cr[0];
+
+    return cr0 & CR0_PG_MASK;
+}
+
+bool x86_is_pae_enabled(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t cr4 = env->cr[4];
+
+    return cr4 & CR4_PAE_MASK;
+}
+
+target_ulong linear_addr(CPUState *cpu, target_ulong addr, X86Seg seg)
+{
+    int ret;
+    target_ulong linear_addr;
+
+    ret = linearize(cpu, addr, &linear_addr, seg);
+    if (ret < 0) {
+        error_report("failed to linearize address");
+        abort();
+    }
+
+    return linear_addr;
+}
+
+target_ulong linear_addr_size(CPUState *cpu, target_ulong addr, int size,
+                              X86Seg seg)
+{
+    switch (size) {
+    case 2:
+        addr = (uint16_t)addr;
+        break;
+    case 4:
+        addr = (uint32_t)addr;
+        break;
+    default:
+        break;
+    }
+    return linear_addr(cpu, addr, seg);
+}
+
+target_ulong linear_rip(CPUState *cpu, target_ulong rip)
+{
+    return linear_addr(cpu, rip, R_CS);
+}
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index 4edd4f462fc..b6dafb6a5be 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -1,5 +1,8 @@
-i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
+emulator_files = files(
   'x86_decode.c',
   'x86_emu.c',
   'x86_flags.c',
-))
+)
+
+i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
+i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_files)
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 092af34e2d8..89ba4912aae 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -13,6 +13,7 @@ i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_HVF', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_WHPX', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_NVMM', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_MSHV', if_true: files('host-cpu.c'))
 
 i386_system_ss = ss.source_set()
 i386_system_ss.add(files(
@@ -34,6 +35,7 @@ subdir('nvmm')
 subdir('hvf')
 subdir('tcg')
 subdir('emulate')
+subdir('mshv')
 
 target_arch += {'i386': i386_ss}
 target_system_arch += {'i386': i386_system_ss}
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
new file mode 100644
index 00000000000..8ddaa7c11dc
--- /dev/null
+++ b/target/i386/mshv/meson.build
@@ -0,0 +1,7 @@
+i386_mshv_ss = ss.source_set()
+
+i386_mshv_ss.add(files(
+  'x86.c',
+))
+
+i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
-- 
2.51.0


