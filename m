Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D56C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA73-0005zA-Eg; Thu, 06 Feb 2025 17:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3zjOlZwgKCg8B9wp387wv33v0t.r315t19-stAt0232v29.36v@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6t-0005r4-Fa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:36 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3zjOlZwgKCg8B9wp387wv33v0t.r315t19-stAt0232v29.36v@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6q-0001V1-SD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:35 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-216750b679eso22719265ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879950; x=1739484750; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=BWbgkjlC4ZYGkYOq/TKr/y5EjzXk8liQ7l3/bt3MsDs=;
 b=HS/32YEjJyytdRSolGng0acC/lkRj//3nW3AYWnucSCr21HS9G9TFUVtQEn+ojhmZT
 aoltfxjrpd0P3fFupZq2M2tw+VYhI1NyuSuOKDK+wzSIIxCiLlXMOVYBM8pjOtal6/nX
 uGgU4TIQRfFHpaFybZK8DgRxj19+808NgKkjEiwWdRpbSLM2n7E5GftkdZLV2Y0bZSGz
 2VNvCcMWnUlc0q5lWsxaBx/ZmOsfoxfd7H2iaP+PgZFAlStZa6X6s0kbGFyQv+547GRQ
 zN6G16iDVb+tjfnEYh2UlSOpvmiqu5uNZZVvOZK91dsehtxhcW47zuUIiF31FkmlGlrq
 QCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879950; x=1739484750;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWbgkjlC4ZYGkYOq/TKr/y5EjzXk8liQ7l3/bt3MsDs=;
 b=HM40EcY6CVkZLXVsJ8EwHfeBtgZr7sbY0lQWRpYDvdSjTWUM/1MdsKeEWrF7jk0ae4
 dN5Bh55MMVkjHOTEK+wrKLpSVY8ClVXC1In93M0Mpz5qCquOlhIFj3cEiqXndh9dNQbB
 JY4wSpeoZPLmUOmKX2JqUJ/0ORvmyTGp1DRcZViG7at1oclqdkFji3vtj4UW+oT5jP4S
 eLkCfxPJVwLaW9F8ZXuA/qIcfUj/IcrOWP7bQtnuh/2zvzyfJ9E+Dsi8uOEtj9eL8jsR
 ClQoKzNIpEHzXQvYXFAafuG3hCRqHBYZCWAkvhd1aCPgvCFyoC5DnqP1GkIQsXc0JQZU
 YkVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtkX0ldHB4pYFEI8BIIy0Di+9O6VL8M1iF297RrfG7LRNHfUaP9mm96jJTPkghXUxM8fJuBgkPzxYh@nongnu.org
X-Gm-Message-State: AOJu0YxxwMRanw0+4rFfwgjMDUUI6GU3MjGLbmj1gssf2p7n3vMR3hMy
 CmYHjXd/YLA0DfKA5I1pGoyCNlHnDfahQwpZtenhHW4CQ9UjuvMqHn8qaKPiIvxDNHNsGHV5fP3
 S9wPlVZ5BQg==
X-Google-Smtp-Source: AGHT+IEqMdQ64itPsIQvwRlR/LomXwIH+aJD9iEdCtgYOuoUXNk4IYgR6bsGfU/dzrqYqM57SdtuEmjSybSuXQ==
X-Received: from pgpk13.prod.google.com ([2002:a63:ab4d:0:b0:ad5:2857:bf09])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7881:b0:1e1:bdae:e058 with SMTP id
 adf61e73a8af0-1ee03bc6aadmr1859553637.37.1738879950441; 
 Thu, 06 Feb 2025 14:12:30 -0800 (PST)
Date: Thu,  6 Feb 2025 14:12:00 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-15-wuhaotsh@google.com>
Subject: [PATCH v4 14/17] hw/net: Add NPCM8XX PCS Module
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3zjOlZwgKCg8B9wp387wv33v0t.r315t19-stAt0232v29.36v@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The PCS exists in NPCM8XX's GMAC1 and is used to control the SGMII
PHY. This implementation contains all the default registers and
the soft reset feature that are required to load the Linux kernel
driver. Further features have not been implemented yet.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/meson.build        |   1 +
 hw/net/npcm_pcs.c         | 410 ++++++++++++++++++++++++++++++++++++++
 hw/net/trace-events       |   4 +-
 include/hw/net/npcm_pcs.h |  42 ++++
 4 files changed, 455 insertions(+), 2 deletions(-)
 create mode 100644 hw/net/npcm_pcs.c
 create mode 100644 include/hw/net/npcm_pcs.h

diff --git a/hw/net/meson.build b/hw/net/meson.build
index 3bb5d749a8..e6759e26ca 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -40,6 +40,7 @@ system_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
 system_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
 system_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c', 'npcm_gmac.c'))
+system_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm_pcs.c'))
 
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_llan.c'))
diff --git a/hw/net/npcm_pcs.c b/hw/net/npcm_pcs.c
new file mode 100644
index 0000000000..ce5034e234
--- /dev/null
+++ b/hw/net/npcm_pcs.c
@@ -0,0 +1,410 @@
+/*
+ * Nuvoton NPCM8xx PCS Module
+ *
+ * Copyright 2022 Google LLC
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
+/*
+ * Disclaimer:
+ * Currently we only implemented the default values of the registers and
+ * the soft reset feature. These are required to boot up the GMAC module
+ * in Linux kernel for NPCM845 boards. Other functionalities are not modeled.
+ */
+
+#include "qemu/osdep.h"
+
+#include "exec/hwaddr.h"
+#include "hw/registerfields.h"
+#include "hw/net/npcm_pcs.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+#define NPCM_PCS_IND_AC_BA      0x1fe
+#define NPCM_PCS_IND_SR_CTL     0x1e00
+#define NPCM_PCS_IND_SR_MII     0x1f00
+#define NPCM_PCS_IND_SR_TIM     0x1f07
+#define NPCM_PCS_IND_VR_MII     0x1f80
+
+REG16(NPCM_PCS_SR_CTL_ID1, 0x08)
+REG16(NPCM_PCS_SR_CTL_ID2, 0x0a)
+REG16(NPCM_PCS_SR_CTL_STS, 0x10)
+
+REG16(NPCM_PCS_SR_MII_CTRL, 0x00)
+REG16(NPCM_PCS_SR_MII_STS, 0x02)
+REG16(NPCM_PCS_SR_MII_DEV_ID1, 0x04)
+REG16(NPCM_PCS_SR_MII_DEV_ID2, 0x06)
+REG16(NPCM_PCS_SR_MII_AN_ADV, 0x08)
+REG16(NPCM_PCS_SR_MII_LP_BABL, 0x0a)
+REG16(NPCM_PCS_SR_MII_AN_EXPN, 0x0c)
+REG16(NPCM_PCS_SR_MII_EXT_STS, 0x1e)
+
+REG16(NPCM_PCS_SR_TIM_SYNC_ABL, 0x10)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR, 0x12)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR, 0x14)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR, 0x16)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR, 0x18)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR, 0x1a)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR, 0x1c)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR, 0x1e)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR, 0x20)
+
+REG16(NPCM_PCS_VR_MII_MMD_DIG_CTRL1, 0x000)
+REG16(NPCM_PCS_VR_MII_AN_CTRL, 0x002)
+REG16(NPCM_PCS_VR_MII_AN_INTR_STS, 0x004)
+REG16(NPCM_PCS_VR_MII_TC, 0x006)
+REG16(NPCM_PCS_VR_MII_DBG_CTRL, 0x00a)
+REG16(NPCM_PCS_VR_MII_EEE_MCTRL0, 0x00c)
+REG16(NPCM_PCS_VR_MII_EEE_TXTIMER, 0x010)
+REG16(NPCM_PCS_VR_MII_EEE_RXTIMER, 0x012)
+REG16(NPCM_PCS_VR_MII_LINK_TIMER_CTRL, 0x014)
+REG16(NPCM_PCS_VR_MII_EEE_MCTRL1, 0x016)
+REG16(NPCM_PCS_VR_MII_DIG_STS, 0x020)
+REG16(NPCM_PCS_VR_MII_ICG_ERRCNT1, 0x022)
+REG16(NPCM_PCS_VR_MII_MISC_STS, 0x030)
+REG16(NPCM_PCS_VR_MII_RX_LSTS, 0x040)
+REG16(NPCM_PCS_VR_MII_MP_TX_BSTCTRL0, 0x070)
+REG16(NPCM_PCS_VR_MII_MP_TX_LVLCTRL0, 0x074)
+REG16(NPCM_PCS_VR_MII_MP_TX_GENCTRL0, 0x07a)
+REG16(NPCM_PCS_VR_MII_MP_TX_GENCTRL1, 0x07c)
+REG16(NPCM_PCS_VR_MII_MP_TX_STS, 0x090)
+REG16(NPCM_PCS_VR_MII_MP_RX_GENCTRL0, 0x0b0)
+REG16(NPCM_PCS_VR_MII_MP_RX_GENCTRL1, 0x0b2)
+REG16(NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0, 0x0ba)
+REG16(NPCM_PCS_VR_MII_MP_MPLL_CTRL0, 0x0f0)
+REG16(NPCM_PCS_VR_MII_MP_MPLL_CTRL1, 0x0f2)
+REG16(NPCM_PCS_VR_MII_MP_MPLL_STS, 0x110)
+REG16(NPCM_PCS_VR_MII_MP_MISC_CTRL2, 0x126)
+REG16(NPCM_PCS_VR_MII_MP_LVL_CTRL, 0x130)
+REG16(NPCM_PCS_VR_MII_MP_MISC_CTRL0, 0x132)
+REG16(NPCM_PCS_VR_MII_MP_MISC_CTRL1, 0x134)
+REG16(NPCM_PCS_VR_MII_DIG_CTRL2, 0x1c2)
+REG16(NPCM_PCS_VR_MII_DIG_ERRCNT_SEL, 0x1c4)
+
+/* Register Fields */
+#define NPCM_PCS_SR_MII_CTRL_RST            BIT(15)
+
+static const uint16_t npcm_pcs_sr_ctl_cold_reset_values[NPCM_PCS_NR_SR_CTLS] = {
+    [R_NPCM_PCS_SR_CTL_ID1]                 = 0x699e,
+    [R_NPCM_PCS_SR_CTL_STS]                 = 0x8000,
+};
+
+static const uint16_t npcm_pcs_sr_mii_cold_reset_values[NPCM_PCS_NR_SR_MIIS] = {
+    [R_NPCM_PCS_SR_MII_CTRL]                = 0x1140,
+    [R_NPCM_PCS_SR_MII_STS]                 = 0x0109,
+    [R_NPCM_PCS_SR_MII_DEV_ID1]             = 0x699e,
+    [R_NPCM_PCS_SR_MII_DEV_ID2]             = 0xced0,
+    [R_NPCM_PCS_SR_MII_AN_ADV]              = 0x0020,
+    [R_NPCM_PCS_SR_MII_EXT_STS]             = 0xc000,
+};
+
+static const uint16_t npcm_pcs_sr_tim_cold_reset_values[NPCM_PCS_NR_SR_TIMS] = {
+    [R_NPCM_PCS_SR_TIM_SYNC_ABL]            = 0x0003,
+    [R_NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR] = 0x0038,
+    [R_NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR] = 0x0038,
+    [R_NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR] = 0x0058,
+    [R_NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR] = 0x0048,
+};
+
+static const uint16_t npcm_pcs_vr_mii_cold_reset_values[NPCM_PCS_NR_VR_MIIS] = {
+    [R_NPCM_PCS_VR_MII_MMD_DIG_CTRL1]         = 0x2400,
+    [R_NPCM_PCS_VR_MII_AN_INTR_STS]           = 0x000a,
+    [R_NPCM_PCS_VR_MII_EEE_MCTRL0]            = 0x899c,
+    [R_NPCM_PCS_VR_MII_DIG_STS]               = 0x0010,
+    [R_NPCM_PCS_VR_MII_MP_TX_BSTCTRL0]        = 0x000a,
+    [R_NPCM_PCS_VR_MII_MP_TX_LVLCTRL0]        = 0x007f,
+    [R_NPCM_PCS_VR_MII_MP_TX_GENCTRL0]        = 0x0001,
+    [R_NPCM_PCS_VR_MII_MP_RX_GENCTRL0]        = 0x0100,
+    [R_NPCM_PCS_VR_MII_MP_RX_GENCTRL1]        = 0x1100,
+    [R_NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0]       = 0x000e,
+    [R_NPCM_PCS_VR_MII_MP_MPLL_CTRL0]         = 0x0100,
+    [R_NPCM_PCS_VR_MII_MP_MPLL_CTRL1]         = 0x0032,
+    [R_NPCM_PCS_VR_MII_MP_MPLL_STS]           = 0x0001,
+    [R_NPCM_PCS_VR_MII_MP_LVL_CTRL]           = 0x0019,
+};
+
+static void npcm_pcs_soft_reset(NPCMPCSState *s)
+{
+    memcpy(s->sr_ctl, npcm_pcs_sr_ctl_cold_reset_values,
+           NPCM_PCS_NR_SR_CTLS * sizeof(uint16_t));
+    memcpy(s->sr_mii, npcm_pcs_sr_mii_cold_reset_values,
+           NPCM_PCS_NR_SR_MIIS * sizeof(uint16_t));
+    memcpy(s->sr_tim, npcm_pcs_sr_tim_cold_reset_values,
+           NPCM_PCS_NR_SR_TIMS * sizeof(uint16_t));
+    memcpy(s->vr_mii, npcm_pcs_vr_mii_cold_reset_values,
+           NPCM_PCS_NR_VR_MIIS * sizeof(uint16_t));
+}
+
+static uint16_t npcm_pcs_read_sr_ctl(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_CTLS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_CTL read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->sr_ctl[regno];
+}
+
+static uint16_t npcm_pcs_read_sr_mii(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_MII read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->sr_mii[regno];
+}
+
+static uint16_t npcm_pcs_read_sr_tim(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_TIMS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_TIM read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->sr_tim[regno];
+}
+
+static uint16_t npcm_pcs_read_vr_mii(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_VR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: VR_MII read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->vr_mii[regno];
+}
+
+static void npcm_pcs_write_sr_ctl(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_CTLS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_CTL write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->sr_ctl[regno] = v;
+}
+
+static void npcm_pcs_write_sr_mii(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_MII write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->sr_mii[regno] = v;
+
+    if ((offset == A_NPCM_PCS_SR_MII_CTRL) && (v & NPCM_PCS_SR_MII_CTRL_RST)) {
+        /* Trigger a soft reset */
+        npcm_pcs_soft_reset(s);
+    }
+}
+
+static void npcm_pcs_write_sr_tim(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_TIMS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_TIM write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->sr_tim[regno] = v;
+}
+
+static void npcm_pcs_write_vr_mii(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_VR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: VR_MII write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->vr_mii[regno] = v;
+}
+
+static uint64_t npcm_pcs_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NPCMPCSState *s = opaque;
+    uint16_t v = 0;
+
+    if (offset == NPCM_PCS_IND_AC_BA) {
+        v = s->indirect_access_base;
+    } else {
+        switch (s->indirect_access_base) {
+        case NPCM_PCS_IND_SR_CTL:
+            v = npcm_pcs_read_sr_ctl(s, offset);
+            break;
+
+        case NPCM_PCS_IND_SR_MII:
+            v = npcm_pcs_read_sr_mii(s, offset);
+            break;
+
+        case NPCM_PCS_IND_SR_TIM:
+            v = npcm_pcs_read_sr_tim(s, offset);
+            break;
+
+        case NPCM_PCS_IND_VR_MII:
+            v = npcm_pcs_read_vr_mii(s, offset);
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Read with invalid indirect address base: 0x%"
+                          PRIx16 "\n", DEVICE(s)->canonical_path,
+                          s->indirect_access_base);
+        }
+    }
+
+    trace_npcm_pcs_reg_read(DEVICE(s)->canonical_path, s->indirect_access_base,
+                            offset, v);
+    return v;
+}
+
+static void npcm_pcs_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    NPCMPCSState *s = opaque;
+
+    trace_npcm_pcs_reg_write(DEVICE(s)->canonical_path, s->indirect_access_base,
+                             offset, v);
+    if (offset == NPCM_PCS_IND_AC_BA) {
+        s->indirect_access_base = v;
+    } else {
+        switch (s->indirect_access_base) {
+        case NPCM_PCS_IND_SR_CTL:
+            npcm_pcs_write_sr_ctl(s, offset, v);
+            break;
+
+        case NPCM_PCS_IND_SR_MII:
+            npcm_pcs_write_sr_mii(s, offset, v);
+            break;
+
+        case NPCM_PCS_IND_SR_TIM:
+            npcm_pcs_write_sr_tim(s, offset, v);
+            break;
+
+        case NPCM_PCS_IND_VR_MII:
+            npcm_pcs_write_vr_mii(s, offset, v);
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Write with invalid indirect address base: 0x%02"
+                          PRIx16 "\n", DEVICE(s)->canonical_path,
+                          s->indirect_access_base);
+        }
+    }
+}
+
+static void npcm_pcs_enter_reset(Object *obj, ResetType type)
+{
+    NPCMPCSState *s = NPCM_PCS(obj);
+
+    npcm_pcs_soft_reset(s);
+}
+
+static const struct MemoryRegionOps npcm_pcs_ops = {
+    .read = npcm_pcs_read,
+    .write = npcm_pcs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 2,
+        .max_access_size = 2,
+        .unaligned = false,
+    },
+};
+
+static void npcm_pcs_realize(DeviceState *dev, Error **errp)
+{
+    NPCMPCSState *pcs = NPCM_PCS(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&pcs->iomem, OBJECT(pcs), &npcm_pcs_ops, pcs,
+                          TYPE_NPCM_PCS, 8 * KiB);
+    sysbus_init_mmio(sbd, &pcs->iomem);
+}
+
+static const VMStateDescription vmstate_npcm_pcs = {
+    .name = TYPE_NPCM_PCS,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(indirect_access_base, NPCMPCSState),
+        VMSTATE_UINT16_ARRAY(sr_ctl, NPCMPCSState, NPCM_PCS_NR_SR_CTLS),
+        VMSTATE_UINT16_ARRAY(sr_mii, NPCMPCSState, NPCM_PCS_NR_SR_MIIS),
+        VMSTATE_UINT16_ARRAY(sr_tim, NPCMPCSState, NPCM_PCS_NR_SR_TIMS),
+        VMSTATE_UINT16_ARRAY(vr_mii, NPCMPCSState, NPCM_PCS_NR_VR_MIIS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void npcm_pcs_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NPCM PCS Controller";
+    dc->realize = npcm_pcs_realize;
+    dc->vmsd = &vmstate_npcm_pcs;
+    rc->phases.enter = npcm_pcs_enter_reset;
+}
+
+static const TypeInfo npcm_pcs_types[] = {
+    {
+        .name = TYPE_NPCM_PCS,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCMPCSState),
+        .class_init = npcm_pcs_class_init,
+    },
+};
+DEFINE_TYPES(npcm_pcs_types)
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c35bfb2eb8..72b69c4a8b 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -483,8 +483,8 @@ npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t tdes1)
 npcm_gmac_tx_desc_owner(const char* name, uint32_t desc_addr) "%s: TX Descriptor @0x%04" PRIX32 " is owned by software"
 
 # npcm_pcs.c
-npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-npcm_pcs_reg_write(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+npcm_pcs_reg_read(const char *name, uint16_t indirect_access_base, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+npcm_pcs_reg_write(const char *name, uint16_t indirect_access_base, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
 
 # dp8398x.c
 dp8393x_raise_irq(int isr) "raise irq, isr is 0x%04x"
diff --git a/include/hw/net/npcm_pcs.h b/include/hw/net/npcm_pcs.h
new file mode 100644
index 0000000000..d5c481ad70
--- /dev/null
+++ b/include/hw/net/npcm_pcs.h
@@ -0,0 +1,42 @@
+/*
+ * Nuvoton NPCM8xx PCS Module
+ *
+ * Copyright 2022 Google LLC
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
+#ifndef NPCM_PCS_H
+#define NPCM_PCS_H
+
+#include "hw/sysbus.h"
+
+#define NPCM_PCS_NR_SR_CTLS     (0x12 / sizeof(uint16_t))
+#define NPCM_PCS_NR_SR_MIIS     (0x20 / sizeof(uint16_t))
+#define NPCM_PCS_NR_SR_TIMS     (0x22 / sizeof(uint16_t))
+#define NPCM_PCS_NR_VR_MIIS     (0x1c6 / sizeof(uint16_t))
+
+struct NPCMPCSState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint16_t indirect_access_base;
+    uint16_t sr_ctl[NPCM_PCS_NR_SR_CTLS];
+    uint16_t sr_mii[NPCM_PCS_NR_SR_MIIS];
+    uint16_t sr_tim[NPCM_PCS_NR_SR_TIMS];
+    uint16_t vr_mii[NPCM_PCS_NR_VR_MIIS];
+};
+
+#define TYPE_NPCM_PCS "npcm-pcs"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMPCSState, NPCM_PCS)
+
+#endif /* NPCM_PCS_H */
-- 
2.48.1.502.g6dc24dfdaf-goog


