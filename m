Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381BDC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdzg-0005QA-VK; Wed, 07 Feb 2024 04:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzb-0005NZ-68
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:21 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzY-0008K3-2a
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:18 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a370328e8b8so45161966b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707297194; x=1707901994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVBl6Dk4lUHM78vggkMek+g7I/12xu6COw4rVVhDdU4=;
 b=Nxd4I82k41Pb6B7XxV4yu5ISz+jQErs0hT8qFfIOH721WyI3RuEKnAGQ481cwNruCR
 TjXXCJf4Zf6eDz51ewnzGwwk/SBufT5vgsAdDqCN/o75MMICwJLj+6tc2WjYkh7uWiX6
 yTEgi49eQMhG0H11tS1M7ANBzEAzutxvjZqH+Dusnn4IQcXFCqtsHTZmZ6Sul/WPMV7z
 NDnDvlwHdafBqU79//JzyUy9FfJiKlDh9A58DJLlbOQ2bSW2j+ZvraBlI78KHpow+OWe
 75XAmNJDPHlowdAWWb66/LNJ+gox84dXdD9qgy3DMEXGkNAlo+hAJIrFCPdhGrlqXcXW
 X8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707297194; x=1707901994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVBl6Dk4lUHM78vggkMek+g7I/12xu6COw4rVVhDdU4=;
 b=QRisi5PAR7axEnBbtERDln8kv4Y3QlKPO+5EA8M86qvlfee6OSN3E/QMXedE1aYo06
 uxncWBMrsB9VeqeblxIaicpjtsTjTnEcVD7sJKQiAJ34v55Hc8p2b2K62YraDUTp7lHQ
 MX6vk7X+b9tbzfYeX6MvcW0v6BO0t5Wb7X8up0meIpQVdD7ee6NfCxIiNO5ahVaMBg6h
 47XZAG6O9eqw+u+QlbT0RC6ooed3/Owd7cPOM2P/tn4UOODxbKNnWOCwbBD9/3b+pQiu
 4AmBpcOZ/I2c0qhGaTJTaPyGHcj6XccWd2AAFyDxfRIASangVBnKeP5SXH+RAMhyVPgg
 iJHg==
X-Gm-Message-State: AOJu0YyddnTMnbKL9iT1gaRKC+Es8JlBJjydAKuu1rOE+FACttDFB28F
 NGGEvlCwRhQuJxHb2OIWakfvMSNUhno+mmQcb5tbjy2HBVmdmZWMCsF+Vy3HNOAFpICzD4+cNYr
 i
X-Google-Smtp-Source: AGHT+IHFrHS/tTDAYsFSX72SKh6SFdAd4FIy8OMzGjtXPtKIW2FahhBtvWzKdCAK4i2Ndz+ROmOOHQ==
X-Received: by 2002:a17:906:abcc:b0:a38:7909:7a87 with SMTP id
 kq12-20020a170906abcc00b00a3879097a87mr698474ejb.54.1707297194559; 
 Wed, 07 Feb 2024 01:13:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUp4N8gq3kQdRWACqm495rF4ODPFQ5lU1g6s85RofXxC3z43BmMPPvW8eVspD+0BcA5MeCMsy6UhoMkwrrQNGjT+GVwjaNneTi9uI2TDDxRNYRCXRg+q9n34EWTcz9ZzP1OmaUNmONSIaCRgP5h7oEqQRGlfUMTMeU/JriKrMKv61de1dhInODBzujqxVyxFm0fIEDlZ4rG2n1hDfAGIdMp/Ejbmk2fLlPTUMKO3LCLDNm97cEC1ds=
Received: from m1x-phil.lan ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 l24-20020a17090612d800b00a3820ec721csm533640ejb.8.2024.02.07.01.13.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Feb 2024 01:13:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
Date: Wed,  7 Feb 2024 10:12:53 +0100
Message-ID: <20240207091254.1478-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240207091254.1478-1-philmd@linaro.org>
References: <20240207091254.1478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

ppc4xx_pci.c is moved from the target specific ppc_ss[] meson
source set to pci_ss[] which is common to all targets: the
object is built once.

Declare PPC4XX_PCI selector in pci-host/Kconfig.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                       | 1 +
 hw/{ppc => pci-host}/ppc4xx_pci.c | 0
 hw/pci-host/ppce500.c             | 2 +-
 hw/pci-host/Kconfig               | 4 ++++
 hw/pci-host/meson.build           | 1 +
 hw/pci-host/trace-events          | 4 ++++
 hw/ppc/Kconfig                    | 2 +-
 hw/ppc/meson.build                | 1 -
 hw/ppc/trace-events               | 4 ----
 9 files changed, 12 insertions(+), 7 deletions(-)
 rename hw/{ppc => pci-host}/ppc4xx_pci.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b288f0dc76..1927530c2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1421,6 +1421,7 @@ Bamboo
 L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc440_bamboo.c
+F: hw/pci-host/ppc4xx_pci.c
 F: tests/avocado/ppc_bamboo.py
 
 e500
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
similarity index 100%
rename from hw/ppc/ppc4xx_pci.c
rename to hw/pci-host/ppc4xx_pci.c
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index fa0d67b342..95b983b2b3 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -5,7 +5,7 @@
  *
  * Author: Yu Liu,     <yu.liu@freescale.com>
  *
- * This file is derived from hw/ppc4xx_pci.c,
+ * This file is derived from ppc4xx_pci.c,
  * the copyright for that material belongs to the original owners.
  *
  * This is free software; you can redistribute it and/or modify
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index f046d76a68..0a221e719e 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -6,6 +6,10 @@ config XEN_IGD_PASSTHROUGH
     default y
     depends on XEN && PCI_I440FX
 
+config PPC4XX_PCI
+    bool
+    select PCI
+
 config RAVEN_PCI
     bool
     select PCI
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 36d5ab756f..eb6dc71c88 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -14,6 +14,7 @@ pci_ss.add(when: 'CONFIG_REMOTE_PCIHOST', if_true: files('remote.c'))
 pci_ss.add(when: 'CONFIG_SH_PCI', if_true: files('sh_pci.c'))
 
 # PPC devices
+pci_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
 pci_ss.add(when: 'CONFIG_RAVEN_PCI', if_true: files('raven.c'))
 pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
 # NewWorld PowerMac
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index b2f47e6335..90a37ebff0 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -37,6 +37,10 @@ unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64
 unin_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 
+# ppc4xx_pci.c
+ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
+ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
+
 # pnv_phb4.c
 pnv_phb4_xive_notify(uint64_t notif_port, uint64_t data) "notif=@0x%"PRIx64" data=0x%"PRIx64
 pnv_phb4_xive_notify_ic(uint64_t addr, uint64_t data) "addr=@0x%"PRIx64" data=0x%"PRIx64
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 44263a58c4..82e847d22c 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -53,7 +53,7 @@ config PPC440
 config PPC4XX
     bool
     select BITBANG_I2C
-    select PCI
+    select PPC4XX_PCI
     select PPC_UIC
 
 config SAM460EX
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index eba3406e7f..d0efc0aba5 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -63,7 +63,6 @@ ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_pcix.c', 'ppc440_uc.c'))
 ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
   'ppc4xx_devs.c',
-  'ppc4xx_pci.c',
   'ppc4xx_sdram.c'))
 ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
 # PReP
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f670e8906c..b59fbf340f 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -146,10 +146,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 
-# ppc4xx_pci.c
-ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
-ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
-
 # ppc440_pcix.c
 ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
 ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
-- 
2.41.0


