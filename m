Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C5C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcghB-0006sw-Lj; Wed, 21 Feb 2024 02:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcghA-0006sl-Hz
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcgh2-0005RL-D6
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708499217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yIhX8BnZOwWsfK7+P9wFDxso7BwP3JZVl3hqeZRoB0w=;
 b=fdrpCSBUGsPMuwmzzgj5WqBq92ZuIs91RZjAUk6M54uhTYCRENXfQM/aw+RsTdF+ljChIH
 GaPWISETpcCKMg1QO74o0ETNVHB3WYizQDonB76hQrI3nzvK5OSshb6lmhL4ACoIQACuJZ
 PN/WJdR3IisK7GZGMMq4w9laUsvJggQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-107TDIZJNUeRjHr-vFEgiA-1; Wed, 21 Feb 2024 02:06:55 -0500
X-MC-Unique: 107TDIZJNUeRjHr-vFEgiA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a30f9374db7so743760866b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 23:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708499214; x=1709104014;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yIhX8BnZOwWsfK7+P9wFDxso7BwP3JZVl3hqeZRoB0w=;
 b=o/7JLrg7HDtLyr7DAxaOx+eR2Uo9DoIlo8In9Vedf5G4Hi5ZX1doXG6/5RiZ2dR7BQ
 l6QjU+4NaamkoC6bqlpm2NbfZfMtRc+edVAVciGUph4Jq8io0pF5ZS5Hs7Ziz4oYzOUW
 zcJL4EJLgGPJZgDdKHTsoEoBpoW1HQ7/ANjqXUfwgGWMEySCplcUIuU7sg2NOyNFH0FE
 wDIyTtVzcAnw8FvbtVLBFt7qYkKe3OcjkDG0tGasxsdRNBzF9BDWJ7KcgPzZcogayG8j
 1oIpP0jWgVdqfov+YiqJGzSDHRyuSdEeT9s5N7i4RyKIZ9KbZxNT+aHrQXZSf6l8ofMS
 89EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJRupUxx3/0Ifc1i3b5yQAMl1go6ZZ0xBjnPIXhLISX3CA3ipQxpHPXoTUw9ojgvmTlzdiJTsBHkv4BBPyoqVWfouFYzI=
X-Gm-Message-State: AOJu0YxS8jjx2Vayr34Z9Y6Y0DHb2Gx7S5h1dXDudFdbHzDA/+0/HGSJ
 pPKAHLbIf75KuT62Vf0p6mEsxXtylsjo5GRa+xx3sIwBtAwxcc5YCoEzaVMCUuS12jVxlTB4nu3
 pwyox++aU0HTA2X4dhUrC26RbGlLiuF2QsivkHMKyUfuB/aitHbc/
X-Received: by 2002:a17:907:20e2:b0:a3e:9df3:b2e7 with SMTP id
 rh2-20020a17090720e200b00a3e9df3b2e7mr6651916ejb.35.1708499214715; 
 Tue, 20 Feb 2024 23:06:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+SoktgSaL6N1M/Tn4o4f31z+Xrmcpv2tsMGkFYOYhmK2ui1tFhGIXg3VnXM0vMy0IgGF4Rg==
X-Received: by 2002:a17:907:20e2:b0:a3e:9df3:b2e7 with SMTP id
 rh2-20020a17090720e200b00a3e9df3b2e7mr6651906ejb.35.1708499214386; 
 Tue, 20 Feb 2024 23:06:54 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 zh11-20020a170906880b00b00a3ec216ec6csm2207743ejb.45.2024.02.20.23.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 23:06:53 -0800 (PST)
Message-ID: <8da15519-ff9e-4b3b-9e52-44403be554d8@redhat.com>
Date: Wed, 21 Feb 2024 08:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
 <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
 <ZdT1pyGMcsNGja3M@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZdT1pyGMcsNGja3M@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/02/2024 19.55, Daniel P. Berrangé wrote:
> On Tue, Feb 20, 2024 at 07:46:37PM +0100, Philippe Mathieu-Daudé wrote:
>> On 20/2/24 18:44, Peter Maydell wrote:
>>> We don't support 32-bit Windows any more, so we don't need to defend it
>>> with this CI job.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    .gitlab-ci.d/container-cross.yml              |   5 -
>>>    .gitlab-ci.d/crossbuilds.yml                  |  14 ---
>>>    .../dockerfiles/fedora-win32-cross.docker     | 111 ------------------
>>>    tests/lcitool/refresh                         |   5 -
>>>    4 files changed, 135 deletions(-)
>>>    delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
>>
>>
>>> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
>>> index d19d98cde05..987ba9694ba 100644
>>> --- a/.gitlab-ci.d/crossbuilds.yml
>>> +++ b/.gitlab-ci.d/crossbuilds.yml
>>> @@ -159,20 +159,6 @@ cross-mips64el-kvm-only:
>>>        IMAGE: debian-mips64el-cross
>>>        EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
>>> -cross-win32-system:
>>> -  extends: .cross_system_build_job
>>> -  needs:
>>> -    job: win32-fedora-cross-container
>>> -  variables:
>>> -    IMAGE: fedora-win32-cross
>>> -    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
>>> -    CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
>>> -                        microblazeel-softmmu mips64el-softmmu nios2-softmmu
>>
>> Thomas, is it possible to add mips64el-softmmu to the cross-win64-system
>> job or is it already at the timeout limit?
> 
> If its too close to the limit, we could add  across-win64-system-part2
> job now we freed time from the deleting the win32 job.

Looking at a recent run:

  https://gitlab.com/qemu-project/qemu/-/jobs/6189303285

It seems like we're in the 50 minutes range here, and timeout is set to 
1h20m, so I think there should still be enough headroom for adding 
mips64el-softmmu to that job.

  Thomas



