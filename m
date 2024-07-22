Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9ECC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvaU-0007UU-4r; Mon, 22 Jul 2024 12:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvaP-0007F6-Tv
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvaL-0007nl-Hy
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso33735985e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664502; x=1722269302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5IVJQKs0mRewT92ekkS2OE3V+7eufImd7ZnhLfAtiw=;
 b=QTXgPtLCanqqaoj8ztYfRyGNp7OdOHfMN/jCgmGlh8F5WfxrzZHMdxhcyqRj9/qGRC
 PV4P0mxJV6denC5cTxQxOmEGyfYfTs59+D5eYtZVIgGzBvd9ebC++m5E8Im8/CLeM7Uz
 Khc1zZpKpAgXW66naP07dKbcywx2tW8f4VR0YAaKxuXBSQSZC0kCeAMgZ1pK4S1q/O95
 wn5yH8xxoKbjg30FSRVZUcylZIxwgYLzLw+IGLS4WnUOZZDm7eoLdXU4NDLbSupV9mHf
 oz7Q36Bx8lwOJjmxOYa15PrGJzasUkbZQG0v5IjW6INr7+RCg96XxC38BQSJ7VWpNmE9
 yD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664502; x=1722269302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5IVJQKs0mRewT92ekkS2OE3V+7eufImd7ZnhLfAtiw=;
 b=cuTkbo/TfEtYrxoLgdMkHxJsNg7m+b3go3SvGJxJ8lWXV/5hdI5e/MtVyvkiuczSS/
 S6uCPXp4lUKCwx9est7u6PaeOVTrK+RmnYzVYPcoeJmoo/3xIXpmzX3BOXleMg7noBzA
 7+n9jNybsG9ecPloiDZc1cx0DnsevtZX1yL72AdhVXQsRhE9Fifkuaz6R1R5kpThSs7t
 X5T3GmxcTnfwYtPAIXzOxETUD0jBMVDokbZ/oyYt+wpnAFUYUiRR8sBMyx0PFEPeOw2t
 oRIYWpCiqv516XIlO5y2QNEBAy6Hgjgj8vpOvjIjOVLRG+2j48kBVV72osKa7fQMRpkZ
 Uz7Q==
X-Gm-Message-State: AOJu0YyK1nmjKEl8MBJ3D9FDaoAzY4NhSX+CvNoeEKq60Z2SaLbYVeKO
 wXZyGbPmpo4xljW7V8mrpxkSPK6ziCbHxJ24ugk36TlZBY0HGLdYfGWedibIndXXLc+D8m/NiR9
 8
X-Google-Smtp-Source: AGHT+IES0/0Gp6R84KpnzozIZodYH7Kb9siP7ixWABhurMCjoRnsqoUxlHz7lH8/H+pAi3dKtB6eWg==
X-Received: by 2002:a05:600c:1c9e:b0:423:791:f446 with SMTP id
 5b1f17b1804b1-427dc51a01emr45867695e9.7.1721664491827; 
 Mon, 22 Jul 2024 09:08:11 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a7257esm158849065e9.28.2024.07.22.09.08.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:08:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] util/fifo8: Rename fifo8_peek_buf() ->
 fifo8_peek_constbuf()
Date: Mon, 22 Jul 2024 18:07:42 +0200
Message-ID: <20240722160745.67904-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
References: <20240722160745.67904-1-philmd@linaro.org>
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

Since fifo8_peek_buf() return a const buffer (which points
directly into the FIFO backing store), rename it using the
'constbuf' suffix. This will help differentiate with methods
*copying* the FIFO data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 4 ++--
 hw/scsi/esp.c        | 2 +-
 util/fifo8.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 2692d6bfda..79450f4583 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -89,7 +89,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
 const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
- * fifo8_peek_buf: read upto max bytes from the fifo
+ * fifo8_peek_constbuf: read upto max bytes from the fifo
  * @fifo: FIFO to read from
  * @max: maximum number of bytes to peek
  * @numptr: pointer filled with number of bytes returned (can be NULL)
@@ -113,7 +113,7 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  *
  * Returns: A pointer to peekable data.
  */
-const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
+const uint8_t *fifo8_peek_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
  * fifo8_reset:
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8504dd30a0..526ed91bef 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -486,7 +486,7 @@ static bool esp_cdb_ready(ESPState *s)
         return false;
     }
 
-    pbuf = fifo8_peek_buf(&s->cmdfifo, len, &n);
+    pbuf = fifo8_peek_constbuf(&s->cmdfifo, len, &n);
     if (n < len) {
         /*
          * In normal use the cmdfifo should never wrap, but include this check
diff --git a/util/fifo8.c b/util/fifo8.c
index 2925fe5611..21943c6032 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -92,7 +92,7 @@ static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
     return ret;
 }
 
-const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+const uint8_t *fifo8_peek_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
     return fifo8_peekpop_buf(fifo, max, numptr, false);
 }
-- 
2.41.0


