Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671EFC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPc4-00068i-MY; Tue, 03 Jun 2025 07:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1uMPbn-00064X-0r
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1uMPbk-00049y-Bq
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748949303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uPfiZ9GVeleSOBo5zAPPtu34oR+PCzc3sZY9U1A27WQ=;
 b=HInzi9eoM4nlk+WL/6b2jnnMCE0eT6JN2nIfEthn11qJ6xj1SyPxUWtfl+veRUyfXWIDyh
 fe6KMPY5WGGacv+JT/5BNuD/4gdYiCKE/3PeFS0hq/9ueePw+5Rxaw32eSMpZo9fOgsjUX
 zOcAx0X1npXtn4L/DOi96dNKrLZkhPc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-W06dxNXsPkWdYzNuLkPfjg-1; Tue, 03 Jun 2025 07:13:39 -0400
X-MC-Unique: W06dxNXsPkWdYzNuLkPfjg-1
X-Mimecast-MFC-AGG-ID: W06dxNXsPkWdYzNuLkPfjg_1748949218
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so28313595e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949218; x=1749554018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPfiZ9GVeleSOBo5zAPPtu34oR+PCzc3sZY9U1A27WQ=;
 b=FFJlVfaMWbB5jLRfU5oc4yZB807JNtgDBcYvJ39rtF+SRV6pyx4iD9YC2T+T9bZZ3u
 PaY0YnXyhre+aTblBESnm2h//JfQR5zqqhU4iPoGA/5/Ww1QwoQu3P/LWho3G1Li5m9m
 kFO+uKSPWaMylNnVTu6t7IcIbz/pba++23A+iT5hnEhL+ejoYPyyCqz0Z3Nm9aYNL3Tn
 mS9kDYfbUBrZE129VT0RNueP4xalOkSeHYjvgko99qn6Gp1ev34Yae6AbkghJAm3pGsr
 yJlpLI+I+dWEG4Sd88+q627Ebf8tPyu4lBs3Lq+XMLRQnD3TxUEVHiuO8QFVN0kRlbnm
 15uQ==
X-Gm-Message-State: AOJu0YwLRDDm3iPefx2426F8aLdnfjgrSBNgl2wtxmgXPr/K9I9txuTm
 zoPfDHLLhVcaLt/iRZMtUZRb1PB7m8UPUT96FVWIO5z7YDHsvwlgEz6xYvoiLFjU3J4Bc7k+Gwq
 f7xd7MFcs4pvMSXDDyKDV8ivneLxTeg+jH079755CO/ywsNobiIKkQiGN0RH/pReE7I5bypPTky
 n35wil5eLNVcawfaMNtb0qgF1hClzYE1kNOV9yHJs=
X-Gm-Gg: ASbGncs/1oRYfUcAmQQLglO6K8glqyHofaXzvSEvw0IP1spL6EVw0iICR59Vd1Xbd5h
 6Ah2rj3ChBSv+vi68O1b/5ncttR7Q8lg6A3Vyj3cSJK57FVrEs0x5ta6IBZcd6YhuNvVB5mXggd
 baN6q/+LUllXrTejAIsZt6x5tentV8Rnu7id4qqoiO0COU+EVvKsNxcrMU0NOxNqyySF+NAhGW2
 itUopaziLx8VqY0pzc/gOE1DZVH99ZV8n5KCuXHLRLogThEobfzemD8lw0cmgL3qxM4ed9nfiXi
 GScej/MFwegp0CHIDN3ix+aNw7bgLYQs3FECxvDIS+IBWaZDa0+9gkkJESeddLee+rSmQ3OY
X-Received: by 2002:a05:600c:4f8b:b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-450d655559emr130604315e9.26.1748949218086; 
 Tue, 03 Jun 2025 04:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKyidGe/POT4w7wLZFNrxESnSX8pYf7grtsqg/hrybAHTE7DAqgDQhMVP+IxoFYKmk1DPODA==
X-Received: by 2002:a05:600c:4f8b:b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-450d655559emr130604015e9.26.1748949217599; 
 Tue, 03 Jun 2025 04:13:37 -0700 (PDT)
Received: from localhost
 (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de.
 [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-450d7fb7dafsm155204825e9.25.2025.06.03.04.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:13:37 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 yuanminghao <yuanmh12@chinatelecom.cn>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v1] vhost: Fix used memslot tracking when destroying a vhost
 device
Date: Tue,  3 Jun 2025 13:13:36 +0200
Message-ID: <20250603111336.1858888-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
---

I assume the problem existed in some form when used_memslots was
introduced. However, I did not check the old behavior of memory listener
unregistration etc.

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
2.49.0


