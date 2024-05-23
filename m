Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96992C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wn-0007G8-AM; Thu, 23 May 2024 11:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wU-0006ob-1X
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wO-0004rX-8K
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwV0yaFJVqKJSmAFwAeX+chM6jTzpTKGi6dHJnBLf0k=;
 b=JA5VX9gyf4AHdiJkyiyk7QqlxbqCi/sAJC/aYWhugM2dCMdW0ihsUiGlPOsV5Qzkb8FjGN
 7c0xiA9O6V5Dg3haHVvIFJ4rfy5rgvTqMcYPu+xicLvojiaqTlCFdO1PZ4ILOzVS0kQrGp
 YtzYlqu+EX8wn0lKSsfsh/BLAkCqirU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-eaF1E9msM1aRulN_NtGoQw-1; Thu, 23 May 2024 11:01:10 -0400
X-MC-Unique: eaF1E9msM1aRulN_NtGoQw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59ad2436f8so114938666b.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476468; x=1717081268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwV0yaFJVqKJSmAFwAeX+chM6jTzpTKGi6dHJnBLf0k=;
 b=CR0JFjGb4OHMY3NYN5oiZcz7LO6ISUcuAFqLwaBnaT5CVujGw3vkb62zONKhRh/gll
 6U2n0MiGSqrbHSkAjX/eyf7Y+ef3LoZtzjZHqQxIUgizxdrlCULWEuyKDuoS/I3Rh4nt
 EkQPHVoZaGjuzrFXqZDjc9/G531rscgR7/F4oDXYhNu7nOH82cJi6kYElTwrAXWBQG4G
 T5Y9HJVvXeNDKXP2RQ7QWo5Ojss5hPSkN5HVU4JMLdbl0WTl/40LOGeypi0gKxjUjB3A
 ukzODz93imIGHwrXJ7+9umYlJ9/Et+z+h+yrKyVYur5SntTRWh2BttZt4DP/ALcsEzI8
 P8jw==
X-Gm-Message-State: AOJu0Yy9SnkyyHUwVJ1pgAWkjQ1hTGFNQnAKfDYlGPCl3dVqnve3PcwN
 CUk0mxqAuEGx1MRKZ2vg06qUsdG6JtD70l+ivXqgzEQX1cLpfQ7XpgVFbmTTe86oaDDcqicEv4n
 bHxfIZQ7RGxea1Q2J9sHMEDK33jwaPn0aU1aor2848eYC+zuPyJTp1Uqn/Ivyy+yEwZx3A2aXDq
 kTmaGtLqTocl4XB8rRV+U2OyfjCWODRR5e9Qag
X-Received: by 2002:a17:906:254d:b0:a5a:88a9:3ef5 with SMTP id
 a640c23a62f3a-a622812e4femr331519266b.39.1716476468026; 
 Thu, 23 May 2024 08:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb2pvwBpXQweIh+EVpst7RURPmvK8GQkeesuouQvuOgxInbbWjzKNU6TdCzYnLEcxJdqQf8Q==
X-Received: by 2002:a17:906:254d:b0:a5a:88a9:3ef5 with SMTP id
 a640c23a62f3a-a622812e4femr331517366b.39.1716476467661; 
 Thu, 23 May 2024 08:01:07 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5fa6e4d4c3sm720172366b.22.2024.05.23.08.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 12/23] i386/cpu: Decouple CPUID[0x1F] subleaf with specific
 topology level
Date: Thu, 23 May 2024 17:00:25 +0200
Message-ID: <20240523150036.1050011-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

At present, the subleaf 0x02 of CPUID[0x1F] is bound to the "die" level.

In fact, the specific topology level exposed in 0x1F depends on the
platform's support for extension levels (module, tile and die).

To help expose "module" level in 0x1F, decouple CPUID[0x1F] subleaf
with specific topology level.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240424154929.1487382-12-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 135 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d350eb8a736..f95d539eeff 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -269,6 +269,115 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
+static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
+                                          enum CPUTopoLevel topo_level)
+{
+    switch (topo_level) {
+    case CPU_TOPO_LEVEL_SMT:
+        return 1;
+    case CPU_TOPO_LEVEL_CORE:
+        return topo_info->threads_per_core;
+    case CPU_TOPO_LEVEL_DIE:
+        return topo_info->threads_per_core * topo_info->cores_per_die;
+    case CPU_TOPO_LEVEL_PACKAGE:
+        return topo_info->threads_per_core * topo_info->cores_per_die *
+               topo_info->dies_per_pkg;
+    default:
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
+                                            enum CPUTopoLevel topo_level)
+{
+    switch (topo_level) {
+    case CPU_TOPO_LEVEL_SMT:
+        return 0;
+    case CPU_TOPO_LEVEL_CORE:
+        return apicid_core_offset(topo_info);
+    case CPU_TOPO_LEVEL_DIE:
+        return apicid_die_offset(topo_info);
+    case CPU_TOPO_LEVEL_PACKAGE:
+        return apicid_pkg_offset(topo_info);
+    default:
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
+{
+    switch (topo_level) {
+    case CPU_TOPO_LEVEL_INVALID:
+        return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
+    case CPU_TOPO_LEVEL_SMT:
+        return CPUID_1F_ECX_TOPO_LEVEL_SMT;
+    case CPU_TOPO_LEVEL_CORE:
+        return CPUID_1F_ECX_TOPO_LEVEL_CORE;
+    case CPU_TOPO_LEVEL_DIE:
+        return CPUID_1F_ECX_TOPO_LEVEL_DIE;
+    default:
+        /* Other types are not supported in QEMU. */
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
+                                X86CPUTopoInfo *topo_info,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    X86CPU *cpu = env_archcpu(env);
+    unsigned long level, next_level;
+    uint32_t num_threads_next_level, offset_next_level;
+
+    assert(count + 1 < CPU_TOPO_LEVEL_MAX);
+
+    /*
+     * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
+     * The search starts from bit 1 (CPU_TOPO_LEVEL_INVALID + 1).
+     */
+    level = CPU_TOPO_LEVEL_INVALID;
+    for (int i = 0; i <= count; i++) {
+        level = find_next_bit(env->avail_cpu_topo,
+                              CPU_TOPO_LEVEL_PACKAGE,
+                              level + 1);
+
+        /*
+         * CPUID[0x1f] doesn't explicitly encode the package level,
+         * and it just encodes the invalid level (all fields are 0)
+         * into the last subleaf of 0x1f.
+         */
+        if (level == CPU_TOPO_LEVEL_PACKAGE) {
+            level = CPU_TOPO_LEVEL_INVALID;
+            break;
+        }
+    }
+
+    if (level == CPU_TOPO_LEVEL_INVALID) {
+        num_threads_next_level = 0;
+        offset_next_level = 0;
+    } else {
+        next_level = find_next_bit(env->avail_cpu_topo,
+                                   CPU_TOPO_LEVEL_PACKAGE,
+                                   level + 1);
+        num_threads_next_level = num_threads_by_topo_level(topo_info,
+                                                           next_level);
+        offset_next_level = apicid_offset_by_topo_level(topo_info,
+                                                        next_level);
+    }
+
+    *eax = offset_next_level;
+    /* The count (bits 15-00) doesn't need to be reliable. */
+    *ebx = num_threads_next_level & 0xffff;
+    *ecx = (count & 0xff) | (cpuid1f_topo_type(level) << 8);
+    *edx = cpu->apic_id;
+
+    assert(!(*eax & ~0x1f));
+}
+
 /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
 static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 {
@@ -6447,31 +6556,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
 
-        *ecx = count & 0xff;
-        *edx = cpu->apic_id;
-        switch (count) {
-        case 0:
-            *eax = apicid_core_offset(&topo_info);
-            *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_SMT << 8;
-            break;
-        case 1:
-            *eax = apicid_die_offset(&topo_info);
-            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
-            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_CORE << 8;
-            break;
-        case 2:
-            *eax = apicid_pkg_offset(&topo_info);
-            *ebx = threads_per_pkg;
-            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_DIE << 8;
-            break;
-        default:
-            *eax = 0;
-            *ebx = 0;
-            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_INVALID << 8;
-        }
-        assert(!(*eax & ~0x1f));
-        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
+        encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
         break;
     case 0xD: {
         /* Processor Extended State */
-- 
2.45.1


