Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF8BC4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdzg-0005Q3-U6; Wed, 07 Feb 2024 04:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzV-0005MB-5Y
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:14 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzS-0008JG-VM
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:12 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3864258438so81872166b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707297189; x=1707901989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yytOM426lSRQ7TkKcf1G+JiJxoGr/F3Uafxb01Uxm28=;
 b=vG32kjNiOx8e15s9qxdVGn8E4L0kr1t0KBWG3pwERYdXgh1u1caTKnFkTCK7TCAFBs
 ag+P8dzlnRkGjUSd3ahX14L5xUFjWRSWUIePq2+N7Dc32DXfVMzJ2wKf2KGL6jwYjwtj
 jRaU8Jo7uFGRGrJ0FZV72cbmoaMVOIszx1HxnyE6s9+ReFPryZ9Ufn/jmajUSVQMjGE9
 DXG7bTlg3JvznRbCxlPkePkJc8ltQbrtisi9V/Gvb37opwoFZTcr+nquh3S/r6eYPSHR
 tMvb8nnEklcWlto16G9TEOKZRPJldcrfJn04Qye0VbgnpW69lh6BUGnXtmMmgeCkTZcT
 ojyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707297189; x=1707901989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yytOM426lSRQ7TkKcf1G+JiJxoGr/F3Uafxb01Uxm28=;
 b=biCdURxPYMlCX4pb0GndPD/q34BYc9VrNfIL6LVKNint7hIxVHVWXXfVY2XIHlFucn
 MO6dD7ifqqcVub9tuE30fr5l53DYMVNVRTr6jVJE09CWLf24U7PO7qYpv5Sgc9//RUUk
 HAGV2VE4QOawSTr6NZWMOIWDZ9MY2b480+jawheDOVmgc2z4g6OpyqJJ7Ra/eDKJvw5M
 7zkVsajfxuFkHwLC/3Oa28f+DEQP+xkIwmobtACkHO9rkrTXdPGGbnFLv4btqhN8yMZE
 mYNVZtv7079Ru8Nbm2HTRp/P+8QZ5EDuekuFPZtlGu9cxL7SCGU59JevMBXr7o2z6m5+
 H3lg==
X-Gm-Message-State: AOJu0YxRtAW5laj8Q29oeQTbX/2kD5yXnwzfewdG1F4SuJ5btg5koPPo
 RTwMJJMtpCKZK9seuBCeFNWrqYAou/FeJ+MtCfWhSTk3IRv1eSZzQU4eVPIPNegpkRinCnAgqka
 k
X-Google-Smtp-Source: AGHT+IGBq/B1g+AP4RykN/Kn4YTMM8dlbD4j0znFVJLXgTU1dDyQy09ZBwtAA0XpZ2U/mVQF6U76TA==
X-Received: by 2002:a17:906:3d29:b0:a38:187c:2a9f with SMTP id
 l9-20020a1709063d2900b00a38187c2a9fmr3431236ejf.36.1707297189012; 
 Wed, 07 Feb 2024 01:13:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW7vjVGQW98Tllh5Ihtam1hDoFmUJ6jv7ppRYKcs3rqOsQp/ySh69YeH9ey322Is+WrYmDoezHyKEWPfGvJ+URUlzEZdbjXv2wSn7kgLNSI1jrXaDsTZlXknc6mcy2vDy/FfYF1Tis+agDa6oJYosoVHKr5UIqkJVltI7kyEb02nLWX6xLv0rgyOWAg89covRdHmJlZaFd0RsbD0Ecwx0ppYgi9iZlJMoabB4Ek45S8u0lnustCpAs=
Received: from m1x-phil.lan ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170906084500b00a372132718esm527985ejd.90.2024.02.07.01.13.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Feb 2024 01:13:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] hw/ppc/ppc4xx_pci: Extract PCI host definitions to
 hw/pci-host/ppc4xx.h
Date: Wed,  7 Feb 2024 10:12:52 +0100
Message-ID: <20240207091254.1478-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240207091254.1478-1-philmd@linaro.org>
References: <20240207091254.1478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20231011132427.65001-3-philmd@linaro.org>
---
 MAINTAINERS                  |  1 +
 include/hw/pci-host/ppc4xx.h | 17 +++++++++++++++++
 include/hw/ppc/ppc4xx.h      |  5 -----
 hw/ppc/ppc440_bamboo.c       |  1 +
 hw/ppc/ppc440_pcix.c         |  2 +-
 hw/ppc/ppc440_uc.c           |  1 +
 hw/ppc/ppc4xx_pci.c          |  2 +-
 hw/ppc/sam460ex.c            |  1 +
 8 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/pci-host/ppc4xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9741b898..b288f0dc76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2068,6 +2068,7 @@ F: hw/ppc/ppc4xx*.c
 F: hw/ppc/ppc440_uc.c
 F: hw/ppc/ppc440.h
 F: hw/i2c/ppc4xx_i2c.c
+F: include/hw/pci-host/ppc4xx.h
 F: include/hw/ppc/ppc4xx.h
 F: include/hw/i2c/ppc4xx_i2c.h
 F: hw/intc/ppc-uic.c
diff --git a/include/hw/pci-host/ppc4xx.h b/include/hw/pci-host/ppc4xx.h
new file mode 100644
index 0000000000..dc36e1ea29
--- /dev/null
+++ b/include/hw/pci-host/ppc4xx.h
@@ -0,0 +1,17 @@
+/*
+ * QEMU PowerPC 4xx PCI-host definitions
+ *
+ * Copyright (c) 2007 Jocelyn Mayer
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_PCIHOST_PPC4XX_H
+#define HW_PCIHOST_PPC4XX_H
+
+#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
+#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
+#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
+#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
+
+#endif
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index ea7740239b..1bd9b8821b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -29,11 +29,6 @@
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 
-#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
-#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
-#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
-#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
-
 /*
  * Generic DCR device
  */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index c75c3083e6..e18f57efce 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -24,6 +24,7 @@
 #include "elf.h"
 #include "hw/char/serial.h"
 #include "hw/ppc/ppc.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index d84418cb7b..1926ae2a27 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 7d6ca70387..1312aa2080 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -14,6 +14,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index e4101398c9..b6c6c8993c 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1e615b8d35..a28498f39c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -25,6 +25,7 @@
 #include "elf.h"
 #include "exec/memory.h"
 #include "ppc440.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
-- 
2.41.0


