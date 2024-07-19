Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBA6C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVP-00044c-SX; Fri, 19 Jul 2024 13:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3e5SaZggKCko8tqzp3uws00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--whendrik.bounces.google.com>)
 id 1sUqUZ-0003On-56
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:30:01 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3e5SaZggKCko8tqzp3uws00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--whendrik.bounces.google.com>)
 id 1sUqUP-0004WD-TG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:51 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-426703ac975so8547455e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406588; x=1722011388; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=LAGJSiOgd9dVOQDbtiYOShQjCMcc/VJ01zFY9NDoXtg=;
 b=IGa9YBI+NxUoMjsEuPiXCUYC78ipBIQ701/fcbgEsvDPrxnu4Tma1KHl2TFToJES3F
 vI5x2kFojPyhwkRQPHfCtFRzBQX4v1YYKFErXTfvraU9qYLMfAgkzimOD5/eBzg7WnzP
 Vw412e9QkDY1+8YIxpdbG0MHz1zg9iSoFSskPyfuBBIsQ9kwHeuA3+CWaGpRM8vjRH3e
 gUyFpjKwCHDkiseu3pRsSoFOOpauELWsOUDCsOTzGgWE4qLm+Q69JM5zcfFQ+lQ05MlQ
 J83jn9Wo0zGrOfwdxnzc4RLkyieZIw0k8Y8x2QkZnJTh0YpQmNng9QF/Y3YahAsXMcfq
 wD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406588; x=1722011388;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LAGJSiOgd9dVOQDbtiYOShQjCMcc/VJ01zFY9NDoXtg=;
 b=rZXSaNHuwK3b5fm5OFXpq2eq6EofdGc/fC3oeA6lQTb1ZlnuGyZMo1Tkq3VRFw+e20
 EKtfffz7bjlXNulW1n80mIqOg2a56LxGBFcba44ee6Odi9DJa6u4oljaxEYvQAxdh2me
 UkEixzcemEQ3SNU1mrh+OqkCH/3s2YrkWYW7wgxE+MKguQ06Wtoqx4rIFjM99YR9FxIu
 j/dsM4UKZ6BCOhcvsa2QvE8mH/h7nsZ5sy3tJV5lo1AMuy9s7GGdwhc10ymByTOvLvCS
 Gs7z5TuJ3s5q+TKT5LUeRzuV+OBuFISeGV7h2LTGvOhyzs9CgNPNZtgieO3vGOXcuUqk
 DcKw==
X-Gm-Message-State: AOJu0YwV64lCQE/D1rHvZ6BM4uWdQ9HtxF/wszrfwpFI8sDNoLMn6fm5
 COt2IDUYOn9F4eC2z1MDARtRk6tUVK/4LJ/rXl4GJL0UQuqdeuJPHnha5UfiTrem4Xr+grWAkxy
 GZWg7f8GKBUV4Au8WDdVce82n6h5PaYcezoGPoD8M9d0VhxZHFhV96BoiR0rDLHjip0/v2C/gbx
 DqvLl8BJw7oR6PArfesIFzmTpRDPtVml86hy0Bo5g9gw==
X-Google-Smtp-Source: AGHT+IE4rczDTzPH+DQuLYL1ci+PkW1+Az9jJaU6RIzOH5qimA24FyprXqGy3ymr4+EEJ6CgOwMOJPGm/ASY6Q==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:600c:5025:b0:426:674a:4e4e with SMTP id
 5b1f17b1804b1-427da9b96c5mr1735e9.4.1721406587692; 
 Fri, 19 Jul 2024 09:29:47 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:26 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-7-whendrik@google.com>
Subject: [PATCH v1 6/9] Add CPUID enumeration for RDT
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3e5SaZggKCko8tqzp3uws00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--whendrik.bounces.google.com;
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

Add CPUID enumeration for intel RDT monitoring and allocation, as well
as the flags used in the enumeration code.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/rdt.c         | 29 ++++++++++++++
 include/hw/i386/rdt.h | 29 ++++++++++++++
 target/i386/cpu.c     | 91 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h     |  5 +++
 4 files changed, 154 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 0d0e5751fc..5ad05f996a 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -17,8 +17,18 @@
 #define MAX_L2_MASK_COUNT      48
 #define MAX_MBA_THRTL_COUNT    31
=20
+/* RDT L3 Allocation features */
+#define CPUID_10_1_EAX_CBM_LENGTH       0xf
+#define CPUID_10_1_EBX_CBM              0x0
+#define CPUID_10_1_ECX_CDP              0x0 // to enable, it would be (1U =
<< 2)
 #define CPUID_10_1_EDX_COS_MAX          MAX_L3_MASK_COUNT
+/* RDT L2 Allocation features*/
+#define CPUID_10_2_EAX_CBM_LENGTH       0xf
+#define CPUID_10_2_EBX_CBM              0x0
 #define CPUID_10_2_EDX_COS_MAX          MAX_L2_MASK_COUNT
+/* RDT MBA features */
+#define CPUID_10_3_EAX_THRTL_MAX        89
+#define CPUID_10_3_ECX_LINEAR_RESPONSE (1U << 2)
 #define CPUID_10_3_EDX_COS_MAX          MAX_MBA_THRTL_COUNT
=20
 #define TYPE_RDT "rdt"
@@ -61,8 +71,27 @@ struct RDTState {
=20
 struct RDTStateClass { };
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
 uint32_t rdt_get_cpuid_10_1_edx_cos_max(void) { return CPUID_10_1_EDX_COS_=
MAX; }
+
+uint32_t rdt_get_cpuid_10_2_eax_cbm_length(void) { return CPUID_10_2_EAX_C=
BM_LENGTH; }
+uint32_t rdt_cpuid_10_2_ebx_cbm_enabled(void) { return CPUID_10_2_EBX_CBM;=
 }
 uint32_t rdt_get_cpuid_10_2_edx_cos_max(void) { return CPUID_10_2_EDX_COS_=
MAX; }
+
+uint32_t rdt_get_cpuid_10_3_eax_thrtl_max(void) { return CPUID_10_3_EAX_TH=
RTL_MAX; }
+uint32_t rdt_cpuid_10_3_eax_linear_response_enabled(void) { return CPUID_1=
0_3_ECX_LINEAR_RESPONSE; }
 uint32_t rdt_get_cpuid_10_3_edx_cos_max(void) { return CPUID_10_3_EDX_COS_=
MAX; }
=20
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index 51d36822f0..74aba33995 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -4,15 +4,44 @@
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
 typedef struct RDTStateInstance RDTStateInstance;
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
=20
+uint32_t rdt_get_cpuid_10_2_eax_cbm_length(void);
+uint32_t rdt_cpuid_10_2_ebx_cbm_enabled(void);
 uint32_t rdt_get_cpuid_10_2_edx_cos_max(void);
=20
+uint32_t rdt_get_cpuid_10_3_eax_thrtl_max(void);
+uint32_t rdt_cpuid_10_3_eax_linear_response_enabled(void);
 uint32_t rdt_get_cpuid_10_3_edx_cos_max(void);
=20
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2..c61981bf82 100644
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
@@ -6629,6 +6630,96 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
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
+        assert(cpu->rdt);
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Monitoring Resource Type Enumeration */
+            case 0:
+                *edx =3D env->features[FEAT_RDT_15_0_EDX];
+                *ebx =3D rdt_max_rmid(cpu->rdt);
+                break;
+            /* L3 Cache Monitoring Capability Enumeration Data */
+            case 1:
+                /* Upscaling Factor */
+                *ebx =3D 1;
+                /* MaxRMID */
+                *ecx =3D rdt_max_rmid(cpu->rdt);
+                /* Set L3 Total BW */
+                *edx |=3D rdt_cpuid_15_1_edx_l3_total_bw_enabled();
+                /* Set L3 Local BW */
+                *edx |=3D rdt_cpuid_15_1_edx_l3_local_bw_enabled();
+                /* Set L3 Occupancy */
+                *edx |=3D rdt_cpuid_15_1_edx_l3_occupancy_enabled();
+                break;
+            default:
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
+        assert(cpu->rdt);
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Cache Allocation Technology Available Resource Types */
+            case 0:
+                /* Set L3 CAT */
+                *ebx |=3D rdt_cpuid_10_0_ebx_l3_cat_enabled();
+                /* Set L2 CAT */
+                *ebx |=3D rdt_cpuid_10_0_ebx_l2_cat_enabled();
+                /* Set MBA */
+                *ebx |=3D rdt_cpuid_10_0_ebx_l2_mba_enabled();
+                // *edx =3D env->features[FEAT_RDT_10_0_EBX];
+                break;
+            case 1:
+                /* Length of capacity bitmask in -1 notation */
+                *eax =3D rdt_get_cpuid_10_1_eax_cbm_length();
+                /* Capability bit mask */
+                *ebx =3D rdt_cpuid_10_1_ebx_cbm_enabled();
+                /* Code and Data priotitization */
+                *ecx |=3D rdt_cpuid_10_1_ecx_cdp_enabled();
+                /* Support for n COS masks (zero-referenced)*/
+                *edx =3D  rdt_get_cpuid_10_1_edx_cos_max();
+                break;
+            case 2:
+                /* Length of capacity bitmask in -1 notation */
+                *eax =3D rdt_get_cpuid_10_2_eax_cbm_length();
+                /* Capability bit mask */
+                *ebx =3D rdt_cpuid_10_2_ebx_cbm_enabled();
+                /* Support for n COS masks (zero-referenced)*/
+                *edx =3D  rdt_get_cpuid_10_2_edx_cos_max();
+                break;
+            case 3:
+                /* Max throttling value -1 (89 means 90) */
+                *eax =3D rdt_get_cpuid_10_3_eax_thrtl_max();
+                /* Linear response of delay values */
+                *ecx =3D rdt_cpuid_10_3_eax_linear_response_enabled();
+                /* Max number of CLOS -1 (15 means 16) */
+                *edx =3D rdt_get_cpuid_10_3_edx_cos_max();
+                break;
+            default:
+                *eax =3D 0;
+                *ebx =3D 0;
+                *ecx =3D 0;
+                *edx =3D 0;
+                break;
+        }
+        break;
+#endif
     case 0x1C:
         if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_ED=
X_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b3aca2d02..12a4b989af 100644
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
2.45.2.1089.g2a221341d9-goog


