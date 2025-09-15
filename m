Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 22:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyHKt-0004nq-Kn; Mon, 15 Sep 2025 18:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHI4-0002sY-KJ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:03:16 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHHO-00008F-QK
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:03:05 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2dbso3342047a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757973748; x=1758578548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FQYoLYpKnTTM6AHc4a2BrPKtAPMVqixOWkEVebIGKLU=;
 b=Ggar2f6Td0mqxCqVeAHxF2xIQFtecfUfF/iJCh0WlO1KJEgpLPb7wNlMjmfjbUt8+f
 UUjc1ZEkXg21ZaHUGXPhH/1r5F1grWyBkQ4YxJ9ryTHYLNRMwW+aKjwfbVxOJO9pZ9/e
 MVg6LE/Za/ll97xjOub/K7cRW65U1j2o/MtBqOCQNKjKiwEIKAfKryX359j6HnDIG0pv
 n5wdkZhMFMa1Mbkv32lCvqseZLNXWI3MD5SZ5jynQ8zK3Ksdz/4Gtt1a5xifNMcHR4zZ
 aODWdpNwCZ4Az+sre2GUH1aCTpe6sbuCmLA7UFpxUxChSHnHw3I/tlX6ylyfKftcTn6W
 F4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757973748; x=1758578548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQYoLYpKnTTM6AHc4a2BrPKtAPMVqixOWkEVebIGKLU=;
 b=W/6TiFkGqRYT0S3UyqvUmEcxwOmpCKByQ2a968ucM3XnqI6P7ikJVkYZ/RgSdBiJuE
 dXVeb3CCMKT5z5fRkeesaIWnuhAJ42DlsWMcU9DjNTjLCNHXusfPSKDnlLFuNCpRYgm8
 Rpwjh84MTlbLytYwOorFqpbeQgirwFx9V7IU/6CCZ0exMiYTRBtlSunVlRJE4W9cc+Qq
 v1pw8KwbizqhLxWiRp2JVeK3z8J960BxCvdlEoRnFbh2AhkGC1zlX9jBa7sW3h+rkLnw
 Z+cxY9dOI2yZyI8aP3FWA0ktYjHp/cse88ycMoTyhnv/MlcjvN3aS4/ba0sj+d6YVOem
 Bd/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH21C0kE+RopfKyRpJCy9/CQML2eKKyeET8Dhu/vhX6qqbZpu+qTtG23cmiz54zo8V9rhXFBpYrDgH@nongnu.org
X-Gm-Message-State: AOJu0Yz0/MXHgYcbRGxW88YVeufdhIAfadAdTxncg7HzO96Ppvt2HMwL
 8d+n9DpLbM8qz+7rZBUgGLTdNG9uamPnQ7bNrbSss8DhZAnsykIijga20D/Oxy3PG2yFbTMy2Sg
 gzZ1D
X-Gm-Gg: ASbGncuWYed8bL/tZgxnRBTms+z/Boz85oyIm2z7uXOIokHiDL+sAokkVRBCCVJBCOs
 MPkc5Kz/WUlg37iSJ3bXZE/Bk85EjMZ4roj4VA7RAFWWro8obbHDrLK9ZHtAywbMbynSe4gColz
 6KnDtazEghrACobOQ16kQAavL2A2m7Uk4xyvBzxmTVuEtj/9H/5ndW76eD1IIN2GmOx8IGoPVDI
 htjC8XAMZA9JGPVs4wX48f3AGwV/HeCbX0p74CNwYEQrrGk+R2YnYGqKpjHbdrFQ+Zv8Z1WHHrU
 K+3lyXZHEbL2H0g/wU+QNbZR0BVay5iwWKSKJKxJaNIWDiwalpPtVwRjVSRM9O2v/33vGrn32S+
 /cR3QppVazglSoNwu/p6OxJNsn19rNomDxO0HN3B1vYcVfEkGMrtewdqe10xieiYxQu94hXYbY3
 l1kvU=
X-Google-Smtp-Source: AGHT+IGT8S9wshqubIgOdPW4D/QTL6ZWVnEyvUG0gMSYENzgUQbPAa96pchkDgojzVCDER4rFeL7ow==
X-Received: by 2002:a17:903:2291:b0:24c:cc16:6c16 with SMTP id
 d9443c01a7336-25d24e9d39dmr192514465ad.19.1757973748060; 
 Mon, 15 Sep 2025 15:02:28 -0700 (PDT)
Received: from [192.168.0.102] (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-263bb2ef614sm61161045ad.150.2025.09.15.15.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 15:02:27 -0700 (PDT)
Message-ID: <275a593b-18e1-461a-a416-aea50cb67dc8@linaro.org>
Date: Mon, 15 Sep 2025 19:02:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] tests/functional: Provide GDB to the functional
 tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250915124207.42053-1-thuth@redhat.com>
 <20250915124207.42053-2-thuth@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250915124207.42053-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Thomas,

On 9/15/25 09:42, Thomas Huth wrote:
> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> The probe of gdb is done in 'configure' and the full path is passed
> to meson.build via the -Dgdb=option.
> 
> meson then can pass the location of gdb to the test via an environment
> variable.
> 
> This patch is based on an earlier patch ("Support tests that require a
> runner") by Gustavo Romero.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure                     | 2 ++
>   meson.build                   | 4 ++++
>   meson_options.txt             | 2 ++
>   scripts/meson-buildoptions.sh | 2 ++
>   tests/functional/meson.build  | 7 +++++++
>   5 files changed, 17 insertions(+)
> 
> diff --git a/configure b/configure
> index 274a7787642..8e2e2cd562a 100755
> --- a/configure
> +++ b/configure
> @@ -1978,6 +1978,8 @@ if test "$skip_meson" = no; then
>     test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
>     test "$plugins" = yes && meson_option_add "-Dplugins=true"
>     test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
> +  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
> +
>     run_meson() {
>       NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
>     }
> diff --git a/meson.build b/meson.build
> index 3d738733566..4cbc3c8ac65 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -75,6 +75,10 @@ have_user = have_linux_user or have_bsd_user
>   
>   sh = find_program('sh')
>   python = import('python').find_installation()
> +# Meson python.get_path() on 'purelib' or 'platlib' doesn't properly return the
> +# site-packages dir in pyvenv, so it is built manually.
> +python_ver = python.language_version()
> +python_site_packages = meson.build_root() / 'pyvenv/lib/python' + python_ver / 'site-packages'
>   
>   cc = meson.get_compiler('c')
>   all_languages = ['c']
> diff --git a/meson_options.txt b/meson_options.txt
> index fff1521e580..5bb41bcbc43 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -36,6 +36,8 @@ option('trace_file', type: 'string', value: 'trace',
>   option('coroutine_backend', type: 'combo',
>          choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
>          value: 'auto', description: 'coroutine backend to use')
> +option('gdb', type: 'string', value: '',
> +       description: 'Path to GDB')
>   
>   # Everything else can be set via --enable/--disable-* option
>   # on the configure script command line.  After adding an option
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 0ebe6bc52a6..f4bd21220ee 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -58,6 +58,7 @@ meson_options_help() {
>     printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
>     printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
>     printf "%s\n" '                           firmware]'
> +  printf "%s\n" '  --gdb=VALUE              Path to GDB'
>     printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
>     printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
>     printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
> @@ -323,6 +324,7 @@ _meson_option_parse() {
>       --disable-fuzzing) printf "%s" -Dfuzzing=false ;;
>       --enable-gcrypt) printf "%s" -Dgcrypt=enabled ;;
>       --disable-gcrypt) printf "%s" -Dgcrypt=disabled ;;
> +    --gdb=*) quote_sh "-Dgdb=$2" ;;
>       --enable-gettext) printf "%s" -Dgettext=enabled ;;
>       --disable-gettext) printf "%s" -Dgettext=disabled ;;
>       --enable-gio) printf "%s" -Dgio=enabled ;;
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 2a0c5aa1418..c822eb66309 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -77,6 +77,12 @@ foreach speed : ['quick', 'thorough']
>       test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
>                                  meson.current_source_dir())

It's necessary to add the Python modules from pyvenv to the PYTHONPATH, otherwise
when libpython from GDB looks for pycotap it cannot find it. We already have
it in python_site_packages in Meson (introduced with this series) so adding
python_site_packages to test_env.set() above, like:

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c822eb6630..ce992adb02 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -74,8 +74,9 @@ foreach speed : ['quick', 'thorough']
      endif
      test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
      test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
-    test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
-                               meson.current_source_dir())
+    test_env.set('PYTHONPATH', meson.project_source_root() / 'python' +
+                               ':' + meson.current_source_dir() +
+                               ':' + python_site_packages)
  
      # Define the GDB environment variable if gdb is available.
      gdb = get_option('gdb')


fixes the error:

    Python Exception <class 'ModuleNotFoundError'>: No module named 'pycotap'
   Error occurred in Python: No module named 'pycotap'


>   
> +    # Define the GDB environment variable if gdb is available.
> +    gdb = get_option('gdb')
> +    if gdb != ''
> +      test_env.set('QEMU_TEST_GDB', gdb)
> +    endif
> +
>       foreach test : target_tests
>         testname = '@0@-@1@'.format(target_base, test)
>         if fs.exists('generic' / 'test_' + test + '.py')
> @@ -121,6 +127,7 @@ foreach speed : ['quick', 'thorough']
>              priority: time_out,
>              suite: suites)
>       endforeach
> +

As Alex pointed out, I think there is a stray newline here too.


Cheers,
Gustavo

>     endforeach
>   endforeach
>   


