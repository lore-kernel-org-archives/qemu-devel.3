Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DD0EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMm3-0004Rz-N6; Sun, 08 Mar 2026 18:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMm1-0004BT-PQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMm0-0003gI-81
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so70655e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009534; x=1773614334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JR52r9ZtO9W2DgERQA3WBebgIB8kxNudBv3P2ybJoFI=;
 b=tTePaCLr+f3gsQrvkj0uDO9NS1YEVUSPP3g6+Q5FCjLl2TtE1aTugRABG7pAdmOyKs
 2WaL46gUh4QYKD+5gi3UX8U2cJeMFwq59iVJeWD4ifXh4OvEP8Pl247X7WkQkAZSwyxu
 DalriNKTzt77Z+uvNrbJp+dXa3ZzK+7doY17eWVMJOFsx+/RiKJzwvwq4plEqTvFw/GE
 0+JzRJ5VkiNHhTQ3yE2BJoHBOsFLwrm0xl4BK4oVIcQA8+G8eliwj7p1Iw5gtAUHJp6e
 JPVezSH5nIU7L99/NPP1gRyIHPM8xrOG5HcDDE+DXZarCA4PS2/dN1a8y5Dssu4prlwP
 u+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009534; x=1773614334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JR52r9ZtO9W2DgERQA3WBebgIB8kxNudBv3P2ybJoFI=;
 b=qdLuy3diUfhhHDOFWC/aeN4HD0yulDkW0V5QA0KAvnF9/o1E5yvfG45rLK0mQB3OJC
 DpELPy4H2nM5DddZ5fcStNcrRoN/551DTCesAsefFi81BqEH5WJixHgBXy9S8+JPdTG3
 Z+NdZFW8YzWRxZ36FJb9Bn06qpAHgHZgDSwfP7mbQBubyFfLCjuodFW1JGR0U0UX61oX
 z7GNa8kMtWHWcMfOlN8LNGomipiTDXuFGe73svWtlEAHr88mf3yzPTeHS0wTYap1jxsp
 5xKO+zKJKKvrHKkSez4/ITbmOQrh2oaVL3Nlc1hzVPomxvoleBQMa18cTeTwsWWNQTZ7
 8iCA==
X-Gm-Message-State: AOJu0YxLGSISe2mYUxzTDwQH+HPCO4f91BVC4LbdZe/+g9LC57bV3ivc
 R1ZHb2Q2hQvihl5KcqNLdfmkHeKDtpX7XavV07ZaLb5cPjxaGrszhPrrx1EJAdew8E6IPuoQ/47
 w9SGxpLg=
X-Gm-Gg: ATEYQzzgoCT/mbPF0pl9rHD3XhfDSRpsBwDF19F2rvlNMI/UOzBNMJ6Ebz/QhhLpwoK
 BENAy8CUCwRNgCsELY/7WZf/1T2Wi0Ix7IA/et/pW6PyB5Q8XM6V3Tzst0XEZKRwJAqdormMZAd
 l+gsPrphtUs0uV3IhCjse0VHK/+Y+n7M5RXFXupkBJKaVxucF1i3Q7Ja3YbHlfa2g1b5R3nfi56
 0zXujV4FBbS5w+LpcsjcsfoK4fVOm+hX4E09HSAhReifDLZOVoud1JyAsb7vQ38yCmC4waBQsvZ
 KL8tq287PXycSbIJuEW63YuNnYl3LS61E/qngXrVrx4CvEQUkIHDRkqlosBkQ3BUw3pr5qoiTvP
 98nMtPuo/3SX7OCfm6M7nfwtmFNbVIbXewVAqEd+CPLfvUkAZUJuD2VM4tWnH0ijnkQQxJD1fGF
 Wu+Wu9Z7pT1LYTw0NfWsaBNWJVyrMGO3SLL5Wqp92ZOJQUVlo/c6mT372nsQskQBAPL1u8iYrCQ
 Xr20g==
X-Received: by 2002:a05:600d:16:b0:485:3c14:885b with SMTP id
 5b1f17b1804b1-4853c148d07mr10787375e9.28.1773009534370; 
 Sun, 08 Mar 2026 15:38:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9ccsm20591505f8f.19.2026.03.08.15.38.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/49] hw/char/serial: Remove unhelpful comment
Date: Sun,  8 Mar 2026 23:34:22 +0100
Message-ID: <20260308223433.25503-39-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
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

There is no "is_load" flag and one can tell from the method name what
the method does. Remove this unhelpful comment.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260305220911.131508-9-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2c558cb9fc6..f73de1ae4f6 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -281,9 +281,6 @@ static void serial_xmit(SerialState *s)
     s->lsr |= UART_LSR_TEMT;
 }
 
-/* Setter for FCR.
-   is_load flag means, that value is set while loading VM state
-   and interrupt should not be invoked */
 static void serial_write_fcr(SerialState *s, uint8_t val)
 {
     /* Set fcr - val only has the bits that are supposed to "stick" */
-- 
2.53.0


