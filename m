Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4648C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfE13-0003EN-JV; Thu, 02 Jul 2026 05:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wfE12-0003Ds-58
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:47:28 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wfE10-0002XJ-E6
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:47:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so186009f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782985644; x=1783590444; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BHsFCClOErBCb2hCTW5Kdx5hfrAxpl2r1lI9X/xFrPM=;
 b=OECrVyns3uGmroedbcT8WA0skdnblV6RTbQyW8eFN38SQORzIYJyaivWMgptu4ljj4
 hpaXTjWxXchXBSs8DKp44ZSqJPPGnAB/RUJiZRDq9U8xsSQsu44v7oH5vgbT1i6fgdG8
 EfJ6Q3zmJGIIJJGs403S+cMFEQWQJSy6addRoMcJBBpoUznd2rhauMSZaj2NgXcriHgP
 vPRtbRZSKIZtXa8RlcvlKfSnNsDBG2gewve7oGFuBtiLKqnqsTppwc1K41POABHYEN+2
 BWnuft4mtC50+lhjtLpYDwbYs5Omo7I6Vq9sap5WzSjGeqMWLEHlhXRbeHu5gw0HSBbT
 Ngsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985644; x=1783590444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BHsFCClOErBCb2hCTW5Kdx5hfrAxpl2r1lI9X/xFrPM=;
 b=BeMp7oV0VD6ozrfx51ejga8GBC7ZFZEj2L/nW2PbKV6vmMexmZYsuVGmFD9jTOizRp
 P/D0VpmgDLdbkuM9otMmfL/RjrbIyHEHhd96avFJkSOKDfBiMRz8NmtbZNB19zskoVGu
 jfyLSlVpPmnOLLvFPagscEKuhUm4WdYd1UciAS5I3k+/YVMn2NLXSb6SV36C81d2BPIS
 7g35gKI8QKHj40BChOeah5EJWXkuc+gGu8MkZV2t1aCMIDyNK1SwSR+WC52Jcf6UxIq7
 nrC/h8P0EJsr6s8lIQEbj9iqStcmIu3zFjLMEo+BxHWTnhcf34I6P/PuI9VsxL2nXL+U
 1SFA==
X-Gm-Message-State: AOJu0YzMKTBFYStM1p7ghYnaqdejlvL53y26RIMhSBxibCzh/nbeTDAU
 KUXOVOdTG7lCCghr1nIjH/RbXL5HQa8up+AJZZPsbvNaBLKo0FAKpP9r
X-Gm-Gg: AfdE7cl/fUFyv//2MzaMDJeNkGfqAtgfMKKjeXh6b/TDn5p0jzowxpu0aTGvpPaB3w7
 eeIDtCYvgJxOAJi764zvI5Q68dep1O5ep5YMlfJfgWBu2zmOQfvc5HtpY6xiRj3oWSMonXRKb3K
 kStWz3giFTX/kPWfA8Qn93Y/6zssf/Gd+OgIUe+MxH/DZwHSSg0BjHbuwuMJY7UXYbVAmnmgkZe
 pD8hDG2kxfDkLGi8DoNo+a4ad171Ot83lCIAQ4F6XKRdo99MgtHlIA4eqU13+AsJ6xA+lycaumH
 iOysjdGJ8wB/Y5t3MhUAk6A6Ud6iiiBgiw2vS+44CuiEicjpKXuC0yazIHZq6CZt/ZmHl6CEba8
 AqMca/IzLuHWncbqT3lwcRg70VW0Skrimzr0tEFnsL3lfI/Qzkf5vA4f+VsN+R6Q5yskrLKpOD8
 tlD5VYPVgvI17cm2F6LPH25j53NXjwSPaoYR51/ZNjAg==
X-Received: by 2002:a05:6000:290f:b0:46f:9026:4971 with SMTP id
 ffacd0b85a97d-475de54e175mr13729534f8f.11.1782985644267; 
 Thu, 02 Jul 2026 02:47:24 -0700 (PDT)
Received: from RTRKN1313-LIN.domain.local ([89.216.37.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a15sm7539152f8f.14.2026.07.02.02.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:47:24 -0700 (PDT)
From: Dusan Stojkovic <stojkovicdusan555@gmail.com>
Date: Thu, 02 Jul 2026 11:46:12 +0200
Subject: [PATCH RFC v3 1/2] vhost: accept Xen guest RAM sections for vhost-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-vhost-xen-foreign-mapping-v3-1-2b8ef913382b@rt-rk.com>
References: <20260702-vhost-xen-foreign-mapping-v3-0-2b8ef913382b@rt-rk.com>
In-Reply-To: <20260702-vhost-xen-foreign-mapping-v3-0-2b8ef913382b@rt-rk.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>, 
 Nikola Jelic <Nikola.Jelic@rt-rk.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=stojkovicdusan555@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>

When QEMU runs as a Xen device model, the guest's RAM is not allocated
by QEMU and is not backed by a file descriptor that could be shared
with a vhost-user backend: accesses from QEMU go through the Xen
mapcache and memory_region_get_fd() returns -1. vhost_section()
therefore filters out every RAM section, the vhost memory listener
registers no regions, and starting any vhost-user device fails with
"Failed initializing vhost-user memory map".

With VHOST_USER_PROTOCOL_F_XEN_MMAP the backend does not need an fd or
a process-local mapping it maps guest memory itself through the Xen
foreign mapping interface, using the guest physical address and domain
id. Accept the Xen RAM region in vhost_section() so that it reaches
the backend's memory table.

The Xen grant region (xen.grants) must never be accepted: grant
references can only be mapped individually on demand via
address_space_map(), and deriving a host pointer for the whole region,
as vhost_region_add_section() does, aborts in the Xen mapcache. Note
that xen_mr_is_memory() returns true for both the RAM and the grants
region, so the grants region is excluded explicitly.

Because of the necessity to exlude xen.grants, the missing stub for
xen_mr_is_grants is added so that it can be called from common code.

Signed-off-by: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>
Signed-off-by: Nikola Jelic <Nikola.Jelic@rt-rk.com>
---
 hw/virtio/vhost.c  | 18 ++++++++++++++++++
 hw/xen/xen_stubs.c |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b52..ffc692b3e2 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -29,6 +29,7 @@
 #include "system/dma.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
+#include "system/xen.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -657,6 +658,23 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
             return false;
         }
 
+        /*
+         * Under Xen, the guest's RAM is not backed by an fd that
+         * can be passed to a vhost-user backend.  The backend
+         * instead maps guest memory through the Xen foreign mapping
+         * interface, by guest physical address and domain id (see
+         * VHOST_USER_PROTOCOL_F_XEN_MMAP), so accept the Xen RAM
+         * region even though it has no fd.
+         */
+        if (xen_enabled()) {
+            if (xen_mr_is_memory(mr) && !xen_mr_is_grants(mr)) {
+                trace_vhost_section(mr->name);
+                return true;
+            }
+            trace_vhost_reject_section(mr->name, 4);
+            return false;
+        }
+
         /*
          * Some backends (like vhost-user) can only handle memory regions
          * that have an fd (can be mapped into a different process). Filter
diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
index f830768d99..7af39bceb0 100644
--- a/hw/xen/xen_stubs.c
+++ b/hw/xen/xen_stubs.c
@@ -29,6 +29,11 @@ bool xen_mr_is_memory(const MemoryRegion *mr)
     g_assert_not_reached();
 }
 
+bool xen_mr_is_grants(const MemoryRegion *mr)
+{
+    g_assert_not_reached();
+}
+
 bool xen_map_cache_enabled(void)
 {
     return false;

-- 
2.43.0


