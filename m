Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEBCC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woy9D-00053a-Cb; Wed, 29 Jul 2026 02:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1woy9C-00052F-3L
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 02:52:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1woy9A-0007rz-4H
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 02:52:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so469203a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785307926; x=1785912726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZYGjUuQiuRV7YhV61sT40yToB5ErVWpo9yoY2GDkffo=;
 b=EqE/sp8GKUaIdz4i5q4pD4v17hz/7SXvJrD4XM/OcYTZ+MflAi1AwGhFWmQPfoXW5x
 G6AvjJAcugGnDYmjGCYhp8+EO9ppsx22nDl1fdvJ1dwV+AAcvIJf7pZw0CN+jmpwXa/q
 ufbWuS4sj+vX6ywGUegJlTpDP8qbCS9fEuqnOkq8kYK1TT37eb0h+oRgebRzU/xMJd4m
 Y+65ExxGbPueAGfJWiZTYNeCjiqteXwfWCYHkhGplcpZOs5awkE36U376nOGJOB7Vt/3
 qyAxwRUYph7sNMgyPzOO318saPYc7a0wtZ9uh7wiewYvieHDpVuLS2Yo6rJBT5QTTV3H
 ABFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785307926; x=1785912726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZYGjUuQiuRV7YhV61sT40yToB5ErVWpo9yoY2GDkffo=;
 b=cVAdcNbQk0Tos9W+tKpKPXMfYlPuJbvyam/tlxMnx9bVJau4RLg2/xqFVshsaoVUe7
 JSGu4xqfAzHA60IVLaZ65lU7zTkHWOGf9R4K97HNnH75wfdErANkNJ/RY8tg9WiqDnIW
 Y1n5bsrQVTaPHw/Cw1hhbtu1QCrvieM3yDP6AavlgtHGOMiUrMhuxQ2DTd0uLXuKmWyC
 Z21ImizW7lbmm7C+qbFN7k2v1taabHpPm2dY82Dy2SYDSmI9/0lzJnmGB9qZixsx2/T6
 okW9nKTNpBdNYBY7DJCNbRcF0XI86k4cDUzKD7mUFWRpIT5vRYThpOgtoNFPe0NxuTzs
 5frg==
X-Gm-Message-State: AOJu0YxlkWGPuxJ7f2CnzLiDi7vHLcyUWjXU4ZiNCEXKCP3HouGXIbeg
 EnJ9d0bkKKDFBjktaMvzdjlnJNZ7FE1pRqIZ24TforuOxHFCq2GonOeD9jf50BQwI40=
X-Gm-Gg: AR+sD13XYMAsM1c35GUChJxhmvb3lvzu0idrlc07LjqC4Sv5F0FwLrhw2jWHBPcLW8X
 sv9dWECMpb18GGOIpTW3LdZixwbxPDt40z+e/+qv9YDaqGsssCNOTF909Fns8xnV+08ADQpTNRy
 OiUosOS3dnXAyov5D7KEjR0E2kYPlo9WMyPuvrC/2gjU9cZ5kzNEjZ38qQhNjWQowDnVJfC8mm/
 FDMsT4xzlHEpXXwr+/86uEoavilcrG/OnDHsQVp1FvUfmAJov6BNOFIDiW/IugbaW8EZ0i2R+dV
 KHFn73/FPz2ZVSOjoAqSabCf/HK+NT80f6e22ydvFzk3HOj9U1X/wBRYREeLn/864OwbK/dmVEC
 760l7qmO2bwblKDceq+PDNez01ucbhZvU+1gMw8BYL+TvbMHuxDSWbMdPDLeWd5ZbTOXCOVK0b1
 6T88/GeTVjq8GSMZ1rNMokV8Lr4rBV/AdIqomoOBSWvmntoKj0l4vgTKYX+i5VUN+ZTD6q7n16T
 R4=
X-Received: by 2002:a05:6a21:9e0f:b0:3c3:83e8:c211 with SMTP id
 adf61e73a8af0-3c8ba63ad14mr6418244637.63.1785307926088; 
 Tue, 28 Jul 2026 23:52:06 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e72745b1bsm5914218c88.14.2026.07.28.23.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:52:05 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: eric.auger@redhat.com,
	mst@redhat.com
Subject: [PATCH] hw/virtio: reject inverted virtio-iommu IOVA ranges
Date: Wed, 29 Jul 2026 14:51:53 +0800
Message-Id: <20260729065153.1718783-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=physicalmtea@gmail.com; helo=mail-pj1-x1029.google.com
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

State produced by an older QEMU can still carry such a key over
migration. Reconstruct endpoints first so failed loads can be cleaned up by
the normal reset and unrealize paths. Validate every mapping before switching
address spaces or scheduling command processing, and reject invalid migration
state.

Fixes: fe2cacae2438 ("virtio-iommu: Implement map/unmap")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 hw/virtio/virtio-iommu.c | 77 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

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
@@ -1639,12 +1656,62 @@ static gboolean reconstruct_endpoints(gpointer key, gpointer value,
     return false; /* continue the domain traversal */
 }
 
-static int iommu_post_load(void *opaque, int version_id)
+typedef struct VirtIOIOMMUMappingValidation {
+    bool valid;
+    uint32_t domain_id;
+    uint64_t low;
+    uint64_t high;
+} VirtIOIOMMUMappingValidation;
+
+static gboolean virtio_iommu_validate_mapping(gpointer key, gpointer value,
+                                              gpointer data)
+{
+    VirtIOIOMMUInterval *interval = key;
+    VirtIOIOMMUMappingValidation *validation = data;
+
+    if (interval->high < interval->low) {
+        validation->valid = false;
+        validation->low = interval->low;
+        validation->high = interval->high;
+        return true;
+    }
+
+    return false;
+}
+
+static gboolean virtio_iommu_validate_domain_mappings(gpointer key,
+                                                      gpointer value,
+                                                      gpointer data)
+{
+    VirtIOIOMMUDomain *domain = value;
+    VirtIOIOMMUMappingValidation *validation = data;
+
+    validation->domain_id = domain->id;
+    g_tree_foreach(domain->mappings, virtio_iommu_validate_mapping,
+                   validation);
+    return !validation->valid;
+}
+
+static bool iommu_post_load_errp(void *opaque, int version_id, Error **errp)
 {
     VirtIOIOMMU *s = opaque;
+    VirtIOIOMMUMappingValidation validation = {
+        .valid = true,
+    };
 
+    /* Rebuild ownership before validation so failed loads can be cleaned up. */
     g_tree_foreach(s->domains, reconstruct_endpoints, s);
 
+    g_tree_foreach(s->domains, virtio_iommu_validate_domain_mappings,
+                   &validation);
+    if (!validation.valid) {
+        error_setg(errp,
+                   "virtio-iommu: invalid migrated mapping in domain %u: "
+                   "[0x%" PRIx64 ", 0x%" PRIx64 "]",
+                   validation.domain_id, validation.low, validation.high);
+        return false;
+    }
+
     /*
      * Memory regions are dynamically turned on/off depending on
      * 'config.bypass' and attached domain type if there is. After
@@ -1657,14 +1724,14 @@ static int iommu_post_load(void *opaque, int version_id)
         timer_mod(s->cmd_timer,
                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
     }
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_virtio_iommu_device = {
     .name = "virtio-iommu-device",
     .minimum_version_id = 2,
     .version_id = 2,
-    .post_load = iommu_post_load,
+    .post_load_errp = iommu_post_load_errp,
     .fields = (const VMStateField[]) {
         VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
                                    &vmstate_domain, VirtIOIOMMUDomain),
-- 
2.34.1


