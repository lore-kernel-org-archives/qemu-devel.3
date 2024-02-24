Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D9C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 20:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdygo-0003pf-4w; Sat, 24 Feb 2024 15:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rdygk-0003nd-4A; Sat, 24 Feb 2024 15:32:02 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rdygi-00062l-Hg; Sat, 24 Feb 2024 15:32:01 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso2389220a12.2; 
 Sat, 24 Feb 2024 12:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708806718; x=1709411518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uO/1+DSLbdpP01ytLRRf3V5DtpTT0RYEyj28N1ovinE=;
 b=iyat8votN7ng3UTTdpnpaD4Hlp+v81/s7ODOA2ialbGEipR9Zks5sTFYmcViK5cYIe
 D/IzMF36XawDsl6ralO6/3TyMkd6tiq0p4dZth6Nn83r3lmLdBh6iM47EIrDB1M7DWuz
 sZV1q5nvWC4ETEqImAz3LL2JCT/Zr7ZM6RFT6Qks5+VwYW92g+4vycK0n9WVohZwoRzM
 WbTRi66uRQd3FHIuQl4TF6xEL+U+i4/za+zuGPGhrAz2eUL+Di12lyh8Ng5UWt4eU/U5
 poxaZkPHBTFsJ6v7qrXj94ZuOUiUHekqfjB6v7XL9Mro31vpVohOoRi+Uq/w+uGphAbi
 fpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708806718; x=1709411518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uO/1+DSLbdpP01ytLRRf3V5DtpTT0RYEyj28N1ovinE=;
 b=MyNPq+1RorZtRME43UgfHQj2V9K1tsL9DmQ+Jq+6NdC76cNMzrU/JoZ9EV9BEPl8GK
 n8YTRtiRp2Hs5YzqdmP7GSlTvK6URGk61cuAocbclJducLaXiqi25yedwTNPAO1Su1EF
 sjb240hjJhyBlGzS6MnFizU5EzSCBGOoW941u/bEQVzTdnWdsdnwTxDdjVVJQiE9I5xM
 n+9eTPyQw5JW3wI8SaGFEt2xkeRJfxx9s9zpAQAjtQjRP5zeMZDiQzwb8+V6WMAfSgoT
 MECHzoyBUwYhvbYBDnXHj2JUTfycIeQqMAFLShFBhICdu4ts3yvHPfXXs5jHi4HuJ6zK
 4A5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMetDpkGqw/l+p8AoR6kjdWUGo8uvCn+8Msqu3yGaFKnxLrEoi4mBPFgX4+aX3PYb6wGEW24yitzZbeoC2CzGhB74G
X-Gm-Message-State: AOJu0YwTT1iBTCwhNNJdtGvEKJENjS8WmsWzgvsRjYxBC3DMgS9aiNLD
 U29vmlUkDwgU1EwK/WUTsCn+aBBj1t5pj7iB2DF3TimpacGmKsrpM1OGyVLz
X-Google-Smtp-Source: AGHT+IFoWglhoAup7wvly6jqrAfjps4V2mZEG1pHeetq5eu8AkpighVhKJ2XZUgxZnS8/xIpVyz+Fw==
X-Received: by 2002:a17:906:5959:b0:a40:75e8:3891 with SMTP id
 g25-20020a170906595900b00a4075e83891mr2045889ejr.7.1708806717698; 
 Sat, 24 Feb 2024 12:31:57 -0800 (PST)
Received: from localhost.localdomain ([212.70.108.232])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a170906088b00b00a3d636e412bsm863405eje.123.2024.02.24.12.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 12:31:57 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v5 0/3] Add support for I2C in BCM2835 boards
Date: Sun, 25 Feb 2024 00:40:35 +0530
Message-Id: <20240224191038.2409945-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series implements support for the Broadcom Serial Controller used
by BCM2835 based boards for I2C.

[Changes in v5]

- Improper whitespace again.

[Changes in v4]

- Added IRQ or-gate for common BSC IRQ.
- Added valid sizes to MemoryRegionOps.
- Use version tag instead of master

[Changes in v3]

- Add SPDX license identifiers.
- Fix a few minor whitespace issues.

[Changes in v2]

- Fixed and simplified writing to status register

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/481
Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Rayhan Faizel (3):
  hw/i2c: Implement Broadcom Serial Controller (BSC)
  hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
  tests/qtest: Add testcase for BCM2835 BSC

 docs/system/arm/raspi.rst            |   1 +
 hw/arm/Kconfig                       |   1 +
 hw/arm/bcm2835_peripherals.c         |  45 ++++-
 hw/i2c/Kconfig                       |   4 +
 hw/i2c/bcm2835_i2c.c                 | 282 +++++++++++++++++++++++++++
 hw/i2c/meson.build                   |   1 +
 include/hw/arm/bcm2835_peripherals.h |   4 +-
 include/hw/i2c/bcm2835_i2c.h         |  80 ++++++++
 tests/qtest/bcm2835-i2c-test.c       | 115 +++++++++++
 tests/qtest/meson.build              |   2 +-
 10 files changed, 530 insertions(+), 5 deletions(-)
 create mode 100644 hw/i2c/bcm2835_i2c.c
 create mode 100644 include/hw/i2c/bcm2835_i2c.h
 create mode 100644 tests/qtest/bcm2835-i2c-test.c

-- 
2.34.1


