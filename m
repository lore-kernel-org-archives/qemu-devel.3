Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068AFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPqV-000562-BN; Mon, 18 Mar 2024 23:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqT-00055b-Mn
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:08:57 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqR-0007Y1-Vy
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:08:57 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c390030af2so616855b6e.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710817735; x=1711422535;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+9JJHiJKPYQ910oe663PRFvMAxXiI7j+0dOR4wlpAGM=;
 b=jzxCDKuuRKQRSz1Em0GwEe9XOdG6MWFi1KgmFeebI4Xmrl/jc2yyhnxqjkvuYpyUyW
 hYy5JYNpdkO3u7K/wEL6av2Pay7bYaHgjy+/bo/ad+4Vbh7dM8tawcAnvtcXYdBPuwlk
 8FZ4+Z3NOmZDluYHD/kj1d8Wiboe8rDYnWwVuX5P/kLYSmiMGT+9fD8GCYm5Qani9eM6
 PtcAIBPmgf5WoyWPTN4QXhW2957xp5x6hZEkmlX6SiIepXO62WIyXKk4kjYpS+7dr3Ab
 ZB+B9kWLGRrYWH1JCWgMSD8QXYrfd1qoX9yvJy7sdsYta4frsAC6cHR49pNHuu3ECqvd
 OCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710817735; x=1711422535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9JJHiJKPYQ910oe663PRFvMAxXiI7j+0dOR4wlpAGM=;
 b=euN7Qbuy5PTwgXy+3hliqTVm3snl8rPeZR2L9NrilVrSQ2wAim40OYWajujds3TlSM
 QRnQ5oPuPYwbEQS80SzOIOBHTzNArEVSLz8wsrv62c+FXlNwb2qZ/77wak6JYWKTSSPm
 UCQ9NTjiTg3JqvQJR8ypWEnoUxT7qJzukyQFVPkCmCwlYBYjSEqxeltj63QDxKUZx5ru
 KMUGk1mIvbpDFT+5/88Slf3LXNav1Zg2HqzgQl0yIUa59KyOTYDNL+s1A1i+gOHhGb5u
 suKJ4jPy2dSY29Ap86kzW8B77Gjr4skN5Jpv8VKHIzlJRrLxNWmbZ7hMoYrtVyf0y+TZ
 zCGA==
X-Gm-Message-State: AOJu0YwjOyvFmfk8hLqp15drUobj2kj0T3y10DCP7QOEfRhlDadMorkj
 AZ0f2FlEUpCqOBBpoUFhjIR8YQOYaY6Jx96MzSXgYS8M78rqEmSvrOBZ5kxCwb+OOV3+DCvh9Np
 E
X-Google-Smtp-Source: AGHT+IFDuqREv7hNGTgJNZKKYROO29r/dWm7qnNqI0TvcHDkAbsqTagyf7zVP5Jc4anijRfzHB5RjQ==
X-Received: by 2002:a05:6808:190a:b0:3c2:5d2f:ef1e with SMTP id
 bf10-20020a056808190a00b003c25d2fef1emr2121764oib.31.1710817734837; 
 Mon, 18 Mar 2024 20:08:54 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 x1-20020a631701000000b005e83b64021fsm4440611pgl.25.2024.03.18.20.08.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 20:08:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 19 Mar 2024 12:08:40 +0900
Subject: [PATCH v2 2/4] ui/vnc: Do not use console_select()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-console-v2-2-3fd6feef321a@daynix.com>
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
In-Reply-To: <20240319-console-v2-0-3fd6feef321a@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
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

console_select() is shared by other displays and a console_select() call
from one of them triggers console switching also in ui/curses,
circumventing key state reinitialization that needs to be performed in
preparation and resulting in stuck keys.

Use its internal state to track the current active console to prevent
such a surprise console switch.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/ui/console.h   |  1 +
 include/ui/kbd-state.h | 11 +++++++++++
 ui/console.c           | 12 ++++++++++++
 ui/kbd-state.c         |  6 ++++++
 ui/vnc.c               | 14 +++++++++-----
 5 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc640c..3729d2db29c7 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -413,6 +413,7 @@ void qemu_console_early_init(void);
 
 void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *ctx);
 
+QemuConsole *qemu_console_lookup_default(void);
 QemuConsole *qemu_console_lookup_by_index(unsigned int index);
 QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index fb79776128cf..1f37b932eb62 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -99,4 +99,15 @@ bool qkbd_state_modifier_get(QKbdState *kbd, QKbdModifier mod);
  */
 void qkbd_state_lift_all_keys(QKbdState *kbd);
 
+/**
+ * qkbd_state_switch_console: Switch console.
+ *
+ * This sends key up events to the previous console for all keys which are in
+ * down state to prevent keys being stuck, and remembers the new console.
+ *
+ * @kbd: state tracker state.
+ * @con: new QemuConsole for this state tracker.
+ */
+void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con);
+
 #endif /* QEMU_UI_KBD_STATE_H */
diff --git a/ui/console.c b/ui/console.c
index 832055675c50..fbc1b9b8b57c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1325,6 +1325,18 @@ void graphic_console_close(QemuConsole *con)
     dpy_gfx_replace_surface(con, surface);
 }
 
+QemuConsole *qemu_console_lookup_default(void)
+{
+    QemuConsole *con;
+
+    QTAILQ_FOREACH(con, &consoles, next) {
+        if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
+            return con;
+        }
+    }
+    return QTAILQ_FIRST(&consoles);
+}
+
 QemuConsole *qemu_console_lookup_by_index(unsigned int index)
 {
     QemuConsole *con;
diff --git a/ui/kbd-state.c b/ui/kbd-state.c
index 62d42a7a22e1..52ed28b8a89b 100644
--- a/ui/kbd-state.c
+++ b/ui/kbd-state.c
@@ -117,6 +117,12 @@ void qkbd_state_lift_all_keys(QKbdState *kbd)
     }
 }
 
+void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con)
+{
+    qkbd_state_lift_all_keys(kbd);
+    kbd->con = con;
+}
+
 void qkbd_state_set_delay(QKbdState *kbd, int delay_ms)
 {
     kbd->key_delay_ms = delay_ms;
diff --git a/ui/vnc.c b/ui/vnc.c
index fc12b343e254..b3fd78022b19 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1872,12 +1872,16 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
     /* QEMU console switch */
     switch (qcode) {
     case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
-        if (vs->vd->dcl.con == NULL && down &&
+        if (down &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL) &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
-            /* Reset the modifiers sent to the current console */
-            qkbd_state_lift_all_keys(vs->vd->kbd);
-            console_select(qcode - Q_KEY_CODE_1);
+            QemuConsole *con = qemu_console_lookup_by_index(qcode - Q_KEY_CODE_1);
+            if (con) {
+                unregister_displaychangelistener(&vs->vd->dcl);
+                qkbd_state_switch_console(vs->vd->kbd, con);
+                vs->vd->dcl.con = con;
+                register_displaychangelistener(&vs->vd->dcl);
+            }
             return;
         }
     default:
@@ -4206,7 +4210,7 @@ void vnc_display_open(const char *id, Error **errp)
             goto fail;
         }
     } else {
-        con = NULL;
+        con = qemu_console_lookup_default();
     }
 
     if (con != vd->dcl.con) {

-- 
2.44.0


