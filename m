Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7D0CD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAZr-0008V4-Dh; Thu, 05 Sep 2024 07:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3jZTZZggKCloO96F5JAC8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--whendrik.bounces.google.com>)
 id 1smAZp-0008LZ-4w
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:01 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3jZTZZggKCloO96F5JAC8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--whendrik.bounces.google.com>)
 id 1smAZl-0002yW-9K
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:00 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-374c581ce35so390039f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725535374; x=1726140174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=zCigvg6qxJM1SCQofdH94q2bhvwsYEgiSEWRDdMjOTY=;
 b=OwalraMAihR2B0cWm8IpBrFlkC2jTtF7CfQAjqokOvql66LgrA8Boc7GQFjZXmDMHg
 lLSQ41bf/w76cPFwsYTu8R8ueUFPUkQhouBiph9NcC/HkBiZr8O3R2F/2W4NesbM2DCw
 9omopRT1MUAZ4DCfFbvuoKNqa3TKmTpaQug60f2l8k2Bu9sib8lYtmgsgXP+dSm0es8j
 EJTC8oMpUKgxFbyB7SmfbJXGvJrrbFwUomEpsjWAQAER0djqHq/ZtYMZcP0n6a6qoouT
 LOD7UWV0E64ATDXsV/M9n/FhKf7GDuFSAeVxy9Ts5O4NakS7czrmkn8Hz/MiiVwyb3Ld
 VL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535374; x=1726140174;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zCigvg6qxJM1SCQofdH94q2bhvwsYEgiSEWRDdMjOTY=;
 b=fFSb+sO4ch8qnW5hp7cTxwBTjJRnP1N5TDNF6o7GAWGmfVUqrLtdZamlzH7qoL7SVG
 xR+cTn6EUzmYh19fFv5ylTsQ3RBIJI06nMRqXfFqU/s8Zh2YK4tlSB4RHJEd81cJoWFe
 G7n3mEReCngoWuMIit7Vei2QSD1R3wbyX+JL1I266LvLCIUIBaXsoBtgugihwuJz90ri
 fNqIw1HtlK5zOwldaO3jg+eMlTeyNGg4V87NH3K7MSVo26Ez8LI+WsrCXAjEBGlwt7NJ
 wIfiuLwPmsirjJCqXd4xGy9w1A6dxa1AMREEMxudOZOMEFoTe3lEnumaFXc9T6fTnA2n
 oeFQ==
X-Gm-Message-State: AOJu0YyY5dSVDjD2JMKBa4aWMn4EwROiV3SWH7uGujhve5zBx02OJFMs
 rpLGIDJ0UMu9aOcH+yztf6BXA3T184pUPQl0jYZSixHiuYJp1Q/PiE9zWKuF+iDv3OJU+A69ih0
 qUyGek0VlCGrm/8bzi8ajA59QnIejEtciYp17GOuF47asVgNGb+/5Z12lATf1e+MB3VgBlNRd9b
 ol/SkfycD+7VzqqGE/2zNZdmFcKs9YSawFk7764+Z6aQ==
X-Google-Smtp-Source: AGHT+IGUCeJ5pqlusSMAD9m8/pn8+ka9wvYb7z11WwlHWbbDqUNRIRCl3VUDSCer0XVp/buXu+F6C5rTMgVWRQ==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:130:7cd9:ac11:98f1]) (user=whendrik job=sendgmr) by
 2002:a5d:56c2:0:b0:374:cef0:fd45 with SMTP id
 ffacd0b85a97d-374cef1007amr17833f8f.11.1725535373445; 
 Thu, 05 Sep 2024 04:22:53 -0700 (PDT)
Date: Thu,  5 Sep 2024 11:22:33 +0000
In-Reply-To: <20240905112237.3586972-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240905112237.3586972-1-whendrik@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905112237.3586972-5-whendrik@google.com>
Subject: [PATCH v2 4/8] i386: Add RDT device interface through MSRs
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3jZTZZggKCloO96F5JAC8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
 include/hw/i386/rdt.h                |  4 ++
 target/i386/cpu.h                    | 14 +++++
 target/i386/tcg/sysemu/misc_helper.c | 84 ++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 288f1fd107..d3713073c5 100644
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
index a2941f98eb..e722fd4622 100644
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
index 094aa56a20..bbfd5c0219 100644
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
+
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
+
+        if (pos >=3D rdt_get_cpuid_10_3_edx_cos_max()) {
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
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC()); =20
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
2.46.0.469.g59c65b2a67-goog


