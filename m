Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE7FC52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvVI-00074c-PP; Thu, 08 Aug 2024 01:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVD-0006yH-25
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:15:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVB-0002jq-8k
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:15:54 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70eb0ae23e4so489422b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723094151; x=1723698951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X36Z7Ay5zBldauGlkDca4uLnx1CG0RaTI4WuaNoO14s=;
 b=bNMB9m16y1wSeb3irP6ddywJ5o+Ute2R19qlTyWRluwaSefngvxDvltIRewPHfSm95
 ZejFZWbH/+JQz4NBpP9VflKXdNWAMrO1/qrsAGTRxoiAsdoxQC93vMcDROiybfCLzQTj
 BUoUs/YUXg3LHkDgquuMxZu/6nSa9DUixgpd3p5VLppE1NdTSYE4HfL13PtAhyF8KHSz
 aLBi3HnmuIAlYA1cCsFyyS/R3C2sXZKj3ShIcGTbbvBQeg/Vl2nPny4o3YnPe4Pnf8my
 jG3GDZOogvx5eOKWZSeTq8mE5NoJ/WUrog4RZqb+z2gKSYF3AEf4MmSlZs/xjsOptuGR
 SfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723094151; x=1723698951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X36Z7Ay5zBldauGlkDca4uLnx1CG0RaTI4WuaNoO14s=;
 b=T9ccpxVxF+jtMEOoNU42v/Jf50h9wPS8onn2AH76G9husTqb9clc/ATjr04+2fYYLw
 0jBqZ+aoSEXaCuJ4lIS2i+M51Yk3osFYGLZZGrPkZ+7Vi3wFQW4TWnKQAfNFqB3dJ2mD
 iPKKa3uMuvaSyeSDoA5PM5ZHjqn3/dUwfFTH5sVB4hnRuqRNW2G/FfTSmXbaZwF1u2gl
 la1/d6M3gXrg9R/XS0bJM0vzqCw9K5TwgY9LDaPOWTHwajCLuNfv/oO2cCzw9MsrzBtl
 u5yptQDkmN7t4Ptb8aDKAFKIcljfvhW/s2qcz9rZVKG7/Lgk/9iAuUK0TETrUXLFVVBY
 R1fg==
X-Gm-Message-State: AOJu0YwKSp1CHfF2JtZ9sQC8q0qQXE7Z/NLjZF7Gf1k5pOMpcLp/rbSq
 9Ttn+iP98H58eJ3sHo8mIKX0Hb5gUZplaiiTna9vH/TV3pv+ttKJ3WS282jLR+LkGanauABS6wq
 4
X-Google-Smtp-Source: AGHT+IHm6tZB85oc2fMijvqxH3VUzJosxZhNevS8RIa5SL9Pcha5zwmEDlLciZ6wMTzlAXUZO5n6XA==
X-Received: by 2002:a05:6a00:3e02:b0:70d:2b23:a720 with SMTP id
 d2e1a72fcca58-710cad45100mr867540b3a.5.1723094150917; 
 Wed, 07 Aug 2024 22:15:50 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm373484b3a.71.2024.08.07.22.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 22:15:50 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 0/4] gdbstub: Add support for MTE in system mode
Date: Thu,  8 Aug 2024 05:15:27 +0000
Message-Id: <20240808051531.3183498-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x433.google.com
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

This patchset makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

It also extends the MTE gdbstub tests to run in system mode, sharing the
tests between QEMU user mode and system mode.

For running the tests, a GDB that supports MTE for baremetal targets is
necessary. This support has just landed GDB's master branch.

GDB can be built and installed into a /tmp directory in a simple way:
after cloning GDB's master branch, inside a build directory, configure
GDB and build it:

 $ git clone --depth 1 https://sourceware.org/git/binutils-gdb.git --branch master gdb_master && cd gdb_master
 $ mkdir build && cd build
 $ ../configure --disable-binutils --disable-ld --disable-gold --disable-gas --disable-sim --disable-gprof --disable-gprofng --with-python=python3 --enable-libctf --enable-unit-tests --prefix=/tmp/gdb --with-additional-debug-dirs=/usr/lib/debug --enable-targets=all
 $ make -j 32
 $ make install

Configure QEMU, specifying where GDB is installed. For example:

 $ cd build
 $ ../configure --target-list=aarch64-linux-user,aarch64-softmmu --disable-docs --gdb=/tmp/gdb/bin/gdb
 $ make -j 32
 $ cd..

And finally run the MTE gdbstub tests for QEMU system mode:

 $ make -C build -j 32 run-tcg-tests-aarch64-softmmu

v2:
 - Use of cpu_mmu_index() instead of arm_mmu_idx() (Richard's review)
 - Converted mte.c test to mte.S
 - Set tcr_el1, mair_el1, and sctlr_el1 in mte.S instead of in boot.S (Richard's review) 
 - Allowed use of argparse in test scripts to get passed arguments from run-test.py (Alex's review)
 - Fixed test output to be stored in run-gdbstub-mte.out instead of printed to stdout
 - Added detection of GDB supporting MTE in baremetal


Cheers,
Gustavo

Gustavo Romero (4):
  gdbstub: Use specific MMU index when probing MTE addresses
  gdbstub: Add support for MTE in system mode
  tests/guest-debug: Support passing arguments to the GDB test script
  tests/tcg/aarch64: Extend MTE gdbstub tests to system mode

 configure                                 |   5 +
 target/arm/gdbstub64.c                    |  21 ++--
 tests/guest-debug/run-test.py             |   6 ++
 tests/guest-debug/test_gdbstub.py         |   5 +
 tests/tcg/aarch64/Makefile.softmmu-target |  49 ++++++++-
 tests/tcg/aarch64/Makefile.target         |   3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     |  71 ++++++++-----
 tests/tcg/aarch64/system/boot.S           |  14 +++
 tests/tcg/aarch64/system/kernel.ld        |   5 +
 tests/tcg/aarch64/system/mte.S            | 115 ++++++++++++++++++++++
 10 files changed, 259 insertions(+), 35 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/mte.S

-- 
2.34.1


