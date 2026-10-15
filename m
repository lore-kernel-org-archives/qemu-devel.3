Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98414CCA469
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvl-0001j2-Nq; Thu, 15 Oct 2026 14:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvR-0001Na-Na
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:33 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvP-0001TG-Sd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:33 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-53391786e55so90474091cf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087890; x=1792692690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8dqvNJcBO5G3C8arG6Z3cNAj55zuZVNPHk34qUIJ7e4=;
 b=qbjl9gRhZ2MRaY8T4TPmTsXmaflnFEkh0G5qktVAJYNmYCKCPPSdKpBCjBMc3PJsNa
 z9eE2Z2F2XJCBQmd3TSQGQ4WnSem2v/uDK2KkaQULlROj177e3rPFx5txM6HEECz96xD
 S5NTaKXk3Pf/GNrhvWBn/UFTqCb06SE5jRiLjREC+c6yvW/ng6/Qv6PFlteTpSkQu3Gf
 myN3fcTvl7zlPov73XfoVK86FfSHGQhaBBZK2kQDCBW8s3wAhAd9ThRBbT271FsHKA0Q
 P2Z4NpdRDxnl55ZHBocKz3SVkZorho43BAQF+jI4QwT1yOcPwOzlNvPf0iimP5fBUYDN
 01Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087890; x=1792692690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8dqvNJcBO5G3C8arG6Z3cNAj55zuZVNPHk34qUIJ7e4=;
 b=Cd8YZtjmnH57SaD7ljr7BE7oUIZWd8tk3C+6Qlv8jA+fyqrUVREo3f876wadU6y+RH
 hrwmR73S6NTA9X33SxJtLL7n2QLevfmbI+r6F7+mpzKHvitkRUxB94uTa4BRrWnV6rhW
 WbWUdgG1dSKimdFzLwUbNE3BYf7rzd6GKLqU4m+w09OZBAivVysSWM/fPLeM9ES0J5L8
 /zVE5n/46nhfLEq0OgUTzNCNRxqwHETMhllUkS4esKBQWJcifNtZtabUr+Rd0ThLWeSS
 2+KcgCRtzGNIybjIOFkKRvLNGgWDgCQb/92+LjDLgcQ1YWQwYdeVY4aiz6m6EuNnLXKb
 wydg==
X-Gm-Message-State: AFq9FYLYPL3lzz0v+DIt42FZI2Tmr5kPgIqhTNWOwfiV4IbdsSt+7eYL
 dhGfsFnSgW6Fhi03hKpvplmEac2g+g8liqKwXkuvXJtENp9kk3HlKdrVaLia1yOV
X-Gm-Gg: AYBFou0+I8IVXQ1ZQlZ8YwI5egCbqXaoapPlufTtgnbBm9cEXjKsq7ilNJXC6YUz6tE
 HQLjQoQhnmzQ3AZtWO7ordj+ml2YMxcbyyA6CE2Qcc5JvC8J9P54odVORlbVeFunSuXvqAOYoeG
 9mdWFc4xUV+XwYu2+bV3QK3hYabaDG+XxrdXiOkuJJ2TavBrzuB7Np/0evxxsloBdGqMfv9wKMz
 t0C8/y/58CsqV5ljqwrsA1UvtiCfqjhiinF2sstOrvnz05PD9nW7/ZtyPnUhLVBZtbB7PGX9ILK
 VnoNDzwAkh3meGjGlPJ/ZRNWdXCVV7jwIpx7xRkeLUclDOqDWD5Sowgp59wYTWQPz4rh3xiMt/j
 4UVwwoHgVlFmA7iZcL/uegilRbV4HEbm/dzrK5HofCSdc1C3nJB8AfcfWjCskTrviysq2Fc8Wcv
 H6E16X0VcHqV0w1aMooU3Z948ExwSEVdQ8xcm8tCXBChPHZakPdd8b9e7ofjBKaxXKHs/IqXYIR
 vEnZvAyqUbGwxAC2IHCeNx3fqFn79D2Y/Jlu7rY/+xFUE84pKLKgMgCSw5rMinpsRHUzuo=
X-Received: by 2002:ac8:5f4b:0:b0:533:43b1:5610 with SMTP id
 d75a77b69052e-5359fae165emr352125261cf.21.1792087890570; 
 Thu, 15 Oct 2026 11:11:30 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:30 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v3 05/16] hw/net/bcm2838_genet: add GENET register structs,
 part 1/4
Date: Thu, 15 Oct 2026 14:11:10 -0400
Message-ID: <20261015181122.60608-6-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/net/bcm2838_genet.c         | 37 ++++++++++++++++
 include/hw/net/bcm2838_genet.h | 77 +++++++++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 2ff93a3417..ff6602c1f3 100644
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
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 91cf1773d5..af5e8abd2e 100644
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
-- 
2.55.0


