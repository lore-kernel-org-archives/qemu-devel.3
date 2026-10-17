Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B7FCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 09:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI0Wa-0004Ob-Nv; Sat, 17 Oct 2026 05:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xI0WL-0004MV-7I
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 05:16:05 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xI0WH-0001fQ-Vq
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 05:16:04 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b8b3c8c4bbso1748131e87.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792228559; x=1792833359; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PtUbuTloeT9ul5nMXsXKZ7kxIu4l9dLwOXJxJ1CdXz4=;
 b=T0YL0APn01vmW5n1YD/R+uuoiU0N+OT5rO95qLdzIWQp3p4CO9L74HtjVKW5vrYcdZ
 spDaGMCqL0jcrLrGoZm4uZnwalpyIbvKIzG+MK4hIwLRpNnAdBM7EnVq1SXI38w68wk8
 nwDyNsuNuUDmmPz41VLgSwlCfMW0qRPSj3ptLHAuI2z9TXy8CA1sE+vIHVfq3wV0Uedj
 FDscmux/Aw8Ojx3QySQdCCoy9+s5QmW6PE2Lck64tcyX9DsuOcJt9qjbHpbJtm66NneL
 ohEIQwBUA+pOn1ms9Uri3xs2rIfQ3vDroa3EfWySLAbRzNUSZKW40soj59n6g8aYGvjt
 xZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792228559; x=1792833359;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PtUbuTloeT9ul5nMXsXKZ7kxIu4l9dLwOXJxJ1CdXz4=;
 b=FBozV7zV+H23IXxAOOUYSYA7wzHk2WD7PATNxR8Sbs/UexgnXy0JnmnW9aagf6rP4v
 z3tddRteV/Ef/CiPn1c2EbJNCCOw2xLf1ExtdhtrJN1JtURsq7i0059B/VSJw4ZhxCtc
 +unVZBca50OD/d4GFhfJdxlgSTUHR+eZo94mVY6ShgtOr6NQgLZ756Ixgt+wvHmejPg+
 fatQfcpXVC7RyQtYn6mpMo5W9hPgcO+TKhAetkIjzQ+xV/AISRVxvv0FrpwtZtPHvOI2
 HQynoVZcMCBI7k67EuSfA1uDulOzUh/wibldsKPagNBYbr67mRknzVlyKTDhyscTlZJZ
 HKDw==
X-Gm-Message-State: AFq9FYJqgqgH3HAWOJYdCuIkEMrqOg4vJ5qLJ3xDmHrJ9xgi/fq5kNLa
 pgxW0pNNE0Z3ZfoYOMUEc037hudcsK+OxhhO+VB3inHoP1g2vqcD1L6A
X-Gm-Gg: AYBFou3n5dmYBZjczDySkbdV78DgvoM4FlXw2Q727wY/OEVyQHDYDTUnhbTHK6HfCiv
 q291It8Zn1lL6xxaLTObAiAXSlyw/Gm9PgyNFPFLGm3ARkauVynbLI5Hb69KwR3uWr0LcqbZOJn
 TcvG1QGzNgpkvSOIHkfhalkEE12c47+//UAMWtlNx9RQBlsOpVHtWN8j2EOy8bmLK3YTtYM4FjQ
 Z9BOTeid3ZGjr1YVmGH2dXrKKjWWHdqajYY0OYVtPY7IyTLrvIJG+JbsG/zWgdEGSfJeo4bjRuJ
 RtuaxlfantR1sW9Bxkv6WjlP4rcc3EGzw9fStxYWq9mJP1oMSRAvWOgqzW4KBJcA4Y86ix7z6Qx
 w8/O1jf1xoqXVgTPUnE77PzeMIxCxYDc+rUZGtZRGdx/eqogxebdbPmnzycFbQaKhqZBG7Xwjv8
 l+l5ZVCV7krQ+4mumdMoAm5iTjR8mgImbO8W/0uhZ1qQ3PJOnFTcxRzUZ9YGDrevLtH19QOTZxr
 JNLKrmX0WugK9P8GUvXVGzhazKsyvPJsgek7X0dg1DOHfRPvclItHJFdp8=
X-Received: by 2002:a05:6512:3d17:b0:5be:41da:5c68 with SMTP id
 2adb3069b0e04-5be4793ec7amr1822990e87.39.1792228558613; 
 Sat, 17 Oct 2026 02:15:58 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be4a633f54sm853132e87.60.2026.10.17.02.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 02:15:57 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH v2 0/2] fix: Allwinner GPIO interrupt handling
Date: Sat, 17 Oct 2026 11:15:31 +0200
Message-Id: <20261017-allwinner-gpio-eint-v2-0-82906f440378@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Zi2sQquuIdhUctQJoGWtKRqC
 He3cgCX7yX//Q0SRaYE92qDSJkTB19AnSqwo/GOkPvCoIS6SiEaNNP0Yu8pols4ILFfUdayHtT
 F0K3XUJZLpIHfR/XRFR45rSF+jpMsf/Z/L0sUaLXuVaNrQ+LZutnwdLZhhm7f9y8FgQwxtgAAA
 A==
X-Change-ID: 20261009-allwinner-gpio-eint-1818f24ae7d5
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x132.google.com
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
Changes in v2:
- Moved changes to the interrupt handling tests to the first commit, so
  tests still pass once the commit is applied.
- Kept new GPIO input test as a separate commit.
- Link to v1: https://lore.kernel.org/qemu-devel/20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com

---
Strahinja Jankovic (2):
      hw/gpio: Add EINT CFG to Allwinner GPIO, fix interrupt handling
      tests/qtest: Add Allwinner GPIO input test

 hw/gpio/allwinner-gpio.c              | 19 +++++++++---
 include/hw/gpio/allwinner-gpio-regs.h |  5 +--
 tests/qtest/allwinner-gpio-test.c     | 57 ++++++++++++++++++++++++++---------
 3 files changed, 57 insertions(+), 24 deletions(-)
---
base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
change-id: 20261009-allwinner-gpio-eint-1818f24ae7d5

Best regards,
-- 
Strahinja Jankovic <strahinja.p.jankovic@gmail.com>


