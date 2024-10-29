Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249C8D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nu2-0003Gu-Az; Tue, 29 Oct 2024 11:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns2-0000cc-IA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nrw-0007fD-0S
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:10:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso53616985e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214650; x=1730819450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6E8Zb5i5ZN1jEbdrK5qD7EoR+N+w6A/G2U/YwItD82s=;
 b=PRjNJPRTTuJRO5B3lLv8UUpze6pYdRO8DrgjJ59zAErTAe2hN0W1kAvk1UeBX4bnpz
 cc9CfAP2sohMW4zQ5g3YtGiGy3kAQ4OocHxx5V/z/D56wlsjO9vXAYjEGjmglkXSnPtk
 ULqEYjHxMe4B1hddfWyfKv0WMWLyvxLSDPCyOWEvmXMexHnYcE/Ehx5Q1P5yzk9NVpBU
 CNQ2/baDf5KbudNWEXOk5/QZZwhmEsa9lR4c1k/fv1N3PZkaWaQ4OtvyTZOfEwSQGhKo
 zJogGyGyIg/aZm+6cHfFOZIO3cLJCF8oHU/o39mXfGSM097n2TwzRTW4BIFfbi59hP4C
 nSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214650; x=1730819450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6E8Zb5i5ZN1jEbdrK5qD7EoR+N+w6A/G2U/YwItD82s=;
 b=YBN9Y7CKMozYZF5sWipsKoOidPnJBmapNqiS8TmTquHsrAVkelztk1cKwf/2XR6xZ/
 K9BxJKJVFgxV3xEVV2wKHqnntigjiu1A0kQQGy034AOXtkblwoS+FmjAYfuwrc35sa+n
 KXAhXPWZj3CZBfkoNJO50Gj6xrnYkGQEU9mraPpB+Co/mJzh9qviyA2MT5lch3bCQZrz
 HcMKX8mSjWo0c/u0fo5X+r4/KEZ1Pj25WvliiIlikcu9t6Nh88bMtRxo4Z+qCN+hkvHy
 MVIKue5d8u4YobuMLJgTmwZEEeuKus2bza4Droy4M3w4+gMhXNZDzMPFi3phS3TA+7hi
 PQ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5HyyZkWUSZ2RG35CzruesUuQ6aQWhmqrL6DeSZbousn6kb+k6Lv+0BwrQy7zrQCa0GNcKDaelqwsV@nongnu.org
X-Gm-Message-State: AOJu0YxiTmeRv1evdDzUFWN3r6DF34vYyXEvnttpZtslQh9KOprqOJK5
 7DkiJEav06clB16p8DXxJi+8h8pNkjwAv2gBZfXupvRDd3E9ZpweI3cXO2AnbrQodu3HJPRDIw6
 p
X-Google-Smtp-Source: AGHT+IERbmF76/3LSN1keKH8OxRJL9HslToPgo/EhwzMYK/gLttxmw6zcwYkB1DcAo+aW2gixNpCUA==
X-Received: by 2002:a05:600c:354c:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-4319ab8d515mr110896985e9.0.1730214649673; 
 Tue, 29 Oct 2024 08:10:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/18] target-arm queue
Date: Tue, 29 Oct 2024 15:10:30 +0000
Message-Id: <20241029151048.1047247-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit fdf250e5a37830615e324017cb3a503e84b3712c:

  Merge tag 'pull-maintainer-oct-misc-241024-1' of https://gitlab.com/stsquad/qemu into staging (2024-10-25 19:12:06 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241029

for you to fetch changes up to 84f298ea3e2f0627c09871561e55068db9ff9180:

  target/arm: kvm: require KVM_CAP_DEVICE_CTRL (2024-10-29 15:04:47 +0000)

----------------------------------------------------------------
target-arm queue:
 * arm/kvm: add support for MTE
 * docs/system/cpu-hotplug: Update example's socket-id/core-id
 * target/arm: Store FPSR cumulative exception bits in env->vfp.fpsr
 * target/arm: Don't assert in regime_is_user() for E10 mmuidx values
 * hw/sd/omap_mmc: Fix breakage of OMAP MMC controller
 * tests/functional: Add functional tests for collie, sx1
 * scripts/symlink-install-tree.py: Fix MESONINTROSPECT parsing
 * docs/system/arm: Document remaining undocumented boards
 * target/arm: Fix arithmetic underflow in SETM instruction
 * docs/devel/reset: Fix minor grammatical error
 * target/arm: kvm: require KVM_CAP_DEVICE_CTRL

----------------------------------------------------------------
Akihiko Odaki (1):
      scripts/symlink-install-tree.py: Fix MESONINTROSPECT parsing

Cornelia Huck (1):
      arm/kvm: add support for MTE

Ido Plat (1):
      target/arm: Fix arithmetic underflow in SETM instruction

Paolo Bonzini (1):
      target/arm: kvm: require KVM_CAP_DEVICE_CTRL

Peter Maydell (14):
      docs/system/cpu-hotplug: Update example's socket-id/core-id
      target/arm: Store FPSR cumulative exception bits in env->vfp.fpsr
      target/arm: Don't assert in regime_is_user() for E10 mmuidx values
      hw/sd/omap_mmc: Don't use sd_cmd_type_t
      tests/functional: Add a functional test for the collie board
      tests/functional: Add a functional test for the sx1 board
      docs/system/arm/stm32: List olimex-stm32-h405 in document title
      docs/system/arm: Don't use wildcard '*-bmc' in doc titles
      docs/system/arm: Split fby35 out from aspeed.rst
      docs/system/arm: Add placeholder doc for exynos4 boards
      docs/system/arm: Add placeholder doc for xlnx-zcu102 board
      docs/system/arm: Add placeholder docs for mcimx6ul-evk and mcimx7d-sabre
      docs/system/target-arm.rst: Remove "many boards are undocumented" note
      docs/devel/reset: Fix minor grammatical error

 MAINTAINERS                         |  6 +++
 docs/devel/reset.rst                |  4 +-
 docs/system/arm/aspeed.rst          | 52 +------------------------
 docs/system/arm/exynos.rst          |  9 +++++
 docs/system/arm/fby35.rst           | 47 +++++++++++++++++++++++
 docs/system/arm/mcimx6ul-evk.rst    |  5 +++
 docs/system/arm/mcimx7d-sabre.rst   |  5 +++
 docs/system/arm/nuvoton.rst         |  4 +-
 docs/system/arm/stm32.rst           |  4 +-
 docs/system/arm/xlnx-zcu102.rst     | 19 ++++++++++
 docs/system/cpu-hotplug.rst         | 56 +++++++++++++--------------
 docs/system/target-arm.rst          |  9 +++--
 include/hw/sd/sd.h                  |  8 ----
 target/arm/cpu.h                    |  2 +
 target/arm/internals.h              |  5 +--
 target/arm/kvm_arm.h                | 35 ++++++++++++-----
 hw/arm/virt.c                       | 76 +++++++++++++++++++++----------------
 hw/intc/arm_gic_kvm.c               |  9 +----
 hw/sd/omap_mmc.c                    | 22 ++++++++---
 hw/sd/sd.c                          |  8 ++++
 target/arm/cpu.c                    | 14 +++++--
 target/arm/kvm.c                    | 75 ++++++++++++++++++++++++++++++------
 target/arm/tcg/helper-a64.c         |  2 +-
 target/arm/vfp_helper.c             | 56 ++++++++-------------------
 scripts/symlink-install-tree.py     |  3 +-
 tests/functional/meson.build        |  3 ++
 tests/functional/test_arm_collie.py | 31 +++++++++++++++
 tests/functional/test_arm_sx1.py    | 72 +++++++++++++++++++++++++++++++++++
 28 files changed, 428 insertions(+), 213 deletions(-)
 create mode 100644 docs/system/arm/exynos.rst
 create mode 100644 docs/system/arm/fby35.rst
 create mode 100644 docs/system/arm/mcimx6ul-evk.rst
 create mode 100644 docs/system/arm/mcimx7d-sabre.rst
 create mode 100644 docs/system/arm/xlnx-zcu102.rst
 create mode 100755 tests/functional/test_arm_collie.py
 create mode 100755 tests/functional/test_arm_sx1.py

