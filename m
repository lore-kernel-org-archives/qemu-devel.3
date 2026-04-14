Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE631F9D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdhb-0000pR-1F; Tue, 14 Apr 2026 09:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhZ-0000p4-Dd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhX-0007yO-Pe
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so69275965e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776172870; x=1776777670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=inCEUUb5wQiL4df7Ck+PQJAJdTDE+5Ugi7DIvPxrK28=;
 b=bQ17769NKqhG14PuvUbmwxXPJSYg1sz/Rtg3oBWY+YE/rQMJlAKZHaJKUZKEsKA/Tb
 O0PyBKuON5EAV0RXtnORPJp7vMARInH3kObcfYSvBwUkbc+qnXG8OaPpPclCvtURKIh2
 txPK6UnV1KBPE1Hh4VJVaWJzCHpMd1WnL4SiEmm+OUO+gG+fbABL4cppnF+V8egbDAj4
 rI9HwITOhhEh+VgJzkUEQG4AqrA6u2bhiQhpePSz6eb/DG7KYOVevSc/WMBo0n29RR7W
 cAz/gamGU41Zckb55iwSa3NocRGs+Lr9nsdbfOzJmhMEqNmuMit+CgY3dtYRFNeLkWmK
 zRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172870; x=1776777670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=inCEUUb5wQiL4df7Ck+PQJAJdTDE+5Ugi7DIvPxrK28=;
 b=EigY6dfkKAFBEIK8veKNp8amXklOyJ+dBcT2wZ0AdHkqxddYzxZ5pvT+j9KybU2HbC
 BwbVsJOJqWQWBYs15JH0g86drG9mZa/4Wwy4YyIz9CJ9lu2VWHafePWyVt1yNujXTAox
 eYd+oOZPPABiiap/VNCWcE4EehhN4+A6MQifuG+Xk02XCnIyzWFH7k1nuc1sqebbdlwl
 1nu+Nbgbg8CfmjVUmvuFYpapgoKU3Z5ZUANc7yu7dX8X/bA/MzOWfw6uMqcsS7NJpXVQ
 3CJv+6JtJtwkJkEwwYqs4ayDQPoe2oRZQ1Gh6N5F6LlftVuoJohVVhKCH4pe0ddew/v4
 Y2aA==
X-Gm-Message-State: AOJu0YyJv0YMa7cg61mo3a8ZPsQz7B8M5hOHF/3Sz6K06yC6ZWbx+ojN
 vRELtFB2gSleHlCSnOQcGdhc9cd/c1ZtL6yBsWRKczu70efEDaiAxlKlV/b7d4PrrT51PwUo0T1
 jnYKqBV0=
X-Gm-Gg: AeBDietlWt3VNpsETV17EpuSxp+LTpJ/1jjm/zcU/Ntk4zK7y7wOhEU2nzc76zUiU81
 UvoAmAnkgiGfbPcX1974GZwRLsqqj0JG6mFVZUSqzHQucimN0sF28eNA1JAjDt7p45erAVqIWQU
 s/SMJ4TU3budhrP16+vC/CdjeeA/CqGwTp7kYdbZAvCdUKMrWbI7MLzxqBf1oRLm2Nly34GlG2w
 wY4D+Ljtplih+zGvdZPCzim/PWCyPfog05ukvoCWfaGkuWe8cn208hEZz2bDrl9+lWuL2C4sqPU
 PJt1KkYHUpvF89tS0TLoolqOgcZ9LlDqpVTPh+Zhg5S5TPQ1QfrcellcwsvHFkg1irrnSwqn8RV
 C0mGthv5gql3mMXPnLy05BtjwGwYEi8Qm4KNgwhR3z9aKklOGLfJJ7uIxOXx3OCaxt26NrllCro
 NgeScCvS3j8owScMDPrmUKUCyrtp5Gpm8aOVkzJSjOX3yKUQQMvqNHUgpyC+Hf6Ue2kQaq/3MVM
 Crc5V8/VDs=
X-Received: by 2002:a05:600c:1391:b0:487:5c0:671f with SMTP id
 5b1f17b1804b1-488d67e6a48mr254675585e9.9.1776172869547; 
 Tue, 14 Apr 2026 06:21:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7bc5f70fsm13480934f8f.3.2026.04.14.06.21.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Apr 2026 06:21:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] hw/ppc/e500: fix bus-frequency property hardcoded to zero
 in CPU FDT node
Date: Tue, 14 Apr 2026 15:20:57 +0200
Message-ID: <20260414132100.53861-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414132100.53861-1-philmd@linaro.org>
References: <20260414132100.53861-1-philmd@linaro.org>
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

From: Vivien LEGER <vivien.leger@gmail.com>

The bus-frequency property in the CPU FDT node was hardcoded to 0.
This is incorrect - it should reflect the actual platform bus clock
frequency, as firmware and RTOSes use it to derive peripheral clock
rates.

Notably, the RTEMS QorIQ BSP uses bus-frequency to program the MPIC
global timer interval. With bus-frequency=0, the timer interval
overflows to ~85 seconds, preventing any clock interrupts from firing.

Fix by adding a bus_freq field to PPCE500MachineClass and using it in
the FDT generator. Set bus_freq = PLATFORM_CLK_FREQ_HZ (400MHz) for
existing machines, matching the existing clock_freq value.

Signed-off-by: Vivien LEGER <vivien.leger@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260411154535.1451361-1-vivien.leger@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.h      | 1 +
 hw/ppc/e500.c      | 2 +-
 hw/ppc/e500plat.c  | 1 +
 hw/ppc/mpc8544ds.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 11f8ae53177..6d56c7b4cb2 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -40,6 +40,7 @@ struct PPCE500MachineClass {
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
     uint32_t clock_freq;
+    uint32_t bus_freq;
     uint32_t tb_freq;
 };
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index d6ca2e8563a..5be2f2095f6 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -518,7 +518,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
                               env->icache_line_size);
         qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-size", 0x8000);
         qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-size", 0x8000);
-        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", 0);
+        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", pmc->bus_freq);
         if (cpu->cpu_index) {
             qemu_fdt_setprop_string(fdt, cpu_name, "status", "disabled");
             qemu_fdt_setprop_string(fdt, cpu_name, "enable-method",
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index ca5647284d0..85cec810d9a 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -94,6 +94,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_mmio_bus_base = 0xE0000000ULL;
     pmc->spin_base = 0xFEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "generic paravirt e500 platform";
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 582698559d2..d022761cb6d 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -56,6 +56,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_pio_base = 0xE1000000ULL;
     pmc->spin_base = 0xEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "mpc8544ds";
-- 
2.53.0


