Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B896EC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekl-0007GF-GK; Thu, 27 Feb 2025 09:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekb-0007Ej-Ka
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekZ-0003lz-43
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzevOw2v7eV63sKXI0ynTRS0gFenKTHy7ijiSe2WtG8=;
 b=Rd1Vaf067brtPWNmwnUkppQEQpPWF/XwqUNtFhQqAnZsOJvhGcMXsqFaa3ZSgQhth+i1VR
 bYp1mABHfwuMVwVIXmVcCm9TwPfZGhdxvq2i6H+3W1GqEtlt16ShEuEzbkacmwUVT+ySBP
 zPSpqqh3Q1YAMtRf+JYW4aDUnpGPuDc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-uccrlwbJOJ6LSCjSRvNpVQ-1; Thu, 27 Feb 2025 09:20:28 -0500
X-MC-Unique: uccrlwbJOJ6LSCjSRvNpVQ-1
X-Mimecast-MFC-AGG-ID: uccrlwbJOJ6LSCjSRvNpVQ_1740666027
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abbc0572fc9so133284766b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666025; x=1741270825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzevOw2v7eV63sKXI0ynTRS0gFenKTHy7ijiSe2WtG8=;
 b=oZSagxcD3UGwns5tcHlJPEPxOiSLTCLH2ffy+z9imdTmn4aDHOu74yr8QJRXNexyvt
 H8t1f/bL1CsBywpc0ywUkNFU8aF0W14IzZHFyXuS6U6X2V8N9sRgHctrHWsgwXP1Un1r
 PGY1gGdx4lPzwrUhWN7a23ntEFVoZ+sp5cxl+ww+xGTGKuH5cSNzqagVVu13yceGBX6H
 TVf4tOhibsJSVmzV3EtbRAIJtlf/3ViuBDVKp43v3f9JYfN0L8OREicRT7iYY4JFhWbs
 z/AhpK99twpaigtj+m6vjeT4L2Z++TQMq5TLvejaUFzTKWX3gVqROD1Ergq/MbqWp28w
 XMSw==
X-Gm-Message-State: AOJu0YzIhsUb6BjoOHAgGOcRDtV011NyZdlnvMVRaVnylfJeYe7XyMN8
 e0LusJUzCofvR190Jf8T7WvlzAdIkUwynedZnGp9iKEXNIVTfmPnwKpgf41Fe2G8RQqGteEaf45
 1z0ysefTBmo0D7dNU6kP9xPwMKNMZDfhENpLLLCHQNOv1zlW9DlbYkixQ5a5LfJPnqT4SDoBJ15
 6kn4XeCjyzGNoNXdKJMx49D9JcZYR1zF7EUnSCnyc=
X-Gm-Gg: ASbGncseswNcb2cRIzKaE7Jn5NhQlckWMHtff21CLm+llxSBvygH/qsxgXgULkay9p8
 OmqXyGCUKU3M5TDwzO2MRLch9ehGNmyHRqijYQsntiAOUTbCeSaphmLiQfzN6EFXOftWwX3V6HO
 vEEy5KXHDXjZrj/B1AslViprSHz6elJSAh9amvCSBiYX2tmC9WyM4/vPHZaZh35qtL+HnVi7hH0
 dcFZtOHmWQiGOMUPQ+3STnfcVOzIBPRl4TXuiVYZ/cAHZAp6ls4/uVYmcqUtAks4p5i/OWUnWM7
 vw6xin3MK/VPFc76Qm4L
X-Received: by 2002:a17:907:7704:b0:ab7:ef38:1277 with SMTP id
 a640c23a62f3a-abc09a74646mr2372138266b.26.1740666025173; 
 Thu, 27 Feb 2025 06:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQMrpA+80/oIoceAbfVOiXOR2QDCzYmfvXCr/nYuVn95AM2fdhPGzTIoMHxUbswgTP5t2+CQ==
X-Received: by 2002:a17:907:7704:b0:ab7:ef38:1277 with SMTP id
 a640c23a62f3a-abc09a74646mr2372133166b.26.1740666024311; 
 Thu, 27 Feb 2025 06:20:24 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c74fba2sm128900366b.131.2025.02.27.06.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/34] target/i386/hvf: fix a typo in a type name
Date: Thu, 27 Feb 2025 15:19:32 +0100
Message-ID: <20250227141952.811410-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Liu <liuwe@linux.microsoft.com>

The prefix x68 is wrong. Change it to x86.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/1740126987-8483-2-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.h       |  8 ++++----
 target/i386/hvf/x86_descr.h |  6 +++---
 target/i386/hvf/x86_task.h  |  2 +-
 target/i386/hvf/hvf.c       |  2 +-
 target/i386/hvf/x86.c       |  4 ++--
 target/i386/hvf/x86_descr.c |  8 ++++----
 target/i386/hvf/x86_task.c  | 22 +++++++++++-----------
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 3570f29aa9d..063cd0b83ec 100644
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
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 9f06014b56a..ce5de983497 100644
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
 
diff --git a/target/i386/hvf/x86_task.h b/target/i386/hvf/x86_task.h
index 4eaa61a7dee..b9afac6a47b 100644
--- a/target/i386/hvf/x86_task.h
+++ b/target/i386/hvf/x86_task.h
@@ -15,6 +15,6 @@
 #ifndef HVF_X86_TASK_H
 #define HVF_X86_TASK_H
 
-void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel,
+void vmx_handle_task_switch(CPUState *cpu, x86_segment_selector tss_sel,
         int reason, bool gate_valid, uint8_t gate, uint64_t gate_type);
 #endif
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ca08f0753f0..353549fa779 100644
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
index 80e36136d04..a0ede138865 100644
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
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index f33836d6cba..7b599c90377 100644
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
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index bcd844cff60..287fe11cf70 100644
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
-- 
2.48.1


