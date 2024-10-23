Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA9ACDDE70
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Zd5-0007Ei-RO; Wed, 23 Oct 2024 07:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd2-0007DH-Os
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:16 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zcy-00033p-2n
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:15 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso804911866b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683248; x=1730288048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pQbsv9+HLFwPElqDt1cQPCWQiM+jUl6LhMnJxHgBrO8=;
 b=M62/Y7ybq2ZI4ywKvui+R0gWITubXpKKhbjezMkxjdMtE59sbzfh6kOIAUplCMCpxn
 /j+LeeLAmU2b8w2K2x5xOGr+n4ahiidFdnzUYeeB1BTd04ixAa/Jh2CPPGevadVxU0ta
 cZ9s5zqs7jcCjsQp1AREvK6a5gtGBct1xw/8n1vU4TRZ5h7SKiK7Vxc9kVwcjlNioM5+
 3pSf/L+H7lbYTqgch3zFdctwU8oa0xe7ISxcFfv3AMbJI73clcJ+KRiCLb/TxwvcYK61
 N9M8V+FrWx0Y6kMunYGrX2IkzDgNlHwuefTUJXqmjKbAYxQsWvC5y9PwljTX6smKkUrI
 3VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683248; x=1730288048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pQbsv9+HLFwPElqDt1cQPCWQiM+jUl6LhMnJxHgBrO8=;
 b=ffGgKh4fS3cNhOJ83B8RmjO/jypEy9FuqaHGUU88s0uUTx+lCqEl3wMb6AnSLfooM8
 BTCeYz+nZCmNogaZdQBQ5Zmguat0ymu5/Y66ma3QgB3Fg3mwTmxrpXqaLAQig6LGFr42
 74xqf0pXR4mjGD78L0FMCiQUIzaguerUtl+DJCNF4ySF3OMvSqYgN45F3koSyTM6M8LM
 nKsjEBbmCHTEO82TnNBVdjbjOAsBaMP46+s3y993vsVXtIvUvPlauToKgkr1CQs0FSAR
 zw8HOvwsT0H3uueXCtfEKEwM2wm39XjizVVU+muaFDhI8zuPNainlqZni4+FZunvdLZ1
 ajKA==
X-Gm-Message-State: AOJu0Yw0B0Bj2SqatTTch7/1JxUbimZUxdTV+EU7bFrbEjn1z9uZiHjX
 hdwTUVr6tkE1WAe+sgOuZ/gRYlGQCUX/i5XFdu7lAjc74duI4YyAtaYdfiqZ0VE=
X-Google-Smtp-Source: AGHT+IGBTwMIHG5DvbrIefLKC+mBtckDycU3fjYg+qjkN6Z/s4jljjceL04+bmzPzYTy+RSRXwQpbw==
X-Received: by 2002:a17:907:940b:b0:a9a:1739:91e9 with SMTP id
 a640c23a62f3a-a9abf86af8emr196140166b.24.1729683248352; 
 Wed, 23 Oct 2024 04:34:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm467109066b.73.2024.10.23.04.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:34:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB4FE5F897;
 Wed, 23 Oct 2024 12:34:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 00/18] maintainer updates (testing, gdbstub, plugins) pre-PR
Date: Wed, 23 Oct 2024 12:33:48 +0100
Message-Id: <20241023113406.1284676-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

This is an aggregation of three of my maintainer trees which you can
also get from their respective branches (testing/next, gdbstub/next
and plugins/next). It is now ready for a pull request.

Since last post:

  - added r-b tags
  - some minor typo fixes
  - dropped meson plugin contrib build and gdb hook changes

The last thing that still needs review:

  gitlab: make check-[dco|patch] a little more verbose

Alex Bennée (9):
  tests/docker: add NOFETCH env variable for testing
  MAINTAINERS: mention my testing/next tree
  scripts/ci: remove architecture checks for build-environment updates
  accel/tcg: add tracepoints for cpu_loop_exit_atomic
  gitlab: make check-[dco|patch] a little more verbose
  MAINTAINERS: mention my gdbstub/next tree
  config/targets: update aarch64_be-linux-user gdb XML list
  tests/tcg: enable basic testing for aarch64_be-linux-user
  MAINTAINERS: mention my plugins/next tree

Gustavo Romero (2):
  tests/tcg/aarch64: Use raw strings for regexes in test-mte.py
  testing: Enhance gdb probe script

Ilya Leoshkevich (2):
  tests/docker: Fix microblaze atomics
  tests/tcg/x86_64: Add cross-modifying code test

Pierrick Bouvier (5):
  meson: hide tsan related warnings
  docs/devel: update tsan build documentation
  dockerfiles: fix default targets for debian-loongarch-cross
  contrib/plugins: remove Makefile for contrib/plugins
  plugins: fix qemu_plugin_reset

 MAINTAINERS                                   |  3 +
 docs/devel/testing/main.rst                   | 26 +++++-
 configure                                     | 23 ++---
 Makefile                                      | 10 ---
 configs/targets/aarch64_be-linux-user.mak     |  2 +-
 meson.build                                   | 10 ++-
 accel/tcg/plugin-gen.c                        |  4 +
 accel/tcg/user-exec.c                         |  2 +-
 tests/tcg/aarch64_be/hello.c                  | 35 ++++++++
 tests/tcg/x86_64/cross-modifying-code.c       | 80 +++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc                |  9 ++
 .gitlab-ci.d/check-dco.py                     |  5 +-
 .gitlab-ci.d/check-patch.py                   |  5 +-
 accel/tcg/trace-events                        | 12 +++
 contrib/plugins/Makefile                      | 87 -------------------
 scripts/ci/setup/ubuntu/build-environment.yml |  2 -
 scripts/probe-gdb-support.py                  | 75 ++++++++--------
 tests/docker/Makefile.include                 |  5 +-
 .../dockerfiles/debian-loongarch-cross.docker |  4 +-
 .../build-toolchain.sh                        |  8 ++
 .../dockerfiles/debian-toolchain.docker       |  7 ++
 tests/tcg/Makefile.target                     |  7 +-
 tests/tcg/aarch64/gdbstub/test-mte.py         |  4 +-
 tests/tcg/aarch64_be/Makefile.target          | 17 ++++
 tests/tcg/x86_64/Makefile.target              |  4 +
 25 files changed, 273 insertions(+), 173 deletions(-)
 create mode 100644 tests/tcg/aarch64_be/hello.c
 create mode 100644 tests/tcg/x86_64/cross-modifying-code.c
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 tests/tcg/aarch64_be/Makefile.target

-- 
2.39.5


