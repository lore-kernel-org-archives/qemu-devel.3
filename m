Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382AFC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqG-0001xy-Gl; Wed, 19 Aug 2026 22:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq7-0001tz-2t
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:11 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq3-0000YS-Uv
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:10 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66c70d73210so2366531d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194147; x=1787798947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TCYTy9d5gmT9RQQ2gbZfFGHaTBT8oPoZWb28xvQ5yu4=;
 b=rarmh6nmgMz7gfo9Iv04O3IHQQ3thcssGl8KtMnPmDvR7UpCMSGrEWvNS+DpAPfWBs
 Mimc6tdSsBlovmC28+ywDx/N8tPGtNOhnm0ChnOitlbpPNw4PH2O69Sra5VXCiZq1pLx
 HKbLF+0nFd2Iv68jW4IrlZpb5Thz8Ad4Dcs9YA4nPShrO5LbX4Mu0ET4UPZl0X/nZpEB
 55NE/XTwBRDUuA5W2t4PRw3GoR77zkkjwVK8DMXAmfjUoaclWGikOeKMyiiQ288c+D27
 l1p3eKs3g8e6d4tWn/Rau6otiPv/q4jN3R8OAy2A/og6uTBswHTjkNyZjHddasGOxHEZ
 6CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194147; x=1787798947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TCYTy9d5gmT9RQQ2gbZfFGHaTBT8oPoZWb28xvQ5yu4=;
 b=dXpnMc/WHI4bB0LfxdRBCKeh8YF0SVzlHxe7MlGCmmsUmhRk7wVOIqQ/5bG7XbOa4A
 CcYyD+mZLlUzjH0z1pbjjrEWkIdpljxkM6hyga8V8ltSNCEsssrqUVl5HGaNHyRmHUZ6
 rfq3w48jHec6NvMV0NNnn2ET4HJ5eeMpKRoia4yQuVoktMK/4TbTx1uj9AwWHfIVQxJg
 Ql8Zfew7S7R0+XDYHx0E+8q+gyWOpo2xu0oJ+dMkMlM62FgJMYHqnJPfzy94Rd56uqaK
 Al3ab+pZ5xPsBa6XyfXSgOfaOpuf2FjuTG2ZAiIX87xPmUQHWk4qi3M2SFVUOJ1pEHCd
 PJIQ==
X-Gm-Message-State: AFuF++lql6ZAkSipmc3l37MtispzYG3U35nJeTkHNXUSOTwDZg0sJexz
 KRABSxOME1sdQX8IfkSIrsmEFY7ox1LPv+kSayOqiAwwA2KZMmLNuhFgUQTmHA==
X-Gm-Gg: AR+sD10Bn7J/wJKpAQf3yPoVp7rQ8mpKYBm0FddW5KrW+8Qi2jnk09DprV/vRq/wbEV
 UoZeZpEJb5ZBjdhGbcDV56URGjL+K6fxkwzXh44BbqODHN9zrrX80ecQPIAnJN5X+uvvLyGjGYy
 /rN0UgmvS9MSeD6r3jTuiyi4ds898tlltyd9+BhqQc8oCfm5LJ4VdKU8imngZ0VN2ME+w65/NB2
 gC4KSpSlclE/MIq329dGkwkA66FrfyMU+ODptx0PP/JGtXQfLRYTi7m+l8/UL/KgHVy1zKQnD52
 qExDjsTP0sxAxZIjbFOj6FFjcuV+gmS/duP99NW2DesRyZpRqKs5GzXHOhgzINVmKpB4iAmAPuS
 S+xCwAeGKg/3GZL1KojrW49zvyyymnv0nWhMug4B2TV/9yD2U2/h5Q9TmtC7xXWhACjB7Gae78H
 G/dDGRUxOw0OtQptb6QR5LCgrnkbFCcQFMjEtjFAVunq8BZhAX+BSs73Kp2hq+j3S10pIZ97HLM
 OfFmQsIOGievg66jk4c4VeuPM0fTXKw/ntvYDNJaH41nP5LGa2/rQ==
X-Received: by 2002:a05:690e:4090:b0:668:91a8:d447 with SMTP id
 956f58d0204a3-66ccb7375c9mr2792359d50.43.1787194146591; 
 Wed, 19 Aug 2026 19:49:06 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:49:05 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 12/16] hw/misc: add i.MX 95 PMIC (PF09/PF53/PCAL6408A) and
 xcache controllers
Date: Wed, 19 Aug 2026 21:48:30 -0500
Message-Id: <20260820024834.3286721-13-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The i.MX 95 EVK power devices on LPI2C - the PF09 and PF53 regulators
and the PCAL6408A IO expander that the SM firmware sequences during
power-up - modelled as I2C-slave register files, plus the xcache (cache
controller) register block.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/misc/Kconfig        |   7 +
 hw/misc/imx95_pmic.c   | 357 +++++++++++++++++++++++++++++++++++++++++
 hw/misc/imx95_xcache.c | 185 +++++++++++++++++++++
 hw/misc/meson.build    |   2 +
 hw/misc/trace-events   |   8 +
 5 files changed, 559 insertions(+)
 create mode 100644 hw/misc/imx95_pmic.c
 create mode 100644 hw/misc/imx95_xcache.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e1cae92f6f..e1b8c390312 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -283,3 +283,10 @@ config IMX95_GPC
 
 config IMX95_SRC
     bool
+
+config IMX95_PMIC
+    bool
+    select I2C
+
+config IMX95_XCACHE
+    bool
diff --git a/hw/misc/imx95_pmic.c b/hw/misc/imx95_pmic.c
new file mode 100644
index 00000000000..e7101f1ed06
--- /dev/null
+++ b/hw/misc/imx95_pmic.c
@@ -0,0 +1,357 @@
+/*
+ * Minimal I2C device models for the i.MX 95 EVK System Manager:
+ *   - PF09 (PF0900) PMIC          (TYPE_PF09_PMIC,  addr 0x08, CRC'd)
+ *   - PCAL6408A 8-bit IO expander (TYPE_PCAL6408A,  addr 0x20)
+ *   - PF53 buck regulator         (TYPE_PF53_PMIC,  addr 0x2a/0x29)
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The NXP SM firmware probes/configures both over LPI2C1 during board
+ * init (BRD_SM_SerialDevicesInit); a failed transfer aborts SM init.
+ * These are register-file models: writes store, reads return the stored
+ * byte. The PF09 driver protects each transfer with a J1850 CRC, so the
+ * PF09 read path appends the CRC the driver expects
+ * (CRC_J1850((devAddr<<1)|1, reg, data)); without it PF09_Init fails.
+ * No actual PMIC/regulator or GPIO behaviour is modelled.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+/* ---- J1850 CRC (matches imx-sm components/crc/crc.c CRC_J1850) ---- */
+#define CRC_J1850_POLY  0x1Du
+
+static uint8_t crc_j1850(const uint8_t *p, unsigned n)
+{
+    uint32_t crc = 0xffu;
+
+    for (unsigned i = 0; i < n; i++) {
+        crc ^= p[i];
+        for (unsigned b = 0; b < 8; b++) {
+            crc = (crc & 0x80u) ? ((crc << 1) ^ CRC_J1850_POLY)
+                                : ((crc << 1) & 0xffu);
+        }
+    }
+    return (uint8_t)crc;
+}
+
+/* ============================ PF09 PMIC ============================ */
+
+#define TYPE_PF09_PMIC "pf09-pmic"
+OBJECT_DECLARE_SIMPLE_TYPE(PF09State, PF09_PMIC)
+
+#define PF09_NUM_REG    256
+
+struct PF09State {
+    I2CSlave    parent_obj;
+
+    uint8_t     regs[PF09_NUM_REG];
+    uint8_t     cur_reg;
+    uint32_t    wcount;     /* bytes received since START(write) */
+    uint32_t    rcount;     /* bytes returned since START(read) */
+};
+
+static int pf09_event(I2CSlave *i2c, enum i2c_event event)
+{
+    PF09State *s = PF09_PMIC(i2c);
+
+    switch (event) {
+    case I2C_START_SEND:
+        s->wcount = 0;
+        break;
+    case I2C_START_RECV:
+        s->rcount = 0;
+        break;
+    default:
+        break;
+    }
+    return 0;   /* ACK */
+}
+
+static int pf09_send(I2CSlave *i2c, uint8_t data)
+{
+    PF09State *s = PF09_PMIC(i2c);
+
+    if (s->wcount == 0) {
+        s->cur_reg = data;          /* register address */
+    } else if (s->wcount == 1) {
+        s->regs[s->cur_reg] = data; /* data byte */
+        trace_pf09_reg_write(s->cur_reg, data);
+    }
+    /* wcount >= 2 is the trailing CRC byte: accept and ignore. */
+    s->wcount++;
+    return 0;   /* ACK */
+}
+
+static uint8_t pf09_recv(I2CSlave *i2c)
+{
+    PF09State *s = PF09_PMIC(i2c);
+    uint8_t val;
+
+    if (s->rcount == 0) {
+        val = s->regs[s->cur_reg];
+        trace_pf09_reg_read(s->cur_reg, val);
+    } else {
+        /* CRC over (devAddr<<1)|1, reg, data - what PF09_PmicRead checks. */
+        uint8_t buf[3] = {
+            (uint8_t)((i2c->address << 1) | 1u),
+            s->cur_reg,
+            s->regs[s->cur_reg],
+        };
+        val = crc_j1850(buf, 3);
+    }
+    s->rcount++;
+    return val;
+}
+
+static void pf09_reset_hold(Object *obj, ResetType type)
+{
+    PF09State *s = PF09_PMIC(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->cur_reg = 0;
+    s->wcount = 0;
+    s->rcount = 0;
+    /* REV_ID >= 0x20 lets PF09_Init skip the STANDBY-monitor write. */
+    s->regs[0x00] = 0x20;
+}
+
+static const VMStateDescription vmstate_pf09 = {
+    .name = TYPE_PF09_PMIC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, PF09State),
+        VMSTATE_UINT8_ARRAY(regs, PF09State, PF09_NUM_REG),
+        VMSTATE_UINT8(cur_reg, PF09State),
+        VMSTATE_UINT32(wcount, PF09State),
+        VMSTATE_UINT32(rcount, PF09State),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void pf09_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = pf09_event;
+    k->recv = pf09_recv;
+    k->send = pf09_send;
+    dc->vmsd = &vmstate_pf09;
+    rc->phases.hold = pf09_reset_hold;
+    dc->desc = "NXP PF09 PMIC (i.MX95 SM stub)";
+}
+
+static const TypeInfo pf09_info = {
+    .name          = TYPE_PF09_PMIC,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(PF09State),
+    .class_init    = pf09_class_init,
+};
+
+/* ========================== PCAL6408A ============================= */
+
+#define TYPE_PCAL6408A "pcal6408a"
+OBJECT_DECLARE_SIMPLE_TYPE(PCAL6408AState, PCAL6408A)
+
+#define PCAL6408A_NUM_REG   256
+
+struct PCAL6408AState {
+    I2CSlave    parent_obj;
+
+    uint8_t     regs[PCAL6408A_NUM_REG];
+    uint8_t     cur_reg;
+    uint32_t    wcount;
+};
+
+static int pcal6408a_event(I2CSlave *i2c, enum i2c_event event)
+{
+    PCAL6408AState *s = PCAL6408A(i2c);
+
+    if (event == I2C_START_SEND) {
+        s->wcount = 0;
+    }
+    return 0;
+}
+
+static int pcal6408a_send(I2CSlave *i2c, uint8_t data)
+{
+    PCAL6408AState *s = PCAL6408A(i2c);
+
+    if (s->wcount == 0) {
+        s->cur_reg = data;
+    } else {
+        trace_pcal6408a_reg_write(s->cur_reg, data);
+        s->regs[s->cur_reg++] = data;
+    }
+    s->wcount++;
+    return 0;
+}
+
+static uint8_t pcal6408a_recv(I2CSlave *i2c)
+{
+    PCAL6408AState *s = PCAL6408A(i2c);
+    uint8_t val = s->regs[s->cur_reg];
+
+    trace_pcal6408a_reg_read(s->cur_reg, val);
+    s->cur_reg++;
+    return val;
+}
+
+static void pcal6408a_reset_hold(Object *obj, ResetType type)
+{
+    PCAL6408AState *s = PCAL6408A(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->cur_reg = 0;
+    s->wcount = 0;
+}
+
+static const VMStateDescription vmstate_pcal6408a = {
+    .name = TYPE_PCAL6408A,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, PCAL6408AState),
+        VMSTATE_UINT8_ARRAY(regs, PCAL6408AState, PCAL6408A_NUM_REG),
+        VMSTATE_UINT8(cur_reg, PCAL6408AState),
+        VMSTATE_UINT32(wcount, PCAL6408AState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void pcal6408a_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = pcal6408a_event;
+    k->recv = pcal6408a_recv;
+    k->send = pcal6408a_send;
+    dc->vmsd = &vmstate_pcal6408a;
+    rc->phases.hold = pcal6408a_reset_hold;
+    dc->desc = "NXP PCAL6408A IO expander (i.MX95 SM stub)";
+}
+
+static const TypeInfo pcal6408a_info = {
+    .name          = TYPE_PCAL6408A,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(PCAL6408AState),
+    .class_init    = pcal6408a_class_init,
+};
+
+/* ============================ PF53 PMIC ============================ */
+
+/*
+ * PF5301 / PF5302 (PF53-family) buck regulators on the same LPI2C bus.
+ * BRD_SM_SerialDevicesInit calls PF53_Init() on each, which only reads
+ * the DEV_ID register and checks that the transfer ACKs (it does not
+ * validate the value, and the SM configures crcEn=false for these). So a
+ * plain register file that ACKs is sufficient to get past SM init.
+ */
+#define TYPE_PF53_PMIC "pf53-pmic"
+OBJECT_DECLARE_SIMPLE_TYPE(PF53State, PF53_PMIC)
+
+#define PF53_NUM_REG    256
+
+struct PF53State {
+    I2CSlave    parent_obj;
+
+    uint8_t     regs[PF53_NUM_REG];
+    uint8_t     cur_reg;
+    uint32_t    wcount;
+};
+
+static int pf53_event(I2CSlave *i2c, enum i2c_event event)
+{
+    PF53State *s = PF53_PMIC(i2c);
+
+    if (event == I2C_START_SEND) {
+        s->wcount = 0;
+    }
+    return 0;
+}
+
+static int pf53_send(I2CSlave *i2c, uint8_t data)
+{
+    PF53State *s = PF53_PMIC(i2c);
+
+    if (s->wcount == 0) {
+        s->cur_reg = data;
+    } else {
+        trace_pf53_reg_write(s->cur_reg, data);
+        s->regs[s->cur_reg++] = data;
+    }
+    s->wcount++;
+    return 0;
+}
+
+static uint8_t pf53_recv(I2CSlave *i2c)
+{
+    PF53State *s = PF53_PMIC(i2c);
+    uint8_t val = s->regs[s->cur_reg];
+
+    trace_pf53_reg_read(s->cur_reg, val);
+    s->cur_reg++;
+    return val;
+}
+
+static void pf53_reset_hold(Object *obj, ResetType type)
+{
+    PF53State *s = PF53_PMIC(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->cur_reg = 0;
+    s->wcount = 0;
+}
+
+static const VMStateDescription vmstate_pf53 = {
+    .name = TYPE_PF53_PMIC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, PF53State),
+        VMSTATE_UINT8_ARRAY(regs, PF53State, PF53_NUM_REG),
+        VMSTATE_UINT8(cur_reg, PF53State),
+        VMSTATE_UINT32(wcount, PF53State),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void pf53_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = pf53_event;
+    k->recv = pf53_recv;
+    k->send = pf53_send;
+    dc->vmsd = &vmstate_pf53;
+    rc->phases.hold = pf53_reset_hold;
+    dc->desc = "NXP PF53 PMIC (i.MX95 SM stub)";
+}
+
+static const TypeInfo pf53_info = {
+    .name          = TYPE_PF53_PMIC,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(PF53State),
+    .class_init    = pf53_class_init,
+};
+
+static void imx95_pmic_register_types(void)
+{
+    type_register_static(&pf09_info);
+    type_register_static(&pcal6408a_info);
+    type_register_static(&pf53_info);
+}
+
+type_init(imx95_pmic_register_types)
diff --git a/hw/misc/imx95_xcache.c b/hw/misc/imx95_xcache.c
new file mode 100644
index 00000000000..ef7752a6201
--- /dev/null
+++ b/hw/misc/imx95_xcache.c
@@ -0,0 +1,185 @@
+/*
+ * NXP i.MX 95 XCACHE controller stub model
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Minimal model of the M33 XCACHE controller (the two instances at
+ * 0x44400000 "PC" and 0x44400800 "PS"). The NXP System Manager firmware
+ * enables and invalidates its caches early in init by writing the cache
+ * control register (CCR): it sets ENCACHE plus the invalidate/push
+ * command bits and the GO bit, then polls.
+ *
+ * QEMU has no cache to model, so the only behaviour that matters is the
+ * self-clearing of the command bits: real hardware clears GO and the
+ * INVWn/PUSHWn bits once the (instantaneous, for us) operation completes,
+ * and leaves ENCACHE/config bits set. A plain RAM stub would leave GO set
+ * forever (the SM's "wait for GO to clear" loop would hang); a zero-return
+ * stub would leave ENCACHE clear (an "is cache enabled" check would hang).
+ * So CCR persists everything except the command bits, which read back 0.
+ * The line-maintenance registers (CLCR/CSAR/CCVR) are plain storage.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX95_XCACHE "imx95.xcache"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95XCacheState, IMX95_XCACHE)
+
+/* Each instance owns 0x800 (the two M33 instances are 0x800 apart). */
+#define IMX95_XCACHE_REG_SIZE   0x800
+
+#define XCACHE_CCR              0x00
+#define XCACHE_CLCR             0x04
+#define XCACHE_CSAR             0x08
+#define XCACHE_CCVR             0x0C
+
+/* CCR bits that self-clear when the cache command completes. */
+#define CCR_GO                  0x80000000u
+#define CCR_PUSHW1              0x08000000u
+#define CCR_INVW1               0x04000000u
+#define CCR_PUSHW0              0x02000000u
+#define CCR_INVW0               0x01000000u
+#define CCR_CMD_BITS \
+    (CCR_GO | CCR_PUSHW1 | CCR_INVW1 | CCR_PUSHW0 | CCR_INVW0)
+
+struct IMX95XCacheState {
+    SysBusDevice    parent_obj;
+    MemoryRegion    iomem;
+
+    uint32_t        ccr;
+    uint32_t        clcr;
+    uint32_t        csar;
+    uint32_t        ccvr;
+};
+
+static uint64_t imx95_xcache_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX95XCacheState *s = opaque;
+
+    trace_imx95_xcache_read(offset);
+
+    switch (offset) {
+    case XCACHE_CCR:
+        return s->ccr;
+    case XCACHE_CLCR:
+        return s->clcr;
+    case XCACHE_CSAR:
+        return s->csar;
+    case XCACHE_CCVR:
+        return s->ccvr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void imx95_xcache_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    IMX95XCacheState *s = opaque;
+
+    trace_imx95_xcache_write(offset, value);
+
+    switch (offset) {
+    case XCACHE_CCR:
+        /* Command bits complete instantly: store everything else. */
+        s->ccr = (uint32_t)value & ~CCR_CMD_BITS;
+        break;
+    case XCACHE_CLCR:
+        s->clcr = value;
+        break;
+    case XCACHE_CSAR:
+        s->csar = value;
+        break;
+    case XCACHE_CCVR:
+        s->ccvr = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx
+                      " value 0x%" PRIx64 "\n",
+                      __func__, offset, value);
+        break;
+    }
+}
+
+static const MemoryRegionOps imx95_xcache_ops = {
+    .read = imx95_xcache_read,
+    .write = imx95_xcache_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx95_xcache_reset_hold(Object *obj, ResetType type)
+{
+    IMX95XCacheState *s = IMX95_XCACHE(obj);
+
+    s->ccr = 0;
+    s->clcr = 0;
+    s->csar = 0;
+    s->ccvr = 0;
+}
+
+static void imx95_xcache_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMX95XCacheState *s = IMX95_XCACHE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_xcache_ops, s,
+                          TYPE_IMX95_XCACHE, IMX95_XCACHE_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx95_xcache = {
+    .name = TYPE_IMX95_XCACHE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ccr, IMX95XCacheState),
+        VMSTATE_UINT32(clcr, IMX95XCacheState),
+        VMSTATE_UINT32(csar, IMX95XCacheState),
+        VMSTATE_UINT32(ccvr, IMX95XCacheState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_xcache_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx95_xcache;
+    rc->phases.hold = imx95_xcache_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 XCACHE controller (stub)";
+}
+
+static const TypeInfo imx95_xcache_info = {
+    .name           = TYPE_IMX95_XCACHE,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95XCacheState),
+    .instance_init  = imx95_xcache_init,
+    .class_init     = imx95_xcache_class_init,
+};
+
+static void imx95_xcache_register_types(void)
+{
+    type_register_static(&imx95_xcache_info);
+}
+
+type_init(imx95_xcache_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 0b7f5e4382d..d7d283a191b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -178,3 +178,5 @@ system_ss.add(when: 'CONFIG_IMX95_ANATOP', if_true: files('imx95_anatop.c'))
 system_ss.add(when: 'CONFIG_IMX95_AONMIX', if_true: files('imx95_aonmix.c'))
 system_ss.add(when: 'CONFIG_IMX95_GPC', if_true: files('imx95_gpc.c'))
 system_ss.add(when: 'CONFIG_IMX95_SRC', if_true: files('imx95_src.c'))
+system_ss.add(when: 'CONFIG_IMX95_PMIC', if_true: files('imx95_pmic.c'))
+system_ss.add(when: 'CONFIG_IMX95_XCACHE', if_true: files('imx95_xcache.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 15fab0596c2..0555b15a1f3 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -458,3 +458,11 @@ imx95_aonmix_m7_gate(int run) "M7 wait gate -> run=%d"
 imx95_gpc_mode(uint64_t offset, uint32_t target) "CMC_MODE_CTRL off 0x%" PRIx64 " target %u"
 imx95_src_m7mix_release(void) "SRC_GEN.SCR M7MIX reset released"
 imx95_src_slice_ctrl(uint64_t offset, uint32_t value) "SLICE_SW_CTRL off 0x%" PRIx64 " <- 0x%08x"
+imx95_xcache_read(uint64_t offset) "read off 0x%" PRIx64
+imx95_xcache_write(uint64_t offset, uint64_t value) "write off 0x%" PRIx64 " <- 0x%08" PRIx64
+pf09_reg_read(uint8_t reg, uint8_t val) "PF09 reg 0x%02x -> 0x%02x"
+pf09_reg_write(uint8_t reg, uint8_t val) "PF09 reg 0x%02x <- 0x%02x"
+pcal6408a_reg_read(uint8_t reg, uint8_t val) "PCAL6408A reg 0x%02x -> 0x%02x"
+pcal6408a_reg_write(uint8_t reg, uint8_t val) "PCAL6408A reg 0x%02x <- 0x%02x"
+pf53_reg_read(uint8_t reg, uint8_t val) "PF53 reg 0x%02x -> 0x%02x"
+pf53_reg_write(uint8_t reg, uint8_t val) "PF53 reg 0x%02x <- 0x%02x"
-- 
2.34.1


