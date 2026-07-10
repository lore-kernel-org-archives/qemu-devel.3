Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5ZG-0004EE-La; Fri, 10 Jul 2026 03:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5ZE-0004Dz-5y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:22:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5ZC-0005Mv-A8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:22:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so352208f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783668152; x=1784272952; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6Pjwxn0IT/CDl9FWftbL9n+IvXjCZFZpqxplrn1uPXU=;
 b=HE/JjGaK6aFooGZujZMqKRPx6OP0AALswgAqzFGoDFkBfxNT9U4aQaQn9E6lY2f+Rf
 v/KWC5F5pCefvIf2hEVcUJOx/bTw7UMktwh6SDbMwhfFPiFzD3JRav7SGjXk4mrm3Fzw
 tEEDetlyWRcQhEoDZBP+VOI1usK+2Lh2Tj2idl9tWR8lz36sFNgwd3IA0coMPaw1BfBY
 klCItTSJDol0hV1JaRMfs8ebPMzXJeBfxxu2aEl7qT+qCmFFonnNhbwBlIJ0v3A9pZ3x
 j0GTqjFWojAYih6w7O6tZKPwUw61L+V9xXjeA0GwZv/FLT2tk6EHL1OeleiId6EwXEqx
 kWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783668152; x=1784272952;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Pjwxn0IT/CDl9FWftbL9n+IvXjCZFZpqxplrn1uPXU=;
 b=gr9IgMESVygjF9zoIV+7Zun1r/icWaeFxPdHingu1dEythflnL/ZDI1xSELGJw1hs0
 pDu3RTDp8l5uatxP3qYdBWiZSNnt/2lYWu6ypGEI2PVohaeosA2sqtNHgNZmn7oY0/v7
 1HjfzYXnCWQV1edu3aI5oOiV8+z4GvlWVilHm4fXGstlfnZSYyvMCe/YLJk/91ifleG8
 WhEwvwUwLyjeAhmvo5yHi8EUXzvUtFImu2SJIV+zbIRmQImMKyNGf9svvDvoOJ7lE/3s
 Dt4+bLvNAcUcn1Me1Zli411r+8frKkzoe3ZjnxMdg+du5MGde3mGbzEj395plB0BvcKc
 yO9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrfpq8BmRTEeZ8+06UnVCChpHWshSNWK62GcXn1hAbBBmST7svDdcebspr6WCEbDzoCL1vixt02Jk7S@nongnu.org
X-Gm-Message-State: AOJu0Yxn0nKzgwumrx6GuP8HRpX69B1Z65eWAQuIxJdZTG0RhEQVZmLV
 02EA9UG+o8fmqmndSuNJDxW+J/dMuqaRuqgcTMGFJ+OkvRJuLqam37oWkwG//avhMzA=
X-Gm-Gg: AfdE7cmncuiJXNSDEuOo5VlMxQaJDwlD3Vkda+aL5I3SOR9sDz9GQj8RW0Y/Z2DVEMO
 RL9/50T3QldjJ5iHaMjPopzHO+2FRIgCCtnPh3PJC8YB7M/b3TWwtrHSC0z2pWUgxmVwM6dmFOg
 +63jGxSdbCQN4PGbJFEKJwOEItW28NrCKVzZKimOX5EMcBdfXoh1MF4EgT18Bbe8tYifouvJjRS
 IzGcX/Agu51TAxQyTesWfRv/5dVIIP7cruds1DmRT8TJtmgy26b2YL40obZUb3KV6mnf1lNT8MC
 M44Mp0BD4VxpP8ADRuXIKnGwqOuC1gjiJ9deIDbMfSbX8+cLQLbz44M62VBR6AZ54nOJt5fAbX9
 Ug899uo6LsGX/tOaGwROuQ5pOcZXjgEHKqadDkmwUy6F1pDIKIPaawB4mQJw8fvJ+wZL0lWJQQM
 9QL74Yk2u4J6Ytz9Sxq/LenTvpxupZVN/JNrtK3vJkvDdspVCeS0a8ie1ZHbQ7oRzlNoUO4xVd8
 LAlA7FXmv0Q9q89gLdn/d6dWGEU2woQb2iklf9zGOXbKSEf9W6lNGrECpdGjy/QGA5oT5yTlaqf
 9d1LCtw5VMwvVnQCSx82SGRR3URUZrf0zlcjsDHamZAmkyQSoDD9xoY=
X-Received: by 2002:a05:6000:41ee:b0:46e:6210:ad4a with SMTP id
 ffacd0b85a97d-47df071e518mr10185413f8f.5.1783668151974; 
 Fri, 10 Jul 2026 00:22:31 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm52866846f8f.31.2026.07.10.00.22.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2026 00:22:31 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:19:48 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6ll?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Philippe Mathieu-Daud=?UTF-8?B?w6k=?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v4 22/97] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
User-Agent: meli/0.8.13
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710062016.1818125-23-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260710062016.1818125-23-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thy75i.2ycx7hqouutmv@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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

On Fri, 10 Jul 2026 09:19, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We directly move compiler requirements in test definition. This allows
>to always declare all tests, and let the main loop filter the ones
>that will be available.
>
>Tested-by: Alex Bennée <alex.bennee@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 43 +++++++++++++++++++++++++++++++++++++------
> 1 file changed, 37 insertions(+), 6 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 05d54093709..26eb17fe17a 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -20,6 +20,10 @@ tcg_tests = {}
> # {
> #   'name_of_target': {
> #     'cc': cross_compiler,
>+#     'cc_feat_cflags': {
>+#       'name': ['feature cflags'],
>+#       ...
>+#     },
> #     'folder': 'folder_for_test_src_files',
> #     'gdb_arch': 'gdb architecture requirement',
> #     'qemu': emulators['qemu-...'],
>@@ -29,6 +33,7 @@ tcg_tests = {}
> #           'exe_name': ['provide an alternative binary name'],
> #           'test_name': ['provide an alternative test name'],
> #           'cflags': ['additional cflags to compile test', ...],
>+#           'cc_feat': 'feature name, must be present in cc_feat_cflags',
> #           'qemu_args': ['qemu command line flags', ...],
> #           'expected_output': 'file_to_compare_output',
> #           'gdb_test': ['gdb test args'],
>@@ -74,10 +79,11 @@ foreach target, plan: tcg_tests
>   # choose how to deal with it.
>   built_tests = {}
>   added_tests = {}
>+  cc_has_feat = {}
> 
>   # return a clear error if user misspell a target entry
>   foreach key, _ : plan
>-    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
>+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
>     if key not in allowed
>       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
>             ' (possible: [' + ', '.join(allowed) + '])')
>@@ -88,13 +94,17 @@ foreach target, plan: tcg_tests
>   folder = plan['folder']
>   gdb_arch = plan['gdb_arch']
>   qemu = plan['qemu']
>+  cc_feat_cflags = {}
>+  if 'cc_feat_cflags' in plan
>+    cc_feat_cflags = plan['cc_feat_cflags']
>+  endif
>   tests = plan['tests']
> 
>   foreach t : tests
>     foreach src, setup: t
>       # return a clear error if user misspell a setup entry
>       foreach key, _ : setup
>-        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
>+        allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
>                    'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
>                    'wrapper']
>         if key not in allowed
>@@ -155,15 +165,36 @@ foreach target, plan: tcg_tests
>               'specify a different \'test_name\'')
>       endif
> 
>+      if 'cflags' in setup or 'cc_feat' in setup
>+        if exe_name in built_tests
>+          error('test ' + exe_name +
>+                ' was already built with cflags or cc_feat:' +
>+                ' remove cflags, cc_feat, or set \'exe_name\'' +
>+                ' (if cflags are different)')
>+        endif
>+      endif
>+
>       cflags = []
>       if 'cflags' in setup
>-        if exe_name in built_tests
>-          error('test ' + exe_name + ' was already built with cflags: ' +
>-                'remove cflags or set \'exe_name\' (if cflags are different)')
>-        endif
>         cflags = setup['cflags']
>       endif
> 
>+      if 'cc_feat' in setup
>+        cc_feat = setup['cc_feat']
>+        if cc_feat not in cc_has_feat
>+          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
>+                            check: false)
>+          avail = cmd.returncode() == 0
>+          cc_has_feat += {cc_feat: avail}
>+        endif
>+
>+        if not cc_has_feat[cc_feat]
>+          skip_test = 'compiler feature ' + cc_feat + ' not supported'
>+          built_tests += {exe_name: exe_name}
>+        endif
>+        cflags += cc_feat_cflags[cc_feat]
>+      endif
>+
>       # build executable if needed
>       if exe_name not in built_tests
>         exe = custom_target(exe_name,
>-- 
>2.47.3
>

