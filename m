Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C80EC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 01:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whdRE-0003U0-TB; Wed, 08 Jul 2026 21:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whdRD-0003Pg-1m
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:20:27 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whdRA-0001uR-55
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783559990;
 bh=GziRZJHGUn10SSqb/0ViEbOW/3rtSVxYLwE1Ud45JtM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EhVIrqzhozxU69YPqKrih0hTKtQg21tPZ/FWMPUoVTToscYEPyrOaX3ai7b8fD/HH
 YtrblAxdsNuRGa81RI6xT7e+c9P49o5H3rmq/eINkKIyDsx+mDA0276H+PtgilRiUc
 VoQD4vb3sn3RIAHH0cBOvvClde1fDep1GZPMBzcLS89eSKE/3aCgYx5ZJx+wJ6fRsa
 W4gdCYqO63P0a/o7v82KgHVhzMmPkgrOI/owCquCqtPfFReWl7/WlKWI3Gzpdh/N7o
 pCgZpJbJB74zqrs2KAiebkbo9N3SRRteM7ADVyWp8ISF2pr/jWBJtrUsyIfmJAu4nf
 3AaBgqfQomYSw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id C02F6300147;
 Thu,  9 Jul 2026 01:19:50 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 33635380D26;
 Thu,  9 Jul 2026 09:19:49 +0800 (CST)
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
Subject: [PATCH v8 2/2] docs/about/emulation: document the dlcall plugin
Date: Thu,  9 Jul 2026 09:19:45 +0800
Message-Id: <20260709011945.282457-3-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709011945.282457-1-functioner@sjtu.edu.cn>
References: <20260709011945.282457-1-functioner@sjtu.edu.cn>
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
Lorelei, one end-to-end userspace implementation, for the toolchain and a
runnable example.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 docs/about/emulation.rst | 202 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3b4c365933..b8fdc88a45 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1046,6 +1046,208 @@ Count traps
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
+automated toolchain that generates the thunks from a library's headers, so guest
+library calls run on the host's native libraries. It supports an x86_64 guest
+running on an x86_64, aarch64 or riscv64 host.
+
+A minimal end-to-end example uses a one-function library, ``libhello.so``, built
+two ways: the guest build tags its output ``from guest`` and the host build tags
+it ``from host``. An unmodified guest program ``main`` calls ``hello("world",
+7)``, and the thunk makes that same binary reach the host build in place of its
+own. The sources live under ``src/``:
+
+.. code-block:: c
+
+   /* src/hello.h */
+   #ifdef __cplusplus
+   extern "C" {
+   #endif
+   void hello(const char *name, int lucky);
+   #ifdef __cplusplus
+   }
+   #endif
+
+.. code-block:: c
+
+   /* src/hello_guest.c */
+   #include "hello.h"
+   #include <stdio.h>
+
+   void hello(const char *name, int lucky)
+   {
+       printf("hello from guest: %s, lucky %d\n", name, lucky);
+       fflush(stdout);
+   }
+
+.. code-block:: c
+
+   /* src/hello_host.c */
+   #include "hello.h"
+   #include <stdio.h>
+
+   void hello(const char *name, int lucky)
+   {
+       printf("hello from host: %s, lucky %d\n", name, lucky);
+       fflush(stdout);
+   }
+
+.. code-block:: c
+
+   /* src/main.c */
+   #include "hello.h"
+
+   int main(void)
+   {
+       hello("world", 7);
+       return 0;
+   }
+
+Lorelei ships a prebuilt toolchain (a "devkit") in its releases. Download the
+one for your host and unpack it:
+
+.. code-block:: shell
+
+   # <arch> is your host architecture: x86_64, aarch64 or riscv64
+   wget https://github.com/rover2024/lorelei/releases/download/v<version>/lorelei-devkit-<arch>-<version>.tar.xz
+   tar -xf lorelei-devkit-<arch>-<version>.tar.xz
+   DEVKIT=lorelei-devkit-<arch>
+
+Build the guest ``libhello.so`` (x86_64) and the host ``libhello.so`` (this
+host's own architecture), then the guest program. ``main`` links the guest
+library with an rpath, so by default it loads that one:
+
+.. code-block:: shell
+
+   mkdir -p build/guest build/host
+   $DEVKIT/bin/x86_64-linux-gnu-clang -shared -fPIC -o build/guest/libhello.so src/hello_guest.c
+   cc -shared -fPIC -o build/host/libhello.so src/hello_host.c
+   $DEVKIT/bin/x86_64-linux-gnu-clang src/main.c -Isrc -Lbuild/guest -lhello \
+       -Wl,-rpath,'$ORIGIN' -o build/guest/main
+
+Run it under qemu. It loads its own guest library:
+
+.. code-block:: shell
+
+   qemu-x86_64 build/guest/main
+
+which prints::
+
+   hello from guest: world, lucky 7
+
+Now generate the thunk from the host ``libhello.so``. This produces a guest-side
+``libhello.so`` that stands in for the guest build, and a host-side thunk library
+that dispatches to the host build:
+
+.. code-block:: shell
+
+   $DEVKIT/bin/LoreMakeThunk.py --name hello --lib build/host/libhello.so \
+       --header hello.h -o thunks -- -Isrc
+
+Run the same ``main`` under the plugin, with the generated guest ``libhello.so``
+ahead of its own on ``LD_LIBRARY_PATH``. The call reaches the host build now,
+from the same unmodified binary:
+
+.. code-block:: shell
+
+   LORELEI_THUNK_PATH=thunks \
+   LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
+       qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
+       -E LD_LIBRARY_PATH=thunks/x86_64/lib/x86_64-LoreGTL:$DEVKIT/x86_64/lib \
+       build/guest/main
+
+which prints::
+
+   hello from host: world, lucky 7
+
+The guest ``LD_LIBRARY_PATH``, passed with ``-E``, is searched before the
+program's rpath, so its generated ``libhello.so`` replaces the guest build:
+
+* ``thunks/x86_64/lib/x86_64-LoreGTL`` holds the generated guest ``libhello.so``.
+* ``$DEVKIT/x86_64/lib`` holds the guest runtime support shipped with the devkit.
+
+The host ``LD_LIBRARY_PATH`` is QEMU's own search path:
+
+* ``$DEVKIT/lib`` holds the host runtime support shipped with the devkit.
+* ``build/host`` holds the host ``libhello.so`` the host thunk dispatches to.
+
+The finished tree::
+
+   src/
+     hello.h
+     hello_guest.c
+     hello_host.c
+     main.c
+   build/
+     guest/
+       libhello.so                            (guest build of the library)
+       main                                   (the guest program)
+     host/
+       libhello.so                            (host build of the library)
+   thunks/
+     lib/x86_64-LoreHTL/libhello_HTL.so       (host thunk)
+     x86_64/lib/x86_64-LoreGTL/libhello.so    (guest thunk, the drop-in)
+
+See the runnable
+`hello <https://github.com/rover2024/lorelei/tree/main/examples/hello>`_
+(minimal) and
+`demo <https://github.com/rover2024/lorelei/tree/main/examples/demo>`_
+(variadic functions and a callback that reenters the guest) examples, and
+`Lorelei <https://github.com/rover2024/lorelei>`_ for the toolchain and the
+runtime environment they expect.
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


