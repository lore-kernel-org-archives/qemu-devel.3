Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D71C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7so-00069s-5H; Mon, 18 Mar 2024 03:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sa-00064d-Ra
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:57:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sZ-0000l4-5P
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:57:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6f69e850bso2893755b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748674; x=1711353474;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hERtPiZgCeqACgFTci0jEGy9KY185zaVUTdb0UYq/LI=;
 b=wgcqECFGkvn1X+SakINuKJKrVeNKvYvuSCXCb85HfqYdAp8skajr2dqvouWSVn0LZh
 TpdEb/hAN4F8Asx7Y8KhknH7Bk53ICwm7ukBNx6qdYYOgsFj/Yfle9mVKfeVjj0BQoXw
 9Nb7B39dK7LzTXdiVDOYEzGGFzv6L92aj2Z4Pb3e59N5LprqAexHXW+WAk1kFGwP0Lv3
 vXQmJMCwG+r99EDimf9Dtq1jz3mX6IZ/lUFre7OaKbQBiNhJX36Qr7m2GgPls+3p9zYK
 QYuaKq5Fnr8JDnhWqkyofPavI1ZveSSxGZIkdVoQnCxwrqhkXKPFF0dqP4UAqZKFUu/N
 hwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748674; x=1711353474;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hERtPiZgCeqACgFTci0jEGy9KY185zaVUTdb0UYq/LI=;
 b=wJ51TsD2F5IJZ/1FPt8QMPTFV2TOffdOJTbda6xrJ3VrAxCvemZaSXlylXlM7NLYwT
 nB1eSzCO7zBQS93b2+7G3s0C8G1yp1fp3yCmHlInq+Gr3pKAazZfqVjzZkOwBMupvnVt
 Xs7Qg4dBtr08l2dmEnM0Da7pJyOlvhifFMyNKGeX1P5Tn3VEsRjDRVNv5zGwZRk20H7T
 mh1j5nvr8CD4SGu6Rk0dyF4N8GaBZMlLNTC/8tWb1eZ0t8BTDvCcpUMYoGyoOpB9B7kC
 /4IfRLb+HaBMDM1yn4ZADmeINHhKQ9F9hLSzSeoJ+92uzcuwYSWZOuywx1Fweu2rQ9LN
 lx7w==
X-Gm-Message-State: AOJu0Yyu8Bak9tmQKw2jBlTGjsZpvTphOnAeSlp7nWSm22MVjwSEwoRq
 8FSa6hkbsIpRdAOe3i8YnL7UcjHJfAIkmu3od1hLAVuqXcKI1zP4a33yKTjzo7k=
X-Google-Smtp-Source: AGHT+IE2+CRh8fZhFysClsHWHIDlF9xzJxTRNb3mcjStZAHPSzrQm0kIH7bk2o0M459oS2rKvM84Qw==
X-Received: by 2002:a05:6a00:816:b0:6e7:2018:aabd with SMTP id
 m22-20020a056a00081600b006e72018aabdmr4532133pfk.8.1710748673691; 
 Mon, 18 Mar 2024 00:57:53 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 u15-20020a63df0f000000b005dbed0ffb10sm6573214pgg.83.2024.03.18.00.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:57:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:57:43 +0900
Subject: [PATCH 2/4] ui/vnc: Do not use console_select()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-console-v1-2-f4efbfa71253@daynix.com>
References: <20240318-console-v1-0-f4efbfa71253@daynix.com>
In-Reply-To: <20240318-console-v1-0-f4efbfa71253@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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
index a4a49ffc640c..a703f7466499 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -413,6 +413,7 @@ void qemu_console_early_init(void);
 
 void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *ctx);
 
+QemuConsole *qemu_console_lookup_first_graphic_console(void);
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
index 832055675c50..6bf02a23414c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1325,6 +1325,18 @@ void graphic_console_close(QemuConsole *con)
     dpy_gfx_replace_surface(con, surface);
 }
 
+QemuConsole *qemu_console_lookup_first_graphic_console(void)
+{
+    QemuConsole *con;
+
+    QTAILQ_FOREACH(con, &consoles, next) {
+        if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
+            return con;
+        }
+    }
+    return NULL;
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
index fc12b343e254..94564b196ba8 100644
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
+        con = qemu_console_lookup_first_graphic_console();
     }
 
     if (con != vd->dcl.con) {

-- 
2.44.0


