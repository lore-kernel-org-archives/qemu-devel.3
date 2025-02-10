Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD73C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadR-0001Rw-OX; Mon, 10 Feb 2025 15:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadO-00017Y-EZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadJ-0003mN-JD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so10910325e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220235; x=1739825035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY/Aa8TRMtVCjoaI8hBcz//02IxC64vepFfepGi7V0s=;
 b=fkbgK7roQeI5kXNnVb/76/Q+GYnX7/vUbUbpRhuWnPshLQiIFnWlYa33Lf2R9UMINy
 hdnrLP1wPqWou8Bcie678dVOHhRup02L2d5B5N81eFrug8oucUwSjkQ9DTkLlhoQOsPk
 KwMr5j42SjiCK5q04NTwBm0atwzsGl/xg5lTgMS/ErqnhftWNMEYT/Tx+XvfaF4LqDWr
 FJHyhwefCAcb+Cm29C/a3HYFlDfuBIgz9xRldSPlW0mjnrtPZiYafiZfBC9Ke0D6oDIi
 e25j295rK0ijKHmxZJHrPKOCS0cvAOmYs1gaiG7I+ht2vTGhm47twUx2m8wGjU5WpLvg
 eX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220235; x=1739825035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY/Aa8TRMtVCjoaI8hBcz//02IxC64vepFfepGi7V0s=;
 b=snPjBDSdSyXyHutEzkqfLapCiLArXxLVf07moL6ZHBIHUwY9sRvu50lKghOsrj4qsa
 sl4XsbUDG9TAuEqTACRYrYkpzFaR+00Uc+/b5R3qZPb1R4a6xH7LCIt3Uc1nuY/xxiVW
 Zy5XNT/d07ny993owW2CHeGoKlTtV+G3/iZ9tITkkmOlwIePhOdK9GkOmBs3mzJFUixl
 n8xFYwIN6QwJn2c6T2rcY1ehMdIXlrO1idsHCiic5AFlfKffU/E5Ib2Du8Nba81s8qsN
 xoIxkc8jGTkFJn5Zs3SOkLjCdvE2QmGceihaIhwpb1wx8X4LGfZC9xEBrsIoqqvEBz7w
 1A5A==
X-Gm-Message-State: AOJu0Yw8qF2YLVmOmT7mpHdaDrlxD4JSTQlcNCs+3sVmQOoZho+SU5ei
 git1lJix145WAD4fOO0yQ36jSFfr+zA0iYCvaZ4eltY9lqhts8k/UcvK8N/3vlhy0fUOhYoGov+
 UPxA=
X-Gm-Gg: ASbGncuZjWsm7BpNeG8ZcU3OHFzx8lp0HUeJcZlttOc0ph2jB80iaLBmszG2w155iqs
 J2qsUei5JhILV9OJ/BsURb7PhFNOY2pAh/j4jzncL9mE2JkEhwjlXtYDYFkAXxR9cR1CHv3m1qw
 iDgg0hpInN8Fzw9/d58tYZEKY/0b9e7LRT9n00aC6XAgwRbO4lFil12wgwKlVL6Q17OeW53M2en
 XmzA3QXCMQ7PG+kVaR/FfDTFA6TXOHv7Tpe0WC/M4prKGRy0M81HGUsP2FZA7uByQa5+YWNOrZ7
 exaKYrIViAjUC8erD8LJ/guJGB9JcdUSfI9WGk7VFF2VSaTz5T5F2N1R/A6hMi0n7Q==
X-Google-Smtp-Source: AGHT+IHd83ut9X0XRjhyaK141gUCz9S93zXhuCUiTmXsm6ztwqTwQENf7QGa8xJf+lrXgbRXJ0PtSQ==
X-Received: by 2002:a05:600c:310f:b0:439:48f6:dd6d with SMTP id
 5b1f17b1804b1-43948f6de9amr31479505e9.22.1739220234856; 
 Mon, 10 Feb 2025 12:43:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439492affe2sm23118305e9.28.2025.02.10.12.43.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 21/32] hw/boards: Explicit no_sdcard=false as ON_OFF_AUTO_OFF
Date: Mon, 10 Feb 2025 21:41:53 +0100
Message-ID: <20250210204204.54407-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Update MachineClass::no_sdcard default implicit AUTO
initialization to explicit OFF. This flag is consumed
in system/vl.c::qemu_disable_default_devices(). Use
this place to assert we don't have anymore AUTO state.

In hw/ppc/e500.c we add the ppce500_machine_class_init()
method to initialize once all the inherited classes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250204200934.65279-3-philmd@linaro.org>
---
 hw/alpha/dp264.c                         |  1 +
 hw/arm/aspeed.c                          | 21 +++++++++++++++++++++
 hw/arm/b-l475e-iot01a.c                  |  1 +
 hw/arm/bananapi_m2u.c                    |  1 +
 hw/arm/collie.c                          |  1 +
 hw/arm/cubieboard.c                      |  1 +
 hw/arm/digic_boards.c                    |  1 +
 hw/arm/exynos4_boards.c                  |  2 ++
 hw/arm/fby35.c                           |  1 +
 hw/arm/highbank.c                        |  2 ++
 hw/arm/imx25_pdk.c                       |  1 +
 hw/arm/integratorcp.c                    |  1 +
 hw/arm/kzm.c                             |  1 +
 hw/arm/mcimx6ul-evk.c                    |  1 +
 hw/arm/mcimx7d-sabre.c                   |  1 +
 hw/arm/microbit.c                        |  1 +
 hw/arm/mps2-tz.c                         |  4 ++++
 hw/arm/mps2.c                            |  4 ++++
 hw/arm/mps3r.c                           |  1 +
 hw/arm/msf2-som.c                        |  1 +
 hw/arm/musca.c                           |  2 ++
 hw/arm/musicpal.c                        |  1 +
 hw/arm/netduino2.c                       |  1 +
 hw/arm/netduinoplus2.c                   |  1 +
 hw/arm/npcm7xx_boards.c                  |  5 +++++
 hw/arm/olimex-stm32-h405.c               |  1 +
 hw/arm/omap_sx1.c                        |  2 ++
 hw/arm/orangepi.c                        |  1 +
 hw/arm/raspi.c                           |  5 +++++
 hw/arm/raspi4b.c                         |  1 +
 hw/arm/realview.c                        |  4 ++++
 hw/arm/sabrelite.c                       |  1 +
 hw/arm/sbsa-ref.c                        |  1 +
 hw/arm/stellaris.c                       |  2 ++
 hw/arm/stm32vldiscovery.c                |  1 +
 hw/arm/versatilepb.c                     |  2 ++
 hw/arm/vexpress.c                        |  2 ++
 hw/arm/virt.c                            |  1 +
 hw/arm/xen-pvh.c                         |  1 +
 hw/arm/xlnx-versal-virt.c                |  1 +
 hw/arm/xlnx-zcu102.c                     |  1 +
 hw/avr/arduino.c                         |  1 +
 hw/hppa/machine.c                        |  2 ++
 hw/i386/pc.c                             |  1 +
 hw/i386/x86.c                            |  1 +
 hw/i386/xen/xen-pvh.c                    |  1 +
 hw/loongarch/virt.c                      |  1 +
 hw/m68k/an5206.c                         |  1 +
 hw/m68k/mcf5208.c                        |  1 +
 hw/m68k/next-cube.c                      |  1 +
 hw/m68k/q800.c                           |  1 +
 hw/m68k/virt.c                           |  1 +
 hw/microblaze/petalogix_ml605_mmu.c      |  1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/microblaze/xlnx-zynqmp-pmu.c          |  1 +
 hw/mips/boston.c                         |  1 +
 hw/mips/fuloong2e.c                      |  1 +
 hw/mips/jazz.c                           |  2 ++
 hw/mips/loongson3_virt.c                 |  1 +
 hw/mips/malta.c                          |  1 +
 hw/mips/mipssim.c                        |  1 +
 hw/openrisc/openrisc_sim.c               |  1 +
 hw/openrisc/virt.c                       |  1 +
 hw/ppc/amigaone.c                        |  1 +
 hw/ppc/e500plat.c                        |  1 +
 hw/ppc/mac_newworld.c                    |  1 +
 hw/ppc/mac_oldworld.c                    |  1 +
 hw/ppc/mpc8544ds.c                       |  1 +
 hw/ppc/pegasos2.c                        |  1 +
 hw/ppc/pnv.c                             |  1 +
 hw/ppc/ppc405_boards.c                   |  1 +
 hw/ppc/ppc440_bamboo.c                   |  1 +
 hw/ppc/prep.c                            |  1 +
 hw/ppc/sam460ex.c                        |  1 +
 hw/ppc/spapr.c                           |  1 +
 hw/ppc/virtex_ml507.c                    |  1 +
 hw/remote/machine.c                      |  1 +
 hw/riscv/microchip_pfsoc.c               |  1 +
 hw/riscv/opentitan.c                     |  1 +
 hw/riscv/shakti_c.c                      |  1 +
 hw/riscv/sifive_e.c                      |  1 +
 hw/riscv/sifive_u.c                      |  1 +
 hw/riscv/spike.c                         |  1 +
 hw/riscv/virt.c                          |  1 +
 hw/rx/rx-gdbsim.c                        |  1 +
 hw/sh4/r2d.c                             |  1 +
 hw/sparc/leon3.c                         |  1 +
 hw/sparc/sun4m.c                         |  1 +
 hw/sparc64/niagara.c                     |  1 +
 hw/sparc64/sun4u.c                       |  2 ++
 hw/tricore/triboard.c                    |  1 +
 hw/tricore/tricore_testboard.c           |  1 +
 hw/xen/xen-pvh-common.c                  |  1 +
 hw/xenpv/xen_machine_pv.c                |  1 +
 hw/xtensa/sim.c                          |  1 +
 hw/xtensa/virt.c                         |  1 +
 hw/xtensa/xtfpga.c                       |  8 ++++++++
 system/vl.c                              |  1 +
 98 files changed, 152 insertions(+)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 570ea9edf24..b11e527be93 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -213,6 +213,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
     mc->default_ram_id = "ram";
     mc->default_nic = "e1000";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d9418e2b9f2..9d9c55adcdc 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1253,6 +1253,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size       = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1269,6 +1270,7 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 1;
     amc->i2c_init  = quanta_q71l_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size       = 128 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1287,6 +1289,7 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1305,6 +1308,7 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1321,6 +1325,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1338,6 +1343,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1354,6 +1360,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1371,6 +1378,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = tiogapass_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size       = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1387,6 +1395,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1403,6 +1412,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1423,6 +1433,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
                      ASPEED_MAC3_ON;
     amc->sdhci_wp_inverted = true;
     amc->i2c_init  = ast2600_evb_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1441,6 +1452,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = g220a_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1024 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1458,6 +1470,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1476,6 +1489,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = rainier_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1498,6 +1512,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init = fuji_bmc_i2c_init;
     amc->uart_default = ASPEED_DEV_UART1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1518,6 +1533,7 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = bletchley_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1559,6 +1575,7 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init  = fby35_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     /* FIXME: Replace this macro with something more general */
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
@@ -1641,6 +1658,7 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     amc->spi_model = "w25q256";
     amc->num_cs = 2;
     amc->macs_mask = 0;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
@@ -1669,6 +1687,7 @@ static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1689,6 +1708,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1708,6 +1728,7 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
+    mc->no_sdcard  = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index c9a5209216c..d43c84435b0 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -120,6 +120,7 @@ static void bl475e_machine_init(ObjectClass *oc, void *data)
     mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
     mc->init = bl475e_init;
     mc->valid_cpu_types = machine_valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 0a4b6f29b1c..3da6ec4a03c 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -141,6 +141,7 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "bpim2u.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index eaa5c52d45a..80bf12246a9 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -79,6 +79,7 @@ static void collie_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "strongarm.sdram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo collie_machine_typeinfo = {
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index b976727eefd..11d896f8322 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -122,6 +122,7 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "cubieboard.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 2492fafeb85..a6ccf7ef9b6 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -143,6 +143,7 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_size = 64 * MiB;
     mc->default_ram_id = "ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 2410e2a28e8..63e86e2c609 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -165,6 +165,7 @@ static void nuri_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo nuri_type = {
@@ -184,6 +185,7 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo smdkc210_type = {
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 83d08e578b7..9b448bf764d 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -170,6 +170,7 @@ static void fby35_class_init(ObjectClass *oc, void *data)
     mc->init = fby35_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 3;
 
     object_class_property_add_bool(oc, "execute-in-place",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 495704d9726..97477571e62 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -357,6 +357,7 @@ static void highbank_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo highbank_type = {
@@ -381,6 +382,7 @@ static void midway_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo midway_type = {
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index c9c2e5dd3b1..8f89e03332f 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -147,6 +147,7 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "imx25.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 4e1b8627d32..905a7c2aecf 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -688,6 +688,7 @@ static void integratorcp_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "integrator.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 08d2b3025cf..45b3b08eb80 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,6 +137,7 @@ static void kzm_machine_init(MachineClass *mc)
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("kzm", kzm_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 690cb64ef36..49520b47f18 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -74,5 +74,6 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
     mc->default_ram_id = "mcimx6ul-evk.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index b3e8e50779f..da32fdd29d0 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -74,5 +74,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
     mc->default_ram_id = "mcimx7d-sabre.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 3f56fb45ce1..9d32ae5bd51 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -67,6 +67,7 @@ static void microbit_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "BBC micro:bit (Cortex-M0)";
     mc->init = microbit_init;
     mc->max_cpus = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo microbit_info = {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 13ed868b6b9..10626120368 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1320,6 +1320,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN505;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41045050;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1354,6 +1355,7 @@ static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN521;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41045210;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1388,6 +1390,7 @@ static void mps3tz_an524_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN524;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41045240;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1427,6 +1430,7 @@ static void mps3tz_an547_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN547;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m55");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41055470;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = 25 * 1000 * 1000; /* 25MHz */
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 3f8db0cab60..2bce37644e2 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -487,6 +487,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN385;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41043850;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -506,6 +507,7 @@ static void mps2_an386_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN386;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41043860;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -525,6 +527,7 @@ static void mps2_an500_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN500;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m7");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41045000;
     mmc->psram_base = 0x60000000;
     mmc->ethernet_base = 0xa0000000;
@@ -544,6 +547,7 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN511;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->scc_id = 0x41045110;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 1bddb5e822f..ae70ebe8604 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -618,6 +618,7 @@ static void mps3r_an536_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 2;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-r52");
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->raminfo = an536_raminfo;
     mps3r_set_default_ram_info(mmc);
 }
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 9b20f1e2c98..349a96a0b5d 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -106,6 +106,7 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index e9c092abc3d..89451b96843 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -615,6 +615,7 @@ static void musca_a_class_init(ObjectClass *oc, void *data)
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Musca-A board (dual Cortex-M33)";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->type = MUSCA_A;
     mmc->init_svtor = 0x10200000;
     mmc->sram_addr_width = 15;
@@ -629,6 +630,7 @@ static void musca_b1_class_init(ObjectClass *oc, void *data)
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Musca-B1 board (dual Cortex-M33)";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mmc->type = MUSCA_B1;
     /*
      * This matches the DAPlink firmware which boots from QSPI. There
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 48a32c24079..d5ebfabe3f9 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1342,6 +1342,7 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_size = MP_RAM_DEFAULT_SIZE;
     mc->default_ram_id = "musicpal.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index df793c77fe1..9ca0ee6a345 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -63,6 +63,7 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->init = netduino2_init;
     mc->valid_cpu_types = valid_cpu_types;
     mc->ignore_memory_transaction_failures = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 81b6334cf72..abe60607658 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -63,6 +63,7 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
     mc->init = netduinoplus2_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 7727e0dc4bb..38b8f02364f 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -481,6 +481,7 @@ static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Nuvoton NPCM750 Evaluation Board (Cortex-A9)";
     mc->init = npcm750_evb_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 512 * MiB;
 };
 
@@ -493,6 +494,7 @@ static void gsj_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Quanta GSJ (Cortex-A9)";
     mc->init = quanta_gsj_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 512 * MiB;
 };
 
@@ -505,6 +507,7 @@ static void gbs_bmc_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Quanta GBS (Cortex-A9)";
     mc->init = quanta_gbs_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
 }
 
@@ -517,6 +520,7 @@ static void kudo_bmc_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Kudo BMC (Cortex-A9)";
     mc->init = kudo_bmc_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
 };
 
@@ -529,6 +533,7 @@ static void mori_bmc_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Mori BMC (Cortex-A9)";
     mc->init = mori_bmc_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_size = 1 * GiB;
 }
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 1f15620f9fd..01ae12fa4ac 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -66,6 +66,7 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 623ebd66395..8170669db1f 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -216,6 +216,7 @@ static void sx1_machine_v2_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo sx1_machine_v2_type = {
@@ -234,6 +235,7 @@ static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo sx1_machine_v1_type = {
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 77e328191d7..76ab214853d 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -121,6 +121,7 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "orangepi.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a7a662f40db..176c324cf82 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -342,6 +342,7 @@ static void raspi0_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     rmc->board_rev = 0x920092; /* Revision 1.2 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -351,6 +352,7 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     rmc->board_rev = 0x900021; /* Revision 1.1 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -360,6 +362,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     rmc->board_rev = 0xa21041;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -370,6 +373,7 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -379,6 +383,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 1264e0d6eed..37eef378888 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -118,6 +118,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
 #endif
     raspi_machine_class_common_init(mc, rmc->board_rev);
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->init = raspi4b_machine_init;
 }
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 9900a98f3b8..4bc8f3956f3 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -415,6 +415,7 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -435,6 +436,7 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -453,6 +455,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->init = realview_pb_a8_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -472,6 +475,7 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 1eb47042eca..8d57653ab34 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -110,6 +110,7 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "sabrelite.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e720de30641..41dba85f44c 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -900,6 +900,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_nic = "e1000e";
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 47c1cfa0485..ef3fd508ba1 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1421,6 +1421,7 @@ static void lm3s811evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s811evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo lm3s811evb_type = {
@@ -1441,6 +1442,7 @@ static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s6965evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo lm3s6965evb_type = {
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index e6c1f5b8d7d..01b4afcb1a0 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -66,6 +66,7 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index bc4522989ec..def3da4a344 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -419,6 +419,7 @@ static void versatilepb_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -439,6 +440,7 @@ static void versatileab_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index b886d16c023..06ec78e6eb8 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -803,6 +803,7 @@ static void vexpress_a9_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ARM Versatile Express for Cortex-A9";
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     vmc->daughterboard = &a9_daughterboard;
 }
@@ -818,6 +819,7 @@ static void vexpress_a15_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ARM Versatile Express for Cortex-A15";
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     vmc->daughterboard = &a15_daughterboard;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3448200e3bf..cb2a626d2d2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3125,6 +3125,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #endif
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index d1509bd235d..e49ab0e7f57 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -75,6 +75,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      * mc->max_cpus, QEMU will bail out with an error message.
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 1401d37959e..8a1cdb037ca 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -818,6 +818,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_id = "ddr";
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 70fb444bbd9..311d8f1cad4 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -280,6 +280,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_ram_id = "ddr-ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", zcu102_get_secure,
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 48ef478346e..1801074a421 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -67,6 +67,7 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c5f247633eb..363ca89ca1c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -704,6 +704,7 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
@@ -740,6 +741,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0eb52d315bb..b01de3a1737 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1799,6 +1799,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
     mc->default_ram_id = "pc.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 69bfc00b9a5..e3b92fcb744 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,6 +382,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 33c10279763..33e5882c2d3 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -82,6 +82,7 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Xen PVH x86 machine";
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
     mc->max_cpus = HVM_MAX_VCPUS;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 63fa0f4e32a..d850c87bbc8 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1471,6 +1471,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index d97399b882b..286c3bac2ad 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -99,6 +99,7 @@ static void an5206_machine_init(MachineClass *mc)
     mc->init = an5206_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
     mc->default_ram_id = "an5206.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("an5206", an5206_machine_init)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 75cc076f787..a0c90d111e6 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -398,6 +398,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->is_default = true;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
     mc->default_ram_id = "mcf5208.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0570e4a76f1..06a4d825e71 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1359,6 +1359,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
     mc->no_cdrom = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo next_typeinfo = {
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index aeed4c8ddb8..21fa56e7a9c 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -743,6 +743,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_add_audiodev_property(mc);
     compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index d967bdd7438..a1bd9c432d2 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -318,6 +318,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_id = "m68k_virt.ram";
 }
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index a795c6385b4..a21112f17c5 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -223,6 +223,7 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
 #endif
     mc->init = petalogix_ml605_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 96aed4ed1a3..d68307f562e 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -146,6 +146,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index bdbf7328bf4..14386785f85 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -188,6 +188,7 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
 #endif
     mc->init = xlnx_zynqmp_pmu_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 364c328032a..bd9059a2070 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -842,6 +842,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_ram_id = "boston.ddr";
     mc->max_cpus = 16;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("boston", boston_mach_class_init)
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 646044e2749..83e95c3b20e 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -335,6 +335,7 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index c89610639a9..326f60c448b 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -424,6 +424,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -441,6 +442,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo mips_pica61_type = {
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 831fddb1bd7..f44932b331e 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -679,6 +679,7 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1600 * MiB;
     mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo loongson3_machine_types[] = {
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 8e9cea70b13..13811f89f91 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1306,6 +1306,7 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_malta.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     compat_props_add(mc->compat_props, malta_compat, malta_compat_len);
 }
 
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index c530688e769..f0d06ab549c 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -247,6 +247,7 @@ static void mips_mipssim_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_mipssim.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index e0da4067ba3..b9d71ea0c3b 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -368,6 +368,7 @@ static void openrisc_sim_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = OR1KSIM_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 7b60bf85094..d250e2ab21f 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -554,6 +554,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index b02792221cc..39449e3632d 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -173,6 +173,7 @@ static void amigaone_machine_init(MachineClass *mc)
     mc->default_display = "std";
     mc->default_ram_id = "ram";
     mc->default_ram_size = 512 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("amigaone", amigaone_machine_init)
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 70a80333733..0b91d422aa1 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -100,6 +100,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index cb3dc3ab482..da53eb11ed9 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -580,6 +580,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_display = "std";
     mc->default_nic = "sungem";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->kvm_type = core99_kvm_type;
 #ifdef TARGET_PPC64
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0dbcea035c3..b23bfff696e 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -427,6 +427,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->default_nic = "ne2k_pci";
     mc->ignore_boot_device_suffixes = true;
     mc->default_ram_id = "ppc_heathrow.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     fwc->get_dev_path = heathrow_fw_dev_path;
 }
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index d74af766eed..0fa3a1b7767 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -62,6 +62,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index b057672e829..03ddbb96b66 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -604,6 +604,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
     mc->default_ram_id = "pegasos2.ram";
     mc->default_ram_size = 512 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_add_audiodev_property(mc);
 
     vhc->cpu_in_nested = pegasos2_cpu_in_nested;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11fd477b71b..70203449fda 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2878,6 +2878,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     /* Pnv provides a AHCI device for storage */
     mc->block_default_type = IF_IDE;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_boot_order = NULL;
     /*
      * RAM defaults to less than 2048 for 32-bit hosts, and large
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 969cac345ac..c602d608176 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -351,6 +351,7 @@ static void ppc405_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->default_ram_id = "ppc405.ram";
     mc->deprecation_reason = "machine is old and unmaintained";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo ppc405_machine_type = {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 099fda39092..5b2d52032f7 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -268,6 +268,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
     mc->default_ram_id = "ppc4xx.sdram";
     mc->default_nic = "e1000";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3e68d8e6e20..998e8ecd426 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -428,6 +428,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 3ecae6a9504..a1b1fc8724a 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -524,6 +524,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc4xx.sdram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f3a4b4235d4..fa030d52767 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4594,6 +4594,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc_spapr.ram";
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f87c221d076..157aaf9449f 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -289,6 +289,7 @@ static void virtex_machine_init(MachineClass *mc)
     mc->init = virtex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
     mc->default_ram_id = "ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index fdc6c441bbd..1f7b0b96dd4 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -128,6 +128,7 @@ static void remote_machine_class_init(ObjectClass *oc, void *data)
 
     mc->init = remote_machine_init;
     mc->desc = "Experimental remote machine";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     hc->unplug = remote_machine_dev_unplug_cb;
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index ec7e2e42264..2417342a717 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -650,6 +650,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /*
      * Map 513 MiB high memory, the minimum required high memory size, because
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index b9e56235d87..3b26e1f53bc 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -121,6 +121,7 @@ static void opentitan_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void lowrisc_ibex_soc_init(Object *obj)
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index e2242b97d0c..2f59c86bf0c 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -84,6 +84,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "riscv.shakti.c.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo shakti_c_machine_type_info = {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 73d3b74281c..56a2ca7cabb 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -153,6 +153,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_E_CPU;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     object_class_property_add_bool(oc, "revb", sifive_e_machine_get_revb,
                                    sifive_e_machine_set_revb);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9a20bcbf7fb..fd57d02dca8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -724,6 +724,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_U_CPU;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "riscv.sifive.u.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     object_class_property_add_bool(oc, "start-in-flash",
                                    sifive_u_machine_get_start_in_flash,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 74a20016f14..a0fa727f6bf 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -358,6 +358,7 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv.spike.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 241389d72f8..d9fc7cdf9ac 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1918,6 +1918,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 88c8f12c101..9c3ae60bf80 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -166,6 +166,7 @@ static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RX62N_CPU;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "ext-sdram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void rx62n7_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index d68c94e82ef..6ef552ae536 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -383,6 +383,7 @@ static void r2d_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = TYPE_SH7751R_CPU;
     mc->default_nic = "rtl8139";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 0aeaad3becc..e99d6d71e8f 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -440,6 +440,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
     mc->max_cpus = MAX_CPUS;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a48d3622c5a..19a2a9f2ff6 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1113,6 +1113,7 @@ static void sun4m_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_display = "tcx";
     mc->default_ram_id = "sun4m.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void ss5_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 805ba6b1e3d..409c67b1b4e 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -167,6 +167,7 @@ static void niagara_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
     mc->default_ram_id = "sun4v-partition.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo niagara_type = {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8ab5cf0461f..eaf3d42bd0a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -809,6 +809,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     fwc->get_dev_path = sun4u_fw_dev_path;
     compat_props_add(mc->compat_props, hw_compat_sparc64, hw_compat_sparc64_len);
 }
@@ -836,6 +837,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo sun4v_type = {
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index f5baa8ccbb3..3cd93daf6a6 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -73,6 +73,7 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->init        = triboard_machine_init;
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     amc->soc_name   = "tc277d-soc";
 };
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 3facfdfd611..29718051702 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -111,6 +111,7 @@ static void ttb_machine_init(MachineClass *mc)
     mc->desc = "a minimal TriCore board";
     mc->init = tricoreboard_init;
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 9c21fa858d3..ed42e4b624c 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -381,6 +381,7 @@ static void xen_pvh_class_init(ObjectClass *oc, void *data)
     mc->default_machine_opts = "accel=xen";
     /* Set to zero to make sure that the real ram size is passed. */
     mc->default_ram_size = 0;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xen_pvh_info = {
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 99c02492ef9..a05713e5daa 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -67,6 +67,7 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->init = xen_init_pv;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("xenpv", xenpv_machine_init)
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 1cea29c66d4..6c86d4939f4 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -125,6 +125,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->max_cpus = 4;
     mc->no_serial = 1;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index b08404fc17c..ffa6f210637 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -122,6 +122,7 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("virt", xtensa_virt_machine_init)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3f3677f1c9a..2b5f20acefc 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -594,6 +594,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 64 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx60_type = {
@@ -611,6 +612,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 64 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -628,6 +630,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 96 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx200_type = {
@@ -645,6 +648,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 96 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -662,6 +666,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_ml605_type = {
@@ -679,6 +684,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -696,6 +702,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_kc705_type = {
@@ -713,6 +720,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
diff --git a/system/vl.c b/system/vl.c
index a845f692af1..a89f905f835 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1346,6 +1346,7 @@ static void qemu_disable_default_devices(void)
     if (!has_defaults || machine_class->no_cdrom) {
         default_cdrom = 0;
     }
+    assert(machine_class->no_sdcard != ON_OFF_AUTO_AUTO);
     if (!has_defaults || machine_class->no_sdcard == ON_OFF_AUTO_ON) {
         default_sdcard = 0;
     }
-- 
2.47.1


