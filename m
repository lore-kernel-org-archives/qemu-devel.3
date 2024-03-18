Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B7FC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBDe-00086b-Gi; Mon, 18 Mar 2024 07:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDc-000865-SG
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDb-00073e-61
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso2125108f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710761509; x=1711366309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYjr201DlEJ4l0jHNZURE4npfEFxYjcehCBVscFCuRE=;
 b=JqpNx0VCRlsxEdNDVGEWoRghM25n95vy7Q03+PhyY2LFAFSNm6x3Zppkv++hRQ4B/X
 BkcI6OrsbWsY3XMyt1uP9f82UK0PMTC8fm6k080K8qo8kTaXIUc+AaKw/29xzgt4U5df
 LMeLQnpwUVG15ts0sgCZVv8IbtOouX9lizCbJRj9QUHllQjmzPuBtGXxULIIGevPbxA8
 AYPlB3BwucCLn33QR45C6uBXMCLxCxFBBKeYep1NFC4mmecy853gSUdA3nDqwSOPIeHV
 sI2lg/XB4KDxr9vF9s12e3WxP8xYYKTPcijmLhMAPT+VCa8RZNiO3XraKbS7pzTBRGnm
 mQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710761509; x=1711366309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYjr201DlEJ4l0jHNZURE4npfEFxYjcehCBVscFCuRE=;
 b=OhZgMF18T6uOqbAgEy7QHpfR0IxSJb8Re6lGv+BdwOA+gD9StZBFsUCNql76KFs2/L
 zmdUhR11/tQ2BIy1bzJgqbqLB5V2rYiVX9BkdGZ44NJlRNXqaFt00qydBJYTTtp5MzO8
 YJJWCIW8Kd+XEXfflObqi/xNy+N8kphUeKZ5F2LAELyPdpAbLY7DqVOoePXfQpV4Us5Y
 AkVJbI8Wm/wmSnHxqOXuoa79DYXdvrn2v/OipoeOTN08xcd2Wnvq/XVM0VXOWiVK7YVe
 CWhtNg9pppDOGnsC3puVSZppNJfW0z//80O2twudTXTNrEqJi05TZbwcEGZnH18mwwcS
 7ACA==
X-Gm-Message-State: AOJu0Yx2Y00qpv+V3SPZYKq44tHOPc5tRY+LDTGN5C7xaGXoXUWvG94i
 n0OZKoU+McsrvlIorPoH1v/gBIKtyFEKghPpGzoBJFZc8RA7k4KX/crmH+0TeC4wLUs9dmP3hJ5
 k
X-Google-Smtp-Source: AGHT+IG/2EVJ24DevrMPRBFPRiSgSpHflZeAlmL5yV5SZ1Aic73791HSZjxNeVl5k+ywBGIxfjwvOw==
X-Received: by 2002:adf:ca88:0:b0:33e:6495:3273 with SMTP id
 r8-20020adfca88000000b0033e64953273mr8314765wrh.4.1710761509290; 
 Mon, 18 Mar 2024 04:31:49 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 bq24-20020a5d5a18000000b0033ed8643638sm6202549wrb.106.2024.03.18.04.31.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 04:31:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 1/3] ui/console: Introduce API to change console
 orientation
Date: Mon, 18 Mar 2024 12:31:38 +0100
Message-ID: <20240318113140.88151-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240318113140.88151-1-philmd@linaro.org>
References: <20240318113140.88151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


