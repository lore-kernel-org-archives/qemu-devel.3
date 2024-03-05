Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8343C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdB-0007kH-4X; Tue, 05 Mar 2024 06:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSd9-0007k6-Bn
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:43 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhScw-0002lB-UP
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:42 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-564fc495d83so6730550a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636789; x=1710241589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02rqTQfgg62x0uwtLxpx8swa4lkknBArB8S0AINXbvk=;
 b=z5nt9f6H7e4+3kxVwsga5xb4au3vc/KW++bq7Z/v2e65idihxAdgpTRNvqhUuJWVGi
 YeaqBzJPJAn5sR6mwEwaJ6+oQqJobmy4Xm/ZxcJT9K/Fr3d6G3LgHtdZdu/wl9iCp+Z8
 MRF3B+itsHQBNGJ0JhbpXXadsWXVMwD741quMjd0cXhyCMTvO6bn0wuTxe1IgWiigynR
 vE/Xr7cmy3429P++LuMWnTFzRYdmyKJiRd6vLIlhweKqClA2lZsVQ4mg1+VUn3nq0QOy
 PnlDlvDEcqGHr3jSva1TlaWMKw8GZXPFPTaZ42jIX6TzQZR19YcJp6cKD84sAYm8nbKC
 kS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636789; x=1710241589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02rqTQfgg62x0uwtLxpx8swa4lkknBArB8S0AINXbvk=;
 b=PliUPwQQDt/fTvQ3i5j0y8Qh7ZXT1XlIesekOYCtAuzUbjxyxiPHuJd+BRnkOPcqA4
 hGxq/OIc0EtVFtOdDClzL28Dqej0znrTiRFx6HcK/TxDHQBo/lJTeCKS+RrG0AljETAS
 Qb3asxc3gxFsuel6je3Dlyuo+B3oQazEZOqYQAcd6rD1iCxsIp1f7l8+wcgmBfWYexw0
 0OlsrojBETLYrDUhVs3kgbjUPZtB8odqprq29qXKD3ZEiY+2Lfm75GF/zWfpwlABtR4U
 eiDWDvClWLX9LEQV95ABz8MAPWEbdTVoeUIrnTosm66rVBwhtnqHk0/6uRa3pzCsdy/+
 LXww==
X-Gm-Message-State: AOJu0YzSnKGT4OU1mngextz3mM5QVZfBGK1DDB5vIy1M9LNgE3I1DGfW
 G3qGf8Dqu/Ivuws/VYgVbOSvCaVlO9iwPPr+oQrTC9VKzNag5o2uXwIEvETv3giwHM4jbP5b0DP
 y
X-Google-Smtp-Source: AGHT+IEwESAAJzjJ77Bqcb1x8dNjIQPMTtINJ2yCrAqzeOKtsRxrtuXOJ4qovEmK+KsIU0K5UvWWzQ==
X-Received: by 2002:a17:906:409a:b0:a45:68b5:78fd with SMTP id
 u26-20020a170906409a00b00a4568b578fdmr3132860ejj.5.1709636788755; 
 Tue, 05 Mar 2024 03:06:28 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a170906698800b00a43e8e76825sm5993981ejr.149.2024.03.05.03.06.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 03/12] ui/cocoa: Split [-QemuCocoaView handleEventLocked:]
Date: Tue,  5 Mar 2024 12:05:58 +0100
Message-ID: <20240305110608.21618-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Currently [-QemuCocoaView handleEventLocked:] parses the passed event,
stores operations to be done to variables, and perform them according
to the variables. This construct will be cluttered with variables and
hard to read when we need more different operations for different
events.

Split the methods so that we can call appropriate methods depending on
events instead of relying on variables.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-1-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 86 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 5618d294c4..aecd60df2a 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1102,45 +1102,61 @@ - (bool) handleEventLocked:(NSEvent *)event
     }
 
     if (mouse_event) {
-        /* Don't send button events to the guest unless we've got a
-         * mouse grab or window focus. If we have neither then this event
-         * is the user clicking on the background window to activate and
-         * bring us to the front, which will be done by the sendEvent
-         * call below. We definitely don't want to pass that click through
-         * to the guest.
-         */
-        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
-            (last_buttons != buttons)) {
-            static uint32_t bmap[INPUT_BUTTON__MAX] = {
-                [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
-                [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
-                [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
-            };
-            qemu_input_update_buttons(dcl.con, bmap, last_buttons, buttons);
-            last_buttons = buttons;
-        }
-        if (isMouseGrabbed) {
-            if (isAbsoluteEnabled) {
-                /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
-                 * The check on screenContainsPoint is to avoid sending out of range values for
-                 * clicks in the titlebar.
-                 */
-                if ([self screenContainsPoint:p]) {
-                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
-                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
-                }
-            } else {
-                qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
-                qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
-            }
-        } else {
-            return false;
-        }
-        qemu_input_event_sync();
+        return [self handleMouseEvent:event buttons:buttons];
     }
     return true;
 }
 
+- (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons
+{
+    /* Don't send button events to the guest unless we've got a
+     * mouse grab or window focus. If we have neither then this event
+     * is the user clicking on the background window to activate and
+     * bring us to the front, which will be done by the sendEvent
+     * call below. We definitely don't want to pass that click through
+     * to the guest.
+     */
+    if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
+        (last_buttons != buttons)) {
+        static uint32_t bmap[INPUT_BUTTON__MAX] = {
+            [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
+            [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
+            [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
+        };
+        qemu_input_update_buttons(dcl.con, bmap, last_buttons, buttons);
+        last_buttons = buttons;
+    }
+
+    return [self handleMouseEvent:event];
+}
+
+- (bool) handleMouseEvent:(NSEvent *)event
+{
+    if (!isMouseGrabbed) {
+        return false;
+    }
+
+    if (isAbsoluteEnabled) {
+        NSPoint p = [self screenLocationOfEvent:event];
+
+        /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
+         * The check on screenContainsPoint is to avoid sending out of range values for
+         * clicks in the titlebar.
+         */
+        if ([self screenContainsPoint:p]) {
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
+        }
+    } else {
+        qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
+        qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
+    }
+
+    qemu_input_event_sync();
+
+    return true;
+}
+
 - (void) grabMouse
 {
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
-- 
2.41.0


