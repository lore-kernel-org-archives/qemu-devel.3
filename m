Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74F2C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtK-0005XM-HZ; Fri, 04 Sep 2026 09:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtH-0005VA-Ij
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtF-0008J4-MY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so11558445e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528212; x=1789133012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=giXT6UKBbI5tEb2F5Y8EDvRatVVj6wPPavdz4S0ypzo=;
 b=TLpqm1hl+njjRUIjystIyGWXhvuj05nDWDgnPz6WevwqSQE8lfdTHah3meIF78A46B
 +t0Y40jsj7JAMMwx5KsBot5DXyKzsQamg8PRETUTgC51mGGU3zp9yGWDJUJrV3hlZp5k
 LFgpS386mzE1knZ36DJtBYdbTJypMomCxvEEUfW1Tc9QtvlHUVPYwTVM5F6LTfVTC3mv
 FqV9rR5/PrvV5fWsZ2eys8LuYaTuplaU1uGUzEx0/GZXmTVP2mjcgpR9PT+zEj00VwEr
 QGu4loRpCG1BY2Zn3eM+NAEZGTJt2sR+yDMTJazkardgIpbDYlU5SnBKenOTkHoHWoLN
 DApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528212; x=1789133012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=giXT6UKBbI5tEb2F5Y8EDvRatVVj6wPPavdz4S0ypzo=;
 b=lnt7bUu8PVBNu11wJTvuqi1IApoaMTfAyHMM7dEdQlFE36ifLI3kQ3c8YMg/8IWsUX
 7Yo13x5XmwGYYUP7qZ8Uw+hcRiAjRvdqwX4tdOCcS1WIm/oR+Co7XUSHWw11D870OuKx
 dtkIOfgY1o3aMfny0an6GGri4apXLB0uxezutIfx/smvp3KeE7whPZmDIOcAzaoJpY+x
 A/UnItsv0CPdX8upfn83rcNbuWZi/IIfxtBHRlAamRj3Dm2Vj1q85AXeXiNATix1QfBh
 Tkxea3kCjFIcLeMxO1y+W339lzEPWYz2upO6CJ+0jGuzCh2r8TMs+tRFG6NjF5DeMZ0m
 fUAw==
X-Gm-Message-State: AFuF++kHr6SqlYQ7V0HKpMx+7oW0hXFNdDgtat2peTdRiJFd32u8vJzx
 EmzbLTqmSY4KptHDJkLiUjV0tVb4I/3Ec3/PbDujuA9tcZnBJIj1OOSucgS5mSZEsEM=
X-Gm-Gg: AYBFou0EN6tHTptRir2jUSeD0TXQv/e/hnF8KZx+sULuK0DD+oTQGrQonS42PKC05qj
 LF7zyhRvepf3ThIEclgNZO/2rIfrO61lq949jQovQzYSsaZdpse/bocYyFOYWP0JV2D9L/nQi6P
 LGGrhyNoOrTdG0mlzpsjpQuhF/BHtJaV2gxtHi/ssH01SRbC69fvDwKIvxAHzOPDqjksUZd2yS6
 AUDje4B3RtrnrZLPq8hD8dQUaSXI3etwBD7G95z5cLRsdCoNHQAGeI1TrsWpn5rpRTzJhBlRr22
 vfGNZnrvtNh/oSjDAmy7IyjGeMHGb9o6EDEC3HsGv43hJgJMtNSKx23aA2cz5l9+dLZHJzwfK9c
 ZU+2U3OmN7ien8wV8BZ/PUXTQaRK/c3fUM59/Hz77gUddHlH1baAXa+Jw2sCD1d4oReAiq9HaYH
 Jhwy/fhoOVDW1OtSTQK6c/XKZWj9XaF5LTCvHXP7XwkzxQA8oFi/2JZjjQn5fA
X-Received: by 2002:a05:600c:4f4c:b0:49c:fc6e:8cb8 with SMTP id
 5b1f17b1804b1-49cfc6e8facmr37017115e9.28.1788528212156; 
 Fri, 04 Sep 2026 06:23:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbe5b252sm41506515e9.3.2026.09.04.06.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB80461499;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 015/105] tests/tcg/meson.build: introduce wrapper
Date: Fri,  4 Sep 2026 13:44:29 +0100
Message-ID: <20260904124604.2207440-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-16-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76375615d0b..0311b2432e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -25,6 +25,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -86,7 +87,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -200,6 +201,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


