Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EC7CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurUx-0006ID-PE; Thu, 11 Apr 2024 06:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUD-0005Jf-DS
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:54 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUA-0007aR-Ni
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:53 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d895138ce6so50936091fa.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830608; x=1713435408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PowLaTwCiK0zblbMYsUQoyhFkR48l8ASgwvzYVcEv18=;
 b=VQa6Q7RzqhcSjCOYkiD1cPtRDt4kLEAS6oqku4CVnZ3aiZwy6jHfERmvlZQFSKRtX4
 i5E+M4jYt1TtciZdzKSdxVw3QjANQRr6sLJWj8562zU2H0XLwIICqPKjixx5o+GrYu3a
 +9dNr6FLz/cMsboMgv/W75nmxIOigddZY+HqxMH9I8B0bre04zy9ct/dPxR3oPrW8HHU
 sAZ1LB/aNw5Xz+d5N8kM+wEhAhqdTu5Bt/GQoN3UupAgYaexDMl9Fobmj5It42c/P7tT
 yfm2XPyTef0Vivhlp+QnlRoFIKKTvKGxmbj1j/Z0vl5yyNYOlEDTRJaa71ekKnEtPKjJ
 pGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830608; x=1713435408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PowLaTwCiK0zblbMYsUQoyhFkR48l8ASgwvzYVcEv18=;
 b=XCGd8m5t+Lxh23PRrt51VriTD2fwCdg2nmorL1eoVqjzLfg/F80NdOzaiZgjyB0B7x
 RAZcWX7paTnN9eRfeSjY+2HgiHzKB+Gq5SsFcuycbodjg/v7mh6Fjm7q5mhqHwX/sUjh
 F1y3H2oT7m98SmxNMaAcLLhIZlsJEta+Jzc0khWkMEfJL8KFS/gyvo2d33/3L8fUtePF
 knQCh0Y5VrUk/LjZN3Gjx3PMMoGaXu+PprvjoGfPzCJKzIlwXnNavjkVBvzEBwpqL7Sa
 uTMACF+1l5T/aXrqTRMZxJHe+1C7aMVP0kTp0r3UIr04jB3rbszgpOXXC+1+tyAdhOQt
 RaQQ==
X-Gm-Message-State: AOJu0YzlMEY4pkuoet6qbvKz0VxX4FcWdqSMOyy1YOR0CFjTU9ZyIsC6
 f9yniDRyLQnEnWv+zCh+o067o3hESsXKMuoDLcMrlLQ2q+rgWT2Ju0p4cuwaEysF88s0W8UUSk9
 pbYk=
X-Google-Smtp-Source: AGHT+IFSUH+M75B1+/Tro4dh3EDiLtN+/dUOVcYVwlUaNx3KR8cCewaOLZl5kukRK4f6BdnsFjCZtg==
X-Received: by 2002:a2e:bc11:0:b0:2d8:901f:7f50 with SMTP id
 b17-20020a2ebc11000000b002d8901f7f50mr4317602ljf.9.1712830608025; 
 Thu, 11 Apr 2024 03:16:48 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 fm6-20020a05600c0c0600b004156afd6843sm5076156wmb.18.2024.04.11.03.16.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/13] util/hexdump: Replace sprintf() by
 g_string_append_printf()
Date: Thu, 11 Apr 2024 12:15:45 +0200
Message-ID: <20240411101550.99392-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Replace sprintf() by GString API in order to avoid:

  [426/1310] Compiling C object libqemuutil.a.p/util_hexdump.c.o
  util/hexdump.c:35:21: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
            line += sprintf(line, " %02x", (unsigned char)buf[b + i]);
                    ^
  util/hexdump.c:37:21: warning: 'sprintf' is deprecated:
            line += sprintf(line, "   ");
                    ^
  2 warnings generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/hexdump.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/util/hexdump.c b/util/hexdump.c
index b6f70e93bb..2ec1171de3 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -19,7 +19,7 @@
 char *qemu_hexdump_line(const void *bufptr, unsigned offset,
                         unsigned int len, bool ascii)
 {
-    char linebuf[QEMU_HEXDUMP_LINE_BYTES], *line = linebuf;
+    g_autoptr(GString) gs = g_string_sized_new(QEMU_HEXDUMP_LINE_BYTES);
     const char *buf = bufptr;
     int i, c;
 
@@ -27,30 +27,29 @@ char *qemu_hexdump_line(const void *bufptr, unsigned offset,
         len = QEMU_HEXDUMP_LINE_BYTES;
     }
 
-    line += snprintf(line, 6, "%04x:", offset);
+    g_string_append_printf(gs, "%04x:", offset);
     for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
         if ((i % 4) == 0) {
-            *line++ = ' ';
+            g_string_append_c(gs, ' ');
         }
         if (i < len) {
-            line += sprintf(line, " %02x", (unsigned char)buf[offset + i]);
+            g_string_append_printf(gs, " %02x", (unsigned char)buf[offset + i]);
         } else {
-            line += sprintf(line, "   ");
+            g_string_append(gs, "   ");
         }
     }
     if (ascii) {
-        *line++ = ' ';
+        g_string_append_c(gs, ' ');
         for (i = 0; i < len; i++) {
             c = buf[offset + i];
             if (c < ' ' || c > '~') {
                 c = '.';
             }
-            *line++ = c;
+            g_string_append_c(gs, c);
         }
     }
-    *line = '\0';
 
-    return g_strdup(linebuf);
+    return g_strdup(gs->str);
 }
 
 void qemu_hexdump(FILE *fp, const char *prefix,
-- 
2.41.0


