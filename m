Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EE2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMK1-0007gS-Ce; Tue, 23 Jul 2024 16:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJw-00075b-HV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJu-0004W9-9e
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-368663d7f80so3242250f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767272; x=1722372072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBM1IJL7GzUQtrseAlPnjePV8gHhhVpan+XyuPJ8YY8=;
 b=BkgbqQKSuPBUhSzEK0rFyCQXDODtII/i03+4iZE9fYDyVD2wpbUgqFYk7rdCezPyiB
 C0o7EQz5vPmsHgAiczbpKtRmzvhMcLE8Xb4ocT3U1VyGUOZW63Luw28yCqnZf+0bGwK+
 a/ofyEWqq8Q6wdm16vIPLhyC1UEhjcHOL/2rlCoAlNo3rhemc1Grjak51i7aEsotsi/V
 WQOpNCW0qgUSmGjEwRN2ZYc25WqPVYS4EGxOPI6cGWtxjqYsHj8zcTEXPP7qqJQVC35i
 ddj+kgW7Z8u2YmYQ0gUcGctB0Ixi+5li4FIehw4JapQGpbDr5botYEAp14Frd/vtHoLj
 PTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767272; x=1722372072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBM1IJL7GzUQtrseAlPnjePV8gHhhVpan+XyuPJ8YY8=;
 b=NDkexa0Pm+cGvX17OGIDTXbpbuUeX2maJatykN+vAbA1ETsg1n7T5jL006rrKMf9Xq
 x3F+Rahhx65fa0vFhKWea683EsoQALHGlxOuzsVJC1ixn6ZxyBcn1FMgeMtsEJ4w7rWB
 /7fawUPy08iRoiw9pcLjJOAiWn7TFushWSzDbWk2EvKvwW2/MmZ6I1ziPP7AptxV4hVb
 SjeRXUSrbsj2dCfZXW8AGegIvvclCdKP1w83PTX0Q754+TXnFcUqtm+sH7R4Vljv6xse
 UdzFVoV5E6OsTgaAiOWDSZ0mHm0BhmfxMGeOHvMPucKL/AA4xzdjvOmD++nzgS4/CX78
 BSTQ==
X-Gm-Message-State: AOJu0YyBjySPuQRJbxo2KED9pshQ6VloO3BQCB9HHKndjIfUeoBqAzDA
 l1+xGYJl7qDfnYuzXP5GfwptB/DyM7DNDbT6GfhQrluwPa/lV6qdri5/BPC+oXoSdlHoZLLxjCG
 Ax+U=
X-Google-Smtp-Source: AGHT+IHp7UXxXFmhUjJGk6XistfccSGrFw31mxt2y8SQLzX53RSGI/FHUAxQhfTgVGM/mcDUtvZg5A==
X-Received: by 2002:adf:f24e:0:b0:369:b7e3:497c with SMTP id
 ffacd0b85a97d-369f5b0eb62mr37435f8f.1.1721767272069; 
 Tue, 23 Jul 2024 13:41:12 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878695a52sm12468356f8f.64.2024.07.23.13.41.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:41:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 24/28] util/fifo8: Rename fifo8_pop_buf() -> fifo8_pop_bufptr()
Date: Tue, 23 Jul 2024 22:38:51 +0200
Message-ID: <20240723203855.65033-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since fifo8_pop_buf() return a const buffer (which points
directly into the FIFO backing store). Rename it using the
'bufptr' suffix to better reflect that it is a pointer to
the internal buffer that is being returned. This will help
differentiate with methods *copying* the FIFO data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240722160745.67904-6-philmd@linaro.org>
---
 include/qemu/fifo8.h    | 15 +++++++--------
 chardev/msmouse.c       |  2 +-
 hw/char/goldfish_tty.c  |  2 +-
 hw/net/allwinner_emac.c |  2 +-
 hw/scsi/esp.c           |  4 ++--
 ui/console-vc.c         |  2 +-
 ui/gtk.c                |  2 +-
 util/fifo8.c            |  2 +-
 8 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index e287e871190..a30220c8e96 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -63,15 +63,15 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
 uint8_t fifo8_pop(Fifo8 *fifo);
 
 /**
- * fifo8_pop_buf:
+ * fifo8_pop_bufptr:
  * @fifo: FIFO to pop from
  * @max: maximum number of bytes to pop
  * @numptr: pointer filled with number of bytes returned (can be NULL)
  *
  * Pop a number of elements from the FIFO up to a maximum of @max. The buffer
  * containing the popped data is returned. This buffer points directly into
- * the FIFO backing store and data is invalidated once any of the fifo8_* APIs
- * are called on the FIFO.
+ * the internal FIFO backing store and data (without checking for overflow!)
+ * and is invalidated once any of the fifo8_* APIs are called on the FIFO.
  *
  * The function may return fewer bytes than requested when the data wraps
  * around in the ring buffer; in this case only a contiguous part of the data
@@ -86,7 +86,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  *
  * Returns: A pointer to popped data.
  */
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
+const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
  * fifo8_peek_bufptr: read upto max bytes from the fifo
@@ -96,10 +96,9 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  *
  * Peek into a number of elements from the FIFO up to a maximum of @max.
  * The buffer containing the data peeked into is returned. This buffer points
- * directly into the internal FIFO backing store (without checking for
- * overflow!). Since data is invalidated once any of the fifo8_* APIs are
- * called on the FIFO, it is the caller responsibility to access it before
- * doing further API calls.
+ * directly into the FIFO backing store. Since data is invalidated once any
+ * of the fifo8_* APIs are called on the FIFO, it is the caller responsibility
+ * to access it before doing further API calls.
  *
  * The function may return fewer bytes than requested when the data wraps
  * around in the ring buffer; in this case only a contiguous part of the data
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index a774c397b45..2279694cfab 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -81,7 +81,7 @@ static void msmouse_chr_accept_input(Chardev *chr)
         const uint8_t *buf;
         uint32_t size;
 
-        buf = fifo8_pop_buf(&mouse->outbuf, MIN(len, avail), &size);
+        buf = fifo8_pop_bufptr(&mouse->outbuf, MIN(len, avail), &size);
         qemu_chr_be_write(chr, buf, size);
         len = qemu_chr_be_can_write(chr);
         avail -= size;
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index cdff46bc13b..c2e1f6537f7 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -109,7 +109,7 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
         len = s->data_len;
         ptr = s->data_ptr;
         while (len && !fifo8_is_empty(&s->rx_fifo)) {
-            const uint8_t *buf = fifo8_pop_buf(&s->rx_fifo, len, &to_copy);
+            const uint8_t *buf = fifo8_pop_bufptr(&s->rx_fifo, len, &to_copy);
 
             dma_memory_write_relaxed(&address_space_memory, ptr, buf, to_copy);
 
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 989839784a9..d40ff37e994 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -349,7 +349,7 @@ static void aw_emac_write(void *opaque, hwaddr offset, uint64_t value,
                               "allwinner_emac: TX length > fifo data length\n");
             }
             if (len > 0) {
-                data = fifo8_pop_buf(fifo, len, &ret);
+                data = fifo8_pop_bufptr(fifo, len, &ret);
                 qemu_send_packet(nc, data, ret);
                 aw_emac_tx_reset(s, chan);
                 /* Raise TX interrupt */
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 412c8cf2260..7e9657e9c30 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -208,7 +208,7 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     }
 
     len = maxlen;
-    buf = fifo8_pop_buf(fifo, len, &n);
+    buf = fifo8_pop_bufptr(fifo, len, &n);
     if (dest) {
         memcpy(dest, buf, n);
     }
@@ -217,7 +217,7 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     len -= n;
     len = MIN(len, fifo8_num_used(fifo));
     if (len) {
-        buf = fifo8_pop_buf(fifo, len, &n2);
+        buf = fifo8_pop_bufptr(fifo, len, &n2);
         if (dest) {
             memcpy(&dest[n], buf, n2);
         }
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 899fa11c948..8393d532e7f 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -287,7 +287,7 @@ static void kbd_send_chars(QemuTextConsole *s)
         const uint8_t *buf;
         uint32_t size;
 
-        buf = fifo8_pop_buf(&s->out_fifo, MIN(len, avail), &size);
+        buf = fifo8_pop_bufptr(&s->out_fifo, MIN(len, avail), &size);
         qemu_chr_be_write(s->chr, buf, size);
         len = qemu_chr_be_can_write(s->chr);
         avail -= size;
diff --git a/ui/gtk.c b/ui/gtk.c
index bc29f7a1b4f..8e14c2ac81d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1820,7 +1820,7 @@ static void gd_vc_send_chars(VirtualConsole *vc)
         const uint8_t *buf;
         uint32_t size;
 
-        buf = fifo8_pop_buf(&vc->vte.out_fifo, MIN(len, avail), &size);
+        buf = fifo8_pop_bufptr(&vc->vte.out_fifo, MIN(len, avail), &size);
         qemu_chr_be_write(vc->vte.chr, buf, size);
         len = qemu_chr_be_can_write(vc->vte.chr);
         avail -= size;
diff --git a/util/fifo8.c b/util/fifo8.c
index 566b0893441..5bbb6150b60 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -97,7 +97,7 @@ const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     return fifo8_peekpop_buf(fifo, max, numptr, false);
 }
 
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
     return fifo8_peekpop_buf(fifo, max, numptr, true);
 }
-- 
2.41.0


