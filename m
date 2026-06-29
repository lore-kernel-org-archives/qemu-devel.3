Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0161C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9Xe-0006tj-RK; Mon, 29 Jun 2026 06:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1we9Xd-0006tJ-3k
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:48:41 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1we9Xb-0006VT-FP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:48:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-46066e640easo1679398f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782730117; x=1783334917; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bwvkO6znXhIa5qM7wiZu9yQsBOrMOtM8ilQjUKeprio=;
 b=RqK5LxZ+pU6WDDxj1YeoIK2aqmeguCKOmI3DlIRecy3p6FQPcxl7OqutG6jTvaHJmn
 q098Q/2RBSIWFOWSM1N5IY/2Bg9sfzbaV5UFJTdhF4P21Eqy46kHbLMLCqeHLXdzmPRq
 P+mstW4hZhlpnwNSst+fRrQIePB7Vzf4+r7EMNJp1gLI7/YQ+rV2CpQwMja4HCZ066o6
 N6S5O2vbh+umz0go7DRrWYKYX1y1QeFeTJ6SYIi/Zb8odkk0oSOpfjZP6GbP05rFepNk
 qI+3h0uHPO857SKtnvw0arRx5uAVYbDU4wmxGmR6lJ+vKhZM2arEj8t2W7k767jiu6Ou
 jHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782730117; x=1783334917;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bwvkO6znXhIa5qM7wiZu9yQsBOrMOtM8ilQjUKeprio=;
 b=rZTE8K2KOmdPFANtqtPjSYe0ktjHQovC8HSv6A+o1ttZH+86nqEHOzV3ee2/tw0KB+
 BL2x2wZ2XfL0RPCXTQLBo4F0Ugc/jvzzon38KORhIy52HOuJu87Jw0HBKCoEfGpmxN43
 qOnqTHapCzGy2VdMpClj7RVdsDgCKMe84kNlKnDvkuvqrb++K+UfOniM0D55ULnREkPh
 G3krJ/QXG8qVJ4IHhu62E8LXmaRH2/bbdOty1cGVUtwrE4vegKZGsKb++fpz/JC4w0wg
 8n1Y/SbBJRp1LUSp+tu1oPCF4Db7A0gwpmu2WqaT/OZnQIFg5Vt+C3rNEEPk20K3jyuy
 5KvQ==
X-Gm-Message-State: AOJu0YyyW9SEPopK8KySbUqjbgODLyeWVzcTQpDqLRTJlYBbVtkg8pxI
 5JIlCTXEQmLPf+1BTIxDJdv5bjF4rAWYuIg83qSXXKlCSaJpO0tsVe1f
X-Gm-Gg: AfdE7ckzQMn5geEZeI3ZvJRlTvlZQ/iPs2DvYT13/mcUw2e0OUcpHCOf1i87MRL3CD7
 KH9oIB0YdUk5vNYAEkzgaNptQ5fjNyMEzdW5bk/vaiXSjrduaNgcRA4/fzGam/bJ7yycjmnIAw3
 a0/f+zMdRsoUqQ13Y9OtsB+//IqzmEjfgM0Av/VWiKDAJfR05f1951kd2/zKLLiJvQd4mkKDrM8
 iYhRn3hD8L31ARWw7Duh69Id4yBGbeZwcfigsUY6eIXiTg8VkPovR/9WEZWVDQbVBBV6MIRs6xm
 vj7OZmJK5WOlnkIEeqCXswkPeNX4TAb5xz5jWISiRfoKyQW5VuyQJXwYuiKz8N84Q+syMCHARmW
 RQp/rCG+HX1zutZ8YG6G/caghBflZey490uyr65GWZ/4bDCywRR/3IDgQhfTUciVIIGAmSbCU/8
 8Ts5VoKVKQ4zbdj/uV+ktciUPxyEAPme+uIirUfLv6RP6RyT/3Trv3IBbsUipIcc+sEyxNclgcD
 e32wa/5+7lGiGOFr4ny
X-Received: by 2002:a05:6000:18a3:b0:473:975c:4fd1 with SMTP id
 ffacd0b85a97d-473975c51admr5618332f8f.25.1782730117239; 
 Mon, 29 Jun 2026 03:48:37 -0700 (PDT)
Received: from RTRKN1313-LIN.domain.local
 (cable-89-216-248-190.dynamic.sbb.rs. [89.216.248.190])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46cf775a4f0sm39691675f8f.17.2026.06.29.03.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 03:48:37 -0700 (PDT)
From: Dusan Stojkovic <stojkovicdusan555@gmail.com>
Date: Mon, 29 Jun 2026 12:46:25 +0200
Subject: [PATCH RFC v2 1/2] vhost: accept Xen guest RAM sections for vhost-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-vhost-xen-foreign-mapping-v2-1-19e4685e7575@rt-rk.com>
References: <20260629-vhost-xen-foreign-mapping-v2-0-19e4685e7575@rt-rk.com>
In-Reply-To: <20260629-vhost-xen-foreign-mapping-v2-0-19e4685e7575@rt-rk.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=stojkovicdusan555@gmail.com; helo=mail-wr1-x42d.google.com
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
index af41841b52..26770d06d5 100644
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
+         * be passed to a vhost-user backend.  The backend instead
+         * guest memory through the Xen foreign mapping interface,
+         * by guest physical address and domain id (see
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


