Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BF0C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxc-00023h-E3; Tue, 28 Jan 2025 15:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxa-00022R-DA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxY-0001Xw-FA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so64355955e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095199; x=1738699999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RuYkzZqUPJ0A2DVj0fSbq4yiszjJOwyj6WBfQc5lhkE=;
 b=voO44oTzddt4A6gtoHxmJxPQ0lpTihxpx14h0/d4LNjKtdUpSkQFy1hp3BroUqdB12
 1KrClim9fjIRG4Gan9VmLK8V2TMfXXEGFBFCcToZXJ7LBVTYBhOiz5MwPaOAdy9InoZs
 4wV+mwrbqj4OHE8QjdSKG2LPpCOhD8bNrwBJWLyRrHnn38zJciVKG+rBBue4rU7YSFPL
 2ewqfJXBD8wJzzjF3NKCtw+h0KWPlnYnRM2HZ8hbHz7F7XbtYtmLw1bN1MyK6pU4dtFg
 PQpM5ZkiH2SzfqxN1X8SSLhfVi7gGezFOmllCMbUJgexJc9c+7cxX9z+GXv7YAIKwhr/
 vGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095199; x=1738699999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RuYkzZqUPJ0A2DVj0fSbq4yiszjJOwyj6WBfQc5lhkE=;
 b=OrURHPjrYX+CyI4fte+GcfiRM5T98E8bg+IUQsdE23UFAclE6JoGfXShO0/NfAlFUj
 A8+AayzvayTo3awvPRL1XdtMDYpgOgigwALO1/oSGwdyTkGWYcgs9trNz3t/KPt0taGM
 gmIMnmNnvS1y/g5XBe4feZo+WSM4/B3YNWeGrp6w/4MU1touJr1sPlfwZSpPXHBz84Ag
 7D3SflunJR4t8bapAjxY8evocSsCP15SLCcSNS0DxKyjOuhO9NE+CXF/G5y9W/6jXHTh
 GWJ1xQahTpc/HIvN4uRU3LJmISU3MPkj/Q52rifOdi3kwQdTEfIqUBaf4JJQZODZIB9A
 q2tA==
X-Gm-Message-State: AOJu0YwO/PmrpR5jTuBGcUfiW45OeJehSLIu44SgvKpBzxaebTWExNfq
 dG34EcysGkFoISdMSJsV0aX3pgTcyTgHCG5Y3MHGdiVe4hNEtELvqLrv2/CmTV+GY0QTZwtrGYj
 w
X-Gm-Gg: ASbGncvtXOavlgNuB8YF4dsSJydccw5dETWmC3JI/DnlOXmd7MgPreiu3GW3cCpf3pg
 wHpPjlo2E/GhfC/GI7A4t1aE3u1ADBQf1ZDc/67mETeNfd0VO9THKy2jdpMOrntRToZmM7eGC+l
 KCwRMdDJ/AgNng4h7+We0j87Uz8Ai8H+3K9i4oftVsmHZ2N65mcyrC14kpq7It+PsQQghs3BUE+
 v9aWoJpkP3Eky64ucZNkJoZnlr0X4yo4o3l64YNJ0xaFO8AH78FDo7xtxj6cT8bPSH4yv9ZHRnq
 rlo9dkjV9YoQWZ0rMm/aew==
X-Google-Smtp-Source: AGHT+IFfUf3P89+YDHlaA9MzkaeU11oXXU8bru2u/lDBLcq6Ro1ea39WD9GOpKOBFRDuthxWYsMA6g==
X-Received: by 2002:a05:600c:4e07:b0:438:a20b:6a62 with SMTP id
 5b1f17b1804b1-438dc4213c2mr2200625e9.28.1738095198626; 
 Tue, 28 Jan 2025 12:13:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/36] hw/arm/stellaris: Add 'armv7m' local variable
Date: Tue, 28 Jan 2025 20:12:40 +0000
Message-Id: <20250128201314.44038-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

While the TYPE_ARMV7M object forward its NVIC interrupt lines,
it is somehow misleading to name it 'nvic'. Add the 'armv7m'
local variable for clarity, but also keep the 'nvic' variable
behaving like before when used for wiring IRQ lines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20250112225614.33723-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 1bba96df14e..7303e096ef7 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1031,7 +1031,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      */
 
     Object *soc_container;
-    DeviceState *gpio_dev[7], *nvic;
+    DeviceState *gpio_dev[7], *armv7m, *nvic;
     qemu_irq gpio_in[7][8];
     qemu_irq gpio_out[7][8];
     qemu_irq adc;
@@ -1095,19 +1095,20 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     qdev_prop_set_uint32(ssys_dev, "dc4", board->dc4);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ssys_dev), &error_fatal);
 
-    nvic = qdev_new(TYPE_ARMV7M);
-    object_property_add_child(soc_container, "v7m", OBJECT(nvic));
-    qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
-    qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
-    qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
-    qdev_prop_set_bit(nvic, "enable-bitband", true);
-    qdev_connect_clock_in(nvic, "cpuclk",
+    armv7m = qdev_new(TYPE_ARMV7M);
+    object_property_add_child(soc_container, "v7m", OBJECT(armv7m));
+    qdev_prop_set_uint32(armv7m, "num-irq", NUM_IRQ_LINES);
+    qdev_prop_set_uint8(armv7m, "num-prio-bits", NUM_PRIO_BITS);
+    qdev_prop_set_string(armv7m, "cpu-type", ms->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk",
                           qdev_get_clock_out(ssys_dev, "SYSCLK"));
     /* This SoC does not connect the systick reference clock */
-    object_property_set_link(OBJECT(nvic), "memory",
+    object_property_set_link(OBJECT(armv7m), "memory",
                              OBJECT(get_system_memory()), &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(armv7m), &error_fatal);
+    nvic = armv7m;
 
     /* Now we can wire up the IRQ and MMIO of the system registers */
     sysbus_mmio_map(SYS_BUS_DEVICE(ssys_dev), 0, 0x400fe000);
-- 
2.34.1


