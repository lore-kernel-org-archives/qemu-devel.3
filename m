Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6388BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wr-0007tA-Dp; Thu, 23 May 2024 11:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wZ-0006uF-Oc
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wV-0004sU-O0
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zjn78Uv8g1mrAzf1P1t6HoPbVp5Vv3EdDmYpZxErxf4=;
 b=eMcvl4i6vh6M7wt9J8Y8FCV6V9je0W35++hP4BfscEQEEzAFR+cCtNR2fbff8t5s2VdR+n
 +sMrbJE9V9tpHk8+i2l8lMsERfBfPqYYD51F+IJ07aqQlQqahH3D5D+BJ1MxAVMUpeKo1O
 oUpOqh9CAdv/TPFnCdxLdbmbLem5GDc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-BP_jdfLtMtCbBxNwuLMyVA-1; Thu, 23 May 2024 11:01:17 -0400
X-MC-Unique: BP_jdfLtMtCbBxNwuLMyVA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-574ec1882f6so751468a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476476; x=1717081276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zjn78Uv8g1mrAzf1P1t6HoPbVp5Vv3EdDmYpZxErxf4=;
 b=E52OphhfOWilJkZiTceNGh8+F/bZ/ER/SxdmiQkGlGm50qzVCVTxT7XuAYzf5AHwzF
 Sq5BMb+XJ0/UOINx+0lRdR2iDTAPkTYVXa/98pWMyPLT1+uTAhRMyDY9L/nkv/ZPJ78y
 e1qR6HyM4q5FEKrO+G1Vy4qtJ1dBNyEThxJoSOybOygp+0aqadBIAIKny4fmR8GIuVFK
 mQkIhYv9VaXAxl5g561+Uhp0gJOvhB8e78grU0xWGbEu0QJ5bF/oXNJN3qjAh3hwBlay
 Mz6KE1QlAJy4K7FVhz0+9os1fsQ16jcScprGvHchH+DkL+xKUpmyh8V1elvwV/hlwEYu
 UAnw==
X-Gm-Message-State: AOJu0Yy7cpWyift2YMY3CGq8KTBqunVz2Tre6plSpLUOulEJts+yQRSf
 q4mypoavWtBd3VL1nBPpB8+KB3eRma63ioM9F9hs71oRMnk/7rMGFiVAQzjQVkFr9nvEnC7FhJd
 SCy9xrrbBdG1i3T+Y8tVg37+8pd73jMCdzXx+xSoNFShI0wL91x0R3sSF23sIP1HZWW/gap+A//
 8+O/DUB3JdWFIwQD1ZyXhQQLDiBTCi+odcFThF
X-Received: by 2002:a50:f602:0:b0:56c:d35:1775 with SMTP id
 4fb4d7f45d1cf-57832c57587mr4966626a12.35.1716476476389; 
 Thu, 23 May 2024 08:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtFZorqbyL5I94Z1GGOnlk03DvesHcab5O6AHtgWqgpsMtWk30WzOSxAhgmLj6wVqzJun62Q==
X-Received: by 2002:a50:f602:0:b0:56c:d35:1775 with SMTP id
 4fb4d7f45d1cf-57832c57587mr4966596a12.35.1716476475934; 
 Thu, 23 May 2024 08:01:15 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574f26d1574sm12465022a12.36.2024.05.23.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Babu Moger <babu.moger@amd.com>
Subject: [PULL 15/23] i386: Expose module level in CPUID[0x1F]
Date: Thu, 23 May 2024 17:00:28 +0200
Message-ID: <20240523150036.1050011-16-pbonzini@redhat.com>
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

Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
erroneous smp_num_siblings on Intel Hybrid platforms") is able to
handle platforms with Module level enumerated via CPUID.1F.

Expose the module level in CPUID[0x1F] if the machine has more than 1
modules.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-15-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/topology.h | 6 ++++--
 target/i386/cpu.h          | 1 +
 hw/i386/x86-common.c       | 2 +-
 target/i386/cpu.c          | 6 ++++++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 7622d806932..ea871045779 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -71,6 +71,7 @@ enum CPUTopoLevel {
     CPU_TOPO_LEVEL_INVALID,
     CPU_TOPO_LEVEL_SMT,
     CPU_TOPO_LEVEL_CORE,
+    CPU_TOPO_LEVEL_MODULE,
     CPU_TOPO_LEVEL_DIE,
     CPU_TOPO_LEVEL_PACKAGE,
     CPU_TOPO_LEVEL_MAX,
@@ -198,11 +199,12 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
 }
 
 /*
- * Check whether there's extended topology level (die)?
+ * Check whether there's extended topology level (module or die)?
  */
 static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
 {
-    return test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
+    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
+           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e79293158a0..196b068614c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1024,6 +1024,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
 #define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
 #define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
+#define CPUID_1F_ECX_TOPO_LEVEL_MODULE   3
 #define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
 
 /* MSR Feature Bits */
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 994f8424889..34dfa894879 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -273,7 +273,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     if (ms->smp.modules > 1) {
         env->nr_modules = ms->smp.modules;
-        /* TODO: Expose module level in CPUID[0x1F]. */
+        set_bit(CPU_TOPO_LEVEL_MODULE, env->avail_cpu_topo);
     }
 
     if (ms->smp.dies > 1) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92aa4498551..4aea6e3dd24 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -277,6 +277,8 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
         return 1;
     case CPU_TOPO_LEVEL_CORE:
         return topo_info->threads_per_core;
+    case CPU_TOPO_LEVEL_MODULE:
+        return topo_info->threads_per_core * topo_info->cores_per_module;
     case CPU_TOPO_LEVEL_DIE:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die;
@@ -297,6 +299,8 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
         return 0;
     case CPU_TOPO_LEVEL_CORE:
         return apicid_core_offset(topo_info);
+    case CPU_TOPO_LEVEL_MODULE:
+        return apicid_module_offset(topo_info);
     case CPU_TOPO_LEVEL_DIE:
         return apicid_die_offset(topo_info);
     case CPU_TOPO_LEVEL_PACKAGE:
@@ -316,6 +320,8 @@ static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
         return CPUID_1F_ECX_TOPO_LEVEL_SMT;
     case CPU_TOPO_LEVEL_CORE:
         return CPUID_1F_ECX_TOPO_LEVEL_CORE;
+    case CPU_TOPO_LEVEL_MODULE:
+        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
     case CPU_TOPO_LEVEL_DIE:
         return CPUID_1F_ECX_TOPO_LEVEL_DIE;
     default:
-- 
2.45.1


