Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AFEC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJh-00047s-Fm; Tue, 23 Jul 2024 16:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJf-0003mr-Gd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJd-0004V5-F6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso44621845e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767256; x=1722372056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TB/f/Th1FBB1dNgfWZKdme0n287GDsmesKr4d3trepo=;
 b=c3cVSXDAPweGChM6QtjXryqtaN3hOBKpRCgYCbX7r4snywe0psuWLfcJtLjvJTmPlY
 tsKjJdTUBjMmbyji3Mq9SoUk103kMtyIWmPze/bRhOzNblPJf9lYG77adSeHqOozgdLY
 gm8PWjUtBqpkE3nUrf1CkDY1PgqNr8hwANy10f/Rn8IIMoU94SvQiOPtUsyCQvQjzbAm
 cNx+TIgJmuNVhuKkAjL/FakB2CHDsxTu7MDiIutCkqO36gX93w/gDE+CqaoZ5lZkOI8N
 bsi1WK7tjUEhBR5GhsA2RvubiiT5Mj1szMaWovTgmpqKL39KDEv5Xf5DZqC7t1ZY57Mb
 dLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767256; x=1722372056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TB/f/Th1FBB1dNgfWZKdme0n287GDsmesKr4d3trepo=;
 b=MO2UoWjMQR9KGCTWKesxTHUJDwQMSjo31b6TLh2ISw+rKUZE+wbm6P46JDepjDIYZx
 Clbgk1TqPmdU60CtjPZk8f6eZ9ZqDAL2oAinFx0oloyjj4/RkHxYUCSM+wUPp7RKZZDS
 vhjx6bCFEp7Tltr/MSF8gRxmhwGTg5J9FbQOQd7Df9CS6IT1MaSKOV/exm93GNb011gz
 P/D43zQFcyC90Yt4BJq0fYHVprlaGGjMw3Sx0L4Ibw+rXt7L76rZRIosyU+wic85Q+qr
 J8hogpQQagxdSrZi1YQydsI1WXcRZGgPsm5bC1yyA1wN0TA6U85KrXRfbUXNOdTSw4vL
 KQFA==
X-Gm-Message-State: AOJu0YxIMx4wKG+3Mhhr/7raJkvcCB/X7tSHdZDjBP5xpE6cYIajAoFp
 O/UWG2CBz8FvwfEN2hIvUiEok72cgf5dvSa25or0lxzx7i9zoQ0WbvMEVwJnv0FR7S7HF9/DP6D
 8tcA=
X-Google-Smtp-Source: AGHT+IHWNE7nBjtTGWYiT80ToYlRD+1DGCLycdnABF1UWiajbMWWd6H3kBCwAN2Rm4VVjCxA8/xq7A==
X-Received: by 2002:a05:6000:1f8d:b0:367:8aa2:d41f with SMTP id
 ffacd0b85a97d-369f5bb44cdmr34324f8f.51.1721767255622; 
 Tue, 23 Jul 2024 13:40:55 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368785c58e7sm12582641f8f.0.2024.07.23.13.40.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 21/28] util/fifo8: Fix style
Date: Tue, 23 Jul 2024 22:38:48 +0200
Message-ID: <20240723203855.65033-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240722160745.67904-3-philmd@linaro.org>
---
 include/qemu/fifo8.h | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index c6295c6ff0c..2692d6bfdaa 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -15,10 +15,9 @@ typedef struct {
  * @fifo: struct Fifo8 to initialise with new FIFO
  * @capacity: capacity of the newly created FIFO
  *
- * Create a FIFO of the specified size. Clients should call fifo8_destroy()
+ * Create a FIFO of the specified capacity. Clients should call fifo8_destroy()
  * when finished using the fifo. The FIFO is initially empty.
  */
-
 void fifo8_create(Fifo8 *fifo, uint32_t capacity);
 
 /**
@@ -26,9 +25,8 @@ void fifo8_create(Fifo8 *fifo, uint32_t capacity);
  * @fifo: FIFO to cleanup
  *
  * Cleanup a FIFO created with fifo8_create(). Frees memory created for FIFO
-  *storage. The FIFO is no longer usable after this has been called.
+ * storage. The FIFO is no longer usable after this has been called.
  */
-
 void fifo8_destroy(Fifo8 *fifo);
 
 /**
@@ -39,7 +37,6 @@ void fifo8_destroy(Fifo8 *fifo);
  * Push a data byte to the FIFO. Behaviour is undefined if the FIFO is full.
  * Clients are responsible for checking for fullness using fifo8_is_full().
  */
-
 void fifo8_push(Fifo8 *fifo, uint8_t data);
 
 /**
@@ -52,7 +49,6 @@ void fifo8_push(Fifo8 *fifo, uint8_t data);
  * Clients are responsible for checking the space left in the FIFO using
  * fifo8_num_free().
  */
-
 void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
 
 /**
@@ -64,7 +60,6 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
  *
  * Returns: The popped data byte.
  */
-
 uint8_t fifo8_pop(Fifo8 *fifo);
 
 /**
@@ -73,7 +68,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  * @max: maximum number of bytes to pop
  * @numptr: pointer filled with number of bytes returned (can be NULL)
  *
- * Pop a number of elements from the FIFO up to a maximum of max. The buffer
+ * Pop a number of elements from the FIFO up to a maximum of @max. The buffer
  * containing the popped data is returned. This buffer points directly into
  * the FIFO backing store and data is invalidated once any of the fifo8_* APIs
  * are called on the FIFO.
@@ -82,7 +77,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  * around in the ring buffer; in this case only a contiguous part of the data
  * is returned.
  *
- * The number of valid bytes returned is populated in *numptr; will always
+ * The number of valid bytes returned is populated in *@numptr; will always
  * return at least 1 byte. max must not be 0 or greater than the number of
  * bytes in the FIFO.
  *
@@ -99,7 +94,7 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  * @max: maximum number of bytes to peek
  * @numptr: pointer filled with number of bytes returned (can be NULL)
  *
- * Peek into a number of elements from the FIFO up to a maximum of max.
+ * Peek into a number of elements from the FIFO up to a maximum of @max.
  * The buffer containing the data peeked into is returned. This buffer points
  * directly into the FIFO backing store. Since data is invalidated once any
  * of the fifo8_* APIs are called on the FIFO, it is the caller responsibility
@@ -109,7 +104,7 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  * around in the ring buffer; in this case only a contiguous part of the data
  * is returned.
  *
- * The number of valid bytes returned is populated in *numptr; will always
+ * The number of valid bytes returned is populated in *@numptr; will always
  * return at least 1 byte. max must not be 0 or greater than the number of
  * bytes in the FIFO.
  *
@@ -126,7 +121,6 @@ const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  *
  * Reset a FIFO. All data is discarded and the FIFO is emptied.
  */
-
 void fifo8_reset(Fifo8 *fifo);
 
 /**
@@ -137,7 +131,6 @@ void fifo8_reset(Fifo8 *fifo);
  *
  * Returns: True if the fifo is empty, false otherwise.
  */
-
 bool fifo8_is_empty(Fifo8 *fifo);
 
 /**
@@ -148,7 +141,6 @@ bool fifo8_is_empty(Fifo8 *fifo);
  *
  * Returns: True if the fifo is full, false otherwise.
  */
-
 bool fifo8_is_full(Fifo8 *fifo);
 
 /**
@@ -159,7 +151,6 @@ bool fifo8_is_full(Fifo8 *fifo);
  *
  * Returns: Number of free bytes.
  */
-
 uint32_t fifo8_num_free(Fifo8 *fifo);
 
 /**
@@ -170,7 +161,6 @@ uint32_t fifo8_num_free(Fifo8 *fifo);
  *
  * Returns: Number of used bytes.
  */
-
 uint32_t fifo8_num_used(Fifo8 *fifo);
 
 extern const VMStateDescription vmstate_fifo8;
-- 
2.41.0


