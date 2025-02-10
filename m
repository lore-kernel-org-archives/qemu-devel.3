Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFD0C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadX-000233-DW; Mon, 10 Feb 2025 15:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadT-0001m1-L7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:07 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadO-0003nO-JR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:07 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso32071815e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220241; x=1739825041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mt6bq8gBBPqPqptoVaX11LBUBlu2K6iSCmAHeS7rR5w=;
 b=d5XZO8hHWXeKwD+zM6Oj/svINJYwloAPpRQ4Kq3sdvHQX2JE6ChCRIvH+8aSxu52/N
 BYEDJ8NviQ8GlwR1hKU1l29xnD+7jcp8NMm0F1QuLwv/RB3FkM+Xp3u+bXMUlqOoKAes
 jcP3U2baCSFxuwLJtHDeuURwZXREo1j7RwSTYO746qg0RCZe4E53S47HqRKShOxEPmbI
 EI3/EySxXG4JZkfQKCFiPs0ycBaCytxdtOlu54EoF6HZ+Z6jF+0NwkPrpJrHNCPak2Wn
 hHNEkG8CywAH0XOVaYqxC7VHtIq48ejpdnKqk2JOjM4anFywN65dbK1Bpz3s0dVmSsqF
 RBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220241; x=1739825041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mt6bq8gBBPqPqptoVaX11LBUBlu2K6iSCmAHeS7rR5w=;
 b=QGy/xJC6cXYBRNEqMcJS35W+AMRNn9vqLGhbLRZtTIkgJRuL0lSWTUD2/Ev98WOS0W
 HdsOUFj1TFJqZTsoKhvqiNxRnNFVjcWkXkf7d8uW5qUQGDOSyWca4j9KIxUopWpPyuOj
 6f/mDHT39FuILnrm6tSuVwb4QNF6oShB0IA3guryU9H28IFMEF1djOJl0Lmg9gcpRrIg
 tcfoeomA0bfO3kXfe7lVBVmtD4VXo+FPEfsTsQOoHfgENbaIqK2bJgsfjhJXQebBsAM7
 xzm5a29cPkDyUZ5JaHktmpHgc/xFg8Cavo+gEfXZynV597NfEXeFVwalnrSUlf0wjcfw
 p0Ew==
X-Gm-Message-State: AOJu0YxuuM7l/VYqE91mAD7IznngnFdVcpT3nue1lLAxGAKh4zGXEe2S
 E6GKzC6sRUgkPSOtJWVyPMC/0/idWml4T8KI3zxFttsHH8Wj6feMHbTJju9IGfqKQYj2vihJYGK
 8n+s=
X-Gm-Gg: ASbGnctXw+ehYvhqNOF7vECU6YrsuTD0KhW6ao1X9OEPN8ffY+tUz0UMlSB2t2p1lPP
 f6yo05EpFW+BkzH73jExkC2I7WdS4DBkeohz7GlVASN2P/kxuKr/r3YwRW0aeeummS9oXhrO6Zm
 /ZInxpcTEnwYXeV/n0n5HIUhdNGAVFpZKhKd4LL8hAriX+slbRPEH5d3gL2xAkvzO7+Cr5Gpr5V
 exF274Ou4Difgesk4UcZD+0iKVlvzklQSnLBDXH6tzaoPmf/RGRCo93PgCiIFYc4tIJYYXcihXe
 o0wvxkpdrtE92pPYQct3y8/OjHRsZLjcglEDcaJI4cyo+SnxWdyQB5YiVfE6A6/pAw==
X-Google-Smtp-Source: AGHT+IFAiTNTkYCIm2SOBS9nHQS0XZomk+pRvld+Q8vWZ/k3Pi7dhCwsdoG2XGpiPY7eTyDM6oAsNw==
X-Received: by 2002:a05:600c:3849:b0:439:4a10:48e8 with SMTP id
 5b1f17b1804b1-4394a104adcmr32251685e9.6.1739220239956; 
 Mon, 10 Feb 2025 12:43:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dce18d6f9sm9564066f8f.29.2025.02.10.12.43.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 22/32] hw/boards: Rename no_sdcard -> auto_create_sdcard
Date: Mon, 10 Feb 2025 21:41:54 +0100
Message-ID: <20250210204204.54407-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Invert the 'no_sdcard' logic, renaming it as the more explicit
"auto_create_sdcard". Machines are supposed to create a SD Card
drive when this flag is set. In many cases it doesn't make much
sense (as boards don't expose SD Card host controller), but this
is patch only aims to expose that nonsense; so no logical change
intended (mechanical patch using gsed).

Most of the changes are:

  -    mc->no_sdcard = ON_OFF_AUTO_OFF;
  +    mc->auto_create_sdcard = true;

Except in
 . hw/core/null-machine.c
 . hw/arm/xilinx_zynq.c
 . hw/s390x/s390-virtio-ccw.c
where the disabled option is manually removed (since default):

  -    mc->no_sdcard = ON_OFF_AUTO_ON;
  +    mc->auto_create_sdcard = false;
  -    mc->auto_create_sdcard = false;

and in system/vl.c we change the 'default_sdcard' type to boolean.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250204200934.65279-4-philmd@linaro.org>
---
 include/hw/boards.h                      |  2 +-
 hw/alpha/dp264.c                         |  2 +-
 hw/arm/aspeed.c                          | 42 ++++++++++++------------
 hw/arm/b-l475e-iot01a.c                  |  2 +-
 hw/arm/bananapi_m2u.c                    |  2 +-
 hw/arm/collie.c                          |  2 +-
 hw/arm/cubieboard.c                      |  2 +-
 hw/arm/digic_boards.c                    |  2 +-
 hw/arm/exynos4_boards.c                  |  4 +--
 hw/arm/fby35.c                           |  2 +-
 hw/arm/highbank.c                        |  4 +--
 hw/arm/imx25_pdk.c                       |  2 +-
 hw/arm/integratorcp.c                    |  2 +-
 hw/arm/kzm.c                             |  2 +-
 hw/arm/mcimx6ul-evk.c                    |  2 +-
 hw/arm/mcimx7d-sabre.c                   |  2 +-
 hw/arm/microbit.c                        |  2 +-
 hw/arm/mps2-tz.c                         |  8 ++---
 hw/arm/mps2.c                            |  8 ++---
 hw/arm/mps3r.c                           |  2 +-
 hw/arm/msf2-som.c                        |  2 +-
 hw/arm/musca.c                           |  4 +--
 hw/arm/musicpal.c                        |  2 +-
 hw/arm/netduino2.c                       |  2 +-
 hw/arm/netduinoplus2.c                   |  2 +-
 hw/arm/npcm7xx_boards.c                  | 10 +++---
 hw/arm/olimex-stm32-h405.c               |  2 +-
 hw/arm/omap_sx1.c                        |  4 +--
 hw/arm/orangepi.c                        |  2 +-
 hw/arm/raspi.c                           | 10 +++---
 hw/arm/raspi4b.c                         |  2 +-
 hw/arm/realview.c                        |  8 ++---
 hw/arm/sabrelite.c                       |  2 +-
 hw/arm/sbsa-ref.c                        |  2 +-
 hw/arm/stellaris.c                       |  4 +--
 hw/arm/stm32vldiscovery.c                |  2 +-
 hw/arm/versatilepb.c                     |  4 +--
 hw/arm/vexpress.c                        |  4 +--
 hw/arm/virt.c                            |  2 +-
 hw/arm/xen-pvh.c                         |  2 +-
 hw/arm/xilinx_zynq.c                     |  1 -
 hw/arm/xlnx-versal-virt.c                |  2 +-
 hw/arm/xlnx-zcu102.c                     |  2 +-
 hw/avr/arduino.c                         |  2 +-
 hw/core/null-machine.c                   |  1 -
 hw/hppa/machine.c                        |  4 +--
 hw/i386/pc.c                             |  2 +-
 hw/i386/x86.c                            |  2 +-
 hw/i386/xen/xen-pvh.c                    |  2 +-
 hw/loongarch/virt.c                      |  2 +-
 hw/m68k/an5206.c                         |  2 +-
 hw/m68k/mcf5208.c                        |  2 +-
 hw/m68k/next-cube.c                      |  2 +-
 hw/m68k/q800.c                           |  2 +-
 hw/m68k/virt.c                           |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |  2 +-
 hw/mips/boston.c                         |  2 +-
 hw/mips/fuloong2e.c                      |  2 +-
 hw/mips/jazz.c                           |  4 +--
 hw/mips/loongson3_virt.c                 |  2 +-
 hw/mips/malta.c                          |  2 +-
 hw/mips/mipssim.c                        |  2 +-
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/openrisc/virt.c                       |  2 +-
 hw/ppc/amigaone.c                        |  2 +-
 hw/ppc/e500plat.c                        |  2 +-
 hw/ppc/mac_newworld.c                    |  2 +-
 hw/ppc/mac_oldworld.c                    |  2 +-
 hw/ppc/mpc8544ds.c                       |  2 +-
 hw/ppc/pegasos2.c                        |  2 +-
 hw/ppc/pnv.c                             |  2 +-
 hw/ppc/ppc405_boards.c                   |  2 +-
 hw/ppc/ppc440_bamboo.c                   |  2 +-
 hw/ppc/prep.c                            |  2 +-
 hw/ppc/sam460ex.c                        |  2 +-
 hw/ppc/spapr.c                           |  2 +-
 hw/ppc/virtex_ml507.c                    |  2 +-
 hw/remote/machine.c                      |  2 +-
 hw/riscv/microchip_pfsoc.c               |  2 +-
 hw/riscv/opentitan.c                     |  2 +-
 hw/riscv/shakti_c.c                      |  2 +-
 hw/riscv/sifive_e.c                      |  2 +-
 hw/riscv/sifive_u.c                      |  2 +-
 hw/riscv/spike.c                         |  2 +-
 hw/riscv/virt.c                          |  2 +-
 hw/rx/rx-gdbsim.c                        |  2 +-
 hw/s390x/s390-virtio-ccw.c               |  1 -
 hw/sh4/r2d.c                             |  2 +-
 hw/sparc/leon3.c                         |  2 +-
 hw/sparc/sun4m.c                         |  2 +-
 hw/sparc64/niagara.c                     |  2 +-
 hw/sparc64/sun4u.c                       |  4 +--
 hw/tricore/triboard.c                    |  2 +-
 hw/tricore/tricore_testboard.c           |  2 +-
 hw/xen/xen-pvh-common.c                  |  2 +-
 hw/xenpv/xen_machine_pv.c                |  2 +-
 hw/xtensa/sim.c                          |  2 +-
 hw/xtensa/virt.c                         |  2 +-
 hw/xtensa/xtfpga.c                       | 16 ++++-----
 system/vl.c                              |  9 +++--
 102 files changed, 156 insertions(+), 160 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index d61b0a47780..9360d1ce394 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -285,7 +285,7 @@ struct MachineClass {
         no_cdrom:1,
         pci_allow_0_address:1,
         legacy_fw_cfg_order:1;
-    OnOffAuto no_sdcard;
+    bool auto_create_sdcard;
     bool is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index b11e527be93..14b942fd5a7 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -213,7 +213,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
     mc->default_ram_id = "ram";
     mc->default_nic = "e1000";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 9d9c55adcdc..f3ba90896c0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1253,7 +1253,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1270,7 +1270,7 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 1;
     amc->i2c_init  = quanta_q71l_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 128 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1289,7 +1289,7 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1308,7 +1308,7 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1325,7 +1325,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1343,7 +1343,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1360,7 +1360,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1378,7 +1378,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = tiogapass_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1395,7 +1395,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1412,7 +1412,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1433,7 +1433,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
                      ASPEED_MAC3_ON;
     amc->sdhci_wp_inverted = true;
     amc->i2c_init  = ast2600_evb_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1452,7 +1452,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = g220a_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1024 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1470,7 +1470,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1489,7 +1489,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = rainier_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1512,7 +1512,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init = fuji_bmc_i2c_init;
     amc->uart_default = ASPEED_DEV_UART1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1533,7 +1533,7 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1575,7 +1575,7 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init  = fby35_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     /* FIXME: Replace this macro with something more general */
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
@@ -1658,7 +1658,7 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     amc->spi_model = "w25q256";
     amc->num_cs = 2;
     amc->macs_mask = 0;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
@@ -1687,7 +1687,7 @@ static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1708,7 +1708,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1728,7 +1728,7 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
-    mc->no_sdcard  = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index d43c84435b0..f05ee0fee0f 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -120,7 +120,7 @@ static void bl475e_machine_init(ObjectClass *oc, void *data)
     mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
     mc->init = bl475e_init;
     mc->valid_cpu_types = machine_valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 3da6ec4a03c..4d84d10d24c 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -141,7 +141,7 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "bpim2u.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 80bf12246a9..864c66193b1 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -79,7 +79,7 @@ static void collie_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "strongarm.sdram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo collie_machine_typeinfo = {
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 11d896f8322..d665d4edd97 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -122,7 +122,7 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "cubieboard.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index a6ccf7ef9b6..f334c1fb02c 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -143,7 +143,7 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_size = 64 * MiB;
     mc->default_ram_id = "ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 63e86e2c609..43dc89d902e 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -165,7 +165,7 @@ static void nuri_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo nuri_type = {
@@ -185,7 +185,7 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo smdkc210_type = {
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 9b448bf764d..6d3663f14a1 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -170,7 +170,7 @@ static void fby35_class_init(ObjectClass *oc, void *data)
     mc->init = fby35_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 3;
 
     object_class_property_add_bool(oc, "execute-in-place",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 97477571e62..975fd7a094a 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -357,7 +357,7 @@ static void highbank_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo highbank_type = {
@@ -382,7 +382,7 @@ static void midway_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo midway_type = {
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 8f89e03332f..e95ea5e4e18 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -147,7 +147,7 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "imx25.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 905a7c2aecf..8aa2e6e98e3 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -688,7 +688,7 @@ static void integratorcp_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "integrator.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 45b3b08eb80..736eabab664 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,7 +137,7 @@ static void kzm_machine_init(MachineClass *mc)
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("kzm", kzm_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 49520b47f18..86982cb0772 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -74,6 +74,6 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
     mc->default_ram_id = "mcimx6ul-evk.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index da32fdd29d0..33119610113 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -74,6 +74,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
     mc->default_ram_id = "mcimx7d-sabre.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 9d32ae5bd51..fb099508324 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -67,7 +67,7 @@ static void microbit_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "BBC micro:bit (Cortex-M0)";
     mc->init = microbit_init;
     mc->max_cpus = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo microbit_info = {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 10626120368..91b8ae6d384 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1320,7 +1320,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN505;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045050;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1355,7 +1355,7 @@ static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN521;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045210;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1390,7 +1390,7 @@ static void mps3tz_an524_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN524;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045240;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1430,7 +1430,7 @@ static void mps3tz_an547_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN547;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m55");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41055470;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = 25 * 1000 * 1000; /* 25MHz */
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 2bce37644e2..40eb5d16187 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -487,7 +487,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN385;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41043850;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -507,7 +507,7 @@ static void mps2_an386_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN386;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41043860;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -527,7 +527,7 @@ static void mps2_an500_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN500;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m7");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045000;
     mmc->psram_base = 0x60000000;
     mmc->ethernet_base = 0xa0000000;
@@ -547,7 +547,7 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN511;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045110;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index ae70ebe8604..f26d1cfb2c4 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -618,7 +618,7 @@ static void mps3r_an536_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 2;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-r52");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->raminfo = an536_raminfo;
     mps3r_set_default_ram_info(mmc);
 }
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 349a96a0b5d..6d3f0a89e0b 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -106,7 +106,7 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 89451b96843..6f19b7d58a0 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -615,7 +615,7 @@ static void musca_a_class_init(ObjectClass *oc, void *data)
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Musca-A board (dual Cortex-M33)";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->type = MUSCA_A;
     mmc->init_svtor = 0x10200000;
     mmc->sram_addr_width = 15;
@@ -630,7 +630,7 @@ static void musca_b1_class_init(ObjectClass *oc, void *data)
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Musca-B1 board (dual Cortex-M33)";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mmc->type = MUSCA_B1;
     /*
      * This matches the DAPlink firmware which boots from QSPI. There
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d5ebfabe3f9..fd2975753ee 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1342,7 +1342,7 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_size = MP_RAM_DEFAULT_SIZE;
     mc->default_ram_id = "musicpal.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 9ca0ee6a345..fca32d45924 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -63,7 +63,7 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->init = netduino2_init;
     mc->valid_cpu_types = valid_cpu_types;
     mc->ignore_memory_transaction_failures = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index abe60607658..e1a59fb9e23 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -63,7 +63,7 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
     mc->init = netduinoplus2_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 38b8f02364f..eb28b97ad83 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -481,7 +481,7 @@ static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Nuvoton NPCM750 Evaluation Board (Cortex-A9)";
     mc->init = npcm750_evb_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
 };
 
@@ -494,7 +494,7 @@ static void gsj_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Quanta GSJ (Cortex-A9)";
     mc->init = quanta_gsj_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
 };
 
@@ -507,7 +507,7 @@ static void gbs_bmc_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Quanta GBS (Cortex-A9)";
     mc->init = quanta_gbs_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
 }
 
@@ -520,7 +520,7 @@ static void kudo_bmc_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Kudo BMC (Cortex-A9)";
     mc->init = kudo_bmc_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
 };
 
@@ -533,7 +533,7 @@ static void mori_bmc_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Mori BMC (Cortex-A9)";
     mc->init = mori_bmc_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
 }
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 01ae12fa4ac..23f686de876 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -66,7 +66,7 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 8170669db1f..c6b0bed0796 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -216,7 +216,7 @@ static void sx1_machine_v2_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo sx1_machine_v2_type = {
@@ -235,7 +235,7 @@ static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo sx1_machine_v1_type = {
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 76ab214853d..634af9b0a10 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -121,7 +121,7 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "orangepi.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 176c324cf82..dce35ca11aa 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -342,7 +342,7 @@ static void raspi0_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     rmc->board_rev = 0x920092; /* Revision 1.2 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -352,7 +352,7 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     rmc->board_rev = 0x900021; /* Revision 1.1 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -362,7 +362,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa21041;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -373,7 +373,7 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -383,7 +383,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 37eef378888..f6de103a3e1 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -118,7 +118,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
 #endif
     raspi_machine_class_common_init(mc, rmc->board_rev);
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->init = raspi4b_machine_init;
 }
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 4bc8f3956f3..436eef816ed 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -415,7 +415,7 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -436,7 +436,7 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -455,7 +455,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->init = realview_pb_a8_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -475,7 +475,7 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 8d57653ab34..df60d47c6fd 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -110,7 +110,7 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "sabrelite.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 41dba85f44c..02c72a62a37 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -900,7 +900,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_nic = "e1000e";
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index ef3fd508ba1..25283fd6233 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1421,7 +1421,7 @@ static void lm3s811evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s811evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo lm3s811evb_type = {
@@ -1442,7 +1442,7 @@ static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s6965evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo lm3s6965evb_type = {
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 01b4afcb1a0..a71da292b84 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -66,7 +66,7 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index def3da4a344..941616cd25b 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -419,7 +419,7 @@ static void versatilepb_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -440,7 +440,7 @@ static void versatileab_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 06ec78e6eb8..48e18a49d54 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -803,7 +803,7 @@ static void vexpress_a9_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ARM Versatile Express for Cortex-A9";
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     vmc->daughterboard = &a9_daughterboard;
 }
@@ -819,7 +819,7 @@ static void vexpress_a15_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ARM Versatile Express for Cortex-A15";
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     vmc->daughterboard = &a15_daughterboard;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cb2a626d2d2..192c2a5ac78 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3125,7 +3125,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #endif
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index e49ab0e7f57..ce4cc4fce93 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -75,7 +75,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      * mc->max_cpus, QEMU will bail out with an error message.
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 12418094f9d..3c6a4604cc9 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -463,7 +463,6 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
-    mc->no_sdcard = ON_OFF_AUTO_ON;
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 8a1cdb037ca..0c6f0359e3d 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -818,7 +818,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_id = "ddr";
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 311d8f1cad4..4fdb153e4d8 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -280,7 +280,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_ram_id = "ddr-ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", zcu102_get_secure,
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 1801074a421..5f30a7d5850 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -67,7 +67,7 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index b93056c0f7b..7f1fb562beb 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -53,7 +53,6 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_ON;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 363ca89ca1c..b4b238ed2c7 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -704,7 +704,7 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
@@ -741,7 +741,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b01de3a1737..f94272e66b0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1799,7 +1799,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
     mc->default_ram_id = "pc.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e3b92fcb744..790b1863f53 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,7 +382,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 33e5882c2d3..6f5b6a2b8f5 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -82,7 +82,7 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Xen PVH x86 machine";
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
     mc->max_cpus = HVM_MAX_VCPUS;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index d850c87bbc8..0eea84c9675 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1471,7 +1471,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 286c3bac2ad..19478705129 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -99,7 +99,7 @@ static void an5206_machine_init(MachineClass *mc)
     mc->init = an5206_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
     mc->default_ram_id = "an5206.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("an5206", an5206_machine_init)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index a0c90d111e6..9a8c551224f 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -398,7 +398,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->is_default = true;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
     mc->default_ram_id = "mcf5208.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 06a4d825e71..ee06a5e2e07 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1359,7 +1359,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
     mc->no_cdrom = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo next_typeinfo = {
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 21fa56e7a9c..f3cb8541b37 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -743,7 +743,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     machine_add_audiodev_property(mc);
     compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index a1bd9c432d2..69e8f53482d 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -318,7 +318,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_ram_id = "m68k_virt.ram";
 }
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index a21112f17c5..504968404fe 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -223,7 +223,7 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
 #endif
     mc->init = petalogix_ml605_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index d68307f562e..e4d3eececc5 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -146,7 +146,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 14386785f85..b40d82b396f 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -188,7 +188,7 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
 #endif
     mc->init = xlnx_zynqmp_pmu_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index bd9059a2070..66cdad639e8 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -842,7 +842,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_ram_id = "boston.ddr";
     mc->max_cpus = 16;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("boston", boston_mach_class_init)
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 83e95c3b20e..e10b5a27743 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -335,7 +335,7 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 326f60c448b..ad4561a51e6 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -424,7 +424,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -442,7 +442,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo mips_pica61_type = {
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f44932b331e..46c2e1e9de5 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -679,7 +679,7 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1600 * MiB;
     mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo loongson3_machine_types[] = {
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 13811f89f91..31ff279b4cb 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1306,7 +1306,7 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_malta.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     compat_props_add(mc->compat_props, malta_compat, malta_compat_len);
 }
 
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index f0d06ab549c..ff2b9050700 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -247,7 +247,7 @@ static void mips_mipssim_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_mipssim.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index b9d71ea0c3b..5e4686ba7a2 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -368,7 +368,7 @@ static void openrisc_sim_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = OR1KSIM_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index d250e2ab21f..2764e398a98 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -554,7 +554,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 39449e3632d..296c30da92f 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -173,7 +173,7 @@ static void amigaone_machine_init(MachineClass *mc)
     mc->default_display = "std";
     mc->default_ram_id = "ram";
     mc->default_ram_size = 512 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("amigaone", amigaone_machine_init)
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 0b91d422aa1..afad4802cae 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -100,7 +100,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index da53eb11ed9..869f3f7104b 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -580,7 +580,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_display = "std";
     mc->default_nic = "sungem";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->kvm_type = core99_kvm_type;
 #ifdef TARGET_PPC64
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index b23bfff696e..08e30a4a4e9 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -427,7 +427,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->default_nic = "ne2k_pci";
     mc->ignore_boot_device_suffixes = true;
     mc->default_ram_id = "ppc_heathrow.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     fwc->get_dev_path = heathrow_fw_dev_path;
 }
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 0fa3a1b7767..38bdf453165 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -62,7 +62,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 03ddbb96b66..479dcfe809f 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -604,7 +604,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
     mc->default_ram_id = "pegasos2.ram";
     mc->default_ram_size = 512 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     machine_add_audiodev_property(mc);
 
     vhc->cpu_in_nested = pegasos2_cpu_in_nested;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 70203449fda..15fbbf6c157 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2878,7 +2878,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     /* Pnv provides a AHCI device for storage */
     mc->block_default_type = IF_IDE;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_boot_order = NULL;
     /*
      * RAM defaults to less than 2048 for 32-bit hosts, and large
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index c602d608176..8946b5173c5 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -351,7 +351,7 @@ static void ppc405_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->default_ram_id = "ppc405.ram";
     mc->deprecation_reason = "machine is old and unmaintained";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo ppc405_machine_type = {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 5b2d52032f7..081a993ef02 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -268,7 +268,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
     mc->default_ram_id = "ppc4xx.sdram";
     mc->default_nic = "e1000";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 998e8ecd426..85bfc2fd4f0 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -428,7 +428,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index a1b1fc8724a..d9c871ef205 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -524,7 +524,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc4xx.sdram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fa030d52767..42b07fadd9d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4594,7 +4594,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc_spapr.ram";
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 157aaf9449f..e71d04d2ce1 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -289,7 +289,7 @@ static void virtex_machine_init(MachineClass *mc)
     mc->init = virtex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
     mc->default_ram_id = "ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index 1f7b0b96dd4..fa4a1bb815a 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -128,7 +128,7 @@ static void remote_machine_class_init(ObjectClass *oc, void *data)
 
     mc->init = remote_machine_init;
     mc->desc = "Experimental remote machine";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     hc->unplug = remote_machine_dev_unplug_cb;
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 2417342a717..9c846f9b5ba 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -650,7 +650,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     /*
      * Map 513 MiB high memory, the minimum required high memory size, because
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 3b26e1f53bc..d78a96c5354 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -121,7 +121,7 @@ static void opentitan_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static void lowrisc_ibex_soc_init(Object *obj)
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 2f59c86bf0c..efe814b5868 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -84,7 +84,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "riscv.shakti.c.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo shakti_c_machine_type_info = {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 56a2ca7cabb..164eb3ab83b 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -153,7 +153,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_E_CPU;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     object_class_property_add_bool(oc, "revb", sifive_e_machine_get_revb,
                                    sifive_e_machine_set_revb);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index fd57d02dca8..679f2024bc6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -724,7 +724,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_U_CPU;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "riscv.sifive.u.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 
     object_class_property_add_bool(oc, "start-in-flash",
                                    sifive_u_machine_get_start_in_flash,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index a0fa727f6bf..1ea35937e15 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -358,7 +358,7 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv.spike.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d9fc7cdf9ac..2aa420f6e55 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1918,7 +1918,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 9c3ae60bf80..de3b708bc57 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -166,7 +166,7 @@ static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RX62N_CPU;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "ext-sdram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static void rx62n7_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5f78c8d20ff..51ae0c133d8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -817,7 +817,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_cdrom = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_ON;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
     mc->smp_props.books_supported = true;
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 6ef552ae536..e34deb33dce 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -383,7 +383,7 @@ static void r2d_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = TYPE_SH7751R_CPU;
     mc->default_nic = "rtl8139";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index e99d6d71e8f..3bd24495758 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -440,7 +440,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
     mc->max_cpus = MAX_CPUS;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 19a2a9f2ff6..d555548a1ca 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1113,7 +1113,7 @@ static void sun4m_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_display = "tcx";
     mc->default_ram_id = "sun4m.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static void ss5_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 409c67b1b4e..37004b99c4e 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -167,7 +167,7 @@ static void niagara_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
     mc->default_ram_id = "sun4v-partition.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo niagara_type = {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index eaf3d42bd0a..6e9a3c5a2e5 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -809,7 +809,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     fwc->get_dev_path = sun4u_fw_dev_path;
     compat_props_add(mc->compat_props, hw_compat_sparc64, hw_compat_sparc64_len);
 }
@@ -837,7 +837,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo sun4v_type = {
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 3cd93daf6a6..d4550507a99 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -73,7 +73,7 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->init        = triboard_machine_init;
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
     amc->soc_name   = "tc277d-soc";
 };
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 29718051702..9299cd5394a 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -111,7 +111,7 @@ static void ttb_machine_init(MachineClass *mc)
     mc->desc = "a minimal TriCore board";
     mc->init = tricoreboard_init;
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index ed42e4b624c..9df50cd5382 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -381,7 +381,7 @@ static void xen_pvh_class_init(ObjectClass *oc, void *data)
     mc->default_machine_opts = "accel=xen";
     /* Set to zero to make sure that the real ram size is passed. */
     mc->default_ram_size = 0;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xen_pvh_info = {
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index a05713e5daa..abdc5bc9a31 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -67,7 +67,7 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->init = xen_init_pv;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("xenpv", xenpv_machine_init)
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 6c86d4939f4..989cfd49182 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -125,7 +125,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->max_cpus = 4;
     mc->no_serial = 1;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index ffa6f210637..0a78ab3a6f9 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -122,7 +122,7 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("virt", xtensa_virt_machine_init)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 2b5f20acefc..e00ae9d2e21 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -594,7 +594,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 64 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx60_type = {
@@ -612,7 +612,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 64 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -630,7 +630,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 96 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx200_type = {
@@ -648,7 +648,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 96 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -666,7 +666,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_ml605_type = {
@@ -684,7 +684,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -702,7 +702,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_kc705_type = {
@@ -720,7 +720,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
diff --git a/system/vl.c b/system/vl.c
index a89f905f835..2ce7d8c49d7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -194,7 +194,7 @@ static int default_parallel = 1;
 static int default_monitor = 1;
 static int default_floppy = 1;
 static int default_cdrom = 1;
-static int default_sdcard = 1;
+static bool auto_create_sdcard = true;
 static int default_vga = 1;
 static int default_net = 1;
 
@@ -718,7 +718,7 @@ static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
     default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
                   CDROM_OPTS);
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
-    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
+    default_drive(auto_create_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
 }
 
@@ -1346,9 +1346,8 @@ static void qemu_disable_default_devices(void)
     if (!has_defaults || machine_class->no_cdrom) {
         default_cdrom = 0;
     }
-    assert(machine_class->no_sdcard != ON_OFF_AUTO_AUTO);
-    if (!has_defaults || machine_class->no_sdcard == ON_OFF_AUTO_ON) {
-        default_sdcard = 0;
+    if (!has_defaults || !machine_class->auto_create_sdcard) {
+        auto_create_sdcard = false;
     }
     if (!has_defaults) {
         default_audio = 0;
-- 
2.47.1


