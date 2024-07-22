Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFDAC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvZV-0004NH-34; Mon, 22 Jul 2024 12:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZS-0004Mg-V6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZQ-0007dK-Vv
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc569440e1so35696745ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664446; x=1722269246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5TybG9Wl5Lf+sqEB7R1oc8u9w3KDzgw5DOhQ3sJf4Lg=;
 b=gTeAU+urCjKEhDOQGgv1XWYQRee07XViaUBqJjntgIoHrInEZIabC/VGYSRNJqmFKR
 qlNMFwIBHgirfrkWJODQLW2ZR1oVgiZb+E1o3FnKjPhKLtEsXh2ke1FFB966nS7p3UAz
 YzK7MFRCnM4x+MhyYLSYT7QlJnA7jFbiNOHkypgTAy4RnOBJmBqMbayzhWL/5V6LsRg5
 +PJTGeCsF6aoFhERs4DKkndWuZ7c8/vR8LjT5o+uZ3ROxL78LA4OzAjpPS/TPQYlFtSx
 AWJf74ORoY8JOIckIkxeoW1b6X/hK9TqZF7maEvjnXroS5GZ62vgO3a7WP+p/MsKlZly
 NeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664446; x=1722269246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5TybG9Wl5Lf+sqEB7R1oc8u9w3KDzgw5DOhQ3sJf4Lg=;
 b=cGkV2E8IQiiPPpY73nr2pQyCky1BYHXHt2FkKmZE68kftD+emwk+WEb0LNaIj60yNw
 0Hs9YB+zOEjLawYTRk+G9OG3fEvSxfCFAhYeAO3eLjbMYD9kPPJwf4mIO7j1BilZWqK5
 GOUYU7y/DWVT+vH2xgTxfLiisFvg3kppAdowzV+/pRZVn6irmMhK8Wcai7ZMLFTuOjqL
 C93D1TfNg2h6WWhIKVo0owEnN4q/KG2m16janS7zOoVxhiYFY2WK/LAQSWXLlpuY6Uf5
 yqnGG3bH0KNRr4aLQU90QazXjCeyCQQvH0tvHf5X/zBH2+eAZ6VemdYerH36eD+newjt
 gY1A==
X-Gm-Message-State: AOJu0YxymJ7OMgHmZbhJQLhARGqMJEbHPFhFWu5eId54iqw5bNLSq+sA
 x0W3MAsz8mFMuSYrFuybDQnh0QUzfDP4TH8QaJStJhNsz0FLjJArTGb5Sm92RB7H64BRHy/8JOw
 E
X-Google-Smtp-Source: AGHT+IFJpPx94NLEe0VLNHXe5tI4WMFHtmJ5qpHS0P44iAFQrevMqPA+O1saJuks8drtRtW1HGr7nA==
X-Received: by 2002:a17:902:e805:b0:1fb:6663:b647 with SMTP id
 d9443c01a7336-1fdb5f50c08mr2484075ad.3.1721664445822; 
 Mon, 22 Jul 2024 09:07:25 -0700 (PDT)
Received: from amd.. ([2804:7f0:b402:9243:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f2ac8eesm56533165ad.118.2024.07.22.09.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 09:07:25 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 0/4] gdbstub: Add support for MTE in system mode
Date: Mon, 22 Jul 2024 16:07:05 +0000
Message-Id: <20240722160709.1677430-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
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
tests between user mode and system mode.

For running the tests, a GDB that supports MTE for baremetal targets is
necessary. The patch for this support is currently under review [0].
For convenience, this patch is available in this GDB branch [1], and GDB
can be built and installed into a /tmp directory in a straightforward
way. After cloning [1], in a 'build' directory, configure GDB to build:

 $ git clone --depth 1 https://github.com/gromero/binutils-gdb.git --branch mte_baremetal mte_baremetal && cd mte_baremetal
 $ mkdir build && cd build
 $ ../configure --disable-binutils --disable-ld --disable-gold --disable-gas --disable-sim --disable-gprof --disable-gprofng --with-python=python3 --enable-libctf --enable-unit-tests --prefix=/tmp/gdb --with-additional-debug-dirs=/usr/lib/debug --enable-targets=all
 $ make -j 32
 $ make install

Configure QEMU, specifying where GDB is installed. For example:

 $ cd build
 $ ../configure --target-list=aarch64-linux-user,aarch64-softmmu --disable-docs --gdb=/tmp/gdb/bin/gdb
 $ make -j 32
 $ cd..

And, finally, run the MTE gdbstub tests for system mode:

 $ make -C build -j 32 run-tcg-tests-aarch64-softmmu


Cheers,
Gustavo

[0] https://sourceware.org/pipermail/gdb-patches/2024-July/210584.html
[1] https://github.com/gromero/binutils-gdb/tree/mte_baremetal

Gustavo Romero (4):
  gdbstub: Use specific MMU index when probing MTE addresses
  gdbstub: Add support for MTE in system mode
  tests/guest-debug: Support passing arguments to the GDB test script
  tests/tcg/aarch64: Extend MTE gdbstub tests to system mode

 target/arm/gdbstub64.c                    | 21 +++++++----
 tests/guest-debug/run-test.py             |  4 +++
 tests/tcg/aarch64/Makefile.softmmu-target | 36 +++++++++++++++++--
 tests/tcg/aarch64/Makefile.target         |  3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     | 44 +++++++++++++++--------
 tests/tcg/aarch64/system/boot.S           | 26 ++++++++++++--
 tests/tcg/aarch64/system/kernel.ld        |  5 +++
 tests/tcg/aarch64/system/mte.c            | 40 +++++++++++++++++++++
 8 files changed, 151 insertions(+), 28 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/mte.c

-- 
2.34.1


