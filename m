Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950ABC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJM-0006Br-VW; Fri, 04 Sep 2026 08:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJF-000680-6w
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJB-0006qJ-Ev
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so10166015e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525976; x=1789130776; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2dX89X8BAFwj4lkrdRQoFyvJ/0+HE5JadftlOOhDSFw=;
 b=Tqa1e4CqjM078wG9sD7QW6CvbNnqKftq1udDudSKvzJLLMrX+g5wH+nAzjD8WFErzw
 o88i/ahihLSd7qkZlEo6W74jHwwQAZ8NhrfkzJ8pRebLgeFwFkpRyoNb8IAUva463hxh
 nUomT9I06ABxfgrsXtdkcj8aZfHZPdlgeswy7nN75MtDWv6q4kK0y3VohUQivcgCqdJU
 PIOaV5p1k+4y4LquAfqtsAa15w4UYhpm/BALMaerYGEA7adViBaZMBP98rCsPca78ncj
 I4/+yIAAWbmAXI5H4hmqqIUWG/GiminRapNCzgXTW6VR5rUXQfq3QxJ2UZoR7JbmqNZm
 LfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525976; x=1789130776;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2dX89X8BAFwj4lkrdRQoFyvJ/0+HE5JadftlOOhDSFw=;
 b=VQkVZDJFsy3bo+x6T7oy7GIPvIlc/mgmDltDThcXhf3oZzOlWNWP0dckUqi4Hl0q6R
 jb1xUA+6Uf7fPJUhwZJZusdDzIvnjOKhTb8F7LgF8Z0mZ6mHsnsTGCzPAsH8UyBViN0F
 0HE9QWyaWMAbLvZXaLoFBN4i+PLqByyE4r2g13pUL25ZyRoCAdtAVngqcXkI7s9gpk5f
 6Lv9TcxUgaqfOKAjj5+s5GmbuJy/EHGZnDozUfeapq7sgLg7qJy7BtFl/6/mwLuxSI1N
 Qqc/bJgGY1y7A7ADCyAPu2+24LIJ9tnI33HuMoWDnbsBIw2HQaqLDDADILJOZhxr7AaA
 IMbA==
X-Gm-Message-State: AFuF++n7PdnnEALte4LKUSNUYmi5GiUMYzH6w8Uxe4flTMjo4uEk/5AL
 T6clAbMRuyDTDtYJgH3OinHkctX7jifiCi8ZHUAS/Ay3Aomkd15sfNqag6uVycv/VOA=
X-Gm-Gg: AYBFou0+BGMznj86gUE1gkaMY5ro54HEQI12rlvxsym21IF5Q5EDYAt6/l/IckS3pzW
 Cq8qfhj9DWI4uc7SHif76SMoOznp6Mp+jFpZ9H2WfzRPcfWlujDjfdYh4s2XbnlLjHUge2Cdjq9
 avdEcOseX6FCdimCQFgFxukffdhC6QSftH0+2+9XSkWGlk8Lpx4KfmTNI0n4hIAky6se333QQcY
 PlaUl8VGqnS+Hy6q1NWyt4mF4U29MIrNJuiQq9xmAJ/sMRW8w3NeBsMBXOB9Ya0b7KOcajPLU6x
 6kr2qayli+PI12bykR8j+xNvA3wC4mvbu9Kao9n3eZnnogEVorUJmDOUQTto6HKM9mG9eJwAchx
 XrwVfdkHZ8pyuaBvWqV6jofFQ4hB+oWMqiPwzjjK3khVLrBP7yBu96sqkM2fJmaI6Yh9o/CZB5J
 wlpVt/uyBOyV52uiEhSpycCu9VYF6W2lZeo4oVDFJXp1WxUUktov53TvvWGtFi
X-Received: by 2002:a05:600c:4585:b0:49c:fc6c:be16 with SMTP id
 5b1f17b1804b1-49cfea09f08mr16961685e9.28.1788525975434; 
 Fri, 04 Sep 2026 05:46:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7740d44sm145467625e9.15.2026.09.04.05.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1AFF613E0;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 014/105] tests/tcg/meson.build: introduce gdb_test
Date: Fri,  4 Sep 2026 13:44:28 +0100
Message-ID: <20260904124604.2207440-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We can now declare a test requiring gdb interaction, based on
tests/guest-debug/run-test.py.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-15-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3714fe4dc0d..76375615d0b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_gdb_test = find_program('../guest-debug/run-test.py')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -22,6 +23,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
@@ -83,7 +85,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
                    'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -102,6 +104,10 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        continue
+      endif
+
       if 'plugin_test' in setup and not get_option('plugins')
         continue
       endif
@@ -118,7 +124,9 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
-      if 'plugin_test' in setup
+      if 'gdb_test' in setup
+        test_name = 'gdb-' + test_name
+      elif 'plugin_test' in setup
         plugin = test_plugins[setup['plugin_test']['plugin']]
         # remove 'lib' prefix
         plugin_name = fs.stem(plugin).substring(3)
@@ -182,6 +190,16 @@ foreach target, plan: tcg_tests
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
+      if 'gdb_test' in setup
+        cmd = [prog_gdb_test,
+               '--gdb', gdb,
+               '--qemu', qemu,
+               '--qargs', ' '.join(qemu_args),
+               '--bin', exe,
+               setup['gdb_test'],
+              ]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


