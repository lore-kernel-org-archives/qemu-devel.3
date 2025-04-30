Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC5C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uABXq-0000cU-0s; Wed, 30 Apr 2025 13:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uABXc-0000Zh-Hx
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uABXZ-0001Ad-OT
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746035271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I17Tf9phOKeR+tV1EMuXPuWTe/04bB4ikge9qN2d8Jk=;
 b=OgW0LH8FNjyhM/emZHPKPIx4yhsehCt7RvgIh1dwVdbiQDunIMoUbkUyr7WmByUsB/GYEi
 Gk3I1H33AFB5lTvypJxQa9vj9/wCudYHWXYzsBNR+I4q2FBFBy3eYYO+viNhB+NfZFY/Uf
 ZX/IJ77SrBLHUURKPhoKcS3tf6vKU0k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-RC0n3629M5C_1wUv0EX0AQ-1; Wed, 30 Apr 2025 13:47:49 -0400
X-MC-Unique: RC0n3629M5C_1wUv0EX0AQ-1
X-Mimecast-MFC-AGG-ID: RC0n3629M5C_1wUv0EX0AQ_1746035269
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39c2da64df9so24495f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746035268; x=1746640068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I17Tf9phOKeR+tV1EMuXPuWTe/04bB4ikge9qN2d8Jk=;
 b=iY5jp5z+KLBqTboUmNQvhvLkxSZKSjJZSS9w1Qd3e35BpH1J1Xf/QUL3vr43zoKBg6
 6pjLJvj5FZsifMoFZ8g1aUVu8jrQ1P14zqbaE/BzqmbZ8Ihhl3nXRr0LLw8uJkOWr21Y
 ZjqKu+BuD4ySqwLrg6m2eTpwE9wR/6ST2uWrFu0OZu9vFzLrG5JI6/IR00/zHzc07NP5
 0lUeY9d+CRErUxIiALmIGraTidxWLW/xX3AmCoKGp2sTZAK4KlVofDUfjvwjyPOjOHJd
 BAh52EHUXUaQ6NxBjWClpYN8rl4yLGC9+q4FrESjJoyN1WGAhpRFntHoprVoboMzBhvH
 Duug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdk1iwZQpmToeaAZjkKunxXhsd9GenFLgCLfjARk/LLt6Lfx/VlfqI1fOJSVFcsNv16B0DR4TcWJGS@nongnu.org
X-Gm-Message-State: AOJu0YzC/B2z63jKAUL+iJY2HCVTOVDMyZq21HCOSRqobmmwGFt4fqky
 pXU5vp52/paNMyNC2W8dFw1oEdmeNJyQviFaDOKqqwEP2cYHRqmL83bGSqvFtJ7+v260j5WAO5L
 owmw/RABmjFwaDmH0zQ5heYmOaMhVd/IfyNc4s6Xwr7TJJf+BAo8Z
X-Gm-Gg: ASbGncvLOkN/NTWWD/Cu00fUel3PYVnqjvojtA3ILxh4+RD3/Aqm5CkKZrcnC5lgN3V
 E/N3wPcCnl7PikN5Sv6PhktQF9iN5sEdmfTUgLMaaJBdMWYD9C0xmNPXzU9pVADJHxGpvcDMU2N
 VTJ1wH0APyB+sfjx74YBeEz4fPSaIfK7KGPd0CWbMC6auq0lw7X0x4S6+UfybSo//VgspRMHx2U
 sVSWJ/WCVUA75/fO5dae59QoeGVFsCwEGGi8Dek7eZmNmO7eFmFE326nwfL2Ee+Aqg/zBss4EWy
 XbsEpYMoS9jitD7eCIsqPOX7yaOPSUQz3Uv8LJ9iwpnOtxMEIZ7uZDR9LAc=
X-Received: by 2002:a05:6000:381:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-3a08ff32d95mr3443474f8f.4.1746035268653; 
 Wed, 30 Apr 2025 10:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgObhmiYf6ElIWYUXZdPgLIVjTpQGAJCGXK9L8G/XVDbDuBBJjA/Pb4JhdnFVaA7+PYEYtvg==
X-Received: by 2002:a05:6000:381:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-3a08ff32d95mr3443447f8f.4.1746035268124; 
 Wed, 30 Apr 2025 10:47:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e1c6sm18033396f8f.98.2025.04.30.10.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:47:47 -0700 (PDT)
Message-ID: <a37de640-1b6f-4b95-8ba0-ce7b78c10418@redhat.com>
Date: Wed, 30 Apr 2025 19:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for user creatable SMMUv3 device
Content-Language: en-US
To: Donald Dutile <ddutile@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <84870c74-f078-48c5-bead-96db1d582987@redhat.com>
 <8f7cc59e3745407bb7ae3d875cf97ae0@huawei.com>
 <7446ba2c-0dbb-44dc-9e48-300f431dcf85@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7446ba2c-0dbb-44dc-9e48-300f431dcf85@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 4/28/25 8:41 PM, Donald Dutile wrote:
>
>
> On 4/22/25 4:57 AM, Shameerali Kolothum Thodi wrote:
>>
>>> -----Original Message-----
>>> From: Donald Dutile <ddutile@redhat.com>
>>> Sent: Friday, April 18, 2025 9:34 PM
>>> To: Shameerali Kolothum Thodi
>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>>> qemu-devel@nongnu.org
>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>> Subject: Re: [PATCH 0/5] Add support for user creatable SMMUv3 device
>>>
>>> Shameer,
>>> Hi!
>>>
>>> First off, like the partitioning of these pieces.
>>>
>>> On 4/15/25 4:10 AM, Shameer Kolothum wrote:
>>>> Hi All,
>>>>
>>>> This patch series introduces support for a user-creatable SMMUv3
>>>> device
>>>> (-device arm-smmuv3-dev) in QEMU.
>>>>
>>> Can we drop the '-dev', as 'arm-smmu' is sufficient, as is '-device'?
>>>
>>> I know, internal to QEMU, there's already an ARM_SMMU, but as suggested
>>> later,
>>> if it uses the same struct, the qemu cmdline syntax is a bit less
>>> redundant.
>>
>> Trust me I tried that😊. The problem is that, the legacy one doesn't
>> have a bus
>> associated with it and the moment we change that and have bus
>> specified for the
>>   "-device arm-smmuv3, bus=pcie.0" the legacy smmuv3 creation in virt,
>>
>> create_smmu() --> qdev_new(TYPE_ARM_SMMUV3)
I have the impression you can achieve your goal by replacing
sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
by
qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
See https://github.com/eauger/qemu/tree/arm-smmuv3-dev-rc0

and its top patch.

indeed it would be better if we could reuse the same device.

Eric
>>
>> will fails as it expects the bus type to be specified for it. I
>> couldn't find a way
>> to solve that.
>>
> I guessed that's why there was new syntax for what is basically an
> extension of previous syntax.
> I'll dig more into it and see if there's a way to handle it.
> qemu does handle varying added params (id=blah, no id=blah),
> so I'm researching how that's done, to figure out how the legacy,
> smmu-for-all,
> and the smmu-for-specific pcie<RC> can both be supported.
> Given your stated trials and tribulations, this should be fun. ;-)
> - Don
>
>>>
>>>> The implementation is based on feedback received from the RFCv2[0]:
>>>> "hw/arm/virt: Add support for user-creatable accelerated SMMUv3"
>>>>
>>>> Currently, QEMU's SMMUv3 emulation (iommu=smmuv3) is tied to the
>>> machine
>>>> and does not support instantiating multiple SMMUv3 devices—each
>>> associated
>>>> with a separate PCIe root complex. In contrast, real-world ARM systems
>>>> often include multiple SMMUv3 instances, each bound to a different
>>>> PCIe
>>>> root complex.
>>>>
>>>> This also lays the groundwork for supporting accelerated SMMUv3, as
>>>> proposed in the aforementioned RFC. Please note, the
>>> accelerated SMMUv3
>>>> support is not part of this series and will be sent out as a separate
>>>> series later on top of this one.
>>>>
>>>> Summary of changes:
>>>>
>>>>    -Introduces support for multiple -device arm-smmuv3-dev,bus=pcie.x
>>>>     instances.
>>>>
>>>>     Example usage:
>>>>
>>>>     -device arm-smmuv3-dev,bus=pcie.0
>>>>     -device virtio-net-pci,bus=pcie.0
>>>>     -device pxb-pcie,id=pcie.1,bus_nr=2
>>>>     -device arm-smmuv3-dev,bus=pcie.1
>>>>     -device pcie-root-port,id=pcie.port1,bus=pcie.1
>>>>     -device virtio-net-pci,bus=pcie.port1
>>>>
>>>>     -Supports either the legacy iommu=smmuv3 option or the new
>>>>     "-device arm-smmuv3-dev" model.
>>>>
>>> nice! :)
>>> Can it support both? i.e., some devices using a system-wide, legacy
>>> smmuv3,
>>> and some pcie devices using the -device arm-smmuv3 ?
>>
>> Please see my reply to patch #2. In short No, it doesn't support both.
>>
>> Also I think we should slowly deprecate the use of legacy SMMUv3 going
>> forward unless there is a strong use case/reason to support it.
>>
>>> If not, then add a check to min-warn or max-fail, that config.
>>> I can see old machines being converted/upgraded to new machines,
>>> and they will want to switch from legacy->device smmuv3, and catching
>>> an edit/update to a machine change (or enabling automated conversion)
>>> would be helpful.
>>
>> Please see Patch #4. It already checks and prevents if incompatible
>> SMMUv3
>> types are specified. Or is the suggestion here is to add something
>> extra?
>> Please let me know.
>>
>> Thanks,
>> Shameer
>>
>


