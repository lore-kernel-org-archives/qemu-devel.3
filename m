Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E3BC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wG-0006K5-84; Thu, 23 May 2024 11:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wE-0006BX-9P
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wC-0004q0-Gv
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dhR+PG6+GRe0tqU2xY91A0UG6wm/n7V1mcWWHwIM7U=;
 b=VYOytKUpSCMqnMPylSsxzJkXFB9vNti+DG6iQfraJlPj6hMft6fFx5JOa8n27ITVzhGbPx
 Fz8kiZmTwue4o37lSkBDaz70t46C2ibMD0EwKJ87CKDkoMHi0KqaaQLGZZYsPz5ZOIx2Uq
 ++X4ky2EJ+DN+GcWJG+iXD/qPYll7l0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-nKncs6TQMNe_z5TIqsgd9g-1; Thu, 23 May 2024 11:00:58 -0400
X-MC-Unique: nKncs6TQMNe_z5TIqsgd9g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59a63a1f78so121023166b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476457; x=1717081257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dhR+PG6+GRe0tqU2xY91A0UG6wm/n7V1mcWWHwIM7U=;
 b=IhTnB+AG+3USPTOhQYoo3Li8R29wOJ3hMqNVir5v9vuf2TIcXivCst/tnCd6OKR7su
 KnBbwCh9RbnpAyLzjG/09Yi9bb78BPhs/VmfSRPWeAR9Q3EO2cCO42pDU1+PkNn3/pFT
 m6a6jJjcDaLH6H9nohHHdgkLR3xaUc+Tbab2Mw/SSIPrPPAK2A8xc87Swr6T6JQVFfVq
 UCdK70JrK3tqjatIFz7OE/kucC73Q6IOpYlT8Ug5LEyzEDaP3DebZlUymKKPeLTtFf/X
 ib7y2OOHfMywXwIDCYKpC0VL6wqyufjl8g5YlDKRRKlmukQE0SC0UsHz82mlDojv2I8g
 VG5g==
X-Gm-Message-State: AOJu0YyvAKIwkr9Fo06NEVobbaN6RrHMjag6dIqDdoxcMA2iwz7j3/U/
 rQZnwguzdhMDe4WvLV1jKx14Nr270ArfzUHn1PzTNW/82AzJguHFUNmtBjLy7uko+2qzKJOjE+9
 SwvuBw4WznFrEaPhatfQJtWvFYQaepilYg9MpfJ9Yo57gPFIakmXB+ZnsqvyRFF/qSqgnYjGge7
 NrVg2BfqOsv1/QrO1D1hNSeASoU5HJw5d7b3TQ
X-Received: by 2002:a17:906:f2ce:b0:a62:c02:425a with SMTP id
 a640c23a62f3a-a62281c804amr373192766b.74.1716476457140; 
 Thu, 23 May 2024 08:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Jd+10a5QOCxHN7FohL3jqfVV9WJ8VXZOV2ru77aqUuREjvc7MTQZGWfAb3XrQ/quXCGoUQ==
X-Received: by 2002:a17:906:f2ce:b0:a62:c02:425a with SMTP id
 a640c23a62f3a-a62281c804amr373190166b.74.1716476456742; 
 Thu, 23 May 2024 08:00:56 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01785sm1942379266b.164.2024.05.23.08.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 08/23] i386/cpu: Use APIC ID info get NumSharingCache for
 CPUID[0x8000001D].EAX[bits 25:14]
Date: Thu, 23 May 2024 17:00:21 +0200
Message-ID: <20240523150036.1050011-9-pbonzini@redhat.com>
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

The commit 8f4202fb1080 ("i386: Populate AMD Processor Cache Information
for cpuid 0x8000001D") adds the cache topology for AMD CPU by encoding
the number of sharing threads directly.

From AMD's APM, NumSharingCache (CPUID[0x8000001D].EAX[bits 25:14])
means [1]:

The number of logical processors sharing this cache is the value of
this field incremented by 1. To determine which logical processors are
sharing a cache, determine a Share Id for each processor as follows:

ShareId = LocalApicId >> log2(NumSharingCache+1)

Logical processors with the same ShareId then share a cache. If
NumSharingCache+1 is not a power of two, round it up to the next power
of two.

From the description above, the calculation of this field should be same
as CPUID[4].EAX[bits 25:14] for Intel CPUs. So also use the offsets of
APIC ID to calculate this field.

[1]: APM, vol.3, appendix.E.4.15 Function 8000_001Dh--Cache Topology
     Information

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240424154929.1487382-8-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f3d2b8053b2..22a8ca1c9b4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -331,7 +331,7 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    uint32_t l3_threads;
+    uint32_t num_sharing_cache;
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
@@ -340,11 +340,11 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
-        *eax |= (l3_threads - 1) << 14;
+        num_sharing_cache = 1 << apicid_die_offset(topo_info);
     } else {
-        *eax |= ((topo_info->threads_per_core - 1) << 14);
+        num_sharing_cache = 1 << apicid_core_offset(topo_info);
     }
+    *eax |= (num_sharing_cache - 1) << 14;
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
-- 
2.45.1


