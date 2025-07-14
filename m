Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF30C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHLp-0007Ac-NZ; Mon, 14 Jul 2025 07:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0c-0001XN-Pv
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0a-00023m-M5
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKAR39+Qoo2PsRjRakDp2hLXY0ic7nZQK21Qh2O4ItU=;
 b=G5XioyEvHzSxzA92vQ3XOkVrWB7BHx9dUKbi9UN5EjEFfq4BamuUwqugjGTFN2/OyuDNuN
 ibqkfEuQEPuAPmoEUJ6Eql8CVTLv8tt+xf/yLiHGS+miHVwKWyuAiIGzmss2F3Kiozuf9x
 oQ0pjw4paH11hCw0FK9xxb/f9JfIH2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-FDVUJ1EgNW-S1qlN8g6VZg-1; Mon, 14 Jul 2025 07:06:06 -0400
X-MC-Unique: FDVUJ1EgNW-S1qlN8g6VZg-1
X-Mimecast-MFC-AGG-ID: FDVUJ1EgNW-S1qlN8g6VZg_1752491165
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so15271085e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491164; x=1753095964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKAR39+Qoo2PsRjRakDp2hLXY0ic7nZQK21Qh2O4ItU=;
 b=Pn1iv6Pvjpa7O8gR9jcMdUjYWSgKMPoQOHMZEVWnTuYpJH5mToMOAigsC/65E41H6o
 eZSZCW0n7OmV6KcT7ENV/Od+ekCPTn7qNSKVYEsmCTyyiwRKcjykaVAqcCvqRNLCmdVG
 n8rjhI6FQhnYNS0L1nuG6QkFPqLkSq8iP9DyoY6tQXZ/6QZofiWDEDHWXa08Yql81KgG
 SK3WnCquU9GisNLLEHISrSZO2QJmDwe97hry+hYMWjcKVszu2y7lOLPIeCiH+7meYE+r
 8f99RejGbwm/pWcoLhLCvh/cYiLRrgTK9cxsWfFsdVcHvd3eoleyapHAeBuDl3BujVnO
 Bqpw==
X-Gm-Message-State: AOJu0YwhMe2Tz9Vm75fGKxCgMRWAV9SZ5M5cXBdIcV4pe7XqIp0FXB0j
 vklY3nur/DzPI78xzqBuVF5Wq4BZ+0FbOdfEFlihxPuEjXurYsYoZa36l2xHNGHxF7MdZccd+De
 8uXnqY7dsg5eZHlVmcKgNMqjCRtA0pONy5EKIhtfYeGLO6SeQu6f6y6ZgfOdmk/VQRA7RrYb+9B
 vTSjF/YbadM+6ziIXW/94NfkAbBf+FqLyf5gTLu1XI
X-Gm-Gg: ASbGnctaXr9efXwPDbSeX1hTHQk2+3uSbTKQj0oRivUFy15+0dWQIc8f5KEdu3fxx77
 7oShUSmdbk1bE1Wc5CHVik1qkKuP2hwHk3wTBXka/IhIs3i9+LV8RcdKLvuInn/JpfaaMicw/QH
 LAlYp4a9/S8q2KV9fM3xWo0SdMlVwvCG4o8rlXqHYN5zSXtprxfNHlgi8pWrHP/FnkCsoAs6JTv
 qDw0m0bnvAWIXMhCU+Gl7cZkRak7zV84sozHKUPSq1E+817BH3J7zdD6hPJp/aFtl1cCjfrFgUK
 +TvIAZLhYpVqZO0QHnslzvd27NJtIfo+JCyWkGlSrpc=
X-Received: by 2002:a05:600c:1c83:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-455e7135bbdmr86658495e9.32.1752491164343; 
 Mon, 14 Jul 2025 04:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyfT5lVSL5La+qRe6r0wBd2hXC09EXivpjtDrdt0XxI0V3wtxzODpSi4/VDmYyCO3qds9YzA==
X-Received: by 2002:a05:600c:1c83:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-455e7135bbdmr86658095e9.32.1752491163746; 
 Mon, 14 Jul 2025 04:06:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43912dsm130739785e9.2.2025.07.14.04.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 44/77] i386/cpu: Consolidate CPUID 0x4 leaf
Date: Mon, 14 Jul 2025 13:03:33 +0200
Message-ID: <20250714110406.117772-45-pbonzini@redhat.com>
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

Modern Intel CPUs use CPUID 0x4 leaf to describe cache information
and leave space in 0x2 for prefetch and TLBs (even TLB has its own leaf
CPUID 0x18).

And 0x2 leaf provides a descriptor 0xFF to instruct software to check
cache information in 0x4 leaf instead.

Therefore, follow this behavior to encode 0xFF when Intel CPU has 0x4
leaf with "x-consistent-cache=true" for compatibility.

In addition, for older CPUs without 0x4 leaf, still enumerate the cache
descriptor in 0x2 leaf, except the case that there's no descriptor
matching the cache model, then directly encode 0xFF in 0x2 leaf. This
makes sense, as in the 0x2 leaf era, all supported caches should have
the corresponding descriptor.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 48 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1f27fcf3ee0..812e85b952f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -225,7 +225,7 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
  * Return a CPUID 2 cache descriptor for a given cache.
  * If no known descriptor is found, return CACHE_DESCRIPTOR_UNAVAILABLE
  */
-static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
+static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache, bool *unmacthed)
 {
     int i;
 
@@ -242,9 +242,44 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
             }
     }
 
+    *unmacthed |= true;
     return CACHE_DESCRIPTOR_UNAVAILABLE;
 }
 
+/* Encode cache info for CPUID[2] */
+static void encode_cache_cpuid2(X86CPU *cpu,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    CPUX86State *env = &cpu->env;
+    CPUCaches *caches = &env->cache_info_cpuid2;
+    int l1d, l1i, l2, l3;
+    bool unmatched = false;
+
+    *eax = 1; /* Number of CPUID[EAX=2] calls required */
+    *ebx = *ecx = *edx = 0;
+
+    l1d = cpuid2_cache_descriptor(caches->l1d_cache, &unmatched);
+    l1i = cpuid2_cache_descriptor(caches->l1i_cache, &unmatched);
+    l2 = cpuid2_cache_descriptor(caches->l2_cache, &unmatched);
+    l3 = cpuid2_cache_descriptor(caches->l3_cache, &unmatched);
+
+    if (!cpu->consistent_cache ||
+        (env->cpuid_min_level < 0x4 && !unmatched)) {
+        /*
+         * Though SDM defines code 0x40 for cases with no L2 or L3. It's
+         * also valid to just ignore l3's code if there's no l2.
+         */
+        if (cpu->enable_l3_cache) {
+            *ecx = l3;
+        }
+        *edx = (l1d << 16) | (l1i <<  8) | l2;
+    } else {
+        *ecx = 0;
+        *edx = CACHE_DESCRIPTOR_UNAVAILABLE;
+    }
+}
+
 /* CPUID Leaf 4 constants: */
 
 /* EAX: */
@@ -7446,16 +7481,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
-        *eax = 1; /* Number of CPUID[EAX=2] calls required */
-        *ebx = 0;
-        if (!cpu->enable_l3_cache) {
-            *ecx = 0;
-        } else {
-            *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
-        }
-        *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
-               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
-               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
+        encode_cache_cpuid2(cpu, eax, ebx, ecx, edx);
         break;
     case 4:
         /* cache info: needed for Core compatibility */
-- 
2.50.0


