Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8670BCD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZh-0000ui-IU; Tue, 12 May 2026 02:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZ7-0007ca-4O
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZ4-0007O5-3Z
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so15275535e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567155; x=1779171955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p9Ko2u3O1LfqUME1hczQ+CYZalMxuJgnkK238faISOk=;
 b=ICzDOjvNfCmUQDJK9udo3bi8L/hLwPDoq86DyXpWaAyF71idRGd9jobUfZjSClAe6k
 wGWHDk/9GRsNcLxvaYNd0DlvNLbJ36dVwh+oe5rAXQuDyVSfMqRnJP20X2f98GSYxacw
 sXVoSLXoZVmVTY6nKDej4BgBEVMmi7ACQ+GG4FqU2+rGTinzVWLXRwRCqDH0mNs0ezAs
 N7+f2k/0G+b9GzSdhC0qnnSMkuWzhHEOiiGtbKoZ4lZoIzOPFfF4ziT3Yk74Tw6q15qt
 pFfKBaX8PzF55G3/esvOdZ9DEiBawkU5wATAc84+bupS2PjBbb9IAMvWzjQOzjLOnZxM
 +HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567155; x=1779171955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p9Ko2u3O1LfqUME1hczQ+CYZalMxuJgnkK238faISOk=;
 b=jvDaCDlBCih/UUuc4wQYOtkVidC0uhj5F4RNQTqt99EqXtOantjP1hBX+tuV8EOixR
 Mt67WcCMk+59EwWrbUTj40UR47TwkJ7k6EOlBbjUq1l7m9t26uWP61xQ79lqf/6TOIbg
 G2XzJUtZDvqsWuy5k/TFJ03hzpBc0Pa3LsnDx+P1HFXD3ltHENR4Tg5rpej6qvu8ZaSZ
 MbDL5JQ4byli2mzMrlGiBHReyk1ywgxtEmnFUOxTvFqoysRtp74XTKt1sSv7L80HauVB
 +3U5uSokZ9SH7knLl+R+NCWRUQ+Ts5oxkuIWtQqJBCteG6UV+iU9llHzLjbKSCE4Mqdy
 TYqA==
X-Gm-Message-State: AOJu0Yz6AmhLG6ow4xqdTcrtWus/HmGsfUI8QCRZPMFsjOA+cOftVzp1
 LQqfr3xTMUNqus5GijN6xCHKdZ0DT3HGheFwqH0iRX5R8oDDZrhwAqowfvcKQPkMSChjfzlzui4
 FjPeqwYM=
X-Gm-Gg: Acq92OFVqQXs5QvN3VVqCoQcvAVY6y6vunvPKv2TZl0dyvRBki+FL0VNRzH2XOgj7VH
 tyqJTrpI1C178FbkjsMbXCjI4zRbj70oZKKBm+J4NOvPMBdeS3UcKBMaVa5tT2zasgPseCEFish
 33dUWo6OLPVIGVO6j/tUhh9ZIMzjg5gOLUhGyoqJIVEThdAXZ+bCVkeRnBC5qBwHoqby3eC6WTk
 uKDpyjDYv1NSrUiXOdX6nIikmcKAglr7UXz07EHb4roF651zh4P4XM3DGaGVZGBQIzgOdaWg2ly
 oEdHzSrrr0BSU6ibJlRJ8Cbuoj9hrU3XMoVO2YADBo9ilyL4gaLq+mOLGNLOidJa3BZryOI2T6/
 FVWBqSGs5tXs4yCMSl1L2k3Y99p7KS72ZkONSTjmRPI5M6s5+iHeoBLL7qV9WykgPBSN0ydesKz
 CkY2uOUScCR3XJiVc+NWj/1xJgVdlR1oZdWkjXKorLEsqwxGHxHwIrajHHnkURzkgSOqZsLkcBG
 kQIqAkagv0=
X-Received: by 2002:a05:600c:1f85:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-48e8fe71bfemr21533615e9.16.1778567154949; 
 Mon, 11 May 2026 23:25:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f435a76sm11437075e9.21.2026.05.11.23.25.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] hw/i2c/microbit_i2c: Don't index off end of
 twi_read_sequence[]
Date: Tue, 12 May 2026 08:21:36 +0200
Message-ID: <20260512062142.67998-36-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

If the guest tries to read more bytes from our fake stub I2C device
than we have provided, we incorrectly read one byte beyond the end of
this array. Avoid this, and instead keep reporting the RXD register
as containing the last byte of the "data transfer".

Cc: qemu-stable@nongnu.org
Fixes: 9d68bf564ec ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3408
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260501162634.4092394-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/microbit_i2c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 2291d6370e2..d9689b6f1ae 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -41,8 +41,13 @@ static uint64_t microbit_i2c_read(void *opaque, hwaddr addr, unsigned int size)
         data = 0x01;
         break;
     case NRF51_TWI_REG_RXD:
+        /*
+         * Return the next byte from our fake data sequence. If
+         * the guest keeps reading the register after that, keep
+         * returning the same last byte value.
+         */
         data = twi_read_sequence[s->read_idx];
-        if (s->read_idx < G_N_ELEMENTS(twi_read_sequence)) {
+        if (s->read_idx + 1 < G_N_ELEMENTS(twi_read_sequence)) {
             s->read_idx++;
         }
         break;
-- 
2.53.0


