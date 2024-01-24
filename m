Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F9BC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSdlJ-0001ov-Vj; Wed, 24 Jan 2024 08:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSdlH-0001m9-AO
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSdlF-0005sc-NJ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706104668;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1fnDX6sltVJ/8BF/VLCjhr9I2rkrkUjdXw/y9U6yng=;
 b=Iztaz4jC6B8McewtTC+ZOMY4cMTNS8I/3iSSKYtkHCqPMbnAkp5qqChiOAkAQ2WtaCq4SD
 nvOvHbD0sha7UFIDfOmk1nqJpurZQmIRxvaUxYqKqhJ2K4u58280TKerL6FiUio6cRN0F+
 B85sF1by/Bbli3B6QmzMKXlvVGQ8Q68=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-v3UwvcpYNbyqlniOtpmM9A-1; Wed, 24 Jan 2024 08:57:46 -0500
X-MC-Unique: v3UwvcpYNbyqlniOtpmM9A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-781d8e14fd8so791513085a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 05:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706104666; x=1706709466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1fnDX6sltVJ/8BF/VLCjhr9I2rkrkUjdXw/y9U6yng=;
 b=YgV8fRN+ZaB6bW+iPAjdN62kt51K/dHg/9/NHJQhcEAdU0MStfEsigKiq2K3zxuzhq
 6L4kzrOPNQ5F/xslcYiYoxA+VPb9f45AFPfLa+iNMUJa4f5DSOWf7ky8A2e6e6loeay6
 7t3fOx6Uv8g1+FgDJRXABdXhn7BJ2J/ZUafJ6uCmpVSYkFBZIvjxKpVoIozX274bhQXe
 XcH06NkB6Q/wBwKjonpStOsIrwFMfOX+2+LEyYfKpjrTZcRsqvjfSp/uVdDZvhTchmiU
 KnAHhI0fJfN2Non7P+cJknl4RbAxcCv2paqOwgmBLVIG2aLrwqrAfc30Ar4pt5xleK7/
 I/ow==
X-Gm-Message-State: AOJu0YxlUj4dmUPLy6f50+RiK3waiT5LBnn/E+tOQKRfmUftT+Y8/4N0
 kuN9cthJU3NC87JL1M3RIn/xDxQ/6d+tCCtIhTG/o80NzPIWo/TAl8jLtgiWK9nAMXWxhr8O7dh
 nXLOuTwbD4w37npAo3ZkV7DTY+mnGapzLF5vRKlidRT6OR3T7qa9F
X-Received: by 2002:a05:622a:15c5:b0:42a:311f:a7c2 with SMTP id
 d5-20020a05622a15c500b0042a311fa7c2mr2663607qty.1.1706104666254; 
 Wed, 24 Jan 2024 05:57:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7MTMyz4h2VKLbeWY6SaQLP4NTNYQxpxI3gu8FgK5UMva7AzMACuhZwo7t/N3bUD5d92PHCw==
X-Received: by 2002:a05:622a:15c5:b0:42a:311f:a7c2 with SMTP id
 d5-20020a05622a15c500b0042a311fa7c2mr2663596qty.1.1706104665995; 
 Wed, 24 Jan 2024 05:57:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ay23-20020a05622a229700b0042a5c2a81a8sm614103qtb.60.2024.01.24.05.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 05:57:45 -0800 (PST)
Message-ID: <a92a2023-7448-4b74-bfd9-e412c6092270@redhat.com>
Date: Wed, 24 Jan 2024 14:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio-iommu: Add an option to define the input range
 width
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
References: <20240123181753.413961-1-eric.auger@redhat.com>
 <20240123181753.413961-2-eric.auger@redhat.com>
 <20240123165141.7a79de34.alex.williamson@redhat.com>
 <a35c4fad-a981-4fbf-81d1-be5625a537b9@redhat.com>
 <20240124063700.67c8c32c.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240124063700.67c8c32c.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,

On 1/24/24 14:37, Alex Williamson wrote:
> On Wed, 24 Jan 2024 14:14:19 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Alex,
>>
>> On 1/24/24 00:51, Alex Williamson wrote:
>>> On Tue, 23 Jan 2024 19:15:55 +0100
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>  
>>>> aw-bits is a new option that allows to set the bit width of
>>>> the input address range. This value will be used as a default for
>>>> the device config input_range.end. By default it is set to 64 bits
>>>> which is the current value.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  include/hw/virtio/virtio-iommu.h | 1 +
>>>>  hw/virtio/virtio-iommu.c         | 4 +++-
>>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>>>> index 781ebaea8f..5fbe4677c2 100644
>>>> --- a/include/hw/virtio/virtio-iommu.h
>>>> +++ b/include/hw/virtio/virtio-iommu.h
>>>> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>>>>      bool boot_bypass;
>>>>      Notifier machine_done;
>>>>      bool granule_frozen;
>>>> +    uint8_t aw_bits;
>>>>  };
>>>>  
>>>>  #endif
>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>> index ec2ba11d1d..e7f299e0c6 100644
>>>> --- a/hw/virtio/virtio-iommu.c
>>>> +++ b/hw/virtio/virtio-iommu.c
>>>> @@ -1314,7 +1314,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>>>       */
>>>>      s->config.bypass = s->boot_bypass;
>>>>      s->config.page_size_mask = qemu_real_host_page_mask();
>>>> -    s->config.input_range.end = UINT64_MAX;
>>>> +    s->config.input_range.end =
>>>> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;  
>>> What happens when someone sets aw_bits = 1?  There are a whole bunch of
>>> impractical values here ripe for annoying bug reports.  vtd_realize()
>>> returns an Error for any values other than 39 or 48.  We might pick an
>>> arbitrary lower bound (39?) or some other more creative solution here
>>> to avoid those silly issues in our future.  Thanks,  
>> You're right. I can check the input value. This needs to be dependent on
>> the machine though but this should be feasable.
>> Then I would allow 39 and 48 for q35 and 64 only on ARM.
> AFAIK AMD-Vi supports 64-bit address space.  Without querying the host
> there's no way to place an accurate limit below 64-bit.  Thanks,

Hum this means I would need to look at
/sys/class/iommu/<iommu>/amd-iommu/ or /sys/class/iommu/dmar* to
discriminate between AMD IOMMU and INTEL IOMMU physical IOMMU. Would
that be acceptable?

Eric
>
> Alex
>
>>>>      s->config.domain_range.end = UINT32_MAX;
>>>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>>>>  
>>>> @@ -1525,6 +1526,7 @@ static Property virtio_iommu_properties[] = {
>>>>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>>>                       TYPE_PCI_BUS, PCIBus *),
>>>>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>>>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>  };
>>>>    


