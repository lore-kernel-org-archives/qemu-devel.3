Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A3EE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH7w-0000cW-Su; Wed, 11 Sep 2024 02:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7u-0000Wt-G6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:55 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7r-0004PK-Ad
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:54 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c26852aff1so7446288a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037209; x=1726642009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=56FVZQHrEfap21ywcDG6PdXhMWYCPHns1nJd/ZhE6o0=;
 b=xBzpjpue3jcv6Lbtbb1ZPq3bemZNkTFW59qcAGVA7gZ6PrlIzgZDhCoJGZ9zI8836T
 hGNK00lLeEChobsYiu9/i3gBHz/9tHugIHo88fuyNf0qCTA1q2Gwtum8ccetT/wyDrQP
 ftHTqpLVsbCa8Q6fZKYyeyMTSlTNZ0ddStQAYhcAod2Nngt6M2tn5GmS/b6TMFr4Cfcz
 vzdYHdIz4z6tDJbtfzWSbYzBQ9qX/vtf4Cuz2ImHGJBE1d4+PfwtXh7g2xu7fUOMetJ8
 JNJ8Lbsy+hQV+IVbRqbquTAFvnqB+vZQyXGQmClmWV+oKGPG6Am1UO4i0wMIaotkJJ/e
 Gm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037209; x=1726642009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=56FVZQHrEfap21ywcDG6PdXhMWYCPHns1nJd/ZhE6o0=;
 b=sVLLXuv5Mi8ZXx0FbxOPaTTLVAP6XNUBgHVMc8kVpApMBBYPn/O1Z8dO+qsVZutSGb
 AHXuG/iAs4jlCsaMFXE3ogY/0kYrpxFb0/ggBwNjNWXC/7S0F+yyyFmb4MFzlWtbIGrX
 emMB0uNu6j1OLKP6dsHI368GkMu3K5pUo+oeHyTnAU8HuxoSWyeW+sWlsFjAh7vn0dYE
 p72PfO/BgAOGDpT1vKbFx2yI7ZWJLcCt8DBjYo81E8vXaxzhRUB+/3jOdfMGJBC9Bweb
 1P1X+jBhoDjewIElldFESK0owBcZbi9HQ/+jA1nO83gY54SuItxUTuEyriHgx9Vl+KxJ
 lLaA==
X-Gm-Message-State: AOJu0YzYoubbswB6vWLyNyN5855B7aO8XgulhvzYRqWVddnlh4TGg/C5
 GZgxJ1YqSNwhr/GXu+AvHzswWGTe6+4saQid5MCsfcgQRcNwWDdhucV2KDn0++029oRrgWWZV3K
 zKT0=
X-Google-Smtp-Source: AGHT+IFkA4eHWaeOZuKH8EZsbGQlAGjFXz94Qp8fdYoQhUUVGGfhrvAFpLvG53L8LT/D6KVlKpXRVg==
X-Received: by 2002:a05:6402:40c6:b0:5c2:50a2:9899 with SMTP id
 4fb4d7f45d1cf-5c3e95354edmr10750105a12.2.1726037208745; 
 Tue, 10 Sep 2024 23:46:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cc1dsm5075313a12.94.2024.09.10.23.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BCEA5F879;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/10] testing and gdbstub updates
Date: Wed, 11 Sep 2024 07:46:35 +0100
Message-Id: <20240911064645.357592-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The following changes since commit a66f28df650166ae8b50c992eea45e7b247f4143:

  Merge tag 'migration-20240909-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-09-10 11:19:22 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-testing-gdbstub-oct-100924-1

for you to fetch changes up to 06dd94e84336d2c5a86c99049dc9abb4a1d6b2e5:

  tests/tcg/aarch64: Extend MTE gdbstub tests to system mode (2024-09-10 23:34:03 +0100)

----------------------------------------------------------------
testing and gdbstub updates:

  - remove docker-armel-cross
  - update i686 and mipsel images to bookworm
  - use docker-all-test-cross for mips64le tests
  - fix duplicated line in docs
  - update gitlab-runner ansible script
  - support MTE in gdbstub for system mode

----------------------------------------------------------------
Alex Bennée (5):
      tests/docker: remove debian-armel-cross
      tests/docker: update debian i686 and mipsel images to bookworm
      tests/docker: use debian-all-test-cross for mips64el tests
      docs/devel: fix duplicate line
      scripts/ci: update the gitlab-runner playbook

Gustavo Romero (5):
      gdbstub: Use specific MMU index when probing MTE addresses
      gdbstub: Add support for MTE in system mode
      tests/guest-debug: Support passing arguments to the GDB test script
      tests/tcg/aarch64: Improve linker script organization
      tests/tcg/aarch64: Extend MTE gdbstub tests to system mode

 docs/devel/testing/main.rst                        |   6 -
 configure                                          |   7 +-
 target/arm/gdbstub64.c                             |  23 ++-
 .gitlab-ci.d/container-cross.yml                   |   6 -
 .gitlab-ci.d/crossbuilds.yml                       |   7 -
 scripts/ci/setup/gitlab-runner.yml                 |  39 +++--
 tests/docker/dockerfiles/debian-armel-cross.docker | 179 ---------------------
 tests/docker/dockerfiles/debian-i686-cross.docker  |  10 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  10 +-
 tests/guest-debug/run-test.py                      |   6 +
 tests/guest-debug/test_gdbstub.py                  |   5 +
 tests/lcitool/refresh                              |  10 +-
 tests/tcg/aarch64/Makefile.softmmu-target          |  49 +++++-
 tests/tcg/aarch64/Makefile.target                  |   3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py              |  71 +++++---
 tests/tcg/aarch64/system/boot.S                    |  11 ++
 tests/tcg/aarch64/system/kernel.ld                 |  33 ++--
 tests/tcg/aarch64/system/mte.S                     | 109 +++++++++++++
 18 files changed, 310 insertions(+), 274 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker
 create mode 100644 tests/tcg/aarch64/system/mte.S

-- 
2.39.2


