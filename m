Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2C5D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVY-0000sj-H5; Thu, 15 Jan 2026 13:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV6-0000dK-TL
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:22 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV3-0005sv-Ev
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:19 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so614536f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503314; x=1769108114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zqq8lC3PTzkCbrFHvPVa1u+gK2upzDKe386+6s++ORg=;
 b=c8wmfh9dkYtWd7bjAg6VQOb3DaxqiBl+QfI19tCsp6UEoErgR9RaL+0AKwFRGdPvij
 pwGHuhc2gqKIMI0LTD2XMq7b4b66bQF6YtYixJgnmz0cSqXO81b9vZr8McD0Vt6OYC+v
 k0qQefyd/scecholdn/2t9/VLp7CgiWLSAW65BpNtv3EEYgXQeIO3U84Vj62uSjprtB9
 uTrjFglAm/dOnbw2HsRYPVj465gsxbyljcvHwfnU5CZWFP1fchHzDxu7+LtjFlbFWjhl
 W5TW6Xk7iaRrps6IkHZGg7sfBsDkTA4UY0YXKFQFXvd8IISnqaplbbtGCDAe0zM/DHnE
 Z2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503314; x=1769108114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zqq8lC3PTzkCbrFHvPVa1u+gK2upzDKe386+6s++ORg=;
 b=kIIcI9NLySX6U+0/a2/CP6/qKFohB8VFD6UXR0s4KS5NIwoP9A8cgMiKtvq30FS6ZM
 81DkPQszaF4w1Ew5tvKrByDkjWf70Jyj3qHW8zzTAA14cqL+JOAHC807GMMqTsRjLQyh
 B39MCwAh/qu2hRgjfU1ZvqnhXKrXaAMcCqVjyJG3gWGwovpMxiqdyCn2Fo6nJEi/bS1z
 xP6l2NpywKmbNQfQTkz/4PvQvBrvfu7V9hu2tVLneRiBLi0831/OLYClUslXjKLunMrC
 0AJqZMHV7uUI+VpFqoOTsToz97DuZiz+SKnjc1EL8DPUL3WwmFKnk4+zk71Qm6iUDN/T
 KMNw==
X-Gm-Message-State: AOJu0YxgQy41MUUyXpvqPx0rL3FM2EI1hET1FhHtZYzJyZZJ3Do562L1
 O6S9hhJelYzihVkGCaHpVfLcNxGIVbZmEHWXIeYNxi0c5UKQO7W5bALfI0alyjcS08xptNdfhjx
 SAj7V
X-Gm-Gg: AY/fxX7tRncOXAvbs24KtaXadRAww0O/vBnHBgOphUoL8fAJSGuw/Lc+nPWsfgMWIGB
 HmSyBkKBsZ3kaVwdkW4XMWNjkTUD1QCY6muhsqHPveybDSlDwxTDblH/V49L1ZAkQEQIVcYlKbZ
 j+U7r6LO2leNbdvkLIgYFmt0fwAhzAqYv+TXpQIZvopz8qXWUAn1xAkrFi/xGcWHLV5Xv3FDFKh
 fLDbuCDLuxXhY3YBS9GnydLUFIQOTGaIOApyTWUrBMBEuA6aZfdbR71pGkItaEiGAi34KO/fR5Q
 hIYcEj8qIUFs0tLPiukHllMKgOtd4tUE1lkPa/33BQC18mvPx3Wy8BKIXSXeTXqkjS7ZnQMBmmb
 rmxrdhPKirxvdJDBgv+3EeHzBSIr93XzWqMEhLXrZbMFBmNEuxMDjYVp2DMkbOTK2yJQGWoBqEo
 JByN/gcQBRfztFS0hru6RGP1Ds3NyqwtZ+Ts+nPYpWULnrOX00lFbezYMQmrTw5PF/tGXAUS3d7
 aH8rdOfPfTK7RoIQMJwlUKZQKPN00LaXXk3YkocL9t7/A==
X-Received: by 2002:a05:6000:25c6:b0:42f:bb9b:9a82 with SMTP id
 ffacd0b85a97d-43569bd2f46mr407960f8f.60.1768503314543; 
 Thu, 15 Jan 2026 10:55:14 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/25] hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to
 disabled uart
Date: Thu, 15 Jan 2026 18:54:48 +0000
Message-ID: <20260115185508.786428-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: julia <midnight@trainwit.ch>

I don't want to admit how many hours I spent trying to figure out why
nothing was being printed (as the enable-ing code hadn't yet run,
even thought it existed).

Signed-off-by: julia <midnight@trainwit.ch>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251217-cmsdk-uart-disabled-warning2-v1-1-847de48840bc@trainwit.ch
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/cmsdk-apb-uart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index bf891081dc..edb80f6181 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -159,6 +159,10 @@ static uint64_t uart_read(void *opaque, hwaddr offset, unsigned size)
     switch (offset) {
     case A_DATA:
         r = s->rxbuf;
+        if (!(s->ctrl & R_CTRL_RX_EN_MASK)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMSDK APB UART: receive data read with Rx disabled\n");
+        }
         s->state &= ~R_STATE_RXFULL_MASK;
         cmsdk_apb_uart_update(s);
         qemu_chr_fe_accept_input(&s->chr);
@@ -248,6 +252,10 @@ static void uart_write(void *opaque, hwaddr offset, uint64_t value,
     switch (offset) {
     case A_DATA:
         s->txbuf = value;
+        if (!(s->ctrl & R_CTRL_TX_EN_MASK)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMSDK APB UART: transmit data write with Tx disabled\n");
+        }
         if (s->state & R_STATE_TXFULL_MASK) {
             /* Buffer already full -- note the overrun and let the
              * existing pending transmit callback handle the new char.
-- 
2.47.3


