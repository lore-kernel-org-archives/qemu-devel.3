Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EEDC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEV-0007sP-Lf; Mon, 14 Jul 2025 07:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1B-0001oe-Jd
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH17-00028r-EB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWO6IlOasxNuKX/Bs+0ihYURBpNqqPnwPBbIYO1DTE0=;
 b=AJaXgrigPD6wbZbgmKkFzzOqPkTNsgdG3FlCab+kyqda9+V/sUMXtHXdf691pvSL4+y8KN
 ryBawPJ8jyQjImcougEyfCrO0VOueucG/JZ4eqkAyDxOjds+d9WPVLAwJEZo8KgUUtGBOW
 nvtbga07bnFlDKYFsHVIxOAkwxDs3Kg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-I2QByDFZMdinu3N8NeCj_A-1; Mon, 14 Jul 2025 07:06:39 -0400
X-MC-Unique: I2QByDFZMdinu3N8NeCj_A-1
X-Mimecast-MFC-AGG-ID: I2QByDFZMdinu3N8NeCj_A_1752491198
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so24022505e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491197; x=1753095997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWO6IlOasxNuKX/Bs+0ihYURBpNqqPnwPBbIYO1DTE0=;
 b=c1qaBlUX2Iw9WPtPVFSIx7cy27LkAtpdAn2NzbXcr4Ypa+GH5OclEi3k3SI1TbE+gu
 rYQJb6mvlgjQnxSAfXjYNV8hi1Gu9fLL6ydRZeDsdfrJd5Mhm9GzXKArZiwvsq1zbl+X
 Du6dSOA2ayW4Y48xkWK3VCU21JmwcVUyYmDok99Mgyszt0HEBegGTfVqACZwztkB0Kii
 tYbuPRTQ+l0B48S/PEx6kvjuUTo3zZaB4V3adi10jphCxyTqeP0fOPNCdJtdia9b2UB3
 9a8ZhLQN7fDnMOsA6eA/Dwz2C7dHmFxbiTHgM7tpGocBK7n6+DG2ozwD/+45at6FYy3n
 GJsQ==
X-Gm-Message-State: AOJu0YxZK5Y7y6sPxrm0PCQFkW05ARcjkxDYhPz6Aj/KaVhoL3/jsdBZ
 AdWuyPXyykpEPlJ4w0h9Unf3J9+MdHgLLVL4NzXPwdoOMjXji2M36/a22yyC8w2y2u+g4AJpu0R
 3ZdR8BXaYXX6a73aaPjjpJFjfdndwZM10b7UdD8FFrlQ9fXcLHZG90bV1akVWJpnCF+rr1o7ePG
 Y6UQy55FZOWPDNW6ufdicbpRipDpf05VJXJuELnPto
X-Gm-Gg: ASbGncsWNdSNhkQVHebqI6P4wWwxNXVMkIPR/Lhi03d/YOdeWNtSC/g8nXy4tPcZ0xu
 aoHCPR5dj95DoXyc2bkTdOJQxUVLqErbBBKlC67cV/dIJ36+vfj3vErHcpeyz7nlJE2HcAvrAcI
 SbO5ZEAV+CzCuW9hZtyu06i/+hCigVQpwOecYasCmFEJnw8mfMi751ZBlST6b0F0bFS2HWiKL46
 j9+paF/22sHrA7KVVLUuOHyLM3g1+dDZjhSK5i62q8apoOM0hB5mBYJb8bTTzpryG4nQXQIwG/F
 gj+pm7rzQ0FOXMCObQgUIDGA+vd+pRC9HO/7+dQYnlk=
X-Received: by 2002:a05:600d:10d:b0:455:e858:cd04 with SMTP id
 5b1f17b1804b1-455e858cfe6mr65717135e9.25.1752491196714; 
 Mon, 14 Jul 2025 04:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUL5iBKMwz5Ldx/+SI5UaM5919hrMt2sgLb6dGbqbf4hvgJTbdoadLn6fxMqlMLK/4G4cF+g==
X-Received: by 2002:a05:600d:10d:b0:455:e858:cd04 with SMTP id
 5b1f17b1804b1-455e858cfe6mr65716805e9.25.1752491196056; 
 Mon, 14 Jul 2025 04:06:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456101b616csm56717045e9.4.2025.07.14.04.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 57/77] i386/cpu: Use a unified cache_info in X86CPUState
Date: Mon, 14 Jul 2025 13:03:46 +0200
Message-ID: <20250714110406.117772-58-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

At present, all cases using the cache model (CPUID 0x2, 0x4, 0x80000005,
0x80000006 and 0x8000001D leaves) have been verified to be able to
select either cache_info_intel or cache_info_amd based on the vendor.

Therefore, further merge cache_info_intel and cache_info_amd into a
unified cache_info in X86CPUState, and during its initialization, set
different legacy cache models based on the vendor.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-19-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |   5 +-
 target/i386/cpu.c | 150 ++++++++--------------------------------------
 2 files changed, 27 insertions(+), 128 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 20499a82a54..f977fc49a77 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2073,11 +2073,12 @@ typedef struct CPUArchState {
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
-    /* Cache information for CPUID.  When legacy-cache=on, the cache data
+    /*
+     * Cache information for CPUID.  When legacy-cache=on, the cache data
      * on each CPUID leaf will be different, because we keep compatibility
      * with old QEMU versions.
      */
-    CPUCaches cache_info_cpuid4, cache_info_amd;
+    CPUCaches cache_info;
     bool enable_legacy_cpuid2_cache;
     bool enable_legacy_vendor_cache;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5b969743bcc..ca6e4120242 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7474,27 +7474,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         } else if (env->enable_legacy_vendor_cache) {
             caches = &legacy_intel_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't use legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. Non-AMD CPUs use cache_info_cpuid4 like before and AMD
-             *    CPU will use cache_info_amd. But this doesn't matter for AMD
-             *    CPU, because this leaf encodes all-0 for AMD whatever its cache
-             *    model is.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         if (cpu->cache_info_passthrough) {
@@ -7513,27 +7493,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->enable_legacy_vendor_cache) {
             caches = &legacy_intel_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't use legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. Non-AMD CPUs use cache_info_cpuid4 like before and AMD
-             *    CPU will use cache_info_amd. But this doesn't matter for AMD
-             *    CPU, because this leaf encodes all-0 for AMD whatever its cache
-             *    model is.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         /* cache info: needed for Core compatibility */
@@ -7942,27 +7902,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->enable_legacy_vendor_cache) {
             caches = &legacy_amd_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't uses legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. AMD CPUs use cache_info_amd like before and non-AMD
-             *    CPU will use cache_info_cpuid4. But this doesn't matter,
-             *    because for Intel CPU, it will get all-0 leaf, and Zhaoxin CPU
-             *    will get correct cache info. Both are expected.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         if (cpu->cache_info_passthrough) {
@@ -7989,25 +7929,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->enable_legacy_vendor_cache) {
             caches = &legacy_amd_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't uses legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. AMD CPUs use cache_info_amd like before and non-AMD
-             *    CPU (Intel & Zhaoxin) will use cache_info_cpuid4 as expected.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         if (cpu->cache_info_passthrough) {
@@ -8080,22 +8002,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
-    case 0x8000001D: {
-        const CPUCaches *caches;
-
-        /*
-         * FIXME: Temporarily select cache info model here based on
-         * vendor, and merge these 2 cache info models later.
-         *
-         * Intel doesn't support this leaf so that Intel Guests don't
-         * have this leaf. This change is harmless to Intel CPUs.
-         */
-        if (IS_AMD_CPU(env)) {
-            caches = &env->cache_info_amd;
-        } else {
-            caches = &env->cache_info_cpuid4;
-        }
-
+    case 0x8000001D:
         *eax = 0;
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -8103,19 +8010,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(caches->l1d_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l1d_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(caches->l1i_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l1i_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(caches->l2_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l2_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(caches->l3_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l3_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
@@ -8126,7 +8033,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx &= CACHE_NO_INVD_SHARING | CACHE_INCLUSIVE;
         }
         break;
-    }
     case 0x8000001E:
         if (cpu->core_id <= 255) {
             encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
@@ -8825,46 +8731,34 @@ static bool x86_cpu_update_smp_cache_topo(MachineState *ms, X86CPU *cpu,
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l1d_cache->share_level = level;
-        env->cache_info_amd.l1d_cache->share_level = level;
+        env->cache_info.l1d_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
-            env->cache_info_cpuid4.l1d_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
-            env->cache_info_amd.l1d_cache->share_level);
+            env->cache_info.l1d_cache->share_level);
     }
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l1i_cache->share_level = level;
-        env->cache_info_amd.l1i_cache->share_level = level;
+        env->cache_info.l1i_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
-            env->cache_info_cpuid4.l1i_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
-            env->cache_info_amd.l1i_cache->share_level);
+            env->cache_info.l1i_cache->share_level);
     }
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l2_cache->share_level = level;
-        env->cache_info_amd.l2_cache->share_level = level;
+        env->cache_info.l2_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
-            env->cache_info_cpuid4.l2_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
-            env->cache_info_amd.l2_cache->share_level);
+            env->cache_info.l2_cache->share_level);
     }
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l3_cache->share_level = level;
-        env->cache_info_amd.l3_cache->share_level = level;
+        env->cache_info.l3_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
-            env->cache_info_cpuid4.l3_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
-            env->cache_info_amd.l3_cache->share_level);
+            env->cache_info.l3_cache->share_level);
     }
 
     if (!machine_check_smp_cache(ms, errp)) {
@@ -9101,7 +8995,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                        "CPU model '%s' doesn't support legacy-cache=off", name);
             return;
         }
-        env->cache_info_cpuid4 = env->cache_info_amd = *cache_info;
+        env->cache_info = *cache_info;
     } else {
         /* Build legacy cache information */
         if (!cpu->consistent_cache) {
@@ -9111,8 +9005,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         if (!cpu->vendor_cpuid_only_v2) {
             env->enable_legacy_vendor_cache = true;
         }
-        env->cache_info_cpuid4 = legacy_intel_cache_info;
-        env->cache_info_amd = legacy_amd_cache_info;
+
+        if (IS_AMD_CPU(env)) {
+            env->cache_info = legacy_amd_cache_info;
+        } else {
+            env->cache_info = legacy_intel_cache_info;
+        }
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.50.0


