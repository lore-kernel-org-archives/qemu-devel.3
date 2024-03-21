Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D83BC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFKd-0004Cb-HS; Thu, 21 Mar 2024 06:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFKJ-0003nQ-Cc
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:07:18 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFKE-0007zw-JF
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:07:11 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-513d717269fso1032225e87.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711015625; x=1711620425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ci2YLuSom554B/WFZVtS1fvhUUyUk3BWXa9IhWJxeEg=;
 b=VMu+61GK/kHjBEC9DokCjFS0RfnQan8toqa3QgkffWdhkvmBdS98+JBVVoLbWJMDOg
 yHNNjS15T2bicy7Tcg1wpL6YiPVbe7auRd28ZqK4W4mnu7JMQNsxufPW/aNcRcvPDwPF
 iOBHHs2QOqGiVMjHBpuH/0N0qXmWVExFxOy9z8qjswRCgVK+isZi+gxCYFs8PMrXJr4w
 gbj2ASGF8u9C7Kv0cGhcCCZRsFN8EgsrnXLZCTpV12RYnUqJWGgSLXjaRBFZYN2Z6nTV
 1kCb10CqtS0Ea3DfA4U7d68GbYvFDqndqxSJ/AHr3fPxk9CDPIuvV2Fy4YD9V0x7LZzD
 haFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015625; x=1711620425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ci2YLuSom554B/WFZVtS1fvhUUyUk3BWXa9IhWJxeEg=;
 b=qmJcRVuAQhmIo8+Jy6YUur4sqwvochMJQt5MHPi7hAf5Xre7jn1RUoVvbiDj/5B+47
 I6KSE3OuiCO7x1NDB4E5y/OmHY3yv3rbl0/DZDzydNqZb4fHr2VNfYQVso3sU5Yn83Nr
 llBk3YZaRLDlvzsHZnXA6Ovgdc18jNO/ga2O5oyF8dTwu8pl1YBfamYo40FGKIbhdccD
 CA1QfMNiWGMmUcrZ53uaSO/bhAa1E3UnMujyD5g+tdo9OZFrsswT4ULP5cwQyijPYhTG
 s4APhZKIuzucnnourDfTP6VDsonadh/w/NFPE2yBocimc2FOh1sK5ELRc0/YKOy5+Gj9
 Q8uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Xr1bYCDKHeD15VnMiXPPcJdlH3ajmOCl2vcipOserN0GnErraarm9WTtxpnjzstGBfCc1Z3HQjCMPnWvFeNQFvDpEn8=
X-Gm-Message-State: AOJu0YxxutV5kqfJ06o4UmQp5vSqOT+Ak5lFMA7tIPLOubyn0EsOijoE
 ExDZ9UIh4wuySq1KH6mnzZtW5uSZwLoLii5n5MiKpHToQx6G3uiRAA5rF9tI1MB2HRvOo1x085N
 mUrU=
X-Google-Smtp-Source: AGHT+IHn3m6uyg6+bPj72cqe0G587CviyfiaXH5xNeLEJ5wGgp+MAFFhUgOAlKJuVv/xSoX258UsQA==
X-Received: by 2002:a05:6512:54e:b0:513:c963:895e with SMTP id
 h14-20020a056512054e00b00513c963895emr3315656lfl.42.1711015622945; 
 Thu, 21 Mar 2024 03:07:02 -0700 (PDT)
Received: from localhost.localdomain (10.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.10]) by smtp.gmail.com with ESMTPSA id
 p42-20020a05600c1daa00b004146f93a9d1sm2984002wms.25.2024.03.21.03.07.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 03:07:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Dongwon Kim <dongwon.kim@intel.com>,
	qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [INCOMPLETE PATCH v3 3/3] ui/console: Introduce
 dpy_gl_create_dmabuf() helper
Date: Thu, 21 Mar 2024 11:06:35 +0100
Message-ID: <20240321100635.64950-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321100635.64950-1-philmd@linaro.org>
References: <20240321100635.64950-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

From: Dongwon Kim <dongwon.kim@intel.com>

It is safer to create, initialize, and access all the parameters
in QemuDmaBuf from a central location, ui/console, instead of
hw/virtio-gpu or hw/vfio modules.

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20240320034229.3347130-1-dongwon.kim@intel.com>
[PMD: Split patch in 3, part 3/3]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Incomplete... VhostUserGPU doesn't allocate,
vhost_user_gpu_handle_display() crashes.
---
 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  2 +-
 include/ui/console.h            |  7 +++++++
 hw/display/virtio-gpu-udmabuf.c | 23 ++++++++---------------
 hw/vfio/display.c               | 24 ++++++++++--------------
 ui/console.c                    | 28 ++++++++++++++++++++++++++++
 6 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..d66e27db02 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -148,7 +148,7 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 typedef struct VFIODMABuf {
-    QemuDmaBuf buf;
+    QemuDmaBuf *buf;
     uint32_t pos_x, pos_y, pos_updates;
     uint32_t hot_x, hot_y, hot_updates;
     int dmabuf_id;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ed44cdad6b..010083e8e3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -169,7 +169,7 @@ struct VirtIOGPUBaseClass {
     DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
 
 typedef struct VGPUDMABuf {
-    QemuDmaBuf buf;
+    QemuDmaBuf *buf;
     uint32_t scanout_id;
     QTAILQ_ENTRY(VGPUDMABuf) next;
 } VGPUDMABuf;
diff --git a/include/ui/console.h b/include/ui/console.h
index 1f3d025548..0b823efb2e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -279,6 +279,7 @@ typedef struct DisplayChangeListenerOps {
     /* optional */
     void (*dpy_gl_cursor_position)(DisplayChangeListener *dcl,
                                    uint32_t pos_x, uint32_t pos_y);
+
     /* optional */
     void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
                                   QemuDmaBuf *dmabuf);
@@ -358,6 +359,12 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
                           bool have_hot, uint32_t hot_x, uint32_t hot_y);
 void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint32_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences);
 uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
 uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
 int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d680e871c1..dde6c8e9d9 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -162,7 +162,7 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
     struct virtio_gpu_scanout *scanout;
 
     scanout = &g->parent_obj.scanout[dmabuf->scanout_id];
-    dpy_gl_release_dmabuf(scanout->con, &dmabuf->buf);
+    dpy_gl_release_dmabuf(scanout->con, dmabuf->buf);
     QTAILQ_REMOVE(&g->dmabuf.bufs, dmabuf, next);
     g_free(dmabuf);
 }
@@ -181,17 +181,10 @@ static VGPUDMABuf
     }
 
     dmabuf = g_new0(VGPUDMABuf, 1);
-    dmabuf->buf.width = r->width;
-    dmabuf->buf.height = r->height;
-    dmabuf->buf.stride = fb->stride;
-    dmabuf->buf.x = r->x;
-    dmabuf->buf.y = r->y;
-    dmabuf->buf.backing_width = fb->width;
-    dmabuf->buf.backing_height = fb->height;
-    dmabuf->buf.fourcc = qemu_pixman_to_drm_format(fb->format);
-    dmabuf->buf.fd = res->dmabuf_fd;
-    dmabuf->buf.allow_fences = true;
-    dmabuf->buf.draw_submitted = false;
+    dmabuf->buf = dpy_gl_create_dmabuf(r->width, r->height, fb->stride,
+                                       r->x, r->y, fb->width, fb->height,
+                                       qemu_pixman_to_drm_format(fb->format),
+                                       0, res->dmabuf_fd, false);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
@@ -213,8 +206,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
         return -EINVAL;
     }
 
-    width = dpy_gl_dmabuf_get_width(&new_primary->buf);
-    height = dpy_gl_dmabuf_get_height(&new_primary->buf);
+    width = dpy_gl_dmabuf_get_width(new_primary->buf);
+    height = dpy_gl_dmabuf_get_height(new_primary->buf);
 
     if (g->dmabuf.primary[scanout_id]) {
         old_primary = g->dmabuf.primary[scanout_id];
@@ -222,7 +215,7 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 
     g->dmabuf.primary[scanout_id] = new_primary;
     qemu_console_resize(scanout->con, width, height);
-    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
+    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
 
     if (old_primary) {
         virtio_gpu_free_dmabuf(g, old_primary);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 676b2fc5f3..a3bdb01789 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -241,14 +241,10 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
     dmabuf = g_new0(VFIODMABuf, 1);
     dmabuf->dmabuf_id  = plane.dmabuf_id;
-    dmabuf->buf.width  = plane.width;
-    dmabuf->buf.height = plane.height;
-    dmabuf->buf.backing_width = plane.width;
-    dmabuf->buf.backing_height = plane.height;
-    dmabuf->buf.stride = plane.stride;
-    dmabuf->buf.fourcc = plane.drm_format;
-    dmabuf->buf.modifier = plane.drm_format_mod;
-    dmabuf->buf.fd     = fd;
+    dmabuf->buf = dpy_gl_create_dmabuf(plane.width, plane.height, plane.stride,
+                                       0, 0, plane.width, plane.height,
+                                       plane.drm_format, plane.drm_format_mod,
+                                       fd, false);
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
     }
@@ -262,12 +258,12 @@ static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
     int fd;
 
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
-    fd = dpy_gl_dmabuf_get_fd(&dmabuf->buf);
+    fd = dpy_gl_dmabuf_get_fd(dmabuf->buf);
     if (fd > -1) {
         close(fd);
     }
 
-    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
+    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
     g_free(dmabuf);
 }
 
@@ -303,13 +299,13 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
-    width = dpy_gl_dmabuf_get_width(&primary->buf);
-    height = dpy_gl_dmabuf_get_height(&primary->buf);
+    width = dpy_gl_dmabuf_get_width(primary->buf);
+    height = dpy_gl_dmabuf_get_height(primary->buf);
 
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
         qemu_console_resize(dpy->con, width, height);
-        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
+        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
         free_bufs = true;
     }
 
@@ -323,7 +319,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     if (cursor && (new_cursor || cursor->hot_updates)) {
         bool have_hot = (cursor->hot_x != 0xffffffff &&
                          cursor->hot_y != 0xffffffff);
-        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
                              cursor->hot_x, cursor->hot_y);
         cursor->hot_updates = 0;
     } else if (!cursor && new_cursor) {
diff --git a/ui/console.c b/ui/console.c
index 10abeb9780..616d636912 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1190,6 +1190,33 @@ void dpy_gl_cursor_position(QemuConsole *con,
     }
 }
 
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint32_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences)
+{
+    QemuDmaBuf *dmabuf;
+
+    dmabuf = g_new0(QemuDmaBuf, 1);
+
+    dmabuf->width = width;
+    dmabuf->height = height;
+    dmabuf->stride = stride;
+    dmabuf->x = x;
+    dmabuf->y = y;
+    dmabuf->backing_width = backing_width;
+    dmabuf->backing_height = backing_height;
+    dmabuf->fourcc = fourcc;
+    dmabuf->modifier = modifier;
+    dmabuf->fd = dmabuf_fd;
+    dmabuf->allow_fences = allow_fences;
+    dmabuf->fence_fd = -1;
+
+    return dmabuf;
+}
+
 uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
 {
     if (dmabuf) {
@@ -1230,6 +1257,7 @@ void dpy_gl_release_dmabuf(QemuConsole *con,
         if (dcl->ops->dpy_gl_release_dmabuf) {
             dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
         }
+        g_free(dmabuf);
     }
 }
 
-- 
2.41.0


