Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC6CC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrwh-0007w1-Sx; Thu, 12 Jun 2025 20:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DmtLaAcKClsDHFEH6B9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--komlodi.bounces.google.com>)
 id 1uPruV-0005t2-Sk
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:47 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DmtLaAcKClsDHFEH6B9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--komlodi.bounces.google.com>)
 id 1uPruL-0000b4-Vy
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:37 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-74858256d38so1091829b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773071; x=1750377871; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8C3VgK1ZX7GYEarJgog+aC0MW3DwCChIc2JJrdXQp18=;
 b=Nj5bczcgpjSicspgrEG9V5nYxiWUVAzl8VGTHPT7QxTabt2n8tt1Bxp3+oJzTYQqNW
 Sta2h0ywI4kOMWYPbjHozqtXf5Gp1gLfPmN6QBfw7LDK4me7gWXM6GxK259KA8PTyrlL
 25OnQg8KsoYWacXYB1V8nQN4s74V/J5Yq9vircagXsF7NjJtfRHDupVJtU6YuAX375Ct
 tkh+iS7o6AShtJuv0eBSKm1fbgQgu3oqXl9tftZzATDjEvAM9oRqGpkx9VBOd5m6zy21
 wg9oKOS6YDO7bhZL/PsJ6SwoKISbVwJcO3rZGXy1u64a0Lr2U9+ucOoF06b+PWO/awJe
 tx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773071; x=1750377871;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8C3VgK1ZX7GYEarJgog+aC0MW3DwCChIc2JJrdXQp18=;
 b=hnwbOcjQnlAPYBBhUHP+0lak6glSO4q0bSWsJodz3Pt2zD7/VdXt+RCyXa4RLUeUYA
 CMonh2BqXE33gAKJ3WxrUUYz6eCAQ1l2xfsWU87eKPTUhd7hmy1dQq4L/mXHf/3H8JnJ
 lEbGQZZyfFF0NLR+RQ0RTJnEGT57J33Ml1At+N0oekBnaohrKC46l9qM6C05Se/AursD
 TQ4l+Ayr0ADPkBnLQoFW9y6z2waLjEVukAyiTYGPOjpx3CCZvRF+uCy5hoHczPRFTrlT
 AGR6R6bMRLRkan0cg4oPGhIJ/RPM9u9PaGdBZfB8jawMpFeK0dM44Le8Y68c4Mhkr/Zu
 M5hg==
X-Gm-Message-State: AOJu0YzXQ7SaBZ0k+eWD/2gWocuIh3tnCKUBfSG2m1u6YU+Pp+wRne41
 duzTTOM3wIaUHXc+JWGbaeMaW9bIG4buNsQBxN/OY/+mAT/b479nvxzIYj+JIhUfuaZ1llRpaHk
 pDtmhoVXcZfnp+bCf4jx9y+Wu+iDmxJfJ8EfPMd/bSbJODaBIR6hxjsib41aLR7YVRe8ZjqjRM8
 9U1ScrGNBQfkzJNyuCyRVxc/jRTvFlgwBCJYCJCW4J
X-Google-Smtp-Source: AGHT+IGyIoqd3mQVLLIRstlT1lE8jxebq2Nhc8fWbty+Z0d0pJUuIQ45bVWGyIsyP+Wei9bD1AFmR3g5G9KH
X-Received: from pgbcw6.prod.google.com ([2002:a05:6a02:4286:b0:af9:8f44:d7ec])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4312:b0:1ee:a914:1d67
 with SMTP id adf61e73a8af0-21fac851b5cmr1298105637.2.1749773070888; Thu, 12
 Jun 2025 17:04:30 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:04:05 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-14-komlodi@google.com>
Subject: [PATCH 13/19] hw/i3c/dw-i3c: Add IBI handling
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3DmtLaAcKClsDHFEH6B9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--komlodi.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

Adds handling for different IBI events that the controller can receive.
This includes:
- Handling a hot-join from a target
- Handling a secondary controller on the bus requesting to be the
  primary bus controller
- Handling an interrupt request from a target.

When receiving an IBI, the controller sets an interrupt to notify
software about what happened.
When the IBI is finished being serviced, the controller pushes the
result of the IBI and any data received from the target into the IBI
queue.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
---
 hw/i3c/dw-i3c.c         | 317 ++++++++++++++++++++++++++++++++++++++++
 hw/i3c/trace-events     |   2 +
 include/hw/i3c/dw-i3c.h |  27 ++++
 3 files changed, 346 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 2c3e1a5760..c5af331ac4 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -19,6 +19,14 @@
 #include "trace.h"
 #include "hw/irq.h"
 
+/*
+ * Disable event command values. sent along with a DISEC CCC to disable certain
+ * events on targets.
+ */
+#define DISEC_HJ 0x08
+#define DISEC_CR 0x02
+#define DISEC_INT 0x01
+
 REG32(DEVICE_CTRL,                  0x00)
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)
     FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)
@@ -373,6 +381,23 @@ static inline bool dw_i3c_can_transmit(DWI3C *s)
            !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);
 }
 
+static inline uint8_t dw_i3c_ibi_slice_size(DWI3C *s)
+{
+    uint8_t ibi_slice_size = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                              IBI_DATA_THLD);
+    /* The minimum supported slice size is 4 bytes. */
+    if (ibi_slice_size == 0) {
+        ibi_slice_size = 1;
+    }
+    ibi_slice_size *= sizeof(uint32_t);
+    /* maximum supported size is 63 bytes. */
+    if (ibi_slice_size >= 64) {
+        ibi_slice_size = 63;
+    }
+
+    return ibi_slice_size;
+}
+
 static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)
 {
     return regval = regval ? (2 << regval) : 1;
@@ -526,6 +551,266 @@ static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t offset)
                       DEV_DYNAMIC_ADDR);
 }
 
+static int dw_i3c_addr_table_index_from_addr(DWI3C *s, uint8_t addr)
+{
+    uint8_t table_size = ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER,
+                                          DEPTH);
+    for (uint8_t i = 0; i < table_size; i++) {
+        if (dw_i3c_target_addr(s, i) == addr) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static void dw_i3c_send_disec(DWI3C *s)
+{
+    uint8_t ccc = I3C_CCC_DISEC;
+    if (s->ibi_data.send_direct_disec) {
+        ccc = I3C_CCCD_DISEC;
+    }
+
+    dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=*/false,
+                                 /*is_i2c=*/false);
+    dw_i3c_send_byte(s, ccc, /*is_i2c=*/false);
+    if (s->ibi_data.send_direct_disec) {
+        dw_i3c_send_start(s, s->ibi_data.disec_addr,
+                                     /*is_recv=*/false, /*is_i2c=*/false);
+    }
+    dw_i3c_send_byte(s, s->ibi_data.disec_byte, /*is_i2c=*/false);
+}
+
+static int dw_i3c_handle_hj(DWI3C *s)
+{
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN)) {
+        s->ibi_data.notify_ibi_nack = true;
+    }
+
+    bool nack_and_disable = ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,
+                                             HOT_JOIN_ACK_NACK_CTRL);
+    if (nack_and_disable) {
+        s->ibi_data.ibi_queue_status = FIELD_DP32(s->ibi_data.ibi_queue_status,
+                                                  IBI_QUEUE_STATUS,
+                                                  IBI_STATUS, 1);
+        s->ibi_data.ibi_nacked = true;
+        s->ibi_data.disec_byte = DISEC_HJ;
+        return -1;
+    }
+    return 0;
+}
+
+static int dw_i3c_handle_ctlr_req(DWI3C *s, uint8_t addr)
+{
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_REQ)) {
+        s->ibi_data.notify_ibi_nack = true;
+    }
+
+    int table_offset = dw_i3c_addr_table_index_from_addr(s, addr);
+    /* Doesn't exist in the table, NACK it, don't DISEC. */
+    if (table_offset < 0) {
+        return -1;
+    }
+
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
+    table_offset += (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER,
+                                      ADDR) / sizeof(uint32_t));
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, MR_REJECT)) {
+        s->ibi_data.ibi_queue_status = FIELD_DP32(s->ibi_data.ibi_queue_status,
+                                                  IBI_QUEUE_STATUS,
+                                                  IBI_STATUS, 1);
+        s->ibi_data.ibi_nacked = true;
+        s->ibi_data.disec_addr = addr;
+        /* Tell the requester to disable controller role requests. */
+        s->ibi_data.disec_byte = DISEC_CR;
+        s->ibi_data.send_direct_disec = true;
+        return -1;
+    }
+    return 0;
+}
+
+static int dw_i3c_handle_targ_irq(DWI3C *s, uint8_t addr)
+{
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IRQ)) {
+        s->ibi_data.notify_ibi_nack = true;
+    }
+
+    int table_offset = dw_i3c_addr_table_index_from_addr(s, addr);
+    /* Doesn't exist in the table, NACK it, don't DISEC. */
+    if (table_offset < 0) {
+        return -1;
+    }
+
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
+    table_offset += (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER,
+                                      ADDR) / sizeof(uint32_t));
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, SIR_REJECT)) {
+        s->ibi_data.ibi_queue_status = FIELD_DP32(s->ibi_data.ibi_queue_status,
+                                                  IBI_QUEUE_STATUS,
+                                                  IBI_STATUS, 1);
+        s->ibi_data.ibi_nacked = true;
+        s->ibi_data.disec_addr = addr;
+        /* Tell the requester to disable interrupts. */
+        s->ibi_data.disec_byte = DISEC_INT;
+        s->ibi_data.send_direct_disec = true;
+        return -1;
+    }
+    return 0;
+}
+
+static int dw_i3c_ibi_handle(I3CBus *bus, uint8_t addr, bool is_recv)
+{
+    DWI3C *s = DW_I3C(bus->qbus.parent);
+
+    trace_dw_i3c_ibi_handle(s->cfg.id, addr, is_recv);
+    s->ibi_data.ibi_queue_status = FIELD_DP32(s->ibi_data.ibi_queue_status,
+                                              IBI_QUEUE_STATUS, IBI_ID,
+                                              (addr << 1) | is_recv);
+    /* Is this a hot join request? */
+    if (addr == I3C_HJ_ADDR) {
+        return dw_i3c_handle_hj(s);
+    }
+    /* Is secondary controller requesting access? */
+    if (!is_recv) {
+        return dw_i3c_handle_ctlr_req(s, addr);
+    }
+    /* Is this a target IRQ? */
+    if (is_recv) {
+        return dw_i3c_handle_targ_irq(s, addr);
+    }
+
+    /* At this point the IBI should have been ACKed or NACKed. */
+    g_assert_not_reached();
+    return -1;
+}
+
+static int dw_i3c_ibi_recv(I3CBus *bus, uint8_t data)
+{
+    DWI3C *s = DW_I3C(bus->qbus.parent);
+    if (fifo8_is_full(&s->ibi_data.ibi_intermediate_queue)) {
+        return -1;
+    }
+
+    fifo8_push(&s->ibi_data.ibi_intermediate_queue, data);
+    trace_dw_i3c_ibi_recv(s->cfg.id, data);
+    return 0;
+}
+
+static void dw_i3c_ibi_queue_push(DWI3C *s)
+{
+    /* Stored value is in 32-bit chunks, convert it to byte chunks. */
+    uint8_t ibi_slice_size = dw_i3c_ibi_slice_size(s);
+    uint8_t num_slices = (fifo8_num_used(&s->ibi_data.ibi_intermediate_queue) /
+                         ibi_slice_size) +
+                         ((fifo8_num_used(&s->ibi_data.ibi_intermediate_queue) %
+                         ibi_slice_size) ? 1 : 0);
+    uint8_t ibi_status_count = num_slices;
+    union {
+        uint8_t b[sizeof(uint32_t)];
+        uint32_t val32;
+    } ibi_data = {
+        .val32 = 0
+    };
+
+    /* The report was suppressed, do nothing. */
+    if (s->ibi_data.ibi_nacked && !s->ibi_data.notify_ibi_nack) {
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_IDLE);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                         DW_I3C_TRANSFER_STATUS_IDLE);
+        return;
+    }
+
+    /* If we don't have any slices to push, just push the status. */
+    if (num_slices == 0) {
+        s->ibi_data.ibi_queue_status =
+             FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,
+                        LAST_STATUS, 1);
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);
+        ibi_status_count = 1;
+    }
+
+    for (uint8_t i = 0; i < num_slices; i++) {
+        /* If this is the last slice, set LAST_STATUS. */
+        if (fifo8_num_used(&s->ibi_data.ibi_intermediate_queue) <
+            ibi_slice_size) {
+            s->ibi_data.ibi_queue_status =
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,
+                           IBI_DATA_LEN,
+                           fifo8_num_used(&s->ibi_data.ibi_intermediate_queue));
+            s->ibi_data.ibi_queue_status =
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,
+                           LAST_STATUS, 1);
+        } else {
+            s->ibi_data.ibi_queue_status =
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,
+                           IBI_DATA_LEN, ibi_slice_size);
+        }
+
+        /* Push the IBI status header. */
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);
+        /* Move each IBI byte into a 32-bit word and push it into the queue. */
+        for (uint8_t j = 0; j < ibi_slice_size; ++j) {
+            if (fifo8_is_empty(&s->ibi_data.ibi_intermediate_queue)) {
+                break;
+            }
+
+            ibi_data.b[j & 3] = fifo8_pop(&s->ibi_data.ibi_intermediate_queue);
+            /* We have 32-bits, push it to the IBI FIFO. */
+            if ((j & 0x03) == 0x03) {
+                fifo32_push(&s->ibi_queue, ibi_data.val32);
+                ibi_data.val32 = 0;
+            }
+        }
+        /* If the data isn't 32-bit aligned, push the leftover bytes. */
+        if (ibi_slice_size & 0x03) {
+            fifo32_push(&s->ibi_queue, ibi_data.val32);
+        }
+
+        /* Clear out the data length for the next iteration. */
+        s->ibi_data.ibi_queue_status = FIELD_DP32(s->ibi_data.ibi_queue_status,
+                                         IBI_QUEUE_STATUS, IBI_DATA_LEN, 0);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,
+                     fifo32_num_used(&s->ibi_queue));
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,
+                     ibi_status_count);
+    /* Threshold is the register value + 1. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                         IBI_STATUS_THLD) + 1;
+    if (fifo32_num_used(&s->ibi_queue) >= threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 1);
+        dw_i3c_update_irq(s);
+    }
+
+    /* State update. */
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                     DW_I3C_TRANSFER_STATE_IDLE);
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                     DW_I3C_TRANSFER_STATUS_IDLE);
+}
+
+static int dw_i3c_ibi_finish(I3CBus *bus)
+{
+    DWI3C *s = DW_I3C(bus->qbus.parent);
+    bool nack_and_disable_hj = ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,
+                                                HOT_JOIN_ACK_NACK_CTRL);
+    if (nack_and_disable_hj || s->ibi_data.send_direct_disec) {
+        dw_i3c_send_disec(s);
+    }
+    dw_i3c_ibi_queue_push(s);
+
+    /* Clear out the intermediate values. */
+    s->ibi_data.ibi_queue_status = 0;
+    s->ibi_data.disec_addr = 0;
+    s->ibi_data.disec_byte = 0;
+    s->ibi_data.send_direct_disec = false;
+    s->ibi_data.notify_ibi_nack = false;
+    s->ibi_data.ibi_nacked = false;
+
+    return 0;
+}
+
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)
 {
     /* Only return the status whose corresponding EN bits are set. */
@@ -586,6 +871,25 @@ static uint32_t dw_i3c_pop_rx(DWI3C *s)
     return val;
 }
 
+static uint32_t dw_i3c_ibi_queue_r(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->ibi_queue)) {
+        return 0;
+    }
+
+    uint32_t val = fifo32_pop(&s->ibi_queue);
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,
+                     fifo32_num_used(&s->ibi_queue));
+    /* Threshold is the register value + 1. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                         IBI_STATUS_THLD) + 1;
+    if (fifo32_num_used(&s->ibi_queue) < threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);
+        dw_i3c_update_irq(s);
+    }
+    return val;
+}
+
 static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)
 {
     if (fifo32_is_empty(&s->resp_queue)) {
@@ -623,6 +927,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
     case R_INTR_FORCE:
         value = 0;
         break;
+    case R_IBI_QUEUE_DATA:
+        value = dw_i3c_ibi_queue_r(s);
+        break;
     case R_INTR_STATUS:
         value = dw_i3c_intr_status_r(s);
         break;
@@ -1362,8 +1669,16 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
     fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);
     fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);
     fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);
+    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);
+    /* Arbitrarily large enough to not be an issue. */
+    fifo8_create(&s->ibi_data.ibi_intermediate_queue,
+                 s->cfg.ibi_queue_capacity_bytes * 8);
 
     s->bus = i3c_init_bus(DEVICE(s), name);
+    I3CBusClass *bc = I3C_BUS_GET_CLASS(s->bus);
+    bc->ibi_handle = dw_i3c_ibi_handle;
+    bc->ibi_recv = dw_i3c_ibi_recv;
+    bc->ibi_finish = dw_i3c_ibi_finish;
 }
 
 static const Property dw_i3c_properties[] = {
@@ -1372,6 +1687,8 @@ static const Property dw_i3c_properties[] = {
                       cfg.cmd_resp_queue_capacity_bytes, 0x10),
     DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,
                       cfg.tx_rx_queue_capacity_bytes, 0x40),
+    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,
+                      cfg.ibi_queue_capacity_bytes, 0x10),
     DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,
                       cfg.num_addressable_devices, 8),
     DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index 044ff06a01..a262fcce39 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -9,6 +9,8 @@ dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
 dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PRId32 " bytes to bus"
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv %" PRId32 " bytes from bus"
+dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI byte 0x%" PRIx8
+dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] handle IBI from address 0x%" PRIx8 " RnW=%d"
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx32 " from RX FIFO"
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to response queue"
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to TX FIFO"
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
index 3de2e46b09..a2cb375aa2 100644
--- a/include/hw/i3c/dw-i3c.h
+++ b/include/hw/i3c/dw-i3c.h
@@ -141,6 +141,28 @@ typedef union DWI3CCmdQueueData {
     DWI3CAddrAssignCmd addr_assign_cmd;
 } DWI3CCmdQueueData;
 
+/*
+ * When we receive an IBI with data, we need to store it temporarily until
+ * the target is finished sending data. Then we can set the IBI queue status
+ * appropriately.
+ */
+typedef struct DWI3CIBIData {
+    /* Do we notify the user that an IBI was NACKed? */
+    bool notify_ibi_nack;
+    /* Intermediate storage of IBI_QUEUE_STATUS. */
+    uint32_t ibi_queue_status;
+    /* Temporary buffer to store IBI data from the target. */
+    Fifo8 ibi_intermediate_queue;
+    /* The address we should send a CCC_DISEC to. */
+    uint8_t disec_addr;
+    /* The byte we should send along with the CCC_DISEC. */
+    uint8_t disec_byte;
+    /* Should we send a direct DISEC CCC? (As opposed to global). */
+    bool send_direct_disec;
+    /* Was this IBI NACKed? */
+    bool ibi_nacked;
+} DWI3CIBIData;
+
 typedef struct DWI3C {
     /* <private> */
     SysBusDevice parent;
@@ -154,11 +176,16 @@ typedef struct DWI3C {
     Fifo32 resp_queue;
     Fifo32 tx_queue;
     Fifo32 rx_queue;
+    Fifo32 ibi_queue;
+
+    /* Temporary storage for IBI data. */
+    DWI3CIBIData ibi_data;
 
     struct {
         uint8_t id;
         uint8_t cmd_resp_queue_capacity_bytes;
         uint16_t tx_rx_queue_capacity_bytes;
+        uint8_t ibi_queue_capacity_bytes;
         uint8_t num_addressable_devices;
         uint16_t dev_addr_table_pointer;
         uint16_t dev_addr_table_depth;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


