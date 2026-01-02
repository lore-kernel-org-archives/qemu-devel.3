Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F31FC6166
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn06-0006hL-85; Fri, 02 Jan 2026 16:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzf-0006fc-0U
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:35 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzc-0000J0-IU
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:34 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c565b888dso13760389a91.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390449; x=1767995249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ox+b8XkntL2j4oBcjnvV6DjCCyAadWFXgpKzPy3YYmE=;
 b=wEkWPSf/7Zui7ePLn9dDRkxcxVM+F4lXfQV/zI3saP7vkZyo4AboOKpOIR56CfYlwK
 COLu/w9+IgPfEmK9oWs3cp8/qkzcaweAOR4IP10LIwcmmENoPwDyLsIDdj7EBMPQEJ2F
 UrDf43pu1T0xAIElcLzECDV+eDenLroZLKeldgjpXDKTgrsFifI0AjHSrChSbfwtB6V1
 lz7kezExRlt3nvfeRWHfbefriGbIryCdGgshrLo6K91GuavlJsBV6/7DJ5/xJEPWEBB8
 qZUrSEiX1d5ThhpYcrmNOxUFNlN/RVj/aEu7YdpL7ImWmgO1HFqglRBrTLlc4Sl2+40x
 uC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390449; x=1767995249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox+b8XkntL2j4oBcjnvV6DjCCyAadWFXgpKzPy3YYmE=;
 b=xKAsLTseRTlML1Wc6hzw9OH05QwJTRkOCSZsF014NQ92DWrMbVZ3rkXI0syJna5cZO
 36YE5rgL/PO0TWoCVhnC7s1d/675GbbnkPUaL82L9ScbsqjUxnBJKyCTQ6S7ZE2bp9xh
 3DU3LagZzDjSRNli5XvMROGOsitDI9n3Tff3rRC3BqaVp/rVF98lzyxzkqOn17VF12jG
 /v1Y4pUH/qf1WYkBE84VSjogKbVq3WVf7Xe98oLFR90uvbm+jtMib27EgxrhYnlJm1Sn
 kIiwqlVwh6ju5836IFH5mUbKMGN56AlQYvHFfOqr9JXy8BuCrd1AD1ac1LKdZECCoDJn
 Ozyw==
X-Gm-Message-State: AOJu0YxWxrX0samB4jo8LSJnfnszbSr+j40+FgjMlEdaZnkfeUzkKrqL
 21SqQSCfnUfUEuRqBXAbfAn7v/8aNwtSgJQ+PUVAgi9SbqXABaw9piBtkTdbL42gBkvm7w5bE0X
 M/HL5
X-Gm-Gg: AY/fxX7rzqGMIO70aajLG/Rf+piBUyYW5tVjKSyk1w5N0XZ1Efzqm6K73EcGUhF4VPf
 gLXBT7LuQvNt0A3XFozmkZ8Fvd5mE8TZ9T1q+ijgj6E3M8ATeDMq2pNnhRF+LT6CB6KDElrachE
 VEuFV2MEp3f5ojNqkoBKhFMDgJiGZg2fBi2CnqIUa9gjlGUbWgw/kh6GFYtYY96U+devMsTj7Lg
 1gNNnHAGCKEDIsXzfbcs4hR0EbMp8A4O3rGNdEOjAsB546Ev4KsBe1WFvMv7gnBxMt2JhGQHSNJ
 NpqEniB1/3eilwqKIWwLc7qOYG5aqK/HPzo2xGMkw0CWfGWIMOIwzPVCKAOYOaHfyPhzYFvCshH
 DSBGyhiZeYkFgNRAKzIpnGI/78OHZjiLVtPt9kqhYGta1CoruxcQ6SMQR3DNklMD9uYR7QA2Uhu
 +rRhMKW2isLMnY0aKF3DgkOH9YpIOhbBxTolmZS8NEhCB1jF5iNhuXgtjCukgDctZc
X-Google-Smtp-Source: AGHT+IEoR9zoMBRbFehMDWKDvW4+3RcQlDkiuiN8wJxouRu6y3dk3zg7sGLUavlputQJqiNUaxeYMA==
X-Received: by 2002:a17:90b:2ec4:b0:339:d1f0:c740 with SMTP id
 98e67ed59e1d1-34e92130bc3mr32336969a91.1.1767390449306; 
 Fri, 02 Jan 2026 13:47:29 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:28 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 00/11] plugins: enable C++ plugins
Date: Fri,  2 Jan 2026 13:47:13 -0800
Message-ID: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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
 scripts/clean-includes                      |   2 +-
 tests/tcg/plugins/meson.build               |  18 +--
 13 files changed, 204 insertions(+), 87 deletions(-)
 rename include/{qemu => plugins}/qemu-plugin.h (99%)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)
 create mode 100644 contrib/plugins/cpp.cpp

-- 
2.47.3


