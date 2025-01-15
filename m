Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32550C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7om-0006If-0W; Wed, 15 Jan 2025 13:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7oj-0006I0-Tn
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7oi-0006UV-Dk
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6fmu5UNbIG+Zy8TKEXBZ0Py33cRbkHlfHziwEK/kCk=;
 b=ZQaO3yloSOQBjl9t/45YaAlTRNbJW+fBufx4B2lqtuvOtSoXmxee9wsDfWAqttrcq6ov5y
 lIrdEiQvN3bazfdMP4W5FpLvPM/yptnumJo+oJpDnqApXFfaJsnN3e1cHMIso/SKm2KJX+
 ghPZTcT4CZPe5ira5PxptrqqTg7/RiY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-xxJtlPcJNseZcQJ-4VX8BA-1; Wed, 15 Jan 2025 13:08:33 -0500
X-MC-Unique: xxJtlPcJNseZcQJ-4VX8BA-1
X-Mimecast-MFC-AGG-ID: xxJtlPcJNseZcQJ-4VX8BA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so44609f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964512; x=1737569312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6fmu5UNbIG+Zy8TKEXBZ0Py33cRbkHlfHziwEK/kCk=;
 b=cJXxIsxjoFjDOC07lJdOLr/wMfL7Yz4jQ/SuBs6duFcCWf2perMVXAiWeWa9DtB4Um
 SVRIRKiqo6A8xbocUhFA42eYUk+FTF7OtaSB4oXL3VbBBIZKL1qz7Zvguvtee6g2+Hq3
 37hTNib4BDQIKoHZXkNIbRhm1mnmk6KNJ0K3YTGph9lI/zun6W04fryztEk3QSikjuCU
 GmRCTGBFR+K8X0X0gPU2KudiOvLhCeFsCtbQJ6fWQ8Y1keoRyTBSpoAfM8uCHdowNW/x
 H9V6FQm//2GfI8sVCX8wp39Bws5XHMtmlOpEHrKDPFF2XtKy0HdPOTZS5xdVh5BeI6iz
 p8Qg==
X-Gm-Message-State: AOJu0YzCZ0RyKiqSUHBUsaB39W/sLGRAH0q3a0KXnYr62mWzFldZXX9b
 VXv7fseZssE29dPxMIwlO2YUQP9Fl9rr7X6iB99AQ8gNnui150Auj48EOvXfrftZ4z0F02DJyvH
 QW5BgRTwrS5LZBE2OBxH6aek9mKBh2gse8O9ZhrxgaKWAzR0r9DNAiFkVR5X++EErMVUbzXCRA1
 PAYI40/Sdy/qhAl+SXg+l4lZVvWJ59Fg==
X-Gm-Gg: ASbGncvjS7wIaCfP47xi8v+5Ill0+c4+0ZX1eslpCysfZp92Oft6IbHoQfZzLxl619w
 RqZ4csaMLXcPgNi+nQ9CN505iPgK5cpmKMVsrNSGXwOiir5/eRCSvW8jfMH6XEPW8gkY73QCnLp
 /F8W0r3u7KkZos9DB/U5hDoK3EDkXSXbrPdsMyht8CxQbjQfNvfO3egvydOHfqMpgbWP0fa3isc
 0K3WHhFVQYTdC3IPeMTrKt3OlJGFvf1eC7zwCgKriU2M1rYZz10
X-Received: by 2002:a05:6000:1563:b0:385:f44a:a53 with SMTP id
 ffacd0b85a97d-38a872cfe40mr21742476f8f.4.1736964512091; 
 Wed, 15 Jan 2025 10:08:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHDJaD8CKwez+RznVpLdNivNogm5ATuB3y63h+XfrYTOdlxbIWQxZGVvPN/VDISNafahRZZw==
X-Received: by 2002:a05:6000:1563:b0:385:f44a:a53 with SMTP id
 ffacd0b85a97d-38a872cfe40mr21742449f8f.4.1736964511676; 
 Wed, 15 Jan 2025 10:08:31 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38378csm18138284f8f.25.2025.01.15.10.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:31 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 01/48] virtio-gpu: Add definition for resource_uuid feature
Message-ID: <1e77a4a32f8b7b6699a2f8b1f98e8fada902ba1f.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dorinda Bassey <dbassey@redhat.com>

Add the VIRTIO_GPU_F_RESOURCE_UUID feature to enable the assignment
of resources UUIDs for export to other virtio devices.

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
Message-Id: <20241007070013.3350752-1-dbassey@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 3 +++
 hw/display/vhost-user-gpu.c    | 8 ++++++++
 hw/display/virtio-gpu-base.c   | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index bd93672185..a42957c4e2 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -98,6 +98,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
+    VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -114,6 +115,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
 #define virtio_gpu_rutabaga_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
+#define virtio_gpu_resource_uuid_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED))
 #define virtio_gpu_hostmem_enabled(_cfg) \
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 12d5c37ee5..2aed6243f6 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -631,6 +631,14 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
         error_report("EDID requested but the backend doesn't support it.");
         g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLED);
     }
+    if (virtio_has_feature(g->vhost->dev.features,
+        VIRTIO_GPU_F_RESOURCE_UUID)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
+    }
+    if (virtio_has_feature(g->vhost->dev.features,
+        VIRTIO_GPU_F_RESOURCE_UUID)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
+    }
 
     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
         return;
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 4fc7ef8896..7827536ac4 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     if (virtio_gpu_context_init_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
     }
+    if (virtio_gpu_resource_uuid_enabled(g->conf)) {
+        features |= (1 << VIRTIO_GPU_F_RESOURCE_UUID);
+    }
 
     return features;
 }
-- 
MST


