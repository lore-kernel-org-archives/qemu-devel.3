Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A3AC79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cRe-0007nc-78; Mon, 07 Sep 2026 12:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRQ-0007b0-UV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:33 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRN-0002rE-LZ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:32 -0400
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so44634325e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799408; x=1789404208;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qc09au/ziPEmptgRaZky6L4t/5n2HyRsY7eNCEjWR84=;
 b=a6HuQY6n1EubCz8ySSdlZAh0kQZhRB13NOgJCl2j9yqrNvAVom26zwZQznkA5QsNcx
 DoJWm7QaRChJN5obAjyf8o+7ft5CduavTgDzvFWiKMDloHH8xKVt7DCq6y2FhhUyM0+e
 /UA7nX9axjBjG1gVV4jiplO3o4sVNVC+fBCZmzxM10nf4sIrDERVY5mqp23gqEEg2D33
 pRXEaxBpnkPDVfpBU3xy79E6pvmYUh0LtQGErh/9BL1Yg0StUOysv6t2ozZbdXaeC0FC
 VJzLJc+PBSbTIGGdhbRY/IojODrIaNhH/4a20XkAkSdzkHunjcNXp27dM3WFZLptA8su
 ydyg==
X-Gm-Message-State: AFuF++nFuVX0hBHqFVEjmdgeQf89ZIrqGXDbfAs1LURJZeW+pbV3HMds
 DU6Dtfc83lSBOh/jOX4VxvATOyApTa8ClrOnKBXu9NrLVkiSws+hrQOVP4m5tVZg
X-Gm-Gg: AYBFou1NosIF2FWjXCVJa8AbQbr/WI9Bxr4WfvP1P5rfYzxnBBy0IPnigqb9f99iH1/
 717hvI0WbyQ5uqBKJ9JG8CQMCEynxmlrLamJrFNJUYTQml5E7BUnrxELJrYSgGpBmr8tYk4n/UQ
 na/Xln4QtT2KPKC98X4mOAzqRp8dZUAF9OZA9Tif+qyMXPqIVJ4Z7+5QLiWG+mWtDMQCAFqC33V
 g3V14pzQDLR4gDEpY3LFFmFH9D/eJyh4BJnBA34SNKCdplFPuWXChMnLJdHaeoSWxQ4sU0t2X6A
 QEukalykL7r6EJXcRh8F7Nk+DXBUnwSNBgXD7IDzVr00ciyyPTJzlDiTtG30ppFw9eHg18+KSXY
 tLGANU4IxcGvrcs03CAFVVY2e1p6cnIdzJ/D0CqVyKGRZouU/cb2oRtUOpVu6UtI2nTaQUA5pI0
 IuneIFroPa8wlW8rOn+h6zyiQ6TEfdYiag8/aKVp6pt+mR5ShQkbDvMonGhgy0/NBgSLRSV0os3
 FT1oGRGpRqt1J3PIQ4PbvoI9AQrVGFWd58=
X-Received: by 2002:a05:600c:6209:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-49cfed6cd4dmr178926145e9.23.1788799407779; 
 Mon, 07 Sep 2026 09:43:27 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce551bf7asm278333335e9.2.2026.09.07.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:43:27 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:41:55 +0200
Subject: [PATCH 05/50] hw/i2c: pca954x: add PCA9545 4-channel mux model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-5-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799319; l=6619;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=jN11PUN0iIxLB/VOsPy3liNV/U5718SCu3GBbjUm/BQ=;
 b=c56iercpKB7ct5JF1sNh1xeMobbsC3o5OUjsuwlVUtaHSEUxBHAenaokDzUUDnPoN9ltyWhLY
 9hOTvnzE7FhATYaLjDth0MdLUPbBOnFy5BNv7Jnny5l2kAsGklQu6CP
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f41.google.com
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

The PCA9545 is a 4-channel I2C mux/switch. What sets it apart from the
plain PCA9546 is its interrupt logic: one INTn input per channel and a
shared INT output, both active low, asserted whenever any channel
interrupt is active.

Model this behind a new has_irq class flag. The PCA9545 gains four named
"interrupt" GPIO inputs and an "interrupt-out" output, and its control
read-back merges the latched status nibble; the plain PCA9546/PCA9548
switches keep their previous behaviour.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/i2c/i2c_mux_pca954x.c         | 71 ++++++++++++++++++++++++++++++++++++++--
 include/hw/i2c/i2c_mux_pca954x.h |  1 +
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index c8e75da8b2e..4bb078a03c4 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -12,12 +12,20 @@
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  * for more details.
+ *
+ * Limitations:
+ * - A control write longer than one byte is rejected rather than retaining the
+ *   last received byte as the datasheet specifies.
+ * - On reset the cached per-channel interrupt state is cleared; a downstream
+ *   INT input that stays asserted across the reset is not re-sampled until it
+ *   next toggles.
  */
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_slave.h"
+#include "hw/core/irq.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
@@ -26,11 +34,15 @@
 #include "trace.h"
 
 #define PCA9548_CHANNEL_COUNT 8
+#define PCA9545_CHANNEL_COUNT 4
 #define PCA9546_CHANNEL_COUNT 4
 
 /*
  * struct Pca954xState - The pca954x state object.
  * @control: The value written to the mux control.
+ * @int_status: Per-channel interrupt status, for parts with interrupt logic.
+ * @int_out: The mux INT output, driven low while any channel interrupt is
+ * active.
  * @channel: The set of i2c channel buses that act as channels which own the
  * i2c children.
  */
@@ -38,6 +50,8 @@ typedef struct Pca954xState {
     SMBusDevice parent;
 
     uint8_t control;
+    uint8_t int_status;
+    qemu_irq int_out;
 
     bool enabled[PCA9548_CHANNEL_COUNT];
     I2CBus *bus[PCA9548_CHANNEL_COUNT];
@@ -48,11 +62,13 @@ typedef struct Pca954xState {
 /*
  * struct Pca954xClass - The pca954x class object.
  * @nchans: The number of i2c channels this device has.
+ * @has_irq: Whether the part implements interrupt logic.
  */
 typedef struct Pca954xClass {
     SMBusDeviceClass parent;
 
     uint8_t nchans;
+    bool has_irq;
 } Pca954xClass;
 
 #define TYPE_PCA954X "pca954x"
@@ -116,8 +132,10 @@ static void pca954x_enable_channel(Pca954xState *s, uint8_t enable_mask)
 
 static void pca954x_write(Pca954xState *s, uint8_t data)
 {
-    s->control = data;
-    pca954x_enable_channel(s, data);
+    Pca954xClass *c = PCA954X_GET_CLASS(s);
+
+    s->control = c->has_irq ? data & ((1 << c->nchans) - 1) : data;
+    pca954x_enable_channel(s, s->control);
 
     trace_pca954x_write_bytes(data);
 }
@@ -148,16 +166,45 @@ static int pca954x_write_data(SMBusDevice *d, uint8_t *buf, uint8_t len)
 static uint8_t pca954x_read_byte(SMBusDevice *d)
 {
     Pca954xState *s = PCA954X(d);
+    Pca954xClass *c = PCA954X_GET_CLASS(s);
     uint8_t data = s->control;
+
+    /*
+     * On parts with interrupt logic the read-back byte carries the per-channel
+     * interrupt status in the upper nibble.
+     */
+    if (c->has_irq) {
+        data = (s->int_status << 4) | (s->control & 0x0f);
+    }
+
     trace_pca954x_read_data(data);
     return data;
 }
 
+/*
+ * A downstream device drives one of the INTn inputs. INTn and INT are active
+ * low, and both carry the physical level: 0 is asserted, 1 is idle.
+ */
+static void pca954x_irq_handler(void *opaque, int n, int level)
+{
+    Pca954xState *s = PCA954X(opaque);
+
+    if (level) {
+        s->int_status &= ~(1 << n);
+    } else {
+        s->int_status |= (1 << n);
+    }
+
+    qemu_set_irq(s->int_out, s->int_status == 0);
+}
+
 static void pca954x_enter_reset(Object *obj, ResetType type)
 {
     Pca954xState *s = PCA954X(obj);
     /* Reset will disable all channels. */
     pca954x_write(s, 0);
+    s->int_status = 0;
+    qemu_set_irq(s->int_out, 1); /* INT released */
 }
 
 I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
@@ -169,6 +216,13 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
     return pca954x->bus[channel];
 }
 
+static void pca9545_class_init(ObjectClass *klass, const void *data)
+{
+    Pca954xClass *s = PCA954X_CLASS(klass);
+    s->nchans = PCA9545_CHANNEL_COUNT;
+    s->has_irq = true;
+}
+
 static void pca9546_class_init(ObjectClass *klass, const void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
@@ -184,12 +238,20 @@ static void pca9548_class_init(ObjectClass *klass, const void *data)
 static void pca954x_realize(DeviceState *dev, Error **errp)
 {
     Pca954xState *s = PCA954X(dev);
+    Pca954xClass *c = PCA954X_GET_CLASS(dev);
     DeviceState *d = DEVICE(s);
     if (s->name) {
         d->id = g_strdup(s->name);
     } else {
         d->id = g_strdup_printf("pca954x[%x]", s->parent.i2c.address);
     }
+
+    if (c->has_irq) {
+        /* One INTn input per channel, plus the shared INT output. */
+        qdev_init_gpio_in_named(dev, pca954x_irq_handler, "interrupt",
+                                c->nchans);
+        qdev_init_gpio_out_named(dev, &s->int_out, "interrupt-out", 1);
+    }
 }
 
 static void pca954x_init(Object *obj)
@@ -242,6 +304,11 @@ static const TypeInfo pca954x_info[] = {
         .class_init    = pca954x_class_init,
         .abstract      = true,
     },
+    {
+        .name          = TYPE_PCA9545,
+        .parent        = TYPE_PCA954X,
+        .class_init    = pca9545_class_init,
+    },
     {
         .name          = TYPE_PCA9546,
         .parent        = TYPE_PCA954X,
diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca954x.h
index 3dd25ec9830..19a10505056 100644
--- a/include/hw/i2c/i2c_mux_pca954x.h
+++ b/include/hw/i2c/i2c_mux_pca954x.h
@@ -3,6 +3,7 @@
 
 #include "hw/i2c/i2c.h"
 
+#define TYPE_PCA9545 "pca9545"
 #define TYPE_PCA9546 "pca9546"
 #define TYPE_PCA9548 "pca9548"
 

-- 
2.50.1


