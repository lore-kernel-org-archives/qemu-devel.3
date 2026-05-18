Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8A1CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsV9-00011B-Ar; Mon, 18 May 2026 03:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUY-0000hR-TA
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUV-0000XR-DD
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so18838285e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089656; x=1779694456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CJZtjp2PDz3MfIqh4LsQdUXR0a9IzqUvFl4W/HGC4w=;
 b=kzTLXweZHW81m9m54imarqwt3NWtHZY9udl4LUgeuYrR2BPiA2WmsWK8Jvd0ngkYvs
 tcuLab0eeyjlTw6SxDOmPVj8mFUUqMvqE7PDxImf9+RRhNKyVu37Jirm8uzlGklUPW9h
 6AeH7wiUOPytBFneGBp0atWfAhiBF4pWdUaL/Sasoo0rplCANcanaFpr7xo8iEnNXpl5
 7AKG9kUExE9oL0O6PvfcjTMz/o2s/4BqX0/c+hriE5n0U8cJcwXKRTuWr62D2TkFIz/V
 azM1ssuQIV+xRAV4xHJpj7mqTdVzer2Zh8tk4xwm0joquQLC13Pp7zRVJD6sDeqV79c3
 hXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089656; x=1779694456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6CJZtjp2PDz3MfIqh4LsQdUXR0a9IzqUvFl4W/HGC4w=;
 b=hM5+fDt5md8/oFxKEwSprUgDBa9mLICSOISQW2Qp1RuhRm2QgJKvrm3zTZ+Nm0W46U
 JPSAnVQBqZFxf7YHCqHil1HdJ1+Ebx50Mp8VUuUJFzDVIBlqxsOcH3wkZT2AELhls8Y2
 fnjPSa5ggeN6KpLklP76aiUEv3gtEraOBqwxNG0w2tmjvsMTfT9E132vcL7IxTaaUEsD
 s5Yka8n6DpYqqc0t7dRC83zIOO33zfWHojE609QFW5HjMHHYDZM8pRYdDXsvKY4XmzUj
 r+IfQ7tHitvSMmue7dXC5qzEjXrunR38xAKIPKAS0PSnHoaYZ8XKAplExfvwJI8fhCRD
 mpfA==
X-Gm-Message-State: AOJu0YwbatXi6C5KOW/nvX+jUeAs36vIlJeDoMQIozPH+G8Zz6w+tgCs
 697vkQdwlxTUJRR9IxcODIdfSk16lD1lTY9mRHmvbx5/tEjrhdbMtaMFjqXaeegD
X-Gm-Gg: Acq92OHqWlFjCC3FdX8TQZ9k6zCUjDMN4nDgG4zPpbiDrG7iGcR9Q6xDUtiFeAyLNw8
 ZyB0IhzcRo845xGUIl4wUyWHlyIi4q1hcJYV89ETQW9nyL0suXCdes7XDcCHkoaNc9EaPTD7hg8
 KsxzhlKGBWFcxuhjpMw8xCCzR8iQKsWt0KrLCJL+ZwLDKdFpV0UjHPmrMHochWLGrAMiu9ZAn7h
 yk1EhTpyApdis34oUCw155wKAVDMz7l7aXp1wphcrpRGcbSP9XaoiQbwOv7ESoq+oQqEpRY3C74
 adJtqj/hCA4yB2noD9SzGLvQdz2MJLMYtchGTdkIViDY9XXucAj7f/Z2INE61vEsh92j5juvi8H
 fYVJz2uPwZlWOuHxWxbL/Egy9N27jQbkDLwbajBKZzd6nz7pyj9IxFLrf5FS8DotqgbZ2HrBhLf
 IQfMWBFTTAAo6q0gE+WUdXAtDKJxa0vFuLqmXrenP+XTx1IQ==
X-Received: by 2002:a05:600c:848c:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-48fe60e52c1mr222469055e9.4.1779089655676; 
 Mon, 18 May 2026 00:34:15 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:15 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 12/16] hw/misc/zynq_slcr: Add CPU clock outputs and ratios
Date: Mon, 18 May 2026 09:33:57 +0200
Message-ID: <20260518073401.11279-13-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

Add CPU clock outs und derive the related domains from the
base CPU clock ration. This makes the CPU clock domains
visible and keeps their ratios consistent with the hardware
clock tree.

We also need to set the reset values during realization to
ensure CPU clocks are properly enabled at startup. Without
this, CPU clocks would have a frequency of 0 Hz, which
causes problems in the a9mpcore timer implementations.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/misc/zynq_slcr.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 0ae5d607be..43e4cc74fe 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -61,6 +61,13 @@ REG32(DDR_PLL_CFG, 0x114)
 REG32(IO_PLL_CFG, 0x118)
 
 REG32(ARM_CLK_CTRL, 0x120)
+    FIELD(ARM_CLK_CTRL, CPU_PERI_CLKACT, 28, 1);
+    FIELD(ARM_CLK_CTRL, CPU_1XCLKACT, 27, 1);
+    FIELD(ARM_CLK_CTRL, CPU_2XCLKACT, 26, 1);
+    FIELD(ARM_CLK_CTRL, CPU_3OR2XCLKACT, 25, 1);
+    FIELD(ARM_CLK_CTRL, CPU_6OR4XCLKACT, 24, 1);
+    FIELD(ARM_CLK_CTRL, DIVISOR, 8, 6);
+    FIELD(ARM_CLK_CTRL, SRCSEL, 4, 2);
 REG32(DDR_CLK_CTRL, 0x124)
 REG32(DCI_CLK_CTRL, 0x128)
 REG32(APER_CLK_CTRL, 0x12c)
@@ -98,6 +105,7 @@ FPGA_CTRL_REGS(3, 0x1a0)
 REG32(BANDGAP_TRIP, 0x1b8)
 REG32(PLL_PREDIVISOR, 0x1c0)
 REG32(CLK_621_TRUE, 0x1c4)
+    FIELD(CLK_621_TRUE, CLK_621_TRUE, 0, 1)
 
 REG32(PSS_RST_CTRL, 0x200)
     FIELD(PSS_RST_CTRL, SOFT_RST, 0, 1)
@@ -206,6 +214,10 @@ struct ZynqSLCRState {
     Clock *ps_clk;
     Clock *uart0_ref_clk;
     Clock *uart1_ref_clk;
+    Clock *cpu_1x;
+    Clock *cpu_2x;
+    Clock *cpu_3x2x;
+    Clock *cpu_6x4x;
     uint8_t boot_mode;
 };
 
@@ -286,14 +298,31 @@ static void zynq_slcr_compute_clocks_internal(ZynqSLCRState *s, uint64_t ps_clk)
     uint64_t io_pll = zynq_slcr_compute_pll(ps_clk, s->regs[R_IO_PLL_CTRL]);
     uint64_t arm_pll = zynq_slcr_compute_pll(ps_clk, s->regs[R_ARM_PLL_CTRL]);
     uint64_t ddr_pll = zynq_slcr_compute_pll(ps_clk, s->regs[R_DDR_PLL_CTRL]);
+    uint64_t cpu_base;
 
     uint64_t uart_mux[4] = {io_pll, io_pll, arm_pll, ddr_pll};
+    uint64_t cpu_mux[4] = {arm_pll, arm_pll, ddr_pll, io_pll};
+
+    bool use_621 = FIELD_EX32(s->regs[R_CLK_621_TRUE], CLK_621_TRUE,
+                              CLK_621_TRUE);
+    /* Select 6:2:1 (true) or 4:2:1 (false) CPU clock ratios. */
+    uint32_t ratio_6x4x = use_621 ? 6 : 4;
+    uint32_t ratio_3x2x = use_621 ? 3 : 2;
+
 
     /* compute uartX reference clocks */
     clock_set(s->uart0_ref_clk,
               ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT0));
     clock_set(s->uart1_ref_clk,
               ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT1));
+
+    /* Base is CPU clock (6x/4x domain). Derive other CPU domains via ratios. */
+    cpu_base = ZYNQ_COMPUTE_CLK(s, cpu_mux, R_ARM_CLK_CTRL, CPU_6OR4XCLKACT);
+
+    clock_set(s->cpu_6x4x, cpu_base);
+    clock_set(s->cpu_3x2x, cpu_base * ratio_6x4x / ratio_3x2x);
+    clock_set(s->cpu_2x,   cpu_base * ratio_6x4x / 2);
+    clock_set(s->cpu_1x,   cpu_base * ratio_6x4x);
 }
 
 /**
@@ -322,6 +351,10 @@ static void zynq_slcr_propagate_clocks(ZynqSLCRState *s)
 {
     clock_propagate(s->uart0_ref_clk);
     clock_propagate(s->uart1_ref_clk);
+    clock_propagate(s->cpu_1x);
+    clock_propagate(s->cpu_2x);
+    clock_propagate(s->cpu_3x2x);
+    clock_propagate(s->cpu_6x4x);
 }
 
 static void zynq_slcr_ps_clk_callback(void *opaque, ClockEvent event)
@@ -620,6 +653,10 @@ static const ClockPortInitArray zynq_slcr_clocks = {
     QDEV_CLOCK_IN(ZynqSLCRState, ps_clk, zynq_slcr_ps_clk_callback, ClockUpdate),
     QDEV_CLOCK_OUT(ZynqSLCRState, uart0_ref_clk),
     QDEV_CLOCK_OUT(ZynqSLCRState, uart1_ref_clk),
+    QDEV_CLOCK_OUT(ZynqSLCRState, cpu_1x),
+    QDEV_CLOCK_OUT(ZynqSLCRState, cpu_2x),
+    QDEV_CLOCK_OUT(ZynqSLCRState, cpu_3x2x),
+    QDEV_CLOCK_OUT(ZynqSLCRState, cpu_6x4x),
     QDEV_CLOCK_END
 };
 
@@ -630,6 +667,9 @@ static void zynq_slcr_realize(DeviceState *dev, Error **errp)
     if (s->boot_mode > 0xF) {
         error_setg(errp, "Invalid boot mode %d specified", s->boot_mode);
     }
+
+    zynq_slcr_reset_init(OBJECT(s), 0);
+    zynq_slcr_compute_clocks_internal(s, clock_get(s->ps_clk));
 }
 
 static void zynq_slcr_init(Object *obj)
-- 
2.47.3


