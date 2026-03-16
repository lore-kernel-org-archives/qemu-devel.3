Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA9AFB5E85
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 23:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2H15-0008Ra-LI; Mon, 16 Mar 2026 19:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2H0x-0008R3-FJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:06:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2H0v-0008I0-EH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:06:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8299f1ca894so2625623b3a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 16:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773702379; x=1774307179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=btz2JYvbC6JN1k6MPf5yxfbruXKsFdJiLAv+M85O1QA=;
 b=D4j/KMa8JieveezouqPA18kuJjOmaBy61Y9pSQ0dJRHa3S7nrxk8tuVuj1/H26r1bU
 QB4ax8mg3AIKpJfqafAnxvRFVZEy4XQ6De3q7Nf+outu5nqB2Cl7h/K5kS8y1+lbJ93z
 cSdxXyqBfbU1ZjyEs1tuQssKVLlz+0GkZuO6w8BUYBWb0VYCueJvbRXGKCUUzdpyrE14
 A+vHyoVtRf6vtkC2CyDyuHRdRrtrrFgC/YILnC6rO4RRTcjPckRu6oHYXLihi0kIfRCI
 SVtiRlgFfK3V9x2kVp9DAmdB+LiNNxxRkAbzRZ8DX4gg412KLNYpWLFM6Bv3dCDNGeUZ
 6FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773702379; x=1774307179;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btz2JYvbC6JN1k6MPf5yxfbruXKsFdJiLAv+M85O1QA=;
 b=CRPBZBA9fGnvqFm1pOfCHu4pTUGo+buqEG5NgM7YMuPM3uhzfTo/KXDde825EMcL8n
 KrV2Hmwcvr9mIacrfSBVQS+pEqtA1OJGnMza/0AYGkdNx5sheMUzpQ2QmXN2QJML8IF1
 ObYRPbJHglkI6jmSTxcaC/Wty2ai1gfjzhAynDoNAiPFcmYSfxjpkWyMmS10VksOSKsB
 6XGpFY1A0/3xsBmXZnOcd7pPz9NR1mFSqAIRffxdka13h7kC1sd2TZwsWR5IFBXrF2XO
 myBIkaeSlTsKQyFx3mIzYVXz9zsbbRG0OG5okr0oB8LmQGjNamCYEK034Cf34kytQZBe
 lKhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcKDVgkA1jSA1nF3062e7feGsCc5NNU0ucdDcR6S/4r38halAh/4lg+j/R+Oy+029/nmegErvHoqhV@nongnu.org
X-Gm-Message-State: AOJu0YyieOUrG2YmDIm3ajhG43w4OiR+0UYtwxAY6eWnj2mI5dTDa/AY
 /lVON9wZOZ2+IEd8wfSD1ApAeEIN/OEP1+DMtmHgncJNEHD1gUJGn6SwV3XI/TtMstY=
X-Gm-Gg: ATEYQzztFXnm66zTaKleREsmPJ6EOOCM5VvL3gTYyDqu5JkXR226onNfD1SOao3JSHe
 ZJj1+QhcQxBSnRrcI4OUSlzfsl1mKOTwZxabPs9LzGQfDbUHiiJD/SNby+wDV3xvoY/JXjRxqvM
 4ZPoDRooCXuyX8957dGGNYwGdcZtqDv+4IClDGKvwcDmAi9FKj1CR8iDLJRr+mutlHU0Ki0owD4
 NFVhdlqkmLedJL34rVA3TCaOaEr4jYh6+BI0WxUgLQGRzCf3K6dTs/AnmRK/O6wQ/UwkoB6ZOlJ
 NUQVBeKonz2A19OeAQO6gIA47cPonnTmU9GTPunzWlRa5gUamw0zbA+iQ10Sj96iNHaTjpfZfom
 xDFyOJZwhaVXnmGZBIpFc/IoTf0OsF8agkFDpS2paRf+XvkKQqZ6N8hKthnZv2EIbPmxu6e1AmM
 coB7MrkRA0IqtpHJd8LvJP3nJuTdyhXfrVcdLGDPdFLTSN1xjv6DzFXXCno0b3vJ6VL4Ah
X-Received: by 2002:a05:6a00:1c83:b0:827:3976:3232 with SMTP id
 d2e1a72fcca58-82a19704357mr11895432b3a.5.1773702378936; 
 Mon, 16 Mar 2026 16:06:18 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0736edd2sm14623327b3a.52.2026.03.16.16.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 16:06:18 -0700 (PDT)
Message-ID: <0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org>
Date: Mon, 16 Mar 2026 16:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] hw/vfio: eradicate CONFIG_IOMMU from sources
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org,
 eric.auger@redhat.com
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
 <20260315070834.198331-5-pierrick.bouvier@linaro.org>
 <8bcc2cb9-6562-4ba2-be95-04f8b23e40f2@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <8bcc2cb9-6562-4ba2-be95-04f8b23e40f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 3/16/26 3:04 AM, Cédric Le Goater wrote:
> Hello Pierrick,
> 
> 
> On 3/15/26 08:08, Pierrick Bouvier wrote:
>> As pointed in c1139fa4 "vfio/iommufd: Remove CONFIG_IOMMUFD usage",
>> iommufd presence can be detected at runtime (through /dev/iommufd)
> 
> Note that the device name is "/dev/iommu/".
>

Oops, you're right, I'll fix the name.

> The overall flow is a slightly more complex. If IOMMUFD is not
> supported by the kernel, QEMU will fail when attemting to attach
> to the device. This failure occurs before the device is connected
> to the IOMMUFD host backend and QEMU will report an error such as :
> 
>     qemu-XYZ: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: vfio 0000:01:00.0: vfio/sys/bus/pci/devices/0000:01:00.0/vfio-dev: failed to load "/sys/bus/pci/devices/0000:01:00.0/vfio-dev/vfio0/dev
> 
> But this is a kernel-side issue.
>

Ok, details are a bit blurry in my head to be honest, as it was 9 months 
ago. After checking again, both CONFIG_IOMMUFD and 
CONFIG_VFIO_DEVICE_CDEV are needed and absence of one of them will 
produce the message above.
https://docs.kernel.org/driver-api/vfio.html#vfio-device-cdev

I had other iommu error messages but it was related to iommu groups 
issue, which is a different topic.

>> and
>> we don't need to isolate this at build time.
>>
>> It's much (much) more simple to expose this inconditionally
> 
> we should better explain the motivation behind this approach.
>
>> compared to
>> build dynamically properties arrays.
> and that would be an alternative that we don't want to explore.
> 
> 
> Let's come back to the proposal. Currently, when the QEMU platform
> doesn't support IOMMUFD (i.e no support for the backend), QEMU reports
> at runtime :
> 
>     qemu-XYZ...: invalid object type: iommufd
> 
> As a consequence, the vfio-pci device doesn't expose the "iommufd"
> property when the backend IOMMUFD is not available.
> 
> However, the additional filtering on the vfio-pci properties based
> on CONFIG_IOMMUFD seems unnecessary. Instead the "iommufd" property
> could always be exposed, whether or not the QEMU build includes IOMMUFD
> support (kernel support is another topic). If the property is used
> in an environment where IOMMUFD is unsupported, QEMU will simply
> fail to create the IOMMUFD object.
> 
> Could you please rephrase the commit log with some of this information ?
>

Sure, how about:

{{{
hw/vfio: eradicate CONFIG_IOMMU from sources

This commit removes usage of CONFIG_IOMMU in hw/vfio sources, exposing 
inconditionally iommufd related properties, which are declared 
statically (in const arrays). The alternative to expose them dynamically 
is more complex and requires boilerplate to set properties at runtime, 
with set_* callbacks and added logic to check if iommufd backend is 
available, with no obvious benefit.

One difference is that user will have a different error message when 
trying to attach a vfio device on a platform not supporting iommufd.

Instead of:
```
$ qemu-system-* -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
invalid object type: iommufd
```

QEMU will try to attach device and error will be reported as:
```
-device vfio-pci,host=0000:01:00.0,iommufd=iommufd0:
vfio 0000:01:00.0: vfio/sys/bus/pci/devices/0000:01:00.0/vfio-dev: 
failed to load "/sys/bus/pci/devices/0000:01:00.0/vfio-dev/vfio0/dev
```

Note: This second error can already happen if user's kernel does not 
have CONFIG_IOMMUFD or CONFIG_VFIO_DEVICE_CDEV support, but QEMU has it.
}}}

Anything you would like to add?

> Thanks,
> 
> C.
>
Writing my answer and seeing current behavior, I wonder if we could not 
have better error messages simply by checking if /dev/iommu exists when 
setting the iommufd property of vfio-pci device or when realizing the 
iommufd object (-object iommufd,id=iommufd0). For the latter, I need to 
double check order or initialization/realization as it might be tricky 
to catch before setting accessing vfio-dev/vfio0/dev.

$ qemu-system-* -object iommufd,id=iommufd0
can't create iommufd object: /dev/iommu not found
Is your kernel config missing CONFIG_IOMMUFD?

As well, we could report "Is your kernel config missing 
CONFIG_VFIO_DEVICE_CDEV?" on the error mentioned in commit message.

And while we're at it, in case we report one of those errors, we could 
check target_arch(), and if it's not one supporting actively support 
iommufd, say to the user "Linux does not support iommufd on this 
platform" instead of "Is your kernel missing X or Y?".

What do you think?

Regards,
Pierrick

