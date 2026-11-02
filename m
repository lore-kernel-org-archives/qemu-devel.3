Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA65606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ozTZZyPb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCl-00035R-Qb; Mon, 02 Nov 2026 08:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCk-00034N-CX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCi-0002FT-CU
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1266546f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626563; x=1794231363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ctZEEjNKdgKrmdMNM18EHpCNy2xDOdaKAIaDyiY0I0s=;
 b=ozTZZyPbraPWyl5KNy35eRLJeQbhUhEPlrNG9KYm2hLKFEo+eKI5B5moct1Yrn9CI7
 jbmgUd+QXHd2aHBHPi66uDlUIrhUoimdsIPcJnn2xw26HolfcVGxtV3cEB33VYJ+9jAU
 zkX2B+gRdHXxsyAn0Yd1+LR4UoIzEO/DpvSsJ8aIgEU+gJI7jDOsTKQJhJkHG4G/Kusa
 mdfCLhYml/VIqC0NqclqMYv+k/7h9GmeRWBlqXJFlgJmXFdYJGvPd5DGFPK0sRxZt8tT
 H3cR+h+i9Pgi45t4FzuyLJSLAR/Fr/qxazX9xuNkTgHqpOVkulmKJxOsjnasB1/h6Skv
 OBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626563; x=1794231363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ctZEEjNKdgKrmdMNM18EHpCNy2xDOdaKAIaDyiY0I0s=;
 b=WIbAav74kyonSUXZdlMMnrikhlshn2y98Vrwmhz6rhGMkaAhBWIiTA8XTxCqKtq7Lf
 qAajBGXt+tLVWKb8gd5qstVsgUpMjKuut1JdIdJpF4ISDhHX0q2RjLgCsYfh8CU01VYD
 YIFqCKrC+ijMu9EH44cOVVr0CoM3jicE1BinUVp4WeKcE5AZjLDvvThTVsMFaRl0iCiK
 mwntMhieqCtftM2LOYYda/ZhQCBwkPLcw2LbbDFcab6z+trp9llKl7l7rC34iVnWsvtB
 mP0r+7YcVIIUpyqGyB1dqcfKpiQa8Fq0eKLF52HWEQSTD43M7O5+/RdFTPXhlaVfSqPV
 r9bg==
X-Gm-Message-State: APuU4Z/b5hTglM1q/3zGgj29tCuZRqXemR6JgAW8eQTtmirHpGHsM491
 7qvhUPb8/IIg6D8OFv+9rZ88eONqKZmZkSG5mkpSUjHtTv6UfH+dYHveoUx65xKWCgRCurSw532
 7n7wQ2i0=
X-Gm-Gg: AYBFou3HH/xG7XXBT9UFfuNnli33mRvfXx7HTVrkkp/3AbOMmIv+8tKgFqEztLbPzcn
 mefz4c6sOsWuCC9QOCrWB6ZFPly8/AHppfBbuUKwUyT06dMcsz0Yttkvd2C44NCubNe4Ek4nl65
 CCt6PB94cuEb6bWdkYQImBffTxDqYYqOcIHJAeEvW6IBIjyoj96lyfOlJlXP7v/pGHeu9DVO0/c
 5f7Fu635ssi6Mt9dak7RPMTLNdfhFp0bqGmuAhiQY8dZBpQla7UzbRPjIxCyza2/qRYb7Z79PuU
 A46OJG+saY3bb70pUlRS34aFY+WWN+KFkfjOQSb6mnXSY4nUCzKLEViPVgy+NX16y5dj0F/vGMY
 A5VWMUEi9epMFqvmB0bvFKivTaz1VRwC/QArIyh6dd+f1bxMvbaU/xd49+lYX+wlh32Wdjpqz5t
 nsdbHaS4GdcsraVqh440y4ZYTCCKTJEKJmSEsPFXLbZ+q8pJxuadbiLDoS5Ad4MOQRFSO3/ggAV
 NI0ysbs/QzOm7w72rUlj6byIGRcMFxR17Q1W5MDkIkR/hVHJWl7xeYk714sp1e4BtuDiL6DdXXZ
 vS66hUpXerdaereo2eHwixIlw+Mr65T2kBKqPqpCFtAfY8CQS3LzExrx3LPBMbMc4UVTc8x6nz6
 gMrG0yXRAJyzhs3GMYzNdAkGuRKVZDwxvAw==
X-Received: by 2002:a05:6000:40dc:b0:48e:412:3829 with SMTP id
 ffacd0b85a97d-48e6e3071f9mr23181560f8f.15.1793626562729; 
 Mon, 02 Nov 2026 05:36:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/47] hw/net/bcm2838_genet: implement GENET MDIO
Date: Mon,  2 Nov 2026 13:35:11 +0000
Message-ID: <20261102133547.1375701-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Implement the MDIO command register handling used to read/write the
BCM54213PE PHY's standard MII registers (BMCR, BMSR, LPA, ...) plus
its vendor "shadow" register blocks reached through the AUX_CTL/
EXP_SHD indirection scheme, and a simple link-state model (PHY
starts down, comes up once BMCR is programmed and autonegotiation
is (re)started).

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

While carrying this forward, fix the autonegotiation-restart handling
in bcm2838_genet_mdio_cmd(): the guest PHY driver sets BMCR.ANRESTART
and polls BMCR until it reads back as cleared, but the result of
FIELD_DP16() (which returns a new value rather than modifying its
argument) was discarded, so the bit never cleared and the guest
spun forever at boot.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-12-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h |   3 +-
 hw/net/bcm2838_genet.c         | 138 ++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index ee240213aa9..94ac457c04f 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -103,7 +103,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_EXP_DATA          BCM2838_GENET_PHY_REG(exp_data)
 #define BCM2838_GENET_EXP_SEL           BCM2838_GENET_PHY_REG(exp_ctrl)
 
-#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_AUXCTL    0x0
+#define BCM2838_GENET_PHY_AUX_CTL_MISC      0x7
 #define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
 
 #define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 1d443e06c12..7d8270ab048 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -216,6 +216,7 @@ FIELD(GENET_PHY_STAT_1000, LOCALRXOK, 13, 1)
 FIELD(GENET_PHY_STAT_1000, MSRES,     14, 1)
 FIELD(GENET_PHY_STAT_1000, MSFAIL,    15, 1)
 
+/* There are two data representations for PHY_AUX_CTRL register */
 REG16(GENET_PHY_AUX_CTRL_0,              0)
 FIELD(GENET_PHY_AUX_CTRL_0, REG_ID_MASK, 0, 3)
 FIELD(GENET_PHY_AUX_CTRL_0, RSVD_3,      3, 1)
@@ -272,6 +273,135 @@ static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
     qemu_set_irq(s->irq_prio, level);
 }
 
+static void bcm2838_genet_phy_aux_ctl_write(BCM2838GenetState *s,
+                                            uint16_t value)
+{
+    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID);
+    uint16_t reg_id_mask = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID_MASK);
+    uint16_t misc_wren = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, MISC_WREN);
+    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_DATA);
+    uint16_t reg_data12 = FIELD_EX16(value, GENET_PHY_AUX_CTRL_1, REG_DATA);
+
+    uint16_t *phy_aux_ctl_shd_reg_id =
+        &s->phy_aux_ctl_shd_regs.regs[reg_id];
+    uint16_t *phy_aux_ctl_shd_reg_id_mask =
+        &s->phy_aux_ctl_shd_regs.regs[reg_id_mask];
+
+    if (reg_id_mask == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+        if (reg_id == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+            if (misc_wren == 0) {
+                /* write for subsequent read (8-bit from AUX_CTL_MISC) */
+                FIELD_DP16(value, GENET_PHY_AUX_CTRL_0, REG_DATA,
+                          *phy_aux_ctl_shd_reg_id);
+            } else {
+                /* write the 8-bit REG_DATA field to AUX_CTL_MISC */
+                *phy_aux_ctl_shd_reg_id_mask = reg_data;
+            }
+        } else {
+            /* write for subsequent read (12-bit) */
+            FIELD_DP16(value, GENET_PHY_AUX_CTRL_1, REG_DATA,
+                      *phy_aux_ctl_shd_reg_id);
+        }
+    } else {
+        /* write 12 bits */
+        *phy_aux_ctl_shd_reg_id_mask = reg_data12;
+    }
+
+    s->phy_regs.aux_ctl = value;
+}
+
+static void bcm2838_genet_phy_shadow_write(BCM2838GenetState *s,
+                                           uint16_t value)
+{
+    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_SHADOW, REG_ID);
+    uint16_t wr = FIELD_EX16(value, GENET_PHY_SHADOW, WR);
+    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_SHADOW, REG_DATA);
+
+    uint16_t *phy_shd_reg = (uint16_t *)&s->phy_shd_regs + reg_id;
+
+    if (wr == 0) {
+        FIELD_DP16(value, GENET_PHY_SHADOW, REG_DATA, *phy_shd_reg);
+    } else {
+        *phy_shd_reg = reg_data;
+    }
+
+    s->phy_regs.shd = value;
+}
+
+static void bcm2838_genet_phy_exp_shadow_write(BCM2838GenetState *s,
+                                               uint16_t value)
+{
+    /*
+     * TODO Stub implementation without side effect,
+     * just storing registers values
+     */
+    uint16_t reg_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                 GENET_PHY_EXP_SEL, REG_ID);
+    uint16_t block_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                   GENET_PHY_EXP_SEL, BLOCK_ID);
+
+    assert(block_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs));
+    assert(reg_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs[0]));
+    s->phy_exp_shd_regs.regs[block_id][reg_id] = value;
+}
+
+static uint16_t bcm2838_genet_phy_exp_shadow_read(BCM2838GenetState *s)
+{
+    uint16_t reg_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                 GENET_PHY_EXP_SEL, REG_ID);
+    uint16_t block_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                   GENET_PHY_EXP_SEL, BLOCK_ID);
+
+    assert(block_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs));
+    assert(reg_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs[0]));
+    return s->phy_exp_shd_regs.regs[block_id][reg_id];
+}
+
+static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
+{
+    uint32_t phy_reg_id = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, REG_ID);
+    uint32_t phy_reg_data = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA);
+    uint32_t start_busy = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, START_BUSY);
+    uint32_t rd = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, RD);
+    uint32_t wr = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, WR);
+    uint16_t *phy_reg = (uint16_t *)&s->phy_regs + phy_reg_id;
+
+    uint16_t anrestart = FIELD_EX16(phy_reg_data, GENET_PHY_BMCR, ANRESTART);
+
+    if (start_busy != 0) {
+        cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, START_BUSY, 0);
+
+        if (rd != 0) {
+            if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA,
+                                 bcm2838_genet_phy_exp_shadow_read(s));
+            } else {
+                cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA, *phy_reg);
+            }
+        } else if (wr != 0) {
+            if (phy_reg_id == BCM2838_GENET_PHY_AUX_CTL) {
+                bcm2838_genet_phy_aux_ctl_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_PHY_SHD) {
+                bcm2838_genet_phy_shadow_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                bcm2838_genet_phy_exp_shadow_write(s, phy_reg_data);
+            } else {
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR) {
+                    /* Initiate auto-negotiation once it has been restarted */
+                    if (anrestart == 1) {
+                        phy_reg_data = FIELD_DP16(phy_reg_data,
+                                                  GENET_PHY_BMCR,
+                                                  ANRESTART, 0);
+                    }
+                }
+                *phy_reg = phy_reg_data;
+            }
+        }
+    }
+
+    return cmd;
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -364,10 +494,13 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
         s->regs.rdma.status = (~value) & GENET_DMA_ENABLE_MASK;
         break;
     case BCM2838_GENET_UMAC_MDIO_CMD:
+        value = bcm2838_genet_mdio_cmd(s, value);
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, MDIO_DONE, 1);
+        break;
     case BCM2838_GENET_TDMA_REGS
         ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-        qemu_log_mask(LOG_UNIMP,
-            "UMAC MDIO and TDMA aren't implemented yet");
+        qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
         break;
     default:
         break;
@@ -463,6 +596,7 @@ static void bcm2838_genet_reset(Object *obj, ResetType type)
 
     trace_bcm2838_genet_reset("done");
 
+    bcm2838_genet_set_qemu_mac(s);
     bcm2838_genet_phy_reset(s);
 }
 
-- 
2.43.0


