Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038D1C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeD1-0003AZ-JV; Tue, 02 Jul 2024 10:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCv-0002nc-G3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCt-0000FH-2r
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/8Z7JyQo+HEEofucdvOkehCzjauROI/8uJ9hGYzaVe8=;
 b=NeT/gFBhcV/D7OB5oTDHUElsFegm/YIXrogtle7ho6FqlOl3oS3n8uflevn8cYEd9MdIIu
 vm3lpoqOoO11XCGCVdCvawNWa40pRGWQeVIaWAPxMANM0AdLY/bG8eiikOhS9oay4S+TtU
 I32W2enBgvA/Tv50dxKySg1oCEWoIWA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-M2u2y-SPMWGZUqRdWZVdeA-1; Tue, 02 Jul 2024 10:10:05 -0400
X-MC-Unique: M2u2y-SPMWGZUqRdWZVdeA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec60e68c81so41338891fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929403; x=1720534203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8Z7JyQo+HEEofucdvOkehCzjauROI/8uJ9hGYzaVe8=;
 b=Gp9IvlYu7ueQi6JVLRt/St01d0ZAb1CEVQeuxXn6+WSNan38X85NVXndauYc0hcLIN
 kYMUmN+eO9gZQU+m2ft/dPJmJkoh7lcy+i8/t48M7Y37mtjgeWOO8RHWoFxXSxwYSG4H
 EYcER6+zSmP7pHr39hP2kZH+P1H43nI1BoBGgK9IB9S4vJ4QIgxEsDdxDB7GyCmZSWeT
 Y7rpW6MlYVVyugVaLFI6nWhljWPJ/p46nBlC/523i7F2QsCsv7URMNl5CyXkISfgKIRz
 PLXqI22mw0tX9x3cRfw3VH7IqW+s8VM9CbwTte7BvYjOPCeA6qXij2+xs3RrhKyY++pS
 5ZNQ==
X-Gm-Message-State: AOJu0Ywds0Y168hILQgPq6u8DAV6lDqesls4VDUvoJ5AmoEq4BND0y9o
 9/HYrAIY4EooN/Lr/EWlzrXex2qhvyec8Kk5wdX5Keb2UYAhLTz5/j53Fk3CVrebBmMQh5quzE4
 uMiaObnYUlFJEYHr0EtbMXpq0x+hJpsxGfaX3OHbBYNjD/dCb7dd9lOsu4fSGH2BvsXcVERodJY
 8EeGWPLBHS8uNMtccIv7rbtDZFp0vwaA==
X-Received: by 2002:a05:651c:198b:b0:2ec:5843:2fbd with SMTP id
 38308e7fff4ca-2ee5e6cd69cmr64760301fa.41.1719929403307; 
 Tue, 02 Jul 2024 07:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2vVM+J0u/21ILTnwbOyL1wB1+k03EWEAQcooVg3hcn1q7fxh17QTgSg6QJYKMZp9avWtzvw==
X-Received: by 2002:a05:651c:198b:b0:2ec:5843:2fbd with SMTP id
 38308e7fff4ca-2ee5e6cd69cmr64759971fa.41.1719929402706; 
 Tue, 02 Jul 2024 07:10:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36787db4d12sm1976984f8f.110.2024.07.02.07.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:02 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 59/91] hw/virtio: Fix the de-initialization of vhost-user
 devices
Message-ID: <b3e63e65010973d0582bd69cb90fc07d3834e811.1719929191.git.mst@redhat.com>
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

From: Thomas Huth <thuth@redhat.com>

The unrealize functions of the various vhost-user devices are
calling the corresponding vhost_*_set_status() functions with a
status of 0 to shut down the device correctly.

Now these vhost_*_set_status() functions all follow this scheme:

    bool should_start = virtio_device_should_start(vdev, status);

    if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
        return;
    }

    if (should_start) {
        /* ... do the initialization stuff ... */
    } else {
        /* ... do the cleanup stuff ... */
    }

The problem here is virtio_device_should_start(vdev, 0) currently
always returns "true" since it internally only looks at vdev->started
instead of looking at the "status" parameter. Thus once the device
got started once, virtio_device_should_start() always returns true
and thus the vhost_*_set_status() functions return early, without
ever doing any clean-up when being called with status == 0. This
causes e.g. problems when trying to hot-plug and hot-unplug a vhost
user devices multiple times since the de-initialization step is
completely skipped during the unplug operation.

This bug has been introduced in commit 9f6bcfd99f ("hw/virtio: move
vm_running check to virtio_device_started") which replaced

 should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;

with

 should_start = virtio_device_started(vdev, status);

which later got replaced by virtio_device_should_start(). This blocked
the possibility to set should_start to false in case the status flag
VIRTIO_CONFIG_S_DRIVER_OK was not set.

Fix it by adjusting the virtio_device_should_start() function to
only consider the status flag instead of vdev->started. Since this
function is only used in the various vhost_*_set_status() functions
for exactly the same purpose, it should be fine to fix it in this
central place there without any risk to change the behavior of other
code.

Fixes: 9f6bcfd99f ("hw/virtio: move vm_running check to virtio_device_started")
Buglink: https://issues.redhat.com/browse/RHEL-40708
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240618121958.88673-1-thuth@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 1451926a13..7512afbc84 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -472,9 +472,9 @@ static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
  * @vdev - the VirtIO device
  * @status - the devices status bits
  *
- * This is similar to virtio_device_started() but also encapsulates a
- * check on the VM status which would prevent a device starting
- * anyway.
+ * This is similar to virtio_device_started() but ignores vdev->started
+ * and also encapsulates a check on the VM status which would prevent a
+ * device from starting anyway.
  */
 static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status)
 {
@@ -482,7 +482,7 @@ static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status
         return false;
     }
 
-    return virtio_device_started(vdev, status);
+    return status & VIRTIO_CONFIG_S_DRIVER_OK;
 }
 
 static inline void virtio_set_started(VirtIODevice *vdev, bool started)
-- 
MST


