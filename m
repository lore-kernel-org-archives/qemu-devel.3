Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8FFD73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVya-0004zW-FL; Thu, 29 Jan 2026 12:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyW-0004ul-Mc
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:36 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyU-0000h6-SV
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:36 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso749220a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708313; x=1770313113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EW/LvKJOHjch2/WO8HxnWJSGnTjzN/LRcA4NPCUYnkE=;
 b=bSPhYoR737VwwA8eECR56E6JPKXpxTD3T4LuXWepCMlQqKlw8SJYTle2VLUVLK4/qq
 UW28eViK30uzS8N5KYNmk80oy9Z+BcHaVhFsNO1ZtoJODnjLDPki+OVxecSPUMSNUTGM
 +kC22Mu8abaNqSfUbtmVtW02Td7Q+3MF7c4mZd+FGAZk56XIXmwzc5lWSU9rP9KINREh
 2vonDEdJH9OMdaAiODEe1YQA3FFD4KEAIUgx0N3QWmlOkFCSo29HL+sCz0BxSdEJUn4n
 lecHXKvaOttW/hkAFSQiwHelQHRrPJ28e/SLbQUfWJucZ2H44g6xxnadc5TI4frNX/l8
 jEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708313; x=1770313113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EW/LvKJOHjch2/WO8HxnWJSGnTjzN/LRcA4NPCUYnkE=;
 b=v9aR8VhwVLdQp7kEAU8oxcrBw9SwnJxqs9ypclvG8zYhnKJGKgHYxHzhTvAPuuiD9n
 +luG3cZq7RsreEdgwm+YEmRYMcd552ZH2mQkSSLHguI6lXSixn4b6gcydOo7KTU04DD+
 O8SfYKsX63IvI7xcLaXgZu4G8Y5grlQMBGaapAjVmec0l5urvqYVjzD1vIIPWAuN4cnA
 4IGvuMd03rLmUK2EkEFvMp5ymAgvbWqiyfB3HyFUc+WALLEf1ISmOwR/9eeQ/Sztsmm0
 mtNq+a3MbYRFtmvG4ei5Wjf6ldi76F76UgB8a87CeMbdY9I4wS9O5s84OVGyXVni+5jr
 z+Sw==
X-Gm-Message-State: AOJu0Yw8gWvcGYKpywtBASiklW03IEJTjQX5q+Mwnvsxtw6zZSR4UExa
 IhOBLdzbTqAF7Ok+hHdj0Fv9a+0IVfoXJmmDkevkH7u8p6TECtvT7jwGZ05wwhP2Ra8ns6id3Mn
 HI8kl
X-Gm-Gg: AZuq6aJaQsfFPVwonLGPMszznxkjc6Aq4NBNVCsvYB470ls2OlFGR40HOsN5vxpVPd7
 FYw6rRb1vNK6PkoMJcTXNCt0TLT8MF5pz1vw2pJ+B0+tLcBDdj3unD06QamHB6LSC4nSVVr745C
 EiRym36jY6jpACmK8+Z3PCYQZOJrXfXz8M/poCisQYB08fnFtPqlXROwcF8McXmWiYg+qi6tyfD
 juVtz3BN/eRAUagf3v9MusBKVEXQtg8r5kSiy/kk/pecdpBySs7WBj1qMJVNUIINPbUMpxa5L7o
 n0920bHowUzo4RsP5SedfR9Ux34anUtk1K/dYYiE4LPdXWrRD1gk6MvGkmuqKxlRh9T3X+xhR12
 0zT/zYOMBJurUsP+jOAgxKzZfw7BkShdYA800g2yi0kr1Evf4t6E79RjqPafZPlxNOTmX8aqcaG
 UJKL7ezZkx4EXQde6jJUR3nkcCSEyJAwyh740JSz/x6xcuNBB79FfmxRLGKIfPW744
X-Received: by 2002:a17:90b:56ce:b0:341:ae23:85fd with SMTP id
 98e67ed59e1d1-3543b315807mr218091a91.11.1769708313392; 
 Thu, 29 Jan 2026 09:38:33 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 20/21] contrib/plugins: add empty cpp plugin
Date: Thu, 29 Jan 2026 09:38:06 -0800
Message-ID: <20260129173811.138036-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-12-pierrick.bouvier@linaro.org
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


