Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6789DE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI26-0002wD-V3; Thu, 05 Dec 2024 15:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZQZSZwgKCvoyjgpftkmiqqing.eqosgow-fgxgnpqpipw.qti@flex--whendrik.bounces.google.com>)
 id 1tJI1n-0002sy-P3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:48 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZQZSZwgKCvoyjgpftkmiqqing.eqosgow-fgxgnpqpipw.qti@flex--whendrik.bounces.google.com>)
 id 1tJI1k-0001e9-EI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:47 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-43499388faaso10686035e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428837; x=1734033637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=pWkgJolpx+mZqKbhYNxiZ9/l5hMtBVxFSqBoV7MfHSM=;
 b=hgmphFZxTQS/cxj5mVra/8LfSxog1R/tKvlHzaVCbUW+CtyCN3phGCGjlUQjuoae2Y
 sR0QuWlU5TBbh26UM+HdlJt+sMrMfVWD8nWoj5Wui7l4NbXmWZuMxhBorecIcvqdJDVi
 OCptnrelTOEpv4JWjOoT6LMo9zzpXoIB/IT1YlRmzt1TqIFwtlOuV5zU/A+Gkj/j8bQx
 ZJGFM0QRIu7R9rFNyFLBN9qeGblAYiLcaK9bvB20rNTcD8k7UUFqtjsA2PbazZ0O1m48
 4bZsk4TcgCvhGKqSK+gAxisYU3E25sseklGl1/EzyTAW7Xlkan+Xj8MRt+jMW6PW6KIf
 verA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428837; x=1734033637;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pWkgJolpx+mZqKbhYNxiZ9/l5hMtBVxFSqBoV7MfHSM=;
 b=a28sakqJRy+akly3CvEVD8ziQ7bu1JwvW3QcPzTYzLnQns/xIyrgC5o9lsnPf7vCjC
 Yd1iGqkRJXOTVB/pkM68rW9CIlKQOgpF64ckpp72SB+EAycMHKN5+xqttb8p/25RWcZY
 6PY9ifVVO0mZUoQcD9SLzaYYlUnRNmhE2q574DKOV6Op9Gy5L/8R+wBJ43CkhEru2U8U
 rb8mkqV4zDQZ/1L8qhi+wzVbN9urXTU0saDfE3BovW7tbfVxJC4LycUbVoOaxIdKKluC
 mnPC+TGaZtS7CKxlF2KcIMhTMI34XE9Mi6TA3um03BEEII+IEiaH6InixJCRoytwNmby
 gM9w==
X-Gm-Message-State: AOJu0YxQmcN24f/u1qLyLHRWiZ8KcAZwVb6CG4KDlpKiMQ5hIP2M0haZ
 Dzr71BT/S8zXtS7orN7MYjSASYuyzTBBbhOYbVEmFmiZDdt1DJP3jBGdvFcuy4G0VChgvWMNhSF
 R2SVAczBhOf3IaQxYOHOtv3LQMXRxNYP2K0+auVNnSDsiZ008mvkRt2AzQ3O3TG+9kyOgMqlHrL
 hyL2+a7ESALJiPeyiag9mYGqw68py04wuPNL+J76kzJg==
X-Google-Smtp-Source: AGHT+IFVN+t5AaK9w5yosMHze73Ql178pSVRUsvxdVCTC54i5jsi7nFSQby/ALy/jmQQJJTpBUkk9Kcw2PLGmw==
X-Received: from wmpq23.prod.google.com ([2002:a05:600c:3317:b0:42c:b336:8685])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:358f:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-434ddeadeeemr4801105e9.2.1733428837804; 
 Thu, 05 Dec 2024 12:00:37 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:22 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-6-whendrik@google.com>
Subject: [PATCH v4 5/8] i386: Add CPUID enumeration for RDT
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3ZQZSZwgKCvoyjgpftkmiqqing.eqosgow-fgxgnpqpipw.qti@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
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
 hw/i386/rdt.c         | 30 ++++++++++++++++++
 include/hw/i386/rdt.h | 31 +++++++++++++++++++
 target/i386/cpu.c     | 71 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h     |  5 +++
 4 files changed, 137 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 3a37341bd6..1409f9a904 100644
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
 bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc)
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
index 3725dbbc4b..bbe2da8ebb 100644
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
+            *edx =3D env->features[FEAT_RDT_15_0_EDX];
+            *ebx =3D rdt_max_rmid(cpu->rdt);
+            break;
+        case 1:
+            *ebx =3D 1;
+            *ecx =3D rdt_max_rmid(cpu->rdt);
+            *edx =3D rdt_cpuid_15_1_edx_l3_total_bw_enabled() |
+                    rdt_cpuid_15_1_edx_l3_local_bw_enabled() |
+                   rdt_cpuid_15_1_edx_l3_occupancy_enabled();
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
index 64a53efa30..98407c8e18 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -678,6 +678,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=3D7,ECX=3D1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=3D7,ECX=3D2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=3D0x24,ECX=3D0].EBX */
+    FEAT_RDT_15_0_EDX,  /* CPUID[EAX=3D0xf,ECX=3D0].EDX (RDT CMT/MBM) */
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
2.47.0.338.g60cca15819-goog


