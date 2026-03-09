Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3C2F3C241
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vza0j-0000et-VV; Mon, 09 Mar 2026 08:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vza0h-0000dp-IB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vza0f-0004FC-Om
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773060416;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJuCQo6H+MvVXMbi5lqS7edQhM07xsq/MRftzGxDZU8=;
 b=AWy2etBnPNRYuiLJxYQ5kY6yLhCbcxmVFYmxrJ+w20hXIZWiGWk2DtOdYoRzrqi6ZNavWN
 XHj+s3NSgdnXucE0F8f1K5SP7xr5p29920GOGLhFjnFWF5NY+B1bJ0xfQ2sOurldK/p3dr
 kYzpYU0QpwgqEGhKnq7rNMtAhMgxelc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-lZv3RmnQPLaiKqt4XRGMGg-1; Mon, 09 Mar 2026 08:46:55 -0400
X-MC-Unique: lZv3RmnQPLaiKqt4XRGMGg-1
X-Mimecast-MFC-AGG-ID: lZv3RmnQPLaiKqt4XRGMGg_1773060414
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853b00f9f5so2906215e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773060414; x=1773665214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJuCQo6H+MvVXMbi5lqS7edQhM07xsq/MRftzGxDZU8=;
 b=EkOJlL8T4kadJ7uFXIzo+aRhSa5gpQT49vNgI6U+io0XMMeivunQMkfyFRfGsX460/
 qLdmsFosueGD7JL+rhY9raYAh9Jap76rYMpUBNwVqE3EyPBW7TeS5zfRSDL6IV1TaAw/
 VNwQQV6CIdMV75jouskgLVpBRGCEFLfolkNLu9P/tdjepSYR/1WF0KtBBzyxAaZfUZek
 jBa6wLK/SG5gZ4O1F7KqBhrO1SkMMunOvuhcO7zSD6kzve88j0XCrJ0UvH7HuAeO5XZs
 B8Fe0wtV5o/ucrjhKGrgob0LViwCwBjcKPNBf91oaTzx7HQ0LVPHvGJuo/jvKiHa78+9
 yyuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuBUFE/HqjBgyIuYbkoSYfGATfDU/pYU+CTgc34sG75+q4yds2442ZWosm7l51mp1o5Bb89JwJp7bT@nongnu.org
X-Gm-Message-State: AOJu0Yy6urtTFitIbmF+vvUqf1O03MD/3KsRoFRc5jkyH4+GFzYvZILI
 73aaXHFZ3d71Tkn7T7LjPm/Hl0wB3oh/ShVd7L/0vZX9cPS3XhtP0LWhWmQrR0ab1EBICtMiNnB
 8ItEJrI0TLNl51AgbtGJvdmaLNf3FuhZDmY8/i1Aq8Ile30u6V4jWMAvy
X-Gm-Gg: ATEYQzxlX0gUwUpKmWygGDS252MtiGLA36vDYoXp5aYyaHseqttno7pS0LzJ7H+MUqZ
 yqeb/ZVJRTuu3fr4P4+PZpCcUtm7LeWcOzJvMzm4QQZfoQfWj9ro9KsaN+OdWhKHuUUV+2YA0iS
 zr5YLpKsNHx8r224vf8BtfEOC3EtnOXQeA9Wz4EvSNgKGCw2D+UQmdWlwsPVZ405a7NjAJSlbI9
 781I+ATl6a876jdYtDObOm4/ALTaBJKGRBpgoFkIgUGQ3Y04zMIQIOJJHCWe0woVYvtPepx0b2L
 W4i/JaLqBxCpkxGLCWTgXQN1zMwINKiB1LwJd7evWwCjPQtfgYNBkPVXHRhAcFma9lKnCRH4i82
 SjH8FpGHGGSj2B3EmcJ9uUf0gOhq/vIgkPKFJbOqKwYqqK35O7xkUB/xKLoMPjbW+DSs7uA==
X-Received: by 2002:a05:600c:a111:b0:485:3b00:f92e with SMTP id
 5b1f17b1804b1-4853b00fb11mr45859085e9.2.1773060414051; 
 Mon, 09 Mar 2026 05:46:54 -0700 (PDT)
X-Received: by 2002:a05:600c:a111:b0:485:3b00:f92e with SMTP id
 5b1f17b1804b1-4853b00fb11mr45858675e9.2.1773060413575; 
 Mon, 09 Mar 2026 05:46:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237dd017sm89901535e9.2.2026.03.09.05.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:46:52 -0700 (PDT)
Message-ID: <7920718a-d1b5-43bc-a066-38f70613507d@redhat.com>
Date: Mon, 9 Mar 2026 13:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-14-skolothumtho@nvidia.com>
 <ed5ca420-94e5-4e9e-a2c3-f59eb6ea8ada@redhat.com>
 <CH3PR12MB7548F5610D7F339C5DAD0E41AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548F5610D7F339C5DAD0E41AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/9/26 12:31 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 09 March 2026 11:09
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV
>> vIOMMU alloc/free
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/26/26 11:50 AM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Replace the stub implementation with real vIOMMU allocation for
>>> Tegra241 CMDQV.
>>>
>>> Free the vIOMMU ID on teardown.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.c | 19 +++++++++++++++++--
>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c index
>>> 6959766129..d487612ba2 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -25,14 +25,29 @@ static void tegra241_cmdqv_write(void *opaque,
>>> hwaddr offset, uint64_t value,
>>>
>>>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)  {
>>> +    SMMUv3AccelState *accel = s->s_accel;
>>> +    IOMMUFDViommu *viommu = accel->viommu;
>>> +
>>> +    if (!viommu) {
>>> +        return;
>>> +    }
>>> +    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
>>>  }
>>>
>>>  static bool
>>>  tegra241_cmdqv_alloc_viommu(SMMUv3State *s,
>> HostIOMMUDeviceIOMMUFD *idev,
>>>                              uint32_t *out_viommu_id, Error **errp)  {
>>> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
>>> -    return false;
>>> +    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
>>> +
>>> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
>>> +
>>> + IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
>> if the only think that differs compared to no cmdq is the type, ie.
>>
>> IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV vs
>> IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV
>>
>> + passing true args, maybe you can just record the type of the cmdqv
>> + that is being used in the smmu_accel device. Then you can get rid of
>> + alloc and free
> It is not just the type. Based on the type we also need to pass,
>
>  * @data_len: Length of the type specific data
>  * @__reserved: Must be 0
>  * @data_uptr: User pointer to a driver-specific virtual IOMMU data
>  *
>
> And the above is implementation specific.
>
> If our idea of the "ops" is to allow easier support for different 
> implementations in future, it probably makes sense to keep this.

OK I missed the fact data_len and IOMMU data needed specialization.

Thanks

Eric
>
> Thanks,
> Shameer
>
>> Eric
>>
>>
>>> +                                      idev->hwpt_id, &cmdqv->cmdqv_data,
>>> +                                      sizeof(cmdqv->cmdqv_data), out_viommu_id,
>>> +                                      errp)) {
>>> +        return false;
>>> +    }
>>> +    return true;
>>>  }
>>>
>>>  static void tegra241_cmdqv_reset(SMMUv3State *s)


