Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9697C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAPrE-0007Ft-ST; Fri, 24 May 2024 04:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPrD-0007FK-3h
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:00:55 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPr9-0006xz-Jg
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:00:54 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6818eea9c3aso504235a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716537644; x=1717142444;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sEnQjjS9flUUpyphQx6EbDRyE52dRZj9hwN6qC25u2c=;
 b=qGvBWkTkQFZnk7lxux505g39egQwHwvgQOBJ96Lfr2nR6WiAPOqYxcqsznilJy6VvK
 NQroSudPYSkdpBGXIPum9YrPkc5+PRlAlO4k2slcwDFnkmKfqM4kWsjXvNXGlpwKn6CZ
 VQ5N/cV0q8oLAqGxop2TUE3fmU/b+sslHYsWHRLCdB6RP1WiWRgOLPc8NmqjWgvVWjQO
 QYQ9pQzSXjzflskAySG2cJKzN2YPwwhtpSnRBsk0OAJVmvC1TfiBrdXXAcZRZnTqR66b
 NBKxYCKKE041zgrutAekoN+2KVBQ6gFMK1Y2cSBR+dCAie+ebbUXnZFnP7xU6FxadKAp
 a+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716537644; x=1717142444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEnQjjS9flUUpyphQx6EbDRyE52dRZj9hwN6qC25u2c=;
 b=vlfmV8fkdStXy3xrkyeqfGvk8wx2bF9kL32NLUZTg09uUM38NN9y9+I8mFuHxLTbic
 uhWHNhjN3CeFKFbxGv250mCrLNgV5n7WVM/m3Gv4MBNG3ZEu/qAkXs0he5e2kLCFMu31
 7nG5RHhtpwzq+86fAOOWwp2s/I0QJxoeUowkTwmYit/Gr9rB8F8zFpc7dA59fqGlbX3u
 y3ExRk0hkj7EVicQ9MbAUEFyVcSkXQXk5fpWjPlR6+7ILkqmnoa93gNNRmbz1OHPMk3Z
 U6KpnfRHIykB1E0UUjQa/x/0lMzOgrFbCdWKEmZYvSHyNYvGljLn4lf93t29FxnW1Qp2
 tZlg==
X-Gm-Message-State: AOJu0Yxi7WHGvxkjqZjiGwJLgj5eOC1bJ0KqaEsGtmmpBdFWmkQuC0Iw
 NWQhI8+4/RP8UgGj62l6OofnKehiDzVfYUG1py7hwe+SCqWgaGWlwY3lMXnyJJM=
X-Google-Smtp-Source: AGHT+IGAUC19dxRHDHb24DZDVMAkBXScVQif3ENAfflfjk/3dJ+jbqCdmmqLuocvvjyyEEbbzAxbyw==
X-Received: by 2002:a05:6a21:3417:b0:1af:d1f0:b350 with SMTP id
 adf61e73a8af0-1b212dc14d2mr1560629637.22.1716537643806; 
 Fri, 24 May 2024 01:00:43 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-6f8fc0598f5sm664732b3a.46.2024.05.24.01.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 01:00:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 May 2024 17:00:22 +0900
Subject: [PATCH RFC 1/2] meson: Pass objects to declare_dependency()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-objects-v1-1-07cbbe96166b@daynix.com>
References: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
In-Reply-To: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-2c6f2
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We used to request declare_dependency() to link_whole static libraries.
If a static library is a thin archive, GNU ld needs to open all object
files referenced by the archieve, and sometimes reaches to the open
file limit.

Another problem with link_whole is that it does not propagate
dependencies. In particular, gnutls, a dependency of crypto, is not
propagated to its users, and we currently workaround the issue by
declaring gnutls as a dependency for each crypto user.

Instead of using link_whole, extract objects included in static
libraries and pass them to declare_dependency(). This requires Meson
1.1.0 or later.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/build-system.rst           |  2 +-
 meson.build                           | 27 ++++++++++++++-------------
 gdbstub/meson.build                   |  4 ++--
 subprojects/libvhost-user/meson.build |  2 +-
 tests/qtest/libqos/meson.build        |  2 +-
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 5baf027b7614..36ad40c76d2a 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -238,7 +238,7 @@ Subsystem sourcesets:
     libchardev = static_library('chardev', chardev_ss.sources(),
                                 build_by_default: false)
 
-    chardev = declare_dependency(link_whole: libchardev)
+    chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false))
 
 Target-independent emulator sourcesets:
   Various general purpose helper code is compiled only once and
diff --git a/meson.build b/meson.build
index d6549722b50d..0e6fa2e4b777 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=0.63.0',
+project('qemu', ['c'], meson_version: '>=1.1.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
@@ -3456,20 +3456,20 @@ subdir('gdbstub')
 
 if enable_modules
   libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
-  modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
+  modulecommon = declare_dependency(objects: libmodulecommon.extract_all_objects(recursive: false), compile_args: '-DBUILD_DSO')
 endif
 
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
                         build_by_default: false)
-qom = declare_dependency(link_whole: libqom)
+qom = declare_dependency(objects: libqom.extract_all_objects(recursive: false))
 
 event_loop_base = files('event-loop-base.c')
 event_loop_base = static_library('event-loop-base',
                                  sources: event_loop_base + genh,
                                  build_by_default: false)
-event_loop_base = declare_dependency(link_whole: event_loop_base,
+event_loop_base = declare_dependency(objects: event_loop_base.extract_all_objects(recursive: false),
                                      dependencies: [qom])
 
 stub_ss = stub_ss.apply({})
@@ -3703,7 +3703,7 @@ libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
                           build_by_default: false)
 
-authz = declare_dependency(link_whole: libauthz,
+authz = declare_dependency(objects: libauthz.extract_all_objects(recursive: false),
                            dependencies: qom)
 
 crypto_ss = crypto_ss.apply({})
@@ -3711,7 +3711,7 @@ libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
                            build_by_default: false)
 
-crypto = declare_dependency(link_whole: libcrypto,
+crypto = declare_dependency(objects: libcrypto.extract_all_objects(recursive: false),
                             dependencies: [authz, qom])
 
 io_ss = io_ss.apply({})
@@ -3720,7 +3720,8 @@ libio = static_library('io', io_ss.sources() + genh,
                        link_with: libqemuutil,
                        build_by_default: false)
 
-io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
+io = declare_dependency(objects: libio.extract_all_objects(recursive: false),
+                        dependencies: [crypto, qom])
 
 libmigration = static_library('migration', sources: migration_files + genh,
                               build_by_default: false)
@@ -3734,7 +3735,7 @@ libblock = static_library('block', block_ss.sources() + genh,
                           link_depends: block_syms,
                           build_by_default: false)
 
-block = declare_dependency(link_whole: [libblock],
+block = declare_dependency(objects: libblock.extract_all_objects(recursive: false),
                            link_args: '@block.syms',
                            dependencies: [crypto, io])
 
@@ -3743,7 +3744,7 @@ libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
                              build_by_default: false)
 
-blockdev = declare_dependency(link_whole: [libblockdev],
+blockdev = declare_dependency(objects: libblockdev.extract_all_objects(recursive: false),
                               dependencies: [block, event_loop_base])
 
 qmp_ss = qmp_ss.apply({})
@@ -3751,18 +3752,18 @@ libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
                         build_by_default: false)
 
-qmp = declare_dependency(link_whole: [libqmp])
+qmp = declare_dependency(objects: libqmp.extract_all_objects(recursive: false))
 
 libchardev = static_library('chardev', chardev_ss.sources() + genh,
                             dependencies: chardev_ss.dependencies(),
                             build_by_default: false)
 
-chardev = declare_dependency(link_whole: libchardev)
+chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false))
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
                            build_by_default: false)
-hwcore = declare_dependency(link_whole: libhwcore)
+hwcore = declare_dependency(objects: libhwcore.extract_all_objects(recursive: false))
 common_ss.add(hwcore)
 
 ###########
@@ -3774,7 +3775,7 @@ foreach m : block_mods + system_mods
   emulator_modules += shared_module(m.name(),
                 build_by_default: true,
                 name_prefix: '',
-                link_whole: m,
+                objects: m.extract_all_objects(recursive: false),
                 install: true,
                 install_dir: qemu_moddir)
 endforeach
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index c91e398ae726..dff741ddd4d7 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -26,9 +26,9 @@ libgdb_system = static_library('gdb_system',
                                 gdb_system_ss.sources() + genh,
                                 build_by_default: false)
 
-gdb_user = declare_dependency(link_whole: libgdb_user)
+gdb_user = declare_dependency(objects: libgdb_user.extract_all_objects(recursive: false))
 user_ss.add(gdb_user)
-gdb_system = declare_dependency(link_whole: libgdb_system)
+gdb_system = declare_dependency(objects: libgdb_system.extract_all_objects(recursive: false))
 system_ss.add(gdb_system)
 
 common_ss.add(files('syscalls.c'))
diff --git a/subprojects/libvhost-user/meson.build b/subprojects/libvhost-user/meson.build
index a18014e7f26f..b3a2a3abf6be 100644
--- a/subprojects/libvhost-user/meson.build
+++ b/subprojects/libvhost-user/meson.build
@@ -17,7 +17,7 @@ vhost_user = static_library('vhost-user',
                             c_args: '-D_GNU_SOURCE')
 
 executable('link-test', files('link-test.c'),
-           link_whole: vhost_user)
+           objects: vhost_user.extract_all_objects(recursive: false))
 
 vhost_user_glib = static_library('vhost-user-glib',
                                  files('libvhost-user-glib.c'),
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 45b81c83ade3..5b18aa4eaeb9 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -70,4 +70,4 @@ endif
 libqos = static_library('qos', libqos_srcs + genh,
                         build_by_default: false)
 
-qos = declare_dependency(link_whole: libqos)
+qos = declare_dependency(objects: libqos.extract_all_objects(recursive: false))

-- 
2.45.1


