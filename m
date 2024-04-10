Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03692CD1299
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaTS-0000Qm-IA; Wed, 10 Apr 2024 12:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTR-0000Oc-4E
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:57 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTO-0002hR-PY
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:56 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a4715991c32so932330166b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765213; x=1713370013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1NpFpUrBWuL7lYE+0KLDn2ZH8pFKE5VoepA/3Vy6uc=;
 b=Tsg5YHeD7mSxw0UaB4lmQ1RUfRORqL3+j2KyD6Vu2/XuDjHcO0YO+TYkMhM6rk0EIC
 RC2VfbvzMyslhfAOnOujjDJu9iKxbGSR3KXO1m/zYa6Pkd0dJrmN4xS1Mam3soSz+GXj
 WK0nJ5kpWVVU1nD7Rxh7phukWj6bfEqGekmYwI7q2tbdYv8pe+k4M1KU+QQth/RMjJj9
 51jCiQUgg0YOS4Hx7Q+9IWbcrOqP8qBqPfsmtRM5eBIzQl2C5IUyqbGeBy6+vUzWnAGZ
 8uRPh7SU23sdZmchB/L5Mqg2NOvfOI/MDjgITP6sL2vZaTwhTvmqENKCCzk/mPElE1hR
 3QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765213; x=1713370013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1NpFpUrBWuL7lYE+0KLDn2ZH8pFKE5VoepA/3Vy6uc=;
 b=NXvIv1Nnsnusk28E1G2ughHHo6aG8OkrFq0vwBY6ggdVGOn7C6Nj7PRREp9SIadJRU
 MfOUG1HdIyaBz2yK5upr1GcDDoYKO3UdyZ8S8StrYwKHfZudeGJFw0yOr/J+j9M39fut
 eVynQkdDxQvSap3M4oEalUUmK+tLx/4miYCPIlrJyoAeVChfQHfAk/yclhgX2+AqCGu8
 HMxMEHZvhYuAYBT4r98EWK66N20GhfPlbGnqkV9A+dm4XPSfELpZ7/q4IIvtdeODFeC7
 VpvviYz8UeYiRaGpU7nnMo61I7es0xpibmt2OPK8waPEv1mkFPTF1W2rQeB51hjr1NWc
 fSog==
X-Gm-Message-State: AOJu0Yx7W2ovaFKOZrKt60F65KJGTz/PlXoVz/FIdN3YPiVrNrHzkbtm
 8j6oKMeIR/aGTVSE1wP+ErRQwCyTN6kfcB5aPRTQcEWudDqUzR5F5A3m9uDsZ+PI7Z01n4dGtEu
 C
X-Google-Smtp-Source: AGHT+IGLLrh2NE0Ml0J+75ELqRlhpFVe/7qf6/vJjNr5kLO5HB8hUYWEnrk8W9mXnsAb1wZu4luWtQ==
X-Received: by 2002:a17:906:2a91:b0:a51:8540:c671 with SMTP id
 l17-20020a1709062a9100b00a518540c671mr1832686eje.50.1712765213206; 
 Wed, 10 Apr 2024 09:06:53 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 xh13-20020a170906da8d00b00a51c0c0cb86sm5506389ejb.22.2024.04.10.09.06.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:06:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 06/12] util/hexdump: Rename @offset argument in
 qemu_hexdump_line()
Date: Wed, 10 Apr 2024 18:06:07 +0200
Message-ID: <20240410160614.90627-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

@offset argument is more descriptive than @b.

Inverse @bufptr <-> @offset arguments order.

Document qemu_hexdump_line().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/cutils.h  | 11 +++++++++--
 hw/virtio/vhost-vdpa.c |  8 ++++----
 util/hexdump.c         | 16 ++++++++--------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c927a6a3..70ca4b876b 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -252,12 +252,19 @@ static inline const char *yes_no(bool b)
  */
 int parse_debug_env(const char *name, int max, int initial);
 
-/*
+/**
+ * qemu_hexdump_line:
+ * @line: Buffer to be filled by the hexadecimal/ASCII dump
+ * @bufptr: Buffer to dump
+ * @offset: Offset within @bufptr to start the dump
+ * @len: Length of the bytes do dump
+ * @ascii: Replace non-ASCII characters by the dot symbol
+ *
  * Hexdump a line of a byte buffer into a hexadecimal/ASCII buffer
  */
 #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
 #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
                        unsigned int len, bool ascii);
 
 /*
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e827b9175f..cf7cfa3f16 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -941,12 +941,12 @@ static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
 static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
                                    uint32_t config_len)
 {
-    int b, len;
+    int ofs, len;
     char line[QEMU_HEXDUMP_LINE_LEN];
 
-    for (b = 0; b < config_len; b += 16) {
-        len = config_len - b;
-        qemu_hexdump_line(line, b, config, len, false);
+    for (ofs = 0; ofs < config_len; ofs += 16) {
+        len = config_len - ofs;
+        qemu_hexdump_line(line, config, ofs, len, false);
         trace_vhost_vdpa_dump_config(dev, line);
     }
 }
diff --git a/util/hexdump.c b/util/hexdump.c
index 9921114b3c..469083d8c0 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
                        unsigned int len, bool ascii)
 {
     const char *buf = bufptr;
@@ -26,13 +26,13 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
         len = QEMU_HEXDUMP_LINE_BYTES;
     }
 
-    line += snprintf(line, 6, "%04x:", b);
+    line += snprintf(line, 6, "%04x:", offset);
     for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
         if ((i % 4) == 0) {
             *line++ = ' ';
         }
         if (i < len) {
-            line += sprintf(line, " %02x", (unsigned char)buf[b + i]);
+            line += sprintf(line, " %02x", (unsigned char)buf[offset + i]);
         } else {
             line += sprintf(line, "   ");
         }
@@ -40,7 +40,7 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
     if (ascii) {
         *line++ = ' ';
         for (i = 0; i < len; i++) {
-            c = buf[b + i];
+            c = buf[offset + i];
             if (c < ' ' || c > '~') {
                 c = '.';
             }
@@ -53,12 +53,12 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size)
 {
-    unsigned int b, len;
+    unsigned int ofs, len;
     char line[QEMU_HEXDUMP_LINE_LEN];
 
-    for (b = 0; b < size; b += QEMU_HEXDUMP_LINE_BYTES) {
-        len = size - b;
-        qemu_hexdump_line(line, b, bufptr, len, true);
+    for (ofs = 0; ofs < size; ofs += QEMU_HEXDUMP_LINE_BYTES) {
+        len = size - ofs;
+        qemu_hexdump_line(line, bufptr, ofs, len, true);
         fprintf(fp, "%s: %s\n", prefix, line);
     }
 
-- 
2.41.0


