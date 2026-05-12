Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62252CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgVz-0000qS-FL; Tue, 12 May 2026 02:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVk-0000gA-B6
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVh-00049x-VG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so3704846f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566947; x=1779171747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EQnBp7Gj5TcacccipAB/n9mwbGRUt4USwHdRZECWo90=;
 b=j8Om0IbxselFUDMQTowKTxHgsRuE9LAt9cj517PsMOaSR5ob6kfwTX4LZ7G5ekgqG6
 Kb9Y1tLR3u0cW2B900LkYcTKkmE/dGs6/gREdxvKP8AxzJsky5RzWUFwjwZCtoDOym5Q
 +ipK9j+gbCGiksuj/wJN6I6PbnZUFO08Z/W9geVlN8+9V/+fDfihqLjBMdEPBd1zUscy
 noqXR6X0ToSWEFI0hwSRuZr1xTaM8V3VJ++xWM0mINwHFRqh9/K/M61vMT1muUtYu+QH
 DXogtcMn5ZvNlpz7DwiTotBWWtN0tO9wi09T5W+CqcJbjsEfYWZsoChKWv7OnWB7d3II
 YM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566947; x=1779171747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EQnBp7Gj5TcacccipAB/n9mwbGRUt4USwHdRZECWo90=;
 b=NSoc6w7bv+a51glkSTsCCFaTXUYAGFwxRnUuEb2KeWspt1NHHWnUiOy5OGcDi63E5G
 ZYPXWHBG7Edvm8LlUmxTYfYSS1c2TnRhiElZ44KL9JgUy2PQYpqNZYC3/HPBQrqRMQPS
 jg+y3Je5Bu9z4BV5mIyD8SK1YahWPgo4MaUkVJfPaVHRolZ58DVizfTa/V0I8ZpdNWtT
 xqWs+N4JNs/gwHZB3cGHSF9bi7win9pu+HlIZ+RCpkIZWJo1aNqneav5qWYIJhLbbnCk
 xY62H3hUewaAEAzfnaaQ+isZ4sbON8XTLv0LAwlMwuRM1MbDP7zqi3alD9Du1UQa0qy3
 h0zw==
X-Gm-Message-State: AOJu0YzwAFUD9Wqi33eks31YPBUam1IjQ/gDEW+/6EAduTYe7h45K8Ds
 /Na1Dxvj0O0rZ7vp90qDK+vOYM/jK4VwUAYUVN2SzBBK/q2yT0amC9WNQ0yk5ooDhkcVCJYSiuc
 fgNltjfA=
X-Gm-Gg: Acq92OGI6+4Cp1j3pvMv7c8vyQcVFLsm16/t/m6JE8mcFMEoEBxGMdksQg0y8dbqf7Y
 LnEda/wji8nUUV66WEObioT4ml2kilBcdU/3hd4P6OuSa75D3zCDuTgulbMRYpQaj/rk4URVycK
 6RWa811tU1SK6ZoHv74t4K5FcyhDPg4h4kW3SuJv1E87nr3Jusk2a+ys0lkARx67rfCFa5LnAyj
 HPlhUmEqtfZSNR2b3TvntmGxs3VZlYEY8TeLJy6PP1yGGMCX5hChK4bEDILFaakB7cwGHqJnaJo
 5M1PwDDfFNFDQ6+lUPpJ9u24lAwT/NL4Ovo++h2hx1UiAPC4PUmrpfkPBEBH2XJ1MCVq6lQn6EM
 gn/rK+1zhwnIs4mGgcLSruKkX2GQ4DYZHpGvLQrSP+nJ2hEVvqux3CrAzdDo1iPWzKJVj5m6w0T
 9zfCqkvcTopaFeLdqpjrHkC7axBv9Dy4SL5TptYYprS0xphv9D9f1CYlAw7NOZlJ/aFbxUAvhS
X-Received: by 2002:a05:6000:2386:b0:43f:e938:1e67 with SMTP id
 ffacd0b85a97d-4515d99fff7mr42996127f8f.38.1778566947377; 
 Mon, 11 May 2026 23:22:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm29571592f8f.20.2026.05.11.23.22.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] hw/sd/sd: Allow multi-byte read/write for generic paths
Date: Tue, 12 May 2026 08:21:07 +0200
Message-ID: <20260512062142.67998-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Christian Speich <c.speich@avm.de>

Paths that use sd_generic_write/read_data can now write/read multiple
bytes with one call.

Signed-off-by: Christian Speich <c.speich@avm.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260417-sdcard-performance-b4-v4-2-119e66be10c2@avm.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 62 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c0b89735f69..b49b83b96e8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1610,7 +1610,7 @@ static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
-/* Configure fields for following sd_generic_write_byte() calls */
+/* Configure fields for following sd_generic_write_data() calls */
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
 {
@@ -1625,7 +1625,7 @@ static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
     return sd_r1;
 }
 
-/* Configure fields for following sd_generic_read_byte() calls */
+/* Configure fields for following sd_generic_read_data() calls */
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
                                            const void *data, size_t size)
@@ -2615,11 +2615,15 @@ send_response:
 }
 
 /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
-static bool sd_generic_write_byte(SDState *sd, uint8_t value)
+static bool sd_generic_write_data(SDState *sd, const void *buf, size_t *len)
 {
-    sd->data[sd->data_offset] = value;
+    size_t to_write = MIN(sd->data_size - sd->data_offset, *len);
 
-    if (++sd->data_offset >= sd->data_size) {
+    memcpy(sd->data, buf, to_write);
+    sd->data_offset += to_write;
+    *len = to_write;
+
+    if (sd->data_offset >= sd->data_size) {
         sd->state = sd_transfer_state;
         return true;
     }
@@ -2627,11 +2631,15 @@ static bool sd_generic_write_byte(SDState *sd, uint8_t value)
 }
 
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
-static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+static bool sd_generic_read_data(SDState *sd, void *buf, size_t *len)
 {
-    *value = sd->data[sd->data_offset];
+    size_t to_read = MIN(sd->data_size - sd->data_offset, *len);
 
-    if (++sd->data_offset >= sd->data_size) {
+    memcpy(buf, sd->data, to_read);
+    sd->data_offset += to_read;
+    *len = to_read;
+
+    if (sd->data_offset >= sd->data_size) {
         sd->state = sd_transfer_state;
         return true;
     }
@@ -2658,18 +2666,12 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return length;
 
-    /*
-     * Only read one byte at a time. We will be called again with the
-     * remaining.
-     */
-    length = 1;
-
     trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
                             sd->current_cmd, sd->data_offset, value[0]);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
@@ -2681,6 +2683,12 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
+        /*
+         * Only read one byte at a time. We will be called again with the
+         * remaining.
+         */
+        length = 1;
+
         if (sd->data_offset == 0) {
             /* Start of the block - let's check the address is valid */
             if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
@@ -2724,7 +2732,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
@@ -2742,7 +2750,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
@@ -2765,7 +2773,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        if (sd_generic_write_byte(sd, value[0])) {
+        if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
@@ -2775,7 +2783,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd_generic_write_byte(sd, value[0]);
+        sd_generic_write_data(sd, buf, &length);
         break;
 
     default:
@@ -2810,12 +2818,6 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         return length;
     }
 
-    /*
-     * We will only read one byte at a time. We will be called again with the
-     * remaining buffer.
-     */
-    length = 1;
-
     io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
@@ -2833,10 +2835,16 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 51: /* ACMD51: SEND_SCR */
     case 56: /* CMD56:  GEN_CMD */
-        sd_generic_read_byte(sd, value);
+        sd_generic_read_data(sd, buf, &length);
         break;
 
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
+        /*
+         * We will only read one byte at a time. We will be called again with
+         * the remaining buffer.
+         */
+        length = 1;
+
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
@@ -2869,7 +2877,7 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT read illegal for command %s\n",
                                        __func__, sd->last_cmd_name);
-        *value = dummy_byte;
+        memset(buf, dummy_byte, length);
     }
 
     return length;
-- 
2.53.0


