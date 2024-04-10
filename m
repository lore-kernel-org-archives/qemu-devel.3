Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E659CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaTz-0000Zr-Q1; Wed, 10 Apr 2024 12:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTY-0000SK-CS
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:05 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTV-0002iU-LA
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:04 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e6f4ee104so3288120a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765219; x=1713370019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYu1kmJUzwiQNwtOT3Hu+HqZtkyD9XR4Mu5bcSA+DO0=;
 b=uBKqE6xB1DFp/3Cl4RBPdgOBXi7v8hIAJH1Blz6plkPcSoURFlI/JYJvWCBauO4oje
 t3xjuf37JYjmTlXaVKPOT5s+J+FiPTAakrkZj215VL5PTr8j+dgwrz5D1C35rw82Ayfy
 bCAGHjH1HOhBzDSa0T+jSOxR0CGlemc049QD8ylHUwin0m3V9yR09LXH67B/uMxEfoLp
 79fDgWhZy/Wnx8jDkYG2omddV348EgtcybYiBLLb+zBgB38xZIx47gTEqln7hl6zMtzq
 fZGDRlV3VHkraWXCNpNbUxMRwzWECf92PXkCGTxF+dSQN1yCibV5Jcv4lqo7jkGTwrQJ
 p/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765219; x=1713370019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYu1kmJUzwiQNwtOT3Hu+HqZtkyD9XR4Mu5bcSA+DO0=;
 b=ISv+YFlhyNmKA50KEtr/+Vrov4yQJJ7fUfIt9+9H4k6d9GSwMBOcbw06tPkDMRR1e3
 xi53KRdX1q43ILZRGey5m885MDXvaa6Pii7KCuvPTjdJklgfdFX6SUOLednX5zsIp0MN
 amvMnXQEBMPh6jOfnoFf70QMFaxcvWJLB82NfPgqFv5gZjLnu+fJtZGoxNGjljzfxIcS
 VulMvJNxM8QO4KD5ux5ZswohhOCtbXUtM20fwPphOkyl2Gcnu6oHR4K9stgbGhIrdpfc
 nXSJwPTapBazMRNENRqoS+JkWQdKYr7n2JX+67cXYZjgg5ft5rnU3fTt7c3gES5yduQ5
 BstQ==
X-Gm-Message-State: AOJu0Yx6Lfqg1Wo3ecxCe2WpcryoXPJMCRKp3OjsBqcRiFWdU11Czunc
 RfOP7FYco+uFJnq2gBvFKyJcBNNWpfIdDcl/ohtk4FUleaO6gR4qwINyyFBz2D1wnbHufVKUmOh
 X
X-Google-Smtp-Source: AGHT+IFfyJmXj9qpaTvYnb1Kun5xr+yN68VIsReEgz93N4vNYb8NOrw29uIlr1DtqEaY0QcaS9OWMA==
X-Received: by 2002:a17:907:7e97:b0:a51:b0e1:863f with SMTP id
 qb23-20020a1709077e9700b00a51b0e1863fmr2426735ejc.13.1712765219100; 
 Wed, 10 Apr 2024 09:06:59 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 t1-20020a1709067c0100b00a46aac377e8sm7089906ejo.54.2024.04.10.09.06.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:06:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 07/12] util/hexdump: Have qemu_hexdump_line() return heap
 allocated buffer
Date: Wed, 10 Apr 2024 18:06:08 +0200
Message-ID: <20240410160614.90627-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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


