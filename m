Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73DECCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YzK-0000X2-5x; Tue, 30 Sep 2025 07:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3YzE-0000VO-At
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:57:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3Yz7-0001bl-4C
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:57:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so3172967f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1759233442; x=1759838242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QxmQxnMHNNlOF0Ia3HWTfpsW714bs+hZh+O79bMeAc=;
 b=Ie4p1xuQ6B+rt/qFBHHYw+5evNkcZ0Us8iF1pyzq4d/c4sUHmDVjiQp+Rye1izidgC
 xrwzksRg736MB6nr/q96lXYEuonlBqsSjsf7X8eS/oGG2e77VCIZBRBjOhm1Pyn5lCJL
 2iULqyzGMkzkf8/eVbwlOMIfRpMNlyKEW8O6JkkeVuGnX2asD8/sr0GfemDn3qgNF50z
 MJim87X3wiyEDHEJ4XxB+Nf7GFHn7Myypdx7vJRy+r2RxDUAgnQsZJjQk0hGRUz68C3D
 CUcmhaShpORQ89zzYm5txPcsyfDUejKurDtJg1Aod1Go7znYKuUYvdrGHLsw7g2JeS8o
 XPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759233442; x=1759838242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QxmQxnMHNNlOF0Ia3HWTfpsW714bs+hZh+O79bMeAc=;
 b=hyoP1JlaZmeBLlGftWurBCN4EX4plYrQiN2xiwEhSaXTrv8kAVK4HYkQnniNQq+Eif
 8ImjCOeJCweDVoncEByeYuhmpq7z/akKSW2cv280oWvfhNvK7qY2uvbbGSds4ksepQPV
 U5XmVYwGNDWQOhBj0vkDwVa5zIDlddJqhUoPj/8y09LvuFI+Z1euqgv8CIMACxsVoEuL
 q/KmBDpDwx8W5w52lHUO4k/Ubb0vsbdf2gOGCrRBSeMPRZRDBdhDJacAgXulxQF3dxkt
 1wLxlZCMhm6FVqdqrfqNE8Uoah/USnJhSFOsyTh9cUc0f3o6jWgy7y6GRlQ3zq+MTxOn
 xOWg==
X-Gm-Message-State: AOJu0Ywa6o2w6kpWxUQ5pmZG1L14TeGxCkKjCF+bybHxUq6EZ5nQppIH
 JjLLm3VyaVQu5Gy2bGSH7Z11SRXKpVwAzOkyD1zngJm1l1PfF8/F5JtXdXEHHYzUYcID5dzjfh5
 c9zk=
X-Gm-Gg: ASbGncvDTjQstFXkGcfYFPMsjhn9Yspm2/42kBUJPYaERO5MH+DoeFXgH7Gg7Bq8QTb
 gA2rZhw4E+XK3+m9SRFA/sqkrNDPF5oObWXXOJdjAH1j44sr3IyS6bt35f+ZCI+MI10MCeYJg4f
 bBfCTH1spzXnDmqhw50ul46V9/kXrZzVE6MJ1ocokkoXqNXbDcme0nibqwCvPUaiXZ232GUsCdS
 FnYyMXVePl2HHMYNcWj3kxlC/nCG+cBsYCitJ0R/DXaNyRHlQAbOfRnULGUAlMbW3Sotx5vn1YU
 Z7PC+9NqzyqdTAs2OvENEyqbc7Rl2nuUBcXdC+gwPr1kqFD1bJ2A6DMNL4/Ta11ExP8/SHfXpdu
 w+E9Hj9FQUqg9WRlYa7FDahbHagzOHCzd8ZYEFsMqP51UEHOk5XctwnLoaz5Hdi3FwG2U12mA70
 FtyKWTuff3EO+lUBzKHyhB9fIdr6qjr7NdVqAcJsdiRwM3oNSpzQ+TMA==
X-Google-Smtp-Source: AGHT+IF8S9GkUI1VfCfMI81h6ppOs6aOk1q+lJg3st5w4fFqXsxM6p471t/cAbwLlmSqNPG9uf9mIw==
X-Received: by 2002:a05:6000:1846:b0:3ee:15b4:846c with SMTP id
 ffacd0b85a97d-40e44682b8dmr18819992f8f.28.1759233441629; 
 Tue, 30 Sep 2025 04:57:21 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7d3780asm22448289f8f.52.2025.09.30.04.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 04:57:21 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 1/3] hw/arm/xlnx-zynqmp: move GIC_NUM_SPI_INTR define in header
Date: Tue, 30 Sep 2025 13:57:16 +0200
Message-Id: <20250930115718.437100-2-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930115718.437100-1-chigot@adacore.com>
References: <20250930115718.437100-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This define will be needed in a later patch in XlnxZynqMPState
structure, hence move it within xlnx-zynqmp header.

Add XLXN_ZYNQMP prefix as it's now public.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/arm/xlnx-zynqmp.c         | 11 +++++------
 include/hw/arm/xlnx-zynqmp.h |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ec96a46eec..d7adc070f8 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -26,8 +26,6 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-#define GIC_NUM_SPI_INTR 160
-
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
 #define ARM_HYP_TIMER_PPI   26
@@ -206,7 +204,7 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regions[] = {
 
 static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 {
-    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
+    return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
 }
 
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
@@ -454,7 +452,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
-    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
+    qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
     Error *err = NULL;
 
     ram_size = memory_region_size(s->ddr_ram);
@@ -502,7 +500,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(ocm_name);
     }
 
-    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq",
+                         XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
     qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
@@ -613,7 +612,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < GIC_NUM_SPI_INTR; i++) {
+    for (i = 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
         gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
     }
 
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c137ac59e8..6a407c2962 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -67,6 +67,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
 #define XLNX_ZYNQMP_OCM_RAM_SIZE 0x10000
 
 #define XLNX_ZYNQMP_GIC_REGIONS 6
+#define XLNX_ZYNQMP_GIC_NUM_SPI_INTR 160
 
 /*
  * ZynqMP maps the ARM GIC regions (GICC, GICD ...) at consecutive 64k offsets
-- 
2.34.1


