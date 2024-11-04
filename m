Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2C2D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JM-00059i-9a; Mon, 04 Nov 2024 16:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JK-0004wh-IN
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JI-0005TI-NE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DreMzE5l8O9RuGS8oEwWkZEzopXOO7MX3eO79wqdwag=;
 b=aqLwKdNxosxZZGaeday49iLfAcLtOTSylZ6IeL4+RlsZg2K6xfScbCDeVKWU20Jp++CpQp
 +BjUpcIkBzo6/zLEULcFu8mexUKgLmhxBSmFxlxb5JkB7H0NLn8pc6gn37o3awkB8KowBK
 P94H3czbcDndSZbpKg0waDBS0RZstjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-1VtKnJMnPhyHCIex6-exig-1; Mon, 04 Nov 2024 16:08:26 -0500
X-MC-Unique: 1VtKnJMnPhyHCIex6-exig-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so34461725e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754505; x=1731359305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DreMzE5l8O9RuGS8oEwWkZEzopXOO7MX3eO79wqdwag=;
 b=pfE81RWkgGdoVQElWwtLhpNssSI+MORpcw2oVCXfwCghlHsxllbj6+LsnF/ePyunMN
 3XcN+ykkhMrj55w4mv7AbdKqHbHRca2l/kgQA8l5Dwf6BvVszHhw32zEiIP+z1PbCxHj
 nBUIG/v56A/Cb0zMWBIPu/Azk1N6jbK/IJPcQBlV3bSkb/IllnW2pXUhW4vxv1By6nNJ
 rBkjdbqpXguOFf7zbLqmcvPBxMBMp1owfr7wmnbcZpmq4sYFlwghwbXYAUpNHqIHTCjn
 PuYltrGomR6x0reMV+bRTAgX/vPGOW5DlAqBe6AUp4tDyP/gphyNbAMpexvB9/0LJ9MM
 JPTg==
X-Gm-Message-State: AOJu0YySjxUUdDf6eqJwsci8WfRc0W3EYoK1yIJxNQdDEs6CldNl+iro
 zZMPW0BfQ+TWTzRzocltEbb6GpIkSXLiKLQePHEP1Gg8lZCV8O7LV2/Zcxr/FYbJJPMpPFSIUng
 GsFSYZ+rBJSD4xeaPVRep1DaA3X+RIe8X4EwHlNhLQhGz//JLZHoB48eRee6T2lUOfqmEB2R/pi
 4cLUO/YyUvSKG9Uik5IZ+6xGJL5GlgsA==
X-Received: by 2002:a05:600c:a41:b0:431:5021:32 with SMTP id
 5b1f17b1804b1-4327b6f9564mr136272385e9.6.1730754505028; 
 Mon, 04 Nov 2024 13:08:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5BfoHcABNNuxPmbIEF3HHjRET8q5SOeMgJ7vx6hop8SHt4ixfDa7XVntgZxKzdv2OPjulPQ==
X-Received: by 2002:a05:600c:a41:b0:431:5021:32 with SMTP id
 5b1f17b1804b1-4327b6f9564mr136272205e9.6.1730754504579; 
 Mon, 04 Nov 2024 13:08:24 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26f51d4sm1020455e9.1.2024.11.04.13.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:23 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:20 -0500
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


