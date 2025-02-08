Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B84C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgns1-00017Z-Dq; Sat, 08 Feb 2025 11:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrx-00015C-29
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrv-00006x-5Y
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436341f575fso36228005e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032785; x=1739637585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81ffc0XjjE2CDrZU8HhaqibfPhqNj9LivXTF2X9Kxp8=;
 b=CckJVCJcrrsuDLl0kgh0hrnNu8/OvjV6v7THB1+IA4GPLmHXI4vH6kPqGcsfB1KGls
 IYSeOg1TGQwtKhITv1VHulLncCCc6Hms1asvZsF4xiWCDkcmLHLFTCfeDUtSY0GY58wy
 i4xxRLZbEq1CgHnU9PC+hRz8hHcwv6dX9Vk6CBFpLiRX9NqK/I+4kxMTtAsZo0GSamvj
 j5a54jNWHOwr5a7SKm7N5rw3LeTQpSXC0gUHLZNvu/cqZP76bDuvAI6UXQfyCQiqWOAG
 ZzdIP3Tmf7owZWFZnpoDxO03OCoBS43q7NGGM32gUIYatobMH5AnS53YPDOUIbuiL2/i
 u9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032785; x=1739637585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81ffc0XjjE2CDrZU8HhaqibfPhqNj9LivXTF2X9Kxp8=;
 b=UXNvSUGJIQ28fVk0c8ibnxiJ2HG9wcWPfgRLtjmpqxcSdEjkG1i44N+T6BWIgI5e9d
 9frdZe8oI/1tCOvM1vL4dwgB8tLlYwT0AdkIK3n6WkI94LYrxd7G7O7j6hyxqJmgYdQq
 kx7ldVybsSUBWO9/v19Wehvk79IxxDLLwLCMCT1Pb9fxvU0lD6BRRjMXxsmCRWiKScHr
 cNm51v355rfgyYBh9ZBLaN2Rc8vBTbigQXu3248vQ6JAQ/DTybCR+npjscminrnnOhtW
 1+FhZTlDPdFDSL/kGU7cJZK90l6hX4fYyMmc0k1eyVoDcXNt7+HmD22y4FG4QNYtCeCI
 fPHA==
X-Gm-Message-State: AOJu0YxG02pSaN97PfPg1gjUCmXp58RmootRfsPGkVBbPklj92yveBrd
 k7oiNIyDOo9P4kuaWUHzuOOBLMFTZPIgF86a68ZDB8xmRR1GdW+/V4uCzs7XLbJvNWyJPUPTV67
 RF0I=
X-Gm-Gg: ASbGnctp3gh6nAaU57YvnxdHVI4VYg/MbNoDmi0l+ja4zb/URX6NcRQa9rtmXRog9yg
 qn1Mu+xAm0wKqTi+TgS0Relq9h806AzKQ8N4ORT4797/HZDGufsEENPeIvq/xPXUCvCssalfJ+O
 tpy4HOOAkQwUcTyPn3v3TircL5fokJIArcOngiW9SxGiehyhE0u8VfP+Pqjvcpy+FG5N1WQ8FTl
 W2BiI43SqzLOw1Kndw/2GaLQtVSe/xHYFOT2DlDA3Ds87kQuJJ4XGMDxUCdaO6kbR0xDhSHbyE9
 Vh6nZvttj3XqFKmMKSf8IIqWMz/gjrzEoKCxvoGi3MVW6hdeTHOsyG2Bn2pPILx3wQ==
X-Google-Smtp-Source: AGHT+IG/X0VyA9+eIBjlpg23/gpiC6q5rDMExQc5IPCMWapruWrwiPy2YHvflwAE1tp+5k9gGRgdgA==
X-Received: by 2002:a05:600c:3d06:b0:436:2238:97f6 with SMTP id
 5b1f17b1804b1-4392f1b8e78mr17671635e9.1.1739032785361; 
 Sat, 08 Feb 2025 08:39:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde31d9bsm7546987f8f.94.2025.02.08.08.39.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 6/7] hw/char/pl011: Drain TX FIFO when no backend connected
Date: Sat,  8 Feb 2025 17:39:10 +0100
Message-ID: <20250208163911.54522-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
References: <20250208163911.54522-1-philmd@linaro.org>
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

When no character backend is connected, the PL011 frontend
just drains the FIFO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 13 +++++++++++++
 hw/char/trace-events |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index ef39ab666a2..3c4264869df 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -240,6 +240,13 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_fifo_rx_put(s, value);
 }
 
+static void pl011_drain_tx(PL011State *s)
+{
+    trace_pl011_fifo_tx_drain(fifo8_num_used(&s->xmit_fifo));
+    pl011_reset_tx_fifo(s);
+    s->rsr &= ~RSR_OE;
+}
+
 static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
 {
     PL011State *s = opaque;
@@ -250,6 +257,12 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
     count = fifo8_num_used(&s->xmit_fifo);
     trace_pl011_fifo_tx_xmit_used(count);
 
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        /* Instant drain the fifo when there's no back-end. */
+        pl011_drain_tx(s);
+        return G_SOURCE_REMOVE;
+    }
+
     data = fifo8_pop(&s->xmit_fifo);
     bytes_consumed = 1;
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 8234f3afa13..7d1cba1b4f8 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -72,6 +72,7 @@ pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
 pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
 pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
 pl011_fifo_tx_overrun(void) "TX FIFO overrun"
+pl011_fifo_tx_drain(unsigned drained) "TX FIFO draining %u chars"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.47.1


