Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89504EF9001
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpD4-0007rj-Ku; Wed, 04 Mar 2026 11:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxpD3-0007rL-4s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxpD1-0007MR-En
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772642183;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/VcDIScbrvARStahzI6NOoxSTIAlk/3uFmz6XnZ1oo=;
 b=YMLpWNRFaN74FsNx8HfC3YiAluc8qX2kLPn+FbiSAupz9GZpGHzRkELRjfli9Z+wGPb56X
 nw3FzJoMCb8QAvjSpVmrO7LxILl3G8eFeY3iNPMRsYHympXptkPTkD05cL/zKlIZyX8ZxH
 H1d7d+WISGNHfHSthHWyzB9tRIuUXBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-YMN3RzvVN92VjCrfkqpjSA-1; Wed, 04 Mar 2026 11:36:22 -0500
X-MC-Unique: YMN3RzvVN92VjCrfkqpjSA-1
X-Mimecast-MFC-AGG-ID: YMN3RzvVN92VjCrfkqpjSA_1772642181
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439ca4b3d0bso470646f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772642181; x=1773246981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/VcDIScbrvARStahzI6NOoxSTIAlk/3uFmz6XnZ1oo=;
 b=uAKszvwFzNB3+b51umQME9XRK7NjcnPfRAoq/9LKbdE6aywPbo1Az5FCHrqOwLfSaJ
 wUoekANnAErz8DHEKHBXC2lkXRgGHO40fjYezs8LIIAO5W+0byTi/prw6PLzFBiV1kS5
 oPs0sRikJNA58UfJQlN+KNFAfCXJXeRrFZ6CajShub8l9SwPP7Kiy1RjtvO5WQu0shek
 gaYAkhKV/28nWJ44pcu5hdYwZ01y3vdAH9n1gSb/zT/cSMZKH8g4y5CzFKiW7cvsbU0G
 5+q6CtihXlhg6r+KJFcDo3nSzbGQacw/xjByN3FhOxoUtIFyufrvwx9m5oZ0lCNuyCQi
 voTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/o6nG1Pz/0QORikK30lcObHUyUYPiUSwEIT2o9rJtxfYBJwRvC0M/ISEIifzWEfyT5hFP0zy1gGRS@nongnu.org
X-Gm-Message-State: AOJu0Yzzkwg9Z4TWdfledcbicQ3xmGi4AfkFegsdWG0HEKnY3yiGMhf3
 B77HRkI5WUdmGOlMbN2H9Y4MfkLSJCTZ3YEHX7oDc0Z/EiUU1qa4gHw562EBzCKesgqrAi1ygLc
 ZpgXmF9mUvrl9Xhbt2m1ecrOFe8Ko8EUHLZ7Ucs9i00+fD+oZVxuGEYaC
X-Gm-Gg: ATEYQzx5AUD5svAyWUmTCyln1aSXd+lEUDAGVECnZVw6vhjMEE08NriIDPUoFArXaCE
 dYFg3Jooz6Se0L+Ms2mRpq2lE+IiksX3jXpuoLGn/KK5gWm82m+3yDDhv+3FcF3Aqh4I0n6GHRg
 qPqUGVG+Hu/9n5iourACFtidXhLyfKzgAAIyDwl/AbzldHjrBMsEpufsHeMsccMBhhQTox2y6H9
 Z5PABEUszz+TyEUNGb1y1L+IqH9/ECEg+BM0i6l8ql6EM23UTOli1sXWJI8jZ2PrGshjB4ayBnr
 hGbmbXG5EjzK37O84pP9L21+bHziSYR7BVPvaKXpjXRt8tpPOecUo13BlX4+axjS8Aalk8H3kth
 mi6cEDI9p/QoKAtI0SLjqMx6A9cON8179qy2OuKCLv/f2eZ0W86fvMa2cdg14kD93bWh3Gw==
X-Received: by 2002:a05:6000:2381:b0:439:b339:7eed with SMTP id
 ffacd0b85a97d-439c7f79ae6mr4714954f8f.20.1772642181105; 
 Wed, 04 Mar 2026 08:36:21 -0800 (PST)
X-Received: by 2002:a05:6000:2381:b0:439:b339:7eed with SMTP id
 ffacd0b85a97d-439c7f79ae6mr4714865f8f.20.1772642180509; 
 Wed, 04 Mar 2026 08:36:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b485a0b6sm27811029f8f.39.2026.03.04.08.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 08:36:20 -0800 (PST)
Message-ID: <b1cadaec-be9f-4056-88a1-f994cd34f07c@redhat.com>
Date: Wed, 4 Mar 2026 17:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 16/31] hw/arm/smmuv3: Plumb SEC_SID through IOMMU
 notifier path
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Mostafa Saleh <smostafa@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101706.2994213-1-tangtao1634@phytium.com.cn>
 <aaGumxmrKRelouE7@google.com>
 <6a6144fe-3db3-4ce8-8a8c-c1391d7aa550@redhat.com>
 <aaXiQ84t1vxTH-EE@google.com>
 <adbb1e4f-2103-4927-aa5e-638c5dbc3896@redhat.com>
 <7a50275c-46bb-45b2-a419-135cc0e43c45@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7a50275c-46bb-45b2-a419-135cc0e43c45@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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



On 3/4/26 4:34 PM, Tao Tang wrote:
> Hi all,
>
> On 2026/3/3 PM3:49, Eric Auger wrote:
>> Hi Mostafa,
>>
>> On 3/2/26 8:17 PM, Mostafa Saleh wrote:
>>> On Mon, Mar 02, 2026 at 07:26:10PM +0100, Eric Auger wrote:
>>>> On 2/27/26 3:47 PM, Mostafa Saleh wrote:
>>>>> On Sat, Feb 21, 2026 at 06:17:06PM +0800, Tao Tang wrote:
>>>>>> Extend IOMMU notifier functions to be SEC_SID-aware, ensuring that
>>>>>> invalidation notifications are dispatched to the correct
>>>>>> security-aware
>>>>>> address space.
>>>>>>
>>>>>> This ensures IOMMU notifier events (e.g., to VFIO) are correctly
>>>>>> routed
>>>>>> to the appropriate security world's address space, maintaining
>>>>>> isolation
>>>>>> between secure and non-secure DMA operations.
>>>>> I don’t think that VFIO cares about secure regime, my guess is to
>>>>> keep the functions as this and don’t call them for secure
>>>>> invalidations.
>>>> So do we want to prevent VFIO devices from working in secure mode
>>>> along
>>>> with the SMMU?
>>> Yes, my impression was that VFIO only works with NS devices, for
>>> example
>>> I see vfio_iommu_map_notify() only deals with system memory:
>>>
>>>      if (iotlb->target_as != &address_space_memory) {
>>>          error_setg(&local_err,
>>>                     "Wrong target AS \"%s\", only system memory is
>>> allowed",
>> Indeed this would need to be changed. I am totally fine not supporting
>> VFIO nor vhost devices (which also use unmap notifiers) in secure more.
>> However in that case I think the series would need to properly check
>> that those devices are not used in secure regime.
>
>
> Thanks for the clarification.
>
>
> For this series, I’m fine not supporting VFIO/vhost in Secure regime.
> I’ll add a fail-fast check at smmuv3_inv_notifiers_iova to reject
> devices using IOMMU notifiers when the selected regime is non-NS. The
> NS path stays unchanged.
>
>
> /* invalidate an asid/vmid/iova range tuple in all mr's */
> static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                       dma_addr_t iova, uint8_t tg,
>                                       uint64_t num_pages, int stage,
>                                       SMMUSecSID sec_sid)
> {
>     SMMUDevice *sdev;
>     if (sec_sid != SMMU_SEC_SID_NS) {     // fail-fast check
>         return;
>     }
>     ......
> } 

You can do that earlier on notifier registration I think

Eric
>
>
> Best regards,
>
> Tao
>
>
>>
>> Thanks
>>
>> Eric
>>>
>>> Otherwise, the callback needs to be enlighted by different address
>>> spaces, I am not sure how (and what uses cases?) will that be done,
>>> does
>>> QEMU emulate TZ in that case? (and present some devices as secure?)
>>>
>>> Thanks,
>>> Mostafa
>>>
>>>> Eric
>>>>> Thanks,
>>>>> Mostafa
>>>>>
>>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>>> ---
>>>>>>   hw/arm/smmuv3.c | 18 +++++++++++-------
>>>>>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>>>> index 4a4de719a7c..e33a7babd1c 100644
>>>>>> --- a/hw/arm/smmuv3.c
>>>>>> +++ b/hw/arm/smmuv3.c
>>>>>> @@ -1195,15 +1195,16 @@ epilogue:
>>>>>>    * @tg: translation granule (if communicated through range
>>>>>> invalidation)
>>>>>>    * @num_pages: number of @granule sized pages (if tg != 0),
>>>>>> otherwise 1
>>>>>>    * @stage: Which stage(1 or 2) is used
>>>>>> + * @sec_sid: StreamID Security state
>>>>>>    */
>>>>>>   static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>>>                                  IOMMUNotifier *n,
>>>>>>                                  int asid, int vmid,
>>>>>>                                  dma_addr_t iova, uint8_t tg,
>>>>>> -                               uint64_t num_pages, int stage)
>>>>>> +                               uint64_t num_pages, int stage,
>>>>>> +                               SMMUSecSID sec_sid)
>>>>>>   {
>>>>>>       SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>>>>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>>>>       SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>>>>>>                                  .inval_ste_allowed = true};
>>>>>>       SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo,
>>>>>> sec_sid);
>>>>>> @@ -1251,7 +1252,8 @@ static void
>>>>>> smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>>>       }
>>>>>>         event.type = IOMMU_NOTIFIER_UNMAP;
>>>>>> -    event.entry.target_as = &address_space_memory;
>>>>>> +    event.entry.target_as = smmu_get_address_space(sdev->smmu,
>>>>>> sec_sid);
>>>>>> +    g_assert(event.entry.target_as);
>>>>>>       event.entry.iova = iova;
>>>>>>       event.entry.addr_mask = num_pages * (1 << granule) - 1;
>>>>>>       event.entry.perm = IOMMU_NONE;
>>>>>> @@ -1262,7 +1264,8 @@ static void
>>>>>> smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>>>   /* invalidate an asid/vmid/iova range tuple in all mr's */
>>>>>>   static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid,
>>>>>> int vmid,
>>>>>>                                         dma_addr_t iova, uint8_t tg,
>>>>>> -                                      uint64_t num_pages, int
>>>>>> stage)
>>>>>> +                                      uint64_t num_pages, int
>>>>>> stage,
>>>>>> +                                      SMMUSecSID sec_sid)
>>>>>>   {
>>>>>>       SMMUDevice *sdev;
>>>>>>   @@ -1274,7 +1277,8 @@ static void
>>>>>> smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>>>>>>                                           iova, tg, num_pages,
>>>>>> stage);
>>>>>>             IOMMU_NOTIFIER_FOREACH(n, mr) {
>>>>>> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
>>>>>> num_pages, stage);
>>>>>> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
>>>>>> +                               num_pages, stage, sec_sid);
>>>>>>           }
>>>>>>       }
>>>>>>   }
>>>>>> @@ -1307,7 +1311,7 @@ static void smmuv3_range_inval(SMMUState
>>>>>> *s, Cmd *cmd, SMMUStage stage,
>>>>>>       if (!tg) {
>>>>>>           trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
>>>>>>                                    tg, 1, ttl, leaf, stage);
>>>>>> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1,
>>>>>> stage);
>>>>>> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1,
>>>>>> stage, sec_sid);
>>>>>>           if (stage == SMMU_STAGE_1) {
>>>>>>               smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1,
>>>>>> ttl, sec_sid);
>>>>>>           } else {
>>>>>> @@ -1331,7 +1335,7 @@ static void smmuv3_range_inval(SMMUState
>>>>>> *s, Cmd *cmd, SMMUStage stage,
>>>>>>           trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
>>>>>>                                    num_pages, ttl, leaf, stage);
>>>>>>           smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
>>>>>> -                                  num_pages, stage);
>>>>>> +                                  num_pages, stage, sec_sid);
>>>>>>           if (stage == SMMU_STAGE_1) {
>>>>>>               smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
>>>>>>                                   num_pages, ttl, sec_sid);
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>


