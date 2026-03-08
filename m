Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BDCEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMls-0002GX-C6; Sun, 08 Mar 2026 18:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlo-00025i-Vt
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMln-0003f8-Gy
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so17236555e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009521; x=1773614321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6qexEWqj7iCTD7/+Rc0f8L0qzeY//jV37wBu4R3LB4M=;
 b=SLkXTOOhvbej8yz5Srv0SbmuquI4iG5zSgUB889Zr5zXY7n9ztClSs4LgxN8Du8974
 Y1Fnmk8Q30VvtxCAyas6dGKUXLpDIAZ1OVT2KV8J7Q3Ezbl8CvD/YHc9KTM5Zjn5sA1s
 X/SqSY1VQ6fvslunH51/DX3tE2o/7EfLrumtDEdhCR1LYn9JRFIzGcN8ttNH3ImWA1nT
 PbJr7sfr+BFrk3h0Xbm94v153+6Sn7rJwE+mWjKAzMAEsA5S7cQms0D7/sCpORNyTLn+
 +dfbRLGYw0W0Omi6filii3k2rJee49k8VDEZTjkxpniJsFnDNNkdTyCQfdR9+Xt5i03a
 O+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009521; x=1773614321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6qexEWqj7iCTD7/+Rc0f8L0qzeY//jV37wBu4R3LB4M=;
 b=Nxxh0kl20I3TqZYaPki4KdGSb0UyjJBVMIrWlOq2jhuipvTqQtfwY36gMZOIuFSJdX
 oDf01et92sBLx3tqgzWl6ExyTn/tp+jslcBM1psc3IWpN+PeURv0LPU3FAlR8tlkWnw+
 wXjRjVW3TPg3urP7g3qZw8Bfc4YDxAopFCXyeRPkUXbmt5Y7QXdVErXyQGGmuwC/Xy+1
 mVFN2QEz+J0NTLRtc21XeVBp+LBW6Ne9HWxRlgZeT2p9zTN6Qrr9O2vkQKnf18bx5HZC
 iDsA4WNn7Mm/HFY8wFmpADzbhcWEkQstjlmZWzz1keCbhhvW0SZ0xjbh/z14F4y7qIHW
 9pYg==
X-Gm-Message-State: AOJu0YxNaVVwxVQ5GrrcbPFvWl6rq1QDhPxxxoSxyMbK3pS2wn2jQJ6h
 nNFTEQwGXq+pnkW6klXgVhocAh7rEtUNQZypw8n41z5lJ/YpmtJ8GQ1MZPtViZJSn1jGMtQbazB
 nEYJUnCk=
X-Gm-Gg: ATEYQzyYp2rotDloKypKopNlb0ASBTFvx2Dv0JhjfMhSFOu/5Labas63y4WQn8c/Se3
 Vz8Y+jSLqE8yIbnpIqmbdtC11PdUeBBRWXpK/Tum+ytPPDq/b18xF6BQrL/CDib/2xUmLpaEFLk
 A/wdXs9Dx1bBp1hJfnwdkrbY+w83onCD8zok2q4oyr7w9iKZMejgs0v/1F+vJQ2XcIj5cMqKTB2
 iYTVeAkvjUKNdWCs6imk7+50OH6vYfUnnQ5PQGNFobGAO7nUubzmUSO/JrLpPANmxK5TosQCVVH
 ejm2jFX7I+GvPzaJ3VC81tVLmTRcF/fL1uY2T4ReN9qgMY9ixTHqYGw5S4Bwf+RPNFoe2mwGqRT
 eP7riagBmr0Sshdz2/AZZr1aZ7Evuw82kJqZCx8EKaL7um5H6K46DTNvdg5vntkzXrslew2/6oP
 fu0ayPHVPSmrPqJmg3FdLGuTyyd6rW8YcvEzNDAX+SKAX+Tbg7RJB4J5Dz8Bxq6hScfG5w0lCGj
 s/lv0sxwi6UXoIf
X-Received: by 2002:a05:600c:3e87:b0:485:3e00:9440 with SMTP id
 5b1f17b1804b1-4853e0094acmr927015e9.24.1773009520999; 
 Sun, 08 Mar 2026 15:38:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e3fsm200375215e9.6.2026.03.08.15.38.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/49] hw/char/serial: Prefer fifo8 methods over open-coding
Date: Sun,  8 Mar 2026 23:34:20 +0100
Message-ID: <20260308223433.25503-37-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
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

Use fifo8_is_empty() and fifo8_is_full() to improve readability of the
code.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260305220911.131508-7-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0f2e79dfba6..20f68fd2f83 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -239,7 +239,7 @@ static void serial_xmit(SerialState *s)
             if (s->fcr & UART_FCR_FE) {
                 assert(!fifo8_is_empty(&s->xmit_fifo));
                 s->tsr = fifo8_pop(&s->xmit_fifo);
-                if (!s->xmit_fifo.num) {
+                if (fifo8_is_empty(&s->xmit_fifo)) {
                     s->lsr |= UART_LSR_THRE;
                 }
             } else {
@@ -481,7 +481,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
             if(s->fcr & UART_FCR_FE) {
                 ret = fifo8_is_empty(&s->recv_fifo) ?
                             0 : fifo8_pop(&s->recv_fifo);
-                if (s->recv_fifo.num == 0) {
+                if (fifo8_is_empty(&s->recv_fifo)) {
                     s->lsr &= ~(UART_LSR_DR | UART_LSR_BI);
                 } else {
                     timer_mod(s->fifo_timeout_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->char_transmit_time * 4);
@@ -555,7 +555,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
 static int serial_can_receive(SerialState *s)
 {
     if(s->fcr & UART_FCR_FE) {
-        if (s->recv_fifo.num < UART_FIFO_LENGTH) {
+        if (!fifo8_is_full(&s->recv_fifo)) {
             /*
              * Advertise (fifo.itl - fifo.count) bytes when count < ITL, and 1
              * if above. If UART_FIFO_LENGTH - fifo.count is advertised the
@@ -585,7 +585,7 @@ static void serial_receive_break(SerialState *s)
 /* There's data in recv_fifo and s->rbr has not been read for 4 char transmit times */
 static void fifo_timeout_int (void *opaque) {
     SerialState *s = opaque;
-    if (s->recv_fifo.num) {
+    if (!fifo8_is_empty(&s->recv_fifo)) {
         s->timeout_ipending = 1;
         serial_update_irq(s);
     }
-- 
2.53.0


