Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B46C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFe-00063r-PH; Wed, 14 Feb 2024 06:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFc-00060Z-AX
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFa-0007Wu-Kc
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I30j7lVXoI5R21ou36fHAIQFrRuJEAkbfijdJs+XjD8=;
 b=fCX4nTZyCsVoL4GoVmKMPFnHtCNZ2I7XntFjfrfjiuDX6zySC0Sj6rHg3K1Py5F9rrQ4Bt
 viWhBPg8K1cbVwzLMAEbothxmtnMELEjP7t78UHCqwh7qttBUZ9KK2A82R8tf3dBjUqp9q
 w5tH3fazj33qjDhbNfkS3f85rEtcs9Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-C1u8OgJ0MAOpO0SIFah6Ow-1; Wed, 14 Feb 2024 06:16:24 -0500
X-MC-Unique: C1u8OgJ0MAOpO0SIFah6Ow-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-511535180b4so4261555e87.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909383; x=1708514183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I30j7lVXoI5R21ou36fHAIQFrRuJEAkbfijdJs+XjD8=;
 b=wOaLvGltpJZhT+RZ/+x/3KZQB9cIaNt9Zvl3BwFEl75lmATYBhVAA8NLwVnLXx/hA1
 Zq+Xp/pbozindnKScdOkgbhEqSVvix3QPvIcQDLw85w09cCcUkiIS7bKW+B3tt0a6FV3
 ZxVhGNjgjH9eFy1jQy571loQIvfLe4wHpWcyM6r8qkvnbSUIT9W6i2UIv7kE1GdrLhDG
 x0yHHp7Ao0v32mh+8gCvC2oFwEJsyvRohgQ2i2H+JBIVvhyt7Mxc+FD/HoIYV0G8WAlE
 K+R5OZd1KFYjgmVKO2TiND/n360ijVWI1JESHqdxQmk7Giiri6ackEKgLQxN4T5YHBxQ
 7TvA==
X-Gm-Message-State: AOJu0Yzbea2+qKSUsFzA3XZcpWI7I6fPYDpBMAhOdTpep4YwSWNoLMyQ
 /s5TAmkmALnUHcZyaUvC4N1yQ6uKkptTLkazz7uaiUbee57qfWlpC+bKH/JA/Q9PIKhT0faQl12
 cRRP06B+IVXhjVGKRIA7X/YfXMru7R4vMyjd6UiJieGCrohKMycii6nUFfwccwJAUVpZlffnYx7
 gkLQcLnNQTaCid8Nk9i2uJGA2Kwn89cg==
X-Received: by 2002:a05:6512:1287:b0:511:acd9:c10d with SMTP id
 u7-20020a056512128700b00511acd9c10dmr546764lfs.40.1707909383135; 
 Wed, 14 Feb 2024 03:16:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFopikCh4jJnR2UIzWfLdhF3HSFZxY+K97pd1SYMQTZbGQwpWG+0Zn/NObii+NynNh3Mf0I7g==
X-Received: by 2002:a05:6512:1287:b0:511:acd9:c10d with SMTP id
 u7-20020a056512128700b00511acd9c10dmr546739lfs.40.1707909382777; 
 Wed, 14 Feb 2024 03:16:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWMxzjOMceSY6eaK6U5U9SXP6EnQF6qPF/7f2PwekTbS0td1Zjasd2r9cqQ4oDruONcItmYhz2sdbVzPxaRb9YBAkc+liv4Pfvp21bC/mDJ293SPM66ocP7JDVmHG3ZZXmK4J6RmK5OXH3C8sP9JXseSfru9LzlUe+9SCsAUsw=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 lj8-20020a170907188800b00a3d2e685ff2sm805646ejc.78.2024.02.14.03.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:22 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 59/60] virtio-gpu-rutabaga.c: override resource_destroy method
Message-ID: <148d114933ea0cab43a3f575cf7516c362c74d2a.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

When the Rutabaga GPU device frees resources, it calls
rutabaga_resource_unref for that resource_id. However, when the generic
VirtIOGPU functions destroys resources, it only removes the
virtio_gpu_simple_resource from the device's VirtIOGPU->reslist list.
The rutabaga resource associated with that resource_id is then leaked.

This commit overrides the resource_destroy class method introduced in
the previous commit to fix this.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <e3778e44c98a35839de2f4938e5355449fa3aa14.1706626470.git.manos.pitsidianakis@linaro.org>
Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 47 ++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 9e67f9bd51..17bf701a21 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -147,15 +147,39 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
+static void
+virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
+                                   struct virtio_gpu_simple_resource *res,
+                                   Error **errp)
+{
+    int32_t result;
+    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+
+    result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
+    if (result) {
+        error_setg_errno(errp,
+                        (int)result,
+                        "%s: rutabaga_resource_unref returned %"PRIi32
+                        " for resource_id = %"PRIu32, __func__, result,
+                        res->resource_id);
+    }
+
+    if (res->image) {
+        pixman_image_unref(res->image);
+    }
+
+    QTAILQ_REMOVE(&g->reslist, res, next);
+    g_free(res);
+}
+
 static void
 rutabaga_cmd_resource_unref(VirtIOGPU *g,
                             struct virtio_gpu_ctrl_command *cmd)
 {
-    int32_t result;
+    int32_t result = 0;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_unref unref;
-
-    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+    Error *local_err = NULL;
 
     VIRTIO_GPU_FILL_CMD(unref);
 
@@ -164,15 +188,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
     res = virtio_gpu_find_resource(g, unref.resource_id);
     CHECK(res, cmd);
 
-    result = rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
-    CHECK(!result, cmd);
-
-    if (res->image) {
-        pixman_image_unref(res->image);
+    virtio_gpu_rutabaga_resource_unref(g, res, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        /* local_err was freed, do not reuse it. */
+        local_err = NULL;
+        result = 1;
     }
-
-    QTAILQ_REMOVE(&g->reslist, res, next);
-    g_free(res);
+    CHECK(!result, cmd);
 }
 
 static void
@@ -1099,7 +1122,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
     vgc->handle_ctrl = virtio_gpu_rutabaga_handle_ctrl;
     vgc->process_cmd = virtio_gpu_rutabaga_process_cmd;
     vgc->update_cursor_data = virtio_gpu_rutabaga_update_cursor;
-
+    vgc->resource_destroy = virtio_gpu_rutabaga_resource_unref;
     vdc->realize = virtio_gpu_rutabaga_realize;
     device_class_set_props(dc, virtio_gpu_rutabaga_properties);
 }
-- 
MST


