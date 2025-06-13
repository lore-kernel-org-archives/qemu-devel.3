Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B8FC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrxG-0000ox-3p; Thu, 12 Jun 2025 20:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DWtLaAcKCloCGEDG5A8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--komlodi.bounces.google.com>)
 id 1uPruU-0005sv-AB
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:47 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DWtLaAcKCloCGEDG5A8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--komlodi.bounces.google.com>)
 id 1uPruK-0000ak-1H
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:36 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-234dbbc4899so21122015ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773069; x=1750377869; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yLPe5ak+2daSUQYBIKud169Th5/ffkfuG/3PwAWFPbc=;
 b=h29xjjy67H4GrlH4R788g9MZ4l5LOdH03+7em7Z9OtvkCFMSNPCQrvbQK/R9lNDrAU
 cqrITRIHs50EA9Hzmifulz7qxo4Hp14E+S6yurAf60RxG3mCSxP9ZDBmywxgLA6cynDX
 m/qupuXmY3Omff8Y0A9mM2lKqmIqDAk9UOwOAwzqdtgwXeJZhyvzY0bOXH7xa0KARyeB
 om2eyfCgIZ5UpLkEz/LSztx2n5xhs4fsrdtSMI2NUedYFC5wdK5ZZ5n6Ej/wP0nKhkpD
 xfRZdICvze//9lllgCAXhvS8zQBPQ2pMv/dLN0fy/X0DVkkSrw3hiarsvLYk+RWWmFVB
 78gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773069; x=1750377869;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLPe5ak+2daSUQYBIKud169Th5/ffkfuG/3PwAWFPbc=;
 b=sMhjowxJtANs6rDp+YAF4bN3fPZiGPl53ZQ6ANThof1AdFeZ8ETHWmmMlsKW05SNO2
 rlcFoVA1iTUhesVcy3EY03lKoeejR+uAElLu4UDvX+Hiss2n9dyD1N2HkObsZ/ZoQBIg
 0ZHJ3FbDG8kd0Aen/oapnrOL+V4YxjJgI2EvdVz3xes2aixy3e8WOuMQ7Suz4fp2xQ6l
 brM/tMu0rrN0ptFouHTmLq+6X5gwsIvOunCPELLdCUPWjXEqsqO6KbvBKoeQOIk76reJ
 Dnj0UqCPcpgMeASqZ9XsjHCaTiJje4zYB17E2fDLg8u4wBXLxg5IlkT1U5mWL77fw4UC
 h5Iw==
X-Gm-Message-State: AOJu0YwcYTO/jd0RTIz0WEpHKcG4cJTn6fMotUtQVHK2JY0zBsL9RL1w
 N/K1Ufq8wiQADTJ92b9ymBwvxUp7IlZFfxvuqmIbgT65seqpC5NRaXv+veqCEkmKNQsLnGOd8iu
 uhx+zpucftlV7hLYy3iLVPVjbYXJX9DcST3OqUPSMgusgQLxKIPvxhXdZ+4Apr7mhXH1KoXd8BI
 L15uGl/9utg7gbrXWMw5ZRdOgqoGSfNIQTRO1QbNlW
X-Google-Smtp-Source: AGHT+IEDGoBBh5Q4NKvODKXbx27HRrFr74xQ8hunpagtfKiBk/Sde98JxcUqBif9zFpLZmZcOFa8hxP2BEFf
X-Received: from pgbfm22.prod.google.com
 ([2002:a05:6a02:4996:b0:b29:82be:c692])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc44:b0:234:c549:da14
 with SMTP id d9443c01a7336-2365dc0d163mr13433885ad.29.1749773069459; Thu, 12
 Jun 2025 17:04:29 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:04:04 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-13-komlodi@google.com>
Subject: [PATCH 12/19] hw/i3c/dw-i3c: Add data TX and RX
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3DWtLaAcKCloCGEDG5A8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This adds data and CCC transmission, reception, and the associated
queues required for data transmission and reception to happen.

The I3C controller transmits data by the user writing into a command
queue. When the queue has a command and an argument in it, the
controller starts executing the command.

The controller can execute 1 of 3 ways:
1. A larger data transfer that involves using the TX and RX queues. This
   is the most common way the controller does transactions.

2. A small data transfer that involves sending a couple bytes passed
   into the command queue argument.

3. An address assignment command. This is how the controller does
   ENTDAA. When ENTDAA succeeds in assigning an address to a target, it
   updates the controller's char table with the target's PID, BCR, and
   DCR.

The controller determines what addresses to send by looking at the index
in the device address table specified by the argument in the command
queue. ENTDAA also uses these addresses to assign to targets on the bus.

When the controller is done executing a command, it puts a response in
the response queue indicating how command execution went.

In order for the user to send and receive data to/from the controller,
the user reads/writes to a bidirectional TX/RX port.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Stephen Longfield <slongfield@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/dw-i3c.c             | 882 +++++++++++++++++++++++++++++++++++-
 hw/i3c/trace-events         |  10 +
 include/hw/i3c/aspeed_i3c.h |   1 +
 include/hw/i3c/dw-i3c.h     | 143 +++++-
 4 files changed, 1030 insertions(+), 6 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index c58e12964c..2c3e1a5760 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -353,12 +353,179 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0xffffffff,
 };
 
+static inline bool dw_i3c_has_hdr_ts(DWI3C *s)
+{
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);
+}
+
+static inline bool dw_i3c_has_hdr_ddr(DWI3C *s)
+{
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_DDR);
+}
+
+static inline bool dw_i3c_can_transmit(DWI3C *s)
+{
+    /*
+     * We can only transmit if we're enabled and the resume bit is cleared.
+     * The resume bit is set on a transaction error, and software must clear it.
+     */
+    return ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_EN) &&
+           !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);
+}
+
+static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)
+{
+    return regval = regval ? (2 << regval) : 1;
+}
+
 static void dw_i3c_update_irq(DWI3C *s)
 {
     bool level = !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);
     qemu_set_irq(s->irq, level);
 }
 
+static void dw_i3c_end_transfer(DWI3C *s, bool is_i2c)
+{
+    if (is_i2c) {
+        legacy_i2c_end_transfer(s->bus);
+    } else {
+        i3c_end_transfer(s->bus);
+    }
+}
+
+static int dw_i3c_send_start(DWI3C *s, uint8_t addr, bool is_recv, bool is_i2c)
+{
+    int ret;
+
+    if (is_i2c) {
+        ret = legacy_i2c_start_transfer(s->bus, addr, is_recv);
+    } else {
+        ret = i3c_start_transfer(s->bus, addr, is_recv);
+    }
+    if (ret) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed on TX with addr 0x%.2x\n",
+                      path, addr);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                         DW_I3C_TRANSFER_STATUS_HALT);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);
+    }
+
+    return ret;
+}
+
+static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t num_to_send,
+                       uint32_t *num_sent, bool is_i2c)
+{
+    int ret;
+    uint32_t i;
+
+    *num_sent = 0;
+    if (is_i2c) {
+        /* Legacy I2C must be byte-by-byte. */
+        for (i = 0; i < num_to_send; i++) {
+            ret = legacy_i2c_send(s->bus, data[i]);
+            if (ret) {
+                break;
+            }
+            (*num_sent)++;
+        }
+    } else {
+        ret = i3c_send(s->bus, data, num_to_send, num_sent);
+    }
+    if (ret) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed sending byte 0x%.2x\n",
+                      path, data[*num_sent]);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                         DW_I3C_TRANSFER_STATUS_HALT);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);
+    }
+
+    trace_dw_i3c_send(s->cfg.id, *num_sent);
+
+    return ret;
+}
+
+static int dw_i3c_send_byte(DWI3C *s, uint8_t byte, bool is_i2c)
+{
+    /*
+     * Ignored, the caller will know if we sent 0 or 1 bytes depending on if
+     * we were ACKed/NACKed.
+     */
+    uint32_t num_sent;
+    return dw_i3c_send(s, &byte, 1, &num_sent, is_i2c);
+}
+
+static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,
+                            uint16_t num_to_read, uint32_t *num_read)
+{
+    int ret;
+
+    if (is_i2c) {
+        for (uint16_t i = 0; i < num_to_read; i++) {
+            data[i] = legacy_i2c_recv(s->bus);
+        }
+        /* I2C devices can neither NACK a read, nor end transfers early. */
+        *num_read = num_to_read;
+        trace_dw_i3c_recv_data(s->cfg.id, *num_read);
+        return 0;
+    }
+    /* I3C devices can NACK if the controller sends an unsupported CCC. */
+    ret = i3c_recv(s->bus, data, num_to_read, num_read);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed receiving byte\n",
+                      object_get_canonical_path(OBJECT(s)));
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                         DW_I3C_TRANSFER_STATUS_HALT);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);
+    }
+
+    trace_dw_i3c_recv_data(s->cfg.id, *num_read);
+
+    return ret;
+}
+
+static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)
+{
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
+    uint16_t dev_index = (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER,
+                                          ADDR) / sizeof(uint32_t)) + offset;
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,
+                   LEGACY_I2C_DEVICE);
+}
+
+static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t offset)
+{
+    if (offset > s->cfg.num_addressable_devices) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device addr table offset %d out of "
+                      "bounds\n", path, offset);
+        /* If we're out of bounds, return an address of 0. */
+        return 0;
+    }
+
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
+    uint16_t dev_index = (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER,
+                                          ADDR) / sizeof(uint32_t)) + offset;
+    /* I2C devices use a static address. */
+    if (dw_i3c_target_is_i2c(s, offset)) {
+        return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,
+                          DEV_STATIC_ADDR);
+    }
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,
+                      DEV_DYNAMIC_ADDR);
+}
+
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)
 {
     /* Only return the status whose corresponding EN bits are set. */
@@ -393,6 +560,56 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)
     dw_i3c_update_irq(s);
 }
 
+static uint32_t dw_i3c_pop_rx(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->rx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read RX FIFO when empty\n",
+                      path);
+        return 0;
+    }
+
+    uint32_t val = fifo32_pop(&s->rx_queue);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,
+                     fifo32_num_used(&s->rx_queue));
+
+    /* Threshold is 2^RX_BUF_THLD. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                         RX_BUF_THLD);
+    threshold = dw_i3c_fifo_threshold_from_reg(threshold);
+    if (fifo32_num_used(&s->rx_queue) < threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);
+        dw_i3c_update_irq(s);
+    }
+
+    trace_dw_i3c_pop_rx(s->cfg.id, val);
+    return val;
+}
+
+static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->resp_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read response FIFO when "
+                      "empty\n", path);
+        return 0;
+    }
+
+    uint32_t val = fifo32_pop(&s->resp_queue);
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,
+                     fifo32_num_used(&s->resp_queue));
+
+    /* Threshold is the register value + 1. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                         RESP_BUF_THLD) + 1;
+    if (fifo32_num_used(&s->resp_queue) < threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);
+        dw_i3c_update_irq(s);
+    }
+
+    return val;
+}
+
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
 {
     DWI3C *s = DW_I3C(opaque);
@@ -409,16 +626,635 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
     case R_INTR_STATUS:
         value = dw_i3c_intr_status_r(s);
         break;
+    case R_RX_TX_DATA_PORT:
+        value = dw_i3c_pop_rx(s);
+        break;
+    case R_RESPONSE_QUEUE_PORT:
+        value = dw_i3c_resp_queue_port_r(s);
+        break;
     default:
         value = s->regs[addr];
         break;
     }
 
-    trace_dw_i3c_read(s->id, offset, value);
+    trace_dw_i3c_read(s->cfg.id, offset, value);
 
     return value;
 }
 
+static void dw_i3c_resp_queue_push(DWI3C *s, uint8_t err, uint8_t tid,
+                                   uint8_t ccc_type, uint16_t data_len)
+{
+    uint32_t val = 0;
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, ERR_STATUS, err);
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, TID, tid);
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, CCCT, ccc_type);
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, DL, data_len);
+    if (!fifo32_is_full(&s->resp_queue)) {
+        trace_dw_i3c_resp_queue_push(s->cfg.id, val);
+        fifo32_push(&s->resp_queue, val);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,
+                     fifo32_num_used(&s->resp_queue));
+    /* Threshold is the register value + 1. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                         RESP_BUF_THLD) + 1;
+    if (fifo32_num_used(&s->resp_queue) >= threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 1);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static void dw_i3c_push_tx(DWI3C *s, uint32_t val)
+{
+    if (fifo32_is_full(&s->tx_queue)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to TX FIFO when "
+                      "full\n", object_get_canonical_path(OBJECT(s)));
+        return;
+    }
+
+    trace_dw_i3c_push_tx(s->cfg.id, val);
+    fifo32_push(&s->tx_queue, val);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     fifo32_num_free(&s->tx_queue));
+
+    /* Threshold is 2^TX_BUF_THLD. */
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                               TX_BUF_THLD);
+    empty_threshold =
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);
+    if (fifo32_num_free(&s->tx_queue) < empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 0);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static uint32_t dw_i3c_pop_tx(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->tx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to pop from TX FIFO when "
+                      "empty\n", path);
+        return 0;
+    }
+
+    uint32_t val = fifo32_pop(&s->tx_queue);
+    trace_dw_i3c_pop_tx(s->cfg.id, val);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     fifo32_num_free(&s->tx_queue));
+
+    /* Threshold is 2^TX_BUF_THLD. */
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                               TX_BUF_THLD);
+    empty_threshold =
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);
+    if (fifo32_num_free(&s->tx_queue) >= empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);
+        dw_i3c_update_irq(s);
+    }
+    return val;
+}
+
+static void dw_i3c_push_rx(DWI3C *s, uint32_t val)
+{
+    if (fifo32_is_full(&s->rx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to RX FIFO when "
+                      "full\n", path);
+        return;
+    }
+    trace_dw_i3c_push_rx(s->cfg.id, val);
+    fifo32_push(&s->rx_queue, val);
+
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,
+                     fifo32_num_used(&s->rx_queue));
+    /* Threshold is 2^RX_BUF_THLD. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                         RX_BUF_THLD);
+    threshold = dw_i3c_fifo_threshold_from_reg(threshold);
+    if (fifo32_num_used(&s->rx_queue) >= threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 1);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,
+                                  DWI3CShortArg arg)
+{
+    uint8_t err = DW_I3C_RESP_QUEUE_ERR_NONE;
+    uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index);
+    bool is_i2c = dw_i3c_target_is_i2c(s, cmd.dev_index);
+    uint8_t data[4]; /* Max we can send on a short transfer is 4 bytes. */
+    uint8_t len = 0;
+    uint32_t bytes_sent; /* Ignored on short transfers. */
+
+    /* Can't do reads on a short transfer. */
+    if (cmd.rnw) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Cannot do a read on a short "
+                      "transfer\n", path);
+        return;
+    }
+
+    if (dw_i3c_send_start(s, addr, /*is_recv=*/false, is_i2c)) {
+        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+        goto transfer_done;
+    }
+
+    /* Are we sending a command? */
+    if (cmd.cp) {
+        data[len] = cmd.cmd;
+        len++;
+        /*
+         * byte0 is the defining byte for a command, and is only sent if a
+         * command is present and if the command has a defining byte present.
+         * (byte_strb & 0x01) is always treated as set by the controller, and is
+         * ignored.
+         */
+        if (cmd.dbp) {
+            data[len] += arg.byte0;
+            len++;
+        }
+    }
+
+    /* Send the bytes passed in the argument. */
+    if (arg.byte_strb & 0x02) {
+        data[len] = arg.byte1;
+        len++;
+    }
+    if (arg.byte_strb & 0x04) {
+        data[len] = arg.byte2;
+        len++;
+    }
+
+    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
+        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+    } else {
+        /* Only go to an idle state on a successful transfer. */
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_IDLE);
+    }
+
+transfer_done:
+    if (cmd.toc) {
+        dw_i3c_end_transfer(s, is_i2c);
+    }
+    if (cmd.roc) {
+        /*
+         * ccc_type is always 0 in controller mode, data_len is 0 in short
+         * transfers.
+         */
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=*/0,
+                                          /*data_len=*/0);
+    }
+}
+
+/* Returns number of bytes transmitted. */
+static uint16_t dw_i3c_tx(DWI3C *s, uint16_t num, bool is_i2c)
+{
+    uint16_t bytes_sent = 0;
+    union {
+        uint8_t b[sizeof(uint32_t)];
+        uint32_t val;
+    } val32;
+
+    while (bytes_sent < num) {
+        val32.val = dw_i3c_pop_tx(s);
+        for (uint8_t i = 0; i < sizeof(val32.val); i++) {
+            if (dw_i3c_send_byte(s, val32.b[i], is_i2c)) {
+                return bytes_sent;
+            }
+            bytes_sent++;
+
+            /* We're not sending the full 32-bits, break early. */
+            if (bytes_sent >= num) {
+                break;
+            }
+        }
+    }
+
+    return bytes_sent;
+}
+
+/* Returns number of bytes received. */
+static uint16_t dw_i3c_rx(DWI3C *s, uint16_t num, bool is_i2c)
+{
+    /*
+     * Allocate a temporary buffer to read data from the target.
+     * Zero it and word-align it as well in case we're reading unaligned data.
+     */
+    g_autofree uint8_t *data = g_new0(uint8_t, num + (4 - (num & 0x03)));
+    uint32_t *data32 = (uint32_t *)data;
+    /*
+     * 32-bits since the I3C API wants a 32-bit number, even though the
+     * controller can only do 16-bit transfers.
+     */
+    uint32_t num_read = 0;
+
+    /* Can NACK if the target receives an unsupported CCC. */
+    if (dw_i3c_recv_data(s, is_i2c, data, num, &num_read)) {
+        return 0;
+    }
+
+    for (uint16_t i = 0; i < num_read / 4; i++) {
+        dw_i3c_push_rx(s, *data32);
+        data32++;
+    }
+    /*
+     * If we're pushing data that isn't 32-bit aligned, push what's left.
+     * It's software's responsibility to know what bits are valid in the partial
+     * data.
+     */
+    if (num_read & 0x03) {
+        dw_i3c_push_rx(s, *data32);
+    }
+
+    return num_read;
+}
+
+static int dw_i3c_transfer_ccc(DWI3C *s, DWI3CTransferCmd cmd,
+                               DWI3CTransferArg arg)
+{
+    /* CCC start is always a write. CCCs cannot be done on I2C devices. */
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=*/false,
+                                     /*is_i2c=*/false)) {
+        return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+    }
+    trace_dw_i3c_transfer_ccc(s->cfg.id, cmd.cmd);
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=*/false)) {
+        return DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+    }
+
+    /* On a direct CCC, we do a restart and then send the target's address. */
+    if (CCC_IS_DIRECT(cmd.cmd)) {
+        bool is_recv = cmd.rnw;
+        uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index);
+        if (dw_i3c_send_start(s, addr, is_recv, /*is_i2c=*/false)) {
+            return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+        }
+    }
+
+    return DW_I3C_RESP_QUEUE_ERR_NONE;
+}
+
+static void dw_i3c_transfer(DWI3C *s, DWI3CTransferCmd cmd,
+                            DWI3CTransferArg arg)
+{
+    bool is_recv = cmd.rnw;
+    uint8_t err = DW_I3C_RESP_QUEUE_ERR_NONE;
+    uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index);
+    bool is_i2c = dw_i3c_target_is_i2c(s, cmd.dev_index);
+    uint16_t bytes_transferred = 0;
+
+    if (cmd.cp) {
+        /* We're sending a CCC. */
+        err = dw_i3c_transfer_ccc(s, cmd, arg);
+        if (err != DW_I3C_RESP_QUEUE_ERR_NONE) {
+            goto transfer_done;
+        }
+    } else {
+        if (ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_BROADCAST_ADDR_INC) &&
+            is_i2c == false) {
+            if (dw_i3c_send_start(s, I3C_BROADCAST,
+                                             /*is_recv=*/false, is_i2c)) {
+                err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+                goto transfer_done;
+            }
+        }
+        /* Otherwise we're doing a private transfer. */
+        if (dw_i3c_send_start(s, addr, is_recv, is_i2c)) {
+            err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+            goto transfer_done;
+        }
+    }
+
+    if (is_recv) {
+        bytes_transferred = dw_i3c_rx(s, arg.data_len, is_i2c);
+    } else {
+        bytes_transferred = dw_i3c_tx(s, arg.data_len, is_i2c);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                     DW_I3C_TRANSFER_STATE_IDLE);
+
+transfer_done:
+    if (cmd.toc) {
+        dw_i3c_end_transfer(s, is_i2c);
+    }
+    if (cmd.roc) {
+        /*
+         * data_len is the number of bytes that still need to be TX'd, or the
+         * number of bytes RX'd.
+         */
+        uint16_t data_len = is_recv ? bytes_transferred : arg.data_len -
+                                                          bytes_transferred;
+        /* CCCT is always 0 in controller mode. */
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=*/0,
+                                          data_len);
+    }
+
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_transfer_cmd(DWI3C *s, DWI3CTransferCmd cmd,
+                                DWI3CCmdQueueData arg)
+{
+    uint8_t arg_attr = FIELD_EX32(arg.word, COMMAND_QUEUE_PORT, CMD_ATTR);
+
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CMD_TID, cmd.tid);
+
+    /* User is trying to do HDR transfers, see if we can do them. */
+    if (cmd.speed == 0x06 && !dw_i3c_has_hdr_ddr(s)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR DDR is not supported\n", path);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        return;
+    }
+    if (cmd.speed == 0x05 && !dw_i3c_has_hdr_ts(s)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR TS is not supported\n", path);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        return;
+    }
+
+    if (arg_attr == DW_I3C_CMD_ATTR_TRANSFER_ARG) {
+        dw_i3c_transfer(s, cmd, arg.transfer_arg);
+    } else if (arg_attr == DW_I3C_CMD_ATTR_SHORT_DATA_ARG) {
+        dw_i3c_short_transfer(s, cmd, arg.short_arg);
+    } else {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown command queue cmd_attr 0x%x"
+                      "\n", path, arg_attr);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+    }
+}
+
+static void dw_i3c_update_char_table(DWI3C *s, uint8_t offset, uint64_t pid,
+                                     uint8_t bcr, uint8_t dcr, uint8_t addr)
+{
+    if (offset > s->cfg.num_addressable_devices) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device char table offset %d out of "
+                      "bounds\n", path, offset);
+        /* If we're out of bounds, do nothing. */
+        return;
+    }
+
+    /*
+     * Each device offset is 128 bits apart in the table, since each device gets
+     * 4 * 32-bits of entries in the table.
+     * / sizeof(uint32_t) because we're indexing into our 32-bit reg array.
+     */
+    uint16_t dev_index = (ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,
+                                          P_DEV_CHAR_TABLE_START_ADDR) /
+                                          sizeof(uint32_t)) +
+                                          (offset * sizeof(uint32_t));
+    s->regs[dev_index] = pid & 0xffffffff;
+    pid >>= 32;
+    s->regs[dev_index + 1] = FIELD_DP32(s->regs[dev_index + 1],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC2,
+                                        MSB_PID, pid);
+    s->regs[dev_index + 2] = FIELD_DP32(s->regs[dev_index + 2],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR,
+                                        dcr);
+    s->regs[dev_index + 2] = FIELD_DP32(s->regs[dev_index + 2],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR,
+                                        bcr);
+    s->regs[dev_index + 3] = FIELD_DP32(s->regs[dev_index + 3],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC4,
+                                        DEV_DYNAMIC_ADDR, addr);
+
+    /* Increment PRESENT_DEV_CHAR_TABLE_INDEX. */
+    uint8_t idx = ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,
+                     PRESENT_DEV_CHAR_TABLE_INDEX);
+    /* Increment and rollover. */
+    idx++;
+    if (idx >= ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,
+                               DEV_CHAR_TABLE_DEPTH) / 4) {
+        idx = 0;
+    }
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,
+                     PRESENT_DEV_CHAR_TABLE_INDEX, idx);
+}
+
+static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
+{
+    uint8_t i = 0;
+    uint8_t err = DW_I3C_RESP_QUEUE_ERR_NONE;
+
+    /* Tell everyone to ENTDAA. If these error, no one is on the bus. */
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=*/false,
+                                     /*is_i2c=*/false)) {
+        err = DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+        goto transfer_done;
+    }
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=*/false)) {
+        err = DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+        goto transfer_done;
+    }
+
+    /* Go through each device in the table and assign it an address. */
+    for (i = 0; i < cmd.dev_count; i++) {
+        uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index + i);
+        union {
+            uint64_t pid:48;
+            uint8_t bcr;
+            uint8_t dcr;
+            uint32_t w[2];
+            uint8_t b[8];
+        } target_info;
+
+        /* If this fails, there was no one left to ENTDAA. */
+        if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=*/false,
+                                         /*is_i2c=*/false)) {
+            err = DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+            break;
+        }
+
+        /*
+         * In ENTDAA, we read 8 bytes from the target, which will be the
+         * target's PID, BCR, and DCR. After that, we send it the dynamic
+         * address.
+         * Don't bother checking the number of bytes received, it must send 8
+         * bytes during ENTDAA.
+         */
+        uint32_t num_read;
+        if (dw_i3c_recv_data(s, /*is_i2c=*/false, target_info.b,
+                                        I3C_ENTDAA_SIZE, &num_read)) {
+            g_autofree char *path = object_get_canonical_path(OBJECT(s));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed ENTDAA CCC\n",
+                          path);
+            err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
+            goto transfer_done;
+        }
+        if (dw_i3c_send_byte(s, addr, /*is_i2c=*/false)) {
+            g_autofree char *path = object_get_canonical_path(OBJECT(s));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed addr 0x%.2x "
+                          "during ENTDAA\n", path, addr);
+            err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
+            break;
+        }
+        dw_i3c_update_char_table(s, cmd.dev_index + i,
+                                            target_info.pid, target_info.bcr,
+                                            target_info.dcr, addr);
+
+        /* Push the PID, BCR, and DCR to the RX queue. */
+        dw_i3c_push_rx(s, target_info.w[0]);
+        dw_i3c_push_rx(s, target_info.w[1]);
+    }
+
+transfer_done:
+    /* Do we send a STOP? */
+    if (cmd.toc) {
+        dw_i3c_end_transfer(s, /*is_i2c=*/false);
+    }
+    /*
+     * For addr assign commands, the length field is the number of devices
+     * left to assign. CCCT is always 0 in controller mode.
+     */
+    if (cmd.roc) {
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=*/0,
+                                         cmd.dev_count - i);
+    }
+}
+
+static uint32_t dw_i3c_cmd_queue_pop(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->cmd_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to dequeue command queue "
+                      "when it was empty\n", path);
+        return 0;
+    }
+    uint32_t val = fifo32_pop(&s->cmd_queue);
+
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                               CMD_BUF_EMPTY_THLD);
+    uint8_t cmd_queue_empty_loc = ARRAY_FIELD_EX32(s->regs,
+                                                   QUEUE_STATUS_LEVEL,
+                                                   CMD_QUEUE_EMPTY_LOC);
+    cmd_queue_empty_loc++;
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                     cmd_queue_empty_loc);
+    if (cmd_queue_empty_loc >= empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);
+        dw_i3c_update_irq(s);
+    }
+
+    return val;
+}
+
+static void dw_i3c_cmd_queue_execute(DWI3C *s)
+{
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                     DW_I3C_TRANSFER_STATE_IDLE);
+    if (!dw_i3c_can_transmit(s)) {
+        return;
+    }
+
+    /*
+     * We only start executing when a command is passed into the FIFO.
+     * We expect there to be a multiple of 2 items in the queue. The first item
+     * should be an argument to a command, and the command should be the second
+     * item.
+     */
+    if (fifo32_num_used(&s->cmd_queue) & 1) {
+        return;
+    }
+
+    while (!fifo32_is_empty(&s->cmd_queue)) {
+        DWI3CCmdQueueData arg;
+        arg.word = dw_i3c_cmd_queue_pop(s);
+        DWI3CCmdQueueData cmd;
+        cmd.word = dw_i3c_cmd_queue_pop(s);
+        trace_dw_i3c_cmd_queue_execute(s->cfg.id, cmd.word, arg.word);
+
+        uint8_t cmd_attr = FIELD_EX32(cmd.word, COMMAND_QUEUE_PORT, CMD_ATTR);
+        switch (cmd_attr) {
+        case DW_I3C_CMD_ATTR_TRANSFER_CMD:
+            dw_i3c_transfer_cmd(s, cmd.transfer_cmd, arg);
+            break;
+        case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:
+            /* Arg is discarded for addr assign commands. */
+            dw_i3c_addr_assign_cmd(s, cmd.addr_assign_cmd);
+            break;
+        case DW_I3C_CMD_ATTR_TRANSFER_ARG:
+        case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:
+            {
+                g_autofree char *path = object_get_canonical_path(OBJECT(s));
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received "
+                              "argument packet when it expected a command "
+                              "packet\n", path);
+            }
+            break;
+        default:
+            /*
+             * The caller's check before queueing an item should prevent this
+             * from happening.
+             */
+            g_assert_not_reached();
+            break;
+        }
+    }
+}
+
+static void dw_i3c_cmd_queue_push(DWI3C *s, uint32_t val)
+{
+    if (fifo32_is_full(&s->cmd_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received packet when "
+                      "already full\n", path);
+        return;
+    }
+    trace_dw_i3c_cmd_queue_push(s->cfg.id, val);
+    fifo32_push(&s->cmd_queue, val);
+
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                               CMD_BUF_EMPTY_THLD);
+    uint8_t cmd_queue_empty_loc = ARRAY_FIELD_EX32(s->regs,
+                                                   QUEUE_STATUS_LEVEL,
+                                                   CMD_QUEUE_EMPTY_LOC);
+    if (cmd_queue_empty_loc) {
+        cmd_queue_empty_loc--;
+        ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                         cmd_queue_empty_loc);
+    }
+    if (cmd_queue_empty_loc < empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 0);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static void dw_i3c_cmd_queue_port_w(DWI3C *s, uint32_t val)
+{
+    uint8_t cmd_attr = FIELD_EX32(val, COMMAND_QUEUE_PORT, CMD_ATTR);
+
+    switch (cmd_attr) {
+    /* If a command is received we can start executing it. */
+    case DW_I3C_CMD_ATTR_TRANSFER_CMD:
+    case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:
+        dw_i3c_cmd_queue_push(s, val);
+        dw_i3c_cmd_queue_execute(s);
+        break;
+    /* If we get an argument just push it. */
+    case DW_I3C_CMD_ATTR_TRANSFER_ARG:
+    case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:
+        dw_i3c_cmd_queue_push(s, val);
+        break;
+    default:
+        {
+            g_autofree char *path = object_get_canonical_path(OBJECT(s));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received packet "
+                          "with unknown cmd attr 0x%x\n", path, cmd_attr);
+        }
+        break;
+    }
+}
+
 static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
                          unsigned size)
 {
@@ -426,7 +1262,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
     uint32_t addr = offset >> 2;
     uint32_t val32 = (uint32_t)value;
 
-    trace_dw_i3c_write(s->id, offset, value);
+    trace_dw_i3c_write(s->cfg.id, offset, value);
 
     val32 &= ~dw_i3c_ro[addr];
     switch (addr) {
@@ -450,6 +1286,10 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
                       __func__, offset, value);
         break;
     case R_RX_TX_DATA_PORT:
+        dw_i3c_push_tx(s, val32);
+        break;
+    case R_COMMAND_QUEUE_PORT:
+        dw_i3c_cmd_queue_port_w(s, val32);
         break;
     case R_RESET_CTRL:
         break;
@@ -492,22 +1332,56 @@ static void dw_i3c_reset_enter(Object *obj, ResetType type)
     DWI3C *s = DW_I3C(obj);
 
     memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));
+    /*
+     * The user config for these may differ from our resets array, set them
+     * manually.
+     */
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,
+                     s->cfg.dev_addr_table_pointer);
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,
+                     s->cfg.dev_addr_table_depth);
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,
+                     P_DEV_CHAR_TABLE_START_ADDR,
+                     s->cfg.dev_char_table_pointer);
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
+                     s->cfg.dev_char_table_depth);
 }
 
 static void dw_i3c_realize(DeviceState *dev, Error **errp)
 {
     DWI3C *s = DW_I3C(dev);
-    g_autofree char *name = g_strdup_printf(TYPE_DW_I3C ".%d", s->id);
+    g_autofree char *name = g_strdup_printf(TYPE_DW_I3C ".%d", s->cfg.id);
 
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 
     memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,
                           DW_I3C_NR_REGS << 2);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+
+    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_bytes);
+    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);
+    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);
+    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);
+
+    s->bus = i3c_init_bus(DEVICE(s), name);
 }
 
 static const Property dw_i3c_properties[] = {
-    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),
+    DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
+    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,
+                      cfg.cmd_resp_queue_capacity_bytes, 0x10),
+    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,
+                      cfg.tx_rx_queue_capacity_bytes, 0x40),
+    DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,
+                      cfg.num_addressable_devices, 8),
+    DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,
+                       cfg.dev_addr_table_pointer, 0x280),
+    DEFINE_PROP_UINT16("dev-addr-table-depth", DWI3C,
+                       cfg.dev_addr_table_depth, 0x08),
+    DEFINE_PROP_UINT16("dev-char-table-pointer", DWI3C,
+                       cfg.dev_char_table_pointer, 0x200),
+    DEFINE_PROP_UINT16("dev-char-table-depth", DWI3C,
+                       cfg.dev_char_table_depth, 0x20),
 };
 
 static void dw_i3c_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index 2d944387db..044ff06a01 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -7,6 +7,16 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64
 # dw-i3c,c
 dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
+dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PRId32 " bytes to bus"
+dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv %" PRId32 " bytes from bus"
+dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx32 " from RX FIFO"
+dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to response queue"
+dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to TX FIFO"
+dw_i3c_pop_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx32 " from TX FIFO"
+dw_i3c_push_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to RX FIFO"
+dw_i3c_transfer_ccc(uint32_t deviceid, uint8_t ccc) "I3C Dev[%u] transfer CCC 0x%" PRIx8
+dw_i3c_cmd_queue_execute(uint32_t deviceid, uint32_t cmd, uint32_t arg) "I3C Dev[%u] execute command 0x%" PRIx32 " arg 0x%" PRIx32
+dw_i3c_cmd_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to cmd queue"
 
 # core.c
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " event 0x%" PRIx8
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
index 793ee111cb..9833292ec0 100644
--- a/include/hw/i3c/aspeed_i3c.h
+++ b/include/hw/i3c/aspeed_i3c.h
@@ -2,6 +2,7 @@
  * ASPEED I3C Controller
  *
  * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2023 Google, LLC
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
index 214f5ffed2..3de2e46b09 100644
--- a/include/hw/i3c/dw-i3c.h
+++ b/include/hw/i3c/dw-i3c.h
@@ -10,12 +10,136 @@
 #ifndef DW_I3C_H
 #define DW_I3C_H
 
+#include "qemu/fifo32.h"
+#include "hw/i3c/i3c.h"
 #include "hw/sysbus.h"
 
 #define TYPE_DW_I3C "dw.i3c"
 OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)
 
-#define DW_I3C_NR_REGS (0x300 >> 2)
+/*
+ * Sufficiently large enough to handle configurations with large device address
+ * tables.
+ */
+#define DW_I3C_NR_REGS (0x1000 >> 2)
+
+/* From datasheet. */
+#define DW_I3C_CMD_ATTR_TRANSFER_CMD 0
+#define DW_I3C_CMD_ATTR_TRANSFER_ARG 1
+#define DW_I3C_CMD_ATTR_SHORT_DATA_ARG 2
+#define DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD 3
+
+/* Enum values from datasheet. */
+typedef enum DWI3CRespQueueErr {
+    DW_I3C_RESP_QUEUE_ERR_NONE = 0,
+    DW_I3C_RESP_QUEUE_ERR_CRC = 1,
+    DW_I3C_RESP_QUEUE_ERR_PARITY = 2,
+    DW_I3C_RESP_QUEUE_ERR_FRAME = 3,
+    DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK = 4,
+    DW_I3C_RESP_QUEUE_ERR_DAA_NACK = 5,
+    DW_I3C_RESP_QUEUE_ERR_OVERFLOW = 6,
+    DW_I3C_RESP_QUEUE_ERR_ABORTED = 8,
+    DW_I3C_RESP_QUEUE_ERR_I2C_NACK = 9,
+} DWI3CRespQueueErr;
+
+typedef enum DWI3CTransferState {
+    DW_I3C_TRANSFER_STATE_IDLE = 0x00,
+    DW_I3C_TRANSFER_STATE_START = 0x01,
+    DW_I3C_TRANSFER_STATE_RESTART = 0x02,
+    DW_I3C_TRANSFER_STATE_STOP = 0x03,
+    DW_I3C_TRANSFER_STATE_START_HOLD = 0x04,
+    DW_I3C_TRANSFER_STATE_BROADCAST_W = 0x05,
+    DW_I3C_TRANSFER_STATE_BROADCAST_R = 0x06,
+    DW_I3C_TRANSFER_STATE_DAA = 0x07,
+    DW_I3C_TRANSFER_STATE_DAA_GEN = 0x08,
+    DW_I3C_TRANSFER_STATE_CCC_BYTE = 0x0b,
+    DW_I3C_TRANSFER_STATE_HDR_CMD = 0x0c,
+    DW_I3C_TRANSFER_STATE_WRITE = 0x0d,
+    DW_I3C_TRANSFER_STATE_READ = 0x0e,
+    DW_I3C_TRANSFER_STATE_IBI_READ = 0x0f,
+    DW_I3C_TRANSFER_STATE_IBI_DIS = 0x10,
+    DW_I3C_TRANSFER_STATE_HDR_DDR_CRC = 0x11,
+    DW_I3C_TRANSFER_STATE_CLK_STRETCH = 0x12,
+    DW_I3C_TRANSFER_STATE_HALT = 0x13,
+} DWI3CTransferState;
+
+typedef enum DWI3CTransferStatus {
+    DW_I3C_TRANSFER_STATUS_IDLE = 0x00,
+    DW_I3C_TRANSFER_STATUS_BROACAST_CCC = 0x01,
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_W = 0x02,
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_R = 0x03,
+    DW_I3C_TRANSFER_STATUS_ENTDAA = 0x04,
+    DW_I3C_TRANSFER_STATUS_SETDASA = 0x05,
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_W = 0x06,
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_R = 0x07,
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_W = 0x08,
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_R = 0x09,
+    DW_I3C_TRANSFER_STATUS_HDR_TS_W = 0x0a,
+    DW_I3C_TRANSFER_STATUS_HDR_TS_R = 0x0b,
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_W = 0x0c,
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_R = 0x0d,
+    DW_I3C_TRANSFER_STATUS_IBI = 0x0e,
+    DW_I3C_TRANSFER_STATUS_HALT = 0x0f,
+} DWI3CTransferStatus;
+
+/*
+ * Transfer commands and arguments are 32-bit wide values that the user passes
+ * into the command queue. We interpret each 32-bit word based on the cmd_attr
+ * field.
+ */
+typedef struct DWI3CTransferCmd {
+    uint8_t cmd_attr:3;
+    uint8_t tid:4; /* Transaction ID */
+    uint16_t cmd:8;
+    uint8_t cp:1; /* Command present */
+    uint8_t dev_index:5;
+    uint8_t speed:3;
+    uint8_t resv0:1;
+    uint8_t dbp:1; /* Defining byte present */
+    uint8_t roc:1; /* Response on completion */
+    uint8_t sdap:1; /* Short data argument present */
+    uint8_t rnw:1; /* Read not write */
+    uint8_t resv1:1;
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */
+    uint8_t pec:1; /* Parity error check enabled */
+} DWI3CTransferCmd;
+
+typedef struct DWI3CTransferArg {
+    uint8_t cmd_attr:3;
+    uint8_t resv:5;
+    uint8_t db; /* Defining byte */
+    uint16_t data_len;
+} DWI3CTransferArg;
+
+typedef struct DWI3CShortArg {
+    uint8_t cmd_attr:3;
+    uint8_t byte_strb:3;
+    uint8_t resv:2;
+    uint8_t byte0;
+    uint8_t byte1;
+    uint8_t byte2;
+} DWI3CShortArg;
+
+typedef struct DWI3CAddrAssignCmd {
+    uint8_t cmd_attr:3;
+    uint8_t tid:4; /* Transaction ID */
+    uint16_t cmd:8;
+    uint8_t resv0:1;
+    uint8_t dev_index:5;
+    uint16_t dev_count:5;
+    uint8_t roc:1; /* Response on completion */
+    uint8_t resv1:3;
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */
+    uint8_t resv2:1;
+} DWI3CAddrAssignCmd;
+
+typedef union DWI3CCmdQueueData {
+    uint32_t word;
+    DWI3CTransferCmd transfer_cmd;
+    DWI3CTransferArg transfer_arg;
+    DWI3CShortArg short_arg;
+    DWI3CAddrAssignCmd addr_assign_cmd;
+} DWI3CCmdQueueData;
 
 typedef struct DWI3C {
     /* <private> */
@@ -24,8 +148,23 @@ typedef struct DWI3C {
     /* <public> */
     MemoryRegion mr;
     qemu_irq irq;
+    I3CBus *bus;
+
+    Fifo32 cmd_queue;
+    Fifo32 resp_queue;
+    Fifo32 tx_queue;
+    Fifo32 rx_queue;
 
-    uint8_t id;
+    struct {
+        uint8_t id;
+        uint8_t cmd_resp_queue_capacity_bytes;
+        uint16_t tx_rx_queue_capacity_bytes;
+        uint8_t num_addressable_devices;
+        uint16_t dev_addr_table_pointer;
+        uint16_t dev_addr_table_depth;
+        uint16_t dev_char_table_pointer;
+        uint16_t dev_char_table_depth;
+    } cfg;
     uint32_t regs[DW_I3C_NR_REGS];
 } DWI3C;
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


