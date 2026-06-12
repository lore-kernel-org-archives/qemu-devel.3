Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AB5CD98D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpmv-0003FG-5d; Thu, 11 Jun 2026 20:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXpmu-0003Et-0j
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 20:30:20 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXpms-0007Lg-Dx
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 20:30:19 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso492406a91.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781224217; x=1781829017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fYrC45hA6fYQ24jxVW3958vXmUWxFbqrVsn8tQmoB88=;
 b=j35fZM0lH+N0kIu28w6ozVZ2beRu1G5GyQ0ocjKTJhH+pRac3kNvjd0Hzz+EPx82CK
 XDcX9+QQ0Z5XsfoD4i6pa7S/EclDghNyxSU1yeHB7h3tQI2AAdYOWbJNzkL+sUQfL8Xd
 fUh4HcytdjuEOtgLHxI12vr7zZaoH72kvb/ppHz2SiZZQmsu4Ie1OSyrmYq8qUjTlpo3
 d9GbwrRERdUkyZ6J8OSflsbmoh3/WX7D96LX+dJS9k3oYYr+FIgaA3T0/Jq2zpzJgYEd
 UzL1ClERBVTS2gvXRe4Qu1jKTOaWzmSdTT0ScCw74J1lMzMEW33uNrzzJ2YnGiC5w0zC
 hSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781224217; x=1781829017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYrC45hA6fYQ24jxVW3958vXmUWxFbqrVsn8tQmoB88=;
 b=s2fX3F5HkL+5wPuD83F5Cmutj8RxBnYQlkfPkn09L24GWY6K60480VffB4Tw2DRMT8
 L1sgPRRfoTTozYUWHb+CZBSckYK6YX1wMyvvJNttN98DiqjRf5zRH0wwd51WAwKxci6G
 qHF/pGM87qPZZT2Y7WPOTi+Dqewre6R95SbX9ed/xoJwXZpU1ucj/R+gwRQ5vbgdwBEQ
 ZlqS8OvBBb7x4AWupHWNoFOdObO/CfpQBesSuiBuPTnuuStJtbzdBoNIsWYbXG8Ryd3t
 Ct1thaOGvAvdjowOPMb4Tw5tOiLCyu+Q/esyoKXdtpVGS8Ruisc+fPIbp9vEFsNqQAac
 kxRg==
X-Gm-Message-State: AOJu0YzG0ywXo7l9BQZ93nbaA5JutO3xZgrfa0rBvV5I2WIXS0mir8C4
 HteJOQUH2haG0qfOOmxfG5zWAGnXpWo+sPL3y1hccwg1uxDmuYqxu466ndVJEw==
X-Gm-Gg: Acq92OHzwz+x+cqiB5sLEm+EOJccDN/is/2hQnN8GMXpYiPHzIHAC9h3ZF7n5AOO2Sr
 k6foeii+Zzi5f3oxo43OCvANrGDN6uSLC4j+8dxPA06cfqusNXmbxKvgndA/lOjhj7bxXGRwjz0
 XyflpRlNPpW8IDcwhAoEslPanZ8M/QYmP6KEK+NqV1kcXw5w0c6PzurEW0HMkFqEDR0f9XjeOUq
 sq/q4/1y8zPgVJN60ZW/Wdc0P3bkNNc3SCiIJSya8Gv+wGdnDgZkT59O/75xzcpGx6koCuZMYVQ
 8jly2APZRJX4225NM7INb5WSPeLG9V6aDtFZdvnGiqLv3AGU4p0mDFbxZrZJXXpnYYpneewgT2r
 oDZco9glzBG9qdgwKCDNrSD9VE4zvP4y26POihZB+S602IuLlO/MuhK2jvmSUggNPvPPPsPgjrZ
 ZyMtSHbSeLrVOhlb/F7bBbrnQLmGNk
X-Received: by 2002:a17:90b:4b8c:b0:36e:2106:ded8 with SMTP id
 98e67ed59e1d1-37a040b3449mr594387a91.25.1781224216605; 
 Thu, 11 Jun 2026 17:30:16 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-379e79396d7sm336989a91.1.2026.06.11.17.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 17:30:16 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 0/2] ufs queue
Date: Fri, 12 Jun 2026 09:29:54 +0900
Message-ID: <cover.1781223925.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit ec6a1f43989c6bbf2de1ab84959a70ee35fa1b57:

  Merge tag 'linux-user-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-06-11 13:22:50 -0400)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260612

for you to fetch changes up to 6b1215d82f7cd8a0b562a02a1473aa6714759eed:

  tests/qtest: Add UFS HID qtest (2026-06-12 09:21:28 +0900)

----------------------------------------------------------------
ufs queue

- Add Host Initiated Defragmentation (HID) support

----------------------------------------------------------------
Keoseong Park (2):
      hw/ufs: Add Host Initiated Defragmentation (HID) support
      tests/qtest: Add UFS HID qtest

 hw/ufs/lu.c            |  16 ++-
 hw/ufs/trace-events    |   4 +
 hw/ufs/ufs.c           | 154 +++++++++++++++++++++++++--
 hw/ufs/ufs.h           |   4 +
 include/block/ufs.h    |  18 ++++
 tests/qtest/ufs-test.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 463 insertions(+), 8 deletions(-)

