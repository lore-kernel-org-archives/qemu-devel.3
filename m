Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BEDC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiV3-0005KQ-Qe; Tue, 02 Jul 2024 14:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV1-0005K4-48
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:07 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiUy-00086W-RR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:06 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c7b14bb4a5so3199272a91.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945902; x=1720550702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zIXRNj6hv7VUKRowdbtUTlmEXvuNh+UxIOlvMPsMxoo=;
 b=O0ixsG+WGrwUX+gnI3g1/ncRa0fooqYjcXzjUA9BsZK97on1667YOipoAN+HBaY0CC
 AGWz8oO/UD/shPDpkRqD0ewmBSmgzdftHjQzvOZlzg102X0GxnJ92ScorM1liQxLSD67
 BVTy2NEfqz8v5SDeNjQZzQwkKg0/GTgCCph8lHe+j8qpflEdjyNCe8khe8lliZl+GAhq
 hwTKcllObGcrWEX1p5Cbv+Do8XGjOZRRuOTAZ/HjFmb2/MuViAJ7e2j64I+Lyx4dNQi0
 vU2MrAOSnhj0/sW/qERgTkLM+sQhhiaf40Zllr3ui/m49vZvCyuWzv0tqPFB5VCA9fFM
 o8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945902; x=1720550702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zIXRNj6hv7VUKRowdbtUTlmEXvuNh+UxIOlvMPsMxoo=;
 b=cuoNPCendfrJhJX9a+Kp9ALSXXiO3/YC94BTnwY7KkiCVI/mx0cLGJ01SIYBN1Gw28
 xp0iQD1214jIrnKrQt7QPdX2hqgELu2LnXzHYbRVAj6M8BRJlYBmN/s/DDvExSeawZc4
 4bbjHEXN+4PW3624EKF/aqfQhc1SFU+DbpRYlqwbgm6Z8t/KyUUZ+P5yYzGp4JkADQAQ
 mDPWj5Arp5uabfy8yby29eH6KbL6uuSUWeE3xAjZkdR1iTjGv0k72FVcx43Hz33JumDG
 dvL86nftvA9b6e+iKuct/4bEFbHfkMf/KwhsRE6D5SCAhmX/FzOKFFvjgcqDwMMmRV0/
 /SIA==
X-Gm-Message-State: AOJu0Yx7ySss6jkot/yx0kT0fa/Z726FecUXddD06vfmwZJMD7XCSCE6
 LDT2bz+PsJVIArVXqjlJhHLkaPqWiqtgDk1eecZy8ElAcG63HqgLUNeq0Y7jDHuKcjro8AdhR3Q
 K
X-Google-Smtp-Source: AGHT+IG/O8yf92G5TRqkc3SyUxMxpg+75yVqL8LwGvI3x36DGxLOG4lAfYcVtQRamGevs6FLK/Zk1Q==
X-Received: by 2002:a17:90b:230f:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c93d2d18d8mr14683731a91.21.1719945901680; 
 Tue, 02 Jul 2024 11:45:01 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8196sm9257394a91.49.2024.07.02.11.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:45:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 0/7] plugins: access values during a memory read/write
Date: Tue,  2 Jul 2024 11:44:41 -0700
Message-Id: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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


