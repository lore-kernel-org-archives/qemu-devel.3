Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5124DC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTo9-0007cg-Jc; Fri, 23 Feb 2024 06:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdTo5-0007VB-H6
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:33:35 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdTo3-0006VN-2m
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:33:32 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3d01a9a9a2so77846866b.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 03:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708688008; x=1709292808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Rjdgl8h7xkEjAmUXGBg3htLnGe4QIxkWGOMpc374Yw=;
 b=TGjRUnI4GzVAIz0x1vWOYUoKtBLU/LyAssGnGl6QkOx+pKrXdxOyeYrMXgmMHRoJfH
 cNY2i5VAosPgMB0hJjcqCMrtR+bOCLi+FppT8gktyxR6ykD/3C4uu2JAxyJu1gGr3JV2
 aVZ1eluTmgAGasoaPvPLKOYpHbEfvbUozwKZsU8iopoC2gARxjmlWsR+HKfDTi6Zuun2
 3nbasMbZZmSdtak59vv8gN56SWfYdFwK4u8gniulO7JeP38f7GjWLijDhjqfiBdpgeQ4
 BpLgJolTJCqfc9pHCnV+eTtxUCzdFnWuYt/z9um8cMWxNkRz3LhQrITN6ti22Avd/zUF
 9aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708688008; x=1709292808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Rjdgl8h7xkEjAmUXGBg3htLnGe4QIxkWGOMpc374Yw=;
 b=Oq69ROERJQWdwK4+0DB+h6cyapdvGLhP8To9KSS3OP+TQnIOYCQZq0B8SI9B4K3hL3
 VCj1dO/L+1pyUeodZHPyG3vivDa7OPDzK1EuqqhDYsdvoNg20SGEa6Q2d6XY4eyw5tI/
 uU9rmdLfdLdNr8Zh1Hk8HTx5K5LXtQT52RH+vanKcRe3bePnVFwhJMTpOM5O4ucKrfCV
 nvJ+2cISgK6nrCXxYFN8xcmG0rbkhXt/00dkwKGCgyGhQutbcHbjJ0yjQnLvwMD/In8P
 0YMV/8w8pstREhW8CX5HlTNh4ts5wmFscz4NiXgOd6AllT1uVKg9HNX85XLnlwc7j0Fu
 wBCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYEUMxKrSkMPttAJOlBjwt9z/+iDU9pmBoW3/WdtLd0MpWrKzsYQVBhMx/zJzyBJo2is4gia4Q5wakae5qxgoIToP1YZU=
X-Gm-Message-State: AOJu0Yx4TP3FlXjc1duqVaYvwyHpWPA8+/WsLGWpFOCGoZh7Ny38qbCI
 1SkKIUDItvDUDAD9hmFXVny5Z7tZfeQmACa4a1MPhcpCODCzZ1yzOtT6Vd0E2g4=
X-Google-Smtp-Source: AGHT+IGJ3tnDUlJbEZE28+/To9ybFbZR2vIzyWIO1GPN8IydpF26unItnxS+yLelTeQBWvyfuz/X1w==
X-Received: by 2002:a17:906:7fd8:b0:a3e:96f4:492e with SMTP id
 r24-20020a1709067fd800b00a3e96f4492emr985467ejs.31.1708688007640; 
 Fri, 23 Feb 2024 03:33:27 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 ts7-20020a170907c5c700b00a3f4bb02bc8sm2260206ejc.42.2024.02.23.03.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 03:33:27 -0800 (PST)
Message-ID: <bdf48012-fdc4-449d-be12-fbbe985cc428@linaro.org>
Date: Fri, 23 Feb 2024 12:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] virtio-iommu: Change the default granule to the
 host page size
Content-Language: en-US
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240223074459.63422-1-eric.auger@redhat.com>
 <20240223074459.63422-4-eric.auger@redhat.com>
 <bdab51cf-fca8-4fe7-9e47-31bd10259dfa@linaro.org>
 <c12ba73f-5eeb-47b7-bd16-cf686f13d108@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c12ba73f-5eeb-47b7-bd16-cf686f13d108@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/2/24 09:38, Eric Auger wrote:
> 
> 
> On 2/23/24 09:08, Philippe Mathieu-Daudé wrote:
>> Hi Eric,
>>
>> On 23/2/24 08:27, Eric Auger wrote:
>>> We used to set the default granule to 4KB but with VFIO assignment
>>> it makes more sense to use the actual host page size.
>>>
>>> Indeed when hotplugging a VFIO device protected by a virtio-iommu
>>> on a 64kB/64kB host/guest config, we current get a qemu crash:
>>>
>>> "vfio: DMA mapping failed, unable to continue"
>>>
>>> This is due to the hot-attached VFIO device calling
>>> memory_region_iommu_set_page_size_mask() with 64kB granule
>>> whereas the virtio-iommu granule was already frozen to 4KB on
>>> machine init done.
>>>
>>> Set the granule property to "host" and introduce a new compat.
>>>
>>> Note that the new default will prevent 4kB guest on 64kB host
>>> because the granule will be set to 64kB which would be larger
>>> than the guest page size. In that situation, the virtio-iommu
>>> driver fails on viommu_domain_finalise() with
>>> "granule 0x10000 larger than system page size 0x1000".
>>>
>>> In that case the workaround is to request 4K granule.
>>>
>>> The current limitation of global granule in the virtio-iommu
>>> should be removed and turned into per domain granule. But
>>> until we get this upgraded, this new default is probably
>>> better because I don't think anyone is currently interested in
>>> running a 4KB page size guest with virtio-iommu on a 64KB host.
>>> However supporting 64kB guest on 64kB host with virtio-iommu and
>>> VFIO looks a more important feature.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>    hw/core/machine.c        | 1 +
>>>    hw/virtio/virtio-iommu.c | 2 +-
>>>    2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index 70ac96954c..38851df4b8 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -35,6 +35,7 @@
>>>      GlobalProperty hw_compat_8_2[] = {
>>>        { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
>>> +    { TYPE_VIRTIO_IOMMU_PCI, "granule", "4K" },
>>
>> IIUC the current value is qemu_target_page_mask(), not 4KiB.
>> Could this be an issue for arm / mips / mips / sparc64 guests?
> The virtio-iommu currently is only supported on ARM and x86 where
> qemu_target_page_mask() corresponds to a 4K granule. So I don't think it
> makes any issue.

Thanks, please explicit that in the commit description.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

>>>    };
>>>    const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>>>    diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> index 0461b87ef2..e9e44a8ad8 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -1558,7 +1558,7 @@ static Property virtio_iommu_properties[] = {
>>>        DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>>>        DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>>>        DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
>>> -                             GRANULE_MODE_4K),
>>> +                             GRANULE_MODE_HOST),
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>>    
>>
> 


