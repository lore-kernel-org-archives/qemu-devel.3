Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1BACD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 12:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKxUK-0008U9-I7; Thu, 07 May 2026 08:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKxUG-0008TT-BC
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:05:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKxUC-0002BH-5h
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:05:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so6463145ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778155546; x=1778760346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a55fnsta7QVOIhLTdBCQDzrOhK52w63j4puh3Zx2B0Q=;
 b=Z7Z/o5SVR+GTrYf460UFMHSzNPv8VDTFEISiHkjhsO2BeVxxXBJC5DP6nBOF/Zg2k3
 6XmcESKdyfTwbgioSKrHrDAYSPAPWD8SEu1A5LBzhLL+T2eR7GVzB+MFMQRG4Jc4NYSu
 f8osxMNlBeHYXeDBLklCrTdasarDQc7VjscwqXcSqkaV+4kM0urVMm753zxb/zbiybHK
 i3YJOK160bw5s/hz40iFUKLEFs4v6qzum0gRHqcwaKVO8kxF9pyWaHngclr9RiMFj2v/
 8xrvC4PzqkgGPChrl+B57HoakyCHJhLbPfavt154NuwCG5bI4ZpoaVPjFGrRJJm/reVS
 n7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155546; x=1778760346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a55fnsta7QVOIhLTdBCQDzrOhK52w63j4puh3Zx2B0Q=;
 b=UAL0omD7dyot854mqsVUlTxgJX63ITmiBmuxcwHPDe4pOKGZlzaInArAlOqR13+3M9
 cXmLK/ePc/OvIlziCGWXW3ut1yP1kAE3S1qkDafXeGzcidSjCPuu3Pjlqq/8ORUcp5Cm
 QsqugAtLB6Na5wJNaRja5eYD15BY6NYYaAmuOa1PaypHs9uYk68f9XdH8W81jxmaohHb
 sneRVaLb+2Nr0kot+lOZ9HxDEn7fyMbl4JFJVYd/DSOCG1WU2dI+tcJUwafYqzUlkkc1
 mD0WJb3/o9hJ8rlujnFzD3sDkxv7kL3d07dSgnccsWeTNJ6laeUut7vT9UWjM2q41t2Z
 e1Bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Z+QQMZhTmG6dVi3QC2zzE/RaALhoFXPr7roivRMgnS+aAaSpUjqStSZol7XufiVUhaqpGHEMO3I5N@nongnu.org
X-Gm-Message-State: AOJu0Yy9qvlT9V0+cxRTBgdaQnjzW4wpP2iNCR+XhfGYdOTMp0u6OxFk
 CZMBOgoBeef7qnuK2Ke7/Ii4pn41yxf/DfPdpA3AlBJU1/SBuxHl4eIK
X-Gm-Gg: AeBDievEPqJ0j6BNqUL3Og68B48khAQ66jQ2brum6ZHXCn6WMRwm+aXjEdZzdzss5Tc
 NVAyLIXjIT4HCJ4I03L57nfIv9R2Pd+cvrufzL6ZbAFlpNB47RylB/gQOKwmS78jiZ642xObzo6
 LRXJAlFNqw8ku3kcLfAy33DcReOw6Kb2V0MO+Ro1rtVEwgbWKSU1ivvHFDuwpPCOGEo0Gw+tSVk
 ADgjsR6tMlo6PgJ2836mEropmApt3DH41a/3oKK3pfy2dPPuIs8YB5S7DFpVqb5ZofMhHAehXqy
 PYKlyLGKEHJBe6mc+SC0P2FMTR2KE0Vt6NFymYP1k/aW5mCj1Tj21/xO6rM5KiyKn6VWHyZSKCx
 a2gTQAGrwoBExHZr002kCpB854PTAfb4jpiI8ZzagfuxabhCY/PCYnbOaMVkZCHjc1BdC98Hncc
 1fq8ZICjVP35udgxPqMoLc2QPExIoTn4O6NDDWvawhrb8c4y6G/KVspXxXelNbWT/tYhdVMRBhX
 oCtjr5T
X-Received: by 2002:a17:902:bd87:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2ba79c22193mr58822705ad.23.1778155545723; 
 Thu, 07 May 2026 05:05:45 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babaad7b68sm24663835ad.22.2026.05.07.05.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:05:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] [RFC] hw/i2c/designware_i2c: Switch to Fifo8
Date: Thu,  7 May 2026 22:05:20 +1000
Message-ID: <20260507120524.111056-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507120524.111056-1-npiggin@gmail.com>
References: <20260507120524.111056-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Alistair suggested moving to Fifo8, which I think is
a good improvement.

Broken out for individual review, but IMO we should
squash before merge since it changes VMState format.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/i2c/designware_i2c.c         | 37 ++++++++++++++++++++-------------
 include/hw/i2c/designware_i2c.h |  7 +++----
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
index 1e5505f571..83d0968580 100644
--- a/hw/i2c/designware_i2c.c
+++ b/hw/i2c/designware_i2c.c
@@ -208,10 +208,8 @@ static void dw_i2c_update_irq(DesignWareI2CState *s)
     qemu_set_irq(s->irq, level);
 }
 
-static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
+static uint8_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
 {
-    uint32_t value = s->rx_fifo[s->rx_cur];
-
     if (s->status != DW_I2C_STATUS_RECEIVING) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Attempted to read from RX fifo when not in receive "
@@ -223,22 +221,21 @@ static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
         return 0;
     }
 
-    s->rx_cur = (s->rx_cur + 1) % DESIGNWARE_I2C_RX_FIFO_SIZE;
+    g_assert(s->ic_rxflr == fifo8_num_used(&s->rx_fifo));
 
-    if (s->ic_rxflr > 0) {
-        s->ic_rxflr--;
-    } else {
+    if (fifo8_is_empty(&s->rx_fifo)) {
         s->ic_raw_intr_stat |= DW_IC_INTR_RX_UNDER;
         dw_i2c_update_irq(s);
         return 0;
     }
 
+    s->ic_rxflr--;
     if (s->ic_rxflr <= s->ic_rx_tl) {
         s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_FULL;
         dw_i2c_update_irq(s);
     }
 
-    return value;
+    return fifo8_pop(&s->rx_fifo);
 }
 
 static uint64_t dw_i2c_read(void *opaque, hwaddr offset, unsigned size)
@@ -445,6 +442,7 @@ static void dw_i2c_reset_to_idle(DesignWareI2CState *s)
         s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
         s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_OVER;
         s->ic_rxflr = 0;
+        fifo8_reset(&s->rx_fifo);
         s->ic_status &= ~DW_IC_STATUS_ACTIVITY;
         s->status = DW_I2C_STATUS_IDLE;
         dw_i2c_update_irq(s);
@@ -509,10 +507,10 @@ static void dw_i2c_write_ic_data_cmd(DesignWareI2CState *s, uint32_t value)
 
     /* Receive data */
     if (recv) {
-        uint8_t pos = (s->rx_cur + s->ic_rxflr) % DESIGNWARE_I2C_RX_FIFO_SIZE;
+        g_assert(s->ic_rxflr == fifo8_num_used(&s->rx_fifo));
 
-        if (s->ic_rxflr < DESIGNWARE_I2C_RX_FIFO_SIZE) {
-            s->rx_fifo[pos] = i2c_recv(s->bus);
+        if (!fifo8_is_full(&s->rx_fifo)) {
+            fifo8_push(&s->rx_fifo, i2c_recv(s->bus));
             s->ic_rxflr++;
         } else {
             s->ic_raw_intr_stat |= DW_IC_INTR_RX_OVER;
@@ -738,7 +736,8 @@ static void designware_i2c_enter_reset(Object *obj, ResetType type)
     s->ic_comp_version = DW_IC_COMP_VERSION_INIT_VAL;
     s->ic_comp_type = DW_IC_COMP_TYPE_INIT_VAL;
 
-    s->rx_cur = 0;
+    fifo8_reset(&s->rx_fifo);
+
     s->status = DW_I2C_STATUS_IDLE;
 }
 
@@ -777,10 +776,8 @@ static const VMStateDescription vmstate_designware_i2c = {
         VMSTATE_UINT32(ic_comp_param_1, DesignWareI2CState),
         VMSTATE_UINT32(ic_comp_version, DesignWareI2CState),
         VMSTATE_UINT32(ic_comp_type, DesignWareI2CState),
+        VMSTATE_FIFO8(rx_fifo, DesignWareI2CState),
         VMSTATE_UINT32(status, DesignWareI2CState),
-        VMSTATE_UINT8_ARRAY(rx_fifo, DesignWareI2CState,
-                        DESIGNWARE_I2C_RX_FIFO_SIZE),
-        VMSTATE_UINT8(rx_cur, DesignWareI2CState),
         VMSTATE_END_OF_LIST(),
     },
 };
@@ -790,6 +787,8 @@ static void designware_i2c_smbus_init(Object *obj)
     DesignWareI2CState *s = DESIGNWARE_I2C(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
+    fifo8_create(&s->rx_fifo, DESIGNWARE_I2C_RX_FIFO_SIZE);
+
     sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->iomem, obj, &designware_i2c_ops, s,
@@ -799,6 +798,13 @@ static void designware_i2c_smbus_init(Object *obj)
     s->bus = i2c_init_bus(DEVICE(s), "i2c-bus");
 }
 
+static void designware_i2c_finalize(Object *obj)
+{
+    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
+
+    fifo8_destroy(&s->rx_fifo);
+}
+
 static void designware_i2c_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -819,6 +825,7 @@ static const TypeInfo designware_i2c_types[] = {
         .instance_size = sizeof(DesignWareI2CState),
         .class_init = designware_i2c_class_init,
         .instance_init = designware_i2c_smbus_init,
+	.instance_finalize = designware_i2c_finalize,
     },
 };
 DEFINE_TYPES(designware_i2c_types);
diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_i2c.h
index 71d74c9141..affaf983a2 100644
--- a/include/hw/i2c/designware_i2c.h
+++ b/include/hw/i2c/designware_i2c.h
@@ -8,6 +8,7 @@
 #ifndef DESIGNWARE_I2C_H
 #define DESIGNWARE_I2C_H
 
+#include "qemu/fifo8.h"
 #include "hw/i2c/i2c.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
@@ -53,8 +54,6 @@ typedef enum DesignWareI2CStatus {
  * @ic_comp_version: I2C component version register
  * @ic_comp_type: I2C component type register
  * @rx_fifo: The FIFO buffer for receiving in FIFO mode.
- * @rx_cur: The current position of rx_fifo.
- * @status: The current status of the SMBus.
  */
 typedef struct DesignWareI2CState {
     SysBusDevice parent_obj;
@@ -88,8 +87,8 @@ typedef struct DesignWareI2CState {
     uint32_t ic_comp_version;
     uint32_t ic_comp_type;
 
-    uint8_t      rx_fifo[DESIGNWARE_I2C_RX_FIFO_SIZE];
-    uint8_t      rx_cur;
+    /* fifo8_num_used(rx_fifo) should always equal ic_rxflr */
+    Fifo8    rx_fifo;
 
     DesignWareI2CStatus status;
 } DesignWareI2CState;
-- 
2.53.0


