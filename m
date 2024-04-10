Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504FCCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaUY-0001dq-Hb; Wed, 10 Apr 2024 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTx-0000d2-On
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:31 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTs-0002m3-DY
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e2e09fc27so10177013a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765243; x=1713370043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpfjBls1Q1Prp7MdrT8xYPE9RcXt49p2EGfNxpQiHmA=;
 b=N3xqMDZa86/KP5ggtImz01ldF4iYqq1O/1aPDpU/g5ACAmFPzq5uiSis1u2+9L/bkm
 qGEBLC9m/hnwCawX2VvXnEhXg9CIINrlGhxPB+5VUtmztX4lWGe5fD9hkakefQC5f598
 jyAbg/MgNU/wXok1Ea1HVbFO60yPwJR2hOeMfI9tsD268EY6k3uyI0clXS42Ff/NJLYZ
 aa2btk2SvXbTBu+Eee9KA0EcyYBKIibfdCum/bVmVz1T95d6SaBKw5QvWwtClEZZirX3
 sDzHGdz1CME7S7ZBgv53EbwH0faF2Dv/dfBDtso1uXwgB8guvaf3Eq00P4H+IBz4pnTk
 yjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765243; x=1713370043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpfjBls1Q1Prp7MdrT8xYPE9RcXt49p2EGfNxpQiHmA=;
 b=gSofnhx0o6UKTft5dd1/OfqKLsGHKKT61vBltyKTIde1Pm6UQPYa/90G+nWsnZVi4Q
 bbs6zWbT29BsUnhfITncXAvEiDZUX5fwnnn8BRTPIU6fzc50LIijahWThMdMKIFWL3Ai
 vZ0d7zJv9zL9eo/FzZ1a5JQHvm0bmgjGaItcT0hnyvOpGaP8GrUkQS/XlY+Rav7XDUPr
 EwGllY2l4svQ/BZaGpLRlOMSjN2jG8Z6vzokSB6hoRDLvLmMqmPOLtS3mC6nYZ35PKTI
 pwAEA8sLB47zfi+bRPsqDB8T+oK6DUWsYJJqflxnQk8A8bjtfLJskb67eJLy3IuG4rCk
 JXVw==
X-Gm-Message-State: AOJu0YwoNoNGRFZFAR9QXoBLBa+nIRXk4xRhtA8mIIz+8vViKttc1jDd
 R9EhWB7wjkQSjcNi2FpRDa9/SwHMqd2q80VH4DL+v/xMb5InjUhLnJvLlaLwy4OQsFHMlmm8Duy
 T
X-Google-Smtp-Source: AGHT+IFKQSC72dunI2u+kZ6IqCSxRMN/G1zfIVesfOLY3KgXO06qFSjVwtRjoNU5a/IEXnn2kJ27jw==
X-Received: by 2002:a05:6402:1955:b0:56e:6fcd:bae7 with SMTP id
 f21-20020a056402195500b0056e6fcdbae7mr103914edz.5.1712765242764; 
 Wed, 10 Apr 2024 09:07:22 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 h25-20020a056402095900b0056e62321eedsm3669224edz.17.2024.04.10.09.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:07:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 11/12] hw/dma/pl330: Use qemu_hexdump_line() to avoid sprintf()
Date: Wed, 10 Apr 2024 18:06:12 +0200
Message-ID: <20240410160614.90627-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


