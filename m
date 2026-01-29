Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D35D46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtM-0000Es-0q; Wed, 28 Jan 2026 20:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGtA-0008Uu-Jd
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:05 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt8-0003Al-Cm
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:04 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-352e2156450so175025a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650321; x=1770255121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZctqSppWns1zLh31eFRQsbIoY++9vlsorD7HNDzT7s=;
 b=GDmeh77vX2r29//ManOyhKXv3OKHgPoxocdmoIf2lGouY33YnLvd9ib9k1jDMnLqJe
 qLkE1QoNBPqxzlsLG6QFyQhQ6r3geWwxuq8qpj4fc8PInp0x1eo7AcsJ68oA5BNaKQ5z
 tOKemnsDms+9D1NKS7h2Am8StvT37vpWkxKpWSmxNDvJFrrDZ0dLmCxkN+5UyEIscXnt
 WCab8PwYHtbFJBsVfX6HbdiWGGpiY7xEBdWvJYhOMes/91GDS1czDb29rY3geMx5bgmf
 9TFrDw9iVSfShEUfj5HMwjUW3qH93KLLjKn+Y8O4LjOCwBBevQCpdtAWK2SLR6KWw5y6
 vQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650321; x=1770255121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZctqSppWns1zLh31eFRQsbIoY++9vlsorD7HNDzT7s=;
 b=Wf6KhHa66Fk5duJ7lSfKR5ROCfGx8aVY9c3PN9krpmdnG2blNMohollBwm4bOMO9xf
 qo54w63RyrF9flNdSIlWdigunhTbvmfRmw4lHfkBbba3gRM+PW4Nvu28OVfyHnPqJEUl
 XtjI0qIfBQD014mqLwBo+yMIar/QTM4UVWthh4XXiILOMRefpuzOBYSj130fUzUBA3gG
 HnLgMjeA8kWYDN5odB8gL+YubN+Bt+pDQqEBJF5lhBdvhIsgU2lNHckPSIp+qa8l/9aB
 f27vgdjRMeF6eFbwZ9ueC8Q0OLZRXYitxd7Gh7onkg7LafYnpc4V7GZgTZ/FyYqQZstE
 AkJQ==
X-Gm-Message-State: AOJu0YxiQguxKh9RQbvpCpwsbWulVkTQu5U677jzKyHqFOxMXo41Feid
 P8J9FWx0t9ht9n5EB9dBK0NwJDmW500hz9xm5uPVNxNPWvcYVBaIrWdKhx55TOtUcBN2mQFqTYP
 ocdIw
X-Gm-Gg: AZuq6aJii4QfjUFB1T5JkPLTohTKJO0MUevb2K/6I44hg0ChWsh9tqyX7/SQjhZxdY2
 7rwMqPniN2dkA22qwTQ+l8Ft0XJfldxFEALLCPxXpx8DH64Wb6pcu96WFhSJeQHDDX2TP20wHL1
 KnaCO9B6yAaZBhokS+7XDpL5RljnWAG/ktyuA+W9G3BrByZcwnwQkuwe1o0mzHH1Kv7ybZoG9so
 WCxcZXw6FdPDjnQpET/tHzGSByqKM9zyfn0kYD94W9E8bq/pf8udIkl5kBuAlhZXcjv2jRT0Phm
 plAjVo3uqcGLwQGduth4PvP4bKJ7qknnNDxv6Su2qR/BMRZO9tRpaGebIURNG80+keobjUuwYSP
 DDcs+DM4g7oRCPhCWzloJbPLYzoGCwg1pqxwBj7I/b51tQm11AJfLCzT5x8ukrpG+DWf50uT7oY
 JLUf6qI4PziM4cMDrf0hEvmsRbelowDqq20ieOzKoGlqWjNY6GlHRLMdOKVFy0WQIU
X-Received: by 2002:a17:90b:3d0b:b0:340:be44:dd0b with SMTP id
 98e67ed59e1d1-353feda18a2mr5377470a91.34.1769650320822; 
 Wed, 28 Jan 2026 17:32:00 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:32:00 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 19/20] contrib/plugins: add empty cpp plugin
Date: Wed, 28 Jan 2026 17:31:33 -0800
Message-ID: <20260129013134.3956938-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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


