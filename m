Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924A3CFB44D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxrMW-00036N-LQ; Mon, 07 Oct 2024 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qhcEZwYKCikYNYZXWLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--titusr.bounces.google.com>)
 id 1sxrMV-000364-Lz
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:17:35 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qhcEZwYKCikYNYZXWLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--titusr.bounces.google.com>)
 id 1sxrMT-000529-3t
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:17:35 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e30cf0cf1bso5772287b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728321451; x=1728926251; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GHz4rSRh9deAPG3dNxam4z9b4qhpmexnTmnPdSRsi6w=;
 b=PGI3gXec4TcfUzM3dYStTQRFVnghUvvJJ3Ugjls6vY2EY1ccAuJGu98K+SkU74lYKA
 T30xAavLHOx2LgQIY1mPfGXZtgoximYUUovkxJEXId/mDFuGNlZtxkX3X4jsHkJau7YE
 qA8k9XqsqOnuQG0z85lRZb2NfRmKKx777V6e45AHeX8pG6jhH5zy9TtIKqtaDtyjteFL
 /e9bxht7NQSWgujFmG9l6wyEDpTziDYHrrOnEIXvq0U4c9chKs0NO3sY4lpZRdUumDiJ
 WdJcD7enYgaiFD+s6h9a4aZU9TPT3OAMhl2rgTsItUTxe30u2fAicfY0KeTnstT9p6Aq
 YLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728321451; x=1728926251;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHz4rSRh9deAPG3dNxam4z9b4qhpmexnTmnPdSRsi6w=;
 b=tPHH4jZO5gF0kuhUlgZFfzNOqwjOi/EBV0AmxVD3OsPLbdCatUo+AuJaN7RDBXrtob
 n/cOWtadlbBRi4CbBJIRIJ36LxkSGjMdXhRgeICGsAINNdvjoPJao4vj7CfFfo4md543
 nIxXwrUjfMKbOwj8Cb7arwGV4zfxz+9TrU2T3+ZycvBv5uxTrR2W84TwoVmqigGDxMOT
 A5+K0uh7UI9js1mTQJCLkOGEQZLW8pmDKTQePTXwarrGQSw8Rli3YR+8/6k+TdwfRwQ0
 hH00ej2GiVxbwHKd4FPOtniLQiNrpvInGchC7iFcZM4YmPTXDDxGeLF67wyKsb6iGg/B
 e+bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqhMifMiuVW8cIuOVl8syAY5TMoKhDkM7m/nQp2s2HOl5U8rsDVutl+EbVRFWxjbpQURdykd0wrnGK@nongnu.org
X-Gm-Message-State: AOJu0Yxb84AE1PlQIMDJ1PGvVB5hOYrj3yqOHHGHy04qmJxulIn909jN
 qts0ecOZRQnvtcZLrqRfTpTLzBZo6OGSOKY2lG7xcpWRyECkBjjDEudgQ24tigQf4oA12os/Nxo
 kJw==
X-Google-Smtp-Source: AGHT+IGs/4Yuwytx+rlHLQoy/aaky/vobzMmBX/BklIQKxGyyddyi49+AbO2F09ZN4s3e49s6TDFTP8qC10=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:914])
 (user=titusr job=sendgmr) by 2002:a25:908d:0:b0:e1d:2043:da46 with
 SMTP id
 3f1490d57ef6-e28936d4d4fmr37111276.3.1728321450342; Mon, 07 Oct 2024 10:17:30
 -0700 (PDT)
Date: Mon,  7 Oct 2024 17:17:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007171700.1594342-1-titusr@google.com>
Subject: [PATCH] hw/arm: add Quanta GSZ bmc machine
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com, 
 wuhaotsh@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3qhcEZwYKCikYNYZXWLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--titusr.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch adds the quanta-gsz-bmc target, a current Google machine of
the day. This machine will be used as a platform to enable features such
as the PECI bmc interface, and Intel eSPI virtual wire interface in
QEMU.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/arm/npcm7xx_boards.c | 140 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index e229efb447..e1ff5af756 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -48,6 +48,8 @@
 #define NPCM750_EVB_POWER_ON_STRAPS ( \
         NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_J2EN)
 #define QUANTA_GSJ_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAULT
+#define QUANTA_GSZ_POWER_ON_STRAPS ( \
+        NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_SFAB)
 #define QUANTA_GBS_POWER_ON_STRAPS ( \
         NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_SFAB)
 #define KUDO_BMC_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAULT
@@ -269,6 +271,109 @@ static void quanta_gsj_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
     npcm7xx_connect_pwm_fan(soc, &splitter[2], 0x05, 1);
 }
 
+static void quanta_gsz_i2c_init(NPCM7xxState *soc)
+{
+    I2CSlave *i2c_mux;
+
+    /* i2c1 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548,
+                                      0x75);
+    /* pca6416@0x20 */
+
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
+                                      TYPE_PCA9548, 0x77);
+
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), "raa229004", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1), "raa229004", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "isl69260", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3), "isl69260", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "isl69260", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "isl69260", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), "adm1272", 0x1f);
+
+    /* i2c2 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2),
+                                      TYPE_PCA9548, 0x77);
+    /*         - channel 0: tps546d24 @25
+     *         - channel 1: delta,dps800 @69
+     */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1), "raa228000", 0x68);
+    /*          - channel 2: delta,dps800 @68 */
+    /* max31725 is compatible with tmp105. */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x5c);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 0x5c);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105", 0x5c);
+
+    /* i2c3 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 3), TYPE_PCA9548,
+                                      0x77);
+
+    /* i2c4 */
+    /* mobo_fru_1 */
+    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192);
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4),
+                                      TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), "max34451", 0x59);
+    /* mobo_fru_2 */
+    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 2), 0x55, 32768);
+
+    /* pca6416@0x20 */
+    /* pca6416@0x20 */
+
+    /* pdb_fru */
+    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 6), 0x55, 8192);
+
+    /* i2c5 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 5), TYPE_PCA9548,
+                                      0x77);
+
+    /* i2c6 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6), TYPE_PCA9548,
+                                      0x77);
+
+    /* i2c7 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 7), TYPE_PCA9548,
+                                      0x77);
+
+    /* i2c8 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 8), TYPE_PCA9548,
+                                      0x77);
+
+    /* i2c9 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 9), TYPE_PCA9548,
+                                      0x77);
+
+    /* i2c10 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 10),
+                                      TYPE_PCA9548, 0x77);
+
+    /* i2c11 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 11),
+                                      TYPE_PCA9548, 0x77);
+
+    /* i2c12 */
+
+    /* i2c13 */
+    /* pca9555@22 */
+
+    /* i2c14 */
+    /* LEDs and PE Resets */
+    /* pca6416@0x20 */
+
+    /* bmc_fru_1 */
+    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192);
+
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 14),
+                                      TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), "max34451", 0x59);
+
+    /* max31725 is compatible with tmp105 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 0x5c);
+
+    /* i2c15 */
+    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15), TYPE_PCA9546, 0x75);
+}
+
 static void quanta_gbs_i2c_init(NPCM7xxState *soc)
 {
     /*
@@ -392,6 +497,25 @@ static void quanta_gsj_init(MachineState *machine)
     npcm7xx_load_kernel(machine, soc);
 }
 
+static void quanta_gsz_init(MachineState *machine)
+{
+    NPCM7xxState *soc;
+
+    soc = npcm7xx_create_soc(machine, QUANTA_GSZ_POWER_ON_STRAPS);
+    npcm7xx_connect_dram(soc, machine->ram);
+    qdev_realize(DEVICE(soc), NULL, &error_fatal);
+
+    npcm7xx_load_bootrom(machine, soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx66u51235f",
+                          drive_get(IF_MTD, 0, 0));
+    npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
+                          drive_get(IF_MTD, 3, 0));
+
+    quanta_gsz_i2c_init(soc);
+    sdhci_attach_drive(&soc->mmc.sdhci, 0);
+    npcm7xx_load_kernel(machine, soc);
+}
+
 static void quanta_gbs_init(MachineState *machine)
 {
     NPCM7xxState *soc;
@@ -496,6 +620,18 @@ static void gsj_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 512 * MiB;
 };
 
+static void gsz_machine_class_init(ObjectClass *oc, void *data)
+{
+    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    npcm7xx_set_soc_type(nmc, TYPE_NPCM730);
+
+    mc->desc = "Quanta GSZ (Cortex-A9)";
+    mc->init = quanta_gsz_init;
+    mc->default_ram_size = 1 * GiB;
+}
+
 static void gbs_bmc_machine_class_init(ObjectClass *oc, void *data)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
@@ -548,6 +684,10 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("quanta-gsj"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("quanta-gsz-bmc"),
+        .parent         = TYPE_NPCM7XX_MACHINE,
+        .class_init     = gsz_machine_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gbs-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
-- 
2.47.0.rc0.187.ge670bccf7e-goog


