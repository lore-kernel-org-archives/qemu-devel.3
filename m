Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26630CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgW0-0000rb-Ow; Tue, 12 May 2026 02:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVe-0000fD-5m
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVb-00048e-Uf
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ad135063so40790375e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566941; x=1779171741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5jEu6kZH+X4N8CYk2mmHCjcBwozvzYS5Uh+w2RSCMmk=;
 b=lXEbo24d0677fd6uE8sX6Bd/hIC6jlso8l9bY9CnRsq8qkif4crRy9pPaUj8STwcTb
 kUzcIUbJoY9PfentETzxKX8h2MNUwc3kFjK++UVeEY0GED30HM/MF0X33TcQDtFJV9wI
 UuK8pCJJy3aJRD7Zsbmto4uYgYfgXkQiEAN9totGFc7f8b+0hTrRw8nwmNZJ74JABwmV
 5/aolenKhuB/IjUxRkjb3is0LEJQXaZ8SPbCryphYGGcXRpQXAt8M45VQgL7rcTIhh35
 HvUn1JltVLZ2Xk/fDhXwnPjSvkmyD85pgvsQZKnWHkLuEYvY9gJvXM1w3XUb+4+nkvcM
 2PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566941; x=1779171741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5jEu6kZH+X4N8CYk2mmHCjcBwozvzYS5Uh+w2RSCMmk=;
 b=BMmsd3PPPSUn4xm94dbh6ZZ71mfQqtyprAFRSpwamasG9oJKRsb3ipw6KwKO4eA1sO
 4CvVAbwtg44lcUkfq/sTaPQctB6bjx5EsRVsycEVDxkZSg8yIcoSGHiSA5SMA4gPVpy4
 EIO6YZ3LOmYFpe/uPdnmALEFwY8JBwIXwgT2L1Vt1doObH1EyO+hLo/7Nn9zXQ6GOR04
 WAPnwfr5GbPDhYMGXyQJrcfUvcP17zwxf/mUmlBnHcZ9HJofCEu80d7tvpBpk7DUodbt
 hKHDnumpfdBvIW1518d/VlqKz7AkGRehEtjDn8DeXQAR3TRnA+qncwG+afKiWK8kN0fR
 szBQ==
X-Gm-Message-State: AOJu0Yy9wSPf/Z8No3cxLRj4TdA96la54/jS5r5wGozwBj3UYK5aryYH
 5eNeItasL/hdVdqaucNbzK1LC+YKU0zdR/l5GsJib2gv8mxcClRfjTYebejbBVq25R8CWdWh+ON
 VFiA+mX0=
X-Gm-Gg: Acq92OFtvFILi6jN9OMc8XyGBBZOFA/ATO8nVzj7ZGSnpKAgoU6G/eUrAdAP9zbQsie
 nxnd7JD5vBH1BBPy214CwC2m7Ky5UtcRMh7N/5F3H15n27Rg5RNkR3SeCxBX3nWgzZuVXEiipX0
 lx18GfN/FqF4OibLATIHFv4/CIWOGa1t9AMv+ife78raqIdIg4MTar73VEkTG6qwQy5KQEAjmdn
 6l/16j+vxkqBemWEApZY+ZncuYgFJ+sXfSz/9hKg/PLl9Xepuir2eaO0pbFigTUgjiN7oObJOGP
 ncYSP8hjYxcLfA9OP6/7XvNDweiF+b9xo2bafIMpKeB6mCSGgNTqDZHwumkwxqeI/LiUwqxCcDX
 wAvx/kSxy7Q9IBvJxNRIz6Il+7p/lDerCLVQKko5xjfW5zN8LbT1z3k04/YjQll+3KXWMlzocrj
 eBE6HstTNUVih4m7mN2EnKbMrLYmXU5UzZVhZQp2D2W0ZS6NMAP0dgC2aMUbzpmJqoLRZ2aXnl
X-Received: by 2002:a05:600c:1d18:b0:48a:8cb6:88b9 with SMTP id
 5b1f17b1804b1-48e51f44621mr419040675e9.22.1778566940502; 
 Mon, 11 May 2026 23:22:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f4470d8sm10083285e9.31.2026.05.11.23.22.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] hw/sd: Switch read/write primitive to buf+len
Date: Tue, 12 May 2026 08:21:06 +0200
Message-ID: <20260512062142.67998-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
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

Currently, read/writes are broken down into individual bytes which result
in many function calls. This is quite bad for performance and since both
the layer below and above work with larger buffers, it should be
corrected.

This patch is the first that switches the corresponding interface over to
use a buf+len instead of a single byte. However, for most cases the
implementation still only reads one byte and is then called again with
the remaining buffer.

Optimizations taking advantage of this new interface are to follow in the
next commits.

Signed-off-by: Christian Speich <c.speich@avm.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260417-sdcard-performance-b4-v4-1-119e66be10c2@avm.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h | 22 ++++++++++------
 hw/sd/core.c       | 26 +++++++++++--------
 hw/sd/sd.c         | 62 ++++++++++++++++++++++++++++++----------------
 3 files changed, 71 insertions(+), 39 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d12f24955a5..2162fb58402 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -107,22 +107,30 @@ struct SDCardClass {
     size_t (*do_command)(SDState *sd, SDRequest *req,
                          uint8_t *resp, size_t respsz);
     /**
-     * Write a byte to a SD card.
+     * Write data to a SD card.
      * @sd: card
-     * @value: byte to write
+     * @value: data to write
+     * @len: length of data
      *
-     * Write a byte on the data lines of a SD card.
+     * Write data on the data lines of a SD card. May write not all data, in
+     * which case it should be called again. At least one byte must be consumed.
+     *
+     * Return: number of bytes actually written. >= 1
      */
-    void (*write_byte)(SDState *sd, uint8_t value);
+    size_t (*write_data)(SDState *sd, const void *buf, size_t len);
     /**
      * Read a byte from a SD card.
      * @sd: card
+     * @buf: buffer to receive the data
+     * @len: size of data to read
      *
-     * Read a byte from the data lines of a SD card.
+     * Read data from the data lines of a SD card. This may not read all
+     * requested data, in this case it should be called again with the remaining
+     * buffer. At least one byte must be read.
      *
-     * Return: byte value read
+     * Return: number of bytes actually read. >= 1
      */
-    uint8_t (*read_byte)(SDState *sd);
+    size_t (*read_data)(SDState *sd, void* buf, size_t len);
     bool (*receive_ready)(SDState *sd);
     bool (*data_ready)(SDState *sd);
     void (*set_voltage)(SDState *sd, uint16_t millivolts);
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 3568a81e809..594c5e011ba 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -113,21 +113,24 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        sc->write_byte(card, value);
+        sc->write_data(card, &value, 1);
     }
 }
 
 void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length)
 {
     SDState *card = get_card(sdbus);
-    const uint8_t *data = buf;
 
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        for (size_t i = 0; i < length; i++) {
-            trace_sdbus_write(sdbus_name(sdbus), data[i]);
-            sc->write_byte(card, data[i]);
+        while (length > 0) {
+            size_t written = sc->write_data(card, buf, length);
+
+            g_assert(written >= 1);
+
+            buf += written;
+            length -= written;
         }
     }
 }
@@ -140,7 +143,7 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        value = sc->read_byte(card);
+        sc->read_data(card, &value, 1);
     }
     trace_sdbus_read(sdbus_name(sdbus), value);
 
@@ -150,14 +153,17 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
 void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
 {
     SDState *card = get_card(sdbus);
-    uint8_t *data = buf;
 
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        for (size_t i = 0; i < length; i++) {
-            data[i] = sc->read_byte(card);
-            trace_sdbus_read(sdbus_name(sdbus), data[i]);
+        while (length > 0) {
+            size_t read = sc->read_data(card, buf, length);
+
+            g_assert(read >= 1);
+
+            buf += read;
+            length -= read;
         }
     }
 }
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ebe6e35b15e..c0b89735f69 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2639,30 +2639,37 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
     return false;
 }
 
-static void sd_write_byte(SDState *sd, uint8_t value)
+static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     unsigned int partition_access;
     int i;
+    const uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
-        return;
+        return length;
     }
 
     if (sd->state != sd_receivingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: not in Receiving-Data state\n", __func__);
-        return;
+        return length;
     }
 
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
-        return;
+        return length;
+
+    /*
+     * Only read one byte at a time. We will be called again with the
+     * remaining.
+     */
+    length = 1;
 
     trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
-                            sd->current_cmd, sd->data_offset, value);
+                            sd->current_cmd, sd->data_offset, value[0]);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
@@ -2687,7 +2694,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
                 }
             }
         }
-        sd->data[sd->data_offset++] = value;
+        sd->data[sd->data_offset++] = value[0];
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
@@ -2717,7 +2724,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
@@ -2735,7 +2742,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
@@ -2758,7 +2765,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        if (sd_generic_write_byte(sd, value)) {
+        if (sd_generic_write_byte(sd, value[0])) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
@@ -2768,36 +2775,47 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd_generic_write_byte(sd, value);
+        sd_generic_write_byte(sd, value[0]);
         break;
 
     default:
         g_assert_not_reached();
     }
+
+    return length;
 }
 
-static uint8_t sd_read_byte(SDState *sd)
+static size_t sd_read_data(SDState *sd, void *buf, size_t length)
 {
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
     unsigned int partition_access;
-    uint8_t ret;
     uint32_t io_len;
+    uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
-        return dummy_byte;
+        memset(buf, dummy_byte, length);
+        return length;
     }
 
     if (sd->state != sd_sendingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: not in Sending-Data state\n", __func__);
-        return dummy_byte;
+        memset(buf, dummy_byte, length);
+        return length;
     }
 
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION)) {
-        return dummy_byte;
+        memset(buf, dummy_byte, length);
+        return length;
     }
 
+    /*
+     * We will only read one byte at a time. We will be called again with the
+     * remaining buffer.
+     */
+    length = 1;
+
     io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
@@ -2815,7 +2833,7 @@ static uint8_t sd_read_byte(SDState *sd)
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 51: /* ACMD51: SEND_SCR */
     case 56: /* CMD56:  GEN_CMD */
-        sd_generic_read_byte(sd, &ret);
+        sd_generic_read_byte(sd, value);
         break;
 
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
@@ -2832,7 +2850,7 @@ static uint8_t sd_read_byte(SDState *sd)
                 sd_blk_read(sd, sd->data_start, io_len);
             }
         }
-        ret = sd->data[sd->data_offset ++];
+        *value = sd->data[sd->data_offset++];
 
         if (sd->data_offset >= io_len) {
             sd->data_start += io_len;
@@ -2851,10 +2869,10 @@ static uint8_t sd_read_byte(SDState *sd)
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT read illegal for command %s\n",
                                        __func__, sd->last_cmd_name);
-        return dummy_byte;
+        *value = dummy_byte;
     }
 
-    return ret;
+    return length;
 }
 
 static bool sd_receive_ready(SDState *sd)
@@ -3196,8 +3214,8 @@ static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
     sc->get_dat_lines = sd_get_dat_lines;
     sc->get_cmd_line = sd_get_cmd_line;
     sc->do_command = sd_do_command;
-    sc->write_byte = sd_write_byte;
-    sc->read_byte = sd_read_byte;
+    sc->write_data = sd_write_data;
+    sc->read_data = sd_read_data;
     sc->receive_ready = sd_receive_ready;
     sc->data_ready = sd_data_ready;
     sc->get_inserted = sd_get_inserted;
-- 
2.53.0


