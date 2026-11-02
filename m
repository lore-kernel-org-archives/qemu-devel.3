Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC9606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a0SopXCO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCf-00032B-HG; Mon, 02 Nov 2026 08:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCd-00031U-Ia
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCb-0002E6-Jk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso30575805e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626556; x=1794231356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rqTZsBajyBlowggkDfcCiu18ZNp2ZsgIs6wIp+/o/7M=;
 b=a0SopXCOnHZPohhrMit2GbssudqYPS3D6pN6iVn2Z624qjXzkY6HYDCAht6AVUGkEs
 tL5fkRUkV/vKaSMCzyNoeBzYpdZvUGz1n2Qz+HLDT5OfH569UTA6e8hEXufMAPb1FWaB
 rI1oju4kPIJ86py6gL4lcipoILJ0jKkp4mn8aapzaB0zNbTSGY32Uf42QIEVQ18JiwKR
 Q/d0UXGS/iV5AKYihtx/hqo2D1X9DaobnCkiHMfHbPV5Bc4RzvY5VqrRN1dS3ndrP/LF
 hm0PQZSx7eGj9WdpdarwdesfBoDGIEpZfHXeZYDb3ZNaAEQ/1cG9c/GYXGmB+ePRK6Rc
 OHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626556; x=1794231356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rqTZsBajyBlowggkDfcCiu18ZNp2ZsgIs6wIp+/o/7M=;
 b=OG2E+g8IciQoGBz6ltbx6OyGJeZkL4J7t7p/K5NRWL2qLp5BWGiaWBP9N94EwRPOAk
 nIbfytwhnlmQc9S+7ytIt53K9Fcv9tY6mWSgE9XIgOxuaa5euRdUOhNUZaE4liLwfXr6
 l3eQwzZF1t38jKN6SIMzUIC9UZ0MRKrpmIakFw4OfJrPvBgpgwrHsuMrDH8JyJgL7Ss/
 e/fdtT6YqeF4C8IsNEEuAqzo2JELpNYsC3v4hnuaoIRsrK1eX9Ebev0wzhJbo/e73dx1
 nRe1M2OkLxbnuU9nO+5D13jcO9h24j3qOpezezVbDCZv0pgpXiXoeZlCOIBYU/3ayUXD
 oekQ==
X-Gm-Message-State: AFq9FYIsxZtnZUVn2XBgDgPW+UAdZp5WZZlWqrLmMcTs1KZRbckwHoTo
 +jxscHqQX7zNdhjqsqlFodJPeaWoZR2IKIQFrRvLoFe35QpYQW/NnzWiB0KtNyqiut20/iR9n78
 6aXbB/1g=
X-Gm-Gg: AYBFou1e4zR688XhXB4pmDCaDKLREzdRGq5dw83YmHPdMmz1SXupbOrAb8urGNHSpFD
 TI1fYFb8GF58hXl6JIqNBje+NZpSj5ZPVWOzd/YR+W9TAFXXrcXi8lgnIp17PXzlF7qSmsWThM/
 m9znBAppKbUZlpHr2PUss+W0OdEB1tUSfKFyLtHR/fdJPmzLQ2qhc7jB2gVGcmVvtHsO32v8AUo
 Cp+GX6JCWRMCaUVE4kiDzSbW9lSpnzka87AydXOzgjCUTtB+5vZa1i9vAuZMPKMb+DZGu8grKKz
 pSsKR+wRnQLlyPpI5k4O0TbTT731XXNQONeil7SodGNxZk/Hgx0CQav6vl4Leqyd5QOYR3/Go2Y
 kn9kA7j3MUNpgXEayG+MgX1HWdElgg2gnLQ8931U1p7rvmsMjjTvOcUNKOosVrhB9IZKVcp/cNi
 ZE+75qH2cwPTYOicMhtq0HT4gvlzC18JEWEhR8q+jUTjJU5Ee3VLo1Ub7F7N8vQziOmwNLJdv4n
 Fu93wKFPzlBGEdIBU1QmMvxPx5m6sVMBfgRTi1DwrbHoliCmqdw9lmXxJH4Pml9EYxZFT0wypIM
 dir9IX2tvXPTIOOZPstkuTrzqmp+vEtBpT/NjKa3TCwPcYbrGhjv1/LfZ8cHy0gRQONBOQgRISF
 vxGthIhIrUHdODKcWvnz5Rfa5t9/or5RryYfrUAn1/st76+7W7vrSnWY=
X-Received: by 2002:a05:600c:19d2:b0:4a4:4d57:8487 with SMTP id
 5b1f17b1804b1-4ac1737c51dmr224258485e9.5.1793626556010; 
 Mon, 02 Nov 2026 05:35:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/47] hw/net/bcm2838_genet: add GENET register structs,
 part 1/4
Date: Mon,  2 Nov 2026 13:35:05 +0000
Message-ID: <20261102133547.1375701-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Add the SYS, GR_BRIDGE, EXT, INTRL0, and INTRL1 register block
layouts and the top-level BCM2838GenetRegs/BCM2838GenetState
structs, plus REG32/FIELD accessors for the revision-control and
interrupt-status registers.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-6-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h | 77 +++++++++++++++++++++++++++++++++-
 hw/net/bcm2838_genet.c         | 37 ++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 91cf1773d5f..af5e8abd2e9 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -19,7 +19,82 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MINOR         0
 
 typedef struct {
-    uint8_t stub_area[0x10000]; /* temporary stub */
+    uint32_t rev_ctrl;
+    uint32_t port_ctrl;
+    uint32_t rbuf_flush_ctrl;
+    uint32_t tbuf_flush_ctrl;
+    uint32_t reserved_0x10[12];
+} BCM2838GenetRegsSys;
+
+typedef struct {
+    uint32_t reserved_0x0[16];
+} BCM2838GenetRegsGrBridge;
+
+typedef struct {
+    uint32_t pwr_mgmt;
+    uint32_t reserved_0x4[2];
+    uint32_t rgmii_oob_ctrl;
+    uint32_t reserved_0x10[3];
+    uint32_t gphy_ctrl;
+    uint32_t reserved_0x20[24];
+} BCM2838GenetRegsExt;
+
+typedef struct {
+    uint32_t stat;
+    uint32_t set;
+    uint32_t clear;
+    uint32_t mask_status;
+    uint32_t mask_set;
+    uint32_t mask_clear;
+    uint32_t reserved_0x18[10];
+} BCM2838GenetRegsIntrl0;
+
+typedef struct {
+    uint32_t stat;
+    uint32_t set;
+    uint32_t clear;
+    uint32_t mask_status;
+    uint32_t mask_set;
+    uint32_t mask_clear;
+    uint32_t reserved_0x18[10];
+} BCM2838GenetRegsIntrl1;
+
+typedef struct {
+    uint32_t ctrl;
+    uint32_t reserved_0x4[2];
+    uint32_t status;
+    uint32_t reserved_0x10;
+    uint32_t chk_ctrl;
+    uint32_t reserved_0x18[31];
+    uint32_t ovfl_cnt;
+    uint32_t err_cnt;
+    uint32_t energy_ctrl;
+    uint32_t reserved_0xA0[5];
+    uint32_t size_ctrl;
+    uint32_t reserved_0xB8[18];
+} BCM2838GenetRegsRbuf;
+
+typedef struct {
+    uint32_t ctrl;
+    uint32_t reserved_0x4[2];
+    uint32_t bp_mc;
+    uint32_t reserved_0x10;
+    uint32_t energy_ctrl;
+    uint32_t reserved_0x18[58];
+} BCM2838GenetRegsTbuf;
+
+typedef struct {
+    BCM2838GenetRegsSys sys;
+    BCM2838GenetRegsGrBridge gr_bridge;
+    BCM2838GenetRegsExt ext;
+    uint32_t reserved_0x100[64];
+    BCM2838GenetRegsIntrl0 intrl0;
+    BCM2838GenetRegsIntrl1 intrl1;
+    uint32_t reserved_0x280[32];
+    BCM2838GenetRegsRbuf rbuf;
+    uint32_t reserved_0x400[128];
+    BCM2838GenetRegsTbuf tbuf;
+    uint32_t reserved_0x700[64];
 } BCM2838GenetRegs;
 
 struct BCM2838GenetState {
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index a20a9e7c728..7c4b036224f 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -15,10 +15,47 @@
 #include "hw/core/irq.h"
 #include "net/checksum.h"
 #include "system/dma.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/resettable.h"
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+REG32(GENET_SYS_REV_CTRL,              0)
+FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
+FIELD(GENET_SYS_REV_CTRL, MINOR_REV,   16, 4)
+FIELD(GENET_SYS_REV_CTRL, RSVD_20_23,  20, 4)
+FIELD(GENET_SYS_REV_CTRL, MAJOR_REV,   24, 4)
+FIELD(GENET_SYS_REV_CTRL, RSVD_28_31,  28, 4)
+
+REG32(GENET_INTRL_0,                0)
+FIELD(GENET_INTRL_0, SCB,           0, 1)
+FIELD(GENET_INTRL_0, EPHY,          1, 1)
+FIELD(GENET_INTRL_0, PHY_DET_R,     2, 1)
+FIELD(GENET_INTRL_0, PHY_DET_F,     3, 1)
+FIELD(GENET_INTRL_0, LINK_UP,       4, 1)
+FIELD(GENET_INTRL_0, LINK_DOWN,     5, 1)
+FIELD(GENET_INTRL_0, UMAC,          6, 1)
+FIELD(GENET_INTRL_0, UMAC_TSV,      7, 1)
+FIELD(GENET_INTRL_0, TBUF_UNDERRUN, 8, 1)
+FIELD(GENET_INTRL_0, RBUF_OVERFLOW, 9, 1)
+FIELD(GENET_INTRL_0, HFB_SM,        10, 1)
+FIELD(GENET_INTRL_0, HFB_MM,        11, 1)
+FIELD(GENET_INTRL_0, MPD_R,         12, 1)
+FIELD(GENET_INTRL_0, RXDMA_MBDONE,  13, 1)
+FIELD(GENET_INTRL_0, RXDMA_PDONE,   14, 1)
+FIELD(GENET_INTRL_0, RXDMA_BDONE,   15, 1)
+FIELD(GENET_INTRL_0, TXDMA_MBDONE,  16, 1)
+FIELD(GENET_INTRL_0, TXDMA_PDONE,   17, 1)
+FIELD(GENET_INTRL_0, TXDMA_BDONE,   18, 1)
+FIELD(GENET_INTRL_0, RSVD_19_22,    19, 4)
+FIELD(GENET_INTRL_0, MDIO_DONE,     23, 1)
+FIELD(GENET_INTRL_0, MDIO_ERROR,    24, 1)
+FIELD(GENET_INTRL_0, RSVD_25_31,    25, 4)
+
+REG32(GENET_INTRL_1,              0)
+FIELD(GENET_INTRL_1, TX_INTRS,    0, 16)
+FIELD(GENET_INTRL_1, RX_INTRS,    16, 16)
+
 
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
-- 
2.43.0


