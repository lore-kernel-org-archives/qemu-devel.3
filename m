Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71086C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHTb-0004zl-6Z; Mon, 14 Jul 2025 07:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH11-0001io-5L
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0t-00026h-5O
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5PG1jUF16fEsfrFUJ9a6f+CrhyoIvlt8q9EtqbOgag=;
 b=D1rR8X1Tdkjt5p6/gvrM0/8pgr6UI007i9zGeHKmISUsNRQWjDU8lBzs0VXsCL2B9MbS7E
 YZfbrdHAj8shESkZ+IUJUKuYSWaKZ+zhpbO9Pq/cBiW88o4DRl4uUre3s4GY5FVMRduuPF
 X7OWJqcS4BdS7dQska/S/9IFiQdbPEo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Qgi-9WzpOm6B2R5VhbAS3Q-1; Mon, 14 Jul 2025 07:06:23 -0400
X-MC-Unique: Qgi-9WzpOm6B2R5VhbAS3Q-1
X-Mimecast-MFC-AGG-ID: Qgi-9WzpOm6B2R5VhbAS3Q_1752491182
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so2705862f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491181; x=1753095981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5PG1jUF16fEsfrFUJ9a6f+CrhyoIvlt8q9EtqbOgag=;
 b=FkesiG05JF0+vOC3/5K9f5lsYgEoYlw5P4UH5X7d4J5kvRfwT2IYhiDiA08LSXe7rf
 ugnSvIRTbxPori6L+DRlAOjDru8BzuXv03zUGD5po3ktknGEJ2OQLOYqWW6sYqJ+6lwx
 6DHvY65HkN80FtP/xJQoKl262ZRTclV0/OJ6tkwHUPa/IJ+LukMoo7BMnl+v66Aj/DTi
 l61ycFA6lqOsTTNCbM3L8huZjqHU5FhAbC27EhH+dZYa9RzG+VZlwJAN4xLyIS0pehyc
 kG9cU0Kpr5MPnz3uaE6j0qN+vpcWKqzPVPTAM63fdishasdi99AEnLoymp4Yur7dVjhC
 F9QA==
X-Gm-Message-State: AOJu0YzMkFlH7UDCJfQuIZdiJ71PyQfSUFrrPPtEFJ+Z20Edmfj+7wp9
 hSuj2aV3RQtueH2EjIME8O62ZvO2Gi3+dycKIOmtGtHTC2w1oL7vXQ1ibA3hzT/UavuoVWMGqi4
 yMvaesLfk6uTqCmQgE0qNx8/TXUMXfOZIbtedAstI4GAa7vwhAqf9EWg+zioPQd3DjA883vNdtb
 e8EoLyMiSHKtYybMeyTzeGnU8ILxv9zNqymIwW91JH
X-Gm-Gg: ASbGncuDGRAsQw2QULrBLfPbQLX9iHwa7T9vXy7SqZlCZxEgrbmnmGPqL+dqFFA2/V+
 EYZCHpnNsyZdiXG4vncC6FWlRl+FYbrv1HCREjqn3VxVC7i8O2dtkg1AoAXCP+jBzqQNJHZskIo
 kUrb4PtRQhN1xwJi7dtvV9PZhY/muu7Lwl9kUsXnOrroPm2z46BUz1EoZHvzd+UqP7kz4+nflca
 trfSOfJHw/oR85jOlr/mC5oKzp8oBbva2zu6MEZtZgH5aNNE08YI0J6+bvF8mNT/Goe4Hghzdov
 wml8/cwnz59DaHRTNlcieEWHUB/qw2X3Lspk13Dq/lc=
X-Received: by 2002:a5d:5d85:0:b0:3b5:f6f9:e803 with SMTP id
 ffacd0b85a97d-3b5f6f9e812mr8051394f8f.14.1752491181141; 
 Mon, 14 Jul 2025 04:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3ufuEwfxJQ0v8ZKiVpw7HEJ9R+h/x+rD/MLQaVKNrkJpRbm35nGRWyOLs3VBb/xOiWR351Q==
X-Received: by 2002:a5d:5d85:0:b0:3b5:f6f9:e803 with SMTP id
 ffacd0b85a97d-3b5f6f9e812mr8051359f8f.14.1752491180557; 
 Mon, 14 Jul 2025 04:06:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm11946507f8f.76.2025.07.14.04.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 51/77] i386/cpu: Add legacy_amd_cache_info cache model
Date: Mon, 14 Jul 2025 13:03:40 +0200
Message-ID: <20250714110406.117772-52-pbonzini@redhat.com>
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

Based on legacy_l1d_cachei_amd, legacy_l1i_cache_amd, legacy_l2_cache_amd
and legacy_l3_cache, build a complete legacy AMD cache model, which can
clarify the purpose of these trivial legacy cache models, simplify the
initialization of cache info in X86CPUState, and make it easier to
handle compatibility later.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-13-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 112 ++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 59 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d265dc81563..92d21ce64c3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -640,60 +640,58 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
  * These are legacy cache values. If there is a need to change any
  * of these values please use builtin_x86_defs
  */
-static CPUCacheInfo legacy_l1d_cache_amd = {
-    .type = DATA_CACHE,
-    .level = 1,
-    .size = 64 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 2,
-    .sets = 512,
-    .partitions = 1,
-    .lines_per_tag = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
-static CPUCacheInfo legacy_l1i_cache_amd = {
-    .type = INSTRUCTION_CACHE,
-    .level = 1,
-    .size = 64 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 2,
-    .sets = 512,
-    .partitions = 1,
-    .lines_per_tag = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
-static CPUCacheInfo legacy_l2_cache_amd = {
-    .type = UNIFIED_CACHE,
-    .level = 2,
-    .size = 512 * KiB,
-    .line_size = 64,
-    .lines_per_tag = 1,
-    .associativity = 16,
-    .sets = 512,
-    .partitions = 1,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
-/* Level 3 unified cache: */
-static CPUCacheInfo legacy_l3_cache = {
-    .type = UNIFIED_CACHE,
-    .level = 3,
-    .size = 16 * MiB,
-    .line_size = 64,
-    .associativity = 16,
-    .sets = 16384,
-    .partitions = 1,
-    .lines_per_tag = 1,
-    .self_init = true,
-    .inclusive = true,
-    .complex_indexing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+static const CPUCaches legacy_amd_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 2,
+        .sets = 512,
+        .partitions = 1,
+        .lines_per_tag = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 2,
+        .sets = 512,
+        .partitions = 1,
+        .lines_per_tag = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .lines_per_tag = 1,
+        .associativity = 16,
+        .sets = 512,
+        .partitions = 1,
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
 };
 
 /*
@@ -8991,11 +8989,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
 
         env->cache_info_cpuid4 = legacy_intel_cache_info;
-
-        env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
-        env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
-        env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
-        env->cache_info_amd.l3_cache = &legacy_l3_cache;
+        env->cache_info_amd = legacy_amd_cache_info;
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.50.0


