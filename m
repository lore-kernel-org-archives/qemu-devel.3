Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24953CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDFF-0006u1-Th; Wed, 10 Jun 2026 03:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDFE-0006te-4Y
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:21:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDFC-0004Rd-B7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:20:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so41736375e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781076056; x=1781680856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xu9ErmaLxhJkLLu5r/Q5TOUBF/47GHYmfvItnStOga4=;
 b=vETfGaW1kKgfuha2zbcDcFZNuQCLrVxAvL9WPJn/T5Qy3c49KdO+TFxh3c3TGVegN8
 Rv+2YWSrTi0IgSXCQ/oB1wjSV7kKYo+1R4yQxdtsVBh3S1J5ANx6EaWpAFa0VdbcazMJ
 9waUw4UtuP0AVdi+HCCrpSjPY7zx01M7bNBZc3N2tBfCnG4HeWr1Y1mGLs9S+k5ViACh
 UGrAITKfhLpzOx3hvXQxx+6ewb3eAGjUM7dZbtL8sTr5M1rryjQRTNT10k8Ty6YPpBQr
 Gykl4vj312EIBCbORe9Kf9jEkrBNNbwr8YrgeuN8xVVG/v9LBDKo97LmElr/ApIgQX6U
 +h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781076056; x=1781680856;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xu9ErmaLxhJkLLu5r/Q5TOUBF/47GHYmfvItnStOga4=;
 b=hr8IAzpQEuZSjMZepaDsxLmKX/mP29lbDi5Smqpbt6fToEiDSiWdR4Wc+k9BIU/Fns
 w5Ok6a+jAPiZSOPN5YG0ennkAJJyyv+sadPrTeKbURBAQ8/c7AEbjyC1wABhGA2fYUh1
 fgDIdMT6IQzRsAT4Bjgr+wsL23JwVUoBkLYwZD6zTLncLjrsKdKQUb98Y66GS4z00hAn
 Sq3H7VROU45axGbQhqsE+LkrgEjUvuDlGfVwvhNhj39PwehlJMbiMoiLOxRgN4CLaeKG
 yMOkMK4SWObQsglDFCMYQttrG87vWRgjzOL5kd94roEzy0B9VzoYX8fHXc1hQQtYBHdU
 ERoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8jYUQorji7D3kDOKO2wZqV246gZUPOKj1byioBIiF7ZX6XyRgA+xHSBewfBT8e4BKrs46bZXDDpI5@nongnu.org
X-Gm-Message-State: AOJu0YzhglfDpcApUbZaxGb30R1IIYmca776aKPnmRf/GgxalHktF4BJ
 bMHB0TJzSAaYKLS5fH6NHz7B91UbruwI67IQZhz0rSDJOZVHdcgJD3z1gUxptzJg2WA=
X-Gm-Gg: Acq92OFdOXwH3/KNKjmibdTcuTYd9nqZQtFEqr4R3X63TCSQ8G7VDVg+Q87DUpOvxlA
 Z3cEDwyVH8u5sV5ZUyGoY00I37oI0Lrs55PnPFmw0xM8EBCj3tW9CYngRDlPcq3h8dPOdjziYHD
 PMCZZIqGhd4EFgkueG0kDzzGOLhKy2jhk7htgTJDe/rUDVozrGL4lYoDoUzyjcTa5gFVI+qouCZ
 9P7nhpGQkh5l+ZDyPsiYQete3gk+8pGxxkg4pR5j0KWxE71eTs1TEnOho/vsR+O3hfTUwuZ9jrA
 PYzetcV7UhHz0Qr3QKCCobM0j6Y6DP3n+bYw4DSFd+j+nyIq0YdHU6eYUnMWoooh6DT1TbpzDH1
 q2FCEUSEQF5lzkqzRpbS/Ye0KFmDIsZWQKdjx4Yv0/IEd+vGlxjE49jnd4p8VR2FEcz9NlfJkCZ
 +vKXPzTwONz2slL5K2GpiH6NkJprdX0gWyc5XAlxQHqbDOW+L2C1MQ2Auhk+0Yp4My2WAaLaRru
 dy+aIt6PVK0cvgQPPwHJbX6IlcjhJd4QQv/Aw6UYtBMOfZQ5NQA5drfAAkH0CP1MvzZ2jC0LWQ=
X-Received: by 2002:a05:600c:450a:b0:490:c2a2:b1d3 with SMTP id
 5b1f17b1804b1-490c2a2b3c6mr352082145e9.34.1781076055627; 
 Wed, 10 Jun 2026 00:20:55 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc413adbsm547220935e9.15.2026.06.10.00.20.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:20:55 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:17:10 +0300
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
Subject: Re: [PATCH 11/27] tests/tcg/meson.build: introduce plugin_test
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-12-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-12-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgen2u.3c957rnxjp0lu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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
>We add possibility to declare a test that is based on a plugin.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---
> tests/tcg/meson.build | 40 +++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 39 insertions(+), 1 deletion(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 5cd80f3c030..a47f1ada779 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -16,6 +16,10 @@ tcg_tests = {}
> #           'cflags': ['cflags to compile test', ...],
> #           'qemu_args': ['qemu command line flags', ...],
> #           'env_var': ['VAR=value', ...],
>+#           'plugin_test': {
>+#             'plugin': 'plugin_name',
>+#             'args': ['plugin_args', ...],
>+#           },
> #         }
> #       },
> #       ...
>@@ -57,12 +61,25 @@ foreach target, plan: tcg_tests
>       # return a clear error if user mispell a setup entry
>       foreach key, _ : setup
>         if key not in ['cflags', 'qemu_args',
>-                       'exe_name', 'test_name', 'env_var',
>+                       'exe_name', 'test_name', 'env_var', 'plugin_test',
>                        ]
>           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
>         endif
>       endforeach
> 
>+      # return a clear error if user mispell a plugin entry

misspells :D haha

>+      if 'plugin_test' in setup
>+        foreach key, _ : setup['plugin_test']
>+          if key not in ['plugin', 'args']
>+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src)
>+          endif
>+        endforeach
>+      endif
>+
>+      if 'plugin_test' in setup and not get_option('plugins')
>+        continue
>+      endif
>+
>       # meson '/' operator drops left operand if right is an absolute path
>       src = folder / src
>       file = files(src)
>@@ -76,6 +93,12 @@ foreach target, plan: tcg_tests
>       if 'test_name' in setup
>         test_name = setup['test_name']
>       endif
>+      if 'plugin_test' in setup
>+        # remove lib prefix
>+        plugin = test_plugins[setup['plugin_test']['plugin']]
>+        plugin_name = fs.stem(plugin).substring(3)

Why skip the first 3 chars? Maybe add a comment like you do elsewhere 
for unclear lines (suggestion).

Regardless of my comments:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
>+      endif
> 
>       exe_name = target + '-' + exe_name
>       test_name = target + '-' + test_name
>@@ -116,6 +139,21 @@ foreach target, plan: tcg_tests
>         qemu_args = setup['qemu_args']
>       endif
> 
>+      if 'plugin_test' in setup
>+        plugin_setup = setup['plugin_test']
>+        plugin = test_plugins[plugin_setup['plugin']]
>+        plugin_args = []
>+        if 'args' in plugin_setup
>+          # add empty arg to generate an additional comma
>+          plugin_args = ['', plugin_setup['args']]
>+        endif
>+        plugin_args = ','.join(plugin_args)
>+
>+        # since we turn plugin into a string, add dependency explicitly
>+        depends += plugin
>+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
>+      endif
>+
>       exe = built_tests[exe_name]
>       cmd = [qemu, qemu_args, exe]
> 
>-- 
>2.43.0
>

