Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F31CE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI20-0002vB-Dn; Thu, 05 Dec 2024 15:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YwZSZwgKCvg1mjsiwnplttlqj.htrvjrz-ij0jqstslsz.twl@flex--whendrik.bounces.google.com>)
 id 1tJI1k-0002s0-Ll
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:45 -0500
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YwZSZwgKCvg1mjsiwnplttlqj.htrvjrz-ij0jqstslsz.twl@flex--whendrik.bounces.google.com>)
 id 1tJI1i-0001du-LL
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:44 -0500
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-385e9c69929so569033f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428836; x=1734033636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=n2k3Kj++lpw+/t0tRPKUWKSRAwMCFCHVv44hybRHn4A=;
 b=v2RqZTOGsW5UZ4uFgmMYiAfMQN5jyAxeUWrYtyrjOtqCJlrkcW7hn8Uugwx3/amWT9
 fcnl9cYVmXJu2dSZvInLLNI6lXRAlt1l6K4JeTpjVh33ESBQu5r+n5tHcd8GwHuRTQON
 J2TXIsVfR2EXGC6YcS7z2WURehrlwNR3xILNmuY9v6afGhA5vZj1HQwNiVgygWj5cWhG
 VJHOyZMnZpuB6TMILf7GecGEYsRYYDcFvjW/I6KPTvdUH7lT40EKhxvH/b7HWuoOZI+B
 N+/afu+MNbYEtn5GTUw6AaKYsJPTKD5LpExW5y6hakaJLJ48saCmnTrKY+YzMcBXII2O
 11yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428836; x=1734033636;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n2k3Kj++lpw+/t0tRPKUWKSRAwMCFCHVv44hybRHn4A=;
 b=o66G1VvZ1Bs+ePY8oS71EVmSjxRx0VCCMVchZCfcShJMQIV+UmmnQUI6CyyQ6sjBEU
 /EmHTXFMT34f87NbKFqw0WPAjsTxhEiswCtBGBOstYOcdA02Nje9CdVgJwfCNFoiLx9w
 6smIt05XBr5SwPNH9YeBx0DxEr/kjLOFV+OnTmKO1jAeltXXX2clErLBHq+cggtbqRHX
 30I+4LZVm3ttrfE1tUJMgdNjXMY0xjbsuyRTY7B7iVRhJYPuGXoUJVm+i2ZXbfCLixwj
 BIARqo3UBSrIEqCOqmVL2YtvkoQV8oBBlTVn0sfFNDXiUJ6p5CDUaL2itRDXWq4vFTR9
 7M2g==
X-Gm-Message-State: AOJu0YzqEvWjhvk8kinjvGbh1VlhFpFFDaT9gBGBlCjOfN4Sc1Ppkz8Z
 bDcP5/Bht56U4k8utLwEh26lbYqh9ckdVfGpGXI95brCeDGsO4TaoQV+jr4y5DevEkR1fEr7hTN
 OJxTury/KKDC1120g6/WH8LFz9nuczjsIePtRDYerWa3WAbhgozVQdeJ/nQNHtCHrVk4vVou4gj
 CQxgbgtZ5Lx4pBPruKZrpgfDIlFvOhRQWOtDl/Dnto2w==
X-Google-Smtp-Source: AGHT+IFn99Rmv5S1XumH2jBaxIAluPe3SSF7qp6sRMvWaFEB5hGr/PCAvDGEpy3p5QRiiOK92ZpEmijKy2XgeA==
X-Received: from wmjv14.prod.google.com ([2002:a7b:cb4e:0:b0:42c:b22f:f7f7])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6f0d:0:b0:385:faad:bfb9 with SMTP id
 ffacd0b85a97d-3862b33b7bfmr399884f8f.8.1733428835908; 
 Thu, 05 Dec 2024 12:00:35 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:21 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-5-whendrik@google.com>
Subject: [PATCH v4 4/8] i386: Add RDT device interface through MSRs
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3YwZSZwgKCvg1mjsiwnplttlqj.htrvjrz-ij0jqstslsz.twl@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x449.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

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

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/rdt.c                        |  4 ++
 include/hw/i386/rdt.h                |  4 ++
 target/i386/cpu.h                    | 14 +++++
 target/i386/tcg/sysemu/misc_helper.c | 81 ++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 01bee79cbe..3a37341bd6 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -81,6 +81,10 @@ struct RDTState {
 struct RDTStateClass {
 };
=20
+uint32_t rdt_get_cpuid_10_1_edx_cos_max(void) { return RDT_MAX_L3_MASK_COU=
NT; }
+uint32_t rdt_get_cpuid_10_2_edx_cos_max(void) { return RDT_MAX_L2_MASK_COU=
NT; }
+uint32_t rdt_get_cpuid_10_3_edx_cos_max(void) { return RDT_MAX_MBA_THRTL_C=
OUNT; }
+
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc)
 {
     X86CPU *cpu =3D X86_CPU(current_cpu);
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index 14b1c64b72..ec82a149f2 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -25,6 +25,10 @@ typedef struct RDTStatePerCore RDTStatePerCore;
 typedef struct RDTMonitor RDTMonitor;
 typedef struct RDTAllocation RDTAllocation;
=20
+uint32_t rdt_get_cpuid_10_1_edx_cos_max(void);
+uint32_t rdt_get_cpuid_10_2_edx_cos_max(void);
+uint32_t rdt_get_cpuid_10_3_edx_cos_max(void);
+
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
=20
 void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0f73c1244d..64a53efa30 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -576,6 +576,17 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
=20
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
=20
@@ -1839,6 +1850,9 @@ typedef struct CPUArchState {
     uint64_t msr_ia32_feature_control;
     uint64_t msr_ia32_sgxlepubkeyhash[4];
=20
+    uint64_t msr_ia32_qm_evtsel;
+    uint64_t msr_ia32_pqr_assoc;
+
     uint64_t msr_fixed_ctr_ctrl;
     uint64_t msr_global_ctrl;
     uint64_t msr_global_status;
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/=
misc_helper.c
index 094aa56a20..a6c6b11a29 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "tcg/helper-tcg.h"
+#include "hw/i386/rdt.h"
 #include "hw/i386/apic.h"
=20
 void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
@@ -293,6 +294,45 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs =3D val;
         cpu_sync_bndcs_hflags(env);
         break;
+    case MSR_IA32_QM_EVTSEL:
+        env->msr_ia32_qm_evtsel =3D val;
+        break;
+    case MSR_IA32_PQR_ASSOC:
+        env->msr_ia32_pqr_assoc =3D val;
+
+        if (!rdt_associate_rmid_cos(val))
+            goto error;
+        break;
+    case MSR_IA32_L3_CBM_BASE ... MSR_IA32_L3_MASKS_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L3_CBM_BASE=
;
+
+        if (pos > rdt_get_cpuid_10_1_edx_cos_max()) {
+            goto error;
+        }
+        rdt_write_msr_l3_mask(pos, val);
+        break;
+    }
+    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BASE=
;
+
+        if (pos > rdt_get_cpuid_10_2_edx_cos_max()) {
+            goto error;
+        }
+        rdt_write_msr_l2_mask(pos, val);
+        break;
+    }
+    case MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE ... MSR_IA32_L2_QOS_Ext_BW_Thrt=
l_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_QOS_Ext_=
BW_Thrtl_BASE;
+
+        if (pos > rdt_get_cpuid_10_3_edx_cos_max()) {
+            goto error;
+        }
+        rdt_write_mba_thrtl(pos, val);
+        break;
+    }
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
@@ -472,6 +512,47 @@ void helper_rdmsr(CPUX86State *env)
         val =3D (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
         break;
     }
+    case MSR_IA32_QM_CTR:
+        val =3D rdt_read_event_count(x86_cpu->rdt,
+                                   (env->msr_ia32_qm_evtsel >> 32) & 0xff,
+                                   env->msr_ia32_qm_evtsel & 0xff);
+        break;
+    case MSR_IA32_QM_EVTSEL:
+        val =3D env->msr_ia32_qm_evtsel;
+        break;
+    case MSR_IA32_PQR_ASSOC:
+        val =3D env->msr_ia32_pqr_assoc;
+        break;
+    case MSR_IA32_L3_CBM_BASE ... MSR_IA32_L3_MASKS_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L3_CBM_BASE=
;
+
+        if (pos >=3D rdt_get_cpuid_10_1_edx_cos_max()) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+        val =3D rdt_read_l3_mask(pos);
+        break;
+    }
+    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BASE=
;
+
+        if (pos >=3D rdt_get_cpuid_10_2_edx_cos_max()) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+        val =3D rdt_read_l2_mask(pos);
+        break;
+    }
+    case MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE ... MSR_IA32_L2_QOS_Ext_BW_Thrt=
l_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_QOS_Ext_=
BW_Thrtl_BASE;
+
+        if (pos >=3D rdt_get_cpuid_10_3_edx_cos_max()) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+        val =3D rdt_read_mba_thrtl(pos);
+        break;
+    }
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
--=20
2.47.0.338.g60cca15819-goog


