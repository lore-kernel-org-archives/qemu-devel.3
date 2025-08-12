Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3100C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 16:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsJ4-0002aJ-6y; Tue, 12 Aug 2025 12:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsJ0-0002Zd-Ox
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:56:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsIu-0007Qh-Mh
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:56:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b79bdc9a7dso3468129f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755017809; x=1755622609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lECCUE2oRDfQXHGBqUuzwa3oXtwyQhPqjLp4xvXlk4=;
 b=oqRXCHFk93t2xLOm7w4pZv3Fp6OpilzEVy9eN1UCgO1FySqFVvJp/i3BRWHPomRequ
 uLhzrrii0b0RFQXWV8+HkwBhL9F2u51ruUWe4Iq5G57OvDLF4XTgeiEM2btbdb7hbuSe
 fTBaE8BrfIlgb/G/mL1SFA7BMjPI6iamC+zXrvKMjYpY8OUw6RBIthJP/4Ix4zQEdGGo
 4E1GrgJHlz4OTmehazEq4BboRlGkT+yopiM5NZivHb/+3xQbWUS+pPSH4Lq7kNI2iPhB
 A5sTNbijpZG+jbkEqnmJgwn5V3SgHW309Ykqc7cOd6v0WYEkKx/cOwRVdKOYcN4HSzez
 FgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755017809; x=1755622609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lECCUE2oRDfQXHGBqUuzwa3oXtwyQhPqjLp4xvXlk4=;
 b=W9m9SvQYypkOfJ5bYovqyYw8SjLHGb13j0qZGTaucHfEZZVYd7YVEvlVMIubN7zXC9
 RUfbjS+4g4JpSQ7y2NINIwLiDrSdoSTjAk5go2lSOPxVy9kE+Y04bTaPfkpAjHH8a4LE
 TrGwz5BnraobdK7Hw/gE2eQlMzdLxDxCTTvEZm+5X806EjLENQQnPy/Yaj/DWR+Eod+s
 WszGxA0sa+tx8qRR38EA3IiZLvdkwQlRroSJ1eOPrczcmaQg1WJEoaZwAGCBN3rROuDL
 sdtrsuHhuyg6waPoJZsIc9LlAFxegoCrBzv4kBCozForSMp7C4IKG/d/k7XV4Hg+X3JV
 bfDA==
X-Gm-Message-State: AOJu0Ywhk86nj44tMV+YsDoCZ/3ONVriGf4CX843enN0EMo1nB3dfW02
 jmfem3vS1Xvdw3KAdiJrvR8h/YmgrBkSLs6YAxPE0hxG4lTT43xKLbKvoRNT+nZPYgQZUk9yh4J
 Fuss9
X-Gm-Gg: ASbGncu3dnmcW5NC6CaxzOc9ZYTfCqdl8/rg7jZyzsMAv386dDUcyTS+BQ2vGu62HJn
 /QeF4otIJ9BtSLx7AjfEwYuhgeKkS6KJ4rONXNAAZYI47z+RYi5maIwsjZVKPoKZembTTvBcVnu
 gOSAKr963YCmfj0NwGcqt9KHNj8MWgeqE7UH+aFjp0wQ0YM4W2jpmCrtSMoJ2SY0SBElylCbiYI
 RA62t7CJ2f5YQrvgU10BvJdc2Lz1/45OFvWzj6a/Gp7mgzJw8ML8sviF78BYS7cldZ3MQQ79Q/m
 9VDwe+HrkZc2gWvhMnV09+Lr1ZCkMuy3fgIBJC5e59DgXpmb6Sd+0xjhYK2bIASt9c2r/M2isJs
 uKT7ag/H6PGqEOyPERkhVDlYopsMDCRH2983ifQ+Y1MKfxrE3HabuNeHVrdrjtn4Ad1sUULvDB0
 L26IY01BY=
X-Google-Smtp-Source: AGHT+IHbbNu3ucBfdPTb0YJtqc0WwtM0B06VgQsWvg04C0nbR8a+rZfsYbUtURY58yNdzk2J+e1L3g==
X-Received: by 2002:a05:6000:4027:b0:3b7:8c98:2f4c with SMTP id
 ffacd0b85a97d-3b9172ea86cmr109206f8f.33.1755017809211; 
 Tue, 12 Aug 2025 09:56:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b916394937sm803325f8f.6.2025.08.12.09.56.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 09:56:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: [PULL 1/2] hw/sd/ssi-sd: Return noise (dummy byte) when no card
 connected
Date: Tue, 12 Aug 2025 18:56:41 +0200
Message-ID: <20250812165642.81157-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812165642.81157-1-philmd@linaro.org>
References: <20250812165642.81157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
code") exposed a bug in the SPI adapter: if no SD card is plugged,
we are returning "there is a card with an error". This is wrong,
we shouldn't return any particular packet response, but the noise
shifted on the MISO line. Return the dummy byte, otherwise we get:

  qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250812140415.70153-2-philmd@linaro.org>
---
 hw/sd/ssi-sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 594dead19ee..3aacbd03871 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
     SDRequest request;
     uint8_t longresp[5];
 
+    if (!sdbus_get_inserted(&s->sdbus)) {
+        return SSI_DUMMY;
+    }
+
     /*
      * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
      *
-- 
2.49.0


