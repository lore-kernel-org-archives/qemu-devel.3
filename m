Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDFBCD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaUC-0000tq-Ok; Wed, 10 Apr 2024 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTe-0000U5-89
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:12 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTb-0002ji-VB
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516d47ce662so9312614e87.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765225; x=1713370025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PowLaTwCiK0zblbMYsUQoyhFkR48l8ASgwvzYVcEv18=;
 b=h2Nwfwv03c1Celk2hdK5rW1ihxBBnc5LWQlUr6GnhPejS9vwlvrTCr4Mu7rgM7fsCB
 MPEI51DqhMjZk9tF5HpZ56cuaXZ1x/1dzxx8njrFBjepEszeO1De6Qa1nAF17liBKbKC
 2lZDIEOyT/unzLaOJJu0Gghp+Zglpwj1uorIDsro2N8O98wpeEyOmah1oQ+nvVlBY7cW
 pSJHglYGsVgEik18RLzvdJLBvz7UuUGH7HjhNV/oAGgMrHB2wJtSYB8ow7IVqfltC6AR
 RWkw742YYAqeYuO5q3oxrCXlG25bZS+2cYG5fDKVPKxsDRA5F7FXbcp2hzY0Mk9pNA24
 k7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765225; x=1713370025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PowLaTwCiK0zblbMYsUQoyhFkR48l8ASgwvzYVcEv18=;
 b=jlfR9d+HzjqPb1aM/USnTzRYTpcX5QMJzdpI1fVLTfDRd27YfefvGeNWQ0Me+GP7YN
 qHA8ZvxGn5e4KQPp7ymIwMQno35DhHGNwSGnG1wHVZXHMrFsmOLJaQRbIYx1k6JRNbDJ
 832hDYncIWkg/PBGBVclMZ26/mDr6dykdb0bmas8ZXSz741i7Vt3WeJr9UQYcsfBonMr
 gefFW+3nNFrEWgXTwYlcIAvkRTNbwDB5ImxkWdH/Bx8sEid00O+yAb7FsWM43KkjGsJQ
 a7A6gEm8n+AnVxY3YnIts/cbB51+UKh7vrLw9jXFnJZ6ewUF5IRP7Xo7HpywP+65ylU3
 SZKQ==
X-Gm-Message-State: AOJu0YxyjdrKkQVZtULsSOgW9gHG8lKt2c+pkYfpDxAJS+QmdWCIKbLo
 elptMFFTetw4CW4ALXFLgkHzDwRzoGOFTK3b+Cinnl3mrENTasBbIY/dVNbU8YBy8wRoPicABzO
 t
X-Google-Smtp-Source: AGHT+IENfuYALi5KAaRuogXnI0+lHOt1Azwmfv2uVUZm5R9Niaq9E8oqANhsLkAdayEvVQI2eycBpQ==
X-Received: by 2002:a05:6512:ea8:b0:513:cfaa:e618 with SMTP id
 bi40-20020a0565120ea800b00513cfaae618mr3244047lfb.0.1712765224777; 
 Wed, 10 Apr 2024 09:07:04 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 r16-20020a170906281000b00a52196cce80sm58124ejc.121.2024.04.10.09.07.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:07:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/12] util/hexdump: Replace sprintf() by
 g_string_append_printf()
Date: Wed, 10 Apr 2024 18:06:09 +0200
Message-ID: <20240410160614.90627-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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


