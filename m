Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28075606A333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BN+col7n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCi-00033Q-4O; Mon, 02 Nov 2026 08:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCf-00032Z-Tl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:01 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCd-0002EV-T5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:01 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e04773687so851950f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626558; x=1794231358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7bxoxdSOc6kP06SWBT39vonpHXD3cgEZ5NM2WTAi2uE=;
 b=BN+col7nSSPiSobFXSFPYdbih3KRw8sfvqdgVcv17NU38NM0jNfr+qq4FLP7L9wO2Q
 h8qX+Yy3JCh5b0CZ8jNGMuqJ8crrpP8aqBUWMgcb5vhF+7LJfBm9tu+1M71QcswS6Ucw
 XfPWh+bH01W73QcQPd6l9/2h5brC2x5EGj96yve5MMbxfgeUEZnR8mfZtl2SktKNx54S
 1u7jrZKqrNv7+knkoM7fThmflU/rU3kXJCJJj8URN/O5ph5BjwDRkfztLE86hpHags3f
 KGdgojI3q9v5hJYm3o8OeOAb9HKSa+IM1Odhr7uMh1BwpCOJce94haeK6FKVsKWzMtoL
 XPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626558; x=1794231358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7bxoxdSOc6kP06SWBT39vonpHXD3cgEZ5NM2WTAi2uE=;
 b=m/FMSa7sOtyZAH1QQZcnb6g69CmBwXTLP49r9OcS1DSnlKkuXVJYA2jR1kU6+Tz4Z6
 AHD1V2q6xyGLuwiQzyfhUWdvN0KQ1FBM1FxMBwv8fK2+q1F9ESMqFY98PA7y+yHnlIMX
 WZezwUfmHFzZ6TIpEO2DCRR2UPf/zkXH4bJ37QnG7sPXL9MPUndRBOCddpWu+kHDZgx5
 N43ex0hnL9J0q6LVtYG6Jjv2PIXjj6znxju/lQAxh7NXdA73mRxqJcxYoVwqDpa4eCGK
 y1QkjxK/4uhBeg5mlBdeDBoLVbIgwUSt7KXbPWZmcbuRGgJAxnky7LgSxt2PqrPwd40R
 /S+g==
X-Gm-Message-State: APuU4Z990oGhhvGBKp7Ifue4psw5LCmtSF4H8gPkJaHSocCCw8TTWfol
 2WWtFn3LGFhM/jeNnAdpn/klGMTJrKrAlAtKB94iboklrSmKCTHltlpZdGnnJZ77v7HsV4fCjDF
 0aQuDpIM=
X-Gm-Gg: AYBFou3hxdV0W/y4710u3wv4w6xXBnKNfB0y6qeHt7BydkJ20ZhHV4fN0yPZ/1nMUd5
 GMdKmWpzwIKrAEs0woMQNIQAudi5PgUfjnj6AlQUwfhdfQxEeT8PTTOtWBApfWrfWZuyM8gCcVh
 BLl/aJ881HKcOdOsNXvSINA8p6VwjtiFbQOrqqBrkFGkl5fodcu3FwZ9Wccyw+ASWgBHQSPjffr
 urw8NeMT+6tsEVz8jG/lfu1IlTuE/mEDPgyUfKvT7c9Ciqadj+sYvI3AMyIngjJa9b4z11/ofSz
 clHQO1mWiOxPChgpsGf9KGmMvKqaFMmOf8OSJ3bH0zdG5NnDswGhMVLv98esYvWP8hdJM+CusNF
 pA0GR7sTdDVkZndItKdLSENRIXlPXFwBS5wQxGnnlM0x/5yJ16faDBChkYMD16hwLe5CsFZ1P7X
 NSYuedQstoVzkmclN7hBM6ycqzENzsqnmP+bKgUiJq0Nh0LoQKwwVQj8FqtRBJq/9dloXuCmM7I
 KXgX1Kcw0unWx0RbM3N8feU5cNwYUQnJncsp2rtm3MGYUbEwek0uID+7Jhyr2xCQ/pAbPsz3Wri
 Bx3TOfxAY46ZUcPfZhzFvtGdkKIIPgoqoqr6BR4ZJ3j5H0u60ZzVva5zszhFweT53m+0lBbrXLS
 ATIKvnjJYd0Kgx+op0ynugvbdpNYqZU8FsA==
X-Received: by 2002:a05:6000:26c1:b0:48e:870:7791 with SMTP id
 ffacd0b85a97d-48e6e30b824mr21151452f8f.26.1793626558167; 
 Mon, 02 Nov 2026 05:35:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/47] hw/net/bcm2838_genet: add GENET register structs,
 part 3/4
Date: Mon,  2 Nov 2026 13:35:07 +0000
Message-ID: <20261102133547.1375701-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sergey Kambalin <serg.oker@gmail.com>

Add the TDMA (transmit DMA ring/length-status) register layout and
field accessors, and the PHY BMCR/BMSR MII register field
definitions.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-8-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h | 88 ++++++++++++++++++++++++++++++++++
 hw/net/bcm2838_genet.c         | 88 ++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index b3893c2dad0..fedfbde0667 100644
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
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 3d22c28b0c1..091cd389546 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -148,6 +148,94 @@ FIELD(GENET_RDMA_LENGTH_STATUS, OWN,        15, 1)
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
-- 
2.43.0


