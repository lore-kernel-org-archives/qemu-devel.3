Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97674C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5cm-0005hD-3B; Fri, 10 Jul 2026 03:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5ck-0005gX-2v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:26:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5ci-0005mh-Fq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:26:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so3764475e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783668371; x=1784273171; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZqNi9WJLtFQuoHzUsWeADXqK5vfQV1iFM6CsQcSPwvk=;
 b=fZnVP+0L7lw/EQi4qTzPWUJnUqm5r7XHvTQNxi4rlV2fJ94dAopsubHgriJ0OQyB/x
 +h373fY407oZ3KxXkGaGT0SPo1AdyTaJ8VRM9O0MQ09wuWjzVX6Gar2UUrgh95jtPNu1
 hf0gtA4pW4wnDiAQh8iacUscVpNLzZdIsmvO4pVzH3Oh2YrmnqP7MZ7tFpgpNX06SZJP
 ReKBBGpu8os4wrk9ejplEg2wNr4yyi/v5YnG5xPNWK9bci8n+2YkgNPRVqCPPWbRdxfG
 RAf7wWXhlSuGFu4wmxgwXdT6AdshvG6rxWjP7nIbentOKmLJOTJTawyXI/pR6V462Ygb
 aWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783668371; x=1784273171;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZqNi9WJLtFQuoHzUsWeADXqK5vfQV1iFM6CsQcSPwvk=;
 b=TQWjIGPEg/VyD5ptvibK8+bIrU/KA6UTq1YaDB+jQYW9Ip12XvJv3r7jV5o5m4GzDY
 cB9X+95wuz+yq1lFjLAizVW1Lnr/sKWjVMiXqG6sKjCmVpGS7mwfXWYsLzk8mhXggnCk
 gM4xiFnX9TlWMi0p0c8+vuD6RFKTUkkDn/sQCmxjCXbOfgXMH6hY/GI9emdEdbFF6NKc
 jyarRamV1cZ/r8DfqWBU/oGdk9lVThIV5V98Fj+ujnhUrjswfw0fZIdt3FBAtMl6wHpW
 RT6loXeDq6W7CG1TiShGeX1ZEmHp+MlKeQuHA6eznkTd23U7lGdd5yjU0maUqSUoDv5A
 QODg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnEk2c86FJ6o4sqlTtg4N784fznogDyfSq1Fcf1Oe2rYu0jFTdk2qM1eQ+zCbBfigOcIJFb5qUKgJ9@nongnu.org
X-Gm-Message-State: AOJu0YyYMkCOfb1pSouGLvyHr/EGvDPMCIMqpGmgXO0AQaIlw1qxnisv
 mNQnIAVDIx1dzX1frdbZdCSuLXiRYAK69PBA8ck/nG9Y2RhCJpJyKzARuv8gA/AXxiI=
X-Gm-Gg: AfdE7cl8yQdkcA9EUhXou7djMvpfJXgMOMQ/WtXKVpfdQ+UNI8OojPlR+24vL73z84w
 G7zeEBEIl3D/4sKOukkKnHlQCM6dWa4RFZG8dBKcXz6JsymCgwJO7KnaDRgfktFWd10xgwWjTdA
 fpxoVA6pxyjWt7A6i/MNttb8wedrFvitFgRhDKFPFqz6lJifexE3BMogzXkbuu5abN+sdylYaJd
 2TIbUGCu0S3WGzs77xiMD1k2X848SL98ngFxeAE+CjkfY18XMhIFdtNpigSOXWPLil99nH89gHo
 mZEKsT2Ld0ANl4rtB+rL1ZnT8Vq1MT7oubNQ4+GZoXInPYvdc7lW96dh+SzQ7FgVIExjTW7QPfi
 WNtf9eTowMt7Uxr27enFv5ZPJneLmd7RJxuKR61Z2SBibIeJKocRqhvI+7l9or69XSSD14m2Bqi
 sVHxf+0RNf0+w8qSOzojJRhrzolacgEoPNUDVoRo5ToSX5avfqPKzdvk9ffVsmeoY39x2khGx24
 KkbaIMGzfs4kPArF2VhJbbEPH7uXQPmjbKhjbgWJsIoHsOXtZumla90lgXeisv58mLxRyrqrmNj
 wACNP1AmtosErhiZqOWsNl7S+++2m6oDhqpXA8GfYaoIKe3NQj+a+3M=
X-Received: by 2002:a05:600c:4754:b0:493:c8f7:3631 with SMTP id
 5b1f17b1804b1-493e68df99fmr98466245e9.22.1783668370616; 
 Fri, 10 Jul 2026 00:26:10 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4cbc620sm18668015e9.13.2026.07.10.00.26.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2026 00:26:10 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:25:55 +0300
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
Subject: Re: [PATCH v4 25/97] tests/tcg/meson.build: let test infrastructure
 detect compiler
User-Agent: meli/0.8.13
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710062016.1818125-26-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260710062016.1818125-26-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thy7bl.36jyggi3vup8o@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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
>Now we moved back flags to tests/tcg/meson.build, we don't need to
>expose cc anymore in target files.
>This will allow us to easily introduce cross containers.
>Also, we can reuse the skip_test logic to gracefully report why tests
>don't run.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 19 ++++++++++++++-----
> 1 file changed, 14 insertions(+), 5 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 572003f4ee7..cb58ad25a1a 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -19,7 +19,7 @@ tcg_tests = {}
> #
> # {
> #   'name_of_target': {
>-#     'cc': cross_compiler,
>+#     'cc': 'cross_compiler',
> #     'cc_feat_cflags': {
> #       'name': ['feature cflags'],
> #       ...
>@@ -96,7 +96,7 @@ foreach target, plan: tcg_tests
>     endif
>   endforeach
> 
>-  cc = plan['cc']
>+  cc = find_program(plan['cc'], required : false)
>   folder = plan['folder']
>   gdb_arch = plan['gdb_arch']
>   qemu = plan['qemu']
>@@ -189,9 +189,13 @@ foreach target, plan: tcg_tests
>       if 'cc_feat' in setup
>         cc_feat = setup['cc_feat']
>         if cc_feat not in cc_has_feat
>-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
>-                            check: false)
>-          avail = cmd.returncode() == 0
>+          avail = false
>+          if cc.found()
>+            cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
>+                               cc_feat_cflags[cc_feat]],
>+                              check: false)
>+            avail = cmd.returncode() == 0
>+          endif
>           cc_has_feat += {cc_feat: avail}
>         endif
> 
>@@ -202,6 +206,11 @@ foreach target, plan: tcg_tests
>         cflags += cc_feat_cflags[cc_feat]
>       endif
> 
>+      if not cc.found()
>+        skip_test = 'compiler ' + plan['cc'] + ' not available'
>+        built_tests += {exe_name: exe_name}
>+      endif
>+
>       # build executable if needed
>       if exe_name not in built_tests
>         exe = custom_target(exe_name,
>-- 
>2.47.3
>

