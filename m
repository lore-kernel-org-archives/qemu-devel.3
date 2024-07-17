Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F17C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzeL-0002dJ-Hf; Wed, 17 Jul 2024 04:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTzeI-0002cS-NQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTzeF-0003xK-TX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721203465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xEi16Z4RFIM7WGCkipN1dy7uSuxGbMRj1vbwVTjVuuE=;
 b=YIFWHHjvvQoq5Ruc1Uwy7uay5hfw9wK3kKYHznbXTXJkxfGQkXBnFHv0XPZCXr+5fz01C2
 LaIsK9vo9gXieKc2fFwx6ItMoJKewpdT0i34RWlzQbAbrqYqkGhR5qlr/0PiH5cgC4EAVN
 p7+SgeU5QNS/H6PlYEN5w14zPhyzy9E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-6c4iJVZAM0q38jB59ifBZA-1; Wed, 17 Jul 2024 04:04:23 -0400
X-MC-Unique: 6c4iJVZAM0q38jB59ifBZA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42725d3ae3eso47770725e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 01:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721203462; x=1721808262;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xEi16Z4RFIM7WGCkipN1dy7uSuxGbMRj1vbwVTjVuuE=;
 b=E/ApZbhdG1OhSFIGFNWNMRNLYFgtnI1BUfmn4he/wwOjncZkGwpsyubIO9wvDu05tO
 PSSXU/3xohutKRlXPmrjuWuyaNIEGU3/ILuUA8ind9Uuw7kp+6vCrLbKEB7uVgjJSvkK
 y/U28u0TPtOcPrHoTqtxnVXSyCghS6O8RjXwmefLudPZKr91lzYd0NUnZwMrKh6skiwv
 A+dDn5vXDb9RStLIW3Xi8g7CvNgVVo1OzrGasLgyQ4dVFulct6o6x7NTnh30x5uSuggL
 zXoRRwfM0ViuhvY/hDNDmRM72GYcETMwo7vrzxKaRlJqFHBn8AXDTYHfRhF9ZyXJwl4l
 bQUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzgrQVHX9FSCJAmzMqgWOSaARYj17CtBs9sU08tYbFYPsIkFhLAFleDYU3EpzUMPLkA/T0Tk0VWMnz4+9wND5MaX9k03c=
X-Gm-Message-State: AOJu0YxERXdjXI6HjZAqseHecckHlxxrW+Z6hhnfaMYR+xyHrQIZZNrT
 K1ZrHvPx5ceGTgHJ6Tgzx+nGV1y7zenblHjsgk75ImPjM0ZycGdaR+uVonJ+e0i83kuG2dfbYni
 iW77GH16Jv2bV3h/YDKj9O80oETT8mSWpPMAa6bOwwS9FnwAxFpgx
X-Received: by 2002:a05:600c:474a:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-427c2cd075amr5429595e9.18.1721203462015; 
 Wed, 17 Jul 2024 01:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC7FyAV7ffEiqi6BXRiYWHbnRx/N8tvzLECVLkEJoSpvQkMKkekwwnPZ7H9HGIjjDkebq31Q==
X-Received: by 2002:a05:600c:474a:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-427c2cd075amr5429455e9.18.1721203461653; 
 Wed, 17 Jul 2024 01:04:21 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db0492asm10972921f8f.103.2024.07.17.01.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 01:04:21 -0700 (PDT)
Message-ID: <2cae80ea-dbf6-4b1c-a086-756a5c6f15e0@redhat.com>
Date: Wed, 17 Jul 2024 10:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <ZpalCr_tcx7nsevQ@redhat.com>
 <b34746d2-b55d-486e-91a8-1394be4dfaeb@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b34746d2-b55d-486e-91a8-1394be4dfaeb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 16/07/2024 19.03, Thomas Huth wrote:
> On 16/07/2024 18.51, Daniel P. Berrangé wrote:
>> On Tue, Jul 16, 2024 at 01:26:03PM +0200, Thomas Huth wrote:
> ...
>>> So instead of trying to update the python-based test suite in QEMU
>>> to a newer version of Avocado, we should maybe try to better integrate
>>> it with the meson test runner instead. Indeed most tests work quite
>>> nicely without the Avocado framework already, as you can see with
>>> this patch series - it does not convert all tests, just a subset so
>>> far, but this already proves that many tests only need small modifi-
>>> cations to work without Avocado.
> ...
>>> Now if you want to try out these patches: Apply the patches, then
>>> recompile and then run:
>>>
>>>   make check-functional
>>>
>>> You can also run single targets e.g. with:
>>>
>>>   make check-functional-ppc
>>>
>>> You can also run the tests without any test runner now by
>>> setting the PYTHONPATH environment variable to the "python" folder
>>> of your source tree, and by specifying the build directory via
>>> QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
>>> QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
>>>
>>>   export PYTHONPATH=$HOME/qemu/python
>>>   export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
>>>   export PYTHONPATH=$HOME/qemu/build
>>>   ~/qemu/tests/functional/test_virtio_version.py
>>
>> For the whole series as is
>>
>>   Tested-by: Daniel P. Berrangé <berrange@redhat.com>
>>
>> as it does what you claim it does here when I tried it.
> 
> Thanks!
> 
>>> The logs of the tests can be found in the build directory under
>>> tests/functional/<testname> - console log and general logs will
>>> be put in separate files there.
>>
>> As an example, one dir name appears to be:
>>
>>    __main__.MemAddrCheck.test_phybits_ok_pentium_pae
>>
>> I'd rather prefer it if the dir name matched the test script
>> file name - in this case test_mem_addr_space.py, as I don't
>> want to have to lookup which class names were defined inside
>> each test script. We could drop the "test_" prefix from the
>> method name too
>>
>> IOW, could we make this dir name be:
>>
>>    test_mem_addr_space.phybits_ok_pentium_pae
> 
> I can try to change that, indeed ... but the boilerplate code will increase 
> a little bit, I guess, since I cannot simply rely on the unittest.id() 
> function in that case anymore...

After looking at this for a while, I think it's maybe best to ditch the idea 
of making the .py files directly runnable and run the tests via a simple 
pycotap runner instead. Then you get proper module names:

$ pyvenv/bin/python3 -m pycotap test_virtio_version
TAP version 13
ok 1 test_virtio_version.VirtioVersionCheck.test_conventional_devs
ok 2 test_virtio_version.VirtioVersionCheck.test_modern_only_devs
1..2

  Thomas



