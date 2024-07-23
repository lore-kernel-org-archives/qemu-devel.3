Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB328C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMKp-0003Rw-Fg; Tue, 23 Jul 2024 16:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMK8-0008W3-VM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMK4-0004Wa-Um
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so52257015e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767283; x=1722372083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edehD0KtGJ7psWAUTWuwqxCMF33mNrSx960MdEztH2M=;
 b=vag+/qlONDv73l2xtzfaO5MXyl9llE2JAgw8zhlFG7KtSPkSDHity8oDZlRijD1OS6
 +pMg0KJ7H8ehLmei39ZDZ4DNfwAGmMAlECDXDNsVtm8wyHAgLcViLXQmf0TDkxoz6aH8
 luufZOedVG0qtiR7aEdb8GQZHTHpbT4YyZeEUOGxBFYh8zE+NC0dPYKQ26qknst02Nya
 rIcUpnF/mbpJVJi3BD+BJ4Dq4UIrpcd5FntCvjUuMSN48F72f7G/w3MOp5j/D0QUC+15
 pVztovDzg2k/idQ9F62pd9B1Vq3Vi/lGDsNa1crf9Z5KAnwno5xY8+LkZGMEcLx/ul9/
 Z2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767283; x=1722372083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edehD0KtGJ7psWAUTWuwqxCMF33mNrSx960MdEztH2M=;
 b=Km7wOqiAykMRRvAiD/+8ud7qxxesTJt+kB8lqWcFraL5T1GDzYZQUGS3YqMJ7mJg9J
 qnGuD6BGLYodHhEVyF19YyynTokkjjindObaVlCVUc+QkxDfIiZdkrlBQETo1Ij6F/yu
 CBcktoReITRNmG97U5yf/ccG0Q8GTKVz/DIH5tqqbp296V4FQqAGAzr2/ufgzOyxeRY3
 5p4FJXMn8vkWCS8G4WNrXyP5CpOcOaeBWkryZUfPsbCmOkC3jBZjg8bzYhMKVn6Ugk3a
 /mlo5E5sfRT0HLHjulAsGpX8IfwFnfL7hJkUek6PVtgI3REdaXBy1p5re92RSdgvvoa3
 MqZg==
X-Gm-Message-State: AOJu0YwzIgSvw9SnVUZsvfJBvEoq04G9Y5whGO7jKPDVCEVxui8O1waq
 1KySttMvriyMBIFLddFr6PpS8BOGJtAqrfSZeUSv9qTyM7kYyZxzw1/LjSoTGpMjJo2QSVaXiGd
 YcYY=
X-Google-Smtp-Source: AGHT+IHfiMIerRfkNnqj78mw4GHum7yCps2MykY5abNv3AQZOeoYzpsWQZ/RX8wkZoB8cfudZEMdOg==
X-Received: by 2002:a05:600c:3ac5:b0:426:673a:2904 with SMTP id
 5b1f17b1804b1-427f7adf206mr4570065e9.36.1721767282776; 
 Tue, 23 Jul 2024 13:41:22 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f935dd83sm598555e9.5.2024.07.23.13.41.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:41:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 26/28] util/fifo8: Introduce fifo8_drop()
Date: Tue, 23 Jul 2024 22:38:53 +0200
Message-ID: <20240723203855.65033-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Add the fifo8_drop() helper for clarity.
It is a simple wrapper over fifo8_pop_buf().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240722160745.67904-8-philmd@linaro.org>
---
 include/qemu/fifo8.h | 9 +++++++++
 hw/scsi/esp.c        | 2 +-
 util/fifo8.c         | 6 ++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index bca6da306f7..d1d06754d84 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -131,6 +131,15 @@ const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  */
 const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
+/**
+ * fifo8_drop:
+ * @fifo: FIFO to drop bytes
+ * @len: number of bytes to drop
+ *
+ * Drop (consume) bytes from a FIFO.
+ */
+void fifo8_drop(Fifo8 *fifo, uint32_t len);
+
 /**
  * fifo8_reset:
  * @fifo: FIFO to reset
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 04c9a557b69..b7af8256232 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -351,7 +351,7 @@ static void do_message_phase(ESPState *s)
     /* Ignore extended messages for now */
     if (s->cmdfifo_cdb_offset) {
         int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
-        fifo8_pop_buf(&s->cmdfifo, NULL, len);
+        fifo8_drop(&s->cmdfifo, len);
         s->cmdfifo_cdb_offset = 0;
     }
 }
diff --git a/util/fifo8.c b/util/fifo8.c
index a250ea9f804..1ffa19d900e 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -131,6 +131,12 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     return n1 + n2;
 }
 
+void fifo8_drop(Fifo8 *fifo, uint32_t len)
+{
+    len -= fifo8_pop_buf(fifo, NULL, len);
+    assert(len == 0);
+}
+
 bool fifo8_is_empty(Fifo8 *fifo)
 {
     return (fifo->num == 0);
-- 
2.41.0


