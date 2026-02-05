Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F13AECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vl-00077o-3y; Thu, 05 Feb 2026 14:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vd-0006vV-Io
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:25 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VZ-0003Ao-V7
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:25 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so1427743f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321560; x=1770926360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0CayTsyi6p8w45gl32kyiBwM+aaroeJuLz0N2LnaBc=;
 b=KGj6hoH2tMjOkoSB8NtCX2TxeFPxm33xYdlfKWCb4GpSY4pZHMp/zq1sBiZLlfuk06
 BH3fvw1tVqIY5Gtez8bkiYvkeLV8aZ5U/Sn2qpAV2L83XIWbLR6j1GnlKs5kOz5X2Shh
 yC+qGxz/99YXEE0WIWjczvX1p6ZBcGfp3lr3W0S6LwmrFamPSAXV8klmMzfBSigETD/J
 yFR99znNsb0ynNrRom+mWAVkx9cjJ//G34tIP3lwI8+kwLr8OXb8dCtSjBe7+/dqqrIF
 ihZOxS7D0S2n7ppLfJcClXfvetphDbELKZz0Ecw7p2BW5L2KQqXQb4lRvmAfswWMnRW1
 4Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321560; x=1770926360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M0CayTsyi6p8w45gl32kyiBwM+aaroeJuLz0N2LnaBc=;
 b=Gj/Ke5ch1kej2Wh5XiiPdR11j0bnK6L6y4FV3jmzqS65D6C/AvaTEEr/LWZ072TNmE
 vnD7a3Haa+KF0qqVnXwSMGpkvqdXsx3LF1jx9esvBgUcdIo7JlXbapIyuQ3BhsaP5JhY
 mcGMbxvwzFd2qv8WR0fEHMH1jTDfW3D23AgxvkeLOkQBchrL+iE3PBA3CvCXWj/kQvW3
 VIvE28fEBCOJT6ttrP2YKsxZxYexvHlwuAGex0z05krFao/3W62ZSSzcmGxA1uK6QPaZ
 eCs3HnamR6P+9kGW4iLLMjkC4fZngzyONqPEFeLFLzCWXSZ++wdpbr7HEtGZ8c7TalPn
 zfnQ==
X-Gm-Message-State: AOJu0YzFZ3k9ySDL7KYi0JjWv+TjwJMPNJwIt2CXsYVr5kxclyEPLWfH
 7EdjLZfQ1QpY+/7qAVzZ2+1mz+vqAt1kf1aZyhI65UKZ1Ih1vUGaftttFpNwucLi4wQ=
X-Gm-Gg: AZuq6aJDeHvdFJiMvTBtd6TT6icw2E46f7Oh6k/YgPYLASzhDkJTFYlFG9uj8Rugy0Q
 HRf3evXLPQzQa9UYmQwawmqqXY3GZIdoLJAFkQ5Cx2WbdEQFWML7gYiUVkof7aC3Wcuu5Obt87U
 Ld/dRHENWmwqnbI8UOVRUreiCw0kqn3pjk1JZCoIdv1pOeVEJvCP0OQoadMLokRVAxp3oKNXI3N
 KQuACwgtGX7NKpzdUuiPyL0dbDCu4CxgWPkYPjVCfNSRjsTYsFvuYIoqF8O7+1j50PuZOPMYdCI
 fuxHvxCXl1YfR76Y89CDHI0q2T6BVyzT/fjLXVNC4SuZNuJ/JNNvZ+qvRmo5QV1/S6gWwDFrS+1
 TVbkNWv0SXkrYwHzOzjbm1SgY34oJCBGI7bSmfQeIgptNX+uJ0CSG16v09od3PuDbgP7xMTSBZQ
 /M6Oigfzziw2h17p/+z/ByVvlRqsrrUQ==
X-Received: by 2002:a05:6000:310b:b0:436:1973:3b05 with SMTP id
 ffacd0b85a97d-4362933bdf4mr568935f8f.2.1770321559945; 
 Thu, 05 Feb 2026 11:59:19 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:19 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 24/29] hw/core: Add FDT support to Remote Port GPIO
Date: Thu,  5 Feb 2026 20:58:19 +0100
Message-ID: <20260205195824.2610192-25-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement the FDTGenericIntc interface for the Remote
Port GPIO device.

This enables the device to be recognized as an interrupt
controller when instantiated via the fdt-generic framework.
It allows other devices defined in the Device Tree to connect
their interrupt lines to this GPIO controller using standard
FDT properties (e.g., 'interrupts' and 'interrupt-parent').

The implementation maps the interrupt specifier from the
Device Tree cells to the corresponding internal GPIO input
line based on the configured cell offset.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-gpio.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/core/remote-port-gpio.c b/hw/core/remote-port-gpio.c
index b9bdbcc5a5..c17a65f63a 100644
--- a/hw/core/remote-port-gpio.c
+++ b/hw/core/remote-port-gpio.c
@@ -19,6 +19,8 @@
 #include "hw/core/irq.h"
 #include "trace.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 #include "hw/core/remote-port.h"
 #include "hw/core/remote-port-proto.h"
 #include "hw/core/remote-port-gpio.h"
@@ -153,14 +155,34 @@ static Property rp_properties[] = {
     DEFINE_PROP_BOOL("posted-updates", RemotePortGPIO, posted_updates, true),
 };
 
+static int rp_fdt_get_irq(FDTGenericIntc *obj, qemu_irq *irqs,
+                          uint32_t *cells, int ncells, int max,
+                          Error **errp)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(obj);
+
+    if (cells[s->cell_offset_irq_num] >= s->num_gpios) {
+        error_setg(errp, "RP-GPIO was setup for %u interrupts: index %"
+                   PRIu32 " requested", s->num_gpios,
+                   cells[s->cell_offset_irq_num]);
+        return 0;
+    }
+
+    (*irqs) = qdev_get_gpio_in(DEVICE(obj), cells[s->cell_offset_irq_num]);
+    return 1;
+};
+
 static void rp_gpio_class_init(ObjectClass *oc, const void *data)
 {
     RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(oc);
+
     rpdc->ops[RP_CMD_interrupt] = rp_gpio_interrupt;
     dc->legacy_reset = rp_gpio_reset;
     dc->realize = rp_gpio_realize;
     device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    fgic->get_irq = rp_fdt_get_irq;
 }
 
 static const TypeInfo rp_info = {
@@ -171,6 +193,7 @@ static const TypeInfo rp_info = {
     .class_init    = rp_gpio_class_init,
     .interfaces    = (InterfaceInfo[]) {
         { TYPE_REMOTE_PORT_DEVICE },
+        { TYPE_FDT_GENERIC_INTC },
         { },
     },
 };
-- 
2.43.0


