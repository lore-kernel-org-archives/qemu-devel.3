Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CF8C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7V98-0000C9-3J; Fri, 18 Sep 2026 05:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1x7V96-0000Bt-IC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:44:40 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1x7V8z-0004TQ-GS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789724642; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=WK9FLpL3ptUqDCmb5UMMVEvr5GDD1rJ5h2gx8o1iKGI=;
 b=gZruI023vfEMuqXcm8412Uz3G3JxAx7F4McwRCHDCyiEF4bQu9C63IBv2DpxwbXtCXioZWeni3nAyFTxg1NoVnKFAWghVerqx4QshXVDqY06IBdb6UkRGzQeNSFv7WLVYWahzYkVcLo0aPEIPvUlb6A0y3teshCxFsrrbTeKe90=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0XBAwgF7_1789724635; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0XBAwgF7_1789724635 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 18 Sep 2026 17:44:01 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 zhengrong_li@linux.alibaba.com
Subject: [PATCH v2] target/i386: show nested VMX peer state in info registers
Date: Fri, 18 Sep 2026 16:51:16 +0800
Message-ID: <178972459476.60317.5936346209022583956@linux.alibaba.com>
In-Reply-To: <178672181798.77890.17896034190526266014@linux.alibaba.com>
References: <178672181798.77890.17896034190526266014@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When a vCPU is running an L2 guest, "info registers" shows only
L2's current state and not the L1 state that will be restored on a
VM-exit. Likewise, while L1 is current, it does not show the L2
guest state configured in vmcs12.

The vmcs12 blob returned by KVM_GET_NESTED_STATE contains both the
guest-state area configured for L2 and the host-state area restored
for L1. Parse the relevant fields from the migration-stable vmcs12
layout and append the other level's state to the existing register
dump.

Use KVM_STATE_NESTED_GUEST_MODE to identify the current level, and
guard the parser with the VMCS12 revision. This is limited to VMX;
SVM nested state is left unchanged.

Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
---

Changes in v2:
- Use KVM_STATE_NESTED_GUEST_MODE instead of HF_GUEST_MASK to select
  the current level.
- Label the existing register dump as current state and VMCS12 values
  as additional state for the other level.
- Test both L1-current and L2-current paths with a nested Windows guest.

v1: https://lore.kernel.org/qemu-devel/178672181798.77890.17896034190526266014@linux.alibaba.com/

 target/i386/cpu-dump.c | 255 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 255 insertions(+)

diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 9e290c0..178d1dc 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -23,6 +23,9 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/i386/apic_internal.h"
 #endif
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
 
 /***********************************************************/
 /* x86 debug */
@@ -343,6 +346,253 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
 #define DUMP_CODE_BYTES_TOTAL    50
 #define DUMP_CODE_BYTES_BACKWARD 20
 
+#ifdef CONFIG_KVM
+/*
+ * Byte offsets into the vmcs12 blob returned by KVM_GET_NESTED_STATE.
+ * Taken from struct vmcs12 in arch/x86/kvm/vmx/vmcs12.h (kernel v6.16).
+ * The layout is locked by live-migration compatibility and compile-time
+ * CHECK_OFFSET assertions in the kernel, so existing offsets are stable.
+ * Only new fields may be appended at the end; existing fields cannot be
+ * moved, deleted, or have their type changed.
+ */
+#define VMCS12_REVISION                  0x11e57ed0
+#define VMCS12_GUEST_IA32_PAT            192
+#define VMCS12_GUEST_IA32_EFER           200
+#define VMCS12_HOST_IA32_PAT             256
+#define VMCS12_HOST_IA32_EFER            264
+#define VMCS12_GUEST_CR0                 424
+#define VMCS12_GUEST_CR3                 432
+#define VMCS12_GUEST_CR4                 440
+#define VMCS12_GUEST_ES_BASE             448
+#define VMCS12_GUEST_CS_BASE             456
+#define VMCS12_GUEST_SS_BASE             464
+#define VMCS12_GUEST_DS_BASE             472
+#define VMCS12_GUEST_FS_BASE             480
+#define VMCS12_GUEST_GS_BASE             488
+#define VMCS12_GUEST_LDTR_BASE           496
+#define VMCS12_GUEST_TR_BASE             504
+#define VMCS12_GUEST_GDTR_BASE           512
+#define VMCS12_GUEST_IDTR_BASE           520
+#define VMCS12_GUEST_DR7                 528
+#define VMCS12_GUEST_RSP                 536
+#define VMCS12_GUEST_RIP                 544
+#define VMCS12_GUEST_RFLAGS              552
+#define VMCS12_GUEST_SYSENTER_ESP        568
+#define VMCS12_GUEST_SYSENTER_EIP        576
+#define VMCS12_HOST_CR0                  584
+#define VMCS12_HOST_CR3                  592
+#define VMCS12_HOST_CR4                  600
+#define VMCS12_HOST_FS_BASE              608
+#define VMCS12_HOST_GS_BASE              616
+#define VMCS12_HOST_TR_BASE              624
+#define VMCS12_HOST_GDTR_BASE            632
+#define VMCS12_HOST_IDTR_BASE            640
+#define VMCS12_HOST_IA32_SYSENTER_ESP    648
+#define VMCS12_HOST_IA32_SYSENTER_EIP    656
+#define VMCS12_HOST_RSP                  664
+#define VMCS12_HOST_RIP                  672
+#define VMCS12_GUEST_ES_LIMIT            840
+#define VMCS12_GUEST_CS_LIMIT            844
+#define VMCS12_GUEST_SS_LIMIT            848
+#define VMCS12_GUEST_DS_LIMIT            852
+#define VMCS12_GUEST_FS_LIMIT            856
+#define VMCS12_GUEST_GS_LIMIT            860
+#define VMCS12_GUEST_LDTR_LIMIT          864
+#define VMCS12_GUEST_TR_LIMIT            868
+#define VMCS12_GUEST_GDTR_LIMIT          872
+#define VMCS12_GUEST_IDTR_LIMIT          876
+#define VMCS12_GUEST_ES_AR_BYTES         880
+#define VMCS12_GUEST_CS_AR_BYTES         884
+#define VMCS12_GUEST_SS_AR_BYTES         888
+#define VMCS12_GUEST_DS_AR_BYTES         892
+#define VMCS12_GUEST_FS_AR_BYTES         896
+#define VMCS12_GUEST_GS_AR_BYTES         900
+#define VMCS12_GUEST_LDTR_AR_BYTES       904
+#define VMCS12_GUEST_TR_AR_BYTES         908
+#define VMCS12_GUEST_SYSENTER_CS         920
+#define VMCS12_HOST_IA32_SYSENTER_CS     924
+#define VMCS12_GUEST_ES_SELECTOR         964
+#define VMCS12_GUEST_CS_SELECTOR         966
+#define VMCS12_GUEST_SS_SELECTOR         968
+#define VMCS12_GUEST_DS_SELECTOR         970
+#define VMCS12_GUEST_FS_SELECTOR         972
+#define VMCS12_GUEST_GS_SELECTOR         974
+#define VMCS12_GUEST_LDTR_SELECTOR       976
+#define VMCS12_GUEST_TR_SELECTOR         978
+#define VMCS12_HOST_ES_SELECTOR          982
+#define VMCS12_HOST_CS_SELECTOR          984
+#define VMCS12_HOST_SS_SELECTOR          986
+#define VMCS12_HOST_DS_SELECTOR          988
+#define VMCS12_HOST_FS_SELECTOR          990
+#define VMCS12_HOST_GS_SELECTOR          992
+#define VMCS12_HOST_TR_SELECTOR          994
+
+static inline uint64_t vmcs12_read64(const uint8_t *vmcs12, size_t off)
+{
+    uint64_t val;
+    memcpy(&val, vmcs12 + off, sizeof(val));
+    return val;
+}
+
+static inline uint32_t vmcs12_read32(const uint8_t *vmcs12, size_t off)
+{
+    uint32_t val;
+    memcpy(&val, vmcs12 + off, sizeof(val));
+    return val;
+}
+
+static inline uint16_t vmcs12_read16(const uint8_t *vmcs12, size_t off)
+{
+    uint16_t val;
+    memcpy(&val, vmcs12 + off, sizeof(val));
+    return val;
+}
+
+static void dump_vmcs12_nested_state(CPUX86State *env, FILE *f,
+                                     const char *seg_name[6])
+{
+    const uint8_t *vmcs12;
+    uint64_t base[8];
+    uint32_t limit[8], ar[8];
+    uint16_t sel[8];
+    int i;
+
+    if (!env->nested_state ||
+        env->nested_state->format != KVM_STATE_NESTED_FORMAT_VMX) {
+        return;
+    }
+
+    vmcs12 = env->nested_state->data.vmx[0].vmcs12;
+
+    /* Sanity check: vmcs12 revision must match expected layout */
+    if (vmcs12_read32(vmcs12, 0) != VMCS12_REVISION) {
+        return;
+    }
+
+    qemu_fprintf(f, "\nNested VMX context:\n");
+    if (env->nested_state->flags & KVM_STATE_NESTED_GUEST_MODE) {
+        /*
+         * The registers above are L2's current state. Show the
+         * additional L1 state that VM-exit will restore.
+         */
+        qemu_fprintf(f, "Current state: L2 (registers above)\n");
+        qemu_fprintf(f, "Additional L1 state (VMCS12 host-state area):\n");
+        qemu_fprintf(f, "RIP=%016" PRIx64 " RSP=%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_RIP),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_RSP));
+        qemu_fprintf(f, "CR0=%016" PRIx64 " CR3=%016" PRIx64
+                     " CR4=%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_CR0),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_CR3),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_CR4));
+        qemu_fprintf(f, "EFER=%016" PRIx64 " PAT=%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_EFER),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_PAT));
+
+        sel[0] = vmcs12_read16(vmcs12, VMCS12_HOST_ES_SELECTOR);
+        sel[1] = vmcs12_read16(vmcs12, VMCS12_HOST_CS_SELECTOR);
+        sel[2] = vmcs12_read16(vmcs12, VMCS12_HOST_SS_SELECTOR);
+        sel[3] = vmcs12_read16(vmcs12, VMCS12_HOST_DS_SELECTOR);
+        sel[4] = vmcs12_read16(vmcs12, VMCS12_HOST_FS_SELECTOR);
+        sel[5] = vmcs12_read16(vmcs12, VMCS12_HOST_GS_SELECTOR);
+        for (i = 0; i < 6; i++) {
+            qemu_fprintf(f, "%-4s sel=%04x\n", seg_name[i], sel[i]);
+        }
+        qemu_fprintf(f, "TR   sel=%04x base=%016" PRIx64 "\n",
+                     vmcs12_read16(vmcs12, VMCS12_HOST_TR_SELECTOR),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_TR_BASE));
+        qemu_fprintf(f, "FS base=%016" PRIx64 " GS base=%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_FS_BASE),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_GS_BASE));
+        qemu_fprintf(f, "GDT=     %016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_GDTR_BASE));
+        qemu_fprintf(f, "IDT=     %016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IDTR_BASE));
+        qemu_fprintf(f, "SYSENTER cs=%08x esp=%016" PRIx64
+                     " eip=%016" PRIx64 "\n",
+                     vmcs12_read32(vmcs12, VMCS12_HOST_IA32_SYSENTER_CS),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_SYSENTER_ESP),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_SYSENTER_EIP));
+    } else {
+        /*
+         * The registers above are L1's current state. Show the
+         * additional L2 state configured in the guest-state area.
+         */
+        qemu_fprintf(f, "Current state: L1 (registers above)\n");
+        qemu_fprintf(f, "Additional L2 state (VMCS12 guest-state area):\n");
+        qemu_fprintf(f, "RIP=%016" PRIx64 " RSP=%016" PRIx64
+                     " RFL=%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_RIP),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_RSP),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_RFLAGS));
+        qemu_fprintf(f, "CR0=%016" PRIx64 " CR3=%016" PRIx64
+                     " CR4=%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_CR0),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_CR3),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_CR4));
+        qemu_fprintf(f, "DR7=%016" PRIx64 " EFER=%016" PRIx64
+                     " PAT=%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_DR7),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_IA32_EFER),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_IA32_PAT));
+
+        sel[0] = vmcs12_read16(vmcs12, VMCS12_GUEST_ES_SELECTOR);
+        sel[1] = vmcs12_read16(vmcs12, VMCS12_GUEST_CS_SELECTOR);
+        sel[2] = vmcs12_read16(vmcs12, VMCS12_GUEST_SS_SELECTOR);
+        sel[3] = vmcs12_read16(vmcs12, VMCS12_GUEST_DS_SELECTOR);
+        sel[4] = vmcs12_read16(vmcs12, VMCS12_GUEST_FS_SELECTOR);
+        sel[5] = vmcs12_read16(vmcs12, VMCS12_GUEST_GS_SELECTOR);
+        base[0] = vmcs12_read64(vmcs12, VMCS12_GUEST_ES_BASE);
+        base[1] = vmcs12_read64(vmcs12, VMCS12_GUEST_CS_BASE);
+        base[2] = vmcs12_read64(vmcs12, VMCS12_GUEST_SS_BASE);
+        base[3] = vmcs12_read64(vmcs12, VMCS12_GUEST_DS_BASE);
+        base[4] = vmcs12_read64(vmcs12, VMCS12_GUEST_FS_BASE);
+        base[5] = vmcs12_read64(vmcs12, VMCS12_GUEST_GS_BASE);
+        limit[0] = vmcs12_read32(vmcs12, VMCS12_GUEST_ES_LIMIT);
+        limit[1] = vmcs12_read32(vmcs12, VMCS12_GUEST_CS_LIMIT);
+        limit[2] = vmcs12_read32(vmcs12, VMCS12_GUEST_SS_LIMIT);
+        limit[3] = vmcs12_read32(vmcs12, VMCS12_GUEST_DS_LIMIT);
+        limit[4] = vmcs12_read32(vmcs12, VMCS12_GUEST_FS_LIMIT);
+        limit[5] = vmcs12_read32(vmcs12, VMCS12_GUEST_GS_LIMIT);
+        ar[0] = vmcs12_read32(vmcs12, VMCS12_GUEST_ES_AR_BYTES);
+        ar[1] = vmcs12_read32(vmcs12, VMCS12_GUEST_CS_AR_BYTES);
+        ar[2] = vmcs12_read32(vmcs12, VMCS12_GUEST_SS_AR_BYTES);
+        ar[3] = vmcs12_read32(vmcs12, VMCS12_GUEST_DS_AR_BYTES);
+        ar[4] = vmcs12_read32(vmcs12, VMCS12_GUEST_FS_AR_BYTES);
+        ar[5] = vmcs12_read32(vmcs12, VMCS12_GUEST_GS_AR_BYTES);
+        for (i = 0; i < 6; i++) {
+            qemu_fprintf(f, "%-4s sel=%04x base=%016" PRIx64
+                         " limit=%08x ar=%08x\n",
+                         seg_name[i], sel[i], base[i], limit[i], ar[i]);
+        }
+        qemu_fprintf(f, "LDT  sel=%04x base=%016" PRIx64
+                     " limit=%08x ar=%08x\n",
+                     vmcs12_read16(vmcs12, VMCS12_GUEST_LDTR_SELECTOR),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_LDTR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_LDTR_LIMIT),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_LDTR_AR_BYTES));
+        qemu_fprintf(f, "TR   sel=%04x base=%016" PRIx64
+                     " limit=%08x ar=%08x\n",
+                     vmcs12_read16(vmcs12, VMCS12_GUEST_TR_SELECTOR),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_TR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_TR_LIMIT),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_TR_AR_BYTES));
+
+        qemu_fprintf(f, "GDT=     %016" PRIx64 " %08x\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_GDTR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_GDTR_LIMIT));
+        qemu_fprintf(f, "IDT=     %016" PRIx64 " %08x\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_IDTR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_IDTR_LIMIT));
+        qemu_fprintf(f, "SYSENTER cs=%08x esp=%016" PRIx64
+                     " eip=%016" PRIx64 "\n",
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_SYSENTER_CS),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_SYSENTER_ESP),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_SYSENTER_EIP));
+    }
+}
+#endif /* CONFIG_KVM */
+
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -595,4 +845,9 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
         qemu_fprintf(f, "\n");
     }
+
+#ifdef CONFIG_KVM
+    /* Show nested peer state from vmcs12 when applicable */
+    dump_vmcs12_nested_state(env, f, seg_name);
+#endif
 }
-- 
2.43.7


