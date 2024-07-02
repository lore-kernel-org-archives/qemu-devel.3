Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C53C30653
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOS2Q-0005PW-Ds; Mon, 01 Jul 2024 21:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2J-0005Ou-Il
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2H-00029r-Q9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:23 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7066a3229f4so2225826b3a.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719882619; x=1720487419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=knxfm46spRW6D4Stc09Cap/r3lb612NK/daP3Um8g20=;
 b=oc+erbzvTeJEdEAsxXZOjIgFEdxJk2VpawUPNtuK3fZJn91wQJ2fu7PkQt9+rxT2w5
 G0I6Gi7T+H1cPfrLnHO+oUOZMOYyZjZb9VZuHLS8yJj5lKhFJNeBnqMoYi8c5bqRtP2F
 B0HL3/Z6NjfVZcTBUAwZz6dipTSREv2UlKhhogZu+6hUmCtIIowiSPZGOLadf7FFTDIE
 EGB/QMay2CaASbLuP5b7YkDl9TSDSZ2EBOuouUKiMiFo3UexH5rFjO19YCNhdP9w4nGC
 7s5cIv5tH4abM8dR6SYmKbqzXqWkYzv8q4Fszy7Z9pStYS2iT5LQvRIBC0ktel1k5hkt
 Uycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719882619; x=1720487419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=knxfm46spRW6D4Stc09Cap/r3lb612NK/daP3Um8g20=;
 b=amm5FwA931uSR4KDkttQ/VKZoRPTEyKClJXH6XYmmtXkhgsMTMk7feAesiM+km3SVn
 pqXSYI5XJWEN0kZuuxe7IrnGB0xrjJkdRFGKxvA5Q71PfN8rF2MaL+3QLuwHCTDr87B6
 eckDNh2QjMC6J4g2PjTfXBCnUzmCwNawIWRjUBPvwPCuJa8GKLDtbA76x6l6KFdvbtAx
 fvnNCSXSt3b+mRQ6Bv6ZmemMdt0r0ZiAe5lX/DalWJGyVGMkeEgznXY3Ub0bAhNcQRJI
 eBFkypDrb+zQu03bPtzHBCqCjdYciJwY+Fz37XfKC3ZZSMNWBi+mvfMowjvwJqDJ+Rog
 TCwQ==
X-Gm-Message-State: AOJu0YxXanezZzViRgpr9wREGFPCewvgj32hYoEsI6G+euZ6epii0rGP
 w5i/7Lbi+bOrBVWhEzUbyREgZGz5g4D+mFgb4JJb6plsLzhp7fMhVlPPNTkmWcw//l42y8cK1YG
 4
X-Google-Smtp-Source: AGHT+IHWVKjKnpbfmurJXpViuVMgL0Qws8rDjttq4SPsPcdGmFT4fEOJl/EhFyAkXrKRTxKPXwDJaA==
X-Received: by 2002:a05:6a20:cd92:b0:1c0:80f5:425b with SMTP id
 adf61e73a8af0-1c080f545d7mr1938915637.61.1719882619435; 
 Mon, 01 Jul 2024 18:10:19 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce1f198sm7480317a91.2.2024.07.01.18.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 18:10:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 0/7] plugins: access values during a memory read/write
Date: Mon,  1 Jul 2024 18:10:08 -0700
Message-Id: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

This will open new use cases for plugins, such as following specific values in
memory.

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

Pierrick Bouvier (7):
  plugins: fix mem callback array size
  plugins: save value during memory accesses
  plugins: extend API to get latest memory value accessed
  tests/tcg: add mechanism to run specific tests with plugins
  tests/tcg: allow to check output of plugins
  tests/plugin/mem: add option to print memory accesses
  tests/tcg/x86_64: add test for plugin memory access

 accel/tcg/atomic_template.h                 | 66 +++++++++++++--
 include/qemu/plugin.h                       |  8 ++
 include/qemu/qemu-plugin.h                  | 32 ++++++++
 accel/tcg/plugin-gen.c                      |  3 +-
 plugins/api.c                               | 34 ++++++++
 plugins/core.c                              |  7 ++
 tcg/tcg-op-ldst.c                           | 72 +++++++++++++++--
 tests/plugin/mem.c                          | 69 +++++++++++++++-
 tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
 accel/tcg/atomic_common.c.inc               | 13 ++-
 accel/tcg/ldst_common.c.inc                 | 38 +++++----
 plugins/qemu-plugins.symbols                |  1 +
 tests/tcg/Makefile.target                   | 10 ++-
 tests/tcg/x86_64/Makefile.target            |  7 ++
 tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
 15 files changed, 462 insertions(+), 35 deletions(-)
 create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
 create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh

-- 
2.39.2


