Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32488C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGG4-0007Jd-Gi; Fri, 24 Jan 2025 04:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFi-0006tg-Cb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFg-0003tc-44
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dR2kSe8qSzBAA1k+EbyVgJaxWbRgwHrntpYjIEWk2M8=;
 b=hSBgcEr7NS2MROivZwopDLhjB+G6iexx7LxDUX/iwc9U06DwlVHl8utLtvWpmgaa5mUmC2
 bKhN4BJ8djsP1EnRlQ37gT9CHrxVsiQS07VrvgEMEpL2G7GUHQFdMJ8z7yeGeQX2LUL0/t
 CWDUxE/LZtsRn6Oli9JsqyVUER1SrO0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-HwUsQbZDNqSWk3sSsq0nAQ-1; Fri, 24 Jan 2025 04:45:21 -0500
X-MC-Unique: HwUsQbZDNqSWk3sSsq0nAQ-1
X-Mimecast-MFC-AGG-ID: HwUsQbZDNqSWk3sSsq0nAQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so10299155e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711920; x=1738316720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dR2kSe8qSzBAA1k+EbyVgJaxWbRgwHrntpYjIEWk2M8=;
 b=bnrJmEAfBr0G9dJMWH5Hyu0kRFYe76kg18WuKEx/xKHoBC0RIyz21RsUiyrHH9/vTd
 b0zzwzVzrhhRHlyi4ao9UkdHgQExu9482u8qOceViH9ukhdDDCF1rMlqrr4DzgZeM7jo
 azdm7Ja2weJlL4zqCykNEplDqCXjEcsFsis96kBfpWJCNArJ9IT+mF+9XxrYl4c8VyNO
 cluxfgUtTVOQCTd+C1sL3yxJaqlsBTG7ocfCYK5JOc9g69yPOqnAZ+eZzY5B40U5Z3Xk
 r5XR0tu6V6vHM+2jj6A/rCWX4TjlNc/1vIUrQjzlzslfnIOwI9I0BIVUWnB/OTmU+BVU
 TgSA==
X-Gm-Message-State: AOJu0YyCFmpH/COEtQ8D0cN3sDTq16IRI5hsZfdshh59QNcgldRk+GzL
 FFyJnZkck6079JljXRH+jNHpjsoWvbK82NVdrPeslelJaXIce503ibPGp9hVWD2PNHUQfHAwTVC
 50dN0I7c/5fCI6YgiMH/dQJWXqfR48crxtyFH50UrbiFbtDcl+M+fE/ydxS4/KjwO6I9oXGsBKj
 lTD675wGHyxei5woLvLvopUJlcWXomba8qRlpcd7E=
X-Gm-Gg: ASbGncvnBisJT/n0Eg18iOP2OW3jV5tAUueV49FkzHPJ2V0/IOMYUGY3Xv0psBqpPty
 qLzeY2Gj+TxtiKW3C3QTCPThpKXuhWhg2N/Exj3qZvqZgh0KeTbwLxQqa3TsWmNOJBncSnMaQzf
 Niw2tklDtVf2ZnJOsl/6FUEOq/uTQ5A6vXH5BRDQwqF9SXT5h++B3t6faCBiNNpuzCpE3+Nztr4
 ZflKVeeLWVIo1sPICxILtXiPlwfOAlhXerxClGWAERbiKzwmabEyMQ3HOD2aQbtDutWMFxl8A==
X-Received: by 2002:a05:600c:1d28:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-43891434081mr255515105e9.22.1737711918569; 
 Fri, 24 Jan 2025 01:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVUZtJTUAd28zMu2hoLbJm75jEGtRAUOLZwB1c5UmpT3xGeiCBZ659EwmCtBrzAqwgFrbQAw==
X-Received: by 2002:a05:600c:1d28:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-43891434081mr255514835e9.22.1737711917994; 
 Fri, 24 Jan 2025 01:45:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9984sm20388465e9.28.2025.01.24.01.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 18/48] target/i386: Add new CPU model ClearwaterForest
Date: Fri, 24 Jan 2025 10:44:12 +0100
Message-ID: <20250124094442.13207-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

From: Tao Su <tao1.su@linux.intel.com>

According to table 1-2 in Intel Architecture Instruction Set Extensions
and Future Features (rev 056) [1], ClearwaterForest has the following new
features which have already been virtualized:

    - AVX-VNNI-INT16 CPUID.(EAX=7,ECX=1):EDX[bit 10]
    - SHA512 CPUID.(EAX=7,ECX=1):EAX[bit 0]
    - SM3 CPUID.(EAX=7,ECX=1):EAX[bit 1]
    - SM4 CPUID.(EAX=7,ECX=1):EAX[bit 2]

Add above features to new CPU model ClearwaterForest. Comparing with
SierraForest, ClearwaterForest bare-metal contains all features of
SierraForest-v2 CPU model and adds:

    - PREFETCHI CPUID.(EAX=7,ECX=1):EDX[bit 14]
    - DDPD_U CPUID.(EAX=7,ECX=2):EDX[bit 3]
    - BHI_NO IA32_ARCH_CAPABILITIES[bit 20]

Add above and all features of SierraForest-v2 CPU model to new CPU model
ClearwaterForest.

[1] https://cdrdv2.intel.com/v1/dl/getContent/671368

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121020650.1899618-4-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  33 +++++++++---
 target/i386/cpu.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b26e25ba15e..c67b42d34fc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -951,6 +951,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Speculative Store Bypass Disable */
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD    (1U << 31)
 
+/* SHA512 Instruction */
+#define CPUID_7_1_EAX_SHA512            (1U << 0)
+/* SM3 Instruction */
+#define CPUID_7_1_EAX_SM3               (1U << 1)
+/* SM4 Instruction */
+#define CPUID_7_1_EAX_SM4               (1U << 2)
 /* AVX VNNI Instruction */
 #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
 /* AVX512 BFloat16 Instruction */
@@ -963,6 +969,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EAX_FSRS              (1U << 11)
 /* Fast Short REP CMPS/SCAS */
 #define CPUID_7_1_EAX_FSRC              (1U << 12)
+/* Flexible return and event delivery (FRED) */
+#define CPUID_7_1_EAX_FRED              (1U << 17)
+/* Load into IA32_KERNEL_GS_BASE (LKGS) */
+#define CPUID_7_1_EAX_LKGS              (1U << 18)
+/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
+#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
 /* Support Tile Computational Operations on FP16 Numbers */
 #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
 /* Support for VPMADD52[H,L]UQ */
@@ -976,17 +988,23 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EDX_AVX_NE_CONVERT    (1U << 5)
 /* AMX COMPLEX Instructions */
 #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
+/* AVX-VNNI-INT16 Instructions */
+#define CPUID_7_1_EDX_AVX_VNNI_INT16    (1U << 10)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
 /* Support for Advanced Vector Extensions 10 */
 #define CPUID_7_1_EDX_AVX10             (1U << 19)
-/* Flexible return and event delivery (FRED) */
-#define CPUID_7_1_EAX_FRED              (1U << 17)
-/* Load into IA32_KERNEL_GS_BASE (LKGS) */
-#define CPUID_7_1_EAX_LKGS              (1U << 18)
-/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
-#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
 
+/* Indicate bit 7 of the IA32_SPEC_CTRL MSR is supported */
+#define CPUID_7_2_EDX_PSFD              (1U << 0)
+/* Indicate bits 3 and 4 of the IA32_SPEC_CTRL MSR are supported */
+#define CPUID_7_2_EDX_IPRED_CTRL        (1U << 1)
+/* Indicate bits 5 and 6 of the IA32_SPEC_CTRL MSR are supported */
+#define CPUID_7_2_EDX_RRSBA_CTRL        (1U << 2)
+/* Indicate bit 8 of the IA32_SPEC_CTRL MSR is supported */
+#define CPUID_7_2_EDX_DDPD_U            (1U << 3)
+/* Indicate bit 10 of the IA32_SPEC_CTRL MSR is supported */
+#define CPUID_7_2_EDX_BHI_CTRL          (1U << 4)
 /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
 #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
 
@@ -1144,7 +1162,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define MSR_ARCH_CAP_FBSDP_NO           (1U << 14)
 #define MSR_ARCH_CAP_PSDP_NO            (1U << 15)
 #define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
+#define MSR_ARCH_CAP_BHI_NO             (1U << 20)
 #define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
+#define MSR_ARCH_CAP_GDS_NO             (1U << 26)
+#define MSR_ARCH_CAP_RFDS_NO            (1U << 27)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33fb27a6119..b5dd60d2812 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4571,6 +4571,141 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ },
         },
     },
+    {
+        .name = "ClearwaterForest",
+        .level = 0x23,
+        .xlevel = 0x80000008,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 221,
+        .stepping = 0,
+        /*
+         * please keep the ascending order so that we can have a clear view of
+         * bit position of each feature.
+         */
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2 | CPUID_SS,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
+            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_TSC_ADJUST |
+            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
+            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT |
+            CPUID_7_0_ECX_CLDEMOTE | CPUID_7_0_ECX_MOVDIRI |
+            CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_SERIALIZE |
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
+            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_SBDR_SSDP_NO |
+            MSR_ARCH_CAP_FBSDP_NO | MSR_ARCH_CAP_PSDP_NO |
+            MSR_ARCH_CAP_BHI_NO | MSR_ARCH_CAP_PBRSB_NO |
+            MSR_ARCH_CAP_GDS_NO | MSR_ARCH_CAP_RFDS_NO,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_SHA512 | CPUID_7_1_EAX_SM3 | CPUID_7_1_EAX_SM4 |
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_CMPCCXADD |
+            CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_AVX_IFMA |
+            CPUID_7_1_EAX_LAM,
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT |
+            CPUID_7_1_EDX_AVX_VNNI_INT16 | CPUID_7_1_EDX_PREFETCHITI,
+        .features[FEAT_7_2_EDX] =
+            CPUID_7_2_EDX_PSFD | CPUID_7_2_EDX_IPRED_CTRL |
+            CPUID_7_2_EDX_RRSBA_CTRL | CPUID_7_2_EDX_DDPD_U |
+            CPUID_7_2_EDX_BHI_CTRL | CPUID_7_2_EDX_MCDT_NO,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY | MSR_VMX_EPT_PAGE_WALK_LENGTH_4 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
+            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+            VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
+            VMX_SECONDARY_EXEC_XSAVES,
+        .features[FEAT_VMX_VMFUNC] =
+            MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .model_id = "Intel Xeon Processor (ClearwaterForest)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { /* end of list */ },
+        },
+    },
     {
         .name = "Denverton",
         .level = 21,
-- 
2.48.1


