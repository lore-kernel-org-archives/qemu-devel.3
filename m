Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E3AC79F88
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQM-0001iF-4J; Fri, 04 Sep 2026 08:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQK-0001gp-Cz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQG-0000hw-D3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48431648f33so1443609f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526415; x=1789131215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HTrZoXFUnOhw1apTHhMkKxBaxnocexlpyfkyOtxfvtg=;
 b=WP/ATxXPmOF3UmC01HmUm+5ev5KbrkeHZL35hzzGhZEAOHwVr+J+zkca4zazyctOQ9
 CDNfsWCkeRSJTXXHEWQfRif3jz35YjA57DKs0YMPa7wqp7K2I/xLWal8ysNfL/uZ95ND
 tFNre6A/gswJC+jYjWdUvfXlyCwIC5cJ6bygiGXEAKaEd9xSg5hUYoSoFzsvKAibDEqc
 h5NSZmhXrLPTGfbMY8gE4O8bH0l/w8n07zcZE3rwp7gVuE69GYGXs45ejyWLk6YtjLYT
 EhdTQ/+UMFYUnEIChMzELBq11pMSqvaGCwx2E8Gl5BcCbBqhsV2RbFIEyEcmvQJ5PjLO
 Sg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526415; x=1789131215;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HTrZoXFUnOhw1apTHhMkKxBaxnocexlpyfkyOtxfvtg=;
 b=bzJcrG/VEohXg18wxf50IETHMKwk4GK4PqAXbmKomey/lFPO6Wp7CYAIY2ayUPfRg2
 lQHYpm0BqVRGmsbbFPYQ/7ZYTWDB7ueGpAC/3oe2qQc+NTkZQiAUUN6b0qf1rFKcQmMU
 IL3MP3VI4M+plKII/0/By6F7pn9c/F2oxRqk+qqt8fixUQ5vWdsR6DJW03zEqhpcivxH
 JrjAGdoeEtGwBCF68r0+iV9Mfi7I6rUEbdIfCjiJPK0aPqROKH/jYgAO4FVixWcmMcZx
 sV7ZyxiudadiAakIJwR7M5FWPJiJ295weAHT4+n0xPxCDas5XtboqIetjs4N/5Wg6RXh
 dSyg==
X-Gm-Message-State: AFuF++m4EJqUhLJ5PMHa4X24WiEUVlRvokMMlpxKheGbuoF8wElZr3T9
 Z6gbxvupwb9mlrJvKIIxokrnZ45qEAp9O1xq/o+Grb1mRTMnL5DpKkJNLkiCCmsMJM8=
X-Gm-Gg: AYBFou3hrR7rsLzItKCpimqaUvkOXp8mqNexbJWtntB1JD4j1VA3CJCHI6V8aFd/Fyn
 jorQY9gul5i/IblItpDpmHDOYNWIQKMPbtG0Rb3SDGzwXLZDP585bixP6mKfb7FxkMA6MdXCa8H
 sya85tUrcKphyrxMfJEHtiYKh8RmkAKiIoQKdJod/v3UX7OLTuQrreMsAZMrw9uIhxF5jbR59C/
 +IMerxBnEHwTfAmUh3XbkTdZuZ6wWhFTduuwiLtYiQeWTZzCBlCT3xRiySgxtlKGcgH5jbuax2E
 IyJn5rT0JI5JAQG2ldgaXBeak/I0hPXqEeE0aiPvjZ0wyx2e9mTDV0cWmR3bvkEfm9BzB65D3sn
 kJXOnFLCn7t9Tas6Pz7sen05daXZh1FmopuPJfuR07u0iLGeIPuueWj8F8DPaWjPld+ZpDpceML
 8FRKIlCLm2vjZRDoNK6QWfExBXbaZkFgKs0EiGAVtMnEucHmLELExmP2I/QOoX
X-Received: by 2002:a05:600c:5247:b0:49c:ee3b:723d with SMTP id
 5b1f17b1804b1-49cf81f69ddmr45196585e9.0.1788526414957; 
 Fri, 04 Sep 2026 05:53:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771e9absm69128255e9.9.2026.09.04.05.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 969C8616E3;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 023/105] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Fri,  4 Sep 2026 13:44:37 +0100
Message-ID: <20260904124604.2207440-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Similar to cc features, we declare the same for gdb. With both
available, we can now declare all tests inconditionally.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-24-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4487d61ef6c..7384786f7f8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -26,6 +26,10 @@ tcg_tests = {}
 #     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
+#     'gdb_feat_version': {
+#       'name': ['minimal gdb version supporting feature'],
+#       ...
+#     },
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -37,6 +41,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
+#           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
@@ -83,7 +88,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
+               'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -98,6 +104,11 @@ foreach target, plan: tcg_tests
   if 'cc_feat_cflags' in plan
     cc_feat_cflags = plan['cc_feat_cflags']
   endif
+  gdb_feat_version = {}
+  if 'gdb_feat_version' in plan
+    gdb_feat_version = plan['gdb_feat_version']
+  endif
+
   tests = plan['tests']
 
   foreach t : tests
@@ -105,8 +116,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
-                   'wrapper']
+                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -261,6 +272,18 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if 'gdb_feat' in setup
+        if 'gdb_test' not in setup
+          error('test ' + test_name + ' is not a gdb test, but it requires ' +
+                'a gdb feature')
+        endif
+        gdb_feat = setup['gdb_feat']
+
+        if not gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
+          skip_test = 'gdb feature ' + gdb_feat + ' not supported'
+        endif
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


