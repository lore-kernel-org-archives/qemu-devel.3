Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE35C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7IUO-0005Da-Ke; Wed, 15 May 2024 13:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUJ-0005D2-Nh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:23 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUH-0002Av-TA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:23 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f44390e328so6532511b3a.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715794338; x=1716399138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XTFwLDtKNV9kJLHUz1V6pSQSBJq6wwvBM7AtVCdyiiQ=;
 b=P3Cbu7nP1vRMJ0ZjVrHHQXY+lfXIUtRh+jzqQZIerDCMlzkpkRWmMHlO3jdQhuvBCi
 hqGpZkg7H/2jhSQ5+EVG/kpaYiTC1g2KW+OyzidWm/6phn8NroAi9chlesfeWQT4KekT
 AtdQDBhxA3BfYeigE/10TLSX3S7yhBlDMYIM2Igrml2POpxfgcK/TTFlgUFAAu+Ebfwl
 peA+PiiCQETGhjWVUIZdGSQcABI7yN6fTgLDHkDOLtsNQel9eks9xzGcokxFCi7bYHW5
 Oy1JQ8WgPBv1N6wPrGBCwlPPYUnF2LqvSfylm0PslBJix7QXarIGPjVT9crdb2+sYou4
 ZdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715794338; x=1716399138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XTFwLDtKNV9kJLHUz1V6pSQSBJq6wwvBM7AtVCdyiiQ=;
 b=DqBw7pVhPvL6vSjKDkKSCRSOoDTk32L+xUg2xXnZTWmEdylV2voKozHMXYE0Dwwgha
 Zv9cHlxi1sU8gQB+dpDhZuQsSvJvFC7sBk0yUNeGo+A+IiKknnvwG0+9qVn4MqyQXFM1
 E9+bkph6B7VC0BCFJfiAebpdfKeT5DxXSEa3rqtw6sSphYzCEB5TlMDYN/axoTu0J0iU
 lRm6DOQcuYz8hXDW+IupP8I9vEZ+FNSCZwIpSQletp0HHIbm7mnEhQQfILDP1da0/snF
 6I5Yaa+54oakPIs/jF0pFn0TgVHs7CblIWwbYDkL/7rWoZznXzRtCyxISclhhy99Ya9C
 8rHQ==
X-Gm-Message-State: AOJu0YyyI9XOraJpuohP0v3KNNFL8Wh3PTCtHY1sW0MyCROelwcVZo7p
 N3ySK7CIAT5f5C97VqDrJTE6iNsl/Oh13WdPpZmVK2RcbY5Q+PHDMcpIuozQWXb4o13YixDhmpA
 X
X-Google-Smtp-Source: AGHT+IGoPDYStXNKqTrWZAwUszBR6S4QBlb4kxI9BkkotlVANoavcoU4BhQGlvz+g/BI2dlDTgCZjA==
X-Received: by 2002:a05:6a21:35c6:b0:1af:63fc:4125 with SMTP id
 adf61e73a8af0-1afde1df6c2mr17943627637.62.1715794337734; 
 Wed, 15 May 2024 10:32:17 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:224b:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66c6asm11365133b3a.6.2024.05.15.10.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 10:32:17 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 0/4] Add MTE stubs for aarch64 user mode
Date: Wed, 15 May 2024 17:31:28 +0000
Message-Id: <20240515173132.2462201-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
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

This patchset adds the stubs necessary to support GDB memory tagging
commands on QEMU aarch64 user mode.

These new stubs handle the qIsAddressTagged, qMemTag, and QMemTag
packets, which allow GDB memory tagging subcommands 'check',
'print-allocation-tag', and 'set-allocation-tag' to work. The remaining
memory tagging commands ('print-logical-tag' and 'with-logical-tag')
will also work, but they don't rely on any stub because they perform
local operations.

Since the memory tagging stubs are not common to all architectures, this
patchset also introduces three functions: set_query_supported_arch,
set_gdb_gen_query_table_arch, and set_gdb_gen_set_table_arch. These
functions can be used to extend the target-specific 'qSupported' feature
string and the handlers for the 'q' (query) and 'Q' (set) packets. These
new functions are used to add the MTE stubs for the aarch64 gdbstub.
 
Note that this patchset requires a GDB that supports the
qIsAddressTagged packet (recently added to GDB), so the gdbstub MTE
tests introduced by it must be run using GDB's master branch, since the
GDB in the distros hasn't picked up the change yet.

Once GDB is built and installed locally, the tests can be exercised, for
example, this way:

make GDB=~/.local/bin/gdb run-tcg-tests-aarch64-linux-user -j 32


Cheers,
Gustavo

Gustavo Romero (4):
  gdbstub: Add support for target-specific stubs
  gdbstub: Add support for MTE in user mode
  tests: Gently exit from GDB when tests complete
  tests/tcg/aarch64: Add MTE gdbstub tests

 configs/targets/aarch64-linux-user.mak |   2 +-
 gdbstub/gdbstub.c                      | 108 +++++----
 gdbstub/internals.h                    |  22 --
 gdbstub/syscalls.c                     |   1 +
 include/exec/gdbstub.h                 |  86 ++++++-
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   | 321 +++++++++++++++++++++++++
 target/arm/internals.h                 |   2 +
 tests/guest-debug/test_gdbstub.py      |   2 +-
 tests/tcg/aarch64/Makefile.target      |  11 +-
 tests/tcg/aarch64/gdbstub/test-mte.py  |  86 +++++++
 tests/tcg/aarch64/mte-8.c              | 102 ++++++++
 12 files changed, 670 insertions(+), 74 deletions(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
 create mode 100644 tests/tcg/aarch64/mte-8.c

-- 
2.34.1


