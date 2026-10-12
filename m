Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93FDCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHaA-0004z7-5d; Mon, 12 Oct 2026 11:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHa3-0004it-Ee
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:04:49 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHa0-0006Yh-BM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:04:47 -0400
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1132991f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817483; x=1792422283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=um44cl8FTErmKq2v7teNfkRsHWMpEkMy+vm/KZ2VsJY=;
 b=tZ7v56FlqJA9QtlvDFQiOy/0Ji8K2AUlwAN0BcXVRhcZ/HS76hr+e5NhXr2B3fHMsy
 fsTuqTLeSjQzxQqfQzH4OOa+AiSgUK5DkU2D259xsNmtQRU+lyZwDXnZvwSjXExEg8Jm
 iZCADbEyu1rW2rc5encfd1QDNlcJetfzkg+v215OL1tsmHm9niJIQnQYupO9adekOwzQ
 pIZg3L0czXuZo72qzJJ5+tWq4N8wJZASSbLVE+CgVvXGEpYsj0u8yI3mMY6jSCa6IZPP
 R0SxRfiA1zNbX8p887HaiFf4tD7Uqy39t7/LAYBvkP595tvX9MZHMAjPWlU1MEaUlKVe
 Hhtg==
X-Gm-Message-State: AFq9FYKp3X+r438dTUnOCPRMoc5r2slxxY6W/fbs/BKW6PEICp2yQQFT
 BIHEkLl1bSYMCnogspuFiwNEy+97ODpyj8TnSfzDAWIKephuzg6J6yvUxIpzmKvt
X-Gm-Gg: AYBFou3ezskKeMXDWb7z8E+8pZ1nKjIY0joDvL3+XsSZ9D5Od3OokGghqa/0trRPgR3
 2ujDSVrdUK6KRmMv1trmE8BQsro37SLMFaNtLdB5K/nZzLWQzVC1VqAmwPak3v2r8mHAPkfNLtJ
 Harrj/NB82Pxj4Uk3YHJ6XGVlZM/OYMhDY+eB8IWBvzBBUmq7y8fe4kSvPcqsnyNiRHvvmvL5Ap
 G0gmo9zVyH8zoWasm8Fc1aCda1jf3dQLGu56BkOmZwTQgvou/k/2NL8yFItdn2XOW5woGbyW+9G
 I87L0fkl7wfZv63RRKG2bIh0Mbwz79gqLTSxkLflotWHLdp2Jj50JeNA8PryUYMeNQ5QQml/3la
 ou+HlBNbcH2IglStJWmoEx6bPOjSuzRtx8go0H2PIHb4rJXS6IJIwvSrlKmqfaIH4/fIg+/eXyr
 85LaNvLX3X5WajJP7t3oamHEpfm97jtbkDoL1aVJ1jLjcJzI0ljl9+D2e/AwRwk27QyJV5YPX7S
 SJ/EGmbgto0G2fjA+bcekE3UurWfEdTBL8hYpcGYmpOzpkVAMTB3UOm
X-Received: by 2002:a05:6000:4683:b0:48c:455a:1c81 with SMTP id
 ffacd0b85a97d-48dbaadc0e1mr12992051f8f.17.1791817482449; 
 Mon, 12 Oct 2026 08:04:42 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aadf9bsm19445445f8f.29.2026.10.12.08.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:04:41 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:05 +0200
Subject: [PATCH v2 12/50] hw/rtc: ds1338: parameterise the register map via
 a device class
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-12-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=6098;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=3HDBdw1nikFPpNJwTwE1d2HiJ1KBQ/Q3c9Vz2uyln2k=;
 b=QzFseEm5TnHFFxeeeA5qFJKz7nJFLk8KOYtmu3ZGJqqC9z1sswm9mJoVShNusWXgJrTJcqTid
 p5Cv2DLId2ICLdVjd5JD9jEK+XMb41EjgWkSdZd/lnM1zl5ehWksKlT
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f48.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In preparation for a register-compatible variant, refactor DS1338
register map. Introduce DS1338Class, carrying the register-pointer wrap
boundary and the control/OSF register location and masks, and drive
inc_regptr() and the control-register handling.

The control-register power-on value is parameterised along with them,
so the part comes up holding the contents its datasheet specifies
rather than zero, and its oscillator-stop flag now reads set at
power-on.

Encode the year register modulo 100 (tm_year % 100) instead of
tm_year - 100.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 71 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 1755a3a37c..7eaa663113 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -30,7 +30,14 @@
 #define HOURS_PM   0x20
 #define CTRL_OSF   0x20
 
-OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
+/* DS1338 register map */
+#define DS1338_NUM_REGS    NVRAM_SIZE   /* 0x00..0x3f, then wraps */
+#define DS1338_CONTROL     0x07
+#define DS1338_CTRL_MASK   0xb3         /* bits 2, 3 and 6 read back as zero */
+/* POR: OUT, OSF, SQWE and both rate-select bits come up set. */
+#define DS1338_CTRL_RESET  0xb3
+
+OBJECT_DECLARE_TYPE(DS1338State, DS1338Class, DS1338)
 
 struct DS1338State {
     I2CSlave parent_obj;
@@ -42,6 +49,17 @@ struct DS1338State {
     bool addr_byte;
 };
 
+struct DS1338Class {
+    I2CSlaveClass parent_class;
+
+    uint8_t num_regs;       /* register-pointer wrap boundary */
+    uint8_t ctrl_addr;      /* control register address */
+    uint8_t ctrl_mask;      /* writable/read-back bits of the control reg */
+    uint8_t osf_addr;       /* register holding the OSF flag */
+    uint8_t osf_mask;       /* OSF bit within osf_addr */
+    uint8_t ctrl_reset;     /* control-register power-on value */
+};
+
 static const VMStateDescription vmstate_ds1338 = {
     .name = "ds1338",
     .version_id = 2,
@@ -82,16 +100,19 @@ static void ds1338_capture_current_time(DS1338State *s)
     s->nvram[3] = (now.tm_wday + s->wday_offset) % 7 + 1;
     s->nvram[4] = to_bcd(now.tm_mday);
     s->nvram[5] = to_bcd(now.tm_mon + 1);
-    s->nvram[6] = to_bcd(now.tm_year - 100);
+    s->nvram[6] = to_bcd(now.tm_year % 100);
 }
 
 static void ds1338_inc_regptr(DS1338State *s)
 {
-    /* The register pointer wraps around after 0x3F; wraparound
-     * causes the current time/date to be retransferred into
-     * the secondary registers.
+    DS1338Class *k = DS1338_GET_CLASS(s);
+
+    /*
+     * The register pointer wraps around after the last register; wraparound
+     * causes the current time/date to be retransferred into the secondary
+     * registers.
      */
-    s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
+    s->ptr = (s->ptr + 1) % k->num_regs;
     if (!s->ptr) {
         ds1338_capture_current_time(s);
     }
@@ -136,11 +157,12 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
 static int ds1338_send(I2CSlave *i2c, uint8_t data)
 {
     DS1338State *s = DS1338(i2c);
+    DS1338Class *k = DS1338_GET_CLASS(i2c);
 
     trace_ds1338_send(s->ptr, data);
 
     if (s->addr_byte) {
-        s->ptr = data & (NVRAM_SIZE - 1);
+        s->ptr = data % k->num_regs;
         s->addr_byte = false;
         return 0;
     }
@@ -190,18 +212,19 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
             break;
         }
         s->offset = qemu_timedate_diff(&now);
-    } else if (s->ptr == 7) {
-        /* Control register. */
-
-        /* Ensure bits 2, 3 and 6 will read back as zero. */
-        data &= 0xB3;
-
-        /* Attempting to write the OSF flag to logic 1 leaves the
-           value unchanged. */
-        data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
-
-        s->nvram[s->ptr] = data;
     } else {
+        if (s->ptr == k->ctrl_addr) {
+            /* Control register: reserved bits read back as zero. */
+            data &= k->ctrl_mask;
+        }
+        if (s->ptr == k->osf_addr) {
+            /*
+             * Attempting to write the OSF flag to logic 1 leaves the
+             * value unchanged.
+             */
+            data = (data & ~k->osf_mask) |
+                   (data & s->nvram[s->ptr] & k->osf_mask);
+        }
         s->nvram[s->ptr] = data;
     }
     ds1338_inc_regptr(s);
@@ -211,11 +234,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
 static void ds1338_reset_hold(Object *obj, ResetType type)
 {
     DS1338State *s = DS1338(obj);
+    DS1338Class *k = DS1338_GET_CLASS(s);
 
     /* The clock is running and synchronized with the host */
     s->offset = 0;
     s->wday_offset = 0;
     memset(s->nvram, 0, NVRAM_SIZE);
+    s->nvram[k->ctrl_addr] = k->ctrl_reset;
     s->ptr = 0;
     s->addr_byte = false;
 }
@@ -225,12 +250,21 @@ static void ds1338_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DS1338Class *dsc = DS1338_CLASS(klass);
 
     k->event = ds1338_event;
     k->recv = ds1338_recv;
     k->send = ds1338_send;
     rc->phases.hold = ds1338_reset_hold;
+    dc->desc = "DS1338 I2C RTC with 56-byte NV RAM";
     dc->vmsd = &vmstate_ds1338;
+
+    dsc->num_regs   = DS1338_NUM_REGS;
+    dsc->ctrl_addr  = DS1338_CONTROL;
+    dsc->ctrl_mask  = DS1338_CTRL_MASK;
+    dsc->osf_addr   = DS1338_CONTROL;
+    dsc->osf_mask   = CTRL_OSF;
+    dsc->ctrl_reset = DS1338_CTRL_RESET;
 }
 
 static const TypeInfo ds1338_types[] = {
@@ -238,6 +272,7 @@ static const TypeInfo ds1338_types[] = {
         .name          = TYPE_DS1338,
         .parent        = TYPE_I2C_SLAVE,
         .instance_size = sizeof(DS1338State),
+        .class_size    = sizeof(DS1338Class),
         .class_init    = ds1338_class_init,
     },
 };

-- 
2.50.1


