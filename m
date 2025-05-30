Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58511C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyw-0006tM-Iz; Fri, 30 May 2025 03:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxf-00040n-Dm
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxd-0007En-GM
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixJ55lNCw9I1NysCzHg4Sn/OUFXZhIJDHwDf3PEKFKE=;
 b=NSEmck68xTD7pspSoJ30o0Dpep2Iw/WsvD/v+FLlsYT8Eie4SABLhibHP4G4B58aTcIxZq
 f4ZzzBX+YCqb1KngenXOUPe9F4jxFvBwVRQs8VSBpt0Jge+oTEgW2rXVZADqrJghcpW1p5
 F0HpGoyEyQzfKXpiQ8P3rj3GSCJqVUo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-wb2-cca6NIC4CAbTfSLl-A-1; Fri, 30 May 2025 03:15:23 -0400
X-MC-Unique: wb2-cca6NIC4CAbTfSLl-A-1
X-Mimecast-MFC-AGG-ID: wb2-cca6NIC4CAbTfSLl-A_1748589322
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso158795866b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589321; x=1749194121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixJ55lNCw9I1NysCzHg4Sn/OUFXZhIJDHwDf3PEKFKE=;
 b=mtFFlH4MrIezsEPm0BlJRVb3RgCZHcgEXew/PgqkNsc8KIhhR2ZtPd0sqKxiPp67+7
 8DLbYvfz9WmrGrzxJuD0om7SZ2herMN+mKGHMymFM8Ss2LSAVS/L99hx7hpfGbrRq1jE
 vQ2/nr/nYkXpyPiLL4GE0ve03KXod7MT2Qzi0R/MVkVmqdu9KgIedFpCBLTxLEZNmSlx
 2Z10mVY88ABFD7Q062Y0VrvoSW9Og97MNsnSRLA27BA7SrFNoPGDP83kIXPrZv2iS3Oz
 tHfb1w15NzpuaBxnl9uA1w+KKYCvCj2wdr85KUGhEOqCRg4xvg4Lx6SWB3TG6pwy0Qzz
 12BQ==
X-Gm-Message-State: AOJu0YytPan+iROJVRr8CXHGS5GyNdrlt+8ngKUtZUYFNdSll4orOnDg
 LEYk/Bq/7bX9QAYHq3U6e+Mq7PPZrzetCrEdusVs1NPBIA/ZxYtIn3D0v/bOtcXAHexwrkCkV1e
 1/iIVIc03H5pMowq3VWOkTiDT8CHpJQcvKrBVUAG68xsM381OvstQM73+ZpPV0LtMe2p4cBhPhC
 rCu1m+h2czJbDDnCaId1l9OvF7iaJJ2ieUbjTsPpyO
X-Gm-Gg: ASbGncu+FWHafvntUWCzNQ2GEAugYr5t8i16b0fqhNH8th2HjYJasYf1+ZOtaa8Ty95
 9SH90wuA9XvNqfKssfioDmmEwieXXM9NUcC38xxGiHC+5WDoZJNXtO/kAs/gIeP2ob/4IG6lzt6
 JJve0RcnQqa+gB2qij5OodYsePjTNo4UTZe3vQy+GAqGREthiY6s7pCkn/sRoaXyaursrTwK06T
 GiWeqa42x2/YXTBszinlbXQd9sCtmuHZ9o/52rQeb++kS/37OQxGttrMjd/BRSKyg1lUswAoH4r
 pTAiqgvJQjMFXw==
X-Received: by 2002:a17:907:7246:b0:ad8:9c97:c2fc with SMTP id
 a640c23a62f3a-adb36b31a5dmr96193866b.13.1748589321267; 
 Fri, 30 May 2025 00:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr9U1L7MUXEqU5KgHYJAMd9suT/IwFc+bIPxjaPbgjdN1sU8IYmk3kh39lqlzVopvrgTgDBA==
X-Received: by 2002:a17:907:7246:b0:ad8:9c97:c2fc with SMTP id
 a640c23a62f3a-adb36b31a5dmr96191666b.13.1748589320752; 
 Fri, 30 May 2025 00:15:20 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5a758sm1191781a12.19.2025.05.30.00.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 59/77] i386/tdx: Add supported CPUID bits relates to XFAM
Date: Fri, 30 May 2025 09:12:29 +0200
Message-ID: <20250530071250.2050910-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Some CPUID bits are controlled by XFAM. They are not covered by
tdx_caps.cpuid (which only contians the directly configurable bits), but
they are actually supported when the related XFAM bit is supported.

Add these XFAM controlled bits to TDX supported CPUID bits based on the
supported_xfam.

Besides, incorporate the supported_xfam into the supported CPUID leaf of
0xD.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-48-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 16 ++++++++++
 target/i386/cpu.c     | 12 -------
 target/i386/kvm/tdx.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e50c57264dc..b38e691f1af 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -584,6 +584,7 @@ typedef enum X86Seg {
 #define XSTATE_OPMASK_BIT               5
 #define XSTATE_ZMM_Hi256_BIT            6
 #define XSTATE_Hi16_ZMM_BIT             7
+#define XSTATE_PT_BIT                   8
 #define XSTATE_PKRU_BIT                 9
 #define XSTATE_ARCH_LBR_BIT             15
 #define XSTATE_XTILE_CFG_BIT            17
@@ -597,6 +598,7 @@ typedef enum X86Seg {
 #define XSTATE_OPMASK_MASK              (1ULL << XSTATE_OPMASK_BIT)
 #define XSTATE_ZMM_Hi256_MASK           (1ULL << XSTATE_ZMM_Hi256_BIT)
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
+#define XSTATE_PT_MASK                  (1ULL << XSTATE_PT_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
 #define XSTATE_ARCH_LBR_MASK            (1ULL << XSTATE_ARCH_LBR_BIT)
 #define XSTATE_XTILE_CFG_MASK           (1ULL << XSTATE_XTILE_CFG_BIT)
@@ -619,6 +621,11 @@ typedef enum X86Seg {
                                  XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK | \
                                  XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
 
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+
+#define CPUID_XSTATE_MASK       (CPUID_XSTATE_XCR0_MASK | CPUID_XSTATE_XSS_MASK)
+
 /* CPUID feature words */
 typedef enum FeatureWord {
     FEAT_1_EDX,         /* CPUID[1].EDX */
@@ -667,6 +674,15 @@ typedef enum FeatureWord {
     FEATURE_WORDS,
 } FeatureWord;
 
+typedef struct FeatureMask {
+    FeatureWord index;
+    uint64_t mask;
+} FeatureMask;
+
+typedef struct FeatureDep {
+    FeatureMask from, to;
+} FeatureDep;
+
 typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5aacb62f081..383c0b35d48 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1694,15 +1694,6 @@ bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg)
     return false;
 }
 
-typedef struct FeatureMask {
-    FeatureWord index;
-    uint64_t mask;
-} FeatureMask;
-
-typedef struct FeatureDep {
-    FeatureMask from, to;
-} FeatureDep;
-
 static FeatureDep feature_dependencies[] = {
     {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
@@ -1871,9 +1862,6 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 };
 #undef REGISTER
 
-/* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
-
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
         /* x87 FP state component is always enabled if XSAVE is supported */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index fa161661fa8..188c2242d53 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -23,6 +23,8 @@
 
 #include <linux/kvm_para.h>
 
+#include "cpu.h"
+#include "cpu-internal.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
@@ -486,6 +488,32 @@ static TdxAttrsMap tdx_attrs_maps[] = {
      .feat_mask = CPUID_7_0_ECX_KeyLocker,},
 };
 
+typedef struct TdxXFAMDep {
+    int xfam_bit;
+    FeatureMask feat_mask;
+} TdxXFAMDep;
+
+/*
+ * Note, only the CPUID bits whose virtualization type are "XFAM & Native" are
+ * defiend here.
+ *
+ * For those whose virtualization type are "XFAM & Configured & Native", they
+ * are reported as configurable bits. And they are not supported if not in the
+ * configureable bits list from KVM even if the corresponding XFAM bit is
+ * supported.
+ */
+TdxXFAMDep tdx_xfam_deps[] = {
+    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA }},
+    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 }},
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI}},
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16}},
+    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT}},
+    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU}},
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 }},
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE }},
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 }},
+};
+
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
                                                         uint32_t index)
 {
@@ -553,6 +581,50 @@ static void tdx_add_supported_cpuid_by_attrs(void)
     }
 }
 
+static void tdx_add_supported_cpuid_by_xfam(void)
+{
+    struct kvm_cpuid_entry2 *e;
+    int i;
+
+    const TdxXFAMDep *xfam_dep;
+    const FeatureWordInfo *f;
+    for (i = 0; i < ARRAY_SIZE(tdx_xfam_deps); i++) {
+        xfam_dep = &tdx_xfam_deps[i];
+        if (!((1ULL << xfam_dep->xfam_bit) & tdx_caps->supported_xfam)) {
+            continue;
+        }
+
+        f = &feature_word_info[xfam_dep->feat_mask.index];
+        if (f->type != CPUID_FEATURE_WORD) {
+            continue;
+        }
+
+        e = find_in_supported_entry(f->cpuid.eax, f->cpuid.ecx);
+        switch(f->cpuid.reg) {
+        case R_EAX:
+            e->eax |= xfam_dep->feat_mask.mask;
+            break;
+        case R_EBX:
+            e->ebx |= xfam_dep->feat_mask.mask;
+            break;
+        case R_ECX:
+            e->ecx |= xfam_dep->feat_mask.mask;
+            break;
+        case R_EDX:
+            e->edx |= xfam_dep->feat_mask.mask;
+            break;
+        }
+    }
+
+    e = find_in_supported_entry(0xd, 0);
+    e->eax |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK);
+    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;
+
+    e = find_in_supported_entry(0xd, 1);
+    e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
+    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -568,6 +640,7 @@ static void tdx_setup_supported_cpuid(void)
 
     tdx_add_supported_cpuid_by_fixed1_bits();
     tdx_add_supported_cpuid_by_attrs();
+    tdx_add_supported_cpuid_by_xfam();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
-- 
2.49.0


