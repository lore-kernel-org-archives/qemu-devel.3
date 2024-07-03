Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA21C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8mX-00027R-HX; Wed, 03 Jul 2024 18:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mU-0001vW-Mp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mO-0005Er-P0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/8Z7JyQo+HEEofucdvOkehCzjauROI/8uJ9hGYzaVe8=;
 b=en8+Y/RtVJJ0ESaSUYFrpUgTIPJp1XPuuxi71mkEIoFDaaz/dRO03EnFPTzjoCaEdqavDp
 6x3Yxw3P/q9U5vSWnLQXNBNiy1acqUp/woCHepCYlvZV6WNY19g8kz5OW6mFLr5EdYTV6l
 TFBFPhDYCOEvO4Hu/ked4vkJDu4xspU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-pR3UJFLcN7ehZCAdJQiAyQ-1; Wed, 03 Jul 2024 18:48:45 -0400
X-MC-Unique: pR3UJFLcN7ehZCAdJQiAyQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-366e0a4c965so36907f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046924; x=1720651724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8Z7JyQo+HEEofucdvOkehCzjauROI/8uJ9hGYzaVe8=;
 b=Nnw5Rh+Kzgb66wql9jthM/PUo6gcKvXSlE11TNdHjIf6YMT8E1tEDtaG4O+hHyriWJ
 NfKUcvFyP9LTmeFDp/PW8F0pUK1+iNrOegYmRz1QDq1ywwV5kbgJ0NSPjguc3f7EyjTs
 SYR9e+MIajFziAsoypGrQNh6eNFhvraa5Z9xaoRp7KfTisHMxGFJ8RyWzmCjZxhrGa6l
 cGfYikwaBUbP1CpNu58KVhiFtZZ3zv6xBZypTqb+UuiXIu2nvnIVdTmanJZjyZvSCJNJ
 Oes6g1urMStExhsP1VV7xKFBZw47CdXI2mxZ/Sg5rnytSSVYeIL2JEygmLX4GhOlIgvK
 aflQ==
X-Gm-Message-State: AOJu0Yxdj9THjwDWOj00PTYTu6Y4tkotgl1SKRol7tNzgZR8pQz+idea
 kmov2egF0qFSdQdjzhSBVcPEJX0cTqwJ5905A7+H4cqsFNmXVk9OD3w/q+9yKDJ6Wrq7n0Q8BxM
 cTLVjaLSMzNrfKjcyMvk93mE2600YdTi9uLiAOuhY7/MPi58wBrR0KQCbO9lR0De6a7NL/MPmSk
 zTmamIAshga0QoMPXRtfNqm7BI8a+BTw==
X-Received: by 2002:a05:6000:1c7:b0:367:9d7f:f83f with SMTP id
 ffacd0b85a97d-3679dd726b2mr1664f8f.58.1720046924304; 
 Wed, 03 Jul 2024 15:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qZJqSjyfGvwcojzk4qPbCDfOBYwefYkkeeU6ewQsN2S56NidapcoEG7//gi59wnWpnqbWA==
X-Received: by 2002:a05:6000:1c7:b0:367:9d7f:f83f with SMTP id
 ffacd0b85a97d-3679dd726b2mr1654f8f.58.1720046923694; 
 Wed, 03 Jul 2024 15:48:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36795e3fe31sm2235346f8f.21.2024.07.03.15.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:43 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL v3 56/85] hw/virtio: Fix the de-initialization of vhost-user
 devices
Message-ID: <d72479b11797c28893e1e3fc565497a9cae5ca16.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


