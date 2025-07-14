Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D833C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGAP-0003Dp-Cl; Mon, 14 Jul 2025 06:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGAN-0003DB-DH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGAL-0001iK-P7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752487928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q+IDoe0gYH4NFbWUyUBJC8Drs/3jxQyirmlx4GErkRI=;
 b=ggUdy0gd7ZKR8QwD3qq06aDP+s0W0haSGt0dKHNbNM5owUhCBYRdiFN3wbShxlLcBpEy82
 xLmM1e95rgN92WCo0lHCvtSevHWEBOlZzATSZl/pIaUvcoJFrYK2uaRfB/xK+QIyrtlK5a
 J27R5AQCiuYnSl/sXQ5lLMxeLJzMs0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-BDH5wPoLMYGXjezepnirKg-1; Mon, 14 Jul 2025 06:12:07 -0400
X-MC-Unique: BDH5wPoLMYGXjezepnirKg-1
X-Mimecast-MFC-AGG-ID: BDH5wPoLMYGXjezepnirKg_1752487926
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45611579300so9142025e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752487925; x=1753092725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+IDoe0gYH4NFbWUyUBJC8Drs/3jxQyirmlx4GErkRI=;
 b=TDxfRBEaSE9tB0FWMA5X6VehKKauFV+aV566fKSDGtapcHLinTglUqHPsPD+WJPvWc
 Exqig9dI+DsW4SYw+Q4EnYZ6rUciDDC0qxyLxGwY+YvAzAiVoAj5IYIMXWWk4u6lPEb6
 ZJwEHujteX8WEZoePG6a8rIZpA/jPv/HWMSq0jZo9cA3H7VlAc6NTGr9oherOOn70PQ0
 0z+7BIJxi5gHmxximO7YZXNj78cr8wucmDoiSG/2FjkddW/Ghcde9H9yJNIWt1RfRwyX
 BPv8FrTAVbBtGPhwdqrK2ogoa50B0kMRsN8nY38Fi1Vud4i/YdBkg8Q6dzIxqsrjqArA
 l4ag==
X-Gm-Message-State: AOJu0Ywj0d6dkfDpCaacgG+OtI+6MlbGFyh15NyV7l7rmGAAzTZ/t7pl
 cmL2nr+n37te7ukOiyktefdToOOKtaZ643MfKWYlf221zMc9+jSMvcXGRH8YlBX+1Heb5e6jA6p
 8kDjqVMNmqJO/khIqyWcRG2RUve7tcLUZU48raSIQWNOGuDbgzwZB0JA5Qo3D4yAyB3DPwC7T7S
 VlJrYm6V0T22+FIHJBS6FX7jAXqmynk1+o/U/rywVn
X-Gm-Gg: ASbGncv+0lSN5XlcukM7xpCgBSzQ7bTK9pHr6lpWaaLCc5ctKd17jRDiTTlJ5Kju8++
 nduKHqfCOKQqHApaftguKkLxNBbL8oOiEHxfU3bks0WDmhC5r8Mc6n40G490XPt3bODelVVdFR5
 8mWVDS2vk+4qnmREzF4Edx8c5PG4Ymf75JZaXut0d4sp7poJxJkquxqyHtVJgoGbA1AbWeEQWk5
 PGcuLUnL3QsHrREN3CI+0Poj5+ZLJ/l8pGVPl6XdduKURsFPSIs5fB+d1R6mAEvV2RM90ln+5Fi
 4sxJ61w2Ezy9fKE7RXVqIBJB0qpEJ+oFxxHd
X-Received: by 2002:a05:600c:c056:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45610a814b4mr29322245e9.28.1752487925373; 
 Mon, 14 Jul 2025 03:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qAOggTZZqti1tWCgwYs1oRYDybG406/FDIBy5kCj7gYeA84Ux3S1Owmg76sHshqUkVuUUQ==
X-Received: by 2002:a05:600c:c056:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45610a814b4mr29321935e9.28.1752487924653; 
 Mon, 14 Jul 2025 03:12:04 -0700 (PDT)
Received: from stex1.lan ([193.207.162.97]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f13ec67asm88759105e9.4.2025.07.14.03.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 03:12:03 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] net/vdpa: fix potential fd leak in net_init_vhost_vdpa()
Date: Mon, 14 Jul 2025 12:11:56 +0200
Message-ID: <20250714101156.30024-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

Coverity reported a file descriptor leak (CID 1490785) that happens if
`vhost_vdpa_get_max_queue_pairs()` returns 0, since in that case
net_host_vdpa_init(), which should take ownership of the fd, is never
called.

vhost_vdpa_get_max_queue_pairs() returns 1 if VIRTIO_NET_F_MQ is not
negotiated, or a negative error if the ioctl() fails, or the maximum
number of queue pairs exposed by the device in the config space in the
`max_virtqueue_pairs` field. In the VIRTIO spec we have:
     The device MUST set max_virtqueue_pairs to between 1 and 0x8000
     inclusive, if it offers VIRTIO_NET_F_MQ.

So, if `vhost_vdpa_get_max_queue_pairs()` returns 0, it's really an
error since the device is violating the VIRTIO spec.

Treat also `queue_pairs == 0` as an error, and jump to the `err` label,
to return a negative value to the caller in any case.

Coverity: CID 1490785
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vhost-vdpa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 58d738945d..9dc7d2cb23 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1813,9 +1813,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
 
     queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
                                                  &has_cvq, errp);
-    if (queue_pairs < 0) {
-        qemu_close(vdpa_device_fd);
-        return queue_pairs;
+    if (queue_pairs <= 0) {
+        goto err;
     }
 
     r = vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
-- 
2.50.1


