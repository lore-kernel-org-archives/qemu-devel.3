Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D0AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvw6-00067A-Go; Thu, 25 Jul 2024 06:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWvvq-00064f-7b
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:42:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWvvm-0006qD-TE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:42:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc569440e1so7054835ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721904161; x=1722508961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lU5hmRpzkuCAtE5EweXfQtilHd8HHpg8NlUp12ztEJo=;
 b=naS+1w3aDx/oyEluTPrPFzkUzRpH9GILBa6Gkrv3YJxgEhVdLHooLD8Rr6Zs71QXO/
 qYX2AJK6ECIy2YoYIVlS+tG0rvNP4rxTLWpKB5+qKVjZtUGQnXiL6oqlSSV5mNpeGnM3
 xm05We7Mp1ZAfxaZ2aqVfvpMIPrOMwN9prz1yFxl41fHk3tb8+Qifx8r4URQCQkwwp1v
 4GexbBboGmeXJuJZM2Kufud65akCLa2ZoCnMf5+DefquSOLx9T+OA1KW2ACnkh/KpQO5
 uHa40XHmbiptKLVOJNJlo9hkdiIccfdmN6B/cMJZqWs5L18qiMl6KM7wfyitVFHN3rxd
 sIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721904161; x=1722508961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lU5hmRpzkuCAtE5EweXfQtilHd8HHpg8NlUp12ztEJo=;
 b=YJyciBFz/+U8TsHMjonVZtBGMm55gIF1AMvC8OrRye43rgFvmVpGqbnhvRBhHuDZwC
 Bq1dSyLxTQrdu2gJqlQuMoafy51P71HigMAGyB0unvCDSm597Dt7wkbtamcA8v38EV36
 PUABEhXNXErcGhdB5jca+X08TP3Tne4qauxOpgL/IrrZtDCu0OUeg55Wok/0fs70CEtV
 +1dqZxAYE1wH9wwSIcNFJqBztEDaunqmGFSNH2ukg+YA2gELDCIwSoJ4uuQj4XMFSuOh
 /TZKzo4ZOrsIdZkdc93gaQJY9SpUQCp9OEt4I6lF9jok75Q61+rFXFCuWikyvcvuMStu
 BxfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPYoK8V+3h3PTp3eG2E5VIRFhhfOJd3u7qd/8rTjuWgYxCwPEV8Ag9VPIQkMhyGq5kpYrCBnkiSAuXWsFTDXF55xDSVBk=
X-Gm-Message-State: AOJu0YzcvxAN7EiUZv5e9301WbnddX4NDNQlgNp/Xw7doowK1SJf4SXu
 ZavzLODDdPNOmt4bq/2Lgy/yySeg0Yl4UiuhR1TOMV1ewJIMNdqIlI4tnpjwEFs=
X-Google-Smtp-Source: AGHT+IHfE4zAhe4uVOixIWCtI27FuBruig+B2/U9f4MmAKV+/UJAWCqxumuqY8hCq6qYB7M5qqTQQg==
X-Received: by 2002:a17:902:d490:b0:1fb:7b96:8479 with SMTP id
 d9443c01a7336-1fed3bf4cc9mr23397885ad.58.1721904160923; 
 Thu, 25 Jul 2024 03:42:40 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c8cd90sm11167505ad.44.2024.07.25.03.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 03:42:40 -0700 (PDT)
Message-ID: <df67c0be-e0d1-4ac2-9a88-2765417875ac@linaro.org>
Date: Thu, 25 Jul 2024 20:42:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
 <ZqIhJSbT2qQKJ7lj@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZqIhJSbT2qQKJ7lj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/25/24 19:55, Daniel P. Berrangé wrote:
> On Thu, Jul 25, 2024 at 09:35:22AM +1000, Richard Henderson wrote:
>> On 7/25/24 03:52, Thomas Huth wrote:
>>> The Avocado v88 that we use in QEMU is already on a life support
>>> system: It is not supported by upstream anymore, and with the latest
>>> versions of Python, it won't work anymore since it depends on the
>>> "imp" module that has been removed in Python 3.12.
>>>
>>> There have been several attempts to update the test suite in QEMU
>>> to a newer version of Avocado, but so far no attempt has successfully
>>> been merged yet.
>>>
>>> Additionally, the whole "make check" test suite in QEMU is using the
>>> meson test runner nowadays, so running the python-based tests via the
>>> Avocodo test runner looks and feels quite like an oddball, requiring
>>> the users to deal with the knowledge of multiple test runners in
>>> parallel (e.g. the timeout settings work completely differently).
>>>
>>> So instead of trying to update the python-based test suite in QEMU
>>> to a newer version of Avocado, we should try to better integrate
>>> it with the meson test runner instead. Indeed most tests work quite
>>> nicely without the Avocado framework already, as you can see with
>>> this patch series - it does not convert all tests, just a subset so
>>> far, but this already proves that many tests only need small modifi-
>>> cations to work without Avocado.
>>>
>>> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
>>> classes (e.g. based on cloud-init images or using SSH) really depend
>>> on the Avocado framework, so we'd need a solution for those if we
>>> want to continue using them. One solution might be to simply use the
>>> required functions from avocado.utils for these tests, and still run
>>> them via the meson test runner instead, but that needs some further
>>> investigation that will be done later.
>>>
>>>
>>> Now if you want to try out these patches: Apply the patches, then
>>> recompile and then run:
>>>
>>>    make check-functional
>>>
>>> You can also run single targets e.g. with:
>>>
>>>    make check-functional-ppc
>>>
>>> You can also run the tests without any test runner now by
>>> setting the PYTHONPATH environment variable to the "python" folder
>>> of your source tree, and by specifying the build directory via
>>> QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
>>> QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
>>>
>>>    export PYTHONPATH=$HOME/qemu/python
>>>    export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
>>>    export QEMU_BUILD_ROOT=$HOME/qemu/build
>>>    ~/qemu/tests/functional/test_virtio_version.py
>>>
>>> The logs of the tests can be found in the build directory under
>>> tests/functional/<arch>/<testname> - console log and general logs will
>>> be put in separate files there.
>>>
>>> Still to be done: Update the documentation for this new test framework.
>>
>> I'll say again that the download *must* be handled separately from the test
>> with timeout. This is an absolute show-stopper.
>>
>> I've tried this twice now, from a decently fast connection in central
>> Brisbane, and have had multiple downloads be canceled by the timeout.  Since
>> the download isn't clever enough to pick up where it left off, it will never
>> succeed.
> 
> This is a tricky problem the way the tests are currently written, given the
> desire for a minimal-change from the old avocado impl.
> 
> IIUC, avocado already had a per-test timeout, so would suffer the same
> problem with downloads exploding the "normal" running time when cached.

Avocado runs a first pass doing all of the downloads, and only afterward runs the actual 
timed tests.  I don't know the specifics of how, but it certainly obvious in the logging.

> Consider if we declared all required assets as class level variable
> 
>    class LinuxInitrd(QemuSystemTest):
> 
>        ASSETS = {
>           "fedora18": {
> 	    "url": ('https://archives.fedoraproject.org/pub/archive/fedora/li'
>                       'nux/releases/18/Fedora/x86_64/os/images/pxeboot/vmlinuz'),
>              "hash": "'41464f68efe42b9991250bed86c7081d2ccdbb21'"
> 	 }
>        }
> 
> Then, we change the 'fetch_asset' method to take an asset name, not a
> URL+hash:
> 
>        def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
>            kernel_path = self.fetch_asset("fedora18")
> 
> Now, 'fetch_asset' would lookup the URL + hash in the self.__class__.ASSETS
> dict, so the test would run exactly as before.

Sure, that's one possibility.

> This is all a non-trivial amount of work though, so I don't think
> it is reasonable todo this as part of the immediate conversion in
> this series.

I think that if we *don't* do this, then we cannot run in CI *at all* because we will be 
plagued with false timeouts.

And, frankly, any developer more than a few time zones away from the hosting of the asset 
will be continually frustrated.

I repeat: this is a show-stopper.


r~

