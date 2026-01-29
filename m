Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F38DD46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtI-0000Bb-Op; Wed, 28 Jan 2026 20:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt4-0008S5-Vw
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:00 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt1-00038d-B3
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:58 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-352f00d0e83so170139a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650314; x=1770255114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+mWfTnpB5o+zVj5uCi6MAntCWjxW6HfhlX1b6nQ+XU=;
 b=p5EWEiG8Hylf8mq8GqqdVCgaJiNrFNxgnHuPWkwPfqDMIFZernP2R8iO2rwv5YmArJ
 QukJvrotXcvjH8JbGg4STDQme4jNVzbwQQxxOMJRSYvdPSe9bbHiSUFybb75GmEUxU/r
 ofUMH1knUBEJRc2adhxW3K4zGfuwFPEbLOslDXMd9+MtH7AthOF7+Au+xqGVk7Gy8Nsb
 B3yvRmxsVJsa4Om3MrCFOY5N84I/dTy4LhU0MavS7BpEDm4gOngST5zpK1JL2XNdT1hp
 FKal0QbqxTxzjD219gd8yN6DnkEiLo+96Mn/DQLyEMgDw8dzM3DCW9NTcHtVyX7AGQNo
 NJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650314; x=1770255114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n+mWfTnpB5o+zVj5uCi6MAntCWjxW6HfhlX1b6nQ+XU=;
 b=WdRMgg4o8KaKVXZM6CmdhOvndjsrR6rmN+JSEMZBxppWMCXDdByMXp7OQ/hYa3ppjU
 0ZGgAI2R5ZEagMYfycgsZBUlDSbVwrM/oRGbBdtMpJWNT5KNRCdMwnKHh8hGHjl+0odL
 JIh0gb3DXF9A/+pPBTgOyn0FBGDjn6dHwt07LSmzQTpIVCNmE0EEtJxWoZ4Eph+5PM3H
 xw4HNHQXItRK95BRZ777GCBXYdMgXuHBdfftRxyWE1vfJg2ld+i7qalMUj77zvofUMby
 9+NnIajsEtcU0a0VUOJXzWs3/+cEkSJQEyvOQMWhty9N1+N7TccOVGqGlKXXqOAtG98C
 /ceg==
X-Gm-Message-State: AOJu0Yz8Am6dJKY+rJV795kG5tHfR6fNulWUXjHBLzJJ1PZaQEtUJKEy
 N1e7iQn2mVuZU787kO/S6aUyFqDh4ShtII1yd/W+Tz+ps8PqBG/GNCynsCEOdFb1YJ4GF8NEa/Q
 ekFN7
X-Gm-Gg: AZuq6aI32YFlTyKNWlNKKlUMSY1YpYwp2QJkXvyJJpXYR2mhVBDu5H/tfjaPVA1QKpV
 I7c/TqTGStPHUnA19NIgJq8UdxRI3qEOiM9StjQ3uVTYc/wx8YkQ87p7o3b466XXiQDIFgZ5auL
 DM2i+u7ty6923oEz2rU+iUM4kF290EfDs5Y2YKhQt2Xpv+IOg1CeYucbW0woXgm8eHRVa22ML2L
 SdQDF1QrId4UiudzI6ZMFK4Gq6T8Zn/TJHVPMsqAHniMcVlKPxcHAn7PCbQ2f5woH+TOoxctOdL
 YAnjCIzsiSenOCFRBp8LzrzcfrxJqVgsyEzOkJvUwK5vSYBDfc2cBGSL5wpEzYh3wXhBzhfIUaY
 TeJRB3u6F1N4HsfxwZsc09ZP+nTPv8rkgEdJWM59R1zj5pHM/c2PSq7oEegsdzP4snGkeCPXFv2
 5WB6VzxAMY92hN66rTAVgVJeC1+bUbVrKEVY6sFkUtk7GaiIJAX3wIvZvnBuFr5VG/
X-Received: by 2002:a17:90b:538f:b0:34c:6108:bf32 with SMTP id
 98e67ed59e1d1-353fedb94b1mr6300207a91.34.1769650313708; 
 Wed, 28 Jan 2026 17:31:53 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:53 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/20] plugins: factorize plugin dependencies and library
 details
Date: Wed, 28 Jan 2026 17:31:24 -0800
Message-ID: <20260129013134.3956938-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  2 +-
 contrib/plugins/meson.build   | 13 ++-----------
 plugins/meson.build           | 15 ++++++++++++++-
 tests/tcg/plugins/meson.build | 13 ++-----------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index 668f1aa919c..402028bb79e 100644
--- a/meson.build
+++ b/meson.build
@@ -4449,7 +4449,7 @@ if get_option('plugins')
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


