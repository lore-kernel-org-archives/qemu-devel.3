Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665A1EB3637
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBM6-0000Jr-Ii; Mon, 02 Mar 2026 17:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM5-0000Ib-9U
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:09 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM3-00016q-KB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:09 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43991064db8so5136283f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488986; x=1773093786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a20X3LL6nOL1DHB0RkjcJ0CTq+OL5+eKSUsrTa1dqPQ=;
 b=MvjC4EyZ1YXn7IxuPGZ0gkeUXoxwkLpH2z16v8aU170tL0+/ZEcMNUhsjmcqZy7QV/
 OwHFaPYiZMjrfrWoIkvzYf2m8IWgqpsx2KWDTFA+YhB4egUAsHPnKNFjk7x0omSWEs7X
 /Ui2muAcF7DQn36QQkBRTy3p5Jdx1fqA00y97wmYLEpjz38MAtPQL37F0AlFVTdoKtrH
 CgHIReAUEJs8BSBZyRI189j8BTtsHI5ITwgXfzS3vz02tpt2qC+XvxPiBMWKgX/nZo3z
 WU8uiFryrLbEYdt89f0lATjf8hGMaOmETMuYrus7ZZLbY+cORrfDdc+W2jDMgU6tn2to
 LOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488986; x=1773093786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a20X3LL6nOL1DHB0RkjcJ0CTq+OL5+eKSUsrTa1dqPQ=;
 b=S8lvnmpRajOBmSlHkAzBXBoY3wQ1Nzj040CSiDINbNn4g9WIGlz2RCB0liJft0/t4T
 gV51Xgb1ooRnlZ2BUAXtEKrr31g+6psKK/yI0oXjFIilpEOg/4rxHJNcmK9TTZXpsr2U
 YzemoHu5KIpndy0+zgByDDcrxHOvGRw4YUXn+zjbQr3nG5bip+S7tYAv1s2d4OzExL5L
 H8KHsGR/791aTy0YeEgKm7Tt5+V0Py1K3GXw/dDJ97+RTDK8IrHeP0uWz6NTWw+PRxV4
 SOlYq23XKhbwiX12CkbvDrKCf7WO3ddqeBtuY5IQ5ig68qs5fnb2xd+LiBXZ6hk+azKz
 Q05Q==
X-Gm-Message-State: AOJu0YyUT2BMN5QduX72FsQcSgcS/9smOeovtjArvwl7PUDS9yP7Szbk
 CBzyTODyZgAIs4yS5MLW5uTukYwDXSZ0CuLmLAdUBh3oXHRqYPaiesA1dFUL1A==
X-Gm-Gg: ATEYQzznkO1VH0V+7m0xtgeu0U/NVyTDuMFiSBau/gjhyNCoyeQfOCBbyhBzeMIvIYI
 6Q7kcf1a6RBiEfLmO28SFCmgilRUz/5A3Z+h6FGJBJDRraXeqLIJDjoC1bQoF2j5dETjy4j0YeF
 L9hmdzGqNaLGf5x/N0HoX0ys/XpcOGByP5ykPejtfjJ57pmGyWxMIUIKWTO0/OQlm65/C9SvYfz
 kPS21hgxzPhNutz9zUSsgS48s0lRDJBh86ve22oDoaoVA8L+wqbwQ9ET8msk6xB3LLjXQ+hZ+yS
 jDI1gHMVT/G+c1SlWz3/KBgkawdjDcMjAFWq+JV5q4/DX+iyXX/Na9/QUjyGyGu1GCD+Mq9bmyq
 JNzu0XWTMAmIcYyWAuax66S0Lk3aQyIZCdiYk7HLYFC9SznYx6suWKO7qOpXwBAZ2wSKI+IHEnG
 4TwVitOc58WFVYcEJ/FVvadP+8sr15WhOcFuw9afzmX7W67aXDvM3I8Eh+k8KwX/nAAtaXI5hPt
 OhwdiAX6cvGDbhPkC91QDA/T4phXycddyl1UnwjvHZlYNc=
X-Received: by 2002:adf:fa52:0:b0:439:ab3d:1c27 with SMTP id
 ffacd0b85a97d-439ab3d1e51mr12575085f8f.2.1772488985526; 
 Mon, 02 Mar 2026 14:03:05 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:05 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 02/12] hw/char/serial: Remove explicit cast from void pointer
Date: Mon,  2 Mar 2026 23:02:44 +0100
Message-ID: <20260302220254.1166849-3-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A void pointer asks for being casted, so C allows for omitting the
explicit cast. Take advantage of that.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/serial.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index adbd1d1d4a..0f2e79dfba 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -715,7 +715,7 @@ static const VMStateDescription vmstate_serial_thr_ipending = {
 
 static bool serial_tsr_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->tsr_retry != 0;
 }
 
@@ -734,7 +734,7 @@ static const VMStateDescription vmstate_serial_tsr = {
 
 static bool serial_recv_fifo_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return !fifo8_is_empty(&s->recv_fifo);
 
 }
@@ -752,7 +752,7 @@ static const VMStateDescription vmstate_serial_recv_fifo = {
 
 static bool serial_xmit_fifo_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return !fifo8_is_empty(&s->xmit_fifo);
 }
 
@@ -769,7 +769,7 @@ static const VMStateDescription vmstate_serial_xmit_fifo = {
 
 static bool serial_fifo_timeout_timer_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return timer_pending(s->fifo_timeout_timer);
 }
 
@@ -786,7 +786,7 @@ static const VMStateDescription vmstate_serial_fifo_timeout_timer = {
 
 static bool serial_timeout_ipending_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->timeout_ipending != 0;
 }
 
@@ -803,7 +803,7 @@ static const VMStateDescription vmstate_serial_timeout_ipending = {
 
 static bool serial_poll_needed(void *opaque)
 {
-    SerialState *s = (SerialState *)opaque;
+    SerialState *s = opaque;
     return s->poll_msl >= 0;
 }
 
-- 
2.53.0


