Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7E5C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJER-0006TK-94; Thu, 04 Jul 2024 05:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEQ-0006TA-IB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEO-00086U-Ep
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnnCivhT0ap8CZRVGgoMYFRLkUzpfV9z/OQ32askbY4=;
 b=XfIuYtMb1lbnDw/yTt6g+/njEyZpubXIqjvsR+DshyTeo3TQif+uYFzRISwvZwoYLATFMa
 MT/yEKoH3WSaDc9a73+rmreiPeWkF5pNOM+e11Q30Mh7PZmDgcnMwvgFTVQekVwVsVrM5j
 1sqG3araNClqykGgbRuDhHbDaci/FKI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ic78V3bTND2dOGGH9_UDXQ-1; Thu, 04 Jul 2024 05:58:18 -0400
X-MC-Unique: ic78V3bTND2dOGGH9_UDXQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4255f94080bso3263125e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087096; x=1720691896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnnCivhT0ap8CZRVGgoMYFRLkUzpfV9z/OQ32askbY4=;
 b=e0fn0VMRQvQQ1iPPOPdVlU+AiDgU1/JGIORqs+7MQhud34xzf/g3WFHrcWCD8LCwPg
 oaBVwiJkOWJW+trG46zzjFoWD1EUOeODRb8rQoMUtDkHtTWlzi65cCTBWM9gdWfcIhJJ
 HiT2CqZ3Q4Gup5rU0Sv2jFsYujCPE4exoYL1AHE5hm2gPfnEHAtL6wc4ewXxp/6nEIUP
 gvrnatKGV+B6ites/Kw2pvmVajJIabdr6yv2E7gvhn+EIferFOWzbsyQPcKEzJpDLRGo
 yJ5NsOIXEBEOJZ3me/IsBrHqEzJzMVPRjPxA3jekX8DedRZwBliOvFl5NpBip3VdsI23
 ivQQ==
X-Gm-Message-State: AOJu0Yw7M8d2mPKxZDRg31cW4Hs893WxYVr/P1ZWBu489oco5h9tz22f
 aE5M1wWNRypcJslyRHMULHE1fK3zk2BRxjIYdb/GrYygJO7coVAv696qdgkuJcfc4fvH8FGbGcF
 VmW3iW9KN5KOm6x6nD+6/WIq7L9QqrdsYiwW5L1OZy0lR+oqWK7VhWZ3CvM1Na5ZW1Vgg7SRtDW
 sjOJq72LgngCc5HTyiRY0KVY7srnIvQbmkdO+l
X-Received: by 2002:a05:600c:3b9d:b0:425:692d:c728 with SMTP id
 5b1f17b1804b1-4264a44d288mr7666325e9.28.1720087096248; 
 Thu, 04 Jul 2024 02:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbDRMZzyyIEGrqlxSvsovBAHzv8F98LziwRAEZ0je/R+LYF6z4SmfPvobgeaecBPilUgp40A==
X-Received: by 2002:a05:600c:3b9d:b0:425:692d:c728 with SMTP id
 5b1f17b1804b1-4264a44d288mr7666075e9.28.1720087094932; 
 Thu, 04 Jul 2024 02:58:14 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d0bd6sm17541425e9.8.2024.07.04.02.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 04/16] meson: Pass objects and dependencies to
 declare_dependency()
Date: Thu,  4 Jul 2024 11:57:54 +0200
Message-ID: <20240704095806.1780273-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

We used to request declare_dependency() to link_whole static libraries.
If a static library is a thin archive, GNU ld keeps all object files
referenced by the archive open, and sometimes exceeds the open file limit.

Another problem with link_whole is that suboptimal handling of nested
dependencies.

link_whole by itself does not propagate dependencies. In particular,
gnutls, a dependency of crypto, is not propagated to its users, and we
currently workaround the issue by declaring gnutls as a dependency for
each crypto user.  On the other hand, if you write something like

  libfoo = static_library('foo', 'foo.c', dependencies: gnutls)
  foo = declare_dependency(link_whole: libfoo)

  libbar = static_library('bar', 'bar.c', dependencies: foo)
  bar = declare_dependency(link_whole: libbar, dependencies: foo)
  executable('prog', sources: files('prog.c'), dependencies: [foo, bar])

hoping to propagate the gnutls dependency into bar.c, you'll see a
linking failure for "prog", because the foo.c.o object file is included in
libbar.a and therefore it is linked twice into "prog": once from libfoo.a
and once from libbar.a.  Here Meson does not see the duplication, it
just asks the linker to link all of libfoo.a and libbar.a into "prog".

Instead of using link_whole, extract objects included in static libraries
and pass them to declare_dependency(); and then the dependencies can be
added as well so that they are propagated, because object files on the
linker command line are always deduplicated.

This requires Meson 1.1.0 or later.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240524-objects-v1-1-07cbbe96166b@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst    |  3 ++-
 meson.build                    | 44 +++++++++++++++++++---------------
 gdbstub/meson.build            |  4 ++--
 pythondeps.toml                |  2 +-
 tcg/meson.build                |  6 +++--
 tests/qtest/libqos/meson.build |  2 +-
 6 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index f4fd76117df..39a1934c63f 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -238,7 +238,8 @@ Subsystem sourcesets:
                                 name_suffix: 'fa',
                                 build_by_default: false)
 
-    chardev = declare_dependency(link_whole: libchardev)
+    chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false),
+                                 dependencies: chardev_ss.dependencies())
 
   As of Meson 0.55.1, the special ``.fa`` suffix should be used for everything
   that is used with ``link_whole``, to ensure that the link flags are placed
diff --git a/meson.build b/meson.build
index df9a64302f0..0c314ae5701 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=0.63.0',
+project('qemu', ['c'], meson_version: '>=1.1.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
@@ -3461,7 +3461,7 @@ endif
 
 if enable_modules
   libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
-  modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
+  modulecommon = declare_dependency(objects: libmodulecommon.extract_all_objects(recursive: false), compile_args: '-DBUILD_DSO')
 endif
 
 qom_ss = qom_ss.apply({})
@@ -3469,14 +3469,15 @@ libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
                         name_suffix: 'fa',
                         build_by_default: false)
-qom = declare_dependency(link_whole: libqom)
+qom = declare_dependency(objects: libqom.extract_all_objects(recursive: false),
+                         dependencies: qom_ss.dependencies())
 
 event_loop_base = files('event-loop-base.c')
 event_loop_base = static_library('event-loop-base',
                                  sources: event_loop_base + genh,
                                  name_suffix: 'fa',
                                  build_by_default: false)
-event_loop_base = declare_dependency(link_whole: event_loop_base,
+event_loop_base = declare_dependency(objects: event_loop_base.extract_all_objects(recursive: false),
                                      dependencies: [qom])
 
 stub_ss = stub_ss.apply({})
@@ -3621,7 +3622,8 @@ foreach d, list : modules
       endif
       emulator_modules += shared_module(sl.name(),
                     name_prefix: '',
-                    link_whole: sl,
+                    objects: sl.extract_all_objects(recursive: false),
+                    dependencies: module_ss.dependencies(),
                     install: true,
                     install_dir: qemu_moddir)
       if module_ss.sources() != []
@@ -3669,7 +3671,8 @@ foreach d, list : target_modules
             system_mods += sl
             emulator_modules += shared_module(sl.name(),
                     name_prefix: '',
-                    link_whole: sl,
+                    objects: sl.extract_all_objects(recursive: false),
+                    dependencies: target_module_ss.dependencies(),
                     install: true,
                     install_dir: qemu_moddir)
             # FIXME: Should use sl.extract_all_objects(recursive: true) too.
@@ -3728,8 +3731,8 @@ libauthz = static_library('authz', authz_ss.sources() + genh,
                           name_suffix: 'fa',
                           build_by_default: false)
 
-authz = declare_dependency(link_whole: libauthz,
-                           dependencies: qom)
+authz = declare_dependency(objects: libauthz.extract_all_objects(recursive: false),
+                           dependencies: [authz_ss.dependencies(), qom])
 
 crypto_ss = crypto_ss.apply({})
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
@@ -3737,8 +3740,8 @@ libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            name_suffix: 'fa',
                            build_by_default: false)
 
-crypto = declare_dependency(link_whole: libcrypto,
-                            dependencies: [authz, qom])
+crypto = declare_dependency(objects: libcrypto.extract_all_objects(recursive: false),
+                            dependencies: [crypto_ss.dependencies(), authz, qom])
 
 io_ss = io_ss.apply({})
 libio = static_library('io', io_ss.sources() + genh,
@@ -3747,12 +3750,13 @@ libio = static_library('io', io_ss.sources() + genh,
                        name_suffix: 'fa',
                        build_by_default: false)
 
-io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
+io = declare_dependency(objects: libio.extract_all_objects(recursive: false),
+                        dependencies: [io_ss.dependencies(), crypto, qom])
 
 libmigration = static_library('migration', sources: migration_files + genh,
                               name_suffix: 'fa',
                               build_by_default: false)
-migration = declare_dependency(link_with: libmigration,
+migration = declare_dependency(objects: libmigration.extract_all_objects(recursive: false),
                                dependencies: [qom, io])
 system_ss.add(migration)
 
@@ -3762,8 +3766,8 @@ libblock = static_library('block', block_ss.sources() + genh,
                           name_suffix: 'fa',
                           build_by_default: false)
 
-block = declare_dependency(link_whole: [libblock],
-                           dependencies: [crypto, io])
+block = declare_dependency(objects: libblock.extract_all_objects(recursive: false),
+                           dependencies: [block_ss.dependencies(), crypto, io])
 
 blockdev_ss = blockdev_ss.apply({})
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
@@ -3771,8 +3775,8 @@ libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              name_suffix: 'fa',
                              build_by_default: false)
 
-blockdev = declare_dependency(link_whole: [libblockdev],
-                              dependencies: [block, event_loop_base])
+blockdev = declare_dependency(objects: libblockdev.extract_all_objects(recursive: false),
+                              dependencies: [blockdev_ss.dependencies(), block, event_loop_base])
 
 qmp_ss = qmp_ss.apply({})
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
@@ -3780,20 +3784,22 @@ libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         name_suffix: 'fa',
                         build_by_default: false)
 
-qmp = declare_dependency(link_whole: [libqmp])
+qmp = declare_dependency(objects: libqmp.extract_all_objects(recursive: false),
+                         dependencies: qmp_ss.dependencies())
 
 libchardev = static_library('chardev', chardev_ss.sources() + genh,
                             name_suffix: 'fa',
                             dependencies: chardev_ss.dependencies(),
                             build_by_default: false)
 
-chardev = declare_dependency(link_whole: libchardev)
+chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false),
+                             dependencies: chardev_ss.dependencies())
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
                            name_suffix: 'fa',
                            build_by_default: false)
-hwcore = declare_dependency(link_whole: libhwcore)
+hwcore = declare_dependency(objects: libhwcore.extract_all_objects(recursive: false))
 common_ss.add(hwcore)
 
 ###########
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index da5721d8452..c56b54eae7e 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -28,9 +28,9 @@ libgdb_system = static_library('gdb_system',
                                 name_suffix: 'fa',
                                 build_by_default: false)
 
-gdb_user = declare_dependency(link_whole: libgdb_user)
+gdb_user = declare_dependency(objects: libgdb_user.extract_all_objects(recursive: false))
 user_ss.add(gdb_user)
-gdb_system = declare_dependency(link_whole: libgdb_system)
+gdb_system = declare_dependency(objects: libgdb_system.extract_all_objects(recursive: false))
 system_ss.add(gdb_system)
 
 common_ss.add(files('syscalls.c'))
diff --git a/pythondeps.toml b/pythondeps.toml
index 9c16602d303..6aba0c9daaa 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
+meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
diff --git a/tcg/meson.build b/tcg/meson.build
index ffbe754d8b3..165e773abbe 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -36,7 +36,8 @@ libtcg_user = static_library('tcg_user',
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
-tcg_user = declare_dependency(link_with: libtcg_user)
+tcg_user = declare_dependency(objects: libtcg_user.extract_all_objects(recursive: false),
+                              dependencies: tcg_ss.dependencies())
 user_ss.add(tcg_user)
 
 libtcg_system = static_library('tcg_system',
@@ -46,5 +47,6 @@ libtcg_system = static_library('tcg_system',
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
 
-tcg_system = declare_dependency(link_with: libtcg_system)
+tcg_system = declare_dependency(objects: libtcg_system.extract_all_objects(recursive: false),
+                                dependencies: tcg_ss.dependencies())
 system_ss.add(tcg_system)
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 558eb4c24be..05fe57a4b97 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -72,4 +72,4 @@ libqos = static_library('qos', libqos_srcs + genh,
                         name_suffix: 'fa',
                         build_by_default: false)
 
-qos = declare_dependency(link_whole: libqos)
+qos = declare_dependency(objects: libqos.extract_all_objects(recursive: false))
-- 
2.45.2


