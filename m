Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD6CC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFKV-0003uk-6U; Thu, 21 Mar 2024 06:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFK9-0003Zz-72
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:07:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFK5-0007yd-Sp
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:06:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41400a9844aso10844625e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711015616; x=1711620416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVKhUMPA/lZLPyzQ0H0k/UNNx6M+om6jLRUQuH/VY+g=;
 b=oF9fLxO+wmr+wCl0d3z5osoaDNze0drUty8gUfV4kEVzQkWKcixblmcQFXHsxa6Vr1
 fp8jZoZaWlGjMNO8k6Kq/MMPfP23odDGUJ0d4357hzbamH5MivSFncOXFc61ZTkMP4/S
 mZahXo2U4DAm9O87oNETPbclYHcN8hFIx5q50Qk9IZs0bEFa674xoXSUJ2jB7rTjSxRU
 NDjzME35x9bgLabcAfnD8msWuEycmVVH6J3qWsW4EoTaLcU0vjPx7Ju8xpdEMtx5DJoL
 4ePqNFYjEQItC5ueSjxH4HAwSJoDUdrq90C7/lmYZ4CKTSCYtrTaFVRbdQLAmP9G+Y1n
 9CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015616; x=1711620416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVKhUMPA/lZLPyzQ0H0k/UNNx6M+om6jLRUQuH/VY+g=;
 b=wSTpBeMJ1R6yChY8cBB4VzVQJITL+TSFYsE7lpUWmzHL+b6D6x20t2FswOj1EpGuEq
 FGUTakSGwAnjQY2UmKTPQL7Ylj3pv2SQhEWBJZmue0/g10aplJRu7H4xr5PZMM3faeyE
 oF7BUUhRA58N6aoDfsdK4fAlDoBSnTCFs7mSs9JfpJGmJ8xbhIVeGe2uTYKNhDOX1Vqm
 FqLo+vkIKJiuFzwGt+RJBMJ1zI25v1Tvf5vPeU7qfrTQa+wxqgAuTYCf7Ax5xPfpszpa
 QWxLkiUUU+tSa19V7F9SDTcnGql2YEjwc0PB1+sX9EmNjoOTA/8RWHxLKeYHEejeDzvV
 XB+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO7y+G0qKDS0RPtSh0+3wh8FEUMTstkIVnp4fBTc7pGf2TLaZuq4ZrHHPlRanY4HlY8IRiiA0JoOXChBgygRManrVoOek=
X-Gm-Message-State: AOJu0YzthxIuXTIrtyZ7xmNqz4c1hB2MFrUqZ3awXvaOgEYxdLyYsQoD
 0KXfWI1GJo60VVsLco0UY9g75QLEyvqp7gaLaM4OAS3XDojMizf7g/hcZu4AhOk=
X-Google-Smtp-Source: AGHT+IEGs4xSfHIU0zUN114wSHRiIPPZEQkQmG0AGnQ80dmtNX8lCUcBc8U/XLzv3uWkQbAVAohRLg==
X-Received: by 2002:a05:600c:1d96:b0:414:37f:18dc with SMTP id
 p22-20020a05600c1d9600b00414037f18dcmr2006908wms.1.1711015615622; 
 Thu, 21 Mar 2024 03:06:55 -0700 (PDT)
Received: from localhost.localdomain (10.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.10]) by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c468500b004132ae838absm5096553wmo.43.2024.03.21.03.06.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 03:06:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Dongwon Kim <dongwon.kim@intel.com>,
	qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/3] ui/console: Introduce dpy_gl_dmabuf_get_fd() helper
Date: Thu, 21 Mar 2024 11:06:34 +0100
Message-ID: <20240321100635.64950-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321100635.64950-1-philmd@linaro.org>
References: <20240321100635.64950-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
[PMD: Split patch in 3, part 2/3]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/console.h | 1 +
 hw/vfio/display.c    | 8 +++++++-
 ui/console.c         | 9 +++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a7f6cef26d..1f3d025548 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -360,6 +360,7 @@ void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
 uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
 uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index c962e5f88f..676b2fc5f3 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -259,9 +259,15 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
 static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 {
+    int fd;
+
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
+    fd = dpy_gl_dmabuf_get_fd(&dmabuf->buf);
+    if (fd > -1) {
+        close(fd);
+    }
+
     dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
-    close(dmabuf->buf.fd);
     g_free(dmabuf);
 }
 
diff --git a/ui/console.c b/ui/console.c
index edabad64c0..10abeb9780 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1208,6 +1208,15 @@ uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf)
     return 0;
 }
 
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->fd;
+    }
+
+    return -1;
+}
+
 void dpy_gl_release_dmabuf(QemuConsole *con,
                           QemuDmaBuf *dmabuf)
 {
-- 
2.41.0


