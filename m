Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D880CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBP-00035p-IN; Sun, 14 Jun 2026 15:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBH-0002Vi-IH
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBE-000206-IY
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVuCWbga5LSxIklMA4eDSA2aVqOGc2j1p74x6rlVsK4=;
 b=AaaD4YE+KfKiZ1YQhLLeBYb3S5TSo+2dXJxC04PlYye767/J8DGpzWrjUb14yphdwmVh9P
 Wok1IHssgIkA/vVwpUr1pVMltZl6pfpzYesDqdTGKPPqRyjb0WnTMeL1dPvfI1G5C7rbiG
 m8MVkbPJN2Rc3K4mAjaKy9VdHo8k2ac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608--g8UuaOHNnO9uEd95FjYbQ-1; Sun, 14 Jun 2026 15:07:33 -0400
X-MC-Unique: -g8UuaOHNnO9uEd95FjYbQ-1
X-Mimecast-MFC-AGG-ID: -g8UuaOHNnO9uEd95FjYbQ_1781464052
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c840efe6so31077915e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464052; x=1782068852; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mVuCWbga5LSxIklMA4eDSA2aVqOGc2j1p74x6rlVsK4=;
 b=UAJDEMDyEoCFv51MWai8ya+9guw+qlELQl0iIYe7sg7g5X893qQeg65QiZdQsHyutL
 xXNo2+/fCaohXNlTPvPHqhUPCZl8KLM1XPC4/mtvRJYNNMh/3gYpdt7BJgTXn7GYpyai
 DmD+baNQ0KacPvhYJp5TS3qRkH0/8iT0bxc2HQeoiNYytYnb0NuxqMpZFPl2lf6Rxy6m
 U8K3IEC+RZRsrSfIiuN0uoZovfgXbxRlR9tYPX327T99/IN/1VRC2H9PXb8id0bGxiFe
 fN60fMql/Bn4KIngSL1DTAuF8qAvyfqtn8YlAC72SN0sP0TNOHJv6j6N0f/UvuYXaUr3
 j2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464052; x=1782068852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVuCWbga5LSxIklMA4eDSA2aVqOGc2j1p74x6rlVsK4=;
 b=YCLatsgaAjSDxsaOT0GHSSEgTkIGmBNhyRl7J2ulf42ZTeyyV+ZRNdxqAckHLjoirK
 M2BbHSx8xGVBxAnArtLZLkztywfgrw2ET73U/Kh3XIwdJctd55yDkzbw9gHZqhkR4Nk3
 hz7byzbA2U8vsWJUyK2ia5M1DevZQxxQo6Z0cIOPfrPGgIqnbwGyUEwoXSjXijKj7ax+
 +W6Tpm5npIcmCjydgE6t7gXhXZTWBqf3d4vwa4tChjHaMALxULOuJqX6fQQ9Q+3aV1vR
 yGjlbKrcxCjnHKf+pC05suq8dpO7rSvGQiQCsHp7vF37SWtCO/fbEhGrsOOUxP/FYGDI
 hcaQ==
X-Gm-Message-State: AOJu0Yz43vdOLplehyoC72COGohUlPk+QVxtQi+fxzfMNw7ETeN6tOKt
 1Pp8Y2tY41FIj15Ou6v07Xrk4pfMFUyQ/pvswLdSGh1oc23aqEbcTOvuzdXYOSg+BIblit6glM5
 tiaedniVXw7JBB3tT2qNVslsQhO6RTWkxSWXtjxES83njeY2zpbZaiVP8MxZUI6Yrm49JFgaPxS
 +D7aM0Hkl5QoTAmZE+3GFT1srxgDO3UXuflg==
X-Gm-Gg: Acq92OFu5/3M7H7cF8cZaEa/KM+TXcjp3tMogd+Mgp1rV35tZUAyaJal4roeIooKE3+
 YqVQOknIfoPhoBStfLy+6MIhL29iNZV9jaPRJ67t/DTPKco/4YhKQulNbSw762FwkxAEaB0dqMB
 6wimEfFp5RsrfttB/+GdrEE3HbNq3ThUav93o3JNkkFEIaMyXVI5L3TTQlf60FvrWe7zsoOQoKk
 GSEyiChmciJqEoi68H8D7e5kmBvqEX3GOUZ1SY2JmCXeA4aHXQkvpJ5W2Da/RcyaBtiee4KixNc
 sUDQaXu2Iuv9h7xAL+oCbUUxvZSSqNwEf6AnAr+Jv6kQFekkVgfgltKV/IjwlRtXkpkUegyPfg6
 WJdj6WE4WOtS4cwB1kpEOfEHCb9g9QzKR1/FQVLE5XYY=
X-Received: by 2002:a05:600c:1912:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-490ec30f6aamr110702605e9.0.1781464052266; 
 Sun, 14 Jun 2026 12:07:32 -0700 (PDT)
X-Received: by 2002:a05:600c:1912:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-490ec30f6aamr110702395e9.0.1781464051768; 
 Sun, 14 Jun 2026 12:07:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922031b21dsm176850365e9.6.2026.06.14.12.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:31 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 040/106] vhost: vhost_virtqueue_start(): drop extra local
 variables
Message-ID: <4801e50cf1af17ffdd80b4b01b3f57581c9b91cc.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

One letter named variables doesn't really help to read the code,
and they simply duplicate structure fields.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-15-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d5bafbcc4b..a3bf7e5a9b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1277,7 +1277,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
-    hwaddr l;
     int r;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_file file = {
@@ -1302,23 +1301,17 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         /* Queue might not be ready for start */
         return 0;
     }
-
-    l = vq->desc_size;
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
     if (!vq->desc) {
         r = -ENOMEM;
         goto fail;
     }
-
-    l = vq->avail_size;
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, l, false);
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
     if (!vq->avail) {
         r = -ENOMEM;
         goto fail;
     }
-
-    l = vq->used_size;
-    vq->used = vhost_memory_map(dev, vq->used_phys, l, true);
+    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
     if (!vq->used) {
         r = -ENOMEM;
         goto fail;
-- 
MST


