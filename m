Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F70C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbU-0000CP-7N; Fri, 21 Feb 2025 09:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWf-0006Q2-P5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:50 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWc-000154-V2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:49 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 48018204E5B4; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48018204E5B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=np/5k2yKZv1pm+cgwBhYE6E+yOA272uLrRXCUF7sHr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ouPvQ8lmeAFKwLtE7XcjMpsPjKhTP5LyaDnM3fWH3XPpMbQjUQZrRAFEbQ6HDPsFD
 38lUlRFgmN9hFTlqemuEVqFr84o2Joy4/oTc7Ss3sGR7981CKhHTQsoVjRRs1nhACy
 Hk9/u7XbCdEtAIDsYakwLa7PZ9moO0brSCqLsFyc=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 01/19] target/i386/hvf: fix a typo in a type name
Date: Fri, 21 Feb 2025 00:36:09 -0800
Message-Id: <1740126987-8483-2-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:05 -0500
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

The prefix x68 is wrong. Change it to x86.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf.c       |  2 +-
 target/i386/hvf/x86.c       |  4 ++--
 target/i386/hvf/x86.h       |  8 ++++----
 target/i386/hvf/x86_descr.c |  8 ++++----
 target/i386/hvf/x86_descr.h |  6 +++---
 target/i386/hvf/x86_task.c  | 22 +++++++++++-----------
 target/i386/hvf/x86_task.h  |  2 +-
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ca08f0753f..353549fa77 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -674,7 +674,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         }
         case EXIT_REASON_TASK_SWITCH: {
             uint64_t vinfo = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
-            x68_segment_selector sel = {.sel = exit_qual & 0xffff};
+            x86_segment_selector sel = {.sel = exit_qual & 0xffff};
             vmx_handle_task_switch(cpu, sel, (exit_qual >> 30) & 0x3,
              vinfo & VMCS_INTR_VALID, vinfo & VECTORING_INFO_VECTOR_MASK, vinfo
              & VMCS_INTR_T_MASK);
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 80e36136d0..a0ede13886 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -48,7 +48,7 @@
 
 bool x86_read_segment_descriptor(CPUState *cpu,
                                  struct x86_segment_descriptor *desc,
-                                 x68_segment_selector sel)
+                                 x86_segment_selector sel)
 {
     target_ulong base;
     uint32_t limit;
@@ -78,7 +78,7 @@ bool x86_read_segment_descriptor(CPUState *cpu,
 
 bool x86_write_segment_descriptor(CPUState *cpu,
                                   struct x86_segment_descriptor *desc,
-                                  x68_segment_selector sel)
+                                  x86_segment_selector sel)
 {
     target_ulong base;
     uint32_t limit;
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 3570f29aa9..063cd0b83e 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -183,7 +183,7 @@ static inline uint32_t x86_call_gate_offset(x86_call_gate *gate)
 #define GDT_SEL     0
 #define LDT_SEL     1
 
-typedef struct x68_segment_selector {
+typedef struct x86_segment_selector {
     union {
         uint16_t sel;
         struct {
@@ -192,7 +192,7 @@ typedef struct x68_segment_selector {
             uint16_t index:13;
         };
     };
-} __attribute__ ((__packed__)) x68_segment_selector;
+} __attribute__ ((__packed__)) x86_segment_selector;
 
 /* useful register access  macros */
 #define x86_reg(cpu, reg) ((x86_register *) &cpu->regs[reg])
@@ -250,10 +250,10 @@ typedef struct x68_segment_selector {
 /* deal with GDT/LDT descriptors in memory */
 bool x86_read_segment_descriptor(CPUState *cpu,
                                  struct x86_segment_descriptor *desc,
-                                 x68_segment_selector sel);
+                                 x86_segment_selector sel);
 bool x86_write_segment_descriptor(CPUState *cpu,
                                   struct x86_segment_descriptor *desc,
-                                  x68_segment_selector sel);
+                                  x86_segment_selector sel);
 
 bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
                         int gate);
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index f33836d6cb..7b599c9037 100644
--- a/target/i386/hvf/x86_descr.c
+++ b/target/i386/hvf/x86_descr.c
@@ -60,14 +60,14 @@ uint64_t vmx_read_segment_base(CPUState *cpu, X86Seg seg)
     return rvmcs(cpu->accel->fd, vmx_segment_fields[seg].base);
 }
 
-x68_segment_selector vmx_read_segment_selector(CPUState *cpu, X86Seg seg)
+x86_segment_selector vmx_read_segment_selector(CPUState *cpu, X86Seg seg)
 {
-    x68_segment_selector sel;
+    x86_segment_selector sel;
     sel.sel = rvmcs(cpu->accel->fd, vmx_segment_fields[seg].selector);
     return sel;
 }
 
-void vmx_write_segment_selector(CPUState *cpu, x68_segment_selector selector, X86Seg seg)
+void vmx_write_segment_selector(CPUState *cpu, x86_segment_selector selector, X86Seg seg)
 {
     wvmcs(cpu->accel->fd, vmx_segment_fields[seg].selector, selector.sel);
 }
@@ -90,7 +90,7 @@ void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc, X86Se
     wvmcs(cpu->accel->fd, sf->ar_bytes, desc->ar);
 }
 
-void x86_segment_descriptor_to_vmx(CPUState *cpu, x68_segment_selector selector,
+void x86_segment_descriptor_to_vmx(CPUState *cpu, x86_segment_selector selector,
                                    struct x86_segment_descriptor *desc,
                                    struct vmx_segment *vmx_desc)
 {
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 9f06014b56..ce5de98349 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -34,10 +34,10 @@ void vmx_read_segment_descriptor(CPUState *cpu,
 void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc,
                                   enum X86Seg seg);
 
-x68_segment_selector vmx_read_segment_selector(CPUState *cpu,
+x86_segment_selector vmx_read_segment_selector(CPUState *cpu,
                                                enum X86Seg seg);
 void vmx_write_segment_selector(CPUState *cpu,
-                                x68_segment_selector selector,
+                                x86_segment_selector selector,
                                 enum X86Seg seg);
 
 uint64_t vmx_read_segment_base(CPUState *cpu, enum X86Seg seg);
@@ -45,7 +45,7 @@ void vmx_write_segment_base(CPUState *cpu, enum X86Seg seg,
                             uint64_t base);
 
 void x86_segment_descriptor_to_vmx(CPUState *cpu,
-                                   x68_segment_selector selector,
+                                   x86_segment_selector selector,
                                    struct x86_segment_descriptor *desc,
                                    struct vmx_segment *vmx_desc);
 
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index bcd844cff6..287fe11cf7 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -76,16 +76,16 @@ static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
     RSI(env) = tss->esi;
     RDI(env) = tss->edi;
 
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ldt}}, R_LDTR);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->es}}, R_ES);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->cs}}, R_CS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ss}}, R_SS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ds}}, R_DS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->fs}}, R_FS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->gs}}, R_GS);
+    vmx_write_segment_selector(cpu, (x86_segment_selector){{tss->ldt}}, R_LDTR);
+    vmx_write_segment_selector(cpu, (x86_segment_selector){{tss->es}}, R_ES);
+    vmx_write_segment_selector(cpu, (x86_segment_selector){{tss->cs}}, R_CS);
+    vmx_write_segment_selector(cpu, (x86_segment_selector){{tss->ss}}, R_SS);
+    vmx_write_segment_selector(cpu, (x86_segment_selector){{tss->ds}}, R_DS);
+    vmx_write_segment_selector(cpu, (x86_segment_selector){{tss->fs}}, R_FS);
+    vmx_write_segment_selector(cpu, (x86_segment_selector){{tss->gs}}, R_GS);
 }
 
-static int task_switch_32(CPUState *cpu, x68_segment_selector tss_sel, x68_segment_selector old_tss_sel,
+static int task_switch_32(CPUState *cpu, x86_segment_selector tss_sel, x86_segment_selector old_tss_sel,
                           uint64_t old_tss_base, struct x86_segment_descriptor *new_desc)
 {
     struct x86_tss_segment32 tss_seg;
@@ -108,7 +108,7 @@ static int task_switch_32(CPUState *cpu, x68_segment_selector tss_sel, x68_segme
     return 0;
 }
 
-void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int reason, bool gate_valid, uint8_t gate, uint64_t gate_type)
+void vmx_handle_task_switch(CPUState *cpu, x86_segment_selector tss_sel, int reason, bool gate_valid, uint8_t gate, uint64_t gate_type)
 {
     uint64_t rip = rreg(cpu->accel->fd, HV_X86_RIP);
     if (!gate_valid || (gate_type != VMCS_INTR_T_HWEXCEPTION &&
@@ -122,7 +122,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
     load_regs(cpu);
 
     struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
-    x68_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
+    x86_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
     uint64_t old_tss_base = vmx_read_segment_base(cpu, R_TR);
     uint32_t desc_limit;
     struct x86_call_gate task_gate_desc;
@@ -140,7 +140,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
         x86_read_call_gate(cpu, &task_gate_desc, gate);
 
         dpl = task_gate_desc.dpl;
-        x68_segment_selector cs = vmx_read_segment_selector(cpu, R_CS);
+        x86_segment_selector cs = vmx_read_segment_selector(cpu, R_CS);
         if (tss_sel.rpl > dpl || cs.rpl > dpl)
             ;//DPRINTF("emulate_gp");
     }
diff --git a/target/i386/hvf/x86_task.h b/target/i386/hvf/x86_task.h
index 4eaa61a7de..b9afac6a47 100644
--- a/target/i386/hvf/x86_task.h
+++ b/target/i386/hvf/x86_task.h
@@ -15,6 +15,6 @@
 #ifndef HVF_X86_TASK_H
 #define HVF_X86_TASK_H
 
-void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel,
+void vmx_handle_task_switch(CPUState *cpu, x86_segment_selector tss_sel,
         int reason, bool gate_valid, uint8_t gate, uint64_t gate_type);
 #endif
-- 
2.39.5 (Apple Git-154)


