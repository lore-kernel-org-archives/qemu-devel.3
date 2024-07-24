Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF0EC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhxm-0002a9-J6; Wed, 24 Jul 2024 15:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxT-0002Mo-A1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:32 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxP-0006E2-Bs
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso919739b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721850437; x=1722455237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2T6v7O+qpLKDTCsjZT5QHx2PqI6oPBcDkqwMfHyRUkE=;
 b=P2tV2EWMBkEoI3GgTrgZd6QaGxwwC0OFKbWzdo4trnT86vT6NuRGmcrlL/NcqwIzKL
 9izXnwkGxzMwD2Cr9NITxEDWMRq6quRgo5iKUv4yFYaZy9Hjas6PUbZBgSMo5C8q4Zh4
 qfAiRFgpLBP0d8VwgVJ+DJoBFT14M9yAySTIgPbnLogzK7mE8fSLsnCdeVNrtNfGR3x/
 v/nRaCKl3qhl1vz1XgBEpc9AQujToUP0UBXCaUUF6A25EQH1CCUV2Cp2GgIkQMM/bb7c
 F/8ETWowcV3KpiRlM0+Qq3s/JtJJaEuUVpzgev15rXs+TJj9a15MVyLlT8KMjg1bIxyi
 3Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721850437; x=1722455237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2T6v7O+qpLKDTCsjZT5QHx2PqI6oPBcDkqwMfHyRUkE=;
 b=K7asuq1jtQvFccPxoZKJLAVP3nIfo+o4zGVQeWd4rRLA3TNqPnBlcqUEsYLCHEbKS1
 4/mxJ/I17bTD9ZV3QkhONpq3cOfrfRMFW0HoDXqWIZcb5AgHakJIacEOU7jJStnedxV1
 +TYYnb9v41HUYXeWzlzPvVhXU9iW4Knp2Nwax6Oj6I1FfFSp9TqObdohadS5XYKTCpS9
 07UtYkeaad5fLz9A14ibuWsZvY20B5ayRET1r+d8UdYE1PdnbnTbdpbWfZGJGesXBF4k
 soK2/VXbIFoAJ4Us3gBtq7hW+OHbTrYi64itwEmSSw4K6nM7YbZnEZeLyNyUsl2lV3jh
 YL3g==
X-Gm-Message-State: AOJu0Yxozkfub44GSsvRucCIljPt+1/dFrX1PihUavg9vmcnwrt3W8jM
 s3cx1RRHOO2FpLBAJ2P0ennlS37lmfwfh+Wz5RgoG2YcVCAvso8WxCBIl6Ob0YbwPmQknGRuKRI
 Fbrg=
X-Google-Smtp-Source: AGHT+IFQTvOtHbRAOqVFOhZ/T0sHd2V2luKguAXGf535oKGLLAueB6ifv9GlsJ/Ta1G2bUq6cWAbhQ==
X-Received: by 2002:a05:6a20:2451:b0:1c3:acd1:5caf with SMTP id
 adf61e73a8af0-1c47403db98mr900138637.23.1721850437179; 
 Wed, 24 Jul 2024 12:47:17 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d19c52a62sm6339116b3a.124.2024.07.24.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 12:47:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v7 0/6] plugins: access values during a memory read/write
Date: Wed, 24 Jul 2024 12:47:02 -0700
Message-Id: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
Patch 7: tests/tcg/multiarch: add test for plugin memory access

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
  tests/plugin/mem: add option to print memory accesses
  tests/tcg/multiarch: add test for plugin memory access

 accel/tcg/atomic_template.h                   |  66 ++++++-
 include/hw/core/cpu.h                         |   4 +
 include/qemu/plugin.h                         |   4 +
 include/qemu/qemu-plugin.h                    |  32 ++++
 plugins/api.c                                 |  33 ++++
 plugins/core.c                                |   6 +
 tcg/tcg-op-ldst.c                             |  66 ++++++-
 tests/plugin/mem.c                            |  69 ++++++-
 tests/tcg/multiarch/test-plugin-mem-access.c  | 175 ++++++++++++++++++
 accel/tcg/atomic_common.c.inc                 |  13 +-
 accel/tcg/ldst_common.c.inc                   |  38 ++--
 plugins/qemu-plugins.symbols                  |   1 +
 tests/tcg/Makefile.target                     |  12 +-
 tests/tcg/multiarch/Makefile.target           |   7 +
 .../tcg/multiarch/check-plugin-mem-access.sh  |  30 +++
 15 files changed, 524 insertions(+), 32 deletions(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-mem-access.sh

-- 
2.39.2


