Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AE7D715EF
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiOG-0004QM-SI; Sat, 24 Jan 2026 13:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOE-0004Pd-Rt
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:42 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOC-0003jZ-Su
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:42 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so2707408b3a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279379; x=1769884179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZctqSppWns1zLh31eFRQsbIoY++9vlsorD7HNDzT7s=;
 b=Y25GI6v7WcOMZU3bdWjHbfUGcWivRwb9p/A0m/L7uDV5yKbUlA3X52ib99K7l3KwUZ
 jv2OYofp0g4g40m8UkL12rw/5JPTPO/v7k5z/gE09fJ22nXwiruH9Cf4gadQUV1mq2Xe
 pY99VGVAJaQKcBAG+Wo2t+hQwhUTm9mkp4IHKo0scQgZCTg8RYPuMb1OJEwBH5W4YYJ3
 XOdy9mWUXZSKeMpgvigQLkCMm9myYFaNM2Wn3rTE3PfnJGFng5QlCB/ANfQvCcfJ4fl4
 V+mwFAc3fLGPrb81rMvnn2wTchscONpVl+rj8lPh9iGgxUhjamcXuB4HvZcj9v7tQp5S
 FLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279379; x=1769884179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZctqSppWns1zLh31eFRQsbIoY++9vlsorD7HNDzT7s=;
 b=UxliflYt7TPemPl1hHUEG0Br6eU+iUWvdGdOBpnF5PLxi5bElKDmMhE4R+7fkHpyBa
 1Ta/3ZKOiILrGZnLmZNBG8dD7Pqvof+OHuYDhJIk/UpG+gL3TvRjQRJupWCbDQk/Ka3S
 RG0HMvNpD4PoBNmN+zUM93hRr0twjRxkwB4Y0rhjvdHFuDGgTizUnz1SaylO6R02Iw23
 XAAj/7qpePOgWufc/k5bikSbk3RW8zW/C7cBt4Wui8oE/wJlIlMQt7Aw83xulf5L5ILl
 at7XAQdkoF8zZM4ricffDtqEQlbcROEGj7bZOsgmZ6rfneo3spl1z7EpqZBbqPb5XDfd
 sJTw==
X-Gm-Message-State: AOJu0Yz3EUTM5+yiuDlLBe9op7+X6sThb4b1agxTAGDkzPooi7Whpokn
 7bL06X187Zgsnaz1Ew2AsFGwoRY5V0B7Ssl9x/W3qbo/mjpwkgxn7F/Hz7uCo5vZzW9zF9nL2wZ
 WhMtYsT4=
X-Gm-Gg: AZuq6aLfAdsSX9nAmRYQ29f2PX829eNwlDf4ACeJZKsjjpU607DT3t6l9JQtTO8KZvV
 eK9kQiLPzG/qaqObxAlmlpcWOVgt0n9tSC6OP/zSl7HlFt5i5H20aK6cbdkT3usTyAWZvewkBOE
 s51K2zda0iA5dB8PUn5o/YT+wIb2Ti0L9NCUXIEhyYLK0ufadH76ft63e7WKggNsHWJUOJuWAd2
 B4Oi7Nm/qtSmaR1H34R/M9ZErwq6cgxoN6+h99/hgam0bpdHTPmdL9ReZHrinL1EeYIMyLxc61h
 mX83PJ3qwFSxADbH98I0lyAg8phBBCdpsUR8hL8K6sTP3oC6a1IYuj/njbE//nZkMtP4yvdrAG0
 b4IGCwyZMCAttbvSXhr/g1qzTcA0gUjzXw1EUOqEpJ7Pmii+iUGF3Gp+o/4MO7Hl3Px5zkSNwdC
 CU5KYFgsDuEceVPaeONgMnpTc8+C/twP3s2F/P1njfwLN5OVnz0Y64QuEwt1gPNE/AVAeEHhJyt
 F0=
X-Received: by 2002:a05:6a00:4b47:b0:81f:33a6:e9b4 with SMTP id
 d2e1a72fcca58-82317df1dc0mr5680509b3a.29.1769279379353; 
 Sat, 24 Jan 2026 10:29:39 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:38 -0800 (PST)
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
Subject: [PATCH v4 11/11] contrib/plugins: add empty cpp plugin
Date: Sat, 24 Jan 2026 10:29:21 -0800
Message-ID: <20260124182921.531562-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This plugin makes sure we can compile in C++ while including qemu-plugin
header. It includes all C++ standard headers, up to C++23 standard,
minus the ones that are missing in the oldest environments we need to
build for.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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


