Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95EEC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz4E-00042X-O8; Mon, 19 Feb 2024 03:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4B-0003hK-Vj; Mon, 19 Feb 2024 03:32:00 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4A-0002Wu-5k; Mon, 19 Feb 2024 03:31:59 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d918008b99so32901735ad.3; 
 Mon, 19 Feb 2024 00:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331516; x=1708936316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQv5sl7Jj/zQtu24J/5XkzVO6uC8Momtwp64DIN703Y=;
 b=k73787A8FBfEsYEylKUttRzDfncdRqIvEVXJfV9kvRmtXCiLlTQmXf56CA3w2+3osn
 z3N88nEo3+rm3eSD1LTu5jXA+nHG3dP79zs4zz5t2arU+4JTKFQ/2OoFBHtgHKP59yDC
 UhuuxwZI+8DfyfuGL/VdXTqGeUIGik2RvfOESCZy2ljzZYZYatbIgoCxA+qV3VSBzT85
 3hqIfCp/PYJM77bwTEn9Z2wDsrNbbYS4eeuJQqDRZ6gHgcgYAGMWFBdGwmT4uRvlb1DL
 K/irGJ8SE9VoumSwmw9InTK8UMmUM/NWH3Bvq0wycYov+1gaS1WLaoSmL98usbGFLGR5
 rHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331516; x=1708936316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQv5sl7Jj/zQtu24J/5XkzVO6uC8Momtwp64DIN703Y=;
 b=q7Q1+8Iar0D04+d/W1gtzxyfivmobGo3zPBsuI871bfSfC2Rsn0k0Zq9bW4yRMzn/W
 if/Ez6MhxIX7/1x+x7jEXAepVITNvxrnVH/9Y+6NwzqJv1kWgRUtfyLjXAd2NBTCeJI0
 dNuZ12fTTrncggp74syVSJUhTxKeM7MwYk8bkV/nNOEatNV0R5nxvvdYAq5zsCe9oG/7
 rVvzyVn5JOrvt7toU4zaPKq+AW7i8P2SpD5aoXMPO/ovXrHnBUiQ90VkYfMCvTapu968
 anLfX/26X4jzGYO4b4arCg/SteVZkQmHfzxlbjcJOefN/WM6iPyVQX5d/z32DHnlo4A+
 S06g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3hBa4I9Gr+sOSBtoVr/EsKOEQ7WQ7c250HVZFPRjyiKhlTjISFc5d6LZJNJYtGNLpNje5Q8n7qBjKOANBEccV9BkZ
X-Gm-Message-State: AOJu0YwmhMtbabmPgpYTEJ27bRamwiy7af+/h4Wi97O3Nw4piKLeZyzu
 7i5AAKR8SnBkcg5uylY++G3eip7VLxt8Q6xvegFF4hIZwoQQ5vIk/ySUrxQt
X-Google-Smtp-Source: AGHT+IGW42UStl6xWWUg7SCXzg290e9hKzSH5qaIk5JucX6kxcerXi3Z7N3IPOgYATfGrY0AbrIKCw==
X-Received: by 2002:a17:902:f64b:b0:1db:aa13:b678 with SMTP id
 m11-20020a170902f64b00b001dbaa13b678mr6043627plg.0.1708331516390; 
 Mon, 19 Feb 2024 00:31:56 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 26/49] ppc/pnv: Add pca9552 to powernv10-rainier for PCIe
 hotplug power control
Date: Mon, 19 Feb 2024 18:29:15 +1000
Message-ID: <20240219082938.238302-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

The Power Hypervisor code expects to see a pca9552 device connected
to the 3rd PNV I2C engine on port 1 at I2C address 0x63 (or left-
justified address of 0xC6).  This is used by hypervisor code to
control PCIe slot power during hotplug events.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/Kconfig       |  1 +
 hw/ppc/pnv.c         | 25 +++++++++++++++++++++++++
 include/hw/ppc/pnv.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 44263a58c4..8e592e4307 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -32,6 +32,7 @@ config POWERNV
     select XIVE
     select FDT_PPC
     select PCI_POWERNV
+    select PCA9552
 
 config PPC405
     bool
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 33b905f854..78f5c6262a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -790,6 +790,7 @@ static void pnv_init(MachineState *machine)
     const char *bios_name = machine->firmware ?: FW_FILE_NAME;
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
     char *fw_filename;
     long fw_size;
     uint64_t chip_ram_start = 0;
@@ -979,6 +980,13 @@ static void pnv_init(MachineState *machine)
      */
     pnv->powerdown_notifier.notify = pnv_powerdown_notify;
     qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
+
+    /*
+     * Create/Connect any machine-specific I2C devices
+     */
+    if (pmc->i2c_init) {
+        pmc->i2c_init(pnv);
+    }
 }
 
 /*
@@ -1879,6 +1887,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
                                                PSIHB9_IRQ_SBE_I2C));
     }
+
+}
+
+static void pnv_rainier_i2c_init(PnvMachineState *pnv)
+{
+    int i;
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+
+        /*
+         * Add a PCA9552 I2C device for PCIe hotplug control
+         * to engine 2, bus 1, address 0x63
+         */
+        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
+    }
 }
 
 static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -2286,9 +2309,11 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
 
     pnv_machine_p10_common_class_init(oc, data);
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
+    pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7e5fef7c43..110ac9aace 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -76,6 +76,7 @@ struct PnvMachineClass {
     int compat_size;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
+    void (*i2c_init)(PnvMachineState *pnv);
 };
 
 struct PnvMachineState {
-- 
2.42.0


