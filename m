Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50318CA9EBF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFDQY-0004qY-ES; Fri, 09 Oct 2026 12:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xFDQV-0004nE-9i
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:26:31 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xFDQS-0004qf-EB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:26:30 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5ba3ec92031so4732068e87.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791563186; x=1792167986; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tjz8cOh/KA77+XCkvn90j5ij+cLgurktLX0KpnSTkvk=;
 b=p1tG1e+fiCpiGhu8FkBEk526flxB0WkCiUxP263sznS6plluCR9R+m+eFkGFOnm1bk
 s0LbLTwh0w1o1iH57eWYcoKKaRasn0VJ9y01HTla6OgtTp/I3CxHO+ZiJ/LXwYZI48d/
 slrMcg9fOlEtP+Bo8n3SO0acxH7Sy6/F/ZsX0IucmotB1TbV3kLYQiybTlqeL2a8ywUn
 q6BlMfVy/AGybOnRJKPOyY2tno8ghATpJeGF8TAkPxxnDXc5xecZl9Sxg6jqBmafeClr
 PiHjClYSTtmNtxh0NYw2evQBTEmNSU+VxkRgv+QGr3dVGAArxQOHSiMQaTHAeEy0nt9T
 TW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791563186; x=1792167986;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tjz8cOh/KA77+XCkvn90j5ij+cLgurktLX0KpnSTkvk=;
 b=bQeX7zpwaQk9oJOxHUtyJu/EDdH9Te0XjMpqRY7Pi2Fmg1VofIAfN2wqH8vStW7cRF
 k2ffUqwAe8FZz0JuliU5CUpEXNBkvAPoMar7OmLrDX5lz5YKJnFPZtXwl+UhDPbyEL9B
 Ys3juu+y3MI6Kbmic37FZC/Dy9jQ27yjqF9c5LEdRJ1GPwi9Q8u6o702MJLrSTCUDXC1
 W27yVPWy5detehJN0CRjLRzYj5XvlkCbttzcVd9ZQ05LShJwaqqCq/fGZ3y3XJdTojTk
 vNmHYk78PpzrUAqk4dkm4/RzsVDeU4XLaNd4kPSj3P2EMtnw5XFX9czemPT4+24ywyhE
 keOQ==
X-Gm-Message-State: AFq9FYKAZ+wbIpc0OvudM/wYikIzim6rCDLpvsIyZfO4d2V0iL7Z5eR3
 Nn00xWdGI/1kFZyVLcsXF789RaV3KIAVY2zbjjN9HiUuQylsdwRrV87H
X-Gm-Gg: AYBFou2oj/6OG8NcSlZhVpEqLLW1eUhJ+heY59G0YP3wHuCWmecv5uDGsp6sjZM+Uvf
 AuyzNZ9eaaLEXEbqvbSsz4J4py8tx5js+G+fT7kFsBtRkrDu4ANU+w5pg4Zp9mxNWFiMsUn59c+
 wXUKvyRoyFK8LlKzMacidXeRDu6iplzW9R2S7gCam/eTZgJvcqoj1TWUYNBInUXq6+dsIY009dr
 J47rCBgI9AKTP1IQSYkcFjpoOjqLYKJMRcm7J2k2gwmRs/Dd9KgtXMJ98tYFHPh1rOd6cnnIhjk
 0tgRXfIiy0z67ay2ga4RWk7oLWZNf/AeNuDogEVnUfjhbTk1yt51GxsYQBPSsjGxXL/lXtej9jm
 JjGDsq2bg4ZuFK2/8bj5Ei6sTGbyRD2OYIRyvPGQqEib7o3x1O07cUu89gfUGxTOkkU+CPd0obg
 y6nPRzv9WxcgpY4747sSRNbwazKYdgIBf51iNQgQdDBUTN0MNS+1Te2OS3n+Gqsku6UlulxkIhd
 ScfB9dKs3fXgCCpXRosuDzTpG4XcusZnzx+T4UwF/3LFwLX75QiuhK4E9k=
X-Received: by 2002:a05:6512:a83:b0:5ba:430f:bf61 with SMTP id
 2adb3069b0e04-5bcde6bcb11mr1045998e87.61.1791563186050; 
 Fri, 09 Oct 2026 09:26:26 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bce5bce999sm240217e87.79.2026.10.09.09.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:26:24 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH 0/2] fix: Allwinner GPIO interrupt handling
Date: Fri, 09 Oct 2026 18:26:08 +0200
Message-Id: <20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtQ6f8q0UJysoGYQqOC8O5Jy
 2/x3guRAlOEoXgh0MWRd8nQZQHzasUTsssGo0yjlerRbtvNIhTQH7wjsZyoO90tprLUuhpyeQR
 a+Pmv45TSB5Oz3nxlAAAA
X-Change-ID: 20261009-allwinner-gpio-eint-1818f24ae7d5
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The original patches assumed that pin had to be configured as input in
order to be able to receive interrupt. However, after additional testing
with libgpiod and gpiomon, the pin is actually supposed to be configured
as EINT (0x06). In the following example with PH1

root@cubieboard-ng:~# gpioget -c 0 224
allwinner_gpio_read [PH:CFG0] -> 0x1061061
allwinner_gpio_write [PH:CFG0] <- 0x1061060
allwinner_gpio_read [PH:DAT] -> 0x49
"224"=active
root@cubieboard-ng:~# gpiomon -c 0 224
allwinner_gpio_read [PH:CFG0] -> 0x1061060
allwinner_gpio_write [PH:CFG0] <- 0x1061066
...

The CFG0 value on the lowest nibble changes from 0 to 6.

This patch set fixes that behavior to expect that pin is configured as
EINT in order to allow interrupt-related functionality.

Tests are also updated to reflect this change, and a new test for pins
configured as input is added.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
Strahinja Jankovic (2):
      hw/gpio: Add EINT CFG to Allwinner GPIO, fix interrupt handling
      tests/qtest: Update Allwinner GPIO test

 hw/gpio/allwinner-gpio.c              | 19 +++++++++---
 include/hw/gpio/allwinner-gpio-regs.h |  5 +--
 tests/qtest/allwinner-gpio-test.c     | 57 ++++++++++++++++++++++++++---------
 3 files changed, 57 insertions(+), 24 deletions(-)
---
base-commit: 602e4f2da10ef642581cfcd5caf5d1534808caa2
change-id: 20261009-allwinner-gpio-eint-1818f24ae7d5

Best regards,
-- 
Strahinja Jankovic <strahinja.p.jankovic@gmail.com>


