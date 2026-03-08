Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57703EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMlx-00036q-3o; Sun, 08 Mar 2026 18:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlu-0002g8-VH
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlt-0003fq-Bb
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso18739835e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009528; x=1773614328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6C8YP53jTJUFe5XlsI4+jeif+amgbN6vtqB11RHrjI4=;
 b=pAwq5DG+XbgTLiG8qj+OBav2y2oUp2DxU81avMspomzk7QZ7oy9udB6cpY/avgzDkT
 /jZ9WD1LFbt5CihScFsbTFotIvdr30Lg9QXcJYpCB3zwBv/ytThC/ShFh2pOGaaGbWYV
 QanR4IeG8gPB+rFEljrfTMIPGKw3tp6syi+9fEV+B51Hbr3ZZhbRKh4G+OSsAWM9kLrZ
 clMY0cZE3opFtaeWwMQg6eCAxGA5lqkqaTKKD2/MGEj4p8EdKjRKwj5cOBR6wI7ZVJgD
 Ve0mFUuWLvH8/iT6SgwX0rx2s6oNHR/ZPH/gr8EllhsuLEGuLEKrkOXMge40y1wcPXco
 3FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009528; x=1773614328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6C8YP53jTJUFe5XlsI4+jeif+amgbN6vtqB11RHrjI4=;
 b=ZZDq9HglO4Zud7nz1NISVcWGtCCJ0O7XqRYYHBCLnmUN/09lo+GYsXQiAEkkbt7wMO
 wtC1PlPnemRVB+bGPnhZnUeJtkAL2Dcw7U2GDvZp/XEH9g7AImyhaYPaWFAyKp0M630S
 jjDFZfifGyGRp56H2wZRv0n6E2aV858K3kWoYqmR2fDEN1z9WEBO+Xs/RVGpoaIleySc
 gRAtHzTn4vg7BFiqjUQwnV4TgeVSd5FIMUXwYKLq8M9h1CDTlNUqqYsIIcx9ZvRiILUR
 TSSCXOuFRuMl1IuT8r7C9XLEtIt/tIwGC/DY0+6dBDzjh/bJ7Qxo9A+e/cIRDsm9YCIW
 kIrg==
X-Gm-Message-State: AOJu0YzIGkTqx/lLBzfsKKk7J07pesa11BqR3XfQs2bwi7MJJMY+8Hrf
 v/N+4Y/C6hqAmeuBWu2yJLXsTPkiyMF0o+xxTqoSZEUm0g7v57QtMsZr3j1RnX06JcbiiD7SYz4
 PDKznXlA=
X-Gm-Gg: ATEYQzy5YvqgYigwo8/cNzut+PbCFxfpGyDqFdQgGTFmPDW2ZP0Zzgl2fI28vuqiHFp
 pG/urHaZIJAE0tLRPEz/r2mwBlRCD6DWFfhiKfCwxzcbw4aY3ucotuyXCExc8t/lzB6rUdhYsYR
 /4h8vg0hAucn6IOm+3tzcg6nt990Zr7F0W73WaK4tPNZIRLRVPqLQ/LjINDeftRUbkmIFLDnA0g
 f5Csy9CA1qJ72CPzFpK9NDQpO5QFmBGZMlI0RwMhcAwnSWXTxwfr8Dg8hyBp2c+e75EUTf2hbCQ
 lo6xvy0pw4hDeCuR1rk939cwmlpxkuqs8llrzUSriFKOBSTtAXXvOuH/MOl0lcYoE5HbuGDH/jR
 LtJZe0YGxt9cAeZBvQtsGWK/3JG6ZnSz+91UHesXV2HQh7ag2prlB7TlUYkap7WJr46Nwgj3FV1
 9EWKThIweWPDLF4ftIMgI3Yai2vpZ6R4HHCUnfwda+AZWghUAD1SiYEuikCzmTgZ8J8OE+SOEHF
 Sqe1Q==
X-Received: by 2002:a05:600c:1e88:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-48526959464mr147091035e9.17.1773009527552; 
 Sun, 08 Mar 2026 15:38:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686bcesm339163205e9.7.2026.03.08.15.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/49] hw/char/serial: Reuse fifo8_num_used()
Date: Sun,  8 Mar 2026 23:34:21 +0100
Message-ID: <20260308223433.25503-38-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Avoids accessing private fields of struct Fifo8. Now, TYPE_SERIAL only
accesses struct Fifo8 through its methods.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260305220911.131508-8-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 20f68fd2f83..2c558cb9fc6 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -128,7 +128,7 @@ static void serial_update_irq(SerialState *s)
         tmp_iir = UART_IIR_CTI;
     } else if ((s->ier & UART_IER_RDI) && (s->lsr & UART_LSR_DR) &&
                (!(s->fcr & UART_FCR_FE) ||
-                s->recv_fifo.num >= s->recv_fifo_itl)) {
+                fifo8_num_used(&s->recv_fifo) >= s->recv_fifo_itl)) {
         tmp_iir = UART_IIR_RDI;
     } else if ((s->ier & UART_IER_THRI) && s->thr_ipending) {
         tmp_iir = UART_IIR_THRI;
@@ -563,8 +563,8 @@ static int serial_can_receive(SerialState *s)
              * the guest has a chance to respond, effectively overriding the ITL
              * that the guest has set.
              */
-            return (s->recv_fifo.num <= s->recv_fifo_itl) ?
-                        s->recv_fifo_itl - s->recv_fifo.num : 1;
+            return (fifo8_num_used(&s->recv_fifo) <= s->recv_fifo_itl) ?
+                        s->recv_fifo_itl - fifo8_num_used(&s->recv_fifo) : 1;
         } else {
             return 0;
         }
-- 
2.53.0


