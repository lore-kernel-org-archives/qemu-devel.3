Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024BCCD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6YV-0006za-BL; Thu, 04 Jun 2026 07:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6YI-0006wA-0w
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6YE-0005pd-Jr
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780573673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Bfd+9ky4ls39Il5SYfH5+JPixa/D1xbdBk7i9KyEp0=;
 b=P/b5S6D5EdmIehlhX+mdNaIZwrViCmeQwhF3ad9Mwosu0y3zDjwItPBRPmbqY+bhmj07sT
 J8al5pttD9q7qow8gKL0rtAXh3E7PhqPgIPNNKZ1FYEkVSniOBf2LmeKesUy4hJdvRLwNM
 Pi5TwVEKu57cYpwYXbFBLywsX3y4pZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-hRj0e5UZNo2Xp1BBOQDCkw-1; Thu, 04 Jun 2026 07:47:52 -0400
X-MC-Unique: hRj0e5UZNo2Xp1BBOQDCkw-1
X-Mimecast-MFC-AGG-ID: hRj0e5UZNo2Xp1BBOQDCkw_1780573671
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so8443455e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 04:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573671; x=1781178471;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Bfd+9ky4ls39Il5SYfH5+JPixa/D1xbdBk7i9KyEp0=;
 b=g/7DxFhfJWi46S4Y2Z7KYceXCIqDBJ+jN1aDLmJwfrU5bIreBCbohjDIuMjDXtGbK0
 LqhuVYrqAGW4uLBN8IaNwS9x0VLAd242SMoB0ZGq10bz5EMxtlHCS5qjTBK1bGbICTEX
 p+RSq/70AwoBVTtjRVjlV6mwV7hDypaZpNabx0HAAb3NDCHOKJOK96wwZk21kjYatQnx
 k2fACjpl9FYumEv8mmcPTPMAXB6hLhuuCRvHArpHYgWl5Q7TEz9xgLuWHuhzeaMLsNjf
 8nIOlrisEbFqL5hSJy4mvUzwx7Fo1Je+xLNjFRjjST+ryNQZPVva1NmiHWyEXKQEuLrO
 TFeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nYJpoay/cKvFDN8GHx1KFZeKEVOudD51dchfk9NgLmvZi4zsF09h9k4H5tiXenFl+IsvkMwOqF/PC@nongnu.org
X-Gm-Message-State: AOJu0YzhgkMV3VebnivU6NKlOZWTIEZ3+l99NJXXdM6g1szvxcRMhu2y
 SMQdh0aPZdGOD2JKqsaAQxKn3PYR742wDbf8lzIHHnlG4rFXxQV+arPUItYqmrmwmG5CpCEF7fi
 HDeCuzhH9sJAAcoI97/cXJ/G4mqjJLPaMJM5OiXj6r82JQFbAbazFzOE9
X-Gm-Gg: Acq92OEJONw5cdXEMSG26QwS4o1YRPVMzGbZc7IIU24uK/czcciD8lTFJSDDjXWmcIs
 o08v1RrfalYmkn1X5WlG4iJy5s8pWErrGkatMy8lPfvYcd7hhG9SCnQHnzIzu3NCxCd+h7mR0aP
 4KJlXPBbigk2raLrlDxh2IRHG7u9lNkjcI1wliighrJMGjUAbQNLVdIwDruwXXPwLrJJ+vcqshO
 1V0zLKzzy8QutrEMpIgt0JN6ZoR0JQ0y6Ms+wRUTsOkD/1diz17/EDzBoJA3j6mv9gVfmGKH6nF
 ADZ0K80OVz/8BEpUQGubQOLxWJka6gjMKtoc4QTJU/AG/2K2RbCboMyDY1GTco8VJUWtWvh40pX
 n/d5nO9hw6xbZ0i1pZo2RJ4wAfchCLyo96QY7+ruHHI3u1TjqiAVWjyDGD6f/VGo8z+q8Jy9fEG
 wnFI61
X-Received: by 2002:a05:600c:5488:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490bc4d2697mr55346245e9.6.1780573670865; 
 Thu, 04 Jun 2026 04:47:50 -0700 (PDT)
X-Received: by 2002:a05:600c:5488:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490bc4d2697mr55345705e9.6.1780573670451; 
 Thu, 04 Jun 2026 04:47:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bd670c2esm51993945e9.0.2026.06.04.04.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 04:47:49 -0700 (PDT)
Message-ID: <39ee654d-1dbb-49f5-b780-bda2c7586e8e@redhat.com>
Date: Thu, 4 Jun 2026 13:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-20-skolothumtho@nvidia.com>
 <d3ab357a-a0f2-48c8-b458-b5263220e09c@redhat.com>
 <CH3PR12MB7548722927EE767FD6736FB7AB102@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548722927EE767FD6736FB7AB102@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/4/26 1:22 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 04 June 2026 10:56
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF
>> page0 as VCMDQ backing
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 6/1/26 1:42 PM, Shameer Kolothum wrote:
>>> hw/arm/tegra241-cmdqv: Use mmap'd VINTF Page 0 as VCMDQ backing
>> the title is double here.
> Ah..Ok.
>
>> By the way may I suggest
>> hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 for mapped vcmdqs
>> direct view
>>
>> to emphasize this relates the direct view and only for mapped vcmdqs
> It's true this eventually relates only to the direct aperture, but not yet.
> VINTF page0 only gets mapped into the guest in patch 21. Until then,
> for allocated vCMDQs we use the mmap'd VINTF page0 for both direct
> and VINTF aperture accesses.
>
> May be we can rename to:
> Route allocated VCMDQ Page0 accesses to the mmap'd VINTF page0

Indeed. Yes above makes sense. It is about allocated VCMDQs only
>
>>> Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ Page 0 register
>>> accesses through the mmap'd VINTF Page 0 backing once a hardware
>>> queue has been allocated for the VCMDQ.
>>>
>>> The two QEMU-trapped Page 0 apertures (direct at 0x10000, VINTF at
>>> 0x30000) are hardware aliases of the same underlying registers. A
>>> subsequent patch installs the VINTF aperture as a RAM-device into
>>> guest MMIO; in this patch both remain QEMU-trapped.
>>>
>>> The direct VCMDQ aperture stays QEMU-trapped (rather than aliased
>>> to the VINTF mmap) so that writes to an unallocated VCMDQ remain
>>> well-defined. The CMDQV architecture allows software to program a
>>> VCMDQ through the direct aperture without first allocating it to a
>>> VINTF; aliasing to the VINTF mmap would route those writes into
>>> unallocated logical slots where the hardware silently drops them.
>>>
>>> A VCMDQ Page 0 access is served from one of two sources:
>>>
>>>   - Cache-backed: no hw_queue is allocated for the VCMDQ
>>>     (HW_QUEUE_ALLOC has not yet succeeded). Both apertures use
>>>     QEMU's register cache.
>>>
>>>   - HW-backed: HW_QUEUE_ALLOC has succeeded. Both apertures access
>>>     the registers directly through the mmap'd VINTF Page 0.
>>>
>>> tegra241_cmdqv_sync_vcmdq() copies any cached writes (CONS_INDX,
>>> PROD_INDX, CONFIG, GERRORN) into the mmap'd page on the cache-to-HW
>>> transition so the guest's earlier register state survives.
>>>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.c | 73
>> +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 73 insertions(+)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index 54d95f4e4e..dce7089697 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -39,6 +39,47 @@ static void
>> tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
>>>      }
>>>  }
>>>
>>> +/*
>>> + * Return a pointer into the mmap'd VINTF page0 for the VCMDQ Page 0
>>> + * register at @offset0 in VCMDQ slot @index, or NULL when the VCMDQ
>>> + * has no hw_queue allocated or the VINTF page0 is not mmap'd.
>>> + */
>>> +static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV
>> *cmdqv,
>>> +                                                 int index, hwaddr offset0)
>>> +{
>>> +    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
>>> +        return NULL;
>>> +    }
>>> +    return (uint32_t *)(cmdqv->vintf_page0 +
>>> +                        (index * CMDQV_VCMDQ_STRIDE) +
>>> +                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
>>> +}
>>> +
>>> +/*
>>> + * Flush cached register writes into the mmap'd VINTF page0 after a
>>> + * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
>>> + * the cache-to-hardware transition.
>>> + */
>>> +static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int
>> index)
>>> +{
>>> +    uint32_t *ptr;
>>> +
>>> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index,
>> A_VCMDQ0_CONS_INDX);
>>> +    if (!ptr) {
>>> +        return;
>>> +    }
>>> +    *ptr = cmdqv->vcmdq_cons_indx[index];
>>> +
>>> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index,
>> A_VCMDQ0_PROD_INDX);
>>> +    *ptr = cmdqv->vcmdq_prod_indx[index];
>>> +
>>> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
>>> +    *ptr = cmdqv->vcmdq_config[index];
>>> +
>>> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
>>> +    *ptr = cmdqv->vcmdq_gerrorn[index];
>>> +}
>>> +
>>>  /*
>>>   * Allocate a host HW VCMDQ from the current cached BASE / size for
>> @index.
>>>   *
>>> @@ -95,6 +136,9 @@ static bool
>> tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
>>>      cmdqv->vcmdq_gerror[index] &=
>> ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
>>>      cmdqv->vcmdq_status[index] |=
>> R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +    /* Pre-alloc cached writes survive the cache-to-hardware transition. */
>> what about the opposite transition?
> Yeah. We don’t do anything now. I think better to reset the cache on
> opposite transition.
OK. I would add this explanation.
>
>>> +    tegra241_cmdqv_sync_vcmdq(cmdqv, index);
>>> +
>>>      return true;
>>>  }
>>>
>>> @@ -113,13 +157,22 @@ static void
>> tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
>>>   *
>>>   * The caller normalizes the MMIO offset such that @offset0 always refers
>>>   * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
>>> + *
>>> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, read directly
>>> + * from the VINTF page0 backing. Otherwise, fall back to the cache.
>>>   */
>>>  static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV
>> *cmdqv,
>>>                                                  hwaddr offset0, int index,
>>>                                                  bool direct)
>>>  {
>>> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
>>>      uint64_t val = 0;
>>>
>>> +    if (ptr) {
>> shouldn't you test "direct" as well? I know that later on this is will
>> be backed by another mr but I think this would be clearer.
> Is the suggestion here to just limit this to "direct"? We can't do that.
> Both apertures alias the same registers, and for an allocated and
> mmapped VINTF page0 we access the hw directly.
>
> The vintf page0 gets mapped to the guest only in patch 21, so
> after that only the direct aperture is trapped here anyway.

Yes I agree this would be true only once patch 21 is applied. Sorry for
the noise.
>
>>> +        val = *ptr;
>>> +        goto out;
>>> +    }
>>> +
>>>      switch (offset0) {
>>>      case A_VCMDQ0_CONS_INDX:
>>>          val = cmdqv->vcmdq_cons_indx[index];
>>> @@ -144,6 +197,7 @@ static uint64_t
>> tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
>>>                        "%s unhandled read access at 0x%" PRIx64 "\n",
>>>                        __func__, offset0);
>>>      }
>>> +out:
>>>      trace_tegra241_cmdqv_read_vcmdq_page0(index, direct ? "direct" : "vi",
>>>                                            offset0, val);
>>>      return val;
>>> @@ -220,11 +274,29 @@ static uint64_t
>> tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
>>>   *
>>>   * Page 0 registers are all 32-bit; this helper is only called for 4-byte
>>>   * writes.
>>> + *
>>> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, write directly
>>> + * to the VINTF page0 backing. Otherwise, update the cache.
>>>   */
>>>  static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV
>> *cmdqv,
>>>                                               hwaddr offset0, int index,
>>>                                               uint32_t value, bool direct)
>>>  {
>>> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
>> same here?
>>> +
>>> +    if (ptr) {
>>> +        switch (offset0) {
>>> +        case A_VCMDQ0_CONS_INDX:
>>> +        case A_VCMDQ0_PROD_INDX:
>>> +        case A_VCMDQ0_CONFIG:
>>> +        case A_VCMDQ0_GERRORN:
>>> +            *ptr = value;
>>> +            goto out;
>>> +        default:
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>>      switch (offset0) {
>>>      case A_VCMDQ0_CONS_INDX:
>>>          cmdqv->vcmdq_cons_indx[index] = value;
>>> @@ -255,6 +327,7 @@ static void
>> tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>>>                        "%s unhandled write access at 0x%" PRIx64 "\n",
>>>                        __func__, offset0);
>>>      }
>>> +out:
>>>      trace_tegra241_cmdqv_write_vcmdq_page0(index, direct ? "direct" : "vi",
>> by the way could be interesting to log in the trace event that mmapped
>> was used instead of cache regs.
> Could do.
>
> Thanks,
> Shameer
Thanks

Eric


