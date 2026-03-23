Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4762F4613C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heP-0005Mk-LN; Mon, 23 Mar 2026 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he4-0005En-5o
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:50 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he0-0007tS-T9
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:47 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66966a394ceso3230607a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281403; x=1774886203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kL8GThsopdarSyI8vzJWFVkxKKk6ujnsVd0l3A8rx6Q=;
 b=cB/Rnzj7p/wH7ZQ7O5EKaUkPcb2vdHhO6EAtU2Ih8FpCN2WEta1ackafFGTLR02Y9b
 uPW/oPvbR+Cw9SEYNeqv8GnjFPpreB+MNWt9eZ1zOi4XqpsLpDvj4kH0NEiJ6noz9xKE
 t10DaEix04COmz2lwwuFOjFkdiGT2qdER5FMYX1RkOzNxuUsPy7Q24E4TwIrLMOiP2py
 6ok1j58QnosA+q9NI5PkG3md0b2QnVZSA6FgAF/GGyUL/cyx4n1ejtxrbetuU1I3a87i
 kHly/Li3ZOWdrBGBmz9fa/A7B4q1YuH/jvrY8uJVRk9IvYk+NNelLvmVXw9RcCAMSAQd
 wWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281403; x=1774886203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kL8GThsopdarSyI8vzJWFVkxKKk6ujnsVd0l3A8rx6Q=;
 b=BaqH8xdImAcvPFkl+wUnbhwmLjOJKKBES4kXLiPpUT3z8nbej2HEtKK7ncLATmUW6H
 fW9HTgXNGQvoZhzmW8ZDZDy7eZJmHUT1pDyaDiSxcCuAz/E8N10vBvtAg479IhE+yJRw
 3cYgLkz7jBPPs+85yZQIHCeTV0BjNSf2p59sARPt8DX9M1vtJu5ioQseyG6voCeYEAvb
 pu6N7VTDpVyMEE+VvDxi/U0yU+gpMx3TE556NUTLuEtMlqnizIrZrp5+2h4VCJFPWgZj
 13G+Mr6jthBFSeTXRSMpaA/79bVLxBnxAi3IIwp8eBDhTidb6OHYZvoWvrUHhr+hPQGt
 WSSw==
X-Gm-Message-State: AOJu0YwP3sdt7LYkOyCKx9ms6RrI4KWa0p4gNsNHAuQeFuZ32nQfiLeq
 0oXwbzfruBCsRlErHnA1q5YRow2e3+T28kmGuqN0Ok/StOA6EiNzk83jQWbl6OWDuivl0RF8cjk
 DXUibF8U=
X-Gm-Gg: ATEYQzzn2cblzmktEWMIUVMSghh6IKQ0HOozMiMC7VwsOqyK41+iRsq9ro+DCM6Pmix
 IA68pjNwlvdRgasXwNQYZWvCHdd8HaQvyvAuwsM/xg5HBrmlTdjrqysDiF6pM14Mk0BnbK1nCqk
 JL7Lb5JqKbZmuBCOAPdsSNER72uP1B2anuwE4LTeJ0Jrv3wHY9LZFoLvL1W9OIfFuYb3SwCVv0R
 EXSl3AEsiJ8OiR/uIAlBJSYPiwVn0ikAhVMLB5fhjdRFTQPacuV1Pb3coXxi969kKcEWc97TEdB
 yFSJaQWx3S3yIECwJhN4uBJFU/NY4oz4WW2UdJfVukpyIoA644ffja4eIgqPTLJukDBle7n33f7
 v33sRvezfxEJ9jIPsbuox+4i6loNNbX3v4EAPzfexXULYWp3ZlK609qA7Gl9kbcT7xwYRPzoCZX
 wgltvZsJDLCSfoYw45BOMDHbQ=
X-Received: by 2002:aa7:dbcb:0:b0:660:335:4e30 with SMTP id
 4fb4d7f45d1cf-66a34053158mr59383a12.4.1774281403158; 
 Mon, 23 Mar 2026 08:56:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-669cba50ac3sm1282620a12.30.2026.03.23.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE09F5F7E4;
 Mon, 23 Mar 2026 15:56:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 11.0 0/8] testing updates (tcg, functional, lcitool)
Date: Mon, 23 Mar 2026 15:56:29 +0000
Message-ID: <20260323155637.145015-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

The following changes since commit eb153d8fd3be325a5aa7e1a6a73be8854eeaaf27:

  Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu into staging (2026-03-23 10:55:20 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.0-testing-updates-230326-1

for you to fetch changes up to 643a171f56682360a9540783c9edb4f69d639965:

  tests: Replace ncat with socat in migration test and drop ncat from containers (2026-03-23 13:13:07 +0000)

----------------------------------------------------------------
testing updates: tcg, functional, lcitool

  - add TCG_TEST_FILTER to filter check-tcg runs
  - use portable version of dirent64 in linux-test
  - add VBSA linux tests
  - drop python3-sqlite from deps
  - update openSUSE to version 16
  - replace ncat with socat for migration tests

----------------------------------------------------------------
Alex Bennée (3):
      tests/tcg: allow filtering of TCG tests
      tests/functional: allow tests to define decompression target
      tests/functional: add VBSA linux tests

Matheus Tavares Bernardino (1):
      tests/tcg/multiarch/linux-test: use portable alternative for dirent64

Thomas Huth (4):
      tests/lcitool: Remove python3-sqlite3 from the list of needed packages
      tests/lcitool: Update openSUSE to version 16
      tests/docker: Update the opensuse-leap container file to version 16
      tests: Replace ncat with socat in migration test and drop ncat from containers

 configure                                          |   1 -
 tests/tcg/multiarch/linux/linux-test.c             |   5 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml     |   1 -
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml   |   1 -
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml     |   1 -
 tests/Makefile.include                             |   8 +-
 tests/docker/dockerfiles/alpine.docker             |   1 -
 tests/docker/dockerfiles/centos9.docker            |   1 -
 tests/docker/dockerfiles/debian-amd64-cross.docker |   1 -
 tests/docker/dockerfiles/debian-arm64-cross.docker |   1 -
 tests/docker/dockerfiles/debian-armhf-cross.docker |   1 -
 tests/docker/dockerfiles/debian-i686-cross.docker  |   1 -
 .../dockerfiles/debian-mips64el-cross.docker       |   1 -
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   1 -
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   1 -
 .../docker/dockerfiles/debian-riscv64-cross.docker |   1 -
 tests/docker/dockerfiles/debian-s390x-cross.docker |   1 -
 tests/docker/dockerfiles/debian.docker             |   1 -
 .../docker/dockerfiles/fedora-rust-nightly.docker  |   1 -
 tests/docker/dockerfiles/fedora-win64-cross.docker |   1 -
 tests/docker/dockerfiles/fedora.docker             |   1 -
 tests/docker/dockerfiles/opensuse-leap.docker      |  35 +++---
 tests/docker/dockerfiles/ubuntu2204.docker         |   1 -
 tests/functional/aarch64/test_virt_vbsa.py         | 122 +++++++++++++++++++--
 tests/functional/migration.py                      |   4 +-
 tests/functional/qemu_test/testcase.py             |   9 +-
 tests/lcitool/mappings.yml                         |  58 ----------
 tests/lcitool/projects/qemu.yml                    |   2 -
 tests/lcitool/refresh                              |   2 +-
 tests/tcg/Makefile.target                          |  12 +-
 30 files changed, 156 insertions(+), 121 deletions(-)

-- 
2.47.3


