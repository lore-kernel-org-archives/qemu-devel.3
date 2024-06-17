Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55DDC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5rf-0003kl-0x; Mon, 17 Jun 2024 02:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rd-0003kY-NM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:13 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rc-0003Rx-0C
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:13 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c315b569c8so3302997a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718605750; x=1719210550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g3a4Zfz9o4mBrvmuJtGKvfiXeIJqAswNRqTYvoUk5a4=;
 b=lo2pVxCUUdci+f0vnDODoFPqKhQlChPUiipIBSMKWRBQpqF+cfiaUhdLNMfzjYKTqj
 98CWNJ/YksOQgav3Oh73Xz1Si22WXtND/WOgkK5U515ZI6NxNFyVmE0lm0RGdQnZjrYi
 TOEBAVZbOtKRyEYaUnI8FvZlOA6BzklEy9KBUxut9WnyXqsTXpXuTl+48XvWdARQeKQJ
 ZzFKwdA/AwAn/D3Ejh7bypN5ssqRvi4lKiqokZCGxrZmBSLmdcDaz+bh9eot6qfOIt68
 d1TrOP4mNtlAdrJFz4NINdEPO/3+7Pj5Nb3NHE6CBtKHPMbnsqfTwkuqozrzBP0kFwav
 qK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718605750; x=1719210550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g3a4Zfz9o4mBrvmuJtGKvfiXeIJqAswNRqTYvoUk5a4=;
 b=X2jd/h7Vxvxy4f1dnuXS763RmhYV9iyNOcyeaRMvmUnm/rNbStRcFh0H7/Y7vIS5EX
 cYzl/StFFBjTMvdlWOwlDGeYa0t+Px14gUnkpVXpgMH5Yfipv6gKE9j4aui4oVGZrh2+
 tIH+O9FnJfdlTdycPjMBE6Q7iXdJpPlUMiNp+osydXRHlEcj4sLsUPRqBWSEo144ZT1e
 vUzbq8+wygnP7/3rhK6+VE7HK61nxHrQSNckhaP80Ao+qo/IcFxSwMV6k0jJi+qCc/zz
 Lp54/GsOhBZyUt96d4W41c0wZCC90Pegblw0oUbE/MclVVJo1M4YK0UXm0B449VE2qlI
 aaNQ==
X-Gm-Message-State: AOJu0YyM5zpIB9ZfJWSW2FJD8L276CCIFBZpK7rg9fNthIIuXHboqJVA
 gjR0FySf23uVGLYXy7xfb999dtWzQDXBan17ZBzj2EzeeH/BkXCbX8oOyBy3bj9n1ZSoQnYe2md
 4
X-Google-Smtp-Source: AGHT+IF6wCdHDys+a0SOzsgzOvffRtdReTuXxxWYF7XXzXf3toir4zWXIv7VjYNebz5Bwl7OkLdo1g==
X-Received: by 2002:a17:90a:7d17:b0:2c3:1f27:e7e2 with SMTP id
 98e67ed59e1d1-2c4dbe3be05mr7425525a91.40.1718605749609; 
 Sun, 16 Jun 2024 23:29:09 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a75ed69csm10641863a91.14.2024.06.16.23.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 23:29:09 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 0/9] Add MTE stubs for aarch64 user mode
Date: Mon, 17 Jun 2024 06:28:40 +0000
Message-Id: <20240617062849.3531745-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
patchset also introduces three functions: gdb_extend_qsupported_features,
gdb_extend_query_table, and gdb_extend_set_table. These functions can be
used to extend the target-specific 'qSupported' feature string and the
handlers for the 'q' (query) and 'Q' (set) packets. These new functions
are used to add the MTE stubs for the aarch64 gdbstub.
 
Note that this patchset requires a GDB that supports the
qIsAddressTagged packet (recently added to GDB), so the gdbstub MTE
tests introduced by it must be run using GDB's master branch, since the
GDB in the distros hasn't picked up the change yet.

Once GDB is built and installed locally, the tests can be exercised, for
example, this way:

make GDB=~/.local/bin/gdb run-tcg-tests-aarch64-linux-user -j 32

v2:
 - Addressed comments from Richard, Phil, and Alex
 - Made the series more granular by splitting it into more patches
 - Moved gdbstub command-specific structs and functions into a new header, gdbstub/commands.h
 - Fixed exception in allocation_tag_mem_probe()
 - Used MTE helpers ({store,load}_tag1 and allocation_tag_mem_probe) in the MTE stubs
 - Factored out MTE code to set TCF0, avoiding duplication (both prctl and gdbstub code use it)
 - Hoisted sscanf() out of loop in handle_Q_memtag stub and use gdb_hextomem instead
 - Rebased this series on Alex's gdb/next branch
 
v3:
 - Moved stubs to gdbstub64.c
 - Fixed build for BSD target
 - Fixed license tags in the new header files
 - Use of only function prototypes in mte_helpers.h
 - Added prefix to arm_set_mte_tcf0 and marked it inline
 - Moved target/arm/mte.h -> target/arm/tcg/mte_user_helper.h
 - Cleaned up leftover in mte-8 test


Cheers,
Gustavo


Gustavo Romero (9):
  gdbstub: Clean up process_string_cmd
  gdbstub: Move GdbCmdParseEntry into a new header file
  gdbstub: Add support for target-specific stubs
  target/arm: Fix exception case in allocation_tag_mem_probe
  target/arm: Make some MTE helpers widely available
  target/arm: Factor out code for setting MTE TCF0 field
  gdbstub: Make get cpu and hex conversion functions non-internal
  gdbstub: Add support for MTE in user mode
  tests/tcg/aarch64: Add MTE gdbstub tests

 configs/targets/aarch64-linux-user.mak |   2 +-
 gdb-xml/aarch64-mte.xml                |  11 ++
 gdbstub/gdbstub.c                      | 211 ++++++++++++------------
 gdbstub/internals.h                    |  24 ---
 gdbstub/syscalls.c                     |   7 +-
 gdbstub/system.c                       |   7 +-
 gdbstub/user-target.c                  |  25 +--
 gdbstub/user.c                         |   7 +-
 include/exec/gdbstub.h                 |   5 +
 include/gdbstub/commands.h             | 102 ++++++++++++
 linux-user/aarch64/target_prctl.h      |  22 +--
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   |  46 ++++++
 target/arm/gdbstub64.c                 | 217 +++++++++++++++++++++++++
 target/arm/internals.h                 |   6 +
 target/arm/tcg/mte_helper.c            |  48 ++----
 target/arm/tcg/mte_helper.h            |  63 +++++++
 target/arm/tcg/mte_user_helper.h       |  40 +++++
 tests/tcg/aarch64/Makefile.target      |  11 +-
 tests/tcg/aarch64/gdbstub/test-mte.py  |  86 ++++++++++
 tests/tcg/aarch64/mte-8.c              |  98 +++++++++++
 21 files changed, 833 insertions(+), 206 deletions(-)
 create mode 100644 gdb-xml/aarch64-mte.xml
 create mode 100644 include/gdbstub/commands.h
 create mode 100644 target/arm/tcg/mte_helper.h
 create mode 100644 target/arm/tcg/mte_user_helper.h
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
 create mode 100644 tests/tcg/aarch64/mte-8.c

-- 
2.34.1


