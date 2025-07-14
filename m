Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E782AC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEn-000067-Os; Mon, 14 Jul 2025 07:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1E-0001pb-7O
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH19-000290-Rf
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3MRbm7BiwFLJpNktHCZXz82/ZMpqoQ6Olp5sQUIC0g=;
 b=eXsOzVVIoCxm4TJ8YVOURFjC3xSI96PSX6Olxsz0F/1vEHjkUwzIstCYKZQxeowRFd7vhm
 kr79r/aRIYqPk+KHGpAO9mySPn1weg/uL/59EtW9ND6KU2sN2sN8dlrO9QBLSYhjsC2xQJ
 vdB4ZMxm0Bax1FDEIX6tjGfJYfRArj8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-nUheGkeNN2i-GOpudfc_kA-1; Mon, 14 Jul 2025 07:06:41 -0400
X-MC-Unique: nUheGkeNN2i-GOpudfc_kA-1
X-Mimecast-MFC-AGG-ID: nUheGkeNN2i-GOpudfc_kA_1752491200
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso1556654f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491199; x=1753095999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3MRbm7BiwFLJpNktHCZXz82/ZMpqoQ6Olp5sQUIC0g=;
 b=oqczGzOLGyc5E0s3ZblkJcvtK7MjfV0hN6/7zFGWEUb4SLfhTbhx+ODKxrAu6hMWlP
 CkXdyOvg9DKQlcywbrSNLd/E5YXrte8kCMGdDWijqJy3rwKKUGiGDSONLhuCs6moaaw2
 MbD5JVq771atxFt+JxZKNY0aC4uZxTxBG3BVAa8LQC3cc983PhQ2MororMbZbtZ7PEX7
 tuCxDcQvfrLZdPpBltz3AkhXgP2ty2Sydwis6WHZ2VZ4k3qvey1M1h5YA4T5TNQ9KApu
 61Ej7wzGMXOCTVeazzVNUw7QGTuFa2h9e+gnD//YuLYHFUI67f1noVUU8fgsBOdIb0Kt
 wRkQ==
X-Gm-Message-State: AOJu0YzWtNwmpqf1v53K3BuI4IM1lR09mE9loUG6pE6ffVXyyynz+lNC
 taa6q/t1gndOvYC1htdKcE5SRM+T2FGUCG7NnfVecVgw7mRHD7BTD6U5IhkfMweGL9GrZ34+YmV
 UWBNmo6KyIfKu7tkwOhF0XoXtsNd+eTqZ7ZfBGhkCve1UXEAXYhBljQBoJgDs/VKA/PWA6lCLEy
 be+tGjYzwpcoGK9XpDlyEJr5Hw8pl8MsFf6ld7wIU1
X-Gm-Gg: ASbGncsrTkMABDdcZw8oXRv5rtTMeDKzFQfWhs8omfSnF/uN6D4YeHnEybhgLQAUqdT
 ljtJX+orB7ZkcLl24tc67Y6YSLENPucebLi4vpSNM9IFpw9XcpkgiX2FXvQc80QDMJ0rM27mqJo
 IjASG6To+n75gEeCXCvmuWYXkd8JAzugFEtSZN/+vzfzyo0ahXdK2P8MdIze6MYJBg0qC6pqiB3
 tnvc+/ZyN33/4C4jebqj58YFtBjKWH4LXp/2EVlNrL5X+9huonfyaTo6yVjug3/KrLOm6CACekI
 sSoWSwpwriSBps1NmSv8TG7KYZAe+YXiHzbXQmg+FkU=
X-Received: by 2002:a05:6000:2d09:b0:3a6:d967:380e with SMTP id
 ffacd0b85a97d-3b5f187eb90mr7210640f8f.3.1752491199411; 
 Mon, 14 Jul 2025 04:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF67G9i7Tyo+jccD5Nb39QANLKCSVYm1N7GVZq5PQoZW8t9MZAVfcxI0ik7QQpsPQBtQmebCQ==
X-Received: by 2002:a05:6000:2d09:b0:3a6:d967:380e with SMTP id
 ffacd0b85a97d-3b5f187eb90mr7210601f8f.3.1752491198724; 
 Mon, 14 Jul 2025 04:06:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e8b1sm12007521f8f.82.2025.07.14.04.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Tao Su <tao1.su@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 58/77] i386/cpu: Introduce cache model for SierraForest
Date: Mon, 14 Jul 2025 13:03:47 +0200
Message-ID: <20250714110406.117772-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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

Add the cache model to SierraForest (v3) to better emulate its
environment.

The cache model is based on SierraForest-SP (Scalable Performance):

      --- cache 0 ---
      cache type                         = data cache (1)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 32768 (32 KB)
      --- cache 1 ---
      cache type                         = instruction cache (2)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x80 (128)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 128
      (size synth)                       = 65536 (64 KB)
      --- cache 2 ---
      cache type                         = unified cache (3)
      cache level                        = 0x2 (2)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x7 (7)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x1000 (4096)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 4096
      (size synth)                       = 4194304 (4 MB)
      --- cache 3 ---
      cache type                         = unified cache (3)
      cache level                        = 0x3 (3)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x1ff (511)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0xc (12)
      number of sets                     = 0x24000 (147456)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = true
      number of sets (s)                 = 147456
      (size synth)                       = 113246208 (108 MB)
      --- cache 4 ---
      cache type                         = no more caches (0)

Suggested-by: Tejus GK <tejus.gk@nutanix.com>
Suggested-by: Jason Zeng <jason.zeng@intel.com>
Suggested-by: "Daniel P . Berrangé" <berrange@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ca6e4120242..3c28e9588af 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2880,6 +2880,97 @@ static const CPUCaches epyc_turin_cache_info = {
         .no_invd_sharing = true,
         .complex_indexing = false,
         .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    }
+};
+
+static const CPUCaches xeon_srf_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x0.EAX */
+        .type = DATA_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x0.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 8,
+
+        /* CPUID 0x4.0x0.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x0.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 32 * KiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x1.EAX */
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x1.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 8,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets = 128,
+
+        /* CPUID 0x4.0x1.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 64 * KiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x2.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .self_init = true,
+
+        /* CPUID 0x4.0x2.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x2.ECX */
+        .sets = 4096,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 4 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_MODULE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x3.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .self_init = true,
+
+        /* CPUID 0x4.0x3.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 12,
+
+        /* CPUID 0x4.0x3.ECX */
+        .sets = 147456,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = true,
+
+        .size = 108 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
     },
 };
 
@@ -5005,6 +5096,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .note = "with srf-sp cache model",
+                .cache_info = &xeon_srf_cache_info,
+            },
             { /* end of list */ },
         },
     },
-- 
2.50.0


