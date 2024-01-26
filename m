Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318B5C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNPb-0003FJ-Gl; Fri, 26 Jan 2024 09:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPa-000371-1r
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:30 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPY-0001RU-72
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:29 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-339289fead2so534560f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706280146; x=1706884946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQtopNr5vvMf8lcJyxn/yFZa/KfoJjaby+4DFvKGnn8=;
 b=C0tY+8p1s5+j62icBultZP/BKwNlioJ6LxcpSvKNYzaajII/b+VVDxNndd9jSldrHl
 YEzbwuGaslFtoC376bhYiD1M6YyI9PymaZpLfYhvdRvsRk1wl40y/UHSaLNm0b72F721
 5OK6wPuhiD6shI7K8QTgyqU006pTmPap3WI+oFjRkdrj9BvNIvt1bWys1XAAkRLmaYzQ
 y/+yrZQy2BCGWQyWyx5zVVw/W8RtB/7BET8oyHy+7+gpVDyiIcjfMGBe++ITrTGxsKyu
 714NuHbRnbLlcQTRQUcvqOTSrUL3KLr0/XYghyZLOXhJvQi0PRqVEALNRMoaX8sBzQIZ
 bTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706280146; x=1706884946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQtopNr5vvMf8lcJyxn/yFZa/KfoJjaby+4DFvKGnn8=;
 b=e+7pK9Phtx3J1zW5npQhX02d5SWh2PmnHE+5KJ0b7uIpmNZgfIEwZlfpJR4dkfdFGC
 LDQpTeJMJklSQrUHXHAfLwP9mpwlOGIXrgwI5qqqrkx6he1QHuBRqHefZSsvE/Vl7dAK
 Y4VLDCDT1cq+C54jQDWmEDZhCaCOcGVN3sBzYwXhC0qoJbn+ObGzF6CWOE68Pgg3JLcT
 q3JpxiCuH5N1bH4kzJENunmnUpraHw26Psbf1oHZg7YVLjUSc0a/wMBjiC6AzLX+pjyA
 TPjrvwxqx/acXCt9KaFRAmtcHEZ763/JSHyVRNWN/AHbT5AthiUxakdTitIRYYe+OX4r
 hMLQ==
X-Gm-Message-State: AOJu0YzdsPlS9xexS7rjOivo0A6m0TSTCLqKEBprp0f8kHSoOHItPLHE
 1K8dr3ZgyIwLXtEslegt9yfBZ80xX+OG4YCHx8kWUVjCizQwa/oPCDvPKAz71y35o/78akucbcF
 unzE=
X-Google-Smtp-Source: AGHT+IHd+6xavana+NPb/ZCsOY5jqmQEf4NX5yvfwKgTl6uDFfxmJNEZ9E6pGoIGhVIIikGPOWGvgQ==
X-Received: by 2002:a05:600c:3423:b0:40e:76b7:e8e3 with SMTP id
 y35-20020a05600c342300b0040e76b7e8e3mr942971wmp.226.1706280146256; 
 Fri, 26 Jan 2024 06:42:26 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.225.tellas.gr.
 [109.242.225.114]) by smtp.gmail.com with ESMTPSA id
 ox27-20020a170907101b00b00a3221b95ce8sm699168ejb.77.2024.01.26.06.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:42:25 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH v1 2/3] virtio-gpu.c: add resource_destroy class method
Date: Fri, 26 Jan 2024 16:41:49 +0200
Message-Id: <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
need to do their own bookkeeping (free rutabaga resources that are
associated with the virtio_gpu_simple_resource).

This commit adds a class method so that virtio-gpu-rutabaga can override
it in the next commit.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu.c        | 19 ++++++++++++++++---
 include/hw/virtio/virtio-gpu.h |  2 ++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2b73ae585b..96420ba74f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -401,8 +401,9 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
     scanout->height = 0;
 }
 
-static void virtio_gpu_resource_destroy(VirtIOGPU *g,
-                                        struct virtio_gpu_simple_resource *res)
+static int32_t
+virtio_gpu_resource_destroy(VirtIOGPU *g,
+                            struct virtio_gpu_simple_resource *res)
 {
     int i;
 
@@ -419,6 +420,8 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
     QTAILQ_REMOVE(&g->reslist, res, next);
     g->hostmem -= res->hostmem;
     g_free(res);
+
+    return 0;
 }
 
 static void virtio_gpu_resource_unref(VirtIOGPU *g,
@@ -1488,11 +1491,20 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 static void virtio_gpu_reset_bh(void *opaque)
 {
     VirtIOGPU *g = VIRTIO_GPU(opaque);
+    VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
     struct virtio_gpu_simple_resource *res, *tmp;
+    int32_t result, resource_id;
     int i = 0;
 
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
-        virtio_gpu_resource_destroy(g, res);
+        resource_id = res->resource_id;
+        result = vgc->resource_destroy(g, res);
+        if (result) {
+            error_report("%s: %s resource_destroy"
+                         "for resource_id = %d failed with return value = %d;",
+                         __func__, object_get_typename(OBJECT(g)), resource_id,
+                         result);
+        }
     }
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
@@ -1632,6 +1644,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vgc->handle_ctrl = virtio_gpu_handle_ctrl;
     vgc->process_cmd = virtio_gpu_simple_process_cmd;
     vgc->update_cursor_data = virtio_gpu_update_cursor_data;
+    vgc->resource_destroy = virtio_gpu_resource_destroy;
     vgbc->gl_flushed = virtio_gpu_handle_gl_flushed;
 
     vdc->realize = virtio_gpu_device_realize;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 584ba2ed73..5683354236 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -219,6 +219,8 @@ struct VirtIOGPUClass {
     void (*update_cursor_data)(VirtIOGPU *g,
                                struct virtio_gpu_scanout *s,
                                uint32_t resource_id);
+    int32_t (*resource_destroy)(VirtIOGPU *g,
+                                struct virtio_gpu_simple_resource *res);
 };
 
 struct VirtIOGPUGL {
-- 
γαῖα πυρί μιχθήτω


