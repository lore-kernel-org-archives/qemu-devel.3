Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A30CE7AFB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWfc-0002vP-4p; Fri, 06 Sep 2024 06:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfR-0002ny-Nk; Fri, 06 Sep 2024 06:58:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfP-000632-BX; Fri, 06 Sep 2024 06:58:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20551eeba95so18781445ad.2; 
 Fri, 06 Sep 2024 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725620282; x=1726225082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iv3NPBfrsDrOuzW2KxeWVOC8agmIsHnTyZ00QhL/KpE=;
 b=NF21oeA+ngD4dIUQyP8Tayj/e4No2/+29owc1TO9AJEe7gxLVc+7wvFOs76XsBPfD1
 5juDJHutz8JepRlCKvbJ0RNiUUXK+ucf0I4ntbWahiPWBEslnfm6r9eOu+zvb73DT4SP
 ZcuF24b5vYEX/hOZxPKDrVM8PRaPlRX+ROW8HjVDFOC5bqixZSYSD8V70UE7C/oaccdN
 9FPqUfj6VaH+rUbXC779Sm4fOJbWjecY6geemTVOaWFpLst12oe6pvMNGzO7FGszvoxx
 Me2+EHogtBdQmOqH7Nu3n0GyJN7fpifqh59+4C1hKoTjwlw+J2g9zRctc/zjVArtBjPw
 Qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725620282; x=1726225082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iv3NPBfrsDrOuzW2KxeWVOC8agmIsHnTyZ00QhL/KpE=;
 b=jUziWw1qos2E91W4MkCArwVqFGd41pC4gykCzcfCkQeeeHdWPs+Q7gTSYNIuwtyfQh
 mm+1ny9EUF0H7NepHEHaqnIBwKTw7XVj9IixaWPJ8vvzKQu0oIaJW1mAXISpsMbklna1
 1/aA9luk9oOyx934mDI2XhlyRO3UU/9sF2nXR+FSSwTJjOzVHUs9lM5cAvXDmAYyTB5i
 6yk+C9F3mjuCM7/KO9efUrCYCKkaMygfYtE8QCxroQdLIdcq3EDdHcLt7rRfNG79nppz
 cxlGt6+6mpqQaJdxEzL76eXo7WMMfG/Tu5JBJahLTaDpim47UdUPV7+yX9p94yX/VkCB
 trOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8+hq0Zbjuu/xPhJDCwfifwShRcPY9EIMhjPatYd1DAsH7pIgMC8ZFwLHiCR+IO6tFi2PBEScR0pwm@nongnu.org
X-Gm-Message-State: AOJu0YwPmPBZ6Tp9Cqmqtx4XziuheVnmW8gAMl4jnS2GCX+ytbXHhYAC
 U/I7dts33M3N0Li6JkFuMAD6zRL2Xi5F9tCYLfveSq72hshTZ39KbHunew==
X-Google-Smtp-Source: AGHT+IEXD84s6322HOR9c5J69r1zLPVQ3uDHb/mFKyfjymGxCzgVvhcjsX/1tRXPaW7uuYltsE1Y7g==
X-Received: by 2002:a17:903:98f:b0:206:a87c:2864 with SMTP id
 d9443c01a7336-206f05f6704mr22382175ad.42.1725620282502; 
 Fri, 06 Sep 2024 03:58:02 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea67bc6sm41134575ad.258.2024.09.06.03.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 03:58:02 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, jeongyuchan0629@gmail.com
Subject: [PULL 0/5] ufs queue
Date: Fri,  6 Sep 2024 19:57:37 +0900
Message-Id: <cover.1725619134.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 7b87a25f49a301d3377f3e71e0b4a62540c6f6e4:

  Merge tag 'edgar/xen-queue-2024-09-04.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-09-05 13:02:26 +0100)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240906

for you to fetch changes up to 9fe8e2c68ad99e503a11390b868a7dad846e7a0d:

  hw/ufs: ufs descriptor read test implemented (2024-09-06 18:04:16 +0900)

----------------------------------------------------------------
ufs queue

- Add basic info of query response upiu
- Add more qtests for the ufs query request

----------------------------------------------------------------
Kyoungrul Kim (1):
      hw/ufs: add basic info of query response upiu

Yoochan Jeong (4):
      hw/ufs: minor bug fixes related to ufs-test
      hw/ufs: ufs flag read/write test implemented
      hw/ufs: ufs attribute read/write test implemented
      hw/ufs: ufs descriptor read test implemented

 hw/ufs/ufs.c           |  32 +++--
 hw/ufs/ufs.h           |   1 +
 include/block/ufs.h    |   6 +
 tests/qtest/ufs-test.c | 384 ++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 410 insertions(+), 13 deletions(-)

