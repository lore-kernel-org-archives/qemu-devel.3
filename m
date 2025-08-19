Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6535FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNV9-0007NU-Vm; Tue, 19 Aug 2025 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uoNV8-0007NB-L6
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:39:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uoNV6-0007ro-T9
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:39:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e2eb3726cso3403402b3a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755614387; x=1756219187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpkf+k5WP9D7t0RxDyD9FNYxub6lt0Xa3IB6Yu63rSs=;
 b=RYD35A7CwXXtgpMbqsiifcbYDTmp708We+qgXEWbjVPWYy9SSBpHQhW5Akb9oIFkDq
 MiIgv3ZH9R+bQxvB+eVkiNyylPb7e2F0pxiWzCbuK3RGtoYFaqqwYZynSzcSxahqUPtN
 1VmAWj+Gt6PdKPlhkIyA5koqK77/D9dfi6Gk1zn9MMqn6T9iDVNv/1mpQ47QQH6C6L/L
 tLCV0KoAZEbBXquVsu7ANHomRtSRqzhZA3jaOfEQ4XQKJ4BqZc4v7hIIpuUsTxgyYpiJ
 gBfEHafNsmLrIaTlKBDZRpxtHKuH7mxiqRcXKE2aI+Ti+KRCSg4YgWyQ53h4dHsz0L8c
 gKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755614387; x=1756219187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpkf+k5WP9D7t0RxDyD9FNYxub6lt0Xa3IB6Yu63rSs=;
 b=nmhK+Hg9Qg3+6iE7nkE541NRM82WolIXH1dhRg25ivSOvLFKzkZAc3kI9/DqdBtsuL
 DPkXLeLBL7yOpmugvh4MftzritPzP/F+BiezczeJUol9P00nZ8o46zZNHNS1gywv/jIY
 ycvCPtUwfo4ghA9PtUMAnteqcLurxO9xNG29dVzRSTXzbeWoeGgwDNtByhAEgUiTbMk5
 kM9z9BdSAK3uqvdLeWiQFE/3s0kJx+/cUN2zn/mGsRpvOjZ8yrkJxWDYqF8jMCJ2pBaJ
 a6yU8nvyGeqX6BStkbbxPLldJ8I+J8RzMD0Usrn5YiTk2Ysfr0L8rwGpAn9lDEeYpNjT
 5Wbw==
X-Gm-Message-State: AOJu0YyEQ48hcwvlL0Ny9a4WhyeaUjpQWhgVlSwrIs4IWVT7Ijd4fK1d
 vGA5YGFPyHPhKSIO59IOQwbi06CMGRyaRV41/zkbqcl15ZVLDJnONx274dAxW5gcUT5JMdFe9/i
 xd3HNgoA=
X-Gm-Gg: ASbGncvg+7r8zOS4nKMUMq+mVCcdkPRoOXT0kuhzAMnwgslhEQiOydxSGhAnzddg5s2
 SnWy+W58hgb6UUPO+zYuE4dfZkLVD0iuRk6TqWAUaLAHUelf979NykwUpum0jJx77eopNXmUC7e
 NlZEvYH/Yc0ExzoU7HC7xlXau1fBzf9SNBHzhaRJS9Unz0kGPnjAT2iIGBxwJtQsFvro1lG2ha/
 o6T70WKVnb7pg0Y6mHPMd7tU6xEkyU/FVUocf/M24JxzSnSxEdgap208PyCw7elm/Z3xUXKnSHh
 8vg0htnjrwm8aPPC5PP1N5cJSH10082aVHowqYgT9qohH7sfFgpXeqt1WgOfs41DFsstKca0ul/
 ugf+EIEFyWHKpEMVdTPIpJ/4AJ9t9T/aLAnsdVWdbA7CGLYZ/jeBWsfRqTQ==
X-Google-Smtp-Source: AGHT+IFWEL25s6qK8e/rwE6Z+4eAjA+HeOQ8UWL085SUxuhBr0S9WVdFIdX9DkczZh9B/I6TwGtgLg==
X-Received: by 2002:a05:6a00:1741:b0:76b:e936:607 with SMTP id
 d2e1a72fcca58-76e80dd34c3mr3141180b3a.0.1755614386830; 
 Tue, 19 Aug 2025 07:39:46 -0700 (PDT)
Received: from gromero0.. (201-1-50-181.dsl.telesp.net.br. [201.1.50.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d0d98dfsm2769781b3a.17.2025.08.19.07.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 07:39:46 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org,
	thuth@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH 2/4] tests/functional: Support tests that require a runner
Date: Tue, 19 Aug 2025 14:39:14 +0000
Message-Id: <20250819143916.4138035-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819143916.4138035-1-gustavo.romero@linaro.org>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add support for running tests that require a specific runner.

The test is specified via a tuple (name, runner, protocol), where name
is the test name as found in the tests/functional directory without the
'test_' prefix and the .py extension, runner is an array containing the
runner and any arguments required by the runner, and protocol is
the test protocol used by Meson to determine whether the test passed or
failed.

The test tuples are added to arrays that follow the current naming
logic but with the suffix '_with_runner' appended to their names. In
Meson it's not easy to select an element in an array at runtime based on
its type, so it's simpler to have a new array for these new test types
than use the current ones from the tests that don't require a runner,
and so avoid mixing strings and tuples in the same array.

Currently there is only one runner, the GDB runner, but more runners can
be defined and associated to a test via the tuple.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 meson.build                  |  4 +++
 tests/functional/meson.build | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/meson.build b/meson.build
index 50c774a195..8d482f0809 100644
--- a/meson.build
+++ b/meson.build
@@ -75,6 +75,10 @@ have_user = have_linux_user or have_bsd_user
 
 sh = find_program('sh')
 python = import('python').find_installation()
+# Meson python.get_path() on 'purelib' or 'platlib' doesn't properly return the
+# site-packages dir in pyvenv, so it is built manually.
+python_ver = python.language_version()
+python_site_packages = meson.build_root() / 'pyvenv/lib/python' + python_ver / 'site-packages'
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 311c6f1806..1f70b70fd4 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -349,6 +349,23 @@ tests_xtensa_system_thorough = [
   'xtensa_replay',
 ]
 
+# Tests that require a specific runner.
+gdb = find_program('gdb-multiarch', required: false)
+if gdb.found()
+    gdb_runner_script =  meson.project_source_root() + '/tests/guest-debug/run-test.py'
+    gdb_runner = [gdb_runner_script, '--gdb', gdb, '--test']
+
+    # A test with a runner is a tuple (name, runner, protocol).
+    # The tests must be elements of an array named like:
+    #
+    # test_<arch>_<mode=[system|linuxuser|bsduser]>_<speed=[quick|thorough]>_with_runner = [
+    #      ['test0', gdb_runner, 'exitcode'],
+    #      ...
+    # ]
+else
+    message('GDB multiarch not found, skipping functional tests that rely on it.')
+endif
+
 precache_all = []
 foreach speed : ['quick', 'thorough']
   foreach dir : target_dirs
@@ -372,9 +389,11 @@ foreach speed : ['quick', 'thorough']
       suites = ['func-quick', 'func-' + target_base]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_quick', []) \
                      + get_variable('tests_generic_' + sysmode)
+      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_quick_with_runner', [])
     else
       suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
+      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed + '_with_runner', [])
     endif
 
     test_deps = [roms, keymap_targets]
@@ -423,6 +442,49 @@ foreach speed : ['quick', 'thorough']
            priority: test_timeouts.get(test, 90),
            suite: suites)
     endforeach
+
+    # Prepare tests that require a specific runner.
+    foreach test : target_tests_r
+      testname = '@0@-@1@'.format(target_base, test[0])
+      testfile = 'test_' + test[0] + '.py'
+      testpath = meson.current_source_dir() / testfile
+      teststamp = testname + '.tstamp'
+      testrunner  = test[1]
+      testproto = test[2]
+
+      test_precache_env = environment()
+      test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
+      # python_site_packages, i.e., site packages from Python in pyvenv, is
+      # added to PYTHONPATH because some runners can run a program that has its
+      # own Python hooks that, by its turn, will search for modules based on
+      # PYTHONPATH independently of the Python used by the runner, like, for
+      # example, GDB using libpython.
+      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python' +
+                                          ':' + meson.current_source_dir() +
+                                          ':' + python_site_packages)
+      precache = custom_target('func-precache-' + testname,
+                               output: teststamp,
+                               command: [testrunner, testpath],
+                               depend_files: files(testpath),
+                               build_by_default: false,
+                               env: test_precache_env)
+      precache_all += precache
+
+      # See comment above about python_site_packages in test_precache_env.
+      # Don't append to test_env since it will affect previous uses of it.
+      test_r_env = test_env
+      test_r_env.append('PYTHONPATH', python_site_packages)
+
+      test('func-' + testname,
+           python,
+           depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
+           env: test_r_env,
+           args: [testrunner, testpath],
+           protocol: testproto,
+           timeout: test_timeouts.get(test[0], 90),
+           priority: test_timeouts.get(test[0], 90),
+           suite: suites)
+    endforeach
   endforeach
 endforeach
 
-- 
2.34.1


