Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D99BC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDt-0003Lv-UT; Thu, 10 Sep 2026 07:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDs-0003LE-Nx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:44 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDq-0000R7-Sq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:44 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id B330524002E
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040741;
 bh=bP93P09dipTAme7gl+KiC3xZoCNRlCh3u1i9YX+BJUE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=OgG/HHd2on7c6G7dOyH8M7gwyGYOSi+FNjDWbIuaOJCO/Rx+uHQWHK8ur1fD2PPZU
 tac8pzXvolZpucN47q0SoOZob+X5wjtYkXDfS1IxWqtGbw92hjR/m0XMK6fncNKOOD
 y57zVFutftTui8Y5P6YCRmsS+/Ko2m6iGX1OnIBt7uVbRgTmmov5mYOpLV4bPLugn7
 W0RsMOrbTzZ2a8sjBqvfO+VXlzs0MBvZfXE9q3mKrGa32eHHUH0zONYf1Z7X+GG3RZ
 WXi/Ns3bRYhzlaOn51ZTp20o9S5t6V9VMYHW74FTlWP8XeQumLyGeQ3lEeymdMKo/k
 7kJLpclm+uAsw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTc5Jjvz6v21;
 Thu, 10 Sep 2026 13:45:40 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Florian Schmidt <flosch@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 6/7] Add option to disable building tests
Date: Thu, 10 Sep 2026 11:45:41 +0000
Message-ID: <20260910114522.396396-7-th.huth@posteo.eu>
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
References: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Florian Schmidt <flosch@nutanix.com>

There are situations in which you might want to build QEMU without
building the full test suite, which in some configurations can take a
considerable amount of time to build. This is especially true when using
LTO with clang. For example:

$ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu
[...]
$ time make -j8
[...]
[3078/3078] Linking target tests/qtest/qos-test
real    6m43.250s
user    101m15.967s
sys     4m3.813s

$ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu --disable-tests
[...]
$ time make -j8
[...]
[2024/2024] Linking target qemu-system-x86_64

real    3m14.277s
user    33m13.174s
sys     1m36.642s

Add a toggle to optionally disable building tests.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260724135413.1716872-1-flosch@nutanix.com>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 meson.build                   | 2 +-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ec9b05414a..2a12071cf0 100644
--- a/meson.build
+++ b/meson.build
@@ -4611,7 +4611,7 @@ subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
 tcg_tests_summary = {}
-if host_os != 'emscripten'
+if get_option('tests').allowed() and host_os != 'emscripten'
   subdir('tests')
 endif
 if gtk.found()
diff --git a/meson_options.txt b/meson_options.txt
index 292625af08..e3570a418a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -43,6 +43,8 @@ option('gdb', type: 'string',
 # on the configure script command line.  After adding an option
 # here make sure to run "make update-buildoptions".
 
+option('tests', type: 'feature', value: 'auto',
+       description: 'Build the test suite')
 option('docs', type : 'feature', value : 'auto',
        description: 'Documentations build support')
 option('fuzzing', type : 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5a67e59a16..ba3c9de216 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -195,6 +195,7 @@ meson_options_help() {
   printf "%s\n" '  spice-protocol  Spice protocol support'
   printf "%s\n" '  stack-protector compiler-provided stack protection'
   printf "%s\n" '  tcg             TCG support'
+  printf "%s\n" '  tests           build test suite'
   printf "%s\n" '  tools           build support utilities that come with QEMU'
   printf "%s\n" '  tpm             TPM support'
   printf "%s\n" '  u2f             U2F emulation support'
@@ -518,6 +519,8 @@ _meson_option_parse() {
     --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
     --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
     --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
+    --enable-tests) printf "%s" -Dtests=enabled ;;
+    --disable-tests) printf "%s" -Dtests=disabled ;;
     --enable-tools) printf "%s" -Dtools=enabled ;;
     --disable-tools) printf "%s" -Dtools=disabled ;;
     --enable-tpm) printf "%s" -Dtpm=enabled ;;
-- 
2.55.0


