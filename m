Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE869C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNd0-0001cX-BW; Fri, 07 Aug 2026 12:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVK-0004J4-Pp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:29:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVH-0007N8-8M
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:29:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cab973140bso49706135ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786116538; x=1786721338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zdTbKI8WpzuthzzDx8V6I4YNlT6+oO5xIBGtVH+zmo=;
 b=cm8IKcgMHBendxaUVfatx+uCLR6j5JX4HdjH/NLDmnLYEMDawhC5Qz3RuLNBZg0FWd
 HpYZkGs4RlQq6eLRSKn8pY8abMpEd51DR8SLfkwjyisNWmqqr0lj8ed1YX/F4pyvCF2B
 wQM4+Yzg0kIKeBwPbokzMIu4kdvmkBi/8+PHkewWoL/Ctx8iLAbUzAf6jFsZMz8OKHkP
 4ceRfV15u1h3Btp4kghwnEibN4gtn/DZCDhvSOObqT2IC/Gk7XpACp9GF6pzZ3R5BUgK
 vaz0ebmpXw7Vk93cJYASdBsd9T8C5PPkVocbJiEhnc3LghfwDwGwhULk/bkaiBQHvHId
 AMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116538; x=1786721338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0zdTbKI8WpzuthzzDx8V6I4YNlT6+oO5xIBGtVH+zmo=;
 b=iUe0TJQnGbheaQydtZx+8j7+FnOV+oNOcgUjIhtbLQo7Ki5+JPiGiM7eg1avbfxjhg
 67ZPXUVLc0b4QGtRYBdcJCjYRyOKaKBVgRHWy7sSJsvKhNuOI7BscDHYbkYi4p0Hcl8X
 0M7zKwvjsxDoQn4Ov/+aJkJOizup8BlIktjCGYXXy3gUsMkYQFXUcuO5xJqBiyUmMQyC
 an20egIed4zYnSjihpP8zc/yj/ESnZg85RzIV9te1SVBh5v7nS7uuaYUZouA5OR5gplp
 IYSZijVShxiQQM2RYEdRfLy9jxVyJJvssMqYnHBVyp2eJ4q5Ct/AnJLf/oKzlM0xcBR+
 k1fQ==
X-Gm-Message-State: AOJu0YwBzCsPlALncbmme0zkevZ8TAaKhxGPxf7U9Rxt6agjGk4R/lmW
 RpmvGPiRZ8arcXiz0T3pzAR/LkicMHPsE7xnATwXTXcWKYDPc2CjH8TE
X-Gm-Gg: AR+sD12FnQ4Oe8x3IT8Sm3XlqPLGFe4Y4hLWifK57ijv9uk03mHEMe67pH9lCszAHNq
 LHr3+i/BlQcPxiji6zik6TnCkMVNX/2wdMTcx3KK2QHOfRfVq+WxTvhkOuAqgi4cm/UyImI5Iiw
 pQ1lfK50B0SQsziPUAEnslViiUs+WEV8H0jncJFIsbURylsWvhu1n0YSuyJN4HSJ8PWWIoJ4gnN
 /MlHxjFSpqxeWlVCbizBTvx0ES4N5ai3YOBAbRjnykd8xO7NriiD2tBQbXFm9JDJqazmohxCHD6
 RX1LBfTp89gJjKQqbDj4lf6bjeI28VieTYOQIF41nYD6ai7QRhEPRScZocPZeLGusb/afNkMI5w
 9cPa2jGNUR88MA328vdWsCpaokN/0M/7vS8kAYrhvxk8D6kIDjRfCtron3bw5NwX4KFSzkPsGW/
 EAB5JcODzUmXUOvSaeYsBexNlnZVZqVgtJQo7f6P1hZDJWe0FwckZ+tumE2pqcwpDut4uYWwG3U
 Gef9HZRsN0=
X-Received: by 2002:a17:902:ef0c:b0:2d0:cc92:f7c2 with SMTP id
 d9443c01a7336-2d2a8457180mr20408855ad.1.1786116537267; 
 Fri, 07 Aug 2026 08:28:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2406:da14:1cf8:d800:471c:a879:4603:554f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccae6f8sm10953895ad.1.2026.08.07.08.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:28:56 -0700 (PDT)
From: Wang Zhongyu <wzy15515798875@gmail.com>
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/5] hw/i2c: add K230 I2C controller model
Date: Fri,  7 Aug 2026 23:28:26 +0800
Message-ID: <20260807152830.6833-2-wzy15515798875@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807152830.6833-1-wzy15515798875@gmail.com>
References: <20260807152830.6833-1-wzy15515798875@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=wzy15515798875@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 07 Aug 2026 12:41:00 -0400
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

Add a model of the I2C controller used by the Kendryte K230 SoC.

The model supports master-mode 7-bit transfers, TX and RX FIFOs,
interrupt status and masking, repeated START and STOP handling,
General Call writes, reset, and migration state.

DMA, 10-bit addressing, bus clear, Device ID transactions, and raw
START BYTE transmission are not implemented.

Signed-off-by: Wang Zhongyu <wzy15515798875@gmail.com>
---
 MAINTAINERS               |    2 +
 hw/i2c/Kconfig            |    4 +
 hw/i2c/k230_i2c.c         | 1083 +++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build        |    1 +
 include/hw/i2c/k230_i2c.h |   72 +++
 5 files changed, 1162 insertions(+)
 create mode 100644 hw/i2c/k230_i2c.c
 create mode 100644 include/hw/i2c/k230_i2c.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..ac61054dd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,8 +1827,10 @@ M: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
+F: hw/i2c/k230_i2c.c
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: include/hw/i2c/k230_i2c.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: tests/functional/riscv64/test_k230.py
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 0766130b59..f2a2ea6169 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -54,3 +54,7 @@ config PMBUS
 config BCM2835_I2C
     bool
     select I2C
+
+config K230_I2C
+    bool
+    select I2C
diff --git a/hw/i2c/k230_i2c.c b/hw/i2c/k230_i2c.c
new file mode 100644
index 0000000000..cc328736a4
--- /dev/null
+++ b/hw/i2c/k230_i2c.c
@@ -0,0 +1,1083 @@
+/*
+ * K230 DesignWare I2C controller
+ *
+ * Copyright (c) 2026 Wang Zhongyu <wzy15515798875@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/k230_i2c.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/bitops.h"
+#include "hw/core/irq.h"
+#include "qemu/fifo8.h"
+#include "qemu/fifo32.h"
+
+#define K230_I2C_MMIO_SIZE               0x1000
+
+#define K230_IC_CON                      0x00
+#define K230_IC_TAR                      0x04
+#define K230_IC_SAR                      0x08
+#define K230_IC_HS_MADDR                 0x0c
+#define K230_IC_DATA_CMD                 0x10
+#define K230_IC_SS_SCL_HCNT              0x14
+#define K230_IC_SS_SCL_LCNT              0x18
+#define K230_IC_FS_SCL_HCNT              0x1c
+#define K230_IC_FS_SCL_LCNT              0x20
+#define K230_IC_HS_SCL_HCNT              0x24
+#define K230_IC_HS_SCL_LCNT              0x28
+#define K230_IC_INTR_STAT                0x2c
+#define K230_IC_INTR_MASK                0x30
+#define K230_IC_RAW_INTR_STAT            0x34
+#define K230_IC_RX_TL                    0x38
+#define K230_IC_TX_TL                    0x3c
+#define K230_IC_CLR_INTR                 0x40
+#define K230_IC_CLR_RX_UNDER             0x44
+#define K230_IC_CLR_RX_OVER              0x48
+#define K230_IC_CLR_TX_OVER              0x4c
+#define K230_IC_CLR_RD_REQ               0x50
+#define K230_IC_CLR_TX_ABRT              0x54
+#define K230_IC_CLR_RX_DONE              0x58
+#define K230_IC_CLR_ACTIVITY             0x5c
+#define K230_IC_CLR_STOP_DET             0x60
+#define K230_IC_CLR_START_DET            0x64
+#define K230_IC_CLR_GEN_CALL             0x68
+#define K230_IC_ENABLE                   0x6c
+#define K230_IC_STATUS                   0x70
+#define K230_IC_TXFLR                    0x74
+#define K230_IC_RXFLR                    0x78
+/* 0x7C reserved */
+#define K230_IC_TX_ABRT_SOURCE           0x80
+#define K230_IC_SLV_DATA_NACK_ONLY       0x84
+#define K230_IC_DMA_CR                   0x88
+#define K230_IC_DMA_TDLR                 0x8c
+#define K230_IC_DMA_RDLR                 0x90
+#define K230_IC_SDA_SETUP                0x94
+#define K230_IC_ACK_GENERAL_CALL         0x98
+#define K230_IC_ENABLE_STATUS            0x9c
+#define K230_IC_COMP_PARAM_1             0xf4
+#define K230_IC_COMP_VERSION             0xf8
+#define K230_IC_COMP_TYPE                0xfc
+/*
+ * Optional bus-clear support is outside the scope of the initial model.
+ * Unimplemented register offsets read as zero and ignore writes.
+ */
+
+/* IC_CON bit definitions */
+#define IC_CON_MASTER_MODE              BIT(0)
+#define IC_CON_SPEED                    (0x3U << 1)
+#define IC_CON_10BITADDR_SLAVE          BIT(3)
+#define IC_CON_10BITADDR_MASTER         BIT(4)
+#define IC_CON_RESTART_EN               BIT(5)
+#define IC_CON_SLAVE_DISABLE            BIT(6)
+#define IC_CON_VALID_MASK                        \
+                (IC_CON_MASTER_MODE      |       \
+                 IC_CON_SPEED            |       \
+                 IC_CON_10BITADDR_SLAVE  |       \
+                 IC_CON_10BITADDR_MASTER |       \
+                 IC_CON_RESTART_EN       |       \
+                 IC_CON_SLAVE_DISABLE)
+
+/* IC_TAR bit definitions */
+#define IC_TAR                          (0x3ffU)
+#define IC_TAR_GC_OR_START              BIT(10)
+#define IC_TAR_SPECIAL                  BIT(11)
+/*
+ * This implementation selects the master addressing mode through
+ * IC_CON[4]. IC_TAR[12] is not modeled as writable.
+ */
+#define IC_TAR_VALID_MASK                       \
+                (IC_TAR                 |       \
+                 IC_TAR_GC_OR_START     |       \
+                 IC_TAR_SPECIAL)
+
+/* IC_SAR bit definitions */
+#define IC_SAR                          (0x3ffU)
+#define IC_SAR_VALID_MASK               IC_SAR
+
+/* IC_HS_MADDR bit definitions */
+#define IC_HS_MAR                       (0x7U)
+#define IC_HS_MAR_VALID_MASK            IC_HS_MAR
+
+/* IC_DATA_CMD bit definitions */
+#define IC_DAT                          (0xffU)
+#define IC_CMD                          BIT(8)
+#define IC_STOP                         BIT(9)
+#define IC_RESTART                      BIT(10)
+#define IC_DATA_CMD_VALID_MASK         (IC_DAT | IC_CMD | IC_STOP | IC_RESTART)
+
+/*
+ * The SCL count registers are retained for software compatibility.
+ * QEMU's I2C bus API does not model cycle-accurate bus timing, so these
+ * values do not change the duration of a transfer.
+ */
+#define IC_SS_SCL_HCNT_VALID_MASK                  (0xffffU)
+#define IC_SS_SCL_LCNT_VALID_MASK                  (0xffffU)
+#define IC_FS_SCL_HCNT_VALID_MASK                  (0xffffU)
+#define IC_FS_SCL_LCNT_VALID_MASK                  (0xffffU)
+#define IC_HS_SCL_HCNT_VALID_MASK                  (0xffffU)
+#define IC_HS_SCL_LCNT_VALID_MASK                  (0xffffU)
+
+/* IC_INTR bit definitions */
+#define IC_INTR_RX_UNDER         BIT(0)
+#define IC_INTR_RX_OVER          BIT(1)
+#define IC_INTR_RX_FULL          BIT(2)
+#define IC_INTR_TX_OVER          BIT(3)
+#define IC_INTR_TX_EMPTY         BIT(4)
+#define IC_INTR_RD_REQ           BIT(5)
+#define IC_INTR_TX_ABRT          BIT(6)
+#define IC_INTR_RX_DONE          BIT(7)
+#define IC_INTR_ACTIVITY         BIT(8)
+#define IC_INTR_STOP_DET         BIT(9)
+#define IC_INTR_START_DET        BIT(10)
+#define IC_INTR_GEN_CALL         BIT(11)
+#define IC_INTR_VALID_MASK       (0xfffU)
+#define IC_INTR_SW_CLEAR_MASK                                 \
+                    (IC_INTR_RX_UNDER | IC_INTR_RX_OVER   |   \
+                     IC_INTR_TX_OVER  | IC_INTR_RD_REQ    |   \
+                     IC_INTR_TX_ABRT  | IC_INTR_RX_DONE   |   \
+                     IC_INTR_STOP_DET | IC_INTR_START_DET |   \
+                     IC_INTR_GEN_CALL | IC_INTR_ACTIVITY)
+
+/* IC_RX_TL and IC_TX_TL bit definitions */
+#define IC_RX_TL                (0xffU)
+#define IC_TX_TL                (0xffU)
+
+/* CLR Reg bit definitions */
+#define IC_CLR_INTR                 BIT(0)
+#define IC_CLR_RX_UNDER             BIT(0)
+#define IC_CLR_RX_OVER              BIT(0)
+#define IC_CLR_TX_OVER              BIT(0)
+#define IC_CLR_RD_REQ               BIT(0)
+#define IC_CLR_TX_ABRT              BIT(0)
+#define IC_CLR_RX_DONE              BIT(0)
+#define IC_CLR_ACTIVITY             BIT(0)
+#define IC_CLR_STOP_DET             BIT(0)
+#define IC_CLR_START_DET            BIT(0)
+#define IC_CLR_GEN_CALL             BIT(0)
+
+/* IC_ENABLE bit definitions */
+#define IC_ENABLE                   BIT(0)
+
+/* IC_STATUS bit definitions */
+#define IC_ACTIVITY                 BIT(0)
+#define IC_TFNF                     BIT(1)
+#define IC_TFE                      BIT(2)
+#define IC_RFNE                     BIT(3)
+#define IC_RFF                      BIT(4)
+#define IC_MST_ACTIVITY             BIT(5)
+#define IC_SLV_ACTIVITY             BIT(6)
+#define IC_STATUS_VALID_MASK              \
+                (IC_ACTIVITY      |       \
+                 IC_TFNF          |       \
+                 IC_TFE           |       \
+                 IC_RFNE          |       \
+                 IC_RFF           |       \
+                 IC_MST_ACTIVITY  |       \
+                 IC_SLV_ACTIVITY)
+
+/* FIFO level register bit definitions */
+#define IC_TXFLR                       (0x3fU)
+#define IC_RXFLR                       (0x7fU)
+
+/* IC_TX_ABRT_SOURCE bit definitions */
+#define IC_ABRT_7B_ADDR_NOACK          BIT(0)
+#define IC_ABRT_10ADDR1_NOACK          BIT(1)
+#define IC_ABRT_10ADDR2_NOACK          BIT(2)
+#define IC_ABRT_TXDATA_NOACK           BIT(3)
+#define IC_ABRT_GCALL_NOACK            BIT(4)
+#define IC_ABRT_GCALL_READ             BIT(5)
+#define IC_ABRT_HS_ACKDET              BIT(6)
+#define IC_ABRT_SBYTE_ACKDET           BIT(7)
+#define IC_ABRT_HS_NORSTRT             BIT(8)
+#define IC_ABRT_SBYTE_NORSTRT          BIT(9)
+#define IC_ABRT_10B_RD_NORSTRT         BIT(10)
+#define IC_ABRT_MASTER_DIS             BIT(11)
+#define IC_ARB_LOST                    BIT(12)
+#define IC_ABRT_SLVFLUSH_TXFIFO        BIT(13)
+#define IC_ABRT_SLV_ARBLOST            BIT(14)
+#define IC_ABRT_SLVRD_INTX             BIT(15)
+#define IC_ABRT_VALID_MASK             0xffffU
+
+/* IC_SLV_DATA_NACK_ONLY bit definitions */
+#define IC_SLV_NACK                    BIT(0)
+
+/*
+ * DMA support is not modeled by this implementation. DMA register writes
+ * are ignored, the registers remain at their reset values, and
+ * IC_COMP_PARAM_1 reports HAS_DMA as clear.
+ */
+#define IC_SDA_SETUP                  (0xffU)
+#define IC_ACK_GEN_CALL               BIT(0)
+
+/* IC_ENABLE_STATUS bit definitions */
+#define IC_EN                         BIT(0)
+#define SLV_DISABLED_WHILE_BUSY       BIT(1)
+#define SLV_RX_DATA_LOST              BIT(2)
+
+/* IC_COMP_PARAM_1 bit definitions */
+#define IC_COMP_PARAM_APB_DATA_WIDTH        (0x3U)
+#define IC_COMP_PARAM_MAX_SPEED_MODE        (0x3U << 2)
+#define IC_COMP_PARAM_HC_COUNT_VALUES       BIT(4)
+#define IC_COMP_PARAM_INTR_IO               BIT(5)
+#define IC_COMP_PARAM_HAS_DMA               BIT(6)
+#define IC_COMP_PARAM_ADD_ENCODED_PARAMS    BIT(7)
+#define IC_COMP_PARAM_RX_BUFFER_DEPTH       (0xffU << 8)
+#define IC_COMP_PARAM_TX_BUFFER_DEPTH       (0xffU << 16)
+
+#define K230_IC_COMP_PARAM_1_VALUE                            \
+         (2U                                                | \
+         (3U << 2)                                          | \
+         IC_COMP_PARAM_INTR_IO                              | \
+         IC_COMP_PARAM_ADD_ENCODED_PARAMS                   | \
+         ((K230_I2C_RX_FIFO_SIZE - 1U) << 8)                | \
+         ((K230_I2C_TX_FIFO_SIZE - 1U) << 16))
+
+static void k230_i2c_update_irq(K230I2CState *s)
+{
+    uint32_t intr;
+    intr = s->ic_raw_intr_stat & s->ic_intr_mask & IC_INTR_VALID_MASK;
+    qemu_set_irq(s->irq, intr != 0);
+}
+
+static uint64_t k230_i2c_clear_intr(K230I2CState *s, uint32_t mask)
+{
+    s->ic_raw_intr_stat &= ~mask;
+    k230_i2c_update_irq(s);
+
+    return 0;
+}
+
+static bool k230_i2c_is_activity(K230I2CState *s)
+{
+    return (s->transfer_state != K230_I2C_STATE_IDLE);
+}
+
+static uint32_t k230_i2c_get_status(K230I2CState *s)
+{
+    uint32_t status = 0;
+
+    if (k230_i2c_is_activity(s)) {
+        status |= IC_ACTIVITY;
+        status |= IC_MST_ACTIVITY;
+    }
+
+    if (!fifo32_is_full(&s->tx_fifo)) {
+        status |= IC_TFNF;
+    }
+
+    if (fifo32_is_empty(&s->tx_fifo)) {
+        status |= IC_TFE;
+    }
+
+    if (!fifo8_is_empty(&s->rx_fifo)) {
+        status |= IC_RFNE;
+    }
+
+    if (fifo8_is_full(&s->rx_fifo)) {
+        status |= IC_RFF;
+    }
+    return status;
+}
+
+static bool k230_i2c_clear_tx_abrt_bit9(K230I2CState *s)
+{
+    return (s->ic_con & IC_CON_RESTART_EN) ||
+           !(s->ic_tar & IC_TAR_SPECIAL) ||
+           !(s->ic_tar & IC_TAR_GC_OR_START);
+}
+
+static void k230_i2c_update_fifo_intr(K230I2CState *s)
+{
+    uint32_t rx_level = fifo8_num_used(&s->rx_fifo);
+    uint32_t tx_level = fifo32_num_used(&s->tx_fifo);
+
+    if (!(s->ic_enable & IC_ENABLE)) {
+        s->ic_raw_intr_stat &= ~(IC_INTR_RX_FULL | IC_INTR_TX_EMPTY);
+        return;
+    }
+
+    if (rx_level > s->ic_rx_tl) {
+        s->ic_raw_intr_stat |= IC_INTR_RX_FULL;
+    } else {
+        s->ic_raw_intr_stat &= ~IC_INTR_RX_FULL;
+    }
+
+    if (!(s->ic_raw_intr_stat & IC_INTR_TX_ABRT) &&
+        tx_level <= s->ic_tx_tl) {
+        s->ic_raw_intr_stat |= IC_INTR_TX_EMPTY;
+    } else {
+        s->ic_raw_intr_stat &= ~IC_INTR_TX_EMPTY;
+    }
+}
+
+static uint64_t k230_i2c_clear_tx_abrt(K230I2CState *s)
+{
+    bool clr_bit9 = k230_i2c_clear_tx_abrt_bit9(s);
+    bool had_bit9 = !!(s->ic_tx_abrt_source & IC_ABRT_SBYTE_NORSTRT);
+
+    s->ic_raw_intr_stat &= ~IC_INTR_TX_ABRT;
+    s->ic_tx_abrt_source = 0;
+    if (!clr_bit9 && had_bit9) {
+        s->ic_tx_abrt_source |= IC_ABRT_SBYTE_NORSTRT;
+        s->ic_raw_intr_stat |= IC_INTR_TX_ABRT;
+    }
+    k230_i2c_update_fifo_intr(s);
+    k230_i2c_update_irq(s);
+    return 0;
+}
+
+static uint64_t k230_i2c_clear_all_intr(K230I2CState *s)
+{
+    bool active = k230_i2c_is_activity(s);
+    s->ic_raw_intr_stat &= ~IC_INTR_SW_CLEAR_MASK;
+    if (active) {
+        s->ic_raw_intr_stat |= IC_INTR_ACTIVITY;
+    }
+    return k230_i2c_clear_tx_abrt(s);
+}
+
+static uint64_t k230_i2c_read_data_cmd(K230I2CState *s)
+{
+    uint8_t data;
+
+    if (fifo8_is_empty(&s->rx_fifo)) {
+        s->ic_raw_intr_stat |= IC_INTR_RX_UNDER;
+        k230_i2c_update_irq(s);
+        return 0;
+    }
+
+    data = fifo8_pop(&s->rx_fifo);
+    if (fifo8_num_used(&s->rx_fifo) >= s->ic_rx_tl + 1) {
+        s->ic_raw_intr_stat |= IC_INTR_RX_FULL;
+    } else {
+        s->ic_raw_intr_stat &= ~IC_INTR_RX_FULL;
+    }
+
+    k230_i2c_update_irq(s);
+    return data;
+}
+
+static void k230_i2c_write_enable(K230I2CState *s, uint32_t value)
+{
+    bool enable_flag = !!(value & IC_ENABLE);
+
+    if (enable_flag) {
+        s->ic_enable = enable_flag;
+        s->ic_enable_status = enable_flag;
+
+        k230_i2c_update_fifo_intr(s);
+        k230_i2c_update_irq(s);
+        return;
+    }
+
+    if (s->transfer_state == K230_I2C_STATE_RECEIVING) {
+        i2c_nack(s->bus);
+    }
+
+    if (k230_i2c_is_activity(s)) {
+        i2c_end_transfer(s->bus);
+    }
+
+    fifo8_reset(&s->rx_fifo);
+    fifo32_reset(&s->tx_fifo);
+
+    s->transfer_state = K230_I2C_STATE_IDLE;
+    s->ic_enable_status = 0;
+    s->ic_enable = 0;
+    s->ic_raw_intr_stat &= ~(IC_INTR_TX_EMPTY |
+                             IC_INTR_RX_FULL  |
+                             IC_INTR_ACTIVITY);
+    k230_i2c_update_irq(s);
+}
+
+static void k230_i2c_abort(K230I2CState *s, uint32_t source)
+{
+    s->ic_tx_abrt_source |= source & IC_ABRT_VALID_MASK;
+    s->ic_raw_intr_stat  |= IC_INTR_TX_ABRT;
+
+    if (k230_i2c_is_activity(s)) {
+        i2c_end_transfer(s->bus);
+    }
+
+    fifo32_reset(&s->tx_fifo);
+    fifo8_reset(&s->rx_fifo);
+
+    s->transfer_state = K230_I2C_STATE_IDLE;
+
+    s->ic_raw_intr_stat &= ~(IC_INTR_TX_EMPTY | IC_INTR_RX_FULL);
+
+    k230_i2c_update_irq(s);
+}
+
+static bool k230_i2c_start_address_phase(K230I2CState *s, bool is_read)
+{
+    uint8_t address;
+    uint32_t noack_source;
+    bool initial_start;
+    bool special;
+    bool general_call;
+    bool start_byte;
+
+    initial_start = (s->transfer_state == K230_I2C_STATE_IDLE);
+
+    if (!(s->ic_con & IC_CON_MASTER_MODE)) {
+        k230_i2c_abort(s, IC_ABRT_MASTER_DIS);
+        return false;
+    }
+
+    /*
+     * This implementation handles 7-bit master transfers only. Requests for
+     * 10-bit master mode are aborted rather than treated as 7-bit transfers.
+     */
+    if (s->ic_con & IC_CON_10BITADDR_MASTER) {
+        qemu_log_mask(LOG_UNIMP,
+                       "k230-i2c: 10-bit master addressing "
+                           "is not implemented\n");
+        k230_i2c_abort(s, 0);
+        return false;
+    }
+
+    special = !!(s->ic_tar & IC_TAR_SPECIAL);
+
+    general_call = (special && !(s->ic_tar & IC_TAR_GC_OR_START));
+
+    start_byte = (special && !!(s->ic_tar & IC_TAR_GC_OR_START));
+
+    /*
+     * QEMU's I2C bus API cannot emit the raw START byte before the target
+     * address. Preserve the DW_apb_i2c RESTART_EN requirement, then fall
+     * back to the normal target-address phase.
+     */
+    if (initial_start && start_byte && !(s->ic_con & IC_CON_RESTART_EN)) {
+        k230_i2c_abort(s, IC_ABRT_SBYTE_NORSTRT);
+        return false;
+    }
+
+    if (general_call) {
+        if (is_read) {
+            k230_i2c_abort(s, IC_ABRT_GCALL_READ);
+            return false;
+        }
+        address = 0;
+        noack_source = IC_ABRT_GCALL_NOACK;
+    } else {
+        address = s->ic_tar & 0x7fU;
+        noack_source = IC_ABRT_7B_ADDR_NOACK;
+    }
+
+    s->ic_raw_intr_stat |= IC_INTR_START_DET | IC_INTR_ACTIVITY;
+
+    if (i2c_start_transfer(s->bus, address, is_read)) {
+        k230_i2c_abort(s, noack_source);
+        return false;
+    }
+
+    s->transfer_state = is_read ? K230_I2C_STATE_RECEIVING :
+                                  K230_I2C_STATE_SENDING;
+
+    return true;
+}
+
+/*
+ * DATA_CMD writes are executed synchronously. The TX FIFO acts as a
+ * transient command staging buffer, while the RX FIFO retains received
+ * data for guest reads and FIFO-level interrupt handling.
+ */
+static void k230_i2c_write_data_cmd(K230I2CState *s, uint32_t value)
+{
+    uint32_t command;
+    uint32_t tx_entry;
+    uint8_t data;
+    bool is_read;
+    bool restart;
+    bool stop;
+    bool direction_changed;
+    bool need_restart;
+    int ret;
+
+    if (!(s->ic_enable & IC_ENABLE)) {
+        return;
+    }
+
+    if (s->ic_raw_intr_stat & IC_INTR_TX_ABRT) {
+        return;
+    }
+
+    if (fifo32_is_full(&s->tx_fifo)) {
+        s->ic_raw_intr_stat |= IC_INTR_TX_OVER;
+        k230_i2c_update_irq(s);
+        return;
+    }
+
+    command = value & IC_DATA_CMD_VALID_MASK;
+
+    fifo32_push(&s->tx_fifo, command);
+
+    tx_entry = fifo32_pop(&s->tx_fifo);
+
+    data = tx_entry & IC_DAT;
+    is_read = !!(tx_entry & IC_CMD);
+    restart = !!(tx_entry & IC_RESTART);
+    stop = !!(tx_entry & IC_STOP);
+
+    direction_changed =
+        (s->transfer_state == K230_I2C_STATE_SENDING && is_read) ||
+        (s->transfer_state == K230_I2C_STATE_RECEIVING && !is_read);
+
+    need_restart = restart || direction_changed;
+
+    switch (s->transfer_state) {
+    case K230_I2C_STATE_IDLE:
+        if (!k230_i2c_start_address_phase(s, is_read)) {
+            return;
+        }
+        break;
+    case K230_I2C_STATE_SENDING:
+    case K230_I2C_STATE_RECEIVING:
+        if (need_restart) {
+            if (!(s->ic_con & IC_CON_RESTART_EN)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "k230-i2c: restart requested while "
+                                  "IC_RESTART_EN is disabled\n");
+                k230_i2c_abort(s, 0);
+                return;
+            }
+
+            if (s->transfer_state == K230_I2C_STATE_RECEIVING) {
+                i2c_nack(s->bus);
+            }
+
+            if (!k230_i2c_start_address_phase(s, is_read)) {
+                return;
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (is_read) {
+        data = i2c_recv(s->bus);
+        if (fifo8_is_full(&s->rx_fifo)) {
+            s->ic_raw_intr_stat |= IC_INTR_RX_OVER;
+        } else {
+            fifo8_push(&s->rx_fifo, data);
+        }
+    } else {
+        ret = i2c_send(s->bus, data);
+        if (ret) {
+            k230_i2c_abort(s, IC_ABRT_TXDATA_NOACK);
+            return;
+        }
+    }
+
+    if (stop) {
+        if (is_read) {
+            i2c_nack(s->bus);
+        }
+
+        i2c_end_transfer(s->bus);
+
+        s->transfer_state = K230_I2C_STATE_IDLE;
+        s->ic_raw_intr_stat |= IC_INTR_STOP_DET;
+    }
+
+    k230_i2c_update_fifo_intr(s);
+    k230_i2c_update_irq(s);
+}
+
+static uint64_t k230_i2c_read(void *opaque, hwaddr offset, unsigned size)
+{
+    K230I2CState *s = K230_I2C(opaque);
+    uint64_t activity_flag;
+    switch (offset) {
+    case K230_IC_CON:
+        return s->ic_con;
+    case K230_IC_TAR:
+        return s->ic_tar;
+    case K230_IC_SAR:
+        return s->ic_sar;
+    case K230_IC_HS_MADDR:
+        return s->ic_hs_maddr;
+    case K230_IC_DATA_CMD:
+        return k230_i2c_read_data_cmd(s);
+    case K230_IC_SS_SCL_HCNT:
+        return s->ic_ss_scl_hcnt;
+    case K230_IC_SS_SCL_LCNT:
+        return s->ic_ss_scl_lcnt;
+    case K230_IC_FS_SCL_HCNT:
+        return s->ic_fs_scl_hcnt;
+    case K230_IC_FS_SCL_LCNT:
+        return s->ic_fs_scl_lcnt;
+    case K230_IC_HS_SCL_HCNT:
+        return s->ic_hs_scl_hcnt;
+    case K230_IC_HS_SCL_LCNT:
+        return s->ic_hs_scl_lcnt;
+    case K230_IC_INTR_STAT:
+        return s->ic_raw_intr_stat & s->ic_intr_mask;
+    case K230_IC_INTR_MASK:
+        return s->ic_intr_mask;
+    case K230_IC_RAW_INTR_STAT:
+        return s->ic_raw_intr_stat;
+    case K230_IC_RX_TL:
+        return s->ic_rx_tl;
+    case K230_IC_TX_TL:
+        return s->ic_tx_tl;
+    case K230_IC_CLR_INTR:
+        return k230_i2c_clear_all_intr(s);
+    case K230_IC_CLR_RX_UNDER:
+        return k230_i2c_clear_intr(s, IC_INTR_RX_UNDER);
+    case K230_IC_CLR_RX_OVER:
+        return k230_i2c_clear_intr(s, IC_INTR_RX_OVER);
+    case K230_IC_CLR_TX_OVER:
+        return k230_i2c_clear_intr(s, IC_INTR_TX_OVER);
+    case K230_IC_CLR_RD_REQ:
+        return k230_i2c_clear_intr(s, IC_INTR_RD_REQ);
+    case K230_IC_CLR_TX_ABRT:
+        return k230_i2c_clear_tx_abrt(s);
+    case K230_IC_CLR_RX_DONE:
+        return k230_i2c_clear_intr(s, IC_INTR_RX_DONE);
+    case K230_IC_CLR_ACTIVITY:
+        activity_flag = !!(s->ic_raw_intr_stat & IC_INTR_ACTIVITY);
+        if (!k230_i2c_is_activity(s)) {
+            k230_i2c_clear_intr(s, IC_INTR_ACTIVITY);
+        }
+        return activity_flag;
+    case K230_IC_CLR_STOP_DET:
+        return k230_i2c_clear_intr(s, IC_INTR_STOP_DET);
+    case K230_IC_CLR_START_DET:
+        return k230_i2c_clear_intr(s, IC_INTR_START_DET);
+    case K230_IC_CLR_GEN_CALL:
+        return k230_i2c_clear_intr(s, IC_INTR_GEN_CALL);
+    case K230_IC_ENABLE:
+        return s->ic_enable;
+    case K230_IC_STATUS:
+        return k230_i2c_get_status(s);
+    case K230_IC_TXFLR:
+        return fifo32_num_used(&s->tx_fifo);
+    case K230_IC_RXFLR:
+        return fifo8_num_used(&s->rx_fifo);
+    case K230_IC_TX_ABRT_SOURCE:
+        return s->ic_tx_abrt_source;
+    case K230_IC_SLV_DATA_NACK_ONLY:
+        return s->ic_slv_data_nack_only;
+    case K230_IC_DMA_CR:
+        return s->ic_dma_cr;
+    case K230_IC_DMA_TDLR:
+        return s->ic_dma_tdlr;
+    case K230_IC_DMA_RDLR:
+        return s->ic_dma_rdlr;
+    case K230_IC_SDA_SETUP:
+        return s->ic_sda_setup;
+    case K230_IC_ACK_GENERAL_CALL:
+        return s->ic_ack_general_call;
+    case K230_IC_ENABLE_STATUS:
+        return s->ic_enable_status;
+    case K230_IC_COMP_PARAM_1:
+        return K230_IC_COMP_PARAM_1_VALUE;
+    case K230_IC_COMP_VERSION:
+        return 0x3132302aU;
+    case K230_IC_COMP_TYPE:
+        return 0x44570140U;
+    default:
+        return 0;
+    }
+}
+
+static void k230_i2c_write(void *opaque, hwaddr offset,
+                           uint64_t value, unsigned size)
+{
+    K230I2CState *s = K230_I2C(opaque);
+    uint32_t val = value;
+
+    switch (offset) {
+    case K230_IC_CON: {
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+        s->ic_con = val & IC_CON_VALID_MASK;
+
+        if (!((s->ic_con & IC_CON_SPEED) >> 1)) {
+            s->ic_con |= IC_CON_SPEED;
+        }
+        s->ic_con |= IC_CON_SLAVE_DISABLE;
+        break;
+    }
+    case K230_IC_TAR: {
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+        s->ic_tar = val & IC_TAR_VALID_MASK;
+        break;
+    }
+    case K230_IC_SAR: {
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+        s->ic_sar = val & IC_SAR_VALID_MASK;
+        break;
+    }
+    case K230_IC_HS_MADDR: {
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+        s->ic_hs_maddr = val & IC_HS_MAR_VALID_MASK;
+        break;
+    }
+    case K230_IC_DATA_CMD: {
+        k230_i2c_write_data_cmd(s, val);
+        break;
+    }
+    case K230_IC_SS_SCL_HCNT: {
+        uint16_t count;
+
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+
+        count = val & IC_SS_SCL_HCNT_VALID_MASK;
+
+        if (count < 6) {
+            count = 6;
+        } else if (count > 65525) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "k230-i2c: invalid IC_SS_SCL_HCNT value %u\n",
+                        (unsigned int)count);
+            break;
+        }
+
+        s->ic_ss_scl_hcnt = count;
+
+        break;
+    }
+    case K230_IC_SS_SCL_LCNT: {
+        uint16_t count;
+
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+
+        count = val & IC_SS_SCL_LCNT_VALID_MASK;
+
+        if (count < 8) {
+            count = 8;
+        }
+
+        s->ic_ss_scl_lcnt = count;
+
+        break;
+    }
+    case K230_IC_FS_SCL_HCNT: {
+        uint16_t count;
+
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+
+        count = val & IC_FS_SCL_HCNT_VALID_MASK;
+
+        if (count < 6) {
+            count = 6;
+        }
+
+        s->ic_fs_scl_hcnt = count;
+
+        break;
+    }
+    case K230_IC_FS_SCL_LCNT: {
+        uint16_t count;
+
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+
+        count = val & IC_FS_SCL_LCNT_VALID_MASK;
+
+        if (count < 8) {
+            count = 8;
+        }
+
+        s->ic_fs_scl_lcnt = count;
+
+        break;
+    }
+    case K230_IC_HS_SCL_HCNT: {
+        uint16_t count;
+
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+
+        count = val & IC_HS_SCL_HCNT_VALID_MASK;
+
+        if (count < 6) {
+            count = 6;
+        }
+
+        s->ic_hs_scl_hcnt = count;
+
+        break;
+    }
+    case K230_IC_HS_SCL_LCNT: {
+        uint16_t count;
+
+        if (s->ic_enable & IC_ENABLE) {
+            break;
+        }
+
+        count = val & IC_HS_SCL_LCNT_VALID_MASK;
+
+        if (count < 8) {
+            count = 8;
+        }
+
+        s->ic_hs_scl_lcnt = count;
+
+        break;
+    }
+    case K230_IC_INTR_MASK: {
+        s->ic_intr_mask = val & IC_INTR_VALID_MASK;
+
+        k230_i2c_update_irq(s);
+        break;
+    }
+    case K230_IC_RX_TL: {
+        uint8_t threshold;
+
+        threshold = val & IC_RX_TL;
+        if (threshold > K230_I2C_RX_FIFO_SIZE - 1) {
+            threshold = K230_I2C_RX_FIFO_SIZE - 1;
+        }
+        s->ic_rx_tl = threshold;
+
+        k230_i2c_update_fifo_intr(s);
+        k230_i2c_update_irq(s);
+
+        break;
+    }
+    case K230_IC_TX_TL: {
+        uint8_t threshold;
+
+        threshold = val & IC_TX_TL;
+        if (threshold > K230_I2C_TX_FIFO_SIZE) {
+            threshold = K230_I2C_TX_FIFO_SIZE;
+        }
+        s->ic_tx_tl = threshold;
+
+        k230_i2c_update_fifo_intr(s);
+        k230_i2c_update_irq(s);
+
+        break;
+    }
+    case K230_IC_ENABLE: {
+        k230_i2c_write_enable(s, val);
+        break;
+    }
+    case K230_IC_TX_ABRT_SOURCE: {
+        s->ic_tx_abrt_source = val & IC_ABRT_VALID_MASK;
+        break;
+    }
+    case K230_IC_SLV_DATA_NACK_ONLY: {
+        /* Slave mode is not supported. */
+        break;
+    }
+    case K230_IC_DMA_CR: {
+        break;
+    }
+    case K230_IC_DMA_TDLR: {
+        break;
+    }
+    case K230_IC_DMA_RDLR: {
+        break;
+    }
+    case K230_IC_SDA_SETUP: {
+        s->ic_sda_setup = val & IC_SDA_SETUP;
+        break;
+    }
+    case K230_IC_ACK_GENERAL_CALL: {
+        s->ic_ack_general_call = val & IC_ACK_GEN_CALL;
+        break;
+    }
+    default:
+        return;
+    }
+}
+
+static void k230_i2c_reset(Object *obj, ResetType type)
+{
+    K230I2CState *s = K230_I2C(obj);
+
+    if (s->transfer_state == K230_I2C_STATE_RECEIVING) {
+        i2c_nack(s->bus);
+    }
+
+    if (k230_i2c_is_activity(s)) {
+        i2c_end_transfer(s->bus);
+    }
+
+    fifo8_reset(&s->rx_fifo);
+    fifo32_reset(&s->tx_fifo);
+
+    s->transfer_state = K230_I2C_STATE_IDLE;
+
+    s->ic_con = 0x7f;
+    s->ic_tar = 0x055;
+    s->ic_sar = 0x055;
+    s->ic_hs_maddr = 0x1;
+
+    s->ic_ss_scl_hcnt = 0x0190;
+    s->ic_ss_scl_lcnt = 0x01d6;
+    s->ic_fs_scl_hcnt = 0x003c;
+    s->ic_fs_scl_lcnt = 0x0082;
+    s->ic_hs_scl_hcnt = 0x0006;
+    s->ic_hs_scl_lcnt = 0x0010;
+
+    s->ic_intr_mask = 0x8ff;
+    s->ic_raw_intr_stat = 0;
+
+    s->ic_rx_tl = 0;
+    s->ic_tx_tl = 0;
+
+    s->ic_enable = 0;
+    s->ic_enable_status = 0;
+
+    s->ic_tx_abrt_source = 0;
+    s->ic_slv_data_nack_only = 0;
+
+    s->ic_dma_cr = 0;
+    s->ic_dma_tdlr = 0;
+    s->ic_dma_rdlr = 0;
+
+    s->ic_sda_setup = 0x64;
+    s->ic_ack_general_call = 0x1;
+
+    qemu_set_irq(s->irq, 0);
+}
+
+static const MemoryRegionOps k230_i2c_ops = {
+    .read = k230_i2c_read,
+    .write = k230_i2c_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void k230_i2c_init(Object *obj)
+{
+    K230I2CState *s = K230_I2C(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    fifo8_create(&s->rx_fifo, K230_I2C_RX_FIFO_SIZE);
+    fifo32_create(&s->tx_fifo, K230_I2C_TX_FIFO_SIZE);
+
+    s->bus = i2c_init_bus(DEVICE(obj), "i2c");
+
+    memory_region_init_io(&s->iomem, obj,
+                          &k230_i2c_ops, s,
+                          TYPE_K230_I2C, K230_I2C_MMIO_SIZE);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void k230_i2c_finalize(Object *obj)
+{
+    K230I2CState *s = K230_I2C(obj);
+
+    fifo8_destroy(&s->rx_fifo);
+    fifo32_destroy(&s->tx_fifo);
+}
+
+static int k230_i2c_post_load(void *opaque, int version_id)
+{
+    K230I2CState *s = opaque;
+
+    if (s->transfer_state > K230_I2C_STATE_RECEIVING) {
+        return -EINVAL;
+    }
+
+    k230_i2c_update_fifo_intr(s);
+    k230_i2c_update_irq(s);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_k230_i2c = {
+    .name = TYPE_K230_I2C,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = k230_i2c_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ic_con, K230I2CState),
+        VMSTATE_UINT32(ic_tar, K230I2CState),
+        VMSTATE_UINT32(ic_sar, K230I2CState),
+        VMSTATE_UINT32(ic_hs_maddr, K230I2CState),
+
+        VMSTATE_UINT32(ic_ss_scl_hcnt, K230I2CState),
+        VMSTATE_UINT32(ic_ss_scl_lcnt, K230I2CState),
+        VMSTATE_UINT32(ic_fs_scl_hcnt, K230I2CState),
+        VMSTATE_UINT32(ic_fs_scl_lcnt, K230I2CState),
+        VMSTATE_UINT32(ic_hs_scl_hcnt, K230I2CState),
+        VMSTATE_UINT32(ic_hs_scl_lcnt, K230I2CState),
+
+        VMSTATE_UINT32(ic_intr_mask, K230I2CState),
+        VMSTATE_UINT32(ic_raw_intr_stat, K230I2CState),
+
+        VMSTATE_UINT32(ic_rx_tl, K230I2CState),
+        VMSTATE_UINT32(ic_tx_tl, K230I2CState),
+
+        VMSTATE_UINT32(ic_enable, K230I2CState),
+        VMSTATE_UINT32(ic_tx_abrt_source, K230I2CState),
+
+        VMSTATE_UINT32(ic_sda_setup, K230I2CState),
+        VMSTATE_UINT32(ic_slv_data_nack_only, K230I2CState),
+
+        VMSTATE_UINT32(ic_dma_cr, K230I2CState),
+        VMSTATE_UINT32(ic_dma_tdlr, K230I2CState),
+        VMSTATE_UINT32(ic_dma_rdlr, K230I2CState),
+        VMSTATE_UINT32(ic_ack_general_call, K230I2CState),
+        VMSTATE_UINT32(ic_enable_status, K230I2CState),
+
+        VMSTATE_FIFO8(rx_fifo, K230I2CState),
+        VMSTATE_FIFO32(tx_fifo, K230I2CState),
+
+        VMSTATE_UINT32(transfer_state, K230I2CState),
+
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void k230_i2c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_k230_i2c;
+    rc->phases.hold = k230_i2c_reset;
+}
+
+static const TypeInfo k230_i2c_info = {
+    .name = TYPE_K230_I2C,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230I2CState),
+    .instance_init = k230_i2c_init,
+    .instance_finalize = k230_i2c_finalize,
+    .class_init = k230_i2c_class_init,
+};
+
+static void k230_i2c_register_types(void)
+{
+    type_register_static(&k230_i2c_info);
+}
+
+type_init(k230_i2c_register_types)
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index 88aea35662..10da237dd9 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -19,4 +19,5 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
+i2c_ss.add(when: 'CONFIG_K230_I2C', if_true: files('k230_i2c.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
diff --git a/include/hw/i2c/k230_i2c.h b/include/hw/i2c/k230_i2c.h
new file mode 100644
index 0000000000..94a4128f46
--- /dev/null
+++ b/include/hw/i2c/k230_i2c.h
@@ -0,0 +1,72 @@
+/*
+ * K230 DesignWare I2C controller
+ *
+ * Copyright (c) 2026 Wang Zhongyu <wzy15515798875@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_I2C_K230_I2C_H
+#define HW_I2C_K230_I2C_H
+
+#include <stdint.h>
+
+#include "hw/core/sysbus.h"
+#include "hw/i2c/i2c.h"
+#include "qemu/fifo32.h"
+#include "qemu/fifo8.h"
+
+#define K230_I2C_RX_FIFO_SIZE 64
+#define K230_I2C_TX_FIFO_SIZE 32
+
+#define TYPE_K230_I2C "k230-i2c"
+OBJECT_DECLARE_SIMPLE_TYPE(K230I2CState, K230_I2C)
+
+typedef enum K230I2CTransferState {
+    K230_I2C_STATE_IDLE,
+    K230_I2C_STATE_SENDING,
+    K230_I2C_STATE_RECEIVING,
+} K230I2CTransferState;
+
+struct K230I2CState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    I2CBus *bus;
+    qemu_irq irq;
+
+    /* K230 I2C register list */
+    uint32_t ic_con;
+    uint32_t ic_tar;
+    uint32_t ic_sar;
+    uint32_t ic_hs_maddr;
+    uint32_t ic_ss_scl_hcnt;
+    uint32_t ic_ss_scl_lcnt;
+    uint32_t ic_fs_scl_hcnt;
+    uint32_t ic_fs_scl_lcnt;
+    uint32_t ic_hs_scl_hcnt;
+    uint32_t ic_hs_scl_lcnt;
+
+    uint32_t ic_intr_mask;
+    uint32_t ic_raw_intr_stat;
+
+    uint32_t ic_rx_tl;
+    uint32_t ic_tx_tl;
+
+    uint32_t ic_enable;
+
+    uint32_t ic_tx_abrt_source;
+    uint32_t ic_sda_setup;
+    uint32_t ic_slv_data_nack_only;
+    uint32_t ic_dma_cr;
+    uint32_t ic_dma_tdlr;
+    uint32_t ic_dma_rdlr;
+    uint32_t ic_ack_general_call;
+    uint32_t ic_enable_status;
+
+    Fifo8 rx_fifo;
+    Fifo32 tx_fifo;
+    uint32_t transfer_state;
+};
+
+#endif /* HW_I2C_K230_I2C_H */
-- 
2.43.0


