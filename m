Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1637AC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFK1-0002kY-VO; Thu, 21 Mar 2024 06:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFJz-0002WM-Ts
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:06:51 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFJy-0007yO-7T
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:06:51 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d220e39907so11242871fa.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711015608; x=1711620408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2dvM+euMDE0v28D1xjaFlsbAEAYgdfmVYQj+HIsXyM=;
 b=wD7fkTGSyL1WMoaiQ78jb40GiGEEoBFYzNxfpRvELPg0smw4W1/V9H+e3+7XB5QH1w
 ceQIkhu7WNwcAPLCZZhySqm3e0X6WKa4PEO7BDdtETvean+lRnJVdVngE2qC6dWlrWPc
 FqdW4QIYAy84s0hzKLMybu3jP4cnPROyHrvG646RmF7+ic0TYAgNhbwEQ7BQsxT8aHml
 s9kbiwtj/tlvArmUJYIEXCqe8HUokVpjqejr8X+UQnCfdRAs95eRmTnZ0qFXjbW8p24m
 +wvumGd9i5d0mJOaGlWUvpsmPJ0N2qt+bv/haB5hiWuPzNXXuqKeLQQ8vX+AgbyNI1QE
 ucgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015608; x=1711620408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2dvM+euMDE0v28D1xjaFlsbAEAYgdfmVYQj+HIsXyM=;
 b=hp7K82qbPZkfxmfWKw5g9Z97b8K96d8lePjyZUJx87KCYz3znlWWWTTZCxCKh4Eaic
 pOcnBNA/Kf0sBGjq6DF/zhHm5YP7YAJ8oIjG/46zYwqxVCAxa2keE4EqBKc0kl3o6wWG
 cHP/q9iFrRiiL+P5J8cmXbHA6YNaTIxhE+zXEZw2gghhtAx5MesepQOZg+O4Uh5RqUuX
 zvRtHDx/10zv3grUgL1VttFzVa7cNVej4uuRDe5na8qZWKoYCkGQzP60bFKlCwhJQ4JU
 fauQrvqXPWCPgt/WFPDX0yBNYdHr6fG+Lddr7ysIc+bjMHztFoitCw0lHw3eeirqJCOc
 WS3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX03Ay6twpGkhB08gPmUK5mzMjE173ck98SVTj8LogAgl1aY83nUplguruMr5KIvCxr69/tXMK2ovB5XO+dzEwHKBHdC8Q=
X-Gm-Message-State: AOJu0YyEPh8BlZbxpxX0l05UPTejr6v+eBE2Vk7FvfKfheEFCV5H3ESL
 PfVplvGhVS7q3/zaoiOPbpbvQ8u2QRwqPKefe+xrIVYMmNCH55CH85kVs+Qry/s=
X-Google-Smtp-Source: AGHT+IGU5M1dD5nFfomSZl4U1vrATCQc2rUAJvLBbC8xtzWFzBKAmm1kRYUV8yV1Rs5WnihURTdX/A==
X-Received: by 2002:a2e:8187:0:b0:2d4:5d56:e559 with SMTP id
 e7-20020a2e8187000000b002d45d56e559mr14298577ljg.47.1711015608437; 
 Thu, 21 Mar 2024 03:06:48 -0700 (PDT)
Received: from localhost.localdomain (10.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.10]) by smtp.gmail.com with ESMTPSA id
 g14-20020a5d540e000000b0033e95bf4796sm16765659wrv.27.2024.03.21.03.06.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 03:06:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Dongwon Kim <dongwon.kim@intel.com>,
	qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] ui/console: Introduce dpy_gl_dmabuf_get_height/width()
 helpers
Date: Thu, 21 Mar 2024 11:06:33 +0100
Message-ID: <20240321100635.64950-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321100635.64950-1-philmd@linaro.org>
References: <20240321100635.64950-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20240320034229.3347130-1-dongwon.kim@intel.com>
[PMD: Split patch in 3, part 1/3]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/console.h            |  2 ++
 hw/display/virtio-gpu-udmabuf.c |  8 +++++---
 hw/vfio/display.c               |  9 ++++++---
 ui/console.c                    | 18 ++++++++++++++++++
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc64..a7f6cef26d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -358,6 +358,8 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
                           bool have_hot, uint32_t hot_x, uint32_t hot_y);
 void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d51184d658..d680e871c1 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -206,20 +206,22 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     VGPUDMABuf *new_primary, *old_primary = NULL;
+    uint32_t width, height;
 
     new_primary = virtio_gpu_create_dmabuf(g, scanout_id, res, fb, r);
     if (!new_primary) {
         return -EINVAL;
     }
 
+    width = dpy_gl_dmabuf_get_width(&new_primary->buf);
+    height = dpy_gl_dmabuf_get_height(&new_primary->buf);
+
     if (g->dmabuf.primary[scanout_id]) {
         old_primary = g->dmabuf.primary[scanout_id];
     }
 
     g->dmabuf.primary[scanout_id] = new_primary;
-    qemu_console_resize(scanout->con,
-                        new_primary->buf.width,
-                        new_primary->buf.height);
+    qemu_console_resize(scanout->con, width, height);
     dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
 
     if (old_primary) {
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 1aa440c663..c962e5f88f 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -286,6 +286,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     VFIOPCIDevice *vdev = opaque;
     VFIODisplay *dpy = vdev->dpy;
     VFIODMABuf *primary, *cursor;
+    uint32_t width, height;
     bool free_bufs = false, new_cursor = false;
 
     primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
@@ -296,10 +297,12 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
+    width = dpy_gl_dmabuf_get_width(&primary->buf);
+    height = dpy_gl_dmabuf_get_height(&primary->buf);
+
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
-        qemu_console_resize(dpy->con,
-                            primary->buf.width, primary->buf.height);
+        qemu_console_resize(dpy->con, width, height);
         dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
         free_bufs = true;
     }
@@ -328,7 +331,7 @@ static void vfio_display_dmabuf_update(void *opaque)
         cursor->pos_updates = 0;
     }
 
-    dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.height);
+    dpy_gl_update(dpy->con, 0, 0, width, height);
 
     if (free_bufs) {
         vfio_display_free_dmabufs(vdev);
diff --git a/ui/console.c b/ui/console.c
index 832055675c..edabad64c0 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1190,6 +1190,24 @@ void dpy_gl_cursor_position(QemuConsole *con,
     }
 }
 
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->width;
+    }
+
+    return 0;
+}
+
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->height;
+    }
+
+    return 0;
+}
+
 void dpy_gl_release_dmabuf(QemuConsole *con,
                           QemuDmaBuf *dmabuf)
 {
-- 
2.41.0


