Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A635BCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGbuw-0006oK-0q; Tue, 13 Oct 2026 08:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbus-0006nP-1M
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1xGbum-0008QY-Pq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:47:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so18035235e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1791895650; x=1792500450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bzd1uJ5ELI9MIEoN1BV9xiWkNnvI+NG1RM+6Al/wByc=;
 b=BYgLaqwD4DiCcbLREx27blcvDqHkwHsaKDytlV4AZ9AfNRSgAi7jyx/YQ56rGvErtK
 ZaxGI1lD6S4E20jgOPekEFdrME1yDraRxFywLEcGzc9OK/Bdvon2DZuVV+CuB9E2t/bR
 q5ugiK7ohVHeji0Y56SgkKUD1l5cqRxdiVron5YnDFOji8PpFDjeLSrvh/Wf6WrRAaO5
 tLVEHO3SUY07zjW8433RirhVh0dUdIaWM0AmwoDVMfxStEDnpypS86hZ7FPxMLkKiHyj
 FGcUI4CUg4z2YamR8MXIB5n7uCoKxaSOctUDzqcYWAAj0Kj7zeTEzgwh5WS8RDVfINE/
 6nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791895650; x=1792500450;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bzd1uJ5ELI9MIEoN1BV9xiWkNnvI+NG1RM+6Al/wByc=;
 b=uTue0TTA7HXllSo4IE6fsKxaZ0xsGUHp2LRWMfALfKokqmOdbHTc6yh5k0L0G+shTW
 dnMuzte1x20unpEMC3MhectKWJinOpmJhzXNt2qXW5ptrKLb9FliTVqGE7r4W+pf1fpq
 Xc75LdB11AQG65aMX9O6XLEJ+T8cNXrHdVcSZnTdt0Pu6cQ1TCoxVl4KaqC2dXOd2BVU
 7oNdP85tdMVtmt62RU2ikgFUjuHAn1Pp9uAPP2MKxKX5kTisIjLnAPLmnLF9lg+SaTc9
 dbpzgV75QZhMNTpksjnfJ3WGuALEZBEIReAGO3WrkLVMr+rPsPW1qDWjHRmdsqiCsulY
 C0dQ==
X-Gm-Message-State: AFq9FYI7jg6Ow7/+NOud9qp0kHP6pDFVq87SRQwJTVIF8FXLsD5RmUmi
 oUIDVolBKsFxlnxHSi1IAVQ3F3U8q2sQGEODMzYp4SEAOyc15UBQhpm/YJ82GKMjF2aRb2oOy+c
 IpjzT
X-Gm-Gg: AYBFou1k+gF9Tn6HZuDWycSm8jF1n5ZS7Bjt+H7E0hnldpidCkUnDZ9V5jcwzejyPct
 FPVWv9B8jym7hhBueCIe2gLvNfPobwLQe+u7L1EfKu22bjRoNciaeXO4l31OIHHmqgm1G3bimyC
 1JX2nlDIgiRbb+Qwc0LVN3NYM3/jafU30bXdpO/QwsGgZOuK9ClVtLLZrHQwqOe9EFYKi6CAHvJ
 zNw5nm0OtFL9J3nNykrCIo9iaABo76WBfyNgsYZaahXQBzKmEoDt9O/D4KVpVHQ10A9WG2jFkFN
 Gt2P6HkbipMrcVf3hKioOufiYvZryarl0IPS5DiTJKIfvSVIrg8piu+P9QO82kYCh44+Z87igkT
 tq+j98uN39OrtCvIXvLorQYoMZ5pmybhffIBmnfYKcoy8fXmMdFAf8SGfL4+FOTLUIoGEEL+6bp
 8cg5xSaCe2Ea0QfAsFlZ7YfzM8lulMuwzoI/9LIFw2t9tbDTTKMNxMz397toFn4x/KAq5SND04E
 daq/QSiOmZ6zR1AYyUDCX8=
X-Received: by 2002:a05:600c:154c:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a18e4a9159mr266427485e9.19.1791895650031; 
 Tue, 13 Oct 2026 05:47:30 -0700 (PDT)
Received: from localhost.localdomain ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ebbsm4768847f8f.45.2026.10.13.05.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:47:29 -0700 (PDT)
From: <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com, clg@kaod.org,
 Alexander Hansen <alexander.hansen@9elements.com>,
 Patrick Leis <venture@google.com>, qemu-arm@nongnu.org
Subject: [PATCH v8 1/5] hw/i2c: support PCA9544
Date: Tue, 13 Oct 2026 14:46:45 +0200
Message-ID: <20261013124649.194808-2-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013124649.194808-1-alexander.hansen@9elements.com>
References: <20261013124649.194808-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x32a.google.com
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

From: Alexander Hansen <alexander.hansen@9elements.com>

Who to explain it better than the manufacturer:

```
The PCA9544A is a 1-of-4 bidirectional translating multiplexer,
controlled via the I2C-bus. The SCL/SDA upstream pair fans out to four
SCx/SDx downstream pairs, or channels. Only one SCx/SDx channel is
selected at a time, determined by the contents of the programmable
control register.
```

The device updates the selected channel after STOP condition, not on
the last byte written [1].

For this reason the parent event handler has to be hooked to prevent
write-read sequence from updating channel selection before STOP
condition.

Reset also had to be modified since a write would not apply the channel
selection by itself.

This emulation is done to support yosemite4 machine emulation.

Interrupt forwarding is currently UNSUPPORTED.

References:
[1] https://www.nxp.com/docs/en/data-sheet/PCA9544A.pdf

Cc: Patrick Leis <venture@google.com> (maintainer:pca954x)
Cc: Emmanuel Blot <eblot@meta.com>
Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)

Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 hw/i2c/i2c_mux_pca954x.c         | 88 ++++++++++++++++++++++++++++----
 include/hw/i2c/i2c_mux_pca954x.h |  1 +
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index c603446028..19212dfa34 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -30,6 +30,10 @@
 
 #define PCA9548_CHANNEL_COUNT 8
 #define PCA9546_CHANNEL_COUNT 4
+#define PCA9544_CHANNEL_COUNT 4
+
+/* enable bit */
+#define PCA9544_ENABLE 0x4
 
 /*
  * struct Pca954xState - The pca954x state object.
@@ -56,6 +60,11 @@ typedef struct Pca954xClass {
     SMBusDeviceClass parent;
 
     uint8_t nchans;
+
+    /* channel enable bit for mux devices, zero for switches */
+    uint8_t mux_enable;
+
+    int (*parent_event)(I2CSlave *s, enum i2c_event event);
 } Pca954xClass;
 
 #define TYPE_PCA954X "pca954x"
@@ -99,28 +108,43 @@ static bool pca954x_match(I2CSlave *candidate, uint8_t address,
     return broadcast;
 }
 
-static void pca954x_enable_channel(Pca954xState *s, uint8_t enable_mask)
+static void pca954x_enable_channel(Pca954xState *s, uint8_t control)
 {
     Pca954xClass *mc = PCA954X_GET_CLASS(s);
     int i;
 
+    if (mc->mux_enable) {
+        uint8_t selected = control & (mc->mux_enable - 1);
+        bool enabled = control & mc->mux_enable;
+
+        for (i = 0; i < mc->nchans; i++) {
+            s->enabled[i] = enabled && i == selected;
+        }
+        return;
+    }
+
     /*
-     * For each channel, check if their bit is set in enable_mask and if yes,
+     * For each channel, check if their bit is set in control and if yes,
      * enable it, otherwise disable, hide it.
      */
     for (i = 0; i < mc->nchans; i++) {
-        if (enable_mask & (1 << i)) {
-            s->enabled[i] = true;
-        } else {
-            s->enabled[i] = false;
-        }
+        s->enabled[i] = control & (1 << i);
     }
 }
 
 static void pca954x_write(Pca954xState *s, uint8_t data)
 {
-    s->control = data;
-    pca954x_enable_channel(s, data);
+    Pca954xClass *mc = PCA954X_GET_CLASS(s);
+    uint8_t data_writable = data;
+
+    if (mc->mux_enable) {
+        data_writable = data & 0x0f;
+    }
+
+    s->control = data_writable;
+    if (!mc->mux_enable) {
+        pca954x_enable_channel(s, data_writable);
+    }
 
     trace_pca954x_write_bytes(data);
 }
@@ -128,6 +152,7 @@ static void pca954x_write(Pca954xState *s, uint8_t data)
 static int pca954x_write_data(SMBusDevice *d, uint8_t *buf, uint8_t len)
 {
     Pca954xState *s = PCA954X(d);
+    Pca954xClass *mc = PCA954X_GET_CLASS(s);
 
     if (len == 0) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: writing empty data\n", __func__);
@@ -136,15 +161,17 @@ static int pca954x_write_data(SMBusDevice *d, uint8_t *buf, uint8_t len)
 
     /*
      * len should be 1, because they write one byte to enable/disable channels.
+     * In case of PCA9544A, multiple bytes can be written but only the last one
+     * will be used.
      */
-    if (len > 1) {
+    if (len > 1 && !mc->mux_enable) {
         qemu_log_mask(LOG_GUEST_ERROR,
             "%s: extra data after channel selection mask\n",
             __func__);
         return -1;
     }
 
-    pca954x_write(s, buf[0]);
+    pca954x_write(s, buf[len - 1]);
     return 0;
 }
 
@@ -156,11 +183,33 @@ static uint8_t pca954x_read_byte(SMBusDevice *d)
     return data;
 }
 
+static int pca954x_event(I2CSlave *s, enum i2c_event event)
+{
+    Pca954xState *state = PCA954X(s);
+    Pca954xClass *mc = PCA954X_GET_CLASS(state);
+
+    int res = mc->parent_event(s, event);
+
+    /*
+     * When a channel is selected, it will become active after
+     * a STOP condition has been placed on the I2C-bus.
+     */
+    if (mc->mux_enable && event == I2C_FINISH) {
+        pca954x_enable_channel(state, state->control);
+    }
+    return res;
+}
+
 static void pca954x_enter_reset(Object *obj, ResetType type)
 {
     Pca954xState *s = PCA954X(obj);
+    Pca954xClass *mc = PCA954X_GET_CLASS(s);
     /* Reset will disable all channels. */
     pca954x_write(s, 0);
+
+    if (mc->mux_enable) {
+        pca954x_enable_channel(s, s->control);
+    }
 }
 
 I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
@@ -172,6 +221,13 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
     return pca954x->bus[channel];
 }
 
+static void pca9544_class_init(ObjectClass *klass, const void *data)
+{
+    Pca954xClass *s = PCA954X_CLASS(klass);
+    s->nchans = PCA9544_CHANNEL_COUNT;
+    s->mux_enable = PCA9544_ENABLE;
+}
+
 static void pca9546_class_init(ObjectClass *klass, const void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
@@ -221,8 +277,13 @@ static void pca954x_class_init(ObjectClass *klass, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     SMBusDeviceClass *k = SMBUS_DEVICE_CLASS(klass);
+    Pca954xClass *s = PCA954X_CLASS(klass);
+
+    /* hook our parent event handler */
+    s->parent_event = sc->event;
 
     sc->match_and_add = pca954x_match;
+    sc->event = pca954x_event;
 
     rc->phases.enter = pca954x_enter_reset;
 
@@ -245,6 +306,11 @@ static const TypeInfo pca954x_info[] = {
         .class_init    = pca954x_class_init,
         .abstract      = true,
     },
+    {
+        .name          = TYPE_PCA9544,
+        .parent        = TYPE_PCA954X,
+        .class_init    = pca9544_class_init,
+    },
     {
         .name          = TYPE_PCA9546,
         .parent        = TYPE_PCA954X,
diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca954x.h
index 3dd25ec983..6449a6dfae 100644
--- a/include/hw/i2c/i2c_mux_pca954x.h
+++ b/include/hw/i2c/i2c_mux_pca954x.h
@@ -3,6 +3,7 @@
 
 #include "hw/i2c/i2c.h"
 
+#define TYPE_PCA9544 "pca9544"
 #define TYPE_PCA9546 "pca9546"
 #define TYPE_PCA9548 "pca9548"
 
-- 
2.56.0


