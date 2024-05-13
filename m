Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3CAC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WZD-00079M-EA; Mon, 13 May 2024 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6WZ6-0006xn-6v
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6WZ4-0000my-Ia
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715610126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i3CMXmDyPeNlWJgC3Plu4yRBWS4XEv/QRCpW8mAP3YI=;
 b=XZZDMfd44nxmFohJyOdpYjIgA3fwZ8TRFKjVqAO17iXOBSKlkCInOZbS96/9YZhOdIxpZC
 LetixqkVjSRq+gNv+DHQxzisndpuvfrr76MFSqbXL5anoG2YxWKnzodMY4QkuW6Zl+c/Kc
 9MsX9E9808pm9VvdJuS3WBAEwpkzGx4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-6YtnYSpTP4mzVw-SzCE-sQ-1; Mon, 13 May 2024 10:22:04 -0400
X-MC-Unique: 6YtnYSpTP4mzVw-SzCE-sQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792c10a363bso634618385a.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610124; x=1716214924;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i3CMXmDyPeNlWJgC3Plu4yRBWS4XEv/QRCpW8mAP3YI=;
 b=BPIhZ019op5V3N8PKL4WNQUnnjR6Vlcrl7dsaecNLeaA/L5fTo+Wg1M59Dh6V9iTDT
 A54D/J9c3YwB9ho3AEeC5UmiygvbeCENQP9v7qSpP8dKLJBe54Rg2OchEw3MlYVCFTuP
 Bz77OW423FDbdi6N1nToN6KvCIz1huuimxyYid4LyvPPqPmE93kOsq4zlF917sZvl8Vg
 tF4BP2RfUfTx95rCP7HX1eTW/xqIEjUMTb/rUDb/VGkrMLl6RxS97WsbSXPROuHbhhtj
 0cc/WGw68YKTdP5C+eVyKcfMmaNAosnI4T+BlmQxpv+H1AcT7FNXatiAiSuyMWcXN2bi
 4zdA==
X-Gm-Message-State: AOJu0Yz2zFeN7iy7+L4TNCpE1/X9Fb07n8LDtHtNq5Om3pAhWfEBxl3R
 d9i0TnlsuIT4+APIJ8gVN61zXvIHTSZ+wDYc3dEDBW+ayEAyK87wiKdvRo6itDiUvIEPrvUU3aV
 6ezhDiI8xVUjvWVWN38pxfDEcYwpm86YZAR+0eGpsVPoBFsvKyqCx
X-Received: by 2002:a05:6214:5347:b0:6a0:b1a2:7540 with SMTP id
 6a1803df08f44-6a16824c289mr127998636d6.61.1715610123923; 
 Mon, 13 May 2024 07:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7o8u5WnXQice15td9OrJjSK46EJ+sjGN+AJNr0bS0zEVCezQw0Z9Pjz7Y+HJrYcLcRhorYw==
X-Received: by 2002:a05:6214:5347:b0:6a0:b1a2:7540 with SMTP id
 6a1803df08f44-6a16824c289mr127998336d6.61.1715610123552; 
 Mon, 13 May 2024 07:22:03 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1857e3sm43668446d6.52.2024.05.13.07.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:22:03 -0700 (PDT)
Message-ID: <22d84c81-7c7b-4656-8606-cf919b26d0a1@redhat.com>
Date: Mon, 13 May 2024 16:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/lcitool: Remove g++ from the containers (except
 for the MinGW one)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240513102252.48884-1-thuth@redhat.com>
 <20240513102252.48884-3-thuth@redhat.com> <ZkHrXOR05UkkMn2X@redhat.com>
 <41974e51-cee5-4a62-bcab-db9b78f76aee@redhat.com>
 <ZkIDYTTtMlX20-xW@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZkIDYTTtMlX20-xW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/05/2024 14.11, Daniel P. Berrangé wrote:
> On Mon, May 13, 2024 at 02:05:16PM +0200, Thomas Huth wrote:
>> On 13/05/2024 12.28, Daniel P. Berrangé wrote:
>>> On Mon, May 13, 2024 at 12:22:50PM +0200, Thomas Huth wrote:
>>>> We don't need C++ for the normal QEMU builds anymore, so installing
>>>> g++ in each and every container seems to be a waste of time and disk
>>>> space. The only container that still needs it is the Fedora MinGW
>>>> container that builds the only remaining C++ code in ./qga/vss-win32/
>>>> and we can install it here with an extra RUN statement instead.
>>>>
>>>> This way we can also add the mingw-w64-tools package quite easily
>>>> which contains the x86_64-w64-mingw32-widl program that is required
>>>> for compiling the vss code of the guest agent (it was missing before
>>>> this change, so the VSS code was actually never compiled in the CI).
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    tests/lcitool/projects/qemu.yml |  1 -
>>>>    tests/lcitool/refresh           | 10 ++++++++--
>>>>    2 files changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
>>>> index 9173d1e36e..b63b6bd850 100644
>>>> --- a/tests/lcitool/projects/qemu.yml
>>>> +++ b/tests/lcitool/projects/qemu.yml
>>>> @@ -22,7 +22,6 @@ packages:
>>>>     - findutils
>>>>     - flex
>>>>     - fuse3
>>>> - - g++
>>>>     - gcc
>>>>     - gcc-native
>>>>     - gcovr
>>>> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
>>>> index 24a735a3f2..dda07ddcd1 100755
>>>> --- a/tests/lcitool/refresh
>>>> +++ b/tests/lcitool/refresh
>>>> @@ -109,6 +109,11 @@ debian12_extras = [
>>>>        "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
>>>>    ]
>>>> +fedora_mingw_extras = [ "\n"
>>>> +    "RUN nosync dnf install -y mingw64-gcc-c++ mingw-w64-tools && \\\n"
>>>> +    "  ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-c++ && \\\n"
>>>> +    "  ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-g++\n\n"
>>>> +]
>>>>    def cross_build(prefix, targets):
>>>>        conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
>>>> @@ -193,8 +198,9 @@ try:
>>>>        generate_dockerfile("fedora-win64-cross", "fedora-38",
>>>>                            cross="mingw64",
>>>> -                        trailer=cross_build("x86_64-w64-mingw32-",
>>>> -                                            "x86_64-softmmu"))
>>>> +                        trailer="".join(fedora_mingw_extras)
>>>> +                                + cross_build("x86_64-w64-mingw32-",
>>>> +                                              "x86_64-softmmu"))
>>>>        #
>>>>        # Cirrus packages lists for GitLab
>>>
>>> A better way to handle this would be to define a separate project
>>>
>>>     'tests/lcitool/projects/qemu-win-installer.yml'
>>>
>>> With
>>>
>>>      packages
>>>        - g++
>>>
>>> Then enable the extra project for win64
>>>
>>>       generate_dockerfile("fedora-win64-cross", "fedora-38",
>>>                           project='qemu,qemu-win-installer',
>>>                           cross="mingw64",
>>>                           trailer=cross_build("x86_64-w64-mingw32-",
>>>                                               "x86_64-softmmu"))
>>>
>>> which should result in an identical container to what we have today
>>> for win64, while letting us slim the other containers.
>>
>> Ok, good idea! ... but then we need to teach lcitool about mingw-w64-tools
>> first, otherwise that vss code won't get built due to the missing "widl"
>> tool.
> 
> Why is that a pre-requisite ?   What i've suggested will result in a
> Dockerfile for win64 that is 100% identical to what we already have
> in git today. So surely that will already succeed to the same extent
> that CI succeeds today ?

If you want to have the same result, we can also simply remove g++ 
everywhere, also for the mingw cross containers, since the vss code is 
currently not built at all due to the missing widl program.

  Thomas



