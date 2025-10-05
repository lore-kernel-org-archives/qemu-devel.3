Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68B8CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 20:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5VCO-0001YK-2Q; Sun, 05 Oct 2025 16:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5VCL-0001Xv-PJ
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5VCJ-0005Mv-Oc
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759695550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMkLKAPcYKE7rFMqjSSuFj0CofrsS5xoQspYNdGwj04=;
 b=CK/zXJZQfoE/U124iK0gVjBLP+2yRwBIc5GUXGnUrzCKVyuWy4yl3UaVUDCnPVLdpY0DtS
 q7fd1L8qqzXgbMG8vhUelJlPScjeSKl7f3U6IRtSUxGQ3TziDdsY7GhW5l3LZS6RXgeScc
 h3RVJhieKD+BBmF5O/yCAX/np1cwnsc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-kE3IbyEUNba3BspTcoJglQ-1; Sun, 05 Oct 2025 16:19:08 -0400
X-MC-Unique: kE3IbyEUNba3BspTcoJglQ-1
X-Mimecast-MFC-AGG-ID: kE3IbyEUNba3BspTcoJglQ_1759695547
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e38bd6680so14188645e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 13:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759695547; x=1760300347;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kMkLKAPcYKE7rFMqjSSuFj0CofrsS5xoQspYNdGwj04=;
 b=L6pv6z364hsiIDnppt4pJ+GsWjRPrRDJEwV35mGlW1fvDBweKS6TOa9uartfh4O1HW
 mIoiaHlmgytDoVSGuwP4ReXRmYJptLvcnwWn5PkaXcSW9Dj8VxAEkDz7+j3jPCNvAUmB
 iTG5SxkGYlk9VUDq9nbVbcdBIabJG1HTCsety/9k1QcGiyjs9Agl9UpL5UYIeudLLzFG
 Ghx86ZrndOlz1Cs53TQAj6e1AMXLfV9ttl3gW/xkw42BN42Ch2hhYHf5ddX5vecmLvTO
 zZp3F6ioxrVPs+C7d5Hx2T0axgiWhrZAihzsDtztSfx6l6tLDITh+/1s7x1SGQe9g7+V
 BAjw==
X-Gm-Message-State: AOJu0YxhFTijtyRZMnB2Yji+uYRiGA9db8caXex5AOBNv2KI13hohq54
 TOEyllv32Ex4C01dN6twZ2oLxIbLsptWsZJx5w+NfLtyR+m1dDwzW/skIvKNJftjzx7x1gvGXAH
 IvWFOMIlGfE+m2nzvdGup8pt5jvcVETQhKlg/74lYRog6wdkIPT82M9ECJoxI5Nxj5/bD+ClQYa
 V0WKO/rElayDWfM06MLv4fBF8VdFQ4Xh9R0w==
X-Gm-Gg: ASbGnctwP2WPw0+vD8+QvZ+RSrMk6MafkcAep+8FG1luLuzLzRqMY/3QjAmfNqfXKCp
 yv4TAHXIIXDX8gokqhmaXJPqA6Lxjs8EtXgNYjCI+3Q37CG+pwnWLinTWkIXOaBptR8FIUoJewP
 0rc5Fqv1aDrl3WyO/ALgaDO9THlyeseobYN1CRCBAtwEsajAYWSp/DlevohZ9kIPPgtTMdoXZZF
 emqGxg18LKCi8dUpt+0xGMkuVdr1l1ytLCdDDipoxxJ7fYordDYbF7YFS0EbzPYBpJlcp19S3Pi
 zESgfbjfPFL+nxav92WQRHmP0nmgnbcZ+nrFLVU=
X-Received: by 2002:a05:600c:628b:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-46e71147470mr71342285e9.30.1759695546984; 
 Sun, 05 Oct 2025 13:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPu0xqumqzQ7fcTPkgw5+lMWzUxDDlvkiYwvHXfREmMIZhYQWYjmisJX03H0yxaPy4MHbPDw==
X-Received: by 2002:a05:600c:628b:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-46e71147470mr71342125e9.30.1759695546492; 
 Sun, 05 Oct 2025 13:19:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a020a3sm226243105e9.10.2025.10.05.13.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 13:19:05 -0700 (PDT)
Date: Sun, 5 Oct 2025 16:19:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 75/75] virtio: improve virtqueue mapping error messages
Message-ID: <0427ff865957ffc66404307f25ca26bd9a4507cb.1759695382.git.mst@redhat.com>
References: <a9324cdecb0d9f7ae7db7f4120251b50cc768d7c.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9324cdecb0d9f7ae7db7f4120251b50cc768d7c.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alessandro Ratti <alessandro@0x65c.net>

Improve error reporting when virtqueue ring mapping fails by including a
device identifier in the error message.

Introduce a helper qdev_get_printable_name() in qdev-core, which returns
either:

 - the device ID, if explicitly provided (e.g. -device ...,id=foo)
 - the QOM path from qdev_get_dev_path(dev) otherwise
 - "<unknown device>" as a fallback when no identifier is present

This makes it easier to identify which device triggered the error in
multi-device setups or when debugging complex guest configurations.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
Message-Id: <20250924093138.559872-2-alessandro@0x65c.net>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/qdev-core.h |  1 +
 hw/core/qdev.c         | 29 +++++++++++++++++++++++++++++
 hw/virtio/virtio.c     | 15 ++++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 530f3da702..a7bfb10dc7 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1064,6 +1064,7 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 extern bool qdev_hot_removed;
 
 char *qdev_get_dev_path(DeviceState *dev);
+const char *qdev_get_printable_name(DeviceState *dev);
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler);
 void qbus_set_bus_hotplug_handler(BusState *bus);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f600226176..fab42a7270 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -411,6 +411,35 @@ char *qdev_get_dev_path(DeviceState *dev)
     return NULL;
 }
 
+const char *qdev_get_printable_name(DeviceState *vdev)
+{
+    /*
+     * Return device ID if explicity set
+     * (e.g. -device virtio-blk-pci,id=foo)
+     * This allows users to correlate errors with their custom device
+     * names.
+     */
+    if (vdev->id) {
+        return vdev->id;
+    }
+    /*
+     * Fall back to the canonical QOM device path (eg. ID for PCI
+     * devices).
+     * This ensures the device is still uniquely and meaningfully
+     * identified.
+     */
+    const char *path = qdev_get_dev_path(vdev);
+    if (path) {
+        return path;
+    }
+
+    /*
+     * Final fallback: if all else fails, return a placeholder string.
+     * This ensures the error message always contains a valid string.
+     */
+    return "<unknown device>";
+}
+
 void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
 {
     dev->unplug_blockers = g_slist_prepend(dev->unplug_blockers, reason);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index de89e8104a..d38aafe5eb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -257,7 +257,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, packed);
     if (len < size) {
-        virtio_error(vdev, "Cannot map desc");
+        virtio_error(vdev,
+                "Failed to map descriptor ring for device %s: "
+                "invalid guest physical address or corrupted queue setup",
+                qdev_get_printable_name(DEVICE(vdev)));
         goto err_desc;
     }
 
@@ -265,7 +268,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        virtio_error(vdev, "Cannot map used");
+        virtio_error(vdev,
+                "Failed to map used ring for device %s: "
+                "possible guest misconfiguration or insufficient memory",
+                qdev_get_printable_name(DEVICE(vdev)));
         goto err_used;
     }
 
@@ -273,7 +279,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-        virtio_error(vdev, "Cannot map avail");
+        virtio_error(vdev,
+                "Failed to map avalaible ring for device %s: "
+                "possible queue misconfiguration or overlapping memory region",
+                qdev_get_printable_name(DEVICE(vdev)));
         goto err_avail;
     }
 
-- 
MST


