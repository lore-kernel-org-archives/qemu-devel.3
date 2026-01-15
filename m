Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50648D44C56
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOcr-0005aO-5W; Thu, 15 Jan 2026 09:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOc9-0004eL-Pd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:43 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOc5-0002iB-Sn
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bca6:0:640:3d05:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E35DE80800;
 Thu, 15 Jan 2026 17:46:10 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b8d::1:8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8kWwj30BHuQ0-Hlvzkff2; Thu, 15 Jan 2026 17:46:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768488370;
 bh=N/NbFFybcShSqKWzIv8kEy/1ty4UmGGQpowBdDLP7gs=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=kL09BqWixWUVddpfQzyF6fVnL4d86MVRUzMV5T29Cb5oGqhTQiR9BfMoB/oFazFCy
 D51zryetDIYQBO6REA8FVmy/JUcgXS0x3bM3x7oXOnWoeo0hJT08BnGRX19VORhVl2
 bstP/KPJ6c6amhi8I1zbtc1uEWIvLsT0FY5kRw84=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/10] ui/spice: Require spice-server >= 0.15.0
Date: Thu, 15 Jan 2026 17:45:55 +0300
Message-ID: <20260115144606.233252-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115144606.233252-1-vsementsov@yandex-team.ru>
References: <20260115144606.233252-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For major distributions we have now:

    Debian 13: 0.15.2
    Ubuntu 22.04: 0.15.0
    RHEL-9/CentOS Stream 9: SPICE is removed
    Fedora 42: 0.15.1
    OpenSUSE Leap 15.4: 0.15.0

Time to update the dependancy in QEMU and drop almost all
SPICE_SERVER_VERSION checks.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/spice.c         |  6 ------
 hw/display/qxl.c        | 11 ++---------
 include/ui/qemu-spice.h |  4 ----
 meson.build             |  2 +-
 ui/spice-display.c      |  8 ++------
 5 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/chardev/spice.c b/chardev/spice.c
index db53b49da2..39b79d60fb 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -278,12 +278,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     }
 
     *be_opened = false;
-#if SPICE_SERVER_VERSION < 0x000e02
-    /* Spice < 0.14.2 doesn't explicitly open smartcard chardev */
-    if (strcmp(type, "smartcard") == 0) {
-        *be_opened = true;
-    }
-#endif
     chr_open(chr, type);
 }
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index f29b736722..fbba02113f 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -261,11 +261,6 @@ static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
                     QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG,
                     0));
     } else {
-#if SPICE_SERVER_VERSION < 0x000e02 /* release 0.14.2 */
-        if (qxl->max_outputs) {
-            spice_qxl_set_max_monitors(&qxl->ssd.qxl, qxl->max_outputs);
-        }
-#endif
         qxl->guest_monitors_config = qxl->ram->monitors_config;
         spice_qxl_monitors_config_async(&qxl->ssd.qxl,
                 qxl->ram->monitors_config,
@@ -2109,6 +2104,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     uint8_t* config = qxl->pci.config;
     uint32_t pci_device_rev;
     uint32_t io_size;
+    Error *err = NULL;
+    char device_address[256] = "";
 
     qemu_spice_display_init_common(&qxl->ssd);
     qxl->mode = QXL_MODE_UNDEFINED;
@@ -2208,9 +2205,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
         return;
     }
 
-#if SPICE_SERVER_VERSION >= 0x000e02 /* release 0.14.2 */
-    Error *err = NULL;
-    char device_address[256] = "";
     if (qemu_console_fill_device_address(qxl->vga.con,
                                          device_address, sizeof(device_address),
                                          &err)) {
@@ -2221,7 +2215,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     } else {
         error_report_err(err);
     }
-#endif
 
     qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
 
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index b7d493742c..8e5e6b2a74 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -34,11 +34,7 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
 
-#if SPICE_SERVER_VERSION >= 0x000f00 /* release 0.15.0 */
 #define SPICE_HAS_ATTACHED_WORKER 1
-#else
-#define SPICE_HAS_ATTACHED_WORKER 0
-#endif
 
 #else  /* CONFIG_SPICE */
 
diff --git a/meson.build b/meson.build
index c58007291a..0d1cfd38fe 100644
--- a/meson.build
+++ b/meson.build
@@ -1358,7 +1358,7 @@ if get_option('spice') \
              .require(pixman.found(),
                       error_message: 'cannot enable SPICE if pixman is not available') \
              .allowed()
-  spice = dependency('spice-server', version: '>=0.14.0',
+  spice = dependency('spice-server', version: '>=0.15.0',
                      required: get_option('spice'),
                      method: 'pkg-config')
 endif
diff --git a/ui/spice-display.c b/ui/spice-display.c
index db71e866f8..f2304bb0ce 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -689,13 +689,11 @@ static int interface_client_monitors_config(QXLInstance *sin,
     if (mc->num_of_monitors > head) {
         info.width  = mc->monitors[head].width;
         info.height = mc->monitors[head].height;
-#if SPICE_SERVER_VERSION >= 0x000e04 /* release 0.14.4 */
         if (mc->flags & VD_AGENT_CONFIG_MONITORS_FLAG_PHYSICAL_SIZE) {
             VDAgentMonitorMM *mm = (void *)&mc->monitors[mc->num_of_monitors];
             info.width_mm = mm[head].width;
             info.height_mm = mm[head].height;
         }
-#endif
     }
 
     trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
@@ -1393,6 +1391,8 @@ static const DisplayGLCtxOps gl_ctx_ops = {
 static void qemu_spice_display_init_one(QemuConsole *con)
 {
     SimpleSpiceDisplay *ssd = g_new0(SimpleSpiceDisplay, 1);
+    Error *err = NULL;
+    char device_address[256] = "";
 
     qemu_spice_display_init_common(ssd);
 
@@ -1414,9 +1414,6 @@ static void qemu_spice_display_init_one(QemuConsole *con)
     ssd->qxl.base.sif = &dpy_interface.base;
     qemu_spice_add_display_interface(&ssd->qxl, con);
 
-#if SPICE_SERVER_VERSION >= 0x000e02 /* release 0.14.2 */
-    Error *err = NULL;
-    char device_address[256] = "";
     if (qemu_console_fill_device_address(con, device_address, 256, &err)) {
         spice_qxl_set_device_info(&ssd->qxl,
                                   device_address,
@@ -1425,7 +1422,6 @@ static void qemu_spice_display_init_one(QemuConsole *con)
     } else {
         error_report_err(err);
     }
-#endif
 
     qemu_spice_create_host_memslot(ssd);
 
-- 
2.52.0


