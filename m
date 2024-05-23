Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF406C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wE-0006A3-3b; Thu, 23 May 2024 11:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wC-0005zu-KN
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wA-0004pi-HG
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqS2UfS+WDHHZdip3hx7UpMxZQFBBZCwcieJssVifKE=;
 b=COV6z7E+0OLZDnktDamiSY6iHLijxFRlifaoSnRLF5miEAeklbhHUvZR7PW5J5EUmqa2Jc
 jK8xP0DpXccPeBF5+WSKMjdzz5a9pKlBDl1QfKQme+tbh+Ne6gFqWQLP2T1QB5FGr2SlgB
 fKC6cuqVydrOgXUYW+jlBWljQLJEArs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-DBuYk1bANOm-qsHBM7-VBw-1; Thu, 23 May 2024 11:00:56 -0400
X-MC-Unique: DBuYk1bANOm-qsHBM7-VBw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59c942611bso119345166b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476455; x=1717081255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqS2UfS+WDHHZdip3hx7UpMxZQFBBZCwcieJssVifKE=;
 b=X0aXm22cKQKJkt5EXf84H9rE8yCGpl2AhSOp6SpSatok6pNkdADjuX3yIVD0ej/UDj
 JB6o84DclxcHI3mP+0IjrjzQsuP/p9cDxRiXnkca5Uf7LjSyNfXiMkLTv1nXjidG2cAm
 4MEfrw4OtEBwwoigL8gH3VgT5lQj3cj50TfScyRqKQTMFfSQOR7DdAd22kRzisMUBIiI
 5N7NaczB7N4t7xTRKdkmt3HjMjtYCbOLU2nyKTGki9/RF4/rKkrXxuSKPDeKIHU0q3nP
 pPv1x8vf/MxXahEEHihzQ/uOXJEiENJFv//iXoyCvLrO4rN/94SEdknq9PRH+epBnpxf
 EIyA==
X-Gm-Message-State: AOJu0YzClt3dYvOZBsvkX4nty9lV0UGQeszEIHBGByK9k81qi4vjFgz6
 9DX2s6Oa2otMNAfIjz78vjVAPrI+wiYECMdVH8J5karuydaI2Rgev9hcYXgBss5W/D87zgDBcJE
 rrqUEyU423YlFOy2xnmRCTTb5UONujgdUN9szddYz5gavederWPYy1U/TQs1pAZF3eyksx7Absf
 A2QGwQFQRh/dzT+H1jAuG4Lqb3AHW9PdC4VV7w
X-Received: by 2002:a17:906:a38f:b0:a59:c23d:85d8 with SMTP id
 a640c23a62f3a-a6228156097mr314608666b.51.1716476454902; 
 Thu, 23 May 2024 08:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLhQjuaMmnqZnOhZnc8p+AieE+ED4aduMULZnVF2+HgTQfVSbKulXKBrC5G13MSFm84L+I0Q==
X-Received: by 2002:a17:906:a38f:b0:a59:c23d:85d8 with SMTP id
 a640c23a62f3a-a6228156097mr314606466b.51.1716476454530; 
 Thu, 23 May 2024 08:00:54 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17d02sm1954719066b.218.2024.05.23.08.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Robert Hoo <robert.hu@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Babu Moger <babu.moger@amd.com>
Subject: [PULL 07/23] i386/cpu: Use APIC ID info to encode cache topo in
 CPUID[4]
Date: Thu, 23 May 2024 17:00:20 +0200
Message-ID: <20240523150036.1050011-8-pbonzini@redhat.com>
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

Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
nearest power-of-2 integer.

The nearest power-of-2 integer can be calculated by pow2ceil() or by
using APIC ID offset/width (like L3 topology using 1 << die_offset [3]).

But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
are associated with APIC ID. For example, in linux kernel, the field
"num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
matched with actual core numbers and it's calculated by:
"(1 << (pkg_offset - core_offset)) - 1".

Therefore the topology information of APIC ID should be preferred to
calculate nearest power-of-2 integer for CPUID.04H:EAX[bits 25:14] and
CPUID.04H:EAX[bits 31:26]:
1. d/i cache is shared in a core, 1 << core_offset should be used
   instead of "cs->nr_threads" in encode_cache_cpuid4() for
   CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
2. L2 cache is supposed to be shared in a core as for now, thereby
   1 << core_offset should also be used instead of "cs->nr_threads" in
   encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
   calculated with the bit width between the package and SMT levels in
   the APIC ID (1 << (pkg_offset - core_offset) - 1).

In addition, use APIC ID bits calculations to replace "pow2ceil()" for
cache_info_passthrough case.

[1]: efb3934adf9e ("x86: cpu: make sure number of addressable IDs for processor cores meets the spec")
[2]: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
[3]: d65af288a84d ("i386: Update new x86_apicid parsing rules with die_offset support")

Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-7-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 50 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3c66242f6d3..f3d2b8053b2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6162,7 +6162,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 {
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
@@ -6234,7 +6233,18 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
         break;
-    case 4:
+    case 4: {
+        /*
+         * CPUID.04H:EAX[bits 25:14]: Maximum number of addressable IDs for
+         * logical processors sharing this cache.
+         */
+        int addressable_threads_width;
+        /*
+         * CPUID.04H:EAX[bits 31:26]: Maximum number of addressable IDs for
+         * processor cores in the physical package.
+         */
+        int addressable_cores_width;
+
         /* cache info: needed for Core compatibility */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -6246,40 +6256,59 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
                 int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
                 if (cs->nr_cores > 1) {
+                    addressable_cores_width = apicid_pkg_offset(&topo_info) -
+                                              apicid_core_offset(&topo_info);
+
                     *eax &= ~0xFC000000;
-                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
+                    *eax |= ((1 << addressable_cores_width) - 1) << 26;
                 }
                 if (host_vcpus_per_cache > vcpus_per_socket) {
+                    /* Share the cache at package level. */
+                    addressable_threads_width = apicid_pkg_offset(&topo_info);
+
                     *eax &= ~0x3FFC000;
-                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
+                    *eax |= ((1 << addressable_threads_width) - 1) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
-            int apic_ids_sharing_l1 = cpu->l1_cache_per_core ? cs->nr_threads : 1;
+            addressable_cores_width = apicid_pkg_offset(&topo_info) -
+                                      apicid_core_offset(&topo_info);
+
             switch (count) {
             case 0: /* L1 dcache info */
+                addressable_threads_width = cpu->l1_cache_per_core
+                    ? apicid_core_offset(&topo_info)
+                    : 0;
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    apic_ids_sharing_l1, cs->nr_cores,
+                                    (1 << addressable_threads_width),
+                                    (1 << addressable_cores_width),
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
+                addressable_threads_width = cpu->l1_cache_per_core
+                    ? apicid_core_offset(&topo_info)
+                    : 0;
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    apic_ids_sharing_l1, cs->nr_cores,
+                                    (1 << addressable_threads_width),
+                                    (1 << addressable_cores_width),
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
+                addressable_threads_width = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
-                                    cs->nr_threads, cs->nr_cores,
+                                    (1 << addressable_threads_width),
+                                    (1 << addressable_cores_width),
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                die_offset = apicid_die_offset(&topo_info);
                 if (cpu->enable_l3_cache) {
+                    addressable_threads_width = apicid_die_offset(&topo_info);
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        (1 << die_offset), cs->nr_cores,
+                                        (1 << addressable_threads_width),
+                                        (1 << addressable_cores_width),
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -6290,6 +6319,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         }
         break;
+    }
     case 5:
         /* MONITOR/MWAIT Leaf */
         *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
-- 
2.45.1


