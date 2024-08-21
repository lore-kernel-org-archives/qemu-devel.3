Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70FCC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgmMi-00028H-7k; Wed, 21 Aug 2024 10:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgmMR-000273-J0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:30:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgmMP-0004sA-8A
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:30:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso54912615e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 07:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724250651; x=1724855451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXUM6lyqYl43Azie6XPu/309B3LmdMlapI1Nz7l1do4=;
 b=dikfMjmdIVpZmrsziTPPbtBiI6VLIV5zedVtlax4UM0oKR5ArVHtwtu8muUaFBhIMa
 Okk8l+Y/O6zdPhReAM+v/SuHriB67SShRfyHoN5AaXgIVvQ4tU3NeBIiR852W0PNaoz+
 UIGyBP/QGi5eyzsKFoQrjF8CCFw3a8st/jiuV9PfjvWIIXsiBxE0HT1Pr+FnGnX1NwGd
 ZD2jQGZf/i4Mzd6Xg+WN/v74PBPvaEb7kMFpTaaLAve00VvqTRFNb9M6XNNmuThH/oJ8
 RwWTrGOOwJTICrDpS74aHN0JXI1vvCItOzjRIwQGq39gJMAUSqxc4XPTwMKh4rMzmeE0
 CgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724250651; x=1724855451;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXUM6lyqYl43Azie6XPu/309B3LmdMlapI1Nz7l1do4=;
 b=DxH6Px8VTOSMsjQ1TQnoHy3PVbae8CpUfxMPmAVXGo0IdWlxskE1HXyhTsYqLnK2t8
 /n4cv8ZYkPQF04JWAoNmTirARJYFK77jllm4AZd8dXEUqonavQ5l/Qe5JM5kYTj2Aems
 nD75z2NFgjLDmUhz0aD+N110oCrVpXYmuESPYQeCzZdQDmQHgC4IJVY931MBw9c0i4tu
 OfCCeF/LUewqOJ/HrkOETN3tGpSjx5f+BcvrBg4/YLrNCeaGU0QsbBYlCrKO9gJHxlp5
 EAmdntnFuwK7Th8QDuIZ4YzsdJJU6OK+onJXe7EOjsdckQC0KlKJHMPpIghP+ECKl5b3
 xQZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWk0LO/U7D/wcRfStHCN5aEGgYgFFri88cew2KGzq4wyEHItSHcbkY/aQYIfRCzYg0NtivR5O2D4mW@nongnu.org
X-Gm-Message-State: AOJu0YzxsZi4vx+6LcLbhSKiNlSDhyoLxjvTlAQYaX95y3U0IrH+Nki3
 kiBKQq5D12f0vG3O7Zxr0mvHQ/rciUJEmJKUnkpDXxsYm9eK1kvtBlSzgL2Gja0=
X-Google-Smtp-Source: AGHT+IFuMEtXz0SM4wrbR6Xg0ogHNg33i68advbKmLynlJM5vapTFoqKxzwBi8hqjxSnJaTr2TqL5g==
X-Received: by 2002:a05:600c:4fcc:b0:421:7bed:5274 with SMTP id
 5b1f17b1804b1-42abf057eabmr20843445e9.10.1724250650963; 
 Wed, 21 Aug 2024 07:30:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abefc6285sm28493855e9.36.2024.08.21.07.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 07:30:50 -0700 (PDT)
Message-ID: <cb2136b4-6d65-4213-86ee-b6e18e4c8995@linaro.org>
Date: Wed, 21 Aug 2024 16:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/35] tests/functional: Prepare the meson build system
 for the functional tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-12-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-12-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 21/8/24 10:27, Thomas Huth wrote:
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
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include       | 11 ++++++
>   tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
>   tests/meson.build            |  1 +
>   3 files changed, 78 insertions(+)
>   create mode 100644 tests/functional/meson.build
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fbb1a4b211..66c8cc3123 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -9,6 +9,8 @@ check-help:
>   	@echo "Individual test suites:"
>   	@echo " $(MAKE) check-qtest-TARGET       Run qtest tests for given target"
>   	@echo " $(MAKE) check-qtest              Run qtest tests"
> +	@echo " $(MAKE) check-functional         Run python-based functional tests"
> +	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
>   	@echo " $(MAKE) check-unit               Run qobject tests"
>   	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
>   	@echo " $(MAKE) check-block              Run block tests"
> @@ -152,6 +154,15 @@ check-acceptance-deprecated-warning:
>   
>   check-acceptance: check-acceptance-deprecated-warning | check-avocado
>   
> +FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))

This only handles system binaries.

> +.PHONY: $(FUNCTIONAL_TARGETS)
> +$(FUNCTIONAL_TARGETS):
> +	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
> +
> +.PHONY: check-functional
> +check-functional:
> +	@$(MAKE) SPEED=thorough check-func check-func-quick
> +
>   # Consolidated targets
>   
>   .PHONY: check check-clean get-vm-images
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> new file mode 100644
> index 0000000000..7fc9c4e513
> --- /dev/null
> +++ b/tests/functional/meson.build
> @@ -0,0 +1,66 @@
> +# QEMU functional tests:
> +# Tests that are put in the 'quick' category are run by default during
> +# 'make check'. Everything that should not be run during 'make check'
> +# (e.g. tests that fetch assets from the internet) should be put into
> +# the 'thorough' category instead.
> +
> +# Most tests run too slow with TCI enabled, so skip the functional tests there
> +if get_option('tcg_interpreter')
> +  subdir_done()
> +endif
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging enabled
> +test_timeouts = {
> +}
> +
> +tests_generic = [
> +]
> +
> +tests_x86_64_quick = [

Hard to distinct system/user tests.

> +]
> +
> +tests_x86_64_thorough = [

It is a bit unfortunate to have to modify meson.build to add a test:
this triggers meson to regenerate build files. Good enough for now,
hopefully we will improve.

> +]
> +
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
> diff --git a/tests/meson.build b/tests/meson.build
> index 80dd3029cf..907a4c1c98 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -85,3 +85,4 @@ subdir('unit')
>   subdir('qapi-schema')
>   subdir('qtest')
>   subdir('migration')
> +subdir('functional')


