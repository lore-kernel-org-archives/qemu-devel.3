Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD118C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvg-0001bV-7Y; Thu, 15 Oct 2026 14:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvW-0001R8-BM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:38 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvT-0001Uc-H0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:37 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-53606d2351aso18292361cf.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087894; x=1792692694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0QOAyRwe4/bt3bQDCy6W5zVkYCsMuZ0faJBwW6eD+5s=;
 b=dZFUrUXUL9EepU/yUnNL0daGEXtr+4aXgpWU+FoandyIC45qSWA2ixcUBKz+2AMtaE
 kyEXJgOxAmR/74OG8BnxgdC42aWWfps6w1KkH2xeb1q4R2NPEB5sar7OtAzqTFgulZLn
 IxF+vFliIORRDNLadf8OD3gmAuRqhBflaNeCyddYR7cv/H3mtpJ9eC2pkxCzZgq7pK19
 FJBFwFrZtvuz/eyK8TevVRIu75N4DDO+QPRxqVVDt7KESZTTccbCOOl3+UWefXVMot3G
 i1y3lBJLfljbN5a/KMuLQ+4awInaFVITpoAx5E68Im3D5chj7ZGwMaKyIHn0vD7Z1Ejc
 yj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087894; x=1792692694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0QOAyRwe4/bt3bQDCy6W5zVkYCsMuZ0faJBwW6eD+5s=;
 b=04OxNbaf5Pf21cs3TiSf7ms1B0ITeW7h8eZxdZzoCkukBnWb08HcfWX3QyiPHWw3VH
 KJ3EzOtGHg2vS9SA69GUmeG0ow3KdUcOUjQG2sKeFM6F6rBldBpb7Co6NfMSbsi3PX7D
 Ys/Q18vyuU2N0/rpU2fV+E96Q26qFv2skbH53htILlwW8ncV2a420HcaYKS4yq9an3Aj
 cye0lDiP0WttwuT0kBJJRb60dUROtmUfdgs9s0LS3NHoaqHMeMPldkaT1KNiRxsZEKJC
 MlThaNT1Rned/S1Xbm37tlBUTco3olUdfN468wMKbBQX/8uowhUKUS3TolQvcg/8NSl/
 mwqA==
X-Gm-Message-State: AFq9FYIBE+7MShv9bzD3jO9wHv/5udMRkVP1PVnUK3o7JJqxILkejL7G
 xl1QZ4WD38L5sTvxN7mFaMvQNiT0tOC/YHxpQ5FcM7X1pqCSMoP7jh2+lIL8dX2s
X-Gm-Gg: AYBFou3z8kbjwhXiB5v7OdTJAb9miOfUacynopEtbcdgAsheC0q91qrBip9721oC62m
 Bm6l/Pvmmu1KcvKGFjiWU1YifyjPSlmHS1oZthvi5eRDjTNOT53iLMWgsSsg7/E3WGX4ZqwW22n
 KwrUlqSnSExrGW5aawO9gh51SPo6lqXawTkZgi1UdEdLxaYYbQMEaqpy47v4baFWkqH7PuYnpOy
 0cqdxTzqA6+xktrTsnn626DUMgzsPuQXobnx3Xp+PmAnhtrwUYyAb6nt506S0Bk50h7yufsTnM7
 vaEuk/yEuU7o6ohUmpsWMuV6prMj5CaaThZ/DoEjoZjEXuVd4nBoVeY5zVBK3mI/NhhWKjVbUxa
 xMUyDZ/73VmsagX/aIX7la7QSp9jnWHVmwsjX/fjF8Eo4j1olMFgDO1qNW1GjZ3qLebfnnIAFVw
 iwpHAfojf/W21JrbFfQoWzIqHnOhNF9cndHoCynk2wxmEAay+E1rbX2Vy1jCCxJ5muRFDD/1XU4
 yPXai+CTkeFo7qtlBwwkOa5RkCuqJyasCrB5CPNYe6VNGdgJnTn47U0TtnmMv/77tcfRWBbbBj3
 XJ0K
X-Received: by 2002:ac8:5d8e:0:b0:535:863a:7cd5 with SMTP id
 d75a77b69052e-5359fba2498mr336773771cf.41.1792087894305; 
 Thu, 15 Oct 2026 11:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:33 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v3 08/16] hw/net/bcm2838_genet: add GENET register structs,
 part 4/4
Date: Thu, 15 Oct 2026 14:11:13 -0400
Message-ID: <20261015181122.60608-9-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x832.google.com
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

Add the PHY "shadow" register structs (BCM54213PE PHY-specific
clock control, RGMII mode, LED, and expansion-block registers
accessed via the AUX_CTL/EXP_SHD indirection scheme) used by the
MDIO emulation added in a later patch.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 include/hw/net/bcm2838_genet.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index fedfbde066..12439b580d 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT   256
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -273,6 +279,34 @@ typedef struct {
     uint16_t rdb_data;
 } BCM2838GenetPhyRegs;
 
+typedef struct {
+    uint16_t reserved_0_2[3];
+    uint16_t clk_ctl;
+    uint16_t scr2;
+    uint16_t scr3;
+    uint16_t reserved_6_9[4];
+    uint16_t apd;
+    uint16_t rgmii_mode;
+    uint16_t reserved_12;
+    uint16_t leds1;
+    uint16_t reserved_14_18[5];
+    uint16_t _100fx_ctrl;
+    uint16_t ssd;
+    uint16_t reserved_21_30[10];
+    uint16_t mode;
+} BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t auxctl;
+    uint16_t reserved_1_6[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE - 2];
+    uint16_t misc;
+} BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -284,6 +318,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.55.0


