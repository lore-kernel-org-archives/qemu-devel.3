Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C66CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWgu-0004YC-TZ; Thu, 28 May 2026 05:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWgr-0004SQ-96
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWgp-0004bt-MG
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779959166;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbGO7LpbXpYWoKSWsnTQSM8pYNTQjbOV/B2tlszLe/k=;
 b=PGpXfUgvY2a5kApzOEA2skfh1rFRNFn7ySOfOxKfss25qjBWL6Bg+VpUbQBl+A2D9tVzTn
 VL32SolwPWirSsXgy8Sk44aF2CW46Xsg7SA81gcmX3csGOCJRAWgWFSuCFHkkUJ4HT0ve6
 Uib0ZjdMlkKCatqcBlaQEKCM1w/Ipvo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Xpvg4GX-MlCxA312-_db5Q-1; Thu, 28 May 2026 05:06:03 -0400
X-MC-Unique: Xpvg4GX-MlCxA312-_db5Q-1
X-Mimecast-MFC-AGG-ID: Xpvg4GX-MlCxA312-_db5Q_1779959163
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490261c79fcso47459865e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779959162; x=1780563962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbGO7LpbXpYWoKSWsnTQSM8pYNTQjbOV/B2tlszLe/k=;
 b=rzZsY0Lgjv8j6b3edEZ2N1AalaeY4yOlhWm1FtKiNrG2oU7IjLWh2/Kp3VAVOPG+63
 Xlddu9AOmejpS5DviJ5ao4EOJwdjEuV0IqKgimhFoQ0BRk0OEzfyaxcwe2isH8GGHRvb
 138mHdcRJnQptghqb2cjC//KbDSycHMkCeTskSzERKyMartmHU7MH6ljEG3Kse+HWu3X
 SMHdXaiMqCCpAFYzDoAf18YN5Sh7lJ6bJroJTNttUZLDOZWuVQCnGXihQ5bP1WN6e5FT
 NijZLz3HapuIcxb40avYEf3xyWlW9WHwlknFdW7YRa5BBNDqKwZ+hLArqSUGoQjTb8GM
 i4/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JntNNlDYhwClc8twcrV5rzt28FcQ8KebPMbM5CAt63QGMF5qo98MNu5kUsqU7klLSMCxLUmSkhVxa@nongnu.org
X-Gm-Message-State: AOJu0YwZPPoQOUebbHthtmSeykPL+C9o7gtY/5sz7SkEhcTo35ua29sl
 IYDWFLx/wTFxtcLGtEaE8f0r3xxGJDGSyKIVIiNbEXvjjXT2HGrGPV/KRStKEXkOVrIjg/9XRP9
 bs2xsxIJKes3rNTcJqJ/qP4zCcrixfpBsIqO/CR7YIlDXeYzDZNUA4YN/
X-Gm-Gg: Acq92OES6RWKE6zf1gRRCh4ZXKEpH8yTGqTpFXdjUbVhyS7aoFyf3iYxJrV+7MQxinB
 z40AHMrBxR6hoBqc/wVxZJrn6Rwp05Q+0dwc9MhMhLfgYNrsFeqKIpwYpyyWUfoF1Ruj75Rmiq5
 nrghVI84cf6eDx9OuKawIG4moL9uhBRIFEN2QZCkv7Hb+tKz9VOdkH8zHq1xP3riZI+2Cwl2xNi
 HHRdHH3SK6lMsJovzivu47hHGBjgezow3xd19k5qTa3EthWwK2ixQo2fRwzv1Vqx7zzaRzFElZ4
 6vga5u2Kliz4B9a3GRDm5j/eNlvaZARXlYwV97Y4ilMmZeprxVsgkM4sPiWI57h2wfPHFIEuEw0
 egguOHPUJtH1s1Ogu8DP0j9BgVCLUCVu16eJA/N/ooxg+3wCX1EB+gc80ZxVK2zA0gmTELN0di9
 /p5VF+
X-Received: by 2002:a05:600c:1d0e:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-4909479e30emr10354825e9.5.1779959162542; 
 Thu, 28 May 2026 02:06:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0e:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-4909479e30emr10354445e9.5.1779959162067; 
 Thu, 28 May 2026 02:06:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909235d4e5sm36784545e9.2.2026.05.28.02.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 02:06:01 -0700 (PDT)
Message-ID: <60e7b00b-f1b9-4f56-b2df-f7e22cfd615e@redhat.com>
Date: Thu, 28 May 2026 11:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-3-nathanc@nvidia.com>
 <5a0afcaa-3fa2-498c-86a9-32480619e973@redhat.com>
 <CH3PR12MB75481D70032929A89D643630AB092@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75481D70032929A89D643630AB092@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/28/26 11:02 AM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 28 May 2026 09:41
>> To: Nathan Chen <nathanc@nvidia.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Philippe Mathieu-Daudé
>> <philmd@linaro.org>; Zhao Liu <zhao1.liu@intel.com>; Matt Ochs
>> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>
>> Subject: Re: [PATCH v4 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
>> documentation
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/28/26 12:16 AM, Nathan Chen wrote:
>>> From: Nathan Chen <nathanc@nvidia.com>
>>>
>>> Add a statement to clarify that the host SMMUv3 must support HW-
>> accelerated
>>> vfio-pci device assignment when setting accel=on.
>>>
>>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>> Hum did I suggest that ;-)
>>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>>> ---
>>>  hw/arm/smmuv3.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 0c65dc8c91..a8c49a48ac 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass,
>> const void *data)
>>>      object_class_property_set_description(klass, "accel",
>>>          "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>>> -        "configured in nested mode for vfio-pci dev assignment");
>>> +        "configured in nested mode for vfio-pci dev assignment. Please "
>>> +        "ensure the host SMMUv3 supports hardware-accelerated VFIO-PCI "
>>> +        "device assignment before enabling.");
>> this is a rather abstract statement. What is the actual host
>> requirement, dual translation stage support?
> I think SMMUv3 spec calls it as "nested translation" support.
+1

Eric
>
> Thanks,
> Shameer


