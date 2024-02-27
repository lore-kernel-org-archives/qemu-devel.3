Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC088C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaz-000160-N4; Tue, 27 Feb 2024 08:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaY-0000pB-A7
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaS-0002uv-3U
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412a390347dso17645935e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040812; x=1709645612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hiu0b1foynOipsz23GrR3xzwd+X8RGGDCKc8WBE7RBE=;
 b=Shs4pVEUvEGCFVZkYyIxTxQRqyFZrV0MhpVko8svk1oBiYgRaasm0SW41LBEajPUGH
 ppN1zRGksl7rBWjdiamLcmHhp86T0khtDfni/QfL/cq0RIuCrNGFv6F/aYFaqoCDMx3l
 2Zgb0kg26b45Ne2POybaUzFVpCUhIdzcvBpkIIs4CYsBTciD0sdC7/QCnLswuMFXmztI
 KGzztvQ52+Gl0oNtKiPkBcjA/aZ0b5Hf2QKICwi95yVlg89VMBYc1169kfpTUj0rZtR5
 vlrdhEX223F46aRIIAb0qONcjAlg8V9QoGTjOHxvNq27QeM0WX6MHoqlHplxWzBTsCQE
 sAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040812; x=1709645612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hiu0b1foynOipsz23GrR3xzwd+X8RGGDCKc8WBE7RBE=;
 b=bOkC6AiG70O6rhO6JXkZK4Qh11ocOoeD7c7LSoP1HyxspM7uH9RTc+y+taV6hXIgT2
 CwdSXrRrzUQK/orL6+ankKu6M8FliWU4bynVj7ejxFBqJxP/HMDfv5wBRglUiSkJRPwh
 GIbY8ZGCI+tQGx/xOEBMV42JthQFSGylOJtUnzjs1gnTFST4NyQBmk/F31WrYVd7POQN
 vvXzg51pvwn5i1dQf3yk4RZxOfneJT9zl78Njs9byOztXAQcza6Ja15Xn3Sd4oakV+fI
 2cC/kN9CR4QPRLo/HEx+zYu64MtDZHzNF802e0eim5zu+ub78uCjwwerAMPU121y5+WO
 dXyA==
X-Gm-Message-State: AOJu0YyglIAme/rFcfepcFwj7xSA9e20FKT9998TwYlaR3Fum0pxUS7v
 vHgaKnijjXoiN71l7v2aJO4tfe/dKGezCI+vQTPjYTWV31MRyAe/5kZkepCN0O/0abaEDrvPJw3
 r
X-Google-Smtp-Source: AGHT+IH8GsIy5MEQfiHw7iLQasCluWlSsuUYbFDvUjkAnw5b1Ub/gDaTjQRAqgGjM1EPM2+FQgCURg==
X-Received: by 2002:a05:6000:543:b0:33d:1cc1:bb08 with SMTP id
 b3-20020a056000054300b0033d1cc1bb08mr7063269wrf.22.1709040812609; 
 Tue, 27 Feb 2024 05:33:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/45] hw/arm/bcm2838_peripherals: Add clock_isp stub
Date: Tue, 27 Feb 2024 13:33:02 +0000
Message-Id: <20240227133314.1721857-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_peripherals.h | 1 +
 hw/arm/bcm2838_peripherals.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index af085934c92..7ee1bd066fa 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -71,6 +71,7 @@ struct BCM2838PeripheralState {
     OrIRQState dma_9_10_irq_orgate;
 
     UnimplementedDeviceState asb;
+    UnimplementedDeviceState clkisp;
 };
 
 struct BCM2838PeripheralClass {
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index ca2f37b2606..e28bef4a37d 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -12,6 +12,9 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/arm/bcm2838_peripherals.h"
 
+#define CLOCK_ISP_OFFSET        0xc11000
+#define CLOCK_ISP_SIZE          0x100
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -176,6 +179,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s_base->peri_mr, BCM2838_MPHI_OFFSET,
                                 &s->mphi_mr_alias);
 
+    create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
+                 CLOCK_ISP_SIZE);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
-- 
2.34.1


