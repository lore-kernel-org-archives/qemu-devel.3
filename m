Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4386FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFs-0001xs-Vp; Mon, 14 Jul 2025 19:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFq-0001cA-LL
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFo-0005MR-Qk
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8qJ4HdgdldyegLzyhVLDGluqXOekO1R56zT/QVUxjQ=;
 b=B+/Bl0AFwgp4HOZJH7oU6ubknbeUfNoa9PKvzNOKPrC5ovFIpBuJSvd0IoHpdr3FZWAbMB
 v1y1x0KoTlbgwFihx/eg9qclcQz/W0BLtRr0J3JrYPh2q17CgKqsrVBJD+0qPPHtLq4GOe
 P+4o74wIk8ffaGTTB9A2z0q5oslSr5s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74--h8Wn-EGO8SFA0_aybB1sw-1; Mon, 14 Jul 2025 19:06:35 -0400
X-MC-Unique: -h8Wn-EGO8SFA0_aybB1sw-1
X-Mimecast-MFC-AGG-ID: -h8Wn-EGO8SFA0_aybB1sw_1752534394
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561dfd07bcso6878175e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534393; x=1753139193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8qJ4HdgdldyegLzyhVLDGluqXOekO1R56zT/QVUxjQ=;
 b=djy7FUmNo0bJpo9FMDznNjjf3JBZrHNv8KxExMNXoG/F7w2DiGXib9GOFtps1SmBqf
 b+dv+COwiDxQjpRaRQ3tK5//3gBKAt3dFc90HflqyMv5v+vb+u8Q0YOLDa1HsOKJuZF2
 7X+KBBS6HdPfFVw9l19c1NOVisLUNUNy+25Bj1Zbb0I6ZvQXAEE7TV7bFm8cVmMmEf5L
 sAWC5nI6at3xIDcYX6oPAK5YFVrcmlEP7YoVwXUBNykXBvWW3JBkHQZe5K01NL6mO2/j
 udr80pBBPPck2XMUbWtQllNWQpby5N8cGAtDb8Hpkhs/y8D59DAeIDtThrC3ABqBYRCO
 iVjQ==
X-Gm-Message-State: AOJu0YyhKWHS+72548xJXeJYdGjAEVS9VfjZ7qYW9qb269Ki7JRvUmZZ
 e7ML60ShP25Yw+zU61OhrFFmWkvZmgqHnEzD8RG7DQlv7Xvr5560I1SEW+5KOoJqrqhtkDrDgjP
 baF1M1jbAvW6zdeDV8fuWWBJHAVHqxtyj3inExEH2xxUy6lNaCYifEjyn+SlT1u10jK82f8n+17
 bkZfUKhYQarv4h/IuG+dLF4AhugvBOD3RpSw==
X-Gm-Gg: ASbGncupkPGBY2oFnjZtbNRivl5BecLRg4lgDEcOKKy9HqFIQ9jCHhwlYnOB0/fb3dS
 lEjifM0Km/2A6apPgAnFv6VivYp615wtQecFpiyc81IdlxM0PpBqWG259e1TCcz6F/DTtRF6a/k
 lPP3nIJZegA7TYEG7Fwq9d9kT6Bwtdgb5EquPKPDmfz984MCvKyF7w/Y8GFSyfDXwIkm9707QC9
 VN9ZJ/xLPK4PIgL67fcaYwnZ7R6FKPJhU+5UMnR6QuQEI63QuooXQjRL+POJdTQaClm+TEW/WrW
 Yav0HHsgGbRCyShMHhu4Lr6ssUakXVMn
X-Received: by 2002:a05:6000:2285:b0:3a5:2d42:aa17 with SMTP id
 ffacd0b85a97d-3b5f18dc655mr10247498f8f.31.1752534393463; 
 Mon, 14 Jul 2025 16:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4k80u1akedcPRgFaPivFgzhK2UweA1hkRP/5T3QrIgl9qYOdQy3wLLdDfGpKRYnmlwVw3IQ==
X-Received: by 2002:a05:6000:2285:b0:3a5:2d42:aa17 with SMTP id
 ffacd0b85a97d-3b5f18dc655mr10247481f8f.31.1752534392923; 
 Mon, 14 Jul 2025 16:06:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26f45sm13670684f8f.92.2025.07.14.16.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:32 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 yuanminghao <yuanmh12@chinatelecom.cn>,
 Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 07/97] vhost: Fix used memslot tracking when destroying a
 vhost device
Message-ID: <9f749129e2629b19f424df106c92c5a5647e396c.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

When we unplug a vhost device, we end up calling vhost_dev_cleanup()
where we do a memory_listener_unregister().

This memory_listener_unregister() call will end up disconnecting the
listener from the address space through listener_del_address_space().

In that process, we effectively communicate the removal of all memory
regions from that listener, resulting in region_del() + commit()
callbacks getting triggered.

So in case of vhost, we end up calling vhost_commit() with no remaining
memory slots (0).

In vhost_commit() we end up overwriting the global variables
used_memslots / used_shared_memslots, used for detecting the number
of free memslots. With used_memslots / used_shared_memslots set to 0
by vhost_commit() during device removal, we'll later assume that the
other vhost devices still have plenty of memslots left when calling
vhost_get_free_memslots().

Let's fix it by simply removing the global variables and depending
only on the actual per-device count.

Easy to reproduce by adding two vhost-user devices to a VM and then
hot-unplugging one of them.

While at it, detect unexpected underflows in vhost_get_free_memslots()
and issue a warning.

Reported-by: yuanminghao <yuanmh12@chinatelecom.cn>
Link: https://lore.kernel.org/qemu-devel/20241121060755.164310-1-yuanmh12@chinatelecom.cn/
Fixes: 2ce68e4cf5be ("vhost: add vhost_has_free_slot() interface")
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20250603111336.1858888-1-david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fc43853704..c87861b31f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -47,12 +47,6 @@ static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
 static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 
-/* Memslots used by backends that support private memslots (without an fd). */
-static unsigned int used_memslots;
-
-/* Memslots used by backends that only support shared memslots (with an fd). */
-static unsigned int used_shared_memslots;
-
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
@@ -74,15 +68,15 @@ unsigned int vhost_get_free_memslots(void)
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
         unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-        unsigned int cur_free;
+        unsigned int cur_free = r - hdev->mem->nregions;
 
-        if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
-            hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
-            cur_free = r - used_shared_memslots;
+        if (unlikely(r < hdev->mem->nregions)) {
+            warn_report_once("used (%u) vhost backend memory slots exceed"
+                             " the device limit (%u).", hdev->mem->nregions, r);
+            free = 0;
         } else {
-            cur_free = r - used_memslots;
+            free = MIN(free, cur_free);
         }
-        free = MIN(free, cur_free);
     }
     return free;
 }
@@ -666,13 +660,6 @@ static void vhost_commit(MemoryListener *listener)
     dev->mem = g_realloc(dev->mem, regions_size);
     dev->mem->nregions = dev->n_mem_sections;
 
-    if (dev->vhost_ops->vhost_backend_no_private_memslots &&
-        dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
-        used_shared_memslots = dev->mem->nregions;
-    } else {
-        used_memslots = dev->mem->nregions;
-    }
-
     for (i = 0; i < dev->n_mem_sections; i++) {
         struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
         struct MemoryRegionSection *mrs = dev->mem_sections + i;
@@ -1619,15 +1606,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
-     * The listener we registered properly updated the corresponding counter.
-     * So we can trust that these values are accurate.
+     * The listener we registered properly setup the number of required
+     * memslots in vhost_commit().
      */
-    if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
-        hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
-        used = used_shared_memslots;
-    } else {
-        used = used_memslots;
-    }
+    used = hdev->mem->nregions;
+
     /*
      * We assume that all reserved memslots actually require a real memslot
      * in our vhost backend. This might not be true, for example, if the
-- 
MST


