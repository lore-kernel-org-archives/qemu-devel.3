Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA921EE3694
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqY8D-0002mW-B7; Thu, 12 Feb 2026 09:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqY8B-0002hL-Ja
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqY89-0001Il-SZ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770908241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KeLaj+6E3iwCE3EmKUGkoRvRQQ/N85qL4sT6EGFRxNQ=;
 b=cUzcnIi6kz7apaZkO/8rdhN2db1tVQngkPEzqtEoNBwyy6ZA/U2aKQ1SSCPvhYw6IG1lwC
 1kuI/Je/qvNsF7rMKsoB4UDq1gud/hG5wAaCoz014hB4vAQCEvtb2XSjZXASO3+K2qCY2e
 RVAHyKXAS3wbqKu0IiPDOiezEVIybQM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-ZaK43Z0qP6i7FXgJQ0UqkQ-1; Thu, 12 Feb 2026 09:57:13 -0500
X-MC-Unique: ZaK43Z0qP6i7FXgJQ0UqkQ-1
X-Mimecast-MFC-AGG-ID: ZaK43Z0qP6i7FXgJQ0UqkQ_1770908232
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so8318575e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770908232; x=1771513032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeLaj+6E3iwCE3EmKUGkoRvRQQ/N85qL4sT6EGFRxNQ=;
 b=VtAALu4sEfYHjsjTTGcQMPQAwnbrcpb/I4ooNnbZBedbxLgYlbkK0UbqRBQuYdavqx
 +dVMd4r+tjFlo75QRJdUGSAkoIAhQ1MHmRX2MefZ9n2Ng1mp5XOPxDDU4nP4dD9OhMmh
 HOqlPD/lJAy9+Uk/OkK2vDhHbzgGTozFYmG9YhSFtKAPdKfw3w6VTDZtIjcK3S/bMH9X
 OPT87APISSBlgvub70R+1rlMfL0M5RrtgPxUJxfIhrtGpaDWyvRgY04ooTrz7R8u9PVk
 P12OIwWHWfCpBUe5LUu3npantJUJHdBiSJozEmpxYhOhi7r/ULxDTOOE8TVyLo6EqE17
 LcbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTw18UjDW4+HRg/HwGVfGJgWNxOCGqbILzv4B2ZUhVl6k5L8Nk1W9sKcICW+5bO3N84QaTrzfNbqpB@nongnu.org
X-Gm-Message-State: AOJu0Yw8mdemswPJ3azzWCGdo3EmeSVwgRZ831OFGuHCGSBh5mjBLZGG
 BMy3lQ9PCKEp0v7lgX0Fc/f6pR+c/598ElK0AvXDLAIz9GWduF3fIYEK8WcDhcpgobjPudl+OFD
 o3/83xYVBBgt6jF1OK5EA3PJqzDq+Wex/2tg2dhuS9gFkuHcT9GCcPtT+
X-Gm-Gg: AZuq6aIw+2nC2cgcXwvpwDtwrE8gOawm/Y9XWRmS1af/q701+LDKhNgfdxCry9h3tDK
 7wlNAvCu7kFCQ3vEc7gXkwIL/fLXTKBArFN3+PXFDAybpEYhjgol9T8rPo/N1caQiNtQZQ4fs0J
 4M5qC52ATevCvzzZw1mysWs1driENZ6hq7iVtVenWKsgiHKokDfc7aqq6S1GMVAFeixrfAQEB3a
 WhYrsRhMZlpZjN43fKpVCsA7vUbovMmZm0DWY+FivMCTIKTw05WktLCIXgBec/ij8/08X5e/Jn+
 0CbxVpTmFczpPoJ8kygXmIhunCIc+xnwXX8lS0UwoF8f2giTizgI4zGIfw9r0FEDTIFTZcFLpVC
 0apTJcaiukS6yPzNocGonLuzRXaC8Isaow4hmi/uVH5ZQJ5oYZvq8/AOLu7VYcglDqfl5UQ==
X-Received: by 2002:a05:600c:6489:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-48365716845mr35103385e9.28.1770908232462; 
 Thu, 12 Feb 2026 06:57:12 -0800 (PST)
X-Received: by 2002:a05:600c:6489:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-48365716845mr35103045e9.28.1770908231961; 
 Thu, 12 Feb 2026 06:57:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfc8b9sm12553726f8f.24.2026.02.12.06.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 06:57:11 -0800 (PST)
Message-ID: <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
Date: Thu, 12 Feb 2026 15:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
 <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2/12/26 3:50 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 12 February 2026 14:42
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Nicolin Chen
>> <nicolinc@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
>> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
>> interface
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/10/26 9:46 AM, Shameer Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Sent: 09 February 2026 19:42
>>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>>>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>>>> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
>>>> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>>>> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>>>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>>>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
>>>> <kjaju@nvidia.com>
>>>> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV
>> ops
>>>> interface
>>>>
>>>> On Fri, Feb 06, 2026 at 02:48:04PM +0000, Shameer Kolothum wrote:
>>>>> CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that
>>>> enables
>>>>> virtualization of multiple command queues (VCMDQs).
>>>> Let's mention "NVIDIA", noting it's a non-standard extension.
>>> The idea of this ops based callback is to make it more generic and not
>>> NVIDIA specific to start with. This leaves room in case ARM introduces
>>> a standardised version of something similar in the future, or if another
>>> vendor provides a similar extension.
>>>
>>>>> CMDQV support is a specialization of the IOMMUFD backed accelerated
>>>>> SMMUv3 path. Introduce an ops interface to factor CMDQV specific
>>>>> initialization and CMDQV vIOMMU/vEVENTQ allocation behavior out of
>>>>> the base implementation. The ops pointer and associated state are
>>>>> stored in the accelerated SMMUv3 state.
>>>>>
>>>>> No functional change
>>>>>
>>>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>>>> ---
>>>>>  hw/arm/smmuv3-accel.h | 19 +++++++++++++++++++
>>>>>  1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>>>>> index c9c10e55c3..ca087240e5 100644
>>>>> --- a/hw/arm/smmuv3-accel.h
>>>>> +++ b/hw/arm/smmuv3-accel.h
>>>>> @@ -16,6 +16,23 @@
>>>>>  #endif
>>>>>  #include CONFIG_DEVICES
>>>>>
>>>>> +/*
>>>>> + * CMDQ-Virtualization (CMDQV) hardware support, extends the
>> SMMUv3
>>>> to
>>>>> + * support multiple VCMDQs with virtualization capabilities.
>>>> Ditto
>>>>
>>>>> + * CMDQV specific behavior is factored behind this ops interface.
>>>>> + */
>>>>> +typedef struct SMMUv3AccelCmdqvOps {
>>>>> +    bool (*init)(SMMUv3State *s, Error **errp);
>>>>> +    bool (*alloc_viommu)(SMMUv3State *s,
>>>>> +                         HostIOMMUDeviceIOMMUFD *idev,
>>>>> +                         uint32_t *out_viommu_id,
>>>>> +                         Error **errp);
>>>>> +    void (*free_viommu)(SMMUv3State *s);
>>>> I don't see much value of having alloc/free_viommu..
>>>>
>>>> Type and data structure are the only difference from the standard
>>>> viommu routine, and both are already in the uAPI header.
>>> That is right. But again, this is mainly to keep the interface generic.
>>> IIUC, Eric had suggested, using an ops or object style abstraction
>>> to separate extension specific behaviour from the core code.
>> My initial thought was callbacks to specialize implementation for accel
>> smmu without vcmdq versus accel smmu with vcmdqs. Effectively we could
>> later imagine to have other implementations with vcmdqs but it is
>> difficult to guess the specialization needs at that stage. I think in
>> the original series you already add the first kind of differentiation.
>>
>> At least reset and init need to be specialized.
>>
>> Maybe alloc_viommu does not need to because the differentiation only
>> happens on the type arg. But originally you where also turning off
>>
>> s->tegra241_cmdqv if IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV failed so
>> I had
>> the impression you reverted to a fallback impl. If there is
>> specialization, I still think ops are relevant. Eric
> There is no fallback implementation. So just to confirm, you are suggesting
> to remove the ops completely or just keep the ops for reset/init only?

Depends on the code to come next. If your reset and init really differs
between normal accel SMMU and vcmdq enhanced accel SMMU, to me it is
still relevant to have separate implementations in different callbacks.

Thanks

Eric
>
> Thanks,
> Shameer
>


