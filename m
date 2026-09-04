Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222D0C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJP-0006Cp-OC; Fri, 04 Sep 2026 08:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJH-00068f-5g
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJD-0006qt-FB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso8923635e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525978; x=1789130778; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nUIcJrjFJ80wCZeo0bUeHBBQhirzWNDdtOPABszpkkA=;
 b=h1r+KMTflS12OFpQWi6WzaBcO7m0fNlyUp1pIvIKiNcRuZKADcGboMUex3dBXhDS1P
 YFXOaKbAg+vu5eAwyb/I9p7myWtMLe/AWqJwGVreaDis4bOTjLKNOB1MDqhAV1N9t5Fs
 DrEVwiaXv9Mi0Gi6RK98MntS8TkchezwXdv6Thix1p1WmbuaKOCTAwEBwbCl9CfHvgi7
 dSJ/lB9lcm98e8s96r9en1HfxFWpTonqOyzOkYQ0ea4wyLwdOg+kwE/rzID5C3BeVjFN
 Qh9BJjSDCnOzWk52uWMkKWXY90enBtQCj87lbh2tTp5n+VEcyh2SnAelF+Ma43H3lMHM
 8FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525978; x=1789130778;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nUIcJrjFJ80wCZeo0bUeHBBQhirzWNDdtOPABszpkkA=;
 b=on+kxGRrduaf+3YhqFOX8oZCbYYpqVLwvSQJQM5Q7oyEhLIxEX1QG05RMGUIqbxJsD
 aXWXsN2zYzyJfB1x34zgGWRwkhG3ysM+T++ejnspqr469nh3PFGlpSt9VbCJ2ralTrfO
 fl0yL1+xdfg3tU4OWkcMmdZeBhNDDFS6na7X7a2ClypDtF8KFHVSo7ayw+bmqWLCt/3Y
 nBDqJVpfa72xYtFH+natThJp4+StaHD0u9EbbGooiQEEqcH4zMURZ22A5O6hQgxbeeOG
 sQt/dA56Ef1bkeyghgXBBe2Wsp+wh0p0eVVpaIsv4yXOilqwNMRYHr1hZk9uw9DOt5kH
 aBZg==
X-Gm-Message-State: AFuF++kTfrzXFTQKoFXGojYKrW/yhd6f+Z/e6JPPmNGlSptICeVhjOK8
 obNGxXCFUV7p1PzF3emK6Jw8kxUNeicou4m6bNJ5L0rbSK27wIooGwSSZboF3yyYLio=
X-Gm-Gg: AYBFou39WDrItH8NFYoaGO582hC64xZCH6wJaJs+dqMk5K1opnv91Dkd8Wrv4ALx803
 aB90Gq2yTgxZdtsKNY0tm25agMNkbwoS7rSXI8mFhWOL96d8Aj3LSt0xct1YcD5ozuKthTMCItz
 jZH0CdwXP/4fuxIRAOODweOfBxOKwgaMeSWgpJ3yOQZ3YYsPnl65wTLQnbmEWJM0mJ5Xfrupex+
 5VJsZyqHCZqBJ/SZEZC7vYFIlCvVbq9ssb9XVwussiYQnAncjbpMnKD8mEJ2AOm+WfOfb5SSarE
 PGL3vijuJ73Kd/ZcOY8kNdf3EZiip2chTcaVAPdDUDkagHPt4zWAxV2Q9wuHPxEsViCV80wqXNa
 1t63aS4+2hOiubDtajEOmQgdF9shZdH+VJdeg0dIdUka6CGRi9xEJgqHvXw+Z/VCedcgdI4ICQ5
 NOektYf8qOImNtdjXA0+E/527XuaWj22Yau9daHYbB6jpe0rUcwfE+xvG+KPTE
X-Received: by 2002:a05:600c:6819:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49cf81fb1acmr58690195e9.2.1788525977863; 
 Fri, 04 Sep 2026 05:46:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm156765385e9.6.2026.09.04.05.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C395618BA;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 038/105] tests/tcg/meson.build: add generic plugin tests
Date: Fri,  4 Sep 2026 13:44:52 +0100
Message-ID: <20260904124604.2207440-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

We add one test for each plugin by picking a different user and system
multiarch test.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-39-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 536def60b44..16292d4d7b0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -90,6 +90,51 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests
+# add a single test for each plugin in user/system multiarch set
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+  normal_tests = []
+
+  # filter tests that are not plugin or gdb tests
+  foreach t: tests
+    foreach src, setup: t
+      if 'plugin_test' in setup or 'gdb_test' in setup
+        continue
+      endif
+      normal_tests += {src: setup}
+    endforeach
+  endforeach
+
+  idx = 0
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    # pick one different test for each plugin
+    foreach src, setup: normal_tests[idx % normal_tests.length()]
+      # copy existing setup and remove existing cflags
+      new_setup = {}
+      foreach key, val: setup
+        if key == 'cflags'
+          continue
+        endif
+        new_setup += {key: val}
+      endforeach
+      new_setup += {'plugin_test': {'plugin': plugin_name}}
+      plugin_tests += {src: new_setup}
+    endforeach
+
+    idx += 1
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.47.3


