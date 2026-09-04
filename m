Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F9AC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaZ-0006pS-H9; Fri, 04 Sep 2026 09:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta2-0006Q4-MM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZw-00038h-8d
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10310145e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527015; x=1789131815; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9PxRCYURZy0LWM9BH465zAgHtFdd5RKFlLw8XfvPHuY=;
 b=ub2Y7+Jh0POSqfjhN4VGU0ZzmrQrDUz8G1PXVrxRU97Ru7z0d9NRUnlNlSy7ZZ3L9v
 gL40pUazhoSLfHkolez9AvcJWg1Uesb6n3gO6u4OReyUFPg/ehQTQ1taf76vC4jDxCal
 7KfsLlVTH6+CRRcHfOPiB1D6VFWbqUviwq/INl/1BZONOFt82tRLefb31TEDSkKJVY0g
 3lA1bsn3COzVjn8SQBqHExSxveCzKz+D0cC5L0Vt6rorsC9fsuKLgfmWNUlVV9sSbVjG
 cIiqjbk4/xMrz2ig7flR/GPKQWx0+KluXvRjAwkbDTwRpk86KuiMa1McwydUdTf2t5Ss
 ui6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527015; x=1789131815;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9PxRCYURZy0LWM9BH465zAgHtFdd5RKFlLw8XfvPHuY=;
 b=NMsD7TFZ2auNvHYQbS65e8e51Gf6R0djHv+sXWUsS4PbmRhNrkZcZzKVY4k7ykoUHH
 iPjJFrrfRqbGcP4Nb7x31IzbHkUI84fgzUTXEKHTV6F22wEBWH4S5czoQGYUwbTmcjEh
 VUN5nXzh30ldOzr6XLOHngy+oveSV80o3ShwU0445x3aquy5pjNNtiD+TzvDrflGxswH
 MkJyjSIC8yPCCrCV+Aos8102II2flVZLb6It/z8Q2WVkryIaDAlSAWXM+vRh7W42NH5/
 0zgBvyKSnIPcObLdlFaQ/A4r0YKNiMGj1ltSpaaD4h2ASu5YDxXT3KP1hpffdQQIASZs
 NWow==
X-Gm-Message-State: AFuF++kxp9H41RinfBZgNK2JNHDRuD/kePIqe+aaDMXOhV2h0yEEROk2
 +Lrk0P6PqNECXhRwIlwGq+iKgQgufLbnDBt1Ys33EBQBppy064C8UHmE43HNZbiNP9o=
X-Gm-Gg: AYBFou15jxYrNHy4jZ+cBj3mwD3SjYSiDd57fpl76s8N+iQYbsSWrRt//M8Cmj42W/7
 ZvUTXOMKeGDA2WYsp+DSjKiamnqxV5Xr6rCiyz8upuW1QodShTmiB/8m90JpoN/voWQgowksve9
 62oNgf4do92VXBHogDE4h6CjjycdholcRYoBUViDJMMyULLlWOK2jng+rYWVXO2FQ8un7nRkztT
 qeAXAJp0o0qHgQYfZYPBdK1LsR4irQ3kQsPDqf+dgN5AbRTPcTuYCWIsjCYuNlgsqkrsgK0TV7n
 LLNTt1YJfI3w4L7LyChwGW7gDgjIz2E4tGNDG/9N+7Q7SM+BHcUHJxUHmr3RhBVdmN46+cq0cKO
 JZfbVB106sI6/tBHaNEZCcHyacOVn81dzdEGo+zcki+xgsrNyeANolvFCFG8mItesYeRQHc7SQP
 g1NBYFUsdc+MuWjgXZvISkIda/HOxUzL68Cjn7L7n/TLQesmWB2ubX2UI2h/+D36BHhrX7g3E=
X-Received: by 2002:a05:600c:8b76:b0:49c:f4e1:3135 with SMTP id
 5b1f17b1804b1-49cf8259953mr64156725e9.14.1788527014735; 
 Fri, 04 Sep 2026 06:03:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm94697095e9.5.2026.09.04.06.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41EFC617E1;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 030/105] tests/tcg/meson.build: introduce depends
Date: Fri,  4 Sep 2026 13:44:44 +0100
Message-ID: <20260904124604.2207440-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

This can be used to declare dependencies for a given test executable.
Useful when generating headers (like x86_64 does).

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-31-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9809695f3b8..ea17a947628 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -40,6 +40,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'depends': [meson_dependency, ...],
 #           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
@@ -178,7 +179,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
                    'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -277,6 +278,11 @@ foreach target, plan: tcg_tests
         built_tests += {exe_name: exe_name}
       endif
 
+      exe_depends = build_test_depends
+      if 'depends' in setup
+        exe_depends += setup['depends']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -289,13 +295,13 @@ foreach target, plan: tcg_tests
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
-                            depends: build_test_depends,
+                            depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
         built_tests += {exe_name: exe}
       endif
 
-      depends = []
+      test_depends = []
       qemu_args = []
       if 'qemu_args' in setup
         qemu_args = setup['qemu_args']
@@ -312,7 +318,7 @@ foreach target, plan: tcg_tests
         plugin_args = ','.join(plugin_args)
 
         # since we turn plugin into a string, add dependency explicitly
-        depends += plugin
+        test_depends += plugin
         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
       endif
 
@@ -367,7 +373,7 @@ foreach target, plan: tcg_tests
       endif
 
       test(test_name, env, args: cmd,
-           depends: depends,
+           depends: test_depends,
            timeout: 120,
            suite: ['tcg', 'tcg-' + target])
       added_tests += {test_name: true}
-- 
2.47.3


