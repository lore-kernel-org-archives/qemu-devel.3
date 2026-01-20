Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CE3D2628B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfa-0004Lc-48; Tue, 20 Jan 2026 13:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfX-00048A-LS
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfU-0006Tl-79
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:35 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so38009435e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934483; x=1769539283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=36oy4LpXeaubv2KU3/hvOkUmF2AsCyfbGtc0pgUrW5Y=;
 b=VX3VDbAP1WlCyr5/1QV0Xx8+Xox5o3+ANJws33YSuQFL/YHqJubVg9wutiRi8lOlCP
 bcFzKGmTARwB8iZDBc8hzlNCUYUQFID5JSxA6nl0Xk3xecVQAcf9OwETbAFHJu9NlvDM
 3xeMS11NGydnaGJ0eik8FDQPWvv2AUiRfR/GYdFKTd24iKW3kC2RHH67lDMTHz0kNMDM
 DLYTqf5zhx960eQ6fol9vUK05QD4i+rf08foFVp6PDPKFNdhC6Eo03KVVED1Be0UK6dr
 MrwdCalvm7AtvES0P/XGU/2wVuS5tpx7B+Z0LBcIb/OVo7pTyAAzDqkyZl1++TMC/euU
 WAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934483; x=1769539283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=36oy4LpXeaubv2KU3/hvOkUmF2AsCyfbGtc0pgUrW5Y=;
 b=em0xkBI34jsjwUhK9Sp6x0opqr8VPu7i25NuZ3D0T4zIGfJx6TMiv8eFOis9hh4IAg
 BlTwFYsmMy6hlAM0k7KpXE8/Rtp7Mpn3AcBUJggvbeGQcxAwOTV4cmur3TYFXCQMg/ob
 9YH1658W2pUawaj403ni/dg8+HYHuyaWe9ujy9+KQzPnOn21dLR+n3hqgYaeBQa+TRxY
 opMceTzi0RN+Fen4gtNkj3ggNTKxhdH4nHHvU/+OkxV5uuoJFu3yunmjFbzCREVvPII3
 Oct2pHhwcy4YhhBYyaKEw5YC+IHcjpXSBRkhNH2tHZzkIrDLgyj0iXe/UXtUAQAjjkoG
 tL3g==
X-Gm-Message-State: AOJu0YzzG+jbCjWOY1wzzElmPdtFzetKoDKzCnk+2mlFjvVOg7mkjg6Y
 IyEQQIkJemT92vrVgHdQl2WzOrRGoLXci07ne8hGW6HHurxrxxY/ffQbYGmaz7nemQob7IL/aAY
 6pBMmHZ0=
X-Gm-Gg: AY/fxX4glazd9iMuPCSRS5weGnaZ1z2XgqqnDmZOGz8z8M6jfOUjKSnGHTFhPXABCE+
 iC1EibaLyH9rL1Ur24O5OdAMT9G+OIepycn4V5CZb8PLzQIuoaA0zMHs/DEGnkuaUGq04bgaPd0
 GHRjpXMVrEco5LpTHPZuFEZfsR00dJ2Ee/PJ7w70H0N2Uuluunb+y1oLGQEL/heysWi0hZG8p73
 td0K26GqC+aDr4jUs6M8I/e5iWloXUbeZeGVbqqu/v/pOYH+ZKISNKt1g6PKrf0DryQvJVGieDk
 ZKyYEecYLRLxe4Kl2fddqgb437aIVOfoa5jls71MTwJkRgBg9y+mwvhztiouWHsDfVxxGCQ6zLB
 hX1dWnRDC0ljiokZMNgEDvgrIzi6EGOxXg+cj/k/zb31KU/GV41qlVTaE2aG+rBh2PUIoZvh5an
 HcjjT9llPt6ot9bBhrNbFMzz3QCMW8Xq/b/UbnExIHrvB18Q6l3gpCNWlKalgpsR3QEJj9Sy8=
X-Received: by 2002:a05:600c:1991:b0:47d:6140:3284 with SMTP id
 5b1f17b1804b1-4801e34b5a7mr175900705e9.37.1768934483316; 
 Tue, 20 Jan 2026 10:41:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f429071besm312546805e9.10.2026.01.20.10.41.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] hw/sd/sdhci: Remove vendor property
Date: Tue, 20 Jan 2026 19:38:53 +0100
Message-ID: <20260120183902.73845-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Now that there are dedicated eSDHC device models it is possible to replace
the "vendor" property (which is really a device-specific property) with a
dynamic cast, "fishing" out only the device models which shall have the
quirk applied.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-14-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h | 1 -
 include/hw/sd/sdhci.h  | 4 ----
 hw/sd/sdhci.c          | 5 ++---
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 50fb746a177..4aeed120bf1 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -309,7 +309,6 @@ extern const VMStateDescription sdhci_vmstate;
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
-    DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
     \
     /* Capabilities registers provide information on supported
      * features of this specific host controller implementation */ \
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 51551348cf5..a9da6203fcb 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -98,7 +98,6 @@ struct SDHCIState {
     uint32_t quirks;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
-    uint8_t vendor;        /* For vendor specific functionality */
     /*
      * Write Protect pin default active low for detecting SD card
      * to be protected. Set wp_inverted to invert the signal.
@@ -107,9 +106,6 @@ struct SDHCIState {
 };
 typedef struct SDHCIState SDHCIState;
 
-#define SDHCI_VENDOR_NONE       0
-#define SDHCI_VENDOR_FSL        2
-
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index eab814096d7..c86dfa281f4 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -307,7 +307,8 @@ static void sdhci_reset(SDHCIState *s)
     s->data_count = 0;
     s->stopped_state = sdhc_not_stopped;
     s->pending_insert_state = false;
-    if (s->vendor == SDHCI_VENDOR_FSL) {
+    if (object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_BE) ||
+            object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE)) {
         s->norintstsen = 0x013f;
         s->errintstsen = 0x117f;
     }
@@ -1863,7 +1864,6 @@ static void fsl_esdhc_be_init(Object *obj)
     s->io_ops = &esdhc_mmio_be_ops;
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
-    qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
 }
 
 static const MemoryRegionOps esdhc_mmio_le_ops = {
@@ -1889,7 +1889,6 @@ static void fsl_esdhc_le_init(Object *obj)
     s->io_ops = &esdhc_mmio_le_ops;
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
-    qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
 }
 
 static const MemoryRegionOps usdhc_mmio_ops = {
-- 
2.52.0


