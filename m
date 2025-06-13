Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53A1C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPruD-0005pB-Dr; Thu, 12 Jun 2025 20:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3AmtLaAcKCk815325uzx55x2v.t537v3B-uvCv2454x4B.58x@flex--komlodi.bounces.google.com>)
 id 1uPruA-0005n1-D3
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:22 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3AmtLaAcKCk815325uzx55x2v.t537v3B-uvCv2454x4B.58x@flex--komlodi.bounces.google.com>)
 id 1uPru7-0000XN-Qa
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:22 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2358de17665so13421045ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773058; x=1750377858; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yV4kGwbpp1m9FhU4yzA1jnn6GM9g9YaJoL8u1HuZLk4=;
 b=2RbQc45IgQTor61EZMPrnidJHE4LfByPrS5Xns6GGNU1ioRcWoq8d65tmPvGVASAIH
 BER6G3D/BQ+bgtdrUUiK1HqpRQt6McJ20nvKARJagA4iibIyBUps3+5J2sYlbNm01Ru8
 tb38mOLls7Nz/r3yzm4A5quJVg//wxv3Yf3UxWGl1+CgEQOUxzWZU+ktWs99LI2d030v
 lS5M2bFp+UmcC3fXCH9Zj0tIc8KdYybOVC9OEdvydvHCqEREg8WGynSdvA6doO0AAyDH
 Lc79vLkOBiUthQ6AD0etS0+XlpY/DA7ASBKMGubqxZbCFVpWP+k2xHT3NwvuKvv0qx8g
 cPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773058; x=1750377858;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yV4kGwbpp1m9FhU4yzA1jnn6GM9g9YaJoL8u1HuZLk4=;
 b=LcPvrnM0jesOpQtQkV2NgBL911oNdox756kGc0yuS27Mh3TvxZ0EUehPsheefMyRvj
 0AwosAlhamoGqViwA8SgycMPKBxzF/lfc/3+kyLIpfdlWCEHI+5nIVYf8dc768nmQ3Ct
 z34BQGjTPPVWnLKe0oYeojUXA9vYh7ncH2mAYDzWYW56qXrZYcsCn0zcvK0Baxlswiic
 tme1ODeXItSjGwpXEgPzGrNwbn3ywzbs4jar1xREDnwMdgflP7r5JifhMnrCV52an8AP
 KIe14AP6krVppQotXMhxvs19XvLzs95IlsmJXCgt0H0NnzJq7KsjCzY3Iv4kA3fJ0ixs
 yiqA==
X-Gm-Message-State: AOJu0YyyVDvQTugwMqYkIB4GfLbM5dwJqNIkVmszW/2kpvA4qVSzeY4Q
 f/3/F77jnS9z/aM67lS+iGYOuwCFVtnybOu2edquzOj2aS7BQLcGwGtTmY3T3ijMM0keMDp31YY
 7xRd3eQC7jpblySiKoxQmGIPlE2VGmm/Wiy+5dXrSGL2/XngMYxFnMlWpjmTrhGV0bXX8AX45cE
 ZXwHIN7WmRc7niQKAkuNI5YqkLxEwZmB+liXjgMQWo
X-Google-Smtp-Source: AGHT+IEItkmlqA0nh1bG1USlq32Zt0fVXVjxOFcC3qqim18euF/XBFRjLkEEWdkTrdMxTUkzZ/cMfsMRYUg0
X-Received: from pgg12.prod.google.com ([2002:a05:6a02:4d8c:b0:b1f:dd75:de2a])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3205:b0:234:b131:15a
 with SMTP id d9443c01a7336-2365d8880f8mr14744295ad.4.1749773058144; Thu, 12
 Jun 2025 17:04:18 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:03:56 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-5-komlodi@google.com>
Subject: [PATCH 04/19] hw/i3c/dw-i3c: Add more register fields
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3AmtLaAcKCk815325uzx55x2v.t537v3B-uvCv2454x4B.58x@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

Adds the rest of the Designware register fields.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/dw-i3c.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 4b1a3f3f07..b252903ea4 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -19,54 +19,270 @@
 #include "trace.h"
 
 REG32(DEVICE_CTRL,                  0x00)
+    FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)
+    FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)
+    FIELD(DEVICE_CTRL, HOT_JOIN_ACK_NACK_CTRL,    8, 1)
+    FIELD(DEVICE_CTRL, IDLE_CNT_MULTIPLIER,       24, 2)
+    FIELD(DEVICE_CTRL, SLV_ADAPT_TO_I2C_I3C_MODE, 27, 1)
+    FIELD(DEVICE_CTRL, DMA_HANDSHAKE_EN,          28, 1)
+    FIELD(DEVICE_CTRL, I3C_ABORT,                 29, 1)
+    FIELD(DEVICE_CTRL, I3C_RESUME,                30, 1)
+    FIELD(DEVICE_CTRL, I3C_EN,                    31, 1)
 REG32(DEVICE_ADDR,                  0x04)
+    FIELD(DEVICE_ADDR, STATIC_ADDR,         0, 7)
+    FIELD(DEVICE_ADDR, STATIC_ADDR_VALID,   15, 1)
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR,        16, 7)
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR_VALID,  15, 1)
 REG32(HW_CAPABILITY,                0x08)
+    FIELD(HW_CAPABILITY, DEVICE_ROLE_CONFIG,  0, 2)
+    FIELD(HW_CAPABILITY, HDR_DDR, 3, 1)
+    FIELD(HW_CAPABILITY, HDR_TS,  4, 1)
 REG32(COMMAND_QUEUE_PORT,           0x0c)
+    FIELD(COMMAND_QUEUE_PORT, CMD_ATTR, 0, 3)
+    /* Transfer command structure */
+    FIELD(COMMAND_QUEUE_PORT, TID, 3, 4)
+    FIELD(COMMAND_QUEUE_PORT, CMD, 7, 8)
+    FIELD(COMMAND_QUEUE_PORT, CP, 15, 1)
+    FIELD(COMMAND_QUEUE_PORT, DEV_INDEX, 16, 5)
+    FIELD(COMMAND_QUEUE_PORT, SPEED, 21, 3)
+    FIELD(COMMAND_QUEUE_PORT, ROC, 26, 1)
+    FIELD(COMMAND_QUEUE_PORT, SDAP, 27, 1)
+    FIELD(COMMAND_QUEUE_PORT, RNW, 28, 1)
+    FIELD(COMMAND_QUEUE_PORT, TOC, 30, 1)
+    FIELD(COMMAND_QUEUE_PORT, PEC, 31, 1)
+    /* Transfer argument data structure */
+    FIELD(COMMAND_QUEUE_PORT, DB, 8, 8)
+    FIELD(COMMAND_QUEUE_PORT, DL, 16, 16)
+    /* Short data argument data structure */
+    FIELD(COMMAND_QUEUE_PORT, BYTE_STRB, 3, 3)
+    FIELD(COMMAND_QUEUE_PORT, BYTE0, 8, 8)
+    FIELD(COMMAND_QUEUE_PORT, BYTE1, 16, 8)
+    FIELD(COMMAND_QUEUE_PORT, BYTE2, 24, 8)
+    /* Address assignment command structure */
+    /*
+     * bits 3..21 and 26..31 are the same as the transfer command structure, or
+     * marked as reserved.
+     */
+    FIELD(COMMAND_QUEUE_PORT, DEV_COUNT, 21, 3)
 REG32(RESPONSE_QUEUE_PORT,          0x10)
+    FIELD(RESPONSE_QUEUE_PORT, DL, 0, 16)
+    FIELD(RESPONSE_QUEUE_PORT, CCCT, 16, 8)
+    FIELD(RESPONSE_QUEUE_PORT, TID, 24, 4)
+    FIELD(RESPONSE_QUEUE_PORT, ERR_STATUS, 28, 4)
 REG32(RX_TX_DATA_PORT,              0x14)
 REG32(IBI_QUEUE_STATUS,             0x18)
+    FIELD(IBI_QUEUE_STATUS, IBI_DATA_LEN,   0, 8)
+    FIELD(IBI_QUEUE_STATUS, IBI_ID,         8, 8)
+    FIELD(IBI_QUEUE_STATUS, LAST_STATUS,    24, 1)
+    FIELD(IBI_QUEUE_STATUS, ERROR,          30, 1)
+    FIELD(IBI_QUEUE_STATUS, IBI_STATUS,     31, 1)
 REG32(IBI_QUEUE_DATA,               0x18)
 REG32(QUEUE_THLD_CTRL,              0x1c)
+    FIELD(QUEUE_THLD_CTRL, CMD_BUF_EMPTY_THLD,  0, 8);
+    FIELD(QUEUE_THLD_CTRL, RESP_BUF_THLD, 8, 8);
+    FIELD(QUEUE_THLD_CTRL, IBI_DATA_THLD, 16, 8);
+    FIELD(QUEUE_THLD_CTRL, IBI_STATUS_THLD,     24, 8);
 REG32(DATA_BUFFER_THLD_CTRL,        0x20)
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_BUF_THLD,   0, 3)
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_BUF_THLD,   10, 3)
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_START_THLD, 16, 3)
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_START_THLD, 24, 3)
 REG32(IBI_QUEUE_CTRL,               0x24)
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN,   0, 1)
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_REQ, 1, 1)
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IRQ,  3, 1)
 REG32(IBI_MR_REQ_REJECT,            0x2c)
 REG32(IBI_SIR_REQ_REJECT,           0x30)
 REG32(RESET_CTRL,                   0x34)
+    FIELD(RESET_CTRL, CORE_RESET,       0, 1)
+    FIELD(RESET_CTRL, CMD_QUEUE_RESET,  1, 1)
+    FIELD(RESET_CTRL, RESP_QUEUE_RESET, 2, 1)
+    FIELD(RESET_CTRL, TX_BUF_RESET,     3, 1)
+    FIELD(RESET_CTRL, RX_BUF_RESET,     4, 1)
+    FIELD(RESET_CTRL, IBI_QUEUE_RESET,  5, 1)
 REG32(SLV_EVENT_CTRL,               0x38)
+    FIELD(SLV_EVENT_CTRL, SLV_INTERRUPT,      0, 1)
+    FIELD(SLV_EVENT_CTRL, MASTER_INTERRUPT,   1, 1)
+    FIELD(SLV_EVENT_CTRL, HOT_JOIN_INTERRUPT, 3, 1)
+    FIELD(SLV_EVENT_CTRL, ACTIVITY_STATE,     4, 2)
+    FIELD(SLV_EVENT_CTRL, MRL_UPDATED,        6, 1)
+    FIELD(SLV_EVENT_CTRL, MWL_UPDATED,        7, 1)
 REG32(INTR_STATUS,                  0x3c)
+    FIELD(INTR_STATUS, TX_THLD,           0, 1)
+    FIELD(INTR_STATUS, RX_THLD,           1, 1)
+    FIELD(INTR_STATUS, IBI_THLD,          2, 1)
+    FIELD(INTR_STATUS, CMD_QUEUE_RDY,     3, 1)
+    FIELD(INTR_STATUS, RESP_RDY,          4, 1)
+    FIELD(INTR_STATUS, TRANSFER_ABORT,    5, 1)
+    FIELD(INTR_STATUS, CCC_UPDATED,       6, 1)
+    FIELD(INTR_STATUS, DYN_ADDR_ASSGN,    8, 1)
+    FIELD(INTR_STATUS, TRANSFER_ERR,      9, 1)
+    FIELD(INTR_STATUS, DEFSLV,            10, 1)
+    FIELD(INTR_STATUS, READ_REQ_RECV,     11, 1)
+    FIELD(INTR_STATUS, IBI_UPDATED,       12, 1)
+    FIELD(INTR_STATUS, BUSOWNER_UPDATED,  13, 1)
 REG32(INTR_STATUS_EN,               0x40)
+    FIELD(INTR_STATUS_EN, TX_THLD,          0, 1)
+    FIELD(INTR_STATUS_EN, RX_THLD,          1, 1)
+    FIELD(INTR_STATUS_EN, IBI_THLD,         2, 1)
+    FIELD(INTR_STATUS_EN, CMD_QUEUE_RDY,    3, 1)
+    FIELD(INTR_STATUS_EN, RESP_RDY,         4, 1)
+    FIELD(INTR_STATUS_EN, TRANSFER_ABORT,   5, 1)
+    FIELD(INTR_STATUS_EN, CCC_UPDATED,      6, 1)
+    FIELD(INTR_STATUS_EN, DYN_ADDR_ASSGN,   8, 1)
+    FIELD(INTR_STATUS_EN, TRANSFER_ERR,     9, 1)
+    FIELD(INTR_STATUS_EN, DEFSLV,           10, 1)
+    FIELD(INTR_STATUS_EN, READ_REQ_RECV,    11, 1)
+    FIELD(INTR_STATUS_EN, IBI_UPDATED,      12, 1)
+    FIELD(INTR_STATUS_EN, BUSOWNER_UPDATED, 13, 1)
 REG32(INTR_SIGNAL_EN,               0x44)
+    FIELD(INTR_SIGNAL_EN, TX_THLD,          0, 1)
+    FIELD(INTR_SIGNAL_EN, RX_THLD,          1, 1)
+    FIELD(INTR_SIGNAL_EN, IBI_THLD,         2, 1)
+    FIELD(INTR_SIGNAL_EN, CMD_QUEUE_RDY,    3, 1)
+    FIELD(INTR_SIGNAL_EN, RESP_RDY,         4, 1)
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ABORT,   5, 1)
+    FIELD(INTR_SIGNAL_EN, CCC_UPDATED,      6, 1)
+    FIELD(INTR_SIGNAL_EN, DYN_ADDR_ASSGN,   8, 1)
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ERR,     9, 1)
+    FIELD(INTR_SIGNAL_EN, DEFSLV,           10, 1)
+    FIELD(INTR_SIGNAL_EN, READ_REQ_RECV,    11, 1)
+    FIELD(INTR_SIGNAL_EN, IBI_UPDATED,      12, 1)
+    FIELD(INTR_SIGNAL_EN, BUSOWNER_UPDATED, 13, 1)
 REG32(INTR_FORCE,                   0x48)
+    FIELD(INTR_FORCE, TX_THLD,          0, 1)
+    FIELD(INTR_FORCE, RX_THLD,          1, 1)
+    FIELD(INTR_FORCE, IBI_THLD,         2, 1)
+    FIELD(INTR_FORCE, CMD_QUEUE_RDY,    3, 1)
+    FIELD(INTR_FORCE, RESP_RDY,         4, 1)
+    FIELD(INTR_FORCE, TRANSFER_ABORT,   5, 1)
+    FIELD(INTR_FORCE, CCC_UPDATED,      6, 1)
+    FIELD(INTR_FORCE, DYN_ADDR_ASSGN,   8, 1)
+    FIELD(INTR_FORCE, TRANSFER_ERR,     9, 1)
+    FIELD(INTR_FORCE, DEFSLV,           10, 1)
+    FIELD(INTR_FORCE, READ_REQ_RECV,    11, 1)
+    FIELD(INTR_FORCE, IBI_UPDATED,      12, 1)
+    FIELD(INTR_FORCE, BUSOWNER_UPDATED, 13, 1)
 REG32(QUEUE_STATUS_LEVEL,           0x4c)
+    FIELD(QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,  0, 8)
+    FIELD(QUEUE_STATUS_LEVEL, RESP_BUF_BLR,         8, 8)
+    FIELD(QUEUE_STATUS_LEVEL, IBI_BUF_BLR,          16, 8)
+    FIELD(QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,       24, 5)
 REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
+    FIELD(DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC, 0, 8)
+    FIELD(DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,       16, 8)
 REG32(PRESENT_STATE,                0x54)
+    FIELD(PRESENT_STATE, SCL_LINE_SIGNAL_LEVEL, 0, 1)
+    FIELD(PRESENT_STATE, SDA_LINE_SIGNAL_LEVEL, 1, 1)
+    FIELD(PRESENT_STATE, CURRENT_MASTER,        2, 1)
+    FIELD(PRESENT_STATE, CM_TFR_STATUS,         8, 6)
+    FIELD(PRESENT_STATE, CM_TFR_ST_STATUS,      16, 6)
+    FIELD(PRESENT_STATE, CMD_TID,               24, 4)
 REG32(CCC_DEVICE_STATUS,            0x58)
+    FIELD(CCC_DEVICE_STATUS, PENDING_INTR,      0, 4)
+    FIELD(CCC_DEVICE_STATUS, PROTOCOL_ERR,      4, 2)
+    FIELD(CCC_DEVICE_STATUS, ACTIVITY_MODE,     6, 2)
+    FIELD(CCC_DEVICE_STATUS, UNDER_ERR,         8, 1)
+    FIELD(CCC_DEVICE_STATUS, SLV_BUSY,          9, 1)
+    FIELD(CCC_DEVICE_STATUS, OVERFLOW_ERR,      10, 1)
+    FIELD(CCC_DEVICE_STATUS, DATA_NOT_READY,    11, 1)
+    FIELD(CCC_DEVICE_STATUS, BUFFER_NOT_AVAIL,  12, 1)
 REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
     FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
     FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
 REG32(DEV_CHAR_TABLE_POINTER,       0x60)
+    FIELD(DEV_CHAR_TABLE_POINTER, P_DEV_CHAR_TABLE_START_ADDR,  0, 12)
+    FIELD(DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,         12, 7)
+    FIELD(DEV_CHAR_TABLE_POINTER, PRESENT_DEV_CHAR_TABLE_INDEX, 19, 3)
 REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
+    FIELD(VENDOR_SPECIFIC_REG_POINTER, P_VENDOR_REG_START_ADDR, 0, 16)
 REG32(SLV_MIPI_PID_VALUE,           0x70)
 REG32(SLV_PID_VALUE,                0x74)
+    FIELD(SLV_PID_VALUE, SLV_PID_DCR, 0, 12)
+    FIELD(SLV_PID_VALUE, SLV_INST_ID, 12, 4)
+    FIELD(SLV_PID_VALUE, SLV_PART_ID, 16, 16)
 REG32(SLV_CHAR_CTRL,                0x78)
+    FIELD(SLV_CHAR_CTRL, BCR,     0, 8)
+    FIELD(SLV_CHAR_CTRL, DCR,     8, 8)
+    FIELD(SLV_CHAR_CTRL, HDR_CAP, 16, 8)
 REG32(SLV_MAX_LEN,                  0x7c)
+    FIELD(SLV_MAX_LEN, MWL, 0, 16)
+    FIELD(SLV_MAX_LEN, MRL, 16, 16)
 REG32(MAX_READ_TURNAROUND,          0x80)
 REG32(MAX_DATA_SPEED,               0x84)
 REG32(SLV_DEBUG_STATUS,             0x88)
 REG32(SLV_INTR_REQ,                 0x8c)
+    FIELD(SLV_INTR_REQ, SIR,          0, 1)
+    FIELD(SLV_INTR_REQ, SIR_CTRL,     1, 2)
+    FIELD(SLV_INTR_REQ, MIR,          3, 1)
+    FIELD(SLV_INTR_REQ, TS,           4, 1)
+    FIELD(SLV_INTR_REQ, IBI_STS,      8, 2)
+    FIELD(SLV_INTR_REQ, MDB,          8, 8)
+    FIELD(SLV_INTR_REQ, SIR_DATA_LEN, 16, 8)
+REG32(SLV_TSX_SYMBL_TIMING,         0x90)
+    FIELD(SLV_TSX_SYMBL_TIMING, SLV_TSX_SYMBL_CNT, 0, 6)
+REG32(SLV_SIR_DATA,                 0x94)
+    FIELD(SLV_SIR_DATA, SIR_DATA_BYTE0, 0, 8)
+    FIELD(SLV_SIR_DATA, SIR_DATA_BYTE1, 8, 8)
+    FIELD(SLV_SIR_DATA, SIR_DATA_BYTE2, 16, 8)
+    FIELD(SLV_SIR_DATA, SIR_DATA_BYTE3, 24, 8)
+REG32(SLV_IBI_RESP,                 0x98)
+    FIELD(SLV_IBI_RESP, IBI_STS,           0, 2)
+    FIELD(SLV_IBI_RESP, SIR_RESP_DATA_LEN, 8, 16)
 REG32(DEVICE_CTRL_EXTENDED,         0xb0)
+    FIELD(DEVICE_CTRL_EXTENDED, MODE, 0, 2)
+    FIELD(DEVICE_CTRL_EXTENDED, REQMST_ACK_CTRL, 3, 1)
 REG32(SCL_I3C_OD_TIMING,            0xb4)
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_LCNT, 0, 8)
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_HCNT, 16, 8)
 REG32(SCL_I3C_PP_TIMING,            0xb8)
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_LCNT, 0, 8)
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_HCNT, 16, 8)
 REG32(SCL_I2C_FM_TIMING,            0xbc)
 REG32(SCL_I2C_FMP_TIMING,           0xc0)
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_LCNT, 0, 16)
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_HCNT, 16, 8)
 REG32(SCL_EXT_LCNT_TIMING,          0xc8)
 REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
 REG32(BUS_FREE_TIMING,              0xd4)
 REG32(BUS_IDLE_TIMING,              0xd8)
+    FIELD(BUS_IDLE_TIMING, BUS_IDLE_TIME, 0, 20)
 REG32(I3C_VER_ID,                   0xe0)
 REG32(I3C_VER_TYPE,                 0xe4)
 REG32(EXTENDED_CAPABILITY,          0xe8)
+    FIELD(EXTENDED_CAPABILITY, APP_IF_MODE,       0, 2)
+    FIELD(EXTENDED_CAPABILITY, APP_IF_DATA_WIDTH, 2, 2)
+    FIELD(EXTENDED_CAPABILITY, OPERATION_MODE,    4, 2)
+    FIELD(EXTENDED_CAPABILITY, CLK_PERIOD,        8, 6)
 REG32(SLAVE_CONFIG,                 0xec)
+    FIELD(SLAVE_CONFIG, DMA_EN,     0, 1)
+    FIELD(SLAVE_CONFIG, HJ_CAP,     0, 1)
+    FIELD(SLAVE_CONFIG, CLK_PERIOD, 2, 14)
+/* Device characteristic table fields */
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC1, 0x200)
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, 0x200)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DYNAMIC_ADDR, 0, 8)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DCR, 8, 8)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, BCR, 16, 8)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, STATIC_ADDR, 24, 8)
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC2, 0x204)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC2, MSB_PID, 0, 16)
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC3, 0x208)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR, 0, 8)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR, 8, 8)
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC4, 0x20c)
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC4, DEV_DYNAMIC_ADDR, 0, 8)
+/* Dev addr table fields */
+REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_STATIC_ADDR, 0, 7)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_PEC_EN, 11, 1)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_WITH_DATA, 12, 1)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, SIR_REJECT, 13, 1)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, MR_REJECT, 14, 1)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_DYNAMIC_ADDR, 16, 8)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_ADDR_MASK, 24, 2)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_NACK_RETRY_CNT, 29, 2)
+    FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)
 
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
     [R_HW_CAPABILITY]               = 0x000e00bf,
-- 
2.50.0.rc1.591.g9c95f17f64-goog


