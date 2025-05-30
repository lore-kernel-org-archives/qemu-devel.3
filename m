Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EE8C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBd-00021k-4j; Fri, 30 May 2025 08:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBV-000205-DH
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBR-0001cq-Cr
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4d877dfb3so2086911f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609399; x=1749214199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fywE7uB7Y+/c+09WkhDdIvIW4vWTk+pJlIWyo8/Hgk0=;
 b=WLOZNS/eh8ZNiugN36/OYmTTcEoXcSqezqtnJfn+gZpPA82kIn71r0ZJ+YXuah3+1I
 2JVdG8VqZxs9u3IN0Ypa4YdbtSDkRJ2btN9AHWYPzecefGUPk5Oviq7kpYaNh5kxAyQ/
 t1tDyi+WVTmFTFx2c1L84Eo58vJsCxc6FXeAXgxyzgAXfBlIII+ubvkGcc1X81+efAB2
 SuAHyDzvAC5h19+Q2zH11n62CmJFqVOngdxazkcw3G+JmXXaFEn5iFH5Yqx6uN9I1VHj
 EWfCTZb3BMbaWC5hJ97o5Xxb8g7cxj6oHO/fwhcZiFtHsURuMey80sYsGs97nM9LxXte
 9V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609399; x=1749214199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fywE7uB7Y+/c+09WkhDdIvIW4vWTk+pJlIWyo8/Hgk0=;
 b=uw6qi9UWBdFgHNfGhcrLIbeuCw1nL+1xe/S3Sr9NvMs+Sjhv/j1Ks0c2HsfUCwmw/3
 E9nuOksLkcyXZ2GPtubVW7jHD3oLAU0lWRb77DYYhOF6wYtcRyqj8SKb0El6W7n+C2G1
 L2JeTKuewDfcYNNzbSp1PGybXXwpI1bXHlQfAPmI9NZS7Y0nkcHH7ULoF9AQQMUM7PfN
 IqT1vooXjUgnLO9HzvhY2JxznI2PHuLrUaoeRLhkPWv1R+KrRbKo4Pc5oJoE/Q0wUnva
 TsYrUhSQ/SRudGIlvpkwmGW2hCOKlGyR5tfxaSs8pjddpqGP9aaMOyd8mgNYg6jVLybY
 gk1Q==
X-Gm-Message-State: AOJu0YzZ7g7Na0HfuMmmM0tWgTimDXUvRGRNJQ5Yxp0aNmh2jelCl42u
 0Ix56LAuu4gQpBmibxbbxeKF1tpF1mRg5ice3fo7ksx8Co2S4JppzUUYnuVYWPVQ/2p9kMFFr2l
 K39F2
X-Gm-Gg: ASbGncujO/cDhlJ9IxB+7MYgRoQ7qzu9F6zxany/fFr64KGTz/L+HHgfFYWxI2EbsAp
 9lKgehjYzMVPKQioRKDAgDD+E08YJ6t7S90Txf1SDhiA6Nbo8i5XIoOiOyOgLMB3nMBMJp7tTQS
 CizGuD1TH3wBQ5SrtnxdhKnEh5rZY7OiF1WMhmZ0CBwt+MrGJuUXc67R+FzPKNsa6APPDiBFHqI
 c9W5PTZ5rs+kqh/sbOIJbRD5PH/YWvWT2ojTCkMECB5G+yf/+JHpGBT9aTTHdUFzcB6CTPUMRn9
 oE+bMYR0g2GUoK8h0ufDIhVyAKfwmZUIcF4LtH8FamMTeeukVWOLFTkQ4Q==
X-Google-Smtp-Source: AGHT+IF6opmCea7f2IiANeYjHOZ35oFGXUzK+82s3BFt+ObBmRla7hmxV5RTLmMAevESwe78iT4BSA==
X-Received: by 2002:a05:6000:26c6:b0:3a4:f73d:53de with SMTP id
 ffacd0b85a97d-3a4f7a4b79cmr2503148f8f.17.1748609399340; 
 Fri, 30 May 2025 05:49:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.49.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:49:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] tests/qtest: Migrate GMAC test from 7xx to 8xx
Date: Fri, 30 May 2025 13:49:39 +0100
Message-ID: <20250530124953.383687-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Nabih Estefan <nabihestefan@google.com>

For upstreaming we migrated this test to 7xx (since that was already
upstream) move it back to 8xx where it can check the 4 GMACs since that
is the board this test was originally created for.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Message-id: 20250508220718.735415-3-nabihestefan@google.com
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/npcm_gmac-test.c | 85 ++++++++++++++++++++++++++++++++++--
 tests/qtest/meson.build      |  6 ++-
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index c28b471ab20..1317da2cd7c 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -36,7 +36,7 @@ typedef struct TestData {
     const GMACModule *module;
 } TestData;
 
-/* Values extracted from hw/arm/npcm7xx.c */
+/* Values extracted from hw/arm/npcm8xx.c */
 static const GMACModule gmac_module_list[] = {
     {
         .irq        = 14,
@@ -46,6 +46,14 @@ static const GMACModule gmac_module_list[] = {
         .irq        = 15,
         .base_addr  = 0xf0804000
     },
+    {
+        .irq        = 16,
+        .base_addr  = 0xf0806000
+    },
+    {
+        .irq        = 17,
+        .base_addr  = 0xf0808000
+    }
 };
 
 /* Returns the index of the GMAC module. */
@@ -174,18 +182,32 @@ static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
     return qtest_readl(qts, mod->base_addr + regno);
 }
 
+static uint16_t pcs_read(QTestState *qts, const GMACModule *mod,
+                          NPCMRegister regno)
+{
+    uint32_t write_value = (regno & 0x3ffe00) >> 9;
+    qtest_writel(qts, PCS_BASE_ADDRESS + NPCM_PCS_IND_AC_BA, write_value);
+    uint32_t read_offset = regno & 0x1ff;
+    return qtest_readl(qts, PCS_BASE_ADDRESS + read_offset);
+}
+
 /* Check that GMAC registers are reset to default value */
 static void test_init(gconstpointer test_data)
 {
     const TestData *td = test_data;
     const GMACModule *mod = td->module;
-    QTestState *qts = qtest_init("-machine npcm750-evb");
+    QTestState *qts = qtest_init("-machine npcm845-evb");
 
 #define CHECK_REG32(regno, value) \
     do { \
         g_assert_cmphex(gmac_read(qts, mod, (regno)), ==, (value)); \
     } while (0)
 
+#define CHECK_REG_PCS(regno, value) \
+    do { \
+        g_assert_cmphex(pcs_read(qts, mod, (regno)), ==, (value)); \
+    } while (0)
+
     CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
     CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
     CHECK_REG32(NPCM_DMA_RCV_POLL_DEMAND, 0);
@@ -235,6 +257,63 @@ static void test_init(gconstpointer test_data)
     CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
     CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
 
+    if (mod->base_addr == 0xf0802000) {
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID1, 0x699e);
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID2, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_STS, 0x8000);
+
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_CTRL, 0x1140);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_STS, 0x0109);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID1, 0x699e);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID2, 0x0ced0);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_ADV, 0x0020);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_LP_BABL, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_EXPN, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_EXT_STS, 0xc000);
+
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_ABL, 0x0003);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR, 0x0038);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR, 0x0038);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR, 0x0058);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR, 0x0048);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR, 0);
+
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MMD_DIG_CTRL1, 0x2400);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_CTRL, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_INTR_STS, 0x000a);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_TC, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DBG_CTRL, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL0, 0x899c);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_TXTIMER, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_RXTIMER, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_LINK_TIMER_CTRL, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_STS, 0x0010);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_ICG_ERRCNT1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MISC_STS, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_RX_LSTS, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_BSTCTRL0, 0x00a);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_LVLCTRL0, 0x007f);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL0, 0x0001);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_STS, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL0, 0x0100);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL1, 0x1100);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0, 0x000e);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL0, 0x0100);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL1, 0x0032);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_STS, 0x0001);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL2, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_LVL_CTRL, 0x0019);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL0, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_CTRL2, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_ERRCNT_SEL, 0);
+    }
+
     qtest_quit(qts);
 }
 
@@ -242,7 +321,7 @@ static void gmac_add_test(const char *name, const TestData* td,
                           GTestDataFunc fn)
 {
     g_autofree char *full_name = g_strdup_printf(
-            "npcm7xx_gmac/gmac[%d]/%s", gmac_module_index(td->module), name);
+            "npcm8xx_gmac/gmac[%d]/%s", gmac_module_index(td->module), name);
     qtest_add_data_func(full_name, td, fn);
 }
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 43e5a86699d..8ad849054fe 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -208,9 +208,10 @@ qtests_npcm7xx = \
    'npcm7xx_sdhci-test',
    'npcm7xx_smbus-test',
    'npcm7xx_timer-test',
-   'npcm7xx_watchdog_timer-test',
-   'npcm_gmac-test'] + \
+   'npcm7xx_watchdog_timer-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
+qtests_npcm8xx = \
+  ['npcm_gmac-test']
 qtests_aspeed = \
   ['aspeed_gpio-test',
    'aspeed_hace-test',
@@ -259,6 +260,7 @@ qtests_aarch64 = \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-- 
2.43.0


