Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC2BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHYd-00019d-DS; Mon, 14 Jul 2025 07:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1P-0001uO-2i
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1I-0002BD-Kc
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOKJ7k5EUKjWP5vYqwIlq0vfh3oRU4VVY5lSk531NFs=;
 b=eUvP5iOGh37E0nCxF8sTq4PYNddrV16x425fjS79n/FjG8P9BHwQbOXKnhWn93dQFwmuX3
 E/pdJztcYvXOgXGh6/JLbjXbm78Cpwn60oTKnyacFVMT82qsLI2qixdPuzWD7TUoxNsg+Z
 hli/iieqG9EMqei7UKQ1kom40svMs84=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-qzVnPUrdMsGGRBEFTP7dKg-1; Mon, 14 Jul 2025 07:06:48 -0400
X-MC-Unique: qzVnPUrdMsGGRBEFTP7dKg-1
X-Mimecast-MFC-AGG-ID: qzVnPUrdMsGGRBEFTP7dKg_1752491207
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso27403585e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491206; x=1753096006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOKJ7k5EUKjWP5vYqwIlq0vfh3oRU4VVY5lSk531NFs=;
 b=BjoV8+LasCelEF85ucRs9TNd9bMK7JYlJNrGZnVdy113M7An5RzO3v6TkdztJVlGLf
 tF1E4TOy+NLSl9o4a+ZFGeRGfk2EGuN8vN1fP2ZHViHjCtdFH88TZWcb2CeXuf5PNktR
 iZzKkuA9UvlJiEu+TV87jZ8KDjUlkwHHp6uhyssvQCDLU0tQV844JVSxgNR6mhG20r+X
 AysjMJ/r8JKLbTNLuUwv3yLI2n2srTs0JByxt041l0sI9AIjeCnKDKnUTi8QqpAdfxiV
 6RJfROXvnw8bh2yVWe5+4SMsJQVDId+2tfPhocy9RGmNkWGq5qxKXpeqUQhX0r+XAcQI
 YNnA==
X-Gm-Message-State: AOJu0Yzg2GsAaGiza0+lXngjcXYGcGLH28w9kZBf8CsKnDt8/ssDprWy
 pDiRXi3yqrL8LNJ8L4QASdCZX77sVeu2TkZgukUt6pZpK2SMb/9xL5gAQVgeNl8bTSSv5JEtIxv
 EuJB4tKYlHsI+kONN9grr5lyga7cvQx3PNUojO5wGB2pUJhZhRxujl4VDEBXd9sAj21kWkaGZPA
 cxmZUvSpT2xWx7WN41TcyuYq4JYeUPkSgLkM0/Lv5k
X-Gm-Gg: ASbGncuxe4zY6tZxwZGv9lsOsdt8+EPRTHBPRXxxcBZ5aLHYCDgUgxP2WtbUNLZ4oqP
 7uVXCmHcdWCOnYyXIbY+ZgGcbuDdmBfXlPTbU94VeFO66nBGVdPDRPtZPINw+PY4ynBoSxt8jI2
 gXwupLCOBirgbXeZMs4uSs/Df1hXNqIOTMyplY5gxwHhzQL6d4x+bmOn0BYI2VsS1j4vAhLgvYz
 qa0MePbk+mOIlT4jKsNTuWNDrjrN+TZTXjz2WfOBPwP+/1SV2yYiT3KE38AxjwMZfcs+Ln2H0DH
 paxj304B1go5QO6OEdpMjt3sy0mWv4rVGjgfGHJlh+I=
X-Received: by 2002:a05:6000:1a87:b0:3a5:3930:f57 with SMTP id
 ffacd0b85a97d-3b5f2e3722amr9638637f8f.51.1752491205992; 
 Mon, 14 Jul 2025 04:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpN4ER/MVc3ocntOVAK91nIlJUFPtS9McML9XrvTW/0Wli85ksa13lGcv/9TPQLO7TYEPjVQ==
X-Received: by 2002:a05:6000:1a87:b0:3a5:3930:f57 with SMTP id
 ffacd0b85a97d-3b5f2e3722amr9638596f8f.51.1752491205405; 
 Mon, 14 Jul 2025 04:06:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f2d3a1b5sm86609585e9.30.2025.07.14.04.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Yi Lai <yi1.lai@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 61/77] i386/cpu: Introduce cache model for YongFeng
Date: Mon, 14 Jul 2025 13:03:50 +0200
Message-ID: <20250714110406.117772-62-pbonzini@redhat.com>
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

From: Ewan Hai <ewanhai-oc@zhaoxin.com>

Add the cache model to YongFeng (v3) to better emulate its
environment.

Note, although YongFeng v2 was added after v10.0, it was also back
ported to v10.0.2. Therefore, the new version (v3) is needed to avoid
conflict.

The cache model is as follows:

      --- cache 0 ---
      cache type                         = data cache (1)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x0 (0)
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
      maximum IDs for cores in pkg       = 0x0 (0)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 65536 (64 KB)
      --- cache 2 ---
      cache type                         = unified cache (3)
      cache level                        = 0x2 (2)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x0 (0)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x200 (512)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = true
      complex cache indexing             = false
      number of sets (s)                 = 512
      (size synth)                       = 262144 (256 KB)
      --- cache 3 ---
      cache type                         = unified cache (3)
      cache level                        = 0x3 (3)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x0 (0)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x2000 (8192)
      WBINVD/INVD acts on lower caches   = true
      inclusive to lower caches          = true
      complex cache indexing             = false
      number of sets (s)                 = 8192
      (size synth)                       = 8388608 (8 MB)
      --- cache 4 ---
      cache type                         = no more caches (0)

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b3b29f69666..40f3b5eac88 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3156,6 +3156,105 @@ static const CPUCaches xeon_srf_cache_info = {
     },
 };
 
+static const CPUCaches yongfeng_cache_info = {
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
+        /* CPUID 0x80000005.ECX */
+        .lines_per_tag = 1,
+        .size = 32 * KiB,
+
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
+        .associativity = 16,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x1.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000005.EDX */
+        .lines_per_tag = 1,
+        .size = 64 * KiB,
+
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
+        .associativity = 8,
+
+        /* CPUID 0x4.0x2.ECX */
+        .sets = 512,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing = false,
+        .inclusive = true,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000006.ECX */
+        .size = 256 * KiB,
+
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
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
+        .associativity = 16,
+
+        /* CPUID 0x4.0x3.ECX */
+        .sets = 8192,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = true,
+        .inclusive = true,
+        .complex_indexing = false,
+
+        .size = 8 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
@@ -6435,6 +6534,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .note = "with the cache model",
+                .cache_info = &yongfeng_cache_info,
+            },
             { /* end of list */ }
         }
     },
-- 
2.50.0


