Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCE1EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMls-0002Dc-3N; Sun, 08 Mar 2026 18:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlh-0001ii-Af
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlf-0003e0-Mc
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso5556420f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009514; x=1773614314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c0hbwBE0hnQGstdyI1VIsE+1GxU4ynbA0Wq9xhPHvFk=;
 b=KwwvXer2rR/xtAG4D1AujNQnvu8WwiS5Ho2dwYv4RsIOPbSxH1EvVe6K5PJf1MiPM+
 dl1LmH8Tu7o9EM/mYh5xtGJvwxMDpUsifIWCwycQu7M3ajEtK0jg2rC98dFhXQmFBL2T
 2pUBOy3paPI0CtBOzJTXFU6FIJGKjx0SHfkf28GDeDjR1i7zTRNUAbR4uzBYqyYl50HW
 dHsmmnhSzOPVJnVU/KZ6pfPZ3HNvwKGcpNF/051xM5m3oxPydpTrJ/TF4cHyIO3/d7c3
 qEQTwzkF/i8IpY0QceVPgJay+VCrkKImsPrbchcq40kX0X9Ci7Sk3Npx4JqGe/2Ts94F
 Reyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009514; x=1773614314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c0hbwBE0hnQGstdyI1VIsE+1GxU4ynbA0Wq9xhPHvFk=;
 b=c5BMaZLaLVirbhV6sjDDQVJS6vshf89N+YQIHwuINxGSgfg6NdUZ1roMQeK7AXxWX4
 97d0mFbX/1ZrjnC2RmxrbOvWgGta/m5p0OZPx2Gs/NAiJL88ZCklRTD6N3X0kfvAeGyS
 1RWt4aeUcN/XgPjfz8gNdKosQz0txfcSvS409WMaxb9ZPzlQxOKsC94VBXVJ4j16Pc32
 18rJxLexkCmaWPkeTCNFEqQQ8qGEpMOI0QvfxjJspiq3DiiS5I0rBGR4GiFnWz8b7zWX
 xa8wwQej27XpxrPfGxpdbgUOWw6N64ZD4h8+s7IYV2ey45OUXtKJkUh7zsKr2h5nw/Tq
 iPvg==
X-Gm-Message-State: AOJu0YyvZenpzKNsmrYN/dw1uD2a0p5lKt3oSX+XoaN0p/Bw5qupgmZF
 10PAO57G+maBFHI2W1uaUHmm/ODHw0sTVivTgT3/K4gmnxcqhMeFko5y+/N8NjttYxYin3iU/nD
 voDQfClE=
X-Gm-Gg: ATEYQzwFwv1PG9lzVqzYZxPwd2ykZfHIXJ4jebXHvFdlmLlg7o4Mqg6U/NaKyx4DGP2
 +T0Rwvmc1hdL3T4une6pJxtzpAsac6JzjXrMnFiOQa4/oVYwnCuPz7bzOlhwspuHwDeEq8Ramrj
 BHNlA09PPe20vCzKgh3oDRWZPlUfbzV0tVUSTj486QqdmNZuTjb2jNa/DP3Ns2fc50+WO3ZTARX
 cs0FiOh0SqctJwIuGaH1qR3GLLu8/W8OaTu8pa6azg1YgIxZtqeM/QORe2pOqRP+8lWKcHLG/K9
 c8xD3IUROH+WDvxpWaUyLj48b07R/ubAyBl2ieyjHI11HP1yywYP6KbT1gR4P5V7zFk5da9ZfAJ
 UxqiUu8IP6mHeL+cIwge+CzAuA0DeeFomRGAl8nhwOyHPBCqtTH5FXWp1oL3s4k7yah8nx4iasr
 UtybO3WWMTd63ItT9B/oJr/JsFpJytHkqyFFIZxpGasGrQfZ55/YKO94vSCCCD2obk5GpQEHwMW
 wJg8Q==
X-Received: by 2002:a05:6000:250e:b0:439:ad72:9900 with SMTP id
 ffacd0b85a97d-439da885f79mr16119738f8f.29.1773009513797; 
 Sun, 08 Mar 2026 15:38:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9d8sm22744808f8f.21.2026.03.08.15.38.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/49] hw/char/serial: Remove explicit cast from void pointer
Date: Sun,  8 Mar 2026 23:34:19 +0100
Message-ID: <20260308223433.25503-36-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

A void pointer asks for being casted, so C allows for omitting the
explicit cast. Take advantage of that.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260305220911.131508-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index adbd1d1d4ab..0f2e79dfba6 100644
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


