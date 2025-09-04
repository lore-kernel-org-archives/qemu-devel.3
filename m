Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E392ACA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuBdS-0006Fq-7v; Thu, 04 Sep 2025 11:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Qqy5aAcKCs08xy74xHz77z4x.v759x5D-wxEx4676z6D.7Az@flex--pefoley.bounces.google.com>)
 id 1uuBdP-0006FG-Co
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:12:23 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Qqy5aAcKCs08xy74xHz77z4x.v759x5D-wxEx4676z6D.7Az@flex--pefoley.bounces.google.com>)
 id 1uuBdE-00018f-Ba
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:12:23 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e9bde4276dbso1822360276.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756998722; x=1757603522; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kN7lUoRYvH8LKnKK9JDuRnYX32aBqBHO9jKnHY8bcWI=;
 b=jF88tOQhe7rYwFDZYry/d1ouYLJ0ht4wPV909FUz+WxZIKwdP0xXc3Ni7xaPI65S/Q
 NcpIagrWKTPzjFrACVHw66T9EfiDYQRJmLUJAQgxqQz/oHSYdij8nzBSXrw1haOcc5n7
 oI2dAR5UqdRUxoqmlvPAF/kHtY/wMPD1NOE+JC9p/87/XInl+wavIwBu/lbHUBz8E2aR
 Adsw1B1BTdHkYIvtRtkET35tKhH1Q7NToMkwmAWwrfoXMi3eCyLjDJU2m/dWYsVg8w3z
 59xsWyLI4xHd/Ruj6J06gBKAyYRh1DsAguEyFZ1b9AMSQJ6L947nGeOQZ7cTG5HPfMsw
 LDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756998722; x=1757603522;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kN7lUoRYvH8LKnKK9JDuRnYX32aBqBHO9jKnHY8bcWI=;
 b=e2f8A1YQpM5TATsGZmKzMPJoIpNCOd08UXQ2D0heiSCQzevs+8RAm3oiK6Is6pXLPp
 XkL8ktmFLx4LYNWGZM3K0PxlR9khYQlEth38GNdXNuEcWWo906FnPJ9GoY8JzsFrx4dU
 6xF1JyfCdyzHY/a0c+MJ5yu9aHXp0oYMrJx59es9VAYKfSi27dIQjlEkg9tgI8XJdI5F
 fIL9iEisLZ/Un3K7YHcGKGRNECMIES20H2KLYuIVTFAWILupg7gtUvUR0dRAF/DLNmtF
 imAWpx/BBYtbADKV/ycvSRiQMvl3LzPSZMUebzgujPUlZ5fQPxLa03hVCGG+rsw8xOvw
 3Xuw==
X-Gm-Message-State: AOJu0YwOAPWCEflvT4CHyB3E34pjI2mh7NJpQ8NJmIEdOv6IRB2RtxFy
 MdKLL4DPnx7uBl792GjG9PDJwegXWGUHs2p/rPlzuKcwfnrOXyrdmUyD1dorhzsA8L+NrHs16Ml
 7dBIIfJ6FBToRGx32hmzciqw6WVm7lAOmGV+vGwFh+teX2FkyNhiJ4ysAKB66updEF43ZzRM+3n
 RJHHnWcqn5zK2sXiykOiKLxNfKyVLJYsbTsDv8RhSL
X-Google-Smtp-Source: AGHT+IEx++Le0vj2I+FWlk1R2Dz0Du7bDo5Fz50jemTAePzNyImhyKxXDNox3hHNTT4B9b76jfutTfUFab2E
X-Received: from ybbha1.prod.google.com ([2002:a05:6902:4501:b0:e96:e1fd:d791])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:440d:b0:e9d:6ab4:92ee
 with SMTP id 3f1490d57ef6-e9d6ab49a4emr2833666276.3.1756998722030; Thu, 04
 Sep 2025 08:12:02 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:11:49 -0400
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADSsuWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMT3YLKkoz8PF1zi+Tk1KQUg7SU1BQloOKCotS0zAqwQdGxtbUA/VQ
 fcFgAAAA=
X-Change-Id: 20250904-python-78ccebd0fded
X-Mailer: b4 0.14.2
Message-ID: <20250904-python-v1-1-c43b3209a0cd@google.com>
Subject: [PATCH] Use meson's detected python installation
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "=?utf-8?q?Marc-Andr=C3=A9_Lureau?=" <marcandre.lureau@redhat.com>, 
 "=?utf-8?q?Daniel_P=2E_Berrang=C3=A9?=" <berrange@redhat.com>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 "=?utf-8?q?Alex_Benn=C3=A9e?=" <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org, 
 nabihestefan@google.com, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Qqy5aAcKCs08xy74xHz77z4x.v759x5D-wxEx4676z6D.7Az@flex--pefoley.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Relying on `python3` to be avilable in $PATH doesn't work in some build
environments. Update the build files to use the found python binary
explicitly.

Signed-off-by: Peter Foley <pefoley@google.com>
---
 block/meson.build   |  6 ++----
 meson.build         | 10 +++++-----
 plugins/meson.build |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/meson.build b/block/meson.build
index 34b1b2a30630214959630d5543181bc82a54d2b3..67e9bee1210307ff15ca87ba0f5e7f785df15042 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -139,14 +139,12 @@ if get_option('dmg').allowed()
   endforeach
 endif
 
-module_block_py = find_program('../scripts/modules/module_block.py')
 module_block_h = custom_target('module_block.h',
                                output: 'module_block.h',
                                input: modsrc,
-                               command: [module_block_py, '@OUTPUT0@', modsrc])
+                               command: [python, files('../scripts/modules/module_block.py'), '@OUTPUT0@', modsrc])
 block_ss.add(module_block_h)
 
-wrapper_py = find_program('../scripts/block-coroutine-wrapper.py')
 block_gen_c = custom_target('block-gen.c',
                             output: 'block-gen.c',
                             input: files(
@@ -158,7 +156,7 @@ block_gen_c = custom_target('block-gen.c',
                                       '../include/system/block-backend-io.h',
                                       'coroutines.h'
                                       ),
-                            command: [wrapper_py, '@OUTPUT@', '@INPUT@'])
+                            command: [python, files('../scripts/block-coroutine-wrapper.py'), '@OUTPUT@', '@INPUT@'])
 block_ss.add(block_gen_c)
 
 block_ss.add(files('stream.c'))
diff --git a/meson.build b/meson.build
index fa6186db33435c26d06dce2971a9f536250607e0..6e8baf3deb13c172eecd371ea302b1c2539048d0 100644
--- a/meson.build
+++ b/meson.build
@@ -12,8 +12,6 @@ add_test_setup('slow', exclude_suites: ['thorough'],
 add_test_setup('thorough',
                env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
 
-meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
-
 ####################
 # Global variables #
 ####################
@@ -76,6 +74,8 @@ have_user = have_linux_user or have_bsd_user
 sh = find_program('sh')
 python = import('python').find_installation()
 
+meson.add_postconf_script([python, 'scripts/symlink-install-tree.py'])
+
 cc = meson.get_compiler('c')
 all_languages = ['c']
 if host_os == 'windows' and add_languages('cpp', required: false, native: false)
@@ -3474,7 +3474,7 @@ foreach target : target_dirs
       output: config_devices_mak,
       depfile: config_devices_mak + '.d',
       capture: true,
-      command: [minikconf,
+      command: [python, minikconf,
                 get_option('default_devices') ? '--defconfig' : '--allnoconfig',
                 config_devices_mak, '@DEPFILE@', '@INPUT@',
                 host_kconfig, target_kconfig])
@@ -3545,8 +3545,8 @@ config_host_h = configure_file(output: 'config-host.h', configuration: config_ho
 genh += config_host_h
 
 hxtool = find_program('scripts/hxtool')
-shaderinclude = find_program('scripts/shaderinclude.py')
-qapi_gen = find_program('scripts/qapi-gen.py')
+shaderinclude = [python, 'scripts/shaderinclude.py']
+qapi_gen = [python, 'scripts/qapi-gen.py']
 qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/commands.py',
                      meson.current_source_dir() / 'scripts/qapi/common.py',
diff --git a/plugins/meson.build b/plugins/meson.build
index 62c991d87fcdd8bcde8edddcc73909c6133f5460..6bf72a69060414ba1b7c1857515eeceb5a2c7b7c 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -6,7 +6,7 @@ qemu_plugin_symbols = configure_file(
   input: files('../include/qemu/qemu-plugin.h'),
   output: 'qemu-plugin.symbols',
   capture: true,
-  command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
+  command: [python, files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
 
 # Modules need more symbols than just those in plugins/qemu-plugins.symbols
 if not enable_modules

---
base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
change-id: 20250904-python-78ccebd0fded

Best regards,
-- 
Peter Foley <pefoley@google.com>


