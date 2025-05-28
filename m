Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91A0C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFd9-00034N-B8; Wed, 28 May 2025 08:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKFd5-0002ya-Bq
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:11:31 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKFcy-0003LZ-4d
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:11:31 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6faa543d8bcso37591796d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748434281; x=1749039081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAcKUHr6qVW7V44eLRkOBhoHjhAe62jvGATf6TS1gTs=;
 b=eEN0IpKm+VbHPkCh9y8Bs8VLwKYwjnXNz8Cz6lolOJX11pB7hYzV188KWHZKutXuBA
 CXdEX+O6q8TL6yi8tcGzWlQPSaoYcYS7/uzbtcOfq82N7M9D5f/uQKHvjzITzbLSJSfP
 ne5QmgzLhd+zuxuR9283Rq/iDPoflo6xVzeh4Jh2peSAxwRlX6QAHMufoa5O54rFxGMD
 mVlssIzSkFCeQBAVDhQjwe1nt3esWMA+cmT2hcJW2VhbhOg5/F0NHje7lg7tRwwlAsSJ
 M/PZEsI7WTVZBE+WVApSi7tP4GNtV0hi2WxOrzMa2lru/6ckyE0gxS283kM64meZ3PLE
 QqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748434281; x=1749039081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yAcKUHr6qVW7V44eLRkOBhoHjhAe62jvGATf6TS1gTs=;
 b=OVDYO36Hvc4BmPUC0xR7UU+M06gFIP0IWtqwIf/AD3Rn0lxACzUvZCGrCQ3R46f5k9
 eWYw+4QDCj3Bzq0aczaqRhaU+f8qosu4ufcYLSm5HAzBPuD9A/7vIxDz5+ocCtUHmMu+
 EfwLBfgh4MXdbyqNIQX8Wmg3t7EC5rYxO1j+DLjVRO8k2AreHKkMJjq1f3mBKpqgSnMm
 D0zcYOOkl+p50kuRiy9cECGAqYzMGq5AWy1yUDojZs5vXlmiyuYP8zDk3Ix1AONeb5ib
 9d/pg5tVTEPIWvNq6tLCc3Q9zK1OsE22PoBzjBo6Fu5KaGHSeLRRRzEgOOi5lrl5d4Y5
 n3GA==
X-Gm-Message-State: AOJu0YzjNDLcYxpsKwaeqCIBH/hlw1L4+bJWkeUV92QLgS4PhCzAbUXf
 N2WRxIqhSBgMNr9lv0GvXbmy5hhDEDe1CD6u3aHkSWSZpTYOUT2HK2gmiH6oFB098s8=
X-Gm-Gg: ASbGnct5DV3K3Vcjd/wGIB76fnWNe4kHIlZM7IlOqbU4mLKayiRJpxif1zvx21Obglu
 W+I23GG44dQ8b5lH8ZVgQjUGRzPCKi/9LJQ3xfSXmV+pcYvKZlzIKtR1yhZWaZsk5fTUjoY4tXw
 Tq55HmXpohbc0/Alxa+nVo8Wa0JVUYX/lEbVTorDf0PKjq/PBHFteVEi1uNYaEcj6wsaBLwKp4S
 +hXcagsEdqbTSxZ07FWdjH1tDhzOfcRsmNr2Cb4lH6HM8ZfMDHgS1ZSTld0i7CzLhNM3aWL0gHn
 dlQAhjuXoDK8omaHi/u6gP6cRrkhwtdrf5vck/wowKQeGqh1adtmAI6ujMD1oev1cAy/p9MC25F
 1uv3cH5mi1xbe+tUL5nPI0O3QcQFQO5cQASfv6GQa
X-Google-Smtp-Source: AGHT+IG/Xd5z05bOgFrW3EwBMvIoR1oDtRcyzrVgncLV0KoRBIbudByLNoa0KrmmZlfuYZcoC/rTuw==
X-Received: by 2002:a05:6214:aca:b0:6f8:a978:d46 with SMTP id
 6a1803df08f44-6fa9d131167mr276698426d6.19.1748434280926; 
 Wed, 28 May 2025 05:11:20 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:2066:dacd:9134:8586?
 ([2804:7f0:b402:6ba2:2066:dacd:9134:8586])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e1efd0edcsm722433241.2.2025.05.28.05.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 05:11:20 -0700 (PDT)
Message-ID: <7e019a90-8715-46ce-9bae-50b070d4904d@linaro.org>
Date: Wed, 28 May 2025 09:11:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_aarch64_hotplug_pci: Update images
To: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250528014737.1630668-1-gustavo.romero@linaro.org>
 <f79878fc-b5d3-4b5c-a717-0173f9c50056@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <f79878fc-b5d3-4b5c-a717-0173f9c50056@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf34.google.com
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

Hi Thomas,

On 5/28/25 04:57, Thomas Huth wrote:
> On 28/05/2025 03.47, Gustavo Romero wrote:
>> The current links for the Linux and initrd.gz images are not truly
>> immutable, so let's change them to point to immutable versions, to avoid
>> having to keep updating their SHAs.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/functional/test_aarch64_hotplug_pci.py | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
>> index fa1bb62c8f..2cf5c28b9f 100755
>> --- a/tests/functional/test_aarch64_hotplug_pci.py
>> +++ b/tests/functional/test_aarch64_hotplug_pci.py
>> @@ -19,13 +19,13 @@ class HotplugPCI(LinuxKernelTest):
>>       ASSET_KERNEL = Asset(
>>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> -         'current/images/netboot/debian-installer/arm64/linux'),
>> -        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
>> +         '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
>> +         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
>>       ASSET_INITRD = Asset(
>>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> -         'current/images/netboot/debian-installer/arm64/initrd.gz'),
>> -        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
>> +         '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
>> +         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
>>       def test_hotplug_pci(self):
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 
> Since the original patch is still sitting in Alex' queue, I assume that he'll squash it into that original patch before it gets upstream?

Exactly. I have a meeting with him in a couple of hours and will ask him to queue it.


Cheers,
Gustavo

