Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB93C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6c3-0005WZ-C4; Fri, 28 Feb 2025 15:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38RbCZwgKCmwgROXNbSUQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--whendrik.bounces.google.com>)
 id 1to6bk-00059m-R8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:19 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38RbCZwgKCmwgROXNbSUQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--whendrik.bounces.google.com>)
 id 1to6bd-00019a-7N
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:15 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-439a5c4dfb2so12425955e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773105; x=1741377905; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=f+N70W1h/Xmy4CplrtdSn+OiQuPC9AQ4ibAdCjh6RWE=;
 b=oaa8E2C3OytYVvsHm+SBwwTIoqBjnsETdhVk8j5/qVhv2At9NfgT6nI03r43Lx+PWZ
 yeoCYfR+U4a65NQOL4elpB6Dyt//Y0auXdbF40iu3gl3QMp/kenX+cPmLjqlcvcOVF+L
 gKQ3O05iKIUKSg3qEQyEL8+ELuTsIvQydnz6IPROm6Tla6kUug4Zfe8TE6SkXWkkujp9
 aYxc1M+fT3c6DmIt5LkRSWvgcthd8KnyUeMjKxlFDSIwmqT22xaJ5exHxCTPjmdPWNKP
 hIrX3kJapg34OxIZ1KEokZuz55jdGvymMjSMD99V62T8gZEW0agcwwsEb7bYJBAZ52HL
 PFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773105; x=1741377905;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f+N70W1h/Xmy4CplrtdSn+OiQuPC9AQ4ibAdCjh6RWE=;
 b=PXov8hDPLyjWLqrPe8PP3Om8ShOYtAxN8nX9gIYaXgt+3dM5mXt4k1fF4a8otqah+M
 FJfRyqnNh1EeX5humHhB8ty/tMWwqulgETUpdchAJiEGrlIxUHXvaHdXrSy3yz/qD5AY
 cqDboMqjKoxzo0Qx3YSsaPfZ7Egf0NOInsGp3qVHtIXVIlLMvKs0kQNBd/DOsHwd23yh
 ug60rgbVduX0nLjesrtU/rkFGNPejkIP1Ozt5CjScozu8isE2wyzwmr1Q4xezshOLviz
 VcLmUa1HFW8m8HrPm/dZIYrC4FLrR7uC4a1mazmQzYeSo5vbCNmg634r9pOKiMQ8kPsR
 BWjQ==
X-Gm-Message-State: AOJu0Yza1TW6C/7u5dzcnavM+cl++I53gl1LDfV5vIvxj2pvdJVxQ5sJ
 FwlWwcteAmFLs/yErojNMwCKdU5M1I189FrSCLajEetCIyFxaFoXgqkrY24DydDqFOdlsAcxIjP
 6gqhSwCaOg8V7MFuaBBr0EzbRiXekimKYcGmLimUTGjsSuyaq/zEaTjDiXp1R28CJDC8AZrHrRf
 FNSArRjqr/+uWrh9+CGgQmSt6mcX86mH3WkcqrH+AiXA==
X-Google-Smtp-Source: AGHT+IEURBPBL9vfA5d4yzQspkEy1o3DNgfzPWOPavDLy+TO2pL5ibEL3KoF00/JlrhhwpKv+5lhTYI5jlJ/Dw==
X-Received: from wmbfk6.prod.google.com ([2002:a05:600c:cc6:b0:439:94f1:365e])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:511e:b0:439:6017:6689 with SMTP id
 5b1f17b1804b1-43ba66e0bf5mr40423805e9.9.1740773105262; 
 Fri, 28 Feb 2025 12:05:05 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:49 +0000
In-Reply-To: <20250228200453.45173-1-whendrik@google.com>
Mime-Version: 1.0
References: <20250228200453.45173-1-whendrik@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-4-whendrik@google.com>
Subject: [PATCH v6 4/8] i386: Add RDT device interface through MSRs
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=38RbCZwgKCmwgROXNbSUQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Implement rdmsr and wrmsr for the following MSRs:
* MSR_IA32_PQR_ASSOC
* MSR_IA32_QM_EVTSEL
* MSR_IA32_QM_CTR
* IA32_L3_QOS_Mask_n
* IA32_L2_QOS_Mask_n
* IA32_L2_QoS_Ext_BW_Thrtl_n

This allows for the guest to call RDT-internal functions to
associate an RMID with a CLOSID / set an active RMID for
monitoring, read monitoring data, and set classes of service.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 include/hw/i386/rdt.h                |  4 ++
 target/i386/cpu.h                    | 14 +++++
 target/i386/tcg/system/misc_helper.c | 85 ++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index d087627499..b63b433eef 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -29,6 +29,10 @@
 #define RDT_MAX_L2_MASK_COUNT      63
 #define RDT_MAX_MBA_THRTL_COUNT    63
 
+#define CPUID_10_1_EDX_COS_MAX          RDT_MAX_L3_MASK_COUNT
+#define CPUID_10_2_EDX_COS_MAX          RDT_MAX_L2_MASK_COUNT
+#define CPUID_10_3_EDX_COS_MAX          RDT_MAX_MBA_THRTL_COUNT
+
 typedef struct RDTState RDTState;
 typedef struct RDTStatePerL3Cache RDTStatePerL3Cache;
 typedef struct RDTStatePerCore RDTStatePerCore;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2cbcc8fe4e..08089ce6c2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -577,6 +577,17 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 
+#define MSR_IA32_QM_EVTSEL                  0x0c8d
+#define MSR_IA32_QM_CTR                     0x0c8e
+#define MSR_IA32_PQR_ASSOC                  0x0c8f
+
+#define MSR_IA32_L3_CBM_BASE                0x0c90
+#define MSR_IA32_L3_MASKS_END               0x0d0f
+#define MSR_IA32_L2_CBM_BASE                0x0d10
+#define MSR_IA32_L2_CBM_END                 0x0d4f
+#define MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE   0xd50
+#define MSR_IA32_L2_QOS_Ext_BW_Thrtl_END    0xd8f
+
 #define MSR_APIC_START                  0x00000800
 #define MSR_APIC_END                    0x000008ff
 
@@ -1883,6 +1894,9 @@ typedef struct CPUArchState {
     uint64_t msr_ia32_feature_control;
     uint64_t msr_ia32_sgxlepubkeyhash[4];
 
+    uint64_t msr_ia32_qm_evtsel;
+    uint64_t msr_ia32_pqr_assoc;
+
     uint64_t msr_fixed_ctr_ctrl;
     uint64_t msr_global_ctrl;
     uint64_t msr_global_status;
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index c9c4d42f84..7027f7228c 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "tcg/helper-tcg.h"
+#include "hw/i386/rdt.h"
 #include "hw/i386/apic.h"
 
 void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
@@ -293,6 +294,47 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs = val;
         cpu_sync_bndcs_hflags(env);
         break;
+#ifdef CONFIG_RDT
+    case MSR_IA32_QM_EVTSEL:
+        env->msr_ia32_qm_evtsel = val;
+        break;
+    case MSR_IA32_PQR_ASSOC:
+        env->msr_ia32_pqr_assoc = val;
+
+        if (!rdt_associate_rmid_cos(val))
+            goto error;
+        break;
+    case MSR_IA32_L3_CBM_BASE ... MSR_IA32_L3_MASKS_END:
+    {
+        uint32_t pos = (uint32_t)env->regs[R_ECX] - MSR_IA32_L3_CBM_BASE;
+
+        if (pos > CPUID_10_1_EDX_COS_MAX) {
+            goto error;
+        }
+        rdt_write_msr_l3_mask(pos, val);
+        break;
+    }
+    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
+    {
+        uint32_t pos = (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BASE;
+
+        if (pos > CPUID_10_2_EDX_COS_MAX) {
+            goto error;
+        }
+        rdt_write_msr_l2_mask(pos, val);
+        break;
+    }
+    case MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE ... MSR_IA32_L2_QOS_Ext_BW_Thrtl_END:
+    {
+        uint32_t pos = (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE;
+
+        if (pos > CPUID_10_3_EDX_COS_MAX) {
+            goto error;
+        }
+        rdt_write_mba_thrtl(pos, val);
+        break;
+    }
+#endif
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
@@ -471,6 +513,49 @@ void helper_rdmsr(CPUX86State *env)
         val = cpu_x86_get_msr_core_thread_count(x86_cpu);
         break;
     }
+#ifdef CONFIG_RDT
+    case MSR_IA32_QM_CTR:
+        val = rdt_read_event_count(x86_cpu->rdtPerNode,
+                                   (env->msr_ia32_qm_evtsel >> 32) & 0xff,
+                                   env->msr_ia32_qm_evtsel & 0xff);
+        break;
+    case MSR_IA32_QM_EVTSEL:
+        val = env->msr_ia32_qm_evtsel;
+        break;
+    case MSR_IA32_PQR_ASSOC:
+        val = env->msr_ia32_pqr_assoc;
+        break;
+    case MSR_IA32_L3_CBM_BASE ... MSR_IA32_L3_MASKS_END:
+    {
+        uint32_t pos = (uint32_t)env->regs[R_ECX] - MSR_IA32_L3_CBM_BASE;
+
+        if (pos >= CPUID_10_1_EDX_COS_MAX) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+        val = rdt_read_l3_mask(pos);
+        break;
+    }
+    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
+    {
+        uint32_t pos = (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BASE;
+
+        if (pos >= CPUID_10_2_EDX_COS_MAX) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+        val = rdt_read_l2_mask(pos);
+        break;
+    }
+    case MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE ... MSR_IA32_L2_QOS_Ext_BW_Thrtl_END:
+    {
+        uint32_t pos = (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE;
+
+        if (pos >= CPUID_10_3_EDX_COS_MAX) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+        val = rdt_read_mba_thrtl(pos);
+        break;
+    }
+#endif
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-- 
2.48.1.711.g2feabab25a-goog


