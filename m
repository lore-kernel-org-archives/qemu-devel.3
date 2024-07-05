Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C14C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 16:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPm88-0007hX-B1; Fri, 05 Jul 2024 12:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sPm86-0007h5-3w
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sPm84-0005UB-GZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720198186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AYsXIKIkwIjpOTAAE8c7mT0odQOrM5AARoaFfzVTp9c=;
 b=G3ILkWK/A1MvyKvCUaPk7kbtCt9Bnf1nw95+oJnw4uwXgQo3ByH6gLAwtr85RMP7ewYebx
 TVosVfj7AyuovV4zIHifzORX3oZjsL5cs45Y4Zg+axYz/lfCay5sdJYndgc7M6zcq8R9yo
 3Z7+MPzje+nIyh9F1HdDk9TQTIcUgts=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-_0BAsrJrMiOHKzchm7StUQ-1; Fri, 05 Jul 2024 12:49:45 -0400
X-MC-Unique: _0BAsrJrMiOHKzchm7StUQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b5f559b8c8so15469646d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 09:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720198185; x=1720802985;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYsXIKIkwIjpOTAAE8c7mT0odQOrM5AARoaFfzVTp9c=;
 b=uE/tc7OYlOO/kQdhiPDh9XNb/aZodNDwX3Pw9cjcQ+AY73wu0nYNb55d12I/PUCpQK
 +VlbqZykyD2wjOKN0CZIoIKtSvAFhZ6PEXM2KqoODQSsxFftvajm0k++3uI2rJe2ODgM
 D6YsT0B67j1/VbP/QX3jW6rl2d+egkkVsWxCNCoVW6u2xNonqlnbNVs7PE6agDh9Uc48
 u6/xKkZKEMoFd91/Bs0KXIMHpKJ4zMPaVulnaOxKrW66z4Es0Tneubsujs/eW+8dRvHc
 BS/p0eBNLUnn4qIx9XnEhu+yzNc0aEQm0S09nwzuIUgmCdw10T3ubvUofr3XKnNhYHJ4
 +1Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1N33HNqhqt4lSMsueTv39HUovYy+w9aC/mOwhKI8LiwHr+1y7evH5I5FfsK8YTQ6GCgJYBvVSY4MlJbacKfvAh/r3/0E=
X-Gm-Message-State: AOJu0YwD9OQbqnKQ8Vxi46Quy6D6Ar0AcdoMis6907jI4IMp/qKJQoHX
 H2UvFixCScuxsmqnZd13oOtOj+GV5Endyu4SCYgdf3zLL3oChDxLFZGXtzL0rvhn+WOSjaVAG9x
 JhLHd3bqVeni9ub1ynUFslWWc/ZYcAIqT8TIAPHRXt5HkACXQVz+r
X-Received: by 2002:a05:6214:5097:b0:6b0:74cb:96d9 with SMTP id
 6a1803df08f44-6b5ee6db1ccmr55522576d6.30.1720198185063; 
 Fri, 05 Jul 2024 09:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCl5hVGgVMAI4cHrOONtgeWUiGFZhfKENTwEb5z/tFcNcYEeZhf0BrZ/0nEy86AQ4+TmzbEA==
X-Received: by 2002:a05:6214:5097:b0:6b0:74cb:96d9 with SMTP id
 6a1803df08f44-6b5ee6db1ccmr55522296d6.30.1720198184757; 
 Fri, 05 Jul 2024 09:49:44 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-179-211.web.vodafone.de.
 [109.42.179.211]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5f82080d3sm7191026d6.144.2024.07.05.09.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 09:49:44 -0700 (PDT)
Message-ID: <5d3be228-1dbb-4e4a-8e20-fb76e4c90134@redhat.com>
Date: Fri, 5 Jul 2024 18:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/40] gitlab: don't bother with KVM for TCI builds
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Mads Ynddal <mads@ynddal.dk>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-21-alex.bennee@linaro.org>
 <07195265-2a54-4396-9724-2a63c98e45fb@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <07195265-2a54-4396-9724-2a63c98e45fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/07/2024 18.34, Philippe Mathieu-Daudé wrote:
> On 5/7/24 10:40, Alex Bennée wrote:
>> In fact any other accelerator would be pointless as the point is to
>> exercise the TCI accelerator anyway.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   .gitlab-ci.d/buildtest.yml   | 2 +-
>>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 425fc6479b..e3a0758bd9 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -635,7 +635,7 @@ build-tci:
>>       - TARGETS="aarch64 arm hppa m68k microblaze ppc64 s390x x86_64"
>>       - mkdir build
>>       - cd build
>> -    - ../configure --enable-tcg-interpreter --disable-docs --disable-gtk 
>> --disable-vnc
>> +    - ../configure --enable-tcg-interpreter --disable-kvm --disable-docs 
>> --disable-gtk --disable-vnc
> 
> Shouldn't we also disable the other accelerators for completeness?

No, this is a Linux machine, and there's only TCG and KVM available for 
Linux. No need to bother with the other accelerators here.

  Thomas



