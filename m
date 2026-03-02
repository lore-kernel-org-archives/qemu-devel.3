Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97884EB362A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7yI-0008TA-LX; Mon, 02 Mar 2026 13:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7yG-0008R8-N1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7yE-0000as-O7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772475976;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LMPDnzTdQWb62mSQwVVw83c4qst9S9fTL7tQ9pE7qg=;
 b=hTaPSwNClO+8VIZ1rxox3tRS4Y0ppCQ8mZ13BiIFoSDb7TPXbSchgvOubMJ+Wm/6T++xkw
 UuufcgN59gteilvW1tYXl6VS2OQD2ECyznBqmY7akXGcuNjDy4DZvAMKeb8C05T//5OPVu
 QQUUt6KgJwE0dCTWotKQZMFBCTFZOQM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-pCsNDrxCOFSBTVH352pTEQ-1; Mon, 02 Mar 2026 13:26:15 -0500
X-MC-Unique: pCsNDrxCOFSBTVH352pTEQ-1
X-Mimecast-MFC-AGG-ID: pCsNDrxCOFSBTVH352pTEQ_1772475974
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso48403225e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 10:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772475974; x=1773080774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LMPDnzTdQWb62mSQwVVw83c4qst9S9fTL7tQ9pE7qg=;
 b=M94O5mf3ApjT7i7TS8wgaGA4gtvYik9cMWgQtRwjViasIdb/lEjACiNKDjjXq6GU7M
 JYWQ1WuHm7DqeWUY+mcFBX8jwJuod0UFHUzWzuM8BYP8COWyUOb82e1ZTIXXcD629ZoB
 klcrdNOf21SOvRMEZIvxisiXtGUsB3L+OufBiltxs8o5vhRavPasKN8S7sH+cZUcNfP4
 z9rGfw915n5+UO6gXK2kse3i0lYn7XRb489rA9VQRcpI1jjBMgBzqtpkQ59eLzoeHnH/
 FE09kYEYpi+vOlWN3THksnEfvTxENcA9cgWjcjsCNcUN2U6rUqdzhQgRX358qLwSTacO
 jogg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGznhS51seKZfdMXDJPRRMtmto0sUAKVhJQT1VAVv/eR+ncHsKUIZoxpso4PWYM+xHzsCcQj8Uiacp@nongnu.org
X-Gm-Message-State: AOJu0YwkAo95V+DTZxiJcyeEjXy8YoLS7sSLvNqTwWsm08XmRldzkArp
 4R4rCQDzI/csv2PStd/U5+nQgFBvpOqueSGsOg4wP0qs4S0OK3YfwPMSfSJzp5/OTZZJ4/Sj3V+
 Inu0YdHBHglpdcRaaaJNBaMuq1GXohyWe3hhTJCDB40ew4qi0apB9FfAd
X-Gm-Gg: ATEYQzzJ4ISDKvLRVRDmyoGj3gQF2p5OF3Z3ACN53I8sVuBjt8o4LbrwGzL65+0Xkii
 edKWIS8lvxBtl5qWmYEXzy8x/5eQKl22uY12zM4WhJJItmG9LYFIQ95r2euYEYbr5NZGpZOjS92
 9MVm+QOT88moT8Uy3ksi71dEJvYprDUTJKcQ0ZoV2cu5HUNDeL6NN/e3rbcKZqhwtBD3IUXSKUZ
 WVKPI7qcdC7+Xzhtsttgbrq9Ot8EbdZyAV3QY+K857w59oTuu0wtNv6k2Q+PkFSUzEEONU2u11r
 8OgRqWZ7PCqytDVyfdlV3JO30kpeNUFncbDq4v1pe4zA2YVHlk3M79Iuuj2IMY8TvZc1CoN4q4O
 Bcb5XS7RssqrIXnGt+MY7pVNrnrati+COzvmfZURm7cskR+2sCPRIUSYrOvps2ycMqj9OUg==
X-Received: by 2002:a05:600c:8106:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-483c9c24049mr207664905e9.25.1772475973887; 
 Mon, 02 Mar 2026 10:26:13 -0800 (PST)
X-Received: by 2002:a05:600c:8106:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-483c9c24049mr207664665e9.25.1772475973431; 
 Mon, 02 Mar 2026 10:26:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ba2a58dasm6094724f8f.27.2026.03.02.10.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 10:26:12 -0800 (PST)
Message-ID: <6a6144fe-3db3-4ce8-8a8c-c1391d7aa550@redhat.com>
Date: Mon, 2 Mar 2026 19:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 16/31] hw/arm/smmuv3: Plumb SEC_SID through IOMMU
 notifier path
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aaGumxmrKRelouE7@google.com>
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



On 2/27/26 3:47 PM, Mostafa Saleh wrote:
> On Sat, Feb 21, 2026 at 06:17:06PM +0800, Tao Tang wrote:
>> Extend IOMMU notifier functions to be SEC_SID-aware, ensuring that
>> invalidation notifications are dispatched to the correct security-aware
>> address space.
>>
>> This ensures IOMMU notifier events (e.g., to VFIO) are correctly routed
>> to the appropriate security world's address space, maintaining isolation
>> between secure and non-secure DMA operations.
> I don’t think that VFIO cares about secure regime, my guess is to
> keep the functions as this and don’t call them for secure invalidations.

So do we want to prevent VFIO devices from working in secure mode along
with the SMMU?

Eric
>
> Thanks,
> Mostafa
>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>  hw/arm/smmuv3.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 4a4de719a7c..e33a7babd1c 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1195,15 +1195,16 @@ epilogue:
>>   * @tg: translation granule (if communicated through range invalidation)
>>   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
>>   * @stage: Which stage(1 or 2) is used
>> + * @sec_sid: StreamID Security state
>>   */
>>  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>                                 IOMMUNotifier *n,
>>                                 int asid, int vmid,
>>                                 dma_addr_t iova, uint8_t tg,
>> -                               uint64_t num_pages, int stage)
>> +                               uint64_t num_pages, int stage,
>> +                               SMMUSecSID sec_sid)
>>  {
>>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>      SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>>                                 .inval_ste_allowed = true};
>>      SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
>> @@ -1251,7 +1252,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>      }
>>  
>>      event.type = IOMMU_NOTIFIER_UNMAP;
>> -    event.entry.target_as = &address_space_memory;
>> +    event.entry.target_as = smmu_get_address_space(sdev->smmu, sec_sid);
>> +    g_assert(event.entry.target_as);
>>      event.entry.iova = iova;
>>      event.entry.addr_mask = num_pages * (1 << granule) - 1;
>>      event.entry.perm = IOMMU_NONE;
>> @@ -1262,7 +1264,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>>                                        dma_addr_t iova, uint8_t tg,
>> -                                      uint64_t num_pages, int stage)
>> +                                      uint64_t num_pages, int stage,
>> +                                      SMMUSecSID sec_sid)
>>  {
>>      SMMUDevice *sdev;
>>  
>> @@ -1274,7 +1277,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>>                                          iova, tg, num_pages, stage);
>>  
>>          IOMMU_NOTIFIER_FOREACH(n, mr) {
>> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
>> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
>> +                               num_pages, stage, sec_sid);
>>          }
>>      }
>>  }
>> @@ -1307,7 +1311,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>      if (!tg) {
>>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
>>                                   tg, 1, ttl, leaf, stage);
>> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, sec_sid);
>>          if (stage == SMMU_STAGE_1) {
>>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
>>          } else {
>> @@ -1331,7 +1335,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
>>                                   num_pages, ttl, leaf, stage);
>>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
>> -                                  num_pages, stage);
>> +                                  num_pages, stage, sec_sid);
>>          if (stage == SMMU_STAGE_1) {
>>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
>>                                  num_pages, ttl, sec_sid);
>> -- 
>> 2.34.1
>>


