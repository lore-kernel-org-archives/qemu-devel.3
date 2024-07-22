Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8323C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVva4-0005ym-W7; Mon, 22 Jul 2024 12:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVva2-0005sO-62
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvZz-0007hE-Ej
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso29846205e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664480; x=1722269280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xJItyCJvAqsvrHU7PZNhwclTP7/Jt4LLoVoT2duvA4=;
 b=FVn1Wsq3Md3trySmqkfE6FomzYGZFvBMtvOHBrKyfhNr/9Ec6mhBiVQn529Bq8Ufv1
 /TxSEnbyITh1B0ivq8mKT26o6wHA9I1Dhrkxv1zfWjX80+bP+hhoUSB9q3COq++BBj0x
 bzQ+YaxYpzwa9dHlVSgtCk94dPVjxYDf/8lJz+r5tizHlFTKw8UWdzlWVeos2rjfOmWA
 vz2ziZhmmIFZ+2ID9aQc6TD/JG5zxhp0JJiy2xHrcJ1m8OAFGm/Wq/kI4sjI65w7iMHs
 RtsM3WZKBd7VfxqaekDPnUKMF/wdLmhOOiepWpbHSPXw2ibtxyl1VSCeyDVX50pSyDhV
 QQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664480; x=1722269280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xJItyCJvAqsvrHU7PZNhwclTP7/Jt4LLoVoT2duvA4=;
 b=tXSCm2CwhE/UdRmeA7RJdUqkMpv3cCrS4/rVsC8mUl9t1wn/I49FVfKzEf7Qaee1JD
 j3oH+6mUKqvpMAf45bni/KDnrcAo9B06rM+6d7bliAbKBqfZw1IjTvauWKJnC8mQ/i9h
 Z6ANP+tWXk4IIC+Ukccw63rMo/W0c8KZ7l//hAUq04BbCw0DCnTgVzfvB1x9R364/CEr
 9NbR94GHeVMzvJPs2m8L/yJSS9r5reN3Oy9o7Vpke8FOfVuIpbzGGjCpjQjT3bW9ANkV
 Du808ALcjFXx2njkhkKiUtcdWnfS477O5M2Gl6M4FfTnArHJpXMDlS2B9GrymoL5lvhH
 1IUA==
X-Gm-Message-State: AOJu0YyDO4SeKXLLrzZGubgV+TCRbbm63Nszv5+9PXIm9Atg5O150y9W
 QxHkbPQKUDwpORlQvJ1oat3nfnVthJDCwS6JzWLOh+1PY9XfItKVM+RGHl7IRyRPxwp8XCZafOX
 Y
X-Google-Smtp-Source: AGHT+IFqArkBzzba1fN0z7xyB/r40W2L6JmFpYslhqOtrFoHGSCCadHo/zv77pYzxAPvfGOTsoCTqg==
X-Received: by 2002:a05:600c:3c9d:b0:426:6099:6eaa with SMTP id
 5b1f17b1804b1-427daa61cddmr54009415e9.26.1721664480241; 
 Mon, 22 Jul 2024 09:08:00 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa394sm132786425e9.3.2024.07.22.09.07.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:07:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] util/fifo8: Fix style
Date: Mon, 22 Jul 2024 18:07:40 +0200
Message-ID: <20240722160745.67904-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
References: <20240722160745.67904-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
---
 include/qemu/fifo8.h | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index c6295c6ff0..2692d6bfda 100644
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


