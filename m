Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C941D172CC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmgu-0003t7-FZ; Mon, 02 Feb 2026 00:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgr-0003sA-OO
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:37 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgq-0003xk-74
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:37 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso2068793b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770010894; x=1770615694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hzkCo37QVUZ6lfU+nmP+vZsfVmeQbdI3Z+O3WnLpvmQ=;
 b=ncCOS3l1qgK22kqAPgpAsc2dfcqoM3MAzTzTWaL+Kj4aGeigHhI7MwAS03ECLPg2NJ
 9RgZ8OLg4G8uaKMx/NMlsdhp6k5gO1LVSSOLyPm1QOsvS9Qxwt0O2B64RUPCxN2bHZrs
 chf4TE883964P5RIaFxe7coEz/p+E0u6nhsY9VJ3Pg59YvLUVp1GDNFXrDDfZ+5KYgxh
 ilm4z/BEdp79QseTeN+RnmqrhozdhGEdCpGWLZeAZqfX3ATDhQxG/rnI35a84SUkWP9y
 oqB5vhlm80cDBTrqIz4nB5AK95WDZ1X3tbgndGiEKZ+TbXFRlctPZZ1/U5UVbhQvcuTF
 DcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010894; x=1770615694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzkCo37QVUZ6lfU+nmP+vZsfVmeQbdI3Z+O3WnLpvmQ=;
 b=j+fsPFrdMp92R+qavT+JCdQK3E72wB02mCBTB0B3hJAVzJbdTe472D1+MHAPztDH6p
 kH3sEUQAxK+ZjrwQeD+EAMOs+v4X7Ly2u42SXUwRGKwEaeblm4F2SGDzSkzEuScD6slY
 ftYwNnjYDitF4gAdeE8yyDF4q0YRiP4bIuXA7zmvJIK9c/kZKTiE7nE2OKvDOcoajiGG
 QslRWysk2qjZO+ltPY6H3HjKPV22NXUz4XCMuOTmLjavnwfuMKS9GHALAkB1Dj3nDZ2R
 a4g8FBNk4m4T2D3UrqNLMSI86cJ1lTnd6QmKechGPfLkgLgk18BreBelsjJ/ysyxcsDM
 e6tQ==
X-Gm-Message-State: AOJu0YwZORPQHdEZowVr3xvwhoSOAeXPLIujp8YaCd8aGr4QZlHSIBcU
 PcFJ8WplaXontXOUwxR1MZaVyXp0Ng2YQY824lcdjZiFY0EYmYbIxv7FLm8SBw==
X-Gm-Gg: AZuq6aL0GOVbCK42qSwOdSGL72GllDgbvhIzxZt8lVwN3YlrswFAkVAhEfNgmcoUZpB
 WodzwuppROdd+CtO4BILIO8EqayTYUrT/UE05TRXzV5NaAsdh1jqFqCAiR2NB2HrqF5A7xcN/EK
 YcUZ2BcEMi4hKTnWzcivMW5aQK0vE9ZSGQGvZgO23UDFI2clvl46Ahuf1ThLdibT1RwsxlU8zFw
 mNvl81u+/Rq3WNbzTl/AUot98IMKVakZLI6dE6AOdBtkzc6daT7k2Bv1ug86dPOgR3trWEb67eX
 sJFtHGstTjd1edXpdHyi959UkmfKFP+U7XvB4oacdsS7diIqrxgVnvUejgndLt+9l5qNOZlBOT9
 1YV8aAhykkZ9APTjbrfrOfokKKQMBGL14UYrYvthyDOLfePM4RxLJbF/ZSHFgv8adgGGVuoCdtp
 Wq/10o4yKRdFplvA==
X-Received: by 2002:a05:6a20:7f84:b0:364:387:8f4e with SMTP id
 adf61e73a8af0-392e007daa1mr9772367637.34.1770010893790; 
 Sun, 01 Feb 2026 21:41:33 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f610266esm17804018a91.4.2026.02.01.21.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 21:41:33 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, jeuk20.kim@samsung.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com
Subject: [PULL v2 0/4] ufs queue
Date: Mon,  2 Feb 2026 14:41:10 +0900
Message-ID: <cover.1770010668.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42f.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit d21a442a5ab9bc1597afea13f01113d5bb3e772c:

  Merge tag 'pull-target-arm-20260129' of https://gitlab.com/pm215/qemu into staging (2026-02-02 15:04:44 +1100)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260202

for you to fetch changes up to 94e72135d4d657d672561b1ae02a5854421616a7:

  tests/qtest/ufs-test: Add test for mcq completion queue wraparound (2026-02-02 14:33:46 +0900)

----------------------------------------------------------------
UFS MCQ fixes and tests series.

Changes in v2:
- Fix additional endianness-related bugs.

----------------------------------------------------------------
Ilia Levi (2):
      hw/ufs: Fix mcq completion queue wraparound
      tests/qtest/ufs-test: Add test for mcq completion queue wraparound

Jeuk Kim (2):
      hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
      hw/ufs: fix CQE endianness and UPIU length

 hw/ufs/lu.c            |   3 +-
 hw/ufs/ufs.c           |  50 +++++++++++++++-----
 hw/ufs/ufs.h           |   9 ++++
 include/block/ufs.h    |   2 +-
 tests/qtest/ufs-test.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 176 insertions(+), 14 deletions(-)

