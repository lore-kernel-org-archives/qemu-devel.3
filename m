Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39845D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNq-0005Fa-QS; Thu, 31 Oct 2024 13:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMw-0002nI-Gq
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMu-0007Ts-Gk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmjX+ntySS0CilrbXXQh8Bo3C+RynICA//RlzZLRpHQ=;
 b=VG0FF0ENjpyAeSqQFz9bHEOk3uHzs8oeUNIuRupHalsoTXSzL1F69Rk8bBZ2H0oO1qsBmX
 8soS8NDXt10FeSe0yrraKz34i7L9Z9FYmFPUj37x8Mll3x8KK8xtJDYeeZKK2tWovs6R8a
 iEqXJqjZVd3TmJboM0M6RrPoh57MhOU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-aQZoeGrkMYS_z-G7u0-CKw-1; Thu, 31 Oct 2024 13:53:58 -0400
X-MC-Unique: aQZoeGrkMYS_z-G7u0-CKw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so532931f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397236; x=1731002036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LmjX+ntySS0CilrbXXQh8Bo3C+RynICA//RlzZLRpHQ=;
 b=Qrbt7ERNgcUcqgumrkAQjYVJ0b0qY5caQMqYmw56ISl7RB+oqcvCnaEhQlDiX6dY2E
 hnBKaSR9jC66MHp3Rd7fVH1YKz2inlazfXWfB2Cl2I0ZsFwlCsDgNSFSqc9BK3UkLn3k
 a4Jpp9Veb7t3Rk7/SSn7H5rfLk1s0TZU4RbaQ6nyo5cacw79Scgh/+U5JntkhN8NQzh1
 xPXtoWXtJ2uv02tEAaxfPfCa+/vgiC8y0dC5Tl99Ed7S6cuuk0WlLFD9gm7Xnfa1Ge31
 vqUr32Wt5I6cCu3gkDBU/augSFKqlWMl+H3t0LDw/JIuiJ7EwKjstWqbXGoAEh2MnVIT
 oyHw==
X-Gm-Message-State: AOJu0Yxya7Za9TIA7yoAdRjzo+InKCfwJdyOPypr7E/dDaAqNKa8kjjZ
 SMaGv84Hzvzg3ICkv+VYf8lN/tVNBEpzbD2Bh61zEK62lhjQy8JJfCPfoN8/TfWt5uVhn4C1Xo/
 h0cCPxqQolWlgSqh2guRWukGfKasm4cLBUzsMOmdKsitkUDaKyOjW46gfD5c4SMzv6LMfQvMqXe
 c0VyFagO4Wg1fxAJp++ZwMcnRaJVW5bQja7getRbY=
X-Received: by 2002:a5d:6c68:0:b0:374:af19:7992 with SMTP id
 ffacd0b85a97d-381c7a47487mr574320f8f.7.1730397236165; 
 Thu, 31 Oct 2024 10:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLb5ZXDEms0QYjiDXYksyFCGmhoHrTcFchyGIo/v97pGnecM0bCjAku2Gg13ayPpYsFNW7eQ==
X-Received: by 2002:a5d:6c68:0:b0:374:af19:7992 with SMTP id
 ffacd0b85a97d-381c7a47487mr574304f8f.7.1730397235614; 
 Thu, 31 Oct 2024 10:53:55 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c1189118sm2771623f8f.116.2024.10.31.10.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>,
	Xuelian Guo <xuelian.guo@intel.com>
Subject: [PULL 45/49] target/i386: add AVX10 feature and AVX10 version property
Date: Thu, 31 Oct 2024 18:52:09 +0100
Message-ID: <20241031175214.214455-46-pbonzini@redhat.com>
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

From: Tao Su <tao1.su@linux.intel.com>

When AVX10 enable bit is set, the 0x24 leaf will be present as "AVX10
Converged Vector ISA leaf" containing fields for the version number and
the supported vector bit lengths.

Introduce avx10-version property so that avx10 version can be controlled
by user and cpu model. Per spec, avx10 version can never be 0, the default
value of avx10-version is set to 0 to determine whether it is specified by
user.  The default can come from the device model or, for the max model,
from KVM's reported value.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Link: https://lore.kernel.org/r/20241031085233.425388-5-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  4 +++
 target/i386/cpu.c     | 64 ++++++++++++++++++++++++++++++++++++++-----
 target/i386/kvm/kvm.c |  3 +-
 3 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a0a122cb5bf..72e98b25114 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -975,6 +975,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
+/* Support for Advanced Vector Extensions 10 */
+#define CPUID_7_1_EDX_AVX10             (1U << 19)
 /* Flexible return and event delivery (FRED) */
 #define CPUID_7_1_EAX_FRED              (1U << 17)
 /* Load into IA32_KERNEL_GS_BASE (LKGS) */
@@ -1954,6 +1956,8 @@ typedef struct CPUArchState {
     uint32_t cpuid_vendor3;
     uint32_t cpuid_version;
     FeatureWordArray features;
+    /* AVX10 version */
+    uint8_t avx10_version;
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fefdaa423..681c04e056e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -46,6 +46,9 @@
 #include "cpu-internal.h"
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
+static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
+                                        uint32_t *eax, uint32_t *ebx,
+                                        uint32_t *ecx, uint32_t *edx);
 
 /* Helpers for building CPUID[2] descriptors: */
 
@@ -1132,7 +1135,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
             "amx-complex", NULL, "avx-vnni-int16", NULL,
             NULL, NULL, "prefetchiti", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "avx10",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1989,6 +1992,7 @@ typedef struct X86CPUDefinition {
     int family;
     int model;
     int stepping;
+    uint8_t avx10_version;
     FeatureWordArray features;
     const char *model_id;
     const CPUCaches *const cache_info;
@@ -6331,6 +6335,9 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
      */
     object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
 
+    object_property_set_uint(OBJECT(cpu), "avx10-version", def->avx10_version,
+                             &error_abort);
+
     x86_cpu_apply_version_props(cpu, model);
 
     /*
@@ -6859,6 +6866,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x24: {
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
+            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+        }
+        break;
+    }
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
@@ -7450,6 +7467,12 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
                 ~env->user_features[w] &
                 ~feature_word_info[w].no_autoenable_flags;
         }
+
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
+            uint32_t eax, ebx, ecx, edx;
+            x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+            env->avx10_version = ebx & 0xff;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
@@ -7513,6 +7536,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
 
+        /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
+        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
+        }
+
         /* SVM requires CPUID[0x8000000A] */
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
@@ -7563,6 +7591,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     CPUX86State *env = &cpu->env;
     FeatureWord w;
     const char *prefix = NULL;
+    bool have_filtered_features;
+
+    uint32_t eax_0, ebx_0, ecx_0, edx_0;
+    uint32_t eax_1, ebx_1, ecx_1, edx_1;
 
     if (verbose) {
         prefix = accel_uses_host_cpuid()
@@ -7584,13 +7616,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
      */
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
         kvm_enabled()) {
-        uint32_t eax_0, ebx_0, ecx_0, edx_0_unused;
-        uint32_t eax_1, ebx_1, ecx_1_unused, edx_1_unused;
-
         x86_cpu_get_supported_cpuid(0x14, 0,
-                                    &eax_0, &ebx_0, &ecx_0, &edx_0_unused);
+                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
         x86_cpu_get_supported_cpuid(0x14, 1,
-                                    &eax_1, &ebx_1, &ecx_1_unused, &edx_1_unused);
+                                    &eax_1, &ebx_1, &ecx_1, &edx_1);
 
         if (!eax_0 ||
            ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX) ||
@@ -7611,7 +7640,27 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         }
     }
 
-    return x86_cpu_have_filtered_features(cpu);
+    have_filtered_features = x86_cpu_have_filtered_features(cpu);
+
+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+        x86_cpu_get_supported_cpuid(0x24, 0,
+                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
+        uint8_t version = ebx_0 & 0xff;
+
+        if (version < env->avx10_version) {
+            if (prefix) {
+                warn_report("%s: avx10.%d. Adjust to avx10.%d",
+                            prefix, env->avx10_version, version);
+            }
+            env->avx10_version = version;
+            have_filtered_features = true;
+        }
+    } else if (env->avx10_version && prefix) {
+        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        have_filtered_features = true;
+    }
+
+    return have_filtered_features;
 }
 
 static void x86_cpu_hyperv_realize(X86CPU *cpu)
@@ -8395,6 +8444,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
     DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
+    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fd9f1988920..8e17942c3ba 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1923,7 +1923,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
         case 0x7:
         case 0x14:
         case 0x1d:
-        case 0x1e: {
+        case 0x1e:
+        case 0x24: {
             uint32_t times;
 
             c->function = i;
-- 
2.47.0


