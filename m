Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCA2C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NpN-0002Es-CW; Fri, 10 May 2024 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Np5-0001y8-Jp
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:58 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Np1-0001Xn-Rf
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:55 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e538a264f7so7492651fa.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338188; x=1715942988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59LwZUfkdqE1X1uqHmA8fJxVEaLTRUaAXUjy1rLp7lY=;
 b=IfXz45XKO6AJC67MVD9EQ6RAv8BanVx/Gv4NWnwQFTkgiBg08dAuZev7H9ny5YiVCK
 7URbEMFhUlOb6eWfNSnOvB+22dHIauDPDTJxiwpSltdOvo3+ElLyDpjBKJF9G4DBIHRJ
 iO1A/rMlZ7Peqg/HV3Dp8RN0tLNZrJTiBH6ebBSWFcVnuFeCNg2PdL9e2Uwiq3auYPQg
 38tyLNDjV45uSrZqM8dt6TUQzyofkv9zyJOBzyO+AEYx+6VKmW7ucndbVZ9HWLIjGtGa
 0NAOyojYyb9AUOa3k3F27K43dm9B4IDJtt02PYKY8OS+A4CoSdbCLmSPNFNNz1cn7lNP
 IHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338188; x=1715942988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59LwZUfkdqE1X1uqHmA8fJxVEaLTRUaAXUjy1rLp7lY=;
 b=X6fiAPLU0TlPS3r+ff3Y8O1ozBwJUyYX9KW1H7+6semO4hu0hA6wiWU4haCMMiS88s
 ExjdsI2xXcvyZOFQWUCP1uWx8ETKPZrt1TDSImlsa1t8K8Cqv4NM+dQGp6tVHEfPUoxB
 0Wbo4VCpIEA/tic9EZdO4ZEh2R6IYemm4+FRuWlS1fF0sfdAfJOes6k0n/v0dyrIksFM
 x1ixuk+5f6ofywjUP9q98C0D8mSou2UMFJrXUJhjM6i8TchjK6XU97HaTJfVj/vulO5h
 hCX+ENSvjUClSvC71wuTZ36Zcw/YOw8U/rogib80lWaItUx29Pfye0bSR8maIvYW4hyg
 ALNA==
X-Gm-Message-State: AOJu0YyqSj7SZyMlmC+pNaBJLSg+w46SFpN2T0VYVgM8IB68jcwDNPyO
 VbSZ38/z83mEIcOO2rAySbG0hKiakKDCSklGp/dDNY9eByu4OECdV5hpl6Fm7y41VMupYz+p5Mq
 u
X-Google-Smtp-Source: AGHT+IHXwM/S059R6UkOB6MRtl349Xb619zHzrqPuRu/IZXAzDzUInG0zBbE08W5hL9UPuwtPHGoJA==
X-Received: by 2002:a2e:9e14:0:b0:2e1:c97b:6f1f with SMTP id
 38308e7fff4ca-2e5203a795emr13764691fa.51.1715338188613; 
 Fri, 10 May 2024 03:49:48 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce2449sm60037515e9.16.2024.05.10.03.49.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] hw/xen: register legacy backends via xen_backend_init
Date: Fri, 10 May 2024 12:49:07 +0200
Message-ID: <20240510104908.76908-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
References: <20240510104908.76908-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

It is okay to register legacy backends in the middle of xen_bus_init().
All that the registration does is record the existence of the backend
in xenstore.

This makes it possible to remove them from the build without introducing
undefined symbols in xen_be_init().  It also removes the need for the
backend_register callback, whose only purpose is to avoid registering
nonfunctional backends.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240509170044.190795-8-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 11 ++---------
 include/hw/xen/xen_pvdev.h          |  1 -
 hw/9pfs/xen-9p-backend.c            |  8 +++++++-
 hw/display/xenfb.c                  |  8 +++++++-
 hw/usb/xen-usb.c                    | 14 ++++----------
 hw/xen/xen-legacy-backend.c         | 16 ----------------
 6 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index cfa43a984a..e55a14057f 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -66,15 +66,8 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
     return xen_be_unmap_grant_refs(xendev, ptr, &ref, 1);
 }
 
-/* actual backend drivers */
-extern const struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
-extern const struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
-#ifdef CONFIG_VIRTFS
-extern const struct XenDevOps xen_9pfs_ops;         /* xen-9p-backend.c  */
-#endif
-#ifdef CONFIG_USB_LIBUSB
-extern const struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
-#endif
+/* backend drivers not included in all machines */
+extern const struct XenDevOps xen_framebuffer_ops;  /* xenfb.c */
 
 /* configuration (aka xenbus setup) */
 void xen_config_cleanup(void);
diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index fd9a33e6ab..0c98444047 100644
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
index b1780eb819..79359d911a 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -513,7 +513,7 @@ static void xen_9pfs_alloc(struct XenLegacyDevice *xendev)
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
 }
 
-const struct XenDevOps xen_9pfs_ops = {
+static const struct XenDevOps xen_9pfs_ops = {
     .size       = sizeof(Xen9pfsDev),
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .alloc      = xen_9pfs_alloc,
@@ -522,3 +522,9 @@ const struct XenDevOps xen_9pfs_ops = {
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
index dd83d0f5a5..b6d370bdf6 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -972,7 +972,7 @@ static void fb_event(struct XenLegacyDevice *xendev)
 
 /* -------------------------------------------------------------------- */
 
-const struct XenDevOps xen_kbdmouse_ops = {
+static const struct XenDevOps xen_kbdmouse_ops = {
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
index 95a901e81f..13901625c0 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -1083,7 +1083,7 @@ static void usbback_event(struct XenLegacyDevice *xendev)
     qemu_bh_schedule(usbif->bh);
 }
 
-const struct XenDevOps xen_usb_ops = {
+static const struct XenDevOps xen_usb_ops = {
     .size            = sizeof(struct usbback_info),
     .flags           = DEVOPS_FLAG_NEED_GNTDEV,
     .init            = usbback_init,
@@ -1095,15 +1095,9 @@ const struct XenDevOps xen_usb_ops = {
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
-const struct XenDevOps xen_usb_ops = {
-    .backend_register = usbback_not_supported,
-};
-
+xen_backend_init(xen_usb_register_backend);
 #endif
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 4dc3a561cf..5514184f9c 100644
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
 
 int xen_be_register(const char *type, const struct XenDevOps *ops)
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
2.41.0


