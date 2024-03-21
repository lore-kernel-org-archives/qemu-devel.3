Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C348C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKhw-0002lI-Ng; Thu, 21 Mar 2024 11:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKhE-0001IZ-AJ
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:51:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKh1-0002Be-Rk
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:51:05 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so1504610a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036257; x=1711641057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6V+xghT+3/f8uj28Yzv/QHtJ2W3P/5E37yCGvs4rFKA=;
 b=bc7NgyvwRODroOste0D284t74pstl1r/4ZsoBKQbV+F4eMGhr1kcgxuymyxdmHdIuU
 qakkddK1x0+6IujEIVIgwnEMAKrFDYEO/8iRZC/zEgh/8Uv8ndz6FH9+d6Nj0YQ/DqkB
 PZDmcpmVbETiANqJKdQFzHJZOlwunvqZ7BUj7gEaLVFJ2hYBe7941xnH6lVO+rO+aMY+
 4mCbjjh9FJ0upuFFFmtRizaSy7w3MrJiGbK8NwaWEVLxnysWAvXjgmbU87EYvlxL6z/L
 RLtzsZ/b7VM6e+pVbOCnkemhheyfFM67E30MMrnVW4yT2+BXBpKYYiF+mUwpIytBB/2I
 IUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036257; x=1711641057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6V+xghT+3/f8uj28Yzv/QHtJ2W3P/5E37yCGvs4rFKA=;
 b=Z0NC4KjryyMBSj/CHU8Vm0Dkec9bZyzwG9CRDKKRv697Af1BHH7MzBo7KbKzyc9/1g
 3sPU5Vmi/+M9nh9mIunwg3EB8Szdrh9on8ZDulRD0U5QA8B6B5deE0TSWHCM0sceh/VO
 aqxxDbb6OfA7y9qzSJBViIpEDhCauVZ4StpC96/jUwKUFxiBW6rVAsE2pIDJvSxzajZu
 qbk/Ba4VEIhW8NGSl41DqRzB86lLvmC0x8M2+l6bt6ejrS5SsEzM4uSrZBJouGNHgvrR
 DxicKHGjDA4YKao9Y2jM4uA+zxiGBcysH5eh5VA1S/1/ohWQBuTSx/t5E3UP56L0GY6Q
 t7Rg==
X-Gm-Message-State: AOJu0Yye/9qBB5ZWBtD8iMIJoOCHOqdyVEbsU+wnlArroGZC5K/L13Qd
 81Vqndvyb27E8prOsyuEdzNqUshw+9XjKhBcK94lxwRPzoehk9avSh/L5PQ0v84AwRftDsUf2vZ
 910k=
X-Google-Smtp-Source: AGHT+IGsbdB9bbsTJSPu6jcHuepTNYz1mIqjLhoqi0ukqIZIA1xQFRu3cMrN8SeguMUz5v/WdnNqXg==
X-Received: by 2002:a05:6402:e83:b0:568:b46c:c4ba with SMTP id
 h3-20020a0564020e8300b00568b46cc4bamr4265530eda.30.1711036257015; 
 Thu, 21 Mar 2024 08:50:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a05640235c900b00568a08a9aacsm14611edc.22.2024.03.21.08.50.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 18/21] target/xtensa: Extract MMU API to new
 mmu.c/mmu.h files
Date: Thu, 21 Mar 2024 16:48:34 +0100
Message-ID: <20240321154838.95771-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Extract the MMU API and expose it via "mmu.h" so we can
reuse the methods in target/xtensa/ files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.h        |  32 +-
 target/xtensa/mmu.h        |  95 ++++
 target/xtensa/mmu.c        | 889 ++++++++++++++++++++++++++++++++++++
 target/xtensa/mmu_helper.c | 892 +------------------------------------
 target/xtensa/meson.build  |   1 +
 5 files changed, 991 insertions(+), 918 deletions(-)
 create mode 100644 target/xtensa/mmu.h
 create mode 100644 target/xtensa/mmu.c

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b2cfc78e9d..b67ee987f3 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -34,6 +34,10 @@
 #include "hw/clock.h"
 #include "xtensa-isa.h"
 
+typedef struct CPUArchState CPUXtensaState;
+
+#include "mmu.h"
+
 /* Xtensa processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
@@ -309,28 +313,6 @@ typedef enum {
     INTTYPE_MAX
 } interrupt_type;
 
-typedef struct CPUArchState CPUXtensaState;
-
-typedef struct xtensa_tlb_entry {
-    uint32_t vaddr;
-    uint32_t paddr;
-    uint8_t asid;
-    uint8_t attr;
-    bool variable;
-} xtensa_tlb_entry;
-
-typedef struct xtensa_tlb {
-    unsigned nways;
-    const unsigned way_size[10];
-    bool varway56;
-    unsigned nrefillentries;
-} xtensa_tlb;
-
-typedef struct xtensa_mpu_entry {
-    uint32_t vaddr;
-    uint32_t attr;
-} xtensa_mpu_entry;
-
 typedef struct XtensaGdbReg {
     int targno;
     unsigned flags;
@@ -689,12 +671,6 @@ static inline int xtensa_get_cring(const CPUXtensaState *env)
 }
 
 #ifndef CONFIG_USER_ONLY
-int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
-        uint32_t vaddr, int is_write, int mmu_idx,
-        uint32_t *paddr, uint32_t *page_size, unsigned *access);
-void xtensa_reset_mmu(CPUXtensaState *env);
-void xtensa_dump_mmu(CPUXtensaState *env);
-
 static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
     return env->system_er;
diff --git a/target/xtensa/mmu.h b/target/xtensa/mmu.h
new file mode 100644
index 0000000000..3e1d2c03ea
--- /dev/null
+++ b/target/xtensa/mmu.h
@@ -0,0 +1,95 @@
+/*
+ * Xtensa MMU/MPU helpers
+ *
+ * SPDX-FileCopyrightText: 2011 - 2019, Max Filippov, Open Source and Linux Lab.
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+
+#ifndef TARGET_XTENSA_MMU_H
+#define TARGET_XTENSA_MMU_H
+
+#include "cpu.h"
+
+typedef struct xtensa_tlb_entry {
+    uint32_t vaddr;
+    uint32_t paddr;
+    uint8_t asid;
+    uint8_t attr;
+    bool variable;
+} xtensa_tlb_entry;
+
+typedef struct xtensa_tlb {
+    unsigned nways;
+    const unsigned way_size[10];
+    bool varway56;
+    unsigned nrefillentries;
+} xtensa_tlb;
+
+typedef struct xtensa_mpu_entry {
+    uint32_t vaddr;
+    uint32_t attr;
+} xtensa_mpu_entry;
+
+#define XTENSA_MPU_SEGMENT_MASK 0x0000001f
+#define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
+#define XTENSA_MPU_ACC_RIGHTS_SHIFT 8
+#define XTENSA_MPU_MEM_TYPE_MASK 0x001ff000
+#define XTENSA_MPU_MEM_TYPE_SHIFT 12
+#define XTENSA_MPU_ATTR_MASK 0x001fff00
+
+#define XTENSA_MPU_PROBE_B 0x40000000
+#define XTENSA_MPU_PROBE_V 0x80000000
+
+#define XTENSA_MPU_SYSTEM_TYPE_DEVICE 0x0001
+#define XTENSA_MPU_SYSTEM_TYPE_NC     0x0002
+#define XTENSA_MPU_SYSTEM_TYPE_C      0x0003
+#define XTENSA_MPU_SYSTEM_TYPE_MASK   0x0003
+
+#define XTENSA_MPU_TYPE_SYS_C     0x0010
+#define XTENSA_MPU_TYPE_SYS_W     0x0020
+#define XTENSA_MPU_TYPE_SYS_R     0x0040
+#define XTENSA_MPU_TYPE_CPU_C     0x0100
+#define XTENSA_MPU_TYPE_CPU_W     0x0200
+#define XTENSA_MPU_TYPE_CPU_R     0x0400
+#define XTENSA_MPU_TYPE_CPU_CACHE 0x0800
+#define XTENSA_MPU_TYPE_B         0x1000
+#define XTENSA_MPU_TYPE_INT       0x2000
+
+unsigned mmu_attr_to_access(uint32_t attr);
+unsigned mpu_attr_to_access(uint32_t attr, unsigned ring);
+unsigned mpu_attr_to_cpu_cache(uint32_t attr);
+unsigned mpu_attr_to_type(uint32_t attr);
+
+unsigned region_attr_to_access(uint32_t attr);
+unsigned cacheattr_attr_to_access(uint32_t attr);
+
+xtensa_tlb_entry *xtensa_get_tlb_entry(CPUXtensaState *env,
+                                       uint32_t v, bool dtlb, uint32_t *pwi);
+xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
+                                       unsigned wi, unsigned ei);
+void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
+                          unsigned wi, unsigned ei,
+                          uint32_t vpn, uint32_t pte);
+
+uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env, bool dtlb,
+                                  uint32_t way);
+uint32_t xtensa_get_vpn_mask(const CPUXtensaState *env, bool dtlb,
+                             uint32_t way);
+
+bool xtensa_split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
+                                 uint32_t *vpn, uint32_t *wi, uint32_t *ei);
+
+int xtensa_tlb_lookup(const CPUXtensaState *env, uint32_t addr, bool dtlb,
+                      uint32_t *pwi, uint32_t *pei, uint8_t *pring);
+int xtensa_mpu_lookup(const xtensa_mpu_entry *entry, unsigned n,
+                      uint32_t vaddr, unsigned *segment);
+
+int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
+                             uint32_t vaddr, int is_write, int mmu_idx,
+                             uint32_t *paddr, uint32_t *page_size,
+                             unsigned *access);
+
+void xtensa_reset_mmu(CPUXtensaState *env);
+void xtensa_dump_mmu(CPUXtensaState *env);
+
+#endif
diff --git a/target/xtensa/mmu.c b/target/xtensa/mmu.c
new file mode 100644
index 0000000000..4f17fb2980
--- /dev/null
+++ b/target/xtensa/mmu.c
@@ -0,0 +1,889 @@
+/*
+ * Copyright (c) 2011 - 2019, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/host-utils.h"
+#include "exec/exec-all.h"
+#include "cpu.h"
+#include "mmu.h"
+
+static uint32_t get_page_size(const CPUXtensaState *env,
+                              bool dtlb, uint32_t way)
+{
+    uint32_t tlbcfg = env->sregs[dtlb ? DTLBCFG : ITLBCFG];
+
+    switch (way) {
+    case 4:
+        return (tlbcfg >> 16) & 0x3;
+
+    case 5:
+        return (tlbcfg >> 20) & 0x1;
+
+    case 6:
+        return (tlbcfg >> 24) & 0x1;
+
+    default:
+        return 0;
+    }
+}
+
+/*!
+ * Get bit mask for the virtual address bits translated by the TLB way
+ */
+uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
+                                  bool dtlb, uint32_t way)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        bool varway56 = dtlb ?
+            env->config->dtlb.varway56 :
+            env->config->itlb.varway56;
+
+        switch (way) {
+        case 4:
+            return 0xfff00000 << get_page_size(env, dtlb, way) * 2;
+
+        case 5:
+            if (varway56) {
+                return 0xf8000000 << get_page_size(env, dtlb, way);
+            } else {
+                return 0xf8000000;
+            }
+
+        case 6:
+            if (varway56) {
+                return 0xf0000000 << (1 - get_page_size(env, dtlb, way));
+            } else {
+                return 0xf0000000;
+            }
+
+        default:
+            return 0xfffff000;
+        }
+    } else {
+        return REGION_PAGE_MASK;
+    }
+}
+
+/*!
+ * Get bit mask for the 'VPN without index' field.
+ * See ISA, 4.6.5.6, data format for RxTLB0
+ */
+uint32_t xtensa_get_vpn_mask(const CPUXtensaState *env, bool dtlb, uint32_t way)
+{
+    if (way < 4) {
+        bool is32 = (dtlb ?
+                env->config->dtlb.nrefillentries :
+                env->config->itlb.nrefillentries) == 32;
+        return is32 ? 0xffff8000 : 0xffffc000;
+    } else if (way == 4) {
+        return xtensa_tlb_get_addr_mask(env, dtlb, way) << 2;
+    } else if (way <= 6) {
+        uint32_t mask = xtensa_tlb_get_addr_mask(env, dtlb, way);
+        bool varway56 = dtlb ?
+            env->config->dtlb.varway56 :
+            env->config->itlb.varway56;
+
+        if (varway56) {
+            return mask << (way == 5 ? 2 : 3);
+        } else {
+            return mask << 1;
+        }
+    } else {
+        return 0xfffff000;
+    }
+}
+
+/*!
+ * Split virtual address into VPN (with index) and entry index
+ * for the given TLB way
+ */
+static void xtensa_split_tlb_entry_spec_way(const CPUXtensaState *env,
+                                            uint32_t v,
+                                            bool dtlb, uint32_t *vpn,
+                                            uint32_t wi, uint32_t *ei)
+{
+    bool varway56 = dtlb ?
+        env->config->dtlb.varway56 :
+        env->config->itlb.varway56;
+
+    if (!dtlb) {
+        wi &= 7;
+    }
+
+    if (wi < 4) {
+        bool is32 = (dtlb ?
+                env->config->dtlb.nrefillentries :
+                env->config->itlb.nrefillentries) == 32;
+        *ei = (v >> 12) & (is32 ? 0x7 : 0x3);
+    } else {
+        switch (wi) {
+        case 4:
+            {
+                uint32_t eibase = 20 + get_page_size(env, dtlb, wi) * 2;
+                *ei = (v >> eibase) & 0x3;
+            }
+            break;
+
+        case 5:
+            if (varway56) {
+                uint32_t eibase = 27 + get_page_size(env, dtlb, wi);
+                *ei = (v >> eibase) & 0x3;
+            } else {
+                *ei = (v >> 27) & 0x1;
+            }
+            break;
+
+        case 6:
+            if (varway56) {
+                uint32_t eibase = 29 - get_page_size(env, dtlb, wi);
+                *ei = (v >> eibase) & 0x7;
+            } else {
+                *ei = (v >> 28) & 0x1;
+            }
+            break;
+
+        default:
+            *ei = 0;
+            break;
+        }
+    }
+    *vpn = v & xtensa_tlb_get_addr_mask(env, dtlb, wi);
+}
+
+/*!
+ * Split TLB address into TLB way, entry index and VPN (with index).
+ * See ISA, 4.6.5.5 - 4.6.5.8 for the TLB addressing format
+ */
+bool xtensa_split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
+                                 uint32_t *vpn, uint32_t *wi, uint32_t *ei)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        *wi = v & (dtlb ? 0xf : 0x7);
+        if (*wi < (dtlb ? env->config->dtlb.nways : env->config->itlb.nways)) {
+            xtensa_split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+            return true;
+        } else {
+            return false;
+        }
+    } else {
+        *vpn = v & REGION_PAGE_MASK;
+        *wi = 0;
+        *ei = (v >> 29) & 0x7;
+        return true;
+    }
+}
+
+xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
+                                       unsigned wi, unsigned ei)
+{
+    const xtensa_tlb *tlb = dtlb ? &env->config->dtlb : &env->config->itlb;
+
+    assert(wi < tlb->nways && ei < tlb->way_size[wi]);
+    return dtlb ?
+        env->dtlb[wi] + ei :
+        env->itlb[wi] + ei;
+}
+
+xtensa_tlb_entry *xtensa_get_tlb_entry(CPUXtensaState *env, uint32_t v,
+                                       bool dtlb, uint32_t *pwi)
+{
+    uint32_t vpn;
+    uint32_t wi;
+    uint32_t ei;
+
+    if (xtensa_split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+        if (pwi) {
+            *pwi = wi;
+        }
+        return xtensa_tlb_get_entry(env, dtlb, wi, ei);
+    } else {
+        return NULL;
+    }
+}
+
+static void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
+                                     xtensa_tlb_entry *entry, bool dtlb,
+                                     unsigned wi, unsigned ei, uint32_t vpn,
+                                     uint32_t pte)
+{
+    entry->vaddr = vpn;
+    entry->paddr = pte & xtensa_tlb_get_addr_mask(env, dtlb, wi);
+    entry->asid = (env->sregs[RASID] >> ((pte >> 1) & 0x18)) & 0xff;
+    entry->attr = pte & 0xf;
+}
+
+void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
+                          unsigned wi, unsigned ei,
+                          uint32_t vpn, uint32_t pte)
+{
+    CPUState *cs = env_cpu(env);
+    xtensa_tlb_entry *entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
+
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        if (entry->variable) {
+            if (entry->asid) {
+                tlb_flush_page(cs, entry->vaddr);
+            }
+            xtensa_tlb_set_entry_mmu(env, entry, dtlb, wi, ei, vpn, pte);
+            tlb_flush_page(cs, entry->vaddr);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s %d, %d, %d trying to set immutable entry\n",
+                          __func__, dtlb, wi, ei);
+        }
+    } else {
+        tlb_flush_page(cs, entry->vaddr);
+        if (xtensa_option_enabled(env->config,
+                    XTENSA_OPTION_REGION_TRANSLATION)) {
+            entry->paddr = pte & REGION_PAGE_MASK;
+        }
+        entry->attr = pte & 0xf;
+    }
+}
+
+hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    uint32_t paddr;
+    uint32_t page_size;
+    unsigned access;
+
+    if (xtensa_get_physical_addr(&cpu->env, false, addr, 0, 0,
+                &paddr, &page_size, &access) == 0) {
+        return paddr;
+    }
+    if (xtensa_get_physical_addr(&cpu->env, false, addr, 2, 0,
+                &paddr, &page_size, &access) == 0) {
+        return paddr;
+    }
+    return ~0;
+}
+
+static void reset_tlb_mmu_all_ways(CPUXtensaState *env, const xtensa_tlb *tlb,
+                                   xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
+{
+    unsigned wi, ei;
+
+    for (wi = 0; wi < tlb->nways; ++wi) {
+        for (ei = 0; ei < tlb->way_size[wi]; ++ei) {
+            entry[wi][ei].asid = 0;
+            entry[wi][ei].variable = true;
+        }
+    }
+}
+
+static void reset_tlb_mmu_ways56(CPUXtensaState *env, const xtensa_tlb *tlb,
+                                 xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
+{
+    if (!tlb->varway56) {
+        static const xtensa_tlb_entry way5[] = {
+            {
+                .vaddr = 0xd0000000,
+                .paddr = 0,
+                .asid = 1,
+                .attr = 7,
+                .variable = false,
+            }, {
+                .vaddr = 0xd8000000,
+                .paddr = 0,
+                .asid = 1,
+                .attr = 3,
+                .variable = false,
+            }
+        };
+        static const xtensa_tlb_entry way6[] = {
+            {
+                .vaddr = 0xe0000000,
+                .paddr = 0xf0000000,
+                .asid = 1,
+                .attr = 7,
+                .variable = false,
+            }, {
+                .vaddr = 0xf0000000,
+                .paddr = 0xf0000000,
+                .asid = 1,
+                .attr = 3,
+                .variable = false,
+            }
+        };
+        memcpy(entry[5], way5, sizeof(way5));
+        memcpy(entry[6], way6, sizeof(way6));
+    } else {
+        uint32_t ei;
+        for (ei = 0; ei < 8; ++ei) {
+            entry[6][ei].vaddr = ei << 29;
+            entry[6][ei].paddr = ei << 29;
+            entry[6][ei].asid = 1;
+            entry[6][ei].attr = 3;
+        }
+    }
+}
+
+static void reset_tlb_region_way0(CPUXtensaState *env,
+                                  xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
+{
+    unsigned ei;
+
+    for (ei = 0; ei < 8; ++ei) {
+        entry[0][ei].vaddr = ei << 29;
+        entry[0][ei].paddr = ei << 29;
+        entry[0][ei].asid = 1;
+        entry[0][ei].attr = 2;
+        entry[0][ei].variable = true;
+    }
+}
+
+void xtensa_reset_mmu(CPUXtensaState *env)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        env->sregs[RASID] = 0x04030201;
+        env->sregs[ITLBCFG] = 0;
+        env->sregs[DTLBCFG] = 0;
+        env->autorefill_idx = 0;
+        reset_tlb_mmu_all_ways(env, &env->config->itlb, env->itlb);
+        reset_tlb_mmu_all_ways(env, &env->config->dtlb, env->dtlb);
+        reset_tlb_mmu_ways56(env, &env->config->itlb, env->itlb);
+        reset_tlb_mmu_ways56(env, &env->config->dtlb, env->dtlb);
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
+        unsigned i;
+
+        env->sregs[MPUENB] = 0;
+        env->sregs[MPUCFG] = env->config->n_mpu_fg_segments;
+        env->sregs[CACHEADRDIS] = 0;
+        assert(env->config->n_mpu_bg_segments > 0 &&
+               env->config->mpu_bg[0].vaddr == 0);
+        for (i = 1; i < env->config->n_mpu_bg_segments; ++i) {
+            assert(env->config->mpu_bg[i].vaddr >=
+                   env->config->mpu_bg[i - 1].vaddr);
+        }
+    } else {
+        env->sregs[CACHEATTR] = 0x22222222;
+        reset_tlb_region_way0(env, env->itlb);
+        reset_tlb_region_way0(env, env->dtlb);
+    }
+}
+
+static unsigned get_ring(const CPUXtensaState *env, uint8_t asid)
+{
+    unsigned i;
+    for (i = 0; i < 4; ++i) {
+        if (((env->sregs[RASID] >> i * 8) & 0xff) == asid) {
+            return i;
+        }
+    }
+    return 0xff;
+}
+
+/*!
+ * Lookup xtensa TLB for the given virtual address.
+ * See ISA, 4.6.2.2
+ *
+ * \param pwi: [out] way index
+ * \param pei: [out] entry index
+ * \param pring: [out] access ring
+ * \return 0 if ok, exception cause code otherwise
+ */
+int xtensa_tlb_lookup(const CPUXtensaState *env, uint32_t addr, bool dtlb,
+                      uint32_t *pwi, uint32_t *pei, uint8_t *pring)
+{
+    const xtensa_tlb *tlb = dtlb ?
+        &env->config->dtlb : &env->config->itlb;
+    const xtensa_tlb_entry (*entry)[MAX_TLB_WAY_SIZE] = dtlb ?
+        env->dtlb : env->itlb;
+
+    int nhits = 0;
+    unsigned wi;
+
+    for (wi = 0; wi < tlb->nways; ++wi) {
+        uint32_t vpn;
+        uint32_t ei;
+        xtensa_split_tlb_entry_spec_way(env, addr, dtlb, &vpn, wi, &ei);
+        if (entry[wi][ei].vaddr == vpn && entry[wi][ei].asid) {
+            unsigned ring = get_ring(env, entry[wi][ei].asid);
+            if (ring < 4) {
+                if (++nhits > 1) {
+                    return dtlb ?
+                        LOAD_STORE_TLB_MULTI_HIT_CAUSE :
+                        INST_TLB_MULTI_HIT_CAUSE;
+                }
+                *pwi = wi;
+                *pei = ei;
+                *pring = ring;
+            }
+        }
+    }
+    return nhits ? 0 :
+        (dtlb ? LOAD_STORE_TLB_MISS_CAUSE : INST_TLB_MISS_CAUSE);
+}
+
+/*!
+ * Convert MMU ATTR to PAGE_{READ,WRITE,EXEC} mask.
+ * See ISA, 4.6.5.10
+ */
+unsigned mmu_attr_to_access(uint32_t attr)
+{
+    unsigned access = 0;
+
+    if (attr < 12) {
+        access |= PAGE_READ;
+        if (attr & 0x1) {
+            access |= PAGE_EXEC;
+        }
+        if (attr & 0x2) {
+            access |= PAGE_WRITE;
+        }
+
+        switch (attr & 0xc) {
+        case 0:
+            access |= PAGE_CACHE_BYPASS;
+            break;
+
+        case 4:
+            access |= PAGE_CACHE_WB;
+            break;
+
+        case 8:
+            access |= PAGE_CACHE_WT;
+            break;
+        }
+    } else if (attr == 13) {
+        access |= PAGE_READ | PAGE_WRITE | PAGE_CACHE_ISOLATE;
+    }
+    return access;
+}
+
+/*!
+ * Convert region protection ATTR to PAGE_{READ,WRITE,EXEC} mask.
+ * See ISA, 4.6.3.3
+ */
+unsigned region_attr_to_access(uint32_t attr)
+{
+    static const unsigned access[16] = {
+         [0] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_WT,
+         [1] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WT,
+         [2] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_BYPASS,
+         [3] =                          PAGE_EXEC | PAGE_CACHE_WB,
+         [4] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WB,
+         [5] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WB,
+        [14] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_ISOLATE,
+    };
+
+    return access[attr & 0xf];
+}
+
+/*!
+ * Convert cacheattr to PAGE_{READ,WRITE,EXEC} mask.
+ * See ISA, A.2.14 The Cache Attribute Register
+ */
+unsigned cacheattr_attr_to_access(uint32_t attr)
+{
+    static const unsigned access[16] = {
+         [0] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_WT,
+         [1] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WT,
+         [2] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_BYPASS,
+         [3] =                          PAGE_EXEC | PAGE_CACHE_WB,
+         [4] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WB,
+        [14] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_ISOLATE,
+    };
+
+    return access[attr & 0xf];
+}
+
+struct attr_pattern {
+    uint32_t mask;
+    uint32_t value;
+};
+
+static int attr_pattern_match(uint32_t attr,
+                              const struct attr_pattern *pattern,
+                              size_t n)
+{
+    size_t i;
+
+    for (i = 0; i < n; ++i) {
+        if ((attr & pattern[i].mask) == pattern[i].value) {
+            return 1;
+        }
+    }
+    return 0;
+}
+
+unsigned mpu_attr_to_cpu_cache(uint32_t attr)
+{
+    static const struct attr_pattern cpu_c[] = {
+        { .mask = 0x18f, .value = 0x089 },
+        { .mask = 0x188, .value = 0x080 },
+        { .mask = 0x180, .value = 0x180 },
+    };
+
+    unsigned type = 0;
+
+    if (attr_pattern_match(attr, cpu_c, ARRAY_SIZE(cpu_c))) {
+        type |= XTENSA_MPU_TYPE_CPU_CACHE;
+        if (attr & 0x10) {
+            type |= XTENSA_MPU_TYPE_CPU_C;
+        }
+        if (attr & 0x20) {
+            type |= XTENSA_MPU_TYPE_CPU_W;
+        }
+        if (attr & 0x40) {
+            type |= XTENSA_MPU_TYPE_CPU_R;
+        }
+    }
+    return type;
+}
+
+unsigned mpu_attr_to_type(uint32_t attr)
+{
+    static const struct attr_pattern device_type[] = {
+        { .mask = 0x1f6, .value = 0x000 },
+        { .mask = 0x1f6, .value = 0x006 },
+    };
+    static const struct attr_pattern sys_nc_type[] = {
+        { .mask = 0x1fe, .value = 0x018 },
+        { .mask = 0x1fe, .value = 0x01e },
+        { .mask = 0x18f, .value = 0x089 },
+    };
+    static const struct attr_pattern sys_c_type[] = {
+        { .mask = 0x1f8, .value = 0x010 },
+        { .mask = 0x188, .value = 0x080 },
+        { .mask = 0x1f0, .value = 0x030 },
+        { .mask = 0x180, .value = 0x180 },
+    };
+    static const struct attr_pattern b[] = {
+        { .mask = 0x1f7, .value = 0x001 },
+        { .mask = 0x1f7, .value = 0x007 },
+        { .mask = 0x1ff, .value = 0x019 },
+        { .mask = 0x1ff, .value = 0x01f },
+    };
+
+    unsigned type = 0;
+
+    attr = (attr & XTENSA_MPU_MEM_TYPE_MASK) >> XTENSA_MPU_MEM_TYPE_SHIFT;
+    if (attr_pattern_match(attr, device_type, ARRAY_SIZE(device_type))) {
+        type |= XTENSA_MPU_SYSTEM_TYPE_DEVICE;
+        if (attr & 0x80) {
+            type |= XTENSA_MPU_TYPE_INT;
+        }
+    }
+    if (attr_pattern_match(attr, sys_nc_type, ARRAY_SIZE(sys_nc_type))) {
+        type |= XTENSA_MPU_SYSTEM_TYPE_NC;
+    }
+    if (attr_pattern_match(attr, sys_c_type, ARRAY_SIZE(sys_c_type))) {
+        type |= XTENSA_MPU_SYSTEM_TYPE_C;
+        if (attr & 0x1) {
+            type |= XTENSA_MPU_TYPE_SYS_C;
+        }
+        if (attr & 0x2) {
+            type |= XTENSA_MPU_TYPE_SYS_W;
+        }
+        if (attr & 0x4) {
+            type |= XTENSA_MPU_TYPE_SYS_R;
+        }
+    }
+    if (attr_pattern_match(attr, b, ARRAY_SIZE(b))) {
+        type |= XTENSA_MPU_TYPE_B;
+    }
+    type |= mpu_attr_to_cpu_cache(attr);
+
+    return type;
+}
+
+unsigned mpu_attr_to_access(uint32_t attr, unsigned ring)
+{
+    static const unsigned access[2][16] = {
+        [0] = {
+             [4] = PAGE_READ,
+             [5] = PAGE_READ              | PAGE_EXEC,
+             [6] = PAGE_READ | PAGE_WRITE,
+             [7] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+             [8] =             PAGE_WRITE,
+             [9] = PAGE_READ | PAGE_WRITE,
+            [10] = PAGE_READ | PAGE_WRITE,
+            [11] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+            [12] = PAGE_READ,
+            [13] = PAGE_READ              | PAGE_EXEC,
+            [14] = PAGE_READ | PAGE_WRITE,
+            [15] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+        },
+        [1] = {
+             [8] =             PAGE_WRITE,
+             [9] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+            [10] = PAGE_READ,
+            [11] = PAGE_READ              | PAGE_EXEC,
+            [12] = PAGE_READ,
+            [13] = PAGE_READ              | PAGE_EXEC,
+            [14] = PAGE_READ | PAGE_WRITE,
+            [15] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+        },
+    };
+    unsigned rv;
+    unsigned type;
+
+    type = mpu_attr_to_cpu_cache(attr);
+    rv = access[ring != 0][(attr & XTENSA_MPU_ACC_RIGHTS_MASK) >>
+        XTENSA_MPU_ACC_RIGHTS_SHIFT];
+
+    if (type & XTENSA_MPU_TYPE_CPU_CACHE) {
+        rv |= (type & XTENSA_MPU_TYPE_CPU_C) ? PAGE_CACHE_WB : PAGE_CACHE_WT;
+    } else {
+        rv |= PAGE_CACHE_BYPASS;
+    }
+    return rv;
+}
+
+static bool is_access_granted(unsigned access, int is_write)
+{
+    switch (is_write) {
+    case 0:
+        return access & PAGE_READ;
+
+    case 1:
+        return access & PAGE_WRITE;
+
+    case 2:
+        return access & PAGE_EXEC;
+
+    default:
+        return 0;
+    }
+}
+
+static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte);
+
+static int get_physical_addr_mmu(CPUXtensaState *env, bool update_tlb,
+                                 uint32_t vaddr, int is_write, int mmu_idx,
+                                 uint32_t *paddr, uint32_t *page_size,
+                                 unsigned *access, bool may_lookup_pt)
+{
+    bool dtlb = is_write != 2;
+    uint32_t wi;
+    uint32_t ei;
+    uint8_t ring;
+    uint32_t vpn;
+    uint32_t pte;
+    const xtensa_tlb_entry *entry = NULL;
+    xtensa_tlb_entry tmp_entry;
+    int ret = xtensa_tlb_lookup(env, vaddr, dtlb, &wi, &ei, &ring);
+
+    if ((ret == INST_TLB_MISS_CAUSE || ret == LOAD_STORE_TLB_MISS_CAUSE) &&
+        may_lookup_pt && get_pte(env, vaddr, &pte)) {
+        ring = (pte >> 4) & 0x3;
+        wi = 0;
+        xtensa_split_tlb_entry_spec_way(env, vaddr, dtlb, &vpn, wi, &ei);
+
+        if (update_tlb) {
+            wi = ++env->autorefill_idx & 0x3;
+            xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, pte);
+            env->sregs[EXCVADDR] = vaddr;
+            qemu_log_mask(CPU_LOG_MMU, "%s: autorefill(%08x): %08x -> %08x\n",
+                          __func__, vaddr, vpn, pte);
+        } else {
+            xtensa_tlb_set_entry_mmu(env, &tmp_entry, dtlb, wi, ei, vpn, pte);
+            entry = &tmp_entry;
+        }
+        ret = 0;
+    }
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (entry == NULL) {
+        entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
+    }
+
+    if (ring < mmu_idx) {
+        return dtlb ?
+            LOAD_STORE_PRIVILEGE_CAUSE :
+            INST_FETCH_PRIVILEGE_CAUSE;
+    }
+
+    *access = mmu_attr_to_access(entry->attr) &
+        ~(dtlb ? PAGE_EXEC : PAGE_READ | PAGE_WRITE);
+    if (!is_access_granted(*access, is_write)) {
+        return dtlb ?
+            (is_write ?
+             STORE_PROHIBITED_CAUSE :
+             LOAD_PROHIBITED_CAUSE) :
+            INST_FETCH_PROHIBITED_CAUSE;
+    }
+
+    *paddr = entry->paddr | (vaddr & ~xtensa_tlb_get_addr_mask(env, dtlb, wi));
+    *page_size = ~xtensa_tlb_get_addr_mask(env, dtlb, wi) + 1;
+
+    return 0;
+}
+
+static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte)
+{
+    CPUState *cs = env_cpu(env);
+    uint32_t paddr;
+    uint32_t page_size;
+    unsigned access;
+    uint32_t pt_vaddr =
+        (env->sregs[PTEVADDR] | (vaddr >> 10)) & 0xfffffffc;
+    int ret = get_physical_addr_mmu(env, false, pt_vaddr, 0, 0,
+                                    &paddr, &page_size, &access, false);
+
+    if (ret == 0) {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: autorefill(%08x): PTE va = %08x, pa = %08x\n",
+                      __func__, vaddr, pt_vaddr, paddr);
+    } else {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: autorefill(%08x): PTE va = %08x, failed (%d)\n",
+                      __func__, vaddr, pt_vaddr, ret);
+    }
+
+    if (ret == 0) {
+        MemTxResult result;
+
+        *pte = address_space_ldl(cs->as, paddr, MEMTXATTRS_UNSPECIFIED,
+                                 &result);
+        if (result != MEMTX_OK) {
+            qemu_log_mask(CPU_LOG_MMU,
+                          "%s: couldn't load PTE: transaction failed (%u)\n",
+                          __func__, (unsigned)result);
+            ret = 1;
+        }
+    }
+    return ret == 0;
+}
+
+static int get_physical_addr_region(CPUXtensaState *env,
+                                    uint32_t vaddr, int is_write, int mmu_idx,
+                                    uint32_t *paddr, uint32_t *page_size,
+                                    unsigned *access)
+{
+    bool dtlb = is_write != 2;
+    uint32_t wi = 0;
+    uint32_t ei = (vaddr >> 29) & 0x7;
+    const xtensa_tlb_entry *entry =
+        xtensa_tlb_get_entry(env, dtlb, wi, ei);
+
+    *access = region_attr_to_access(entry->attr);
+    if (!is_access_granted(*access, is_write)) {
+        return dtlb ?
+            (is_write ?
+             STORE_PROHIBITED_CAUSE :
+             LOAD_PROHIBITED_CAUSE) :
+            INST_FETCH_PROHIBITED_CAUSE;
+    }
+
+    *paddr = entry->paddr | (vaddr & ~REGION_PAGE_MASK);
+    *page_size = ~REGION_PAGE_MASK + 1;
+
+    return 0;
+}
+
+int xtensa_mpu_lookup(const xtensa_mpu_entry *entry, unsigned n,
+                      uint32_t vaddr, unsigned *segment)
+{
+    unsigned nhits = 0;
+    unsigned i;
+
+    for (i = 0; i < n; ++i) {
+        if (vaddr >= entry[i].vaddr &&
+            (i == n - 1 || vaddr < entry[i + 1].vaddr)) {
+            if (nhits++) {
+                break;
+            }
+            *segment = i;
+        }
+    }
+    return nhits;
+}
+
+static int get_physical_addr_mpu(CPUXtensaState *env,
+                                 uint32_t vaddr, int is_write, int mmu_idx,
+                                 uint32_t *paddr, uint32_t *page_size,
+                                 unsigned *access)
+{
+    unsigned nhits;
+    unsigned segment;
+    uint32_t attr;
+
+    nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
+                              vaddr, &segment);
+    if (nhits > 1) {
+        return is_write < 2 ?
+            LOAD_STORE_TLB_MULTI_HIT_CAUSE :
+            INST_TLB_MULTI_HIT_CAUSE;
+    } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
+        attr = env->mpu_fg[segment].attr;
+    } else {
+        xtensa_mpu_lookup(env->config->mpu_bg,
+                          env->config->n_mpu_bg_segments,
+                          vaddr, &segment);
+        attr = env->config->mpu_bg[segment].attr;
+    }
+
+    *access = mpu_attr_to_access(attr, mmu_idx);
+    if (!is_access_granted(*access, is_write)) {
+        return is_write < 2 ?
+            (is_write ?
+             STORE_PROHIBITED_CAUSE :
+             LOAD_PROHIBITED_CAUSE) :
+            INST_FETCH_PROHIBITED_CAUSE;
+    }
+    *paddr = vaddr;
+    *page_size = env->config->mpu_align;
+    return 0;
+}
+
+/*!
+ * Convert virtual address to physical addr.
+ * MMU may issue pagewalk and change xtensa autorefill TLB way entry.
+ *
+ * \return 0 if ok, exception cause code otherwise
+ */
+int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
+                             uint32_t vaddr, int is_write, int mmu_idx,
+                             uint32_t *paddr, uint32_t *page_size,
+                             unsigned *access)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        return get_physical_addr_mmu(env, update_tlb,
+                                     vaddr, is_write, mmu_idx, paddr,
+                                     page_size, access, true);
+    } else if (xtensa_option_bits_enabled(env->config,
+                XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
+                XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION))) {
+        return get_physical_addr_region(env, vaddr, is_write, mmu_idx,
+                                        paddr, page_size, access);
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
+        return get_physical_addr_mpu(env, vaddr, is_write, mmu_idx,
+                                     paddr, page_size, access);
+    } else {
+        *paddr = vaddr;
+        *page_size = TARGET_PAGE_SIZE;
+        *access = cacheattr_attr_to_access(env->sregs[CACHEATTR] >>
+                                           ((vaddr & 0xe0000000) >> 27));
+        return 0;
+    }
+}
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 31ee3fa957..8be8d79dcd 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -26,38 +26,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/log.h"
 #include "qemu/qemu-print.h"
 #include "qemu/units.h"
-#include "cpu.h"
 #include "exec/helper-proto.h"
-#include "qemu/host-utils.h"
 #include "exec/exec-all.h"
-
-#define XTENSA_MPU_SEGMENT_MASK 0x0000001f
-#define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
-#define XTENSA_MPU_ACC_RIGHTS_SHIFT 8
-#define XTENSA_MPU_MEM_TYPE_MASK 0x001ff000
-#define XTENSA_MPU_MEM_TYPE_SHIFT 12
-#define XTENSA_MPU_ATTR_MASK 0x001fff00
-
-#define XTENSA_MPU_PROBE_B 0x40000000
-#define XTENSA_MPU_PROBE_V 0x80000000
-
-#define XTENSA_MPU_SYSTEM_TYPE_DEVICE 0x0001
-#define XTENSA_MPU_SYSTEM_TYPE_NC     0x0002
-#define XTENSA_MPU_SYSTEM_TYPE_C      0x0003
-#define XTENSA_MPU_SYSTEM_TYPE_MASK   0x0003
-
-#define XTENSA_MPU_TYPE_SYS_C     0x0010
-#define XTENSA_MPU_TYPE_SYS_W     0x0020
-#define XTENSA_MPU_TYPE_SYS_R     0x0040
-#define XTENSA_MPU_TYPE_CPU_C     0x0100
-#define XTENSA_MPU_TYPE_CPU_W     0x0200
-#define XTENSA_MPU_TYPE_CPU_R     0x0400
-#define XTENSA_MPU_TYPE_CPU_CACHE 0x0800
-#define XTENSA_MPU_TYPE_B         0x1000
-#define XTENSA_MPU_TYPE_INT       0x2000
+#include "cpu.h"
+#include "mmu.h"
 
 void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
 {
@@ -78,421 +52,6 @@ void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
     }
 }
 
-static uint32_t get_page_size(const CPUXtensaState *env,
-                              bool dtlb, uint32_t way)
-{
-    uint32_t tlbcfg = env->sregs[dtlb ? DTLBCFG : ITLBCFG];
-
-    switch (way) {
-    case 4:
-        return (tlbcfg >> 16) & 0x3;
-
-    case 5:
-        return (tlbcfg >> 20) & 0x1;
-
-    case 6:
-        return (tlbcfg >> 24) & 0x1;
-
-    default:
-        return 0;
-    }
-}
-
-/*!
- * Get bit mask for the virtual address bits translated by the TLB way
- */
-static uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
-                                         bool dtlb, uint32_t way)
-{
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        bool varway56 = dtlb ?
-            env->config->dtlb.varway56 :
-            env->config->itlb.varway56;
-
-        switch (way) {
-        case 4:
-            return 0xfff00000 << get_page_size(env, dtlb, way) * 2;
-
-        case 5:
-            if (varway56) {
-                return 0xf8000000 << get_page_size(env, dtlb, way);
-            } else {
-                return 0xf8000000;
-            }
-
-        case 6:
-            if (varway56) {
-                return 0xf0000000 << (1 - get_page_size(env, dtlb, way));
-            } else {
-                return 0xf0000000;
-            }
-
-        default:
-            return 0xfffff000;
-        }
-    } else {
-        return REGION_PAGE_MASK;
-    }
-}
-
-/*!
- * Get bit mask for the 'VPN without index' field.
- * See ISA, 4.6.5.6, data format for RxTLB0
- */
-static uint32_t xtensa_get_vpn_mask(const CPUXtensaState *env, bool dtlb,
-                                    uint32_t way)
-{
-    if (way < 4) {
-        bool is32 = (dtlb ?
-                env->config->dtlb.nrefillentries :
-                env->config->itlb.nrefillentries) == 32;
-        return is32 ? 0xffff8000 : 0xffffc000;
-    } else if (way == 4) {
-        return xtensa_tlb_get_addr_mask(env, dtlb, way) << 2;
-    } else if (way <= 6) {
-        uint32_t mask = xtensa_tlb_get_addr_mask(env, dtlb, way);
-        bool varway56 = dtlb ?
-            env->config->dtlb.varway56 :
-            env->config->itlb.varway56;
-
-        if (varway56) {
-            return mask << (way == 5 ? 2 : 3);
-        } else {
-            return mask << 1;
-        }
-    } else {
-        return 0xfffff000;
-    }
-}
-
-/*!
- * Split virtual address into VPN (with index) and entry index
- * for the given TLB way
- */
-static void xtensa_split_tlb_entry_spec_way(const CPUXtensaState *env,
-                                            uint32_t v,
-                                            bool dtlb, uint32_t *vpn,
-                                            uint32_t wi, uint32_t *ei)
-{
-    bool varway56 = dtlb ?
-        env->config->dtlb.varway56 :
-        env->config->itlb.varway56;
-
-    if (!dtlb) {
-        wi &= 7;
-    }
-
-    if (wi < 4) {
-        bool is32 = (dtlb ?
-                env->config->dtlb.nrefillentries :
-                env->config->itlb.nrefillentries) == 32;
-        *ei = (v >> 12) & (is32 ? 0x7 : 0x3);
-    } else {
-        switch (wi) {
-        case 4:
-            {
-                uint32_t eibase = 20 + get_page_size(env, dtlb, wi) * 2;
-                *ei = (v >> eibase) & 0x3;
-            }
-            break;
-
-        case 5:
-            if (varway56) {
-                uint32_t eibase = 27 + get_page_size(env, dtlb, wi);
-                *ei = (v >> eibase) & 0x3;
-            } else {
-                *ei = (v >> 27) & 0x1;
-            }
-            break;
-
-        case 6:
-            if (varway56) {
-                uint32_t eibase = 29 - get_page_size(env, dtlb, wi);
-                *ei = (v >> eibase) & 0x7;
-            } else {
-                *ei = (v >> 28) & 0x1;
-            }
-            break;
-
-        default:
-            *ei = 0;
-            break;
-        }
-    }
-    *vpn = v & xtensa_tlb_get_addr_mask(env, dtlb, wi);
-}
-
-/*!
- * Split TLB address into TLB way, entry index and VPN (with index).
- * See ISA, 4.6.5.5 - 4.6.5.8 for the TLB addressing format
- */
-static bool xtensa_split_tlb_entry_spec(CPUXtensaState *env,
-                                        uint32_t v, bool dtlb,
-                                        uint32_t *vpn, uint32_t *wi,
-                                        uint32_t *ei)
-{
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        *wi = v & (dtlb ? 0xf : 0x7);
-        if (*wi < (dtlb ? env->config->dtlb.nways : env->config->itlb.nways)) {
-            xtensa_split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
-            return true;
-        } else {
-            return false;
-        }
-    } else {
-        *vpn = v & REGION_PAGE_MASK;
-        *wi = 0;
-        *ei = (v >> 29) & 0x7;
-        return true;
-    }
-}
-
-static xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
-                                              unsigned wi, unsigned ei)
-{
-    const xtensa_tlb *tlb = dtlb ? &env->config->dtlb : &env->config->itlb;
-
-    assert(wi < tlb->nways && ei < tlb->way_size[wi]);
-    return dtlb ?
-        env->dtlb[wi] + ei :
-        env->itlb[wi] + ei;
-}
-
-static xtensa_tlb_entry *xtensa_get_tlb_entry(CPUXtensaState *env,
-        uint32_t v, bool dtlb, uint32_t *pwi)
-{
-    uint32_t vpn;
-    uint32_t wi;
-    uint32_t ei;
-
-    if (xtensa_split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
-        if (pwi) {
-            *pwi = wi;
-        }
-        return xtensa_tlb_get_entry(env, dtlb, wi, ei);
-    } else {
-        return NULL;
-    }
-}
-
-static void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
-                                     xtensa_tlb_entry *entry, bool dtlb,
-                                     unsigned wi, unsigned ei, uint32_t vpn,
-                                     uint32_t pte)
-{
-    entry->vaddr = vpn;
-    entry->paddr = pte & xtensa_tlb_get_addr_mask(env, dtlb, wi);
-    entry->asid = (env->sregs[RASID] >> ((pte >> 1) & 0x18)) & 0xff;
-    entry->attr = pte & 0xf;
-}
-
-static void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
-                                 unsigned wi, unsigned ei,
-                                 uint32_t vpn, uint32_t pte)
-{
-    CPUState *cs = env_cpu(env);
-    xtensa_tlb_entry *entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
-
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        if (entry->variable) {
-            if (entry->asid) {
-                tlb_flush_page(cs, entry->vaddr);
-            }
-            xtensa_tlb_set_entry_mmu(env, entry, dtlb, wi, ei, vpn, pte);
-            tlb_flush_page(cs, entry->vaddr);
-        } else {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s %d, %d, %d trying to set immutable entry\n",
-                          __func__, dtlb, wi, ei);
-        }
-    } else {
-        tlb_flush_page(cs, entry->vaddr);
-        if (xtensa_option_enabled(env->config,
-                    XTENSA_OPTION_REGION_TRANSLATION)) {
-            entry->paddr = pte & REGION_PAGE_MASK;
-        }
-        entry->attr = pte & 0xf;
-    }
-}
-
-hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-{
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    uint32_t paddr;
-    uint32_t page_size;
-    unsigned access;
-
-    if (xtensa_get_physical_addr(&cpu->env, false, addr, 0, 0,
-                &paddr, &page_size, &access) == 0) {
-        return paddr;
-    }
-    if (xtensa_get_physical_addr(&cpu->env, false, addr, 2, 0,
-                &paddr, &page_size, &access) == 0) {
-        return paddr;
-    }
-    return ~0;
-}
-
-static void reset_tlb_mmu_all_ways(CPUXtensaState *env,
-                                   const xtensa_tlb *tlb,
-                                   xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
-{
-    unsigned wi, ei;
-
-    for (wi = 0; wi < tlb->nways; ++wi) {
-        for (ei = 0; ei < tlb->way_size[wi]; ++ei) {
-            entry[wi][ei].asid = 0;
-            entry[wi][ei].variable = true;
-        }
-    }
-}
-
-static void reset_tlb_mmu_ways56(CPUXtensaState *env,
-                                 const xtensa_tlb *tlb,
-                                 xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
-{
-    if (!tlb->varway56) {
-        static const xtensa_tlb_entry way5[] = {
-            {
-                .vaddr = 0xd0000000,
-                .paddr = 0,
-                .asid = 1,
-                .attr = 7,
-                .variable = false,
-            }, {
-                .vaddr = 0xd8000000,
-                .paddr = 0,
-                .asid = 1,
-                .attr = 3,
-                .variable = false,
-            }
-        };
-        static const xtensa_tlb_entry way6[] = {
-            {
-                .vaddr = 0xe0000000,
-                .paddr = 0xf0000000,
-                .asid = 1,
-                .attr = 7,
-                .variable = false,
-            }, {
-                .vaddr = 0xf0000000,
-                .paddr = 0xf0000000,
-                .asid = 1,
-                .attr = 3,
-                .variable = false,
-            }
-        };
-        memcpy(entry[5], way5, sizeof(way5));
-        memcpy(entry[6], way6, sizeof(way6));
-    } else {
-        uint32_t ei;
-        for (ei = 0; ei < 8; ++ei) {
-            entry[6][ei].vaddr = ei << 29;
-            entry[6][ei].paddr = ei << 29;
-            entry[6][ei].asid = 1;
-            entry[6][ei].attr = 3;
-        }
-    }
-}
-
-static void reset_tlb_region_way0(CPUXtensaState *env,
-                                  xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
-{
-    unsigned ei;
-
-    for (ei = 0; ei < 8; ++ei) {
-        entry[0][ei].vaddr = ei << 29;
-        entry[0][ei].paddr = ei << 29;
-        entry[0][ei].asid = 1;
-        entry[0][ei].attr = 2;
-        entry[0][ei].variable = true;
-    }
-}
-
-void xtensa_reset_mmu(CPUXtensaState *env)
-{
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        env->sregs[RASID] = 0x04030201;
-        env->sregs[ITLBCFG] = 0;
-        env->sregs[DTLBCFG] = 0;
-        env->autorefill_idx = 0;
-        reset_tlb_mmu_all_ways(env, &env->config->itlb, env->itlb);
-        reset_tlb_mmu_all_ways(env, &env->config->dtlb, env->dtlb);
-        reset_tlb_mmu_ways56(env, &env->config->itlb, env->itlb);
-        reset_tlb_mmu_ways56(env, &env->config->dtlb, env->dtlb);
-    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
-        unsigned i;
-
-        env->sregs[MPUENB] = 0;
-        env->sregs[MPUCFG] = env->config->n_mpu_fg_segments;
-        env->sregs[CACHEADRDIS] = 0;
-        assert(env->config->n_mpu_bg_segments > 0 &&
-               env->config->mpu_bg[0].vaddr == 0);
-        for (i = 1; i < env->config->n_mpu_bg_segments; ++i) {
-            assert(env->config->mpu_bg[i].vaddr >=
-                   env->config->mpu_bg[i - 1].vaddr);
-        }
-    } else {
-        env->sregs[CACHEATTR] = 0x22222222;
-        reset_tlb_region_way0(env, env->itlb);
-        reset_tlb_region_way0(env, env->dtlb);
-    }
-}
-
-static unsigned get_ring(const CPUXtensaState *env, uint8_t asid)
-{
-    unsigned i;
-    for (i = 0; i < 4; ++i) {
-        if (((env->sregs[RASID] >> i * 8) & 0xff) == asid) {
-            return i;
-        }
-    }
-    return 0xff;
-}
-
-/*!
- * Lookup xtensa TLB for the given virtual address.
- * See ISA, 4.6.2.2
- *
- * \param pwi: [out] way index
- * \param pei: [out] entry index
- * \param pring: [out] access ring
- * \return 0 if ok, exception cause code otherwise
- */
-static int xtensa_tlb_lookup(const CPUXtensaState *env,
-                             uint32_t addr, bool dtlb,
-                             uint32_t *pwi, uint32_t *pei, uint8_t *pring)
-{
-    const xtensa_tlb *tlb = dtlb ?
-        &env->config->dtlb : &env->config->itlb;
-    const xtensa_tlb_entry (*entry)[MAX_TLB_WAY_SIZE] = dtlb ?
-        env->dtlb : env->itlb;
-
-    int nhits = 0;
-    unsigned wi;
-
-    for (wi = 0; wi < tlb->nways; ++wi) {
-        uint32_t vpn;
-        uint32_t ei;
-        xtensa_split_tlb_entry_spec_way(env, addr, dtlb, &vpn, wi, &ei);
-        if (entry[wi][ei].vaddr == vpn && entry[wi][ei].asid) {
-            unsigned ring = get_ring(env, entry[wi][ei].asid);
-            if (ring < 4) {
-                if (++nhits > 1) {
-                    return dtlb ?
-                        LOAD_STORE_TLB_MULTI_HIT_CAUSE :
-                        INST_TLB_MULTI_HIT_CAUSE;
-                }
-                *pwi = wi;
-                *pei = ei;
-                *pring = ring;
-            }
-        }
-    }
-    return nhits ? 0 :
-        (dtlb ? LOAD_STORE_TLB_MISS_CAUSE : INST_TLB_MISS_CAUSE);
-}
-
 uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
@@ -569,384 +128,6 @@ void HELPER(wtlb)(CPUXtensaState *env, uint32_t p, uint32_t v, uint32_t dtlb)
     }
 }
 
-/*!
- * Convert MMU ATTR to PAGE_{READ,WRITE,EXEC} mask.
- * See ISA, 4.6.5.10
- */
-static unsigned mmu_attr_to_access(uint32_t attr)
-{
-    unsigned access = 0;
-
-    if (attr < 12) {
-        access |= PAGE_READ;
-        if (attr & 0x1) {
-            access |= PAGE_EXEC;
-        }
-        if (attr & 0x2) {
-            access |= PAGE_WRITE;
-        }
-
-        switch (attr & 0xc) {
-        case 0:
-            access |= PAGE_CACHE_BYPASS;
-            break;
-
-        case 4:
-            access |= PAGE_CACHE_WB;
-            break;
-
-        case 8:
-            access |= PAGE_CACHE_WT;
-            break;
-        }
-    } else if (attr == 13) {
-        access |= PAGE_READ | PAGE_WRITE | PAGE_CACHE_ISOLATE;
-    }
-    return access;
-}
-
-/*!
- * Convert region protection ATTR to PAGE_{READ,WRITE,EXEC} mask.
- * See ISA, 4.6.3.3
- */
-static unsigned region_attr_to_access(uint32_t attr)
-{
-    static const unsigned access[16] = {
-         [0] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_WT,
-         [1] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WT,
-         [2] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_BYPASS,
-         [3] =                          PAGE_EXEC | PAGE_CACHE_WB,
-         [4] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WB,
-         [5] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WB,
-        [14] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_ISOLATE,
-    };
-
-    return access[attr & 0xf];
-}
-
-/*!
- * Convert cacheattr to PAGE_{READ,WRITE,EXEC} mask.
- * See ISA, A.2.14 The Cache Attribute Register
- */
-static unsigned cacheattr_attr_to_access(uint32_t attr)
-{
-    static const unsigned access[16] = {
-         [0] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_WT,
-         [1] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WT,
-         [2] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_BYPASS,
-         [3] =                          PAGE_EXEC | PAGE_CACHE_WB,
-         [4] = PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_CACHE_WB,
-        [14] = PAGE_READ | PAGE_WRITE             | PAGE_CACHE_ISOLATE,
-    };
-
-    return access[attr & 0xf];
-}
-
-struct attr_pattern {
-    uint32_t mask;
-    uint32_t value;
-};
-
-static int attr_pattern_match(uint32_t attr,
-                              const struct attr_pattern *pattern,
-                              size_t n)
-{
-    size_t i;
-
-    for (i = 0; i < n; ++i) {
-        if ((attr & pattern[i].mask) == pattern[i].value) {
-            return 1;
-        }
-    }
-    return 0;
-}
-
-static unsigned mpu_attr_to_cpu_cache(uint32_t attr)
-{
-    static const struct attr_pattern cpu_c[] = {
-        { .mask = 0x18f, .value = 0x089 },
-        { .mask = 0x188, .value = 0x080 },
-        { .mask = 0x180, .value = 0x180 },
-    };
-
-    unsigned type = 0;
-
-    if (attr_pattern_match(attr, cpu_c, ARRAY_SIZE(cpu_c))) {
-        type |= XTENSA_MPU_TYPE_CPU_CACHE;
-        if (attr & 0x10) {
-            type |= XTENSA_MPU_TYPE_CPU_C;
-        }
-        if (attr & 0x20) {
-            type |= XTENSA_MPU_TYPE_CPU_W;
-        }
-        if (attr & 0x40) {
-            type |= XTENSA_MPU_TYPE_CPU_R;
-        }
-    }
-    return type;
-}
-
-static unsigned mpu_attr_to_type(uint32_t attr)
-{
-    static const struct attr_pattern device_type[] = {
-        { .mask = 0x1f6, .value = 0x000 },
-        { .mask = 0x1f6, .value = 0x006 },
-    };
-    static const struct attr_pattern sys_nc_type[] = {
-        { .mask = 0x1fe, .value = 0x018 },
-        { .mask = 0x1fe, .value = 0x01e },
-        { .mask = 0x18f, .value = 0x089 },
-    };
-    static const struct attr_pattern sys_c_type[] = {
-        { .mask = 0x1f8, .value = 0x010 },
-        { .mask = 0x188, .value = 0x080 },
-        { .mask = 0x1f0, .value = 0x030 },
-        { .mask = 0x180, .value = 0x180 },
-    };
-    static const struct attr_pattern b[] = {
-        { .mask = 0x1f7, .value = 0x001 },
-        { .mask = 0x1f7, .value = 0x007 },
-        { .mask = 0x1ff, .value = 0x019 },
-        { .mask = 0x1ff, .value = 0x01f },
-    };
-
-    unsigned type = 0;
-
-    attr = (attr & XTENSA_MPU_MEM_TYPE_MASK) >> XTENSA_MPU_MEM_TYPE_SHIFT;
-    if (attr_pattern_match(attr, device_type, ARRAY_SIZE(device_type))) {
-        type |= XTENSA_MPU_SYSTEM_TYPE_DEVICE;
-        if (attr & 0x80) {
-            type |= XTENSA_MPU_TYPE_INT;
-        }
-    }
-    if (attr_pattern_match(attr, sys_nc_type, ARRAY_SIZE(sys_nc_type))) {
-        type |= XTENSA_MPU_SYSTEM_TYPE_NC;
-    }
-    if (attr_pattern_match(attr, sys_c_type, ARRAY_SIZE(sys_c_type))) {
-        type |= XTENSA_MPU_SYSTEM_TYPE_C;
-        if (attr & 0x1) {
-            type |= XTENSA_MPU_TYPE_SYS_C;
-        }
-        if (attr & 0x2) {
-            type |= XTENSA_MPU_TYPE_SYS_W;
-        }
-        if (attr & 0x4) {
-            type |= XTENSA_MPU_TYPE_SYS_R;
-        }
-    }
-    if (attr_pattern_match(attr, b, ARRAY_SIZE(b))) {
-        type |= XTENSA_MPU_TYPE_B;
-    }
-    type |= mpu_attr_to_cpu_cache(attr);
-
-    return type;
-}
-
-static unsigned mpu_attr_to_access(uint32_t attr, unsigned ring)
-{
-    static const unsigned access[2][16] = {
-        [0] = {
-             [4] = PAGE_READ,
-             [5] = PAGE_READ              | PAGE_EXEC,
-             [6] = PAGE_READ | PAGE_WRITE,
-             [7] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
-             [8] =             PAGE_WRITE,
-             [9] = PAGE_READ | PAGE_WRITE,
-            [10] = PAGE_READ | PAGE_WRITE,
-            [11] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
-            [12] = PAGE_READ,
-            [13] = PAGE_READ              | PAGE_EXEC,
-            [14] = PAGE_READ | PAGE_WRITE,
-            [15] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
-        },
-        [1] = {
-             [8] =             PAGE_WRITE,
-             [9] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
-            [10] = PAGE_READ,
-            [11] = PAGE_READ              | PAGE_EXEC,
-            [12] = PAGE_READ,
-            [13] = PAGE_READ              | PAGE_EXEC,
-            [14] = PAGE_READ | PAGE_WRITE,
-            [15] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
-        },
-    };
-    unsigned rv;
-    unsigned type;
-
-    type = mpu_attr_to_cpu_cache(attr);
-    rv = access[ring != 0][(attr & XTENSA_MPU_ACC_RIGHTS_MASK) >>
-        XTENSA_MPU_ACC_RIGHTS_SHIFT];
-
-    if (type & XTENSA_MPU_TYPE_CPU_CACHE) {
-        rv |= (type & XTENSA_MPU_TYPE_CPU_C) ? PAGE_CACHE_WB : PAGE_CACHE_WT;
-    } else {
-        rv |= PAGE_CACHE_BYPASS;
-    }
-    return rv;
-}
-
-static bool is_access_granted(unsigned access, int is_write)
-{
-    switch (is_write) {
-    case 0:
-        return access & PAGE_READ;
-
-    case 1:
-        return access & PAGE_WRITE;
-
-    case 2:
-        return access & PAGE_EXEC;
-
-    default:
-        return 0;
-    }
-}
-
-static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte);
-
-static int get_physical_addr_mmu(CPUXtensaState *env, bool update_tlb,
-                                 uint32_t vaddr, int is_write, int mmu_idx,
-                                 uint32_t *paddr, uint32_t *page_size,
-                                 unsigned *access, bool may_lookup_pt)
-{
-    bool dtlb = is_write != 2;
-    uint32_t wi;
-    uint32_t ei;
-    uint8_t ring;
-    uint32_t vpn;
-    uint32_t pte;
-    const xtensa_tlb_entry *entry = NULL;
-    xtensa_tlb_entry tmp_entry;
-    int ret = xtensa_tlb_lookup(env, vaddr, dtlb, &wi, &ei, &ring);
-
-    if ((ret == INST_TLB_MISS_CAUSE || ret == LOAD_STORE_TLB_MISS_CAUSE) &&
-        may_lookup_pt && get_pte(env, vaddr, &pte)) {
-        ring = (pte >> 4) & 0x3;
-        wi = 0;
-        xtensa_split_tlb_entry_spec_way(env, vaddr, dtlb, &vpn, wi, &ei);
-
-        if (update_tlb) {
-            wi = ++env->autorefill_idx & 0x3;
-            xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, pte);
-            env->sregs[EXCVADDR] = vaddr;
-            qemu_log_mask(CPU_LOG_MMU, "%s: autorefill(%08x): %08x -> %08x\n",
-                          __func__, vaddr, vpn, pte);
-        } else {
-            xtensa_tlb_set_entry_mmu(env, &tmp_entry, dtlb, wi, ei, vpn, pte);
-            entry = &tmp_entry;
-        }
-        ret = 0;
-    }
-    if (ret != 0) {
-        return ret;
-    }
-
-    if (entry == NULL) {
-        entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
-    }
-
-    if (ring < mmu_idx) {
-        return dtlb ?
-            LOAD_STORE_PRIVILEGE_CAUSE :
-            INST_FETCH_PRIVILEGE_CAUSE;
-    }
-
-    *access = mmu_attr_to_access(entry->attr) &
-        ~(dtlb ? PAGE_EXEC : PAGE_READ | PAGE_WRITE);
-    if (!is_access_granted(*access, is_write)) {
-        return dtlb ?
-            (is_write ?
-             STORE_PROHIBITED_CAUSE :
-             LOAD_PROHIBITED_CAUSE) :
-            INST_FETCH_PROHIBITED_CAUSE;
-    }
-
-    *paddr = entry->paddr | (vaddr & ~xtensa_tlb_get_addr_mask(env, dtlb, wi));
-    *page_size = ~xtensa_tlb_get_addr_mask(env, dtlb, wi) + 1;
-
-    return 0;
-}
-
-static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte)
-{
-    CPUState *cs = env_cpu(env);
-    uint32_t paddr;
-    uint32_t page_size;
-    unsigned access;
-    uint32_t pt_vaddr =
-        (env->sregs[PTEVADDR] | (vaddr >> 10)) & 0xfffffffc;
-    int ret = get_physical_addr_mmu(env, false, pt_vaddr, 0, 0,
-                                    &paddr, &page_size, &access, false);
-
-    if (ret == 0) {
-        qemu_log_mask(CPU_LOG_MMU,
-                      "%s: autorefill(%08x): PTE va = %08x, pa = %08x\n",
-                      __func__, vaddr, pt_vaddr, paddr);
-    } else {
-        qemu_log_mask(CPU_LOG_MMU,
-                      "%s: autorefill(%08x): PTE va = %08x, failed (%d)\n",
-                      __func__, vaddr, pt_vaddr, ret);
-    }
-
-    if (ret == 0) {
-        MemTxResult result;
-
-        *pte = address_space_ldl(cs->as, paddr, MEMTXATTRS_UNSPECIFIED,
-                                 &result);
-        if (result != MEMTX_OK) {
-            qemu_log_mask(CPU_LOG_MMU,
-                          "%s: couldn't load PTE: transaction failed (%u)\n",
-                          __func__, (unsigned)result);
-            ret = 1;
-        }
-    }
-    return ret == 0;
-}
-
-static int get_physical_addr_region(CPUXtensaState *env,
-                                    uint32_t vaddr, int is_write, int mmu_idx,
-                                    uint32_t *paddr, uint32_t *page_size,
-                                    unsigned *access)
-{
-    bool dtlb = is_write != 2;
-    uint32_t wi = 0;
-    uint32_t ei = (vaddr >> 29) & 0x7;
-    const xtensa_tlb_entry *entry =
-        xtensa_tlb_get_entry(env, dtlb, wi, ei);
-
-    *access = region_attr_to_access(entry->attr);
-    if (!is_access_granted(*access, is_write)) {
-        return dtlb ?
-            (is_write ?
-             STORE_PROHIBITED_CAUSE :
-             LOAD_PROHIBITED_CAUSE) :
-            INST_FETCH_PROHIBITED_CAUSE;
-    }
-
-    *paddr = entry->paddr | (vaddr & ~REGION_PAGE_MASK);
-    *page_size = ~REGION_PAGE_MASK + 1;
-
-    return 0;
-}
-
-static int xtensa_mpu_lookup(const xtensa_mpu_entry *entry, unsigned n,
-                             uint32_t vaddr, unsigned *segment)
-{
-    unsigned nhits = 0;
-    unsigned i;
-
-    for (i = 0; i < n; ++i) {
-        if (vaddr >= entry[i].vaddr &&
-            (i == n - 1 || vaddr < entry[i + 1].vaddr)) {
-            if (nhits++) {
-                break;
-            }
-            *segment = i;
-        }
-    }
-    return nhits;
-}
-
 void HELPER(wsr_mpuenb)(CPUXtensaState *env, uint32_t v)
 {
     v &= (2u << (env->config->n_mpu_fg_segments - 1)) - 1;
@@ -1013,75 +194,6 @@ uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
     }
 }
 
-static int get_physical_addr_mpu(CPUXtensaState *env,
-                                 uint32_t vaddr, int is_write, int mmu_idx,
-                                 uint32_t *paddr, uint32_t *page_size,
-                                 unsigned *access)
-{
-    unsigned nhits;
-    unsigned segment;
-    uint32_t attr;
-
-    nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
-                              vaddr, &segment);
-    if (nhits > 1) {
-        return is_write < 2 ?
-            LOAD_STORE_TLB_MULTI_HIT_CAUSE :
-            INST_TLB_MULTI_HIT_CAUSE;
-    } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
-        attr = env->mpu_fg[segment].attr;
-    } else {
-        xtensa_mpu_lookup(env->config->mpu_bg,
-                          env->config->n_mpu_bg_segments,
-                          vaddr, &segment);
-        attr = env->config->mpu_bg[segment].attr;
-    }
-
-    *access = mpu_attr_to_access(attr, mmu_idx);
-    if (!is_access_granted(*access, is_write)) {
-        return is_write < 2 ?
-            (is_write ?
-             STORE_PROHIBITED_CAUSE :
-             LOAD_PROHIBITED_CAUSE) :
-            INST_FETCH_PROHIBITED_CAUSE;
-    }
-    *paddr = vaddr;
-    *page_size = env->config->mpu_align;
-    return 0;
-}
-
-/*!
- * Convert virtual address to physical addr.
- * MMU may issue pagewalk and change xtensa autorefill TLB way entry.
- *
- * \return 0 if ok, exception cause code otherwise
- */
-int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
-                             uint32_t vaddr, int is_write, int mmu_idx,
-                             uint32_t *paddr, uint32_t *page_size,
-                             unsigned *access)
-{
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        return get_physical_addr_mmu(env, update_tlb,
-                                     vaddr, is_write, mmu_idx, paddr,
-                                     page_size, access, true);
-    } else if (xtensa_option_bits_enabled(env->config,
-                XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
-                XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION))) {
-        return get_physical_addr_region(env, vaddr, is_write, mmu_idx,
-                                        paddr, page_size, access);
-    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
-        return get_physical_addr_mpu(env, vaddr, is_write, mmu_idx,
-                                     paddr, page_size, access);
-    } else {
-        *paddr = vaddr;
-        *page_size = TARGET_PAGE_SIZE;
-        *access = cacheattr_attr_to_access(env->sregs[CACHEATTR] >>
-                                           ((vaddr & 0xe0000000) >> 27));
-        return 0;
-    }
-}
-
 static void dump_tlb(CPUXtensaState *env, bool dtlb)
 {
     unsigned wi, ei;
diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
index f8d60101e3..46010c35c4 100644
--- a/target/xtensa/meson.build
+++ b/target/xtensa/meson.build
@@ -18,6 +18,7 @@ xtensa_ss.add(files(
 xtensa_system_ss = ss.source_set()
 xtensa_system_ss.add(files(
   'dbg_helper.c',
+  'mmu.c',
   'mmu_helper.c',
   'monitor.c',
   'xtensa-semi.c',
-- 
2.41.0


