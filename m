Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151D8C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 01:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdEu-0003Ek-5r; Sun, 07 Jul 2024 21:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sQdEp-0003Ax-UM; Sun, 07 Jul 2024 21:32:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sQdEo-0001aM-6C; Sun, 07 Jul 2024 21:32:19 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-706a1711ee5so1828547b3a.0; 
 Sun, 07 Jul 2024 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720402334; x=1721007134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w22szoAG675Q8ABHy9DYD9nwmRV07dPGYZPauXiWGdM=;
 b=c9ozO+R2jFQTKZoSsarbRyiIq/q/nULRmqLsFTMv9NO6U5JnJhS8zP1V4ZGTiGvYD5
 086z4fi810vnhzOhrsk2eU4ysimmuqDM9wK1x8ae5Aj7OJnQgjYy8USGUCp38hQH1c7Y
 fxbr6vCKYUB5tUAwwd1jhdMuzxT0LLC3jqqS++XLv+Sy3G0igGmem5WYSnkrgUdZvpzO
 ysCUczXxMgLLEioVg2b482ARJv0v9vLBh14hR9rgdUlio8whnhP+8sigAasYnfK5/3hT
 6VpaGJivXfFI9dQAEKr6+sQVDciso6J2d5FUGohzeCaW6t1YyeR49vIQQYGYO4Jwkde0
 XU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720402334; x=1721007134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w22szoAG675Q8ABHy9DYD9nwmRV07dPGYZPauXiWGdM=;
 b=O47GhtcCppko/xqzoxwqtklm1iR1PCgH4zn5FHBmxcZo/av/aC7xxlINcib7pZybi3
 8WLMPPb8I/rUAuHebo/1zQMpMLJRQzf4T5rjEueCvsWJuo/OIslKTU3X1U0UGll9UrPt
 9I2+5UytyPy+FMt469EjKL27RxA8TfftB3RgxnkbqA47VvDi4VS0HxJxDskFV9J4J88v
 BkfGFM/v7JIlkQYhHNoPIhoYZJGKg88J5DyumO1/sqBYYsM0AGU/E7kbcAXUkDAqDR9c
 MAHnOcj/eejMS2UYDy91OVomwSlXWMBO4E3vNjCj7ti4dvhIqyluruR7mgBWgmu8EEfn
 cSAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeRkF00zuP3Xjtf/qxV+jHkE1NLni6xrhAqKLamfBb/XgZFvSlQWPOZ/ULgKUOxeg9q5bLdxVky8sr3Uz1xlUvNwdQH+c=
X-Gm-Message-State: AOJu0YwnABQ9zQj+ZPklihzuOZ4mBCc3GO2bOLI0CYclwFExy7ODCxK6
 H40YToedzIDBwijvEwYX1LlvAvKuxlqsdqpF6JtsObN032e3Y5v64fVysgi6
X-Google-Smtp-Source: AGHT+IGVI6snG5TZHTxnpXCYzgshFRnCpaYnS/enir40MjnMdjm3clSV+uWyvjWeRGz1ts0sRKWsIA==
X-Received: by 2002:a05:6a21:7896:b0:1c0:ebca:ead0 with SMTP id
 adf61e73a8af0-1c0ebcaf176mr2295342637.47.1720402334493; 
 Sun, 07 Jul 2024 18:32:14 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a98ac94sm6963729a91.33.2024.07.07.18.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 18:32:14 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 0/1] ufs queue
Date: Mon,  8 Jul 2024 10:31:44 +0900
Message-Id: <cover.1720402238.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit b9ee1387e0cf0fba5a73a610d31cb9cead457dc0:

  Merge tag 'sdmmc-20240706' of https://github.com/philmd/qemu into staging (2024-07-07 10:34:52 -0700)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240708

for you to fetch changes up to 6db492596dd9204e8fe341b2396472271cf15023:

  hw/ufs: Fix mcq register range determination logic (2024-07-08 10:25:20 +0900)

----------------------------------------------------------------
hw/ufs:
- Fix invalid address access in ufs_is_mcq_reg()

----------------------------------------------------------------
Jeuk Kim (1):
      hw/ufs: Fix mcq register range determination logic

 hw/ufs/ufs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

