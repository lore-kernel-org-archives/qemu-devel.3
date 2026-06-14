Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EE8CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBP-00033q-0u; Sun, 14 Jun 2026 15:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBC-0002TI-MI
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBA-0001yH-2X
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciAHQiL8oLMziOSY6mFU0q/YMW1lcOKJcQakg7fvlSA=;
 b=UWkyx0pBVmYS7kK00+py8HMHxgkrPzoJ1f0JBooXpQd7t7Xv7o0oGSqdu4+Et/v2rOXfAB
 9ScmPazBcMWXVlzsCvF0tHoy8bnJRxGH3Y/9tfhr3DjAjra79HKksDDQuV7/DphzHYLsoC
 FXdxVAkd79xB1HDpI19lt8L9v+3yPqA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-uMisvmjPNGebUdnPKZ5jvA-1; Sun, 14 Jun 2026 15:07:29 -0400
X-MC-Unique: uMisvmjPNGebUdnPKZ5jvA-1
X-Mimecast-MFC-AGG-ID: uMisvmjPNGebUdnPKZ5jvA_1781464048
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b5d2e394so17284065e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464048; x=1782068848; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ciAHQiL8oLMziOSY6mFU0q/YMW1lcOKJcQakg7fvlSA=;
 b=mzEj+1YFssgiQh3MPE6YxsD5VwhVyvBf/AdItFlqSZyq5nz/hMovGjAl5HPazM+bsr
 iWq5EkkkakzGsDqCbCSTgTKPfHnp4nuhJpB+mm0QKCFABj6VHIB32IfKlqc1UHWhOJXc
 qHJOMvlhABgs3ubVoxGqmEkrAO8/T+ut9z4LkJNhiECHkdXtu+Om4SDteYTDayrRnBcB
 SGoFWK4Q9UbT1Zh/JgdFbqWCk04e52ik2yTy78USvYzPbnNgkD7zd+8unv+oSABGXK8N
 PdHtLb7TA3Q0AMSsXZO9aTsefUEmmVG921ldjgmafPLhs1xjbwXtnQxsSYV+tQ8aig8H
 1zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464048; x=1782068848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciAHQiL8oLMziOSY6mFU0q/YMW1lcOKJcQakg7fvlSA=;
 b=eIOHWQGHrJLZHbG6g9AdjlqHCXJ7vBGJw0my7/sCj4A9hOQXgy4t9Km+55jvmdnju1
 N/cLIOKH0UTbLyt3U9gj2HNPHHUYuadS9bwT8Gzm4DRCeKaPUFQhwSL4QklCecr+bC9m
 lD3phS3yjjNDZPPf3a+XNLrCWprs6qp6N6dbLDHyQXM1IV4RnjuHEIvPBosw6yMg5R44
 CupYyRXw+rMAfN3XIuJyIWazujwYF2yNi2cxKKcGe2jRxJjbf2E4dSA4YBb//0Lyp3Ib
 frpD6h3mzA8QatfQzd28IRKv/WI3nNTNoweFBog0x5c0Os2p/Z1kW5vnwK+6j/PZC240
 omcg==
X-Gm-Message-State: AOJu0Yw1W6JQk8iBK1KaxOV/W/KhPl1AhM6EqIukvKji1eoxHZICMnCU
 Y1qmS8dHMhPZcpzJCY7Ecjiu7+OtXsUWkJ79E65soePoQqcxSNTIR8hCttetzDaxHkWK6PvldBG
 yn4Gogj8E7luwUeyN1LF3P+Op1Gj2uVp1q6AAkaO6Dtqwtqmv9LtfiYoiNaknOXrTt5oqZtZNIl
 Lz5Fd5dP/AU24mhV9HS5WqUR25DKgmh3mVQw==
X-Gm-Gg: Acq92OEhZsPt0i8UZyi2IAcQ3arYogo2ClG5EgGlGooZslzwoZCXDaJczWM9/Xir3If
 o7G0O9wuLhTb6LLeqeu4JDAUQQrzUkTkoU4qw8HA/uXH2w39I0OYgVF5B2MGXHyOslDOuM4KnQd
 IXh+4JCNhkEUAEr8ZQqFSmirVm9Agpvpjl4rDZf0jMxAPGgnGsoSXQGcbOYDQr9m+60fVK05a4l
 wzahchLWfF2UhD/g9XrImCnR+c6gBNKjLRJOu+dD2j6qNhnMziIf1O1CyWZvl202oqphLA1FyVg
 IcQXmGsTF4h7CGqpb3G+aI29VEmnfdR7o/JZQnwKCwYmIpSxaTGKjbHJE0vfP9SsAmfBWJuXSXc
 DFQrzE5iTih68xq7IlC9TjqdZp90NvePMi64Av0xd1f0=
X-Received: by 2002:a05:600d:6452:20b0:490:bc46:1a58 with SMTP id
 5b1f17b1804b1-490ec4fb6d6mr101566395e9.18.1781464048004; 
 Sun, 14 Jun 2026 12:07:28 -0700 (PDT)
X-Received: by 2002:a05:600d:6452:20b0:490:bc46:1a58 with SMTP id
 5b1f17b1804b1-490ec4fb6d6mr101566065e9.18.1781464047404; 
 Sun, 14 Jun 2026 12:07:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220372ed0sm163993215e9.14.2026.06.14.12.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:26 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 038/106] vhost: simplify calls to vhost_memory_unmap()
Message-ID: <060ef8cac1153e3c84ca3d43254c03de3c75b593.1781463125.git.mst@redhat.com>
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

No reason to calculate memory size again, as we have corresponding
variable for each vring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-13-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9b7a984e3..f43e563f0d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1383,12 +1383,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     return 0;
 
 fail:
-    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
-                       0, 0);
-    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, 0);
-    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, 0);
+    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
+    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
+    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
     return r;
 }
 
@@ -1435,12 +1432,9 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
-                       1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, virtio_queue_get_desc_size(vdev, idx));
+    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
+    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_size);
+    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
     return r;
 }
 
-- 
MST


