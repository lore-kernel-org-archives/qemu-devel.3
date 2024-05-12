Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699C8C25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mw-0003SM-L2; Sun, 12 May 2024 06:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mm-0003KE-Qi
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mk-00065j-R3
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFVtiu0Pbo0KI6IVNWD9rMm4LOpSL4W7AopCivvfmCI=;
 b=eT6zP01cHheAUJTU2+Oy/1MrXQZhyMDorHyGM7Pfb6nbwLpEychA96zeQWd39EZvFjXZ4B
 67vfJSlZLX3CA0DCvTOkS0ybrz4erx+TnK9uDyj7vYwHnGzUW9gSfTJibMIsAO0HCCKCK0
 u+TEYUMa0WwQ9ZPjAALImFywDV7UlKE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-_Mrz3nWMOdWSQG8wXi23iw-1; Sun, 12 May 2024 06:50:28 -0400
X-MC-Unique: _Mrz3nWMOdWSQG8wXi23iw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59d0fb7731so229782966b.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511026; x=1716115826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFVtiu0Pbo0KI6IVNWD9rMm4LOpSL4W7AopCivvfmCI=;
 b=LSMidu2rKvEUhTnHU7hxVK/VUQp+DOOdVMe8ddZkW3YPPTtLyddOZusUmJLATHTza3
 nroLc9fzX3ofvMOnbykb6Y6GvynKBIgGjMvEufTTFBCY/CUdCuMpm4SLGJtYs3QePWsk
 tgd5g2aLzAJjzZHEfeR3wz0uJG3tCoPFIJ2859N7PnNPqbqHmgnopjzkWPXnU14nR2gX
 wF3cTJjmwMilSguhgaCud/MR0wpwHW5o+k1RWIN/k9KnaXJHuaE28Pv0EACIgkHClnBl
 1dA8bBgAvrjCVEDY9y7jpQBTIGTnbhYK92WZuSx3QUmlWL6UmXFswVlS+sgIkBUfVjdz
 klUw==
X-Gm-Message-State: AOJu0YwwKUiuVY8ZkHtRhpf8g+2Rcu098u5aohVEI+gJFedkMlwcHHUG
 7Mrwq+cQGnQqn8zObE6OfMQ120tCQP8hZbUk6ZqS4/s4STZxll3EVM8hytpcY3arxNdeZP79ksY
 tgT56Sm8Mg+5udqs9uxiAzbiXyPolqQ1uM7y/OVaRFb/Xwog3nPsg1aFegTuNJUUgY1MK8iTmjQ
 pdWO0hiyNva6TSc5yXYS2TreBpVErM+mZNqKJs
X-Received: by 2002:a17:906:6805:b0:a59:bfab:b257 with SMTP id
 a640c23a62f3a-a5a2d6761d9mr443949466b.65.1715511026583; 
 Sun, 12 May 2024 03:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpFFrdae7CYG3orm4MZcr6jh+Vb5xFmYN7bwdor08WVQR3cSojwE4Ad3AY01QnEURd4TrfqQ==
X-Received: by 2002:a17:906:6805:b0:a59:bfab:b257 with SMTP id
 a640c23a62f3a-a5a2d6761d9mr443948066b.65.1715511025753; 
 Sun, 12 May 2024 03:50:25 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a41e85063sm242683366b.126.2024.05.12.03.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/27] xen: register legacy backends via xen_backend_init
Date: Sun, 12 May 2024 12:49:33 +0200
Message-ID: <20240512104945.130198-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240509170044.190795-8-pbonzini@redhat.com>
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


