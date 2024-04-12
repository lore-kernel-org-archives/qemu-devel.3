Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9A3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ2-0006yT-JI; Fri, 12 Apr 2024 03:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBPz-0006ww-OW
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:51 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBPx-00074a-Qf
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:51 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso421993a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907228; x=1713512028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ISGCLEDJVFZiUeSj505TnpSQiQ8gRVs+fhfSNIPx8Ks=;
 b=RaCYFfs38nvxICiWQCl6+45MYFyfzIsrBmBLs9NTtKTwIZH3tc47PtZauX4mEkGNYA
 DE98YqDOiTkqh5RTEISNhWensMSu2B7LVLG+Z5oauXSX1z/+pkxVeqHVmVhZdHGERbNd
 0nQ5tZQlBmyUND4KSzZR94C6rkTVcD/+3xN6xjPF1U4hHGvbrQ39K1Ewsfjxd119qykO
 DO4Psm8O7cOTzot1isbzrffti0CelbxuH5r71sR8ylpynUntvIWzpptMA1oJC1eSFIXs
 9MkhcC6KI+Od1OlNE8NXM1tGIV36uT3HUo+uUav0Dd/AV1VLB1phu6wB3jb2U/fOpDfI
 Dl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907228; x=1713512028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISGCLEDJVFZiUeSj505TnpSQiQ8gRVs+fhfSNIPx8Ks=;
 b=ZG5W/G34smriHMz+CdxtSmc/vFBAeRASJVL3+crunjQTTuDRxSOCDV+H8PpIkx8yAb
 6xhpwKRjFgtVchYKO1GHkvkUMdVBNyhpplOlGzg9JTDsTNwFruSptIdNS6bQvHBI0pjz
 4Yw4JfhhNdHg0jrXfnOuZ557uZH8DSayDxsmbQXfHAhe7Lc1G0PEXZSn+OfpLNL11GUe
 G0wSHj09vHdmnpbXweGiMZgAHMbowXhE6eD0lg/YXWZAPhWHlyuWe15F+gAr13z4o0Cz
 xtp2qhpgURJ/dUw7mqwNdfowUj4cNh6YiFM9GurE7gJTTuYej0Zy8K/y+mPEgXweMnPR
 2TKg==
X-Gm-Message-State: AOJu0Yxx2IOdqSXXN9f8YJyyDdi9N47DGS/GoxnrPsEOlRhnnvcQq9Hm
 iCXsec+kkgFMUNl18pAAzGxkt7aKiwWO6s5i0oS93Dz/jH0C7vKw5Cam6JbMFDHCxSxSFG6VveS
 S
X-Google-Smtp-Source: AGHT+IEnd0rmDPo0aYVMqOy1/eSlsemPhUtzIqHjNRKp5GkbmIhthdNb0lm/JIm7U/5TDoJRIZ2Zlw==
X-Received: by 2002:a05:6a21:3e02:b0:1a7:9adc:86de with SMTP id
 bk2-20020a056a213e0200b001a79adc86demr2025603pzc.20.1712907228329; 
 Fri, 12 Apr 2024 00:33:48 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/27] util/hexdump: Remove b parameter from
 qemu_hexdump_line
Date: Fri, 12 Apr 2024 00:33:20 -0700
Message-Id: <20240412073346.458116-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Require that the caller output the offset and increment bufptr.
Use QEMU_HEXDUMP_LINE_BYTES in vhost_vdpa_dump_config instead
of raw integer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/cutils.h  |  2 +-
 hw/virtio/vhost-vdpa.c |  4 ++--
 util/hexdump.c         | 13 ++++++-------
 hw/virtio/trace-events |  2 +-
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c927a6a3..3415f5d249 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -257,7 +257,7 @@ int parse_debug_env(const char *name, int max, int initial);
  */
 #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
 #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+void qemu_hexdump_line(char *line, const void *bufptr,
                        unsigned int len, bool ascii);
 
 /*
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e827b9175f..b4afa142f6 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -946,8 +946,8 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
 
     for (b = 0; b < config_len; b += 16) {
         len = config_len - b;
-        qemu_hexdump_line(line, b, config, len, false);
-        trace_vhost_vdpa_dump_config(dev, line);
+        qemu_hexdump_line(line, config + b, len, false);
+        trace_vhost_vdpa_dump_config(dev, b, line);
     }
 }
 
diff --git a/util/hexdump.c b/util/hexdump.c
index 9921114b3c..7324e7b126 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+void qemu_hexdump_line(char *line, const void *bufptr,
                        unsigned int len, bool ascii)
 {
     const char *buf = bufptr;
@@ -26,13 +26,12 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
         len = QEMU_HEXDUMP_LINE_BYTES;
     }
 
-    line += snprintf(line, 6, "%04x:", b);
     for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
-        if ((i % 4) == 0) {
+        if (i != 0 && (i % 4) == 0) {
             *line++ = ' ';
         }
         if (i < len) {
-            line += sprintf(line, " %02x", (unsigned char)buf[b + i]);
+            line += sprintf(line, " %02x", (unsigned char)buf[i]);
         } else {
             line += sprintf(line, "   ");
         }
@@ -40,7 +39,7 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
     if (ascii) {
         *line++ = ' ';
         for (i = 0; i < len; i++) {
-            c = buf[b + i];
+            c = buf[i];
             if (c < ' ' || c > '~') {
                 c = '.';
             }
@@ -58,8 +57,8 @@ void qemu_hexdump(FILE *fp, const char *prefix,
 
     for (b = 0; b < size; b += QEMU_HEXDUMP_LINE_BYTES) {
         len = size - b;
-        qemu_hexdump_line(line, b, bufptr, len, true);
-        fprintf(fp, "%s: %s\n", prefix, line);
+        qemu_hexdump_line(line, bufptr + b, len, true);
+        fprintf(fp, "%s: %04x: %s\n", prefix, b, line);
     }
 
 }
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 96632fd026..d01bc85037 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -50,7 +50,7 @@ vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRI
 vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
 vhost_vdpa_set_vring_enable_one(void *dev, unsigned i, int enable, int r) "dev: %p, idx: %u, enable: %u, r: %d"
-vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
+vhost_vdpa_dump_config(void *dev, unsigned ofs, const char *line) "dev: %p %04x: %s"
 vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
 vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
 vhost_vdpa_suspend(void *dev) "dev: %p"
-- 
2.34.1


