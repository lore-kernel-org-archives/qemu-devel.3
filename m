Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA65C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8N8-0004yK-Ix; Thu, 20 Feb 2025 10:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tl8N6-0004xq-JV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:21:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tl8N4-0007lo-9S
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740064908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v6DRenldR9248QQ9M7j4dj5Sv6X+Rh0DVFMeg+anvqI=;
 b=Y9lU/FyNNyXdnSP/H1RV52jp0Grywr3ATao/Sdm0NLRKCQJm9hWFYXzSXe+HEEbgyZRM/Z
 XpoKEfV0+dhyY8qwNiDO2SeJQ3hrSF53+KqaLa9Z64bmnRVQ/Fz2ayN/Y5aWg7C6DeH813
 iMVPOVN/qNkAtPYr0KG8yyIRv/8ceM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-KB36bQydM7S5g9WrgElo5A-1; Thu, 20 Feb 2025 10:21:46 -0500
X-MC-Unique: KB36bQydM7S5g9WrgElo5A-1
X-Mimecast-MFC-AGG-ID: KB36bQydM7S5g9WrgElo5A_1740064906
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so5400285e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740064905; x=1740669705;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v6DRenldR9248QQ9M7j4dj5Sv6X+Rh0DVFMeg+anvqI=;
 b=opAv7qNzG7d37dToT5j11a503q10NFxv5tR0wulUeelO6FgNzKx/oiJXf/1bySlr1B
 ARh8FiLuqXmP9aQhS0iJNEf6ILOcClDu1gQj6WuE0URiUSMjsPhZA/fc6hqaSmJ3zzAI
 W4cCK+V+9OkC1oPTDw19qDy4/d/m64QtZqjQeeptKIKDoCvIMrlZZUJ3nGcXQ8trobKQ
 TVDo6XXGWAsgY0rCRSFWE24ZdS4oOnBqQ6h5x+gP6r/X+8pV+gjlsSfpUcU8Fz3vLADR
 IlIRZ+5CAMTDrb/jNOqPa/Lba438T8ULC2ihHM+254551rKPbImNXdWBxLE0kkd9GMc5
 eqtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUndRJUJPl0gcSZJPVrVWjVKArQiYXsGsWcPmLF7rKINfSnpnrO95WQiw2T6ezOOrqO1ZIdQ3FoUS29@nongnu.org
X-Gm-Message-State: AOJu0YxvDMe26NLgQyiFLBhiBoTKiK9o/mSFpami6+zL4yPqI5Fdei6S
 lUWUW/EPIo/ODHuX6sG0q9306h88feS1Y1D70VY84537KB7O2elqR/RlU0nr0mi8ZOLiLwFPC7g
 Lq9kafG/BI/6bivxHNleIwh8AD8p38kd0uz3dlOAZL+5Td3PcZzl4
X-Gm-Gg: ASbGncs4GlrRWLwGGKY3hHs0qKXmhlVP2CDu1pd75ZwiLdKkidAkG3YCcGTN4FIQxbM
 D08L39NXYqdV9I6g7tPkc7E4t6K1ZPrTetUesb2gmvnYQhxGPtGtFgA3SzxXEzt8jtn9CMnfrAm
 U+gFq5B8RSJpwfKtV+8s0cYo3674XNt1Vq20hz/gvbc3EyjkRk60lg+5tfDXFrf4wZ5YQNITCOF
 DJ/B/THykO/rRkuOa3UDIOSqNhfkwNd/CKP/XA4uaqxz7Qmzr24nGbKyTmqMFFFft6s+6Q7Kmu7
 a6e4WPdogXzHyRHWk3T2zxfc67VlAvqPmufx
X-Received: by 2002:a05:600c:314d:b0:439:9898:f18c with SMTP id
 5b1f17b1804b1-4399898f441mr78044795e9.26.1740064905566; 
 Thu, 20 Feb 2025 07:21:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOtEO+feTYNdWdJVNMceeAQvYwM1JPu+PI/twj43GhPhZTwmkvOhPQ0rZAgzjSJprhPWZ6yw==
X-Received: by 2002:a05:600c:314d:b0:439:9898:f18c with SMTP id
 5b1f17b1804b1-4399898f441mr78044515e9.26.1740064905138; 
 Thu, 20 Feb 2025 07:21:45 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987d1865asm116806055e9.3.2025.02.20.07.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 07:21:44 -0800 (PST)
Message-ID: <8c9e41b6-44ab-427f-a381-7e160a1b50e0@redhat.com>
Date: Thu, 20 Feb 2025 16:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Change notes on x86 machine type deprecation
 into a general one
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20250116064644.65670-1-thuth@redhat.com>
 <ad3d06df-f0ae-4508-b979-c838b3647510@linaro.org>
 <Z4jPGGezEK3XRMl8@redhat.com> <Z4jmfnfLdsTbHRFd@redhat.com>
 <20250220095733-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250220095733-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20/02/2025 15.59, Michael S. Tsirkin wrote:
> On Thu, Jan 16, 2025 at 10:59:10AM +0000, Daniel P. Berrangé wrote:
>> On Thu, Jan 16, 2025 at 09:19:20AM +0000, Daniel P. Berrangé wrote:
>>> On Thu, Jan 16, 2025 at 09:48:50AM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 16/1/25 07:46, Thomas Huth wrote:
>>>>> We now have a general note about versioned machine types getting
>>>>> deprecated and removed at the beginning of the deprecated.rst file,
>>>>> so we should also have a general note about this in removed-features.rst
>>>>> (which will also apply to versioned non-x86 machine types) instead of
>>>>> listing individual old machine types in the document.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>    docs/about/deprecated.rst       |  7 -------
>>>>>    docs/about/removed-features.rst | 11 +++++------
>>>>>    2 files changed, 5 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>>>> index 4a3c302962..7b42d6eecc 100644
>>>>> --- a/docs/about/deprecated.rst
>>>>> +++ b/docs/about/deprecated.rst
>>>>> @@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>>>>>    better reflects the way this property affects all random data within
>>>>>    the device tree blob, not just the ``kaslr-seed`` node.
>>>>> -``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
>>>>> -''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>>>> -
>>>>> -These old machine types are quite neglected nowadays and thus might have
>>>>> -various pitfalls with regards to live migration. Use a newer machine type
>>>>> -instead.
>>>>> -
>>>>>    PPC 405 ``ref405ep`` machine (since 9.1)
>>>>>    ''''''''''''''''''''''''''''''''''''''''
>>>>> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
>>>>> index c6616ce05e..156c0c253c 100644
>>>>> --- a/docs/about/removed-features.rst
>>>>> +++ b/docs/about/removed-features.rst
>>>>> @@ -972,6 +972,11 @@ from Linux in 2021, and is not supported anymore by QEMU either.
>>>>>    System emulator machines
>>>>>    ------------------------
>>>>> +Note: Versioned machine types that have been introduced in a QEMU version
>>>>> +that has initially been released more than 6 years before are considered
>>>>> +obsolete and will be removed without further notice in this document.
>>>>> +Please use newer machine types instead.
>>>>
>>>> This is an improvement. I still wonder if we shouldn't list them removed
>>>> machines here, to help old users.
>>>>
>>>>    Removed in 4.0:
>>>>      - pc-0.10
>>>>      - ...
>>>>    Removed in 9.0:
>>>>      - pc-i440fx-2.3
>>>>    Remove in 10.0:
>>>>      - pc-i440fx-2.4
>>>>      - pc-i440fx-2.5
>>>>      - pc-i440fx-2.6
>>>>      - pc-q35-2.4
>>>>      - pc-q35-2.5
>>>>      - pc-q35-2.6
>>>>      - ARM virt-2.6
>>>>      ...
>>>>
>>>> ?
>>>
>>> A big part of the reason for the macros for machine type deprecation & then
>>> skipping machine registration, was to eliminate repeated manual work that is
>>> visible to users if forgotten.
>>>
>>> We still have the actual code deletion which is manual, but that's harmless
>>> as even if forgotten, such that the code exists, the machine type will have
>>> been entirely removed from view.
>>>
>>> As such I'm pretty reluctant to suggest we create a new place which needs
>>> manually updating when we remove machine types.
>>>
>>> I wonder if its possible to get an auto-generated version number into the
>>> documentation though ?
>>
>> To answer my own question, yes with something like this:
>>
>> diff --git a/docs/conf.py b/docs/conf.py
>> index 31bb9a3789..899ad13305 100644
>> --- a/docs/conf.py
>> +++ b/docs/conf.py
>> @@ -110,6 +110,22 @@
>>       else:
>>           version = release = "unknown version"
>>   
>> +bits = version.split(".")
>> +major = int(bits[0])
>> +minor = int(bits[1])
>> +micro = int(bits[2])
>> +
>> +# Dev snapshot, adjust to next release version
>> +if micro >= 50:
>> +    micro = 0
>> +    minor += 1
>> +    if minor == 3:
>> +        major += 1
>> +        minor = 0
>> +
>> +ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)
>> +ver_machine_deletion_version = "%d.%d.%d" % (major - 6, minor, micro)
>> +
>>   # The language for content autogenerated by Sphinx. Refer to documentation
>>   # for a list of supported languages.
>>   #
>> @@ -138,7 +154,18 @@
>>   # environment variable is not set is for the benefit of readthedocs
>>   # style document building; our Makefile always sets the variable.
>>   confdir = os.getenv('CONFDIR', "/etc/qemu")
>> -rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
>> +
>> +vars = {
>> +    "CONFDIR": confdir,
>> +    "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
>> +    "VER_MACHINE_DELETION_VERSION": ver_machine_deletion_version,
>> +}
>> +
>> +rst_epilog = "".join([
>> +    ".. |" + key + "| replace:: ``" + vars[key] + "``\n"
>> +    for key in vars.keys()
>> +])
>> +
>>   # We slurp in the defs.rst.inc and literally include it into rst_epilog,
>>   # because Sphinx's include:: directive doesn't work with absolute paths
>>   # and there isn't any one single relative path that will work for all
>>
>>
>> Then....
>>
>>
>>>
>>> eg, so we can have an entry in 'deprecated.rst'
>>>
>>>    Versioned machine types for x86_64, i386, aarch64  <other targets here>
>>>    -----------------------------------------------------------------------
>>>
>>>    In accordance with our versioned machine type deprecation policy,
>>>    all machine types older than 7.0.0 have been deprecated.
>>
>> use   |VER_MACHINE_DEPRECATION_VERSION|  here
>>
>>>
>>> and in 'removed-features.rst'
>>>
>>>    Versioned machine types for x86_64, i386, aarch64  <other targets here>
>>>    -----------------------------------------------------------------------
>>>
>>>    In accordance with our versioned machine type removal policy,
>>>    all machine types older than 4.1.0 have been removed.
>>
>> use   |VER_MACHINE_DELETION_VERSION|  here
>>
>> though, we should not add to removed-features.rst until 10.1.0 cycle
>> since we don't start to do automatic deletion until then.
>>
>> With regards,
>> Daniel
> 
> It's been quiet. Thomas, wdyt?

I assumed Daniel would go forward and post his idea as a proper patch?

  Thomas


