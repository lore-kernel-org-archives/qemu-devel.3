Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C3EC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 13:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgN5E-0006iW-2L; Sun, 05 Jul 2026 09:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wgN5C-0006iG-3t
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 09:40:30 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wgN59-0001EF-HT
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 09:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783258788;
 bh=QXPShsd1shQ+WQVW+VK/qKDB+lGRtn14nS88S8V6BkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fm99xp6YRL0MTwDMfyF/8J+dDqotB3kv+YATehvbuSgcG4PNgWN/7F0tqqVZuj1Or
 /rJqVw39V4iSk4WpRc/JnkeFhn8GVEC1cXzXArcPK2ET11BBXSrIPZ9J1oYia6JTCW
 B2s/ggpagn0vaBJpe777ijppZR7P2hWwtxjXWj/CT2AtszLhIbVnwNJhgKdN8lyNQs
 jnokaB6IsXEb7JPtcHW9HLk9DgSrxuZQ4YDWJucw4sVzyNQcr1y79rc9mRIbGyHFvV
 n7t4mPqzRvaDZX5ezJSEgx8oNo89AXOqbTtFbrgyChDCkoPde2glFXdkOwb+HvDric
 BQzqL96NmgSxg==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 9EB1030012D;
 Sun,  5 Jul 2026 13:39:48 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id E3FE7380C9B;
 Sun,  5 Jul 2026 21:39:47 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v6 2/2] docs/about/emulation: document the dlcall plugin
Date: Sun,  5 Jul 2026 21:39:43 +0800
Message-Id: <20260705133943.113202-3-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260705133943.113202-1-functioner@sjtu.edu.cn>
References: <20260705133943.113202-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Document the dlcall plugin under Example Plugins: what it does, the trusted-
guests and guest_base == 0 constraints, how to load it, and a pointer to
Lorelei, one end-to-end userspace implementation, for prebuilt thunks and a
runnable example.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 docs/about/emulation.rst | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3b4c365933..8528cc7444 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1046,6 +1046,92 @@ Count traps
 This plugin counts the number of interrupts (asynchronous events), exceptions
 (synchronous events) and host calls (e.g. semihosting) per cpu.
 
+Dynamic Linking Call
+....................
+
+``contrib/plugins/dlcall.c``
+
+This plugin provides a dynamic linking function call interception mechanism
+for linux-user guests: the guest hands a call off to the host, where the plugin
+runs native code in its place instead of the guest emulating it. Interception
+alone enables several uses, for instance tracing or auditing guest calls.
+One use is acceleration by leveraging the host's native shared libraries. For
+example, a thunk layer can run the stock zlib ``minizip`` utility under
+emulation while forwarding its ``deflate`` calls to the host's native zlib
+library (libz). This avoids emulating those selected library calls instruction
+by instruction.
+
+The guest issues a reserved "magic" system call (4096 by default, configurable
+with ``syscall_num=N``) whose first argument selects a pass-through operation:
+dlopen/dlclose a host library, dlsym a symbol, and invoke a resolved host
+function. The plugin performs the operation on the host and consumes the
+syscall, so the real kernel never sees it.
+
+.. warning::
+
+   Trusted guests only. The guest can load arbitrary host libraries and run
+   arbitrary code in the QEMU host process. The plugin is not a sandbox and
+   provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
+   default), as guest pointers are dereferenced as host addresses with no
+   translation.
+
+The plugin intentionally keeps the QEMU side lightweight and knows nothing
+about any particular library or its calling convention. Turning a real library
+into working thunks, including argument marshalling, callbacks and variadic
+functions, is done entirely in userspace, and any toolchain can implement the
+interface.
+
+Loading the plugin is all that is required from QEMU's side:
+
+.. code-block:: shell
+
+   qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
+
+`Lorelei <https://github.com/rover2024/lorelei>`_ is one end-to-end userspace
+implementation of this: it provides the guest and host runtimes and an
+automated toolchain that generates the thunks from a library's headers, to
+accelerate execution over native libraries. Its prebuilt thunks are for an
+x86_64 guest, running on an x86_64, aarch64 or riscv64 host.
+
+A minimal end-to-end example wraps a one-function library:
+
+.. code-block:: c
+
+   void hello(const char *name, int lucky);
+
+In Lorelei a short manifest describes it:
+
+.. code-block:: toml
+
+   dir = "hello"
+   project = "hello"
+
+   [symbols]
+   lib = "libhello.so"     # dump its exported symbols from here
+
+   [desc]
+   headers = ["hello.h"]   # parse these for the signatures
+
+The toolchain turns that into the guest and host thunks, and an ordinary x86_64
+program that calls ``hello()`` then runs over them under the plugin. See the
+runnable
+`hello <https://github.com/rover2024/lorelei-thunks/tree/main/examples/hello>`_
+(minimal) and
+`demo <https://github.com/rover2024/lorelei-thunks/tree/main/examples/demo>`_
+(variadic functions and a callback that reenters the guest) examples, and
+`Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk trees and
+the runtime environment they expect.
+
+.. list-table:: Dynamic Linking Call arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - syscall_num=N
+    - The magic syscall number the guest issues (default 4096). Must be high
+      enough not to clash with a real syscall.
+
 Other emulation features
 ------------------------
 
-- 
2.34.1


