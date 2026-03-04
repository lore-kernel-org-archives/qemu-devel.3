Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143AEEB362F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhA9-0005DN-51; Wed, 04 Mar 2026 03:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxh9v-0005AT-Vq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:00:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxh9s-0005J8-DE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:00:43 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6248033W003242
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 17:00:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=EwiIJazzSOLgYbijpSqU7HVDJlPzIFEJX2FTdficBQ8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772611204; v=1;
 b=ke8eP/G2+Xl6jQ+2mYA2nZfBFHwkaNV+z9LRKcSQpLnmiGsMlqQBMjhGammXKI2V
 s+v9Ft2JTLHcezKJYVXYmbW6OzTPX4XPDjDWB86LFKhH+iEt2QQqFOxUpLAOzHpx
 NiNOXeZoV71QbRo5VdmD47Lsa9fZ0nnQ6V+vi8069T1jaX034QgHT/7IicYTBj35
 LaHE/wkOufthMtrIMhm85/A4vAcxm0Bonbj/KsVeywrOSjddmcHHqSLoio4Jb1Kf
 zR4PAv3mplgwxzuBCwLqh9QICKEQG5fCRRXQY5bQxyGi60h2YXjHsg+Ax2rvJoSd
 yvoqG840L0dq0DIHoJ2BVQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 16:59:51 +0900
Subject: [PATCH] contrib/plugins/cpp: Add -fcoroutines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-cpp-v1-1-7d87b975fc1e@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAHbmp2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMT3eSCAt2UlGQjQ0tjc5NUkzQloMqCotS0zAqwKdGxtbUAdxewnFU
 AAAA=
X-Change-ID: 20260304-cpp-ddc219374e4f
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

GCC 15.2.1 requires it:

[67/6111] Compiling C++ object contrib/plugins/libcpp.so.p/cpp.cpp.o
FAILED: contrib/plugins/libcpp.so.p/cpp.cpp.o
c++ -Icontrib/plugins/libcpp.so.p -Icontrib/plugins -I../contrib/plugins -I../include/plugins -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-6 -fdiagnostics-color=auto -D_GLIBCXX_ASSERTIONS=1 -Wall -Winvalid-pch -Werror -O2 -g -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -fsanitize=address -fstack-protector-strong -fsanitize=undefined -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wredundant-decls -Wshadow=local -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /home/me/q/var/qemu/linux-headers -isystem linux-headers -iquote . -iquote /home/me/q/var/qemu -iquote /home/me/q/var/qemu/!
 include -iquote /home/me/q/var/qemu/host/include/aarch64 -iquote /home/me/q/var/qemu/host/include/generic -iquote /home/me/q/var/qemu/tcg/aarch64 -pthread -fPIC -MD -MQ contrib/plugins/libcpp.so.p/cpp.cpp.o -MF contrib/plugins/libcpp.so.p/cpp.cpp.o.d -o contrib/plugins/libcpp.so.p/cpp.cpp.o -c ../contrib/plugins/cpp.cpp
In file included from ../contrib/plugins/cpp.cpp:91:
/usr/include/c++/15/coroutine:43:3: error: #error "the <coroutine> header requires -fcoroutines"
   43 | # error "the <coroutine> header requires -fcoroutines"
      |   ^~~~~

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 contrib/plugins/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 099319e7a173..caa0fca17245 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -26,8 +26,14 @@ endif
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
+    if i == 'cpp.cpp' and cxx.has_argument('-fcoroutines')
+      cpp_args = ['-fcoroutines']
+    else
+      cpp_args = []
+    endif
+
     t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+                       cpp_args: cpp_args, dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0

---
base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
change-id: 20260304-cpp-ddc219374e4f

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


