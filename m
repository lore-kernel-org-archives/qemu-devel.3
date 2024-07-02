Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941F7C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjtO-0001Yv-Tk; Tue, 02 Jul 2024 16:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtL-0001Yn-Io
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtH-0007ZN-24
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=gLhni65fSodH+3tr0W2MOg8jBEZaKCY2K8flJXc1U271JSb+Mh+q/SZOv0gMycu2HVXW5Y
 z7Aj+MeJIYtqQ8FEyr4VHFDyBRZKtkcM7BdvlOXrW2569gKygdQyE9h/aa5Y5HiWmDkHjj
 LIeI2MDlvEf/90obl7VNtOztwDjyrnE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Nsprf0GxONCElVGCjZ0iuA-1; Tue, 02 Jul 2024 16:14:12 -0400
X-MC-Unique: Nsprf0GxONCElVGCjZ0iuA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-424fb2df2bdso42112055e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951250; x=1720556050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=Bq9G0lIsTLbZLgcWYuhwdcw7x25pjOcqEF39BFUZwExa6TlZzCXvJRA0rrDQzGw7cz
 rN9wEW3CsQKVGQ2oyqESjWFy9In+dxOXjdvIlZHo6Q+CC3sAAX8ZEAssnaAKhS9I5YlT
 xV5y4WfV4yI33kLXgVURXaSkT+9uZHIDGgYqUup6mw6sf1vUdMd5Om60s8gnm8wnh3oO
 NkHN0cqtioqQUN+ArSz9rpSOWLPS1n5Eay4eJ8gkqHSAbFd6Wqf8IomAOwgGx7yi3Zf5
 +46ZT4Rwb6+sH5WVz0jJjckR8VZAHYmKYQ9gr1MiG8xL4yT1dCNHcyB0SXmzFIlwclCl
 wwfw==
X-Gm-Message-State: AOJu0Yze7CChoevDlUrCq65Qw/rbzq6dkXX57cSfsk4Ntm5BzA6vcY3t
 4sTNSEQbmxViTuavJey5sJVPcbOXRrDin7RtLkNyPjAVIJbGOQjtlxq+uqqaIGBsOHxxEZ5lpGk
 Dn7tjofFvRsazpDtfEk8ZMBnvIThDdfuc32/4b5azw0jhQrDV1BvwrUwnUom8QycEzdJ9XThZhw
 UIusBWf3/zDC0G7dW7wCMOBEu0wPxCwQ==
X-Received: by 2002:a05:600c:42c6:b0:424:ac79:5504 with SMTP id
 5b1f17b1804b1-4257a00be40mr82203645e9.17.1719951250619; 
 Tue, 02 Jul 2024 13:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERR4GKbvP6QG5ZOi2lrXk6MkKLah/nONb2eGhbIxk4UDU0YVhY/forzYQzxVwhc61+8Rtfjw==
X-Received: by 2002:a05:600c:42c6:b0:424:ac79:5504 with SMTP id
 5b1f17b1804b1-4257a00be40mr82203185e9.17.1719951249520; 
 Tue, 02 Jul 2024 13:14:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5a3b0sm211339685e9.13.2024.07.02.13.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Subject: [PULL v2 07/91] virtio-ccw: Handle extra notification data
Message-ID: <594b543a4a75d08f47e5ea92c96a89502a3eab72.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
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


