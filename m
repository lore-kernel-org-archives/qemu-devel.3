Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2E0FEDA10
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZzX-0003Mo-Ug; Tue, 17 Mar 2026 15:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2ZzK-0003KF-9q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:21:59 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2ZzH-0002Dj-6m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:21:56 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c73c990a96dso2322698a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773775313; x=1774380113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QQNlZ45VoRV7kUIXgwWzg8KvERvgBqCY4Lma5emJ/Ho=;
 b=uL8sZj+XmhLKrRnSMMbw4hoU2XwTuKSZlYhAztdUTXEViTwx7jO3JnOdqwDCIUYae8
 EnTJQmVAqzC1e1Ngri19tHB0S9Q16i/hRwluye2Zn5g6+ISWxTJu2qsVlCNv6DtVh9pR
 cEWTBwD09wPT2p+8rVCRRIw7wmSEeGCCoMJD+MF9rx+0mENwZsYQVNa/U5xQ234axQW3
 NwZ3EThLVF1k9IUOGO5+W41pBfOPb1AcZ03fG/xHoP4BuCpYB02iIED5LlXObLix314A
 a9a40kAhxdONLUHe0SITv+pqj6jKgQ2NrQAqvUj+kgkd4zf5Jynjvl8jJJ5QlhFr9f4d
 WzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773775313; x=1774380113;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQNlZ45VoRV7kUIXgwWzg8KvERvgBqCY4Lma5emJ/Ho=;
 b=gnzOswfIPJcG8la7CtpC11anGQY88AQu8k1zhaBAQEWdBwWOvYmuD1iLprIg5Vuf/F
 YHb3NTlyh49hw+tXn98BUC9qIAMilq2gMeuMdQVhD6mR0zNbmtIT6OYL4716o6aZyMg0
 NVhzk5WijseOrqU71/80vmoTHGSO5/gGuwNZrdpkKvnyQ3MaR9aiC9uZtiPpUjMD4QQp
 TjpFfhN3YPE7hkS4RPBQx1MXPp4CD/MoLDgmgrZMKjtn01N7v5KrOD1kSyKZDLSloxEz
 0WXwMmqwQmsocoHASv2sLvfgovg9AZHMj38yuLNmENQNK6XNH3h4ckHu5TSUFF5Xslmc
 NaQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVSS4Oeglr+dABv0dQDoAZkgLzUD2Xpi4JhkgoHGtRy/ZwDLS1prF23buCG9la+HNCdwhvAnC6/wyD@nongnu.org
X-Gm-Message-State: AOJu0YwXliK9PIBmYDzA4g/YGR1iI1vFGBSnVoGAtV054Ha2xUj+4aj1
 3LtIQm7LTKsrjgzlG329O0Kl85ZqQNYd7zgALJOsmi7Wxi6x1VyoU+K0a0LGZWXPM7s=
X-Gm-Gg: ATEYQzxsGex+8PE28Hl6LKrSRv+AaNOR80lYNVrvg5yYKQ+OY0Jhh7nPiVTuReVwHDR
 ozgF9rhd/a+/IZFaB/UHVXViIy03+xd3woHmk2ZLJJqVoLd5djTNZBnuW7CE145Ybkbwt9lO3EZ
 DcExzX/GvngnjXEPnyv6J41vz316BnC2mUk/0HH2y7wMBy4msiWdEMFIGqRBGrfJAMeZaIbrw1O
 Jug8xQOwc+vjr+Jum1wBRUJcasbp6DuuFNJR0ao4GkN3DtAw5lHca+QYE2zb+Yi8X3kpHsyHsBP
 FsuyZR9vd71cKkE1Gk/PaMSy2ko4s0QhiM+LOyHJRe5Q5H6Pv5ZGYpvqUW+d1j5F/NKe52vvfFO
 TsPwRioynEMvfDYEc8CnaIhRdCBsyJGS5JJIm/wJVxC3LUOia7tQQ1D/yo3Yf+pHSKrWKu65BxJ
 zkdUz3k2PzZ5iNSrlPLZlDUlnRjQRZ6YBjbeUbd0UrwIvXf5l+HsbUsibwCCijjduM/Rhj
X-Received: by 2002:a17:903:1a88:b0:2b0:4f82:74d0 with SMTP id
 d9443c01a7336-2b06e43d36cmr6681435ad.46.1773775313083; 
 Tue, 17 Mar 2026 12:21:53 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm3484395ad.73.2026.03.17.12.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 12:21:52 -0700 (PDT)
Message-ID: <b740c904-6d1a-4f33-9661-5ee4748e7a28@linaro.org>
Date: Tue, 17 Mar 2026 12:21:52 -0700
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
 <0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org>
 <e8254fe0-4c23-4b92-9549-a15ce2627bfb@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <e8254fe0-4c23-4b92-9549-a15ce2627bfb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 3/17/26 6:55 AM, Cédric Le Goater wrote:
>>> Let's come back to the proposal. Currently, when the QEMU platform
>>> doesn't support IOMMUFD (i.e no support for the backend), QEMU reports
>>> at runtime :
>>>
>>>      qemu-XYZ...: invalid object type: iommufd
>>>
>>> As a consequence, the vfio-pci device doesn't expose the "iommufd"
>>> property when the backend IOMMUFD is not available.
>>>
>>> However, the additional filtering on the vfio-pci properties based
>>> on CONFIG_IOMMUFD seems unnecessary. Instead the "iommufd" property
>>> could always be exposed, whether or not the QEMU build includes IOMMUFD
>>> support (kernel support is another topic). If the property is used
>>> in an environment where IOMMUFD is unsupported, QEMU will simply
>>> fail to create the IOMMUFD object.
>>>
>>> Could you please rephrase the commit log with some of this information ?
>>>
>>
>> Sure, how about:
>>
>> {{{
>> hw/vfio: eradicate CONFIG_IOMMU from sources
>>
>> This commit removes usage of CONFIG_IOMMU in hw/vfio sources, exposing inconditionally iommufd related properties, which are declared statically (in const arrays). The alternative to expose them dynamically is more complex and requires boilerplate to set properties at runtime, with set_* callbacks and added logic to check if iommufd backend is available, with no obvious benefit.
>>
>> One difference is that user will have a different error message when trying to attach a vfio device on a platform not supporting iommufd.
>    
>> Instead of:
>> ```
>> $ qemu-system-* -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
> 
> This should be
> 
>     # ... -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
>     qemu-system-*: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Property 'vfio-pci.iommufd' not found
> 
> but, since we need to specify '-object iommufd,id=iommufd0' anyway,
> the error is :
> 
>     # ... -object iommufd,id=iommufd0  -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
>     qemu-system-*: invalid object type: iommufd
> 
> and it stays the same with your proposal :
> 
>     # ... -object iommufd,id=iommufd0  -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
>     qemu-system-*: invalid object type: iommufd
> 
>

Right, in my previous answer, I was (wrongly) focused on kernel config 
instead of QEMU one. I'll update message description.

>> invalid object type: iommufd
>> ```
>>
>> QEMU will try to attach device and error will be reported as:
>> ```
>> -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0:
>> vfio 0000:01:00.0: vfio/sys/bus/pci/devices/0000:01:00.0/vfio-dev: failed to load "/sys/bus/pci/devices/0000:01:00.0/vfio-dev/vfio0/dev
>> ```
> 
> This error only occurs when the kernel doesn't have proper IOMMUFD support.
> I don't think it is worth mentioning for this change.
>

Ok, I'll remove it.

> 
>> Note: This second error can already happen if user's kernel does not have CONFIG_IOMMUFD or CONFIG_VFIO_DEVICE_CDEV support, but QEMU has it.
>> }}}
>>
>> Anything you would like to add?
>>
>>> Thanks,
>>>
>>> C.
>>>
>> Writing my answer and seeing current behavior, I wonder if we could not have better error messages simply by checking if /dev/iommu exists when setting the iommufd property of vfio-pci device or when realizing the iommufd object (-object iommufd,id=iommufd0). For the latter, I need to double check order or initialization/realization as it might be tricky to catch before setting accessing vfio-dev/vfio0/dev.
> 
> yes. as said before, QEMU attaches to the device before connecting it
> to the IOMMU backend. So the iommufd object is unused until we reach
> this step of the device initialization.
> 
>> $ qemu-system-* -object iommufd,id=iommufd0
>> can't create iommufd object: /dev/iommu not found
>> Is your kernel config missing CONFIG_IOMMUFD?
> 
> Why not. Would you have time for it ?
>

Yes, I'll take a look to add it as an additional patch on top of this 
series.

>> As well, we could report "Is your kernel config missing CONFIG_VFIO_DEVICE_CDEV?" on the error mentioned in commit message.
> 
> This could added in one of the error messages of iommufd_cdev_getfd().
> 
>> And while we're at it, in case we report one of those errors, we could check target_arch(), and if it's not one supporting actively support iommufd, say to the user "Linux does not support iommufd on this platform" instead of "Is your kernel missing X or Y?".
> 
> The Kconfig file of the machines have 'imply IOMMUFD' so that the object
> iommufd is only built on systems where it makes sense: i386, arm, s390x,
> as of today. We should be fine.
>

Good point, iommufd object won't be available in this case.
> Thanks,
> 
> C.
> 
> 

Regards,
Pierrick

