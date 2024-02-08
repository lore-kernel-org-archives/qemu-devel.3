Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E702C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 19:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYANV-0001a2-GP; Thu, 08 Feb 2024 14:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38y_FZQwKCpwJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com>)
 id 1rYANT-0001Ze-De
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:48:07 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38y_FZQwKCpwJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com>)
 id 1rYANR-00071Y-AQ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:48:07 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc64f63d768so303225276.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 11:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707421683; x=1708026483; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=aJWdE8dgJBmLhnOvg9g09ld9xcg39OqcH+vA2Kb7ro4=;
 b=vDPi5vOwQVyll73GKSadjR4Yix1ig2PkPY768Z3z4puH9yORhaFd+u460wjB8jHrjH
 X43TYBDQTgjdYmFPTsnOjn/nZ4MFFul2CSdbUZCsKxhSrNvdMlSByhUSdjUltzp0ltoC
 R1uhS3wp/5pYD/b0Rlfcc+8nFf+Bzg+LXakdXMJeKM02X0KyWKgNuDu+hgmstTnOg227
 etRVVsEq5tC+3LSXGHWsqIGkQvgc43do2qYwuzLExxOxgfaIHxVieKORMBrBApNkGWx4
 0EpBZ9LQwiO3/GvgqfUPtjm8nVBuZOHyqxFK388yjmMg/hhCGJGSPG7vfU/Zg746kgoZ
 rIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707421683; x=1708026483;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aJWdE8dgJBmLhnOvg9g09ld9xcg39OqcH+vA2Kb7ro4=;
 b=sZAI43eoUGopAX5KHOvXdABBzyREFoOapUeNCVjX9pVGl2qhC492DE7GT8/X9Eijk1
 Cjd5Sg29JDZ02f1q4erYoEyLEVKb/3L3Y4fs8m/b2UAwNQNUfwqfSGmw1INtElYf2SN9
 r0Dnly+toaz0ZJwnnbBz7xq8nPEW5E+CM5FpkZlBnxAl5aMKgMU3/ZHl18ZdTLnEL9ED
 bpls9Ei6x7cvIPYKYezguIdqLfUKOZdGwQAOG+IyX8r6OCa43NYJ0ycw8ZR5jbnwmK2M
 125Rbf7jAqq/j22tY+QgcsH91WxXILy/0UZnY1O6Ts/ErEidkbBdkk9NyiDphTOAdl3W
 71MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVGl2vC0a2axp01GtC87vWU/rFx2DI4caQvp/kXxUFOy9dC7OQNMKDlChjLeefS01AG0mdyWz4rfWpuHL2tqeXpl1zUH8=
X-Gm-Message-State: AOJu0Yx6q+Bp2NCeN3bWfOnrPdZdknE8wKatrz+ydZFnnX5F4q8MMbje
 ymRsJcNRpxkfIV1Lgv/zKUnpZbxdvXWbIhrYHDD5HQDBEuNi/jMYtOT6YL36bflhHbw3sGyhixr
 CmebdRe66m1ymj7iOgTEhjijaDg==
X-Google-Smtp-Source: AGHT+IHO0OZDv4E8TUPSEPLhMsn5RHanxB3BXOPuDSKFdsL9eSQLVAxXL8xKHLbzEF1osAiafKQ/kV7VwiUDAtYzFz4=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:124a:b0:dc2:23f5:1791 with
 SMTP id t10-20020a056902124a00b00dc223f51791mr108234ybu.6.1707421683752; Thu,
 08 Feb 2024 11:48:03 -0800 (PST)
Date: Thu,  8 Feb 2024 19:47:59 +0000
In-Reply-To: <20240208194759.2858582-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240208194759.2858582-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208194759.2858582-2-nabihestefan@google.com>
Subject: [PATCH v3 1/1] tests/qtest: Fixing GMAC test to run in 7xx
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=38y_FZQwKCpwJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

Fixing the nocm_gmac-test.c file to run on a nuvoton 7xx machine instead
of 8xx. Also fixing comments referencing this and values expecting 8xx.

Change-Id: Iabd0fba14910c3f1e883c4a9521350f3db9ffab8
Signed-Off-By: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 tests/qtest/meson.build      |  4 +-
 tests/qtest/npcm_gmac-test.c | 84 +-----------------------------------
 2 files changed, 4 insertions(+), 84 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 39557d5ecb..2b89e8634b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -192,7 +192,8 @@ qtests_npcm7xx = \
    'npcm7xx_sdhci-test',
    'npcm7xx_smbus-test',
    'npcm7xx_timer-test',
-   'npcm7xx_watchdog_timer-test'] + \
+   'npcm7xx_watchdog_timer-test',
+   'npcm_gmac-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
 qtests_aspeed = \
   ['aspeed_hace-test',
@@ -231,7 +232,6 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index 9e58b15ca1..c28b471ab2 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -36,7 +36,7 @@ typedef struct TestData {
     const GMACModule *module;
 } TestData;
 
-/* Values extracted from hw/arm/npcm8xx.c */
+/* Values extracted from hw/arm/npcm7xx.c */
 static const GMACModule gmac_module_list[] = {
     {
         .irq        = 14,
@@ -46,14 +46,6 @@ static const GMACModule gmac_module_list[] = {
         .irq        = 15,
         .base_addr  = 0xf0804000
     },
-    {
-        .irq        = 16,
-        .base_addr  = 0xf0806000
-    },
-    {
-        .irq        = 17,
-        .base_addr  = 0xf0808000
-    }
 };
 
 /* Returns the index of the GMAC module. */
@@ -182,32 +174,18 @@ static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
     return qtest_readl(qts, mod->base_addr + regno);
 }
 
-static uint16_t pcs_read(QTestState *qts, const GMACModule *mod,
-                          NPCMRegister regno)
-{
-    uint32_t write_value = (regno & 0x3ffe00) >> 9;
-    qtest_writel(qts, PCS_BASE_ADDRESS + NPCM_PCS_IND_AC_BA, write_value);
-    uint32_t read_offset = regno & 0x1ff;
-    return qtest_readl(qts, PCS_BASE_ADDRESS + read_offset);
-}
-
 /* Check that GMAC registers are reset to default value */
 static void test_init(gconstpointer test_data)
 {
     const TestData *td = test_data;
     const GMACModule *mod = td->module;
-    QTestState *qts = qtest_init("-machine npcm845-evb");
+    QTestState *qts = qtest_init("-machine npcm750-evb");
 
 #define CHECK_REG32(regno, value) \
     do { \
         g_assert_cmphex(gmac_read(qts, mod, (regno)), ==, (value)); \
     } while (0)
 
-#define CHECK_REG_PCS(regno, value) \
-    do { \
-        g_assert_cmphex(pcs_read(qts, mod, (regno)), ==, (value)); \
-    } while (0)
-
     CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
     CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
     CHECK_REG32(NPCM_DMA_RCV_POLL_DEMAND, 0);
@@ -257,64 +235,6 @@ static void test_init(gconstpointer test_data)
     CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
     CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
 
-    /* TODO Add registers PCS */
-    if (mod->base_addr == 0xf0802000) {
-        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID1, 0x699e);
-        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID2, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_CTL_STS, 0x8000);
-
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_CTRL, 0x1140);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_STS, 0x0109);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID1, 0x699e);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID2, 0x0ced0);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_ADV, 0x0020);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_LP_BABL, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_EXPN, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_EXT_STS, 0xc000);
-
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_ABL, 0x0003);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR, 0x0038);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR, 0x0038);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR, 0x0058);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR, 0x0048);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR, 0);
-
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MMD_DIG_CTRL1, 0x2400);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_CTRL, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_INTR_STS, 0x000a);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_TC, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DBG_CTRL, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL0, 0x899c);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_TXTIMER, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_RXTIMER, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_LINK_TIMER_CTRL, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_STS, 0x0010);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_ICG_ERRCNT1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MISC_STS, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_RX_LSTS, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_BSTCTRL0, 0x00a);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_LVLCTRL0, 0x007f);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL0, 0x0001);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_STS, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL0, 0x0100);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL1, 0x1100);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0, 0x000e);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL0, 0x0100);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL1, 0x0032);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_STS, 0x0001);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL2, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_LVL_CTRL, 0x0019);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL0, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_CTRL2, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_ERRCNT_SEL, 0);
-    }
-
     qtest_quit(qts);
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


