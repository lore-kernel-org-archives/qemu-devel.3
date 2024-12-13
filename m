Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF62E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Rb-0008UT-Ql; Fri, 13 Dec 2024 12:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3aG5cZwgKCvcvgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com>)
 id 1tM9RY-0008TE-Ln
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:12 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3aG5cZwgKCvcvgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com>)
 id 1tM9RT-0007q8-KO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:12 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so4858625e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110825; x=1734715625; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=pGGndzlyEmTL5r3SwAzymXOwQXZlbBFF+E9VZuGkaIQ=;
 b=kKogyAvf2Q0a9Ycmp8LQoQMKAaL16UlfpMz/mWgAE3mfm/RAhUEgEtxwVsrVdOGYS/
 gh0jBZcPxhp5T+TDZZpi0ROm/GPJKC2CT9Bc8dU5lwVxQOLqfskly5YQ6oJ0K+bdL6Gx
 OLefz1csvszcy8fMTJaVzHd5yy3h25CY96pwdXBt5Q5+eOVP057ec6zfqgmOo/SNehp2
 HXMAf3Rp7E+DRTSo0zu1o987KR1Xq7RDk1V5/jRQJnn+GrEMMNYf66/vdBNEByc/zjhY
 UdZuKPOfNxL3lMpFLDnZJ/mgNwNa8va8E1CbWdT7DtBF8U25P771ver8u/2laE1WUJ/m
 zQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110825; x=1734715625;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pGGndzlyEmTL5r3SwAzymXOwQXZlbBFF+E9VZuGkaIQ=;
 b=iCRfJHwOmQeyPzEel0g13wrblBTDu/PhVLi+3rxUpQfEZXj8BfJgEDjFQQ96wYpcpY
 PEcxjKhNJaa4C1rULa7DDgjh2lO8NiRyMX5dWOM7wys1XkkT02dAIMfJ4jJbfKkx/yH9
 3YQbn1wxhAY/fKNWIiYx4ce44lFE3VBD+HtUCNCU13mhgZV2T/jpzQNRRC9InIqVy6n5
 nz8KkMKT6lsim+Y2MUBvquOlcb3h5+ntCgDjaekxfIDQdjEBxXmkgYk7+7490AUE0vwl
 aJ6iyqFJ7bt+bJFqYkh9ijYzCTXD4bmvHSZU43XQU1PB6nmfVFnBAAb4Gas79nR1kT3z
 0d6w==
X-Gm-Message-State: AOJu0YxYVLY4ZqKICuZ3edtl0ut0pqCtaYi/Rm+4tHOhbhi8YF5iPcBf
 A9IT0ErsCzm40J3MFZsdREcdx2/YFJ+GURgRTVqzfJPQyTFGKsSh//rpiRRhYuQqR/3+Sznab4x
 AHt+tHaLQ/+Z7jYGZTarjF5bNRMLEQLyjgFKCSyjVMD2r+/e8KDETPnaK6kPS4l9+6wQXhZ8FcA
 Rogz54HkAw4cioY1r9oXw1Ea6xeV+bHlSqLDiAE+Sfcg==
X-Google-Smtp-Source: AGHT+IGhvN4/1yno2Lnqg3uB4M24JpY5kItm0P2r0QcNdzXCqBkl2Jr1zxIh9qssRj4MSfswc3OdK0w0qS+agg==
X-Received: from wmna1.prod.google.com ([2002:a05:600c:681:b0:434:a2a5:1fb5])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d86:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-4362a98815cmr33545565e9.0.1734110824963; 
 Fri, 13 Dec 2024 09:27:04 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:42 +0000
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-6-whendrik@google.com>
Subject: [PATCH v5 5/8] i386: Add CPUID enumeration for RDT
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3aG5cZwgKCvcvgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
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

Add CPUID enumeration for intel RDT monitoring and allocation, as well
as the flags used in the enumeration code.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/rdt.c         | 30 ++++++++++++++++++
 include/hw/i386/rdt.h | 31 +++++++++++++++++++
 target/i386/cpu.c     | 71 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h     |  5 +++
 4 files changed, 137 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 3a37341bd6..7c9170559d 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -35,6 +35,17 @@
 #define RDT_MAX_L2_MASK_COUNT      63
 #define RDT_MAX_MBA_THRTL_COUNT    63
=20
+/* RDT L3 Allocation features */
+#define CPUID_10_1_EAX_CBM_LENGTH       0xf
+#define CPUID_10_1_EBX_CBM              0x0
+#define CPUID_10_1_ECX_CDP              0x0 // to enable, it would be (1U =
<< 2)
+/* RDT L2 Allocation features*/
+#define CPUID_10_2_EAX_CBM_LENGTH       0xf
+#define CPUID_10_2_EBX_CBM              0x0
+/* RDT MBA features */
+#define CPUID_10_3_EAX_THRTL_MAX        89
+#define CPUID_10_3_ECX_LINEAR_RESPONSE (1U << 2)
+
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
=20
@@ -81,8 +92,27 @@ struct RDTState {
 struct RDTStateClass {
 };
=20
+uint32_t rdt_get_cpuid_F_0_edx_l3(void) { return CPUID_F_1_EDX_L3_OCCUPANC=
Y | CPUID_F_1_EDX_L3_TOTAL_BW | CPUID_F_1_EDX_L3_LOCAL_BW; }
+
+uint32_t rdt_cpuid_F_1_edx_l3_total_bw_enabled(void) { return CPUID_F_1_ED=
X_L3_TOTAL_BW; }
+uint32_t rdt_cpuid_F_1_edx_l3_local_bw_enabled(void) { return CPUID_F_1_ED=
X_L3_LOCAL_BW; }
+uint32_t rdt_cpuid_F_1_edx_l3_occupancy_enabled(void) { return CPUID_F_1_E=
DX_L3_OCCUPANCY; }
+
+uint32_t rdt_cpuid_10_0_ebx_l3_cat_enabled(void) { return CPUID_10_0_EBX_L=
3_CAT; }
+uint32_t rdt_cpuid_10_0_ebx_l2_cat_enabled(void) { return CPUID_10_0_EBX_L=
2_CAT; }
+uint32_t rdt_cpuid_10_0_ebx_l2_mba_enabled(void) { return CPUID_10_0_EBX_M=
BA; }
+
+uint32_t rdt_get_cpuid_10_1_eax_cbm_length(void) { return CPUID_10_1_EAX_C=
BM_LENGTH; }
+uint32_t rdt_cpuid_10_1_ebx_cbm_enabled(void) { return CPUID_10_1_EBX_CBM;=
 }
+uint32_t rdt_cpuid_10_1_ecx_cdp_enabled(void) { return CPUID_10_1_ECX_CDP;=
 }
 uint32_t rdt_get_cpuid_10_1_edx_cos_max(void) { return RDT_MAX_L3_MASK_COU=
NT; }
+
+uint32_t rdt_get_cpuid_10_2_eax_cbm_length(void) { return CPUID_10_2_EAX_C=
BM_LENGTH; }
+uint32_t rdt_cpuid_10_2_ebx_cbm_enabled(void) { return CPUID_10_2_EBX_CBM;=
 }
 uint32_t rdt_get_cpuid_10_2_edx_cos_max(void) { return RDT_MAX_L2_MASK_COU=
NT; }
+
+uint32_t rdt_get_cpuid_10_3_eax_thrtl_max(void) { return CPUID_10_3_EAX_TH=
RTL_MAX; }
+uint32_t rdt_cpuid_10_3_eax_linear_response_enabled(void) { return CPUID_1=
0_3_ECX_LINEAR_RESPONSE; }
 uint32_t rdt_get_cpuid_10_3_edx_cos_max(void) { return RDT_MAX_MBA_THRTL_C=
OUNT; }
=20
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc)
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index ec82a149f2..859fb4871c 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -20,13 +20,44 @@
 #include <stdbool.h>
 #include <stdint.h>
=20
+/* RDT L3 Cache Monitoring Technology */
+#define CPUID_F_0_EDX_L3               (1U << 1)
+#define CPUID_F_1_EDX_L3_OCCUPANCY     (1U << 0)
+#define CPUID_F_1_EDX_L3_TOTAL_BW      (1U << 1)
+#define CPUID_F_1_EDX_L3_LOCAL_BW      (1U << 2)
+
+/* RDT Cache Allocation Technology */
+#define CPUID_10_0_EBX_L3_CAT           (1U << 1)
+#define CPUID_10_0_EBX_L2_CAT           (1U << 2)
+#define CPUID_10_0_EBX_MBA              (1U << 3)
+#define CPUID_10_0_EDX CPUID_10_0_EBX_L3_CAT | CPUID_10_0_EBX_L2_CAT | CPU=
ID_10_0_EBX_MBA
+
 typedef struct RDTState RDTState;
 typedef struct RDTStatePerCore RDTStatePerCore;
 typedef struct RDTMonitor RDTMonitor;
 typedef struct RDTAllocation RDTAllocation;
=20
+uint32_t rdt_get_cpuid_F_0_edx_l3(void);
+
+uint32_t rdt_cpuid_F_1_edx_l3_total_bw_enabled(void);
+uint32_t rdt_cpuid_F_1_edx_l3_local_bw_enabled(void);
+uint32_t rdt_cpuid_F_1_edx_l3_occupancy_enabled(void);
+
+uint32_t rdt_cpuid_10_0_ebx_l3_cat_enabled(void);
+uint32_t rdt_cpuid_10_0_ebx_l2_cat_enabled(void);
+uint32_t rdt_cpuid_10_0_ebx_l2_mba_enabled(void);
+
+uint32_t rdt_get_cpuid_10_1_eax_cbm_length(void);
+uint32_t rdt_cpuid_10_1_ebx_cbm_enabled(void);
+uint32_t rdt_cpuid_10_1_ecx_cdp_enabled(void);
 uint32_t rdt_get_cpuid_10_1_edx_cos_max(void);
+
+uint32_t rdt_get_cpuid_10_2_eax_cbm_length(void);
+uint32_t rdt_cpuid_10_2_ebx_cbm_enabled(void);
 uint32_t rdt_get_cpuid_10_2_edx_cos_max(void);
+
+uint32_t rdt_get_cpuid_10_3_eax_thrtl_max(void);
+uint32_t rdt_cpuid_10_3_eax_linear_response_enabled(void);
 uint32_t rdt_get_cpuid_10_3_edx_cos_max(void);
=20
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3725dbbc4b..c6e6cff19d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -41,6 +41,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "hw/i386/rdt.h"
=20
 #include "disas/capstone.h"
 #include "cpu-internal.h"
@@ -6725,6 +6726,76 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
 uint32_t count,
         assert(!(*eax & ~0x1f));
         *ebx &=3D 0xffff; /* The count doesn't need to be reliable. */
         break;
+#ifndef CONFIG_USER_ONLY
+    case 0xF:
+        /* Shared Resource Monitoring Enumeration Leaf */
+        *eax =3D 0;
+        *ebx =3D 0;
+        *ecx =3D 0;
+        *edx =3D 0;
+        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQM))
+            break;
+        if (!(cpu->rdt)) {
+            warn_report("Intel RDT features enabled in commandline, "
+                        "but rdt device not used");
+            break;
+        }
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Monitoring Resource Type Enumeration */
+        case 0:
+            *edx =3D env->features[FEAT_RDT_F_0_EDX];
+            *ebx =3D rdt_max_rmid(cpu->rdt);
+            break;
+        case 1:
+            *ebx =3D 1;
+            *ecx =3D rdt_max_rmid(cpu->rdt);
+            *edx =3D rdt_cpuid_F_1_edx_l3_total_bw_enabled() |
+                    rdt_cpuid_F_1_edx_l3_local_bw_enabled() |
+                   rdt_cpuid_F_1_edx_l3_occupancy_enabled();
+            break;
+        }
+        break;
+    case 0x10:
+        /* Shared Resource Director Technology Allocation Enumeration Leaf=
 */
+        *eax =3D 0;
+        *ebx =3D 0;
+        *ecx =3D 0;
+        *edx =3D 0;
+        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQE))
+            break;
+        if (!(cpu->rdt)) {
+            warn_report("Intel RDT features enabled in commandline, "
+                        "but rdt device not used");
+            break;
+        }
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Cache Allocation Technology Available Resource Types */
+        case 0:
+            *ebx |=3D rdt_cpuid_10_0_ebx_l3_cat_enabled();
+            *ebx |=3D rdt_cpuid_10_0_ebx_l2_cat_enabled();
+            *ebx |=3D rdt_cpuid_10_0_ebx_l2_mba_enabled();
+            break;
+        case 1:
+            *eax =3D rdt_get_cpuid_10_1_eax_cbm_length();
+            *ebx =3D rdt_cpuid_10_1_ebx_cbm_enabled();
+            *ecx |=3D rdt_cpuid_10_1_ecx_cdp_enabled();
+            *edx =3D  rdt_get_cpuid_10_1_edx_cos_max();
+            break;
+        case 2:
+            *eax =3D rdt_get_cpuid_10_2_eax_cbm_length();
+            *ebx =3D rdt_cpuid_10_2_ebx_cbm_enabled();
+            *edx =3D  rdt_get_cpuid_10_2_edx_cos_max();
+            break;
+        case 3:
+            *eax =3D rdt_get_cpuid_10_3_eax_thrtl_max();
+            *ecx =3D rdt_cpuid_10_3_eax_linear_response_enabled();
+            *edx =3D rdt_get_cpuid_10_3_edx_cos_max();
+            break;
+        }
+        break;
+#endif
     case 0x1C:
         if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_ED=
X_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 64a53efa30..a1ec2d5dde 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -678,6 +678,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=3D7,ECX=3D1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=3D7,ECX=3D2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=3D0x24,ECX=3D0].EBX */
+    FEAT_RDT_F_0_EDX,  /* CPUID[EAX=3D0xf,ECX=3D0].EDX (RDT CMT/MBM) */
     FEATURE_WORDS,
 } FeatureWord;
=20
@@ -852,8 +853,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cp=
u, FeatureWord w);
 #define CPUID_7_0_EBX_RTM               (1U << 11)
 /* Zero out FPU CS and FPU DS */
 #define CPUID_7_0_EBX_ZERO_FCS_FDS      (1U << 13)
+/* Resource Director Technology Monitoring */
+#define CPUID_7_0_EBX_PQM               (1U << 12)
 /* Memory Protection Extension */
 #define CPUID_7_0_EBX_MPX               (1U << 14)
+/* Resource Director Technology Allocation */
+#define CPUID_7_0_EBX_PQE               (1U << 15)
 /* AVX-512 Foundation */
 #define CPUID_7_0_EBX_AVX512F           (1U << 16)
 /* AVX-512 Doubleword & Quadword Instruction */
--=20
2.47.1.613.gc27f4b7a9f-goog


