Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EBC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvai-0000eR-W6; Mon, 22 Jul 2024 12:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvah-0000YP-8H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvad-0007qV-LP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so38728365e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664520; x=1722269320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLrYF0/Wx1i/Oi595G8nLiFu8j75+0aJtBHlGLk36ig=;
 b=K9YNVqLtWWTk+hxjMwf9Eatx1nXW+GfNWMwXRDGVMbXBREsT24Sh3+Rn6vzdaHlOXC
 YTHN6aYKqXS8b2nlRblCPlgwiCMp9PmyHMpCkarljXx0N4pruHFRpE+scBEx9WmNdK9D
 pb6pOP/iopkk/1cl3yoswM6JFh1EWRUSS7mT/wJlzbrhzbKmZf10PAAivQp+7XV+zZ4C
 CoOAi8ISS3AuO+pKEr2Kec/k1Vjx6CBym17pqHOL6jVrBft15dqV6pNtXi62urqSfnAK
 9iUoQW+rZEPgZIleJwm0CAf7QVuKmxt0SYKu61urMPEP/YDgg7yuPoUyZ/bEfQF+ieVt
 GVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664520; x=1722269320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLrYF0/Wx1i/Oi595G8nLiFu8j75+0aJtBHlGLk36ig=;
 b=cfJbu0wlgoWQIrB6N0ooYnZ2lp9EV0dCfcN0gmkOLIUoG+aRcSfRlhOm0pSSQaTsZv
 W5VnqYmfBy63yy+iq6xPdy9NVu5L+toS5QDkNqHlmzunEYKRuyrjeMzT3fVOQprN7EbI
 MLA9YE776VZzNUtc9PX0CBbnChlaiy7KfMELEOYEmWXXZVokM2yfJbt5JDEALfvmg9+h
 GXh0O4cpAo/PDOHwv8zj+HGzlAZ04qH/mZgVW86SxZ58LR8x/zvtY/FUWHKPwqRNbC8H
 rr3TLJ/gg/Azsc2UJfl30Piszi16Kv/zrLD+b0KydTxSBt2Em6BJGPYIAWRIRJz6PELU
 eT4Q==
X-Gm-Message-State: AOJu0YwLDPcY5MMeLUPzKtI7/qYVTMkS1ohyCo9onEx4UKt5x/lSeLsJ
 Lt+kKqKWEkMwqzj/Oo68ZXWrpRvYPapxNLcZJ0Ym5yVFR6G9gVjGUt5mB20vQitI+LYnYYagF/r
 m
X-Google-Smtp-Source: AGHT+IGmGU63KNcR5lhPUTQT673NSNTIExqPMcMydnIJUtRXt0pgBbXK6AJt59/e9lh+rA71DDL5TA==
X-Received: by 2002:a05:600c:3b26:b0:426:5b44:2be7 with SMTP id
 5b1f17b1804b1-427dc5204bfmr69229835e9.10.1721664520226; 
 Mon, 22 Jul 2024 09:08:40 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e29d11d5sm66473215e9.38.2024.07.22.09.08.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:08:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] util/fifo8: Introduce fifo8_discard()
Date: Mon, 22 Jul 2024 18:07:45 +0200
Message-ID: <20240722160745.67904-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
References: <20240722160745.67904-1-philmd@linaro.org>
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

Add the fifo8_discard() helper for clarity.
It is a simple wrapper over fifo8_pop_buf().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 8 ++++++++
 hw/scsi/esp.c        | 2 +-
 util/fifo8.c         | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 21c7a22937..53bafabd25 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -129,6 +129,14 @@ const uint8_t *fifo8_pop_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  */
 const uint8_t *fifo8_peek_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
+/**
+ * fifo8_discard:
+ * @fifo: FIFO to consume bytes
+ *
+ * Discard (consume) bytes from a FIFO.
+ */
+void fifo8_discard(Fifo8 *fifo, uint32_t len);
+
 /**
  * fifo8_reset:
  * @fifo: FIFO to reset
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index cec847b54a..c703fa7351 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -351,7 +351,7 @@ static void do_message_phase(ESPState *s)
     /* Ignore extended messages for now */
     if (s->cmdfifo_cdb_offset) {
         int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
-        fifo8_pop_buf(&s->cmdfifo, NULL, len);
+        fifo8_discard(&s->cmdfifo, len);
         s->cmdfifo_cdb_offset = 0;
     }
 }
diff --git a/util/fifo8.c b/util/fifo8.c
index 6610b79182..ea39ca2552 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -131,6 +131,12 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     return n1 + n2;
 }
 
+void fifo8_consume(Fifo8 *fifo, uint32_t len)
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


