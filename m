Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E9EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYPU-0001Ym-77; Thu, 01 Aug 2024 12:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYPT-0001XR-6t
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:12:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYPQ-00076n-SI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:12:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso45010435e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722528727; x=1723133527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRofhEbEeBMYiPuko3T/7aA/VoA582xLo7SR/dbsb+k=;
 b=L57c0w7cER136B765rhPonIlizVBYHYTDPcVDuHeD7chBF8e8xmZ5zuowhw64qWzun
 +PIBlhR67MPDHqEOCrertQIRrF4QGV8OMncYfbSyRgpkDi4/2rntl7QwM07B+f0Lwi2l
 oweINVhtAPJIY4tRVr+uksA+kQNMX/rXfw0kwGqeWmy7VCJk/3B21pip63z7ywtYIXLK
 FQPIrbAny0Cpx3jih2Mpda+PR2tXBbtL3P8m/nU8857eCHYzV3tpaS8TrNxb9zyb7bN1
 czpDP9u8a4YKwxH2qx7fVVPCHdhXJjDwqyffBxkJp1xXdSYEjSD2HZy+b+M4Rcyjbx4s
 Nd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528727; x=1723133527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRofhEbEeBMYiPuko3T/7aA/VoA582xLo7SR/dbsb+k=;
 b=lXl2VwxcvBbGjdng7+vGj+WMwRqR7esdy6CKHLtGfN6c4QHRWkD4Ks+lexQOI0RYef
 5bBoBWzkNYPlA1rG5k81RqyyzDFe/6aHdj2akzlducW8D97VFCrn7/UQ4v692z3V444r
 Ok1HeBeFlldLfs3BKyoxCaxGS/m7pdRY6kcWdt1n1uQPEKd6xfbKgwGFEOxRVxh0fHih
 4UTHMTjC4IJzrQBPqJgnDy2ubc6QsdrCRqn5yv7BgzqIg2AVPEWyY3CtDIeLbZNJFsR7
 rBZfubR1mPhCpatCw/VAC9iwEDQFt3Roi/uwa8lZx+NzrDJjpr/EXJGCfaf2Ry7Asajt
 kahg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU/oMk0FPtO321yfFUzbPaK/MrF53eSuZ1eOxg1tSoXDI6Yl4oW3j0ex2fSB6tyvlwA1JzR+xzKD4GzfSK1l3UoRUBOgo=
X-Gm-Message-State: AOJu0Yw3iOwhmoUdYRqpO4nHt9//xBhAa05LW/0pVjJXJ1iasFI8bngU
 /jvNVLLn0/Ode8XAZeoie4ppKmIXiZ+DSfbods620TXQ3y3WcaoK/mdSglozhXQ=
X-Google-Smtp-Source: AGHT+IHDAvrCxJytdIukPfqJPKEluzHi02FwVmnhXAAkGenc1cC6TBsVT8rfZ3q+KfB2qd0nYntHXA==
X-Received: by 2002:a05:600c:4fcb:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-428e6a5afc3mr3473575e9.0.1722528727009; 
 Thu, 01 Aug 2024 09:12:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e05ffesm1983365e9.18.2024.08.01.09.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:12:06 -0700 (PDT)
Message-ID: <e393dbb5-dcc4-43d8-82dd-7d32e692eb91@linaro.org>
Date: Thu, 1 Aug 2024 18:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/24] tests/functional: Prepare the meson build system
 for the functional tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-6-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi,

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Provide a meson.build file for the upcoming python-based functional
> tests, and add some wrapper glue targets to the tests/Makefile.include
> file. We are going to use two "speed" modes for the functional tests:
> The "quick" tests can be run at any time (i.e. also during "make check"),
> while the "thorough" tests should only be run when running a
> "make check-functional" test run (since these tests might download
> additional assets from the internet).
> 
> The changes to the meson.build files are partly based on an earlier
> patch by Ani Sinha.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include       | 11 ++++++
>   tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
>   tests/meson.build            |  1 +
>   3 files changed, 78 insertions(+)
>   create mode 100644 tests/functional/meson.build


> +foreach speed : ['quick', 'thorough']
> +  foreach dir : target_dirs
> +    if not dir.endswith('-softmmu')
> +      continue
> +    endif
> +
> +    target_base = dir.split('-')[0]
> +    test_emulator = emulators['qemu-system-' + target_base]
> +
> +    if speed == 'quick'
> +      suites = ['func-quick', 'func-' + target_base]
> +      target_tests = get_variable('tests_' + target_base + '_quick', []) + tests_generic
> +    else
> +      suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
> +      target_tests = get_variable('tests_' + target_base + '_' + speed, [])
> +    endif
> +
> +    test_deps = roms
> +    test_env = environment()
> +    if have_tools
> +      test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() / 'qemu-img')
> +      test_deps += [qemu_img]
> +    endif
> +    test_env.set('QEMU_TEST_QEMU_BINARY',
> +                 meson.global_build_root() / 'qemu-system-' + target_base)
> +    test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
> +    test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
> +                               meson.current_source_dir())
> +
> +    foreach test : target_tests
> +      test('func-@0@/@1@'.format(target_base, test),
> +           python,
> +           depends: [test_deps, test_emulator, emulator_modules],
> +           env: test_env,
> +           args: [meson.current_source_dir() / 'test_' + test + '.py'],
> +           protocol: 'tap',
> +           timeout: test_timeouts.get(test, 60),
> +           priority: test_timeouts.get(test, 60),
> +           suite: suites)
> +    endforeach
> +  endforeach
> +endforeach

Can we have meson report why a test is skipped? All Python
unittest @skip* decorators provide a 'reason' argument, so
we already have that information.

Not much help on meson doc:
https://mesonbuild.com/Unit-tests.html#skipped-tests-and-hard-errors

If I run a test manually I see the reason in the tap output:

$ FOO=bar tests/functional/test_mips64el_loongson3v.py
TAP version 13
ok 1 test_mips64el_loongson3v.MipsLoongson3v.test_pmon_serial_console # 
SKIP untrusted code
1..1
$

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


