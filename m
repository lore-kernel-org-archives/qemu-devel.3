Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5154F10F9977
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVj-000464-M5; Wed, 08 Apr 2026 15:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAY5F-0006lK-6k
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:01 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAV2v-0003qJ-7M
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 11:42:26 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d932cc948so3809319a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775662942; x=1776267742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+UP7T+/Kb94Z27VYM4GRggPETHiNxicI7D2e3OC+eYk=;
 b=cltuHgiGZv7BZruCtPLBMH0wvSial4yE+lO5fP1jZzlOyozoL53L6zJhTi4QqgsGAZ
 WjryZpp5zgdVUFNr592s14Vj3vXcvZNIoX3NF8GoSsDApYvQt4slF/0PnCmqcd/LiwS2
 rXAVI6Y4wyG9AfE7TZN9545ngisb8/88HvdtbzDZbnbHW9R20AnOM5Lsu66a0K6VzfsU
 Mym+I5Hqkbjm7NnJ3e6P738c1jVLwktt45vTpwTXYZXwOVE+VVeMtKy/snSnSPqlZFUM
 2cMBqhjtu757nTAGXLzvO0a1R9vTZezcVOOllMyBeh4Ip8WqmM4Ku3hqI3wFCUyThyIK
 +DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775662942; x=1776267742;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+UP7T+/Kb94Z27VYM4GRggPETHiNxicI7D2e3OC+eYk=;
 b=Y/HdnSZ7cw9OMR+8O9IB3ohKI3NvBk6PKdC7ppZdPITG6kGpxDR6bx0nuQ0cvVvT3W
 6mf2EiyacDVWGnASfNom+dSeHUPnY4wJ2DaIVs12fmLUppTWOeYf36jWkqRsdxfhhacm
 FZkxohWT34K8THHz1KpF2V+a9y1mvvHwev+F3lhWR2KAhvZuPNEg1WeBJq/isUPSk2DH
 q/znVZpSi4sgITZn/dFvoogeu7yRrW3i53AWhEaQL/Nxwjd0ameft7ic0sW/GA2lkzD4
 IWG/hWvyaxZ5SfHzxX6tFl0rjFnO/SFg2W89QJn4/yf7d45GJyqu9ml3jUWJujYtwCeO
 CocA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSt/n6VFJN9xVd0Z/x7pMNe+/BNsf7PA9KuVMe0NoAs7szHvFKFVe3DzTjzpIxovmXNJuzgPbtSPVN@nongnu.org
X-Gm-Message-State: AOJu0YwkJe7gv5eSIxhoPTexjRxEuiq5qJovA7XYC0WdtE79ovsYr1YL
 xEmLL+jYcDdJIyO/sySRLjqjHLL5MCIuO/3fp3cmkqGI7WuSCi7kqD4irDaBUxiz7Zo=
X-Gm-Gg: AeBDiet2TELCbLWgG7y61XtXPKdmzpN4NNOnKuvMizabPulZt0rt/DKywPtbNRgdP9B
 zclywg9s4nGtYldnx1kkGEgOP5a6C20v/DDec1zmDkCdQfiN2+DQbfoc8kTNv6Jw3Ln2X4vbYq2
 arAsxxys4Z+FEjRjwnlVoUM9sZ/JOFoGYjITGqkiRVp76Hmel3GjFQWg1R//T70mHOUFrDTOtAf
 7L7u2rwDnTnz3BELJXOS0DzZTq8uwNzEPenmBbtUPXjznVz/0B+zYYatXla4XmWvwFPC+JY3gbi
 1E5vAHF4f/W4TRAEoLUgPDCGBNWoRwg6uNY7yIEGPI10MceDgSp8hFT/2bKqzacDaM0KDnlwwFH
 bgNWgz43+kYl9zj1Zt5Y+yYQDSP5naTUh6I65NCriFjR1FD4fBGN9inioCJg5z/Uhr0QUZGaIbF
 aq0cRdsEjY++gfipY9r25JxE9BvSl2b22kZJcr3nUa/AfXRDE3uGxnmkV/Bd4aYlYIXBj5VA64o
 /y0/0fP
X-Received: by 2002:a17:90b:5586:b0:35d:997c:8ebf with SMTP id
 98e67ed59e1d1-35de697193fmr20526830a91.21.1775662941990; 
 Wed, 08 Apr 2026 08:42:21 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e3517f2a0sm5330a91.17.2026.04.08.08.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 08:42:21 -0700 (PDT)
Message-ID: <8ca5d525-dea0-4d4d-8b5f-ae32a0a5e959@linaro.org>
Date: Wed, 8 Apr 2026 08:42:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
 <33ec528c-30e7-4d77-a9ef-c29c00aedc26@linaro.org>
 <c0f772d0-e4dd-4334-bfd2-8ac8da1c9032@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <c0f772d0-e4dd-4334-bfd2-8ac8da1c9032@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/8/26 12:20 AM, Thomas Huth wrote:
> On 06/04/2026 06.47, Pierrick Bouvier wrote:
>> Hi everyone,
>>
>> On 4/2/26 4:20 AM, Peter Maydell wrote:
>>> On Thu, 2 Apr 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> This is a follow-up to my 3-years old patch series here, now with the
>>>> universal binary initiative in mind:
>>>>
>>>>    https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html
>>>>
>>>> This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
>>>> (by renaming or symlinking the binary to "qemu-system-i386" or something
>>>> similar with a "-i386" suffix). After doing this, qemu-system-x86_64
>>>> should be a full superset of qemu-system-i386 (apart from 32-bit KVM
>>>> support, which however is not required anymore now that we removed support
>>>> for 32-bit hosts). It is now possible to migrate a guest that has been
>>>> started with an old "qemu-system-i386" binary to a qemu-system-x86_64
>>>> binary that has been renamed with a "-i386" suffix.
>>>
>>
>> Thanks for posting this Thomas.
>>
>>> I think my reaction here is similar to what it has been when
>>> the similar idea has been raised for qemu-system-arm : we should
>>> have a coordinated plan that is considering all architectures,
>>> not just dropping a single binary for one architecture where
>>> it happens to be more straightforward.
>>>
>>
>> There are two things to consider for this series, and we should clarify what
>> it is trying to do.
>>
>> The first one is the possibility to have a single-binary. The second one is
>> to reduce the number of binaries qemu officially have. It does not impact
>> the number of targets, since 32-bit ones will still be supported.
> 
> Agreed, thanks for pointing this out, Pierrick!
> 
> Given the fact that the patch for declaring qemu-system-i386 as deprecated
> seems to have rather caused mixed feelings, I think we'd should rather
> postpone that discussion and focus on the patches that will be useful for
> the universal binary.
> 
> ...
>> Let's fast forward 5 years in the future and imagine that all QEMU targets
>> are integrated in the single-binary. Once it is done, we know that all files
>> in target/X/* will be compiled only once, and integrated selectively for 32-
>> bit or 64-bit targets. The key to understand is that in this setup, choosing
>> to keep the 32-bit does not change anything. Technically, it will just be a
>> simple target-info file, representing this 32-bit target, and a symlink for
>> representing the target binary. All the rest will already be common with 64-
>> bit.
>>
>> With this projection in mind, I wonder what is the concrete value to make
>> any proper plan to deprecate 32-bit targets, since in the end, it won't
>> matter if they are present or not.
>>
>> What are your thoughts?
>> Which value would we get from deprecating 32-bit targets when possible?
> 
> My concern with the i386 target is that you have to maintain the clunky
> additional vmstates for migration forever that way. It's just ugly, for very
> low benefit here (who is *really* still using the i386 32-bit target in 2026?).
>

I agree, it's probably not used nowadays. However, I suspect it's 
different for some other architectures when 32-bit are still active, and 
people are used to qemu 32-bit target binary.

> Also maintaining additional 32-bit targets increases our test matrix, i.e.
> we could shorten our CI times if we remove it one day.
> 
> So let's keep this in mind. We don't have to deprecate the 32-bit targets
> right now, but if it's bothering us again in the future, we might want to
> reconsider to deprecate them.
>

 From your feedback, it seems like this series is really focused on i386 
architecture, and it does not seem like we should take further action to 
have a general policy of deprecation for other 32-bit targets.

>    Thomas
> 

Regards,
Pierrick

