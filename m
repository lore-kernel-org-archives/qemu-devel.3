Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD4CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDHx-0007si-M9; Wed, 10 Jun 2026 03:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDHv-0007sR-K7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:23:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDHs-0005rU-Rg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:23:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso5129279f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781076221; x=1781681021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9IcOj5xqFfH6LwjjxsZKsEA79FrufZ1zE7xFNf7tzsQ=;
 b=Dp9S41ITuCjq+2ptIs174orgRNZK3dZDJU9BEHv6FN6/TmHatWcKyqPGDLcB2BLaRQ
 nAnlxoe5g6ogfE2bEcrFJwlxMtG48OLNJffDXCIR36c+2DlNHynYiig1R+mEWynKJ02a
 SlJ8WIxWaoeFMibfjnxWJXxdbtnjpVb4zi1P+vHJ+aAH+A6DOzXHwKBhbm7P7k6OzXVg
 73QepJC4BzrFguao4dYyxlOtTflyQspyK6KGyaENbqcsCNK4RxAKtONdws74Np2WGBbv
 GbpRHT7A6yiettHVmRCreoZ/YCpe8JHH4VO95oT/ejhH0if2ziol8jWi/E4Uz+OnS5HO
 VFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781076221; x=1781681021;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9IcOj5xqFfH6LwjjxsZKsEA79FrufZ1zE7xFNf7tzsQ=;
 b=FOqDJ1X4q+DcvIHbqtJ14qW37xtCBG7Q3X56F5dI+MQGkLkWAzFFP+V+68UfFBmlm7
 mrAdBXtCahxIkPDoBzDriuC0eXwUpqnTXu+3S2xilq/SCWt7yWFsAEWok+ZodeQAxq2j
 z6FhraY6ClUek49GK8mVIx1iDtkYdtXLpiZrUS/ei6WnYsKUz9qTufuHSKHdv+1FZU8K
 jZ1LpXk2MymeZ6Wd1C1X81fwJ6MkBXasmnR2GrSc6DZn8eQJpTtw8h1BDWDsevZ+ns42
 xtxiLPqTlXeEhmE5ljzft7IBUk6OzlHveBaniGLPWsVkUrYa0LQHZ8lyLQQqGN0lnnBe
 uSXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KNbBH2CgB6kpEBsO5GFVHXvm771B2naJmQzsciJTgzExzcenflR6gxpniIU+ys22y4EvpJ+g9qdla@nongnu.org
X-Gm-Message-State: AOJu0YyJW22JdF7aH84XZvNMSmKhgbczG//e4/L1xn9Cag+QlZEhHAoZ
 KHDmljeYrhKTOxfoEfZziXSV6/0PF19ddW6tfgdjZCGmY3/mYCOfNvq70DY/ZoEBJBQ=
X-Gm-Gg: Acq92OE48Xu92/WfriXIthkT4ONpKLl1NuqDAMp6lDX0wbBOVTpr1wCwZq3jX+zO+3z
 pWK9wm6YjKsJGEBGLOcZP1MPHg0sKlPx9cgmBSomq398AvWncoYwfINOwHvEPx/yfli/OP5X+uu
 ab+85YIwzR79g4aQKBi1xQqVwgf3wq7BGGd1ORwhcXX2xVrkI1KnroV5eyzDLGcmCT6eaw7Z6ai
 o7aPfy4pTZ0Cdxz+NPw6OWkWV42M2Zlmkdu8pJ0QCMwPUNoVCWTbNc0JyYs1o8DPnJxgIuzx+rf
 eL5vdLR/0Oo+Uo8rd3ynmj3nh8P75prb2AFx2yGaJAiiBXVdmxn3bQ6IB2FqameB1HLBJi35+7z
 SOy3vx9nnM50Hr3z9TBjig9ynhs4X0jEiAENqeVFdiEnjuv5RNhZ2YcMx42zoih8W/7lDn9hiHC
 cpjg0cyuaD0T2v+JcxgrZPgsshpd8B3QDuxKHW0MlpugE10AjTYaD2JEBMhbutkRqy9KH3F1ihK
 4yI4TpGml4/zhfrmg0V6S6J6+YO2FFTQykgbD6kPCtQJzzbWCYTO+gZD2xuNUDe
X-Received: by 2002:adf:fb85:0:b0:45e:e44b:312b with SMTP id
 ffacd0b85a97d-460305061a9mr28865714f8f.18.1781076220915; 
 Wed, 10 Jun 2026 00:23:40 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344148sm66404201f8f.19.2026.06.10.00.23.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:23:40 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:23:23 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 13/27] tests/tcg/meson.build: introduce gdb_test
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-14-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-14-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgen7f.2dkbxc5oftbiv@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Wed, 10 Jun 2026 00:47, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We can now declare a test requiring gdb interaction, based on
>tests/guest-debug/run-test.py.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 22 ++++++++++++++++++++--
> 1 file changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 1496cba460c..d0080eb0f9f 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
>   gdb_progs = [config_host['GDB'], gdb_progs]
> endif
> gdb = find_program(gdb_progs, required: false)
>+prog_gdb_test = find_program('../guest-debug/run-test.py')
> 
> tcg_tests = {}
> # tcg_tests is a dictionary with following structure:
>@@ -22,6 +23,7 @@ tcg_tests = {}
> #           'test_name': ['provide an alternative test name'],
> #           'cflags': ['cflags to compile test', ...],
> #           'qemu_args': ['qemu command line flags', ...],
>+#           'gdb_test': ['gdb test args'],
> #           'env_var': ['VAR=value', ...],
> #           'plugin_test': {
> #             'plugin': 'plugin_name',
>@@ -80,7 +82,7 @@ foreach target, plan: tcg_tests
>     foreach src, setup: t
>       # return a clear error if user mispell a setup entry
>       foreach key, _ : setup
>-        if key not in ['cflags', 'qemu_args',
>+        if key not in ['cflags', 'qemu_args', 'gdb_test',
>                        'exe_name', 'test_name', 'env_var', 'plugin_test',
>                        ]
>           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
>@@ -96,6 +98,10 @@ foreach target, plan: tcg_tests
>         endforeach
>       endif
> 
>+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
>+        continue
>+      endif
>+
>       if 'plugin_test' in setup and not get_option('plugins')
>         continue
>       endif
>@@ -113,7 +119,9 @@ foreach target, plan: tcg_tests
>       if 'test_name' in setup
>         test_name = setup['test_name']
>       endif
>-      if 'plugin_test' in setup
>+      if 'gdb_test' in setup
>+        test_name = 'gdb-' + test_name
>+      elif 'plugin_test' in setup
>         # remove lib prefix
>         plugin = test_plugins[setup['plugin_test']['plugin']]
>         plugin_name = fs.stem(plugin).substring(3)
>@@ -177,6 +185,16 @@ foreach target, plan: tcg_tests
>       exe = built_tests[exe_name]
>       cmd = [qemu, qemu_args, exe]
> 
>+      if 'gdb_test' in setup
>+        cmd = [prog_gdb_test,
>+               '--gdb', gdb,
>+               '--qemu', qemu,
>+               '--qargs', ' '.join(qemu_args),
>+               '--bin', exe,
>+               setup['gdb_test'],
>+              ]
>+      endif
>+
>       # some tests expect QEMU env var to be set
>       cmd = ['QEMU=' + qemu.full_path(), cmd]
> 
>-- 
>2.43.0
>

