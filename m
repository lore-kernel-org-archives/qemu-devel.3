Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7200FC6179
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 13:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc1Kf-0000pk-Ud; Sat, 03 Jan 2026 08:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1K5-0000Zd-BM
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:05:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1K0-0006DW-1h
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:05:35 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so94218065e9.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 05:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767445530; x=1768050330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QqgAj6fln7rKs7/PFoyYY+bWuK1XncGBIEWTKQs3/T8=;
 b=wOZSQhQugTip8UnjqX8Dw1c8YJ0l4RkpPgEWs1vgboVVbQXyj4fi4VkEsPc9ST0XJe
 4RZgfoBQKQmNfBmrvsqp+EQRWUyjTTVgcMtjH7G30gUfDVKD8e3ZOcuvMJ+rpZU9uckN
 Sh+sCay/zlOqihuTiE5xP68MG1+I6FEcjJNSitGX3zRKzsOPT4j3HEeKI45BtoYBLEDY
 4kRIhNnTbyJU/gVCfLCCjXG/IEtPThhNrGPAshYw+xb4tuJ4r6t+B4APPd0m+k42T3pM
 QB2WrHRLlgNlUeeH/VulTsVnWiUdbB2yTyFNsOnh5b35VJHl6TziuPNwgyrK3JKyueZD
 ahfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767445530; x=1768050330;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QqgAj6fln7rKs7/PFoyYY+bWuK1XncGBIEWTKQs3/T8=;
 b=eHgz7vuCl0OSijOw1NW/yElIPHVgQ/emwijY/hvzZO6JqWN5OWeZ7WlzSFkFrhN/pF
 Ywsznk8ay3EnkOht5u42TT4tMeNoNAhqymgZPTZGnnPID+v+6MfGc13cVBLKvldksE/w
 tpvXZjGQltXiIM/5dH5MUv2mi/TXD90QHIwZGgNnlsdF4dMmO8fMFW9+OmBjpPQbFLaU
 9kB8bTvCfnVCFP1TghJVyiW6RScUvrEZcqZWeYX0591a4d61Y6UrZj85Aj95mrM6O8Un
 /aYWQjv+dpRvqf3iRRVpvEkaOqVVXsCU0X6thZssimd037hbKFQSnXHWSjXdlcBkINkT
 jrVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7xwKwmZvwCbAxg89evNGskDguAIdsjKtHdNlyaO7x7Y6aNwt5Ppjzm1r+EKvxgk1ZlztXPliG9mJo@nongnu.org
X-Gm-Message-State: AOJu0Yz695ZZpaqmm1J5CDulDYGp9m2aLHjLIYc0/mMXwLPwg3Tsgo+X
 e5zvJsAUM4NwFh3ienGaZk0Rsv74nrBjLLDZuDV7m/QMyyCgBG/iB1QfEayQBWADyk8=
X-Gm-Gg: AY/fxX7evN7ASX98Bi7RMieeCCDMiaZUxUYoMmKr6DrRRBSPHK/8BHYNo+PoGWWjChC
 17bVX0K4+M6q+90e65y7RmCkPlK31VD50IXxAEfkVEDSnvgbVAvWfPbCUdFdkvzlxBwsQ3Tl1Or
 gByKXhalsgJW8YVnq2P/oMNw6KxsYsYJ+zMcztpC+V9VApOibQOCvLrAaMQmUaUj5aOk8w4IJSN
 LEol1CE2yhsmPQrulU0sIyzJLBvCeu6AwbGr9zxvnQi8BJuoQbz2yGawMlsjt6YeAKSjckcDOl9
 9JNPHK/lozmsEHvkFKD97wgsdC0mPYAn9BGrF8NLk8cS7UGDLS9ZkAl7kk3Ofz+dWbpPhX3nwer
 PXq4/xmVVLRbq98er77lkoK+Chl1UF3V3toSXsixclq7lOtkTMR0OWGwi0tBwlYimUsOYwdWQ8g
 oavQsgtkLUtjLyhedbi/bFEZxhzFsmv7TFMSBOykDjK0f9+D19Yu/xmQx/bn2pZJlLIU4rmA==
X-Google-Smtp-Source: AGHT+IF8WkcKio6ybBiJ6+8V6Yfo44X61b0ypDHhc+35Mg/j7RTzdjUuka/iHZdcSCBjQugeLsPrmQ==
X-Received: by 2002:a05:600c:8b11:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-47d2d273515mr538126345e9.19.1767445530064; 
 Sat, 03 Jan 2026 05:05:30 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d452c69sm44733105e9.9.2026.01.03.05.05.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 05:05:29 -0800 (PST)
Date: Sat, 03 Jan 2026 15:05:03 +0200
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
Subject: Re: [PATCH v2 11/11] contrib/plugins: add empty cpp plugin
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-12-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-12-pierrick.bouvier@linaro.org>
Message-ID: <t8ahp3.j8i64w8mt9gb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
>This plugin makes sure we can compile in C++ while including qemu-plugin
>header. It includes all C++ standard headers, up to C++23 standard,
>minus the ones that are missing in the oldest environments we need to
>build for.
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/cpp.cpp     | 119 ++++++++++++++++++++++++++++++++++++
> contrib/plugins/meson.build |   4 ++
> 2 files changed, 123 insertions(+)
> create mode 100644 contrib/plugins/cpp.cpp
>
>diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
>new file mode 100644
>index 00000000000..1ff54896d97
>--- /dev/null
>+++ b/contrib/plugins/cpp.cpp
>@@ -0,0 +1,119 @@
>+/*
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ *
>+ * This C++ plugin ensures we don't have regression when compiling C++.
>+ */
>+
>+#include <qemu-plugin.h>
>+
>+/* https://en.cppreference.com/w/cpp/headers.html */
>+#include <algorithm>
>+#include <any>
>+#include <array>
>+#include <atomic>
>+#include <barrier>
>+#include <bit>
>+#include <bitset>
>+#include <cassert>
>+#include <cctype>
>+#include <cerrno>
>+#include <cfenv>
>+#include <cfloat>
>+#include <charconv>
>+#include <chrono>
>+#include <cinttypes>
>+#include <climits>
>+#include <clocale>
>+#include <cmath>
>+#include <codecvt>
>+#include <compare>
>+#include <complex>
>+#include <concepts>
>+#include <condition_variable>
>+#include <coroutine>
>+#include <csetjmp>
>+#include <csignal>
>+#include <cstdarg>
>+#include <cstddef>
>+#include <cstdint>
>+#include <cstdio>
>+#include <cstdlib>
>+#include <cstring>
>+#include <ctime>
>+#include <cuchar>
>+#include <cwchar>
>+#include <cwctype>
>+#include <deque>
>+#include <exception>
>+#include <execution>
>+#include <filesystem>
>+#include <forward_list>
>+#include <fstream>
>+#include <functional>
>+#include <future>
>+#include <initializer_list>
>+#include <iomanip>
>+#include <ios>
>+#include <iosfwd>
>+#include <iostream>
>+#include <istream>
>+#include <iterator>
>+#include <latch>
>+#include <limits>
>+#include <list>
>+#include <locale>
>+#include <map>
>+#include <memory>
>+#include <memory_resource>
>+#include <mutex>
>+#include <new>
>+#include <numbers>
>+#include <numeric>
>+#include <optional>
>+#include <ostream>
>+#include <queue>
>+#include <random>
>+#include <ranges>
>+#include <ratio>
>+#include <regex>
>+#include <scoped_allocator>
>+#include <semaphore>
>+#include <set>
>+#include <shared_mutex>
>+#include <source_location>
>+#include <span>
>+#include <sstream>
>+#include <stack>
>+#include <stdexcept>
>+#include <stop_token>
>+#include <streambuf>
>+#include <string>
>+#include <string_view>
>+#include <syncstream>
>+#include <system_error>
>+#include <thread>
>+#include <tuple>
>+#include <typeindex>
>+#include <typeinfo>
>+#include <type_traits>
>+#include <unordered_map>
>+#include <unordered_set>
>+#include <utility>
>+#include <valarray>
>+#include <variant>
>+#include <vector>
>+#include <version>
>+
>+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>+
>+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+{
>+}
>+
>+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>+                                           const qemu_info_t *info,
>+                                           int argc, char **argv)
>+{
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    return 0;
>+}
>diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>index 3d2d7862e0c..53d52c97967 100644
>--- a/contrib/plugins/meson.build
>+++ b/contrib/plugins/meson.build
>@@ -6,6 +6,10 @@ if host_os != 'windows'
>   contrib_plugins += 'lockstep.c'
> endif
> 
>+if 'cpp' in all_languages
>+  contrib_plugins += 'cpp.cpp'
>+endif
>+
> t = []
> if get_option('plugins')
>   foreach i : contrib_plugins
>-- 
>2.47.3
>

