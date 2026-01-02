Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A2BFA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0n-0006pz-0j; Fri, 02 Jan 2026 16:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzo-0006gK-Ss
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:48 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzl-0000Kc-HG
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:43 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso13171547a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390460; x=1767995260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=em7lmvjlMGnS3avhi35owKtaVtV9xVpJa0BeP9UCQDw=;
 b=R1KYKm59HdH/Y1KDDouOCcJ4Qp2YyXQQMljMfBM47hkyDLyIr3LB44OTm7WTiLnylV
 PvKqCvUwBzSjl8xx62+YU5S8G4ZZH4NRMJnac1mtSUyTZgdnD8fNzmqTRCDiJIs/X5tp
 0pPuEoAnYbuEh0EI5FLNv6Lf35edBNfu6B04/gj9rEYSEuZqV3XMqxtpwQ0MmSgmKoOF
 jV6gcNsxOnyIKPobAUbeBwSIJeQxK5BRGL8vdSt7Ha+bUTSmxhyG+1VNAkIRh52VQV7T
 NLQagRWwaiPdKu7+yAaZKpjoZv2kY1QCeGsMD1snZpgCSRG+xBJd0coI/aM8dPzTXfyF
 RbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390460; x=1767995260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=em7lmvjlMGnS3avhi35owKtaVtV9xVpJa0BeP9UCQDw=;
 b=IxMu09S7e5QmgwemflChNJUC3Qke1uR590xtmYhs6I4fgNnLBMnF1cNH2vu5ekMYtf
 RT3/X9gLvic9SXXVxyVpqSGFoaUyWGHvaiz/X6K7PLr7JRE9uK9xt7rWMUMAMx11qw1P
 go6zxoHxyVKLU0jINTP6d1okU31P/aaxt2NnFht9kFtKcVV/XJvoa+J4uB6lP4GkrHst
 HF7yI0ZFxFmhiMrWFf2owpl1sZiCEO+lgV12V/DFdhc+fiommu50f/bYTTa+ouDZT/7c
 0tKDClcCENFHP1MMhiGcvWDWTqQzoMYOvou9qwRqsr9AEr7LsAMgtFyphV5V7gAEubXK
 xFMA==
X-Gm-Message-State: AOJu0YzkDX2bR/BIVEYMX4tGsV0sAiqGmJghdMFYWvDQkcxPdb/u7btK
 6m9PFWXeS1EiforeEzu2wde87u8GmYrgw7RnEHWROHZe5rsBA1iBXl7Y2Mbo1D/Gcovu5kKykfb
 Za9Wd
X-Gm-Gg: AY/fxX6jFL22sJ5kTnCXGivzMkBSb0dWhvj0chukdIm+6xXus/ODtGubFr6hpGK9i2x
 CaO0K1Yth8mZx6zV7hCsig1mGMfazCTCZAsM/ickqy/kMoQzIqUZ02XwsKWizf8gW8Mud6slQwX
 ZFfvOB5vz7f6A67of0DizqxQL8KaHD0IBv9yj6JG6eNzCNbwIjGyl/oG+PUmw5Hqr/TUWWHY4DQ
 sc27k8CN3N29I4nxKzR1HzxKCdJ7+Q6HrbygcQ3V+Ec+Jdu0MiapkWaR/2X5KB3kpNNJsp1SPep
 d/tsrskD5mBGca8Pfl6UbxbL1XZFMrQxIgZdH87bPaCGTsXbOslKiFnlDknwqdcJbc+FeIlRHpx
 7eNWpyx8TMGZ56GPv6AxEyOWZIrEuvlztywKqVj8kJTx5PV/lUxDwLJP/MDmqubZquo52sDgA65
 3XFo5Z+PzPI5FLC/uUr++2KS5KplSGuB+v5RkuCIHGI+9EPSb/o7uLsTYUR3tYNq/o
X-Google-Smtp-Source: AGHT+IGJVK3Uz35XkrNJtJ3xeiN504NaAEsJx58PcuOYaLTmUF3N+HtO9Rzg4xPTdx7iT6hq+cbKog==
X-Received: by 2002:a17:90b:2e4a:b0:339:eff5:ef26 with SMTP id
 98e67ed59e1d1-34e921bc3e0mr35556676a91.30.1767390459856; 
 Fri, 02 Jan 2026 13:47:39 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:39 -0800 (PST)
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
Subject: [PATCH v2 11/11] contrib/plugins: add empty cpp plugin
Date: Fri,  2 Jan 2026 13:47:24 -0800
Message-ID: <20260102214724.4128196-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

This plugin makes sure we can compile in C++ while including qemu-plugin
header. It includes all C++ standard headers, up to C++23 standard,
minus the ones that are missing in the oldest environments we need to
build for.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/cpp.cpp     | 119 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   4 ++
 2 files changed, 123 insertions(+)
 create mode 100644 contrib/plugins/cpp.cpp

diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
new file mode 100644
index 00000000000..1ff54896d97
--- /dev/null
+++ b/contrib/plugins/cpp.cpp
@@ -0,0 +1,119 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This C++ plugin ensures we don't have regression when compiling C++.
+ */
+
+#include <qemu-plugin.h>
+
+/* https://en.cppreference.com/w/cpp/headers.html */
+#include <algorithm>
+#include <any>
+#include <array>
+#include <atomic>
+#include <barrier>
+#include <bit>
+#include <bitset>
+#include <cassert>
+#include <cctype>
+#include <cerrno>
+#include <cfenv>
+#include <cfloat>
+#include <charconv>
+#include <chrono>
+#include <cinttypes>
+#include <climits>
+#include <clocale>
+#include <cmath>
+#include <codecvt>
+#include <compare>
+#include <complex>
+#include <concepts>
+#include <condition_variable>
+#include <coroutine>
+#include <csetjmp>
+#include <csignal>
+#include <cstdarg>
+#include <cstddef>
+#include <cstdint>
+#include <cstdio>
+#include <cstdlib>
+#include <cstring>
+#include <ctime>
+#include <cuchar>
+#include <cwchar>
+#include <cwctype>
+#include <deque>
+#include <exception>
+#include <execution>
+#include <filesystem>
+#include <forward_list>
+#include <fstream>
+#include <functional>
+#include <future>
+#include <initializer_list>
+#include <iomanip>
+#include <ios>
+#include <iosfwd>
+#include <iostream>
+#include <istream>
+#include <iterator>
+#include <latch>
+#include <limits>
+#include <list>
+#include <locale>
+#include <map>
+#include <memory>
+#include <memory_resource>
+#include <mutex>
+#include <new>
+#include <numbers>
+#include <numeric>
+#include <optional>
+#include <ostream>
+#include <queue>
+#include <random>
+#include <ranges>
+#include <ratio>
+#include <regex>
+#include <scoped_allocator>
+#include <semaphore>
+#include <set>
+#include <shared_mutex>
+#include <source_location>
+#include <span>
+#include <sstream>
+#include <stack>
+#include <stdexcept>
+#include <stop_token>
+#include <streambuf>
+#include <string>
+#include <string_view>
+#include <syncstream>
+#include <system_error>
+#include <thread>
+#include <tuple>
+#include <typeindex>
+#include <typeinfo>
+#include <type_traits>
+#include <unordered_map>
+#include <unordered_set>
+#include <utility>
+#include <valarray>
+#include <variant>
+#include <vector>
+#include <version>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 3d2d7862e0c..53d52c97967 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -6,6 +6,10 @@ if host_os != 'windows'
   contrib_plugins += 'lockstep.c'
 endif
 
+if 'cpp' in all_languages
+  contrib_plugins += 'cpp.cpp'
+endif
+
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-- 
2.47.3


