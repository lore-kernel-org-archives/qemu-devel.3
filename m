Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EA7C0218B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyun-0001rz-Hs; Mon, 20 Jan 2025 16:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyub-0001cT-Db
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:23 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyuY-0002wm-04
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:21 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d88c355e0dso9482174a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406936; x=1738011736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ihiKrKRxDJxLxAaYATB66nrO+RRpI0LPvSiH9m1+/fU=;
 b=nG5pElsE0m1SeAyXGmYYpS3bWqCSYr8GZiedPTPZttIyxTP2P827n40JjHNX9didBu
 44f4g2EoxGofWARROosMsVrS15CpN+ot/Cdy8ieUobDYWlNjBugx5uNyRjL+1Svhl8OO
 K6mEzs1UaoMMff6s8Uc9yvMNEdL8RE2RFDHcq8BvO56EGmV75zMF6YP6Z/CRtTnvlV3Q
 xshxPDgEzWyWisqi6vtkjTzl70pw76I4ni2JZWWM9mOla4wOhw+98RO3qGAeZqGyPXQE
 5K0j2ljMwTXjP7EOdHKrG4GJ9lb9B63rU6orYDuzF61DCOK05NiDayPI2XJ+gfd+lIVg
 czSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406936; x=1738011736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ihiKrKRxDJxLxAaYATB66nrO+RRpI0LPvSiH9m1+/fU=;
 b=TCbVHBpC4UTv5195w77CDbxTbvzioCl4km8Zv2fIF8nU2YadKRr90KFfGqKFAKun7L
 tmzcPy9QJ+GWnkwVTaOusgosTf0HyyItyPfezh+/wboEB9Uy1H9sB++TdBbh2DLySHcg
 JF7sWKg+kDthSm5My65qqAugY2PIdWG4JAiu+cLnLsZAuXgvc1IBEUa5IocVeQpBhZ1d
 T3p+puZqetRsJGZl/lrVmd7UjxbEwCK4clfNnYXHATeqYkTGk6UjM8gKzmX6WgKGI1Jo
 aMs+ajeMI9OM2FxHUrcx9by5a77eel9V8kjUblKfJVvF5qOEU6TCIXm2XrLNH6btZ2LY
 G/9A==
X-Gm-Message-State: AOJu0Yx2Z0fn6BN7g/vcFnKY63/JyCbeulX6ei8KH/eRQCgR6JN1KaKz
 7NJa1G6jV2vqNhNuVcpo8HrRP4lJrKMPlfG/NQE+VP3LIFAC71cR/J3pnwS4VtXkK2UKA4gXlR3
 /mKc=
X-Gm-Gg: ASbGncuBldjW8y5mE0x49I16aySmEiehyw4CzzDicUN4rzvRI+tO2baXetRFDuUXNKp
 jb80ig/5gWeYF1Yrfwx1GgSLEuB8g3PM1+/Xg2KfxN8bf6nDmc6QZ7XWJovXz5Eu2HAySECitIf
 AEoCKxY08U1qGEr7mnmopoq+bqbelvONVrtKDbz4FWuiAggcfiTIY9v9E8EfG9bViLAiFpdl5Dy
 zW9Fr41lRbbVLORoK25mMJAgW10PcPh2Aj45uI4WQnoQ0LX3SiH146A11cfXt4P8aOi
X-Google-Smtp-Source: AGHT+IHBHe/qLI/S6AsR179BQPMj/PPC/XwLLOL1fS9l1j4mvLxhnswmVJBmSvcVm77xJ+0uZKUl9g==
X-Received: by 2002:a05:6402:2110:b0:5cf:e894:8de9 with SMTP id
 4fb4d7f45d1cf-5db7d2e7da7mr13973182a12.3.1737406936337; 
 Mon, 20 Jan 2025 13:02:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73670dbbsm6283722a12.28.2025.01.20.13.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:02:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCFB15F713;
 Mon, 20 Jan 2025 21:02:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/7] testing/next (qtest timer stuff)
Date: Mon, 20 Jan 2025 21:02:05 +0000
Message-Id: <20250120210212.3890255-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

Thomas found that a number of tests fail under CFI and other exotic
setups. The eventual realisation was that --enable-slirp masks a lot
of timer misuse because it ensures there is always a timer and
therefor things tend to move on (until the system is shutting down).

It turns out that bc02be4508 wasn't the solution after all. The first
few patches are clean-ups and various tightening of test expectations
before we revert the patch.

Please review:

  Revert "util/timer: avoid deadlock when shutting down"
  tests/qtest: tighten up the checks on clock_step
  tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
  tests/qtest: simplify qtest_process_inbuf
  tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
  tests/qtest: don't attempt to clock_step while waiting for virtio ISR
  tests/docker: replicate the check-rust-tools-nightly CI job

Alex.

Alex Bennée (7):
  tests/docker: replicate the check-rust-tools-nightly CI job
  tests/qtest: don't attempt to clock_step while waiting for virtio ISR
  tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
  tests/qtest: simplify qtest_process_inbuf
  tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
  tests/qtest: tighten up the checks on clock_step
  Revert "util/timer: avoid deadlock when shutting down"

 include/system/qtest.h                 |  1 -
 hw/ppc/spapr_rtas.c                    |  1 -
 hw/riscv/riscv_hart.c                  |  1 -
 system/qtest.c                         | 53 +++++++++-----------------
 tests/qtest/libqos/virtio-pci-modern.c |  6 +--
 tests/qtest/libqos/virtio-pci.c        |  6 +--
 tests/qtest/npcm7xx_timer-test.c       |  1 -
 util/qemu-timer.c                      | 16 ++------
 tests/docker/Makefile.include          |  3 ++
 tests/docker/test-rust                 | 21 ++++++++++
 10 files changed, 48 insertions(+), 61 deletions(-)
 create mode 100755 tests/docker/test-rust

-- 
2.39.5


