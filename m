Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E364DC624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzU0-0001F7-T5; Mon, 02 Mar 2026 04:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzTz-0001DY-E2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzTx-0007ex-Te
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:31 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48372efa020so34756865e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 01:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772443347; x=1773048147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=53lxDTWJOUnDlMe6xwIvYf4YhH9NI07Oyq4gFjVKK8U=;
 b=tNPm7D5b+oGbdT0Fj/01FxRh9l/+AcGzmFbh6M83L1SiZymfJ5wrQT//FsRrzsv22r
 0WxAnM648jdQtIDpHFH7mHvUvKt8fBtk+hzHDi9PHIfW2Sm4AR9Wtl61eX4l6oBy5voH
 q3soVhm+ysG7f2AnPq7jl7R0lrwAdRpYyG53LBr2WnsLT8AF7Kje4tavyXSGzCKOFb0L
 pAKkS9z4TI9eekqjlzVM+PGnpRhsVXxxKSATDj1UQU6J0NnLZzyfDRYuMsTzJbg66tSL
 GM5S7wi5OzjgaPXOSsAmr80Vu96Q7EnjDP9NW5OqQOePsPjXr7hNE068ypZSIUy7UGU4
 gVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772443347; x=1773048147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53lxDTWJOUnDlMe6xwIvYf4YhH9NI07Oyq4gFjVKK8U=;
 b=ER3W90biR/xaA+uh7Uke7b/IsKGHdVgAOt1Qh2owvgEgo2AELF5itbUIViomv5gBb2
 lhuuMtCZCh+Z3GryURI7QABpP+CAOz0zAgj6pOG1KsHAA8SmFytR9Hm3N9/JzgYuRJlB
 KvNsEkYeCmgv8znf7nvX8abSWdAPn5Jeg82k8M/AlG31QcIP95LV8QwMSvKKuL5uhJbh
 3SnIFP/4zRAQN4hp5cckzAx95Gbwxj1Od80mqBsP2057Lvm1lYWhvocd/VsJCWOi/FEE
 aM2OaqlB8zMHnXeFr+ZH6uRRBp4Ru7b72ANTYu/dMkXCBpuXi1F+UbvfaxsnJ72s51NT
 P5jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBxwhBu2cNVaG05ft9y1nIMRWzdbxL0XCAArUJbcuQugkOBBNqSwSfZIAgeumtLCigKQU1QxQi8rxl@nongnu.org
X-Gm-Message-State: AOJu0Ywb+f0w4DNmgOjU2yO+Gb3ai4vaQvYZWBsidbbVM3ludRzO+KZF
 WYemgZy0Ho2mFB/Ayx5JLNqpb/lmqyuyxcR+2ygic7BHk5OUUPjgGdr84As4KCkgkeY=
X-Gm-Gg: ATEYQzyN8xGgtUFfZAFp29X+Yy4qYgGw0j6pGpEf11lTKqo8jLVxQe9X1sJ00DKsoq3
 +2bdijj8kPo/VcyJI1WzM0rO5CsizW2/KcJUDcqgRTB0abs2nn3LZ7FXbKDS1jaqVethXyCEd8X
 IRtWWiuU9A96TOKpVN4jJvD4PzwgWSqhr6YGlhqfmB/gP+AxdcMJ9lFrIdhRTyxsdD/ee3BSmCQ
 aNRvsgjC3YYfcDOrpZPmOwLJVWt6mawY5IbpZftal9wl7DT2oi/hx9gmG00bcMS8yjhFYJgwcr5
 qI8CtrDiMnxC0IgrZJRkL9Kb/PRRU3XfIyZbWHIjoqh9ajXz3Gj7JhoJtHzjhyKTSZE5YlkbKjg
 uddSgq6B0TNIrlWk3VcuSvCprtRZuQ9+VkShmI0wPz1KiqPPj1zDvaPEhWeyPpzqDD1kU/GLzf2
 sxVhYWUv5X2a9RRLsufAK+/aMg65aUY5gJ/3Kgf4SWGk1NPxoA1x8zTwCYKURQYQ4gcQKYehX4Q
 PE6IscpWrYITeKbEhwU9q9zU6dUiKo=
X-Received: by 2002:a05:600c:4f07:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-483c9bb1c13mr237083165e9.2.1772443347125; 
 Mon, 02 Mar 2026 01:22:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb9d9c6sm129435305e9.14.2026.03.02.01.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 01:22:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 0/9] arm (and others): fix some memory leaks
Date: Mon,  2 Mar 2026 09:22:16 +0000
Message-ID: <20260302092225.4088227-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

This patchset fixes a couple of minor memory leaks I found by running
"make check" for the arm targets with the clang leak sanitizer enabled.
Version 2 also includes some patches by Fabiano from last year that
fell through the cracks; I've rebased them and included them here.

Changes in v2:
 * patch 1 now just moves the file to keep 'git log --follow' happy
 * patch 1 fixes the filename in tests/docker/test-fuzz
 * patch 2 has the SPDX/doc comment that were in patch 1 before
 * patch 2 drops the walk_path suppression as one of Fabiano's
   patches fixes this leak properly
 * patches 5-9 are from Fabiano; most were reviewed last year

Patches still needing review: just patch 1.

thanks
-- PMM

Fabiano Rosas (5):
  chardev: Fix QIOChannel refcount
  chardev: Don't attempt to unregister yank function more than once
  chardev: Consolidate yank registration
  tests/qtest/test-x86-cpuid-compat: Free allocated memory
  tests/qtest/qos-test: Plug a couple of leaks

Peter Maydell (4):
  scripts: Move lsan_suppressions.txt out of oss-fuzz subdir
  scripts/lsan_suppressions.txt: Add more leaks
  hw/arm/aspeed_gpio: Don't leak string in aspeed_gpio_init()
  tests/qtest/iommu-smmuv3-test: Free QPCIDevice

 .gitlab-ci.d/buildtest.yml             |  2 +-
 chardev/char-io.c                      |  5 ++++
 chardev/char-socket.c                  | 34 ++++++------------------
 hw/gpio/aspeed_gpio.c                  |  2 +-
 scripts/lsan_suppressions.txt          | 26 +++++++++++++++++++
 scripts/oss-fuzz/lsan_suppressions.txt |  5 ----
 tests/docker/test-fuzz                 |  2 +-
 tests/qtest/iommu-smmuv3-test.c        |  1 +
 tests/qtest/qos-test.c                 | 36 +++++++++++++++++++-------
 tests/qtest/test-x86-cpuid-compat.c    |  4 +++
 10 files changed, 73 insertions(+), 44 deletions(-)
 create mode 100644 scripts/lsan_suppressions.txt
 delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt

-- 
2.43.0


