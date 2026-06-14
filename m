Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35306CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDQ-0000Ev-5j; Sun, 14 Jun 2026 15:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDJ-0007mM-Su
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDI-0002iV-69
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LeQdwvlxUcXinBqYKDGXgIIF+pdKo0MXbEyWkBYMIlM=;
 b=g9uToUj56+6+mwTarffOM97D5qTQhM8fgqUrwwXSNoCu4TFQBhjVnrxU0Kc8+Vlq8oHOl7
 XrvH7qrJHKrAcGpyvYevzdJkUOaRksDOmXyE8hH4dozWdlnh9Og8fn+a7gJ3QZM4wYUW/h
 SfSQFLDVdxtfbEIIqSM2XbnTpjoFzfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-JejFclSBNV-IaX8K98kwbg-1; Sun, 14 Jun 2026 15:09:42 -0400
X-MC-Unique: JejFclSBNV-IaX8K98kwbg-1
X-Mimecast-MFC-AGG-ID: JejFclSBNV-IaX8K98kwbg_1781464181
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490e547f3cfso24344405e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464181; x=1782068981; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LeQdwvlxUcXinBqYKDGXgIIF+pdKo0MXbEyWkBYMIlM=;
 b=HMmQKvjtaFNsiFyMnFMOsyhD+kUBwDiMjUEEp6vw5kJXTdhtlghvhGczSZ4O0JqMeP
 gaogAqWb7bXrb4JJzaPkLLlOGoZ+C2f5R/g5Zvj81GedGg3BCWiGqbTsGLIDjFd8XXXH
 rjar9bycIpZay9l9n43QB5BSZ+HQvq8Hm+r1uIMDFs1AhzDW8mNvOAxa/F20p1ry2FAD
 eK///twBLbmrm3T0+7NFIx0iGY4nDracbi8iTypv4e3Q3oqhmxovxKdfXmyJz1HRRjw9
 SC39OA0Ht8DRnPc/3KDMJkvQAH/KOtx4pRy0pU+NhBHsvEZrxhGtqtB4K1wgh6OAH0Za
 nB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464181; x=1782068981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeQdwvlxUcXinBqYKDGXgIIF+pdKo0MXbEyWkBYMIlM=;
 b=oBxXaoG9cfUhCpOXGfg0NOPCDhNyARaUAaO9p1UXLJuBnYwjebpvkZj9Gt/HOKk9R0
 246Wl6KuBekU01A47oo2Awv912GOftEAuK9LLOTMk3Hj6iPITRsA9P3bomDA58+fTrv5
 SIye7TjguWgqxUJ3dLDZTl8aF7z1E0YzzqqaD9BgWPrSkPsZN3zuJtSJerLjHgNusjnV
 2O1IV1cJAwe97QdEZEzUy6N0g+GtSvzNgIqtfd0D0SHX3zMTZsqWKqrIg70cciKIz0Zl
 45gwVSyT2Z01hRk/qVAtzY/6ct+kye+CBq8KCbnqq1+5cliaLo2i4h8mzZXs5pxNMLKW
 Yzdw==
X-Gm-Message-State: AOJu0YxoDrDBnAFCL2YUJLyflut2iygyGUTGOANDcXhjAYbEhyX4w0jd
 coJwApOohF22OdFdPdAewt93mbELBmzUXJPozqNlZLzDrzRXjrPvFQl6hZzsu5G9ATqeAEp1aUS
 O91EKLrsnbY1F/dSG8aTNAFL0yTuJUGWBbMexgCh6kUWJ+5OXmGGYbVoVzvqvhO2ZvjLXvWMU67
 RrScaCem3Yo/nLxyYzPdhZUcaRQI7weCGXlw==
X-Gm-Gg: Acq92OH57d0SKxiqbz8dBn41KcEkVcLI2saTWwynKSL24CDq2gJQdrtCfWynAhgbR0t
 RJj/nPWa7gopRiJ+m5DJ9jnVVW1yRgPA2483CeK+b4thtfU8ZtVtpo2GzqJvDQXCrjBef2+eXPL
 TyX7Uc4JnDmq0YPv1Ap2s2lK4NEbv3NQx6bSHqqr8v3c2H86XnEJaADuS4vv4FQp2AhEKI34VmA
 kaU/XaYNS857uRRtkWFtATgVuUM/uHA0SDIbtc++NdlQ54zYHwcTxwfxFP4CUjKrpxLdOHrgifd
 xyAWAL1hnCEvK+UnRImRJBA8+ALzXlenSD8Kb8r2aNTZPKSXFG0hNsJutqIx4z5Zempo6TIoIF2
 mCa4XnwKaEhJ64K9wUqqdnray5eDgIeEYEem+Prm6IIg=
X-Received: by 2002:a05:600c:820c:b0:490:5cd8:d213 with SMTP id
 5b1f17b1804b1-490ec4d3407mr144348825e9.15.1781464180834; 
 Sun, 14 Jun 2026 12:09:40 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:5cd8:d213 with SMTP id
 5b1f17b1804b1-490ec4d3407mr144348475e9.15.1781464180291; 
 Sun, 14 Jun 2026 12:09:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220310a58sm210690175e9.4.2026.06.14.12.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:39 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 094/106] vhost_user: Add frontend get_shmem_config command
Message-ID: <458f80f661e51d09936efb53eaba7c0d81ba323c.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Albert Esteve <aesteve@redhat.com>

The frontend can use this command to retrieve
VirtIO Shared Memory Regions configuration from
the backend. The response contains the number of
shared memory regions, their size, and shmid.

This is useful when the frontend is unaware of
specific backend type and configuration,
for example, in the `vhost-user-device` case.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304165223.2166175-5-aesteve@redhat.com>
---
 include/hw/virtio/vhost-backend.h         | 10 ++++++++++
 include/hw/virtio/vhost-user.h            |  1 +
 include/hw/virtio/virtio.h                |  2 ++
 subprojects/libvhost-user/libvhost-user.h |  4 +++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 00881a0bd4..d878d7b733 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -162,6 +162,15 @@ typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
                                             int *reply_fd,
                                             Error **errp);
 typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
+/*
+ * Max regions is VIRTIO_MAX_SHMEM_REGIONS, so that is the maximum
+ * number of memory_sizes that will be accepted.
+ */
+typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
+                                         int *nregions,
+                                         uint64_t *memory_sizes,
+                                         Error **errp);
+
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -220,6 +229,7 @@ typedef struct VhostOps {
     vhost_supports_device_state_op vhost_supports_device_state;
     vhost_set_device_state_fd_op vhost_set_device_state_fd;
     vhost_check_device_state_op vhost_check_device_state;
+    vhost_get_shmem_config_op vhost_get_shmem_config;
 } VhostOps;
 
 int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 5ab70dab7e..06c360af18 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -35,6 +35,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
     VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
     VHOST_USER_PROTOCOL_F_GPA_ADDRESSES = 21,
+    VHOST_USER_PROTOCOL_F_SHMEM = 22,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 3f745e3b67..c99cb19d88 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -82,6 +82,8 @@ typedef struct VirtQueueElement
 
 #define VIRTIO_NO_VECTOR 0xffff
 
+#define VIRTIO_MAX_SHMEM_REGIONS 256
+
 /* special index value used internally for config irqs */
 #define VIRTIO_CONFIG_IRQ_IDX -1
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index 6a2d0f9fae..a534d70771 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -70,7 +70,9 @@ enum VhostUserProtocolFeature {
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE */
-    VHOST_USER_PROTOCOL_F_SHMEM = 20,
+    /* Feature 20 is reserved for VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT */
+    /* Feature 21 is reserved for VHOST_USER_PROTOCOL_F_GPA_ADDRESSES */
+    VHOST_USER_PROTOCOL_F_SHMEM = 22,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
-- 
MST


