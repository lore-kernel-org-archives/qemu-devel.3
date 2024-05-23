Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C818C25B7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wC-0005zh-QW; Thu, 23 May 2024 11:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wB-0005tG-C3
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9w9-0004pb-F7
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRwx+emp8z1T3Io0QQVZ2C4uYnikwD6/IsL4K09fAzM=;
 b=hN6OH75dmEyya9ewZZ90m7sX9WsMSQjs5WuSNaeKsmjhURQcY40330RVJuddg7bBvW8Ohp
 QTTszXJJAueic14ZYbM7dftr8jLdEsCCr1KZsLc7PLyHBILZgTfGXDyYfg0p7JAEuz1SvB
 1Q6GdypzwYofSLSZZP/NNhUYUoO2u00=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-tmkbCu87NIe5C6VZlRXXkg-1; Thu, 23 May 2024 11:00:54 -0400
X-MC-Unique: tmkbCu87NIe5C6VZlRXXkg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a62471564a0so36928466b.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476452; x=1717081252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRwx+emp8z1T3Io0QQVZ2C4uYnikwD6/IsL4K09fAzM=;
 b=qJsMh9hFD58nr4KbrRPh8mEVku55Hd0jDHactr2vwKnoYw7HfiZT7lO5yTazAXIcs3
 H4s31vkbVT4XAw2cTTolUWYFxTN0Yo6w95uUss2Y+KZakOGIhXlYkBtkuPSqNWogLiY2
 K8mTUvrqUOnN4a4PeTFwkbGTQNDt4W9svftHRIvUjcwZ3dzLEV0E8Iv9YrEFFayPvSfi
 aZyb9zjhDvDQIvv50qtWj/CbYtMtnL5ywJL4bqDZtU8ATmHkonnvPCOzAuMhhSRSE+RL
 8Vl/GA8OAg4gnf1lNYkYzzYAEXSB6Qh3Dr0ipYkjq6aXueVLZczGKie0qWFVd+j9U0ag
 yfNw==
X-Gm-Message-State: AOJu0YzBy0KpdHqLZZdw6dUGo/iUITbO7gZiza2aXnH//cH10t/QM/Y8
 v5IWO1n9A/MhG7gTlqPSagxKNx3PExaSLpJVusP6Qpdvmg6BtWyTOO4iBU1owUA44NMHqJ29l0H
 Do2AtT3nCtSR1ubfLSxOtwRzeWue2N5+kqLtZ411aGU9yU8khcWubWpRO7sIRCuyWq/239HcOxz
 aG/ofAeRhYsSIzErdTytFlNyHM07bTXkKSfUda
X-Received: by 2002:a17:906:1854:b0:a62:2b65:1dd5 with SMTP id
 a640c23a62f3a-a622b65233cmr319045066b.58.1716476452520; 
 Thu, 23 May 2024 08:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESRppVHw6OSjrP8Qr8czZVtfHjhw7DkxPSJYwN9zh+MHrd1dc/Jhz8C9J9feD7SDDHUGnkpA==
X-Received: by 2002:a17:906:1854:b0:a62:2b65:1dd5 with SMTP id
 a640c23a62f3a-a622b65233cmr319042866b.58.1716476452207; 
 Thu, 23 May 2024 08:00:52 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a25f0d2a9sm1923665866b.60.2024.05.23.08.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Robert Hoo <robert.hu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 06/23] i386/cpu: Fix i/d-cache topology to core level for Intel
 CPU
Date: Thu, 23 May 2024 17:00:19 +0200
Message-ID: <20240523150036.1050011-7-pbonzini@redhat.com>
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

For i-cache and d-cache, current QEMU hardcodes the maximum IDs for CPUs
sharing cache (CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits
25:14]) to 0, and this means i-cache and d-cache are shared in the SMT
level.

This is correct if there's single thread per core, but is wrong for the
hyper threading case (one core contains multiple threads) since the
i-cache and d-cache are shared in the core level other than SMT level.

For AMD CPU, commit 8f4202fb1080 ("i386: Populate AMD Processor Cache
Information for cpuid 0x8000001D") has already introduced i/d cache
topology as core level by default.

Therefore, in order to be compatible with both multi-threaded and
single-threaded situations, we should set i-cache and d-cache be shared
at the core level by default.

This fix changes the default i/d cache topology from per-thread to
per-core. Potentially, this change in L1 cache topology may affect the
performance of the VM if the user does not specifically specify the
topology or bind the vCPU. However, the way to achieve optimal
performance should be to create a reasonable topology and set the
appropriate vCPU affinity without relying on QEMU's default topology
structure.

Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240424154929.1487382-6-zhao1.liu@intel.com>
[Add compat property. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c      | 1 +
 target/i386/cpu.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4a2d6f5a97f..6126bfdd2a7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,6 +79,7 @@
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
 GlobalProperty pc_compat_9_0[] = {
+    { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
     { "sev-guest", "legacy-vm-type", "true" },
     { TYPE_X86_CPU, "legacy-multi-node", "on" },
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index de1ad7270cf..3c66242f6d3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6258,15 +6258,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
+            int apic_ids_sharing_l1 = cpu->l1_cache_per_core ? cs->nr_threads : 1;
             switch (count) {
             case 0: /* L1 dcache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    1, cs->nr_cores,
+                                    apic_ids_sharing_l1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    1, cs->nr_cores,
+                                    apic_ids_sharing_l1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
@@ -8105,6 +8106,7 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
+    DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.45.1


