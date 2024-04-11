Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5D2CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurUv-00067E-Mx; Thu, 11 Apr 2024 06:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurU6-0005Hg-Bk
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:47 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurU4-0007Xu-FJ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:46 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d700beb6beso82827231fa.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830602; x=1713435402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYu1kmJUzwiQNwtOT3Hu+HqZtkyD9XR4Mu5bcSA+DO0=;
 b=U6k/BHCwgJFABigzB8R+bTpGMo28cYY+vNyrudGuDwq1DJYL2lhXDfgjt3muytAsxA
 vP+xn1te8pMdZ6luDwKbW5odiXZYp8i3Faubm9B9z0Nncgf/b6/72c3I0nr5mkQtEaAP
 iPADb5sEiJmcuZgoDKuCW0ieFql3hZzaWA+LlZljQpSbih+fAzT+grI7AncvMdHePOdc
 +28tTx2bHK9S5lhrUXN9VtBdttNbZibdWQELUcrvRhpak0jn5G7nw82GJqiDHdetu9lY
 MK0LvgZQ9s9Icmkf+raAusEUmFnFeWdbFK6AMlefBCrU9rClOT9Es4CgciEWeWqdnNgD
 InRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830602; x=1713435402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYu1kmJUzwiQNwtOT3Hu+HqZtkyD9XR4Mu5bcSA+DO0=;
 b=cCO5JvbOkDBEXCo56d7DQN6o97lUmvuiMdblLfj10RvD4mLvyqp5DLsB7bnXzkybVi
 F6onU1Tue8mk6fvi3IBgYn/C9jPxzACbhzED1kxG7OnLa7ksHkM98zcx7q0zohTv2QTz
 6jPSp1TwPhorrQgSL+cg3kw28OIbH3+T6tyOJTVLhd5LR+8xAPFreizGkIFj7bswkSaT
 PpZ/gKfmUb4iCoZUz5BVpO8OnZyX3SCXT+HPW2ri0zSm218tudl09ev5TsvBDnuxt/Rf
 o4mzqPWjRS6KGf3PDDO0+tu4phgLlwFCF4ho0rlrm52Es+PTkEuHc2NqiGNvXU6TWxNx
 ttRg==
X-Gm-Message-State: AOJu0YyTt7i0b1uy5g+5n5na/Iyf7YtVgy0m/VRT6cM1JnUfxtQ3N21R
 Zlhheqj2z3etP5D7DEOIapoNMjo7X9k49PBHDPtZljMrEMYK1+0XA8i5Lq+t5A941VUH6Q1feeF
 +EWk=
X-Google-Smtp-Source: AGHT+IEYcrSsnKC+BNy0igxOfTznc1k8qeifQMpPAh+YXA34UAl4IH8I9oOIAFR8asGlor1swIb/RQ==
X-Received: by 2002:a2e:9219:0:b0:2d8:d23a:f440 with SMTP id
 k25-20020a2e9219000000b002d8d23af440mr2454866ljg.6.1712830602221; 
 Thu, 11 Apr 2024 03:16:42 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c1d8500b00417e227f40bsm740594wms.3.2024.04.11.03.16.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 08/13] util/hexdump: Have qemu_hexdump_line() return heap
 allocated buffer
Date: Thu, 11 Apr 2024 12:15:44 +0200
Message-ID: <20240411101550.99392-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/cutils.h  | 10 +++++++---
 hw/virtio/vhost-vdpa.c |  5 +++--
 util/hexdump.c         | 12 ++++++++----
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 70ca4b876b..e8d6b86098 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -254,18 +254,22 @@ int parse_debug_env(const char *name, int max, int initial);
 
 /**
  * qemu_hexdump_line:
- * @line: Buffer to be filled by the hexadecimal/ASCII dump
  * @bufptr: Buffer to dump
  * @offset: Offset within @bufptr to start the dump
  * @len: Length of the bytes do dump
  * @ascii: Replace non-ASCII characters by the dot symbol
  *
  * Hexdump a line of a byte buffer into a hexadecimal/ASCII buffer
+ *
+ * The caller must use g_free() to free the returned data when it is
+ * no longer required.
+ *
+ * Returns: Hexadecimal/ASCII dump
  */
 #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
 #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
-                       unsigned int len, bool ascii);
+char *qemu_hexdump_line(const void *bufptr, unsigned offset,
+                        unsigned int len, bool ascii);
 
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index cf7cfa3f16..e61af86d9d 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -942,12 +942,13 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
                                    uint32_t config_len)
 {
     int ofs, len;
-    char line[QEMU_HEXDUMP_LINE_LEN];
+    char *line;
 
     for (ofs = 0; ofs < config_len; ofs += 16) {
         len = config_len - ofs;
-        qemu_hexdump_line(line, config, ofs, len, false);
+        line = qemu_hexdump_line(config, ofs, len, false);
         trace_vhost_vdpa_dump_config(dev, line);
+        g_free(line);
     }
 }
 
diff --git a/util/hexdump.c b/util/hexdump.c
index 469083d8c0..b6f70e93bb 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,9 +16,10 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
-                       unsigned int len, bool ascii)
+char *qemu_hexdump_line(const void *bufptr, unsigned offset,
+                        unsigned int len, bool ascii)
 {
+    char linebuf[QEMU_HEXDUMP_LINE_BYTES], *line = linebuf;
     const char *buf = bufptr;
     int i, c;
 
@@ -48,18 +49,21 @@ void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
         }
     }
     *line = '\0';
+
+    return g_strdup(linebuf);
 }
 
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size)
 {
     unsigned int ofs, len;
-    char line[QEMU_HEXDUMP_LINE_LEN];
+    char *line;
 
     for (ofs = 0; ofs < size; ofs += QEMU_HEXDUMP_LINE_BYTES) {
         len = size - ofs;
-        qemu_hexdump_line(line, bufptr, ofs, len, true);
+        line = qemu_hexdump_line(bufptr, ofs, len, true);
         fprintf(fp, "%s: %s\n", prefix, line);
+        g_free(line);
     }
 
 }
-- 
2.41.0


