Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECA7FA3751
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0m-0006ps-5Q; Fri, 02 Jan 2026 16:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzg-0006fs-Lq
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:44 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmze-0000JG-1U
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:36 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so11847628a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390452; x=1767995252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAxt9eRCBAnOw0tS+03oIZgAiM6wZWJgVfag7QKOmwk=;
 b=dxjUAZsBCfrzZoNiy855Lg5LOLPvUU3XiRMSHl2TUFBFJVHnb7JJQ+YUQZJpV7rpeP
 spvR2SFb0xg25yQQ6eSART/doqpyHqjZ9vHZg4xFsRD6Nh0e5RLzIkAd5Dy6ACcC40i8
 ewitxjix6+mQoN7BcHoPcDGIop+tvIukR+vPXdWRWs+jV75daUNBmGMhRKWhz4fHD2mc
 WuoKwgGtqqFbPtOwQ25mvP1OQEJ6kga0mV17upLDKKXy2ikUlAQOV3ooRCgOmFpwK5zl
 xUusyXXMVmqeR+zYJ0aEIeu6rdkW3R6esQGK0f5i291VBtzTT7KN9oyzai2OszvBsX0o
 3Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390452; x=1767995252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAxt9eRCBAnOw0tS+03oIZgAiM6wZWJgVfag7QKOmwk=;
 b=SeOKDI2GD9ZjT8mKs/DlmkXJ5aoO2z2thCDYm0ZQUqsz86lhygun6GilRIVRkID0Ot
 0IlH5jXTISWMe47/j0ZlKkUCZyNqyXFFNm4OdTM+hVNnqdyOMmhdeAz8eTnoPggBA1e7
 cns5z+kFl/sU05Pjw5Fdxqtjl0S5lGz6oHwCDT/bueiX4l+O//cUqy5L6hwO+9Kdq8B/
 KymcWf/jdoj31bOc4pedH9uFli1/BsTGxTyBYu4a6vv24vvtgH80eX/jTSs21hJl3aPS
 99lO/oIjR7Jfsey1aTuQYvZJe7EWoaCGMFM8BhvzXP4s8fgJ0B9Z7TeMyGzZx32a0+UB
 RsQQ==
X-Gm-Message-State: AOJu0YxwQEw4UdhbKvoegav8bxvIA/h4sysifNUrQ9IXhXfyYcW+tY5R
 vsC/mvddoInqXXwDywjNBfS/yGHa2jj2RLqbvc4JGffU38z6wW8Q6w5C7mwBN0mX3Dser/DL0A1
 O0PI0
X-Gm-Gg: AY/fxX55M9WmbSkdCbUaLUO/GB/U+9e1oNzxbkzaXd61cZdeXYx5dkB2kNWC4O1QmGA
 AvTBccDw4PtWkZl7gLZLWGFVqR79LMWuzIr6qD/SAcCVZsCFNj3lvAzKr63dk397x8gN5AaFTf6
 vIKxnnnA1AZGR1p2Xcoey9aaNsapiI6x/gD/PEWFk8J9cngN+kuv3mAZ642mL9L34VsV5naL5KD
 66DwNSq5w0UyzyeVGRFzI5W4GMa2OZDI7tkK7h/Fsi+h1Ccj/K+xszBPOOZFPyIMLeVElwtgj4q
 8mlJiyJkYhpkiEAdRaplstsdhPmF1yH5H0h/zbapdHwxyOBmYRAUruI2zpemVJcXoFGRkJqPO3g
 caJj5ynthJxsx0lxhU0b6D46GenRA31HzH65leDxQvzCZIDTathUdy/NrEaSW2svJKPy0zP4uYG
 o1/r0NwyDHA1pMqxuKVGiShnNvOuvA7x4FHIXTAKl5c6OO068WjAmk/kDzDPax54oE
X-Google-Smtp-Source: AGHT+IFb5x5I/sKOn8Gj/HzF2WrqAvEqu7u8OyILPKEpVhhAGcQso0NGdUGvBcGCj05e9JGeaiuLxg==
X-Received: by 2002:a17:90b:46:b0:349:3fe8:e7de with SMTP id
 98e67ed59e1d1-34e921e64efmr35137613a91.28.1767390451938; 
 Fri, 02 Jan 2026 13:47:31 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/11] plugins: factorize plugin dependencies and library
 details
Date: Fri,  2 Jan 2026 13:47:15 -0800
Message-ID: <20260102214724.4128196-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  2 +-
 contrib/plugins/meson.build   | 13 ++-----------
 plugins/meson.build           | 15 ++++++++++++++-
 tests/tcg/plugins/meson.build | 13 ++-----------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index db87358d62d..3d6c6c702d0 100644
--- a/meson.build
+++ b/meson.build
@@ -4499,7 +4499,7 @@ if get_option('plugins')
   if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
-    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+    install_data(win32_qemu_plugin_api, install_dir: 'lib')
   endif
 endif
 
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6f72b2ce0c9..8f9f0257ee5 100644
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
+                      dependencies: plugins_deps)
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
index a6e78438510..c58f2e382ae 100644
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
+                      dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


