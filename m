Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87377C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvaX-0007xL-NN; Mon, 22 Jul 2024 12:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvaV-0007ly-P0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvaR-0007oY-NQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so32747795e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664508; x=1722269308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D13SsLbTdb+rPn3f2Roi8BU4ul1b5GgWpSQvaH/PkW0=;
 b=HTc7vL43soHt7J6N36/gUO0tC/QXqOJoRM/m2NjFiZwn0Ji5lF3DYub8vZ3RCM0ozp
 H0M7ASpBR5eNIWXKy+WDre3635XoGouBHqiE0rJc8DitqFXKyaYzvSIcdTTKOfsAme0H
 jH3bXTae42i61HHa+4kJFayaJBgU7DMU/Tud7M7J+I8aDuurmnpcq6bma0NQFjmgrJwv
 g31NKensoH7tS59Ec/QTC0aXySN22Wh4mflcDPwa4JZMs42N7YOAeJGSSzALtss6KTjE
 DNz6+f+Gnwm8xuCFYRaIAOvPEhyZCvd4wfH8Cd5i25PcBBVZYByZPsLG3/dEfXwqs51s
 EHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664508; x=1722269308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D13SsLbTdb+rPn3f2Roi8BU4ul1b5GgWpSQvaH/PkW0=;
 b=eqGEyGmuQJAkq+FgUvhhkzksHTSF+YD44L8UHpxMuxe4yFcuPwTiPmHUxp0gd0ctC/
 hbxMdZYBQEFe2SfXjyTk0Ps/wNbL1f9egIj4SmeV+6qrMf4cSOCZbMK80q3TDYTxUfZN
 EpjVCKCmNkdhOMJsWzkrbsZx+0CsP8Msssaj+X1LnuKJpNjPAk8L0lzejmzz6wtUU5rW
 59Ib1ngx6I7JDQ9PFRh58QkA8Pj9K2CIu7Yk2SXia0NT/JYoAqb/5WlpF0bOp8Ec94IP
 aY7synxlj+v7FlG50ZVEdztf0mMmP+VtvTDjx1XJuF+lGkw3OULoYRyFirFo0XrOv5lS
 WoGw==
X-Gm-Message-State: AOJu0YxiTOdfelTRJT+bGZmVO3yQnPD9dkCCiT5G/PJCxN26OyG0oeGb
 gm6B1O6w8zluiBJPLOMzgQ2WkRwA5LchYoqGaXRrg4+zOxZfnv7OrY00FbywfbbXkYQiN4caN94
 S
X-Google-Smtp-Source: AGHT+IHRr2Hse5CaEmOALI6VDv3D1w/NDKzUvtjoPzuh1A/PDTLZOczZbBtc36qmY7CP1Trc0EdJ8g==
X-Received: by 2002:a05:600c:1d8f:b0:426:51dc:f6cd with SMTP id
 5b1f17b1804b1-427dc529057mr55262845e9.18.1721664508179; 
 Mon, 22 Jul 2024 09:08:28 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced33sm8964748f8f.86.2024.07.22.09.08.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:08:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] util/fifo8: Rename fifo8_pop_buf() ->
 fifo8_pop_constbuf()
Date: Mon, 22 Jul 2024 18:07:43 +0200
Message-ID: <20240722160745.67904-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
References: <20240722160745.67904-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Since fifo8_pop_buf() return a const buffer (which points
directly into the FIFO backing store), rename it using the
'constbuf' suffix. This will help differentiate with methods
*copying* the FIFO data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h    | 4 ++--
 chardev/msmouse.c       | 2 +-
 hw/char/goldfish_tty.c  | 4 ++--
 hw/net/allwinner_emac.c | 2 +-
 hw/scsi/esp.c           | 4 ++--
 ui/console-vc.c         | 2 +-
 ui/gtk.c                | 2 +-
 util/fifo8.c            | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 79450f4583..686918a3a4 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -63,7 +63,7 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
 uint8_t fifo8_pop(Fifo8 *fifo);
 
 /**
- * fifo8_pop_buf:
+ * fifo8_pop_constbuf:
  * @fifo: FIFO to pop from
  * @max: maximum number of bytes to pop
  * @numptr: pointer filled with number of bytes returned (can be NULL)
@@ -86,7 +86,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  *
  * Returns: A pointer to popped data.
  */
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
+const uint8_t *fifo8_pop_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
  * fifo8_peek_constbuf: read upto max bytes from the fifo
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index a774c397b4..08836d92e8 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -81,7 +81,7 @@ static void msmouse_chr_accept_input(Chardev *chr)
         const uint8_t *buf;
         uint32_t size;
 
-        buf = fifo8_pop_buf(&mouse->outbuf, MIN(len, avail), &size);
+        buf = fifo8_pop_constbuf(&mouse->outbuf, MIN(len, avail), &size);
         qemu_chr_be_write(chr, buf, size);
         len = qemu_chr_be_can_write(chr);
         avail -= size;
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index f8ff043c39..2c5004851d 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -69,7 +69,7 @@ static uint64_t goldfish_tty_read(void *opaque, hwaddr addr,
 static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
 {
     uint32_t to_copy;
-    uint8_t *buf;
+    const uint8_t *buf;
     uint8_t data_out[GOLFISH_TTY_BUFFER_SIZE];
     int len;
     uint64_t ptr;
@@ -109,7 +109,7 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
         len = s->data_len;
         ptr = s->data_ptr;
         while (len && !fifo8_is_empty(&s->rx_fifo)) {
-            buf = (uint8_t *)fifo8_pop_buf(&s->rx_fifo, len, &to_copy);
+            buf = fifo8_pop_constbuf(&s->rx_fifo, len, &to_copy);
             address_space_rw(&address_space_memory, ptr,
                             MEMTXATTRS_UNSPECIFIED, buf, to_copy, 1);
 
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 989839784a..3b0a2ee07e 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -349,7 +349,7 @@ static void aw_emac_write(void *opaque, hwaddr offset, uint64_t value,
                               "allwinner_emac: TX length > fifo data length\n");
             }
             if (len > 0) {
-                data = fifo8_pop_buf(fifo, len, &ret);
+                data = fifo8_pop_constbuf(fifo, len, &ret);
                 qemu_send_packet(nc, data, ret);
                 aw_emac_tx_reset(s, chan);
                 /* Raise TX interrupt */
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 526ed91bef..64384f9b0e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -208,7 +208,7 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     }
 
     len = maxlen;
-    buf = fifo8_pop_buf(fifo, len, &n);
+    buf = fifo8_pop_constbuf(fifo, len, &n);
     if (dest) {
         memcpy(dest, buf, n);
     }
@@ -217,7 +217,7 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     len -= n;
     len = MIN(len, fifo8_num_used(fifo));
     if (len) {
-        buf = fifo8_pop_buf(fifo, len, &n2);
+        buf = fifo8_pop_constbuf(fifo, len, &n2);
         if (dest) {
             memcpy(&dest[n], buf, n2);
         }
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 899fa11c94..e9906aae59 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -287,7 +287,7 @@ static void kbd_send_chars(QemuTextConsole *s)
         const uint8_t *buf;
         uint32_t size;
 
-        buf = fifo8_pop_buf(&s->out_fifo, MIN(len, avail), &size);
+        buf = fifo8_pop_constbuf(&s->out_fifo, MIN(len, avail), &size);
         qemu_chr_be_write(s->chr, buf, size);
         len = qemu_chr_be_can_write(s->chr);
         avail -= size;
diff --git a/ui/gtk.c b/ui/gtk.c
index bc29f7a1b4..a4db90e8cb 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1820,7 +1820,7 @@ static void gd_vc_send_chars(VirtualConsole *vc)
         const uint8_t *buf;
         uint32_t size;
 
-        buf = fifo8_pop_buf(&vc->vte.out_fifo, MIN(len, avail), &size);
+        buf = fifo8_pop_constbuf(&vc->vte.out_fifo, MIN(len, avail), &size);
         qemu_chr_be_write(vc->vte.chr, buf, size);
         len = qemu_chr_be_can_write(vc->vte.chr);
         avail -= size;
diff --git a/util/fifo8.c b/util/fifo8.c
index 21943c6032..31f0d34c0c 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -97,7 +97,7 @@ const uint8_t *fifo8_peek_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     return fifo8_peekpop_buf(fifo, max, numptr, false);
 }
 
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+const uint8_t *fifo8_pop_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
     return fifo8_peekpop_buf(fifo, max, numptr, true);
 }
-- 
2.41.0


