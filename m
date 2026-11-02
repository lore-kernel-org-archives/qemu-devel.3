Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760B60A6F6F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jO3cafqV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCh-00032y-4F; Mon, 02 Nov 2026 08:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCf-000325-9C
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCd-0002EJ-17
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2471148f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626557; x=1794231357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cYVxhRKJXxTmJpSzggwUrFWsQarrJnKSY6cYLl/kqQw=;
 b=jO3cafqV6AHplSL942iBdmvTqVcKkfDbr8LiWMu3OKfNHaWjb4XGKFICKnvNA0vRph
 BG2I8PGJkuhy9xaZw0t8osmBNEzHizLXWmq0JkIG8jIYSt9ElZXd3xnotWmfFCPZPjz3
 /J4rrV13VmS2BYaQsBanHS7vb8NO1ANjskwq96sJimBrjEwbkbmkwfhUc3Pw1n/F7Pn1
 tjS7/IgKc+cAu8LHrNp1t2H4K/5ozHYS92nmwsnzCQsRs1u70tx31uKqjwcLyerGZxhN
 bZbjdHTGoKHN+NsxTk10qdduM0vKSqjJjs05Dnd9RFF1OI39SFM+a7jSL4qXYVwVEc6J
 mGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626557; x=1794231357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cYVxhRKJXxTmJpSzggwUrFWsQarrJnKSY6cYLl/kqQw=;
 b=v0iskM1eDSQgGyGfXGSboLXEkMOMaqFt8Wl9piGX6yGWdS5PViOi7FxYf/uahVKBRC
 CvdPK4Kd476+cAxsrP33SqYlDDQvtFtCcT5SWKjZ6tSr556Stp12yinrVwA0UBHjzxn1
 j+Pcvl2vfh4d9kNLWT8fvaobaWbOSvQ+HpzfGq5uFiuG2quVpEG7oVaMfVF0Vw/qGxBC
 VO+Y+WzBLX99UWqIN+zZs2XXh6odh60zPzVYwrF9gWHBmUPdFMNR3WWUhMRK4D7abHn4
 KGv3AIMoewUniz55Eagxx2GPpe8QrRkyKBHFrrQdJnS7U+B7sHZi9wyKmbxcUomcLLC6
 sjbA==
X-Gm-Message-State: APuU4Z8KkSJ056ih3sbkhEPgniOIuTrV7EhrI550nRGVumWWqS2o3HZz
 ymq4cLHbjIV/qQ9K85ROXpBLV9x1Ill4d8c5ejUAM6lA9+1x3SKjE8+GYKWpXihSc36gKBgpfEO
 pm9OC0Cw=
X-Gm-Gg: AYBFou2kY3lyZD4DCUvO9fbupa73sz8iMxyIefVyH1NAb6bpBrCs+5mzczI9V/fHpUh
 PjrmpZap2/RHwSKUP5iuRHGf6zP2Hv3m7pXGUzQndCrgVJ5JLYby20PZHG5CrcR8TvPJ4W/zKKH
 ZaHA3UVpQ1NFVm2+vstlLyKUm8ALnSFUXUBxICEER0F9H3X5tT0K5eqNY0wagzBGcAqRgtWtcui
 RDWrnGWCiM04b4gUNQf6trKhrxAVYWxxqEvBJSBwfvqw8nM7sBwFvotmhNBeshEemX97X0KLSO/
 uTseXDGYwlt7lWc35BCo1qpOs7AksuR9Wi6cI4pFvHVbzKRuxXTs4BeJDR7C4PNdqQYZTSdAzy2
 60lC8OcSh9lHlDyUSjGZtHAT16nSZ1zHEkpeE10y8o7i2gTAAanwxPacvE/MbIEe2UxtQOiSiK3
 /QizDkc4ZlCug4qdjaD7EcH2dXzWdBp0R3PbhfOJsxid8AWdK4GBnkUHHSyTzGEaiIpDpCnxpLu
 p7JXvAnOICp+GAN199O9RZRhLYjzpS2K/hmoMQtmrIKmNvro1cFEID5/rvwaoeNAJMPFWZ6DRrd
 pCpIPhQk2u+TScnzvVlT9oDskyV7QrgQ4ixxIwyjoD1WhqCTLSRQt9A34pec2iSgE4H9xz/AWSk
 ZkJSUpRLnc4gZMX+mXPFHy70O87qria14PA==
X-Received: by 2002:a05:6000:4914:b0:48c:69b3:610f with SMTP id
 ffacd0b85a97d-48e6e5008b4mr22690628f8f.26.1793626557117; 
 Mon, 02 Nov 2026 05:35:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/47] hw/net/bcm2838_genet: add GENET register structs,
 part 2/4
Date: Mon,  2 Nov 2026 13:35:06 +0000
Message-ID: <20261102133547.1375701-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Add the UMAC (CMD, MAC address, MDIO command) and DMA (ring config,
control, producer/consumer index, status, RX descriptor
length/status) register layouts and their field accessors.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-7-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h | 89 +++++++++++++++++++++++++++++++++
 hw/net/bcm2838_genet.c         | 91 ++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index af5e8abd2e9..b3893c2dad0 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -18,6 +18,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MAJOR         6
 #define BCM2838_GENET_REV_MINOR         0
 
+#define BCM2838_GENET_DMA_DESC_CNT      256
+#define BCM2838_GENET_DMA_RING_CNT      17
+#define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -83,6 +87,88 @@ typedef struct {
     uint32_t reserved_0x18[58];
 } BCM2838GenetRegsTbuf;
 
+typedef struct {
+    uint32_t reserved_0x0;
+    uint32_t hd_bkp_ctrl;
+    uint32_t cmd;
+    uint32_t mac0;
+    uint32_t mac1;
+    uint32_t max_frame_len;
+    uint32_t pause_quanta;
+    uint32_t reserved_0x1C[10];
+    uint32_t mode;
+    uint32_t frm_tag0;
+    uint32_t frm_tag1;
+    uint32_t reserved_0x50[3];
+    uint32_t tx_ipg_len;
+    uint32_t reserved_0x60;
+    uint32_t eee_ctrl;
+    uint32_t eee_lpi_timer;
+    uint32_t eee_wake_timer;
+    uint32_t eee_ref_count;
+    uint32_t reserved_0x74;
+    uint32_t rx_ipg_inv;
+    uint32_t reserved_0x7C[165];
+    uint32_t macsec_prog_tx_crc;
+    uint32_t macsec_ctrl;
+    uint32_t reserved_0x318[6];
+    uint32_t pause_ctrl;
+    uint32_t tx_flush;
+    uint32_t rx_fifo_status;
+    uint32_t tx_fifo_status;
+    uint32_t reserved_0x340[48];
+    uint32_t mib[96];
+    uint32_t mib_ctrl;
+    uint32_t reserved_0x584[36];
+    uint32_t mdio_cmd;
+    uint32_t reserved_0x618[2];
+    uint32_t mpd_ctrl;
+    uint32_t mpd_pw_ms;
+    uint32_t mpd_pw_ls;
+    uint32_t reserved_0x62C[3];
+    uint32_t mdf_err_cnt;
+    uint32_t reserved_0x63C[5];
+    uint32_t mdf_ctrl;
+    uint32_t mdf_addr;
+    uint32_t reserved_0x658[106];
+} BCM2838GenetRegsUmac;
+
+typedef struct {
+    uint32_t length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} BCM2838GenetRdmaDesc;
+
+typedef struct {
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    uint32_t prod_index;
+    uint32_t cons_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t xon_xoff_tresh;
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    uint32_t reserved_0x34[3];
+} BCM2838GenetRdmaRing;
+
+typedef struct {
+    BCM2838GenetRdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetRdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    uint32_t ring_cfg;
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t scb_burst_size;
+    uint32_t reserved_0x1050[7];
+    uint32_t ring_timeout[17];
+    uint32_t index2ring[8];
+    uint32_t reserved_0x10D0[972];
+} BCM2838GenetRegsRdma;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -95,6 +181,9 @@ typedef struct {
     uint32_t reserved_0x400[128];
     BCM2838GenetRegsTbuf tbuf;
     uint32_t reserved_0x700[64];
+    BCM2838GenetRegsUmac umac;
+    uint32_t reserved_0x1000[1024];
+    BCM2838GenetRegsRdma rdma;
 } BCM2838GenetRegs;
 
 struct BCM2838GenetState {
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 7c4b036224f..3d22c28b0c1 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -20,6 +20,7 @@
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+/* GENET layouts */
 REG32(GENET_SYS_REV_CTRL,              0)
 FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
 FIELD(GENET_SYS_REV_CTRL, MINOR_REV,   16, 4)
@@ -56,6 +57,96 @@ REG32(GENET_INTRL_1,              0)
 FIELD(GENET_INTRL_1, TX_INTRS,    0, 16)
 FIELD(GENET_INTRL_1, RX_INTRS,    16, 16)
 
+REG32(GENET_UMAC_CMD,                  0)
+FIELD(GENET_UMAC_CMD, TX_EN,           0, 1)
+FIELD(GENET_UMAC_CMD, RX_EN,           1, 1)
+FIELD(GENET_UMAC_CMD, SPEED,           2, 2)
+FIELD(GENET_UMAC_CMD, PROMISC,         4, 1)
+FIELD(GENET_UMAC_CMD, PAD_EN,          5, 1)
+FIELD(GENET_UMAC_CMD, CRC_FWD,         6, 1)
+FIELD(GENET_UMAC_CMD, PAUSE_FWD,       7, 1)
+FIELD(GENET_UMAC_CMD, RX_PAUSE_IGNORE, 8, 1)
+FIELD(GENET_UMAC_CMD, TX_ADDR_INS,     9, 1)
+FIELD(GENET_UMAC_CMD, HD_EN,           10, 1)
+FIELD(GENET_UMAC_CMD, SW_RESET_OLD,    11, 1)
+FIELD(GENET_UMAC_CMD, RSVD_12,         12, 1)
+FIELD(GENET_UMAC_CMD, SW_RESET,        13, 1)
+FIELD(GENET_UMAC_CMD, RSVD_14,         14, 1)
+FIELD(GENET_UMAC_CMD, LCL_LOOP_EN,     15, 1)
+FIELD(GENET_UMAC_CMD, RSVD_16_21,      16, 6)
+FIELD(GENET_UMAC_CMD, AUTO_CONFIG,     22, 1)
+FIELD(GENET_UMAC_CMD, CNTL_FRM_EN,     23, 1)
+FIELD(GENET_UMAC_CMD, NO_LEN_CHK,      24, 1)
+FIELD(GENET_UMAC_CMD, RMT_LOOP_EN,     25, 1)
+FIELD(GENET_UMAC_CMD, RX_ERR_DISC,     26, 1)
+FIELD(GENET_UMAC_CMD, PRBL_EN,         27, 1)
+FIELD(GENET_UMAC_CMD, TX_PAUSE_IGNORE, 28, 1)
+FIELD(GENET_UMAC_CMD, TX_RX_EN,        29, 1)
+FIELD(GENET_UMAC_CMD, RUNT_FILTER_DIS, 30, 1)
+FIELD(GENET_UMAC_CMD, RSVD_31,         31, 1)
+
+REG32(GENET_UMAC_MAC_0,         0)
+FIELD(GENET_UMAC_MAC_0, ADDR_3, 0,  8)
+FIELD(GENET_UMAC_MAC_0, ADDR_2, 8,  8)
+FIELD(GENET_UMAC_MAC_0, ADDR_1, 16, 8)
+FIELD(GENET_UMAC_MAC_0, ADDR_0, 24, 8)
+
+REG32(GENET_UMAC_MAC_1,             0)
+FIELD(GENET_UMAC_MAC_1, ADDR_5,     0,  8)
+FIELD(GENET_UMAC_MAC_1, ADDR_4,     8,  8)
+FIELD(GENET_UMAC_MAC_1, RSVD_16_31, 16, 8)
+
+REG32(GENET_UMAC_MDIO_CMD,             0)
+FIELD(GENET_UMAC_MDIO_CMD, REG_DATA,   0, 16)
+FIELD(GENET_UMAC_MDIO_CMD, REG_ID,     16, 5)
+FIELD(GENET_UMAC_MDIO_CMD, PHY_ID,     21, 5)
+FIELD(GENET_UMAC_MDIO_CMD, WR,         26, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RD,         27, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RD_FAIL,    28, 1)
+FIELD(GENET_UMAC_MDIO_CMD, START_BUSY, 29, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RSVD_30_31, 30, 2)
+
+REG32(GENET_DMA_RING_CFG,             0)
+FIELD(GENET_DMA_RING_CFG, EN,         0, 17)
+FIELD(GENET_DMA_RING_CFG, RSVD_17_31, 17, 14)
+
+REG32(GENET_DMA_CTRL,              0)
+FIELD(GENET_DMA_CTRL, EN,          0, 1)
+FIELD(GENET_DMA_CTRL, RING_BUF_EN, 1, 17)
+FIELD(GENET_DMA_CTRL, RSVD_18_19,  18, 2)
+FIELD(GENET_DMA_CTRL, TSB_SWAP_EN, 20, 1)
+FIELD(GENET_DMA_CTRL, RSVD_21_31,  21, 11)
+
+REG32(GENET_DMA_PROD_INDEX,              0)
+FIELD(GENET_DMA_PROD_INDEX, INDEX,       0, 16)
+FIELD(GENET_DMA_PROD_INDEX, DISCARD_CNT, 16, 16)
+
+REG32(GENET_DMA_CONS_INDEX,             0)
+FIELD(GENET_DMA_CONS_INDEX, INDEX,      0, 16)
+FIELD(GENET_DMA_CONS_INDEX, RSVD_16_31, 16, 16)
+
+REG32(GENET_DMA_STATUS,                     0)
+FIELD(GENET_DMA_STATUS, DISABLED,           0, 1)
+FIELD(GENET_DMA_STATUS, DESC_RAM_INIT_BUSY, 1, 1)
+FIELD(GENET_DMA_STATUS, RSVD_2_31,          2, 30)
+
+#define GENET_DMA_ENABLE_MASK ((1U << 18) - 1)
+
+REG32(GENET_RDMA_LENGTH_STATUS,             0)
+FIELD(GENET_RDMA_LENGTH_STATUS, OVERRUN,    0, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, CRC_ERROR,  1, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, RXERR,      2, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, NO,         3, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, LG,         4, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, MULTICAST,  5, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, BROADCAST,  6, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_7_11,  7, 5)
+FIELD(GENET_RDMA_LENGTH_STATUS, WRAP,       12, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, SOP,        13, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, EOP,        14, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, OWN,        15, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, BUFLENGTH,  16, 12)
+FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_28_31, 29, 4)
 
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
-- 
2.43.0


