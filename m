Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B5DE68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQr-0003mg-Gk; Thu, 31 Oct 2024 00:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQn-0003iA-Dv
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:09 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQk-00052o-QF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:08 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so458988a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347505; x=1730952305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MazmFmRo30op9YnWOmViRpaEpFEJWTUfVA0x4drzOKE=;
 b=MZtrlJvIBG4cWcdTt8pd+KKsdh6m/7r0KO91JCsN8EEFlKH+9zUAJpJnRxug0TnLmR
 wJSMVhs5iv7STZIYrnzzQAvqsF4ilBGISjVVKH2HmRlNmFPdv2g9O+3IIX8DrWl85ovW
 Qmf6pBrZCzGL9cZ3Hj/1uabpZAWELD8G4IBVSRTqVS9N6Sh+k4Ih9/DDMDf8cxwombeT
 +hBCNSxed2p09d6bPXyYgKSqWawdcP8YS4WrZnodWA5U78Q8/caajgvtlOFMXj0a1xa1
 53bLAMyZS9z9EvYCQMLtQ7hgQ7D++g1CPuKnMh4fJVW+DOZz6cT0JpgYYx3Dchu4NJZm
 t42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347505; x=1730952305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MazmFmRo30op9YnWOmViRpaEpFEJWTUfVA0x4drzOKE=;
 b=ltXe29v7fgjdju4osMSJm7OgTplerGx2BxUeZoaXY4DPHVIi2eHmT1pJctlBQkaV4Z
 AKM3usGZPt7Wkyu5m4O3YKr/R/7F3CeZdx2BGWmjlINFkVXoeQ4FB7fse7huZXIpoQC9
 3CmwCsTyY7Gg5NUNf919lYrOmJmmz7ieAwG2hyqZyK9DBM4jSCcAZmhykh6vNeCwCpgR
 vzb2bXnqiyUbxevG2rMAMbHAP11DeDjgcz2a5306M7vU8OGa9KEs4CXFMFDYLRdHlLej
 gH9bRrRr1TP7Pd6ooG0k+J2qrgcevDz5FezCD8UROtU8diF0G9K50fXhNH2aOhzBRim0
 6KVA==
X-Gm-Message-State: AOJu0YzD9tzHjz3OV7maVaktr0hRqinJs3FHWHoL3eHnH7h9hgJReu55
 I3h2gKeSOFbX7/AtV4ftqJ8L6XL3jfs/wc8ocgzKhQNDKpjjB62pE74K7eoswwKag8wsa/pUoNN
 suJTTsA==
X-Google-Smtp-Source: AGHT+IHdmSiRISRG5n+ZBrvve1XtDbfjxHdxnqVkOlXZXDyKbVyjzGTs5AJSO6xJnFkwQjww9CZpeg==
X-Received: by 2002:a17:90b:1a8e:b0:2e5:e43a:1413 with SMTP id
 98e67ed59e1d1-2e93c182879mr2408081a91.9.1730347505119; 
 Wed, 30 Oct 2024 21:05:05 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/12] plugins: enable linking with clang/lld
Date: Wed, 30 Oct 2024 21:04:22 -0700
Message-Id: <20241031040426.772604-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Windows uses a special mechanism to enable plugins to work (DLL delay
loading). Option for lld is different than ld.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  4 ++++
 contrib/plugins/meson.build   |  2 +-
 plugins/meson.build           | 24 ++++++++++++++++++++----
 tests/tcg/plugins/meson.build |  3 +--
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index d0d5dbe1479..fe11570b147 100644
--- a/meson.build
+++ b/meson.build
@@ -334,6 +334,10 @@ elif host_os == 'windows'
   # We use this compilation option instead of relying on gcc_struct attribute
   # because clang does not support it (but supports the option).
   qemu_common_flags += ['-mno-ms-bitfields']
+
+  if compiler.get_id() == 'clang' and compiler.get_linker_id() != 'ld.lld'
+    error('On windows, you need to use lld with clang - use msys2 clang64/clangarm64 env')
+  endif
 endif
 
 # Choose instruction set (currently x86-only)
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 63a32c2b4f0..484b9a808c8 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -12,7 +12,7 @@ if get_option('plugins')
       t += shared_module(i, files(i + '.c') + 'win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        link_args: win32_qemu_plugin_api_link_flags,
                         dependencies: glib)
     else
       t += shared_module(i, files(i + '.c'),
diff --git a/plugins/meson.build b/plugins/meson.build
index 1cc039d29b2..51297582f93 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -11,14 +11,15 @@ if not enable_modules
       capture: true,
       command: ['sed', '-ne', 's/^[[:space:]]*\\(qemu_.*\\);/_\\1/p', '@INPUT@'])
     emulator_link_args += ['-Wl,-exported_symbols_list,plugins/qemu-plugins-ld64.symbols']
+  elif host_os == 'windows' and meson.get_compiler('c').get_id() == 'clang'
+    # LLVM/lld does not support exporting specific symbols. However, it works
+    # out of the box with dllexport/dllimport attribute we set in the code.
   else
     emulator_link_args += ['-Xlinker', '--dynamic-list=' + (meson.project_source_root() / 'plugins/qemu-plugins.symbols')]
   endif
 endif
 
 if host_os == 'windows'
-  dlltool = find_program('dlltool', required: true)
-
   # Generate a .lib file for plugins to link against.
   # First, create a .def file listing all the symbols a plugin should expect to have
   # available in qemu
@@ -27,12 +28,27 @@ if host_os == 'windows'
     output: 'qemu_plugin_api.def',
     capture: true,
     command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+
   # then use dlltool to assemble a delaylib.
+  # The delaylib will have an "imaginary" name (qemu.exe), that is used by the
+  # linker file we add with plugins (win32_linker.c) to identify that we want
+  # to find missing symbols in current program.
+  win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
+  if meson.get_compiler('c').get_id() == 'clang'
+    # With LLVM/lld, delaylib is specified at link time (-delayload)
+    dlltool = find_program('llvm-dlltool', required: true)
+    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
+    win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
+  else
+    # With gcc/ld, delay lib is built with a specific delay parameter.
+    dlltool = find_program('dlltool', required: true)
+    dlltool_cmd = [dlltool, '--input-def', '@INPUT@',
+                   '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
+  endif
   win32_qemu_plugin_api_lib = configure_file(
     input: win32_plugin_def,
     output: 'libqemu_plugin_api.a',
-    command: [dlltool, '--input-def', '@INPUT@',
-              '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
+    command: dlltool_cmd
   )
 endif
 specific_ss.add(files(
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index f847849b1b7..87a17d67bd4 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -5,9 +5,8 @@ if get_option('plugins')
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        link_args: win32_qemu_plugin_api_link_flags,
                         dependencies: glib)
-
     else
       t += shared_module(i, files(i + '.c'),
                         include_directories: '../../../include/qemu',
-- 
2.39.5


