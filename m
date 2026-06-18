Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA386CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGIY-0004bK-PX; Thu, 18 Jun 2026 13:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1waEsd-0000uD-QZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:42:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1waEsc-0006LH-4O
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:42:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so912179f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781797329; x=1782402129; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bwvkO6znXhIa5qM7wiZu9yQsBOrMOtM8ilQjUKeprio=;
 b=cLUlUeW+vT7H9W/RIlcIBQTsdEWv54bZIX3IGaLdOgF2jdZ0OfQtWtjecTyCn5qjOI
 Tit1HmS1qNAFpokelNHMpVvlZRA4BWlcqarzuKD5QhNiDNpTzMaFWn9h4OoyCWCAlvSq
 nIatKub/4jddFBGIuprGCVXFlUAAood+6hy3OmDcZlc6HfZN0c5eLPltJgPXieSPUgOT
 paClfIfHYV9gTIGYejoZEDY98xsvUfHx6Csg7KJvY2IHxySrx0mFQaxsubjOF/6/ENL3
 S6AawywUUVOlpQuC86u8cilpI7mn7emM2cW5a4KtnveewxumE4Pc/TKILKvJd+GKX19+
 1F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797329; x=1782402129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bwvkO6znXhIa5qM7wiZu9yQsBOrMOtM8ilQjUKeprio=;
 b=d0u0Y2K5y8EQVxUQW08g6h9YbdLtf/2zN05wUgCtjQ591jK9PBiCcdBu2oGLvo0qfY
 T0cNLMijEzmthJQ/1AcWKmHqfmBK6B3QDf7bidasAlvwUctum8etJ8MoUHKs5jf+tC+7
 U0WRdljq8CX3HiKQNiR5pKhUTuzLFNBKwVI+2adWdD3mnEsCxMeyWXPbkxVW/Re/UD+U
 UXgWgStHcpbPz6XQBBwUw+WZ3R1BEPiRXkQT0aOoc874TCfJtHKz1G1m+7C5h0OJNX4A
 wom1Sh0PBz1H2GoLLCuC/+8LhXBf8TNy1p/vCGuZ8Jbncb/Cjjyx5oLzaYO+zfJOcuEE
 u6PA==
X-Gm-Message-State: AOJu0Yy76ILe4Ba4NqEavUYo33dEsrn7NozAuun7WBWZWh3daFreLAhh
 CRTKS6hjs+s8DBGvZYWbUmurSgxei7rl2FLcl/KNH4BtThHRHfIfVCpn
X-Gm-Gg: AfdE7clwy5hXLjQFL6pG5YE91IZXVO6YVmghLwzQ0yFdpK9OKcjA0NrRQVXWOKBqRBS
 tiW13gwlq4CVNAe698RN8fvyydd335oGh8u2jIrd2CuVsrZbJnG5CVOi1CkSkv1Um97UgNeDFuT
 cv9K+kH0QyvdrQ6js+ULK1Re16xYBnc68ZAA6nmf5cvvcVJFL0uzeKqhexq3Wzqs2Wwv5384xZ5
 BBiZcEnL298ekG64eKURwuyWn+wd5X9rvvtens+RVfHgoSxofU6EW08wLWKKu4XPLWUzPkuQkDK
 DPUJl6/LkGoxlQ4m/3NfnJzNbKVNSwX48fXO2tEimSbO/1gOwR0pUsk0sOwnpNayeIKYIiyTiRd
 FzYwYvb3EFk7yj1NHZtHK8h2bR/CR17vVH8Ss19yiC6Z5PtPwgu4DzK00IonmRXrzb728JTeOxd
 cGoOwRjvkSdXHxaG3S6FGb0ELmYFJqQBH0LqleA+6BUTMCUQpWOGxf
X-Received: by 2002:a05:6000:2382:b0:45e:df08:b02 with SMTP id
 ffacd0b85a97d-46240cf9461mr15122509f8f.28.1781797328378; 
 Thu, 18 Jun 2026 08:42:08 -0700 (PDT)
Received: from RTRKN1313-LIN.domain.local ([89.216.37.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm69038581f8f.28.2026.06.18.08.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:42:07 -0700 (PDT)
From: Dusan Stojkovic <stojkovicdusan555@gmail.com>
Date: Thu, 18 Jun 2026 17:39:36 +0200
Subject: [PATCH RFC 1/2] vhost: accept Xen guest RAM sections for
 vhost-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-vhost-xen-foreign-mapping-v1-1-7f60a6241971@rt-rk.com>
References: <20260618-vhost-xen-foreign-mapping-v1-0-7f60a6241971@rt-rk.com>
In-Reply-To: <20260618-vhost-xen-foreign-mapping-v1-0-7f60a6241971@rt-rk.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=stojkovicdusan555@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 13:12:59 -0400
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


