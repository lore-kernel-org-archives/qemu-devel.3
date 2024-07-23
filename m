Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B4EC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWIYg-0006uL-P4; Tue, 23 Jul 2024 12:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWIYa-0006mq-SI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWIYY-0001ZG-Ir
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721752803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZkNsRazCJZZPQZc0vMKv6cPyzjVC9m4rB51zqNztNA=;
 b=O6Mmeg6+tSluN4UXbk0HcgDYQgSvYbgRcxkHIJYTFUUC0FP1VXYQYrZJH3UsQMi7AhGpPG
 epJEJuUixnSUlVcxcJK67cxWylf6a61hM7rYOvJESp63Mkt93HBCoeeO2iFmLjk6gxnWkA
 uuVUJYmn/Er6WBf10C7fFrEOqFMTEK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-UhwoFS1ZPeub8Z_HjQPsXQ-1; Tue, 23 Jul 2024 12:40:01 -0400
X-MC-Unique: UhwoFS1ZPeub8Z_HjQPsXQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36873a449dfso9697f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721752799; x=1722357599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZkNsRazCJZZPQZc0vMKv6cPyzjVC9m4rB51zqNztNA=;
 b=iShMagqdaxVM+OV2iqbBEH/vpBa7PnH6Cdfnoq3q9carfy1GffC7Lkm1ek3Q3cOI6N
 tT3GUk80LKPSZ0NIDSVAYtTK3dvEKxi7IFjb0bqnZEBxYgfHi8/qxuxUV8vOSEhXEgRl
 KGe5XvySW4f2JF7NS9yVlWxTJpZKVuVGVTwBKJ3WErLu1whcmf++zibGWBk2N7Sf3QDe
 0lAaq4D0CjVRigEJ7PKMD3oRqol7X5SkX95dYZhXle9r00GFRlNvlx4jepen570cfWk5
 Lgnm2TCiHiny+6y43fFn9vx7colYliZjVuknU8j5nL3yQtKvNsfcHvsQtDApudngTlRO
 IOjQ==
X-Gm-Message-State: AOJu0YxKn1TWs7e0OjNsM91lBE0eSG0GU/oF7Zc6urm5X296YBTAGgH1
 gwFocvDEf8ngQeGgWAM5dWO0ihAzAaw/SCnD+4ZnqQ66y+TvSANrdFQvNQdV7b5EoEmr2mrF3us
 2TYd+H72rKnyy1jKfQfMqbEBAE1XFpyFU9yrBVLeeg672kNtRZH3TUlfQDxqGZmJVwBUfzAwVif
 ft1p4U4LgTpS1M9ifl2qC2iYfDR8OWUcRUjg==
X-Received: by 2002:adf:fc81:0:b0:366:dee6:a9ea with SMTP id
 ffacd0b85a97d-369e3f110d7mr1667190f8f.26.1721752799495; 
 Tue, 23 Jul 2024 09:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF25MuBu/BdiagYbUaDvtsF9v4p2Z9x2bII98AIeHY+t7t7ZPc8XDwNF2wsfMJIYD+juP+Ydg==
X-Received: by 2002:adf:fc81:0:b0:366:dee6:a9ea with SMTP id
 ffacd0b85a97d-369e3f110d7mr1667172f8f.26.1721752798757; 
 Tue, 23 Jul 2024 09:39:58 -0700 (PDT)
Received: from localhost
 (p200300cfd74b1cd04af1f18b763c5dac.dip0.t-ipconnect.de.
 [2003:cf:d74b:1cd0:4af1:f18b:763c:5dac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a9466bsm208158025e9.41.2024.07.23.09.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 09:39:56 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/2] virtio: Always reset vhost devices
Date: Tue, 23 Jul 2024 18:39:40 +0200
Message-ID: <20240723163941.48775-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723163941.48775-1-hreitz@redhat.com>
References: <20240723163941.48775-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Requiring `vhost_started` to be true for resetting vhost devices in
`virtio_reset()` seems like the wrong condition: Most importantly, the
preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
up in `vhost_dev_stop()` (through vhost devices' `.set_status`
implementations), setting `vdev->vhost_started = false`.  Therefore, the
gated `vhost_reset_device()` call is unreachable.

`vhost_started` is not documented, so it is hard to say what exactly it
is supposed to mean, but judging from the fact that `vhost_dev_start()`
sets it and `vhost_dev_stop()` clears it, it seems like it indicates
whether there is a vhost back-end, and whether that back-end is
currently running and processing virtio requests.

Making a reset conditional on whether the vhost back-end is processing
virtio requests seems wrong; in fact, it is probably better to reset it
only when it is not currently processing requests, which is exactly the
current order of operations in `virtio_reset()`: First, the back-end is
stopped through `virtio_set_status(vdev, 0)`, then we want to send a
reset.

Therefore, we should drop the `vhost_started` condition, but in its
stead we then have to verify that we can indeed send a reset to this
vhost device, by not just checking `k->get_vhost != NULL` (introduced by
commit 95e1019a4a9), but also that the vhost back-end is connected
(`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/virtio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 583a224163..35dfc01074 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2150,8 +2150,12 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (vdev->vhost_started && k->get_vhost) {
-        vhost_reset_device(k->get_vhost(vdev));
+    if (k->get_vhost) {
+        struct vhost_dev *hdev = k->get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev && hdev->vhost_ops) {
+            vhost_reset_device(hdev);
+        }
     }
 
     if (k->reset) {
-- 
2.45.2


