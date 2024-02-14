Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8982EC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFc-00060p-M5; Wed, 14 Feb 2024 06:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFZ-0005wY-Pd
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFY-0007WQ-2c
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWvXvbaJCJDx3gylChFMzTBYNmFWTG/2A3hUdEuwE2s=;
 b=G5BKpfU+bzfFRHvIL7m2XN1fCvx9k9r2K+K134olAe+6afYc9q9b9s2D5HZKVKdjHLMB2n
 ssxJ+tSZBRinpZ7XtfdWO4XYM7atdNgS2TogQgFp5mZukvhxHxm1xz5JdAhEF40o/HcjRL
 Wr9yE/ILZgQRvOt+47HP9a1VNr6KzNY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-L6p72Ht8MIa7GdG-gYEKoA-1; Wed, 14 Feb 2024 06:16:22 -0500
X-MC-Unique: L6p72Ht8MIa7GdG-gYEKoA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3c3f477eb7so186417066b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909380; x=1708514180;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uWvXvbaJCJDx3gylChFMzTBYNmFWTG/2A3hUdEuwE2s=;
 b=p3TZC7x6GaHUQkd5sC8d0rIsSMoKsVFiHJRV48RtgsNvGyuSldIZAnVtojo5jJbU4o
 fUa3IBqpEIQKRVz8F1qjg5deB2DgTNipUy0jBVHCo12ZhQfhTWhi2+CoepRrGJh7dL3g
 GUYIy9O0yWRAZOC0jx+MREPOKEjovuEQoO6IcsXjz3Mx44Qp9G1RaUEpBVmt5EPhG0xO
 RB+74v7JtyOKiuTw1f0vvUDw8xpKuUXBafqcudDjFohtMSdTRd6LNwia5jo+F/YjGfVs
 fARueVkgbtsD2mJNj3mXrgYG2IKPb36ka9RuRGDMrcg7vQ7tWQm8Vc1eZR4HhLGyvr9w
 mU1A==
X-Gm-Message-State: AOJu0YzPnQAHIl57H4+r2np5FEw4FVPlJMKfCsTFXEzQ1I7r4K4zEI7n
 59eWzkzwSNlq1WxBFAdXjfGTQH1wFML0eV1RT0pEUcVhTFFdlWBUzujMjYbbQoHvi+50EVbTAAb
 5dRGQovaVu+q+hKXQuP+JNkG8X+0PMfhxo+ZF4Ngv1zRTTf1fkhcswsrwGUy7ax9Ld0XG3ZI2Zy
 OcU/mSBUxsKWFjxzZ/fAqm686lxtuD2Q==
X-Received: by 2002:a17:906:d14f:b0:a3d:1edf:f9c6 with SMTP id
 br15-20020a170906d14f00b00a3d1edff9c6mr1525267ejb.33.1707909380405; 
 Wed, 14 Feb 2024 03:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGCOhcF574L1dv+7lkgQaW6VX6fPFKzac6lvta0OO8ZsLFiv/7ZJOyvUvaDBbYC1oLK1573w==
X-Received: by 2002:a17:906:d14f:b0:a3d:1edf:f9c6 with SMTP id
 br15-20020a170906d14f00b00a3d1edff9c6mr1525246ejb.33.1707909380001; 
 Wed, 14 Feb 2024 03:16:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVaHudQaTlihTqrNJfllMBJi68j/BTCrgUJ3HRnpOykh6VzemLlSw1rPU38uubMELGSwYwyOqr9+lxvm8IF6t1rcdtWnQO2a1an7oZh91j9sE07F6/KlNnpu4Kozo4JYj0vWAJ9bBupmH5hDfSz59yrm30+/kGjafy2MO6E3NM=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 y8-20020a170906558800b00a3d409ebe5fsm550631ejp.119.2024.02.14.03.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:19 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 58/60] virtio-gpu.c: add resource_destroy class method
Message-ID: <330399bd8935c9c2100c40e168781f405545d05a.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
need to do their own bookkeeping (free rutabaga resources that are
associated with the virtio_gpu_simple_resource).

This commit adds a class method so that virtio-gpu-rutabaga can override
it in the next commit.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <b0a86630c4d601f3a269fd7e08cfefc13bd4e219.1706626470.git.manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  3 +++
 hw/display/virtio-gpu.c        | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 584ba2ed73..b28e7ef0d2 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -219,6 +219,9 @@ struct VirtIOGPUClass {
     void (*update_cursor_data)(VirtIOGPU *g,
                                struct virtio_gpu_scanout *s,
                                uint32_t resource_id);
+    void (*resource_destroy)(VirtIOGPU *g,
+                             struct virtio_gpu_simple_resource *res,
+                             Error **errp);
 };
 
 struct VirtIOGPUGL {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2b73ae585b..1c1ee230b3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -402,7 +402,8 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 }
 
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
-                                        struct virtio_gpu_simple_resource *res)
+                                        struct virtio_gpu_simple_resource *res,
+                                        Error **errp)
 {
     int i;
 
@@ -438,7 +439,11 @@ static void virtio_gpu_resource_unref(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
     }
-    virtio_gpu_resource_destroy(g, res);
+    /*
+     * virtio_gpu_resource_destroy does not set any errors, so pass a NULL errp
+     * to ignore them.
+     */
+    virtio_gpu_resource_destroy(g, res, NULL);
 }
 
 static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
@@ -1488,11 +1493,24 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 static void virtio_gpu_reset_bh(void *opaque)
 {
     VirtIOGPU *g = VIRTIO_GPU(opaque);
+    VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
     struct virtio_gpu_simple_resource *res, *tmp;
+    uint32_t resource_id;
+    Error *local_err = NULL;
     int i = 0;
 
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
-        virtio_gpu_resource_destroy(g, res);
+        resource_id = res->resource_id;
+        vgc->resource_destroy(g, res, &local_err);
+        if (local_err) {
+            error_append_hint(&local_err, "%s: %s resource_destroy"
+                              "for resource_id = %"PRIu32" failed.\n",
+                              __func__, object_get_typename(OBJECT(g)),
+                              resource_id);
+            /* error_report_err frees the error object for us */
+            error_report_err(local_err);
+            local_err = NULL;
+        }
     }
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
@@ -1632,6 +1650,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vgc->handle_ctrl = virtio_gpu_handle_ctrl;
     vgc->process_cmd = virtio_gpu_simple_process_cmd;
     vgc->update_cursor_data = virtio_gpu_update_cursor_data;
+    vgc->resource_destroy = virtio_gpu_resource_destroy;
     vgbc->gl_flushed = virtio_gpu_handle_gl_flushed;
 
     vdc->realize = virtio_gpu_device_realize;
-- 
MST


