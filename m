Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969B9C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHDr-0006ZL-09; Mon, 14 Jul 2025 07:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0q-0001fm-Va
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0o-000263-QZ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thCWbzpn9tuIPYHaAUoFp+onJN6KsKkVNOqqjaM55Rk=;
 b=gSn28D1CC84Nqfb3bZ+jMxCrYpSNbDMKs2coTrGbGBqeSKXADOEv11BYD/mlQrCsx5lygw
 hF7CP6w3vXU2RkGfrcM+QOSDnm6NWyyll7dtMHUau3kOji8VOLnSkFJXAOjETxFB0g750B
 2X06xpbhzmHrm4YzyZsTWmfTBtr7Tw8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-diUf87Y5MS-InqGVf24TBg-1; Mon, 14 Jul 2025 07:06:20 -0400
X-MC-Unique: diUf87Y5MS-InqGVf24TBg-1
X-Mimecast-MFC-AGG-ID: diUf87Y5MS-InqGVf24TBg_1752491180
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso27401095e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491178; x=1753095978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thCWbzpn9tuIPYHaAUoFp+onJN6KsKkVNOqqjaM55Rk=;
 b=HSim5prEJuSalNjAtoiqmrRpKfqhhgsDruwLPpinuYRumkdBE8ZXn4gjiA5EqW09je
 bYQCNxBbD/31nFKas7FHM7LwKYTCcg1RTxWrATyTchZwvVXdwrjOykc2YgegKUSf5LZn
 nNkB0kkJJZR2q98JK9D1iYUoyKY3ohYLZpQUqhd/uFp31iN7HeWbwwq8EFuByqEYEVzM
 ja31rOJV8vzEdC6GZBD2qZ9rg5vQZ28x+iHjVkBko7rpC6L3du+vYtuMoJAATUwRAFwF
 0a+zGhuEpQMMTZqgDQ18SBp3awy85wM0FoLDMbNXZRw5A9M7BDU8icgRbG8s+0w8pEhD
 8t5Q==
X-Gm-Message-State: AOJu0YwXsHQEqE9PrEWG7ILBzpd1VHyX6bFvAnV+A6KIUoj6bBZEXOh0
 WVydHMtTKcrk4EyXu7DhL+ZfQNyenDZaalX4zAJWi2sKf9XWPFYwakhCRBYgJsRZ4hl22YdHk7q
 b/+Im6c1TquiNFU5GhuNI8ifes3xxoSvTURhehibQXAIkceQw/oJ3zDo1Obj+RNLWbn3JpWpJ+x
 GI0VzEGrTL9n+F8cF67ji5KmR4AZnAyh7YjWZ3tif8
X-Gm-Gg: ASbGncs0bDOMTgzjtwqSnSeutQdqFx1bD6PaZWJ0C67XLQNB8e+r/Vs9/pO09lj/CcQ
 cfxAaMBaLdFHyswsO6YWNNYqwasm4+Jlfq+UMzjFhwUrfLhvY7E3bps0ueLiXludKfpdwqVt7gL
 nAGWZ7doiiTVNPxnI2NDj7cJsDzBKWYMdK6vNqBXXvo6ZOQG+A1lxtcdZwBRorGsMMCek8Si1tu
 8uzlFy+E5CVk7ioAd7vqugahMcHlL6BBoiatg8U9rxIgZERCiFW5ZQvezStdC3U1Li0MbTRDS7Z
 5cANS8hwQQnFsn42cP2Euuu0vuscsItuZjiYNNKt2eo=
X-Received: by 2002:a05:6000:2884:b0:3a5:2c18:b181 with SMTP id
 ffacd0b85a97d-3b5f2e3a02bmr8888230f8f.53.1752491178469; 
 Mon, 14 Jul 2025 04:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNVX7zC3TllamP4vaK0OHrsMzqq6pSljcEdTSRvt/3fSxaZFDlk3q5MtCBqZ0+yf43Igl0Yw==
X-Received: by 2002:a05:6000:2884:b0:3a5:2c18:b181 with SMTP id
 ffacd0b85a97d-3b5f2e3a02bmr8888197f8f.53.1752491177915; 
 Mon, 14 Jul 2025 04:06:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f844c2dsm57366755e9.0.2025.07.14.04.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 50/77] i386/cpu: Add legacy_intel_cache_info cache model
Date: Mon, 14 Jul 2025 13:03:39 +0200
Message-ID: <20250714110406.117772-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Based on legacy_l1d_cache, legacy_l1i_cache, legacy_l2_cache and
legacy_l3_cache, build a complete legacy intel cache model, which can
clarify the purpose of these trivial legacy cache models, simplify the
initialization of cache info in X86CPUState, and make it easier to
handle compatibility later.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-12-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 101 +++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6a0e8592bbe..d265dc81563 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -640,21 +640,6 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
  * These are legacy cache values. If there is a need to change any
  * of these values please use builtin_x86_defs
  */
-
-/* L1 data cache: */
-static CPUCacheInfo legacy_l1d_cache = {
-    .type = DATA_CACHE,
-    .level = 1,
-    .size = 32 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 8,
-    .sets = 64,
-    .partitions = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
 static CPUCacheInfo legacy_l1d_cache_amd = {
     .type = DATA_CACHE,
     .level = 1,
@@ -669,20 +654,6 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/* L1 instruction cache: */
-static CPUCacheInfo legacy_l1i_cache = {
-    .type = INSTRUCTION_CACHE,
-    .level = 1,
-    .size = 32 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 8,
-    .sets = 64,
-    .partitions = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
 static CPUCacheInfo legacy_l1i_cache_amd = {
     .type = INSTRUCTION_CACHE,
     .level = 1,
@@ -697,20 +668,6 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/* Level 2 unified cache: */
-static CPUCacheInfo legacy_l2_cache = {
-    .type = UNIFIED_CACHE,
-    .level = 2,
-    .size = 4 * MiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 16,
-    .sets = 4096,
-    .partitions = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
 static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
     .level = 2,
@@ -800,6 +757,59 @@ static const CPUCaches legacy_intel_cpuid2_cache_info = {
     },
 };
 
+static const CPUCaches legacy_intel_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 64,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 64,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 4 * MiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 16,
+        .sets = 4096,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 16 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .sets = 16384,
+        .partitions = 1,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* TLB definitions: */
 
 #define L1_DTLB_2M_ASSOC       1
@@ -8980,10 +8990,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             env->enable_legacy_cpuid2_cache = true;
         }
 
-        env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
-        env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
-        env->cache_info_cpuid4.l2_cache = &legacy_l2_cache;
-        env->cache_info_cpuid4.l3_cache = &legacy_l3_cache;
+        env->cache_info_cpuid4 = legacy_intel_cache_info;
 
         env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
         env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
-- 
2.50.0


