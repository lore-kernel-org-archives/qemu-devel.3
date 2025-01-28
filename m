Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CA5C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6c-0001Jn-BR; Tue, 28 Jan 2025 05:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj66-0001AD-Kl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj61-0003XV-UV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:33 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so4509380f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061127; x=1738665927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhOuLd7arurLv4UbtgWbigCBbLZ+aw4LgTQlp527aNE=;
 b=QNR6j+jEMTAB3Ey+Ulztu9arK5Px/zlCCaMFuRL4dOc26EC3/1IY3CmfM7Hx+1m+qX
 8sJoCqLIRnGNvzobko0OnmxLYyLtkpIgPZtv6hR3KSn96+8IG8WBIL6ABvbXwwWVanty
 VnG7jbCA19jTeiLIpUnkQ+Q31bSHn14kQIHgryBeXZWlzbhuO3IUiMlNIi0Nv9wXRW9Y
 JUb0uH3jh1e0Unryi1kPavNEIlTxXEzbnkGBCPllJgyXuVwcVoa9UUFKmlRvktWVSsEG
 BGoUqxDW27cppTqOA7n8GFXT4vvwm4taNfoZJkx7X7LKU99+5Y99XI+NJyae6JwbpQqU
 ZckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061127; x=1738665927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhOuLd7arurLv4UbtgWbigCBbLZ+aw4LgTQlp527aNE=;
 b=JcDnt4tugm3Sbdojol237/tq+m7oHhp/fsOeKEJKCmU1HX9soeZkt7KlsgUe8VnjPz
 gwk1kWq/l+rfQT5kfXIudzZAEc1j93dVrx169Ts8xFLajzSw0QDCtCIWpl/vej/ROJAi
 MGhKVIZTx+vkCjR6igRqiGjukKD8vyPHXI/BqGIS5ttPltclSL08XjRdCfTthCKd/ZB+
 Fg7FD+EGZGjhp9Djxy03zfTTdFuyq/ewSgPwU+3ksO2CWkYYwKPTYJdv5YL/jfpj8rPl
 NQZvTh05j8SWrf1bf3b15oquKqb5hfzEBC+5UDe9rg+Izga3uyYMc8H/4AVFCoxtb9ca
 KLuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJuzdJOnnb3DV2Ssp4kxU8/hEjxlJtpVh2eWCt7CIoNe9y4gJYOcqSybZuFkUAsYdvx/Wd1Nzo5+KV@nongnu.org
X-Gm-Message-State: AOJu0YwT18W1cNFPtU0zwf3HinghLdMAQZ2BY4YQ5LoHNh/Odpx+QuwG
 vFCV2JB/7QX6i8bhyQIWDpXh8DXeDfsmSdkDhWkkjxVesrZoLwaYj/GLo6Z5dGrn3H3sanHJiva
 g
X-Gm-Gg: ASbGncuq3RgaDa7X3YYXq7Nz4uw5yZ74MXTDgb8s5A8y2BnotAUbRa5Oow5ypAaoRis
 Yn66Na/wOgwJCj526/ph8ShC/AHYwRwUbR5yt3BRFk8w5ctzeXjB6CtmXXNAU4lI5zl3GJvjuAZ
 r4jKkOTJ9hD5MBplAwlJTXD5hUaeugsntIpBR1Yh9azvbnmLQCOd4/ZNp8+m+C9DIWyXdZ1opk2
 lDq8WwVRCDk2G1uMKxP+oOh+uoAeic41gFPXVYSe0dyxoTySn3vH03LWn8zNXZN81nJrlfPndcx
 KkWU3y2DJ2nfoTTn2I//
X-Google-Smtp-Source: AGHT+IHbfUIIyfwoAJqzn08bVH/OcKAdoD4vuS5BxpgJhgT0Zn9CQQJqLz6Pkw2ki5aTCxfT+b2yUw==
X-Received: by 2002:a5d:64c2:0:b0:385:df73:2f18 with SMTP id
 ffacd0b85a97d-38bf59ed533mr51002112f8f.51.1738061127029; 
 Tue, 28 Jan 2025 02:45:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 05/11] hw/sd/omap_mmc: Use similar API for "wire up omap_clk"
 to other OMAP devices
Date: Tue, 28 Jan 2025 10:45:13 +0000
Message-Id: <20250128104519.3981448-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The approach we've settled on for handling the omap_clk wiring for
OMAP devices converted to QDev is to have a function omap_foo_set_clk()
whose implementation just sets the field directly in the device's
state struct. (See the "TODO" comment near the top of omap.h.)
Make omap_mmc do the same.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h | 3 +++
 hw/sd/omap_mmc.c      | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index d20c55a8957..7cb87ea89cd 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -535,6 +535,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(OMAPMMCState, OMAP_MMC)
 DeviceState *omap_mmc_init(hwaddr base,
                            MemoryRegion *sysmem,
                            qemu_irq irq, qemu_irq dma[], omap_clk clk);
+/* TODO: clock framework (see above) */
+void omap_mmc_set_clk(DeviceState *dev, omap_clk clk);
+
 
 /* omap_i2c.c */
 I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 46fdeac1121..fcec2899afb 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -583,6 +583,13 @@ static const MemoryRegionOps omap_mmc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+void omap_mmc_set_clk(DeviceState *dev, omap_clk clk)
+{
+    OMAPMMCState *s = OMAP_MMC(dev);
+
+    s->clk = clk;
+}
+
 DeviceState *omap_mmc_init(hwaddr base,
                            MemoryRegion *sysmem,
                            qemu_irq irq, qemu_irq dma[], omap_clk clk)
@@ -594,7 +601,7 @@ DeviceState *omap_mmc_init(hwaddr base,
     s = OMAP_MMC(dev);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-    s->clk = clk;
+    omap_mmc_set_clk(dev, clk);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(s), 0));
-- 
2.34.1


