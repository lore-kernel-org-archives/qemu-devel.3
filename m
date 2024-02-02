Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C8C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvbB-0000hh-7A; Fri, 02 Feb 2024 10:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb7-0000Oq-Ah
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb3-0004Xl-Q3
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40ef6bbb61fso18649085e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888212; x=1707493012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d4Dw/zUBj8djGXGpZZ1PuJwGodEvYtT2TVETZ0aTH+E=;
 b=YsQuOv0VtNcGpnDI9QafVXkv87/tSNajJwkq4b6NcOUpExm+gnyy1tsS//xro/WPFA
 15r2GboivFVXYGNRjq/VIDDUFsylgSf1vYVo5Kz64ZU/0tPTzimNg/6bxdqvzQqaZ4Um
 Mg7K/mmlWGV+D4Wl3nVsDqucJ/x7H/VNqh05Vpr08XmjZ18X/hQPgoOLkJ3O3n7Ak0Wr
 red5r+J1TqE6c8InRHCi3gTamijQYs+gsi5jzZ2O/L7c7Ogt8WvYRX7cO3dGjtEbU+bA
 gws94pzNCmYXTKFWFGC2tA+hYIXEfhw0aXbbd9b4I810U2K5vxLfmvUU8LlKYqK0b2kD
 F5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888212; x=1707493012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4Dw/zUBj8djGXGpZZ1PuJwGodEvYtT2TVETZ0aTH+E=;
 b=cRB6GqpfbFGyobTUEY4SOWKud96gs4wPxqQRfFuWIigtXltRj+Ge08kX9eh7DjIy/O
 SMCNtTKBDENnRyIzh/1o5lGzzcKGUKs24VoLkQPAkGDYD2xZAWHIBPY6ZoB82DORRcYD
 tUTnni2cDmgbeFM5kMyh51jGw3Dour8EqOPE+gMr5C6CceMr4UJnrZQCPUGCK4uXhWEr
 BNYAJLLPab2Ab1uPhDHfDAM9+YqihsjOGBaMt7rYU3Glw4Yvrv3juA23iR2/TimeGEf1
 96PE9CjXZzlqYZ2WBsYRqx9CujgA5CyPXG8mGehzlq4uVlv1dxx/cUtOgpvOXmIwWs+5
 utcQ==
X-Gm-Message-State: AOJu0Yyqzb8g+ZqmvV6zdluOsGJbpBrYDCm+gF50xbsOCv6Sog6hvIOM
 Ft5Ibv2KKnzpWGmXezW3fnLlqFs87Qu1bBuCLuYoxAZYzT2PNT0ZTxEycfDZP7GM0DxQ/gCXI0g
 h
X-Google-Smtp-Source: AGHT+IGy3upOuyToh5107HDZfc1ovB1dMWQfHvUH1gqAtwJ9XpyKnYzHTGrUEssBILeNnFVjd6jrcg==
X-Received: by 2002:a05:600c:b9a:b0:40f:cb4b:dfe3 with SMTP id
 fl26-20020a05600c0b9a00b0040fcb4bdfe3mr763210wmb.16.1706888212104; 
 Fri, 02 Feb 2024 07:36:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/36] hw/net: Add NPCMXXX GMAC device
Date: Fri,  2 Feb 2024 15:36:30 +0000
Message-Id: <20240202153637.3710444-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

This patch implements the basic registers of GMAC device and sets
registers for networking functionalities.
Squashed IRQ Implementation patch into this one for compliation.
Tested:
The following message shows up with the change:
Broadcom BCM54612E stmmac-0:00: attached PHY driver [Broadcom BCM54612E] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
stmmaceth f0802000.eth eth0: Link is Up - 1Gbps/Full - flow control rx/tx

Change-Id: If71c6d486b95edcccba109ba454870714d7e0940
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Message-id: 20240131002800.989285-2-nabihestefan@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/npcm_gmac.h | 343 +++++++++++++++++++++++++++
 hw/net/npcm_gmac.c         | 467 +++++++++++++++++++++++++++++++++++++
 hw/net/meson.build         |   2 +-
 hw/net/trace-events        |  12 +
 4 files changed, 823 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 hw/net/npcm_gmac.c

diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
new file mode 100644
index 00000000000..f2d9f08ec1a
--- /dev/null
+++ b/include/hw/net/npcm_gmac.h
@@ -0,0 +1,343 @@
+/*
+ * Nuvoton NPCM7xx/8xx GMAC Module
+ *
+ * Copyright 2024 Google LLC
+ * Authors:
+ * Hao Wu <wuhaotsh@google.com>
+ * Nabih Estefan <nabihestefan@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef NPCM_GMAC_H
+#define NPCM_GMAC_H
+
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "net/net.h"
+
+#define NPCM_GMAC_NR_REGS (0x1060 / sizeof(uint32_t))
+
+#define NPCM_GMAC_MAX_PHYS 32
+#define NPCM_GMAC_MAX_PHY_REGS 32
+
+struct NPCMGMACRxDesc {
+    uint32_t rdes0;
+    uint32_t rdes1;
+    uint32_t rdes2;
+    uint32_t rdes3;
+};
+
+/* NPCMGMACRxDesc.flags values */
+/* RDES2 and RDES3 are buffer addresses */
+/* Owner: 0 = software, 1 = dma */
+#define RX_DESC_RDES0_OWN BIT(31)
+/* Destination Address Filter Fail */
+#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL BIT(30)
+/* Frame length */
+#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 14)
+/* Frame length Shift*/
+#define RX_DESC_RDES0_FRAME_LEN_SHIFT 16
+/* Error Summary */
+#define RX_DESC_RDES0_ERR_SUMM_MASK BIT(15)
+/* Descriptor Error */
+#define RX_DESC_RDES0_DESC_ERR_MASK BIT(14)
+/* Source Address Filter Fail */
+#define RX_DESC_RDES0_SRC_ADDR_FILT_FAIL_MASK BIT(13)
+/* Length Error */
+#define RX_DESC_RDES0_LEN_ERR_MASK BIT(12)
+/* Overflow Error */
+#define RX_DESC_RDES0_OVRFLW_ERR_MASK BIT(11)
+/* VLAN Tag */
+#define RX_DESC_RDES0_VLAN_TAG_MASK BIT(10)
+/* First Descriptor */
+#define RX_DESC_RDES0_FIRST_DESC_MASK BIT(9)
+/* Last Descriptor */
+#define RX_DESC_RDES0_LAST_DESC_MASK BIT(8)
+/* IPC Checksum Error/Giant Frame */
+#define RX_DESC_RDES0_IPC_CHKSM_ERR_GNT_FRM_MASK BIT(7)
+/* Late Collision */
+#define RX_DESC_RDES0_LT_COLL_MASK BIT(6)
+/* Frame Type */
+#define RX_DESC_RDES0_FRM_TYPE_MASK BIT(5)
+/* Receive Watchdog Timeout */
+#define RX_DESC_RDES0_REC_WTCHDG_TMT_MASK BIT(4)
+/* Receive Error */
+#define RX_DESC_RDES0_RCV_ERR_MASK BIT(3)
+/* Dribble Bit Error */
+#define RX_DESC_RDES0_DRBL_BIT_ERR_MASK BIT(2)
+/* Cyclcic Redundancy Check Error */
+#define RX_DESC_RDES0_CRC_ERR_MASK BIT(1)
+/* Rx MAC Address/Payload Checksum Error */
+#define RC_DESC_RDES0_RCE_MASK BIT(0)
+
+/* Disable Interrupt on Completion */
+#define RX_DESC_RDES1_DIS_INTR_COMP_MASK BIT(31)
+/* Recieve end of ring */
+#define RX_DESC_RDES1_RC_END_RING_MASK BIT(25)
+/* Second Address Chained */
+#define RX_DESC_RDES1_SEC_ADDR_CHND_MASK BIT(24)
+/* Receive Buffer 2 Size */
+#define RX_DESC_RDES1_BFFR2_SZ_SHIFT 11
+#define RX_DESC_RDES1_BFFR2_SZ_MASK(word) extract32(word, \
+    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 11)
+/* Receive Buffer 1 Size */
+#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 11)
+
+
+struct NPCMGMACTxDesc {
+    uint32_t tdes0;
+    uint32_t tdes1;
+    uint32_t tdes2;
+    uint32_t tdes3;
+};
+
+/* NPCMGMACTxDesc.flags values */
+/* TDES2 and TDES3 are buffer addresses */
+/* Owner: 0 = software, 1 = gmac */
+#define TX_DESC_TDES0_OWN BIT(31)
+/* Tx Time Stamp Status */
+#define TX_DESC_TDES0_TTSS_MASK BIT(17)
+/* IP Header Error */
+#define TX_DESC_TDES0_IP_HEAD_ERR_MASK BIT(16)
+/* Error Summary */
+#define TX_DESC_TDES0_ERR_SUMM_MASK BIT(15)
+/* Jabber Timeout */
+#define TX_DESC_TDES0_JBBR_TMT_MASK BIT(14)
+/* Frame Flushed */
+#define TX_DESC_TDES0_FRM_FLSHD_MASK BIT(13)
+/* Payload Checksum Error */
+#define TX_DESC_TDES0_PYLD_CHKSM_ERR_MASK BIT(12)
+/* Loss of Carrier */
+#define TX_DESC_TDES0_LSS_CARR_MASK BIT(11)
+/* No Carrier */
+#define TX_DESC_TDES0_NO_CARR_MASK BIT(10)
+/* Late Collision */
+#define TX_DESC_TDES0_LATE_COLL_MASK BIT(9)
+/* Excessive Collision */
+#define TX_DESC_TDES0_EXCS_COLL_MASK BIT(8)
+/* VLAN Frame */
+#define TX_DESC_TDES0_VLAN_FRM_MASK BIT(7)
+/* Collision Count */
+#define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 4)
+/* Excessive Deferral */
+#define TX_DESC_TDES0_EXCS_DEF_MASK BIT(2)
+/* Underflow Error */
+#define TX_DESC_TDES0_UNDRFLW_ERR_MASK BIT(1)
+/* Deferred Bit */
+#define TX_DESC_TDES0_DFRD_BIT_MASK BIT(0)
+
+/* Interrupt of Completion */
+#define TX_DESC_TDES1_INTERR_COMP_MASK BIT(31)
+/* Last Segment */
+#define TX_DESC_TDES1_LAST_SEG_MASK BIT(30)
+/* First Segment */
+#define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
+/* Checksum Insertion Control */
+#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 2)
+/* Disable Cyclic Redundancy Check */
+#define TX_DESC_TDES1_DIS_CDC_MASK BIT(26)
+/* Transmit End of Ring */
+#define TX_DESC_TDES1_TX_END_RING_MASK BIT(25)
+/* Secondary Address Chained */
+#define TX_DESC_TDES1_SEC_ADDR_CHND_MASK BIT(24)
+/* Transmit Buffer 2 Size */
+#define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 11)
+/* Transmit Buffer 1 Size */
+#define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 11)
+
+typedef struct NPCMGMACState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    NICState *nic;
+    NICConf conf;
+
+    uint32_t regs[NPCM_GMAC_NR_REGS];
+    uint16_t phy_regs[NPCM_GMAC_MAX_PHYS][NPCM_GMAC_MAX_PHY_REGS];
+} NPCMGMACState;
+
+#define TYPE_NPCM_GMAC "npcm-gmac"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
+
+/* Mask for RO bits in Status */
+#define NPCM_DMA_STATUS_RO_MASK(word) (word & 0xfffe0000)
+/* Mask for RO bits in Status */
+#define NPCM_DMA_STATUS_W1C_MASK(word) (word & 0x1e7ff)
+
+/* Transmit Process State */
+#define NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT 20
+/* Transmit States */
+#define NPCM_DMA_STATUS_TX_STOPPED_STATE \
+    (0b000)
+#define NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE \
+    (0b001)
+#define NPCM_DMA_STATUS_TX_RUNNING_WAITING_STATE \
+    (0b010)
+#define NPCM_DMA_STATUS_TX_RUNNING_READ_STATE \
+    (0b011)
+#define NPCM_DMA_STATUS_TX_SUSPENDED_STATE \
+    (0b110)
+#define NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE \
+    (0b111)
+/* Transmit Process State */
+#define NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT 17
+/* Receive States */
+#define NPCM_DMA_STATUS_RX_STOPPED_STATE \
+    (0b000)
+#define NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE \
+    (0b001)
+#define NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE \
+    (0b011)
+#define NPCM_DMA_STATUS_RX_SUSPENDED_STATE \
+    (0b100)
+#define NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE \
+    (0b101)
+#define NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE \
+    (0b111)
+
+
+/* Early Receive Interrupt */
+#define NPCM_DMA_STATUS_ERI BIT(14)
+/* Fatal Bus Error Interrupt */
+#define NPCM_DMA_STATUS_FBI BIT(13)
+/* Early transmit Interrupt */
+#define NPCM_DMA_STATUS_ETI BIT(10)
+/* Receive Watchdog Timout */
+#define NPCM_DMA_STATUS_RWT BIT(9)
+/* Receive Process Stopped */
+#define NPCM_DMA_STATUS_RPS BIT(8)
+/* Receive Buffer Unavailable */
+#define NPCM_DMA_STATUS_RU BIT(7)
+/* Receive Interrupt */
+#define NPCM_DMA_STATUS_RI BIT(6)
+/* Transmit Underflow */
+#define NPCM_DMA_STATUS_UNF BIT(5)
+/* Receive Overflow */
+#define NPCM_DMA_STATUS_OVF BIT(4)
+/* Transmit Jabber Timeout */
+#define NPCM_DMA_STATUS_TJT BIT(3)
+/* Transmit Buffer Unavailable */
+#define NPCM_DMA_STATUS_TU BIT(2)
+/* Transmit Process Stopped */
+#define NPCM_DMA_STATUS_TPS BIT(1)
+/* Transmit Interrupt */
+#define NPCM_DMA_STATUS_TI BIT(0)
+
+/* Normal Interrupt Summary */
+#define NPCM_DMA_STATUS_NIS BIT(16)
+/* Interrupts enabled by NIE */
+#define NPCM_DMA_STATUS_NIS_BITS (NPCM_DMA_STATUS_TI | \
+                                  NPCM_DMA_STATUS_TU | \
+                                  NPCM_DMA_STATUS_RI | \
+                                  NPCM_DMA_STATUS_ERI)
+/* Abnormal Interrupt Summary */
+#define NPCM_DMA_STATUS_AIS BIT(15)
+/* Interrupts enabled by AIE */
+#define NPCM_DMA_STATUS_AIS_BITS (NPCM_DMA_STATUS_TPS | \
+                                  NPCM_DMA_STATUS_TJT | \
+                                  NPCM_DMA_STATUS_OVF | \
+                                  NPCM_DMA_STATUS_UNF | \
+                                  NPCM_DMA_STATUS_RU  | \
+                                  NPCM_DMA_STATUS_RPS | \
+                                  NPCM_DMA_STATUS_RWT | \
+                                  NPCM_DMA_STATUS_ETI | \
+                                  NPCM_DMA_STATUS_FBI)
+
+/* Early Receive Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_ERE BIT(14)
+/* Fatal Bus Error Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_FBE BIT(13)
+/* Early transmit Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_ETE BIT(10)
+/* Receive Watchdog Timout Enable */
+#define NPCM_DMA_INTR_ENAB_RWE BIT(9)
+/* Receive Process Stopped Enable */
+#define NPCM_DMA_INTR_ENAB_RSE BIT(8)
+/* Receive Buffer Unavailable Enable */
+#define NPCM_DMA_INTR_ENAB_RUE BIT(7)
+/* Receive Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_RIE BIT(6)
+/* Transmit Underflow Enable */
+#define NPCM_DMA_INTR_ENAB_UNE BIT(5)
+/* Receive Overflow Enable */
+#define NPCM_DMA_INTR_ENAB_OVE BIT(4)
+/* Transmit Jabber Timeout Enable */
+#define NPCM_DMA_INTR_ENAB_TJE BIT(3)
+/* Transmit Buffer Unavailable Enable */
+#define NPCM_DMA_INTR_ENAB_TUE BIT(2)
+/* Transmit Process Stopped Enable */
+#define NPCM_DMA_INTR_ENAB_TSE BIT(1)
+/* Transmit Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_TIE BIT(0)
+
+/* Normal Interrupt Summary Enable */
+#define NPCM_DMA_INTR_ENAB_NIE BIT(16)
+/* Interrupts enabled by NIE Enable */
+#define NPCM_DMA_INTR_ENAB_NIE_BITS (NPCM_DMA_INTR_ENAB_TIE | \
+                                     NPCM_DMA_INTR_ENAB_TUE | \
+                                     NPCM_DMA_INTR_ENAB_RIE | \
+                                     NPCM_DMA_INTR_ENAB_ERE)
+/* Abnormal Interrupt Summary Enable */
+#define NPCM_DMA_INTR_ENAB_AIE BIT(15)
+/* Interrupts enabled by AIE Enable */
+#define NPCM_DMA_INTR_ENAB_AIE_BITS (NPCM_DMA_INTR_ENAB_TSE | \
+                                     NPCM_DMA_INTR_ENAB_TJE | \
+                                     NPCM_DMA_INTR_ENAB_OVE | \
+                                     NPCM_DMA_INTR_ENAB_UNE | \
+                                     NPCM_DMA_INTR_ENAB_RUE | \
+                                     NPCM_DMA_INTR_ENAB_RSE | \
+                                     NPCM_DMA_INTR_ENAB_RWE | \
+                                     NPCM_DMA_INTR_ENAB_ETE | \
+                                     NPCM_DMA_INTR_ENAB_FBE)
+
+/* Flushing Disabled */
+#define NPCM_DMA_CONTROL_FLUSH_MASK BIT(24)
+/* Start/stop Transmit */
+#define NPCM_DMA_CONTROL_START_STOP_TX BIT(13)
+/* Start/stop Receive */
+#define NPCM_DMA_CONTROL_START_STOP_RX BIT(1)
+/* Next receive descriptor start address */
+#define NPCM_DMA_HOST_RX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
+/* Next transmit descriptor start address */
+#define NPCM_DMA_HOST_TX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
+
+/* Receive enable */
+#define NPCM_GMAC_MAC_CONFIG_RX_EN BIT(2)
+/* Transmit enable */
+#define NPCM_GMAC_MAC_CONFIG_TX_EN BIT(3)
+
+/* Frame Receive All */
+#define NPCM_GMAC_FRAME_FILTER_REC_ALL_MASK BIT(31)
+/* Frame HPF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HPF_MASK BIT(10)
+/* Frame SAF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_SAF_MASK BIT(9)
+/* Frame SAIF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_SAIF_MASK BIT(8)
+/* Frame PCF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PCF_MASK BIT(word) extract32((word), 6, 2)
+/* Frame DBF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_DBF_MASK BIT(5)
+/* Frame PM Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PM_MASK BIT(4)
+/* Frame DAIF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_DAIF_MASK BIT(3)
+/* Frame HMC Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HMC_MASK BIT(2)
+/* Frame HUC Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HUC_MASK BIT(1)
+/* Frame PR Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PR_MASK BIT(0)
+
+#endif /* NPCM_GMAC_H */
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
new file mode 100644
index 00000000000..7118b4c7c78
--- /dev/null
+++ b/hw/net/npcm_gmac.c
@@ -0,0 +1,467 @@
+/*
+ * Nuvoton NPCM7xx/8xx GMAC Module
+ *
+ * Copyright 2024 Google LLC
+ * Authors:
+ * Hao Wu <wuhaotsh@google.com>
+ * Nabih Estefan <nabihestefan@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ *
+ * Unsupported/unimplemented features:
+ * - MII is not implemented, MII_ADDR.BUSY and MII_DATA always return zero
+ * - Precision timestamp (PTP) is not implemented.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/registerfields.h"
+#include "hw/net/mii.h"
+#include "hw/net/npcm_gmac.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "sysemu/dma.h"
+#include "trace.h"
+
+REG32(NPCM_DMA_BUS_MODE, 0x1000)
+REG32(NPCM_DMA_XMT_POLL_DEMAND, 0x1004)
+REG32(NPCM_DMA_RCV_POLL_DEMAND, 0x1008)
+REG32(NPCM_DMA_RX_BASE_ADDR, 0x100c)
+REG32(NPCM_DMA_TX_BASE_ADDR, 0x1010)
+REG32(NPCM_DMA_STATUS, 0x1014)
+REG32(NPCM_DMA_CONTROL, 0x1018)
+REG32(NPCM_DMA_INTR_ENA, 0x101c)
+REG32(NPCM_DMA_MISSED_FRAME_CTR, 0x1020)
+REG32(NPCM_DMA_HOST_TX_DESC, 0x1048)
+REG32(NPCM_DMA_HOST_RX_DESC, 0x104c)
+REG32(NPCM_DMA_CUR_TX_BUF_ADDR, 0x1050)
+REG32(NPCM_DMA_CUR_RX_BUF_ADDR, 0x1054)
+REG32(NPCM_DMA_HW_FEATURE, 0x1058)
+
+REG32(NPCM_GMAC_MAC_CONFIG, 0x0)
+REG32(NPCM_GMAC_FRAME_FILTER, 0x4)
+REG32(NPCM_GMAC_HASH_HIGH, 0x8)
+REG32(NPCM_GMAC_HASH_LOW, 0xc)
+REG32(NPCM_GMAC_MII_ADDR, 0x10)
+REG32(NPCM_GMAC_MII_DATA, 0x14)
+REG32(NPCM_GMAC_FLOW_CTRL, 0x18)
+REG32(NPCM_GMAC_VLAN_FLAG, 0x1c)
+REG32(NPCM_GMAC_VERSION, 0x20)
+REG32(NPCM_GMAC_WAKEUP_FILTER, 0x28)
+REG32(NPCM_GMAC_PMT, 0x2c)
+REG32(NPCM_GMAC_LPI_CTRL, 0x30)
+REG32(NPCM_GMAC_TIMER_CTRL, 0x34)
+REG32(NPCM_GMAC_INT_STATUS, 0x38)
+REG32(NPCM_GMAC_INT_MASK, 0x3c)
+REG32(NPCM_GMAC_MAC0_ADDR_HI, 0x40)
+REG32(NPCM_GMAC_MAC0_ADDR_LO, 0x44)
+REG32(NPCM_GMAC_MAC1_ADDR_HI, 0x48)
+REG32(NPCM_GMAC_MAC1_ADDR_LO, 0x4c)
+REG32(NPCM_GMAC_MAC2_ADDR_HI, 0x50)
+REG32(NPCM_GMAC_MAC2_ADDR_LO, 0x54)
+REG32(NPCM_GMAC_MAC3_ADDR_HI, 0x58)
+REG32(NPCM_GMAC_MAC3_ADDR_LO, 0x5c)
+REG32(NPCM_GMAC_RGMII_STATUS, 0xd8)
+REG32(NPCM_GMAC_WATCHDOG, 0xdc)
+REG32(NPCM_GMAC_PTP_TCR, 0x700)
+REG32(NPCM_GMAC_PTP_SSIR, 0x704)
+REG32(NPCM_GMAC_PTP_STSR, 0x708)
+REG32(NPCM_GMAC_PTP_STNSR, 0x70c)
+REG32(NPCM_GMAC_PTP_STSUR, 0x710)
+REG32(NPCM_GMAC_PTP_STNSUR, 0x714)
+REG32(NPCM_GMAC_PTP_TAR, 0x718)
+REG32(NPCM_GMAC_PTP_TTSR, 0x71c)
+
+/* Register Fields */
+#define NPCM_GMAC_MII_ADDR_BUSY             BIT(0)
+#define NPCM_GMAC_MII_ADDR_WRITE            BIT(1)
+#define NPCM_GMAC_MII_ADDR_GR(rv)           extract16((rv), 6, 5)
+#define NPCM_GMAC_MII_ADDR_PA(rv)           extract16((rv), 11, 5)
+
+#define NPCM_GMAC_INT_MASK_LPIIM            BIT(10)
+#define NPCM_GMAC_INT_MASK_PMTM             BIT(3)
+#define NPCM_GMAC_INT_MASK_RGIM             BIT(0)
+
+#define NPCM_DMA_BUS_MODE_SWR               BIT(0)
+
+static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] = {
+    /* Reduce version to 3.2 so that the kernel can enable interrupt. */
+    [R_NPCM_GMAC_VERSION]         = 0x00001032,
+    [R_NPCM_GMAC_TIMER_CTRL]      = 0x03e80000,
+    [R_NPCM_GMAC_MAC0_ADDR_HI]    = 0x8000ffff,
+    [R_NPCM_GMAC_MAC0_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC1_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC1_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC2_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC2_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC3_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC3_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_PTP_TCR]         = 0x00002000,
+    [R_NPCM_DMA_BUS_MODE]         = 0x00020101,
+    [R_NPCM_DMA_HW_FEATURE]       = 0x100d4f37,
+};
+
+static const uint16_t phy_reg_init[] = {
+    [MII_BMCR]      = MII_BMCR_AUTOEN | MII_BMCR_FD | MII_BMCR_SPEED1000,
+    [MII_BMSR]      = MII_BMSR_100TX_FD | MII_BMSR_100TX_HD | MII_BMSR_10T_FD |
+                      MII_BMSR_10T_HD | MII_BMSR_EXTSTAT | MII_BMSR_AUTONEG |
+                      MII_BMSR_LINK_ST | MII_BMSR_EXTCAP,
+    [MII_PHYID1]    = 0x0362,
+    [MII_PHYID2]    = 0x5e6a,
+    [MII_ANAR]      = MII_ANAR_TXFD | MII_ANAR_TX | MII_ANAR_10FD |
+                      MII_ANAR_10 | MII_ANAR_CSMACD,
+    [MII_ANLPAR]    = MII_ANLPAR_ACK | MII_ANLPAR_PAUSE |
+                      MII_ANLPAR_TXFD | MII_ANLPAR_TX | MII_ANLPAR_10FD |
+                      MII_ANLPAR_10 | MII_ANLPAR_CSMACD,
+    [MII_ANER]      = 0x64 | MII_ANER_NWAY,
+    [MII_ANNP]      = 0x2001,
+    [MII_CTRL1000]  = MII_CTRL1000_FULL,
+    [MII_STAT1000]  = MII_STAT1000_FULL,
+    [MII_EXTSTAT]   = 0x3000, /* 1000BASTE_T full-duplex capable */
+};
+
+static void npcm_gmac_soft_reset(NPCMGMACState *gmac)
+{
+    memcpy(gmac->regs, npcm_gmac_cold_reset_values,
+           NPCM_GMAC_NR_REGS * sizeof(uint32_t));
+    /* Clear reset bits */
+    gmac->regs[R_NPCM_DMA_BUS_MODE] &= ~NPCM_DMA_BUS_MODE_SWR;
+}
+
+static void gmac_phy_set_link(NPCMGMACState *gmac, bool active)
+{
+    /* Autonegotiation status mirrors link status.  */
+    if (active) {
+        gmac->phy_regs[0][MII_BMSR] |= (MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+    } else {
+        gmac->phy_regs[0][MII_BMSR] &= ~(MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+    }
+}
+
+static bool gmac_can_receive(NetClientState *nc)
+{
+    return true;
+}
+
+/*
+ * Function that updates the GMAC IRQ
+ * It find the logical OR of the enabled bits for NIS (if enabled)
+ * It find the logical OR of the enabled bits for AIS (if enabled)
+ */
+static void gmac_update_irq(NPCMGMACState *gmac)
+{
+    /*
+     * Check if the normal interrupts summary is enabled
+     * if so, add the bits for the summary that are enabled
+     */
+    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
+        (NPCM_DMA_INTR_ENAB_NIE_BITS)) {
+        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_NIS;
+    }
+    /*
+     * Check if the abnormal interrupts summary is enabled
+     * if so, add the bits for the summary that are enabled
+     */
+    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
+        (NPCM_DMA_INTR_ENAB_AIE_BITS)) {
+        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_AIS;
+    }
+
+    /* Get the logical OR of both normal and abnormal interrupts */
+    int level = !!((gmac->regs[R_NPCM_DMA_STATUS] &
+                    gmac->regs[R_NPCM_DMA_INTR_ENA] &
+                    NPCM_DMA_STATUS_NIS) |
+                   (gmac->regs[R_NPCM_DMA_STATUS] &
+                   gmac->regs[R_NPCM_DMA_INTR_ENA] &
+                   NPCM_DMA_STATUS_AIS));
+
+    /* Set the IRQ */
+    trace_npcm_gmac_update_irq(DEVICE(gmac)->canonical_path,
+                               gmac->regs[R_NPCM_DMA_STATUS],
+                               gmac->regs[R_NPCM_DMA_INTR_ENA],
+                               level);
+    qemu_set_irq(gmac->irq, level);
+}
+
+static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
+{
+    /* Placeholder. Function will be filled in following patches */
+    return 0;
+}
+
+static void gmac_cleanup(NetClientState *nc)
+{
+    /* Nothing to do yet. */
+}
+
+static void gmac_set_link(NetClientState *nc)
+{
+    NPCMGMACState *gmac = qemu_get_nic_opaque(nc);
+
+    trace_npcm_gmac_set_link(!nc->link_down);
+    gmac_phy_set_link(gmac, !nc->link_down);
+}
+
+static void npcm_gmac_mdio_access(NPCMGMACState *gmac, uint16_t v)
+{
+    bool busy = v & NPCM_GMAC_MII_ADDR_BUSY;
+    uint8_t is_write;
+    uint8_t pa, gr;
+    uint16_t data;
+
+    if (busy) {
+        is_write = v & NPCM_GMAC_MII_ADDR_WRITE;
+        pa = NPCM_GMAC_MII_ADDR_PA(v);
+        gr = NPCM_GMAC_MII_ADDR_GR(v);
+        /* Both pa and gr are 5 bits, so they are less than 32. */
+        g_assert(pa < NPCM_GMAC_MAX_PHYS);
+        g_assert(gr < NPCM_GMAC_MAX_PHY_REGS);
+
+
+        if (v & NPCM_GMAC_MII_ADDR_WRITE) {
+            data = gmac->regs[R_NPCM_GMAC_MII_DATA];
+            /* Clear reset bit for BMCR register */
+            switch (gr) {
+            case MII_BMCR:
+                data &= ~MII_BMCR_RESET;
+                /* Autonegotiation is a W1C bit*/
+                if (data & MII_BMCR_ANRESTART) {
+                    /* Tells autonegotiation to not restart again */
+                    data &= ~MII_BMCR_ANRESTART;
+                }
+                if ((data & MII_BMCR_AUTOEN) &&
+                    !(gmac->phy_regs[pa][MII_BMSR] & MII_BMSR_AN_COMP)) {
+                    /* sets autonegotiation as complete */
+                    gmac->phy_regs[pa][MII_BMSR] |= MII_BMSR_AN_COMP;
+                    /* Resolve AN automatically->need to set this */
+                    gmac->phy_regs[0][MII_ANLPAR] = 0x0000;
+                }
+            }
+            gmac->phy_regs[pa][gr] = data;
+        } else {
+            data = gmac->phy_regs[pa][gr];
+            gmac->regs[R_NPCM_GMAC_MII_DATA] = data;
+        }
+        trace_npcm_gmac_mdio_access(DEVICE(gmac)->canonical_path, is_write, pa,
+                                        gr, data);
+    }
+    gmac->regs[R_NPCM_GMAC_MII_ADDR] = v & ~NPCM_GMAC_MII_ADDR_BUSY;
+}
+
+static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NPCMGMACState *gmac = opaque;
+    uint32_t v = 0;
+
+    switch (offset) {
+    /* Write only registers */
+    case A_NPCM_DMA_XMT_POLL_DEMAND:
+    case A_NPCM_DMA_RCV_POLL_DEMAND:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Read of write-only reg: offset: 0x%04" HWADDR_PRIx
+                      "\n", DEVICE(gmac)->canonical_path, offset);
+        break;
+
+    default:
+        v = gmac->regs[offset / sizeof(uint32_t)];
+    }
+
+    trace_npcm_gmac_reg_read(DEVICE(gmac)->canonical_path, offset, v);
+    return v;
+}
+
+static void npcm_gmac_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    NPCMGMACState *gmac = opaque;
+
+    trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
+
+    switch (offset) {
+    /* Read only registers */
+    case A_NPCM_GMAC_VERSION:
+    case A_NPCM_GMAC_INT_STATUS:
+    case A_NPCM_GMAC_RGMII_STATUS:
+    case A_NPCM_GMAC_PTP_STSR:
+    case A_NPCM_GMAC_PTP_STNSR:
+    case A_NPCM_DMA_MISSED_FRAME_CTR:
+    case A_NPCM_DMA_HOST_TX_DESC:
+    case A_NPCM_DMA_HOST_RX_DESC:
+    case A_NPCM_DMA_CUR_TX_BUF_ADDR:
+    case A_NPCM_DMA_CUR_RX_BUF_ADDR:
+    case A_NPCM_DMA_HW_FEATURE:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Write of read-only reg: offset: 0x%04" HWADDR_PRIx
+                      ", value: 0x%04" PRIx64 "\n",
+                      DEVICE(gmac)->canonical_path, offset, v);
+        break;
+
+    case A_NPCM_GMAC_MAC_CONFIG:
+        break;
+
+    case A_NPCM_GMAC_MII_ADDR:
+        npcm_gmac_mdio_access(gmac, v);
+        break;
+
+    case A_NPCM_GMAC_MAC0_ADDR_HI:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        gmac->conf.macaddr.a[0] = v >> 8;
+        gmac->conf.macaddr.a[1] = v >> 0;
+        break;
+
+    case A_NPCM_GMAC_MAC0_ADDR_LO:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        gmac->conf.macaddr.a[2] = v >> 24;
+        gmac->conf.macaddr.a[3] = v >> 16;
+        gmac->conf.macaddr.a[4] = v >> 8;
+        gmac->conf.macaddr.a[5] = v >> 0;
+        break;
+
+    case A_NPCM_GMAC_MAC1_ADDR_HI:
+    case A_NPCM_GMAC_MAC1_ADDR_LO:
+    case A_NPCM_GMAC_MAC2_ADDR_HI:
+    case A_NPCM_GMAC_MAC2_ADDR_LO:
+    case A_NPCM_GMAC_MAC3_ADDR_HI:
+    case A_NPCM_GMAC_MAC3_ADDR_LO:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Only MAC Address 0 is supported. This request "
+                      "is ignored.\n", DEVICE(gmac)->canonical_path);
+        break;
+
+    case A_NPCM_DMA_BUS_MODE:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        if (v & NPCM_DMA_BUS_MODE_SWR) {
+            npcm_gmac_soft_reset(gmac);
+        }
+        break;
+
+    case A_NPCM_DMA_RCV_POLL_DEMAND:
+        /* We dont actually care about the value */
+        break;
+
+    case A_NPCM_DMA_STATUS:
+        /* Check that RO bits are not written to */
+        if (NPCM_DMA_STATUS_RO_MASK(v)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Write of read-only bits of reg: offset: 0x%04"
+                           HWADDR_PRIx ", value: 0x%04" PRIx64 "\n",
+                           DEVICE(gmac)->canonical_path, offset, v);
+        }
+        break;
+
+    default:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        break;
+    }
+
+    gmac_update_irq(gmac);
+}
+
+static void npcm_gmac_reset(DeviceState *dev)
+{
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
+
+    npcm_gmac_soft_reset(gmac);
+    memcpy(gmac->phy_regs[0], phy_reg_init, sizeof(phy_reg_init));
+
+    trace_npcm_gmac_reset(DEVICE(gmac)->canonical_path,
+                          gmac->phy_regs[0][MII_BMSR]);
+}
+
+static NetClientInfo net_npcm_gmac_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState),
+    .can_receive = gmac_can_receive,
+    .receive = gmac_receive,
+    .cleanup = gmac_cleanup,
+    .link_status_changed = gmac_set_link,
+};
+
+static const struct MemoryRegionOps npcm_gmac_ops = {
+    .read = npcm_gmac_read,
+    .write = npcm_gmac_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm_gmac_realize(DeviceState *dev, Error **errp)
+{
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&gmac->iomem, OBJECT(gmac), &npcm_gmac_ops, gmac,
+                          TYPE_NPCM_GMAC, 8 * KiB);
+    sysbus_init_mmio(sbd, &gmac->iomem);
+    sysbus_init_irq(sbd, &gmac->irq);
+
+    qemu_macaddr_default_if_unset(&gmac->conf.macaddr);
+
+    gmac->nic = qemu_new_nic(&net_npcm_gmac_info, &gmac->conf, TYPE_NPCM_GMAC,
+                             dev->id, &dev->mem_reentrancy_guard, gmac);
+    qemu_format_nic_info_str(qemu_get_queue(gmac->nic), gmac->conf.macaddr.a);
+    gmac->regs[R_NPCM_GMAC_MAC0_ADDR_HI] = (gmac->conf.macaddr.a[0] << 8) + \
+                                            gmac->conf.macaddr.a[1];
+    gmac->regs[R_NPCM_GMAC_MAC0_ADDR_LO] = (gmac->conf.macaddr.a[2] << 24) + \
+                                           (gmac->conf.macaddr.a[3] << 16) + \
+                                           (gmac->conf.macaddr.a[4] << 8) + \
+                                            gmac->conf.macaddr.a[5];
+}
+
+static void npcm_gmac_unrealize(DeviceState *dev)
+{
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
+
+    qemu_del_nic(gmac->nic);
+}
+
+static const VMStateDescription vmstate_npcm_gmac = {
+    .name = TYPE_NPCM_GMAC,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCMGMACState, NPCM_GMAC_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static Property npcm_gmac_properties[] = {
+    DEFINE_NIC_PROPERTIES(NPCMGMACState, conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm_gmac_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->desc = "NPCM GMAC Controller";
+    dc->realize = npcm_gmac_realize;
+    dc->unrealize = npcm_gmac_unrealize;
+    dc->reset = npcm_gmac_reset;
+    dc->vmsd = &vmstate_npcm_gmac;
+    device_class_set_props(dc, npcm_gmac_properties);
+}
+
+static const TypeInfo npcm_gmac_types[] = {
+    {
+        .name = TYPE_NPCM_GMAC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCMGMACState),
+        .class_init = npcm_gmac_class_init,
+    },
+};
+DEFINE_TYPES(npcm_gmac_types)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 9afceb06191..d4e1dc98389 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -38,7 +38,7 @@ system_ss.add(when: 'CONFIG_I82596_COMMON', if_true: files('i82596.c'))
 system_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
 system_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
 system_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
-system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c'))
+system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c', 'npcm_gmac.c'))
 
 system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_eth.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 387e32e1533..56057de47f3 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -467,6 +467,18 @@ npcm7xx_emc_rx_done(uint32_t crxdsa) "RX done, CRXDSA=0x%x"
 npcm7xx_emc_reg_read(int emc_num, uint32_t result, const char *name, int regno) "emc%d: 0x%x = reg[%s/%d]"
 npcm7xx_emc_reg_write(int emc_num, const char *name, int regno, uint32_t value) "emc%d: reg[%s/%d] = 0x%x"
 
+# npcm_gmac.c
+npcm_gmac_reg_read(const char *name, uint64_t offset, uint32_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx32
+npcm_gmac_reg_write(const char *name, uint64_t offset, uint32_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx32
+npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa, uint8_t gr, uint16_t val) "%s: is_write: %" PRIu8 " pa: %" PRIu8 " gr: %" PRIu8 " val: 0x%04" PRIx16
+npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]: 0x%04" PRIx16
+npcm_gmac_set_link(bool active) "Set link: active=%u"
+npcm_gmac_update_irq(const char *name, uint32_t status, uint32_t intr_en, int level) "%s: Status Reg: 0x%04" PRIX32 " Interrupt Enable Reg: 0x%04" PRIX32 " IRQ Set: %d"
+
+# npcm_pcs.c
+npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+npcm_pcs_reg_write(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+
 # dp8398x.c
 dp8393x_raise_irq(int isr) "raise irq, isr is 0x%04x"
 dp8393x_lower_irq(void) "lower irq"
-- 
2.34.1


