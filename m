Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40314C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAY-00022z-Dk; Tue, 02 Jul 2024 10:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAR-000216-In
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAI-0007tO-Cp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=P9vxdxOTDLfIDMGMo8s+8sHsVZahQFmrIHVtu+9VzRZx2hvqpmAasVN6F5uw32WNBqqFs0
 Z8XwVhYSgar4/ACUd2wg5sVKvKGo9zeCz/ZgU6fzRK8msQ78CrEGEy/JQug+thpZUYfkab
 tc1iVIwTv6GsVuIzhSlHK4hCc7tM5JU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Sr0d3wFWMmCSeMBdW-fY3w-1; Tue, 02 Jul 2024 10:07:21 -0400
X-MC-Unique: Sr0d3wFWMmCSeMBdW-fY3w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256569a4faso27251975e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929240; x=1720534040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=YBdLDIzyFG4U7e4bseedfF4pVbC/le7l2RrZaLN9xcbdjZ4EvsI8qqeZ9rP/+RwnFH
 tnBJmK9Ww+ldPuxbSLQ7/sYDJ6ykSvTLrU+E2RqOooyfpw3uHSqdS2e0MgNxTjBYmhYZ
 FIGK/Ik6M21Ig7P/sZ1KjC35DVbO7hGnxewG15B2Zk/8gqSwvjpTJ1KCY2SzrSwjCXl8
 KzKjv4SLC+WX1jg5zjfqL5aRgoc6bxaM2kRabF+sCqqIJEPigaTjnev6JFnJIHQ68BMo
 lvbK168Uj7wDpApuzP1qCLZRsCjBGOJ1H5NA+v0mUPD7R4ZNUx1TaJ24FI4iYgSeWMuq
 CwCg==
X-Gm-Message-State: AOJu0Ywyw7phOy3R23mx+DGdTwF6ATTlC8A0aubIh7WC5iMqyIRnDXbd
 KlagU7ILd3kiJw0y4PfBf7LagG2uxjFpdXbf8yHtlsLYkq/QqVQmwH1i+G5jRiyJW5gOz+f6q5N
 1uVkEkn8vhwFkxvr+9T8hHF/T6/V6CqDiDHmP64JSEl/u66COgFzCMGeTTmTxj2APmfpPLEKr2U
 YAmaVHDLuR5PuncfGOLGJ8d8FCTeCEig==
X-Received: by 2002:a05:600c:4f16:b0:421:b65d:2235 with SMTP id
 5b1f17b1804b1-42579714d61mr85248445e9.0.1719929240566; 
 Tue, 02 Jul 2024 07:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcfD/TG50V6u71ZCSG17LMuFoXXHV16QOjAwnFcMBi0KqtEmouEowf5haA8WxfPyl+05xIsA==
X-Received: by 2002:a05:600c:4f16:b0:421:b65d:2235 with SMTP id
 5b1f17b1804b1-42579714d61mr85248085e9.0.1719929240079; 
 Tue, 02 Jul 2024 07:07:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256f55c4b5sm185964545e9.43.2024.07.02.07.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:19 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL 07/91] virtio-ccw: Handle extra notification data
Message-ID: <594b543a4a75d08f47e5ea92c96a89502a3eab72.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add support to virtio-ccw devices for handling the extra data sent from
the driver to the device when the VIRTIO_F_NOTIFICATION_DATA transport
feature has been negotiated.

The extra data that's passed to the virtio-ccw device when this feature
is enabled varies depending on the device's virtqueue layout.

That data passed to the virtio-ccw device is in the same format as the
data passed to virtio-pci devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-5-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cd063f8b64..8cd912f20e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -126,9 +126,11 @@ static void subsystem_reset(void)
 static int virtio_ccw_hcall_notify(const uint64_t *args)
 {
     uint64_t subch_id = args[0];
-    uint64_t queue = args[1];
+    uint64_t data = args[1];
     SubchDev *sch;
+    VirtIODevice *vdev;
     int cssid, ssid, schid, m;
+    uint16_t vq_idx = data;
 
     if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
         return -EINVAL;
@@ -137,12 +139,19 @@ static int virtio_ccw_hcall_notify(const uint64_t *args)
     if (!sch || !css_subch_visible(sch)) {
         return -EINVAL;
     }
-    if (queue >= VIRTIO_QUEUE_MAX) {
+
+    vdev = virtio_ccw_get_vdev(sch);
+    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {
         return -EINVAL;
     }
-    virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
-    return 0;
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+        virtio_queue_set_shadow_avail_idx(virtio_get_queue(vdev, vq_idx),
+                                          (data >> 16) & 0xFFFF);
+    }
+
+    virtio_queue_notify(vdev, vq_idx);
+    return 0;
 }
 
 static int virtio_ccw_hcall_early_printk(const uint64_t *args)
-- 
MST


