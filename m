Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF137FC617E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 12:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc19R-0003ry-0G; Sat, 03 Jan 2026 07:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc19H-0003lp-RP
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:54:30 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc19C-0002dA-Lb
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:54:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso120721875e9.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 04:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767444861; x=1768049661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q9XSJUc9nCcg+H3blZYdyVxZJjCf4XbtgjeWj7veJZo=;
 b=zvOoTVrPW0CC9veWLfu+71GqOM+O0sOftfRaA0ln8ejOFaLrfjvJkoUrDuQz+hch+n
 AD+rlwkeyIvd4ZvYTkgnFwQqc/hgqA97kSeQx1ttJq97SUU+oMtAhaSPTVstduHZDOlB
 ZUkQrvsCO+t0PppSSHZ5WfDPdnYyFLeeTGQ0KCplKK6E/gXxGvkoIC6UTQuvv90A83Sc
 b7s4pGvF3Ieo37aifPZVWVQ0W2C3oGUDLOaDxYvO4nDdhWLBXI9H1yeP+oLuzAH00vno
 kqLup0DUiMbNztRsMiTUtnXxcdig6FZOv427zwahrgtyTsiZo0YFQ+VZEoO0TrJzMHvS
 wUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767444861; x=1768049661;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q9XSJUc9nCcg+H3blZYdyVxZJjCf4XbtgjeWj7veJZo=;
 b=dweefNlqrNnXZ97fcxWOvBi8dvKB/a0LNsPPQlJ2E5FbpYW+T5hAyv2V8nqf+ez17X
 v9A5uSLVW0d+aiu+Uw5Ei33QOcyap+ahovox0X0UtVCvY+hWzPHpooO8hJIMMxQuNPIX
 RtwDruwLb+glBtvkPA4EboC/pCuzDLE935A7xIJuUQjIqHufhbRk5BLulnGBxg1G325X
 O4QDWUQQwnso+YA8AtqvaG7gjK17n3PugiyzHvZ8VlVHqerei9RGMPtw4+hgUBiV6l9Y
 FcHAO/BDZEi+HFNAtZNPhcUYpDtLoEzjapeuUyXMsK4/HYUDHbzPvQP06sFxkRJNDlmg
 c2og==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Zr4SoUwfCeo5k0+sGQlGxNZIVM7ht4LPbXP5vvoA5p9njvanlDze6cMdOQdfJHq6Wn7lT+rmVt5J@nongnu.org
X-Gm-Message-State: AOJu0Yz+VmLUj1+6ckoT81VCgzwEAOZQoGpytPi9o2kDN4gSOtBVDSwL
 0vFhNYreIMli3BynTuESj//EmD2gcuexOqjxZIdhFFm8VQshRM+hPG2yUbgatQJQlgw=
X-Gm-Gg: AY/fxX5NNCkf8xXJ3MzuD+MDH2TQCBPCaGqwWbELNV5t+dQ9CSes9y0xqjpDKRlr9d1
 t8QQqM66pYj865Csoaf4UWGiT3/EgpwrYoo0JLFx/pP6efcRFMvblqDEAauwAsj0FyF18V3DElA
 HTl8ZUNA4xY4zo8CyMQ0ndwfWK8iyhKHX2S9jw8pyly8QOdbaXIjOc9u/2jpQOnY6VWu8Ps2yg3
 GZdSbS5D+RwQNeLarHDS8bHcpyvpsbXoSlEMDRS4gNTezYx16rcb2S4Ex/OAqGd8yUzUHkEu1OU
 crO/TNXqIvpB231bTnCAkBrdJjysLKSsWB3frp8ImhYdYkwsjJdLkQRxnLSJPD0Mof5X2ZekfY6
 nyIWQeCN3AkfmugVoPAB3KzWcBOaKHN4PVMws+2gQ84aeP0s++R9HX7F+TxOG7esnkvyA8FLD2i
 AUAtcifAnyly8KttNfTBQWZLn9+sHvSGieSPtvBkJ+odUe909EYA9pZCTMbry2vlYi+qgKqQ==
X-Google-Smtp-Source: AGHT+IGIA+QGqHAoRrFshv6HsqOOrMlv0/F0qSUs6k/8YVUvLJcHy/eU7AvryjDqq4axq8rwGcNnSA==
X-Received: by 2002:a05:600c:c08a:b0:46e:1abc:1811 with SMTP id
 5b1f17b1804b1-47d197f67edmr412303775e9.27.1767444860981; 
 Sat, 03 Jan 2026 04:54:20 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm89570848f8f.35.2026.01.03.04.54.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 04:54:20 -0800 (PST)
Date: Sat, 03 Jan 2026 14:53:26 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 06/11] plugins: move qemu-plugin.h to include/plugins/
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-7-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-7-pierrick.bouvier@linaro.org>
Message-ID: <t8ah6i.frhxgsp2bzew@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>This change has two benefits:
>- ensure plugins can't include anything else from QEMU than plugins API
>- when compiling a C++ module, solves the header conflict with iostream
>  header that includes transitively the wrong ctype.h, which already
>  exists in include/qemu.
>
>By Hyrum's law, there was already one usage of other headers with mem
>plugin, which has been eliminated in previous commit.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> docs/devel/tcg-plugins.rst              | 4 ++--
> meson.build                             | 2 +-
> include/{qemu => plugins}/qemu-plugin.h | 3 ---
> include/qemu/plugin.h                   | 2 +-
> plugins/core.c                          | 2 +-
> plugins/meson.build                     | 6 +++---
> scripts/clean-includes                  | 2 +-
> 7 files changed, 9 insertions(+), 12 deletions(-)
> rename include/{qemu => plugins}/qemu-plugin.h (99%)
>
>diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>index 9463692c411..f48c32bd844 100644
>--- a/docs/devel/tcg-plugins.rst
>+++ b/docs/devel/tcg-plugins.rst
>@@ -166,7 +166,7 @@ Plugin API
> ==========
> 
> The following API is generated from the inline documentation in
>-``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
>+``include/plugins/qemu-plugin.h``. Please ensure any updates to the API
> include the full kernel-doc annotations.
> 
>-.. kernel-doc:: include/qemu/qemu-plugin.h
>+.. kernel-doc:: include/plugins/qemu-plugin.h
>diff --git a/meson.build b/meson.build
>index 3d6c6c702d0..a8fd8e88225 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -4495,7 +4495,7 @@ endforeach
> # Other build targets
> 
> if get_option('plugins')
>-  install_headers('include/qemu/qemu-plugin.h')
>+  install_headers('include/plugins/qemu-plugin.h')
>   if host_os == 'windows'
>     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
>     # so that plugin authors can compile against it.
>diff --git a/include/qemu/qemu-plugin.h b/include/plugins/qemu-plugin.h
>similarity index 99%
>rename from include/qemu/qemu-plugin.h
>rename to include/plugins/qemu-plugin.h
>index e44f863d839..78872716246 100644
>--- a/include/qemu/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -2,9 +2,6 @@
>  * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
>  * Copyright (C) 2019, Linaro
>  *
>- * License: GNU GPL, version 2 or later.
>- *   See the COPYING file in the top-level directory.
>- *
>  * SPDX-License-Identifier: GPL-2.0-or-later
>  */
> 
>diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>index cea0a68858b..cdd4f68c0c1 100644
>--- a/include/qemu/plugin.h
>+++ b/include/qemu/plugin.h
>@@ -8,7 +8,7 @@
> #define QEMU_PLUGIN_H
> 
> #include "qemu/config-file.h"
>-#include "qemu/qemu-plugin.h"
>+#include "plugins/qemu-plugin.h"
> #include "qemu/error-report.h"
> #include "qemu/queue.h"
> #include "qemu/option.h"
>diff --git a/plugins/core.c b/plugins/core.c
>index b4b783008f7..3f66533d749 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -15,7 +15,7 @@
> #include "qemu/lockable.h"
> #include "qemu/option.h"
> #include "qemu/plugin.h"
>-#include "qemu/qemu-plugin.h"
>+#include "plugins/qemu-plugin.h"
> #include "qemu/queue.h"
> #include "qemu/rcu_queue.h"
> #include "qemu/rcu.h"
>diff --git a/plugins/meson.build b/plugins/meson.build
>index 4318e3a1671..34643e2cea3 100644
>--- a/plugins/meson.build
>+++ b/plugins/meson.build
>@@ -3,7 +3,7 @@ if not get_option('plugins')
> endif
> 
> qemu_plugin_symbols = configure_file(
>-  input: files('../include/qemu/qemu-plugin.h'),
>+  input: files('../include/plugins/qemu-plugin.h'),
>   output: 'qemu-plugin.symbols',
>   capture: true,
>   command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
>@@ -62,12 +62,12 @@ endif
> 
> if host_os == 'windows'
>   plugins_deps = declare_dependency(sources: [files('win32_linker.c')],
>-                                    include_directories: '../include/qemu',
>+                                    include_directories: '../include/plugins',
>                                     link_with: win32_qemu_plugin_api_lib,
>                                     link_args: win32_qemu_plugin_api_link_flags,
>                                     dependencies: glib)
> else
>-  plugins_deps = declare_dependency(include_directories: '../include/qemu',
>+  plugins_deps = declare_dependency(include_directories: '../include/plugins',
>                                     dependencies: glib)
> endif
> 
>diff --git a/scripts/clean-includes b/scripts/clean-includes
>index 25dbf16c021..3fae8e00e67 100755
>--- a/scripts/clean-includes
>+++ b/scripts/clean-includes
>@@ -128,7 +128,7 @@ for f in "$@"; do
>       ;;
>     *include/qemu/osdep.h | \
>     *include/qemu/compiler.h | \
>-    *include/qemu/qemu-plugin.h | \
>+    *include/plugins/qemu-plugin.h | \
>     *include/glib-compat.h | \
>     *include/system/os-posix.h | \
>     *include/system/os-win32.h | \
>-- 
>2.47.3
>

