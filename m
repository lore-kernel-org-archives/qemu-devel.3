Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DFCC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7h1-0004IR-QZ; Thu, 22 Feb 2024 06:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd7gz-0004GP-TO
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd7gy-0001GR-Bk
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708603003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9/KT9qWZ8xS1ejd6GcZZzkwSG6eL5eeYgqXhV7GpNKc=;
 b=aJFMNrxgq2iQPyt+FuMF6dOzYUyHYC0bnt7b24k6Hwo106ek5NK9OIs87zPlhphw+JND/1
 /xXuYqrGHWB+sCIMcjHZs8gSwNJWxHlx8hip+yXbF7tmDBzGhT7dGyjoi5ilBCm4DJEqAQ
 /K1eG9O2ZeLxyCRIgeXUBgXzfQQDIrU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-xWcG3pDQNdWJvLieOk3HDg-1; Thu, 22 Feb 2024 06:56:41 -0500
X-MC-Unique: xWcG3pDQNdWJvLieOk3HDg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a26f2da3c7bso387582666b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 03:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708603001; x=1709207801;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/KT9qWZ8xS1ejd6GcZZzkwSG6eL5eeYgqXhV7GpNKc=;
 b=o6cOagfLFZAtjGR7yFvVS5YDZY4dFEG1zUxL8QzNEoWtuyXASZ0yQDJxap+BsVzegT
 1LCo7J4ZPscCsKAZ67bFz8ZcxgGSf8Qhj+AicfeyHXuh78LDfFE2YyVJA3UL3EBTuL7K
 +igeIM6aE2Axauss2Uc4ZkvG/9oOZBARzx1kuq8OikSvPiuGdSDtcBRhoTg8T1OVQLIg
 GJwQyU4Lzb7DpJ0accWSCdL8OaHParuwbVt+0HuNOEYE8hTAM4dXwf2diRvc9P3n9vE1
 7MxynMQzZ88Fz4NUz91N6mym2oPEDDT+/4xORtstRniR0YR+Im+Lg0zmMEfhrFv2QoUi
 Upjw==
X-Gm-Message-State: AOJu0YxS6LYgSfHlbjpPfhX+A+mCJlDQV+SsfrmUrONZ3laLnHTN0dRc
 Xd0+9P9Eeebyt9Y2dFjHnkr+VPNGz//B8YSG/7GYDNT/hRwwwr8WKbF0Y9GeH4Cbcwf3vu7Dbo2
 j5rvp3Tcu/TmI1dXG6/oSCgFnRVzaAsfs+n//MaDK8sbQfF/JCjjm
X-Received: by 2002:a17:906:398c:b0:a3e:b3e4:31e2 with SMTP id
 h12-20020a170906398c00b00a3eb3e431e2mr7707416eje.73.1708603000855; 
 Thu, 22 Feb 2024 03:56:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXwsFZb2UeReR/GIx85p3oHNkoDVgG1tct6UQQvbEV++XvT7bqcWYyWUcnQnU8m1q7RTtkTA==
X-Received: by 2002:a17:906:398c:b0:a3e:b3e4:31e2 with SMTP id
 h12-20020a170906398c00b00a3eb3e431e2mr7707405eje.73.1708603000571; 
 Thu, 22 Feb 2024 03:56:40 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 w24-20020a1709067c9800b00a3ec01c4079sm3501139ejo.224.2024.02.22.03.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 03:56:40 -0800 (PST)
Message-ID: <83ba064a-d0ec-46c0-a6a3-f767350c5542@redhat.com>
Date: Thu, 22 Feb 2024 12:56:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
 <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
 <CAFEAcA_1zEQ-bT8bE=74FC24fz7HYN6j8ZLZVaDn7C47vraNAQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_1zEQ-bT8bE=74FC24fz7HYN6j8ZLZVaDn7C47vraNAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/02/2024 12.44, Peter Maydell wrote:
> On Tue, 20 Feb 2024 at 18:46, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
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
>>>
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
> This is a skip, i.e. exclude, list, not an include list. So dropping
> this job is not removing mips64el-softmmu from coverage.
> The Windows build coverage we lose will be the targets we
> are skipping in the cross-win64-system job and weren't
> skipping here:
>   or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
>   tricore-softmmu xtensaeb-softmmu
> 
> which then fall into the same bucket as
>     alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
>     microblazeel-softmmu nios2-softmmu
> 
> which are already not built in either cross-win*-system job.
> 
> Is there a reason why we aren't covering those in Windows
> builds?

I guess it's just an arbitrary list to keep the compilation time within the 
timeout limits.

  Thomas


