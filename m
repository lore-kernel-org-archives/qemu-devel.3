Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC37606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=o3R4uS8k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5fJ-0004Y0-AO; Mon, 02 Nov 2026 22:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xO5fB-0004WJ-RS; Mon, 02 Nov 2026 22:58:22 -0500
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xO5f7-0000x4-Rd; Mon, 02 Nov 2026 22:58:21 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=VMInWRt+tgIZaQ5YTAKFTdHM3rWp8qRAuEOadSnD1TI=;
 b=o3R4uS8k6fzJyrml1fmHPDiRS6pxEELe/+d2RcYav43hC8d1Ye/u8hOhuuocxG8Hkl8EqGfhD
 YCYIM/a0kBN00yTM7mZHv6tRiLaTSe/O9k/qfZj8ulPNq6ioCvv05Wiq9goqdXuwLtzHJgzG4Mx
 TFa+6Hso++WyOhVbp2t0yW0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jJZYG0l7Mz12LDF;
 Tue,  3 Nov 2026 11:58:10 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id EF78240561;
 Tue,  3 Nov 2026 11:58:09 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 11:58:09 +0800
Message-ID: <922f814f-d49d-43a1-b9ea-7694575b8fa5@huawei.com>
Date: Tue, 3 Nov 2026 11:58:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/37] hw/arm/mpam: Implement CPOR cache portion
 partitioning
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_6C7ED336265811796EE3A442668C8E275709@qq.com>
 <20261103012649.3c68031d@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103012649.3c68031d@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.220;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout05.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/3 9:26, Jonathan Cameron 写道:
> On Fri, 16 Oct 2026 17:47:05 +0800
> Jinjie Ruan <2118537295@qq.com> wrote:
> 
>> From: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> Add the cache-portion controls: MPAMF_CPOR_IDR advertises the
>> CPBM bitmap width (MPAM_CACHE_PART portions) and the cache
>> subtype sets HAS_CPOR_PART, and the CPBM array registers become
>> readable and writable per selected internal PARTID.  Reads and
>> writes of CPOR_IDR/CPBM on an MSC without CPOR support are
>> logged and ignored.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Comment in here is fix the fixme ;)
> 
> Otherwise looks fine to me and I think it is a wise
> decision to always allocate backing for the max sized bitmap
> rather than trying to do it dependent on what the width is
> for a particular instance.
> 
>> ---
>>  hw/arm/mpam.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
>> index cce9355..2b1401e 100644
>> --- a/hw/arm/mpam.c
>> +++ b/hw/arm/mpam.c
>> @@ -356,6 +356,13 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>>              return 0;
>>          }
>>          return mpamf->impl_idr;
>> +    case A_MPAMF_CPOR_IDR:
>> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
>> +            qemu_log_mask(LOG_UNIMP,
>> +                "MPAM: Unexpected read of CPOR_IDR with no CPOR support\n");
>> +            return 0;
>> +        }
>> +        return mpamf->cpor_idr;
>>      case A_MPAMF_PARTID_NRW_IDR: {
>>          return mpamf->partid_nrw_idr;
>>      }
>> @@ -367,6 +374,19 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>>          return mpamf->mbwumon_idr;
>>      case A_MPAMF_CFG_PART_SEL:
>>          return mpamf->cfg_part_sel;
>> +    case A_MPAMF_MPAMCFG_CPBM0...
>> +        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
>> +    {
>> +        uint32_t array_offset;
>> +
>> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
>> +            qemu_log_mask(LOG_UNIMP,
>> +                "MPAM: Unexpected read of CPBM with no CPOR support\n");
>> +            return 0;
> 
> Sanity check for whether the width is large enough would just be informational
> here but it would I think be nice to have.

Will add a Sanity check for the width.

> 
>> +        }
>> +        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
>> +        return mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset];
>> +    }
>>      default:
>>          qemu_log_mask(LOG_UNIMP,
>>                        "MPAM: Unexpected read of %lx\n", offset);
>> @@ -410,6 +430,21 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>>          mpamf = &s->mpamf[s->ris];
>>          mpamf->cfg_part_sel = value;
>>          return;
>> +    case A_MPAMF_MPAMCFG_CPBM0...
>> +        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
>> +    {
>> +        uint32_t array_offset;
>> +
>> +        /* TODO: Figure out write mask to check this stays in write bits */
> 
> Ah. Indeed, this is the thing the LLM was complaining about earlier. The
> width depends on how many partitions there are.
> Definitely need that enforced (and a log on going over it). 
> 
> Roughly speaking n such that (from the spec)
> When ((n * 32) + x) >= UInt(MPAMF_CPOR_IDR().CPBM_WD)
> is bad so either register out of range where n is the
> register offset and x is the bit in it.  So shouldn't be too tricky to
> fix this.

Yes, the spec requires this, we should fix it.

> 
> 
>> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
>> +            qemu_log_mask(LOG_UNIMP,
>> +                          "MPAM: Unexpected write to CPMB when !HAS_CPORT_PART\n");
>> +            return;
>> +        }
>> +        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
>> +        mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset] = value;
>> +        return;
>> +    }
> 

-- 
Best regards,
Jinjie


