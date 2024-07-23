Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9FAC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMKN-00013C-72; Tue, 23 Jul 2024 16:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMK3-00087D-Br
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMK0-0004WL-K9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-427db004e36so29717495e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767277; x=1722372077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1Rd8JLREenPY7uD+H493cwaNhRJxArDOSc9CQhnapI=;
 b=wBRBmOHiukq57BhbTTUKFtfQhk5rj3IlB9SBzreTSsHHLD34Fs2z2SZEupTFL8hjcO
 cuiuMaRHPOMyF1LFGdYjtLLstqxamaRYsbcVyeOlOtyvaK2mem1vwL7JJtbMzg3niEf1
 DrAeAVirHjtGAnVrrDLElmT1trzEVW4yP4pDXxajPqaWtz90PvxPlKvAhwvEJ9HJr8GJ
 tzcA1rfyPPMfkmEhnnDBlBTKa4sNgXBj6c8z7TC1DlkmPB7BtmQhvbYYgEux5D/AXsCf
 YkGPtUuOp2GhymioSTZ6xiIKXJH08EHxvXPspgYbAka4QhQc3peP837cck7dCui+XvvN
 Q11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767277; x=1722372077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1Rd8JLREenPY7uD+H493cwaNhRJxArDOSc9CQhnapI=;
 b=S3d34h+g2p/O99EhO2sanr2YBUQ/p2x6GwOaEAJ7jXIx8bSofvKWbTrDiL2MlIxtgl
 YSefZb1EfjlwBv4phHxDG91PEBONBlEUhFINARhDD7wWUuz2GmNOCaU+r2ZiBI4/K2No
 JTqJ2ZFjslTyzuZDniiHAbZWqmmNSKpZq3jAR8E5PO7XpsKQBFV6nukYgvpCQRNqVYQJ
 dg1QnyF5asqJ5DwDJG3NEuiyMAnoXHWsq4HcyU/uwwaaZP4PjBllPjJbvtco5AZOom4S
 CoNThRMA+g97WeXIvufJX6Vbd/H7xQX9HgMxu/SjOvUDpYsRqRgJN4x6cUlIAkFiKoxx
 cUWA==
X-Gm-Message-State: AOJu0Yzb/O8EVl965ZvNyIMgClpY5FDrOxoPgCIHR1tcxWNAGjUeRH2m
 Hd8X0tKJcPqtzf4ZML2eW75Mm6Vtbytg7faTlE7QB8eLqGDau2lsXiif5pF/lSGG8AZsV2fXp5P
 HwhY=
X-Google-Smtp-Source: AGHT+IGfUznRA8pB8/zGnHSd8/r+tIrnoK4d3cJhfnvCstd1Qbxfv+wVIDqU6avUgxWYvf36TaHuAA==
X-Received: by 2002:a05:600c:4694:b0:426:6688:2421 with SMTP id
 5b1f17b1804b1-427f9554a96mr119885e9.11.1721767277493; 
 Tue, 23 Jul 2024 13:41:17 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9398602sm510395e9.26.2024.07.23.13.41.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:41:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/28] util/fifo8: Expose fifo8_pop_buf()
Date: Tue, 23 Jul 2024 22:38:52 +0200
Message-ID: <20240723203855.65033-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Extract fifo8_pop_buf() from hw/scsi/esp.c and expose
it as part of the <qemu/fifo8.h> API. This function takes
care of non-contiguous (wrapped) FIFO buffer (which is an
implementation detail).

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240722160745.67904-7-philmd@linaro.org>
---
 include/qemu/fifo8.h | 16 ++++++++++++++++
 hw/scsi/esp.c        | 36 +++---------------------------------
 util/fifo8.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index a30220c8e96..bca6da306f7 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -62,12 +62,28 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
  */
 uint8_t fifo8_pop(Fifo8 *fifo);
 
+/**
+ * fifo8_pop_buf:
+ * @fifo: FIFO to pop from
+ * @dest: the buffer to write the data into (can be NULL)
+ * @destlen: size of @dest and maximum number of bytes to pop
+ *
+ * Pop a number of elements from the FIFO up to a maximum of @destlen.
+ * The popped data is copied into the @dest buffer.
+ * Care is taken when the data wraps around in the ring buffer.
+ *
+ * Returns: number of bytes popped.
+ */
+uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
+
 /**
  * fifo8_pop_bufptr:
  * @fifo: FIFO to pop from
  * @max: maximum number of bytes to pop
  * @numptr: pointer filled with number of bytes returned (can be NULL)
  *
+ * New code should prefer to use fifo8_pop_buf() instead of fifo8_pop_bufptr().
+ *
  * Pop a number of elements from the FIFO up to a maximum of @max. The buffer
  * containing the popped data is returned. This buffer points directly into
  * the internal FIFO backing store and data (without checking for overflow!)
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 7e9657e9c30..04c9a557b69 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -197,39 +197,9 @@ static uint8_t esp_fifo_pop(ESPState *s)
     return val;
 }
 
-static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
-{
-    const uint8_t *buf;
-    uint32_t n, n2;
-    int len;
-
-    if (maxlen == 0) {
-        return 0;
-    }
-
-    len = maxlen;
-    buf = fifo8_pop_bufptr(fifo, len, &n);
-    if (dest) {
-        memcpy(dest, buf, n);
-    }
-
-    /* Add FIFO wraparound if needed */
-    len -= n;
-    len = MIN(len, fifo8_num_used(fifo));
-    if (len) {
-        buf = fifo8_pop_bufptr(fifo, len, &n2);
-        if (dest) {
-            memcpy(&dest[n], buf, n2);
-        }
-        n += n2;
-    }
-
-    return n;
-}
-
 static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
 {
-    uint32_t len = esp_fifo8_pop_buf(&s->fifo, dest, maxlen);
+    uint32_t len = fifo8_pop_buf(&s->fifo, dest, maxlen);
 
     esp_update_drq(s);
     return len;
@@ -335,7 +305,7 @@ static void do_command_phase(ESPState *s)
     if (!cmdlen || !s->current_dev) {
         return;
     }
-    esp_fifo8_pop_buf(&s->cmdfifo, buf, cmdlen);
+    fifo8_pop_buf(&s->cmdfifo, buf, cmdlen);
 
     current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
     if (!current_lun) {
@@ -381,7 +351,7 @@ static void do_message_phase(ESPState *s)
     /* Ignore extended messages for now */
     if (s->cmdfifo_cdb_offset) {
         int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
-        esp_fifo8_pop_buf(&s->cmdfifo, NULL, len);
+        fifo8_pop_buf(&s->cmdfifo, NULL, len);
         s->cmdfifo_cdb_offset = 0;
     }
 }
diff --git a/util/fifo8.c b/util/fifo8.c
index 5bbb6150b60..a250ea9f804 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -102,6 +102,35 @@ const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     return fifo8_peekpop_buf(fifo, max, numptr, true);
 }
 
+uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+{
+    const uint8_t *buf;
+    uint32_t n1, n2 = 0;
+    uint32_t len;
+
+    if (destlen == 0) {
+        return 0;
+    }
+
+    len = destlen;
+    buf = fifo8_pop_bufptr(fifo, len, &n1);
+    if (dest) {
+        memcpy(dest, buf, n1);
+    }
+
+    /* Add FIFO wraparound if needed */
+    len -= n1;
+    len = MIN(len, fifo8_num_used(fifo));
+    if (len) {
+        buf = fifo8_pop_bufptr(fifo, len, &n2);
+        if (dest) {
+            memcpy(&dest[n1], buf, n2);
+        }
+    }
+
+    return n1 + n2;
+}
+
 bool fifo8_is_empty(Fifo8 *fifo)
 {
     return (fifo->num == 0);
-- 
2.41.0


