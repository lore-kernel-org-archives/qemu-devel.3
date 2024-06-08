Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269D8C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXo-0000qQ-OX; Sat, 08 Jun 2024 04:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXl-0000oq-9G
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXj-00005n-Mx
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+zNUQYGJES8crbafCkZ53AktXNZOWTGmFeVSXVIck8=;
 b=PNYNrECTA7NkEZcaIs2+uowXg4bOgBDOhzEv3WV0gqpCqSTQ5wyWqLyhkfKoZXsBWxQ0iA
 vsz7MGQ5MLfUXahlV1C6rznao7XhRMyTZUgYrHgLtYH8bn3EUMjT6xGhcGWkhCZA80InGI
 FpTIuciDGwi7LI6/gg4gdwhA+dVmOcE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-Un4juinENE2mJ1vlXICwig-1; Sat, 08 Jun 2024 04:35:14 -0400
X-MC-Unique: Un4juinENE2mJ1vlXICwig-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6efac81377so29300566b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835712; x=1718440512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+zNUQYGJES8crbafCkZ53AktXNZOWTGmFeVSXVIck8=;
 b=Lb+/+GrClYoLFR4mb8+QQakj24WJy9+CDOSzwpZBBwn66WdLiQBYs71vLesjRXmzHL
 1E4O2u7ofRKL0adrWKo0sZHeTZ7d2eCAtrajXRq4STrBqdJW1GVDxPz23eCenUm1pnh2
 GWqje9oVRz7fPvg2bxw4jDf5f/++IXmkmuRN+rwL/njUviR+KzhX8gMVt0ajOWT4AUe1
 F6777WvzI2pl8G1brODPujUlKY9lubtDsZEsBg4MIi1MaUOX9KhwB3j0oPDlxtwGQg4b
 90ZbN2gyAlf/aDL6vLXtqzmche3Z8aliYkAD+ApfAkA9YpWYa6tmhHTwjoFucSchu9Ki
 +V+w==
X-Gm-Message-State: AOJu0YxRSPNfENbjlKx6OtDsW//V8YN/PP5qV713BQv9CnYXioi4dN0w
 d+GB4pbBawgTmuiJbEgtBVsNuJMbEuNdfI+IFlxf3MP9ZqWrHFShI8qegPyilO+E4A1QZIIbElZ
 M2qJolVTPDC45Z1TdWOdK3pKG1AcRkSivlYiUY4iZozvG+/jikaTV5QpbpN8lLJE8YxbdJfGpfu
 qLbZmqlSCjnmLLg1c08KbvzDDCfIUI0LsS0Hqj
X-Received: by 2002:a17:906:2994:b0:a52:6159:5064 with SMTP id
 a640c23a62f3a-a6cdaa07629mr389087466b.52.1717835711635; 
 Sat, 08 Jun 2024 01:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGadBG25tmTeHs93eaO1weQMQpX/TLuHhYhDuYPg2Bw5thrT4A1K+2x+BLSrSpck6iTt7oqDg==
X-Received: by 2002:a17:906:2994:b0:a52:6159:5064 with SMTP id
 a640c23a62f3a-a6cdaa07629mr389086266b.52.1717835711239; 
 Sat, 08 Jun 2024 01:35:11 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0c410d31sm28937666b.73.2024.06.08.01.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 20/42] backends/hostmem: Report error when memory size is
 unaligned
Date: Sat,  8 Jun 2024 10:33:53 +0200
Message-ID: <20240608083415.2769160-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michal Privoznik <mprivozn@redhat.com>

If memory-backend-{file,ram} has a size that's not aligned to
underlying page size it is not only wasteful, but also may lead
to hard to debug behaviour. For instance, in case
memory-backend-file and hugepages, madvise() and mbind() fail.
Rightfully so, page is the smallest unit they can work with. And
even though an error is reported, the root cause it not very
clear:

  qemu-system-x86_64: Couldn't set property 'dump' on 'memory-backend-file': Invalid argument

After this commit:

  qemu-system-x86_64: backend 'memory-backend-file' memory size must be multiple of 2 MiB

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Message-ID: <b5b9f9c6bba07879fb43f3c6f496c69867ae3716.1717584048.git.mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hostmem.h |  2 +-
 backends/hostmem-epc.c   |  1 +
 backends/hostmem-file.c  |  1 +
 backends/hostmem-memfd.c |  1 +
 backends/hostmem.c       | 10 ++++++++++
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 04b884bf42a..de47ae59e4b 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -74,7 +74,7 @@ struct HostMemoryBackend {
     uint64_t size;
     bool merge, dump, use_canonical_path;
     bool prealloc, is_mapped, share, reserve;
-    bool guest_memfd;
+    bool guest_memfd, aligned;
     uint32_t prealloc_threads;
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index 735e2e1cf84..f58fcf00a10 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -36,6 +36,7 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
 
+    backend->aligned = true;
     name = object_get_canonical_path(OBJECT(backend));
     ram_flags = (backend->share ? RAM_SHARED : 0) | RAM_PROTECTED;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 3c69db79460..7e5072e33ef 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -80,6 +80,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         g_assert_not_reached();
     }
 
+    backend->aligned = true;
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 745ead0034d..6a3c89a12b2 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -52,6 +52,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
 
+    backend->aligned = true;
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
diff --git a/backends/hostmem.c b/backends/hostmem.c
index eb9682b4a85..1edc0ede2a5 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -20,6 +20,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
+#include "qemu/cutils.h"
 #include "hw/qdev-core.h"
 
 #ifdef CONFIG_NUMA
@@ -325,6 +326,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     void *ptr;
     uint64_t sz;
+    size_t pagesize;
     bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
 
     if (!bc->alloc) {
@@ -336,6 +338,14 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 
     ptr = memory_region_get_ram_ptr(&backend->mr);
     sz = memory_region_size(&backend->mr);
+    pagesize = qemu_ram_pagesize(backend->mr.ram_block);
+
+    if (backend->aligned && !QEMU_IS_ALIGNED(sz, pagesize)) {
+        g_autofree char *pagesize_str = size_to_str(pagesize);
+        error_setg(errp, "backend '%s' memory size must be multiple of %s",
+                   object_get_typename(OBJECT(uc)), pagesize_str);
+        return;
+    }
 
     if (backend->merge) {
         qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
-- 
2.45.1


