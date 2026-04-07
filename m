Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FECFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABQq-0002cA-0C; Tue, 07 Apr 2026 14:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wABQn-0002LR-W0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAAdX-0000e3-PE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:54:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso47994685e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775584490; x=1776189290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=U+4hdeKUwoNJ407j6g8XQ+qtVgeH6GZUNZ2DPuYA7es=;
 b=JUPdxLKGageLZyxzTYyOQKIGviLTvHOlpH8bKJDCcHWVt60ve0gYslRmUnPMS5zHa0
 wDsYuGrXbtT7Msuem9wEA7q4ajIbHlTOtkD1I2oQN8FkF2qCnlEiEOC9KE/w9st1RgRB
 CZBxarbzdL4JIZKVArEVbgg7bPJ/9j21tBkFvI3ZhTNbNQFXW0MRB/gwBH6VzngV2ew6
 GY2GD7X25f1SEyj5sv0vVo4BGAFY/+ml13KwN72fA2Xn50R8cpnnzGQwLQgSa4+O4WK6
 hyOO+OS8EB82Rvt4h3yX9zIaXOVFrhkCJGW6FHOTXus5LfncesSg3ete9kdOVE6NyOtg
 Usgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775584490; x=1776189290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+4hdeKUwoNJ407j6g8XQ+qtVgeH6GZUNZ2DPuYA7es=;
 b=RupQyJbWdKW5QGrprr2zSzuwWJ38iHBlPQQk1M8hHeOTn6uQ59nNmWHxIr64V69jqy
 Vf7ChU3IqL3LXF8cSpqrFcRJGyKyGBKKm4MrcvnO0VZTz2GA5Ar3nPyGQEPf5MqjT8Bs
 ra7m2xNudJgRvJahnyPIDc4jGLNXhDkJ85YeI72H9c/spVwBlStxGwk6w8EPOfVdFZgK
 MNUhPM7ysdXrD9p7deBqUjk7VJ8Y4Th7PdsuWjlf8mle1gO5Es//j2TyRrem+Z5sTIos
 999AUeBqLl+Ijsy+SgU4CvhIUCpO3+guKicherUBxEcOQkz86i3AGRw3JvlopyvBNboK
 zoKA==
X-Gm-Message-State: AOJu0YwSv+zBs9UTl2fwyUInOfl8m8n9pVZiSfoG2LpEMhHap5FG6wfS
 R9JVcrRayUSIIbS7Ub926hcdu+M1AtVZ8/ajpAdU4JkyyQAnbLe6aLJi7kfKwY8H5apwxFFuuu9
 6oBv0VW0=
X-Gm-Gg: AeBDiev5R7egh8eDwpTZrgMzPTjt2Gym/ydp4Gq7v+M/i2nqhrbA7Dz1xi970pA9QBV
 yg5bcBc5HBgcvjeydEXpH9DlT/tq/vqRhgoHbdojPfz3qmoPtenlsDCuK+o4Y4FofvWdnhNeNtv
 CSO/xkRUEb6wLKIk6uShgeqTdqelHt65XIr8hnOkKH0l/4x5YQqq46NzbMWIHbRjUqIzvi9A6Xx
 PnSF5oXnRCXwkUMWnTN3Udcwf4KC9j0oa0e760mUu8HuQxcmN5q+qRXCV6VszGEy7zIhlu1kCAA
 dBzjT4U1tQW2aOYDfM15mWzG2HocPw+RE/G9+0cl/WhDkVtCaW/Iqnrc7iePdh/kltLsEd+lZy/
 zrvBes+vv8Q5cusbUest83Hsqd+v0Lh+UIS1/Ikl0lCIRXcEHubOvoZO5bFgNBkKeIEw3kOahv7
 lgYh5wElunOiBbmcFQ7YD6ypQ6pyuun0+pGVupUWW/JAgwxCWMDLCNj2srjVDOLEMZG91zIGP3e
 M/smTVKJbuiwZ7SKQaJ0wihkLJllNo=
X-Received: by 2002:a05:600c:3549:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-488997d1f50mr239854405e9.21.1775584489563; 
 Tue, 07 Apr 2026 10:54:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c5308b3esm1615525e9.1.2026.04.07.10.54.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:54:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] target-arm queue
Date: Tue,  7 Apr 2026 18:54:45 +0100
Message-ID: <20260407175448.3329196-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Some arm patches: two small bug fixes for page table walking,
plus one docs tweak.

-- PMM

The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:

  Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260407

for you to fetch changes up to 8a9fa9ec99be2437a0741b6c74930e6d65dbcb0d:

  docs/system: remove extraneous sentence (2026-04-07 16:03:54 +0100)

----------------------------------------------------------------
target-arm queue:
 * docs/system: remove extraneous sentence
 * target/arm: fix fault_s1ns for stage 2 faults
 * target/arm: do_ats_write(): avoid assertion when ptw failed

----------------------------------------------------------------
Alex Bennée (2):
      target/arm: fix fault_s1ns for stage 2 faults
      docs/system: remove extraneous sentence

Peter Maydell (1):
      target/arm: do_ats_write(): avoid assertion when ptw failed

 docs/system/introduction.rst |  6 ++----
 target/arm/internals.h       |  5 ++++-
 target/arm/ptw.c             | 12 +++++++-----
 target/arm/tcg/cpregs-at.c   |  3 ++-
 4 files changed, 15 insertions(+), 11 deletions(-)

