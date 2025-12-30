Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07801EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vah06-0006lL-Q8; Tue, 30 Dec 2025 16:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah03-0006YQ-RV
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah02-0002tD-Bk
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:27 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1826959f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129084; x=1767733884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5rXIIuuJOx9dPiHg3QhjGbzovkvDH2p8y3rHgXwhNGI=;
 b=bKkM9JKeN4UQGCkUO1hVTkY/IdrFjYQ+uXAWZsut9TsgH2dYBO2RqwLe+SuVxgGKft
 B9tLBZvmhuVlydT8LUrjoh3dLkoKBtWcHMZS+H3p+KJ0Xz6MtlCqpy1kB/CqsayoJfHB
 l71yPL3pJGjSIaD7TfJBBoOIXHlOmkeGKbZRnAkKtMV0PEqiATP5oroz4lj6W5YzdGG3
 ZhNkBT6n1TvPurydWSGMzM7RfneopcAn3owyU/1vnRj54/+M8eBBjZcVAQfpo7h/0tvN
 UBXvOO1eamftdSLapocWnY6XqToUrM3RmVZsYGT5R5O1zzeBMnshVm32GRbaMV9wuYER
 Z78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129084; x=1767733884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5rXIIuuJOx9dPiHg3QhjGbzovkvDH2p8y3rHgXwhNGI=;
 b=QYpFIY2L4UOhe6Jnk+FbWENX28y77R/4RP3iWYWevVPbb1UITRrJEY6A2ZvA2dXyP+
 xEPABhpaRMeEA/OUl81e34AbMCN/Sue1qM1d4cW0WscUd4bmXa5w0H+V0ZJKdcopdeqD
 dm0fn9Bjzo2MRJ3Ycl2gt3zQDdhInnNzBES3E7TNOnlc2U3abAHtAdB0zymWfdgwisSA
 hcNNcBgbIqbmuyNiRBoochEc3VvLjxN4gwlzPu7vjXjEqo9rtPJBtDfYfTGO/WPnDb7M
 rSj4VL7JZ6LNJHxMwtYKgLaz/4hRB7iqt6+LnEAWiwTY2JvOPg72bTGm85nJmCaUeXJL
 QkLg==
X-Gm-Message-State: AOJu0Yy4cxQrFNV19hMAglqaQh+S5UjuldftsThT+hE36/D5cRMzzbyf
 U19NzHKLi4y9+BLTilpWSJy4WCk9pINAwUs94ihXIVQDAgogi+RwwIU5EF7aa1HAh4pSDnU2WW/
 HRAFTpco=
X-Gm-Gg: AY/fxX6fjYUWF1brUC6L9C9EIoF9SCI1pDxzWtYOkJcEtuJDvtYiJT4MR5Opd1e6Wlf
 TcFIaBUZkAGYOkpCV5rryUcddTZfUxR+fQK3glXXQEi6cdysitgrZRbt5HOfLrY9pPLHq9gbYcG
 wRyo8qaiV8FzoP9T9Jx3m2LO5uXwC/+GfjJz4fC78yRhjKiQvNyFIWU46y4MRsQETxZ4M0cRhFM
 vLsQnmHnysZ5rWi7vAec+D/GjkFStTsw5PcCNc1YUIPXMUd6hPFxcmfKwPvmIQnogRsiKeBWbEK
 0kLjqeU3R7Pf1bSUThETJkaf4q6jScrLtYJP8/0N6dUOwxT+lwByWj2miFaH7VaBMK9xRH7z4KQ
 9Cbt7ORLaDgNUZWYT2/clJHdGif533s7o9GCXlUtGN2Xat7ekiM+SZ46PSHzXhEmWXQ4behGTe5
 MaKpojGBVG7BRACy0L2p7L0CGw081pPU+Hb0uYl3b+Tnp7LWJgHFt7s2cx7VJP
X-Google-Smtp-Source: AGHT+IGWW7US14n06nI61jlc48DbuXSqiaUziOlB0rvaawxFfX1LYMSJ0jE6y9gbljxyR9r9OjGO7g==
X-Received: by 2002:adf:e588:0:b0:430:f742:fbc8 with SMTP id
 ffacd0b85a97d-4324e4bfa36mr32490091f8f.6.1767129084501; 
 Tue, 30 Dec 2025 13:11:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm71328031f8f.20.2025.12.30.13.11.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:11:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/34] hw/i2c/imx: Fix trace func name error
Date: Tue, 30 Dec 2025 22:07:53 +0100
Message-ID: <20251230210757.13803-32-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Alano Song <AlanoSong@163.com>

Signed-off-by: Alano Song <AlanoSong@163.com>
Fixes: e589c0ea9c9 ("hw/i2c/imx_i2c: Convert DPRINTF() to trace events")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251218141144.51001-1-AlanoSong@163.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/imx_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 88269653e2c..9b2d10060ca 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -151,8 +151,8 @@ static void imx_i2c_write(void *opaque, hwaddr offset,
 {
     IMXI2CState *s = IMX_I2C(opaque);
 
-    trace_imx_i2c_read(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
-                       offset, value);
+    trace_imx_i2c_write(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
+                        offset, value);
 
     value &= 0xff;
 
-- 
2.52.0


