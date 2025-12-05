Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983FCD33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsA-0005Up-PI; Fri, 05 Dec 2025 11:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs9-0005TZ-Ew
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:33 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs6-0005jK-Dx
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:33 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2e671521so1528976f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952887; x=1765557687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1155hxUGMmswdZayXsFxvNHEuA+dzyh/qWFq8oUu1Hg=;
 b=oCgOo7LVHQE6KEl7vi8rfXxjr6xIlBY2Kq3ssD/Aqg6GLVjUoeTx3+RhBkWdwPw4QQ
 tkaGiiTmvUgVX66FfuwPK8kFByfLWWk1yfc93Iy9sgjY/gaO8uq6VLI6u0Ib9wk5MYiV
 WocGRkdDnj9x3UHbasth1QcWUxJlwA3cpDOi3G8C4iTFTuN+gTFUjA+yTrXvVnHWVuya
 n6XhResnnd1STOWJ9BW3v/YMhfQ6qQZlelWXKuh1eH1FjMp+N5nG7Dgz1Nk782ykBme3
 q1Qd+Y76z640Wahdvl+09oQP0GvNFHfs/kPn39+vvM/gi8Xl5JCFDGBVpvOeLaGFi7Sb
 GlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952887; x=1765557687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1155hxUGMmswdZayXsFxvNHEuA+dzyh/qWFq8oUu1Hg=;
 b=vwUIt0fkU6/0S67aF/oulnrY61p60jmSqcMh56bYTq2yuU9rQzpPOai1f6Pmdm9k05
 AbrX1NV6bKJ3uY2KbeOiEEEMUjzSpKimT+hR+oC5y8bA5NekMahZt3gxEs2hqMORKx8W
 70jCC8XbdWgnXG5zzLpdPrHSiTQ06PGQROeOe2x/m9ttBGa7R0qWGkrHj10no0R2BeId
 a7XnZxFPC/uWHZwqBrM6qSYlfNPtc71NyFh753UBR674M2SlgTmwnEmVE6SWvh3cX2b6
 sHQ/y3FrSQ/2EYnvopMWddQl9of99Ds6BJy0BAPsN1rZwkI/aIqPRxjpTW0OJkB2K0dG
 K5fw==
X-Gm-Message-State: AOJu0Yz7gRcbb+Buw4hbtSH6ugp3sJqCPlUNO1adX+8NHoTsXNjGqQQP
 YLNiNABq6uATNq2AcevLJ+NPFCRSPshcHeHWN+RYBwDcYrSTYc4SHNzzcmt5YRmjQiUvczW7Gx7
 e1AsX
X-Gm-Gg: ASbGncujUmgOemk2s9Nfnp8BVdrZ/rKG3kcgJd72jQ8Xa4MaCDe3BXd0ik9k9/bAs7G
 aIkSGOPnWN0WANdHqbH0olsf3McaV+fuPO1gDCZ+79CTCnLjb1Y1XHeZq9N0VQyDoF2ZdC/C4oM
 +p7QxEdJUwc0mTsiVnyD/kEZMwyKjhEMVsJoyAD+IQOaNxwzoqo4PQaBaLf5JfQPnlTsLhHpifr
 9pO3XQKbK1tOz1R2q/YZAR/YPR8I5SKM46GMhOaLH9O55PBFDtuAJ0yxUb8SrsZulzml9VMzKk5
 CsjACzN9Dk35Wc/QRGPKq60nna9zyvgHhVdOuihvL+ZtrhjCqKbfH+Jp5j993+lGNyUTD+zYpnr
 L1M+0zsg95ViLq/tZA1vGcu6n15MgY8Lmiyy8EZcIjnsjTWPx1BFytyHKEfXI4D8CWQks08L9L9
 Vl4ypH9v5fmsM=
X-Google-Smtp-Source: AGHT+IGXTDuCKXUlfJNy6FsevDa7jFbF8EeD6M4d8/w8kdBakDqHyURIhhYrJt3Zcz/bL/1uXfm+6g==
X-Received: by 2002:adf:fe08:0:b0:42f:8816:6e55 with SMTP id
 ffacd0b85a97d-42f88166e96mr649627f8f.63.1764952887438; 
 Fri, 05 Dec 2025 08:41:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331092sm9887416f8f.30.2025.12.05.08.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00C545F82E;
 Fri, 05 Dec 2025 16:41:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/14] Final fixes for 10.2 (gitlab, testing, docker, docs,
 plugins)
Date: Fri,  5 Dec 2025 16:41:11 +0000
Message-ID: <20251205164125.2122504-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

The following changes since commit 864814f71b4cbb2e65bc83a502e63b3cbdd43b0f:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-12-04 13:37:46 -0600)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-final-fixes-051225-2

for you to fetch changes up to 704db3e250f5c646b3f51bfc7975b66b0f47d767:

  aspeed: Deprecate the fby35 machine (2025-12-05 15:37:18 +0000)

----------------------------------------------------------------
Final fixes for 10.2 (gitlab, testing, docker, docs, plugins)

 - drop out of date --disable-pie workaround for aarch64 custom job
 - remove explicit pxe-test from build with no libslirp
 - update the FreeBSD test image
 - don't try and run check-tcg tests we haven't built qemu for
 - skip iotests which need crypto if we haven't got support
 - transition debian-all-test-cross to lcitool
 - update build env documentation to refer to lcitool
 - update MAINTAINERS entry for custom runners
 - ensure discon plugins can read registers
 - fix a bug on uftrace symbol helper script
 - deprecate the fby35 machine

----------------------------------------------------------------
Alano Song (1):
      docs/devel: Correct typo

Alex Bennée (9):
      gitlab: drop --disable-pie from aarch64-all-linux-static build
      gitlab: drop explicit pxe-test from the build-tci job
      tests/tcg: honour the available QEMU binaries when running check-tcg
      tests/lcitool: add bzip2 to the minimal dependency list
      tests/docker: transition debian-all-test-cross to lcitool
      tests/docker: drop --disable-[tools|system] from all-test-cross
      docs/devel: update build environment setup documentation
      MAINTAINERS: update the custom runner entries
      plugins/core: allow reading of registers during discon events

Cédric Le Goater (1):
      aspeed: Deprecate the fby35 machine

Michael Tokarev (1):
      gitlab-ci.d/cirrus: Update the FreeBSD job to v14.3

Sönke Holz (1):
      contrib/plugins/uftrace_symbols.py: unbreak --no-prefix-symbols

Thomas Huth (1):
      tests/qemu-iotests: Check for a functional "secret" object before using it

 MAINTAINERS                                        |   7 +-
 docs/about/deprecated.rst                          |  13 +-
 docs/devel/atomics.rst                             |   4 +-
 docs/devel/build-environment.rst                   | 145 ++++++++++++++-------
 configure                                          |   6 +-
 hw/arm/fby35.c                                     |   1 +
 plugins/core.c                                     |   2 +
 .gitlab-ci.d/buildtest.yml                         |   4 +-
 .gitlab-ci.d/cirrus.yml                            |   2 +-
 .../custom-runners/ubuntu-24.04-aarch64.yml        |   4 +-
 contrib/plugins/uftrace_symbols.py                 |   2 +
 tests/Makefile.include                             |   9 ++
 .../dockerfiles/debian-all-test-cross.docker       | 130 ++++++++++--------
 tests/lcitool/projects/qemu-minimal.yml            |   1 +
 tests/lcitool/refresh                              |  49 +++++++
 tests/qemu-iotests/049                             |   2 +
 tests/qemu-iotests/134                             |   1 +
 tests/qemu-iotests/158                             |   1 +
 tests/qemu-iotests/common.rc                       |  14 ++
 19 files changed, 277 insertions(+), 120 deletions(-)

-- 
2.47.3


