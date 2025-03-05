Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C49C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWl-00062x-9N; Tue, 04 Mar 2025 20:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUE-0001v4-5l
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:50 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUC-00078k-9C
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:49 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso1801685e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137826; x=1741742626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcgROWvnD1tl+yrdTbb0OGaatnzB/uZ+RCngGMPfVPI=;
 b=kwNqBOVoIKq4isWbIsuNMEaGOeiprGc7QpBlix9Blo1RglkvVlT8tJxFlNgWrxipoH
 N9WiiWjcKvad5WSeBQ/pY/R+m9wiCzCWfM1w/i8UB7E9yjcs8VRWUrXo7hnUR4I9qJFR
 PGTsoTOxuNrDCvQZgq/zZeaPwECVi6Ztb/KWQWYoYW3iZJIKCVQkHkbPWyNdkDp6lOO3
 8xEhjn5wbY82JvUB8YaGU3SVGKb00Q4AOvPfzbFqEYbaTitJMEYyp7cUbqt9BqofhO+I
 gJUC6Q6cRMpAI6j2X1EuL8dShzJPBP6Lp8JMk7d1s/JMSYjFsYhElbR0Vl3QIBkjitPC
 hiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137826; x=1741742626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcgROWvnD1tl+yrdTbb0OGaatnzB/uZ+RCngGMPfVPI=;
 b=qkhsM4NrrzgtOOjT1j5mG+hNWB6imYV45hWyiYzVyqh5xUv2PYAHFA8V70A58bUOf9
 vv4ciVIXf1QTelH1MBnsJ8MQWA7gGaAp6cjIXSg3WzZYzVhQak7lABlsJVXRGKytOkqf
 VVch3FBFFTMX0xAzb+1HEL2Ya1TTLpwSwR99HzEdAx7pMkVfQIaBONIPvEHwhliHZjbh
 BKFGaeHCLgrrlx1HPHI2LTk3byF3ZbcGZW/OT7KCHOOo99c1w14/FYOI9fsNYvz0+xWQ
 U6EUBfLi5o08RS9PlngEx5vqjoGwl6wAKU9eraZlyG74gRoiva78rDu/lXpeKcSPu556
 +r/A==
X-Gm-Message-State: AOJu0Yy5ggElejZK+YczNHunPOI6x00+raVNWIVhWExWC1HY7xbH4jjJ
 gqKLw4WVW9O7td7KBVTzmSFwoLYWhNYVlWgbIv3ojCLdnoNOCOWzMGHbDumA3MPCFN6SA97SlCJ
 hT7k=
X-Gm-Gg: ASbGncsaLnh2g9GV6KN2yrNp/QWlxD6qa7/vR/wilqNUVoV/NxEOwNz+/N2DxgwDOrz
 FiGF0FFjnIww5ohejMaJoW5gWAXh/tmXRvEps7JlJwOHELb7MhJLy7Wgt26VJOEMtGdLzGeJGrU
 GCyLUMMGRG1tnLHDR92r/kjw4KLy958JJ3siwHrkxZ8A3LAiTFGSB8yCoe3GyK4Udd4AIBLmyNf
 /t8jv4DWjH92HAeox43HfXggBYCWN80bxTIK3QAG1K81fef8cqmomgZsNvOQWvicR9uv1/wtGB1
 RhUY4BsxdsSthvaxw2qX0NHjzwTyOf6vkfGDEXhKyqb1xjHXIaWQZsiUhIV9DGSwh30Zv88o74L
 uZgJMLn5JucFoMx56Y7E=
X-Google-Smtp-Source: AGHT+IGcysnovb8MSwaDqBRnJJwPKabu0cPJHuHe1dre9qbRvl57/QtiXmpCD1KLbspo17XNuMrMXw==
X-Received: by 2002:adf:e183:0:b0:391:22e2:ccd2 with SMTP id
 ffacd0b85a97d-39122e2d080mr64186f8f.3.1741137826487; 
 Tue, 04 Mar 2025 17:23:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426cbc2sm2045285e9.4.2025.03.04.17.23.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/41] hw/char/pl011: Really use RX FIFO depth
Date: Wed,  5 Mar 2025 02:21:37 +0100
Message-ID: <20250305012157.96463-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

While we model a 16-elements RX FIFO since the PL011 model was
introduced in commit cdbdb648b7c ("ARM Versatile Platform Baseboard
emulation"), we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Example of FIFO better used by enabling the pl011 tracing events
and running the tests/functional/test_aarch64_virt.py tests:

  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_receive recv 5 chars
  pl011_fifo_rx_put RX FIFO push char [0x72] 1/16 depth used
  pl011_irq_state irq state 1
  pl011_fifo_rx_put RX FIFO push char [0x6f] 2/16 depth used
  pl011_fifo_rx_put RX FIFO push char [0x6f] 3/16 depth used
  pl011_fifo_rx_put RX FIFO push char [0x74] 4/16 depth used
  pl011_fifo_rx_put RX FIFO push char [0x0d] 5/16 depth used
  pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
  pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
  pl011_write addr 0x038 value 0x00000050 reg IMSC
  pl011_irq_state irq state 1
  pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
  pl011_read addr 0x03c value 0x00000030 reg RIS
  pl011_write addr 0x044 value 0x00000000 reg ICR
  pl011_irq_state irq state 1
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 4/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x00000072 reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 4/16, can_receive 12 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 3/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x0000006f reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 3/16, can_receive 13 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 2/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x0000006f reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 2/16, can_receive 14 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 1/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x00000074 reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 1/16, can_receive 15 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 0/16
  pl011_irq_state irq state 0
  pl011_read addr 0x000 value 0x0000000d reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_read addr 0x018 value 0x00000090 reg FR
  pl011_read addr 0x03c value 0x00000020 reg RIS
  pl011_write addr 0x038 value 0x00000050 reg IMSC
  pl011_irq_state irq state 0
  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_read addr 0x018 value 0x00000090 reg FR
  pl011_write addr 0x000 value 0x00000072 reg DR

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250220092903.3726-5-philmd@linaro.org>
---
 hw/char/pl011.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f7485e7c541..23a9db8c57c 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -489,7 +489,6 @@ static int pl011_can_receive(void *opaque)
     PL011State *s = (PL011State *)opaque;
     unsigned fifo_depth = pl011_get_fifo_depth(s);
     unsigned fifo_available = fifo_depth - s->read_count;
-    int r = fifo_available ? 1 : 0;
 
     if (!(s->cr & CR_UARTEN)) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -500,7 +499,8 @@ static int pl011_can_receive(void *opaque)
                       "PL011 receiving data on disabled RX UART\n");
     }
     trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
-    return r;
+
+    return fifo_available;
 }
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
@@ -515,7 +515,9 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
         return;
     }
 
-    pl011_fifo_rx_put(opaque, *buf);
+    for (int i = 0; i < size; i++) {
+        pl011_fifo_rx_put(opaque, buf[i]);
+    }
 }
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
-- 
2.47.1


