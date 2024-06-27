Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A14EC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgWV-0006Cx-Ls; Thu, 27 Jun 2024 00:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWT-0006Ch-GF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:13 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWQ-00007m-V3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:12 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-25c9ef2701fso4163226fac.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719461648; x=1720066448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSeOzfkYDlIJW2pScs5aQr5R1YLYoQV0rtpLul9xrBM=;
 b=j8exl/Azdvg21qK44WMdtEzzLasq68lMN/qjJQ+2feoGHRiK2t5aFWk31onePINQQo
 twcbTO9BiyKJZq4u37qfylu6xysJc8Gdb5L+6P2fghplpfq/TJwvx9yPjNyvMChvr4bf
 +jO4HCm2P1M2WzIeC73N3RC9/iXWb0csziSXLVanUntpaNaA3d0Gupz9WIK877pv06fb
 tzehRXH7gmz9w9pX4JdlBSrd6PVkoKQ5g6L7XZKBiiu9++LqMc3kHZGdDRpHAy8OvMBG
 dMFHbS7Fw3ClNjXttcz10HG4AK7ElfwGyHUwmDhCzzUI1/vhtwR+at4S8Y8Bpw18I/+p
 +d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719461648; x=1720066448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSeOzfkYDlIJW2pScs5aQr5R1YLYoQV0rtpLul9xrBM=;
 b=J1+fLI2URnTan5j8mIZ+N5svOA3zRRsHOoAL/dZhReUZ+kXLG9SzKSQM12WrJD7z/m
 UXpmWJ533tjqjikRHF6p4sCu44+V+TAs7o+NmvFvNvS3vODZyx7MV0ygNct5UtN49ipb
 bkEshkcEAXiDV5sEjVlLa+nju1XkDI3Woh+8wP+qxAcTQNUiKt2WsQWKJvIT7IZxdPFL
 WTEEcTEviNrrPEOJeUHvUcJBBl+2SdjCqG1EwgRXXD8PvgNm6SwNelweD0glgK0U4ASf
 50VXczdjewuk5aQL1gh4DCZCHoS6heXboH40W7JYaRzgbQTRqRDdysLtLUVaRrANDGMF
 9flA==
X-Gm-Message-State: AOJu0YzjnvGHdKtVLa8fYmz0neOt1GFOejvE8Ev5Vo9dj5U15xzeHSvW
 i5UYs6+uFLRxVHyEOAhW3mU6vD6dqTSU4107IRgzYYKijes3N+M7pD9o8QVD6lzCl3/8w7ijgqt
 fhk0=
X-Google-Smtp-Source: AGHT+IEiVDTEoJIDk/xGqaaqrQM1BoxfZqiFCKTz2E5YClrA+nN7em3tFjFwWsx1LEuAFcrcVY15Og==
X-Received: by 2002:a05:6870:d611:b0:25c:c73a:dce3 with SMTP id
 586e51a60fabf-25d06ebbc04mr13131406fac.54.1719461648549; 
 Wed, 26 Jun 2024 21:14:08 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72748e8539fsm273045a12.66.2024.06.26.21.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 21:14:07 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 0/9] Add MTE stubs for aarch64 user mode
Date: Thu, 27 Jun 2024 04:13:40 +0000
Message-Id: <20240627041349.356704-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x2c.google.com
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
 
v4:
 - Don't run tests when GDB < 15 (i.e., lacks most recent MTE changes) (Alex's review)
 - Added g_assert()s in new gdb_extend_* API functions to ensure all CPUs have the same features/query/set tables (Alex's review)
 - Move load_tag1 and store_tag1 to mte_helpers.h marking them as "static inline" (Richard's review)
 - Move mte_user_helper.h to linux-user/aarch64/ and include it from gdbstub64.c (Richard's review)

v5:
 - Made load_tag1, store_tag1, and arm_set_mte_tcf0 non-inlined for code modularity (Phil's review)
 - MTE tests: GDB_HAS_MTE is now only set for aarch64 targets (Alex's suggestion)
 
 
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
 configure                              |   4 +
 gdb-xml/aarch64-mte.xml                |  11 ++
 gdbstub/gdbstub.c                      | 254 +++++++++++++++----------
 gdbstub/internals.h                    |  24 ---
 gdbstub/syscalls.c                     |   7 +-
 gdbstub/system.c                       |   7 +-
 gdbstub/user-target.c                  |  25 +--
 gdbstub/user.c                         |   7 +-
 include/exec/gdbstub.h                 |   5 +
 include/gdbstub/commands.h             | 102 ++++++++++
 linux-user/aarch64/meson.build         |   2 +
 linux-user/aarch64/mte_user_helper.c   |  34 ++++
 linux-user/aarch64/mte_user_helper.h   |  25 +++
 linux-user/aarch64/target_prctl.h      |  22 +--
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   |  46 +++++
 target/arm/gdbstub64.c                 | 220 +++++++++++++++++++++
 target/arm/internals.h                 |   6 +
 target/arm/tcg/mte_helper.c            |  48 +----
 target/arm/tcg/mte_helper.h            |  66 +++++++
 tests/tcg/aarch64/Makefile.target      |  14 +-
 tests/tcg/aarch64/gdbstub/test-mte.py  |  86 +++++++++
 tests/tcg/aarch64/mte-8.c              |  98 ++++++++++
 24 files changed, 911 insertions(+), 205 deletions(-)
 create mode 100644 gdb-xml/aarch64-mte.xml
 create mode 100644 include/gdbstub/commands.h
 create mode 100644 linux-user/aarch64/mte_user_helper.c
 create mode 100644 linux-user/aarch64/mte_user_helper.h
 create mode 100644 target/arm/tcg/mte_helper.h
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
 create mode 100644 tests/tcg/aarch64/mte-8.c

-- 
2.34.1


