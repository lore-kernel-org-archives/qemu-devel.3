Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B2D715E3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiO7-0004L0-07; Sat, 24 Jan 2026 13:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO5-0004KR-Ml
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:33 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO3-0003cM-Vw
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:33 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso1785885b3a.3
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279369; x=1769884169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6/3SCHzxa6OHH2ekb2alqt7GMnbKXy8REhsKJuShvps=;
 b=RPULwDq/Nbsd5l7Ql8Bl9TUxPWftjPbU1L33RJstVqrCLr7yMVe5BdioTLpDxrIlaa
 22N1Z8JkvuN9qfd7SIUP0tUCT/wabcMQmTrgxdCN9Fw6TWGf/BSVf/LWo6DhJ76lZF6+
 gv8Vc5pi83ksjLy7xepx2flvsp2M2hauPSKKSUMESlA/CUP7qcc7t0L/iePv4InDV5Xc
 9SxpQpsteSpj8OdqiPeQtS20bSbc4MW6qucnSbBQzIv1G7kNqHW90Pl65DB+yCcyCXWW
 wa55dP7B6WzYG8W+WVI4ASGhnZK/GlKuMXjdX05K2J9T5sO/kfFKrDazUpUMu21MiPTg
 2qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279369; x=1769884169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/3SCHzxa6OHH2ekb2alqt7GMnbKXy8REhsKJuShvps=;
 b=gadRqP0cTMTFwF7qSHP09O2spTifE86/3jG8SOgjKucz5toZux5q4j8YzjLFjrvnR4
 PhiFtjSumE1f1l052aog+vyuXO87EvewDsmJrbqMDazhkieyM/QZyiX8br1se5zoln7v
 rI9mDaELTii5/HyqPA+1Zjc3H419JorARdskABs0Xu/AukY+sWJuUEpZBVwpKwo6YM+8
 DrTgQJG4H6uyMGRWi9Fp27TySsZDMsImVDIIKAgDHe9qcSQ51gjF8De3ZXQg62fH5WZE
 cSy3eF+lZWxbaa5vWdxVkfFTU2O5TARU3QKYHAaapkA+G3vYi/2Efb3sfOKwhK7FJiDJ
 s7tQ==
X-Gm-Message-State: AOJu0Yx2ms2UGtKf5a89GwTo5vF9wzhHWBCmcu/0p/aDuwP/bpf5kZ30
 +kJCVppuRecQWmCwVoLO1YGsVcDHdfKU5h3rhBeYwrpqMp1u5izCx3D7hFuKVQ3fO4SaaiOcVGu
 UmhB0o9M=
X-Gm-Gg: AZuq6aLYuS2X3C37AS/9LdrbK8brdJejYB0oieP1dRQDPDGAv7aFPTsA38pgWY/vKNt
 1v2f+WNkrcwlnuF9UfF1CMIYbQNIclgFX1aq/irZ8t6sdjMIbgGLcBMLobR6BNFgKytVjOUV/TV
 B35oM6l/XelMRDuZ2mf5VPztHhdRupemUquel4exLwWpDVPHQ2jyExx05HZuWTbXrF+oSOqsIj4
 S7KLJhjoCiOhXtNMruXUrwrRFWaqA8aDtE0nIOEvpMOO5cHm7+w0YA00vZC8DAMPvpQ4i8B9Cg0
 XyYyQu/tA99SyEKLeiMtY3VAyOfoqmeUwOgUxzdEjp73EdmKVp1n7XdxoRuLwLQBePo0fm2gf1E
 DOriGMXeYxDTOInLDF1piCVYt66uO3hhJoC8df2hYwOTO5fvcM1uEQSEtvLn/ZPFi+6S6dR8V+r
 CtDgQPmDTxWLDyTzuvZr7cm0NlKzS0XuLPxVbq5s6pi/0V3P3vR7OjJVtmz3Zm4jSw
X-Received: by 2002:a05:6a00:4b43:b0:817:9a85:54af with SMTP id
 d2e1a72fcca58-82317e00603mr5959621b3a.43.1769279369535; 
 Sat, 24 Jan 2026 10:29:29 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 00/11] plugins: enable C++ plugins
Date: Sat, 24 Jan 2026 10:29:10 -0800
Message-ID: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Writing plugins in C can be sometimes tedious, especially when using Glib to
keep track of execution state. We can directly use the same C API but write our
plugin in C++, benefiting from its great standard library offering strings,
smart pointers, data structures and synchronization mechanisms.

It's common for downstream QEMU forks to provide C++ for plugins, like this:
- https://github.com/panda-re/panda/tree/dev/panda/plugins
- https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin

Hopefully this will help more people to use upstream QEMU, and as a benefit, get
their contribution back and help to develop plugins ecosystem upstream directly.

This series first cleans up build system for plugins, factorizing details
between contrib/plugins and tests/tcg/plugins folders.
Then, we perform codebase cleanups to fix conflicts between existing headers
and C++ headers.
After that, we can update the C++ standard used by QEMU, to benefit fully
from latest updates of the language.
Finally, we define an empty C++ plugin, making sure we can keep track of
possible regression in qemu-plugin header.

Note: This series is *not* a trojan horse to bring C++ in QEMU
codebase, nor to define an alternative C++ API for plugins. It's just enabling
more users to get the most out of existing C plugin API.

CI: https://gitlab.com/pbo-linaro/qemu/-/pipelines/2242427013

v4
--

rebase on top of master (new conflict with ./scripts/clean-includes)

v3
--

- fix indentation in patch 2

v2
--

- drop coroutine.h rename patch as it's not needed
- drop ctype.h rename patch, and move qemu-plugin.h to include/plugins
- fix mem.c to not depend on other QEMU headers

Pierrick Bouvier (11):
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

 docs/devel/tcg-plugins.rst                  |   4 +-
 meson.build                                 |  26 +++--
 include/{qemu => plugins}/qemu-plugin.h     |  11 +-
 include/qemu/plugin.h                       |   2 +-
 plugins/core.c                              |   2 +-
 {contrib/plugins => plugins}/win32_linker.c |   0
 tests/tcg/plugins/mem.c                     |  59 ++++------
 contrib/plugins/cpp.cpp                     | 119 ++++++++++++++++++++
 contrib/plugins/meson.build                 |  25 ++--
 plugins/meson.build                         |  17 ++-
 qga/vss-win32/requester.cpp                 |   6 +-
 tests/tcg/plugins/meson.build               |  18 +--
 12 files changed, 203 insertions(+), 86 deletions(-)
 rename include/{qemu => plugins}/qemu-plugin.h (99%)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)
 create mode 100644 contrib/plugins/cpp.cpp

-- 
2.47.3


