Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822CECD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYhj-0002ME-VK; Wed, 20 May 2026 00:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPYhd-0001om-Dq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPYhS-0003xr-4y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779251909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xMby641YOdW9kytrOA6DwX49JRlCDWVNZo+mGZL9sU=;
 b=MQKr5nckQk1HfpdNWtbdavlZDBL/2lCgO2OBPpp0edsGzFN6yw14zSL4uLgRdSV5tlabB1
 MKcRQhdK6A6Wk6SrYvuTgWsDCNkEL6vGr4QdDIzXKAnlQLRsTPpP9zzt6q20ovZZEWjSoU
 XO7hi/zxYowiLERyZ8UfRl7srDB9Z2k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-IWtRzGTbPGCxAgAqXVvq2w-1; Wed, 20 May 2026 00:38:27 -0400
X-MC-Unique: IWtRzGTbPGCxAgAqXVvq2w-1
X-Mimecast-MFC-AGG-ID: IWtRzGTbPGCxAgAqXVvq2w_1779251907
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso35905885e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251907; x=1779856707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xMby641YOdW9kytrOA6DwX49JRlCDWVNZo+mGZL9sU=;
 b=bCdT9Oy7Ol7HeBMVMagykxYco3J5M0r1F1W4EN44ZfAEaasKdo392/O5LxmEY4f1KC
 sCQPvrvbwL0r9m7dDW9d6tIep1Y3kCzbDvN//chSxxbmYmAHasIS0UdEPVa1wPAZiY05
 y48uEetTzmxINQeaj+ckW+VEzE4svnLy9/EzTrvSdNbs4y4vAhCFGxUUe+2hOfONmwOy
 itpmtkvJMTXBru2W7ZUNbYj9C7Q38jyO8cuhkBNLt8sgJVKbleppKxhDJUGQZrzezmuc
 NBpD+u0StD3Y1hkVxBwGmz7IVaJfDsxrv03ziXwH5gCzqjYFJW0X8LA5GdtEll+SRQrg
 UglA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iCEr7VJL3qTPfDUzy6yvDsRQKAsfimdxsRrBxKf3xgW46eQF9l4dzqUcpdqJaH9blp+eCeGfIazoh@nongnu.org
X-Gm-Message-State: AOJu0YwaYOSFpDD18rL4SzB1fm+rKpdQTn/mkGhEGFtx7BATHmMOJXQd
 Ak8XmfGwxtqGZcDQGMcIk8mUpqzeZ7e5PwHO3p0cZO5ScvSlf3JSa/qxMNXVCGKMVCbWT2pWIQW
 /fjddIkunM9INE5wTpzHdBt7Eh2gYPmJsIRXcDuDiEZeKP9iKCYi7A1qz
X-Gm-Gg: Acq92OGiyBr4mQpYm+n7nowzKxDEHDxvYRnwdyZMsk60613OOeXCexZVSKq/dPiTTsq
 5Tb5o++SGRzpN9VjgqL/gn64y43FF+r+xdkHpgaAErC05XkoAjIcFsl+iTehnaC6UKufPRU+Tkv
 Pfy8C/wb8x6JZuP/qvrViuLKD7sGMZOv2swzJyKwIuwESS6xLZwRCbv9V9BKXdT1/QobJANYTLI
 ZIS0dr5p9luiuV2tsDPrrnAIo+DFXx+qNwigGPYpG3SRic5meNlVZ3wE+XX0x7Xtpl0x7hVn/bq
 AORAyX1er9mRdpfCQLPxd5uH44x2RFDFE3oEXTdbTDZg9q3kxfSpF/7wLBHNZLBRRQiJ7wpn8ZA
 zRMjrQfEbiJ/o1gd2AM8IzNKe0FFOjwU7V2eXGM/w1X+q1Avj+r+CZGgTt2zBY3m0+88tXJ0eGS
 TJrguf
X-Received: by 2002:a05:600c:8715:b0:490:b07:5f27 with SMTP id
 5b1f17b1804b1-4900b07600fmr225077105e9.24.1779251906786; 
 Tue, 19 May 2026 21:38:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:490:b07:5f27 with SMTP id
 5b1f17b1804b1-4900b07600fmr225076805e9.24.1779251906400; 
 Tue, 19 May 2026 21:38:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c834besm399042185e9.3.2026.05.19.21.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 21:38:25 -0700 (PDT)
Message-ID: <f1141630-6f3f-4983-8f8d-9e4f08a15b68@redhat.com>
Date: Wed, 20 May 2026 06:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-8-nathanc@nvidia.com>
 <0e747538-5e87-40ba-ac44-bc7bbe89bc7f@redhat.com>
 <33370934-a239-4215-87d9-2cc64648a258@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <33370934-a239-4215-87d9-2cc64648a258@nvidia.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/19/26 10:53 PM, Nathan Chen wrote:
> Hi Eric,
>
> On 5/19/2026 9:03 AM, Eric Auger wrote:
>> Hi Nathan,
>>
>> On 5/12/26 9:35 PM, Nathan Chen wrote:
>>> From: Nathan Chen<nathanc@nvidia.com>
>>>
>>> Update documentation now that "auto" is supported for accelerated
>>> SMMUv3
>>> properties.
>>>
>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>> ---
>>>   qemu-options.hx | 25 +++++++++++++++++++------
>>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 96ae41f787..46b02a1bb3 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -1291,30 +1291,43 @@ SRST
>>>           Enabling accel configures the host SMMUv3 in nested mode
>>> to support
>>>           vfio-pci passthrough.
>>>   -     The following options are available when accel=on.
>>> -     Note: 'auto' mode is not currently supported.
>>> +     The following options will be set to auto by default if not
>>> manually
>>> +     set. When accel=on and these properties are set to auto, the
>>> value is
>>> +     derived from the host SMMUv3 capabilities via
>>> IOMMU_GET_HW_INFO. With
>>> +     accel=on, this requires at least one cold-plugged vfio-pci
>>> device; if
>>> +     none is present at machine init, QEMU will abort.
>>>   -    ``ril=on|off`` (default: on)
>>> +     If accel=off, auto values resolve to the non-accel defaults
>>> given below.
>> [*]
>>> +
>>> +    ``ril=on|off|auto`` (default: auto)
>>>           Support for Range Invalidation, which allows the SMMUv3
>>> driver to
>>>           invalidate TLB entries for a range of IOVAs at once
>>> instead of issuing
>>>           separate commands to invalidate each page. Must match with
>>> host SMMUv3
>>>           Range Invalidation support.
>>> +        - With accel=on, auto means the value is automatically
>>> derived from the host SMMU.
>> instead of repeating that sentence for all props you mean put it in [*]
> I would like to omit this for all props since it is already mentioned
> above "When accel=on and these properties are set to auto, the value
> is derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO".
> Would that be OK? 

Yes then it sounds enough to me

Eric
>
> Thanks,
> Nathan
>


