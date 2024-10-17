Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD41D374A3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rl3-0003WW-8Z; Thu, 17 Oct 2024 10:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl1-0003Vh-O5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:43 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rkz-0005di-Og
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:43 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb4fa17044so11876571fa.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176340; x=1729781140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GanDoQPe72SVPSkPSldUjnclOENoEQhhoRjErfVjJmU=;
 b=X53C9YlUX0EiCW9eo9z20g6pWopwj3vY80M8JYJWB+rS71WBp7eqenhoeB9bQuvib1
 ZLcyDAx+kZTot4ULbfTYmvuQsOSFFUOPb4X2g/qkxVDBa68UQ2Lq2r8Ym8q8/tYc4UU6
 cLAqizJ5XKAjKDCFCAd/Y3P1ESAFcyOVSlgjRLFFKF4ypW3IKjsFi3X8b35Y8s4qbYkz
 7v5LNp3IgrTNoMKcGO4MG0FCKPWy1cA3qrOL5LQmOjMWCJ2bxYNsgXnxMfV2WraZilv8
 gO2q+OEghvPxzDTKz7CE2WrEZ2GXfG9Bnbc/e1WoXhkI9gMxp2wfCEKk2KqpuPm01jRn
 FSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176340; x=1729781140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GanDoQPe72SVPSkPSldUjnclOENoEQhhoRjErfVjJmU=;
 b=sbrU2uvb1ngU0uc+XVQVMlRJEWehrlEOPZAGEt7VEocqMdtIz36BDAlQDazV+CZzyQ
 9RIhvGlMPKQZistgVsXbu38cJUBZqoxV01ZS0QUe+fAP8A6d14hyfnurn+e5JzesxWdN
 jSRsPx9XOuNacM4AZBY0f+o17CRwL2uf250a4DnSikI/UCCDVwILb996JpvUn4QEcran
 WZMUb5bfe1XX1S5PfqZcYS2sj+A6kSGy5QgHZjySAiuJa4Wtqw8IdAOOsZqot+efnEEb
 lJYp1yKJfYjl9w2LplXEx/3wDg1+ua5ZHiNcYltOvP++4hUjpWaQezOxJyHbrWY+u6FJ
 P05w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7CTf62QITflKu8zHcjqhCWrPl19CxjHpB4qlXbCbYwA07RmuSewVt2xhffl111Vn5x1zPZS72eUVv@nongnu.org
X-Gm-Message-State: AOJu0YyTzhtzJTwq/DqtBv8priu7XvNW7SGZGn6On7mIiwVXFQ6s1yPf
 JlCfYdxMHbh9F12bf/z7gWphYW0OPZhuFVbSlmLmz3uUjrRoo0ngn2ycdqpD
X-Google-Smtp-Source: AGHT+IF2MF2uELI/PYTtWbP9qVbmDRb1YFKiCxdfTGd0GSrHygdQJr2XnuNlOgbNMsFvESW/16d9qg==
X-Received: by 2002:a2e:a550:0:b0:2f7:53b8:ca57 with SMTP id
 38308e7fff4ca-2fb3f1d3c4cmr92025871fa.19.1729176339601; 
 Thu, 17 Oct 2024 07:45:39 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:38 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 4/8] chardev/char: rename frontend mux calls
Date: Thu, 17 Oct 2024 16:43:12 +0200
Message-Id: <20241017144316.517709-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
References: <20241017144316.517709-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x234.google.com
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

This patch renames calls in the frontend mux implementation
to reflect its frontend nature. Patch does the following:

  s/mux_chr/mux_fe_chr/g

No functional changes are made.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  6 ++--
 chardev/char-mux-fe.c      | 68 +++++++++++++++++++-------------------
 chardev/chardev-internal.h |  8 ++---
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 7b1ae16c62a4..a2b5bff39fd9 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -197,7 +197,7 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
         if (CHARDEV_IS_MUX_FE(s)) {
             MuxFeChardev *d = MUX_FE_CHARDEV(s);
 
-            if (!mux_chr_attach_frontend(d, b, &tag, errp)) {
+            if (!mux_fe_chr_attach_frontend(d, b, &tag, errp)) {
                 return false;
             }
         } else if (s->be) {
@@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         }
         if (CHARDEV_IS_MUX_FE(b->chr)) {
             MuxFeChardev *d = MUX_FE_CHARDEV(b->chr);
-            mux_chr_detach_frontend(d, b->tag);
+            mux_fe_chr_detach_frontend(d, b->tag);
         }
         if (del) {
             Object *obj = OBJECT(b->chr);
@@ -306,7 +306,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
     }
 
     if (CHARDEV_IS_MUX_FE(b->chr)) {
-        mux_set_focus(b->chr, b->tag);
+        mux_fe_chr_set_focus(b->chr, b->tag);
     }
 }
 
diff --git a/chardev/char-mux-fe.c b/chardev/char-mux-fe.c
index 6a195390a3c9..dcfce099ea9a 100644
--- a/chardev/char-mux-fe.c
+++ b/chardev/char-mux-fe.c
@@ -35,7 +35,7 @@
 /* MUX driver for serial I/O splitting */
 
 /* Called with chr_write_lock held.  */
-static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static int mux_fe_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int ret;
@@ -118,8 +118,8 @@ static void mux_print_help(Chardev *chr)
     }
 }
 
-static void mux_chr_send_event(MuxFeChardev *d, unsigned int mux_nr,
-                               QEMUChrEvent event)
+static void mux_fe_chr_send_event(MuxFeChardev *d, unsigned int mux_nr,
+                                  QEMUChrEvent event)
 {
     CharBackend *be = d->backends[mux_nr];
 
@@ -128,12 +128,12 @@ static void mux_chr_send_event(MuxFeChardev *d, unsigned int mux_nr,
     }
 }
 
-static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
+static void mux_fe_chr_be_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     if (d->focus != -1) {
-        mux_chr_send_event(d, d->focus, event);
+        mux_fe_chr_send_event(d, d->focus, event);
     }
 }
 
@@ -172,7 +172,7 @@ static int mux_proc_byte(Chardev *chr, MuxFeChardev *d, int ch)
             if (bit >= MAX_MUX) {
                 bit = find_next_bit(&d->mux_bitset, MAX_MUX, 0);
             }
-            mux_set_focus(chr, bit);
+            mux_fe_chr_set_focus(chr, bit);
             break;
         } case 't':
             d->timestamps = !d->timestamps;
@@ -189,7 +189,7 @@ static int mux_proc_byte(Chardev *chr, MuxFeChardev *d, int ch)
     return 0;
 }
 
-static void mux_chr_accept_input(Chardev *chr)
+static void mux_fe_chr_accept_input(Chardev *chr)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int m = d->focus;
@@ -202,7 +202,7 @@ static void mux_chr_accept_input(Chardev *chr)
     }
 }
 
-static int mux_chr_can_read(void *opaque)
+static int mux_fe_chr_can_read(void *opaque)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(opaque);
     int m = d->focus;
@@ -219,7 +219,7 @@ static int mux_chr_can_read(void *opaque)
     return 0;
 }
 
-static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
+static void mux_fe_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     Chardev *chr = CHARDEV(opaque);
     MuxFeChardev *d = MUX_FE_CHARDEV(opaque);
@@ -227,7 +227,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
     CharBackend *be = d->backends[m];
     int i;
 
-    mux_chr_accept_input(opaque);
+    mux_fe_chr_accept_input(opaque);
 
     for (i = 0; i < size; i++)
         if (mux_proc_byte(chr, d, buf[i])) {
@@ -248,16 +248,16 @@ void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event)
     /* Send the event to all registered listeners */
     bit = -1;
     while ((bit = find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < MAX_MUX) {
-        mux_chr_send_event(d, bit, event);
+        mux_fe_chr_send_event(d, bit, event);
     }
 }
 
-static void mux_chr_event(void *opaque, QEMUChrEvent event)
+static void mux_fe_chr_event(void *opaque, QEMUChrEvent event)
 {
     mux_chr_send_all_event(CHARDEV(opaque), event);
 }
 
-static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
+static GSource *mux_fe_chr_add_watch(Chardev *s, GIOCondition cond)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(s);
     Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
@@ -270,7 +270,7 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
     return cc->chr_add_watch(chr, cond);
 }
 
-static void char_mux_finalize(Object *obj)
+static void char_mux_fe_finalize(Object *obj)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(obj);
     int bit;
@@ -285,22 +285,22 @@ static void char_mux_finalize(Object *obj)
     qemu_chr_fe_deinit(&d->chr, false);
 }
 
-static void mux_chr_update_read_handlers(Chardev *chr)
+static void mux_fe_chr_update_read_handlers(Chardev *chr)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers_full(&d->chr,
-                                  mux_chr_can_read,
-                                  mux_chr_read,
-                                  mux_chr_event,
+                                  mux_fe_chr_can_read,
+                                  mux_fe_chr_read,
+                                  mux_fe_chr_event,
                                   NULL,
                                   chr,
                                   chr->gcontext, true, false);
 }
 
-bool mux_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
-                             unsigned int *tag, Error **errp)
+bool mux_fe_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
+                                unsigned int *tag, Error **errp)
 {
     unsigned int bit;
 
@@ -320,7 +320,7 @@ bool mux_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
     return true;
 }
 
-bool mux_chr_detach_frontend(MuxFeChardev *d, unsigned int tag)
+bool mux_fe_chr_detach_frontend(MuxFeChardev *d, unsigned int tag)
 {
     unsigned int bit;
 
@@ -335,19 +335,19 @@ bool mux_chr_detach_frontend(MuxFeChardev *d, unsigned int tag)
     return true;
 }
 
-void mux_set_focus(Chardev *chr, unsigned int focus)
+void mux_fe_chr_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) == focus);
 
     if (d->focus != -1) {
-        mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
+        mux_fe_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
     }
 
     d->focus = focus;
     chr->be = d->backends[focus];
-    mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
+    mux_fe_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
 static void qemu_chr_open_mux(Chardev *chr,
@@ -389,30 +389,30 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
     mux->chardev = g_strdup(chardev);
 }
 
-static void char_mux_class_init(ObjectClass *oc, void *data)
+static void char_mux_fe_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
     cc->parse = qemu_chr_parse_mux;
     cc->open = qemu_chr_open_mux;
-    cc->chr_write = mux_chr_write;
-    cc->chr_accept_input = mux_chr_accept_input;
-    cc->chr_add_watch = mux_chr_add_watch;
-    cc->chr_be_event = mux_chr_be_event;
-    cc->chr_update_read_handler = mux_chr_update_read_handlers;
+    cc->chr_write = mux_fe_chr_write;
+    cc->chr_accept_input = mux_fe_chr_accept_input;
+    cc->chr_add_watch = mux_fe_chr_add_watch;
+    cc->chr_be_event = mux_fe_chr_be_event;
+    cc->chr_update_read_handler = mux_fe_chr_update_read_handlers;
 }
 
-static const TypeInfo char_mux_type_info = {
+static const TypeInfo char_mux_fe_type_info = {
     .name = TYPE_CHARDEV_MUX_FE,
     .parent = TYPE_CHARDEV,
-    .class_init = char_mux_class_init,
+    .class_init = char_mux_fe_class_init,
     .instance_size = sizeof(MuxFeChardev),
-    .instance_finalize = char_mux_finalize,
+    .instance_finalize = char_mux_fe_finalize,
 };
 
 static void register_types(void)
 {
-    type_register_static(&char_mux_type_info);
+    type_register_static(&char_mux_fe_type_info);
 }
 
 type_init(register_types);
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index c874850a41ad..94c8d07ac235 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -59,14 +59,14 @@ DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
 #define CHARDEV_IS_MUX_FE(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)
 
-bool mux_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
-                             unsigned int *tag, Error **errp);
-bool mux_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
-void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
 /* Mux type dependent calls */
+void mux_fe_chr_set_focus(Chardev *d, unsigned int focus);
 void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event);
+bool mux_fe_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
+                                unsigned int *tag, Error **errp);
+bool mux_fe_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
 
 Object *get_chardevs_root(void);
 
-- 
2.34.1


