Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFB9C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9sa-0001FZ-Sj; Mon, 18 Mar 2024 06:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sS-0001F4-Ko
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:05:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sQ-000610-St
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:05:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4140aadfe2eso9370225e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756351; x=1711361151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYjr201DlEJ4l0jHNZURE4npfEFxYjcehCBVscFCuRE=;
 b=wED3Wv2Fg9AZfwtxDpYxlZSx5DRIp75AHQxbYjEkPKDCfEeNXfConYrbtOcQbfOW0w
 g0GYBZZe39zE9q2pvf9Z1bYzFZOhcZl715y+4ONbgobnmnBGs2Noa97RXIlvVn0omz7s
 2pg4kxDRnjhkOVA119JmSZfSEREHeiZHN2P7QHw+w70/Sdup3F5M/N+z9doi85yEFG7X
 FeoZJqJ+/CZ3eKQjQ4nwR382dFWaw7YW9pVq+vPmi72JbvIHyqh8fM+yVPdb8XzBQk5h
 Ukw+O+ByrFIJ6eYxhoC4nFpEdgDBeK5YaAOY0yStgm4GfvKBVNsZJb47AGNz4xCJwF+n
 FV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756351; x=1711361151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYjr201DlEJ4l0jHNZURE4npfEFxYjcehCBVscFCuRE=;
 b=ML9pLUeQHrd85/Rm3LGHBbQoTioPLthqcMySXSJGdCy+w+3V9HiuqDsp/lZVguTfFK
 RIRIzr4K4E81HO8Bg7AUxJ0xnXMa6NY9E3X7duyXH7/NYbfOEWjcuQ782nItoNS++abi
 B/plRT1ypWML0fRe30VozYEbao0o4cAoTHiT9nNp1XIRXVSy6xpD8GaJ5z0Fl4TEc5CN
 ys0vWtB92QApMczMU0nTkcLV4PlcBVlUyENrUxyG3LTB7P8we12aPUiGdVZRr9XOJYeq
 VK7D/xIWgqXtRRB2cnVNQzH2QxPjOcp9t26KTTN4vPWiTYq774zsYHxc2TEucZ7j5lmJ
 NH3g==
X-Gm-Message-State: AOJu0YyoWKygSZ/gAxAjvzNGHK3ocYttpyMxNClr0ixfzNnkyPHArsic
 e2jtA+6qEb6cbzwBno2pJb3DSLf0agy2jWMqz5DjpLfJ1gGO/qJC1AowVeERs8y2oY4fWz7AF6B
 BRzA=
X-Google-Smtp-Source: AGHT+IFtyiiDnkj1FgS7yzKffl96QJpzZsBKwPZzeLa/dJfHDKJk3lOs19OMYEwg+u2OLHoR45DjVQ==
X-Received: by 2002:a05:600c:198a:b0:414:860:bdc5 with SMTP id
 t10-20020a05600c198a00b004140860bdc5mr3998787wmq.17.1710756351440; 
 Mon, 18 Mar 2024 03:05:51 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 hg12-20020a05600c538c00b004140f81e513sm3398470wmb.37.2024.03.18.03.05.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 03:05:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 1/3] ui/console: Introduce API to change console
 orientation
Date: Mon, 18 Mar 2024 11:05:40 +0100
Message-ID: <20240318100543.78846-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240318100543.78846-1-philmd@linaro.org>
References: <20240318100543.78846-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Extract the following methods:

  - qemu_console_set_rotate()
  - qemu_console_is_rotated()
  - qemu_console_get_rotate_arcdegree()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/console.h |  3 +++
 ui/console.c         | 16 ++++++++++++++++
 ui/input.c           |  9 ++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc64..86ba36e391 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -422,15 +422,18 @@ bool qemu_console_is_visible(QemuConsole *con);
 bool qemu_console_is_graphic(QemuConsole *con);
 bool qemu_console_is_fixedsize(QemuConsole *con);
 bool qemu_console_is_gl_blocked(QemuConsole *con);
+bool qemu_console_is_rotated(QemuConsole *con);
 char *qemu_console_get_label(QemuConsole *con);
 int qemu_console_get_index(QemuConsole *con);
 uint32_t qemu_console_get_head(QemuConsole *con);
 int qemu_console_get_width(QemuConsole *con, int fallback);
 int qemu_console_get_height(QemuConsole *con, int fallback);
+unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con);
 /* Return the low-level window id for the console */
 int qemu_console_get_window_id(QemuConsole *con);
 /* Set the low-level window id for the console */
 void qemu_console_set_window_id(QemuConsole *con, int window_id);
+void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree);
 
 void console_select(unsigned int index);
 void qemu_console_resize(QemuConsole *con, int width, int height);
diff --git a/ui/console.c b/ui/console.c
index 832055675c..84aee76846 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -37,6 +37,7 @@
 #include "trace.h"
 #include "exec/memory.h"
 #include "qom/object.h"
+#include "sysemu/sysemu.h"
 
 #include "console-priv.h"
 
@@ -207,6 +208,21 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id)
     con->window_id = window_id;
 }
 
+void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree)
+{
+    graphic_rotate = arcdegree;
+}
+
+bool qemu_console_is_rotated(QemuConsole *con)
+{
+    return graphic_rotate != 0;
+}
+
+unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con)
+{
+    return graphic_rotate;
+}
+
 void graphic_hw_invalidate(QemuConsole *con)
 {
     if (!con) {
diff --git a/ui/input.c b/ui/input.c
index dc745860f4..951806bf05 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "trace.h"
@@ -179,10 +178,10 @@ static int qemu_input_transform_invert_abs_value(int value)
   return (int64_t)INPUT_EVENT_ABS_MAX - value + INPUT_EVENT_ABS_MIN;
 }
 
-static void qemu_input_transform_abs_rotate(InputEvent *evt)
+static void qemu_input_transform_abs_rotate(QemuConsole *src, InputEvent *evt)
 {
     InputMoveEvent *move = evt->u.abs.data;
-    switch (graphic_rotate) {
+    switch (qemu_console_get_rotate_arcdegree(src)) {
     case 90:
         if (move->axis == INPUT_AXIS_X) {
             move->axis = INPUT_AXIS_Y;
@@ -341,8 +340,8 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt)
     qemu_input_event_trace(src, evt);
 
     /* pre processing */
-    if (graphic_rotate && (evt->type == INPUT_EVENT_KIND_ABS)) {
-            qemu_input_transform_abs_rotate(evt);
+    if (qemu_console_is_rotated(src) && (evt->type == INPUT_EVENT_KIND_ABS)) {
+        qemu_input_transform_abs_rotate(src, evt);
     }
 
     /* send event */
-- 
2.41.0


