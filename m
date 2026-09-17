Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB0AC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FPP-0007iP-CV; Thu, 17 Sep 2026 12:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FP5-0007dG-Pa
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FP3-0000YI-Rx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:07 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48431648f33so391169f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664164; x=1790268964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yHpZ4osyOwqlH2yON4E+JXtQVPRiTiTuVL3FLCwJ7As=;
 b=QHiQKmoqOs5KTx2l8aWMNk1Ak0PjWbAaRi9rEnGKB2+aFVzSJ/4v9Nww6DkdhhjI1C
 XbAe99W/dXvG5a8sQp+AUFrS2S/x4owbkdiAbu/A8xMKjBwlm5aBx0c3joNIwgSpLYkE
 LCo/5dlZUSpH+Be/QNocjpKV5MHj0J3SwKHgyeT8/E4nI1YxME/JO3gLp60DmyyaolEm
 aJLubISudKtcC/Kj4kz6p5BP8jMNLtea09xbmh6mi1sndVCgoNrHMSwvvO+i0HpRwWI4
 Ti5v3Jb7vboB9Q4xdc5YYhO3jbKGrCYnZtkbpjzTfffURE3iTldRPFAd2pyfKS6Esrx/
 HjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664164; x=1790268964;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yHpZ4osyOwqlH2yON4E+JXtQVPRiTiTuVL3FLCwJ7As=;
 b=jeXiHlXslZJ94lr5+t4l37AGnF9F1mW2iEI91OlI2fCBH27yFaaMyqjB4gKeD32jnb
 zGy1fvTxb6JAY8iwrLrjohzi/FDfFUVQR1cCTGax98ft4bow3zgk6Qf3k5x3Bfaagm2K
 tXlNp5QPHKuZYUChgNfw90NVCq0/AZPL0hHoyRMi1yAcCJ9rRY0C9F6BfVEcWLl63BA8
 9cIyNeQwRSO2Dv1/AIy4WaSumqm+zszNEs4wVbDZ/xzUsMjp7pBRloKg50Ti+TWRyBci
 KxrYETkM30YJiXcJFoirATH35OmLLe/chQhL+g0uKC67B8Fe8tz0B+fnsCZT4PJVxfnB
 PgAw==
X-Gm-Message-State: AFuF++l57TX74HLRg9PGqMA7amn3NyqbHm8COUopOOxXKKl7Ggcbb/0M
 xuOWD4muBVcZDZBe9426pYKAZClwkUpBHMNvG1vN0hU4MdIWwOOE683C49q9VWNrQoo=
X-Gm-Gg: AYBFou23GtjS4oPJXPO6zHg2MEPb0WW56hDcu1U4ictjMfoQXQBnvTtWNvSBW1ASVxq
 Z7mqd9LHl/lEe1CKRlWlWhM+yzVBSGxZQJHLSmnZV1H1ehKD66bh/GkNlpGzumYPhr/EycW2D1g
 9/JdXU0u8lrRuHkF3tmQjpHMAnk64aO90JX2iJGtsF/C+XRk110I+/5u+PBM8HdTRYTv37zqd1o
 VOHiaAaU9HS3aGuQtXulOCjoTqJfhpdTZDu2xjnViRkKqQGHPt3vSnPB9wzVdzQs/3TTzGLpMjr
 KgAsK6h/wsDaYNLMuLxIXVlZZoIJU7tcE9gAAEoGBzC+2iPEJ+i12JM7wby3ePKA4QfsyPH4yf3
 j2LGM1JHkZREh1+VVVYfSa1CavLb+OWoNGX7RYyUO6zpOB0On9VaLPBz91RT9RiCjIZSsSVHzCg
 j64nv2muXMjqzbkAiekyxYRrwpHgZRFCvVw+3mPgGSAT8QQJKZrvNmrmUBnAv0P9ER0S1X6DQar
 cqJviJdWQ==
X-Received: by 2002:a05:6000:438a:b0:487:158f:18f8 with SMTP id
 ffacd0b85a97d-487158f1c24mr5757888f8f.22.1789664163880; 
 Thu, 17 Sep 2026 09:56:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fe7esm17538691f8f.6.2026.09.17.09.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:56:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 278685F872;
 Thu, 17 Sep 2026 17:56:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Brad Smith <brad@comstyle.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v5 00/17] testing: various docker clean-ups post meson tcg
 conversion (pre-PR)
Date: Thu, 17 Sep 2026 17:55:44 +0100
Message-ID: <20260917165602.3405537-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

This cleans up a few bits and pieces although doesn't totally solve
the issue of an apparent stall while meson builds the docker image.
However with these changes there should be no difference between the
meson build and the equivalent "make docker-image-foo" invocation.

We also finally get rid of the ill-advised magic caching support in
docker.py.

v5
 - fixup a bunch of rebase damage
 - swap out my ccache fix for Anders
 - rename revert to "configure: ensure it also honours container configuration"
 - use Pierricks solution for avoid too many SKIPs while validating config

v4
 - added Illya's fixes for out of tree and s390x tests
 - tweaked the revert so --disable-containers still passed to meson
 - don't define tests if no compiler available to avoid excess SKIPs

v3

 - Update make2test to trigger docker build from Makefile.include.
 - add Daniels's suggested console: true patch
 - fixed up some unref vars from the reverts

v2

I've restored the configure based compiler checks for so we can build
roms and the vdso blobs again. It looks like we could never build roms
with container based images so I've left it for now. Unlike the vdso
build we can't trigger a container build through Makefile.prereqs.

TODO
----

I also need to look at the timestamp stuff that Pierrick has suggested
to see if that improves the caching from the registry. However that
can wait until after the PR.

The following still need review:

  gitlab: drop check-tcg from clang-system job
  tests/tcg: don't define tests when missing compilers

Please test and review.

Alex.

Alex Bennée (13):
  Revert "configure: remove cross_cc and gdb detection logic"
  configure: ensure it also honours container configuration
  configure: re-purpose the tcg test compiler configs for vdso building
  tests/tcg: prefix meson built docker tags with qemu/
  tests/tcg: use --add-current-user when building containers
  tests/tcg: don't define tests when missing compilers
  tests/docker: add container registry to configure and use
  tests/docker: remove used _read_qemu_dockerfile
  tests/docker: strip remaining caching logic from docker.py
  tests/docker: add specific command to parser
  gitlab: update the @user id mapping file
  tests/tcg: add console property to docker image custom target
  gitlab: drop check-tcg from clang-system job

Anders Roxell (1):
  tests/docker: fix ccache directory variable expansion

Daniel P. Berrangé (1):
  configure: correctly honour --disable-containers

Ilya Leoshkevich (2):
  tests/tcg/s390x: Provide the libc bits needed by the system tests
  tests/tcg: Fix building outside of the source tree

 configure                               | 465 +++++++++++++++++++++++-
 tests/tcg/s390x/libc/stdio.h            |  11 +
 tests/tcg/s390x/libc/string.h           |  12 +
 .gitlab-ci.d/buildtest.yml              |   2 +-
 .gitlab-map-auto                        |   8 +-
 linux-user/aarch64/Makefile.vdso        |   2 +-
 linux-user/arm/Makefile.vdso            |   2 +-
 linux-user/hppa/Makefile.vdso           |   2 +-
 linux-user/i386/Makefile.vdso           |   2 +-
 linux-user/loongarch64/Makefile.vdso    |   2 +-
 linux-user/ppc/Makefile.vdso            |   2 +-
 linux-user/riscv/Makefile.vdso          |   2 +-
 linux-user/s390x/Makefile.vdso          |   2 +-
 linux-user/sh4/Makefile.vdso            |   2 +-
 linux-user/x86_64/Makefile.vdso         |   2 +-
 meson_options.txt                       |   3 +
 scripts/coverity-scan/run-coverity-scan |   2 +-
 scripts/gitlab-map-update               |   2 +-
 scripts/meson-buildoptions.sh           |   3 +
 tests/docker/Makefile.include           |   6 +-
 tests/docker/docker.py                  | 172 +++------
 tests/tcg/meson.build                   |  30 +-
 tests/tcg/s390x/system/meson.build      |   2 +
 23 files changed, 591 insertions(+), 147 deletions(-)
 create mode 100644 tests/tcg/s390x/libc/stdio.h
 create mode 100644 tests/tcg/s390x/libc/string.h

-- 
2.47.3


