Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2348BCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0XB-0006aY-Kl; Thu, 23 Oct 2025 14:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X7-0006Ya-NJ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X5-0003E1-9q
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YB+xOGWDMtE1OJfHdAxqd5sOxAtxUDFVH7AXA1Dk0w=;
 b=XAbm0SPEe82jc3R5zhMZ08f4m50qJs3EdCnDR3uL5z7+j3mE+8ZkbLuEHM1gvteVj1G+ZC
 r7IbB9ekbtZrkXvp6O+hAvUk56YwMqmon7hFf8cMypcGm/2XTnbwzNBHkoMZawiL+9jBey
 b/S7Yu2uV2NtV9RzIswJHi9OXP177zI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-xqi5XLMZMOeBPxshN1nXRg-1; Thu, 23 Oct 2025 14:59:28 -0400
X-MC-Unique: xqi5XLMZMOeBPxshN1nXRg-1
X-Mimecast-MFC-AGG-ID: xqi5XLMZMOeBPxshN1nXRg_1761245968
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-890f1090e81so341667085a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245968; x=1761850768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YB+xOGWDMtE1OJfHdAxqd5sOxAtxUDFVH7AXA1Dk0w=;
 b=gZ7AA2t21JD9Vl4NiRjDALGD6yI4rqJwkLOo1aDyDmQNZ1Stdhsw4MiX7TY28/7JB+
 IwmFHZUQp02coOcpWISqN/xcAYk3/JJMxKcsGqSkxd6tjy/nAmUwNadC63pk7cVRYZ5s
 XWM7T6zOOqbpJh8z+dpNf8uuvc1uAUMh8XRATbilQ1mAGTw6vGYxR5Cj+NhcSjYmhj0Z
 o3U9gavuXwb+pT0yZcWijTYSHrArXnwh3y91iwcv2Ptz309qyOOLV6HJ/+0R5pWK49b5
 jvurlawFq4LfGmmDQwZ3T2mXWJMqBBtmxjkdfqLTAaUQyC09yA/For+ef52XYUWLWjdp
 +VrA==
X-Gm-Message-State: AOJu0YzaAoJZkaCek6tX1TPVEDIPcg5fQ2YTU06Xbvu2yjhSrJYY9h5K
 tFld1bCSBusfLPMWGBqjLSD9W/qJ6/n2BklxF14f7UQRBiwQ1tAAXE5Ixb4wBKtJlOqvse2rFTx
 BE1bZtmQh5x/c+969/OAOxHfgt7Y+Gcyi53LPRFzWd1vwEk5J9++4nn4HRU476fxGbrg9uVwlW6
 RGxb9fBSS+blSzhipYx5FougkDRJt/5gRq/GstFA==
X-Gm-Gg: ASbGncs7s+9kZWtpjdmc+KmtTe9LKcBKs2Wc6hROuugoD3qOs1zB2vweaT3ydW7qa1Y
 cVRJx/1h7T9vzXtavUVp19ppcIpsBsi4DwgktUwkqbA08YPXC4ng8kRyb2cfC9huv6YryVkqNJJ
 gxNisVlF2iM1YHqdFsGYRL9O6/qlVNrBdujXwOEi48wz7Rov8ZYHr1NUBFHkGWi7nROyORXu6X0
 QrwfAF3zZRzB9s+MUL/pzlFKGXbaxmaejDC2IEaH5sFvhALF1u8AwoA2kujzrCpMJC2P2v+lQEU
 JxWM29KwQlVGvRMeFr8IshvbDEQ5BVy6SbPjjFxbBzoSw83uNuEBtIFSpR7GLiPf
X-Received: by 2002:a05:620a:2586:b0:844:c04c:6a9f with SMTP id
 af79cd13be357-89070603bf9mr2770581685a.72.1761245967588; 
 Thu, 23 Oct 2025 11:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6w20327bFVAP6AIV1bCFZSr9pU4iSoe5jW81ZihAUC2O5/zPeIQUWvu/dTLlswfo3XpO7+w==
X-Received: by 2002:a05:620a:2586:b0:844:c04c:6a9f with SMTP id
 af79cd13be357-89070603bf9mr2770577885a.72.1761245966971; 
 Thu, 23 Oct 2025 11:59:26 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 7/8] hostmem: Rename guest_memfd to guest_memfd_private
Date: Thu, 23 Oct 2025 14:59:12 -0400
Message-ID: <20251023185913.2923322-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023185913.2923322-1-peterx@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename the HostMemoryBackend.guest_memfd field to reflect what it really
means, on whether it needs guest_memfd to back its private portion of
mapping.  This will help on clearance when we introduce in-place
guest_memfd for hostmem.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/hostmem.h | 2 +-
 backends/hostmem-file.c  | 2 +-
 backends/hostmem-memfd.c | 2 +-
 backends/hostmem-ram.c   | 2 +-
 backends/hostmem.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 88fa791ac7..dcbf81aeae 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -76,7 +76,7 @@ struct HostMemoryBackend {
     uint64_t size;
     bool merge, dump, use_canonical_path;
     bool prealloc, is_mapped, share, reserve;
-    bool guest_memfd, aligned;
+    bool guest_memfd_private, aligned;
     uint32_t prealloc_threads;
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 1f20cd8fd6..0e4cfd6dc6 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 3f3e485709..ea93f034e4 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -60,7 +60,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 96ad29112d..6a507fad77 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 35734d6f4d..70450733db 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->guest_memfd = machine_require_guest_memfd(machine);
+    backend->guest_memfd_private = machine_require_guest_memfd(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
-- 
2.50.1


