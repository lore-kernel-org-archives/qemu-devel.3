Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB87D46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGt4-0008RB-Jx; Wed, 28 Jan 2026 20:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsv-0008O6-JT
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:50 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGst-00036x-S4
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:49 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3530e7b3dc2so289776a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650306; x=1770255106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3NXUDVr77suKUvatHAXzsk9hDy3t8LyJjBWiwWdSO0=;
 b=miPIxoB9cwGuet98hC5LHSJGz4Vqi2IX51JJdZzahBYAz9icZG/Wa0iNyNYrNjxVjs
 MriYGs7MfdfiNXQwXTOcV+rGoc/JmoE+tajSLmvbS4UtwqWGOC2cO0uxMSIRnbhSkBiM
 U8BjOpMTtiDHYqS2KY5DYtwdMBNnPLkGxvIv8Y3d7ta1Vm5UiwfHr/u770cnhxqivVnQ
 /B4Lx5TEIAns9hrlvMC6LJZXK7WDrcXCzm1cZlbZjoM+ubo00gIveFOBL3JD84X++WKv
 QeLi0uFKVjOAiEB9YwTdwLQYL7aZ9PQYgCNQqPL2NSh5K6XNme7WZTdr9zICB/d4za7S
 yWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650306; x=1770255106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3NXUDVr77suKUvatHAXzsk9hDy3t8LyJjBWiwWdSO0=;
 b=QE++Pq+57WvUs3FHtP1Yav4hODv/jDyhorGZlT8oF23GaLP3SituxeP1MQacJp9dwy
 HMSx13y9RofKgedss8ArcZ+ng3E6PODslFbHrll/EVmKaofP0alSPqTnttvgCPAYuqzy
 Pg3iiyniSajKhE6+Qre4jVb9OxCiDj/Go1OxTR+2H7sljGD/6XE2GmDidL2R/jakf4CN
 pC+CMw/VuGxMUVkfgT3bfnG3dhe1yVf4/KQhwBWqsnfrenuldhsrVN0o+s6zwwE1Etdh
 JAWMuYcG3p7fxEafttEFtE7Pwt+f6bypW+gpmeXiULkmZiDQpuxubk9Yx7VuQ7FFXUGa
 NXMA==
X-Gm-Message-State: AOJu0YwLJBED2HpTQX6GuCWIoaMhJlZZgX0poSQVLOif0SgAe/QR/hmb
 nkPYtfwQu3ARXVR2763KQ7LK5ESioQtQE80cl1A8E1T/PeXTaPF2kY2DuuTZ/ukNbHMOCvZE2qx
 pLiy5
X-Gm-Gg: AZuq6aIqCxJPvpqDC0wUSVGWwhToTKl7LlonSBEq0VfKVlgLccOOP7kdBVJi0K/TWPR
 HfJv6/Cyn0jBzJMQBoXhtDPKwyPkBmEoO1QHgjd+YoOel4kSGdNgbOrh1PHzNL5ECtiDd8IuJ8I
 diI1JJwLlTK6lClXvT+ZCI895RdbLYoqRxPhPOmqtVNVrSl3sJ3NDX3HEAHbYi0mrORSrkVuELA
 d1aMM7824nA+vhC9dkifxN71w7inOKaza8NAef9IQpBb6QzdbcTJoelVPw6pszBKM0eV6tWCADV
 LRy0CRo1X/3bRqOqTKngUDFkA5u+Y5c1dHFEgDdq7EDiUMs2TjqPPEx7Z2Wdh+f+zmqjFIVHKwW
 TdBXsocHleSZtqUar87lXGK0z8f6Q7JQJmhalci7+i9T1QL0+24dWzRtHifg93Q6cjouRtWpk34
 wC6qGVmfTK5yP3PIdkRR/QBb67FsjZLCav5dlROmKnOi5PtzBignIEoG/7aVcmrnJtVAwd6TUYU
 VU=
X-Received: by 2002:a17:90b:2ccd:b0:34a:4cc0:9e38 with SMTP id
 98e67ed59e1d1-353fece37a0mr5730738a91.10.1769650306207; 
 Wed, 28 Jan 2026 17:31:46 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:45 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 00/20] Plugins patches for 2026-01-28
Date: Wed, 28 Jan 2026 17:31:14 -0800
Message-ID: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 9ad7f544c696d73ce377bbad83f3cf8b4dd8dcac:

  Merge tag 'pull-request-2026-01-27' of https://gitlab.com/thuth/qemu into staging (2026-01-28 10:04:17 +1100)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260128

for you to fetch changes up to 2ddf77d673174d7a5c9ba0bb855cad664225d7c3:

  plugins: reduce source conflicts in plugins list (2026-01-28 16:41:59 -0800)

----------------------------------------------------------------
Changes:
- contrib/plugins/hotblocks: Minor bug fixes and add limit argument (Alex Bradbury <asb@igalia.com>)
- linux-user: introduce syscall-filter plugin API (Ziyang Zhang <functioner@sjtu.edu.cn>)
- plugins: return bool from register r/w API (Florian Hofhammer <florian.hofhammer@fhofhammer.de>)
- plugins: enable C++ plugins (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
- plugins: reduce source conflicts in plugins list (Pierrick Bouvier <pierrick.bouvier@linaro.org>)

----------------------------------------------------------------
Alex Bradbury (5):
      contrib/plugins/hotblocks: Correctly free sorted counts list
      contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
      contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
      docs/about/emulation: Add documentation for hotblocks plugin arguments
      contrib/plugins/hotblocks: Allow limit to be set as a command line argument

Florian Hofhammer (1):
      plugins: return bool from register r/w API

Pierrick Bouvier (12):
      plugins: move win32_linker.c file to plugins directory
      plugins: factorize plugin dependencies and library details
      plugins: use complete filename for defining plugins sources
      plugins: define plugin API symbols as extern "C" when compiling in C++
      tests/tcg/plugins/mem.c: remove dependency on qemu headers
      plugins: move qemu-plugin.h to include/plugins/
      meson: fix supported compiler arguments in other languages than C
      meson: enable cpp (optionally) for plugins
      qga/vss-win32: fix clang warning with C++20
      meson: update C++ standard to C++23
      contrib/plugins: add empty cpp plugin
      plugins: reduce source conflicts in plugins list

Ziyang Zhang (2):
      linux-user: add plugin API to filter syscalls
      tcg tests: add a test to verify the syscall filter plugin API

 docs/about/emulation.rst                         |  12 +++
 docs/devel/tcg-plugins.rst                       |   4 +-
 meson.build                                      |  26 ++---
 include/{qemu => plugins}/qemu-plugin.h          |  62 +++++++++---
 include/qemu/plugin-event.h                      |   1 +
 include/qemu/plugin.h                            |  35 +++++--
 include/user/syscall-trace.h                     |  17 ++++
 contrib/plugins/execlog.c                        |  14 +--
 contrib/plugins/hotblocks.c                      |  20 ++--
 contrib/plugins/uftrace.c                        |   8 +-
 linux-user/syscall.c                             |   7 +-
 plugins/api.c                                    |  36 ++++---
 plugins/core.c                                   |  39 +++++++-
 {contrib/plugins => plugins}/win32_linker.c      |   0
 tests/tcg/multiarch/test-plugin-syscall-filter.c |  39 ++++++++
 tests/tcg/plugins/insn.c                         |   4 +-
 tests/tcg/plugins/mem.c                          |  59 +++++------
 tests/tcg/plugins/syscall.c                      |  19 ++++
 contrib/plugins/cpp.cpp                          | 119 +++++++++++++++++++++++
 contrib/plugins/meson.build                      |  38 +++++---
 plugins/meson.build                              |  17 +++-
 qga/vss-win32/requester.cpp                      |   6 +-
 tests/tcg/multiarch/Makefile.target              |   7 +-
 tests/tcg/plugins/meson.build                    |  27 ++---
 24 files changed, 478 insertions(+), 138 deletions(-)
 rename include/{qemu => plugins}/qemu-plugin.h (95%)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
 create mode 100644 contrib/plugins/cpp.cpp

