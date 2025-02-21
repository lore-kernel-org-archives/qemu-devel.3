Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9BDC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSls-0005Lp-Jd; Fri, 21 Feb 2025 08:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tlSlk-0005Iu-Km
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tlSlh-0004kT-4a
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740143315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ju1t6qy1InYwgs5Ty/i/Vzln1asSl83mUBtJKgjA798=;
 b=QKvaTZ5xIuSnwgAKWiv68Hw9FHGL2mM0TTlo89ZAIi0ATkgKM0pzkYyHbNI72hz49mi/vO
 UXIIDUlYVetBKhXKRV7MYUeDXV/OUvUdV6k8R1zdGyoV8oo5jiqP3YeypDwakS2YcQNFlK
 MzJikEcQg3UjSw/vVXhlq0g1fq1l074=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-MM3Us7_WO1aqINJbHeEYNg-1; Fri, 21 Feb 2025 08:08:34 -0500
X-MC-Unique: MM3Us7_WO1aqINJbHeEYNg-1
X-Mimecast-MFC-AGG-ID: MM3Us7_WO1aqINJbHeEYNg_1740143313
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f39352f1dso884250f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740143313; x=1740748113;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ju1t6qy1InYwgs5Ty/i/Vzln1asSl83mUBtJKgjA798=;
 b=CuW00nyC3fXrOorDD6zJK938sGCCXvmMC4MURryCRU8gZG3EQtUOWVdaQoOYtkDyBG
 Cyj4MepSUdZl8gSvm+mfO6+1bnwBmTe2wIUIfidWpYtfOQv7qf9gfdZH1cvXhf5nUhEm
 w82E/eAHubVZ9fFGvXqqlUh46TP4SouHl8uneb+bC5qk8y9P1GdlTr5OMwLchdJXV+LL
 BiUbA01TP+4XVFvc+d/1GkfzluxU/EqtJYir8GhijgRyZsyLfe5anSM8XfXiCty6qnor
 Zme8bW0TVDUobzpTJgEL4Qy2sNz30fM/3GLBd5SsUpmRHxCbPvDecOhYhAnAhrPSuPZE
 fuMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoAE0SigD2otKrxfkJNzKfa5GTLIdwFUkJE+X5+mzGhmTTb0CETNUnn18THQHM+kCnL2Cejv6VHTxs@nongnu.org
X-Gm-Message-State: AOJu0YwJVhr2wtuYW6F1oGjGNt8kbxvCJnXD9o7Ml2GgLvua0zy81w0J
 pssxCp1vJOFHvAn+u1+4UyDwnYXCTes1sk0nOR5axt71m4EAZffCLCr85CNjIcEtWyhKshdbEZC
 0T4oId54lUECZ5B1DrrSoQz11gHcmkLRc8fqrrnmAJKTNUODmQVRi
X-Gm-Gg: ASbGnctG7zVMbWclEjePlbc4G53aasPtAuoSESXFOO/X9Wyf/pS+xgju7bS/yQzsrPg
 PekNxjaeJWTolulv9Xwi75QXW0hYAIpcq6uQZWfZchwSX+V2yHstIoidRxSS9111sqjNgh4rPkJ
 9A+FvitanVxcqRqq6G2eE7YjHDVAjwp4AAk33N1k8m4T3LoeDc1w9T6MohvLDvcH0KCKgMiFxcW
 HhCh61wHNoaxOik2Q0wm1+ti9eesgKYHpoW3AOs6POeyCbTI5vKuEEBK5TNsIBss+UOvGNV1WOx
 PU5+PArPswCjLTMus468bV1ze6ymRVgdai17sSyJj/TLm/I=
X-Received: by 2002:a05:6000:144d:b0:38f:3073:708 with SMTP id
 ffacd0b85a97d-38f70773556mr2488072f8f.3.1740143313089; 
 Fri, 21 Feb 2025 05:08:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuvkhu1HwzeU0XOMdCkYf1EvIyi8IlLsWR3kGsOJlm2ezIMlGSfhrmU4T5zwAOG5GFJelfbg==
X-Received: by 2002:a05:6000:144d:b0:38f:3073:708 with SMTP id
 ffacd0b85a97d-38f70773556mr2488055f8f.3.1740143312720; 
 Fri, 21 Feb 2025 05:08:32 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fdb19sm23903856f8f.95.2025.02.21.05.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:08:32 -0800 (PST)
Message-ID: <9e010d8e-314e-432e-83e4-81be91d43538@redhat.com>
Date: Fri, 21 Feb 2025 14:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: debugging functional tests that only fail in 'make
 check-functional'
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA-u+TMgQV8G8LvQixE95BGhfN5hyYdxcZTnxu5StVBKRw@mail.gmail.com>
 <014caf20-41d1-437b-bd0a-6ef263a709d1@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <014caf20-41d1-437b-bd0a-6ef263a709d1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 21/02/2025 13.54, Thomas Huth wrote:
> On 20/02/2025 19.39, Peter Maydell wrote:
>> I'm trying to debug some functional tests that fail for me
>> with 'make check-functional' on a debug build. Consistently
>> (well, same set of tests in two runs) when I run
>> 'make -j8 check-functional' these fail:
>>
>>   7/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_sx1
>>                          ERROR           173.31s   exit status 1
>> 10/44 qemu:func-thorough+func-aarch64-thorough+thorough /
>> func-aarch64-aarch64_virt            TIMEOUT         720.04s   killed
>> by signal 15 SIGTERM
>> 11/44 qemu:func-thorough+func-arm-thorough+thorough /
>> func-arm-arm_aspeed_ast2600              TIMEOUT         720.07s
>> killed by signal 15 SIGTERM
>> 12/44 qemu:func-thorough+func-aarch64-thorough+thorough /
>> func-aarch64-aarch64_sbsaref_alpine  TIMEOUT         720.07s   killed
>> by signal 15 SIGTERM
>> 40/44 qemu:func-thorough+func-arm-thorough+thorough /
>> func-arm-arm_aspeed_ast2500              TIMEOUT         480.01s
>> killed by signal 15 SIGTERM
>>
>> The aarch64-virt one is gpu issue, so I know about that one.
>> The others pass OK on a clang no-debug sanitizer build.
>>
>> If I try to run just the sx1 tests "by hand":
>>
>> $ (cd build/x86 && PYTHONPATH=../../python:../../tests/functional
>> QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3
>> ../../tests/functional/test_arm_sx1.py)
>> TAP version 13
>> ok 1 test_arm_sx1.SX1Test.test_arm_sx1_flash
>> ok 2 test_arm_sx1.SX1Test.test_arm_sx1_initrd
>> ok 3 test_arm_sx1.SX1Test.test_arm_sx1_sd
>> 1..3
>>
>> they pass; but inside the test framework that third sd test
>> errors: testlog-thorough.txt says:
> [...]
>> timed out after 60 seconds
> [...]
>> which I interpret to mean "we waited the 60 seconds the test says,
>> but the test didn't exit within that time".
>>
>> Any suggestions for how to debug?
> 
> Some TCG-based tests are slowing down very much when running on a shared 
> hyperthreaded CPU ... Do you have 8 real cores in your system, or rather 4 
> real cores with 2 SMT threads each? In the latter case, have a try whether 
> "make -j4" works better.
> 
> We apparently also increased the timeout in this test in the past already, 
> see commit 92ee59bf56ba42954166e56ab112afe10f3c7556 ... does it work better 
> if you increase the timeout even further?
> 
>> (Also the console.log is empty regardless of whether the
>> test passes or fails; this doesn't seem right.)
> 
> I think we only log the console output when we look for strings
> in the output. Since this test does not look for any strings,
> there is no log.
> Something like this causes some log to be generated:
> 
> diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/ 
> test_arm_sx1.py
> --- a/tests/functional/test_arm_sx1.py
> +++ b/tests/functional/test_arm_sx1.py
> @@ -43,7 +43,8 @@ def test_arm_sx1_initrd(self):
>           self.vm.add_args('-append', f'kunit.enable=0 rdinit=/sbin/init 
> {self.CONSOLE_ARGS}')
>           self.vm.add_args('-no-reboot')
>           self.launch_kernel(zimage_path,
> -                           initrd=initrd_path)
> +                           initrd=initrd_path,
> +                           wait_for='Boot successful')
>           self.vm.wait(timeout=60)

Actually, thinking about this twice, this might even be a valid fix for your 
problem. Without waiting for a a string that signals a successful boot, the 
test was just firing up the guest kernel and then waiting for 60 seconds for 
the guest kernel to boot up and shut down again. If the boot is delayed for 
some reasons, these 60 seconds might still not be enough. So if we wait for 
a successful boot first before starting with the timeout, the 60 seconds 
afterwards should be enough for a successful shut down, I guess?

  Thomas


