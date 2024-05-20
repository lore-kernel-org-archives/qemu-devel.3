Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9A6C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 08:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8yJt-0007a7-26; Mon, 20 May 2024 04:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s8yGO-0006cn-Ei
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s8yGM-0007hE-Jx
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716193253;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cr8VAKzTFUmlB9QS202+Ns4uqgwSfbIvEtGycUMDgjs=;
 b=gkHzDb1o1eHvz4GLbXY9AuBexalaz/cTyXsmUnPsVxS4n7LQbS7sw90zd+BRUZcrppO7Zw
 tZBjGWCbSZ8MDTavHax1Ntd5Wot8WtLuvaKBI5kZ3/7RgGgz0DDWpOjEuAuLL/GgKZluMP
 oY98+psuc4n5LkPEdQBGQhxn+34F5yo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-EfPP6eGaPJalG04NuCDgoA-1; Mon, 20 May 2024 04:20:48 -0400
X-MC-Unique: EfPP6eGaPJalG04NuCDgoA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a35d0f1673so48894006d6.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 01:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716193248; x=1716798048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cr8VAKzTFUmlB9QS202+Ns4uqgwSfbIvEtGycUMDgjs=;
 b=WpNj7O0niN7cIrn7UeLLceUwa0PvbNCeS8MOSVceGV4FNFjn4NMyq7xW+s7e0Wa9ds
 ALDmMBEtipSm1xDlDlTCXfryktg5qEyXqHddgMaLDDyT3494KUvcNjww5eXGWDe1HYOq
 OZDhbxzXyiwfvpbo4mmyD6AcI9vVg+91yuw7Lp/Pppf9gCHSFE3t25VyUFSogTx6VCUX
 bZIYkZtP2QxdV1MEfMUs2B6sXuXO1i5jJtPOW2ssUod4NDJHoA000jScemVZgDStMHVl
 JEsoinVbyBlZVEqSZzMIuSW8aPr8rKv55Jk4gx7iEhZCYmuw8SP0PONVotR8JP99ddZB
 bkzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW77mg/m0im+n6c+tJKx5FBszsHDxujqFEt1mvNO1bS/Hl4KXRf3jyjdHSfqP7S8kbxFgZsn8v6zOYjuTeXaulQlXwhXtU=
X-Gm-Message-State: AOJu0Yyn3nyxLVyd/OBOR2oHo9GCaJBVjx5hTgep1T71EUQ/t48Kjt9S
 KRWctMjJR/X65NZLBtaGz3Y2mqiuHXwlx3BDlDWn3sH2aeNSRIfClpQGTDUfCh44ci6EGTC2ZJH
 wjUnuuVQfM55Hg7RBRl8t1YsDgAjbmV00Bd0W0s4Amqemf6priRSz
X-Received: by 2002:a05:6214:5d0f:b0:6a9:69af:83f2 with SMTP id
 6a1803df08f44-6a969af8da9mr42996536d6.48.1716193247631; 
 Mon, 20 May 2024 01:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqNqPXEJ1nPSMAFCOWVRwsPlwDwGEVHIXpUYwOfWiL8K18vy0t3+LnHwmTCGpR9vCAUaQIHQ==
X-Received: by 2002:a05:6214:5d0f:b0:6a9:69af:83f2 with SMTP id
 6a1803df08f44-6a969af8da9mr42996286d6.48.1716193246935; 
 Mon, 20 May 2024 01:20:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194d2esm109644856d6.68.2024.05.20.01.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 01:20:46 -0700 (PDT)
Message-ID: <6b41c718-7e02-4a3d-adf8-a56306ab68d9@redhat.com>
Date: Mon, 20 May 2024 10:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/18] hw/arm/smmu-common: Add support for nested
 TLB
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-9-smostafa@google.com>
 <dc8d52ac-68af-4426-9a60-07ad909c86b0@redhat.com>
 <ZkYkTgDztEyX6GT_@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZkYkTgDztEyX6GT_@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Mostafa,
On 5/16/24 17:20, Mostafa Saleh wrote:
> Hi Eric,
>
> On Wed, May 15, 2024 at 03:48:05PM +0200, Eric Auger wrote:
>> Hi Mostafa,
>>
>> On 4/29/24 05:23, Mostafa Saleh wrote:
>>> This patch adds support for nested(combined) TLB entries.
>> space between nested and (.
> Will do.
>>> The main function combine_tlb() is not used here but in the next
>>> patches, but to simplify the patches it is introduced first.
>>>
>>> Main changes:
>>> 1) New entry added in the TLB, parent_perm, for nested TLB, holds the
>> s/entry/field, s/TLB/SMMUTLBEntry struct
> Will do.
>>>    stage-2 permission, this can be used to know the origin of a
>>>    permission fault from a cached entry as caching the “and” of the
>>>    permissions loses this information.
>>>
>>>    SMMUPTWEventInfo is used to hold information about PTW faults so
>>>    the event can be populated, the value of stage (which maps to S2
>>>    in the event) used to be set based on the current stage for TLB
>> I don't understand "(which maps to S2 in the event)". What do you mean?
>> This could be S1 or S2 depending on the active stage, no?
> Not really, if the IPA size is larger than S2 input size, this is
> considered stage-1 fault.
>
> For TLB permission fault, yes, that is how it is decided.
> However, with nesting, a permission fault from a cached entry can be
> from a stage-1 or stage-2, that’s why we now cache both and not just
> the combined permission, and the logic to set fault stage is modified
> accordingly.
I meant in smmu_translate() we initially had for permission fault
info->stage = cfg->stage whcih can be S1 or S2. Hence the fact I do not
understand the sentence

the value of stage (which maps to S2 in the event)

I understand that with nested this computation needs to change because the permission can be linked to either the S1 or S2 stage.
Maybe that's just a matter or rephrasing?


>>>    permission faults, however with the parent_perm, it is now set
>>>    based on which perm has the missing permission
>>>
>>>    When nesting is not enabled it has the same value as perm which
>>>    doesn't change the logic.
>>>
>>> 2) As combined TLB implementation is used, the combination logic
>>>    chooses:
>>>    - tg and level from the entry which has the smallest addr_mask.
>> tbh I am scared bout swapping s1/s2 tg and level. In smmu_iotlb_lookup()
>> I see tt->granule_sz being used which is s1 data. I mean it is not
>> obvious to me this is correct. Could you maybe give more explanations
>> detailing why/how this is guaranted to work.
> As you mentioned the next patch reworks the lookup logic, I can reorder
> the 2 patches if that is better, please let me know what you think?
Yes if you manage to reorder that may be more logical because otherwise
it looks incorrect.
>
>> Can you give additional details about what s1+s2 combinations were tested?
> I tested with S1 and S2 4K pages
> S1 level = 3 and S2 level = 3
> S1 level = 2 and S2 level = 3
> S1 level = 3 and S2 level = 2
> S1 level = 1 and S2 level = 2
>
> And also tested with with S1 64K granule and S2 4K.
OK, I would suggest you mention that in the coverletter because it is
reassuring and the combination is not totally obvious - at least to me ;-) -

Eric
>
>>>    - Based on that the iova that would be cached is recalculated.
>>>    - Translated_addr is chosen from stage-2.
>>>
>>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>>> ---
>>>  hw/arm/smmu-common.c         | 32 ++++++++++++++++++++++++++++----
>>>  include/hw/arm/smmu-common.h |  1 +
>>>  2 files changed, 29 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 21982621c0..0d6945fa54 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -394,7 +394,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>>>          tlbe->entry.translated_addr = gpa;
>>>          tlbe->entry.iova = iova & ~mask;
>>>          tlbe->entry.addr_mask = mask;
>>> -        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
>>> +        tlbe->parent_perm = tlbe->entry.perm = PTE_AP_TO_PERM(ap);
>> nit: I would prefer on separate lines.
> Will do.
>
>>>          tlbe->level = level;
>>>          tlbe->granule = granule_sz;
>>>          return 0;
>>> @@ -515,7 +515,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>>>          tlbe->entry.translated_addr = gpa;
>>>          tlbe->entry.iova = ipa & ~mask;
>>>          tlbe->entry.addr_mask = mask;
>>> -        tlbe->entry.perm = s2ap;
>>> +        tlbe->parent_perm = tlbe->entry.perm = s2ap;
>>>          tlbe->level = level;
>>>          tlbe->granule = granule_sz;
>>>          return 0;
>>> @@ -530,6 +530,27 @@ error:
>>>      return -EINVAL;
>>>  }
>>>  
>>> +/* combine 2 TLB entries and return in tlbe in nested config. */
>> suggestion: combine S1 and S2 TLB entries into a single entry. As a
>> result the S1 entry is overriden with combined data.
> Will do.
>
>>> +static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
>>> +                                                SMMUTLBEntry *tlbe_s2,
>>> +                                                dma_addr_t iova,
>>> +                                                SMMUTransCfg *cfg)
>>> +{
>>> +    if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
>>> +        tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
>>> +        tlbe->granule = tlbe_s2->granule;
>>> +        tlbe->level = tlbe_s2->level;
>>> +    }
>>> +
>>> +    tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
>>> +                                    tlbe->entry.translated_addr);
>>> +
>>> +    tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
>>> +    /* parent_perm has s2 perm while perm has s1 perm. */
>>  suggestion: while perm keeps s1 perm.
>>
> Will do.
>
> Thanks,
> Mostafa
>>> +    tlbe->parent_perm = tlbe_s2->entry.perm;
>>> +    return;
>>> +}
>>> +
>>>  /**
>>>   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
>>>   *
>>> @@ -607,9 +628,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>>>  
>>>      cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
>>>      if (cached_entry) {
>>> -        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
>>> +        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
>>> +            cached_entry->parent_perm & IOMMU_WO)) {
>>>              info->type = SMMU_PTW_ERR_PERMISSION;
>>> -            info->stage = cfg->stage;
>>> +            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
>>> +                          SMMU_STAGE_1 :
>>> +                          SMMU_STAGE_2;
>>>              return NULL;
>>>          }
>>>          return cached_entry;
>>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>>> index 09d3b9e734..1db566d451 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -77,6 +77,7 @@ typedef struct SMMUTLBEntry {
>>>      IOMMUTLBEntry entry;
>>>      uint8_t level;
>>>      uint8_t granule;
>>> +    IOMMUAccessFlags parent_perm;
>>>  } SMMUTLBEntry;
>>>  
>>>  /* Stage-2 configuration. */
>> Thanks
>>
>> Eric
>>


