Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0DAD5D687
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t98b4-0001cM-Cw; Thu, 07 Nov 2024 14:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GBstZwYKCkMynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1t98ay-0001Xg-DF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:08 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GBstZwYKCkMynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1t98aw-0003Lt-40
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:08 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6ea90b6ee2fso24432357b3.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731009304; x=1731614104; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=2TPajN/xK866wB9/V0io4yin6lsJZUCZq19AIoNDrlE=;
 b=34cAvccrIHy7K54KuYIfa8mCgzS11KozYsQDWsovLVkAeUzmn4uYwAcc3EfgcyLFaT
 Nm1AdPdTtWNyWfe92h1G8TiCdTvPJS3xB/81snLoefNo8pHVzQH3jQCavPRtSAq4xz7/
 CKmMLQzwED/FwS8We3zxfBuWXmg8CW8GKAho5UUz7+U+aL6fsNVwZd9/nVt9orexePci
 5xnNOTuL0+62Vv6BEkP3DUhTtb1J+plSYEiuPstsLzSEnEEbLz8tgLFIorrwTsg9NFPJ
 x0BhkCRVCl+qo+F5n1KLu6WZF1uEbHD64gfeKnOEDKeHH29zBh1lpf8TrwleGnGzdM0t
 LHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731009304; x=1731614104;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2TPajN/xK866wB9/V0io4yin6lsJZUCZq19AIoNDrlE=;
 b=xDuNlR2s+swb6/IYAxMGgYUUIN+wnFsxHrm1yy4D0LME3imfSWtrnHsDsMPoH0pY3n
 /r72H9x1ETQsnOZ/70Ahf4gWDE3uUqG79fuId2CHjLschWGQj2ELZXxVIdrfi1CL/NH2
 DYWumL/55lYv41PMkylaUQMN5QXWupeaaPPW/TTTSkH/Skn/QI3uwqvgOc+AU+FP5Gh1
 A5+08ySScFZIrJgFYDpvlr+sW7KmSQ5oXk4SA/UGqEeN85ZWk0J7Fkq1fZwj2SJj7Jj1
 8vanN1NYn71I3eLIvQpPqOIn/XnWvSG7l7OLoxuCXm2rf8FChhuYDQXhJ9T6OeMtTLR6
 NmMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+h4g+Z8bt5JYeMhxMqfk9wMwxdwCXxMGQF6dmTW1k9A1K+cydqnuaJdFpVWugFWZw7aBAIXk/phw4@nongnu.org
X-Gm-Message-State: AOJu0YyFodMbnDWBmTBsLHzG4NMX/S9iTpMGVPwWvVbMst6Kb1/rtKuA
 krGUeploSuBuLDceuWFk8p011sEgx7d2f7Zg+HUCAcLeLPxxG8O/mQpJqMxOQNIwLVNeERlx1TK
 Aig==
X-Google-Smtp-Source: AGHT+IEzEwAfAp07uy20252K/bFORWiekex+xIIr144a5YKUpOP1oPmKiItVm5RBIBNDcMtB/WWZ/cyXDJs=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:e14])
 (user=titusr job=sendgmr) by 2002:a05:690c:6908:b0:6ea:71c3:6cc3
 with SMTP id
 00721157ae682-6eaddfe2f18mr907b3.8.1731009304063; Thu, 07 Nov 2024 11:55:04
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:54:53 +0000
In-Reply-To: <20241107195453.2684138-1-titusr@google.com>
Mime-Version: 1.0
References: <20241107195453.2684138-1-titusr@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107195453.2684138-7-titusr@google.com>
Subject: [PATCH 6/6] hw/arm: add Quanta GSZ bmc machine
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3GBstZwYKCkMynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

This patch adds the quanta-gsz-bmc target, a current Google machine of
the day. This machine will be used as a platform to enable features such
as the PECI bmc interface, and Intel eSPI virtual wire interface in
QEMU.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/arm/npcm7xx_boards.c | 160 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index e229efb447..85c3f8e9a0 100644
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
@@ -269,6 +271,129 @@ static void quanta_gsj_fan_init(NPCM7xxMachine *machine, NPCM7xxState *soc)
     npcm7xx_connect_pwm_fan(soc, &splitter[2], 0x05, 1);
 }
 
+static void quanta_gsz_i2c_init(NPCM7xxState *soc)
+{
+    DeviceState *dev;
+    I2CSlave *i2c_mux;
+
+    /* i2c1 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548,
+                                      0x75);
+    /* pca6416@0x20 */
+    dev = DEVICE(i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3),
+                                         "pca6416", 0x20));
+    object_property_set_uint(OBJECT(dev), "gpio_config", 0xF00, &error_abort);
+    object_property_set_uint(OBJECT(dev), "gpio_input", 0xF00, &error_abort);
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
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
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
+    dev = DEVICE(i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3),
+                                         "pca6416", 0x20));
+    object_property_set_uint(OBJECT(dev), "gpio_config", 0x4000, &error_abort);
+    object_property_set_uint(OBJECT(dev), "gpio_input", 0x4000, &error_abort);
+
+    dev = DEVICE(i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4),
+                                         "pca6416", 0x20));
+    object_property_set_uint(OBJECT(dev), "gpio_config", 0xFFFF, &error_abort);
+    object_property_set_uint(OBJECT(dev), "gpio_input", 0x0000, &error_abort);
+
+    /* pdb_fru */
+    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 6), 0x55, 8192);
+
+    /* i2c5 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 5), TYPE_PCA9548,
+                                      0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
+
+    /* i2c6 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6), TYPE_PCA9548,
+                                      0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
+
+    /* i2c7 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 7), TYPE_PCA9548,
+                                      0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
+
+    /* i2c8 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 8), TYPE_PCA9548,
+                                      0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
+
+    /* i2c9 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 9), TYPE_PCA9548,
+                                      0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
+
+    /* i2c10 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 10),
+                                      TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1), "pca9538", 0x72);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
+    /* i2c11 */
+    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 11),
+                                      TYPE_PCA9548, 0x77);
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "pca9538", 0x72);
+
+    /* i2c12 */
+
+    /* i2c13 */
+    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 13), "pca6416", 0x22);
+
+    /* i2c14 */
+    /* LEDs and PE Resets */
+    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 14), "pca6416", 0x20);
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
@@ -392,6 +517,25 @@ static void quanta_gsj_init(MachineState *machine)
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
@@ -496,6 +640,18 @@ static void gsj_machine_class_init(ObjectClass *oc, void *data)
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
@@ -548,6 +704,10 @@ static const TypeInfo npcm7xx_machine_types[] = {
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
2.47.0.277.g8800431eea-goog


