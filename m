Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE88EC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJO-0006CN-CC; Fri, 04 Sep 2026 08:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJH-000692-92
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJD-0006qP-F2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso8392965e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525976; x=1789130776; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JJRRLQKjYH6ftKXJglo+Wz+lGfOq+Ff93uY+8fVGf2U=;
 b=inJaY/yywpyfVZmnYx8R8GyxqQ3CVvpwOwdA12PEcpSZiffwnkDIAzRV9FfOdJzbZw
 uIsTRqkHplvBWKEEoWfHk+hSOcOH3k6WxTX5UN8wxAIRCr859bzkabIhiVLlGJM2BvwP
 UOLc74VZ+omKca917uBL8TL9LECQ+dDC/vj3NawucOzcUeQICiyXkkraAlb2OTvHrOsV
 7SSABjfT1V1o/Saq7Ds/F7u6vc0mWRa2Oet3eEI9Z4oH7qy8CcNrtPOUHNNeNl2pMjHa
 5EHfnIy53ijiVfDnPPRjnim+BI5zG8HilY/cNPHEpB2rD9Ti86RF2mBXNlDCQdztgzlH
 W+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525976; x=1789130776;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JJRRLQKjYH6ftKXJglo+Wz+lGfOq+Ff93uY+8fVGf2U=;
 b=T4ZOX+1AW4k4zdAEKwl6JXJDEKZtguVzztIg7xHcRDAV72sBC35GcK4C/zh3m2dohr
 /D8t4rls9P+KEaubCuHm9KOoaFxo4i5Lw8+X8fW9d6YGaet6gqbm5W/VAp+1kvY2sayF
 TO83/AxaFLvY3Z3jY8vO2ymG7T63FsAXZGxnxYmtCdcZVPwH6tSEArSL4ommyRW02nPB
 FXCJiKkndOdGDzwEPHtIjMvtRILru6VIH8cHNhI007r97vELTdkUgjVCQA/41qlPuyda
 a0cN1PFq5dd7eQGt5hADNgufaxNZ4if3JZx6RBHjQqwynEEiJq5iO2+So2IjtxTvKMTf
 LL7Q==
X-Gm-Message-State: AFuF++mX4gpMwBFyqfwNASj7JDWKUoWX6PO2EZlAkYLwj6V1ZGcgxfKi
 ibyiXX93AwbD6/SWooimwhmVYL59aNFCcAgyQBDw55aQbv8TGl/hGSwnbw2VMRle80E=
X-Gm-Gg: AYBFou2e48U9Eom1SIs5fzemGeTT4hqrm1Wymm2mj0Eion8Esskni+1kMyBaiaKhiLC
 C++AmD1T+veiG3hLUL5DQyeJJJa/kwswg8t0AqtsSx6e/LZQdVY90UN6QYCme5TYUQPvBvON1KQ
 qwJ8Cafdj7ItDlH6OsF4wZncQ1dYh0hgqC1T5ehe30JIEuwZXLkSJaXjIDqp7E7wXhuQyOOerCV
 2w5ClS4jtWZiHAeFols3BFmcNSJSGpLVsOVuRbOpUlMuIwob8yn+lkBQhQ9beK3H1lDpslm09Vc
 1SZx3hxCbZY99j2ppoEiaxYo9mAm0NaBAneAR4FIrg7ibZgm5ufY1PkCMfuWsw4mau9Uh0EQwAr
 /UyTPJJ4bttTMzqNfgRnjToLIDntmhDno+sipJRQKeTlfbvjtXTM7slc5xomDmHknntfEj0bwaJ
 /uyIsNyWXAs8Upi8EEaJzoAgNu0dTFJj6OgDtcIHwAFjvTzsgnUG1HoowKAehhfgck4HJpOrOIJ
 Q==
X-Received: by 2002:a05:600c:5247:b0:49c:ee3b:723d with SMTP id
 5b1f17b1804b1-49cf81f69ddmr44820335e9.0.1788525976080; 
 Fri, 04 Sep 2026 05:46:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6158e9sm151816925e9.12.2026.09.04.05.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 835E3613CA;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 012/105] tests/tcg/meson.build: introduce plugin_test
Date: Fri,  4 Sep 2026 13:44:26 +0100
Message-ID: <20260904124604.2207440-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

We add possibility to declare a test that is based on a plugin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-13-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9940bae80a4..7b51750b016 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -16,6 +16,10 @@ tcg_tests = {}
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
 #           'env_var': ['VAR=value', ...],
+#           'plugin_test': {
+#             'plugin': 'plugin_name',
+#             'args': ['plugin_args', ...],
+#           },
 #         }
 #       },
 #       ...
@@ -59,13 +63,29 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+                   'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
         endif
       endforeach
 
+      # return a clear error if user misspell a plugin entry
+      if 'plugin_test' in setup
+        foreach key, _ : setup['plugin_test']
+          allowed = ['args', 'plugin']
+          if key not in allowed
+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src +
+                  ' (possible: [' + ', '.join(allowed) + '])')
+          endif
+        endforeach
+      endif
+
+      if 'plugin_test' in setup and not get_option('plugins')
+        continue
+      endif
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
@@ -78,6 +98,12 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
+      if 'plugin_test' in setup
+        plugin = test_plugins[setup['plugin_test']['plugin']]
+        # remove 'lib' prefix
+        plugin_name = fs.stem(plugin).substring(3)
+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = target + '-' + test_name
@@ -118,6 +144,21 @@ foreach target, plan: tcg_tests
         qemu_args = setup['qemu_args']
       endif
 
+      if 'plugin_test' in setup
+        plugin_setup = setup['plugin_test']
+        plugin = test_plugins[plugin_setup['plugin']]
+        plugin_args = []
+        if 'args' in plugin_setup
+          # add empty arg to generate an additional comma
+          plugin_args = ['', plugin_setup['args']]
+        endif
+        plugin_args = ','.join(plugin_args)
+
+        # since we turn plugin into a string, add dependency explicitly
+        depends += plugin
+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
+      endif
+
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
-- 
2.47.3


