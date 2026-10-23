Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A850606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R05DinyF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeG-0006aF-96; Fri, 23 Oct 2026 14:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeD-0006ZQ-GC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeB-0004WH-49
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so12381375e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778741; x=1793383541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Sn5iSHrI4+kW8C0fm9ctWPZe0GC6lT5Du4E8Al2JkSc=;
 b=R05DinyF+BhgMlNDmdQTp3OkXe5Vj3fDV8n/6vQYMBt2Hwf4ie4qF1PF8DgBwwSuQJ
 7F3kUj0qyTlL3I1CF0sPJ7cIdLg4yqZCITJwaQZ5dCzh30cDYl9ZNdxL8TaXY0T0BUU8
 Pl0Ua6e8jif9Pgl8K/e5K382xqHi/fDERpdX7KeOzxBBNffCe4nG1UMFTFkCPv83VSFq
 XqpTqurkRUmyYcQgmHpwHxaABnySKlSrvBjfnLD9kMuhnjpSiU5Gy9W/jw1P2YhLWBHy
 WA5QN8nGmFa/ADXZkF2/ZUNxYKTKPl0nqoLwbrav9Dfl4caKnZxO6gKRJMjt7e1lgww+
 /n7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778741; x=1793383541;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sn5iSHrI4+kW8C0fm9ctWPZe0GC6lT5Du4E8Al2JkSc=;
 b=S0gCpIPjdRk3cGAsif/O8akIMqZIJ6SROwnuvQbv5NkqfhL+K/fs6VQM7GEUcRYDuC
 NulJBBClwnQ0dufI4KEm8c+8YO1j1v8y7dDvS+AUo8jL74h7ux7AbviMdHqS4GvkVOkg
 egA1fYHMiMIRyNemfjS6DM/evIF2o/ZI/nnm73335euFA9y0mOZqVti7bSDf/XTGcemN
 henYGSlGR/GhhE64O3nmuSl5+1QkG+dSCpnj0O768KP2fdSKdA7/amJrUFh4UmT7TLaM
 EcO3tfYVTC7zHb2gvrg6zw0OLVLVE/pDrCh6nf5qxG7eD/9cyFA0qUDdUi3bne+wtu70
 D3Yw==
X-Gm-Message-State: AFq9FYI3eza12QfJcsfMiRq+38M/wz9w6Vre+K5YCDrNB7+RzEiuEorZ
 /zMWqIPwVhOeSgxCF3DWGleny7l+51X+drnepdBeXayHNsVroa6t1gegZCuD/E9V2NLd5zdyryx
 zwquAolw=
X-Gm-Gg: AYBFou1xBFg9BA+O9dKtIqj4F537mmHW+GEaNCtCwW/r5R9cmC077VOSdRCzYSpJ/8T
 E08DGSD5yISSDesiI6A+E1SX2JCwbWScat2l4iI4phQJoPn8971ceD0WndUhwlDzj2Qp2xd9e+m
 gM9BqvnuqBrJC6XjdiyH/TiKvERhmWOh/47n2Vsg9cUmfwXlOc+SMjU+gfnAGJMCL/0u5ZY9eQA
 6zs5qwONswl0+M0/nLkPCOTl0YvbbbmZ2xp0IlLhe+PfdBw76rRszi4JjRls3HUP5cYjQzH78zM
 Gwl0XdMvFuW8xDij+kSAnsEvubIKVo5fgDQSCXFITwUO7pl6cSrDLMOjejbF8cdEApt+Gy/ogGs
 PKO76ygsYB+Dh2oQcArmj57bB55A+Gcoxl/5S8OdsVurukkYvsJDXxLsHxve7CtQ0mbQzne86h8
 2OdiOzTk3pzZo/zWsyYjLDF5dwlunYvBYrDdA4IaBoatCb/Qn/d0Q2531cTsd9GyCV9DeZ+p7j1
 uSZKgBgi1astT+NTlg+r91Xm/e/TCkK+TEyw83nM+1zARuZUSEcWhs=
X-Received: by 2002:a05:600c:4f0f:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4a3599107e8mr7880755e9.16.1792778741345; 
 Fri, 23 Oct 2026 11:05:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312eafc80sm30542695e9.3.2026.10.23.11.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5AB245F894;
 Fri, 23 Oct 2026 19:05:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/19] testing updates (tcg, gdbstub)
Date: Fri, 23 Oct 2026 19:05:18 +0100
Message-ID: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:

  Merge tag 'pbouvier/pr/tcg_tests-20261022' of https://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.2-gdbstub-kvm-231026-1

for you to fetch changes up to e0a7139b213487a59023d88e7d56b7e95d90d553:

  tests/functional: add tuxrun kvm gdb test for s390x (2026-10-23 17:32:05 +0100)

----------------------------------------------------------------
testing updates (tcg, gdbstub):

  - make sure we have TCG to run test_acpi_bits
  - fix overflow in linux-sigrtminmax
  - make .dir-locals aware of PYTHONPATH
  - detect gdb in top-level meson
  - fetch kernel assets with symbols for x86, aarch64 and s390 tuxruns
  - use arrays in gdb run-test to make quoting less messy
  - add support for --symbols and --kargs to gdbstub run-test.py
  - restore old kvm gdb test script with a few fixes
  - add tuxrun_kvm_gdb tests for x86,aarch64 and s390

----------------------------------------------------------------
Alex Bennée (18):
      tests/functional: test_acpi_bits requires TCG
      .dir-locals: include QEMU code in PYTHONPATH
      meson: move gdb detection into the top level build file
      tests/functional: allow tuxrun tests to be passed "accel"
      tests/functional: split x86_64 tuxrun into tcg and kvm run
      tests/functional: update x86_64 tuxrun images
      tests/guest-debug: convert gdb_cmd to an array
      tests/guest-debug: convert cmd to an qemu_cmd array
      tests/guest-debug: add --kargs option to run-test
      tests/guest-debug: add --symbols option to run-test
      tests/functional: teach tuxrun about launching gdb tests
      tests/functional: add tuxrun kvm gdb test for x86_64
      tests/functional: split aarch64 tuxrun into tcg and kvm run
      tests/functional: update arm64 tuxrun images
      tests/functional: add tuxrun kvm gdb test for arm64
      tests/functional: split s390x tuxrun into tcg and kvm run
      tests/functional: update s390x tuxrun images
      tests/functional: add tuxrun kvm gdb test for s390x

Max Filippov (1):
      tests/tcg: fix buffer overflow in multiarch/linux/linux-sigrtminmax

 meson.build                                     |  15 +--
 tests/tcg/multiarch/linux/linux-sigrtminmax.c   |   2 +-
 .dir-locals.el                                  |   8 +-
 tests/functional/aarch64/test_tuxrun.py         |  35 ++++-
 tests/functional/gdb-scripts/kernel_gdb_test.py | 164 ++++++++++++++++++++++++
 tests/functional/meson.build                    |   5 +-
 tests/functional/qemu_test/tuxruntest.py        | 108 ++++++++++++++--
 tests/functional/s390x/test_tuxrun.py           |  37 +++++-
 tests/functional/sh4/test_tuxrun.py             |   6 +-
 tests/functional/x86_64/test_acpi_bits.py       |   3 +
 tests/functional/x86_64/test_tuxrun.py          |  45 ++++++-
 tests/guest-debug/run-test.py                   |  83 ++++++++----
 tests/tcg/meson.build                           |   5 -
 13 files changed, 443 insertions(+), 73 deletions(-)
 create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py

-- 
2.47.3


