Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822A7EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4Xs-00034k-7o; Tue, 10 Sep 2024 13:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xo-00032Y-N5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:48 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xm-0002m0-Qb
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:48 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2d8b679d7f2so4553296a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725988845; x=1726593645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AfNU4E2Cw9UkkRJul++973/P7trBC9AonoQW9F/AiDA=;
 b=Gg7kyDOQPRw9PDo/tY4nxqphXktaMncH+dLVirxXndl+96LO2gNBIhCXnunyoJwm76
 4r8nty4mOopFkK9hewcqcqufQ6/7xcIybpOKhZiE2H7dE5NM4EgutXL56uMpQEpseorz
 RQ9S4QR+NUCaTpwQT/jOlWxjsSpUSaGW6M4UZ4Of8QIFGDk9hnPjCf10HD1IZiwnmVXd
 QhZYhxZ8FnzsV03lAZ5943Iw3j6yw6MRwexKy4nmQ98d9jd/jKlrmKOBNBVLh79Sea2s
 Xd5AWOykkl9bkmNtrjKS8OacwEjKWbWHFRoPy79AgLTTyfNqCOSKTitP0JKdDsgrfaJO
 bh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988845; x=1726593645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AfNU4E2Cw9UkkRJul++973/P7trBC9AonoQW9F/AiDA=;
 b=Jr1rLhmNCiQl9JEsXArXFKrbLtARh/cUIs8ySi3jEDRk28axa2QW6NWB/n/pg+0+53
 oMGbnqIr1GweGH2FbTMUIy+QXUl1rs7bhxMC/TI5/FtmJvjaZ4jflFS+N0mwgRKUtxxZ
 pEGlbpuMzfpAitA78rpgfcDvxOfWa5PXIly0O4NW0k0aO9YX+RfDLQbxmsE+V6He/wSj
 UXDmRM3Ol3o82PDFMls8X+Q6D/aVYOWrsHPhiMLEnwCoDXsZqIdMxTLoat1Ld7LVkMYE
 F5zsfSgUeYS3i1lxkit6Eh1jmCzI6YwNEba9xHsFE+htQ6boLmONHmYMp/ljYEyKQq/o
 jzrg==
X-Gm-Message-State: AOJu0YxjduzaIy8YaA54BPjHfteBf6VMP1Co2KPkbpVC0vwHhHYOfqNw
 5/JClqfKYvuXOU33X6CMfjfqRZqL/j61qlWTZodyQO99p9VomyeQVdtxmngmSHLocgHnLlzTMnN
 DF42C2w==
X-Google-Smtp-Source: AGHT+IHkX8yC7ScDO1qto3R4A4ULn9W3KYjJqtj11VaG2ul2srX9B2Lgbj3sqNAkQ+dohmZFZaUyng==
X-Received: by 2002:a17:90a:ef0b:b0:2d8:b91d:d284 with SMTP id
 98e67ed59e1d1-2dad50106a0mr17990709a91.16.1725988845256; 
 Tue, 10 Sep 2024 10:20:45 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db049883e5sm6685310a91.50.2024.09.10.10.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:20:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v8 0/6] plugins: access values during a memory read/write
Date: Tue, 10 Sep 2024 10:20:27 -0700
Message-Id: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

This series allows plugins to know which value is read/written during a memory
access.

For every memory access, we know copy this value before calling mem callbacks,
and those can query it using new API function:
- qemu_plugin_mem_get_value

Mem plugin was extended to print accesses, and a new test was added to check
functionality work as expected. A bug was found where callbacks were not
called as expected.

This will open new use cases for plugins, such as tracking specific values in
memory.

Needs review:
Patch 6: tests/tcg/multiarch: add test for plugin memory access

v8:
- fix test for all target architecture

v7
- renamed variable for adding plugins tests in Makefile
- do not run any command when plugin output should not be checked (thanks Alex)
- add LICENSE + summary for tests/tcg/multiarch/test-plugin-mem-access.c
- test for mem access is now multiarch (tested on aarch64, x86_64, i386)

v6
- fix big endian offset for plugin_gen_mem_callbacks_i32

v5
- fixed width output for mem values in mem plugin
- move plugin_mem_value to CPUNegativeOffset
- tcg/tcg-op-ldst.c: only store word size mem access (do not set upper bits)

v4
- fix prototype for stubs qemu_plugin_vcpu_mem_cb (inverted low/high parameters
  names)
- link gitlab bugs resolved (thanks @Anton Kochkov for reporting)
  https://gitlab.com/qemu-project/qemu/-/issues/1719
  https://gitlab.com/qemu-project/qemu/-/issues/2152

v3
- simplify API: return an algebraic data type for value accessed
  this can be easily extended when QEMU will support wider accesses
- fix Makefile test (use quiet-command instead of manually run the command)
- rename upper/lower to high/low
- reorder functions parameters and code to low/high instead of high/low, to
  follow current convention in QEMU codebase

v2
- fix compilation on aarch64 (missing undef in accel/tcg/atomic_template.h)

v3
- add info when printing memory accesses (insn_vaddr,mem_vaddr,mem_hwaddr)

Pierrick Bouvier (6):
  plugins: save value during memory accesses
  plugins: extend API to get latest memory value accessed
  tests/tcg: add mechanism to run specific tests with plugins
  tests/tcg: allow to check output of plugins
  tests/tcg/plugins/mem: add option to print memory accesses
  tests/tcg/multiarch: add test for plugin memory access

 accel/tcg/atomic_template.h                  |  66 ++++++-
 include/hw/core/cpu.h                        |   4 +
 include/qemu/plugin.h                        |   4 +
 include/qemu/qemu-plugin.h                   |  32 ++++
 plugins/api.c                                |  33 ++++
 plugins/core.c                               |   6 +
 tcg/tcg-op-ldst.c                            |  66 ++++++-
 tests/tcg/multiarch/test-plugin-mem-access.c | 177 +++++++++++++++++++
 tests/tcg/plugins/mem.c                      |  69 +++++++-
 accel/tcg/atomic_common.c.inc                |  13 +-
 accel/tcg/ldst_common.c.inc                  |  38 ++--
 plugins/qemu-plugins.symbols                 |   1 +
 tests/tcg/Makefile.target                    |  12 +-
 tests/tcg/alpha/Makefile.target              |   3 +
 tests/tcg/multiarch/Makefile.target          |  11 ++
 tests/tcg/multiarch/check-plugin-output.sh   |  36 ++++
 tests/tcg/ppc64/Makefile.target              |   5 +
 17 files changed, 544 insertions(+), 32 deletions(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-output.sh

-- 
2.39.2


