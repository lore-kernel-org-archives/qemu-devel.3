Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE5E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl49-0000Gr-8B; Wed, 04 Dec 2024 03:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dRdQZwgKCiYYJGPFTKMIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--whendrik.bounces.google.com>)
 id 1tIl47-0000FZ-9l
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:59 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dRdQZwgKCiYYJGPFTKMIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--whendrik.bounces.google.com>)
 id 1tIl45-00011a-5e
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:59 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so36880135e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302133; x=1733906933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=b3xdx0BtyJ8+TSPEvjOg1rRfuqizDB0vQT6QT3cRbVk=;
 b=fDaFemuoCkF/QkkrNE/oQAMwWK8eoz3D0Wra8MFq1F/ZlyflD7iQ7PMpFURS62c0zh
 Wucgwq3IepQ0eceIGhXCao8EeFgZLWX3eIuJ3cnS2+soBo7J1phtSJcvqCKeHdsSeirf
 rUCrIfh1EJWoFCZzvltFSwehWyHd7d8uHrvn2tWOA15FCOUbtpLcYxqV1YHACaI/Mo0q
 StDoFrA283/0m5cfFbGnhgnYtaGafVaEbGlLKw2Q6uOE4wtnd5VH4ZGYUeQFX3nU7g63
 enN7q883GOaKxayZ3To/sTzSi0Uld87eoyEa6F5jvKLCWossdXRkWVoY8g0HqJV/HW5A
 1XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302133; x=1733906933;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b3xdx0BtyJ8+TSPEvjOg1rRfuqizDB0vQT6QT3cRbVk=;
 b=phdBKA6e9fHVPCVE+MNiymxumbQxWax6MyoE6gL05k/8gYu1YJZ6Ve+OPrIMFa5a4O
 Xc7kG66yosPA2+cqd+8idoHP2a0/sHy2Z/l3Au7ss4x8khvhRp+5JsDrC28liELA7ci5
 fsEHQ5517pbgK+YwwlfQyR5ZlSDQ2nsrN03qv4Nay1qwv77yeBLh/Qs/oBNlhkoVbhRb
 pCiKORg99jyT1NLQtkux3PMvQnvprrZMB3W6VI+zSwQR+j2IzwQp509vlXEutodQcIwR
 J1+XvD+4ELaWa0bCcFQbr4bvtgbVEz3pHu2W9nnzguhMkqYOCSMwnIkrQr9TyotDmrI3
 GAbA==
X-Gm-Message-State: AOJu0YzLAoSAMhC/lMxd3n5Zf+UPhwZWBvFKUsSzLJ/mkB+PEFdFV3Me
 788UJYVS8bFzFAtBW9dJ7u9M7CaGKygmrtyrYb4pr71wkJkvoff52UhARKPgnF0PojKWwT6Udyv
 2QuhlwQRXJL378qdLoG9BcJABw1Rx6FNbkPT6smOUS28/W2fDbl/xgwdas90lqOTWTPYPhASw1Y
 pUw7TgiprapMML+O4MMECLfWWKexsIlMjn0tVl2/mmKw==
X-Google-Smtp-Source: AGHT+IHhIGNjKTtOJmX/9FVIDvNs2Zul7pAEVFuzNKXKUYNhB7VtLRUxbMaXPR1H+XJNpfxOiKDAEO0Xg2lVMg==
X-Received: from wmba12.prod.google.com ([2002:a05:600c:6dcc:b0:434:9ed7:8b97])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b29:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-434d3fcc4e6mr27415265e9.24.1733302133323; 
 Wed, 04 Dec 2024 00:48:53 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:34 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-6-whendrik@google.com>
Subject: [PATCH v3 5/8] i386: Add CPUID enumeration for RDT
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3dRdQZwgKCiYYJGPFTKMIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--whendrik.bounces.google.com;
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

Add CPUID enumeration for intel RDT monitoring and allocation, as well
as the flags used in the enumeration code.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/rdt.c         | 33 +++++++++++++++++++++
 include/hw/i386/rdt.h | 31 +++++++++++++++++++
 target/i386/cpu.c     | 69 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h     |  5 ++++
 4 files changed, 138 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index f295273aec..a3c748c127 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -31,6 +31,20 @@
 #define RDT_MAX_L2_MASK_COUNT      63
 #define RDT_MAX_MBA_THRTL_COUNT    63
=20
+/* RDT L3 Allocation features */
+#define CPUID_10_1_EAX_CBM_LENGTH       0xf
+#define CPUID_10_1_EBX_CBM              0x0
+#define CPUID_10_1_ECX_CDP              0x0 // to enable, it would be (1U =
<< 2)
+#define CPUID_10_1_EDX_COS_MAX          MAX_L3_MASK_COUNT
+/* RDT L2 Allocation features*/
+#define CPUID_10_2_EAX_CBM_LENGTH       0xf
+#define CPUID_10_2_EBX_CBM              0x0
+#define CPUID_10_2_EDX_COS_MAX          MAX_L2_MASK_COUNT
+/* RDT MBA features */
+#define CPUID_10_3_EAX_THRTL_MAX        89
+#define CPUID_10_3_ECX_LINEAR_RESPONSE (1U << 2)
+#define CPUID_10_3_EDX_COS_MAX          MAX_MBA_THRTL_COUNT
+
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
=20
@@ -77,8 +91,27 @@ struct RDTState {
 struct RDTStateClass {
 };
=20
+uint32_t rdt_get_cpuid_15_0_edx_l3(void) { return CPUID_15_1_EDX_L3_OCCUPA=
NCY | CPUID_15_1_EDX_L3_TOTAL_BW | CPUID_15_1_EDX_L3_LOCAL_BW; }
+
+uint32_t rdt_cpuid_15_1_edx_l3_total_bw_enabled(void) { return CPUID_15_1_=
EDX_L3_TOTAL_BW; }
+uint32_t rdt_cpuid_15_1_edx_l3_local_bw_enabled(void) { return CPUID_15_1_=
EDX_L3_LOCAL_BW; }
+uint32_t rdt_cpuid_15_1_edx_l3_occupancy_enabled(void) { return CPUID_15_1=
_EDX_L3_OCCUPANCY; }
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
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index ec82a149f2..57d2fa5b77 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -20,13 +20,44 @@
 #include <stdbool.h>
 #include <stdint.h>
=20
+/* RDT L3 Cache Monitoring Technology */
+#define CPUID_15_0_EDX_L3               (1U << 1)
+#define CPUID_15_1_EDX_L3_OCCUPANCY     (1U << 0)
+#define CPUID_15_1_EDX_L3_TOTAL_BW      (1U << 1)
+#define CPUID_15_1_EDX_L3_LOCAL_BW      (1U << 2)
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
+uint32_t rdt_get_cpuid_15_0_edx_l3(void);
+
+uint32_t rdt_cpuid_15_1_edx_l3_total_bw_enabled(void);
+uint32_t rdt_cpuid_15_1_edx_l3_local_bw_enabled(void);
+uint32_t rdt_cpuid_15_1_edx_l3_occupancy_enabled(void);
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
index 4688d140c2..a8198fe5a7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -42,6 +42,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "hw/i386/rdt.h"
=20
 #include "disas/capstone.h"
 #include "cpu-internal.h"
@@ -6629,6 +6630,74 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
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
+            warn_report("Intel RDT features enabled in commandline, but rd=
t device not used");
+            break;
+        }
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Monitoring Resource Type Enumeration */
+            case 0:
+                *edx =3D env->features[FEAT_RDT_15_0_EDX];
+                *ebx =3D rdt_max_rmid(cpu->rdt);
+                break;
+            case 1:
+                *ebx =3D 1;
+                *ecx =3D rdt_max_rmid(cpu->rdt);
+                *edx =3D rdt_cpuid_15_1_edx_l3_total_bw_enabled() |
+                       rdt_cpuid_15_1_edx_l3_local_bw_enabled() |
+                       rdt_cpuid_15_1_edx_l3_occupancy_enabled();
+                break;
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
+            warn_report("Intel RDT features enabled in commandline, but rd=
t device not used");
+            break;
+        }
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Cache Allocation Technology Available Resource Types */
+            case 0:
+                *ebx |=3D rdt_cpuid_10_0_ebx_l3_cat_enabled();
+                *ebx |=3D rdt_cpuid_10_0_ebx_l2_cat_enabled();
+                *ebx |=3D rdt_cpuid_10_0_ebx_l2_mba_enabled();
+                break;
+            case 1:
+                *eax =3D rdt_get_cpuid_10_1_eax_cbm_length();
+                *ebx =3D rdt_cpuid_10_1_ebx_cbm_enabled();
+                *ecx |=3D rdt_cpuid_10_1_ecx_cdp_enabled();
+                *edx =3D  rdt_get_cpuid_10_1_edx_cos_max();
+                break;
+            case 2:
+                *eax =3D rdt_get_cpuid_10_2_eax_cbm_length();
+                *ebx =3D rdt_cpuid_10_2_ebx_cbm_enabled();
+                *edx =3D  rdt_get_cpuid_10_2_edx_cos_max();
+                break;
+            case 3:
+                *eax =3D rdt_get_cpuid_10_3_eax_thrtl_max();
+                *ecx =3D rdt_cpuid_10_3_eax_linear_response_enabled();
+                *edx =3D rdt_get_cpuid_10_3_edx_cos_max();
+                break;
+        }
+        break;
+#endif
     case 0x1C:
         if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_ED=
X_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d7d5ad37fd..1520a93927 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -673,6 +673,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=3D0xd,ECX=3D1].EDX */
     FEAT_7_1_EDX,       /* CPUID[EAX=3D7,ECX=3D1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=3D7,ECX=3D2].EDX */
+    FEAT_RDT_15_0_EDX,  /* CPUID[EAX=3D0xf,ECX=3D0].EDX (RDT CMT/MBM) */
     FEATURE_WORDS,
 } FeatureWord;
=20
@@ -843,8 +844,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cp=
u, FeatureWord w);
 #define CPUID_7_0_EBX_INVPCID           (1U << 10)
 /* Restricted Transactional Memory */
 #define CPUID_7_0_EBX_RTM               (1U << 11)
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
2.47.0.338.g60cca15819-goog


