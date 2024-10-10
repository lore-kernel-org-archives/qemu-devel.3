Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61EFCF11C6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHg-0006Sr-43; Thu, 10 Oct 2024 06:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHd-0006R0-7T
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:37 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHa-0003Xm-FC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:36 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99422929c5so89630066b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728555633; x=1729160433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKDzqyax2qKyd+N8mhq+Mp3gABt7BQpJI6OVdd7Cz18=;
 b=BCnRZ7rOQSWnGkcGN2v11kPfdc45zqJMMDAosLIS3lbLrI3myvQIqq98ys36bAr3k2
 q37tN6i8wInMPKxLzrNxpulV+3/wNZ4DLpbh7TUzopoqnLeH96a3gzE19TqJCdgKT1bJ
 W0m1JvrweTOqL+Vy2wc77b6tr6qN1M6eWsVel6lG+Jmk8Zo8XLFKrkMoIImLDzOO2R4g
 gP3vO70yybIjHT12m7U+eceYnZG3IxsL3FKOWMarnAfl4rKSznp12jf1FMcFMiD52v6Y
 QA0zszMH3573BXFj7PkRlQfyXqQLbqcqJSvTOKVz7uHTX4QUqXIW6pJMDM53gdDwglO/
 Ox/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555633; x=1729160433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKDzqyax2qKyd+N8mhq+Mp3gABt7BQpJI6OVdd7Cz18=;
 b=vQOCjJ5ch+RcC8Uv7dezBt2aXlDNBz5owLqWiWYQAyI3CAcP7Ow7b/paGB4vWvAwPf
 JC20ufFOFGxgcD8O204yv0TFQ5NA7ZFvrs4chZ/Wew4fP2Nmweeqxq65H3CwG1aTSHB4
 2aa1zE733q1RDToH1yQKm8FkgFIRmn2KLo01Eh3EfAQRMtdJjnuphDiBA5QTLBhZyty6
 Dcf2M8UvssBfWtDGYZzKu3bmtDDnRFTe6TdNZUPs0dVzKzwHFkxkoEdNv+GwBHOd1FnY
 5VWfwbfZnnbxsxy41RD1YAvxL8OgRMkT+zIVdT4KD9UESeQ7JGDEePioBvWqIUzI44+3
 uRuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZp0NAoD5Zv++GU0u20zIEkn4w7dFQi3F1zljK3V/cSNFQk2PzPSZIxUoVR0OIwTWErdz/bgn/tj8A@nongnu.org
X-Gm-Message-State: AOJu0YzkLJE55g3evmurGXepVpdHLeh+dT02rDfXStrU+RbjvvMc2in9
 Lqw9FLbRIEY5s1qaP/JOQLU8zdVlOMQRdwyP6Qs9d9M18OYnc0IKPWC2ig==
X-Google-Smtp-Source: AGHT+IG5JfdBMKYCTEiPbju1tQDeHqOpCUSX07QskTqYCko846g2j9tgNukhKsbH4xYneLzXNnPE6Q==
X-Received: by 2002:a17:907:7e83:b0:a99:446f:4c1 with SMTP id
 a640c23a62f3a-a998d20e83dmr513675666b.33.1728555632338; 
 Thu, 10 Oct 2024 03:20:32 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2436fsm68240266b.53.2024.10.10.03.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 03:20:32 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/7] chardev/char: move away mux suspend/resume calls
Date: Thu, 10 Oct 2024 12:18:33 +0200
Message-Id: <20241010101838.331032-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010101838.331032-1-r.peniaev@gmail.com>
References: <20241010101838.331032-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The suspend/resume open multiplexer calls are generic
and will be used for frontend (current mux) and backend
(will follow) implementations. Move them away from the
`char-mux-fe.c` to more generic `char.c` file. Also
for the sake of clarity these renames were made:

  s/suspend_mux_open/mux_suspend_open/g
  s/resume_mux_open/mux_resume_open/g

No functional changes are made.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux-fe.c      | 63 ++-------------------------------
 chardev/char.c             | 72 ++++++++++++++++++++++++++++++++++++++
 chardev/chardev-internal.h |  3 ++
 include/chardev/char.h     |  5 +--
 system/vl.c                |  4 +--
 5 files changed, 82 insertions(+), 65 deletions(-)

diff --git a/chardev/char-mux-fe.c b/chardev/char-mux-fe.c
index 673971ca1798..cd9ff0c5dc12 100644
--- a/chardev/char-mux-fe.c
+++ b/chardev/char-mux-fe.c
@@ -33,13 +33,6 @@
 
 /* MUX driver for serial I/O splitting */
 
-/*
- * Set to false by suspend_mux_open.  Open events are delayed until
- * resume_mux_open.  Usually suspend_mux_open is called before
- * command line processing and resume_mux_open afterwards.
- */
-static bool muxes_opened = true;
-
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
@@ -239,15 +232,10 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
         }
 }
 
-void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
+void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event)
 {
-    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int i;
 
-    if (!muxes_opened) {
-        return;
-    }
-
     /* Send the event to all registered listeners */
     for (i = 0; i < d->mux_cnt; i++) {
         mux_chr_send_event(d, i, event);
@@ -335,7 +323,7 @@ static void qemu_chr_open_mux(Chardev *chr,
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
-    *be_opened = muxes_opened;
+    *be_opened = mux_is_opened();
     qemu_chr_fe_init(&d->chr, drv, errp);
 }
 
@@ -355,53 +343,6 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
     mux->chardev = g_strdup(chardev);
 }
 
-/**
- * Called after processing of default and command-line-specified
- * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
- * to a mux chardev. This is done here to ensure that
- * output/prompts/banners are only displayed for the FE that has
- * focus when initial command-line processing/machine init is
- * completed.
- *
- * After this point, any new FE attached to any new or existing
- * mux will receive CHR_EVENT_OPENED notifications for the BE
- * immediately.
- */
-static void open_muxes(Chardev *chr)
-{
-    /* send OPENED to all already-attached FEs */
-    mux_chr_send_all_event(chr, CHR_EVENT_OPENED);
-
-    /*
-     * mark mux as OPENED so any new FEs will immediately receive
-     * OPENED event
-     */
-    chr->be_open = 1;
-}
-
-void suspend_mux_open(void)
-{
-    muxes_opened = false;
-}
-
-static int chardev_options_parsed_cb(Object *child, void *opaque)
-{
-    Chardev *chr = (Chardev *)child;
-
-    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
-        open_muxes(chr);
-    }
-
-    return 0;
-}
-
-void resume_mux_open(void)
-{
-    muxes_opened = true;
-    object_child_foreach(get_chardevs_root(),
-                         chardev_options_parsed_cb, NULL);
-}
-
 static void char_mux_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
diff --git a/chardev/char.c b/chardev/char.c
index 9d180f996dfb..d38a0c76a51e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -43,6 +43,13 @@
 
 #include "chardev-internal.h"
 
+/*
+ * Set to false by mux_suspend_open().  Open events are delayed until
+ * mux_resume_open().  Usually mux_suspend_open() is called before
+ * command line processing and mux_resume_open() afterwards.
+ */
+static bool muxes_opened = true;
+
 /***********************************************************/
 /* character device */
 
@@ -1259,6 +1266,71 @@ void qemu_chr_cleanup(void)
     object_unparent(get_chardevs_root());
 }
 
+/**
+ * Called after processing of default and command-line-specified
+ * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
+ * to a mux chardev. This is done here to ensure that
+ * output/prompts/banners are only displayed for the FE that has
+ * focus when initial command-line processing/machine init is
+ * completed.
+ *
+ * After this point, any new FE attached to any new or existing
+ * mux will receive CHR_EVENT_OPENED notifications for the BE
+ * immediately.
+ */
+static void open_muxes(Chardev *chr)
+{
+    /* send OPENED to all already-attached FEs */
+    mux_chr_send_all_event(chr, CHR_EVENT_OPENED);
+
+    /*
+     * mark mux as OPENED so any new FEs will immediately receive
+     * OPENED event
+     */
+    chr->be_open = 1;
+}
+
+void mux_suspend_open(void)
+{
+    muxes_opened = false;
+}
+
+static int chardev_options_parsed_cb(Object *child, void *opaque)
+{
+    Chardev *chr = (Chardev *)child;
+
+    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
+        open_muxes(chr);
+    }
+
+    return 0;
+}
+
+void mux_resume_open(void)
+{
+    muxes_opened = true;
+    object_child_foreach(get_chardevs_root(),
+                         chardev_options_parsed_cb, NULL);
+}
+
+bool mux_is_opened(void)
+{
+    return muxes_opened;
+}
+
+void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
+{
+    if (!mux_is_opened()) {
+        return;
+    }
+
+    if (CHARDEV_IS_MUX_FE(chr)) {
+        MuxFeChardev *d = MUX_FE_CHARDEV(chr);
+
+        mux_fe_chr_send_all_event(d, event);
+    }
+}
+
 static void register_types(void)
 {
     type_register_static(&char_type_info);
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 1b943c81bcd8..a77f0bdaccfa 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -63,6 +63,9 @@ DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
 void mux_set_focus(Chardev *chr, int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
+/* Mux type dependent calls */
+void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event);
+
 Object *get_chardevs_root(void);
 
 #endif /* CHARDEV_INTERNAL_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index d9d23b6232db..0bec974f9d73 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -317,7 +317,8 @@ extern int term_escape_char;
 GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
                                  GSourceFunc func, void *private);
 
-void suspend_mux_open(void);
-void resume_mux_open(void);
+bool mux_is_opened(void);
+void mux_suspend_open(void);
+void mux_resume_open(void);
 
 #endif
diff --git a/system/vl.c b/system/vl.c
index fe547ca47c27..6222e0625b1e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3690,7 +3690,7 @@ void qemu_init(int argc, char **argv)
 
     qemu_create_machine(machine_opts_dict);
 
-    suspend_mux_open();
+    mux_suspend_open();
 
     qemu_disable_default_devices();
     qemu_setup_display();
@@ -3768,5 +3768,5 @@ void qemu_init(int argc, char **argv)
     qemu_init_displays();
     accel_setup_post(current_machine);
     os_setup_post();
-    resume_mux_open();
+    mux_resume_open();
 }
-- 
2.34.1


