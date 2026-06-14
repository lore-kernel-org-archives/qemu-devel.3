Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105FDCD8CA8
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBL-0002fK-AC; Sun, 14 Jun 2026 15:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBH-0002Vj-IH
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBC-0001yc-GY
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwaEuPK7+O7yDymvQWRrZNfcvXvxTXlnEXU6uD1afn0=;
 b=ZNMFVX2c099LWb0unnYQKiHPVqv/OQNqeFjot1vbSojtNw3q5gw16pe2yfRIOzKNtX/Nd0
 NnbJTllEgd5KXrZVY5B1ZWS6bkzdIsMnGy9iWTtNKhDgqjZu1f5VU9x80c35ZMpsBnVFyD
 uvN2pfq2npjE82WKQL9v4GETMoUN6UI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-A8MO2NcmPpCQhm6uD-LUjw-1; Sun, 14 Jun 2026 15:07:31 -0400
X-MC-Unique: A8MO2NcmPpCQhm6uD-LUjw-1
X-Mimecast-MFC-AGG-ID: A8MO2NcmPpCQhm6uD-LUjw_1781464050
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490c840efe6so31077805e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464050; x=1782068850; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rwaEuPK7+O7yDymvQWRrZNfcvXvxTXlnEXU6uD1afn0=;
 b=OtWDQm3aA5ucEGEeyf1j7kYN6qB4lsdxYGOPoUunPaM+HfEtSlWTz2yw6nN98k7uYs
 tYICtF2UDUrs1uuGxx9iRP8VpILzTu4EccjGNT9s5XQk4cMGSDIsi9DiQViWaBGW2MRI
 BkHh539z3ffKHegU0QN64kAJSZoMlIE5rm/8HSRvml/9Co9+FQ2RhQHAWk7lPH3QwcuN
 Xw+SDTEi0ivQ8yjl2SmKit04Bjgml98BrFgVd9JEeS271S1M9+i8aC1ew8SGBwlIsnmr
 YeTOYlr5VPGE505V2m/O2WiIunyBfIxH8bi7gyScn2urygbQsqOvn2ZIoDr8DDV1pUgp
 u50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464050; x=1782068850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwaEuPK7+O7yDymvQWRrZNfcvXvxTXlnEXU6uD1afn0=;
 b=akcl5Y6DUvtd3y8elirdKGBAcRRCdY3GFpoK5vXDninTQTbtzydCkXD1hfSqcvWnaG
 Kb6ZNESuB/fML3SkZYVcdKCtT//9wXnuhaR1AvFLF3m++FkPDA7duqgKsVcHdAv1Df2F
 phTceNiOu1LZPz+T98XNJi5pkoeKg4OVCsrLgU1znfVgU1Yx27CHAuGyOuGPdlJlJtvw
 lYwtIhcCo48KDQwONUtohFWhbUw536A+vyaKG9VBNLBWHzBtEO7k0Zq3JjHvo4wsjMCo
 PGhTZofHJMOAFdIE+zRTtNVcdIrRPfTQQWB29A6ZR+Sftq++StP9A5WQZfVHhh+Hlfhz
 duGQ==
X-Gm-Message-State: AOJu0Yz2f7lId7PMoJZpdqbgafPC4J7Vut08m31Z6Le2fPT6gePj2vTB
 Kke37A5zeGEUHYHJUOpY96cPnk5q0bn3KH1qyKWpimz7+9FT15HKy/bsIPywNIN9J22TWScPUwO
 SdkotOxDb8Wd7QzE6sFf5vsInxsdstgKsOCx/zF7F3lJNxCBY9AQ6rd6ekWRAj4UF0N2/w9sDTd
 suru+cSJH832L7KeXfTFshlX+yOIvFTMNfXg==
X-Gm-Gg: Acq92OFFEqwHI/W8JJ4EQineKPtnj9I7CyGAtAua5fIXAp+vRWMCvro7a/4CQjnGd8L
 ucB0x4fCZ+hLjAG7LVJhEXnXwojBF4DIOZyKp50H3rQYYvyANxTGUrYjgIB/lMx/StpPCOjeU85
 WdthIo9TE3awq9Zr+pdFquXg5G/i1Oj9/8v/wGdwiZQ7UwGNn9Bwu6KuH8WWFDvPO2xvA9JQGIc
 XZHMZO82R2Z5+4iXy3EoxjT2lAyz80qRqC5oIOKQSDEaij59aQsOz7UwHP2iS4sm6YFYwxuqJiM
 D2ACeK/7UC3D3mEDOo/zfMChXJhdplIwLEpu6JtSwCRcYI1MRnNl+ZY28Z2nlvN0ZUt9hXrbPjo
 2MBYndhWtGiOcQ9CXks2I6br30WJHAmp9g3/opk0kdOs=
X-Received: by 2002:a05:600c:8b2a:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-490ec50a338mr131341825e9.11.1781464050244; 
 Sun, 14 Jun 2026 12:07:30 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2a:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-490ec50a338mr131341435e9.11.1781464049672; 
 Sun, 14 Jun 2026 12:07:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea963cf8sm163404525e9.2.2026.06.14.12.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:29 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 039/106] vhost: move vrings mapping to the top of
 vhost_virtqueue_start()
Message-ID: <60abdf60d505748a729b05de2864813f20f4b8f4.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

This simplifies further refactoring and final introduction
of vhost backend live migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-14-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f43e563f0d..d5bafbcc4b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1303,29 +1303,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         return 0;
     }
 
-    vq->num = state.num = virtio_queue_get_num(vdev, idx);
-    r = dev->vhost_ops->vhost_set_vring_num(dev, &state);
-    if (r) {
-        VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
-        return r;
-    }
-
-    state.num = virtio_queue_get_last_avail_idx(vdev, idx);
-    r = dev->vhost_ops->vhost_set_vring_base(dev, &state);
-    if (r) {
-        VHOST_OPS_DEBUG(r, "vhost_set_vring_base failed");
-        return r;
-    }
-
-    if (vhost_needs_vring_endian(vdev)) {
-        r = vhost_virtqueue_set_vring_endian_legacy(dev,
-                                                    virtio_vdev_is_big_endian(vdev),
-                                                    vhost_vq_index);
-        if (r) {
-            return r;
-        }
-    }
-
     l = vq->desc_size;
     vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
     if (!vq->desc) {
@@ -1347,6 +1324,28 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         goto fail;
     }
 
+    vq->num = state.num = virtio_queue_get_num(vdev, idx);
+    r = dev->vhost_ops->vhost_set_vring_num(dev, &state);
+    if (r) {
+        VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
+        goto fail;
+    }
+
+    state.num = virtio_queue_get_last_avail_idx(vdev, idx);
+    r = dev->vhost_ops->vhost_set_vring_base(dev, &state);
+    if (r) {
+        VHOST_OPS_DEBUG(r, "vhost_set_vring_base failed");
+        goto fail;
+    }
+
+    if (vhost_needs_vring_endian(vdev)) {
+        r = vhost_virtqueue_set_vring_endian_legacy(
+            dev, virtio_vdev_is_big_endian(vdev), vhost_vq_index);
+        if (r) {
+            goto fail;
+        }
+    }
+
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
     if (r < 0) {
         goto fail;
-- 
MST


