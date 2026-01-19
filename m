Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF6CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufG-0006k3-Ae; Mon, 19 Jan 2026 14:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufF-0006jv-6c
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufD-0001TD-Ae
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso26686365ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849906; x=1769454706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V2v/o7ivTiK6XgYAFtoIRVlVf/StAOAnl4LyBGW6UDE=;
 b=Vedz1xlutOB2nWUIXvwRVGVStcqqblTQRIbXPPgwJxNhOqqC30VUxT/fqytiOV1V4A
 wpFz7gtxCdoo8AF0dniwgwZoXHNTymWffOb2X010SScZ7im1n9ak455CsOqYxg1DDROO
 x1yWk25Vd5GRjjhqtLkUDLw1WkDc68epNJZ9QR3x5zasGXV2PpHJzscW1aLqEsEt1srl
 0QAIaspQjkxwTMjFSx+jr8G530dVwt3rTWtoOeziwHFoaGHq7Wa4Tq0tem6sKp7Jh8r3
 mHDCtxGjBEbVuC9NsDOkLI0SSUPb5/SwnLvj+wcGo5S3oBThWg+XpR49Id2nBq5pY95e
 clVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849906; x=1769454706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2v/o7ivTiK6XgYAFtoIRVlVf/StAOAnl4LyBGW6UDE=;
 b=dwV4fpSmZYFyNjan/UZvVZ0HmHCYjGXFVQrjrJAKEFas3UvtJhj5JVTMm2zxOHk9Jm
 ZYTSqAbXYFJo7pHPzfpyhLsRvhTs0725wPOsTAR/7LQ1DkZt0G+6F4MHLMos13n83AnO
 imLCBCD/udaUR1IfOhZdksZPVc9t17j11Gx32v7iXykkIhUfbtaqqX6/wjzU4PAx5H6R
 sKbIkXheNegMuhHf8b4L636xNPI/mVnjZxCkh5KAI/7ykVNQF3pJvVkUZS30wOUifVEh
 YRKME0hSNwWv5QK5TgWUKItOsBpXA1tFM/mBxPLWpSt6pATBA+/7XQ2auCHA50egfM5O
 D/AQ==
X-Gm-Message-State: AOJu0YydfXREx/orJXGHsshVlfpEKFBlsPH66AAwWSW9DuGQrqgPwRXS
 fbMalViHTpX94XRta6okp7nMGCRUE/cpOh9z5L6KQxJoM2jF61W1zNNvCn9mhuwsYiFRvZ0usB8
 9Tjer
X-Gm-Gg: AZuq6aLEwHpHGNUNpK9WWY72meX4qu0Q/BOmZzfrYfzjNIEKKfb5uFXNzNCTQ/1m4Jh
 5pFFsT2KqIVLIpBBjRxqsdr19cSJaFx7v5fN/9Eu09Tock4vMnpVYykowX4K7ldLZzRU4RQvhdG
 1RkQw6YdfCEeYgsnHgIgPObVARogaUcIwA+a7XJR2XlE/F8hODd96BlPuna7CCj4DRnH/dypneA
 K7DQSF/pUwmj32Olzoibuapz94CgAqrCy3dgIrplC/IULGrIah6O3+G9RXiKKBAAKzZsPDZgdWs
 YEkbNNcI6BgE58EdRF+fwcqhQ7CGSxsGWfz4IYIOB/Tn24ZAwhZdkJ5tAZhCyWRGsRi1nE2zSow
 D1ySEhnSzblhylolFqaDKd1dS3kl7a6+H+n+JVNpGoNjzNWrQFzzJUi1EkLf0THqi0OSJhdaomK
 HoFewLmEUoWs+m96tsAyk3R9+Z9JDHZej5F1nhUWit99ripBW4VnltZqjVjV0ClW5eoQnqA9R0j
 d0=
X-Received: by 2002:a17:902:e80b:b0:267:a95d:7164 with SMTP id
 d9443c01a7336-2a717808c2dmr104104645ad.60.1768849905489; 
 Mon, 19 Jan 2026 11:11:45 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:45 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 00/11] plugins: enable C++ plugins
Date: Mon, 19 Jan 2026 11:11:26 -0800
Message-ID: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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
 scripts/clean-includes                      |   2 +-
 tests/tcg/plugins/meson.build               |  18 +--
 13 files changed, 204 insertions(+), 87 deletions(-)
 rename include/{qemu => plugins}/qemu-plugin.h (99%)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)
 create mode 100644 contrib/plugins/cpp.cpp

-- 
2.47.3


