Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804EAC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9x3-0000GQ-Ps; Thu, 23 May 2024 11:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wo-0007Q5-5t
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wm-0004ud-53
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prpxbCqu/R2QYNj70K3y+D0jhsOl54X51FnzRZgVpws=;
 b=N+KS2I42ZFsUDtCOCIflJHTYHU02SutBM+O2GvvXx6jZf550wiVpZwbSbmUSP5tUlRrRuc
 RSyFnzGi8vFx8sm+6JcL1T70J6F/uZM5StEQ09/1q43nAU9mcMdvr6WwUK7Ayvnp0+0v0h
 TXe83uGxjCDDh6x7sF9r4/ROAfpG7g0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-bodBPX9iPCaQiT6QriIszg-1; Thu, 23 May 2024 11:01:33 -0400
X-MC-Unique: bodBPX9iPCaQiT6QriIszg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a0d2280cso135457966b.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476491; x=1717081291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prpxbCqu/R2QYNj70K3y+D0jhsOl54X51FnzRZgVpws=;
 b=J3UpKuIClBkYMs14BY0cmbnpy+Cuetku85ceTuL89WassA6wybA2+zDbtrf6eh93by
 kZG4CQftb83oJUS3aU7HQK2YnWY4mDk+m1j+Cqnqm1SFX3+YNT1LBYON4S4AhSqWlZ1k
 LaVfF0zHzfNhFOQo/wYFPs7rywzEBeCDMkL65N2yGa3SrU1eM4s/HutLMvVFeQejl9Mr
 NfhC+A8BSJunW7Xgkw7zBfp2VkDoU4hFQKOolhil0MRGTZhaJ7n2zwZefC4AtRBvnlg6
 nG0CpzV0Rl8Y/gF65ChaTf116v6y3drcVlzeBTBFLTq2EHeMb0BtyRWFcA51tLmkGUyc
 W7vQ==
X-Gm-Message-State: AOJu0YzT57zuNjIBfvt8KcwAo2PRGq9qqQDzgTDpoxqgwg4KgN+wYG1Q
 gnXVO0grw24L9O0/lC1os7sBod7KN1/jsvhTOtVqOFQZz7jX2Xys/vvoyLDg4gflIp5noF8WE4Q
 xcGkgsF2ITP1ZpJtfnRjnJ29LWJJrK6d7AdfxA196xjEgQSQrgltP/PgmCjC/EEBK4nf2t2+5St
 aaoOz8WBe0KwIamBHq4leyWbN+T3qR4dj9Vi3M
X-Received: by 2002:a17:906:b844:b0:a5a:6686:ff9 with SMTP id
 a640c23a62f3a-a62281723ccmr273248366b.77.1716476490923; 
 Thu, 23 May 2024 08:01:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMVQtw3Pw6vNCLtFeKbn7/hXyQnL0jRzYNavVWySRmMackuAl76fV7AhEGoDt9jzxfn9ogzg==
X-Received: by 2002:a17:906:b844:b0:a5a:6686:ff9 with SMTP id
 a640c23a62f3a-a62281723ccmr273246366b.77.1716476490403; 
 Thu, 23 May 2024 08:01:30 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01598sm1971897566b.178.2024.05.23.08.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Babu Moger <babu.moger@amd.com>
Subject: [PULL 21/23] i386/cpu: Use CPUCacheInfo.share_level to encode CPUID[4]
Date: Thu, 23 May 2024 17:00:34 +0200
Message-ID: <20240523150036.1050011-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
Intel CPUs.

After cache models have topology information, we can use
CPUCacheInfo.share_level to decide which topology level to be encoded
into CPUID[4].EAX[bits 25:14].

And since with the helper max_processor_ids_for_cache(), the filed
CPUID[4].EAX[bits 25:14] (original virable "num_apic_ids") is parsed
based on cpu topology levels, which are verified when parsing -smp, it's
no need to check this value by "assert(num_apic_ids > 0)" again, so
remove this assert().

Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
helper to make the code cleaner.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-21-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  5 +++
 target/i386/cpu.c | 94 +++++++++++++++++++++++++----------------------
 2 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9f152812b60..c500a69a696 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2011,6 +2011,11 @@ struct ArchCPU {
      */
     bool enable_l3_cache;
 
+    /* Compatibility bits for old machine types.
+     * If true present L1 cache as per-thread, not per-core.
+     */
+    bool l1_cache_per_core;
+
     /* Compatibility bits for old machine types.
      * If true present the old cache topology information
      */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 656b65ad333..f91e1500266 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -235,22 +235,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
                        ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
                        0 /* Invalid value */)
 
+static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
+                                         enum CPUTopoLevel share_level)
+{
+    uint32_t num_ids = 0;
+
+    switch (share_level) {
+    case CPU_TOPO_LEVEL_CORE:
+        num_ids = 1 << apicid_core_offset(topo_info);
+        break;
+    case CPU_TOPO_LEVEL_DIE:
+        num_ids = 1 << apicid_die_offset(topo_info);
+        break;
+    case CPU_TOPO_LEVEL_PACKAGE:
+        num_ids = 1 << apicid_pkg_offset(topo_info);
+        break;
+    default:
+        /*
+         * Currently there is no use case for SMT and MODULE, so use
+         * assert directly to facilitate debugging.
+         */
+        g_assert_not_reached();
+    }
+
+    return num_ids - 1;
+}
+
+static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
+{
+    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
+                               apicid_core_offset(topo_info));
+    return num_cores - 1;
+}
 
 /* Encode cache info for CPUID[4] */
 static void encode_cache_cpuid4(CPUCacheInfo *cache,
-                                int num_apic_ids, int num_cores,
+                                X86CPUTopoInfo *topo_info,
                                 uint32_t *eax, uint32_t *ebx,
                                 uint32_t *ecx, uint32_t *edx)
 {
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
-    assert(num_apic_ids > 0);
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
-           ((num_cores - 1) << 26) |
-           ((num_apic_ids - 1) << 14);
+           (max_core_ids_in_package(topo_info) << 26) |
+           (max_thread_ids_for_cache(topo_info, cache->share_level) << 14);
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
@@ -6392,18 +6423,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
         break;
-    case 4: {
-        /*
-         * CPUID.04H:EAX[bits 25:14]: Maximum number of addressable IDs for
-         * logical processors sharing this cache.
-         */
-        int addressable_threads_width;
-        /*
-         * CPUID.04H:EAX[bits 31:26]: Maximum number of addressable IDs for
-         * processor cores in the physical package.
-         */
-        int addressable_cores_width;
-
+    case 4:
         /* cache info: needed for Core compatibility */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -6415,59 +6435,48 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 if (cores_per_pkg > 1) {
-                    addressable_cores_width = apicid_pkg_offset(&topo_info) -
-                                              apicid_core_offset(&topo_info);
-
                     *eax &= ~0xFC000000;
-                    *eax |= ((1 << addressable_cores_width) - 1) << 26;
+                    *eax |= max_core_ids_in_package(&topo_info) << 26;
                 }
                 if (host_vcpus_per_cache > threads_per_pkg) {
-                    /* Share the cache at package level. */
-                    addressable_threads_width = apicid_pkg_offset(&topo_info);
-
                     *eax &= ~0x3FFC000;
-                    *eax |= ((1 << addressable_threads_width) - 1) << 14;
+
+                    /* Share the cache at package level. */
+                    *eax |= max_thread_ids_for_cache(&topo_info,
+                                CPU_TOPO_LEVEL_PACKAGE) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
-            addressable_cores_width = apicid_pkg_offset(&topo_info) -
-                                      apicid_core_offset(&topo_info);
 
             switch (count) {
             case 0: /* L1 dcache info */
-                addressable_threads_width = cpu->l1_cache_per_core
-                    ? apicid_core_offset(&topo_info)
-                    : 0;
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    (1 << addressable_threads_width),
-                                    (1 << addressable_cores_width),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
+                if (!cpu->l1_cache_per_core) {
+                    *eax &= ~MAKE_64BIT_MASK(14, 12);
+                }
                 break;
             case 1: /* L1 icache info */
-                addressable_threads_width = cpu->l1_cache_per_core
-                    ? apicid_core_offset(&topo_info)
-                    : 0;
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    (1 << addressable_threads_width),
-                                    (1 << addressable_cores_width),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
+                if (!cpu->l1_cache_per_core) {
+                    *eax &= ~MAKE_64BIT_MASK(14, 12);
+                }
                 break;
             case 2: /* L2 cache info */
-                addressable_threads_width = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
-                                    (1 << addressable_threads_width),
-                                    (1 << addressable_cores_width),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 if (cpu->enable_l3_cache) {
-                    addressable_threads_width = apicid_die_offset(&topo_info);
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        (1 << addressable_threads_width),
-                                        (1 << addressable_cores_width),
+                                        &topo_info,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -6478,7 +6487,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         }
         break;
-    }
     case 5:
         /* MONITOR/MWAIT Leaf */
         *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
-- 
2.45.1


