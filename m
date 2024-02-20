Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DD4C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 13:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQOH-0007ua-KO; Tue, 20 Feb 2024 08:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcQOG-0007uA-47; Tue, 20 Feb 2024 08:42:32 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcQO4-0004Bg-AP; Tue, 20 Feb 2024 08:42:31 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3d484a58f6so720905266b.3; 
 Tue, 20 Feb 2024 05:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708436538; x=1709041338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yzJTQOoc+BFQ9VReGpVoE36YvrjBFqEn7yvCGMeFGIg=;
 b=ZlPTHLc6uaGi+wy3a3NpP1GorO9tyoCcyJ0HotArddXlU9r//PmF5gcd6+x0Dh6xSj
 A8SGsclm64TtLK0xtyxcKWuG4NNL6ofgwWQ0QN/v6G3amx9ssCRjOA3rhIff4CU9Jnoc
 x8ncpnvpeSOd5QqV5zgBMrxD6Dp/npj03I+pkUk4sAoeBtdd19N/Q85yqDh/tYNS/IzJ
 W4HDpVOBMFf65pNlN2eHGuaeg9OkqdcKo4+kh50z/7EZLK8YWi1EwmxLxC40mRPgkYHj
 9EUExZIpMYK0GFs/pgMwMOWgJA/hLOhM83J1B9YRq0lLuNdiXh4svsBm0rAbX5gz11IA
 jZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436538; x=1709041338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yzJTQOoc+BFQ9VReGpVoE36YvrjBFqEn7yvCGMeFGIg=;
 b=V4zuyqomHwUhKFCaQYlCV9IhQtJoAke99q7cwZgpXUCQaBQ4hKQD5WSST9OsmckJL+
 DLRi8BnDLaq0Y0egAh2bm5cKJ3xyDTwAATjGVdRIiPLnm1Xt8mH3yRshRg12uz0VkkHX
 yhRYnrRBxQh6UGjmyJhW3Dvnvx0RcrFuyhpFfLP0gb/hXf426UCwjEG3bSEXoMeHr74/
 gG/rZ6ZpouH4HYMUISXr6lQpV8CXWW+UrXEatAWJ5NZagzk3bmF7h/K9DEzBr73Lojz0
 wzHqpb44gJMCb7QLVbkJuK+wMli6RpEeaJPyykFVduAPa6gwKvm3xZWBAqG8GVAnUO8f
 oNtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlmpbM9eKwLpiPK+ESccqV9fFgNvBL9SH/u0259aa+0rG6/5jZU06Dnra8sSEc2ST0noufy+wlthNj6Ov6hH4TF174
X-Gm-Message-State: AOJu0YwLZc9GuJo5+v8jw3GWvEVO7/jr5cAup30YIsNbJ+0J8aB054Qd
 TQWtx0rcOZi+KDKgMZFeVRtDerd6rexm0T/R1wq20HZAa3nYTuuna7v3mMo/
X-Google-Smtp-Source: AGHT+IGl781uNGn4FsyRy9nKJiXiRQg6bgzfYpbEsRh4RP7cdoZcUfwnVOn/V5wfdwTU9YGZo9HGfw==
X-Received: by 2002:a17:906:dce:b0:a3e:63bd:3ae1 with SMTP id
 p14-20020a1709060dce00b00a3e63bd3ae1mr4597371eji.9.1708436537674; 
 Tue, 20 Feb 2024 05:42:17 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 h23-20020a170906591700b00a3ef17464b1sm728449ejq.9.2024.02.20.05.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:42:17 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v3 0/3] Add support for I2C in BCM2835 boards
Date: Tue, 20 Feb 2024 19:11:17 +0530
Message-Id: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 hw/arm/bcm2835_peripherals.c         |  32 ++-
 hw/i2c/Kconfig                       |   4 +
 hw/i2c/bcm2835_i2c.c                 | 278 +++++++++++++++++++++++++++
 hw/i2c/meson.build                   |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/i2c/bcm2835_i2c.h         |  80 ++++++++
 tests/qtest/bcm2835-i2c-test.c       | 107 +++++++++++
 tests/qtest/meson.build              |   2 +-
 10 files changed, 504 insertions(+), 5 deletions(-)
 create mode 100644 hw/i2c/bcm2835_i2c.c
 create mode 100644 include/hw/i2c/bcm2835_i2c.h
 create mode 100644 tests/qtest/bcm2835-i2c-test.c

-- 
2.34.1


