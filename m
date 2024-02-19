Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F481C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz4f-0005GJ-3u; Mon, 19 Feb 2024 03:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4T-0004xP-TS; Mon, 19 Feb 2024 03:32:18 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4R-0002Y8-M9; Mon, 19 Feb 2024 03:32:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dba177c596so20072045ad.0; 
 Mon, 19 Feb 2024 00:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331533; x=1708936333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mOx/ZOZzdjWfC1DAtK2q5WSUrtNSa8E8AfSYcVc8Ng=;
 b=OdNiYImQEJzGcd7RitnDLySmz4cx66Q/EXfFVkiUF2Nzl1NJUrUwtBwPz6mlO6eVR6
 Y7kNyiECubTRq0QEAWQL+Hjq3YT2+MjKkWWpxP96H21hYUt5XXiRynY6Z/DcK/7AyICG
 nmvBg2tAywtCZUwJ+T4RrmbZNO5Uik+ciDWN9X9XfdqFWPtdgUyNpkKpT7Uc1UyHdkjt
 CMu8Kli8lIkL8L7jzRpnJrEJkcim4ocQeMqmtUEXKPr6MImzuaO5exH5Sz9Q1UIJPwwZ
 M8hHw+sZIqQUCj9Og6UPsrgwLEXRpajjLtxbCVOo/b8nAfbwbqm4WmgjnFl/+nAqTcD9
 ZetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331533; x=1708936333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mOx/ZOZzdjWfC1DAtK2q5WSUrtNSa8E8AfSYcVc8Ng=;
 b=TJz8yTfLxEUWoQB4xZsBnN07qfZOrA6kJH9Xr9PqDi9FPryTFFdRwdNghWNTSauvrT
 d1ZH6zR6/8hDiAkQDs1Y+H7hnPXPC+9WiKDpmR1dKpVbn8DCDnzkKg/kMklD+nr6nEJ2
 qgsg85CRlN2Z1zzYiTFnOion3dovdrxfJC1mIezxgJHHiF6dFaYi75IgeNNDLuWlPIri
 XgW2Fll/YCZHjgHolJvQ14llM8QZErL76Nw8y5YadcSMh2MIkx4XNsSa23HbOfMG1k7S
 V4VTeUm+PyifWbXGA1oT32vDnRGQFssQKDRp6D6T94Uywd8zdCnpRwrjg+81jjqkNqW7
 47Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkaug5CAGtdJZ66/JfPVAPakg8tfiKgb870wjgInKTqnnr/SUVGeYg6Q06Dq+qxWjxAr0biuPfAkGhA0/M2pJW2F95
X-Gm-Message-State: AOJu0YyBgOE1wQOEIf9ues8y5XQEG3y1/riuhOcaJiSmanqhI1yf0f3D
 +MXnQUsd/m0aMECxCI3OX/7uX7bUy3Dr1VD3sB/aPLzGtlJJqDHvg/ckYAl8
X-Google-Smtp-Source: AGHT+IEcrIvM0U+tbqsxwyhPK3xFkswoKEf+WBjfmB/YPLVnLlBU+Ro/AjxaC/2pwtdhb0bdan66Ow==
X-Received: by 2002:a17:902:e746:b0:1d9:a15:615d with SMTP id
 p6-20020a170902e74600b001d90a15615dmr17124314plf.1.1708331533403; 
 Mon, 19 Feb 2024 00:32:13 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 30/49] ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
Date: Mon, 19 Feb 2024 18:29:19 +1000
Message-ID: <20240219082938.238302-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

For powernv10-rainier, the Power Hypervisor code expects to see a
pca9554 device connected to the 3rd PNV I2C engine on port 1 at I2C
address 0x25 (or left-justified address of 0x4A).  This is used by
the hypervisor code to detect if a "Cable Card" is present.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/misc/Kconfig     | 4 ++++
 hw/misc/meson.build | 1 +
 hw/ppc/Kconfig      | 1 +
 hw/ppc/pnv.c        | 6 ++++++
 4 files changed, 12 insertions(+)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4fc6b29b43..83ad849b62 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -34,6 +34,10 @@ config PCA9552
     bool
     depends on I2C
 
+config PCA9554
+    bool
+    depends on I2C
+
 config I2C_ECHO
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e4ef1da5a5..746686835b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
+system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 8e592e4307..d97743d02f 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -33,6 +33,7 @@ config POWERNV
     select FDT_PPC
     select PCI_POWERNV
     select PCA9552
+    select PCA9554
 
 config PPC405
     bool
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 97bdfb2d1e..0755fab155 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1913,6 +1913,12 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
         qdev_connect_gpio_out(DEVICE(dev), 2, qdev_get_gpio_in(DEVICE(dev), 7));
         qdev_connect_gpio_out(DEVICE(dev), 3, qdev_get_gpio_in(DEVICE(dev), 8));
         qdev_connect_gpio_out(DEVICE(dev), 4, qdev_get_gpio_in(DEVICE(dev), 9));
+
+        /*
+         * Add a PCA9554 I2C device for cable card presence detection
+         * to engine 2, bus 1, address 0x25
+         */
+        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9554", 0x25);
     }
 }
 
-- 
2.42.0


