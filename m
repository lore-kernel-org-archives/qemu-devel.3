Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544BCE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6sg-00073g-Gt; Sun, 12 Jan 2025 17:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sb-00072q-NA
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sZ-0001Z5-UQ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436341f575fso38282495e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736722581; x=1737327381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BowyydtiNf13IGVqTkq6nfH3HgTKKikK+aOyxCGRJEY=;
 b=PiIYG3XDPK6YCpzbuYS5sjWDMaRxgtCX3zIYlvYhmcj5/W6GbHhrNMxniDPP0rIMkG
 dsPcSSg4d7jUgoY/Y2Rep1IbZpkTqTqGhmvTCksVffPqW9Qie1NVaNkTJEW5rL55kHvE
 oziGuaMQVO/7qFA4b3YkI7OsEy3YcNU7MJlIT/RKi+U5pYY3KmvX3dFwyAzeleQ4XluP
 XqcXttvz4VDSjjG7jgDQB6qvQ+KiEGlAx1iZEqav7cY4C23Zt48tiUPNbwhx/YMze7Wt
 +TxUQ8IwH9DHhgFEcZxbcI0OarINVYPAA/a1gA3NoBTaZMvqlgfIavM6GHx4a92tr+97
 cjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736722581; x=1737327381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BowyydtiNf13IGVqTkq6nfH3HgTKKikK+aOyxCGRJEY=;
 b=Z8OP7cafpQjBdsgA3kw3+e9UcbBcqQSjslIQnXlSs8kL/MVcg7gvURzrnQ5rG0Nb/9
 KzZHatJbhy2hz5AO21mhig2KQX2G1vjMkHpaJXEgjXWRkEGppWCNGBkTtRNwFyW84YFV
 w4Io3S+Sl+UsJRKkzvE9tAVhGMj2FQYhdnXkNzItUmuGPLloC31312IE0ysJhO806QzR
 laA4+InIfGO3u7jTGN7vAFKG3iFP7/jSwJ28iY7hSl/uF7FT5vYlVEkQ5BwrX3jYp/3e
 zSlghP3FBQjX23BOxeoC2klkR1EvoXpIfmD3aUuhD9DIXqUVpdj34kPy5bznpZElr23D
 MWEw==
X-Gm-Message-State: AOJu0YzS7a7mtyms9RaBPLvEGnh42GW+ySswtgp149c+G3Q0XO2G3gWu
 YODmjQTrMZp0xRRIys7Ghz+fFpa9jSXs/dC75+/Plva4tcVVgnx+vmT9Pan21gOwR3d2o0mD5cu
 bgNs=
X-Gm-Gg: ASbGnctyEMTf52Oet9geH5bOSdm4WHUaFcnAWKqbu/jdQQl3CnBcBqJSqNC7Qm6gndS
 pTpi+xYjlpbSact1BnJu1/SJgysRkCs7asEzpkbBhpB4WrdoPf2D+EciAfatzm1E71/pJE3fpwC
 0A5lvDgC/GMc7o3ChKVjBXlByb57sa68y/MuIadRlFY/kF1AtuERrJeAdQrZEboKwL4icf35lYg
 4ZJ8ByT4YpUg8FiBtNbHagu4TxnddlEzocpBDWknPvtDGkEsmwkjlV4UGDCJyJOtYxK9G3QEBea
 T+KiHYzhRRyrgXfkMqSY29SzcJnbwLo=
X-Google-Smtp-Source: AGHT+IG3baNxfHKjCh6axCGAtAHcHe2E8plLXHK0zYJtggV7imMZt4klP3RfVo/7JlX/8THKmi08Tw==
X-Received: by 2002:a05:600c:46d2:b0:434:a1d3:a321 with SMTP id
 5b1f17b1804b1-436e2679db4mr164289725e9.3.1736722581599; 
 Sun, 12 Jan 2025 14:56:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38325esm10604058f8f.27.2025.01.12.14.56.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:56:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/arm/nrf51: Rename ARMv7MState 'cpu' -> 'armv7m'
Date: Sun, 12 Jan 2025 23:56:12 +0100
Message-ID: <20250112225614.33723-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112225614.33723-1-philmd@linaro.org>
References: <20250112225614.33723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The ARMv7MState object is not simply a CPU, it also
contains the NVIC, SysTick timer, and various MemoryRegions.

Rename the field as 'armv7m', like other Cortex-M boards.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/nrf51_soc.h |  2 +-
 hw/arm/nrf51_soc.c         | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index e52a56e75e0..f88ab1b7d3e 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -30,7 +30,7 @@ struct NRF51State {
     SysBusDevice parent_obj;
 
     /*< public >*/
-    ARMv7MState cpu;
+    ARMv7MState armv7m;
 
     NRF51UARTState uart;
     NRF51RNGState rng;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 37dd4cf5f40..dee06ab5654 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -76,16 +76,16 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     /* This clock doesn't need migration because it is fixed-frequency */
     clock_set_hz(s->sysclk, HCLK_FRQ);
-    qdev_connect_clock_in(DEVICE(&s->cpu), "cpuclk", s->sysclk);
+    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
     /*
      * This SoC has no systick device, so don't connect refclk.
      * TODO: model the lack of systick (currently the armv7m object
      * will always provide one).
      */
 
-    object_property_set_link(OBJECT(&s->cpu), "memory", OBJECT(&s->container),
+    object_property_set_link(OBJECT(&s->armv7m), "memory", OBJECT(&s->container),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
@@ -104,7 +104,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
     memory_region_add_subregion_overlap(&s->container, NRF51_UART_BASE, mr, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
-                       qdev_get_gpio_in(DEVICE(&s->cpu),
+                       qdev_get_gpio_in(DEVICE(&s->armv7m),
                        BASE_TO_IRQ(NRF51_UART_BASE)));
 
     /* RNG */
@@ -115,7 +115,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0);
     memory_region_add_subregion_overlap(&s->container, NRF51_RNG_BASE, mr, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng), 0,
-                       qdev_get_gpio_in(DEVICE(&s->cpu),
+                       qdev_get_gpio_in(DEVICE(&s->armv7m),
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
 
     /* UICR, FICR, NVMC, FLASH */
@@ -161,7 +161,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer[i]), 0, base_addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->cpu),
+                           qdev_get_gpio_in(DEVICE(&s->armv7m),
                                             BASE_TO_IRQ(base_addr)));
     }
 
@@ -185,10 +185,10 @@ static void nrf51_soc_init(Object *obj)
 
     memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX);
 
-    object_initialize_child(OBJECT(s), "armv6m", &s->cpu, TYPE_ARMV7M);
-    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
+    object_initialize_child(OBJECT(s), "armv6m", &s->armv7m, TYPE_ARMV7M);
+    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
                          ARM_CPU_TYPE_NAME("cortex-m0"));
-    qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
+    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", 32);
 
     object_initialize_child(obj, "uart", &s->uart, TYPE_NRF51_UART);
     object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev");
-- 
2.47.1


