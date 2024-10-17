Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA30D374A3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rl7-0003Y7-7A; Thu, 17 Oct 2024 10:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl4-0003X3-Qs
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:46 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl1-0005es-Vs
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so1513923a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176342; x=1729781142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8uFRJduKBOIoIdWhyfSl/CyT6kPP6VnOfjMEjyVSjY=;
 b=ewWJ5VGB9hn6TyQ30hrg6bIE/vKq09pCW8w51UShpwrZrsEp5hS/YuIRSp15Ki2i1M
 GTllW4X1t1cVkoxlLSt0zvECyQc2OnNVjdlNlxBzjwZaAOjTQ/jVG29L0puOKZact5I5
 YPr0secoPT6DWZkKQAeFSDaxETTsDXMpi2xrOFmKGgQ8Q7p8VSJnkdMLRwqgGaI9uqwi
 a0/q2ytqgGxJ3lblDq1ri8yvjPzMDabKho7FBhI4+KvhmVYL/qiiL05zPSAhLmaz5C8o
 WZcQEN5ec3Zbd2iTF3cria0rBRn6OvCUKP0+PMsgZBZfC/HTs6oyAMUNIkoFCSIYlfsS
 OA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176342; x=1729781142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8uFRJduKBOIoIdWhyfSl/CyT6kPP6VnOfjMEjyVSjY=;
 b=ht00TTQR7k6xikks1fwruxJK+j8/EUMWl5EKuxWSN7EeHcUDq+2Ts6AX83JqweAcLF
 I1lfkWhuHWn3Y7tGYawUTo0uksTg+3jyFW9DtUzDZPBK6+7BsCNnl8myIMcxM6Vnh4/8
 Is3bD7sobWu6zvfykoP+jWGxSrZIfelQzBGCq2SuAYIV0CoN4fSxaESekidCs/1N6rGo
 KDKMcqj7Jya9Z+9NHDm+BVqVu4zHmsi2S5hbNL7CQqxu68Qn8ewJ7M84uz+TrXwNBBeQ
 qXVPVt6bBSuvc+BsUbeqyP6ENWlUtbQjbDQ15luYB6vbc5UN72htIdOYflLWThU+5zRB
 2u1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+zlfyD8jEMhz+xvMIICN3CimEHzAtisUu+aDyANGlrrkghrYH0kW4suaS76JysTDg72v6+L/SyaUA@nongnu.org
X-Gm-Message-State: AOJu0YxQ3mLeBneb+7JpEvydva06Y5tJYFyJQqThgbquz9Wmnqk4x3JR
 dk3RsZlcK9Lc7Kqk5vxugfVBKvT4vQssf4n/PYtFfncNo7MX7JbM
X-Google-Smtp-Source: AGHT+IHCHyVjlbWv9f3e8uQnJJy0IaAq5mKIPCjBbokRthtCIrFzYfPfYKDfdEh+7vyU23K0c+2rBw==
X-Received: by 2002:a05:6402:34d4:b0:5c8:8381:c1bf with SMTP id
 4fb4d7f45d1cf-5c95ac098e1mr11534626a12.3.1729176342199; 
 Thu, 17 Oct 2024 07:45:42 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:40 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 6/8] chardev/char-mux: implement backend chardev
 multiplexing
Date: Thu, 17 Oct 2024 16:43:14 +0200
Message-Id: <20241017144316.517709-7-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
References: <20241017144316.517709-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x536.google.com
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

This patch implements multiplexing capability of several backend
devices, which opens up an opportunity to use a single frontend
device on the guest, which can be manipulated from several
backend devices.

The idea of the change is trivial: keep list of backend devices
(up to 4), init them on demand and forward data buffer back and
forth.

Patch implements another multiplexer type `mux-be`. The following
is QEMU command line example:

   -chardev mux-be,id=mux0 \
   -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0,mux-be-id=mux0 \
   -chardev vc,id=vc0,mux-be-id=mux0 \
   -device virtconsole,chardev=mux0 \
   -vnc 0.0.0.0:0

Which creates 2 backend devices: text virtual console (`vc0`) and a
socket (`sock0`) connected to the single virtio hvc console with the
backend multiplexer (`mux0`) help. `vc0` renders text to an image,
which can be shared over the VNC protocol.  `sock0` is a socket
backend which provides biderectional communication to the virtio hvc
console.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |   9 ++
 chardev/char-mux-be.c      | 290 +++++++++++++++++++++++++++++++++++++
 chardev/char.c             |  62 ++++++--
 chardev/chardev-internal.h |  34 ++++-
 chardev/meson.build        |   1 +
 include/chardev/char.h     |   1 +
 qapi/char.json             |  25 ++++
 7 files changed, 409 insertions(+), 13 deletions(-)
 create mode 100644 chardev/char-mux-be.c

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index a2b5bff39fd9..2f794674563b 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -200,6 +200,12 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
             if (!mux_fe_chr_attach_frontend(d, b, &tag, errp)) {
                 return false;
             }
+        } else if (CHARDEV_IS_MUX_BE(s)) {
+            MuxBeChardev *d = MUX_BE_CHARDEV(s);
+
+            if (!mux_be_chr_attach_frontend(d, b, errp)) {
+                return false;
+            }
         } else if (s->be) {
             error_setg(errp, "chardev '%s' is already in use", s->label);
             return false;
@@ -226,6 +232,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         if (CHARDEV_IS_MUX_FE(b->chr)) {
             MuxFeChardev *d = MUX_FE_CHARDEV(b->chr);
             mux_fe_chr_detach_frontend(d, b->tag);
+        } else if (CHARDEV_IS_MUX_BE(b->chr)) {
+            MuxBeChardev *d = MUX_BE_CHARDEV(b->chr);
+            mux_be_chr_detach_frontend(d);
         }
         if (del) {
             Object *obj = OBJECT(b->chr);
diff --git a/chardev/char-mux-be.c b/chardev/char-mux-be.c
new file mode 100644
index 000000000000..64a4f2c00034
--- /dev/null
+++ b/chardev/char-mux-be.c
@@ -0,0 +1,290 @@
+/*
+ * QEMU Character Backend Multiplexer
+ *
+ * Author: Roman Penyaev <r.peniaev@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/cutils.h"
+#include "chardev/char.h"
+#include "sysemu/block-backend.h"
+#include "qapi/qapi-commands-control.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-builtin-visit.h"
+#include "chardev-internal.h"
+
+/*
+ * MUX-BE driver for multiplexing 1 frontend device with N backend devices
+ */
+
+/*
+ * Write to all backends. Different backend devices accept data with
+ * various rate, so it is quite possible that one device returns less,
+ * then others. In this case we return minimum to the caller,
+ * expecting caller will repeat operation soon. When repeat happens
+ * send to the devices which consume data faster must be avoided
+ * for obvious reasons not to send data, which was already sent.
+ */
+static int mux_be_chr_write_to_all(MuxBeChardev *d, const uint8_t *buf, int len)
+{
+    int r, i, ret = len;
+    unsigned int written;
+
+    for (i = 0; i < d->be_cnt; i++) {
+        written = d->be_written[i] - d->be_min_written;
+        if (written) {
+            /* Written in the previous call so take into account */
+            ret = MIN(written, ret);
+            continue;
+        }
+        r = qemu_chr_fe_write(&d->backends[i], buf, len);
+        if (r < 0 && errno == EAGAIN) {
+            /*
+             * Fail immediately if write would block. Expect to be called
+             * soon on watch wake up.
+             */
+            return r;
+        } else if (r < 0) {
+            /*
+             * Ignore all other errors and pretend the entire buffer is
+             * written to avoid this chardev being watched. This device
+             * becomes disabled until the following write succeeds, but
+             * writing continues to others.
+             */
+            r = len;
+        }
+        d->be_written[i] += r;
+        ret = MIN(r, ret);
+    }
+    d->be_min_written += ret;
+
+    return ret;
+}
+
+/* Called with chr_write_lock held.  */
+static int mux_be_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+    return mux_be_chr_write_to_all(d, buf, len);
+}
+
+static void mux_be_chr_send_event(MuxBeChardev *d, QEMUChrEvent event)
+{
+    CharBackend *fe = d->frontend;
+
+    if (fe && fe->chr_event) {
+        fe->chr_event(fe->opaque, event);
+    }
+}
+
+static void mux_be_chr_be_event(Chardev *chr, QEMUChrEvent event)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+
+    mux_be_chr_send_event(d, event);
+}
+
+static int mux_be_chr_can_read(void *opaque)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(opaque);
+    CharBackend *fe = d->frontend;
+
+    if (fe && fe->chr_can_read) {
+        return fe->chr_can_read(fe->opaque);
+    }
+
+    return 0;
+}
+
+static void mux_be_chr_read(void *opaque, const uint8_t *buf, int size)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(opaque);
+    CharBackend *fe = d->frontend;
+
+    if (fe && fe->chr_read) {
+        fe->chr_read(fe->opaque, buf, size);
+    }
+}
+
+void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event)
+{
+    mux_be_chr_send_event(d, event);
+}
+
+static void mux_be_chr_event(void *opaque, QEMUChrEvent event)
+{
+    mux_chr_send_all_event(CHARDEV(opaque), event);
+}
+
+static GSource *mux_be_chr_add_watch(Chardev *s, GIOCondition cond)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(s);
+    Chardev *chr;
+    ChardevClass *cc;
+    unsigned int written;
+    int i;
+
+    for (i = 0; i < d->be_cnt; i++) {
+        written = d->be_written[i] - d->be_min_written;
+        if (written) {
+            /* We skip the device with already written buffer */
+            continue;
+        }
+
+        /*
+         * The first device that has no data written to it must be
+         * the device that recently returned EAGAIN and should be
+         * watched.
+         */
+
+        chr = qemu_chr_fe_get_driver(&d->backends[i]);
+        cc = CHARDEV_GET_CLASS(chr);
+
+        if (!cc->chr_add_watch) {
+            return NULL;
+        }
+
+        return cc->chr_add_watch(chr, cond);
+    }
+
+    return NULL;
+}
+
+bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **errp)
+{
+    bool ret;
+
+    if (d->be_cnt >= MAX_MUX) {
+        error_setg(errp, "too many uses of multiplexed chardev '%s'"
+                   " (maximum is " stringify(MAX_MUX) ")",
+                   d->parent.label);
+        return false;
+    }
+    ret = qemu_chr_fe_init(&d->backends[d->be_cnt], chr, errp);
+    if (ret) {
+        /* Catch up with what was already written */
+        d->be_written[d->be_cnt] = d->be_min_written;
+        d->be_cnt += 1;
+    }
+
+    return ret;
+}
+
+static void char_mux_be_finalize(Object *obj)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(obj);
+    CharBackend *fe = d->frontend;
+    int i;
+
+    if (fe) {
+        fe->chr = NULL;
+    }
+    for (i = 0; i < d->be_cnt; i++) {
+        qemu_chr_fe_deinit(&d->backends[i], false);
+    }
+}
+
+static void mux_be_chr_update_read_handlers(Chardev *chr)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+    int i;
+
+    for (i = 0; i < d->be_cnt; i++) {
+        /* Fix up the real driver with mux routines */
+        qemu_chr_fe_set_handlers_full(&d->backends[i],
+                                      mux_be_chr_can_read,
+                                      mux_be_chr_read,
+                                      mux_be_chr_event,
+                                      NULL,
+                                      chr,
+                                      chr->gcontext, true, false);
+    }
+}
+
+bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error **errp)
+{
+    if (d->frontend) {
+        error_setg(errp,
+                   "multiplexed chardev '%s' is already used "
+                   "for multiplexing", d->parent.label);
+        return false;
+    }
+    d->frontend = b;
+
+    return true;
+}
+
+void mux_be_chr_detach_frontend(MuxBeChardev *d)
+{
+    d->frontend = NULL;
+}
+
+static void qemu_chr_open_mux_be(Chardev *chr,
+                                 ChardevBackend *backend,
+                                 bool *be_opened,
+                                 Error **errp)
+{
+    /*
+     * Only default to opened state if we've realized the initial
+     * set of muxes
+     */
+    *be_opened = mux_is_opened();
+}
+
+static void qemu_chr_parse_mux_be(QemuOpts *opts, ChardevBackend *backend,
+                                  Error **errp)
+{
+    ChardevMuxBe *mux;
+
+    backend->type = CHARDEV_BACKEND_KIND_MUX_BE;
+    mux = backend->u.mux_be.data = g_new0(ChardevMuxBe, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevMuxBe_base(mux));
+}
+
+static void char_mux_be_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->parse = qemu_chr_parse_mux_be;
+    cc->open = qemu_chr_open_mux_be;
+    cc->chr_write = mux_be_chr_write;
+    cc->chr_add_watch = mux_be_chr_add_watch;
+    cc->chr_be_event = mux_be_chr_be_event;
+    cc->chr_update_read_handler = mux_be_chr_update_read_handlers;
+}
+
+static const TypeInfo char_mux_be_type_info = {
+    .name = TYPE_CHARDEV_MUX_BE,
+    .parent = TYPE_CHARDEV,
+    .class_init = char_mux_be_class_init,
+    .instance_size = sizeof(MuxBeChardev),
+    .instance_finalize = char_mux_be_finalize,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_mux_be_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index cffe60860589..551ae402cba7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -341,6 +341,9 @@ static bool qemu_chr_is_busy(Chardev *s)
     if (CHARDEV_IS_MUX_FE(s)) {
         MuxFeChardev *d = MUX_FE_CHARDEV(s);
         return d->mux_bitset != 0;
+    } else if (CHARDEV_IS_MUX_BE(s)) {
+        MuxBeChardev *d = MUX_BE_CHARDEV(s);
+        return d->frontend != NULL;
     } else {
         return s->be != NULL;
     }
@@ -648,7 +651,8 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     ChardevBackend *backend = NULL;
     const char *name = qemu_opt_get(opts, "backend");
     const char *id = qemu_opts_id(opts);
-    char *bid = NULL;
+    const char *mux_be_id = NULL;
+    char *mux_fe_id = NULL;
 
     if (name && is_help_option(name)) {
         GString *str = g_string_new("");
@@ -676,10 +680,25 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     }
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
-        bid = g_strdup_printf("%s-base", id);
+        mux_fe_id = g_strdup_printf("%s-base", id);
+    }
+    mux_be_id = qemu_opt_get(opts, "mux-be-id");
+    if (mux_be_id && mux_fe_id) {
+        error_setg(errp, "chardev: mux and mux-be can't be used for the same "
+                   "device");
+        goto out;
+    } else if (mux_be_id) {
+        const ObjectClass *oc = &cc->parent_class;
+
+        if (oc == object_class_by_name(TYPE_CHARDEV_MUX_FE) ||
+            oc == object_class_by_name(TYPE_CHARDEV_MUX_BE)) {
+            /* Stacking is not supported due to possible dependency loops */
+            error_setg(errp, "chardev: multiplexers can't be stacked");
+            goto out;
+        }
     }
 
-    chr = qemu_chardev_new(bid ? bid : id,
+    chr = qemu_chardev_new(mux_fe_id ? mux_fe_id : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
                            backend, context, errp);
     if (chr == NULL) {
@@ -687,25 +703,40 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     }
 
     base = chr;
-    if (bid) {
+    if (mux_fe_id) {
         Chardev *mux;
         qapi_free_ChardevBackend(backend);
         backend = g_new0(ChardevBackend, 1);
         backend->type = CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data = g_new0(ChardevMux, 1);
-        backend->u.mux.data->chardev = g_strdup(bid);
+        backend->u.mux.data->chardev = g_strdup(mux_fe_id);
         mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX_FE, backend, context, errp);
         if (mux == NULL) {
-            object_unparent(OBJECT(chr));
-            chr = NULL;
-            goto out;
+            goto unparent_and_out;
         }
         chr = mux;
+    } else if (mux_be_id) {
+        Chardev *s;
+
+        s = qemu_chr_find(mux_be_id);
+        if (!s) {
+            error_setg(errp, "chardev: mux-be device can't be found by id '%s'",
+                       mux_be_id);
+            goto unparent_and_out;
+        }
+        if (!CHARDEV_IS_MUX_BE(s)) {
+            error_setg(errp, "chardev: device '%s' is not a multiplexer device"
+                       " of 'mux-be' type", mux_be_id);
+            goto unparent_and_out;
+        }
+        if (!mux_be_chr_attach_chardev(MUX_BE_CHARDEV(s), chr, errp)) {
+            goto unparent_and_out;
+        }
     }
 
 out:
     qapi_free_ChardevBackend(backend);
-    g_free(bid);
+    g_free(mux_fe_id);
 
     if (replay && base) {
         /* RR should be set on the base device, not the mux */
@@ -713,6 +744,11 @@ out:
     }
 
     return chr;
+
+unparent_and_out:
+    object_unparent(OBJECT(chr));
+    chr = NULL;
+    goto out;
 }
 
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
@@ -1114,7 +1150,7 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
         return NULL;
     }
 
-    if (CHARDEV_IS_MUX_FE(chr)) {
+    if (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr)) {
         error_setg(errp, "Mux device hotswap not supported yet");
         return NULL;
     }
@@ -1302,7 +1338,7 @@ static int chardev_options_parsed_cb(Object *child, void *opaque)
 {
     Chardev *chr = (Chardev *)child;
 
-    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
+    if (!chr->be_open && (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr))) {
         open_muxes(chr);
     }
 
@@ -1329,8 +1365,10 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 
     if (CHARDEV_IS_MUX_FE(chr)) {
         MuxFeChardev *d = MUX_FE_CHARDEV(chr);
-
         mux_fe_chr_send_all_event(d, event);
+    } else if (CHARDEV_IS_MUX_BE(chr)) {
+        MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+        mux_be_chr_send_all_event(d, event);
     }
 }
 
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 94c8d07ac235..8ea1258f8ff4 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -35,7 +35,9 @@
 
 struct MuxFeChardev {
     Chardev parent;
+    /* Linked frontends */
     CharBackend *backends[MAX_MUX];
+    /* Linked backend */
     CharBackend chr;
     unsigned long mux_bitset;
     int focus;
@@ -54,10 +56,36 @@ struct MuxFeChardev {
 };
 typedef struct MuxFeChardev MuxFeChardev;
 
+struct MuxBeChardev {
+    Chardev parent;
+    /* Linked frontend */
+    CharBackend *frontend;
+    /* Linked backends */
+    CharBackend backends[MAX_MUX];
+    /*
+     * Number of backends attached to this mux. Once attached, a
+     * backend can't be detached, so the counter is only increasing.
+     * To safely remove a backend, mux has to be removed first.
+     */
+    unsigned int be_cnt;
+    /*
+     * Counters of written bytes from a single frontend device
+     * to multiple backend devices.
+     */
+    unsigned int be_written[MAX_MUX];
+    unsigned int be_min_written;
+};
+typedef struct MuxBeChardev MuxBeChardev;
+
 DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
                          TYPE_CHARDEV_MUX_FE)
-#define CHARDEV_IS_MUX_FE(chr)                             \
+DECLARE_INSTANCE_CHECKER(MuxBeChardev, MUX_BE_CHARDEV,
+                         TYPE_CHARDEV_MUX_BE)
+
+#define CHARDEV_IS_MUX_FE(chr)                              \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)
+#define CHARDEV_IS_MUX_BE(chr)                              \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_BE)
 
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
@@ -67,6 +95,10 @@ void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event);
 bool mux_fe_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
                                 unsigned int *tag, Error **errp);
 bool mux_fe_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
+void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event);
+bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **errp);
+bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error **errp);
+void mux_be_chr_detach_frontend(MuxBeChardev *d);
 
 Object *get_chardevs_root(void);
 
diff --git a/chardev/meson.build b/chardev/meson.build
index 778444a00ca6..3a9f5565372b 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -3,6 +3,7 @@ chardev_ss.add(files(
   'char-file.c',
   'char-io.c',
   'char-mux-fe.c',
+  'char-mux-be.c',
   'char-null.c',
   'char-pipe.c',
   'char-ringbuf.c',
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 0bec974f9d73..c58c11c4eeaf 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 
 #define TYPE_CHARDEV_NULL "chardev-null"
 #define TYPE_CHARDEV_MUX_FE "chardev-mux"
+#define TYPE_CHARDEV_MUX_BE "chardev-mux-be"
 #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
 #define TYPE_CHARDEV_PTY "chardev-pty"
 #define TYPE_CHARDEV_CONSOLE "chardev-console"
diff --git a/qapi/char.json b/qapi/char.json
index fb0dedb24383..cdec8f9cf4e2 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -336,6 +336,17 @@
   'data': { 'chardev': 'str' },
   'base': 'ChardevCommon' }
 
+##
+# @ChardevMuxBe:
+#
+# Configuration info for mux-be chardevs.
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevMuxBe',
+  'data': { },
+  'base': 'ChardevCommon' }
+
 ##
 # @ChardevStdio:
 #
@@ -483,6 +494,8 @@
 #
 # @mux: (since 1.5)
 #
+# @mux-be: (since 9.2)
+#
 # @msmouse: emulated Microsoft serial mouse (since 1.5)
 #
 # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
@@ -525,6 +538,7 @@
             'pty',
             'null',
             'mux',
+            'mux-be',
             'msmouse',
             'wctablet',
             { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
@@ -599,6 +613,16 @@
 { 'struct': 'ChardevMuxWrapper',
   'data': { 'data': 'ChardevMux' } }
 
+##
+# @ChardevMuxBeWrapper:
+#
+# @data: Configuration info for mux-be chardevs
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevMuxBeWrapper',
+  'data': { 'data': 'ChardevMuxBe' } }
+
 ##
 # @ChardevStdioWrapper:
 #
@@ -707,6 +731,7 @@
             'pty': 'ChardevPtyWrapper',
             'null': 'ChardevCommonWrapper',
             'mux': 'ChardevMuxWrapper',
+            'mux-be': 'ChardevMuxBeWrapper',
             'msmouse': 'ChardevCommonWrapper',
             'wctablet': 'ChardevCommonWrapper',
             'braille': { 'type': 'ChardevCommonWrapper',
-- 
2.34.1


