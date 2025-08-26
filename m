Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555BCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvT3-0007sF-62; Tue, 26 Aug 2025 11:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqvSz-0007oT-0L
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:20:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqvSj-0005KF-AR
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:20:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771f3f89952so1068817b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756221586; x=1756826386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CFp5XYV5vt0+YmMHlulgMAqHUrhNiVHLMR+6k+JMX94=;
 b=KpcmcUJmE9N9f1xdA76zlz2fDMNTzud7uG4M1yZuPYAMIYo4Us3NJ7YJm+Nt8z7T6q
 IBiv4bpsvRSNUcWA/j+YL5nP1Nhvq5Imq8gVZ/b5qwMsin5eCV3ZaUUKXy6NKqyyw1JR
 S8DEMYnInQFLKyBsFcdlavNxP3MzvfpgJANEP9VzrICrihgkHdgyEXUlmLrUSJaEqst7
 ljgMMBkh1Gxy1+T0uLyowmFPlBsTyPyRaGLJMWfiYchMoS1C+dNZWeVjqHFcQ53RcJSn
 vHTP/h5p5H3JbHxpwaYVYuY29yec8yLnJrkJY7MLZmAXkU9HsLBCQs+FD560p4Na38JM
 kKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756221586; x=1756826386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CFp5XYV5vt0+YmMHlulgMAqHUrhNiVHLMR+6k+JMX94=;
 b=gnG1Q1zth2TtpayKIc00qA8FfqQ2sTVn5iCynz1eaPwjhbs/450oGR7kZPmMvuFjTH
 4GfH9hfd4B0Bbg87PPf9nYc8sMOQgfq71yPU7GmwxY1RHblfUknIE6nYbspUufC9v0UW
 Bifdzr19VHYIYKXdme6ovXc7KK1ejDq1y42J7GHMjUj0clGloPmz+uD/gYBOdclBDY3Y
 NHYOVQQlbZin/5wlQVBgquPzKgIsNalIqMV/FMBQJZVlercV/9Hd+mitIVM7RCStvln/
 Eo/nJTaCUtoAlgCrwfLkC0ZstBMbV0kJBTaMdivtfViCNSj+1eNi+jWhWLVQObNFYYiv
 zhmw==
X-Gm-Message-State: AOJu0YwpRZx5zHU4J/BdwpM7OAHQcjHxCj1jhPMi2d9pK37xbQeJo+tH
 npP6R+xImoK9KOmXASI1VgmFy9JZZg381McXJ47bdomzeEWS6dRn3daBs1m9bXQ/noz0lGz8eJ0
 i+vOu4iE=
X-Gm-Gg: ASbGncunr95xD2Oy8y7XWdls6X9BTQOroZMoSTNUmb2SkzlsRbKx9jFHVNI41UBwAk7
 6YcM5jzQWpuo7Rsi6x/xVGChW208qhxhVMTxRAbUSL9Til/AraMQW7sihthGnjahUpBXOm2T5JM
 Xtd6xm7u2Bcl1fzPV9a9q5UjEp7qQZfjWFVOLysLvFr40dOJQcrpXhAgbH2BhjmL5fuct7VwX98
 MXk8M0esd9lB9ISODONsGZVwM0SG+5bsR1cNbhtic5A0vnEJGPGVflbv8FOcP5RofqK0UkoP0p4
 9/1UTMCzkSfOV2ZpwI7l/t9BlQBjoXMiEVJYFpXE1HMuPQJxPCLAnIdXLiEFd1Rgpn/zoeOji4T
 JrScetxW4quY5ydhAnUf2G21M/pPUtsh6Wg==
X-Google-Smtp-Source: AGHT+IH2gQWaOB6wCDxO5XdRxiGrTc1VAoLJ2V8vluKoeRh4BX2wn3ItW6HxOWAUZIiR4u4pjp7wdA==
X-Received: by 2002:a05:6a00:3406:b0:771:f071:28fd with SMTP id
 d2e1a72fcca58-771fc296d94mr2215911b3a.14.1756221586008; 
 Tue, 26 Aug 2025 08:19:46 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.38.174])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7704fb69542sm8724553b3a.94.2025.08.26.08.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 08:19:45 -0700 (PDT)
Message-ID: <ff89f821-e0aa-4a4e-9ac9-f50a6ee062af@linaro.org>
Date: Tue, 26 Aug 2025 12:20:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/functional: Support tests that require a runner
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, qemu-arm@nongnu.org,
 1844144@gmail.com
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <20250819143916.4138035-3-gustavo.romero@linaro.org>
 <87bjo32vmf.fsf@draig.linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <87bjo32vmf.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

Hi Alex,

On 8/25/25 13:50, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Add support for running tests that require a specific runner.
>>
>> The test is specified via a tuple (name, runner, protocol), where name
>> is the test name as found in the tests/functional directory without the
>> 'test_' prefix and the .py extension, runner is an array containing the
>> runner and any arguments required by the runner, and protocol is
>> the test protocol used by Meson to determine whether the test passed or
>> failed.
>>
>> The test tuples are added to arrays that follow the current naming
>> logic but with the suffix '_with_runner' appended to their names. In
>> Meson it's not easy to select an element in an array at runtime based on
>> its type, so it's simpler to have a new array for these new test types
>> than use the current ones from the tests that don't require a runner,
>> and so avoid mixing strings and tuples in the same array.
>>
>> Currently there is only one runner, the GDB runner, but more runners can
>> be defined and associated to a test via the tuple.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   meson.build                  |  4 +++
>>   tests/functional/meson.build | 62 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 50c774a195..8d482f0809 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -75,6 +75,10 @@ have_user = have_linux_user or have_bsd_user
>>   
>>   sh = find_program('sh')
>>   python = import('python').find_installation()
>> +# Meson python.get_path() on 'purelib' or 'platlib' doesn't properly return the
>> +# site-packages dir in pyvenv, so it is built manually.
>> +python_ver = python.language_version()
>> +python_site_packages = meson.build_root() / 'pyvenv/lib/python' + python_ver / 'site-packages'
>>   
>>   cc = meson.get_compiler('c')
>>   all_languages = ['c']
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 311c6f1806..1f70b70fd4 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -349,6 +349,23 @@ tests_xtensa_system_thorough = [
>>     'xtensa_replay',
>>   ]
>>   
>> +# Tests that require a specific runner.
>> +gdb = find_program('gdb-multiarch', required: false)
>> +if gdb.found()
>> +    gdb_runner_script =  meson.project_source_root() + '/tests/guest-debug/run-test.py'
>> +    gdb_runner = [gdb_runner_script, '--gdb', gdb, '--test']
>> +
>> +    # A test with a runner is a tuple (name, runner, protocol).
>> +    # The tests must be elements of an array named like:
>> +    #
>> +    # test_<arch>_<mode=[system|linuxuser|bsduser]>_<speed=[quick|thorough]>_with_runner = [
>> +    #      ['test0', gdb_runner, 'exitcode'],
>> +    #      ...
>> +    # ]
>> +else
>> +    message('GDB multiarch not found, skipping functional tests that rely on it.')
>> +endif
>> +
> 
> We already have a --gdb option in configure which sets GDB= for
> check-tcg - we should use the same configuration for these tests. You
> may need to convert the configure probe to a meson-option.

True. I'll sort it out in v2. Afaics it will solve the issue Thomas found on
Fedora. As Daniel says gdb in Fedora already has all the arch built-in, the
detection in configure will work. Thanks.


Cheers,
Gustavo

>>   precache_all = []
>>   foreach speed : ['quick', 'thorough']
>>     foreach dir : target_dirs
>> @@ -372,9 +389,11 @@ foreach speed : ['quick', 'thorough']
>>         suites = ['func-quick', 'func-' + target_base]
>>         target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_quick', []) \
>>                        + get_variable('tests_generic_' + sysmode)
>> +      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_quick_with_runner', [])
>>       else
>>         suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
>>         target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
>> +      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed + '_with_runner', [])
>>       endif
>>   
>>       test_deps = [roms, keymap_targets]
>> @@ -423,6 +442,49 @@ foreach speed : ['quick', 'thorough']
>>              priority: test_timeouts.get(test, 90),
>>              suite: suites)
>>       endforeach
>> +
>> +    # Prepare tests that require a specific runner.
>> +    foreach test : target_tests_r
>> +      testname = '@0@-@1@'.format(target_base, test[0])
>> +      testfile = 'test_' + test[0] + '.py'
>> +      testpath = meson.current_source_dir() / testfile
>> +      teststamp = testname + '.tstamp'
>> +      testrunner  = test[1]
>> +      testproto = test[2]
>> +
>> +      test_precache_env = environment()
>> +      test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
>> +      # python_site_packages, i.e., site packages from Python in pyvenv, is
>> +      # added to PYTHONPATH because some runners can run a program that has its
>> +      # own Python hooks that, by its turn, will search for modules based on
>> +      # PYTHONPATH independently of the Python used by the runner, like, for
>> +      # example, GDB using libpython.
>> +      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python' +
>> +                                          ':' + meson.current_source_dir() +
>> +                                          ':' + python_site_packages)
>> +      precache = custom_target('func-precache-' + testname,
>> +                               output: teststamp,
>> +                               command: [testrunner, testpath],
>> +                               depend_files: files(testpath),
>> +                               build_by_default: false,
>> +                               env: test_precache_env)
>> +      precache_all += precache
>> +
>> +      # See comment above about python_site_packages in test_precache_env.
>> +      # Don't append to test_env since it will affect previous uses of it.
>> +      test_r_env = test_env
>> +      test_r_env.append('PYTHONPATH', python_site_packages)
>> +
>> +      test('func-' + testname,
>> +           python,
>> +           depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
>> +           env: test_r_env,
>> +           args: [testrunner, testpath],
>> +           protocol: testproto,
>> +           timeout: test_timeouts.get(test[0], 90),
>> +           priority: test_timeouts.get(test[0], 90),
>> +           suite: suites)
>> +    endforeach
>>     endforeach
>>   endforeach
> 


