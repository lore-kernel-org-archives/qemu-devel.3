Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590C9C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWuS-0002qJ-Ol; Thu, 04 Jul 2024 20:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWuR-0002q0-IB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:34:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWuP-00005E-JL
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:34:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so7560105ad.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720139679; x=1720744479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s03RC0K1xp3v9oXRtQJSIBQz5PP4M75DzZJLQM+JcYs=;
 b=D/94udseBlsePXwc47cW7vFHbeBU9cBfRpkEQfIskq20lYv7SbPRVk6qBieOL4vrFE
 gaDNpmjV5O6NLgMlyosKCl7ZNTsePKXSOgvsND7tz6Qsqf/lyeCwF8FDGS5uIqOEtT+J
 okMLt0ugEAYagVOHkKrGPoidBbq7REZxUGT0ibH3BH33+hYA05y40caJcMChOltMaJPt
 wJrc8ie6cM5EzsEPAfv44eaFUIxzO3Zv7w6qmlrmaNDyNiB+/viSIsFXMIJRY8vIhhqG
 7v4y7qPHZyv9JZUzUlaqhDBpOaT6f/R77IRan6jrWmEBWKjDurHVfQtVqGaRJgtadg2C
 sfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720139679; x=1720744479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s03RC0K1xp3v9oXRtQJSIBQz5PP4M75DzZJLQM+JcYs=;
 b=QzxgGUae4RIL3ulvfyXEratzqtuTKvWhH/VDUcyxBfhHj8EAz6GCQbmF1BhAJsFG59
 HY0LFv7yWF5qwvSgVDSqiw+G/GReQ3ZSBJ64aDZEGT0a9Ge3M3t8SmFjvRzeh/LzsQDm
 6JcxqaE8FHgW/hLP/PMXgKya1FGi8HNKDQX0B9f+/VUZXK5kQYJkR20W2wJP+ew3aUqP
 W8xWfToXf+WMrRGAxCuD5+62niK6GskZ1pTCAkdHI/3GYPTs2zeieQAYZoQT/fb85Q4p
 ZIuC69bvOfuepw8YI8WrNYnXPPvP+AoYJ1X82av++SPdlDWZL3bHE/JvEh4i3QbXhop2
 0JEQ==
X-Gm-Message-State: AOJu0Yy7r723ePuqypwsHyunS/tqCCmLDtvde1ZDl2exxp7oMjkTjlSL
 aCkWzZx2hpqVWKBvgLKYwFzvr+hrRN28ZgHrrKHmzyz2JvXUphvYGudLJPcRH0jHrK/1Rl6ojz6
 d9rU=
X-Google-Smtp-Source: AGHT+IHF8ONK11LYsKby0IWJ97HEMf8VIVYzl9W8GINXWHFILeRevfeP4A5R0g2SuSWv5t1CXQTnZA==
X-Received: by 2002:a17:903:192:b0:1fa:f9e1:5d33 with SMTP id
 d9443c01a7336-1fb33ed9f56mr26587825ad.50.1720139678766; 
 Thu, 04 Jul 2024 17:34:38 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1a075616sm39008595ad.15.2024.07.04.17.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 17:34:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/7] plugins: access values during a memory read/write
Date: Thu,  4 Jul 2024 17:34:14 -0700
Message-Id: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


