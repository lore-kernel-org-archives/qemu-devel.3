Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1DDC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLp2-0007B0-8p; Tue, 06 Feb 2024 08:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLoz-0007Ae-Gy
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLox-0004Ix-Hz
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707227346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjoZ7m+yeFmajbjArflrTUEg5Mjxs+tXJcD90IMO0Hs=;
 b=WaDlyYfrOtGV1Qy0guU383yTUtYA3/asxF6C+7RrS+vr3a+sRjh63mkNUkS/WjJoTCQM/u
 sW2nqUoZQx2K6bccaS3/tch4sNp0MoJBlrEMTlMlVOTn/ijS4GpgZSK7/c6J2A6ErFNgxG
 u4z857cmGgQansSAMK9nF7fom4LYqaw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-tdW4ymayNiuqGklfqp6swA-1; Tue, 06 Feb 2024 08:47:46 -0500
X-MC-Unique: tdW4ymayNiuqGklfqp6swA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DDC785A589;
 Tue,  6 Feb 2024 13:47:46 +0000 (UTC)
Received: from work.fritz.box (unknown [10.39.195.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D8C62026D06;
 Tue,  6 Feb 2024 13:47:45 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v3 4/5] target/i386: Fix feature_word_info.c.inc formatting
Date: Tue,  6 Feb 2024 14:47:38 +0100
Message-ID: <20240206134739.15345-5-twiederh@redhat.com>
In-Reply-To: <20240206134739.15345-1-twiederh@redhat.com>
References: <20240206134739.15345-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Make the formatting of the file more regular. This reduces the
diff to the generated version.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/feature_word_info.c.inc | 136 ++++++++++++++++++----------
 1 file changed, 86 insertions(+), 50 deletions(-)

diff --git a/target/i386/feature_word_info.c.inc b/target/i386/feature_word_info.c.inc
index 152d4b45a9..4beae01918 100644
--- a/target/i386/feature_word_info.c.inc
+++ b/target/i386/feature_word_info.c.inc
@@ -11,7 +11,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fxsr", "sse", "sse2", "ss",
             "ht", "tm", "ia64", "pbe",
         },
-        .cpuid = {.eax = 1, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 1,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_FEATURES,
         .no_autoenable_flags = CPUID_HT,
     },
@@ -27,7 +30,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "tsc-deadline", "aes", "xsave", NULL,
             "avx", "f16c", "rdrand", "hypervisor",
         },
-        .cpuid = { .eax = 1, .reg = R_ECX, },
+        .cpuid = {
+            .eax = 1,
+            .reg = R_ECX,
+        },
         .tcg_features = TCG_EXT_FEATURES,
     },
     [FEAT_8000_0001_EDX] = {
@@ -42,7 +48,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "fxsr-opt", "pdpe1gb", "rdtscp",
             NULL, "lm", "3dnowext", "3dnow",
         },
-        .cpuid = { .eax = 0x80000001, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x80000001,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_EXT2_FEATURES,
     },
     [FEAT_8000_0001_ECX] = {
@@ -57,7 +66,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "perfctr-nb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000001, .reg = R_ECX, },
+        .cpuid = {
+            .eax = 0x80000001,
+            .reg = R_ECX,
+        },
         .tcg_features = TCG_EXT3_FEATURES,
         .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
     },
@@ -73,7 +85,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0xC0000001, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0xC0000001,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_EXT4_FEATURES,
     },
     [FEAT_KVM] = {
@@ -88,7 +103,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock-stable-bit", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EAX, },
+        .cpuid = {
+            .eax = KVM_CPUID_FEATURES,
+            .reg = R_EAX,
+        },
         .tcg_features = TCG_KVM_FEATURES,
     },
     [FEAT_KVM_HINTS] = {
@@ -103,7 +121,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EDX, },
+        .cpuid = {
+            .eax = KVM_CPUID_FEATURES,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_KVM_FEATURES,
         .no_autoenable_flags = ~0U,
     },
@@ -111,7 +132,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "npt", "lbrv", "svm-lock", "nrip-save",
-            "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
+            "tsc-scale", "vmcb-clean", "flushbyasid", "decodeassists",
             NULL, NULL, "pause-filter", NULL,
             "pfthreshold", "avic", NULL, "v-vmsave-vmload",
             "vgif", NULL, NULL, NULL,
@@ -119,7 +140,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vnmi", NULL, NULL,
             "svme-addr-chk", NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x8000000A, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x8000000A,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_SVM_FEATURES,
     },
     [FEAT_7_0_EBX] = {
@@ -136,7 +160,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EBX,
         },
         .tcg_features = TCG_7_0_EBX_FEATURES,
@@ -155,7 +180,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_ECX,
         },
         .tcg_features = TCG_7_0_ECX_FEATURES,
@@ -174,7 +200,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_0_EDX_FEATURES,
@@ -193,7 +220,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_7_1_EAX_FEATURES,
@@ -212,7 +240,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_1_EDX_FEATURES,
@@ -231,7 +260,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 2,
+            .needs_ecx = true,
+            .ecx = 2,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
@@ -248,7 +278,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000007, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x80000007,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_APM_FEATURES,
         .unmigratable_flags = CPUID_APM_INVTSC,
     },
@@ -264,7 +297,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amd-ssbd", "virt-ssbd", "amd-no-ssb", NULL,
             "amd-psfd", NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
+        .cpuid = {
+            .eax = 0x80000008,
+            .reg = R_EBX,
+        },
         .tcg_features = TCG_8000_0008_EBX,
         .unmigratable_flags = 0,
     },
@@ -280,7 +316,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
+        .cpuid = {
+            .eax = 0x80000021,
+            .reg = R_EAX,
+        },
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
@@ -298,7 +337,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0xd,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_XSAVE_FEATURES,
@@ -328,7 +368,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .eax = 0xD,
             .needs_ecx = true,
             .ecx = 1,
-            .reg = R_EDX
+            .reg = R_EDX,
         },
     },
     [FEAT_6_EAX] = {
@@ -343,14 +383,18 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 6, .reg = R_EAX, },
+        .cpuid = {
+            .eax = 6,
+            .reg = R_EAX,
+        },
         .tcg_features = TCG_6_EAX_FEATURES,
     },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
             .eax = 0xD,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EAX,
         },
         .tcg_features = ~0U,
@@ -363,7 +407,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
             .eax = 0xD,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EDX,
         },
         .tcg_features = ~0U,
@@ -417,7 +462,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .index = MSR_IA32_PERF_CAPABILITIES,
         },
     },
-
     [FEAT_VMX_PROCBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -432,9 +476,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_SECONDARY_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -449,9 +492,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_PROCBASED_CTLS2,
-        }
+        },
     },
-
     [FEAT_VMX_PINBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -466,9 +508,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_PINBASED_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_EXIT_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -484,9 +525,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_ENTRY_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -501,9 +541,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_MISC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -518,9 +557,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_MISC,
-        }
+        },
     },
-
     [FEAT_VMX_EPT_VPID_CAPS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -544,9 +582,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_EPT_VPID_CAP,
-        }
+        },
     },
-
     [FEAT_VMX_BASIC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -559,7 +596,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .no_autoenable_flags = MSR_VMX_BASIC_DUAL_MONITOR,
     },
-
     [FEAT_VMX_VMFUNC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -567,9 +603,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_VMFUNC,
-        }
+        },
     },
-
     [FEAT_14_0_ECX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -584,12 +619,12 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x14,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_ECX,
         },
         .tcg_features = TCG_14_0_ECX_FEATURES,
-     },
-
+    },
     [FEAT_SGX_12_0_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -604,16 +639,16 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EAX,
         },
         .tcg_features = TCG_SGX_12_0_EAX_FEATURES,
     },
-
     [FEAT_SGX_12_0_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "sgx-exinfo" , NULL, NULL, NULL,
+            "sgx-exinfo", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -624,12 +659,12 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EBX,
         },
         .tcg_features = TCG_SGX_12_0_EBX_FEATURES,
     },
-
     [FEAT_SGX_12_1_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -644,7 +679,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_SGX_12_1_EAX_FEATURES,
-- 
2.43.0


