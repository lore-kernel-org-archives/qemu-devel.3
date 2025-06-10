Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFBEC71132
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXb-0006oi-2A; Tue, 10 Jun 2025 08:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXZ-0006o2-28
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXX-0002ci-2v
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so45288345e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560237; x=1750165037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9wZcuxBWyI1dFyweR0rRL6SBi5bA4sN/aQECa3VdUc=;
 b=QX4bsIphaAKsqsp7k9txKCymPghZciGLyUCojTj0FavSgaQNfIu2mUvh7SjWLfFEnO
 72ZkSV4caUKktKOPWGhMA6XtSJnSoB0uXeq9xyEiwJLfE5qRXy8JXybUcwQLR0br9KJE
 mj5tfB+6IhQfhncd2EZCPph8QQZ9t0bAn5gkD3+9Rv2UzXBZZTyY14KqrvTlDGrVJ1ku
 ebmKw7/vC53ZC2zSaXBVfSvMteA5hs2aDhoVYgk3qm6XdqT+kXuWrTHOcSq0F3VSC8Yv
 GdZcDkk1yIfSYAGF6fndP1mPJagQlEAFkJJK6qlnksZ8HPsw04MCjTCzESSqk6WWXqbU
 Dmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560237; x=1750165037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9wZcuxBWyI1dFyweR0rRL6SBi5bA4sN/aQECa3VdUc=;
 b=LXTbcZsbZNwBWOQk3t1ZaeSa5PuwCCKCC8qOXs6wKj4B/MncfD8Reui8qc4NnzYdqZ
 LHq9YVbfGvK5WZxGviQ+Z5iHKDOCYD1Mf9LPS5Us7pftvqCGVrHOuEYDRBvJpDUEqBIE
 vNfhlGVK5QI9alyokvVrKyH1nUb0Bf9LaZxJQ0xh3YPOl9rIWAHQ+0M5LeTZhs6j32Zw
 CRwweSJxxWyuLj+JiG0VD/XBybwwdprqa7OyQ9l/mRwlO58knwQ5j5VtxiNA0WjEtT6P
 xyCPIqJY3s+bGTUlZxqSxPRtT5k86h38HDWbuWss2CxQPmWMM8QZ5lIO2SWBuAnzeRSO
 hmrg==
X-Gm-Message-State: AOJu0YyRqjZuL0LbIg87+7W9oo5zq9ikfOOprIG4AKDUyTQ3NgRskswI
 D6paAuwEiNkoaZ7sLRoqjRFyBKsRsRJGh4/U7cqvi5p9dBCC2/oSXdgEyMi07yGH5BPmipRq7gq
 jbl0PIfM=
X-Gm-Gg: ASbGncuoG9B0lHMbFRhWNBp3kY+GSwMtydSkaLY+0laTHpBtYtHaJ0fZ26+fMjSJOEQ
 0T15TIKJdLL1i2KZKAPj3VzCnJYBuNzOhFuPHADQP7Hh0i7qaRCLDTuFdESfGaB9as03vUTxguO
 UttSOpbHo5FdUMyB0Vlu2sbX+4jo8IVs6pzIRtAKtYlnXPb2yuH6Z1cT9Y6nQaAd+TrsvseCYHB
 vaU0KyKmqB7Fh0R8oNt93QOfbsBhFWJJN75GQ0x+W6+Ev+ICR0PJp8R06+vKqNPbCiTGVKNAVBV
 CWHt+wK951cFM2b4YvDGoy3HT7qQ+DcvbXR/+qEKoEIHPEVgQ2KR2TkemMkOcZB1YUA4QisgbB7
 jYul5U3msPA2ipzxiEHNX8pss+Y1hkqTK/5iVg+n7Cw==
X-Google-Smtp-Source: AGHT+IGjU2rG41kxvcFVJ/KrLuqT6bnlMRBt4W0hSKvmBif4Q/24/OU23MrYORffR352tpE/KXhsmA==
X-Received: by 2002:a05:600c:c119:b0:453:78f:faa8 with SMTP id
 5b1f17b1804b1-453078ffbbamr70192195e9.6.1749560236668; 
 Tue, 10 Jun 2025 05:57:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e0563cesm144357165e9.1.2025.06.10.05.57.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/24] hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's
 internal resources
Date: Tue, 10 Jun 2025 14:56:18 +0200
Message-ID: <20250610125633.24411-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Rather than accessing the attributes of TYPE_CCSR directly, use the SysBusDevice
API which exists exactly for that purpose. Furthermore, registering the memory
region with the SysBusDevice API makes it show up in QMP's `info qom-tree`
command.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: rebased]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <619a58d1f83d2aad5b4feec930d46c64abff0977.1748012109.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/ppce500.c | 8 ++++----
 hw/ppc/e500.c         | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index e97a515d5fe..52269b05bb1 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -16,7 +16,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/ppc/e500-ccsr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
@@ -418,11 +417,12 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(
+    SysBusDevice *ccsr = SYS_BUS_DEVICE(
         object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));
+    MemoryRegion *ccsr_space = sysbus_mmio_get_region(ccsr, 0);
 
-    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
-                             0, int128_get64(ccsr->ccsr_space.size));
+    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
+                             ccsr_space, 0, int128_get64(ccsr_space->size));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
 }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index dedd96b0574..6899802bedd 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -931,7 +931,6 @@ void ppce500_init(MachineState *machine)
     CPUPPCState *firstenv = NULL;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
-    PPCE500CCSRState *ccsr;
     I2CBus *i2c;
 
     irqs = g_new0(IrqLines, smp_cpus);
@@ -993,10 +992,10 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     dev = qdev_new("e500-ccsr");
+    s = SYS_BUS_DEVICE(dev);
     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ccsr = CCSR(dev);
-    ccsr_addr_space = &ccsr->ccsr_space;
+    sysbus_realize_and_unref(s, &error_fatal);
+    ccsr_addr_space = sysbus_mmio_get_region(s, 0);
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
                                 ccsr_addr_space);
 
@@ -1284,6 +1283,7 @@ static void e500_ccsr_initfn(Object *obj)
     PPCE500CCSRState *ccsr = CCSR(obj);
     memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
                        MPC8544_CCSRBAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
 }
 
 static const TypeInfo e500_ccsr_info = {
-- 
2.49.0


