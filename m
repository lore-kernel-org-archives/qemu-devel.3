Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F34C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret36-0005l1-Ul; Tue, 27 Feb 2024 03:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret35-0005ab-Jw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret33-0008UF-L4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412a38e2adaso14860715e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023368; x=1709628168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neUNa6vtFGWdPhcBeRIzla/viNhIcPd+5ZZ+Q+4SiBQ=;
 b=qlxc+0l3qktB0xYiqXIShrzXLBeV7yE5lNuJvjpJMZTDEm+mpqeqAp9KFfGuucbj/c
 1GfXW+nDwPP9QH7p7cOkJeTxN1EecQ0ulij/eFGBPKBfl9PK8uTI7SDR7rUqMT1+HC3T
 k+TuWCNYBlikHR4lOQ2g8nyOYtR3CWPNiZZ1uGsFURh7iIn+7SWnp7Nv5ez4Rkju5VOa
 /0qP6tUiC/7yMKN8t8OiVL+UM+W5zy34jy4QrK32NeU47ZXrFbSnK0JCwTIgoCB0PfPi
 6BS4fmz/zsNFkA1AIYIrtq+N3fjdQkG4N8TaWimYZHpTp8InZmkx4HSZTtDch/Lc0SWC
 jG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023368; x=1709628168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neUNa6vtFGWdPhcBeRIzla/viNhIcPd+5ZZ+Q+4SiBQ=;
 b=JMlhuyHVNSPUKNTKQaYssu4eHSg01FAIkHXDjjv6X6llszT288aBvIVK+pqOBrKqrF
 4HoOZx5oWSJwKvbB3sfb44TDTghamFm7ZvkG+6cGgzP3Fpp2BXCFnOKrSYUCzOfr34tt
 nKupZXYg5a3zuQg6Ka935qTB4e0ZHFB6kd7je+sDMkZzVGYokpiI+5NiowLJocBAFTeG
 duVVoUCrdewyBYkHPzt6ox4eYLw2RMOitpixVfTWKucG9P4i1bSu6AAFPirAKP/V+iER
 ZEAIaUY2xM8S1fqZcVbEHveMVElbnpvxnjxwyIo3qh1l2FQ5Ze/Uel0AZCP9mZ+0KmLO
 AOfA==
X-Gm-Message-State: AOJu0Yy0XowrYerCGTPlIGJXHTHdkjsushvhxfshB0F8ZiMlPN+gSBcZ
 NVdABMG51L8DhDoDavDmDwTOkasLS0ITi+ZNsQJRtlQZvAM5sAIdUOVOqjEeFX64Zi6mZ5USl0J
 2
X-Google-Smtp-Source: AGHT+IHWKNxGAz+HFAhsktoQM7CSw6qeZ7fo8vmgNcCMJR3X6jfdp5OFBdZSJnEjWksrv4g07okMMA==
X-Received: by 2002:a05:600c:34d2:b0:412:afa6:cf28 with SMTP id
 d18-20020a05600c34d200b00412afa6cf28mr186075wmq.30.1709023367753; 
 Tue, 27 Feb 2024 00:42:47 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 w15-20020a05600c474f00b004129860d532sm10692174wmo.2.2024.02.27.00.42.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PULL 28/30] hw/arm/sbsa-ref: Do not open-code ahci_ide_create_devs()
Date: Tue, 27 Feb 2024 09:39:44 +0100
Message-ID: <20240227083948.5427-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Use ahci_ide_create_devs() instead of open-coding it.
Not accessing AHCIDevice internals anymore allows to
remove "hw/ide/ahci_internal.h" (which isn't really a
public header).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240226080632.9596-2-philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 5d3a574664..4a59e2fd37 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -37,7 +37,6 @@
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/ide/internal.h"
-#include "hw/ide/ahci_internal.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
@@ -571,8 +570,6 @@ static void create_ahci(const SBSAMachineState *sms)
     DeviceState *dev;
     DriveInfo *hd[NUM_SATA_PORTS];
     SysbusAHCIState *sysahci;
-    AHCIState *ahci;
-    int i;
 
     dev = qdev_new("sysbus-ahci");
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
@@ -581,14 +578,8 @@ static void create_ahci(const SBSAMachineState *sms)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 
     sysahci = SYSBUS_AHCI(dev);
-    ahci = &sysahci->ahci;
     ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < ahci->ports; i++) {
-        if (hd[i] == NULL) {
-            continue;
-        }
-        ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
-    }
+    ahci_ide_create_devs(&sysahci->ahci, hd);
 }
 
 static void create_xhci(const SBSAMachineState *sms)
-- 
2.41.0


