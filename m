Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F195C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPqe-00057d-Ok; Mon, 18 Mar 2024 23:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqc-000575-Gp
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:09:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqa-0007Zl-21
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:09:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dde26f7e1dso35853795ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710817741; x=1711422541;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=voqKMRFIOybvS2Hg6iHx8FdNHKUHUcPUs/Xfg158V/I=;
 b=oek0XIQzA3g8vsTRluDh78am14jQP6pQ9T9jXY36mlwzyJeyFb47dkT0nbGYn/r/CD
 hPuHQTKh8zOEDU9+zPtLdZK7l2ZeWaAJXxTsIuXFacAGux08BFIf/vEaqPpcYUZY9b7G
 zGwNKGAmTVIRKVgMw1o9LFl/E01k75WTulU0L/GNXTXMb7IB3+DTGJOzie4HK4KmSiSG
 8iXs2ziVlYQNKNY0iJqvDqQgyYLjatfgNP1la9gb7HrPwynUU13GPU4jgvWj8xI7yGBT
 hPk929SS7kPLBL+AmF10/Rf1Dcg/RjoOGujng8HZoEuW6HDdpCI6iIF40tYjbSTYm55K
 l0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710817741; x=1711422541;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voqKMRFIOybvS2Hg6iHx8FdNHKUHUcPUs/Xfg158V/I=;
 b=Fz+WwiA/38JYIaIjBLfWpBaotuo9ebYsaco37gEZg+jZK9X31EfBcEbyCrz5J4hYvq
 G6Wr1qz4NR3cS9jdh8ys1KlwoMn3Gf27enIFMmjJpuNxzCQZ5OvvUwkUi9sqatX1Hm0b
 qiI4vt7v2vVDXHLxBN5Fz7fz3d1a1xbA49BFonKd83qc6C6bOezs2qBYyvt9x/HxKDne
 usmEgunc9vxxra05zcRHbzU/SJHP76Teo56ZRHtVfMRavpq3Kw1lIjfnG7Eg25drBOe3
 r/4c6AlVjqNn3wIixFVdLEzv6qd7YaRJk0q7GA/mtDJb9ZZFNWKRTf4sMeVLkMg1YDSJ
 Dg7g==
X-Gm-Message-State: AOJu0YxjTY5bceRpCMTZP/dAslhQnj8JNQtsXHh4ce/01LPu7TVokt5W
 78CvhQNdDPG2gJspjyJzRdzXj2q+5pi/oEii5gLYsefF1fxWbosPJxXQ3BD7CpiBTb7VhVGIjGb
 u
X-Google-Smtp-Source: AGHT+IHBWUwNnAjKNAlb2gFpp3MjGdo9YOkG8jlg1lLF5xVcXX2yMQDt3qmHq5dTuDyfqJKRxhT9FQ==
X-Received: by 2002:a17:902:c206:b0:1dd:7829:6a2b with SMTP id
 6-20020a170902c20600b001dd78296a2bmr12419981pll.35.1710817741417; 
 Mon, 18 Mar 2024 20:09:01 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 u7-20020a17090341c700b001dde004b31bsm5535915ple.166.2024.03.18.20.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 20:09:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 19 Mar 2024 12:08:42 +0900
Subject: [PATCH v2 4/4] ui/curses: Do not use console_select()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-console-v2-4-3fd6feef321a@daynix.com>
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
In-Reply-To: <20240319-console-v2-0-3fd6feef321a@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ui/curses is the only user of console_select(). Move the implementation
to ui/curses.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/ui/console.h  |   1 -
 ui/console-priv.h     |   2 +-
 ui/console-vc-stubs.c |   2 +-
 ui/console-vc.c       |   3 +-
 ui/console.c          | 121 +++++++++-----------------------------------------
 ui/curses.c           |  48 +++++++++++---------
 6 files changed, 51 insertions(+), 126 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 3729d2db29c7..0bc7a00ac0bb 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -433,7 +433,6 @@ int qemu_console_get_window_id(QemuConsole *con);
 /* Set the low-level window id for the console */
 void qemu_console_set_window_id(QemuConsole *con, int window_id);
 
-void console_select(unsigned int index);
 void qemu_console_resize(QemuConsole *con, int width, int height);
 DisplaySurface *qemu_console_surface(QemuConsole *con);
 void coroutine_fn qemu_console_co_wait_update(QemuConsole *con);
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 88569ed2cc41..43ceb8122f13 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -35,7 +35,7 @@ struct QemuConsole {
     QTAILQ_ENTRY(QemuConsole) next;
 };
 
-void qemu_text_console_select(QemuTextConsole *c);
+void qemu_text_console_update_size(QemuTextConsole *c);
 const char * qemu_text_console_get_label(QemuTextConsole *c);
 void qemu_text_console_update_cursor(void);
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym);
diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
index 2afc52329f0c..b63e2fb2345f 100644
--- a/ui/console-vc-stubs.c
+++ b/ui/console-vc-stubs.c
@@ -10,7 +10,7 @@
 #include "chardev/char.h"
 #include "ui/console-priv.h"
 
-void qemu_text_console_select(QemuTextConsole *c)
+void qemu_text_console_update_size(QemuTextConsole *c)
 {
 }
 
diff --git a/ui/console-vc.c b/ui/console-vc.c
index f22c8e23c2ed..899fa11c9485 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -958,10 +958,9 @@ static void vc_chr_set_echo(Chardev *chr, bool echo)
     drv->console->echo = echo;
 }
 
-void qemu_text_console_select(QemuTextConsole *c)
+void qemu_text_console_update_size(QemuTextConsole *c)
 {
     dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
-    qemu_text_console_update_cursor();
 }
 
 static void vc_chr_open(Chardev *chr,
diff --git a/ui/console.c b/ui/console.c
index fbc1b9b8b57c..43226c5c1454 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -66,7 +66,6 @@ struct DisplayState {
 };
 
 static DisplayState *display_state;
-static QemuConsole *active_console;
 static QTAILQ_HEAD(, QemuConsole) consoles =
     QTAILQ_HEAD_INITIALIZER(consoles);
 
@@ -135,7 +134,6 @@ void graphic_hw_update_done(QemuConsole *con)
 void graphic_hw_update(QemuConsole *con)
 {
     bool async = false;
-    con = con ? con : active_console;
     if (!con) {
         return;
     }
@@ -209,9 +207,6 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id)
 
 void graphic_hw_invalidate(QemuConsole *con)
 {
-    if (!con) {
-        con = active_console;
-    }
     if (con && con->hw_ops->invalidate) {
         con->hw_ops->invalidate(con->hw);
     }
@@ -219,9 +214,6 @@ void graphic_hw_invalidate(QemuConsole *con)
 
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
 {
-    if (!con) {
-        con = active_console;
-    }
     if (con && con->hw_ops->text_update) {
         con->hw_ops->text_update(con->hw, chardata);
     }
@@ -265,12 +257,12 @@ static void dpy_gfx_update_texture(QemuConsole *con, DisplaySurface *surface,
 }
 
 static void displaychangelistener_display_console(DisplayChangeListener *dcl,
-                                                  QemuConsole *con,
                                                   Error **errp)
 {
     static const char nodev[] =
         "This VM has no graphic display device.";
     static DisplaySurface *dummy;
+    QemuConsole *con = dcl->con;
 
     if (!con || !console_compatible_with(con, dcl, errp)) {
         if (!dummy) {
@@ -305,39 +297,8 @@ static void displaychangelistener_display_console(DisplayChangeListener *dcl,
     }
 }
 
-void console_select(unsigned int index)
-{
-    DisplayChangeListener *dcl;
-    QemuConsole *s;
-
-    trace_console_select(index);
-    s = qemu_console_lookup_by_index(index);
-    if (s) {
-        DisplayState *ds = s->ds;
-
-        active_console = s;
-        QLIST_FOREACH (dcl, &ds->listeners, next) {
-            if (dcl->con != NULL) {
-                continue;
-            }
-            displaychangelistener_display_console(dcl, s, NULL);
-        }
-
-        if (QEMU_IS_TEXT_CONSOLE(s)) {
-            qemu_text_console_select(QEMU_TEXT_CONSOLE(s));
-        }
-    }
-}
-
 void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym)
 {
-    if (!s) {
-        if (!QEMU_IS_TEXT_CONSOLE(active_console)) {
-            return;
-        }
-        s = QEMU_TEXT_CONSOLE(active_console);
-    }
-
     qemu_text_console_handle_keysym(s, keysym);
 }
 
@@ -392,11 +353,6 @@ qemu_console_register(QemuConsole *c)
 {
     int i;
 
-    if (!active_console || (!QEMU_IS_GRAPHIC_CONSOLE(active_console) &&
-                            QEMU_IS_GRAPHIC_CONSOLE(c))) {
-        active_console = c;
-    }
-
     if (QTAILQ_EMPTY(&consoles)) {
         c->index = 0;
         QTAILQ_INSERT_TAIL(&consoles, c, next);
@@ -751,8 +707,6 @@ dcl_set_graphic_cursor(DisplayChangeListener *dcl, QemuGraphicConsole *con)
 
 void register_displaychangelistener(DisplayChangeListener *dcl)
 {
-    QemuConsole *con;
-
     assert(!dcl->ds);
 
     trace_displaychangelistener_register(dcl, dcl->ops->dpy_name);
@@ -761,13 +715,12 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
     gui_setup_refresh(dcl->ds);
     if (dcl->con) {
         dcl->con->dcls++;
-        con = dcl->con;
-    } else {
-        con = active_console;
     }
-    displaychangelistener_display_console(dcl, con, dcl->con ? &error_fatal : NULL);
-    if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
-        dcl_set_graphic_cursor(dcl, QEMU_GRAPHIC_CONSOLE(con));
+    displaychangelistener_display_console(dcl, &error_fatal);
+    if (QEMU_IS_GRAPHIC_CONSOLE(dcl->con)) {
+        dcl_set_graphic_cursor(dcl, QEMU_GRAPHIC_CONSOLE(dcl->con));
+    } else if (QEMU_IS_TEXT_CONSOLE(dcl->con)) {
+        qemu_text_console_update_size(QEMU_TEXT_CONSOLE(dcl->con));
     }
     qemu_text_console_update_cursor();
 }
@@ -805,9 +758,6 @@ static void dpy_set_ui_info_timer(void *opaque)
 
 bool dpy_ui_info_supported(const QemuConsole *con)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     if (con == NULL) {
         return false;
     }
@@ -819,19 +769,11 @@ const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
 {
     assert(dpy_ui_info_supported(con));
 
-    if (con == NULL) {
-        con = active_console;
-    }
-
     return &con->ui_info;
 }
 
 int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info, bool delay)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
-
     if (!dpy_ui_info_supported(con)) {
         return -1;
     }
@@ -870,7 +812,7 @@ void dpy_gfx_update(QemuConsole *con, int x, int y, int w, int h)
     }
     dpy_gfx_update_texture(con, con->surface, x, y, w, h);
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gfx_update) {
@@ -916,7 +858,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     con->surface = new_surface;
     dpy_gfx_create_texture(con, new_surface);
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         displaychangelistener_gfx_switch(dcl, new_surface, surface ? FALSE : TRUE);
@@ -970,7 +912,7 @@ void dpy_text_cursor(QemuConsole *con, int x, int y)
         return;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_text_cursor) {
@@ -988,7 +930,7 @@ void dpy_text_update(QemuConsole *con, int x, int y, int w, int h)
         return;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_text_update) {
@@ -1006,7 +948,7 @@ void dpy_text_resize(QemuConsole *con, int w, int h)
         return;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_text_resize) {
@@ -1028,7 +970,7 @@ void dpy_mouse_set(QemuConsole *c, int x, int y, int on)
         return;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (c != (dcl->con ? dcl->con : active_console)) {
+        if (c != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_mouse_set) {
@@ -1049,7 +991,7 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor *cursor)
         return;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (c != (dcl->con ? dcl->con : active_console)) {
+        if (c != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_cursor_define) {
@@ -1099,7 +1041,7 @@ void dpy_gl_scanout_disable(QemuConsole *con)
         con->scanout.kind = SCANOUT_NONE;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gl_scanout_disable) {
@@ -1126,7 +1068,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
         x, y, width, height, d3d_tex2d,
     };
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gl_scanout_texture) {
@@ -1148,7 +1090,7 @@ void dpy_gl_scanout_dmabuf(QemuConsole *con,
     con->scanout.kind = SCANOUT_DMABUF;
     con->scanout.dmabuf = dmabuf;
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gl_scanout_dmabuf) {
@@ -1164,7 +1106,7 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
     DisplayChangeListener *dcl;
 
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gl_cursor_dmabuf) {
@@ -1181,7 +1123,7 @@ void dpy_gl_cursor_position(QemuConsole *con,
     DisplayChangeListener *dcl;
 
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gl_cursor_position) {
@@ -1197,7 +1139,7 @@ void dpy_gl_release_dmabuf(QemuConsole *con,
     DisplayChangeListener *dcl;
 
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gl_release_dmabuf) {
@@ -1216,7 +1158,7 @@ void dpy_gl_update(QemuConsole *con,
 
     graphic_hw_gl_block(con, true);
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (con != dcl->con) {
             continue;
         }
         if (dcl->ops->dpy_gl_update) {
@@ -1415,30 +1357,21 @@ static QemuConsole *qemu_graphic_console_lookup_unused(void)
 
 QEMUCursor *qemu_console_get_cursor(QemuConsole *con)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     return QEMU_IS_GRAPHIC_CONSOLE(con) ? QEMU_GRAPHIC_CONSOLE(con)->cursor : NULL;
 }
 
 bool qemu_console_is_visible(QemuConsole *con)
 {
-    return (con == active_console) || (con->dcls > 0);
+    return con->dcls > 0;
 }
 
 bool qemu_console_is_graphic(QemuConsole *con)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     return con && QEMU_IS_GRAPHIC_CONSOLE(con);
 }
 
 bool qemu_console_is_fixedsize(QemuConsole *con)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     return con && (QEMU_IS_GRAPHIC_CONSOLE(con) || QEMU_IS_FIXED_TEXT_CONSOLE(con));
 }
 
@@ -1505,17 +1438,11 @@ char *qemu_console_get_label(QemuConsole *con)
 
 int qemu_console_get_index(QemuConsole *con)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     return con ? con->index : -1;
 }
 
 uint32_t qemu_console_get_head(QemuConsole *con)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     if (con == NULL) {
         return -1;
     }
@@ -1527,9 +1454,6 @@ uint32_t qemu_console_get_head(QemuConsole *con)
 
 int qemu_console_get_width(QemuConsole *con, int fallback)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     if (con == NULL) {
         return fallback;
     }
@@ -1547,9 +1471,6 @@ int qemu_console_get_width(QemuConsole *con, int fallback)
 
 int qemu_console_get_height(QemuConsole *con, int fallback)
 {
-    if (con == NULL) {
-        con = active_console;
-    }
     if (con == NULL) {
         return fallback;
     }
diff --git a/ui/curses.c b/ui/curses.c
index 8bde8c5cf7c3..ec61615f7c1f 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -98,7 +98,7 @@ static void curses_update(DisplayChangeListener *dcl,
 
 static void curses_calc_pad(void)
 {
-    if (qemu_console_is_fixedsize(NULL)) {
+    if (qemu_console_is_fixedsize(dcl->con)) {
         width = gwidth;
         height = gheight;
     } else {
@@ -201,7 +201,7 @@ static void curses_cursor_position(DisplayChangeListener *dcl,
             curs_set(1);
             /* it seems that curs_set(1) must always be called before
              * curs_set(2) for the latter to have effect */
-            if (!qemu_console_is_graphic(NULL)) {
+            if (!qemu_console_is_graphic(dcl->con)) {
                 curs_set(2);
             }
             return;
@@ -274,11 +274,11 @@ static void curses_refresh(DisplayChangeListener *dcl)
         clear();
         refresh();
         curses_calc_pad();
-        graphic_hw_invalidate(NULL);
+        graphic_hw_invalidate(dcl->con);
         invalidate = 0;
     }
 
-    graphic_hw_text_update(NULL, screen);
+    graphic_hw_text_update(dcl->con, screen);
 
     while (1) {
         /* while there are any pending key strokes to process */
@@ -318,11 +318,16 @@ static void curses_refresh(DisplayChangeListener *dcl)
                     /* process keys reserved for qemu */
                     if (keycode >= QEMU_KEY_CONSOLE0 &&
                             keycode < QEMU_KEY_CONSOLE0 + 9) {
-                        erase();
-                        wnoutrefresh(stdscr);
-                        console_select(keycode - QEMU_KEY_CONSOLE0);
-
-                        invalidate = 1;
+                        QemuConsole *con = qemu_console_lookup_by_index(keycode - QEMU_KEY_CONSOLE0);
+                        if (con) {
+                            erase();
+                            wnoutrefresh(stdscr);
+                            unregister_displaychangelistener(dcl);
+                            dcl->con = con;
+                            register_displaychangelistener(dcl);
+
+                            invalidate = 1;
+                        }
                         continue;
                     }
                 }
@@ -354,45 +359,45 @@ static void curses_refresh(DisplayChangeListener *dcl)
         if (keycode == -1)
             continue;
 
-        if (qemu_console_is_graphic(NULL)) {
+        if (qemu_console_is_graphic(dcl->con)) {
             /* since terminals don't know about key press and release
              * events, we need to emit both for each key received */
             if (keycode & SHIFT) {
-                qemu_input_event_send_key_number(NULL, SHIFT_CODE, true);
+                qemu_input_event_send_key_number(dcl->con, SHIFT_CODE, true);
                 qemu_input_event_send_key_delay(0);
             }
             if (keycode & CNTRL) {
-                qemu_input_event_send_key_number(NULL, CNTRL_CODE, true);
+                qemu_input_event_send_key_number(dcl->con, CNTRL_CODE, true);
                 qemu_input_event_send_key_delay(0);
             }
             if (keycode & ALT) {
-                qemu_input_event_send_key_number(NULL, ALT_CODE, true);
+                qemu_input_event_send_key_number(dcl->con, ALT_CODE, true);
                 qemu_input_event_send_key_delay(0);
             }
             if (keycode & ALTGR) {
-                qemu_input_event_send_key_number(NULL, GREY | ALT_CODE, true);
+                qemu_input_event_send_key_number(dcl->con, GREY | ALT_CODE, true);
                 qemu_input_event_send_key_delay(0);
             }
 
-            qemu_input_event_send_key_number(NULL, keycode & KEY_MASK, true);
+            qemu_input_event_send_key_number(dcl->con, keycode & KEY_MASK, true);
             qemu_input_event_send_key_delay(0);
-            qemu_input_event_send_key_number(NULL, keycode & KEY_MASK, false);
+            qemu_input_event_send_key_number(dcl->con, keycode & KEY_MASK, false);
             qemu_input_event_send_key_delay(0);
 
             if (keycode & ALTGR) {
-                qemu_input_event_send_key_number(NULL, GREY | ALT_CODE, false);
+                qemu_input_event_send_key_number(dcl->con, GREY | ALT_CODE, false);
                 qemu_input_event_send_key_delay(0);
             }
             if (keycode & ALT) {
-                qemu_input_event_send_key_number(NULL, ALT_CODE, false);
+                qemu_input_event_send_key_number(dcl->con, ALT_CODE, false);
                 qemu_input_event_send_key_delay(0);
             }
             if (keycode & CNTRL) {
-                qemu_input_event_send_key_number(NULL, CNTRL_CODE, false);
+                qemu_input_event_send_key_number(dcl->con, CNTRL_CODE, false);
                 qemu_input_event_send_key_delay(0);
             }
             if (keycode & SHIFT) {
-                qemu_input_event_send_key_number(NULL, SHIFT_CODE, false);
+                qemu_input_event_send_key_number(dcl->con, SHIFT_CODE, false);
                 qemu_input_event_send_key_delay(0);
             }
         } else {
@@ -400,7 +405,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
             if (keysym == -1)
                 keysym = chr;
 
-            qemu_text_console_put_keysym(NULL, keysym);
+            qemu_text_console_put_keysym(QEMU_TEXT_CONSOLE(dcl->con), keysym);
         }
     }
 }
@@ -798,6 +803,7 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
     curses_winch_init();
 
     dcl = g_new0(DisplayChangeListener, 1);
+    dcl->con = qemu_console_lookup_default();
     dcl->ops = &dcl_ops;
     register_displaychangelistener(dcl);
 

-- 
2.44.0


