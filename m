Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F2AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ8-00070j-1J; Fri, 12 Apr 2024 03:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ6-00070C-ER
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ4-00078P-Va
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e5c11076b9so640725ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907235; x=1713512035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ilxVF5BFwS4yjUJP5brLaFANRlAZicyrMWrO+XSuc0=;
 b=TZXSFWDsAsMGQVsYPjBqDchaQDmbOPAHKM/mgPJZFKOqGbDHoFqE4DMQTolwJT/oPm
 eOGKEAk3lg4DGoTK9ZxQQRwo6OMgkkM67eYoF/rRZoqW804imrnbw14AJgpmL1lezudM
 a6EG09maLY4M/phWqabf8jytQRcGNq08Fb0HzpjJmkeOpwZs5MJQtiwPCpiUGew22ZBe
 3VVYNIXpThn5fnOObzkVzxohofOnGOJMvFEKsWeoeP4681R0vQTBZGeLv9+3tUwqF4MT
 NOjIelZwb11j1Qlpbz0cQid/SEqf48j1mN2FarH0ufaUoeGlqkEOf8xOm9jLzPy7LnrX
 3Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907235; x=1713512035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ilxVF5BFwS4yjUJP5brLaFANRlAZicyrMWrO+XSuc0=;
 b=baQwoQO5atYM08PmEa8jorRxcv0EAN8KH9XvosgMt9lUuFfsAGopK/6NP8ndEDJnR4
 S4++yolis/J7p27lGWN8gRbG0i/n1g1l16Oy75Ox7MBiaPOYmaaIX0hsY92Jl/YbIpvX
 ynItaMcZhmQQBSCbUXmToDEIbgtyryEIkT/pvrpTpg1OYIdC45Rahbw0HV3oow82wUQB
 wVvHzMHT4hQ6DlkPekceNJOsT4fuF/C4KkMzyRUgRyKkDsaUwuHbNStwi/C1+i+zNwRf
 korrMZegqP4OBhbV0bzCdsALE7t6dDboiyq33KOWKc4FNGpJskSvz5wFyF4tbEpnxvQR
 wzKQ==
X-Gm-Message-State: AOJu0YyHqfBGS1vKELy7eEV0+EKOU5jzJ915aEfJizH+Wp4APjcbnWbv
 WOVOATm3IXuoWW1HqQkFjXEC1n9q7xH0mEo7NxhX5pG1jXRdw0ClFBGGJfLPvXY15mPCTYoma8K
 z
X-Google-Smtp-Source: AGHT+IFIMoPGKgkXg1GY63SfyjaPXmkZpZTU2GlLISIDNSVn8pE+lGFT5Lcx7Z4tVcNYnVRhogK/MA==
X-Received: by 2002:a17:902:f64a:b0:1e3:ff5e:159f with SMTP id
 m10-20020a170902f64a00b001e3ff5e159fmr2442098plg.18.1712907235663; 
 Fri, 12 Apr 2024 00:33:55 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/27] hw/dma/pl330: Use qemu_hexdump_line to avoid sprintf
Date: Fri, 12 Apr 2024 00:33:29 -0700
Message-Id: <20240412073346.458116-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/dma/pl330.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 70a502d245..5f89295af3 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -317,22 +318,14 @@ typedef struct PL330InsnDesc {
 
 static void pl330_hexdump(uint8_t *buf, size_t size)
 {
-    unsigned int b, i, len;
-    char tmpbuf[80];
+    g_autoptr(GString) str = g_string_sized_new(64);
+    size_t b, len;
 
-    for (b = 0; b < size; b += 16) {
-        len = size - b;
-        if (len > 16) {
-            len = 16;
-        }
-        tmpbuf[0] = '\0';
-        for (i = 0; i < len; i++) {
-            if ((i % 4) == 0) {
-                strcat(tmpbuf, " ");
-            }
-            sprintf(tmpbuf + strlen(tmpbuf), " %02x", buf[b + i]);
-        }
-        trace_pl330_hexdump(b, tmpbuf);
+    for (b = 0; b < size; b += len) {
+        len = MIN(16, size - b);
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, buf + b, len, 1, 4);
+        trace_pl330_hexdump(b, str->str);
     }
 }
 
-- 
2.34.1


