Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3820DCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 16:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwXS-0004Dr-Ph; Mon, 04 May 2026 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wJwXK-00047Z-Kl
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:52:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wJwXF-0005Hd-MJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:52:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso53947395e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1777913563; x=1778518363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBmyL+xxJH7vGICjj1w99tcSqQgZp6hFiUE3aYQpoJo=;
 b=A7qNYWNDXXYLLAK4oCjZ0iwIWO6qG81MPFWsqWQzcIUMZW1ZBS91EtUIaAA52P/rSW
 Y/VzPaP0nBlDe33aGN3JoP9CkN7eU4isBoQWWdm7K4mBGdP4nc+bzExE7B23C0gp5s5+
 GCNu53J9QVIwns7NZBUZo+hnMwgBkbxC8LK7TQEYIF9ArLkA3NI3J6QxuIPGz4bBvVFV
 1fhVZZiKrG1OlIXs7RdwxO4maYOjT+vAlF8Pi0Djef911iaqzfdz4L0IosRSOELbJEc9
 lSjycurpDe5PFrL/j6HzlnBr9awQJWOkxV+dMtZWv7OsfeL/wwVl2p+p4mOAS5GrxBSb
 pFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777913563; x=1778518363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zBmyL+xxJH7vGICjj1w99tcSqQgZp6hFiUE3aYQpoJo=;
 b=Uo52so8oOtsmOIjuNf8ZNNfMKDp3LSeb/2Eg9DYvbh6G+ZpzAUpBv9Xa37qQdsjnek
 dqNXpKURBJVLR87Vcxd6mEaM6oXbd7WLijHFnEHEIdrnvlo3UHnTWRHVzIWSmyUngzvs
 stYHCrVc84wBhe0XKvlmnNA/zPS1CR7JlN177K3lvMagddYM9WCCUrT0CLWFOpQCugGk
 w0vtDUhil1aV21mW0XGQFp2dkRdEhlymBeZjdvHGj6RkpTwvXDyxe34fzwORAoaBfjDM
 L19godr84VGCKOSDnhsZiI97Llv1ada2RM5b5ecvWxdtxQZDPsNvcJmJoMtrF+YO7ovK
 sLJg==
X-Gm-Message-State: AOJu0YzaCYqQr3LS/9Q7FfRspMXr8hxFx+pvDlf7yOVYVMeCzKQEV61q
 +/Huji+kujqzESRizOGSKQJF02JPxEqLAL5hojCA+3NnRxsQIeV4v5FzB5nxrJ3pw6kRLK26sOL
 a81Q8zkzeoQ==
X-Gm-Gg: AeBDieu24/kNDj7aPqh2TCTycDOm/oydAl2WDmyvqaU9gzLIcr1cIqOrksoexpnh20b
 K/s4Wqg65BVifxCDhJc787772BwzAICXx9Yp0zMUZslYgBOKPFfdhs0gkXLDUVBaM9gWZt6bluy
 +CofdFMCdEZBNWOpzV2d1xTJ30eiw/USOZ5MhvDYl5igByYjzV63uE36DELYpD3tgDQJTBhfpqT
 ngcw0or5bsVlIUWNTubLippS3B5f3us6G5gWuEWj4JhHgPXpUmQaTR9RiKbokknKYzvpeic4IK5
 7IahnaTjSStgW2/tArxj0NCGsdzH4j/KscBRPeGeidlKb0GhqaF+45gV8HXxBHAMb7f4O/dWwo1
 /d41VBjjLp4Y/mlfsfTLbpT0fPr6EtNbnc9TFqnxsK++FGsxwRfIIi7nzkmLSblM0JKv2g+oEwA
 cBTHWvIFWHx9QFxtzmMZ93MLb950v06ABWpGhpC/4qRDihxwM7T75T0rY=
X-Received: by 2002:a05:600c:a117:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48a9866837bmr131516655e9.19.1777913563005; 
 Mon, 04 May 2026 09:52:43 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ef50e59sm26482830f8f.10.2026.05.04.09.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 09:52:42 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: [PATCH 4/4] ast2600: yosemite4 initial support
Date: Mon,  4 May 2026 18:48:36 +0200
Message-ID: <20260504165043.213704-6-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504165043.213704-2-alexander.hansen@9elements.com>
References: <20260504165043.213704-2-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x32b.google.com
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

Initial patch based on [1] to support yosemite v4 bmc emulation.

The goal of this machine support is to support OpenBMC development.

Reference linux devicetree from openbmc linux is [2].

Status:
- Enclosure FRU:         showing up
- Management Board FRU:  showing up
- Blade Board FRU:       showing up
- Blade Board sensors:   not implemented
- Blade Chassis FRU:     showing up
- Fan Board FRU:         both showing up
- Fan Board sensors:     supported

Overall the emulation is incomplete but already helpful in development
and testing.

The focus of this initial support is on the FRU eeproms and fanboard
sensors.

Tested: booted an OpenBMC image for yosemite4 target.

References:
[1] https://github.com/9elements/qemu/commit/32139f913c2bd0ebe4bd26c46765861f6f9f2d49
[2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 hw/arm/aspeed_ast2600_fby4.c | 298 +++++++++++++++++++++++++++++++++++
 hw/arm/meson.build           |   1 +
 2 files changed, 299 insertions(+)
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c

diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
new file mode 100644
index 0000000000..84cd372838
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -0,0 +1,298 @@
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/tmp105.h"
+#include "hw/sensor/max31790.h"
+#include "hw/sensor/max11615.h"
+#include "hw/sensor/adc128d818.h"
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/gpio/pca9552.h"
+#include "system/reset.h"
+
+#define FBY4_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+/* START OF EEPROM CONTENTS */
+
+/*
+./frugen -s board.mfg="Wiwynn" \
+  --set board.pname="Fan Board FSC-MAX ADC-TI LED-NXP EFUSE-MAX" \
+  --set text:board.pn="BRD-PN-345" \
+  --board-date "10/1/2017 12:58:00" \
+  --set board.serial="123456" \
+  --set product.pname="Yosemite V4" \
+  --set product.mfg="Wiwynn" \
+  --set product.ver="v1.1" \
+  --set product.serial="123456" \
+  --set product.atag="PLACEHOLDER" \
+  --set product.custom="Fanboard Custom1" \
+  --set product.custom.1="Fanboard Custom2" \
+  --set text:product.pn="PN-345" \
+  fru-yv4-fanboard.bin
+*/
+/* EM Config: yosemite4_fanboard_fsc_max_adc_ti_led_nxp_ons_efuse_max.json */
+/* Yosemite4 fan board */
+unsigned char fru_yv4_fanboard_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xea, 0x46, 0x61,
+  0x6e, 0x20, 0x42, 0x6f, 0x61, 0x72, 0x64, 0x20, 0x46, 0x53, 0x43, 0x2d,
+  0x4d, 0x41, 0x58, 0x20, 0x41, 0x44, 0x43, 0x2d, 0x54, 0x49, 0x20, 0x4c,
+  0x45, 0x44, 0x2d, 0x4e, 0x58, 0x50, 0x20, 0x45, 0x46, 0x55, 0x53, 0x45,
+  0x2d, 0x4d, 0x41, 0x58, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42,
+  0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00,
+  0x00, 0x00, 0x00, 0xdb, 0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79,
+  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20,
+  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31,
+  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e,
+  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xd0, 0x46, 0x61, 0x6e, 0x62,
+  0x6f, 0x61, 0x72, 0x64, 0x20, 0x43, 0x75, 0x73, 0x74, 0x6f, 0x6d, 0x32,
+  0xc1, 0x00, 0x00, 0x9d
+};
+unsigned int fru_yv4_fanboard_bin_len = 160;
+
+/*
+./frugen -s board.mfg="Wiwynn" \
+  --set board.pname="Sentinel Dome without Retimer" \
+  --set text:board.pn="BRD-PN-345" \
+  --board-date "10/1/2017 12:58:00" \
+  --set board.serial="123456" \
+  --set product.pname="Yosemite V4" \
+  --set product.mfg="Wiwynn" \
+  --set product.ver="v1.1" \
+  --set product.serial="123456" \
+  --set product.atag="PLACEHOLDER" \
+  --set product.custom="Yosemite V4 T1" \
+  --set product.custom.1="Yosemite V4 T1" \
+  --set text:product.pn="PN-345" \
+  fru-yv4-sentineldome-board.bin
+*/
+/* product.cust maps to PRODUCT_INFO_AM2 */
+/* EM Config: yosemite4_sentineldome_t1.json */
+/* Yosemite4 Sentinel Dome without Retimer Boards */
+unsigned char fru_yv4_sentineldome_board_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x09, 0x00, 0x00, 0xf5, 0x01, 0x08, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xdd, 0x53, 0x65,
+  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 0x20,
+  0x77, 0x69, 0x74, 0x68, 0x6f, 0x75, 0x74, 0x20, 0x52, 0x65, 0x74, 0x69,
+  0x6d, 0x65, 0x72, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 0x52,
+  0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 0x78,
+  0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 0x59,
+  0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 0x50,
+  0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 0x91,
+  0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 0x64,
+  0x29, 0x03, 0xc0, 0xce, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65,
+  0x20, 0x56, 0x34, 0x20, 0x54, 0x31, 0xc1, 0x00, 0x00, 0x00, 0x00, 0xeb
+};
+unsigned int fru_yv4_sentineldome_board_bin_len = 144;
+
+/*
+./frugen -s board.mfg="Wiwynn" \
+        --set board.pname="Sentinel Dome" \
+        --set text:board.pn="BRD-PN-345" \
+        --board-date "10/1/2017 12:58:00" \
+        --set board.serial="123456" \
+        --set product.pname="Yosemite V4" \
+        --set product.mfg="Wiwynn" \
+        --set product.ver="v1.1" \
+        --set product.serial="123456" \
+        --set product.atag="PLACEHOLDER" \
+        --set text:product.pn="PN-345" \
+        fru-yv4-sentineldome-chassis.bin
+*/
+/* EM Config: yosemite4_sentineldome_chassis.json */
+/* Yosemite 4 Sentinel Dome Chassis FRU */
+unsigned char fru_yv4_sentineldome_chassis_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0xf7, 0x01, 0x06, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcd, 0x53, 0x65,
+  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 0x85,
+  0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 0x4e,
+  0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 0xb6, 0x01, 0x07, 0x19, 0xc6,
+  0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d,
+  0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34,
+  0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05,
+  0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xc1,
+  0x00, 0x00, 0x00, 0x59
+};
+unsigned int fru_yv4_sentineldome_chassis_bin_len = 112;
+
+/*
+./frugen -s board.mfg="Wiwynn" \
+      --set board.pname="Management Board wBMC" \
+      --set text:board.pn="BRD-PN-345" \
+      --board-date "10/1/2017 12:58:00" \
+      --set board.serial="123456" \
+      --set product.pname="Yosemite V4" \
+      --set product.mfg="Wiwynn" \
+      --set product.ver="v1.1" \
+      --set product.serial="123456" \
+      --set product.atag="PLACEHOLDER" \
+      --set text:product.pn="PN-345" \
+      fru-yv4-eclosure.bin
+*/
+/* EM Config: yosemite4_chassis.json, yosemite4.json */
+/* Yosemite 4 Sentinel Dome Enclosure FRU */
+unsigned char fru_yv4_eclosure_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xd5, 0x4d, 0x61,
+  0x6e, 0x61, 0x67, 0x65, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x42, 0x6f, 0x61,
+  0x72, 0x64, 0x20, 0x77, 0x42, 0x4d, 0x43, 0x85, 0x91, 0x34, 0x51, 0x95,
+  0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35,
+  0xc0, 0xc1, 0x00, 0x26, 0x01, 0x07, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79,
+  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20,
+  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31,
+  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e,
+  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x59
+};
+unsigned int fru_yv4_eclosure_bin_len = 120;
+
+/* END OF EEPROM CONTENTS */
+
+static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
+{
+
+    /* 2 fan boards */
+    for (int i = 0; i <= 1; i++) {
+        /* downstream bus */
+        I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
+
+        /* ti,adc128d818 @ 0x1f    (adc) */
+        /* the driver will throw away the last 4 bits, set them 0 */
+        uint16_t adc_values1[8] = {
+            0b011110000000, 0b010100010000,
+            0b001000110000, 0b100000100000,
+            0b011110000000, 0b010100010000,
+            0b001000110000, 0b100000100000};
+        adc128d818_init_with_values(bus,
+                              0x1f, adc_values1, 8);
+
+        /* maxim,max31790 @ 0x20   (pwm) */
+        i2c_slave_create_simple(bus,
+                              TYPE_MAX31790, 0x20);
+
+        /*
+         * ti,tca6424 @ 0x22       (gpio)
+         * linux handles tca6424 with PCA953X_TYPE, same as pca9535
+         * { "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
+         * { "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
+         * so we _could_ be fine here unless more than 16 gpios are used
+         */
+        i2c_slave_create_simple(bus,
+                              TYPE_PCA9535, 0x22);
+        /*
+         * NOTE: above works and could use for gpio presence:
+         * $ gpioget gpiochip2 2
+         * 1
+         */
+
+        /* maxim,max31790 @ 0x2f   (pwm) */
+        i2c_slave_create_simple(bus,
+                              TYPE_MAX31790, 0x2f);
+
+        /* maxim,max11615 @ 0x33   (adc) */
+        uint16_t adc_values[8] = {
+            0b011110000010, 0b010100011000,
+            0b001000110100, 0b100000101001,
+            0b011110000010, 0b010100011000,
+            0b001000110100, 0b100000101001};
+        max11615_init_with_values(bus,
+                              0x33, adc_values, 8);
+
+        at24c_eeprom_init_rom(
+            bus, 0x52, eepromSize,
+            fru_yv4_fanboard_bin,
+            fru_yv4_fanboard_bin_len);
+
+        /* LED blink driver / gpio expander */
+        /* nxp,pca9552 @ 0x61   (gpio) */
+        i2c_slave_create_simple(bus,
+                              TYPE_PCA9552, 0x61);
+    }
+}
+
+static void fby4_i2c_init_blade_chassis(I2CBus *bus, size_t eepromSize)
+{
+
+    /* Sentinel Dome Board EEPROMS */
+    const uint8_t board_addr = 0x54;
+    const uint8_t chassis_addr = 0x55;
+
+    /* Board */
+    at24c_eeprom_init_rom(bus, board_addr, eepromSize,
+        fru_yv4_sentineldome_board_bin, fru_yv4_sentineldome_board_bin_len);
+
+    /* Chassis */
+   at24c_eeprom_init_rom(bus, chassis_addr, eepromSize,
+       fru_yv4_sentineldome_chassis_bin, fru_yv4_sentineldome_chassis_bin_len);
+}
+
+static void fby4_i2c_init_multiple_blade_chassis(I2CBus **i2c,
+    size_t eepromSize)
+{
+
+    /* there is 8 blade chassis, but we only emulate 2 for performance reason */
+    for (int bus = 1; bus <= (8 / 4); bus++) {
+
+        fby4_i2c_init_blade_chassis(i2c[bus], eepromSize);
+    }
+}
+
+static void fby4_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16];
+
+    for (int i = 0; i < 16; i++) {
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    const size_t eepromSize = 128 * KiB;
+
+    const uint8_t enclosure_addr = 0x51;
+
+    /* Enclosure (EM Config: yosemite4_chassis.json, yosemite4.json) */
+    at24c_eeprom_init_rom(i2c[1], enclosure_addr, eepromSize,
+        fru_yv4_eclosure_bin, fru_yv4_eclosure_bin_len);
+
+    fby4_i2c_init_multiple_blade_chassis(i2c, eepromSize);
+
+    /* Yv4 fanboard connection */
+    I2CSlave *fan_mux = i2c_slave_create_simple(i2c[14], TYPE_PCA9546, 0x74);
+
+    fby4_i2c_init_fanboard(fan_mux, eepromSize);
+}
+
+static void fby4_reset(MachineState *state, ResetType type)
+{
+    qemu_devices_reset(type);
+}
+
+static void aspeed_machine_fby4_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook fby4 BMC (Cortex-A7)";
+    mc->reset      = fby4_reset;
+    amc->fmc_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC3_ON;
+    amc->i2c_init  = fby4_i2c_init;
+    mc->default_ram_size = FBY4_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_fby4_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("fby4-bmc"),
+        .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
+        .class_init    = aspeed_machine_fby4_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_fby4_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 84b8ec5fb5..ccbc23e549 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_catalina.c',
   'aspeed_ast2600_evb.c',
   'aspeed_ast2600_fby35.c',
+  'aspeed_ast2600_fby4.c',
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_qcom-dc-scm-v1.c',
-- 
2.54.0


