Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B90C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmcz-00010w-FI; Fri, 17 Jan 2025 08:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcv-0000yH-Gl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:09 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002CX-7v
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:09 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d88c355e0dso4113777a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121379; x=1737726179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vl4KqBMWzoTJ8MYxVVubHG6e+0PD32/5yfKoj21Kd6Q=;
 b=MKBoLw1pglCboscsMp/PTUpn+rNyUeG/i2NxKPWZ6CiB1FIsPfY68TeN/iw1wQ2zVf
 oVum+NdAzQ/ECe1WZeMXsfSRGH3gQCnvIZ+Y3DLkhm36ilUTliMMerSVtt+PlY1d30aj
 2TOcwSwjr2OreT/167ip0nzmhNx7ZPR20M/BrWzI/tH+55AYFK+HgYzc+hIpnkUfglVN
 AaenZyckbHs9cc6ogxfJqx9WXJXt++C7NxMp+2U8sig8iFRH0p5eJs4JJVdOEn0VJ03W
 S+uFti1WGst27VUk3qqbVdOEbslRgUM4JkbeZgiAIUjpSlkfP6s3ND7FzGTKE7u6SMAl
 DIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121379; x=1737726179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vl4KqBMWzoTJ8MYxVVubHG6e+0PD32/5yfKoj21Kd6Q=;
 b=TmzpBHI+1I4EGFr75kiiYfrSvswb5t9lIDWG/dW7Z5ZW0LWnoi/kRxEnRorT/ULOli
 s20CufXoCbPqGDCDGXrFZbBxDNAIzEQgqSu5KV5EkSkKQMrqeCU0nLBweEC3zUOHqiEA
 7W6kvRZPgpCAn0bZpvdM0qf4UQ92OJ3k9sMksLd2snwzG7g7csBoEyvxyoX/rpNrDVbF
 fzM1LKa8bige/aoHRWZsJkSiCuitgqaJMr+yh6HC8AhgRnHhkInF6Zl+MXmR+0B7A4nF
 qXa9G199V/+63JQSlKrbFJ+SAgRZie48mKUaFwWV28bxUx9uTQhfWWje0OQaciebaTHp
 RLYg==
X-Gm-Message-State: AOJu0YwvVYFeehwT2HC50aoMuayY/BRBQzjYy/iHVDWuHDtgZNa/Hrk0
 HhWjchYN7Kv6MjlCZEManr1jjK21TGlWNqO1Ktpl+A64iorOw79AciK/6jcKX8zzqpWLCrzWHUt
 y+Ak=
X-Gm-Gg: ASbGncvR4+bqKs44cZoC9CBDnRUx4pIsqPdCKME38uE/WJxgCrT/UQYz8dHEevaEDZj
 xeB6REZnHGUaHieqxxsC0c3UBpY1NUV+3JWa6IeJRvTYXlnEn0EOPIQzgTgJKhU5sjCXtq+Nwpt
 Hg6xB68OlB6nBtTvGyRVUceCjS3yVCEVW5PGBSe14mt1nWt9073FluK0GevFShF4fl1UjwAa4k1
 zmu/V/8TOE0x9X7n1XSy/e3UAB6uDhjZgmxbja+60gxZNRehSXXkVk=
X-Google-Smtp-Source: AGHT+IHIQaGhq2SSfDjMeUwaYe1xBU/bUZACnPn/tmmjTrDsvo6gMCZYDOTxRCbzgDBgc2nF5jVtiQ==
X-Received: by 2002:a05:6402:1ec8:b0:5d3:e45d:ba7c with SMTP id
 4fb4d7f45d1cf-5db7db077f4mr2291823a12.29.1737121379397; 
 Fri, 17 Jan 2025 05:42:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73642c1asm1487029a12.5.2025.01.17.05.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:42:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DAD896083E;
 Fri, 17 Jan 2025 13:42:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/37] maintainer updates for gdb, plugins,
 documentation and windows builds
Date: Fri, 17 Jan 2025 13:42:19 +0000
Message-Id: <20250117134256.2079356-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

The following changes since commit 4d5d933bbc7cc52f6cc6b9021f91fa06266222d5:

  Merge tag 'pull-xenfv-20250116' of git://git.infradead.org/users/dwmw2/qemu into staging (2025-01-16 09:03:43 -0500)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.0-gdb-plugins-doc-updates-170125-1

for you to fetch changes up to b9eab5efc1a631b476656859beb8eaaa895eb202:

  scripts/nsis.py: Run dependency check for each DLL file only once (2025-01-17 10:46:15 +0000)

----------------------------------------------------------------
semihosting, plugin and doc updates:

  - log a guest_error for failed semihosting open()
  - clean up semihosting includes to reduce build duplication
  - re-factor misc device initialisation to fail with &error_exit
  - propagate Error * to gdbserver_start sub-functions
  - fix 32-bit build of plugins and re-enable by default
  - ensure IRQs don't preempt io recompiled instructions
  - remove usage of gcc_struct to enable clang builds
  - enable clang/lld to build plugins on windows
  - various small kdoc typo fixes
  - add perl scripts to editorconfig
  - remove unused field from MemoryRegion
  - make kdoc script a dependency so doc rebuilds get triggered
  - expand developer documentation:
    - notes on git-publish
    - describe usage of b4
    - setting up build dependencies
    - codebase layout
    - add a glossary of common terms
  -  optimise the windows ndis script

----------------------------------------------------------------
Alex Bennée (11):
      semihosting: add guest_error logging for failed opens
      system/vl: more error exit into config enumeration code
      system: squash usb_parse into a single function
      system: propagate Error to gdbserver_start (and other device setups)
      accel/tcg: also suppress asynchronous IRQs for cpu_io_recompile
      plugins: fix kdoc annotation
      editorconfig: update for perl scripts
      tests/qtest: fix some copy and paste errors in kdoc
      include/exec: fix some copy and paste errors in kdoc
      include/exec: remove warning_printed from MemoryRegion
      docs/sphinx: include kernel-doc script as a dependency

Philippe Mathieu-Daudé (6):
      semihosting/uaccess: Briefly document returned values
      semihosting/syscalls: Include missing 'exec/cpu-defs.h' header
      semihosting/uaccess: Include missing 'exec/cpu-all.h' header
      semihosting/arm-compat: Include missing 'cpu.h' header
      semihosting/console: Avoid including 'cpu.h'
      semihosting/meson: Build config.o and console.o once

Pierrick Bouvier (19):
      tests/tcg/plugins/insn: remove unused callback parameter
      contrib/plugins/howvec: ensure we don't regress if this plugin is extended
      tests/tcg/plugins/syscall: fix 32-bit build
      tests/tcg/plugins/mem: fix 32-bit build
      contrib/plugins/stoptrigger: fix 32-bit build
      contrib/plugins/cache: fix 32-bit build
      contrib/plugins/hotblocks: fix 32-bit build
      contrib/plugins/cflow: fix 32-bit build
      contrib/plugins/hwprofile: fix 32-bit build
      contrib/plugins/hotpages: fix 32-bit build
      configure: reenable plugins by default for 32-bit hosts
      win32: remove usage of attribute gcc_struct
      docs/devel/style: add a section about bitfield, and disallow them for packed structures
      plugins: enable linking with clang/lld
      docs/devel: add git-publish for patch submitting
      docs/devel: add b4 for patch retrieval
      docs/devel: add information on how to setup build environments
      docs/devel: add a codebase section
      docs: add a glossary

Stefan Weil (1):
      scripts/nsis.py: Run dependency check for each DLL file only once

 MAINTAINERS                               |   5 +-
 docs/about/build-platforms.rst            |   4 +-
 docs/about/emulation.rst                  |   2 +
 docs/devel/build-environment.rst          | 118 +++++++++++++
 docs/devel/codebase.rst                   | 220 +++++++++++++++++++++++
 docs/devel/control-flow-integrity.rst     |   2 +
 docs/devel/decodetree.rst                 |   2 +
 docs/devel/ebpf_rss.rst                   |   2 +
 docs/devel/index-build.rst                |   1 +
 docs/devel/index-internals.rst            |   2 +
 docs/devel/index.rst                      |   1 +
 docs/devel/migration/main.rst             |   2 +
 docs/devel/multi-thread-tcg.rst           |   2 +
 docs/devel/qapi-code-gen.rst              |   1 +
 docs/devel/style.rst                      |  20 +++
 docs/devel/submitting-a-patch.rst         |  39 +++++
 docs/devel/testing/main.rst               |   9 +-
 docs/devel/testing/qtest.rst              |   2 +
 docs/glossary.rst                         | 280 ++++++++++++++++++++++++++++++
 docs/index.rst                            |   3 +
 docs/interop/qemu-ga.rst                  |   2 +
 docs/sphinx/depfile.py                    |   3 +
 docs/system/arm/virt.rst                  |   2 +
 docs/system/images.rst                    |   2 +
 docs/system/qemu-block-drivers.rst.inc    |   2 +
 docs/tools/qemu-nbd.rst                   |   2 +
 docs/tools/qemu-storage-daemon.rst        |   2 +
 docs/user/main.rst                        |   6 +
 configure                                 |  21 +--
 meson.build                               |   6 +-
 include/exec/gdbstub.h                    |   8 +-
 include/exec/memory.h                     |   5 +-
 include/qemu/compiler.h                   |   7 +-
 include/qemu/qemu-plugin.h                |   2 +-
 include/semihosting/console.h             |   2 -
 include/semihosting/syscalls.h            |   1 +
 include/semihosting/uaccess.h             |  55 ++++++
 scripts/cocci-macro-file.h                |   6 +-
 subprojects/libvhost-user/libvhost-user.h |   6 +-
 tests/qtest/libqos/qgraph.h               |   2 +-
 tests/qtest/libqtest.h                    |   6 +-
 accel/tcg/translate-all.c                 |   5 +-
 bsd-user/main.c                           |   2 +-
 contrib/plugins/cache.c                   |  18 +-
 contrib/plugins/cflow.c                   |  17 +-
 contrib/plugins/hotblocks.c               |  29 +++-
 contrib/plugins/hotpages.c                |   6 +-
 contrib/plugins/howvec.c                  |   7 +-
 contrib/plugins/hwprofile.c               |  27 +--
 contrib/plugins/stoptrigger.c             |  48 ++---
 gdbstub/system.c                          |  22 +--
 gdbstub/user.c                            |  22 +--
 linux-user/main.c                         |   6 +-
 monitor/hmp-cmds.c                        |   2 +-
 semihosting/arm-compat-semi.c             |   1 +
 semihosting/console.c                     |   3 +-
 semihosting/syscalls.c                    |   2 +
 semihosting/uaccess.c                     |   1 +
 system/vl.c                               | 101 +++++------
 tests/tcg/plugins/insn.c                  |   4 +-
 tests/tcg/plugins/mem.c                   |   6 +-
 tests/tcg/plugins/syscall.c               |   6 +-
 .editorconfig                             |  13 ++
 contrib/plugins/meson.build               |   2 +-
 plugins/meson.build                       |  24 ++-
 scripts/nsis.py                           |  10 +-
 semihosting/meson.build                   |   9 +-
 tests/tcg/plugins/meson.build             |   3 +-
 68 files changed, 1035 insertions(+), 226 deletions(-)
 create mode 100644 docs/devel/build-environment.rst
 create mode 100644 docs/devel/codebase.rst
 create mode 100644 docs/glossary.rst

-- 
2.39.5


