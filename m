Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03647C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaU-0006jC-V5; Fri, 04 Sep 2026 09:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta8-0006VV-M8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZx-000381-0I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso11433375e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527013; x=1789131813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k/BfTarnLWqkrSwxO4pH9S9p5Y90HaKbjPjWlxoYnes=;
 b=qeesGFqhTqMgSrfs1Lv5qWMo/u9Ac5OGrdJytVX62dEhkAqWR/N69toNqDR/n9DMVO
 AkJ8yu0zAQfnTIGroF2og99O5Pr5nBpFRuXOPx+QfqI6ALT+AWsmc3k2AtJdUbiVeVby
 jLaNNQbvetkogGN9hntbAU4OVM7+4LwAbMnK0yadnkJypdKZPGFsaoRBRbs3bXQ8UZtI
 PYnjyMCtQSS74exB17vJmVnVcd1bp4cfd5L0u6Dgjfy5OwiKUA7awgRui3juSVZ6KwWr
 Nmx4jTsICr/hpKtvLEuPfD5qaCyBHkLNtAPZJr+BW5+34iy2Y18uJcXvFudKhFH2eaLP
 aETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527013; x=1789131813;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k/BfTarnLWqkrSwxO4pH9S9p5Y90HaKbjPjWlxoYnes=;
 b=U44nY+5tR5TJ/2SXy9+UR9ZcPElovHTy3dW5lnfHBVQoej48hKfgNQ9qSSiSzDIs/o
 sX/EDzo+lNRrxXaL0DN98QDWUNDc9xw6nSXSKIt5u/zuaD7yUQcWuyzxtvHQx+vMA695
 kSHaJtxFJDvglfKA3VLqgoV9pviY/54fygbNC0ssqwmlibuW3dfp+lCWDwSXKXtyXLWO
 E+vEWHj3BFDb6Fb5cEedc5HRCtxowwH8VLLw2kXHfFhl96TXRITDQp/gYRHlvWmruX4u
 bOh6Ajd04LbPKnjAMC5d9QPkH2zsXQ/ELL59Okli5J4WchtGBmvq8d+9FXCPtmISc7d8
 jktQ==
X-Gm-Message-State: AFuF++koyrJ0gtGdBnw87bKHuDu5OZcVW+tDFV6xBoTcqo/16qGdoq1J
 8vj66fRXk0rBHKlStKQkw1c/RnnXBhqFofhDM/CzaCF3AzIvjFRmObBf/JK63tvrdyI=
X-Gm-Gg: AYBFou0gobpGOZKHMLB+G3ScGRJrUplOKCiWP+gOZB6GzN8ukAJV+Hr86KhWGXEGhr9
 rQRVU0mope7Kfh2nL2F9FK2axi5eYNpc0h5wA87w1gZ7ijZDMc8Y427bsyHrp30TOvkCOrJ1rEV
 uxezgO2yxhgov4kUW6vhja1Gr+OoXR3b+5YUlThdlX8EJ3/91fRNZSg+P8XY0aUkCfzIFG3o1c/
 q3eu4iT0bu9TQmCTKwPFWfMb5ZoBT8eb8o3hW5t9xUjKcqs2Fzq5j3PeqRO0SGqzrAYggV6Uv4m
 rbaiGg9BnS5jeAMwG4Go9fUD+oSxw9Elxh7AlHVyFnWxpPtU0Kvcr4GG4NxPq8gkIEQ2H9JARzz
 QVxEOOMFzH261ruCjFu4iluDVOzKXrOenj36s7QlKYGitUtjRELNMm37ssnKoMeokYAfWjruWxv
 QWQEnmRWghnSA/1WkmYG1NNbOqrt0ZuPcOG7aEfkKlpwOKwUey3ehb8xuVZ0THYFXuxGDG5E4=
X-Received: by 2002:a05:600c:1c23:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49cf820a8e3mr67367675e9.3.1788527012679; 
 Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce55259ecsm148878375e9.2.2026.09.04.06.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D1415FBD6;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 022/105] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Fri,  4 Sep 2026 13:44:36 +0100
Message-ID: <20260904124604.2207440-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We directly move compiler requirements in test definition. This allows
to always declare all tests, and let the main loop filter the ones
that will be available.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-23-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b60ea53825..4487d61ef6c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -20,6 +20,10 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': cross_compiler,
+#     'cc_feat_cflags': {
+#       'name': ['feature cflags'],
+#       ...
+#     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
@@ -29,6 +33,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
@@ -74,10 +79,11 @@ foreach target, plan: tcg_tests
   # choose how to deal with it.
   built_tests = {}
   added_tests = {}
+  cc_has_feat = {}
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -88,13 +94,17 @@ foreach target, plan: tcg_tests
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
+  cc_feat_cflags = {}
+  if 'cc_feat_cflags' in plan
+    cc_feat_cflags = plan['cc_feat_cflags']
+  endif
   tests = plan['tests']
 
   foreach t : tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
+        allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
                    'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
                    'wrapper']
         if key not in allowed
@@ -155,15 +165,36 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
-      cflags = []
-      if 'cflags' in setup
+      if 'cflags' in setup or 'cc_feat' in setup
         if exe_name in built_tests
-          error('test ' + exe_name + ' was already built with cflags: ' +
-                'remove cflags or set \'exe_name\' (if cflags are different)')
+          error('test ' + exe_name +
+                ' was already built with cflags or cc_feat:' +
+                ' remove cflags, cc_feat, or set \'exe_name\'' +
+                ' (if cflags are different)')
         endif
+      endif
+
+      cflags = []
+      if 'cflags' in setup
         cflags = setup['cflags']
       endif
 
+      if 'cc_feat' in setup
+        cc_feat = setup['cc_feat']
+        if cc_feat not in cc_has_feat
+          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
+                            check: false)
+          avail = cmd.returncode() == 0
+          cc_has_feat += {cc_feat: avail}
+        endif
+
+        if not cc_has_feat[cc_feat]
+          skip_test = 'compiler feature ' + cc_feat + ' not supported'
+          built_tests += {exe_name: exe_name}
+        endif
+        cflags += cc_feat_cflags[cc_feat]
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.47.3


