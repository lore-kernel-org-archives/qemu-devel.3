Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB140C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5aV-0004dv-6P; Fri, 10 Jul 2026 03:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5aT-0004dk-Ia
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:23:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5aR-0005SX-MB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:23:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso2823715e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783668230; x=1784273030; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vGqwAR5x9V2yxH0HCoEkGh00RINGawCoz4STBTMDego=;
 b=h/bMRQ0EkM9/nqBKYwclrD0xYtywnpEQmD1P3nNXddZ0JKsSQzvFUQN/QK/AFYphGw
 Ulus4ZBnNxvIiW0ttLLNwngwyhRORLlwbWuOCunzxbEkK1IUbAjf54cbacXy9+F6OBtO
 xX+AoQ13TRB1O//chO+VP8FIUEiI29lR63KM8phFgebGblHFnd7W9CCiLFJFV3LFx6KM
 pUevLlSO84388DPar8jsGXYTM+EAni+CdJxzibpLJpsIWsJcPQ4shuVFtyWhyM1twm4p
 3ieMN+tUdPoOzDkQ9PVLoCagRb7dvr+SSSnTiduz/udPioB5rWqi93qLDpm+dkno7TE+
 LLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783668230; x=1784273030;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vGqwAR5x9V2yxH0HCoEkGh00RINGawCoz4STBTMDego=;
 b=dBonkPJaUPXMKIVCQhsIXBDO33TJp7XCPgR7yPfLQyivBTurYifvFEo7fY3zrajpCY
 x5U8k956WFO3t4dd1jeiL5Fm2yVLFtzsS3atLxOu6Rc/RjES5FOHS0RPwyV5NF5v7GCg
 nT1MtzTb/1VGs4m9L2p3GewY90mvhLaimJxY+LtVnMEe9IPk9RZiwLogReYHd+PbjzIi
 Tmaw3SqUumkemEG1uGrbECd7PSjBhf4zKjd7l5fmooIRoh5yC1xgd9H5mv3H9IpyD8zw
 ufUsAzN9qNKL96CbDgyNRKM0Je+uxbHF9ubHjItvsuiQr2EHIjlhjmuZkErtX2EjlLNU
 IQ7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1EI0EG3lz6McCy1JjDT09E0FDVK2GDPA73jl1vRgv6gVDrFF+AJVh8X/cd7DyR0jhqLBRfqOOoZ4w@nongnu.org
X-Gm-Message-State: AOJu0Yx4LSFpSD/u/H5Jx+3zWMBo0pK9s5gZsWpW7wR4Y8iX+coR7soh
 Jp2oZmtJ/HeyFdr9xqnlJiaEZ6srRBNdYwYlXltbvMXdyXAU7wnbBebYdzInmI6mpq4=
X-Gm-Gg: AfdE7cmWl1hpxaPbQxS+s+hbKfXrHLESocuYhBcyaqlbcfv6L7sYeq3UdTRFocle8rW
 zeDF1KMlE0KJzqjHBbeYeo3klKyTUhDugsp57mA5fwyIZdP2TdhtSmA9uaI4VS/bJf7oUeM2rq1
 5shqJSunP687NMSR6JyP7VQpHrLo3p994j4RElbqtSe+rd3YYSifY2cKQ2lxmNr/196uJQEJFJl
 RIG37IO4s7Jxy0Smam2XKFwLzb57w7JAjiwn6GUdAPspW+ubTIKOOJAIZ34O1Zd6Xu+yU8b4f2D
 9Wssgv7yUGEI4ZlMPz6qFCqdM9DgkejADdBwfBcQyWkU2NGu8ZqE6UIJqrppvB6NyoD5qf7eRt/
 SWzpl5U2324joIRU+pZEIaLjBVBMs1SOHO7oD9nlZz0Wk5kZfRAPN0+0tjlUAC+ykEi8TW8Iyyn
 ViHUCeE0STAMRJIK8l8KZqDUCC5h4XB8En7Txa1j5o3Wc5amUqXIaH7b7UqeZmLTjWD31F5EApn
 qYlSLhAnmwGXit0ysYMh2wYAHxrGrFxfFbWKv8YeNbKC5u2MGCAX5SneVgbMWNa8nazXmD8H/sT
 D9L1IZQCoD38qnc+Z9nmqW7UXLLDpy5miJH9UXwWjZxaCIF+Dv/Tno6C64pmKOssUg==
X-Received: by 2002:a05:600c:4694:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-493e68ddd36mr97420945e9.18.1783668229906; 
 Fri, 10 Jul 2026 00:23:49 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm196617285e9.14.2026.07.10.00.23.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2026 00:23:49 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:22:43 +0300
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
Subject: Re: [PATCH v4 23/97] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
User-Agent: meli/0.8.13
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710062016.1818125-24-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260710062016.1818125-24-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thy77o.3edjawk7gm117@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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
>Similar to cc features, we declare the same for gdb. With both
>available, we can now declare all tests inconditionally.
>
>Tested-by: Alex Bennée <alex.bennee@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 29 ++++++++++++++++++++++++++---
> 1 file changed, 26 insertions(+), 3 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 26eb17fe17a..993a948bb80 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -26,6 +26,10 @@ tcg_tests = {}
> #     },
> #     'folder': 'folder_for_test_src_files',
> #     'gdb_arch': 'gdb architecture requirement',
>+#     'gdb_feat_version': {
>+#       'name': ['minimal gdb version supporting feature'],
>+#       ...
>+#     },
> #     'qemu': emulators['qemu-...'],
> #     'tests': [
> #       {
>@@ -37,6 +41,7 @@ tcg_tests = {}
> #           'qemu_args': ['qemu command line flags', ...],
> #           'expected_output': 'file_to_compare_output',
> #           'gdb_test': ['gdb test args'],
>+#           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
> #           'env_var': ['VAR=value', ...],
> #           'wrapper': [program_to_launch_test, 'args'...],
> #           'plugin_test': {
>@@ -83,7 +88,8 @@ foreach target, plan: tcg_tests
> 
>   # return a clear error if user misspell a target entry
>   foreach key, _ : plan
>-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
>+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
>+               'qemu', 'tests']
>     if key not in allowed
>       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
>             ' (possible: [' + ', '.join(allowed) + '])')
>@@ -98,6 +104,11 @@ foreach target, plan: tcg_tests
>   if 'cc_feat_cflags' in plan
>     cc_feat_cflags = plan['cc_feat_cflags']
>   endif
>+  gdb_feat_version = {}
>+  if 'gdb_feat_version' in plan
>+    gdb_feat_version = plan['gdb_feat_version']
>+  endif
>+
>   tests = plan['tests']
> 
>   foreach t : tests
>@@ -105,8 +116,8 @@ foreach target, plan: tcg_tests
>       # return a clear error if user misspell a setup entry
>       foreach key, _ : setup
>         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
>-                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
>-                   'wrapper']
>+                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
>+                   'test_name', 'wrapper']
>         if key not in allowed
>           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
>                 ' (possible: [' + ', '.join(allowed) + '])')
>@@ -261,6 +272,18 @@ foreach target, plan: tcg_tests
>         cmd = [setup['env_var'], cmd]
>       endif
> 
>+      if 'gdb_feat' in setup
>+        if 'gdb_test' not in setup
>+          error('test ' + test_name + ' is not a gdb test, but it requires ' +
>+                'a gdb feature')
>+        endif
>+        gdb_feat = setup['gdb_feat']
>+
>+        if not gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
>+          skip_test = 'gdb feature ' + gdb_feat + ' not supported'
>+        endif
>+      endif
>+
>       if skip_test != ''
>         # still declare test, but skip it and print reason
>         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
>-- 
>2.47.3
>

