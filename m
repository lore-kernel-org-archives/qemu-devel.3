Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8428FC54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXxx-0006Gz-2P; Fri, 23 Feb 2024 11:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjF-0005fD-Np; Fri, 23 Feb 2024 10:44:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjE-0006O3-3C; Fri, 23 Feb 2024 10:44:49 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d8da50bffaso3030925ad.2; 
 Fri, 23 Feb 2024 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703086; x=1709307886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gChk1GwQ4BpEFZkklczw0ka4p8ifxr/kGa99Ydgw00k=;
 b=PJlZcX8hWRzI8S0kcb/tOzm3Dqq6NIZYuLj142ai57lTmuQ9sRrOdekJs4Ny5FoSRJ
 dkEs9pyoOOQzqdHAWPdwrzMbAp39x7tapdTz3YAQWq82y39yZtuZC7dDOB39bbwyFA08
 3S3TWkXzszBWk5GAgIq2lWNJMuruNBsHeJ3/nEvO/p0UaDxBJypGJHi/Kiz3Zxfrx77s
 XBAOYfuwrF2s8c0eJJg9eP2pvjzSvG4o7TEBdvuR85INJSPe2zFF0N9BRwdJySEvvUpu
 sHMN6t21jua9L9mzPs5qocqxFmsVZTuslJaoXP93KKXN/SIbQwrFE+P2CR7Ijc3JElAI
 bsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703086; x=1709307886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gChk1GwQ4BpEFZkklczw0ka4p8ifxr/kGa99Ydgw00k=;
 b=m8tyjMGIrtaGnx8aMyA5pPVEIyWXZsMRGft94toXdWaE9kgCVLDwswA8h1MhOiAjhD
 6j5y3Av1F6Fim/jhNgyUVH4hOenTsIPhQDi8j+oj8Ho4Fe76W3GfK3I2wdXGpnRq5+uY
 uQrsxY+E5MfdP+l91h9s/YMRItzOyL5aoWq2huXKoIdq7dH7PGjNqzWN8TtrVidMVdwB
 XTjLUGaMvwvFb9mvIKfv9mVoMjvvrbA62kDMlksGySQ82B89tqewBPBRMgYZREzyoEmA
 6wNJkp1Axu+Y3BL5XIY7dT9I7hylvBQWycUp92Ba44LL1MXFbDIGO0ALjTTzJfA5FvO4
 GNPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGLbalg9hb8MdvMEJbOsXNOi4HRd/33hv4IanCEW1Vrw8VDn4CJmGmTqRCyminHP8OAiZPcTtgYIhy1x+p+9ZIzwwo
X-Gm-Message-State: AOJu0YzSjE8FwUy1dyRsJjatAzUZfuf7PH09OWbIULmVchTf6cIOHHez
 18MzFScbuaLAH5oNtioLpqrl8a5YXymzQUKfiMmcj3eOGFtu0S8r+d6ZmWjb
X-Google-Smtp-Source: AGHT+IG2Ou+yDNstdN98NAC2zG/wXrRy/DMJ/ceuMPuMkfJp8OiT3LnDKMQrlh+LfI4Z8bj4PZb52w==
X-Received: by 2002:a17:902:dac1:b0:1db:f033:9f95 with SMTP id
 q1-20020a170902dac100b001dbf0339f95mr222715plx.66.1708703086265; 
 Fri, 23 Feb 2024 07:44:46 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 24/47] ppc/pnv: Add pca9552 to powernv10-rainier for PCIe
 hotplug power control
Date: Sat, 24 Feb 2024 01:41:43 +1000
Message-ID: <20240223154211.1001692-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
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
index 99d571fa20..0e5acfd1c4 100644
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


