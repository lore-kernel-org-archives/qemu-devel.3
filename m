Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A52CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxp1P-00071B-03; Mon, 07 Oct 2024 10:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxp1N-00070Y-NE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:47:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxp1M-000463-2k
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:47:37 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so35669635e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728312454; x=1728917254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A1fr/rYlw9AI2M0g4JKjOGpNkbuvuDWs4lHkTXYOIYU=;
 b=FZ5vnJ/73BblFeW7EunOhMMTOwAMpxOJSbc22RumIQpeAiP3X7MNjjCgGM2oS/dNSK
 kS1CEk6nhJA3QV9INrxmN23buH0Q6S9wP8s2buWd90XKsypx1NR/rbnpv9bKjctYsTAb
 Qp0y+/FzthR9knIjgTYOFzXM6VeD5DXZUXXN7T3Vh/sSk05ofRyUwpHSEbUaWrdpS2s8
 xkQt7k16vZGF8cEtKIN/zGWOXN3NRzyhzGOOT8OcqKxieWfWJaA2T82gcWAQa62Dc4FW
 +rMLc920aqYU7LL53cYfl/HPxEuw88Y4fZsCvsM3ES/rOdozOSjLEjpCaBtOi4T8SWd9
 IqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728312454; x=1728917254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A1fr/rYlw9AI2M0g4JKjOGpNkbuvuDWs4lHkTXYOIYU=;
 b=U+Pmum4sj3otGEz+CND8Q/Fgw19cA1ZN+dtZz0K+cTUwtrumPAFYqCtEabONzpGB1P
 38CkwL44uISwlfnVDtMLS2LB2yYtE0EH3OdDE0lUyCXQRBKwJol9aH25f88yYm/483Ja
 oLtFnZiItqR+ya5e0u0MMXQSINl2mBk1wexgiw9ZSfVQdW6JgC+zjQ+NlClWvip397Ud
 VrheBBvlbYyaGkE6NkH7cyp3bQA0ahqKsuVncIKlAsJ33HTcmkij3lyZht/zGxK6MpW1
 ic4G/JJAo3KsU/H8CcU5l1Em1LDzP7hbGVEDK4X24PvtXmClFwfYjrYzMiNRF4pZ/N61
 5kGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhptcFlT3cHCxgfRwRYMX81lY7ecg4DtahO/uDjG4b3ZGPGar2Z1HCvO9fHFG/z7fnQ0wg3Q4YlGxH@nongnu.org
X-Gm-Message-State: AOJu0Yy+fB57dV7qySgCBeTVtv7HmqueNyM5QTc/mEIPtoklgaHT4u0p
 o1rKwhdDXmsz2NJ8B1rTmI0WX1t7HNGRgrmruCR7V0+ICnn5br1Z9Xhaw1X+Xds=
X-Google-Smtp-Source: AGHT+IGuIPKbSf6PuOle/25mp5Ufkht8woOOwN9rVjudaUD9M6fTee142HTowo5JQpUKhsyUVqjCiw==
X-Received: by 2002:a05:600c:45c6:b0:426:51dc:f6cd with SMTP id
 5b1f17b1804b1-42f85abebdcmr78276085e9.18.1728312454342; 
 Mon, 07 Oct 2024 07:47:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a20393sm94252435e9.12.2024.10.07.07.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 07:47:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH] hw/char/pl011: Use correct masks for IBRD and FBRD
Date: Mon,  7 Oct 2024 15:47:32 +0100
Message-Id: <20241007144732.2491331-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

In commit b88cfee90268cad we defined masks for the IBRD and FBRD
integer and fractional baud rate divider registers, to prevent the
guest from writing invalid values which could cause division-by-zero.
Unfortunately we got the mask values the wrong way around: the FBRD
register is six bits and the IBRD register is 16 bits, not
vice-versa.

You would only run into this bug if you programmed the UART to a baud
rate of less than 9600, because for 9600 baud and above the IBRD
value will fit into 6 bits, as per the table in
 https://developer.arm.com/documentation/ddi0183/g/programmers-model/register-descriptions/fractional-baud-rate-register--uartfbrd

The only visible effects would be that the value read back from
the register by the guest would be truncated, and we would
print an incorrect baud rate in the debug logs.

Cc: qemu-stable@nongnu.org
Fixes: b88cfee90268 ("hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2610
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 15df7c1e1ca..0fd1334fab4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -90,10 +90,10 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_UARTEN   (1 << 0)
 
 /* Integer Baud Rate Divider, UARTIBRD */
-#define IBRD_MASK 0x3f
+#define IBRD_MASK 0xffff
 
 /* Fractional Baud Rate Divider, UARTFBRD */
-#define FBRD_MASK 0xffff
+#define FBRD_MASK 0x3f
 
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
-- 
2.34.1


