Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDECC2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQAqw-0002BW-M1; Sat, 06 Jul 2024 15:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqw-0002BD-36
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqu-00044G-6X
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1faad2f1967so25684035ad.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293222; x=1720898022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yiu73V50jAJTsEZIryPpO9LavvIbxV5Ey2NeXSRa2vA=;
 b=bNTnKcXrywAk4QTCz/Ajce7s8KoG3N/2kLvtIKcY2QQgvVHRzjhcALzFVD2JysRrkM
 nXlxekCBSeAwdBmub4RopQReO7dpo2sQvLtjMAMQSQyW9AxqU0zbT4TyW3Nk2bsEnjxK
 Ct/WwXE2XNW7Pn6NywEh3bs9lAJeD49dWN/aA8OuLEKUG+ejF74AMnC6J3Oy6nC3pLbs
 jItL3NIvaEDWmTXeYaTHRuLmhYa88zvWC+h53/1LWhGzfsB8QXfDJzkl6X5H5C1UDUJv
 9wqbh+984T84gHWVkHrWf4yyDQjCLWorRShuF87uJptJdPleu8shM02rFCbpwbfSBbnT
 oT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293222; x=1720898022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yiu73V50jAJTsEZIryPpO9LavvIbxV5Ey2NeXSRa2vA=;
 b=f/HVMJ8T7iYUjXzkAbgOxob4L7g3p1oWru42LqkCtbiXYUA3Jygom4xatOHBi+zaTV
 3KdZga4/ubG/VoQ8o5wUYgYgESXk1Eem5K++FxYwPqSKcGMTXEaL7vKzCFFPxp3/5PV1
 Vkmhi8B/2DhrNlDvUmNIIskIM0AeN6dAgnTBObjNPlBfrb6bjxJ/aqiEZiNkLe6QOg4+
 AbCSJRVcLmyR7ESV+VKmVsN0jK5WK/qKvD+Sv5giclA+qmtHLCvoBZBWAreR0aOlpmTe
 BP7IXFF8d4jTHUSBVl6utY4A7BZGGsOny3aS+0gaSGXXbpUNapvMuV/iE3DbClHasBwc
 35Uw==
X-Gm-Message-State: AOJu0YzDhFHZCoVcN7XeNl5dZvJ5nG29Jf8a0UOFFUT7dQHzxRregnnT
 C7RfA6TrfgqhUaE8UMjCjM/gJjmB3y5G74IGlsPhgfV7MGVTCmeqqCGipt17vV8tWMimJD6Noui
 7urg=
X-Google-Smtp-Source: AGHT+IGbu+SZS2AO+0wXzn4JSwanCHDUYuGD8FKGx+afdnBpFzxZoFOY4zDey5f2nlD7wwbcLbqmmg==
X-Received: by 2002:a17:902:eb82:b0:1f9:f6c5:b483 with SMTP id
 d9443c01a7336-1fb370a89bfmr125171095ad.27.1720293221908; 
 Sat, 06 Jul 2024 12:13:41 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb6153cb3bsm17304305ad.129.2024.07.06.12.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 12:13:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 0/7] plugins: access values during a memory read/write
Date: Sat,  6 Jul 2024 12:13:28 -0700
Message-Id: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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
Patch 7: tests/tcg/x86_64: add test for plugin memory access

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

Pierrick Bouvier (7):
  plugins: fix mem callback array size
  plugins: save value during memory accesses
  plugins: extend API to get latest memory value accessed
  tests/tcg: add mechanism to run specific tests with plugins
  tests/tcg: allow to check output of plugins
  tests/plugin/mem: add option to print memory accesses
  tests/tcg/x86_64: add test for plugin memory access

 accel/tcg/atomic_template.h                 | 66 +++++++++++++--
 include/hw/core/cpu.h                       |  4 +
 include/qemu/plugin.h                       |  4 +
 include/qemu/qemu-plugin.h                  | 32 ++++++++
 accel/tcg/plugin-gen.c                      |  3 +-
 plugins/api.c                               | 33 ++++++++
 plugins/core.c                              |  6 ++
 tcg/tcg-op-ldst.c                           | 66 +++++++++++++--
 tests/plugin/mem.c                          | 69 +++++++++++++++-
 tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
 accel/tcg/atomic_common.c.inc               | 13 ++-
 accel/tcg/ldst_common.c.inc                 | 38 +++++----
 plugins/qemu-plugins.symbols                |  1 +
 tests/tcg/Makefile.target                   | 10 ++-
 tests/tcg/x86_64/Makefile.target            |  7 ++
 tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
 16 files changed, 455 insertions(+), 34 deletions(-)
 create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
 create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh

-- 
2.39.2


