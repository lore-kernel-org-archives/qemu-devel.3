Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2E5D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Yi-0007mD-TF; Mon, 04 Nov 2024 16:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Yh-0007lu-7R
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Yf-0006uV-Hw
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730755460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DreMzE5l8O9RuGS8oEwWkZEzopXOO7MX3eO79wqdwag=;
 b=bQoWnxh7Hyo2OMIxfXEuoETFPnrF/RCVOWOr1VGgVhlPqX0HH1n9hmTaGrxepX7EuViadn
 4DiijjG+K+IQCAcQ9AGABI06bE1SPWcimkT09KXNfa+5wEvthPqL4NeTVa71YERKtIY5Ck
 /vl4K/04z0mk/mFbZJkWT5ONWUD7+qk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-QdznsFODMhyGgsjteIZw9A-1; Mon, 04 Nov 2024 16:24:18 -0500
X-MC-Unique: QdznsFODMhyGgsjteIZw9A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so34542295e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730755457; x=1731360257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DreMzE5l8O9RuGS8oEwWkZEzopXOO7MX3eO79wqdwag=;
 b=YSY3aP6pb44gl1w1oP8gyr45nEsrUdcNjaFjY9IsI4bNLGmKx6RaJsXdl7fta1IuBD
 xKb8UPFPCIaJbFRPj0L1TNyNX7dzV5dDHh7I5ikaAHPYks4qJcPGTH5epc/1DelD4aG9
 LsbDgHs8lbJg0syhBwJFLqA7KXKyUFDUTccurxK1uycKE1XXLm+rzxEsXPrtn2fXyRYE
 tiYbdEZfqzcF4HIHRAaCuQCltC60RAZefUPYNtfeaC+sz8Gb6edC6x+QK7uTkeUFxrkH
 dWReVn+UMNkPNx1R5+hY3Nl5q8F/7kzTk2TNzdbWksCeM/A4kgDs9Co7LMxNnfPA37DT
 lEtA==
X-Gm-Message-State: AOJu0YxknGkTApCpVha83ywtKVIXo7Fa3kZ/ubONGajUE2sR0jZAAx1Y
 C6LnVTUQBexfJ+QrkkTggBaJCUyOwZNodf2wA1fbIRlv1Lr/WY7Bn2GLmYy6VgjW+UREurAqKpu
 ZkR009rIfBdRjNuykepIy1jwxbP2ICFs+GF0X50mxaN6jLzy1l8ohaq/QiJhj+1uJM9PNbtS5KV
 1yGnzhHXkgu7Mjq6FYYq0JTY4xksSQIQ==
X-Received: by 2002:a05:600c:3b94:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-4327b82138dmr138300975e9.32.1730755456998; 
 Mon, 04 Nov 2024 13:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWeEt6h5fo5qV7ErSVl2DeEI9Shk/s98EvtWGsduzw3eN2kbn1sI82Y5axjaIWyqjo4MzFPA==
X-Received: by 2002:a05:600c:3b94:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-4327b82138dmr138300825e9.32.1730755456586; 
 Mon, 04 Nov 2024 13:24:16 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e771sm14249189f8f.81.2024.11.04.13.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:24:15 -0800 (PST)
Date: Mon, 4 Nov 2024 16:24:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 42/65] vhost-user: fix shared object return values
Message-ID: <eea5aeef84e1b74f515b474d3a86377701f93750.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Message-ID: <20241104212412.xoRzNZqealRUl3iwShNcpgoTqsuThkob9nG1IoJ0j98@z>

From: Albert Esteve <aesteve@redhat.com>

VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
in the spec that they return 0 for successful
operations, non-zero otherwise. However,
implementation relies on the return types
of the virtio-dmabuf library, with opposite
semantics (true if everything is correct,
false otherwise). Therefore, current
implementation violates the specification.

Revert the logic so that the implementation
of the vhost-user handling methods matches
the specification.

Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Message-Id: <20241022124615.585596-1-aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d1b0893b4d..f170f0b25b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1623,9 +1623,14 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
-    return virtio_add_vhost_device(&uuid, dev);
+    return !virtio_add_vhost_device(&uuid, dev);
 }
 
+/*
+ * Handle VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE backend requests.
+ *
+ * Return: 0 on success, 1 on error.
+ */
 static int
 vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
                                                VhostUserShared *object)
@@ -1639,16 +1644,16 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
         struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
         if (dev != owner) {
             /* Not allowed to remove non-owned entries */
-            return 0;
+            return 1;
         }
         break;
     }
     default:
         /* Not allowed to remove non-owned entries */
-        return 0;
+        return 1;
     }
 
-    return virtio_remove_resource(&uuid);
+    return !virtio_remove_resource(&uuid);
 }
 
 static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
-- 
MST


