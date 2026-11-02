Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A998606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aaonK5va
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCi-00033g-FN; Mon, 02 Nov 2026 08:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCg-00032u-Tk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:02 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCe-0002Eh-Sd
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:02 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2436206f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626559; x=1794231359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eoGN1+L5+D79s5IndXi8yyjWOSaGlE6ZCnvWGyIBPCw=;
 b=aaonK5vaMs3BaymqutV03SYzFF9cPKo878Ibyg+kgbZ+wGMnTrM5GindTXgA0kQ7sW
 MM/aGLEIDvh8kCREFDtktDHrgYwWSlwBcN2m24cvWiTHP4WZAqAssg52doU7mtrx9UrC
 r8IPOrK3V1RO/ZYxyChYn8zoy980liVtelQ9v1iNKVAMvEA+a4qTlsfsE0qtSP+2amYC
 eGziQt06hc9lkq9bxokR4yxBn2nBFQ6EGz6OcTpvGxuy9Ycy18bDGlmY6P3qNT2IBB0s
 uLxoNPjwagOXQMUXm4XHxDI3FFULwJxQc7SO4G8v2b3t4vDQeN9zKBN8iurWaU584QiB
 1x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626559; x=1794231359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eoGN1+L5+D79s5IndXi8yyjWOSaGlE6ZCnvWGyIBPCw=;
 b=cO7Wi1DWXCew08kVY0r16szNdM9i9qeMIpiOuK3YpdPiDezOmdxa2TipsvwZirp43s
 e68OidD5byR1oI3Eohq4A8Q2UzYo3Kp0ZBZOSFi4NHGvEwovnC4icIfk5AFqxaWoaLyu
 xoriTmrEowEgS1/5JS2U8QvGCKXgBnT69GQU+MrGkeUTiju4LjhuvYDy0iagzp5LdfYD
 yOpb/4dvpQkRLIjIk7QK+hY9hKgTxSU7ecdvmOdK78KQh9L2qJOR5Ka1Qz7rAckAvy8U
 AYDi7yRfVnjZ72lanxiKTEKEPjyl2RdDAlXILouJEDA+gqV2NnRSAZ50fgcvTODo0LaB
 cufQ==
X-Gm-Message-State: APuU4Z80imo9JAoGEW2YryPrzAhtiu0CkBHQ8uPNenjUFqkMmkS7r8qr
 hHgvNy7YLD2Tv+3Ec1sR1xt8UbqSFhsunUCcxN02X5QHz5hL3Y9//KM/3iu5ipc+Yqm4ghBbIYg
 09p4seVQ=
X-Gm-Gg: AYBFou0wztpOnHaHeqrzZ2jVZA0Js0dl9s8vzFobdFOLuQPQbvONAHOlEcPDI/HFrwG
 p9MoMTSdGErYMWSqz6IvCWMW8EAQ+lDeV0+C18gmCSfGRbSeudP9BzbtTUaHnyNcdgJiA7oJzHD
 nIp54vQHUyasBv6tveXA18dDb8w8TDdOOYH3FSGndNnBoI/n1I5K7Tb7ECuI599A7rm6jbo+v3G
 eUbXMXlwumgY+hhbsIEwJjKf3QFJJdVB2je54mbTxiBs/4q9lkNjcl+x9xN5Tg5msyNYhVg0kPg
 SoKhYd6XhMHB+PuXyZYcBYnyOw+Ve1veh4muZfv7XJ3qwSN6hMuQWUJDWLGWnImmaJ3jmp6Dh8J
 VX9mDcmfwjP1SqnovnxdN1xm+0uoRGU9Wrp1Zv+lJfdCOPJIxzVkWd0vkB02ITrQQWPo+yvNCPP
 5ZcZJeJW54qO+bgUv1PAwYM9jSFu895w6KBKmpnxQyHTBWj6kpeqWr0/vC+m7StGKbTrrI/ytqK
 pov7jWyC5CJNouReUJ+NoJgMLhqlK+Ja4pHBRHnIs015K0vRBapeBw4tX5h1V+yzKJMVlz8Ev1/
 pKGip1WCBPMVytBUIfNknwS8DEeOu7xDmcCU2RIfKDFTrYwmRBYgJJ5Lrw09tugMXUEgGOzUChG
 BDYiZ0zut568H+9ho1dude5TYgkJODclgeA==
X-Received: by 2002:a5d:634e:0:b0:488:5d44:6680 with SMTP id
 ffacd0b85a97d-48e6e2faf41mr17318208f8f.36.1793626559299; 
 Mon, 02 Nov 2026 05:35:59 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/47] hw/net/bcm2838_genet: add GENET register structs,
 part 4/4
Date: Mon,  2 Nov 2026 13:35:08 +0000
Message-ID: <20261102133547.1375701-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Add the PHY "shadow" register structs (BCM54213PE PHY-specific
clock control, RGMII mode, LED, and expansion-block registers
accessed via the AUX_CTL/EXP_SHD indirection scheme) used by the
MDIO emulation added in a later patch.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-9-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index fedfbde0667..2c3c62a9dd2 100644
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
@@ -273,6 +279,32 @@ typedef struct {
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
+    uint16_t regs[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE];
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
@@ -284,6 +316,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.43.0


