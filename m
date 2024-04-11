Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A8FCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurV2-0006Mp-Dj; Thu, 11 Apr 2024 06:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUV-0005Ww-Cm
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:17:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUS-0007ct-Eq
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:17:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33edbc5932bso5751574f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830625; x=1713435425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpfjBls1Q1Prp7MdrT8xYPE9RcXt49p2EGfNxpQiHmA=;
 b=SBMP4xtG9G3waBZ60GaxVAKGy0nKpYbbPDfPoyAF/cFANqvvgpAhX1aqMzUYhqtKEU
 moz9KaKHyFm0FzqC/eInvu3pG8zDKdGyDs1NsUw0UzT5cTcAmcRoAVC1cQHYW+RqOR65
 OVE9YtFblhh6CXzHdcjxCXMKAVfv6Dk4h0ucb65NFKxcg9W3irjppCOkeL1wp7nAptMD
 irXqp8DNH2ly1P/iTPBGH6LYyxENGeB/5hNCuL0/JNUBPiwtfy9RWDVuG50f7lsDRtp2
 xcxtFX1ipgrQdNfIDeNw3pyVlMYGDesTBP9MvW6ZIALVL/OoyMXlH1b7F+uCvdPlJa1V
 d14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830625; x=1713435425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpfjBls1Q1Prp7MdrT8xYPE9RcXt49p2EGfNxpQiHmA=;
 b=aw6Vv9A83+S+HJ8fBvb2+bA/Kc66oUo+RzaI4xIDVAMk9HjlMeFtfcXgma6J7aG/5W
 4yiiYUKfuZ6UV/PwcgiPUm6NEv3igDZqaX8UAo1ryEsTVFjPmmPY4mnwTarsgfU3dzbg
 IVtxYubiKTqLb9gDGwS5qERxUuCebhZiBs2+H6+Vgr4M+HgON9Akmmg+gYrhqLKPpNUx
 2GCw9kYwqnbvViKiEshA2JgczABI4JNWbsTNHEHvvV7BrJw6twEQEbTzUfyxL2SJePGg
 W5I9LNnxUdZtVAQcvNvEjPgRVOw9Wn3H4RML70YPUw1o1dlnbe2siEsOBUJhBA2fVxMj
 5uQA==
X-Gm-Message-State: AOJu0YyebH5xCaYd+JGq1cXvoh7w3UayyhSEuiB+2DYdasvd3u0ra840
 E8qJfN0Jj30p7okEQzTnIQoNgo1W4iD1vznpZQkO6k4n66+hMF1D4Uv4vtGQZHwY/McNRgZsqJh
 I6ag=
X-Google-Smtp-Source: AGHT+IEntjiaNu1j5vQGnBg5Wqtn10f6Ce3FmtivnI9SPVHaPMgYxtouAtrJe3Ygzo/xvbFrNN+duQ==
X-Received: by 2002:a5d:4385:0:b0:33e:d448:e48c with SMTP id
 i5-20020a5d4385000000b0033ed448e48cmr3184277wrq.15.1712830625598; 
 Thu, 11 Apr 2024 03:17:05 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adfe482000000b00343bd6716b3sm1406416wrm.99.2024.04.11.03.17.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:17:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/13] hw/dma/pl330: Use qemu_hexdump_line() to avoid
 sprintf()
Date: Thu, 11 Apr 2024 12:15:48 +0200
Message-ID: <20240411101550.99392-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Use qemu_hexdump_line() to avoid sprintf() calls, silencing:

  [5/8] Compiling C object libcommon.fa.p/hw_dma_pl330.c.o
  hw/dma/pl330.c:333:13: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
            sprintf(tmpbuf + strlen(tmpbuf), " %02x", buf[b + i]);
            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/dma/pl330.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 70a502d245..0435378b7e 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -317,21 +318,14 @@ typedef struct PL330InsnDesc {
 
 static void pl330_hexdump(uint8_t *buf, size_t size)
 {
-    unsigned int b, i, len;
-    char tmpbuf[80];
+    unsigned int b, len;
 
     for (b = 0; b < size; b += 16) {
         len = size - b;
         if (len > 16) {
             len = 16;
         }
-        tmpbuf[0] = '\0';
-        for (i = 0; i < len; i++) {
-            if ((i % 4) == 0) {
-                strcat(tmpbuf, " ");
-            }
-            sprintf(tmpbuf + strlen(tmpbuf), " %02x", buf[b + i]);
-        }
+        g_autofree char *tmpbuf = qemu_hexdump_line(buf, b, len, false);
         trace_pl330_hexdump(b, tmpbuf);
     }
 }
-- 
2.41.0


