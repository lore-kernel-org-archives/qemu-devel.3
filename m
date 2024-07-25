Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED6C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvTJ-000320-1k; Thu, 25 Jul 2024 06:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWvTG-0002z3-W7
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWvTE-0006c4-UF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721902391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FxnaUjha+tCsUMD/MRAcW5GxDiTpWjqvGkQFxL9+Ao8=;
 b=GusbD46fwWnTY1ruBRRSTOhcfx4ikJkFWPoD8+Mc3QMrch1W782DXjxcwM/cU5MkzfJRoS
 GCFz5oXDKWR/m2jeeMza8lXaI2ksldyhOchKvC3z6LgM+aYNU9KX5KtqMjjmfbx5GS6wVG
 ADB+gPFzlvTLjBpEfakGSHxccLKY32U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-I3n04LRnO_qhf6fRsfUQiQ-1; Thu, 25 Jul 2024 06:13:09 -0400
X-MC-Unique: I3n04LRnO_qhf6fRsfUQiQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b79d1eb896so12141556d6.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721902389; x=1722507189;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxnaUjha+tCsUMD/MRAcW5GxDiTpWjqvGkQFxL9+Ao8=;
 b=s10jHT2OLVzXbzbTeuLn3BWROF4tT3F36XzC8aVEqZZIFftzMvavRowOdQgRZHogLL
 FzVY5APwIQrvLRLn6Lwxqr7ZhYMCYrsuGe9SciCP1GOgNc+aNF8pGt0Yuy609QD/691Q
 kLvn3Ute03X4c+AIyqVGwsX30UOcjDE4ddBNwvK7rzLCfdhUkmyYQYQO1biNE86kul8h
 33s5PVFYu3d2GYFW0JuNdXSgoGlzQDsQRBQLgNFeVShP5kplUzL670PsxtkwsRtmXhn4
 6CsVaStVh/KVGGPMO8sUrnh0JudkWJHuAdwYbnMPPj2jVX3ey5Qb6XchhBFX49mSfTtC
 0Q1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrYcQIYK7/J192gbyyEna3bLwVWZq6/oGDX6nxCpxqx1eny5u9dxleWghBOyvi8ZuYEyh9QLpc609qTMXxjAUaJFgbTc4=
X-Gm-Message-State: AOJu0YwAHnnjEYTmw0v0MA7Xhpg6+JUwp7kBW5/iTjMT3OySs2F3MGtz
 WQf+K6A2dnlQ78VQ1Y5fuheoXpzOumsHdXmt0LQeJDFXfoHOZICnuz/Xy7mSVGmSO6+7+Wnq1hM
 gFUWHirFYvysmzV3Bd4ljx61nJGtNNSTGPUgHBqE/KFYw8glz9X8+
X-Received: by 2002:a05:6214:230b:b0:6af:69c0:e559 with SMTP id
 6a1803df08f44-6bb3cad6fd6mr25985016d6.50.1721902388993; 
 Thu, 25 Jul 2024 03:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMizICBrmoFTB5Ov/+u9rblrrw/mcgycKIY51U0EtILCmiMLNG5PWyiS+iZuz4Ju4y6dqy/Q==
X-Received: by 2002:a05:6214:230b:b0:6af:69c0:e559 with SMTP id
 6a1803df08f44-6bb3cad6fd6mr25984806d6.50.1721902388622; 
 Thu, 25 Jul 2024 03:13:08 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-36.web.vodafone.de.
 [109.43.178.36]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb3f943a30sm5473646d6.74.2024.07.25.03.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 03:13:08 -0700 (PDT)
Message-ID: <877f8f8d-c798-4e8f-a323-e06d14cda44a@redhat.com>
Date: Thu, 25 Jul 2024 12:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/07/2024 01.35, Richard Henderson wrote:
> On 7/25/24 03:52, Thomas Huth wrote:
>> The Avocado v88 that we use in QEMU is already on a life support
>> system: It is not supported by upstream anymore, and with the latest
>> versions of Python, it won't work anymore since it depends on the
>> "imp" module that has been removed in Python 3.12.
>>
>> There have been several attempts to update the test suite in QEMU
>> to a newer version of Avocado, but so far no attempt has successfully
>> been merged yet.
>>
>> Additionally, the whole "make check" test suite in QEMU is using the
>> meson test runner nowadays, so running the python-based tests via the
>> Avocodo test runner looks and feels quite like an oddball, requiring
>> the users to deal with the knowledge of multiple test runners in
>> parallel (e.g. the timeout settings work completely differently).
>>
>> So instead of trying to update the python-based test suite in QEMU
>> to a newer version of Avocado, we should try to better integrate
>> it with the meson test runner instead. Indeed most tests work quite
>> nicely without the Avocado framework already, as you can see with
>> this patch series - it does not convert all tests, just a subset so
>> far, but this already proves that many tests only need small modifi-
>> cations to work without Avocado.
>>
>> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
>> classes (e.g. based on cloud-init images or using SSH) really depend
>> on the Avocado framework, so we'd need a solution for those if we
>> want to continue using them. One solution might be to simply use the
>> required functions from avocado.utils for these tests, and still run
>> them via the meson test runner instead, but that needs some further
>> investigation that will be done later.
>>
>>
>> Now if you want to try out these patches: Apply the patches, then
>> recompile and then run:
>>
>>   make check-functional
>>
>> You can also run single targets e.g. with:
>>
>>   make check-functional-ppc
>>
>> You can also run the tests without any test runner now by
>> setting the PYTHONPATH environment variable to the "python" folder
>> of your source tree, and by specifying the build directory via
>> QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
>> QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
>>
>>   export PYTHONPATH=$HOME/qemu/python
>>   export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
>>   export QEMU_BUILD_ROOT=$HOME/qemu/build
>>   ~/qemu/tests/functional/test_virtio_version.py
>>
>> The logs of the tests can be found in the build directory under
>> tests/functional/<arch>/<testname> - console log and general logs will
>> be put in separate files there.
>>
>> Still to be done: Update the documentation for this new test framework.
> 
> I'll say again that the download *must* be handled separately from the test 
> with timeout. This is an absolute show-stopper.
> 
> I've tried this twice now, from a decently fast connection in central 
> Brisbane, and have had multiple downloads be canceled by the timeout.  Since 
> the download isn't clever enough to pick up where it left off, it will never 
> succeed.

  Hi Richard,

just for my understanding, did you try to run the tests in parallel (i.e. 
something like "make -j$(nproc)")? ... I think in that case you can easily 
clog your internet connection even on modern systems if a lot of tests are 
trying to download the assets in parallel.

For me, it works fine if I use normal serial testing with "-j" (btw. Avocado 
v88 is doing serial testing, too, so you won't lose much time during the 
first run here). But if downloading fails for you without "-j", too, I 
agree, we need to tackle that problem first, e.g. by implementing what 
Daniel suggested. That will take a little bit longer, of course, so I hope 
you meanwhile found a work-around for the problem with the missing "imp" 
package on your system?

  Thomas


