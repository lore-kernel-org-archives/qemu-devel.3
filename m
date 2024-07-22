Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30531C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvab-0008JW-Gn; Mon, 22 Jul 2024 12:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvaZ-000886-Hn
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvaW-0007pM-Q4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso2099841f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664514; x=1722269314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGm6Mz1jj/9Q+YEDysgdokwei7I83wY7MgFeQkOcKf0=;
 b=JdjdY55byPLMPG+fk+Dcqbn+dH3pk0WXmxp0000EIyGSuPGvB7gr7+UK0h058/KEOp
 4umhkTUjQQigTuhqIZRjMgRDAcSPLiS0XSgyE38/ap2ERbuWkD+Uj1NoODtbuFMrlWSK
 +2djAQi+/iAYQmiMRVzWviNEMlMSMLQEpE6siOqYsckKJf4hpCuenCfX9jFOAICkWn2d
 UPhhT7ViUOcL+roH1/CLy/bWGuG9S79n0HYZE7FKPtJZoPa24KTTpNi0fCes2Yochwrw
 INwcD8qW9s53Lla4nMeYDgV6pqiDs0UYOx2F81iPuANZw79zpFFm+MI8D13xZCBbYdtA
 aP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664514; x=1722269314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGm6Mz1jj/9Q+YEDysgdokwei7I83wY7MgFeQkOcKf0=;
 b=glf2uWNyz3DoMtdhJXUHxofm6oPgkumm/CQQLYL4Zli3EGyikwoh9ULheKcsFArb6A
 CgZurkhPT2Kl8qv0W8xx+jqAfdGmd7aLSJ11iblilwU8h//Nj1a01pBqFc7leb3FXRfi
 PHhJ2th1AXMwmHwJiJJteFWRtzza64cyOaOLL9HmgQNTI9qMf/PYCq9XYxDO9RoeWviJ
 hOMXXOFX8nNQye8MzpTatAvmPJHCaeHmV9uLCYhZkw/8VSqGpeST4Krk0JKG9fwtRAZQ
 7WGMoA3aAOyWc9fCUnm3WqkrcQqPt7kuThj8tnMTBvzXUv0r3OJc9JFq0ZTSMvpFf9nD
 vNzA==
X-Gm-Message-State: AOJu0YxULcuewzlFxyoXrrpDDOJ64DA2nzeWC9sEuZqYWsAWeYd2Csyz
 n0IF6I/00kFpZMxo9XiPCdZDKK0CQY3QQelOAALbmFwVguQzUUHMGpjsEF+4Pqjdlids+JDQ4fO
 p
X-Google-Smtp-Source: AGHT+IHcH+R92EgVUUK7+rC/5DXJUPRBaCYhT4ZqdHKasDuq1aj6JEc4vlAP87+dMEui+yHCllfbhw==
X-Received: by 2002:a05:6000:4e6:b0:368:5a32:f5bc with SMTP id
 ffacd0b85a97d-369dee4fa8dmr206590f8f.38.1721664513985; 
 Mon, 22 Jul 2024 09:08:33 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b5fdsm8860554f8f.38.2024.07.22.09.08.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:08:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] util/fifo8: Expose fifo8_pop_buf()
Date: Mon, 22 Jul 2024 18:07:44 +0200
Message-ID: <20240722160745.67904-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
References: <20240722160745.67904-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Extract fifo8_pop_buf() from hw/scsi/esp.c and expose
it as part of the <qemu/fifo8.h> API. This function takes
care of non-contiguous (wrapped) FIFO buffer (which is an
implementation detail).

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 14 ++++++++++++++
 hw/scsi/esp.c        | 36 +++---------------------------------
 util/fifo8.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 686918a3a4..21c7a22937 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -62,6 +62,20 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
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
  * fifo8_pop_constbuf:
  * @fifo: FIFO to pop from
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 64384f9b0e..cec847b54a 100644
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
-    buf = fifo8_pop_constbuf(fifo, len, &n);
-    if (dest) {
-        memcpy(dest, buf, n);
-    }
-
-    /* Add FIFO wraparound if needed */
-    len -= n;
-    len = MIN(len, fifo8_num_used(fifo));
-    if (len) {
-        buf = fifo8_pop_constbuf(fifo, len, &n2);
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
index 31f0d34c0c..6610b79182 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -102,6 +102,35 @@ const uint8_t *fifo8_pop_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
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
+    buf = fifo8_pop_constbuf(fifo, len, &n1);
+    if (dest) {
+        memcpy(dest, buf, n1);
+    }
+
+    /* Add FIFO wraparound if needed */
+    len -= n1;
+    len = MIN(len, fifo8_num_used(fifo));
+    if (len) {
+        buf = fifo8_pop_constbuf(fifo, len, &n2);
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


