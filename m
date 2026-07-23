Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B071C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1xp-0005vw-0l; Thu, 23 Jul 2026 18:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1x0-00058q-F7
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:35 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wy-0001VW-Jv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:34 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-80dc4a68e4aso9925727b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845892; x=1785450692; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GKRiouieuWI1DwlbrQ7+GSIDGiapIP1YbqHrv02aXj4=;
 b=HLW7l4FJ2kR3iH/wuj4vjGvkn3+7elKixqrxiwtSr4THGWO72KEq/bGk3IRuJxNdKR
 hfkqeKZ7UXGJJfJ3Z4L7BDwrVglIH/0bUCDBj2p1S/9+0w6bK7PP9526RtCj+CDJ7G/I
 Q8fvjn3HWAQrJaaZlwawxLhM4//nzrcB32Q94vvtXQUQbdwbg2kTdh0Q/HqysuIiWipS
 ZDF8y1C5qKeazPCNOlWeLGLyKzLUXgtnsA2xxrGKiOV/winQIYeK1D74qbAZDrMPiG1t
 U/mjaPAtzbN3Nw8mK7wZBq4jh399Cs5xmQ/hUdFEVclh3XSM2lGR+R1XZy6H6OoFm5qA
 42qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845892; x=1785450692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GKRiouieuWI1DwlbrQ7+GSIDGiapIP1YbqHrv02aXj4=;
 b=CY22VIe8qeI3aLKcZhkANLH859RsGBYdTImqbHKSNMFwTugG1mm+Yz31iz4ev8UNxN
 QHN0uQYjtCwTAbhQcKcC1dqzbQvB4pcQwe85Tf9i5FJBETE3/QYajxMSTMleVzMqunIR
 CI9Mq6LyIWY9TEXWVnWgRtLoIh5hrGfOk/0FbL6Ni7j0BG0wWwzBHjXs8DYi3BiWkOhZ
 W+R4FrAjxivRZ8nQDYtdu47boNaJaDOI2k4TGBWBXBEc/WeFeHdTnm3Dg8uxVT46/nuA
 p27tdkLuIw9uGQB5iy3kB5EURHLVjXQBG8+U4nJBj0xB74O0yNfzST/HxpwiOWv9u+KA
 YhWA==
X-Gm-Message-State: AOJu0Yyyg4G0SiAahZgJDSOoLu5l1MbY5LFqdtKlwTpi/J1ekAUoqgpC
 K4S0thV9KxG8dS6Cdihf1bw8SL7m3x2xJ5YSDvS2xMwdv5kO2qWAAigW
X-Gm-Gg: AR+sD11gCDlFz9NXSY1GcfuK7RHmmuT738yiSFYVQq0cmfPPvfI36ZT5RFdFQlZ+NZX
 LyxJt+aKCS84L82N/A/7gxfxNrheS/rWBNabMW57xIGNTTzP/3adfYsuDZ5mF4TQrGl9IYM+xBs
 mapPjaiTSktAarmdE+V5X+4jzClS5D3Z70BPbIWQU6BDjdWkp0p82tLqmjcfMJId3zCiEHbV2Ev
 tD4d6QVyKhIvOVM5rrsBHOa4BUCfFLbM4OfPedw1/JIx3PSfz/ynyu4pbKnLYF3y3LcXqJkKR9b
 x+Q3kjeq9Z0IHmubquidI6FEYML8DJqOM61PibX7o44JW1xaU64EgSl8hy8poKza+0o2tlaFvAg
 e+WmstwrLpXAWL7leb3cJ5dizNrOKzYgSCoVqz0XxpiQ5qhsupuFrFILvH02os1YR9qGDAFWy+N
 JD0g0/djw=
X-Received: by 2002:a05:690c:9a13:b0:80c:85c6:898f with SMTP id
 00721157ae682-81f4c385c3cmr17699887b3.62.1784845891600; 
 Thu, 23 Jul 2026 15:31:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:31 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:13 -0700
Subject: [PATCH RFC 14/15] hw/virtio/vhost-user: handle data movement with
 shadow vqs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-14-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=7740;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=xEeRhGfcKFx4bZNfrfgaBAeG54f3UIPcnr2JwcHSaLI=;
 b=VzOWwZdOmRpBpOwUSyJ1rwROwiQiEWqNy3EW+u9gkPrYwZlbAlRWoUYraUqQK9Fn3BTl94e7d
 hzYa7doD71DA7T+oDrfN0eQ5QP9hEWzssolfhzJrOpyjbl88vMHSY2j
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x1132.google.com
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

- Add start logic for shadow virtqueues, which sets vring addresses.
- Update logic for sending vring addresses to backend to point
  to the shadow vrings when isolation mode is active.
- Implement handlers for intercepted avail and used descriptors. These
  handlers copy buffer contents between bounce buffers in the isolation
  region and the buffers made available by the guest
- Implement logic to stop svqs

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-user.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 75858289a2..e65f877f9a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1299,6 +1299,97 @@ static int init_isolation_regions(struct vhost_dev *dev,
     return 0;
 }
 
+static int vhost_user_memory_lookup(struct vhost_dev *dev, hwaddr gpa,
+                                    hwaddr *hva)
+{
+    int i;
+    hwaddr offset;
+
+    for (i = 0; i < dev->mem->nregions; i++) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+
+        if (gpa >= reg->guest_phys_addr &&
+            reg->guest_phys_addr + reg->memory_size > gpa) {
+            offset = gpa - reg->guest_phys_addr;
+            *hva = reg->userspace_addr + offset;
+            return 0;
+        }
+    }
+
+    return -EFAULT;
+}
+
+static int vhost_user_svq_handle_used(VhostShadowVirtqueue *svq,
+                                      VirtQueueElement *elem,
+                                      void *opaque)
+{
+    hwaddr hva;
+    int r;
+    struct vhost_dev *dev = opaque;
+
+    for (int i = 0; i < elem->in_num; i++) {
+        r = vhost_user_memory_lookup(dev, elem->in_addr[i], &hva);
+        if (r < 0) {
+            return r;
+        }
+
+        memcpy((void *) hva, elem->in_sg[i].iov_base, elem->in_sg[i].iov_len);
+        elem->in_sg[i].iov_base = (void *) hva;
+    }
+
+    for (int i = 0; i < elem->out_num; i++) {
+        r = vhost_user_memory_lookup(dev, elem->out_addr[i], &hva);
+        if (r < 0) {
+            return r;
+        }
+
+        memcpy((void *) hva, elem->out_sg[i].iov_base, elem->out_sg[i].iov_len);
+        elem->out_sg[i].iov_base = (void *) hva;
+    }
+
+    return 0;
+}
+
+static int vhost_user_svq_handle_avail(VhostShadowVirtqueue *svq,
+                                       VirtQueueElement *elem,
+                                       void *opaque)
+{
+    hwaddr offset;
+    const DMAMap *map;
+    DMAMap needle;
+    hwaddr *iova_base;
+
+    for (int i = 0; i < elem->out_num; i++) {
+        needle.translated_addr = elem->out_addr[i];
+        needle.size = elem->out_sg[i].iov_len - 1;
+        map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
+        offset = needle.translated_addr - map->translated_addr;
+        iova_base = (void *)(map->iova + offset);
+
+        elem->out_sg[i].iov_base = iova_base;
+        memcpy(iova_base, elem->out_sg[i].iov_base, needle.size + 1);
+    }
+
+    for (int i = 0; i < elem->in_num; i++) {
+        needle.translated_addr = elem->in_addr[i];
+        needle.size = elem->in_sg[i].iov_len - 1;
+        map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
+        offset = needle.translated_addr - map->translated_addr;
+        iova_base = (void *)(map->iova + offset);
+
+        elem->in_sg[i].iov_base = iova_base;
+        memcpy(iova_base, elem->in_sg[i].iov_base, needle.size + 1);
+    }
+
+    vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->out_addr,
+                  elem->in_sg, elem->in_num, elem->in_addr, elem);
+
+    return 0;
+}
+
+
+
+
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
@@ -1772,6 +1863,8 @@ static int vhost_user_set_vring_err(struct vhost_dev *dev,
 static int vhost_user_set_vring_addr(struct vhost_dev *dev,
                                      struct vhost_vring_addr *addr)
 {
+    struct vhost_user *u = dev->opaque;
+
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_VRING_ADDR,
         .hdr.flags = VHOST_USER_VERSION,
@@ -1779,6 +1872,25 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.addr),
     };
 
+    if (u->user->memory_isolation) {
+        if (!u->svqs_allocated) {
+            return 0;
+        }
+
+        int svq_idx = addr->index - dev->vq_index;
+        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs,
+                                                      svq_idx);
+
+        struct vhost_vring_addr svq_addr = {
+            .avail_user_addr = (uint64_t)(uintptr_t)svq->vring.avail,
+            .desc_user_addr = (uint64_t)(uintptr_t)svq->vring.desc,
+            .used_user_addr = (uint64_t)(uintptr_t)svq->vring.used,
+            .index = addr->index,
+        };
+
+        msg.payload.addr = svq_addr;
+    }
+
     /*
      * wait for a reply if logging is enabled to make sure
      * backend is actually logging changes
@@ -2754,13 +2866,18 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
+static const VhostShadowVirtqueueOps vhost_user_svq_ops = {
+    .avail_handler = vhost_user_svq_handle_avail,
+    .used_handler = vhost_user_svq_handle_used
+};
+
 static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user *u)
 {
     /*Modified from vhost-vdpa*/
     u->shadow_vqs = g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
     for (int i = 0; i < dev->nvqs; i++) {
         VhostShadowVirtqueue *svq;
-        svq = vhost_svq_new(NULL, NULL);
+        svq = vhost_svq_new(&vhost_user_svq_ops, dev);
         g_ptr_array_add(u->shadow_vqs, svq);
     }
 }
@@ -3466,8 +3583,56 @@ void vhost_user_async_close(DeviceState *d,
     }
 }
 
+static bool vhost_user_svqs_start(struct vhost_dev *dev)
+{
+    struct vhost_user *u = dev->opaque;
+    uint64_t vring_base = u->iso_memory.vring_base_addr;
+    u->svqs_allocated = true;
+
+    for (int i = 0; i < u->shadow_vqs->len; i++) {
+        VirtQueue *vq = virtio_get_queue(dev->vdev, dev->vq_index + i);
+        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs, i);
+        svq->base_addr = (hwaddr *) vring_base;
+        vhost_svq_start(svq, dev->vdev, vq, u->iso_iova_tree);
+
+        struct vhost_vring_addr addr = {
+            .index = dev->vq_index + i,
+            .desc_user_addr = vring_base,
+            .avail_user_addr = vring_base + sizeof(vring_desc_t) *
+                svq->vring.num,
+            .used_user_addr = vring_base + vhost_svq_driver_area_size(svq)
+        };
+
+        vhost_user_set_vring_addr(dev, &addr);
+
+        vring_base += vhost_svq_device_area_size(svq) +
+                      vhost_svq_driver_area_size(svq);
+    }
+
+    return false;
+}
+
+static void vhost_user_svqs_stop(struct vhost_dev *dev)
+{
+    struct vhost_user *u = dev->opaque;
+
+    for (int i = 0; i < u->shadow_vqs->len; i++) {
+        vhost_svq_stop(g_ptr_array_index(u->shadow_vqs, i));
+    }
+}
+
+
 static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
 {
+    struct vhost_user *u = dev->opaque;
+    if (u->user->memory_isolation) {
+        if (started) {
+            vhost_user_svqs_start(dev);
+        } else {
+            vhost_user_svqs_stop(dev);
+        }
+    }
+
     if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         return 0;
     }

-- 
2.43.0


