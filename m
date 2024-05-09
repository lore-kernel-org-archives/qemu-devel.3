Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6AEC25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s578q-0002Gu-8z; Thu, 09 May 2024 13:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578o-0002GF-8i
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578m-0003Xk-6V
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfht/8nDL9dNmoJdt0AfWcd+ja7bm3XnHVnoXh9KG24=;
 b=R2KldbKm3mfdHlncOiYoR/5Npcg1oxKS585huPlNi1yUeyjIe6Bg64mSjQ0sNjwW8M/BX9
 6gvRsvP+pUIAU3A8lmdHuTVI6Li0xaEL5SrgQVE2jbFcde4zoYI2k05oQv7aSL+nIIVom0
 RRTJ7hKetdIrdImn+xrayNcdrcTItY0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Q25JQfYrOnmY29JYexrn2g-1; Thu, 09 May 2024 13:01:04 -0400
X-MC-Unique: Q25JQfYrOnmY29JYexrn2g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51ffd1181e4so1148849e87.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274062; x=1715878862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfht/8nDL9dNmoJdt0AfWcd+ja7bm3XnHVnoXh9KG24=;
 b=Mxey30h84Cgk/9Tw6idPDTM16XXkwja6xP+kjFzYTf+QvqtxaCWIaEgSczMzRqWn6r
 a4hz5UtixrSu2dpBk5Z1YyD8jYbBjOFHk2g/h0y/q1V3BRwugIxeWOLNjGtKcHSkQjyA
 QK58/cCDjkddDFWZVXrsk3pvaP/iT1v06bnXK1in9wSHWPq+PyxDEAhmQ7ONhwfU0zdu
 BfeHJ6hy5je/3rVeZJvWjSoZOcVOPDVA5JzViqxjHoUnsceLOQjc3/44mWpS2/Y8SeqB
 oLCTjeLpjr32i7hvjCnGo5olzlnKnJue85KVFWTc/2O9S58duIm3fBCVjJdjZju51jfc
 iwnw==
X-Gm-Message-State: AOJu0Yw34NDSciBopBLfkQ+bdOrsr1m5BBUWgCskf9vvQNjsfS8oUubc
 AVAxx5m8hP6rOOidbQ+tExONwpdA3BAUr0oGZ6qRBjsiQi4S9kPrrdXXaUQ8OTedFUryuf96Xwf
 Zk+BhFajNMH7dXNYLV0L5DWY3p5nn/F0cuIJxwwPiMaegmefiWo64S8j8Auex+avxu80OVWJV9r
 uGecIcjWZ7hKe0LD3VUwHqq91v39/4BXApmMeu
X-Received: by 2002:a05:6512:3f20:b0:51d:4383:9e59 with SMTP id
 2adb3069b0e04-5220f86c902mr140668e87.0.1715274061674; 
 Thu, 09 May 2024 10:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnvI2p0M3PxeHQAPpxwPMeRQ4GavaRnF8Fj08jaaeJbRuWyShBlEDzg7q+Zg4Bv+N9hTTTLg==
X-Received: by 2002:a05:6512:3f20:b0:51d:4383:9e59 with SMTP id
 2adb3069b0e04-5220f86c902mr140603e87.0.1715274060298; 
 Thu, 09 May 2024 10:01:00 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a178a9d9csm91480766b.74.2024.05.09.10.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:00:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 07/13] xen: register legacy backends via xen_backend_init
Date: Thu,  9 May 2024 19:00:38 +0200
Message-ID: <20240509170044.190795-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is okay to register legacy backends in the middle of xen_bus_init().
All that the registration does is record the existence of the backend
in xenstore.

This makes it possible to remove them from the build without introducing
undefined symbols in xen_be_init().  It also removes the need for the
backend_register callback, whose only purpose is to avoid registering
nonfunctional backends.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/xen/xen-legacy-backend.h | 14 ++------------
 include/hw/xen/xen_pvdev.h          |  1 -
 hw/9pfs/xen-9p-backend.c            |  8 +++++++-
 hw/display/xenfb.c                  |  8 +++++++-
 hw/usb/xen-usb.c                    | 14 ++++----------
 hw/xen/xen-legacy-backend.c         | 16 ----------------
 6 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 2cca1747786..979c4ea04c5 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -66,18 +66,8 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
     return xen_be_unmap_grant_refs(xendev, ptr, &ref, 1);
 }
 
-/* actual backend drivers */
-extern struct XenDevOps xen_console_ops;      /* xen_console.c     */
-extern struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
-extern struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
-extern struct XenDevOps xen_blkdev_ops;       /* xen_disk.c        */
-#ifdef CONFIG_VIRTFS
-extern struct XenDevOps xen_9pfs_ops;       /* xen-9p-backend.c        */
-#endif
-extern struct XenDevOps xen_netdev_ops;       /* xen_nic.c         */
-#ifdef CONFIG_USB_LIBUSB
-extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
-#endif
+/* backend drivers not included in all machines */
+extern struct XenDevOps xen_framebuffer_ops;  /* xenfb.c */
 
 /* configuration (aka xenbus setup) */
 void xen_config_cleanup(void);
diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index ddad4b9f36a..fdf84f47af1 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -29,7 +29,6 @@ struct XenDevOps {
                                  const char *node);
     void      (*frontend_changed)(struct XenLegacyDevice *xendev,
                                   const char *node);
-    int       (*backend_register)(void);
 };
 
 struct XenLegacyDevice {
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 4aa9c8c736d..a3ac53f989e 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -513,7 +513,7 @@ static void xen_9pfs_alloc(struct XenLegacyDevice *xendev)
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
 }
 
-struct XenDevOps xen_9pfs_ops = {
+static struct XenDevOps xen_9pfs_ops = {
     .size       = sizeof(Xen9pfsDev),
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .alloc      = xen_9pfs_alloc,
@@ -522,3 +522,9 @@ struct XenDevOps xen_9pfs_ops = {
     .disconnect = xen_9pfs_disconnect,
     .free       = xen_9pfs_free,
 };
+
+static void xen_9pfs_register_backend(void)
+{
+    xen_be_register("9pfs", &xen_9pfs_ops);
+}
+xen_backend_init(xen_9pfs_register_backend);
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index b2130a0d700..27536bfce0c 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -972,7 +972,7 @@ static void fb_event(struct XenLegacyDevice *xendev)
 
 /* -------------------------------------------------------------------- */
 
-struct XenDevOps xen_kbdmouse_ops = {
+static struct XenDevOps xen_kbdmouse_ops = {
     .size       = sizeof(struct XenInput),
     .init       = input_init,
     .initialise = input_initialise,
@@ -995,3 +995,9 @@ static const GraphicHwOps xenfb_ops = {
     .gfx_update  = xenfb_update,
     .ui_info     = xenfb_ui_info,
 };
+
+static void xen_vkbd_register_backend(void)
+{
+    xen_be_register("vkbd", &xen_kbdmouse_ops);
+}
+xen_backend_init(xen_vkbd_register_backend);
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 09ec326aeae..416623f956a 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -1083,7 +1083,7 @@ static void usbback_event(struct XenLegacyDevice *xendev)
     qemu_bh_schedule(usbif->bh);
 }
 
-struct XenDevOps xen_usb_ops = {
+static struct XenDevOps xen_usb_ops = {
     .size            = sizeof(struct usbback_info),
     .flags           = DEVOPS_FLAG_NEED_GNTDEV,
     .init            = usbback_init,
@@ -1095,15 +1095,9 @@ struct XenDevOps xen_usb_ops = {
     .event           = usbback_event,
 };
 
-#else /* USBIF_SHORT_NOT_OK */
-
-static int usbback_not_supported(void)
+static void xen_usb_register_backend(void)
 {
-    return -EINVAL;
+    xen_be_register("qusb", &xen_usb_ops);
 }
-
-struct XenDevOps xen_usb_ops = {
-    .backend_register = usbback_not_supported,
-};
-
+xen_backend_init(xen_usb_register_backend);
 #endif
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 124dd5f3d68..6f0b300a421 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -622,27 +622,11 @@ void xen_be_init(void)
     qbus_set_bus_hotplug_handler(xen_sysbus);
 
     xen_set_dynamic_sysbus();
-
-    xen_be_register("vkbd", &xen_kbdmouse_ops);
-#ifdef CONFIG_VIRTFS
-    xen_be_register("9pfs", &xen_9pfs_ops);
-#endif
-#ifdef CONFIG_USB_LIBUSB
-    xen_be_register("qusb", &xen_usb_ops);
-#endif
 }
 
 int xen_be_register(const char *type, struct XenDevOps *ops)
 {
     char path[50];
-    int rc;
-
-    if (ops->backend_register) {
-        rc = ops->backend_register();
-        if (rc) {
-            return rc;
-        }
-    }
 
     snprintf(path, sizeof(path), "device-model/%u/backends/%s", xen_domid,
              type);
-- 
2.45.0


