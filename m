Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB84E67A8A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxKVT-0008Bx-M1; Tue, 03 Mar 2026 02:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxKVR-0008B3-Qu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:49:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxKVL-0005Kp-Ve
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772524159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7iHVlU1i7SUB5wF6WfqBJNYBVE44HM90PHHM38NAVY=;
 b=a4Z7Tk1w3R+IE06fEq/DJ+EZEieZszOCV3KWJdqUe9yI0M2FB10RyJb3zutESSfa2xzggz
 gkQCROgLbNftiaq+AgmV9KydwEZ8lqkq9+OH7OUin0nE73W6vxJZeWW82FhZHHkI/kvrD/
 Tr4oQK/PlajqkSyQu8zHqh1i+h3YGds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-s6-9ZWyMPMuoJOJ6d-a8Aw-1; Tue, 03 Mar 2026 02:49:17 -0500
X-MC-Unique: s6-9ZWyMPMuoJOJ6d-a8Aw-1
X-Mimecast-MFC-AGG-ID: s6-9ZWyMPMuoJOJ6d-a8Aw_1772524157
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so56380835e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 23:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772524156; x=1773128956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7iHVlU1i7SUB5wF6WfqBJNYBVE44HM90PHHM38NAVY=;
 b=RDhe7XH89ypulEF4RCEDZq4QaF2ZR9Zs51nv7SaffmGGUomz3Cqx8fXGUNcQ5Z3RQA
 OtLmG1/bT4vIeMc+4lEEXfZAG6lHRNTCsuWM0wajXkH7LXWFFtNmJUjwCOHyYmREl/YT
 HV2wy4xhNysmUKss++V3LxtV8ZSv5WwlJFKpYWyLNftAz3ofBnCRZh+HVCzla2pJj1X2
 lkWGVlGkzEp3dCJGvJ48IYsKImYzUyya8jCAJ6Vl47DPPxWbTMup0qOz/YbIXNlw+UcG
 T1ZZHF3bH8bN0DyO3aQt9Hkezs7zcHApkifSsDr193YdJol4StqPDVVLjq1TftnVy+GF
 xWXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY2Xp2ON81rQzRnE0TPW7y3AOCzsDR6g6TQnHdtSNRJjgzTh/qpfm5t50gU+NOVEEdjPB3viTxN9/z@nongnu.org
X-Gm-Message-State: AOJu0Yw9d5xRdqRfiPScEc+yxljdP84+eIG/I12vsg+JUgu0DIMNxGh3
 buglKW0rXL73WaRcq48mCh/m5aFQGbU0aAsWs+i47r7Qi8EURmJLBf4jOsFjZ0tTuz5E8bWSnV4
 z6+RmB+qGvW7m+/i1Lqo1DhzzRhdj3z1u5B0hP9jwFmu2CPi4W29Dq89f
X-Gm-Gg: ATEYQzzkY4xZAXofGLuRdqJjX3ocm2gjck2y0byqdYJHGIkmfGZwvVD1wWsd/2HbshN
 vQppxo1adl6WDJVaHhSdikGNMxNwusu9IL0Ro8iwwIDzjM/M8UnF3dbivSbzFOkBt+HB/ZCrCoo
 lMV1FmCEo32I4llS87AyH2wR4/uD/wdCgtTEE1vMDdzNuvEvuVSeetFPFlSNJ8ow5Mz1qeXckcr
 4uBRgwf97qvhBpYgSUgpTDX29LeiquqZLkVsA6KNeY8i84ldQU/4NyYLNUhVv0G3JmIGM28XIny
 mq1rtS9b6X5LVMDCI9LQwBlPpWAueEO4qPtEN/7JdWZk+aJgMdOvESZfmIVkW+bGYtLJ4AGFUaC
 QK838dJAiTCA5lir6KxJ42p1kXIMHlGF55wXSGYTzCn0mVj77flUCXbLiHnIWNyIaOryF6Q==
X-Received: by 2002:a05:600c:6383:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-483c9bdb683mr237447135e9.32.1772524156187; 
 Mon, 02 Mar 2026 23:49:16 -0800 (PST)
X-Received: by 2002:a05:600c:6383:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-483c9bdb683mr237446815e9.32.1772524155590; 
 Mon, 02 Mar 2026 23:49:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7507adsm493667365e9.9.2026.03.02.23.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 23:49:15 -0800 (PST)
Message-ID: <adbb1e4f-2103-4927-aa5e-638c5dbc3896@redhat.com>
Date: Tue, 3 Mar 2026 08:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 16/31] hw/arm/smmuv3: Plumb SEC_SID through IOMMU
 notifier path
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
Cc: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aaXiQ84t1vxTH-EE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

Hi Mostafa,

On 3/2/26 8:17 PM, Mostafa Saleh wrote:
> On Mon, Mar 02, 2026 at 07:26:10PM +0100, Eric Auger wrote:
>>
>> On 2/27/26 3:47 PM, Mostafa Saleh wrote:
>>> On Sat, Feb 21, 2026 at 06:17:06PM +0800, Tao Tang wrote:
>>>> Extend IOMMU notifier functions to be SEC_SID-aware, ensuring that
>>>> invalidation notifications are dispatched to the correct security-aware
>>>> address space.
>>>>
>>>> This ensures IOMMU notifier events (e.g., to VFIO) are correctly routed
>>>> to the appropriate security world's address space, maintaining isolation
>>>> between secure and non-secure DMA operations.
>>> I don’t think that VFIO cares about secure regime, my guess is to
>>> keep the functions as this and don’t call them for secure invalidations.
>> So do we want to prevent VFIO devices from working in secure mode along
>> with the SMMU?
> Yes, my impression was that VFIO only works with NS devices, for example
> I see vfio_iommu_map_notify() only deals with system memory:
>
>     if (iotlb->target_as != &address_space_memory) {
>         error_setg(&local_err,
>                    "Wrong target AS \"%s\", only system memory is allowed",

Indeed this would need to be changed. I am totally fine not supporting
VFIO nor vhost devices (which also use unmap notifiers) in secure more.
However in that case I think the series would need to properly check
that those devices are not used in secure regime.

Thanks

Eric
>
>
> Otherwise, the callback needs to be enlighted by different address
> spaces, I am not sure how (and what uses cases?) will that be done, does
> QEMU emulate TZ in that case? (and present some devices as secure?)
>
> Thanks,
> Mostafa
>
>> Eric
>>> Thanks,
>>> Mostafa
>>>
>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>> ---
>>>>  hw/arm/smmuv3.c | 18 +++++++++++-------
>>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index 4a4de719a7c..e33a7babd1c 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -1195,15 +1195,16 @@ epilogue:
>>>>   * @tg: translation granule (if communicated through range invalidation)
>>>>   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
>>>>   * @stage: Which stage(1 or 2) is used
>>>> + * @sec_sid: StreamID Security state
>>>>   */
>>>>  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>                                 IOMMUNotifier *n,
>>>>                                 int asid, int vmid,
>>>>                                 dma_addr_t iova, uint8_t tg,
>>>> -                               uint64_t num_pages, int stage)
>>>> +                               uint64_t num_pages, int stage,
>>>> +                               SMMUSecSID sec_sid)
>>>>  {
>>>>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>>      SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>>>>                                 .inval_ste_allowed = true};
>>>>      SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
>>>> @@ -1251,7 +1252,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>      }
>>>>  
>>>>      event.type = IOMMU_NOTIFIER_UNMAP;
>>>> -    event.entry.target_as = &address_space_memory;
>>>> +    event.entry.target_as = smmu_get_address_space(sdev->smmu, sec_sid);
>>>> +    g_assert(event.entry.target_as);
>>>>      event.entry.iova = iova;
>>>>      event.entry.addr_mask = num_pages * (1 << granule) - 1;
>>>>      event.entry.perm = IOMMU_NONE;
>>>> @@ -1262,7 +1264,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>>>>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>>>>                                        dma_addr_t iova, uint8_t tg,
>>>> -                                      uint64_t num_pages, int stage)
>>>> +                                      uint64_t num_pages, int stage,
>>>> +                                      SMMUSecSID sec_sid)
>>>>  {
>>>>      SMMUDevice *sdev;
>>>>  
>>>> @@ -1274,7 +1277,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>>>>                                          iova, tg, num_pages, stage);
>>>>  
>>>>          IOMMU_NOTIFIER_FOREACH(n, mr) {
>>>> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
>>>> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
>>>> +                               num_pages, stage, sec_sid);
>>>>          }
>>>>      }
>>>>  }
>>>> @@ -1307,7 +1311,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>>>      if (!tg) {
>>>>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
>>>>                                   tg, 1, ttl, leaf, stage);
>>>> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>>>> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, sec_sid);
>>>>          if (stage == SMMU_STAGE_1) {
>>>>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
>>>>          } else {
>>>> @@ -1331,7 +1335,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>>>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
>>>>                                   num_pages, ttl, leaf, stage);
>>>>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
>>>> -                                  num_pages, stage);
>>>> +                                  num_pages, stage, sec_sid);
>>>>          if (stage == SMMU_STAGE_1) {
>>>>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
>>>>                                  num_pages, ttl, sec_sid);
>>>> -- 
>>>> 2.34.1
>>>>


