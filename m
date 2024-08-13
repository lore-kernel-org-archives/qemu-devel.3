Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B60C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 12:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdqD5-0007nK-I1; Tue, 13 Aug 2024 08:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdqCG-0007Ob-Cz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdqCB-00066v-V9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723550409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n3G0WNx12VyRoJ/Eu3Pzw8SRfrAraPIsHeIz6Dh8yAc=;
 b=ShdTNPzEP/kUjTHpcowc0YL0vJ9GBOJJFjitGhMwEPCZEYREfOy8HwKEsiijs1sUvVRLsM
 wBnJjXsGdmpfAE+Mba/6Uy/dbqj8its4FfQd2CBekfCOf2kFvYI/NaD+lsLdtbaP4RJ9Ru
 YU2ymH8Fswlmw5CqC86foLMTfLis2IY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-0tpMPR_jPyem4fcWPW_Nzw-1; Tue, 13 Aug 2024 08:00:06 -0400
X-MC-Unique: 0tpMPR_jPyem4fcWPW_Nzw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36863648335so2881255f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 05:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723550405; x=1724155205;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3G0WNx12VyRoJ/Eu3Pzw8SRfrAraPIsHeIz6Dh8yAc=;
 b=DcEgUjzzhGlElOUQgl4AFUXe4CtmXeLOY1sFsuZgGJlvexCLgDrtV+R880ksh/78qN
 B1SrP0Cd/KKGcLcsJvdOTupmuHV15YqQf8U6ZFAwXzFcP3iDopJZm8ZmRihKzfCcGshf
 d9b9n3XN0TDmdMADGdLwE0Hi645UkAN7UsrwuGUxwtXkfms2Xz2kjnakNk1ekBb5xUPa
 sW7ZnFjdyzkYzLkBEuU22PMX3Lc0U0s3vS2yHsXiNHdGCwadkh5mF3jk9UFpleKGy4gc
 SApWwSb/voaO4XRva3hTO7QVeruzMHJypXUmkqO+hrWHSlUMl5maPMifJbWLMnMZTj7q
 NuJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhHqzjV/p7FdcMir4pU5OOSsdL1AEXHmUzmyAfJ0pjU1KsJboneZo8bGRm1oPRfc2morFYC9ZNzOqdKUCvzQxInYtzCYk=
X-Gm-Message-State: AOJu0YzlQtDw63W9LK6S7RrmO92PNbN5DMg4utixIAbvcp/5twMg1asA
 uwh5sbDgBb7j8RTMEVjmmYtAO0X9X4iIUfPuUcEabFxzXZFlrysTpGoSBMuUjVyw8ic23Z7zrEN
 ChfnV7Sy2fJPNi28ttRkY+1MvTlKe5IEsimfYRlmH/2ENAY/2zDJX
X-Received: by 2002:a5d:5284:0:b0:366:ec2c:8646 with SMTP id
 ffacd0b85a97d-3716cd24ddemr2200554f8f.43.1723550405183; 
 Tue, 13 Aug 2024 05:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJDFNhKYLwR5+eBBL8aNIlY2F7kWPyg1eHddSHQwJGfOKnlDigGRn63MinpagHpurTjeHtIg==
X-Received: by 2002:a5d:5284:0:b0:366:ec2c:8646 with SMTP id
 ffacd0b85a97d-3716cd24ddemr2200526f8f.43.1723550404596; 
 Tue, 13 Aug 2024 05:00:04 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4ecc7a52sm10014329f8f.103.2024.08.13.05.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 05:00:04 -0700 (PDT)
Message-ID: <1f3d8742-05c2-424a-98e8-db9835e4a3e2@redhat.com>
Date: Tue, 13 Aug 2024 14:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/24] tests/functional: Prepare the meson build system
 for the functional tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-6-berrange@redhat.com>
 <e393dbb5-dcc4-43d8-82dd-7d32e692eb91@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e393dbb5-dcc4-43d8-82dd-7d32e692eb91@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/08/2024 18.12, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Provide a meson.build file for the upcoming python-based functional
>> tests, and add some wrapper glue targets to the tests/Makefile.include
>> file. We are going to use two "speed" modes for the functional tests:
>> The "quick" tests can be run at any time (i.e. also during "make check"),
>> while the "thorough" tests should only be run when running a
>> "make check-functional" test run (since these tests might download
>> additional assets from the internet).
>>
>> The changes to the meson.build files are partly based on an earlier
>> patch by Ani Sinha.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/Makefile.include       | 11 ++++++
>>   tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
>>   tests/meson.build            |  1 +
>>   3 files changed, 78 insertions(+)
>>   create mode 100644 tests/functional/meson.build
> 
> 
>> +foreach speed : ['quick', 'thorough']
>> +  foreach dir : target_dirs
>> +    if not dir.endswith('-softmmu')
>> +      continue
>> +    endif
>> +
>> +    target_base = dir.split('-')[0]
>> +    test_emulator = emulators['qemu-system-' + target_base]
>> +
>> +    if speed == 'quick'
>> +      suites = ['func-quick', 'func-' + target_base]
>> +      target_tests = get_variable('tests_' + target_base + '_quick', []) 
>> + tests_generic
>> +    else
>> +      suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
>> +      target_tests = get_variable('tests_' + target_base + '_' + speed, [])
>> +    endif
>> +
>> +    test_deps = roms
>> +    test_env = environment()
>> +    if have_tools
>> +      test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() / 
>> 'qemu-img')
>> +      test_deps += [qemu_img]
>> +    endif
>> +    test_env.set('QEMU_TEST_QEMU_BINARY',
>> +                 meson.global_build_root() / 'qemu-system-' + target_base)
>> +    test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
>> +    test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
>> +                               meson.current_source_dir())
>> +
>> +    foreach test : target_tests
>> +      test('func-@0@/@1@'.format(target_base, test),
>> +           python,
>> +           depends: [test_deps, test_emulator, emulator_modules],
>> +           env: test_env,
>> +           args: [meson.current_source_dir() / 'test_' + test + '.py'],
>> +           protocol: 'tap',
>> +           timeout: test_timeouts.get(test, 60),
>> +           priority: test_timeouts.get(test, 60),
>> +           suite: suites)
>> +    endforeach
>> +  endforeach
>> +endforeach
> 
> Can we have meson report why a test is skipped? All Python
> unittest @skip* decorators provide a 'reason' argument, so
> we already have that information.

I guess you'd need to extend the meson test runner for this...

> Not much help on meson doc:
> https://mesonbuild.com/Unit-tests.html#skipped-tests-and-hard-errors
> 
> If I run a test manually I see the reason in the tap output:
> 
> $ FOO=bar tests/functional/test_mips64el_loongson3v.py
> TAP version 13
> ok 1 test_mips64el_loongson3v.MipsLoongson3v.test_pmon_serial_console # SKIP 
> untrusted code
> 1..1

You can also see this information in the txt file in the meson-logs folder, 
so it is certainly not completely lost.

  Thomas



