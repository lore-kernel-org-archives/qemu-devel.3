Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD11FA3728
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 16:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbhsi-0002YY-Eg; Fri, 02 Jan 2026 11:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbhsg-0002YE-A1
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbhsd-0000iP-7B
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767370797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ARYheAmxa9ljSA4IpiioRkqrtBhHmGunpYB+nB6ePPg=;
 b=PhJzVbw+DsllTkcGaOvrGT6y7h6Ucf7/PayCwAlNmPDdy+CdVUWNFWsBA3NOlvCiiWRpdX
 cn9o10p8Wzjngyyiy43X+QUBXQXM+6cakHH1A7DF1zIRGgfyUiYBlRLpqjKKL4JPEK3eQl
 /8/X5UqF8AcMti+1X+Ur6wTq+Pe9cJY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-YZR3rY21Pqes3hQ0uXeH2g-1; Fri, 02 Jan 2026 11:19:56 -0500
X-MC-Unique: YZR3rY21Pqes3hQ0uXeH2g-1
X-Mimecast-MFC-AGG-ID: YZR3rY21Pqes3hQ0uXeH2g_1767370795
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so9485796f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767370795; x=1767975595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ARYheAmxa9ljSA4IpiioRkqrtBhHmGunpYB+nB6ePPg=;
 b=fpP9u0aSZkQmS9gPy/CJ1URtAJ0ASTussSI9TeDsPUBNdbwatHpBI0bccSOUlAyCId
 jkn8QNyTxE8SXoxxS/WY+O4d1EzOtGFeaJnlRVhNQhTTiApmht0TXpDcXjifHoqL5oMq
 Sor0sZ909zpldKt+9yMeehFZgHM817IgNp0MhRrZwTokmjmSog13Oz/D77sO3IF4q0iD
 tibyX0+PBJz58vjQjPlTJroZxj8/FMEtp2WcfU6zB30r+Iqh1jh0TwcdqrrIBa9pJdLF
 vA0ZPSAE54aUlC/fWGYt9ntQXqcBVP8sHXbXHnYLmMhCL7jIOS0u254EN75zAYeEg7pp
 et1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767370795; x=1767975595;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARYheAmxa9ljSA4IpiioRkqrtBhHmGunpYB+nB6ePPg=;
 b=NDBLGsWinrMah8B81ISQo1LEh9itmbnZl0yFSwN6hp99LbrxV4myqrKo19fVrJxUAD
 Jesw/D9PlVd3MqLUrLOGYs2MAN96aM8RfG3hQvO0bvNMXGOpJmjrnxDLHrEl7sxwsEMS
 2wIoFTORx2IZFzCh66pzOJ/kWvwhBXguS0BgR395faqhbgA2KW9+iDazXIFe9LaU9zwa
 OVKIwMMp5KpK5BL0cuL5EihdMhwEO89BdwZpq4vamvLteDqBgsaHeb9DDZzA846xhTy1
 6UEdh34hvjNwSFcKOXmqkksFksAa2sSXIpxUQUCfJlbMfphRgNowt6enkLBNfZ6fa14T
 M5rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvYldpNeNhhM2qF2MyfhvaiF+YR2+7RojqUmxh1bXt3WB4lqIrrd+1p4hy6w9Psw6tNYo4MRb/pGJo@nongnu.org
X-Gm-Message-State: AOJu0YyxItS0Iac+64uEtST0s1/gM/vyPsuNmbZRphA77NgIXa2sRUa3
 rITMFzRsHnQMHgbsQ2MFBMFbe8GevM16H4x4szu/tBaGVuvkPdhj9xz/I8iXzFsg2gS9xAw/Lg5
 KQ1CDiuPqc5tU0FC2PG0IF5/1ht9oy/vyBqiHQC48G29XQcgtWcdjTvyr
X-Gm-Gg: AY/fxX7lwo/shnmAAqduzXHEnPdy1HwCPtISXrz/XHPffP4u1s1H/HshVP4uSjKNlJk
 1muawBV13yVJbjswYe1ksZ8tWr3NN9FaQt9t02vwHs/Qkcg/psFjI3pHnXQKdSNpDYBKcqbzWJj
 nSjRpspNSrwxkj2szcMvOES0SH94td8nt30Dzxs2TfTciGE9TVQZnpI/N7boLS/MR/buOPRw39Q
 EczE1jVvglirN5rAuk7TPD5oyi3mgFMzof+LzX6PV5+2bXNsU8fI7fH1GjWzz945NcCXm0sS7p8
 /sfbCAV/XVT5378hyUWkZiyiVy09bT/QrhaCngzz47HjZ0uRyjrQh1pL4JJLd4GgcO5uk/tapIb
 QoFX6hzE=
X-Received: by 2002:a05:6000:288c:b0:430:fbfc:ec77 with SMTP id
 ffacd0b85a97d-4324e4c637dmr65811142f8f.12.1767370794732; 
 Fri, 02 Jan 2026 08:19:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfvFZOUo+shnCDjQqfTbNxy7D97TKUwO566+W0KRCUFOdMozRpt+H/Dc3/wHeXm2KDtfgewA==
X-Received: by 2002:a05:6000:288c:b0:430:fbfc:ec77 with SMTP id
 ffacd0b85a97d-4324e4c637dmr65811107f8f.12.1767370794272; 
 Fri, 02 Jan 2026 08:19:54 -0800 (PST)
Received: from [192.168.0.8] ([47.64.114.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm85582740f8f.28.2026.01.02.08.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 08:19:53 -0800 (PST)
Message-ID: <16974f48-e25b-4dca-8b21-a6c09329dd1d@redhat.com>
Date: Fri, 2 Jan 2026 17:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Allow tests to be run individually
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20251218123320.31347-1-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251218123320.31347-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/12/2025 13.33, Fabiano Rosas wrote:
> The functional tests currently don't allow a single test to be
> selected for execution by dotted name, e.g:
> 
> ../tests/functional/ppc64/test_pseries.py PseriesMachine.test_ppc64_linux_boot
>                                            ^
> The issue is that the testcase.py main function passes the test
> module's name as the second argument to unittest.main(), which makes
> it ignore all other positional arguments (presumably because the
> module is already the superset of all tests).
> 
> After commit cac08383f0 ("tests/functional: expose sys.argv to
> unittest.main"), the situation improves by passing the rest of the
> argv from the command line invocation into unittest.main(), but it
> still doesn't fix the issue. The short form options are now accepted,
> so the -k option could be used to filter for a pattern, which is
> useful, but not the same as listing the test names.
> 
> Fix this by passing the test module name via the "module" argument to
> unittest.main() and stop touching argv. The ways of invoking tests are
> now as per unittests documentation (-k still works):
> 
>    Examples:
>      test_pseries.py                           - run default set of tests
>      test_pseries.py MyTestSuite               - run suite 'MyTestSuite'
>      test_pseries.py MyTestCase.testSomething  - run MyTestCase.testSomething
>      test_pseries.py MyTestCase                - run all 'test*' test methods in MyTestCase
> 
> Note that ever since we've been programatically passing the module
> name to unittest.main(), the usage 'test_pseries.py test_pseries' was
> never valid. It used to "work" just the same as 'test_pseries.py
> foobar' would. After this patch, that usage results in an error.
> 
> Also note that testcase.py:main() pertains to running the test module
> that invoked it via QemuSystemTest.main(), i.e. module == __main__. So
> the 'discover' usage of unittest doesn't apply here, the module is
> already discovered because that's where this code was called from to
> begin with. This patch could just as well call unittest.main() instead
> of unittest.main(test_module), but the latter provides nicer error
> messages prefixed with the module name.
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> v2: added docs
> ---
>   docs/devel/testing/functional.rst      | 19 +++++++++++++++++--
>   tests/functional/qemu_test/testcase.py |  7 +++----
>   2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index fdeaebaadc..4ccc7c3940 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -52,17 +52,32 @@ the following line will only run the tests for the x86_64 target:
>   
>     make check-functional-x86_64
>   
> -To run a single test file without the meson test runner, you can also
> +To run the tests from a test file without the meson test runner, you can also
>   execute the file directly by specifying two environment variables first,
>   the PYTHONPATH that has to include the python folder and the tests/functional
>   folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
>   to the QEMU binary that should be used for the test. The current working
> -directory should be your build folder. For example::
> +directory should be your build folder. Like so::
>   
>     $ export PYTHONPATH=../python:../tests/functional
>     $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
> +
> +With the above set, run all tests from a test file::
> +
>     $ pyvenv/bin/python3 ../tests/functional/test_file.py
>   
> +Run all tests from a test class::
> +
> +  $ pyvenv/bin/python3 ../tests/functional/test_file.py TestClass
> +
> +Or a single test::
> +
> +  $ pyvenv/bin/python3 ../tests/functional/test_file.py TestClass.test_name
> +
> +Filtering test names also works::
> +
> +  $ pyvenv/bin/python3 ../tests/functional/test_file.py -k pattern
> +
>   The test framework will automatically purge any scratch files created during
>   the tests. If needing to debug a failed test, it is possible to keep these
>   files around on disk by setting ``QEMU_TEST_KEEP_SCRATCH=1`` as an env


  Hi Fabiano!

I was just about to pick this patch up, but seems like this now has a 
conflict with another update to the functional.rst file that got merged in 
between ... could you please rebase and send a v3?

  Thanks,
   Thomas


