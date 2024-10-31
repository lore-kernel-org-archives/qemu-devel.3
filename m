Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5DCD767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZMG-0001LA-4n; Thu, 31 Oct 2024 13:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZM4-0000b2-FI
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZM2-0007Mw-K9
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlTNwfMj7hGCg59mSHIfPfGyST8jSaHvHWyfrTkr92c=;
 b=GVK7dfx/jqfVP3+cpBNRD9YA9/TJb700WZX6wTMqkHFMmT0pchDis0BKYvBIudHhWIvQIa
 DrC3zyt9aouwJawg0IxHEIYgQyHDD3xM4kzeIvG59VJ+wl2GkU69mJg80fRMY5cS8tK45T
 pXnjjF611OP46I490o5BH/Np++HyxYA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-AaHSZChUPxWpA9873HebUw-1; Thu, 31 Oct 2024 13:53:03 -0400
X-MC-Unique: AaHSZChUPxWpA9873HebUw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso7564085e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397182; x=1731001982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlTNwfMj7hGCg59mSHIfPfGyST8jSaHvHWyfrTkr92c=;
 b=ILI2EdnjwKCL+p6hfwgPdJ5S2s+FTXOkYX/9d4rgaf9YDsDJAENIjXwaHUz2y6Nnyo
 hKCZ2Zuo4EqR1UI/u1RVMxYrVbSeMfd/9EK2vr8hDz+uwzI4jM2VoBoSr5xZayQKpeMO
 oVSM6ZTRamV5ApbhoUOQKZ1M5WwCS7b6oQApoVG1ZracRMtGFyuvUgj9jwVewGMgQ5eG
 pCbMCeEsIRp99LCKvC3Nx9Lxf37zTLRn3pmSyjysdP76pb50QS3VulTvZFvrMDRkBLRa
 AdD6A9gK3W5P2+GKMBw7i68aejri5k5fFRrX9GHzF6HDnpjCdobCGMRgtmtDWy7Jyvgy
 WJ1g==
X-Gm-Message-State: AOJu0Yx18jhGdLiJhIMM9c8eS/2ZbnYIeVAcm83vjaWg6TpVL5q8nCFa
 5RovtxHVHCuYQCD0m0veTKUuSCpra8ZPPaMBFBugU6neRFdM9ntxj2qj+ICGO15pLHKWlnnhcTb
 uTLlYLlB47m1hYWegfWyFAB4fQNqFe2nhX+00dZ6ehFCShB+paYu2tGylH+l++cZyxtFjRlHndi
 x6MvFtFHOC7UnL+uHfjwmRObycXDA3ZjX+9TiKm10=
X-Received: by 2002:a05:6000:788:b0:37d:4cee:55b with SMTP id
 ffacd0b85a97d-381c7ae3095mr702888f8f.59.1730397180534; 
 Thu, 31 Oct 2024 10:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Pa9ZFgr44qMJdHH0v4uIFIeKZL5PtcARu06rIu4A2JKhdJEBlGOSSjNrINcqI8TEdLC72g==
X-Received: by 2002:a05:6000:788:b0:37d:4cee:55b with SMTP id
 ffacd0b85a97d-381c7ae3095mr702825f8f.59.1730397178611; 
 Thu, 31 Oct 2024 10:52:58 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e595sm2797733f8f.77.2024.10.31.10.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>
Subject: [PULL 19/49] target/i386: Expose new feature bits in CPUID
 8000_0021_EAX/EBX
Date: Thu, 31 Oct 2024 18:51:43 +0100
Message-ID: <20241031175214.214455-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Babu Moger <babu.moger@amd.com>

Newer AMD CPUs support ERAPS (Enhanced Return Address Prediction Security)
feature that enables the auto-clear of RSB entries on a TLB flush, context
switches and VMEXITs. The number of default RSP entries is reflected in
RapSize.

Add the feature bit and feature word to support these features.

CPUID_Fn80000021_EAX
Bits   Feature Description
24     ERAPS:
       Indicates support for enhanced return address predictor security.

CPUID_Fn80000021_EBX
Bits   Feature Description
31-24  Reserved
23:16  RapSize:
       Return Address Predictor size. RapSize x 8 is the minimum number
       of CALL instructions software needs to execute to flush the RAP.
15-00  MicrocodePatchSize. Read-only.
       Reports the size of the Microcode patch in 16-byte multiples.
       If 0, the size of the patch is at most 5568 (15C0h) bytes.

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/7c62371fe60af1e9bbd853f5f8e949bf2d908bd0.1729807947.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  9 +++++++++
 target/i386/cpu.c | 11 +++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 792518b62d4..e2e10f55b2e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -634,6 +634,7 @@ typedef enum FeatureWord {
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
+    FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
     FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
@@ -1022,6 +1023,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
+/* Enhanced Return Address Predictor Scurity */
+#define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
 /* Selective Branch Predictor Barrier */
 #define CPUID_8000_0021_EAX_SBPB                         (1U << 27)
 /* IBPB includes branch type prediction flushing */
@@ -1031,6 +1034,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Not vulnerable to SRSO at the user-kernel boundary */
 #define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
 
+/*
+ * Return Address Predictor size. RapSize x 8 is the minimum number of
+ * CALL instructions software needs to execute to flush the RAP.
+ */
+#define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
+
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8d4d3d9e3d5..5886b44fcf7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1220,13 +1220,19 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, "sbpb",
+            "eraps", NULL, NULL, "sbpb",
             "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
+    [FEAT_8000_0021_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = { .eax = 0x80000021, .reg = R_EBX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -7069,8 +7075,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     case 0x80000021:
+        *eax = *ebx = *ecx = *edx = 0;
         *eax = env->features[FEAT_8000_0021_EAX];
-        *ebx = *ecx = *edx = 0;
+        *ebx = env->features[FEAT_8000_0021_EBX];
         break;
     default:
         /* reserved values: zero */
-- 
2.47.0


