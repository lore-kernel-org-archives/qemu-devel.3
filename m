Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862DAC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4my9-0001PW-5v; Thu, 10 Sep 2026 18:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVZ-0006ND-If
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVC-0003gm-6J
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsEZfCYpQa9toaMH2oc+Rwd2XMpw3IccFW5x9qsdK3I=;
 b=bBjFkbtxVo54O/IulXiWRfx+YgZGGN2oG4NY69sQ+L+6/MF6BN9gdTzIpzrol8cViWEqUJ
 kvD9C07pF6z4tC8oyNe6B/joK8pR7aKTNKZwORjmqSI2Uy8YUiqw531hnEcNSOjZ3R0m4f
 YTUsnbzhC9uYYtIb6DPyBDnd9oDhdGk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-x9w56P0JPBu3KpXsAqM09A-1; Thu, 10 Sep 2026 16:13:57 -0400
X-MC-Unique: x9w56P0JPBu3KpXsAqM09A-1
X-Mimecast-MFC-AGG-ID: x9w56P0JPBu3KpXsAqM09A_1789071236
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48589603501so62907f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071236; x=1789676036; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hsEZfCYpQa9toaMH2oc+Rwd2XMpw3IccFW5x9qsdK3I=;
 b=LAPqKFY33ldOq3JelBgdHhv95MZTPu4uhQA3h3p6G8RHsBiWsVKNVeNAiGyfoEDVRh
 8PEemk7poeHZ/a/9qmAGOJgJjCn43yk2SXreZNSKc5Tvw9UylDlrcqrf7BV0LQoVLeaP
 lmlrqMo6Tr2f6LF+KDJmfNEQzLnRrcpwEI5q+2kTE9p0H7y/RF9tgk5wFfN4kB3zytcZ
 ZrmfzXbPQalLTMBQMLasPrdEtc7gRd1q8C/LuMf+smVZUyigZx2tzsd9YMqjkIRulqgQ
 iwW0L30u/ORHEWBS5V7XNCulRgQ43JheFp4T4TmPqwB1r8nihZCuCLswMYpkvoB6wzgC
 M1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071236; x=1789676036;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hsEZfCYpQa9toaMH2oc+Rwd2XMpw3IccFW5x9qsdK3I=;
 b=HuiLqisZTHX7ZHUgvI1DnVYjmSOict30R3U3e2Q51dIxa4yXLBdf73njmIIyNvcrEx
 sY67nndYrB+T11Dqri8XMFLhWebMMpAucR/WUE590t0EPwe9h+fmVxyrXLj9b7xikCsw
 pW4cDiZkN8Dj8GzgRjaDOl3cjAxKTTS/eTF0ubputW4bo/0aEnIJgvNxb/GK7hGzBzXf
 JSJbfrGJdh2rXAgAd7nXOScu18tq50whCkevQYagjrDs+2i35SLVhJ6KBScFHzq5b0w2
 6oh1iZEa9YNTEKCACYbnWoe0xmRddWa0NvVOZF/5/WVgUnzMatwqFA///KdPl1Y9MwuA
 VqXQ==
X-Gm-Message-State: AFuF++k8tKDIQQ7MNAZxpdT9ypvbH7ezxIVfGMdjyMcAyewUwUOnIaO7
 qKFzBwLIhVkc8qrr1L5QE2ZCXNiHZtRry6OqATrBNjYLeWqm4+YoDiCkB25WJcuczxMxlV6OBmQ
 A8sxKCZcKLzJrONiarz8KY8hvdwMIpd5GYgpWDkb9zisJ0NSrNc6tXNxPrOCROab1F0dBCyWFs0
 1zqSLJaGkDMbzKC8USH7AV8Nn+HuRxNfcBQQ==
X-Gm-Gg: AYBFou2M75cb5lV7SURwrjOyjJaM/u6Bkw7QCwCpMKB9yAsljjga8ecirNYhCMB4NuJ
 wIi6spq5J2ne5ikNZRSb6CsdsuYp7jNW4xwATOWbPui5n7ORJ5qTjVugDBtDC206qPWeR9nGQiA
 2tQATewnxn0HOrncAUVJ/vQfD3T4TROhIWh67PTszctv1F1PGIzv7YqznYgWsYfD6zHf820vb2i
 P7jVbhGclLKyvQl6jiPOLUGrP+V6rdnED/ch5aKfseegXnl5Utr38uUQ46xNHJ2CeVBSALm3Ut1
 oNZSNiezCMJ9N4u0xdbzG2xF0WiZ5vPmNAygVrkqMM7XHdGlQbLr9KpQWq9eV/76o+hgx0hhLRY
 3jAkniE6DdEAXb/gdxUyARvY=
X-Received: by 2002:a05:6000:4717:b0:485:8c16:a357 with SMTP id
 ffacd0b85a97d-486eb358c5dmr606786f8f.47.1789071235738; 
 Thu, 10 Sep 2026 13:13:55 -0700 (PDT)
X-Received: by 2002:a05:6000:4717:b0:485:8c16:a357 with SMTP id
 ffacd0b85a97d-486eb358c5dmr606744f8f.47.1789071235238; 
 Thu, 10 Sep 2026 13:13:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f353sm768655f8f.26.2026.09.10.13.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:54 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xiong Weimin <xiongweimin@kylinos.cn>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 58/90] hw/virtio: Propagate vhost_virtqueue_mask errors
Message-ID: <22ffc542a1ab7ad898e3efacc0ce16c68ae85c73.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Xiong Weimin <xiongweimin@kylinos.cn>

vhost_virtqueue_mask() currently reports failures from
vhost_set_vring_call() but always returns void, so callers cannot
react.  In particular, vhost_virtqueue_start() has a TODO next to the
unmask call when !use_guest_notifier_mask.

Make vhost_virtqueue_mask() return the underlying errno, and on failure
in vhost_virtqueue_start() jump to the existing fail path which unmaps
the vring and propagates the error to the device start caller.  Other
call sites keep today's behavior by ignoring the return value.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807024359.2157914-1-xiongweimin@kylinos.cn>
---
 include/hw/virtio/vhost.h |  9 ++++++---
 hw/virtio/vhost.c         | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 7c4f032996..cd012b99a2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -359,10 +359,13 @@ void vhost_dev_set_config_notifier(struct vhost_dev *dev,
  */
 bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
 
-/* Mask/unmask events from this vq.
+/**
+ * vhost_virtqueue_mask(): mask/unmask events from this vq.
+ *
+ * Returns: 0 on success, a negative errno on failure.
  */
-void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
-                          bool mask);
+int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
+                         bool mask);
 
 /**
  * vhost_get_features_ex() - sanitize the extended features set
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 838b1da739..6c2612a1dd 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1481,8 +1481,10 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
      * will do it later.
      */
     if (!vdev->use_guest_notifier_mask) {
-        /* TODO: check and handle errors. */
-        vhost_virtqueue_mask(dev, vdev, idx, false);
+        r = vhost_virtqueue_mask(dev, vdev, idx, false);
+        if (r < 0) {
+            goto fail;
+        }
     }
 
     if (k->query_guest_notifiers &&
@@ -1962,7 +1964,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n)
 }
 
 /* Mask/unmask events from this vq. */
-void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
+int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
                          bool mask)
 {
     struct VirtQueue *vvq = virtio_get_queue(vdev, n);
@@ -1983,7 +1985,9 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
     r = hdev->vhost_ops->vhost_set_vring_call(hdev, &file);
     if (r < 0) {
         error_report("vhost_set_vring_call failed %d", -r);
+        return r;
     }
+    return 0;
 }
 
 bool vhost_config_pending(struct vhost_dev *hdev)
-- 
MST


