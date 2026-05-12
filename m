Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F180CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtsZ-00010i-IZ; Tue, 12 May 2026 16:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMtsW-0000vW-ML
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:38:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMtsU-00047m-Fl
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:38:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso3305244f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618332; x=1779223132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KcQUrQr865krc/yCxduaFxVQNrpnDX8A523V3gV3rLI=;
 b=UA5YqojL1yZ+WUq1P0cslWat4GoaP/+tKFRR5kx9xwrWTc60zow438fX8esUbC/HFv
 wck5RAKfz27MjBgNltHffrvqgmINXy2eXEk4CwdsJqubwzPB/oaEklkd/kfHFqxevKMr
 A16ybRsobBHUzhfGMDvNxA6XDPQuHvZRZ/B2EAtq0Cq3JofMzkHhlvRE5cKmW+naZ6qe
 FpiyswGYP2SNtJA7xY4JcNMrDaL1nTgG5w84pxowbIThGn/bnQCs9mZ9ivyp3jbwxUNp
 rVZgeQwMs4SshP2sBw0sfTmb5QXYIOM3Ei0o6QiGkSrUUuBj1xfMBvEActIfUaZNNmXs
 Ek2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618332; x=1779223132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KcQUrQr865krc/yCxduaFxVQNrpnDX8A523V3gV3rLI=;
 b=QINJCvzp60LdccDVdzjdELhsBfOerVdz3kiV0GuNO6rXzKT9RBlI3b2wyQ7lSvYI0y
 Ffhd3fO+k77/DRQPjKQzOB5nxyyLlOBk8ePNWJazd2hVB6fhbC5kQsBhQdakMw8cysYA
 0tWba2cIEl0Ahz6pkX6OTIGT2wjD52vqabSJ7O3yKxj8lAEtRp0OioMHNCluLOUCoLNR
 BY7685MD0Cwbn9R53Va67Tf/oArvCrC4tdunHZ0cx2+JEB0PRXVRTqcbVVQLTV2Oi8tV
 xFj5MNaAbbsw66bUIIUWjxf7FUfbRFGpbEDgcXnFl3t8y/TCSNZDZYoSXbfl+ViXTJkE
 wXTw==
X-Gm-Message-State: AOJu0YyMRu786ITxPT+3lfG5FuOklavAYL3yTik8zxdP/PpiABFts4ob
 JvFYhT3dwuPszL6Ddh1s7+b0GELGVmNWODR9W5dmdVV8UHz7Dq/YrkT6pdPB0WSlygS0Uf2xIPQ
 uPTL9gA0=
X-Gm-Gg: Acq92OFmE230+AEVBKkv30wdIcSRrwgLLgFNK5fylbPiWcdMTzZoGdhXOR1aRHtfeVY
 y7hFu9x8DU78NcRdJLjBhDCfDt/jDBnW63UYpUNcumU8Oo9HWdRPCDSBP6VbuedNeXkYtmFJrDQ
 cN2rO3zf1NDLH/doUd3f7ekKBNKmoK+7/fHDwVdqTywsqwIoQoMi7QHp7HrctDRhi5jwofJIfAo
 q2K2ertchlKtKbI3BeX8UcnIFVyw+mq9+vyiqcQmti5CQgeNOyqFoN0/XnW68EsMgZCajCNvBBA
 jTud1ix8QxzGqPEg0gfXgfpMjOkHigizMWD7io6r47FNsRVaPdCJV/jr35UA2WSB6pLQuwbk0+X
 sig46pptLwqBdUgVpZN6UUyGokiFgw9zMg4e2f23LXt0o7f112w6k+hMvkjKC1tBKFX0xIB9DH8
 LOFEUdb/ytBt7O2rDCPtZC19qhTLamdsusBQaelVIoNHj5CkuCxjzRffTyFB41wmwGVx63j6v7S
 gplWzBdH40=
X-Received: by 2002:a05:6000:288c:b0:456:ba09:3e64 with SMTP id
 ffacd0b85a97d-45c5762d2e1mr463397f8f.1.1778618332032; 
 Tue, 12 May 2026 13:38:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm37071914f8f.31.2026.05.12.13.38.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 13:38:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/41] hw/sd/sd: Allow multi-byte read/write for generic
 paths
Date: Tue, 12 May 2026 22:38:42 +0200
Message-ID: <20260512203842.4863-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512203842.4863-1-philmd@linaro.org>
References: <20260512203842.4863-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
[PMD: Access &sd->data[sd->data_offset] in sd_generic_read/write_data]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 62 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c0b89735f69..11f6b91576a 100644
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
+    memcpy(&sd->data[sd->data_offset], buf, to_write);
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
+    memcpy(buf, &sd->data[sd->data_offset], to_read);
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


