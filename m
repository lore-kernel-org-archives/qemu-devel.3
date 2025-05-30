Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C558AC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyw-0006ol-5J; Fri, 30 May 2025 03:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxb-0003u9-30
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxY-0007EN-0g
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Orjcr0WOSg/rpO4DfKUDnvKfRTwcJdCnl2YDxWmF/yU=;
 b=SWthx0TsMR5BCNnclKqamiAg7fhLk0jy1/RrM6NDS6mHoc3Z/879JTJED3g8Ok1DpbC0MK
 m8PdnNmzgixQSBdzfLcwQRM7vG2uGD1ILkuuPTatHgBK/MhQxMtAhp3iOVDx0OLzTxz9E6
 oI8aSaU6wCUa5DPu46j1+dzPOh817I4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-ZJF9o_dGOtCAlg91V72sFw-1; Fri, 30 May 2025 03:15:18 -0400
X-MC-Unique: ZJF9o_dGOtCAlg91V72sFw-1
X-Mimecast-MFC-AGG-ID: ZJF9o_dGOtCAlg91V72sFw_1748589317
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad56c5412f2so150224866b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589316; x=1749194116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Orjcr0WOSg/rpO4DfKUDnvKfRTwcJdCnl2YDxWmF/yU=;
 b=ayFK9kwB0/REAk5BxFVue7GT+/mQ7D3+ERu8q1pHG7yW/WlZ/F1HHZux+aOpjCV+NA
 aph21tyKgefQxZqm637YnmiW8wOyvfPfl5/Pgf42lmzvk4fFJKNcT0TZ5wZFdAUBDEtU
 0y81nqQ5wkFYN7xN7sSsUs59kJ6++qSDDPDmks2CogyVBOS+YwUoZ96+WKwsIEaF7zBG
 Mwe0AnYYXCVM+C1v6g6LtpzmPj1xTDgvRUANuWOTG25m5jZFuHeIyU5y/mMn74/9a/Za
 /iwc+WHKh+i8Bq+qa+dT+X6j2wXWPWOC/bWQ3y/NmNLyH/ANphZ66efe17bP8T0XmtVJ
 jR3g==
X-Gm-Message-State: AOJu0Yx/fBccQGbAz9BaPs8ZFM2qSHubOEyBL4VXXc90yKWGj6sDAq2m
 6e6BBkbfyGq+r7HDAnISekBxzTTY1WnVLk1tW4NfhbSZBkq7H7ddC3aAhP+t2BbDOGeVsY9Gl61
 gCbjJ+qHpRa+yMmYSp5LMYwY6tjR3r1QV5c7SMJivR3rE620KpCfRB90YTssyTKacZclNgwx7eN
 qscxDtPohxg8iraVBo6K+R1Y5e8Grlu6UIr2VZeBsc
X-Gm-Gg: ASbGncs3qDAVIArtRDz2y/stO9zN7m52yJsX00E6LZN9GeUaAlJZhwmFxCiNPx/Mzwu
 RsUA7sji8CODLAtBzKE7gIRKOJv2cCxtGHf9q4pErweIYaznp0CSaNBco7IOMASPY88rbcg1MwT
 uEzCTHRdUkJLbaWL/RZdGbF88hgSEVhv5hMIDTEf1xBIk2NVHneGw/JRbiw5sFfuceaGp7IOVfv
 uXckDcY1yXpWlyY0939ygpeIsFtYEEJa/QYT7Orx+kMt94MTzj+skzH6vGtmeRGr0jdRXBa3ZVT
 BhIFpHKSYACh7g==
X-Received: by 2002:a17:907:7e8e:b0:ad2:425c:27ce with SMTP id
 a640c23a62f3a-adb36b2330fmr104851566b.2.1748589315684; 
 Fri, 30 May 2025 00:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHySeQKmrF/Fw22foAa2vg8INyuym5CyrS5Jf8pYpahvAL5IkS6hcZ7LLue3tY+34WTJzgMTw==
X-Received: by 2002:a17:907:7e8e:b0:ad2:425c:27ce with SMTP id
 a640c23a62f3a-adb36b2330fmr104848566b.2.1748589315163; 
 Fri, 30 May 2025 00:15:15 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6ac07sm278332366b.177.2025.05.30.00.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 57/77] i386/tdx: Add TDX fixed1 bits to supported CPUIDs
Date: Fri, 30 May 2025 09:12:27 +0200
Message-ID: <20250530071250.2050910-58-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

TDX architecture forcibly sets some CPUID bits for TD guest that VMM
cannot disable it. They are fixed1 bits.

Fixed1 bits are not covered by tdx_caps.cpuid (which only contains the
directly configurable bits), while fixed1 bits are supported for TD guest
obviously.

Add fixed1 bits to tdx_supported_cpuid. Besides, set all the fixed1
bits to the initial set of KVM's support since KVM might not report them
as supported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-46-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h          |   2 +
 target/i386/kvm/kvm_i386.h |   7 ++
 target/i386/kvm/tdx.c      | 134 +++++++++++++++++++++++++++++++++++++
 target/i386/sev.c          |   8 ---
 4 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7ffcf91b014..342e4f2a572 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -920,6 +920,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EDX_FSRM              (1U << 4)
 /* AVX512 Vector Pair Intersection to a Pair of Mask Registers */
 #define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
+ /* "md_clear" VERW clears CPU buffers */
+#define CPUID_7_0_EDX_MD_CLEAR          (1U << 10)
 /* SERIALIZE instruction */
 #define CPUID_7_0_EDX_SERIALIZE         (1U << 14)
 /* TSX Suspend Load Address Tracking instruction */
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 484a1de84d5..5f83e8850a2 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -44,6 +44,13 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
 
 #ifdef CONFIG_KVM
 
+#include <linux/kvm.h>
+
+typedef struct KvmCpuidInfo {
+    struct kvm_cpuid2 cpuid;
+    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
+} KvmCpuidInfo;
+
 bool kvm_is_vm_type_supported(int type);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e3b7ad6d146..9d92ff1484b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -367,6 +367,133 @@ static Notifier tdx_machine_done_notify = {
     .notify = tdx_finalize_vm,
 };
 
+/*
+ * Some CPUID bits change from fixed1 to configurable bits when TDX module
+ * supports TDX_FEATURES0.VE_REDUCTION. e.g., MCA/MCE/MTRR/CORE_CAPABILITY.
+ *
+ * To make QEMU work with all the versions of TDX module, keep the fixed1 bits
+ * here if they are ever fixed1 bits in any of the version though not fixed1 in
+ * the latest version. Otherwise, with the older version of TDX module, QEMU may
+ * treat the fixed1 bit as unsupported.
+ *
+ * For newer TDX module, it does no harm to keep them in tdx_fixed1_bits even
+ * though they changed to configurable bits. Because tdx_fixed1_bits is used to
+ * setup the supported bits.
+ */
+KvmCpuidInfo tdx_fixed1_bits = {
+    .cpuid.nent = 8,
+    .entries[0] = {
+        .function = 0x1,
+        .index = 0,
+        .ecx = CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_DTES64 |
+               CPUID_EXT_DSCPL | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 |
+               CPUID_EXT_PDCM | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+               CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+               CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
+               CPUID_EXT_RDRAND | CPUID_EXT_HYPERVISOR,
+        .edx = CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+               CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+               CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+               CPUID_PAT | CPUID_CLFLUSH | CPUID_DTS | CPUID_MMX | CPUID_FXSR |
+               CPUID_SSE | CPUID_SSE2,
+    },
+    .entries[1] = {
+        .function = 0x6,
+        .index = 0,
+        .eax = CPUID_6_EAX_ARAT,
+    },
+    .entries[2] = {
+        .function = 0x7,
+        .index = 0,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .ebx = CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_FDP_EXCPTN_ONLY |
+               CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_INVPCID |
+               CPUID_7_0_EBX_ZERO_FCS_FDS | CPUID_7_0_EBX_RDSEED |
+               CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+               CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_SHA_NI,
+        .ecx = CPUID_7_0_ECX_BUS_LOCK_DETECT | CPUID_7_0_ECX_MOVDIRI |
+               CPUID_7_0_ECX_MOVDIR64B,
+        .edx = CPUID_7_0_EDX_MD_CLEAR | CPUID_7_0_EDX_SPEC_CTRL |
+               CPUID_7_0_EDX_STIBP | CPUID_7_0_EDX_FLUSH_L1D |
+               CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_CORE_CAPABILITY |
+               CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+    },
+    .entries[3] = {
+        .function = 0x7,
+        .index = 2,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .edx = CPUID_7_2_EDX_PSFD | CPUID_7_2_EDX_IPRED_CTRL |
+               CPUID_7_2_EDX_RRSBA_CTRL | CPUID_7_2_EDX_BHI_CTRL,
+    },
+    .entries[4] = {
+        .function = 0xD,
+        .index = 0,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .eax = XSTATE_FP_MASK | XSTATE_SSE_MASK,
+    },
+    .entries[5] = {
+        .function = 0xD,
+        .index = 1,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .eax = CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC|
+               CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+    },
+    .entries[6] = {
+        .function = 0x80000001,
+        .index = 0,
+        .ecx = CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        /*
+         * Strictly speaking, SYSCALL is not fixed1 bit since it depends on
+         * the CPU to be in 64-bit mode. But here fixed1 is used to serve the
+         * purpose of supported bits for TDX. In this sense, SYACALL is always
+         * supported.
+         */
+        .edx = CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+               CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+    },
+    .entries[7] = {
+        .function = 0x80000007,
+        .index = 0,
+        .edx = CPUID_APM_INVTSC,
+    },
+};
+
+static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
+                                                        uint32_t index)
+{
+    struct kvm_cpuid_entry2 *e;
+
+    e = cpuid_find_entry(tdx_supported_cpuid, function, index);
+    if (!e) {
+        if (tdx_supported_cpuid->nent >= KVM_MAX_CPUID_ENTRIES) {
+            error_report("tdx_supported_cpuid requries more space than %d entries",
+                          KVM_MAX_CPUID_ENTRIES);
+            exit(1);
+        }
+        e = &tdx_supported_cpuid->entries[tdx_supported_cpuid->nent++];
+        e->function = function;
+        e->index = index;
+    }
+
+    return e;
+}
+
+static void tdx_add_supported_cpuid_by_fixed1_bits(void)
+{
+    struct kvm_cpuid_entry2 *e, *e1;
+    int i;
+
+    for (i = 0; i < tdx_fixed1_bits.cpuid.nent; i++) {
+        e = &tdx_fixed1_bits.entries[i];
+
+        e1 = find_in_supported_entry(e->function, e->index);
+        e1->eax |= e->eax;
+        e1->ebx |= e->ebx;
+        e1->ecx |= e->ecx;
+        e1->edx |= e->edx;
+    }
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -379,6 +506,8 @@ static void tdx_setup_supported_cpuid(void)
     memcpy(tdx_supported_cpuid->entries, tdx_caps->cpuid.entries,
            tdx_caps->cpuid.nent * sizeof(struct kvm_cpuid_entry2));
     tdx_supported_cpuid->nent = tdx_caps->cpuid.nent;
+
+    tdx_add_supported_cpuid_by_fixed1_bits();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
@@ -463,6 +592,11 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
 {
     struct kvm_cpuid_entry2 *e;
 
+    e = cpuid_find_entry(&tdx_fixed1_bits.cpuid, feature, index);
+    if (e) {
+        value |= cpuid_entry_get_reg(e, reg);
+    }
+
     if (is_feature_word_cpuid(feature, index, reg)) {
         e = cpuid_find_entry(tdx_supported_cpuid, feature, index);
         if (e) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 8b87b7cdec3..adf787797e7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -212,14 +212,6 @@ static const char *const sev_fw_errlist[] = {
 
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
 
-/* <linux/kvm.h> doesn't expose this, so re-use the max from kvm.c */
-#define KVM_MAX_CPUID_ENTRIES 100
-
-typedef struct KvmCpuidInfo {
-    struct kvm_cpuid2 cpuid;
-    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
-} KvmCpuidInfo;
-
 #define SNP_CPUID_FUNCTION_MAXCOUNT 64
 #define SNP_CPUID_FUNCTION_UNKNOWN 0xFFFFFFFF
 
-- 
2.49.0


