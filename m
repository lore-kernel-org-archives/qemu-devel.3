Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92F7C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs54-0003sS-99; Fri, 19 Jul 2024 14:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs52-0003gb-I7
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs50-0003uI-Cw
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so13652825e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412700; x=1722017500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8wjXx2GxaXvhCmT3K/sKVDQtxch9aqIxPKOi+RY35s=;
 b=Izxs50haudGCc2YV2T/tqmBa/fy+QhBkgPFUssAGU4kgTAw7S/vwFstBJm5Mealdxx
 5ol8W/ozfkMK9eEXE1RUFmzsVpWrtjX0TPjqovzOVdZZs5vAPH/RqO2WZs0di6VacaYr
 da51phfxhcLPvQxOer3tf9QoxgUxJD4C9fRiVgWaC453RerVT2b+NjpptIC+nUhTev0k
 uJhXnGePt9Z4vxkKF7n5uUurpYQxKOrDsg/wsDH02/8LHHSIniJKQq9DyZlMnt3Zisaa
 vvC5F2lNZELkRiikBxY0/CazCWF8e3SlgxZnIKzOFasXIcgcSvsv8n6JIJwvn3aA96gi
 jpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412700; x=1722017500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8wjXx2GxaXvhCmT3K/sKVDQtxch9aqIxPKOi+RY35s=;
 b=GQVKEuuH0JNq0cvsZm8d4VB4HdeLma4LPNWosyePji0sVvDyhEX5EmNNAQZ+9sfm1E
 uUsAUa8upLrX36e/dEeXXUxsP25YAtjgTJz3ls42wpvvMSk6njmDtHEhIO69yXVaZtQg
 pkGeLNiXMNsXOnsc5q995MwzP8C0TWZVUjc/aSpuSgJE9HmmyRhgT5gYT49ObkcKec47
 ZixC0mfaq+Kw3k9/HPEIDGPS+N4yzgWytKXYeGNoeHyFCuk9WbYVNF1JGQ6OAmn16wTC
 FaLi68zzXgen3klMVyej+FH6D/F6SyVbLTZiEcWR1hdAA5kurW9XlH7Kxy64OFI/m7eS
 GrPA==
X-Gm-Message-State: AOJu0YyKzDH+RHj5Y5kFgxYUljUHi+AFOnSOMbMtJfPZZrf+cYWy2s1v
 LTsmtYRPu3okIYljnj3l4SM0FMUnaoaLDZ+u4Y1KWKVmcu2yPiudXqv7RyF9iIGH7XGSLKFYNxA
 1
X-Google-Smtp-Source: AGHT+IEQVsRzjCNWPuwRgcSt5N92vn8toj1j0Vw3yyreHnS3jvRH2VUU2YVFQeZXLjFBymNif10exQ==
X-Received: by 2002:a05:600c:1550:b0:426:68f2:4d7b with SMTP id
 5b1f17b1804b1-427c2ca57admr55957355e9.3.1721412700009; 
 Fri, 19 Jul 2024 11:11:40 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868420fsm2232641f8f.3.2024.07.19.11.11.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 09/16] tests/qtest: Update tests using PL011 UART
Date: Fri, 19 Jul 2024 20:10:34 +0200
Message-ID: <20240719181041.49545-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

We weren't enabling the PL011 TX UART before using it
on the raspi and virt machines. Update the ASM code
prefixing:

  *UART_CTRL = UART_ENABLE | TX_ENABLE;

to:

  while (true) {
      *UART_DATA = 'T';
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/boot-serial-test.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 3b92fa5d50..5cb309ccf0 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -70,18 +70,23 @@ static const uint8_t kernel_plml605[] = {
 };
 
 static const uint8_t bios_raspi2[] = {
-    0x08, 0x30, 0x9f, 0xe5,                 /* ldr   r3,[pc,#8]    Get base */
+    0x10, 0x30, 0x9f, 0xe5,                 /* ldr     r3,[pc,#8]    Get base */
+    0x10, 0x20, 0x9f, 0xe5,                 /* ldr     r2,[pc,#8]    Get CR */
+    0xb0, 0x23, 0xc3, 0xe1,                 /* strh    r2,[r3, #48]  Set CR */
     0x54, 0x20, 0xa0, 0xe3,                 /* mov     r2,#'T' */
-    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3] */
-    0xfb, 0xff, 0xff, 0xea,                 /* b       loop */
+    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3]       loop: */
+    0xfd, 0xff, 0xff, 0xea,                 /* b       loop */
     0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 = UART0 base addr */
+    0x01, 0x01, 0x00, 0x00,                 /* 0x101      = CR UARTEN|TXE */
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
     0x02, 0x20, 0xa1, 0xd2,                 /* mov     x2, #0x9000000 */
+    0x21, 0x20, 0x80, 0x52,                 /* mov     w1, #0x101 */
+    0x41, 0x60, 0x00, 0x79,                 /* strh    w1, [x2, #48] */
+    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
     0x41, 0x00, 0x00, 0x39,                 /* strb    w1, [x2] */
-    0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
+    0xff, 0xff, 0xff, 0x17,                 /* b       -4 (loop) */
 };
 
 static const uint8_t kernel_nrf51[] = {
-- 
2.41.0


