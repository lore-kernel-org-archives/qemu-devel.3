Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4FBC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 00:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBkvk-0005Fy-F8; Mon, 27 May 2024 20:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkvj-0005Fc-6D; Mon, 27 May 2024 20:43:07 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkvh-0001jR-MH; Mon, 27 May 2024 20:43:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f693fb0ab6so217160b3a.1; 
 Mon, 27 May 2024 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716856982; x=1717461782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hV/Ff4XuDNOr3amt5eEY63kZmhuDX+0RMWIQl2Ft4Ec=;
 b=lwqdla8jLz7eSyshPoazG1aKyWtW0rmpGKUbqTQ6L1t/A0evcIzJhAhl/3I4jx4jIO
 8Mcpm0op+ZeTK5dW0PrZquozs085PJzTVn6icZZZnI5e+HObrtjejYrJX4hOnQBO3KpA
 0fCnG7LOmZcUK9uHo1KegwcaG/DiwKFC0Tks1goxiOI4o2ivF0YV5Wdw03Pf8/4pM2L5
 9tSNvq32A6GES7PKKvPn4fK55d1Jc8eEaydtpXn9xZFVSWeDXkf5+0oHXumFWKbsELHf
 CS6mYrDyPWSLYhHTF/RA9UY7B7ITBsM6auLQ9DmdwsZZZLh3oIeJeSR1sWYv9ooRsGv1
 4zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716856982; x=1717461782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hV/Ff4XuDNOr3amt5eEY63kZmhuDX+0RMWIQl2Ft4Ec=;
 b=Dtc3rGBN5MYYTi0N0CwC75HncpjBEl0TcaLcYHSaZDjaR5aX+MmsZ+kT1c/XzFUonN
 T4iMhrjnorEJEy3n5ZpnYgImUPVFDngjiFyKNCYtOUHE4Qkk7F8FCJbuFbhOEGwM8riC
 pjmxdO3E8D37xlFTf/+K+bkKM71NUx4/TWC6DuranWhRSr68S8Yc3NwlwpFVRNsSLYdd
 maaC/UCktnrW6EBadgTFLi3mgw4RJU/SYRVeTn0jRHSNnqIgnyOmkWxEp1Adg1rCDbh5
 ypLTiRQJXQhsoJ0CGnU0iOhbAD5J021ilzTHnkvWgPfoRBC3SOG3Dv/gsEY01UnJb7s9
 kwtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8i8oYv4G3OYqkpwcapU4OhZt1HY71tFnhu3NSPV8OLAo4lc1rFz401f2xLmA921bqJ0b5nRa/P05ZOQoGsoLURdop
X-Gm-Message-State: AOJu0YzQBt5UnLEdFKkYCdLbrGj0L5Y0NRO12ql82p30WFa7DaXkjzLz
 K+6EzR78pMmXdGBu01psN6QA3NigHJwiXGzbAn2VOG3AiBcF3N3bwJcpKg==
X-Google-Smtp-Source: AGHT+IF16yS6qGilLmRCukaw3CVELDjCEYb5J35GbDgru/YoPSB/d0zZgAZJIh80DvET+cex1JRfJQ==
X-Received: by 2002:a05:6a20:9493:b0:1b0:18d1:c46c with SMTP id
 adf61e73a8af0-1b212d39517mr9088002637.27.1716856982106; 
 Mon, 27 May 2024 17:43:02 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75783asm67613595ad.23.2024.05.27.17.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 17:43:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 0/6] tests/qtest/migration-test: Improve and enable on ppc64
Date: Tue, 28 May 2024 10:42:04 +1000
Message-ID: <20240528004211.564010-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

Since v1:
- Added "TCG" in subject since it is enabling for TCG
- Enable test_mode_reboot with checking GITLAB_CI env that Fabiano
  suggested.
- Move test_ignore_shared patch out of the s390 fix series to here
  and use GITLAB_CI for it too.
- Move ppc64 pseries machine options out of libqos-spapr.h to a
  new general qtest ppc header.
- Adjust remaining s390x comment to explain the problem.

Thanks,
Nick

Nicholas Piggin (6):
  tests/qtest/migration: Run test_mode_reboot outside gitlab CI
  tests/qtest/migration-test: Fix and enable test_ignore_shared
  tests/qtest: Move common define from libqos-spapr.h to new ppc-util.h
  tests/qtest/migration-test: Quieten ppc64 QEMU warnigns
  tests/qtest/migration-test: Enable on ppc64 TCG
  tests/qtest/migration-test: Use custom asm bios for ppc64

 tests/migration/migration-test.h   |  1 +
 tests/migration/ppc64/a-b-kernel.h | 42 +++++++++++++++
 tests/qtest/libqos/libqos-spapr.h  |  7 ---
 tests/qtest/ppc-util.h             | 19 +++++++
 tests/qtest/boot-serial-test.c     |  2 +-
 tests/qtest/migration-test.c       | 85 ++++++++++--------------------
 tests/qtest/prom-env-test.c        |  2 +-
 tests/qtest/pxe-test.c             |  2 +-
 tests/migration/Makefile           |  2 +-
 tests/migration/ppc64/Makefile     | 15 ++++++
 tests/migration/ppc64/a-b-kernel.S | 66 +++++++++++++++++++++++
 11 files changed, 174 insertions(+), 69 deletions(-)
 create mode 100644 tests/migration/ppc64/a-b-kernel.h
 create mode 100644 tests/qtest/ppc-util.h
 create mode 100644 tests/migration/ppc64/Makefile
 create mode 100644 tests/migration/ppc64/a-b-kernel.S

-- 
2.43.0


