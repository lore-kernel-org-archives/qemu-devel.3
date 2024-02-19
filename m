Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37555C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 19:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc9km-000486-UC; Mon, 19 Feb 2024 14:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rc9kj-00047l-Vu; Mon, 19 Feb 2024 14:56:38 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rc9ki-0000P9-C3; Mon, 19 Feb 2024 14:56:37 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d23d301452so15229241fa.1; 
 Mon, 19 Feb 2024 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708372593; x=1708977393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0dgFWS53poceWO508lR/QJ6s4O6s/rE/7MSfXXg/f5w=;
 b=jpSMsWtLY5PopVBXgXKCWqlTi1Nxo1eKEyBs4GEp7BuraUyOPvviWehUr2yrbO5j1q
 BCJp0QimAagYkulh1vnjp2JopjTEiyeztPD0eOMtPD4iTQvhmI0QQxA0BTyL1k5taFGv
 vEx/ZqBCN3M286dl1EV6V62sErk6SrA5pCcR0g+/QihUfQoL3XW2CjPN/bK4IUy7bXer
 8xv6udWvQeyyD07FkTZlUH1JpzqDgkRSxjmU2wzYU0VS9OCK3sD5ovLG2RaNmkNlGO7y
 I+jGezy1nqqWjTn2Ugo5Nm60I8UMqqjH/bTh//Fdx6QqwoByCarfQzFGVqCsIuQsT6pL
 2K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708372593; x=1708977393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dgFWS53poceWO508lR/QJ6s4O6s/rE/7MSfXXg/f5w=;
 b=bPaKE02auYHKkfTUpnXmGHP09rxwBTZFa8AhbKCrpajMdCe0zdAIh5bFskdw+HotVh
 o+3rN0GKGWkdxxKtWNDhwaMSwcGQI2SyejDAxtpIrXz4vB4GXg+5ccdRbn9RaTTcPU30
 eEHuV++S9rlFMHzA2nH4k7KtME1JbAs/QzRQU093nETwUcl7K+DWOInW3eeOWRkzbiIo
 qNTIgnBmKfBJeSYxpkj9nLvNNWrDEfT6cUifPnBznOt2N6CW0nI8eHR/htjnsDKU10dO
 AiPPY+ohOVjStNh/yxvRZB/kepvCpxcshAx7eBU59FFLTGd9pOyCQDgoQbloByEtmosa
 FwQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcm1zVKpGu6OwM214kD8Pua1/LGtUhZCDt9Rt4A2yt1z5p6XQgd64X01xV094yDPv1+Yr5w3/qXjLV3DxLSGV4GV0V
X-Gm-Message-State: AOJu0YwtZOkBBqCHQafk7wKr+YQDlZHbLEunkgncApOPwCY/YMZBskQm
 cMX0UUOdSFK3yzedQk1u2iATRGpbkqLAUR5ThbuGpuEVpwMCOMPa/RC2hNXLwcc=
X-Google-Smtp-Source: AGHT+IF98YAtfyvEaXlFDg2nFmqrS0DFYACOfy69OkPLLz0W779caFQArrC0Lkb7IRDSvGKl1w390Q==
X-Received: by 2002:a05:6512:3a7:b0:512:b37f:a9ae with SMTP id
 v7-20020a05651203a700b00512b37fa9aemr1961315lfp.63.1708372592577; 
 Mon, 19 Feb 2024 11:56:32 -0800 (PST)
Received: from localhost.localdomain ([37.186.51.232])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a170906a09300b00a3daa068f76sm3255911ejy.65.2024.02.19.11.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 11:56:32 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, pbonzini@redhat.com,
 qemu-arm@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 0/3] Add support for I2C in BCM2835 boards
Date: Mon, 19 Feb 2024 22:51:30 +0300
Message-Id: <20240219195133.2304668-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-lj1-x233.google.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/481
Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Rayhan Faizel (3):
  hw/i2c: Implement Broadcom Serial Controller (BSC)
  hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
  tests/qtest: Add testcase for BCM2835 BSC

 docs/system/arm/raspi.rst            |   1 +
 hw/arm/Kconfig                       |   1 +
 hw/arm/bcm2835_peripherals.c         |  32 +++-
 hw/i2c/Kconfig                       |   4 +
 hw/i2c/bcm2835_i2c.c                 | 277 +++++++++++++++++++++++++++
 hw/i2c/meson.build                   |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/i2c/bcm2835_i2c.h         |  80 ++++++++
 tests/qtest/bcm2835-i2c-test.c       | 105 ++++++++++
 tests/qtest/meson.build              |   2 +-
 10 files changed, 501 insertions(+), 5 deletions(-)
 create mode 100644 hw/i2c/bcm2835_i2c.c
 create mode 100644 include/hw/i2c/bcm2835_i2c.h
 create mode 100644 tests/qtest/bcm2835-i2c-test.c

-- 
2.34.1


