Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA345C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQms-00024R-8e; Fri, 24 Jul 2026 21:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTI-0006xN-QM
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:32 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTG-0000oE-UG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:32 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5bf8a2932a3so420078e0c.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940150; x=1785544950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BKCzktrYiQEBlxn5mpG34rrLG4b9oySiA6cw0F3P7Fk=;
 b=Zrqpb+s8NvfFyslIal6f7VjQSy+tqklhu0ZrPZL/6WgE4w5fJrHeHlSCyGKwRlZs7r
 2ERSddWi/GeLl8JiW68QGmt8cN+OVued+QQ5AsyCu+RzjljwNmQPVOO2hkcAqhPx5xCg
 ZuB21v+BO2BNtlZYc1u/4bT/qzm4RvmX3TrYGJwWzRzfxIsion0iQqzQCQzTCJd/bQHF
 kfBCjvHDw74LvLi36XtZIbYPk7/1SpTjXhiGtiWz47Ds5lLr/OykSR5KbRNBIxBSkUY3
 xzwWUPHymL5/X4WROCdVEb/BPMGWyJ3VXJ9fazZqrlUos3LJQ6W51SjBeupdBA2+D5i1
 wf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940150; x=1785544950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BKCzktrYiQEBlxn5mpG34rrLG4b9oySiA6cw0F3P7Fk=;
 b=M9bn4Pbtx3ur4+ueIxHJ55wsL0ZEC1vxdL61vDXoMv4R2A/Mjh9WMMF3c7UofZgLQo
 gVw1bx4tl01UzPoZUmqmalFf87D+1IVxuZoYlXw6eSOOJiHsp88egWbt5pK3tO9LOa8L
 MTbtJe0FVRrQcgp3m22WLaiT/o9wTFHfOQ7X1BALQmK1lxxo7qwWKP9edvZ030Qz9YX5
 ZDnptRB7UIqk+xXt8WhOOvpLQNMuVGTbc8ToSEGNlihmq6y3Vb43QU2sSmKr4Z000xB5
 qO9TJWacEeqqhqoQQmP3C/YshTjm8QV7nGMYx9rGdjMH72+/vj+zlTDWPYinNABtj1sG
 ey3A==
X-Gm-Message-State: AOJu0YzgFGJ6ZzQRtuiPlD6pRxLjsfghJscM7Uuea3WM8oJd/lCSo3ad
 IbKVkMoqWrDtu1AScNCpTWB3xevoOZVI3H8O04IIkjh13PzVJVqdtQV+/nuO7ntp
X-Gm-Gg: AR+sD11bvSvw/Ix/TMGxDYHeZ9XWW2TuGNA3SzyI2qmLEgNNOTOani+6ltuyKGVvLXa
 XX68hWlpSdzyPYAYhb7EnlPYAbCo+Ja1e2Hyvh0Mgto+Tpim5WJXspAV0405V09O2SCAfHKelua
 H4XkGHU9PhFMEHeOsk2LrUI4uwx5Ev7n5MrwlfjyZaTAOWGEb7iUwcpmKj4KUFMOnHTyPevDl/M
 H5/GYuj5EucutbqesAkcntIbt3HbQ3N5a7uFYCan+vZQGs1sx8UpIVp4IGswwh1/9GH4Ol8fRej
 Z3hu+wLCQm4sWXa3k3EN+G5gNe68TX54cuc0/oPMpbHrvs40PqPFXy/9cfTENws/5NWTiz9rf2+
 rSvh8gIVnzMgfa5FsypJ0hoVcG48ruBLLXxYfvHmHYw+yd5SBGc057jJ3Z/Jt8hSXcKuZtWkWgW
 dNrpteTSEL2Ng6A7RR19XbKoRtJzIEDRAH
X-Received: by 2002:a05:6122:1823:b0:5bd:fc20:1fc3 with SMTP id
 71dfb90a1353d-5c306c0fae3mr438774e0c.4.1784940149831; 
 Fri, 24 Jul 2026 17:42:29 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:29 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 07/19] hw/net/bcm2838_genet: add GENET register structs,
 part 3/4
Date: Fri, 24 Jul 2026 20:42:06 -0400
Message-ID: <20260725004219.66222-8-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

From: Sergey Kambalin <serg.oker@gmail.com>

Add the TDMA (transmit DMA ring/length-status) register layout and
field accessors, and the PHY BMCR/BMSR MII register field
definitions.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 88 ++++++++++++++++++++++++++++++++++
 include/hw/net/bcm2838_genet.h | 88 ++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 02ce3e34..3f152deb 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -146,6 +146,94 @@ FIELD(GENET_RDMA_LENGTH_STATUS, OWN,        15, 1)
 FIELD(GENET_RDMA_LENGTH_STATUS, BUFLENGTH,  16, 12)
 FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_28_31, 29, 4)
 
+REG32(GENET_TDMA_LENGTH_STATUS,             0)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_0_3,   0, 4)
+FIELD(GENET_TDMA_LENGTH_STATUS, DO_CSUM,    4, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, OW_CRC,     5, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, APPEND_CRC, 6, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_7_8,   7, 2)
+FIELD(GENET_TDMA_LENGTH_STATUS, UNDERRUN,   9, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_10_11, 10, 2)
+FIELD(GENET_TDMA_LENGTH_STATUS, WRAP,       12, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, SOP,        13, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, EOP,        14, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, OWN,        15, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, BUFLENGTH,  16, 12)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_28_31, 29, 4)
+
+REG16(GENET_PHY_BMCR,            0)
+FIELD(GENET_PHY_BMCR, RSVD_0_5,  0, 6)
+FIELD(GENET_PHY_BMCR, SPEED1000, 6, 1)
+FIELD(GENET_PHY_BMCR, CTST,      7, 1)
+FIELD(GENET_PHY_BMCR, FULLDPLX,  8, 1)
+FIELD(GENET_PHY_BMCR, ANRESTART, 9, 1)
+FIELD(GENET_PHY_BMCR, ISOLATE,   10, 1)
+FIELD(GENET_PHY_BMCR, PDOWN,     11, 1)
+FIELD(GENET_PHY_BMCR, AENABLE,   12, 1)
+FIELD(GENET_PHY_BMCR, SPEED100,  13, 1)
+FIELD(GENET_PHY_BMCR, LOOPBACK,  14, 1)
+FIELD(GENET_PHY_BMCR, RESET,     15, 1)
+
+REG16(GENET_PHY_BMSR,               0)
+FIELD(GENET_PHY_BMSR, ERCAP,        0, 1)
+FIELD(GENET_PHY_BMSR, JCD,          1, 1)
+FIELD(GENET_PHY_BMSR, LSTATUS,      2, 1)
+FIELD(GENET_PHY_BMSR, ANEGCAPABLE,  3, 1)
+FIELD(GENET_PHY_BMSR, RFAULT,       4, 1)
+FIELD(GENET_PHY_BMSR, ANEGCOMPLETE, 5, 1)
+FIELD(GENET_PHY_BMSR, RSVD_6_7,     6, 2)
+FIELD(GENET_PHY_BMSR, ESTATEN,      8, 1)
+FIELD(GENET_PHY_BMSR, _100HALF2,    9, 1)
+FIELD(GENET_PHY_BMSR, _100FULL2,    10, 1)
+FIELD(GENET_PHY_BMSR, _10HALF,      11, 1)
+FIELD(GENET_PHY_BMSR, _10FULL,      12, 1)
+FIELD(GENET_PHY_BMSR, _100HALF,     13, 1)
+FIELD(GENET_PHY_BMSR, _100FULL,     14, 1)
+FIELD(GENET_PHY_BMSR, _10BASE4,     15, 1)
+
+REG16(GENET_PHY_LPA,                           0)
+FIELD(GENET_PHY_LPA, SLCT,                     0, 5)
+FIELD(GENET_PHY_LPA, _10HALF_1000XFULL,        5, 1)
+FIELD(GENET_PHY_LPA, _10FULL_1000XHALF,        6, 1)
+FIELD(GENET_PHY_LPA, _100HALF_1000XPAUSE,      7, 1)
+FIELD(GENET_PHY_LPA, _100FULL_1000XPAUSE_ASYM, 8, 1)
+FIELD(GENET_PHY_LPA, _100BASE4,                9, 1)
+FIELD(GENET_PHY_LPA, PAUSE_CAP,                10, 1)
+FIELD(GENET_PHY_LPA, PAUSE_ASYM,               11, 1)
+FIELD(GENET_PHY_LPA, RSVD_12,                  12, 1)
+FIELD(GENET_PHY_LPA, RFAULT,                   13, 1)
+FIELD(GENET_PHY_LPA, LPACK,                    14, 1)
+FIELD(GENET_PHY_LPA, NPAGE,                    15, 1)
+
+REG16(GENET_PHY_STAT_1000,            0)
+FIELD(GENET_PHY_STAT_1000, RSVD_0_9,  0, 10)
+FIELD(GENET_PHY_STAT_1000, HALF,      10, 1)
+FIELD(GENET_PHY_STAT_1000, FULL,      11, 1)
+FIELD(GENET_PHY_STAT_1000, REMRXOK,   12, 1)
+FIELD(GENET_PHY_STAT_1000, LOCALRXOK, 13, 1)
+FIELD(GENET_PHY_STAT_1000, MSRES,     14, 1)
+FIELD(GENET_PHY_STAT_1000, MSFAIL,    15, 1)
+
+REG16(GENET_PHY_AUX_CTRL_0,              0)
+FIELD(GENET_PHY_AUX_CTRL_0, REG_ID_MASK, 0, 3)
+FIELD(GENET_PHY_AUX_CTRL_0, RSVD_3,      3, 1)
+FIELD(GENET_PHY_AUX_CTRL_0, REG_DATA,    4, 8)
+FIELD(GENET_PHY_AUX_CTRL_0, REG_ID,      12, 3)
+FIELD(GENET_PHY_AUX_CTRL_0, MISC_WREN,   15, 1)
+
+REG16(GENET_PHY_AUX_CTRL_1,           0)
+FIELD(GENET_PHY_AUX_CTRL_1, RSVD_0_3, 0, 4)
+FIELD(GENET_PHY_AUX_CTRL_1, REG_DATA, 4, 12)
+
+REG16(GENET_PHY_SHADOW,           0)
+FIELD(GENET_PHY_SHADOW, REG_DATA, 0, 10)
+FIELD(GENET_PHY_SHADOW, REG_ID,   10, 5)
+FIELD(GENET_PHY_SHADOW, WR,       15, 1)
+
+REG16(GENET_PHY_EXP_SEL,           0)
+FIELD(GENET_PHY_EXP_SEL, REG_ID,   0, 8)
+FIELD(GENET_PHY_EXP_SEL, BLOCK_ID, 8, 8)
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index b3893c2d..fedfbde0 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -22,6 +22,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_DMA_RING_CNT      17
 #define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
 
+#define BCM2838_GENET_HFB_FILTER_CNT      48
+#define BCM2838_GENET_HFB_FILTER_SIZE     128
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -169,6 +172,53 @@ typedef struct {
     uint32_t reserved_0x10D0[972];
 } BCM2838GenetRegsRdma;
 
+typedef struct {
+    uint32_t length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} BCM2838GenetTdmaDesc;
+
+typedef struct {
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    uint32_t cons_index;
+    uint32_t prod_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t flow_period;
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    uint32_t reserved_0x34[3];
+} BCM2838GenetTdmaRing;
+
+typedef struct {
+    BCM2838GenetTdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetTdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    uint32_t ring_cfg;
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t scb_burst_size;
+    uint32_t reserved_0x1050[7];
+    uint32_t arb_ctrl;
+    uint32_t priority[3];
+    uint32_t reserved_0x10D0[993];
+} BCM2838GenetRegsTdma;
+
+typedef struct {
+    uint8_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE
+        * sizeof(uint32_t)];
+    uint32_t reserved_0x6000[1792];
+    uint32_t ctrl;
+    uint32_t flt_enable[2];
+    uint32_t reserved_0x7C0C[4];
+    uint32_t flt_len[BCM2838_GENET_HFB_FILTER_CNT / sizeof(uint32_t)];
+    uint32_t reserved_0x7C4C[237];
+} BCM2838GenetRegsHfb;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -184,8 +234,45 @@ typedef struct {
     BCM2838GenetRegsUmac umac;
     uint32_t reserved_0x1000[1024];
     BCM2838GenetRegsRdma rdma;
+    BCM2838GenetRegsTdma tdma;
+    uint32_t reserved_0x6000[2048];
+    BCM2838GenetRegsHfb hfb;
 } BCM2838GenetRegs;
 
+typedef struct {
+    uint16_t bmcr;
+    uint16_t bmsr;
+    uint16_t sid1;
+    uint16_t sid2;
+    uint16_t advertise;
+    uint16_t lpa;
+    uint16_t expansion;
+    uint16_t next_page;
+    uint16_t lpa_next_page;
+    uint16_t ctrl1000;
+    uint16_t stat1000;
+    uint16_t reserved_11_12[2];
+    uint16_t mmd_ctrl;
+    uint16_t mmd_data;
+    uint16_t estatus;
+    uint16_t ecr;
+    uint16_t esr;
+    uint16_t dcounter;
+    uint16_t fcscounter;
+    uint16_t nwaytest;
+    uint16_t exp_data;
+    uint16_t srevision;
+    uint16_t exp_ctrl;
+    uint16_t aux_ctl;
+    uint16_t phyaddr;
+    uint16_t isr;
+    uint16_t imr;
+    uint16_t shd;
+    uint16_t reserved_29;
+    uint16_t rdb_addr;
+    uint16_t rdb_data;
+} BCM2838GenetPhyRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -196,6 +283,7 @@ struct BCM2838GenetState {
     AddressSpace dma_as;
 
     BCM2838GenetRegs regs;
+    BCM2838GenetPhyRegs phy_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.47.1


