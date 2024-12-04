Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA11E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl44-0000BV-SH; Wed, 04 Dec 2024 03:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cxdQZwgKCiQWHENDRIKGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--whendrik.bounces.google.com>)
 id 1tIl43-0000B4-1s
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:55 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cxdQZwgKCiQWHENDRIKGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--whendrik.bounces.google.com>)
 id 1tIl41-00011H-5Y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:54 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434a6483514so46488335e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302131; x=1733906931; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=cNAdBMjdTz7ImCpTTY8WArjOvkh3ADfd5YtDzq7u3Yc=;
 b=Q7fUZlqQH1SCxPqVRk7pwNN3L3aGwyUwVVmtsZktrnynhYy8wrZCdFMkWWn58cEkyv
 LUbAgcvu/5cn0d7NAGU17seCLYxHFubDYqnub8kbfdWgb6veT2EO5C7sV4nXenVu+iiW
 MSAAYuPmwWu1J00uR/OkrQoCfe1KjErVbr9XaZqr2r+v0fIeJJ7MoOfHpeBlN6sqqMml
 9a3m0BhcKIuJBOM9T5Z7yayDpAmtEoJI7iXlw+WzVXbufJIb/Pu58uX1wtTzgXYsRjmo
 BsNfQpCKsSw6T5NmQpHEXOlYO3I97+PZ5OJpoRCkNmJXXUVFJFTKPQHBJu6fHKfGdCeo
 HOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302131; x=1733906931;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cNAdBMjdTz7ImCpTTY8WArjOvkh3ADfd5YtDzq7u3Yc=;
 b=F75GKNFmJGIo2U0+Juf+Du1LH7/hsljsiJPPli5TBWBUtNNh36LESdBQDQ3kC9dSqw
 TgEB49TM/gsTocqkOPnl6D26Ur4WB++lGgc1jQPCakSu0jNI+3Qj8R+iGPc5rJAtMuE8
 OUSQ/0y4Q4dwHh0+tOsp+zH9TtdSi01R/OJeLtztC6Le0SgyOr6nVg+RWIIr98NHsowu
 dFWWIQN4rqQzaLNav+C3yp4W+CfXtb8Bln1DkE23SbXxBgKV3yXowWJ8LqQfvsnvft3n
 fVHSxD+LJ0R6s7n+o7+xxxXIv+ErG1w3nFhkV+bjZK5tpODP2CaTgU09UNpZNYSwaEhF
 05uQ==
X-Gm-Message-State: AOJu0YwYyO1DTxUxut1XLx8zf47F1+h5oKQbVd3PsUrzsvubu5UZaKcV
 6LPh0NojdHcDrR0BZCeQRVLvLsb9Y3m5qfzQqdMBPY+2cPQGOJzol9fRHPTNURzejKyVzC21lDx
 IoBR+MAb9PDIWNhY2gKm7djLci3BM5Y0DMrJ6mlT6M6xXN66XQDQtobOzX0tQpE9nAT7c+qH5E4
 YciIphXZ6zgJRgQE0LlOjTh0K2JZfkOVzIpSni9d73sg==
X-Google-Smtp-Source: AGHT+IGTUOOXIXwe1YqkSm+6GIDITjT5VyV+o/D3rKj6x1DYi3Jo/Ofuu7BdxpMXYun0kCTVubT4nj2pTXAikA==
X-Received: from wmlm7.prod.google.com ([2002:a7b:ca47:0:b0:434:b9c7:8907])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c9:b0:434:a5b6:273c with SMTP id
 5b1f17b1804b1-434d09b1464mr46502835e9.2.1733302131492; 
 Wed, 04 Dec 2024 00:48:51 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:33 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-5-whendrik@google.com>
Subject: [PATCH v3 4/8] i386: Add RDT device interface through MSRs
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3cxdQZwgKCiQWHENDRIKGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
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
 hw/i386/rdt.c                        | 22 ++++----
 include/hw/i386/rdt.h                |  6 +-
 target/i386/cpu.h                    | 14 +++++
 target/i386/tcg/sysemu/misc_helper.c | 84 ++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 13 deletions(-)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 19fea8999a..f295273aec 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -77,6 +77,10 @@ struct RDTState {
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
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
     X86CPU *cpu =3D X86_CPU(current_cpu);
     RDTStatePerCore *rdt =3D cpu->rdt;
@@ -86,7 +90,7 @@ bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) =
{
     uint32_t rmid =3D msr_ia32_pqr_assoc & 0xffff;
=20
     if (cos_id > RDT_MAX_L3_MASK_COUNT || cos_id > RDT_MAX_L2_MASK_COUNT |=
|
-    cos_id > RDT_MAX_MBA_THRTL_COUNT || rmid > rdt_max_rmid(rdt)) {
+        cos_id > RDT_MAX_MBA_THRTL_COUNT || rmid > rdt_max_rmid(rdt)) {
         return false;
     }
=20
@@ -104,8 +108,7 @@ uint32_t rdt_read_l3_mask(uint32_t pos)
     X86CPU *cpu =3D X86_CPU(current_cpu);
     RDTStatePerCore *rdt =3D cpu->rdt;
=20
-    uint32_t val =3D rdt->rdtstate->msr_L3_ia32_mask_n[pos];
-    return val;
+    return rdt->rdtstate->msr_L3_ia32_mask_n[pos];
 }
=20
 uint32_t rdt_read_l2_mask(uint32_t pos)
@@ -113,8 +116,7 @@ uint32_t rdt_read_l2_mask(uint32_t pos)
     X86CPU *cpu =3D X86_CPU(current_cpu);
     RDTStatePerCore *rdt =3D cpu->rdt;
=20
-    uint32_t val =3D rdt->rdtstate->msr_L2_ia32_mask_n[pos];
-    return val;
+    return rdt->rdtstate->msr_L2_ia32_mask_n[pos];
 }
=20
 uint32_t rdt_read_mba_thrtl(uint32_t pos)
@@ -122,8 +124,7 @@ uint32_t rdt_read_mba_thrtl(uint32_t pos)
     X86CPU *cpu =3D X86_CPU(current_cpu);
     RDTStatePerCore *rdt =3D cpu->rdt;
=20
-    uint32_t val =3D rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos];
-    return val;
+    return rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos];
 }
=20
 void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val) {
@@ -153,7 +154,8 @@ uint32_t rdt_max_rmid(RDTStatePerCore *rdt)
     return rdtdev->rmids - 1;
 }
=20
-uint64_t rdt_read_event_count(RDTStatePerCore *rdtInstance, uint32_t rmid,=
 uint32_t event_id)
+uint64_t rdt_read_event_count(RDTStatePerCore *rdtInstance,
+                              uint32_t rmid, uint32_t event_id)
 {
     CPUState *cs;
     RDTMonitor *mon;
@@ -181,13 +183,10 @@ uint64_t rdt_read_event_count(RDTStatePerCore *rdtIns=
tance, uint32_t rmid, uint3
     switch (event_id) {
         case RDT_EVENT_L3_OCCUPANCY:
             return count_l3 =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_l3;
-            break;
         case RDT_EVENT_L3_REMOTE_BW:
             return count_remote =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_remo=
te;
-            break;
         case RDT_EVENT_L3_LOCAL_BW:
             return count_local =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_local=
;
-            break;
         default:
             return QM_CTR_ERROR;
     }
@@ -247,4 +246,3 @@ static void rdt_class_init(ObjectClass *klass, void *da=
ta)
=20
     device_class_set_props(dc, rdt_properties);
 }
-
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index 875142bad8..ec82a149f2 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -25,7 +25,10 @@ typedef struct RDTStatePerCore RDTStatePerCore;
 typedef struct RDTMonitor RDTMonitor;
 typedef struct RDTAllocation RDTAllocation;
=20
-#endif
+uint32_t rdt_get_cpuid_10_1_edx_cos_max(void);
+uint32_t rdt_get_cpuid_10_2_edx_cos_max(void);
+uint32_t rdt_get_cpuid_10_3_edx_cos_max(void);
+
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
=20
 void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val);
@@ -39,3 +42,4 @@ uint32_t rdt_read_mba_thrtl(uint32_t pos);
 uint64_t rdt_read_event_count(RDTStatePerCore *rdt, uint32_t rmid, uint32_=
t event_id);
 uint32_t rdt_max_rmid(RDTStatePerCore *rdt);
=20
+#endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a2941f98eb..d7d5ad37fd 100644
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
+#define MSR_IA32_L2_QOS_Ext_BW_Thrtl_END    0xd8f
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
index 094aa56a20..707cd3dc81 100644
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
@@ -293,6 +294,47 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs =3D val;
         cpu_sync_bndcs_hflags(env);
         break;
+    case MSR_IA32_QM_EVTSEL:
+        env->msr_ia32_qm_evtsel =3D val;
+        break;
+    case MSR_IA32_PQR_ASSOC:
+    {
+        env->msr_ia32_pqr_assoc =3D val;
+
+        if (!rdt_associate_rmid_cos(val))
+            goto error;
+        break;
+    }
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
@@ -472,6 +514,47 @@ void helper_rdmsr(CPUX86State *env)
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
@@ -499,6 +582,7 @@ void helper_rdmsr(CPUX86State *env)
     }
     env->regs[R_EAX] =3D (uint32_t)(val);
     env->regs[R_EDX] =3D (uint32_t)(val >> 32);
+    return;
 }
=20
 void helper_flush_page(CPUX86State *env, target_ulong addr)
--=20
2.47.0.338.g60cca15819-goog


