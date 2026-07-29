Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4104C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1uN-000703-VS; Wed, 29 Jul 2026 06:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wp1uM-0006zv-Ck
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:53:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wp1uK-0002x2-LE
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:53:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8487088510aso780455b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785322383; x=1785927183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fXZchGvDgPXp5gMcLbq1tX4EplzIqNTatppvcWJgMsg=;
 b=rXJAryGCuoMUSiQEXuGY37xh190BL40VNA5pngQpNEy37pnk7tTdjp3Jsfu/AATOPX
 UYGFGQ/VvJCIswpOiHDa37gDJL9ANP7m80Ca5KlchN5vtxJ/UWTSOOmCbhf/nKkzeABn
 TObx7PtdcRGM4MwcRsayOJOwS1eOlpFkxxroV2+tA4QKH31zVc6GBMHhYvgZGlz1WAT8
 MtOP0hDNdcgvDnY0mKfJBzaVlEIhVWTWFkzcNrnQO/SLcwPGFZ+S70cKGU60dXhqimk3
 Kikgavn/v3hoVIcvNo2G1wii5RtxNQzTEOYoU1SFNDmpxEO0kzXPL7+uaBr3wVy5fmy/
 IAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785322383; x=1785927183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fXZchGvDgPXp5gMcLbq1tX4EplzIqNTatppvcWJgMsg=;
 b=ZsuOQ/2kLlfQdf3MRpg9yZuuJbLwirXLOQOHWnwMoaavOx8LSu2gDnZLBwlaYMMTM3
 TtJDEij+J288YCnnI95cpjqxDLAI+EkYiO8CK2xTRlkZFTFvU4P9L2DF4AQix8nDtQDZ
 qK70dvYiQIFfft8/7D8ler06J9hkdi75TrOps64kiaAm1YkpbFJzJghH6gFbO7RMJrOH
 WH0edx0x32gg/OTyZ9sVuda1PA3BZ1xrEixRZ7F+z7MGfytqcSXrKlSng1fAzuW+g9Av
 y2lJB4Y7MNy8B+MmI7SPw+iRnNDF/c+dup+B1XuC7wAZoAYQjjwHwZ3TCmEL46EcOhw+
 7AXw==
X-Gm-Message-State: AOJu0YwmEGhVZl4aIcK5/FTLPmrJhYOqWrGCuGxW8p0bD6e4KEHa3uA9
 oEeuJ4tjcy4gHsipqOPrqvUNSRzqudUwRWx3jHWy9sBfmIVLU1kgVwQneNRQ0GVo3/w=
X-Gm-Gg: AR+sD13oTl8KBQazy7smVP0a0zqaRPzVvM1R+AS9YN5QNGRe8B2wQlsf+r97tTXnO3v
 DK20JZSgvglZG4NiShKMkUqKDmLh6kWz1mf14KfhjpHq3yesgQu0Xvs7kAk4vO1z8OFq8Pllj3S
 1B56BBkZS8rryKDpmmJacjElyVa8DR9iLKRG+CSifkiieGg5ljX4I0h+GUnTpgJmNTMJpB4Pyz1
 zyoomXK7dHvalM8jouOxIWL/0X3tuVbgom2VZswjnFAOe5wwbU+Fy1J+FQtbxoGqpTOkBVM3ZMq
 75BWyoBz1HoqQIFIStQFr9HX9xGnGEnWFfIuFiRnd5e7NCOQYDdEmA469ccR8QUtOB7XHZwi3PL
 UF/e9zEbS9wzBj5LJR39ZKY9E37dV73L7UQqKfr7XfZYPK3Zqooz2T36b83x1Xh+chNlLbt3lAz
 RxtPdI8hEM2Ct/Y32tB76iVgSk5U0SyVSDhCSPiUs/jVT3ONVaTe0d4H/+uIqelaI=
X-Received: by 2002:a05:6a00:10ca:b0:848:727f:2c90 with SMTP id
 d2e1a72fcca58-84e93352adamr6317252b3a.64.1785322382166; 
 Wed, 29 Jul 2026 03:53:02 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84eade11c0fsm417590b3a.20.2026.07.29.03.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:53:01 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	eric.auger@redhat.com
Subject: [PATCH v2] hw/virtio: reject inverted virtio-iommu IOVA ranges
Date: Wed, 29 Jul 2026 18:52:47 +0800
Message-Id: <20260729105247.1719595-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729045037-mutt-send-email-mst@kernel.org>
References: <20260729045037-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=physicalmtea@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Guest MAP and UNMAP requests can set virt_end below virt_start. Since
virt_end is inclusive, this is not a valid interval. MAP nevertheless
stores it in domain->mappings, but interval_cmp() assumes low <= high.
For an inverted key, interval_cmp(key, key) returns -1. A covering UNMAP
can therefore find the key but fail to remove it and repeat forever while
holding s->mutex.

Reject inverted request ranges with VIRTIO_IOMMU_S_INVAL and make the
notifier range decomposition skip invalid ranges. Keep the existing
notifier-before-remove ordering, but return VIRTIO_IOMMU_S_DEVERR if
g_tree_remove() fails.

Fixes: fe2cacae2438 ("virtio-iommu: Implement map/unmap")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v2:
- Drop migration-state validation and keep the existing post-load callback.

 hw/virtio/virtio-iommu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 533bd5073f..b7145c8277 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -210,7 +210,13 @@ static void virtio_iommu_notify_map_unmap(IOMMUMemoryRegion *mr,
                                           IOMMUTLBEvent *event,
                                           hwaddr virt_start, hwaddr virt_end)
 {
-    uint64_t delta = virt_end - virt_start;
+    uint64_t delta;
+
+    if (virt_end < virt_start) {
+        return;
+    }
+
+    delta = virt_end - virt_start;
 
     event->entry.iova = virt_start;
     event->entry.addr_mask = delta;
@@ -807,6 +813,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
         return VIRTIO_IOMMU_S_INVAL;
     }
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -857,6 +867,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
 
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -879,7 +893,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
                 virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
                                           current_high);
             }
-            g_tree_remove(domain->mappings, iter_key);
+            if (!g_tree_remove(domain->mappings, iter_key)) {
+                ret = VIRTIO_IOMMU_S_DEVERR;
+                break;
+            }
             trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
         } else {
             ret = VIRTIO_IOMMU_S_RANGE;
-- 
2.34.1


