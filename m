Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8340C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBDs-0008GH-92; Mon, 18 Mar 2024 07:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDp-0008F4-Ae
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:32:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDm-000783-LD
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:32:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4140eb3aeb9so7320575e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710761520; x=1711366320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awIh3lBTG+gHE0lcYbdt4h6RpA3aL2oraGQ+LIq+QwM=;
 b=t6abnBkU2XUWkGK6POZGY+MO2BQ8GqPy+hx7OVZfjAC0kQNJCFXLmqz0nlhL//8otC
 XVzdFxDO50LZCyHfZLeOXwTwz3NcBfHLhK5KtsxxjmjmPX2z4miJyYcCfFzqx8sKhawy
 V5gduQN5/+FpaMjB1qAVBUEpYKb9D2/c/q0su/C3GQOIPNIvGICUBd5bif8Uffy69w3u
 N1PNxlch6v8Ns0kgr6Ih7PWther1bQdc5VToG7piQ1V4uWgA2WYJwtz9KCk/ENObCjso
 D/QPNf6kDFaMKMp2CcNPxBL0+FuHVcOHlltrtpMnk691vWALI67vl3vhxVbEUF+swwk4
 g95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710761520; x=1711366320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awIh3lBTG+gHE0lcYbdt4h6RpA3aL2oraGQ+LIq+QwM=;
 b=q9prbPnbNR14SBnB09v8pEAd0Hf/tKUemVuQiUcOVJWLeHiB4JxxlU/sleKpCyf3lH
 fG5OZNGo5TEcYqFe8Ib7oXyT1k2hppkTrWcUSCLEwzZXayZ4iEtgamIrNry5zORazlR1
 sf6CjeCreUdZW8s24MJiBJ3h6n+avILWi7x/Q5/AaeoAMN27jvr7XOzQZxd0QZDaBfRw
 xL7DUzglediPbtP1ICxQXl2Q8BX79txcbs5SRW+O+xGCtw9Xd65Zvc4QqLRW+PQD+R+u
 cdRTb2KjuCourycGkmxvnT+NBp8FV6StO4LwWSGcxMFR7Z5TDr0vjADn+YyHPkSdkuuW
 Vypw==
X-Gm-Message-State: AOJu0YzH8zM8GS4/rxVP24q+Wz/ML+kQydbbRMvN59le9/PMA4zx6NQp
 7Lpa1q3IHxqNG2M2ninn6fF4DNZA2Q6oqXSPFWx4z9LKGWHVQGwQLGn7/qO9R2xnkmOM4TA661X
 3
X-Google-Smtp-Source: AGHT+IFBv/J5i4OUDpYrV9YnY22ZnLpSkvv5jZxo8t6ebFFJX+TXkbUcPArGKgCh7aMLaxZtd4uUJw==
X-Received: by 2002:a05:6000:18ce:b0:341:715e:36d6 with SMTP id
 w14-20020a05600018ce00b00341715e36d6mr2144217wrq.34.1710761520731; 
 Mon, 18 Mar 2024 04:32:00 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 y10-20020a5d4aca000000b0033e03d37685sm9617334wrs.55.2024.03.18.04.31.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 04:32:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 3/3] ui/console: Add 'rotate_arcdegree' field to
 allow per-console rotation
Date: Mon, 18 Mar 2024 12:31:40 +0100
Message-ID: <20240318113140.88151-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240318113140.88151-1-philmd@linaro.org>
References: <20240318113140.88151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Add the 'rotate_arcdegree' field to QemuGraphicConsole and
remove the use of the 'graphic_rotate' global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/console.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 84aee76846..94624c37ae 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -37,7 +37,6 @@
 #include "trace.h"
 #include "exec/memory.h"
 #include "qom/object.h"
-#include "sysemu/sysemu.h"
 
 #include "console-priv.h"
 
@@ -51,6 +50,8 @@ typedef struct QemuGraphicConsole {
 
     QEMUCursor *cursor;
     int cursor_x, cursor_y, cursor_on;
+
+    unsigned rotate_arcdegree;
 } QemuGraphicConsole;
 
 typedef QemuConsoleClass QemuGraphicConsoleClass;
@@ -210,17 +211,23 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id)
 
 void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree)
 {
-    graphic_rotate = arcdegree;
+    QemuGraphicConsole *gc = QEMU_GRAPHIC_CONSOLE(con);
+
+    gc->rotate_arcdegree = arcdegree;
 }
 
 bool qemu_console_is_rotated(QemuConsole *con)
 {
-    return graphic_rotate != 0;
+    QemuGraphicConsole *gc = QEMU_GRAPHIC_CONSOLE(con);
+
+    return gc->rotate_arcdegree != 0;
 }
 
 unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con)
 {
-    return graphic_rotate;
+    QemuGraphicConsole *gc = QEMU_GRAPHIC_CONSOLE(con);
+
+    return gc->rotate_arcdegree;
 }
 
 void graphic_hw_invalidate(QemuConsole *con)
-- 
2.41.0


