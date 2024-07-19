Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A7C3DA7E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVS-0004Fs-Na; Fri, 19 Jul 2024 13:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eZSaZggKCkg6roxn1suqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--whendrik.bounces.google.com>)
 id 1sUqUR-0002xy-1j
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:57 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eZSaZggKCkg6roxn1suqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--whendrik.bounces.google.com>)
 id 1sUqUO-0004UB-AQ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:50 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so8431185e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406586; x=1722011386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Trplm99Z1aULDWhzH5q5aD7aoAQd1PPsWcyH21okhHs=;
 b=aScLeyn4ICl3wlvBAFqhLpcg8SHpdqlNixLFhreL22M+5rc/f98c1RN1yuTOraMJWy
 ZwBDuEwrMFf1ci/cw9XF/TnJ/crPd7yAUU5buw8r8Z7fS0yvTMlnV2LPmUht8Mdqmeqp
 RbxZASzRywbU6BnWR7jYGp5a9BEW1uaer4mEW7z1rIgW6HXot2Lh9QGK7ZiOpcuqiRr8
 +lwd5PZSxJDRjqOQdT/wbDhpXd2M+MjZEUdTOIDTcjqlBlnmGX0Yj2QBYhTjqSLsWmuU
 KFJmxNNQgCeJxVRr0pBSt/UqG1QXuSWG3GNCNGaUH7NuOZoZqAcdTpWvfeTguDc2v8Lq
 kMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406586; x=1722011386;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Trplm99Z1aULDWhzH5q5aD7aoAQd1PPsWcyH21okhHs=;
 b=W8tKBmtNjipPugpjXkr/GaOmWYE19QmSDq4GtZmTpnmYwIFKpdKupAzljKIvAtRgwA
 yU5h/OU4BDfXi9XY9rU+8bPkVm65zmWhmp37MArWi4b64j/fiLIT8UxHTsHJ9hu1WyDW
 aSGWCS824km/j51iBw+iOXa6zeXcHaCoGNxY1B+D8u60gVVg4u51Qcn853x2I1HgTOs5
 +WZ3W9SWu5vSroAXwnd4VhYKj3TEt0kmHHFSUCZtulzxNh1xQ+14QtaD116FvRSReaNs
 trH8fyAZ3nFLBkY4DsGwCAbE1pAPSOxbI7ng0/ndykmMYG9A4gDISEfQQGNjukR2d/FV
 kMpw==
X-Gm-Message-State: AOJu0YxYE+3l+abFs7G86DrKLpAFuSZKCxaJBT87wQ+5/D/wHRGC/bjS
 v8fxsqnkP1TJlAKeedau4bEAGytOl09Hx6mKGksiN47xnTUjGn2ilBK494JklSOKbIFLk2Xcofb
 T/hkfjs9Ccx2AaHWcPyhP78dPG3a2QwPzorPxB9lB+sbX/aAGmPzf6D9pEQg3nzG6VtXDZCD2Qj
 U2TQKtOobkTtFr0PcoerY8hDLedaqdHf8XyhDZ6HuQww==
X-Google-Smtp-Source: AGHT+IFCv+YVMM4ND7PfSuzkzJpeNK4OFi4OY06S8sH/6TRIjE5ggmufRHZWg5wMkZBhKdOa0TS4MoQv7HHRCw==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:600c:1e2a:b0:426:6771:f768 with SMTP id
 5b1f17b1804b1-427da8b0fbdmr3605e9.2.1721406585797; 
 Fri, 19 Jul 2024 09:29:45 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:25 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-6-whendrik@google.com>
Subject: [PATCH v1 5/9] Add RDT device interface through MSRs
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3eZSaZggKCkg6roxn1suqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:50 -0400
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
 hw/i386/rdt.c                        |  8 +++
 include/hw/i386/rdt.h                |  8 ++-
 target/i386/cpu.h                    | 14 +++++
 target/i386/tcg/sysemu/misc_helper.c | 80 ++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 77b7b4f2d4..0d0e5751fc 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -17,6 +17,10 @@
 #define MAX_L2_MASK_COUNT      48
 #define MAX_MBA_THRTL_COUNT    31
=20
+#define CPUID_10_1_EDX_COS_MAX          MAX_L3_MASK_COUNT
+#define CPUID_10_2_EDX_COS_MAX          MAX_L2_MASK_COUNT
+#define CPUID_10_3_EDX_COS_MAX          MAX_MBA_THRTL_COUNT
+
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
=20
@@ -57,6 +61,10 @@ struct RDTState {
=20
 struct RDTStateClass { };
=20
+uint32_t rdt_get_cpuid_10_1_edx_cos_max(void) { return CPUID_10_1_EDX_COS_=
MAX; }
+uint32_t rdt_get_cpuid_10_2_edx_cos_max(void) { return CPUID_10_2_EDX_COS_=
MAX; }
+uint32_t rdt_get_cpuid_10_3_edx_cos_max(void) { return CPUID_10_3_EDX_COS_=
MAX; }
+
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
     X86CPU *cpu =3D X86_CPU(current_cpu);
     RDTStateInstance *rdt =3D cpu->rdt;
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index 8092c5f290..51d36822f0 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -9,7 +9,12 @@ typedef struct RDTStateInstance RDTStateInstance;
 typedef struct RDTMonitor RDTMonitor;
 typedef struct RDTAllocation RDTAllocation;
=20
-#endif
+uint32_t rdt_get_cpuid_10_1_edx_cos_max(void);
+
+uint32_t rdt_get_cpuid_10_2_edx_cos_max(void);
+
+uint32_t rdt_get_cpuid_10_3_edx_cos_max(void);
+
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
=20
 void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val);
@@ -23,3 +28,4 @@ uint32_t rdt_read_mba_thrtl(uint32_t pos);
 uint64_t rdt_read_event_count(RDTStateInstance *rdt, uint32_t rmid, uint32=
_t event_id);
 uint32_t rdt_max_rmid(RDTStateInstance *rdt);
=20
+#endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bd0bbb75f2..0b3aca2d02 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -574,6 +574,17 @@ typedef enum X86Seg {
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
+#define MSR_IA32_L2_QOS_Ext_BW_Thrtl_END    0xd80
+
 #define MSR_APIC_START                  0x00000800
 #define MSR_APIC_END                    0x000008ff
=20
@@ -1778,6 +1789,9 @@ typedef struct CPUArchState {
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
index 094aa56a20..e48e6b0da1 100644
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
@@ -293,6 +294,44 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs =3D val;
         cpu_sync_bndcs_hflags(env);
         break;
+    case MSR_IA32_QM_EVTSEL:
+        env->msr_ia32_qm_evtsel =3D val;
+        break;
+    case MSR_IA32_PQR_ASSOC:
+    {
+        env->msr_ia32_pqr_assoc =3D val;
+        bool res =3D rdt_associate_rmid_cos(val);
+        if (!res)
+            goto error;
+        break;
+    }
+    case MSR_IA32_L3_CBM_BASE ... MSR_IA32_L3_MASKS_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L3_CBM_BASE=
;
+        if (pos >=3D rdt_get_cpuid_10_1_edx_cos_max()) {
+            goto error;
+        }
+        rdt_write_msr_l3_mask(pos, val);
+        break;
+    }
+    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BASE=
;
+        if (pos >=3D rdt_get_cpuid_10_2_edx_cos_max()) {
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
+        if (pos >=3D rdt_get_cpuid_10_3_edx_cos_max()) {
+            goto error;
+        }
+        rdt_write_mba_thrtl(pos, val);
+        break;
+    }
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
@@ -472,6 +511,44 @@ void helper_rdmsr(CPUX86State *env)
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
+        if (pos >=3D rdt_get_cpuid_10_1_edx_cos_max()) {
+            goto error;
+        }
+        val =3D rdt_read_l3_mask(pos);
+        break;
+    }
+    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BASE=
;
+        if (pos >=3D rdt_get_cpuid_10_2_edx_cos_max()) {
+            goto error;
+        }
+        val =3D rdt_read_l2_mask(pos);
+        break;
+    }
+    case MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE ... MSR_IA32_L2_QOS_Ext_BW_Thrt=
l_END:
+    {
+        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_QOS_Ext_=
BW_Thrtl_BASE;
+        if (pos >=3D rdt_get_cpuid_10_3_edx_cos_max()) {
+            goto error;
+        }
+        val =3D rdt_read_mba_thrtl(pos);
+        break;
+    }
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
@@ -499,6 +576,9 @@ void helper_rdmsr(CPUX86State *env)
     }
     env->regs[R_EAX] =3D (uint32_t)(val);
     env->regs[R_EDX] =3D (uint32_t)(val >> 32);
+return;
+error:
+    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
 }
=20
 void helper_flush_page(CPUX86State *env, target_ulong addr)
--=20
2.45.2.1089.g2a221341d9-goog


