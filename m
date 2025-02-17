Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12EEC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxQI-0001m9-Nr; Mon, 17 Feb 2025 04:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQG-0001lq-Nu; Mon, 17 Feb 2025 04:28:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQE-0000te-N2; Mon, 17 Feb 2025 04:28:16 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220c665ef4cso60786505ad.3; 
 Mon, 17 Feb 2025 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739784491; x=1740389291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+h6jY0pZl3z4LJ1S1KOykpQQjaQw002zPbOWSHZ19fM=;
 b=SvP2rVTKeZFE3Ek6wkPfX176qifNxNWyO0xdoBAPL9tIpdkhHovNbYgrUgHwO+nJR1
 qFWLfqC6F9+2Lo48w+ZITGfNw1VAeRUi3SybWJkztS4toOJCKUT4ccZk4H6Qp8t506j+
 trFEMsHlXdGZiOp/ZlQ1MavpyUXvS1nUgX+BDwoJOizE/kDMIk2bAYNpqVEfiq8l96Ia
 +8761sdbao2V48Qc4/fIsuKv50bAI6yqHG8Xmu4sOpyfwuAIysuaJ9zA4tD8p+gcePrL
 3zDDYvK08C5t1jlWxo1ImozVBzh9wZlBbcDQJUvoaTRStc7SWxZANlHybzNk59WDPLIX
 /Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739784491; x=1740389291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+h6jY0pZl3z4LJ1S1KOykpQQjaQw002zPbOWSHZ19fM=;
 b=pCkeHRmGWnsx119CZ1UU9OX58w0lI35znLLVfE9UGZcBBxXLFFHqf0hPe4Dgz8FSdL
 hWneQscSroS27pQv0xo1dgqC3PyGWpHskH0y6UqmOiL1QfFjlHbFfm6D81Gmaqfyx1Lw
 wV53oa7AyomgSeYvwqzE8rvut1phU+Pxlho8ukF74s4sA6elFPnzGNi3UfFcn+PHiiz4
 R2Ka9IeXhJMJK1OBs6K/q/LmcAhclCf+dW0ZtOrxpH31p6l8oJMWmwBxbyjb0y8Fyp89
 1wTT8GhilhmirJpieg2ap6HYkIetFD+qR8bm7ghWOi7v5Uuvp4VS17jyChbyiGqIhCDU
 +pBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaQNA5PszWo4g6kS/jfwjXnwv/1ai1cbeEkvoGom0U7CMfqGyH+e+9G/c/gMKsNLsrZDn7dUqdMXTG@nongnu.org
X-Gm-Message-State: AOJu0YyHVth6TvDdUeLws1urQxp/bIjECXZsfLJauLmp3vp5umZgaiZN
 zUB9DsnX70o302LCwPtNLWDsKW6ui4jgh24kSeL50raILHgtdVnnHmLBag==
X-Gm-Gg: ASbGncuHtYvJUd33spBotrwLQSzVf9Da6FCJvhg9Hy2c48ft+B7t6tacx0KbsEHSSCd
 FdqVoMV7NYySS6PQQluibrM0kAmcgJc6h3fvMTUy9Wj5iqeVNJuILRKZ/1HdrpwgPEZEnu55QMI
 xKLc17qYoviodS15jiY6GbYYW42K0P1XixZPrUvtAMz0OtTXmXfL2lepEAqYlYajMAxhPdWx70u
 /DE/o4GceZPBnexV+8IrM6k40ucNGkNduQfZ6wTWGS8XUETOC9RmKP1HcHoldZ39Bcdof3s1uCT
 FN/Cewzun2hI074hvvA=
X-Google-Smtp-Source: AGHT+IGcKf0o2stO4YybS+QREyO5zpFQKAgh7cXAr2fO1nzCRxCeLeRguIh+XfoI5QhyTolDDJVHJQ==
X-Received: by 2002:a05:6a20:6a05:b0:1ee:3116:1b66 with SMTP id
 adf61e73a8af0-1ee8cc03457mr19511898637.34.1739784491239; 
 Mon, 17 Feb 2025 01:28:11 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73265f98e18sm4152940b3a.106.2025.02.17.01.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 01:28:10 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, farosas@suse.de, lvivier@redhat.com
Subject: [PULL 0/4] ufs queue
Date: Mon, 17 Feb 2025 18:27:51 +0900
Message-ID: <cover.1739784105.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62d.google.com
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

The following changes since commit db7aa99ef894e88fc5eedf02ca2579b8c344b2ec:

  Merge tag 'hw-misc-20250216' of https://github.com/philmd/qemu into staging (2025-02-16 20:48:06 -0500)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20250217

for you to fetch changes up to a54596a96006096798b172a368ae952a231f9f72:

  tests/qtest/ufs-test: Add test code for MCQ functionality (2025-02-17 18:20:53 +0900)

----------------------------------------------------------------
ufs updates for MCQ testing  

- Remove unused task management request code  
- Implement bitmap-based command descriptor slot allocation for MCQ  
- Add test cases for MCQ initialization and basic read/write operations  
- Fix LSDBS value for legacy single doorbell mode  

----------------------------------------------------------------
Jeuk Kim (4):
      hw/ufs: Fix legacy single doorbell support bit
      tests/qtest/ufs-test: Cleanup unused code
      tests/qtest/ufs-test: Prepare for MCQ test
      tests/qtest/ufs-test: Add test code for MCQ functionality

 hw/ufs/ufs.c           |   2 +-
 tests/qtest/ufs-test.c | 724 +++++++++++++++++++++++++++++--------------------
 2 files changed, 429 insertions(+), 297 deletions(-)

