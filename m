Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BA6CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeUS-0001Os-ST; Tue, 28 Oct 2025 03:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeUP-0001Ju-Rb
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:51:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeUI-0007UK-GU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:51:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711810948aso41124775e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637876; x=1762242676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAiY/ORuhCuU5FJAi2wbmg3bd/8hEKzfQnI+Ob1U31Q=;
 b=ktVDSYKe5Dyg5LpOqBnLoLhNnNrLZq8mzAo1K1hShG7RJc8JEPfQjPLbswD/rWUvZJ
 s0Bzk4BLdx1YCIBOk0h66nzPqbzazn1MREUSwSZp1SNXh4b19Zl+eiPdg7ufn/8rSDPe
 IrwXnTMy+9CkKtBp+5SWteAhJncP0uQESW//P25Zjsr9VFabJP3+3d8u2+HUhTAX7Eeb
 tntUv/U7CRO015DY9RcpWSAQsXvQWbubrFwfEYEqae+QRC4XokW4lL8x1cljzM4OaR5L
 D4RlCSUmOy9apQPsVENt9BPFrVtQx2EwbDYRIEjXREmfI4rtAXBzlEIyOaJbVK2shWy5
 QfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637876; x=1762242676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAiY/ORuhCuU5FJAi2wbmg3bd/8hEKzfQnI+Ob1U31Q=;
 b=i+NOz3DsYaRGTsmzviGhZtchxOsDBxAztrmII1+2Pyg47r71/DeF/Fwu1+kXXNYgBh
 hM3BGsNGckGdqoR7jVgJcH3t9+UZoaavZcXazCDo/p0VNkuGO3TC8NguyHC1RQVaFYIV
 fCRGcCWZW2DudfBR+fi+vsQ2YnejgXHRPZOa0uCNvSJQcWHH+SwaghHgObWQu3G1B7Rq
 BwW0S8m72hZyXg1DOQxBAFD62t/4tnRW2NuzrKcsN+tUYGjtxukPU0TnBLLyzLRZ1WgD
 3q4wvAjXo4zuwnOsaLksEe3z32UdkNSn70k2YmpnHLIIu7PfxRAmOrgz6KBS157gm28a
 S7LQ==
X-Gm-Message-State: AOJu0Yz/NqJD/wcEwbSRNsEKO1i9v8TTSA8u/ESZmfTkjKat3TgIPgxU
 XiGh6bW1COjB7qTrBPsg5wGUl6oAZlylV4gKefUOjBiJ0m37r5EPqtfboKVYYd++Fgi0E0H4nFS
 ZszFGJ8o=
X-Gm-Gg: ASbGnct/XhJYqfEgIhNJq9E4F/RKL9CcxsX5/rsMO7tqHKnDCKKZi2u+dMek+atjIFu
 PKItOVul5HSe2wZRpVw0BBTujnOvT6wfy3daJoU+p20Upb/2n32xLci9vT2mhVYQRAyZHJnlD67
 XeTYHMfirgH/5tx/zxIPgWKxNtH0iGhSBPflTgFpLoHXWrRLIcmHRV3DkqG9iXsU58P5T+ootZi
 Krxl95gcVi2Ceqc/u16YHdvh5nUneugt0k5yxFx/Hpcwcx55SCelB7os4gTIEbfUgxsGWANchav
 xMCn5TIkxnJHD7Qa4LNhuvBffd9dstcM59xEYUn2mSuyIQKbEialJmB9NjtKDQFdR3cZDoXDzHd
 gP3InZ1WQKxJBffKLbn3KLKl2HEcivORDNoPzwCrsBdHO8O7Nzroj5GSsjqRJO1PbsTLOZPnmAM
 kg3IN4L4CeI1ncLFXJ8GBuiqd7n6Jxt7nDy0FwAkPH9c/P8VLc6tVArM4=
X-Google-Smtp-Source: AGHT+IFq2SE0DiQDUt7RXSMWjsQnEFmRM9pgaFLl2pQ9NHt1hWPnfD8jCer+6ke2T7k3PtnCEMSqcQ==
X-Received: by 2002:a05:600c:5487:b0:475:de68:3c28 with SMTP id
 5b1f17b1804b1-47717def760mr22234015e9.8.1761637876009; 
 Tue, 28 Oct 2025 00:51:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd035dc2sm183600905e9.5.2025.10.28.00.51.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:51:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org
Subject: [PULL 06/23] hw/pci-host/raven: Simplify PCI facing part
Date: Tue, 28 Oct 2025 08:48:42 +0100
Message-ID: <20251028074901.22062-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The raven PCI device does not need a state struct as it has no data to
store there any more, so we can remove that to simplify code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3c4cb144c24a2a729669549c4c0e6e47d230e68e.1761232472.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c0492d14569..fa76e5170c8 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -31,7 +31,6 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
 #include "hw/or-irq.h"
@@ -40,12 +39,6 @@
 #define TYPE_RAVEN_PCI_DEVICE "raven"
 #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
 
-OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
-
-struct RavenPCIState {
-    PCIDevice dev;
-};
-
 typedef struct PRePPCIState PREPPCIState;
 DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
                          TYPE_RAVEN_PCI_HOST_BRIDGE)
@@ -312,16 +305,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
     d->config[PCI_CAPABILITY_LIST] = 0x00;
 }
 
-static const VMStateDescription vmstate_raven = {
-    .name = "raven",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, RavenPCIState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
 static void raven_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -333,7 +316,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
     k->revision = 0x00;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
     dc->desc = "PReP Host Bridge - Motorola Raven";
-    dc->vmsd = &vmstate_raven;
     /*
      * Reason: PCI-facing part of the host bridge, not usable without
      * the host-facing part, which can't be device_add'ed, yet.
@@ -344,7 +326,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo raven_info = {
     .name = TYPE_RAVEN_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(RavenPCIState),
     .class_init = raven_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-- 
2.51.0


