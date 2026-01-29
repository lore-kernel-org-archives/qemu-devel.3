Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B980ED73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyS-0004pH-Bj; Thu, 29 Jan 2026 12:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyP-0004eE-Ka
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:29 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyN-0000f9-PH
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:29 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso729925a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708306; x=1770313106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tfzt/+Tqbqaa8fpLeO7Urmm7clD6CMvMT/txFOKy+4E=;
 b=gEWja8Ottsear4toLT01U5SksuNVqwSm8V2xj2cKNSLBbu+uEg3GnBs0wq/yuOBMJi
 SrhSWcYjruiL52+zPj3R1El71c2UWK0suERnAS1IGgaFmPSLMn0HJAzaZadOVGSFVASH
 gEvhc8SW3d7t+4thcu8XcSNu6oWQujhwqQNzZ7hAJBcfQ5glvhZc0V/DMlsFSQVJsicU
 GOipYsPeNGBBLKwMx/H5QDYEQMOjJFifhWYFiULRqglF9tppzYRCAHONcu64FNYwV+Nk
 LAozc58S7v7mXb5jny0XUPYOkFGn6hb9kbcN3D7eCu/Z7zrn7T/G5kajGt8HzvS5jKZ2
 cHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708306; x=1770313106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tfzt/+Tqbqaa8fpLeO7Urmm7clD6CMvMT/txFOKy+4E=;
 b=hiJpMBRMn3N1pTcJ3Gm05E+JnuQZ1cmKZouUTDIeH6lnV9NPe1/6Hl5FMIaHSnZeaD
 ni7teyFlWxUIxiSlGcLcZsoMJ1DcE8Id4C/0inZFin2QiHo8n9aiooeJxigg7grANCc8
 s4FdcYo56pde1Y9FJ8t7wzik61ln32dW/wwaHnYJEZDV8ReQxzGiIR1xH0KH2USq5Ig4
 zq0kDBqYUR1PgPxrNW4CjzPPGYnXVgnF2WWozmY0vfGrrkDEG+C9wMqzyHb221YiKbvs
 jYPxW5akqZW45dSF0geUAiLqlDPo0IU7dvdRqfWx1F+VIR/Qt5akZvyPiK4krWijTunI
 Q5Xw==
X-Gm-Message-State: AOJu0YxVi2OTRRCrSOnh5OpqqTOivk9tlnrgs5v2xJN/Pfp6g7AH9RvA
 0MMV+wT95uxT8FbovB2LYezgwjQ5DE6tQGtIVBIJcSgV3ljvaaJvRRXnlgUwSwh9oQqhBblVW5H
 Mc74L
X-Gm-Gg: AZuq6aIccu3K3ga7L/X3ENU+oSmGBs10yVKL3HOMvJvHM0DAnphrPlfiiB3KVKGAeHr
 zmniOAHGPQXPigiH5+HxTcStqEa7LeFJAcSA/e7FK3P/Pu9eFTgiIzUXZPAHBpZJftMhDhAC9xH
 A087m6512QQI954BT3Z3iMRf4d0dc2due3s5Q7ZoOBSAkfRzL5fZRg91gTd26Sbp+FHnmdGvrfa
 RsXcSpNo/0VHnLZzbFaK/D2IHHiSOiLCkEon/xE5qq8qpAW8hPAPcf6aeEix02pcodve7XgT70y
 CPJ1Jvyczhgz3c9K5qU6blKQXWjuw7e7VUmvaXfPP1s8H5GhCZp8HBUGH4oxWmQodz8IcBXX4dj
 lWnl9R0EsnaBQo9UZfSFROex5gfGwtFGb8k703KJDS3UkRi5Lkz3/vA7iAAZrp45FKc2U2SMxYL
 XDnPiTL8tsjF0IHtD9iWXiX6nSk4WqHSYui2ma2mg9THSDbIVG+dWLyevfTKps8zyB
X-Received: by 2002:a17:90a:e704:b0:343:a631:28b1 with SMTP id
 98e67ed59e1d1-3543b3161dcmr273290a91.16.1769708306176; 
 Thu, 29 Jan 2026 09:38:26 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:25 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/21] plugins: factorize plugin dependencies and library
 details
Date: Thu, 29 Jan 2026 09:37:57 -0800
Message-ID: <20260129173811.138036-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-3-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  2 +-
 contrib/plugins/meson.build   | 13 ++-----------
 plugins/meson.build           | 15 ++++++++++++++-
 tests/tcg/plugins/meson.build | 13 ++-----------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index cc0dfed0667..82e0188b0bc 100644
--- a/meson.build
+++ b/meson.build
@@ -4450,7 +4450,7 @@ if get_option('plugins')
   if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
-    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+    install_data(win32_qemu_plugin_api, install_dir: 'lib')
   endif
 endif
 
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6f72b2ce0c9..6915ffa5fbc 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -9,17 +9,8 @@ endif
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
-                        include_directories: '../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
diff --git a/plugins/meson.build b/plugins/meson.build
index 62c991d87fc..4318e3a1671 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -51,11 +51,24 @@ if host_os == 'windows'
     dlltool_cmd = [dlltool, '--input-def', '@INPUT@',
                    '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
   endif
-  win32_qemu_plugin_api_lib = configure_file(
+  win32_qemu_plugin_api = configure_file(
     input: win32_plugin_def,
     output: 'libqemu_plugin_api.a',
     command: dlltool_cmd
   )
+  win32_qemu_plugin_api_lib = static_library('win32_qemu_plugin_api',
+                                             link_depends: win32_qemu_plugin_api)
+endif
+
+if host_os == 'windows'
+  plugins_deps = declare_dependency(sources: [files('win32_linker.c')],
+                                    include_directories: '../include/qemu',
+                                    link_with: win32_qemu_plugin_api_lib,
+                                    link_args: win32_qemu_plugin_api_link_flags,
+                                    dependencies: glib)
+else
+  plugins_deps = declare_dependency(include_directories: '../include/qemu',
+                                    dependencies: glib)
 endif
 
 user_ss.add(files('user.c', 'api-user.c'))
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index a6e78438510..d7823704616 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,17 +1,8 @@
 t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
-                        include_directories: '../../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


