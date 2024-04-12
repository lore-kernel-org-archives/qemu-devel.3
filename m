Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30513C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ2-0006yU-J3; Fri, 12 Apr 2024 03:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ1-0006xY-Cm
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBPz-00074k-7X
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso5125995ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907230; x=1713512030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q7LRFqckZoWWz6WECvkgu9IuYe9DhqTySxBwiAwbY30=;
 b=Ji1OwLEqenHekJ5WeWHeaRXRfrT88eaNY5bBL/LziJFECT8hpPCiLFkgvFBSoXHBmm
 17SVvvvIXayIIkBX2MFT9S1iG2iSAEJtQEqPfTTQQLjrQ1sQdQZ5iRLLi4aPxDtZy/jA
 ZGWrkNAvpbROhTTAh5ZFG6xMNVtDfNmTx1I5Y1eViE2maVZdBwJ09cD4V/e2Xsj1SbAU
 wUohtZNNsx7hwRofGKNKqdl/SU4aEp+ic1sXs+j82ocFy0c7niv0ueOwwrNkwXUH1Lxk
 YzRM/3uW7Jc/fzO45RNabTYgRVlIDy13RdosyaSBl9U5DewJt7+8BGBf/y6fE1Zs/Gdv
 8sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907230; x=1713512030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7LRFqckZoWWz6WECvkgu9IuYe9DhqTySxBwiAwbY30=;
 b=qO0WNMIMdJQQTcBR/BhBDk+rat/ur6368t1fMX6Yf/oZnnAW4fb1gSmIgtQUfFV1H3
 Ni3n7IjdCWZnQu2S6Er590l3PJaZItBJbSVw6G8AnrQa2lsd2StzhIklbs9TBPwmsbJH
 y59sR8fBrLoHxl8o23MVvbd2FYEpgGlgw+aWVbjJubBjnkEpK9sjnXzKPFSmoYEzODZv
 vg4QKTOxAC0ScvzghwDA1HFOqXeZCZ/gYAyL/Qw1abpF6tWSowKl8xKN5eQfMFS8kElF
 6pWm/atonTJzth+JsEs1aJfNaIGYnYvSrbbtDFtmbyalpcHqZzJeHZ0BWfGH4V1+kdLz
 IMJw==
X-Gm-Message-State: AOJu0YznmLtaGYDDGPjcEUQ6T31rYVYHVPYLAqf5ElS+KBg1caLySPwx
 fJj6ZvxbVPHLEzIh+YYtVm+Xmq28IEOnUutlvJAzKA/2cIECi6FUnCPUiY2UWTqXc5D4/eqRQJW
 Q
X-Google-Smtp-Source: AGHT+IEWUpBQvEH1BepR1QQxCKJq5Vr/moEzz9mRVCcewMn0jekh5nsUOoQ8SwukAXAgWDEw2aa5sg==
X-Received: by 2002:a17:902:d2c2:b0:1e2:3d05:5f4c with SMTP id
 n2-20020a170902d2c200b001e23d055f4cmr1837714plc.39.1712907229941; 
 Fri, 12 Apr 2024 00:33:49 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/27] util/hexdump: Use a GString for qemu_hexdump_line
Date: Fri, 12 Apr 2024 00:33:22 -0700
Message-Id: <20240412073346.458116-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Allocate a new, or append to an existing GString instead of
using a fixed sized buffer.  Require the caller to determine
the length of the line -- do not bound len here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/cutils.h  | 15 ++++++++++-----
 hw/virtio/vhost-vdpa.c | 14 ++++++++------
 util/hexdump.c         | 29 +++++++++++++++++------------
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index d0c5386e6c..7311fb36ca 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -252,12 +252,17 @@ static inline const char *yes_no(bool b)
  */
 int parse_debug_env(const char *name, int max, int initial);
 
-/*
- * Hexdump a line of a byte buffer into a hexadecimal/ASCII buffer
+/**
+ * qemu_hexdump_line:
+ * @str: GString into which to append
+ * @buf: buffer to dump
+ * @len: number of bytes to dump
+ *
+ * Append @len bytes of @buf as hexadecimal into @str.
+ * If @str is NULL, allocate a new string and return it;
+ * otherwise return @str.
  */
-#define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
-#define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, const void *bufptr, size_t len);
+GString *qemu_hexdump_line(GString *str, const void *buf, size_t len);
 
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 32bad5ce68..ab047d8ee0 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -941,13 +941,15 @@ static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
 static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
                                    uint32_t config_len)
 {
-    int b, len;
-    char line[QEMU_HEXDUMP_LINE_LEN];
+    g_autoptr(GString) str = g_string_sized_new(4 * 16);
+    size_t b, len;
 
-    for (b = 0; b < config_len; b += 16) {
-        len = config_len - b;
-        qemu_hexdump_line(line, config + b, len);
-        trace_vhost_vdpa_dump_config(dev, b, line);
+    for (b = 0; b < config_len; b += len) {
+        len = MIN(config_len - b, 16);
+
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, config + b, len);
+        trace_vhost_vdpa_dump_config(dev, b, str->str);
     }
 }
 
diff --git a/util/hexdump.c b/util/hexdump.c
index dbc536fe84..521e346bc6 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,22 +16,25 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
+GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len)
 {
-    const char *buf = bufptr;
-    int i, c;
+    const uint8_t *buf = vbuf;
+    size_t i;
 
-    if (len > QEMU_HEXDUMP_LINE_BYTES) {
-        len = QEMU_HEXDUMP_LINE_BYTES;
+    if (str == NULL) {
+        /* Estimate the length of the output to avoid reallocs. */
+        i = len * 3 + len / 4;
+        str = g_string_sized_new(i + 1);
     }
 
     for (i = 0; i < len; i++) {
         if (i != 0 && (i % 4) == 0) {
-            *line++ = ' ';
+            g_string_append_c(str, ' ');
         }
-        line += sprintf(line, " %02x", (unsigned char)buf[i]);
+        g_string_append_printf(str, " %02x", buf[i]);
     }
-    *line = '\0';
+
+    return str;
 }
 
 static void asciidump_line(char *line, const void *bufptr, size_t len)
@@ -49,24 +52,26 @@ static void asciidump_line(char *line, const void *bufptr, size_t len)
     *line = '\0';
 }
 
+#define QEMU_HEXDUMP_LINE_BYTES 16
 #define QEMU_HEXDUMP_LINE_WIDTH \
     (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
 
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size)
 {
-    char line[QEMU_HEXDUMP_LINE_LEN];
+    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
     char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
     size_t b, len;
 
     for (b = 0; b < size; b += len) {
         len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
 
-        qemu_hexdump_line(line, bufptr + b, len);
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, bufptr + b, len);
         asciidump_line(ascii, bufptr + b, len);
 
-        fprintf(fp, "%s: %04x: %-*s %s\n",
-                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, line, ascii);
+        fprintf(fp, "%s: %04zx: %-*s %s\n",
+                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, str->str, ascii);
     }
 
 }
-- 
2.34.1


