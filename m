Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA2EC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelE-00085E-EX; Thu, 27 Feb 2025 09:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tneko-0007Nm-AJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekk-0003ne-UB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kREDGuRWTSnetD6IUegbVc8rafPOtZ5CPk3iVS4K+Rc=;
 b=X2O7nkuY0dRtzu9AyZGzW3siwUHgpLv+WO9n2lC0dSBw5MUFQmoK0PWP7Hq2cotWFbKbi2
 G6czk1M+Q0zWpiNm+RVVf+xCpG188/vpGgv4mFicGDdBIDZTYZY+Mrwq4YNL4CSHD/oOQd
 JlU73/FQzIEVJiMBKVGT1KrAG0/Tm+g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-bkBhKyI9PwuQw9XQT3k2gA-1; Thu, 27 Feb 2025 09:20:35 -0500
X-MC-Unique: bkBhKyI9PwuQw9XQT3k2gA-1
X-Mimecast-MFC-AGG-ID: bkBhKyI9PwuQw9XQT3k2gA_1740666034
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so151935566b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666033; x=1741270833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kREDGuRWTSnetD6IUegbVc8rafPOtZ5CPk3iVS4K+Rc=;
 b=pkuAE3D/DnctosFtRVAVVc5R8uBViDvAKVAqZinmaP504BGctPBD7cy7TDPXukwisV
 v9zv+du1zqZW1/+NoEX/r4T+gI+Wohu3obIONLje25vocdm/pyhY28HVMlxmwSrtJgCj
 paU5GfNnYPOkZzm9Gemj7MQchyTRRVxxxqPGjIt6xVefd7byMGuXQATTwLOKbu+Ra2v5
 F9fSmzmsrpu2ryfn8zeMJN9By/6VhtA10eF8BjCJ2pTjYrLlBT74l2tsQuSG131PassF
 9PhT6VlET667qyoaFp2xB3luRYZjLkUn8MSpLzefbJiu8hBD3h2Yga7errmDbORpFgZB
 lUig==
X-Gm-Message-State: AOJu0YyHcRxhJWhi378YF061A8Y6BP0JdCRwqFoiuvYdhqS20byacHdq
 aeOle8/Yv3ffRb+oOqSanrWDx2fNPgS8HmmN/+KfuxSfhUHRx3/aILdmS2fOpSmXCOD9xRmZlLQ
 E6LH1whzieP2oOOR+3VnJN9K8ZjEIruds3wygOX7Yj4+ADu+huUzROd+CYzKDsNU3yx63lQr3HQ
 2lvZf2hP+gnF3Aws0nZkheYzuHJWAkyp5ZY3+gaAY=
X-Gm-Gg: ASbGncuub7qTyx3xZY8FmE7ysriMGWiXtbRMTCVbpnPMk9YzV4NmaydQH1FAj+Z9EzH
 wyqiD7+/9HEC4oA1wB4QcO3x5FhDK+1hrc8LuBjErC7xMUmmb6+F2j2RGrZNYfU8ROa6IbUFZtg
 FBIFEU1xwGqjfLB1yaBWEVWgjqrQfB+1gqzua3GpiMk5uEkkqJW8PHagymiku7LDz1OtGw8iGRe
 vfmSlEQuZxfVE4p7JLKT4mXl8iAwehtGMGnefsXK3CnBAqFneG/LXSrCWTjqSVVqa9Y82b53mY+
 srEkHKh8yR0RATkgxXlb
X-Received: by 2002:a17:907:2ce2:b0:ab7:d87:50f2 with SMTP id
 a640c23a62f3a-abed101dd89mr1442889066b.44.1740666032648; 
 Thu, 27 Feb 2025 06:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFagW/zcje0zwDc9ll7PjYs3gpck6Hbc6M8vl/UAXFWCH5dqmF+rFyZNglzK7/QJE2o66H03w==
X-Received: by 2002:a17:907:2ce2:b0:ab7:d87:50f2 with SMTP id
 a640c23a62f3a-abed101dd89mr1442883866b.44.1740666032034; 
 Thu, 27 Feb 2025 06:20:32 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0db671sm129939766b.72.2025.02.27.06.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 17/34] target/i386/hvf: move and rename {load, store}_regs
Date: Thu, 27 Feb 2025 15:19:35 +0100
Message-ID: <20250227141952.811410-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

They contain HVF specific code. Move them to a better location and
add "hvf_" prefix. Fix up all the call sites.

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1740126987-8483-7-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.h  |  3 --
 target/i386/hvf/x86hvf.h   |  3 ++
 target/i386/hvf/hvf.c      | 71 +++++++++++++++++++++++++++++++-------
 target/i386/hvf/x86_emu.c  | 46 ------------------------
 target/i386/hvf/x86_task.c |  4 +--
 5 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 8bd97608c42..cd953849c99 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -26,9 +26,6 @@
 void init_emu(void);
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
 
-void load_regs(CPUState *cpu);
-void store_regs(CPUState *cpu);
-
 void simulate_rdmsr(CPUX86State *env);
 void simulate_wrmsr(CPUX86State *env);
 
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 423a89b6ad3..8c46ce8ad02 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -31,4 +31,7 @@ void hvf_get_xsave(CPUState *cs);
 void hvf_get_msrs(CPUState *cs);
 void vmx_clear_int_window_exiting(CPUState *cs);
 void vmx_update_tpr(CPUState *cs);
+
+void hvf_load_regs(CPUState *cpu);
+void hvf_store_regs(CPUState *cpu);
 #endif
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 1ecb6993ba1..3ab3c0043db 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -61,6 +61,7 @@
 #include "vmx.h"
 #include "x86.h"
 #include "x86_descr.h"
+#include "x86_flags.h"
 #include "x86_mmu.h"
 #include "x86_decode.h"
 #include "x86_emu.h"
@@ -434,6 +435,52 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
+void hvf_load_regs(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    int i = 0;
+    RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
+    RRX(env, R_EBX) = rreg(cs->accel->fd, HV_X86_RBX);
+    RRX(env, R_ECX) = rreg(cs->accel->fd, HV_X86_RCX);
+    RRX(env, R_EDX) = rreg(cs->accel->fd, HV_X86_RDX);
+    RRX(env, R_ESI) = rreg(cs->accel->fd, HV_X86_RSI);
+    RRX(env, R_EDI) = rreg(cs->accel->fd, HV_X86_RDI);
+    RRX(env, R_ESP) = rreg(cs->accel->fd, HV_X86_RSP);
+    RRX(env, R_EBP) = rreg(cs->accel->fd, HV_X86_RBP);
+    for (i = 8; i < 16; i++) {
+        RRX(env, i) = rreg(cs->accel->fd, HV_X86_RAX + i);
+    }
+
+    env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
+    rflags_to_lflags(env);
+    env->eip = rreg(cs->accel->fd, HV_X86_RIP);
+}
+
+void hvf_store_regs(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    int i = 0;
+    wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
+    wreg(cs->accel->fd, HV_X86_RBX, RBX(env));
+    wreg(cs->accel->fd, HV_X86_RCX, RCX(env));
+    wreg(cs->accel->fd, HV_X86_RDX, RDX(env));
+    wreg(cs->accel->fd, HV_X86_RSI, RSI(env));
+    wreg(cs->accel->fd, HV_X86_RDI, RDI(env));
+    wreg(cs->accel->fd, HV_X86_RBP, RBP(env));
+    wreg(cs->accel->fd, HV_X86_RSP, RSP(env));
+    for (i = 8; i < 16; i++) {
+        wreg(cs->accel->fd, HV_X86_RAX + i, RRX(env, i));
+    }
+
+    lflags_to_rflags(env);
+    wreg(cs->accel->fd, HV_X86_RFLAGS, env->eflags);
+    macvm_set_rip(cs, env->eip);
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -517,10 +564,10 @@ int hvf_vcpu_exec(CPUState *cpu)
             if (ept_emulation_fault(slot, gpa, exit_qual)) {
                 struct x86_decode decode;
 
-                load_regs(cpu);
+                hvf_load_regs(cpu);
                 decode_instruction(env, &decode);
                 exec_instruction(env, &decode);
-                store_regs(cpu);
+                hvf_store_regs(cpu);
                 break;
             }
             break;
@@ -535,7 +582,7 @@ int hvf_vcpu_exec(CPUState *cpu)
 
             if (!string && in) {
                 uint64_t val = 0;
-                load_regs(cpu);
+                hvf_load_regs(cpu);
                 hvf_handle_io(env_cpu(env), port, &val, 0, size, 1);
                 if (size == 1) {
                     AL(env) = val;
@@ -547,7 +594,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                     RAX(env) = (uint64_t)val;
                 }
                 env->eip += ins_len;
-                store_regs(cpu);
+                hvf_store_regs(cpu);
                 break;
             } else if (!string && !in) {
                 RAX(env) = rreg(cpu->accel->fd, HV_X86_RAX);
@@ -557,11 +604,11 @@ int hvf_vcpu_exec(CPUState *cpu)
             }
             struct x86_decode decode;
 
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             decode_instruction(env, &decode);
             assert(ins_len == decode.len);
             exec_instruction(env, &decode);
-            store_regs(cpu);
+            hvf_store_regs(cpu);
 
             break;
         }
@@ -614,21 +661,21 @@ int hvf_vcpu_exec(CPUState *cpu)
         case EXIT_REASON_RDMSR:
         case EXIT_REASON_WRMSR:
         {
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
                 simulate_rdmsr(env);
             } else {
                 simulate_wrmsr(env);
             }
             env->eip += ins_len;
-            store_regs(cpu);
+            hvf_store_regs(cpu);
             break;
         }
         case EXIT_REASON_CR_ACCESS: {
             int cr;
             int reg;
 
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             cr = exit_qual & 15;
             reg = (exit_qual >> 8) & 15;
 
@@ -656,16 +703,16 @@ int hvf_vcpu_exec(CPUState *cpu)
                 abort();
             }
             env->eip += ins_len;
-            store_regs(cpu);
+            hvf_store_regs(cpu);
             break;
         }
         case EXIT_REASON_APIC_ACCESS: { /* TODO */
             struct x86_decode decode;
 
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
-            store_regs(cpu);
+            hvf_store_regs(cpu);
             break;
         }
         case EXIT_REASON_TPR: {
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 2c7da10c1d2..8b0d54d69a0 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -1452,52 +1452,6 @@ static void init_cmd_handler(void)
     }
 }
 
-void load_regs(CPUState *cs)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    int i = 0;
-    RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
-    RRX(env, R_EBX) = rreg(cs->accel->fd, HV_X86_RBX);
-    RRX(env, R_ECX) = rreg(cs->accel->fd, HV_X86_RCX);
-    RRX(env, R_EDX) = rreg(cs->accel->fd, HV_X86_RDX);
-    RRX(env, R_ESI) = rreg(cs->accel->fd, HV_X86_RSI);
-    RRX(env, R_EDI) = rreg(cs->accel->fd, HV_X86_RDI);
-    RRX(env, R_ESP) = rreg(cs->accel->fd, HV_X86_RSP);
-    RRX(env, R_EBP) = rreg(cs->accel->fd, HV_X86_RBP);
-    for (i = 8; i < 16; i++) {
-        RRX(env, i) = rreg(cs->accel->fd, HV_X86_RAX + i);
-    }
-
-    env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
-    rflags_to_lflags(env);
-    env->eip = rreg(cs->accel->fd, HV_X86_RIP);
-}
-
-void store_regs(CPUState *cs)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    int i = 0;
-    wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
-    wreg(cs->accel->fd, HV_X86_RBX, RBX(env));
-    wreg(cs->accel->fd, HV_X86_RCX, RCX(env));
-    wreg(cs->accel->fd, HV_X86_RDX, RDX(env));
-    wreg(cs->accel->fd, HV_X86_RSI, RSI(env));
-    wreg(cs->accel->fd, HV_X86_RDI, RDI(env));
-    wreg(cs->accel->fd, HV_X86_RBP, RBP(env));
-    wreg(cs->accel->fd, HV_X86_RSP, RSP(env));
-    for (i = 8; i < 16; i++) {
-        wreg(cs->accel->fd, HV_X86_RAX + i, RRX(env, i));
-    }
-
-    lflags_to_rflags(env);
-    wreg(cs->accel->fd, HV_X86_RFLAGS, env->eflags);
-    macvm_set_rip(cs, env->eip);
-}
-
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     /*if (hvf_vcpu_id(cs))
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 287fe11cf70..161217991fc 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -119,7 +119,7 @@ void vmx_handle_task_switch(CPUState *cpu, x86_segment_selector tss_sel, int rea
         return;
     }
 
-    load_regs(cpu);
+    hvf_load_regs(cpu);
 
     struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
     x86_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
@@ -178,7 +178,7 @@ void vmx_handle_task_switch(CPUState *cpu, x86_segment_selector tss_sel, int rea
     x86_segment_descriptor_to_vmx(cpu, tss_sel, &next_tss_desc, &vmx_seg);
     vmx_write_segment_descriptor(cpu, &vmx_seg, R_TR);
 
-    store_regs(cpu);
+    hvf_store_regs(cpu);
 
     hv_vcpu_invalidate_tlb(cpu->accel->fd);
 }
-- 
2.48.1


