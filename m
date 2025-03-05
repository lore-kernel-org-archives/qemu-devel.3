Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A3CC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUr-00037j-Vo; Tue, 04 Mar 2025 20:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdU0-00017G-L8
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTy-00076h-TB
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so21509305e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137813; x=1741742613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXL5B5zw3pZta0/9DCa7fbyWVn6oj5wqXc+Tu2wdyGc=;
 b=lPhjsJhh1qGpQTamOxZIoAJ6mnhtpFCBrkCBdqaVgtNDLpyk0Cb3opFylqsOTLEdWA
 Lp6QTM9o9im3+WoMPNwod0Nq9CwJPhoho1o+4kERSY7cBvUbcOS5if4jK8oRtlMSWG8n
 I6jbph/wRMWET26IMhK6CSzfaAgdrAXTi/zi02yz6A818cX0Uq0tbg2+dTWZWtkjlZ3B
 r35pB3c+MxSVXJNlQ5FPrV+Xjugv5qGENU/dtTQmKWw8zRdio5aayz7NkEWJncM/w37N
 8InxAFZ6Ntp/EfT1QMLp8ZziXFY/2t/7rlAbMybkoM714VK1VVXVEMvTGKf8Qte2AkJi
 +saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137813; x=1741742613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXL5B5zw3pZta0/9DCa7fbyWVn6oj5wqXc+Tu2wdyGc=;
 b=sROAVgZdid3AHzqIENrRBfVvYALefCveAS2+qgS56fh/TkMYKLa9hovOn0+he52cDM
 W+wY8GwWwDqASmtwuujyQAgps2RoSR6AgkiliKRmRFuIRIp5LrdiC8E8mt5pHUS391FQ
 Jv/4Ac25IwAI2AOHrBxxBL+joz24Sh8fPb+cMixtEOmNS6QCXEu0sszyANmlDyq2fnjy
 cssn7GLQQLPVEj9iQ6F5kZnwXvzlAUFsvAb2aRdo+SWBrHjxIEmWez5lmbJyd4smZQt4
 ukYQyz/oRzoV5VYb9tChpcTQkKm5jVI+nJvfQoedpKfpA1PntT6wHRNUhz0VPA8IJxkO
 Qo2A==
X-Gm-Message-State: AOJu0Yx2vqg0hJtp3nbQUzxh+k1MrfecBX52Wr3rz4zNEuucD/wtaVol
 BTFqxpu/NQe3wOyABcUDiqqdCzqUFCkp1x30yNcronfH2y5UBv6Tq/++FeuctaA0dmC4aEX1pGJ
 SynI=
X-Gm-Gg: ASbGncvZhYTbvLxemymL9Fqqx4DRXc272tw0dv/U+3MgtxjuxBsOn/2FlasPKpLvPoH
 FklUjiau4SiJIRK/7rSd4CJwyFKXo3mdhmvL6FZpb6zNY+lkWJbqH4tEFLsT+/pFHLMTlxb82tC
 MR6EopKPo9YiHfs+fCWnLZ83Fm+ivrXprZXoQbpyHbX0tdnxn5NjJsUAiHJpe9xE8dQVIyKxUBX
 EnCGCBSAWV/Zz0dsFzholFpwRLiz9JdfaNnkwdcMGfCr1CqH/hGioBn6ia2bSZhBTtGvJFiGAsf
 yY6OIUkrSS8D9psKJtLlDINOP4prSLaEfospGGHFy8h6d4y63fMeYfXhZ40dV6HsNsxFo27Yzps
 6wP6YLRM16kdv0jaOIyA=
X-Google-Smtp-Source: AGHT+IF/guHa8k1/nCw46LIANCQTGevHIRFKBoA3EzattkIkY3LlS3BPfihgea5vcJJsBjaKX/8Bwg==
X-Received: by 2002:a05:6000:4185:b0:391:5f:fa4e with SMTP id
 ffacd0b85a97d-3911f7476b5mr487607f8f.29.1741137812850; 
 Tue, 04 Mar 2025 17:23:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42e51e8sm1956345e9.26.2025.03.04.17.23.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PULL 19/41] hw/char/pl011: Warn when using disabled receiver
Date: Wed,  5 Mar 2025 02:21:34 +0100
Message-ID: <20250305012157.96463-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

We shouldn't receive characters when the full UART or its
receiver is disabled. However we don't want to break the
possibly incomplete "my first bare metal assembly program"s,
so we choose to simply display a warning when this occurs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-Id: <20250220092903.3726-2-philmd@linaro.org>
---
 hw/char/pl011.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 06ce851044d..12a2d4bc7bd 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -85,6 +85,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_OUT1     (1 << 12)
 #define CR_RTS      (1 << 11)
 #define CR_DTR      (1 << 10)
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_LBE      (1 << 7)
 #define CR_UARTEN   (1 << 0)
@@ -487,6 +488,14 @@ static int pl011_can_receive(void *opaque)
     PL011State *s = (PL011State *)opaque;
     int r;
 
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 receiving data on disabled UART\n");
+    }
+    if (!(s->cr & CR_RXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 receiving data on disabled RX UART\n");
+    }
     r = s->read_count < pl011_get_fifo_depth(s);
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
-- 
2.47.1


