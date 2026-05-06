Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1563ECD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 11:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKaCz-0004uM-UN; Wed, 06 May 2026 07:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKaCy-0004ty-Gq
 for qemu-devel@nongnu.org; Wed, 06 May 2026 07:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKaCv-0002sT-Hm
 for qemu-devel@nongnu.org; Wed, 06 May 2026 07:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778066063;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdxOvKWd7QjpPcjWvOUERL3A7gVOS1Cgkr9jPfltKc4=;
 b=Z2sDrb5PTWgheUBqZYrutI3XQVOcVLOy710cCllr/ZTspBlC6TlssHOvvyqz1bllN9CqyZ
 oNWBjKA5IHowGcCsYUiqg4NQn9BvgRO7T8QLFk6Gv27hunLKJXdjpUxgTI9hCeXg9lfwWf
 AmNPE1Io7s/N19WkWxhc6ZBiSlHW77E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-XFXxooHJNN6EyJEB4APwZg-1; Wed, 06 May 2026 07:14:21 -0400
X-MC-Unique: XFXxooHJNN6EyJEB4APwZg-1
X-Mimecast-MFC-AGG-ID: XFXxooHJNN6EyJEB4APwZg_1778066061
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso2176486f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 04:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778066060; x=1778670860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdxOvKWd7QjpPcjWvOUERL3A7gVOS1Cgkr9jPfltKc4=;
 b=FyNKDdLFJWQRSYvM20KAAy+MWutWRlgbJmK9xiMiL/t+vxF1Jw0Y1mycl178W2hGsG
 avz1j8gARR4J2QVOJyuvXIqh7ZI5s7wKq506R3tTi1tBpwVVHCrHsT3kt+VfkBTTnakM
 UL3bBhFUV/gnzG2OFH4jOx9hqXtOkxBrf7FwoDKN/bAgKsaQ3DTAA3w/MDapUAJORxqe
 fdFhDxPgobjU/k9Te2vb63gzeX+PmXK71/WTumonGkoVVbL+0cAbcsti+oDSfgslzyVI
 i5mwEyzcrlsCg/BHvjQZk1vgnRJhpG8ZxoYXnhXhW0EyiFAL3E5TvPXDJE7iZ3v4CA1i
 QYCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3NcK4qLfwFxRvKtEhbYdS2C//3eR/R6DTDmokdUr9NXlsC/1SuvSaost14Qgde5wGpBuRtPuMNW8k@nongnu.org
X-Gm-Message-State: AOJu0Yxy8fppMcJHVGsDDAlMEglgGN4tjbZ95KuzuRj2Bl2kxis1XtCq
 RwmpFCwMd0lZeEtgfhR1M6NwWs8VG7uOZq4yZP63JbrERiVj90+vqmdhZMyEzYb6FAP0prCNPbn
 VqZ4tZTolMw9+/VjW1aN0zUqFbR+6lRWHSqTVF+CXKKEyse5qgShbPT60
X-Gm-Gg: AeBDiesXV61xbA9gsl9pTiAQQYtfVMWmk2agmmjWllDh12OaA8wDg1M+Nq5jA+3eaac
 vN/y/Lf2kiMm3Lgz9CpuEDnx/RWAvByb/ruSaOpFCmIINPhlh56vYu3Yv3QRI30PLoPct0XGPt7
 ZUtLmFMg4PH7bYQUO7c8NwNlMom8B7UypMFTdUfvndOwFmbYbCK7+ZvXFq4GJuLKQCOqaLeb/kU
 3pUdJ7XIsslKX5i44EqtkPqflUFCJ4wQfalt2jL9OD/r4jc+HUbICHRtBsdIy99650/Gx2dR055
 YwQYwH8zSlzvIwT5VIGNVAE57Li8y4zN7luqVRpP7d4grMByQlC1a8TnuOmIld5s96WSzM0/VWh
 h8bUw6VjqUesE5rnI/TW4dK91+grscwQ6N2NRSUIEKUal+KC3cFTa3JtYMwl+tf2u+w/2waNR06
 REP7fG
X-Received: by 2002:a5d:588b:0:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-4515b057282mr5226249f8f.9.1778066060476; 
 Wed, 06 May 2026 04:14:20 -0700 (PDT)
X-Received: by 2002:a5d:588b:0:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-4515b057282mr5226196f8f.9.1778066059970; 
 Wed, 06 May 2026 04:14:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4511d8cd160sm7213615f8f.8.2026.05.06.04.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 04:14:19 -0700 (PDT)
Message-ID: <9e936551-dc4c-441d-8ea2-f60c6d88f9d6@redhat.com>
Date: Wed, 6 May 2026 13:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 reads
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
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-16-skolothumtho@nvidia.com>
 <b5589dbb-c553-4218-8cb5-53b99ec828d5@redhat.com>
 <CH3PR12MB7548B9F1FFF1AFE039C33226AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548B9F1FFF1AFE039C33226AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/5/26 3:27 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 05 May 2026 11:13
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
>> phrdina@redhat.com
>> Subject: Re: [PATCH v4 15/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ
>> register reads
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi,
>>
>> On 4/15/26 12:55 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Tegra241 CMDQV exposes per-VCMDQ register windows through two
>> MMIO
>>> apertures:
>>>
>>>   CMDQV_CMDQ_BASE (0x10000/0x20000): VCMDQ Page0/Page1
>> (global)
>>>   CMDQV_VI_CMDQ_BASE (0x30000/0x40000): VINTF VCMDQ
>> Page0/Page1
>> (logical)
>>> VINTF Page0 (0x30000) and VCMDQ Page0 (0x10000) are hardware aliases
>> what about page1?
> Right. Page1 is also an alias, but kernel only provides mmap support for Page0.
> Hence Page1 is always served from register cache. I will update.
>
>>> addressing the same underlying registers. Add read emulation for both
>>> apertures, backed by a register cache. VINTF Page0 reads are translated
>>> to their VCMDQ Page0 equivalent and served from the same cached state.
>>>
>>> Once IOMMU_HW_QUEUE_ALLOC and viommu_mmap are wired up in a
>> subsequent
>>> patch, Page0 register reads will be served directly from the hardware
>>> backed mmap'd page instead of the cache. Page1 registers are always
>>> served from cache.
>> I would add add that
>> Page 0 contains VCMDQ control and status registers
>> while Page 1 contains VCMDQ base and DRAM address registers
>>
>>
>> I would add Nicolin's explanation
>> "
>>
>> The global page 0 programmable at any time so long as CMDQV_EN
>> is enabled.
>>
>> The logical (VINTF) page 0 are programmable only when SW allocates and
>> maps
>> global vcmdq(s) to a VINTF. "logical" also means "local" to that
>> VINTF.
>> "
> Ok. Will add.
>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.h | 185
>> ++++++++++++++++++++++++++++++++++++++++
>>>  hw/arm/tegra241-cmdqv.c |  73 ++++++++++++++++
>>>  2 files changed, 258 insertions(+)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
>>> index 965670066d..b8bd8cd8ff 100644
>>> --- a/hw/arm/tegra241-cmdqv.h
>>> +++ b/hw/arm/tegra241-cmdqv.h
>>> @@ -29,6 +29,13 @@
>>>   */
>>>  #define TEGRA241_CMDQV_IO_LEN 0x50000
>>>
>>> +/* CMDQV MMIO aperture bases and VCMDQ stride */
>>> +#define CMDQV_VCMDQ_PAGE0_BASE  0x10000  /* CMDQV_CMDQ_BASE
>> */
>>> +#define CMDQV_VCMDQ_PAGE1_BASE  0x20000
>>> +#define CMDQV_VINTF_PAGE0_BASE  0x30000  /*
>> CMDQV_VI_CMDQ_BASE */
>>> +#define CMDQV_VINTF_PAGE1_BASE  0x40000
>>> +#define CMDQV_VCMDQ_STRIDE      0x80
>>> +
>>>  typedef struct Tegra241CMDQV {
>>>      struct iommu_viommu_tegra241_cmdqv cmdqv_data;
>>>      SMMUv3AccelState *s_accel;
>>> @@ -49,6 +56,14 @@ typedef struct Tegra241CMDQV {
>>>      uint32_t vintf_sid_match[16];
>>>      uint32_t vintf_sid_replace[16];
>>>      uint32_t vintf_cmdq_err_map[4];
>> I would add a comment explaining that those cached registers store the
>> consistent/idenftical values for both the global and logical regs (they
>> are same)
>>> +    uint32_t vcmdq_cons_indx[TEGRA241_CMDQV_MAX_CMDQ];
>>> +    uint32_t vcmdq_prod_indx[TEGRA241_CMDQV_MAX_CMDQ];
>>> +    uint32_t vcmdq_config[TEGRA241_CMDQV_MAX_CMDQ];
>>> +    uint32_t vcmdq_status[TEGRA241_CMDQV_MAX_CMDQ];
>>> +    uint32_t vcmdq_gerror[TEGRA241_CMDQV_MAX_CMDQ];
>>> +    uint32_t vcmdq_gerrorn[TEGRA241_CMDQV_MAX_CMDQ];
>>> +    uint64_t vcmdq_base[TEGRA241_CMDQV_MAX_CMDQ];
>>> +    uint64_t vcmdq_cons_indx_base[TEGRA241_CMDQV_MAX_CMDQ];
>>>  } Tegra241CMDQV;
>>>
>>>  /* CMDQ-V Config page registers (offset 0x00000) */
>>> @@ -160,6 +175,176 @@
>> SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
>>>  /* MAP_1 and MAP_2 omitted; not referenced directly */
>>>  SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
>>>
>>> +/*
>>> + * VCMDQ register windows.
>>> + *
>>> + * Page 0 @ 0x10000: VCMDQ control and status registers
>>> + * Page 1 @ 0x20000: VCMDQ base and DRAM address registers
>> Can you clearly separate regs that belong to page 0 from regs that
>> belong to page 1
>>> + */
>>> +#define A_VCMDQi_CONS_INDX(i)
>> same remark as for config registers. Please use the spec terminology
>>
>> SMMU_CMDQV_VCMDQi_CONS_INDX_0
>>
>>>                \
>>> +    REG32(VCMDQ##i##_CONS_INDX, 0x10000 + i * 0x80) \
>>> +    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
>>> +    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
>>> +
>>> +A_VCMDQi_CONS_INDX(0)
>>> +A_VCMDQi_CONS_INDX(1)
>>> +
>>> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_NONE 0
>>> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_OPCODE 1
>>> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ABT 2
>>> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ATC_INV_SYNC 3
>>> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_ACCESS 4
>>> +
>>> +#define A_VCMDQi_PROD_INDX(i)
>> SMMU_CMDQV_VCMDQi_PROD_INDX_0
>>>                        \
>>> +    REG32(VCMDQ##i##_PROD_INDX, 0x10000 + 0x4 + i * 0x80) \
>>> +    FIELD(VCMDQ##i##_PROD_INDX, WR, 0, 20)
>>> +
>>> +A_VCMDQi_PROD_INDX(0)
>>> +A_VCMDQi_PROD_INDX(1)
>>> +
>>> +#define A_VCMDQi_CONFIG(i)
>> SMMU_CMDQV_VCMDQi_CONFIG_0(i)
>>>                   \
>>> +    REG32(VCMDQ##i##_CONFIG, 0x10000 + 0x8 + i * 0x80) \
>> 0x80, isn't it the stride you defined earlier, ie
>>
>>  CMDQV_VCMDQ_STRIDE ?
>>
>>> +    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
>>> +
>>> +A_VCMDQi_CONFIG(0)
>>> +A_VCMDQi_CONFIG(1)
>>> +
>>> +#define A_VCMDQi_STATUS(i)                             \
>>> +    REG32(VCMDQ##i##_STATUS, 0x10000 + 0xc + i * 0x80) \
>>> +    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
>>> +
>>> +A_VCMDQi_STATUS(0)
>>> +A_VCMDQi_STATUS(1)
>>> +
>>> +#define A_VCMDQi_GERROR(i)                               \
>>> +    REG32(VCMDQ##i##_GERROR, 0x10000 + 0x10 + i * 0x80)  \
>>> +    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
>>> +    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
>>> +    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
>>> +
>>> +A_VCMDQi_GERROR(0)
>>> +A_VCMDQi_GERROR(1)
>>> +
>>> +#define A_VCMDQi_GERRORN(i)                               \
>>> +    REG32(VCMDQ##i##_GERRORN, 0x10000 + 0x14 + i * 0x80)  \
>>> +    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
>>> +    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
>>> +    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
>>> +
>>> +A_VCMDQi_GERRORN(0)
>>> +A_VCMDQi_GERRORN(1)
>> /* Page 1 */
>>> +
>>> +#define A_VCMDQi_BASE_L(i)
>> ditto remove the A_ prefix and use spec terminology
>>>               \
>>> +    REG32(VCMDQ##i##_BASE_L, 0x20000 + i * 0x80) \
>>> +    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
>>> +    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
>>> +
>>> +A_VCMDQi_BASE_L(0)
>>> +A_VCMDQi_BASE_L(1)
>>> +
>>> +#define A_VCMDQi_BASE_H(i)                             \
>>> +    REG32(VCMDQ##i##_BASE_H, 0x20000 + 0x4 + i * 0x80) \
>> may instead of using 0x20000 define macros for the base address of each
>> region
>>> +    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
>>> +
>>> +A_VCMDQi_BASE_H(0)
>>> +A_VCMDQi_BASE_H(1)
>>> +
>>> +#define A_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
>>> +    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x20000 + 0x8 + i *
>> 0x80) \
>>> +    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
>>> +
>>> +A_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
>>> +A_VCMDQi_CONS_INDX_BASE_DRAM_L(1)
>>> +
>>> +#define A_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
>>> +    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x20000 + 0xc + i *
>> 0x80) \
>>> +    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
>>> +
>>> +A_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
>>> +A_VCMDQi_CONS_INDX_BASE_DRAM_H(1)
>> I would group all regs definition par page. The layout would look
>> clearer to me.
>>> +
>>> +/*
>>> + * VI_VCMDQ register windows (VCMDQs mapped via VINTF).
>>> + *
>>> + * Page 0 @ 0x30000: VI_VCMDQ control and status registers
>>> + * Page 1 @ 0x40000: VI_VCMDQ base and DRAM address registers
>> same here, pls separate page 0 and page 1 definitions
>>> + */
>>> +#define A_VI_VCMDQi_CONS_INDX(i)
>> A_
>>>                  \
>>> +    REG32(VI_VCMDQ##i##_CONS_INDX, 0x30000 + i * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
>>> +    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
>>> +
>>> +A_VI_VCMDQi_CONS_INDX(0)
>>> +A_VI_VCMDQi_CONS_INDX(1)
>>> +
>>> +#define A_VI_VCMDQi_PROD_INDX(i)                             \
>>> +    REG32(VI_VCMDQ##i##_PROD_INDX, 0x30000 + 0x4 + i * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
>>> +
>>> +A_VI_VCMDQi_PROD_INDX(0)
>>> +A_VI_VCMDQi_PROD_INDX(1)
>>> +
>>> +#define A_VI_VCMDQi_CONFIG(i)                             \
>>> +    REG32(VI_VCMDQ##i##_CONFIG, 0x30000 + 0x8 + i * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
>>> +
>>> +A_VI_VCMDQi_CONFIG(0)
>>> +A_VI_VCMDQi_CONFIG(1)
>>> +
>>> +#define A_VI_VCMDQi_STATUS(i)                             \
>>> +    REG32(VI_VCMDQ##i##_STATUS, 0x30000 + 0xc + i * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
>>> +
>>> +A_VI_VCMDQi_STATUS(0)
>>> +A_VI_VCMDQi_STATUS(1)
>>> +
>>> +#define A_VI_VCMDQi_GERROR(i)                               \
>>> +    REG32(VI_VCMDQ##i##_GERROR, 0x30000 + 0x10 + i * 0x80)  \
>>> +    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
>>> +    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
>>> +    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
>>> +
>>> +A_VI_VCMDQi_GERROR(0)
>>> +A_VI_VCMDQi_GERROR(1)
>>> +
>>> +#define A_VI_VCMDQi_GERRORN(i)                               \
>>> +    REG32(VI_VCMDQ##i##_GERRORN, 0x30000 + 0x14 + i * 0x80)  \
>>> +    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
>>> +    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
>>> +    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
>>> +
>>> +A_VI_VCMDQi_GERRORN(0)
>>> +A_VI_VCMDQi_GERRORN(1)
>>> +
>>> +#define A_VI_VCMDQi_BASE_L(i)                       \
>>> +    REG32(VI_VCMDQ##i##_BASE_L, 0x40000 + i * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
>>> +    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
>>> +
>>> +A_VI_VCMDQi_BASE_L(0)
>>> +A_VI_VCMDQi_BASE_L(1)
>>> +
>>> +#define A_VI_VCMDQi_BASE_H(i)                             \
>>> +    REG32(VI_VCMDQ##i##_BASE_H, 0x40000 + 0x4 + i * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
>>> +
>>> +A_VI_VCMDQi_BASE_H(0)
>>> +A_VI_VCMDQi_BASE_H(1)
>>> +
>>> +#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
>>> +    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x40000 + 0x8 + i
>> * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
>>> +
>>> +A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
>>> +A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(1)
>>> +
>>> +#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
>>> +    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x40000 + 0xc + i
>> * 0x80) \
>>> +    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
>>> +
>>> +A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
>>> +A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(1)
>>> +
>>>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>>>
>>>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index 3b08ed0ff3..35e6f0bbd6 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -15,6 +15,46 @@
>>>  #include "tegra241-cmdqv.h"
>>>  #include "trace.h"
>>>
>>> +/*
>>> + * Read a VCMDQ register using VCMDQ0_* offsets.
>>> + *
>>> + * The caller normalizes the MMIO offset such that @offset0 always refers
>>> + * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
>>> + *
>>> + * All VCMDQ accesses return cached registers.
>>> + */
>>> +static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv,
>> hwaddr offset0,
>>> +                                          int index)
>>> +{
>>> +    switch (offset0) {
>>> +    case A_VCMDQ0_CONS_INDX:
>>> +        return cmdqv->vcmdq_cons_indx[index];
>>> +    case A_VCMDQ0_PROD_INDX:
>>> +        return cmdqv->vcmdq_prod_indx[index];
>>> +    case A_VCMDQ0_CONFIG:
>>> +        return cmdqv->vcmdq_config[index];
>>> +    case A_VCMDQ0_STATUS:
>>> +        return cmdqv->vcmdq_status[index];
>>> +    case A_VCMDQ0_GERROR:
>>> +        return cmdqv->vcmdq_gerror[index];
>>> +    case A_VCMDQ0_GERRORN:
>>> +        return cmdqv->vcmdq_gerrorn[index];
>>> +    case A_VCMDQ0_BASE_L:
>>> +        return cmdqv->vcmdq_base[index];
>>> +    case A_VCMDQ0_BASE_H:
>>> +        return cmdqv->vcmdq_base[index] >> 32;
>>> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
>>> +        return cmdqv->vcmdq_cons_indx_base[index];
>>> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
>>> +        return cmdqv->vcmdq_cons_indx_base[index] >> 32;
>>> +    default:
>>> +        qemu_log_mask(LOG_UNIMP,
>>> +                      "%s unhandled read access at 0x%" PRIx64 "\n",
>>> +                      __func__, offset0);
>>> +        return 0;
>>> +    }
>>> +}
>>> +
>>>  static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV
>> *cmdqv,
>>>                                                   hwaddr offset)
>>>  {
>>> @@ -92,6 +132,7 @@ static uint64_t tegra241_cmdqv_read_mmio(void
>> *opaque, hwaddr offset,
>>>  {
>>>      Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
>>>      uint64_t val = 0;
>>> +    int index;
>>>
>>>      if (offset >= TEGRA241_CMDQV_IO_LEN) {
>>>          qemu_log_mask(LOG_UNIMP,
>>> @@ -125,6 +166,38 @@ static uint64_t tegra241_cmdqv_read_mmio(void
>> *opaque, hwaddr offset,
>>>      case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
>>>          val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
>>>          break;
>>> +    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
>>> +        /*
>>> +         * VINTF Page0 registers have the same per-VCMDQ layout as the
>>> +         * VCMDQ Page0 registers. Translate the VINTF aperture offset to the
>>> +         * equivalent VCMDQ aperture offset, then fall through to reuse the
>>> +         * common VCMDQ decoding logic below.
>>> +         */
>>> +        offset -= CMDQV_VINTF_PAGE0_BASE -
>> CMDQV_VCMDQ_PAGE0_BASE;
>>> +        QEMU_FALLTHROUGH;
>>> +    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
>>> +        /*
>>> +         * Decode a per-VCMDQ register access.
>>> +         *
>>> +         * The hardware supports up to 128 identical VCMDQ instances; we
>>> +         * currently expose TEGRA241_CMDQV_MAX_CMDQ (= 2). Each
>> VCMDQ
>>> +         * occupies a CMDQV_VCMDQ_STRIDE-byte window within the page.
>>> +         *
>>> +         * Extract the VCMDQ index and normalize to the VCMDQ0_* register
>>> +         * offset. A single helper services all instances via @index.
>>> +         */
>>> +        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) /
>> CMDQV_VCMDQ_STRIDE;
>>> +        return tegra241_cmdqv_read_vcmdq(cmdqv,
>>> +                offset - index * CMDQV_VCMDQ_STRIDE, index);
>>> +    case A_VI_VCMDQ0_BASE_L ...
>> A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
>>> +        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above */
>>> +        offset -= CMDQV_VINTF_PAGE1_BASE -
>> CMDQV_VCMDQ_PAGE1_BASE;
>>> +        QEMU_FALLTHROUGH;
>>> +    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
>>> +        /* Same decode logic as VCMDQ Page0 case above */
>>> +        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) /
>> CMDQV_VCMDQ_STRIDE;
>>> +        return tegra241_cmdqv_read_vcmdq(cmdqv,
>>> +                offset - index * CMDQV_VCMDQ_STRIDE, index);
>> Please add trace points for read & write accesses
> Just to clarify, we already have trace_tegra241_cmdqv_read_mmio and
> trace_tegra241_cmdqv_write_mmio, so this suggestion is for to have 
> another pair for vcmdq read/write, right?
nope I did not see that

trace_tegra241_cmdqv_write_mmio also applied to those accesses.
To be honest I would have prefered to have different traces points for different types of MMIO (CMDQV Config, VCMDQ P0 (when not mmaped), VCMDQ P1) to easily differentiate them but if you fell that's too heavy that's enough.

Eric

>
> (Agree with all other suggestions above)
>
> Thanks,
> Shameer


