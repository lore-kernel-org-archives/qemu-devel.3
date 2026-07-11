Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33573C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 09:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiUI8-0003Vl-58; Sat, 11 Jul 2026 05:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wiUI6-0003VZ-Mz
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:46:34 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wiUI4-0002h1-EB
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783763156;
 bh=FePJtfm0kFlZzj4BpZ/WBEHbETtJ1pu/fD1Zj+iD200=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kapfk4nDtr4EvbyXGJnSbQqgVGzGIEpCj4+pQqYlsIeBItN0cEa93uwHRXhAkSaP2
 8hSAbMjhLD14ZLo+EiDUyvTbyPB4E6QQN0mcbDLNtjhZqACYspz1mYIAQuKhqXc9OR
 FCU1wWF3lhRKSdcvDJ1gbuUiauEW9Wi1//4s3Li0/0AvjsIagSUpXSWWFPkIqiP5Zs
 v97YeoV2oaMrdBgkW4BQoxlcw2oDFM7knjU7/eUVr0uihrSxjpBi0F6/aJ/L1T9TWQ
 UGZbImZq5sX/iBmjAl/piu7ymq1veo+z8z2oXUZZH+nonuhrymxzotsF9V2z7EqU4K
 gOC9krrMR1REQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 8B1982FF3F9;
 Sat, 11 Jul 2026 09:45:56 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 0634A380CA1;
 Sat, 11 Jul 2026 17:45:26 +0800 (CST)
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
Subject: [PATCH v12 2/2] docs/about/emulation: document the dlcall plugin
Date: Sat, 11 Jul 2026 17:45:23 +0800
Message-Id: <20260711094523.622997-3-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711094523.622997-1-functioner@sjtu.edu.cn>
References: <20260711094523.622997-1-functioner@sjtu.edu.cn>
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
 docs/about/emulation.rst | 158 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3b4c365933..b861501e85 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1046,6 +1046,164 @@ Count traps
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
+two ways: the guest build tags its output ``(from the guest)`` and the host
+build ``(from the host)``. An unmodified guest program ``main`` calls
+``hello("World", 7)``, and the thunk makes that same binary reach the host build
+in place of its own. The sources live under ``src/``:
+
+.. code-block:: c
+
+   /* src/hello.h */
+   void hello(const char *name, int lucky);
+
+.. code-block:: c
+
+   /* src/hello_guest.c */
+   #include "hello.h"
+   #include <stdio.h>
+
+   void hello(const char *name, int lucky)
+   {
+       printf("Hello, %s! Your lucky number is %d. (from the guest)\n", name, lucky);
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
+       printf("Hello, %s! Your lucky number is %d. (from the host)\n", name, lucky);
+   }
+
+.. code-block:: c
+
+   /* src/main.c */
+   #include "hello.h"
+
+   int main(void)
+   {
+       hello("World", 7);
+       return 0;
+   }
+
+Lorelei ships a prebuilt toolchain (a "devkit") in its releases. Download the
+one for your host and unpack it:
+
+.. code-block:: shell
+
+   # ARCH is your host's architecture: x86_64, aarch64 or riscv64. This example uses aarch64.
+   # See https://github.com/rover2024/lorelei/releases
+   ARCH=aarch64
+   VERSION=$(curl -fsSL -o /dev/null -w '%{url_effective}' \
+         https://github.com/rover2024/lorelei/releases/latest | sed 's|.*/tag/v||')
+   wget "https://github.com/rover2024/lorelei/releases/download/v$VERSION/lorelei-devkit-$ARCH-$VERSION.tar.xz"
+   tar -xf lorelei-devkit-$ARCH-$VERSION.tar.xz
+   DEVKIT=lorelei-devkit-$ARCH
+
+Build the guest ``libhello.so`` (x86_64) and the host ``libhello.so`` (this
+host's architecture), then the guest program:
+
+.. code-block:: shell
+
+   mkdir -p build/guest build/host
+   $DEVKIT/bin/x86_64-linux-gnu-clang -shared -fPIC src/hello_guest.c -o build/guest/libhello.so
+   cc -shared -fPIC src/hello_host.c -o build/host/libhello.so
+   $DEVKIT/bin/x86_64-linux-gnu-clang src/main.c -Isrc -Lbuild/guest -lhello -o build/guest/main
+
+Run it under qemu:
+
+.. code-block:: shell
+
+   qemu-x86_64 -L /usr/x86_64-linux-gnu/ -E LD_LIBRARY_PATH=build/guest build/guest/main
+
+which prints::
+
+   Hello, World! Your lucky number is 7. (from the guest)
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
+Run the same ``main`` under the plugin. The call reaches the host build now:
+
+.. code-block:: shell
+
+   LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
+       qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
+       -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64 \
+       -L /usr/x86_64-linux-gnu/ \
+       build/guest/main
+
+which prints::
+
+   Hello, World! Your lucky number is 7. (from the host)
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


