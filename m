Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69055606A332
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ACm+Eb9g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5UO-0004Rc-6K; Mon, 02 Nov 2026 22:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xO5UJ-0004Pt-KG; Mon, 02 Nov 2026 22:47:07 -0500
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xO5UD-000808-FN; Mon, 02 Nov 2026 22:47:07 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6vtK9MV7OIfwMc1/xVnrx8sKUHJ1hamKdp+djdznTGw=;
 b=ACm+Eb9gpNPIeHyjMNV4cuXsKKg58h2znutgl289tj9hr/zDD+QAFbF026R444L8ck/nuZmgm
 Rs/QGWptEhXn0CIk8FFfTIoaQDpDkiXHAxRoR/OYf4wNVMG4k7szaqJUER6Z11ltWkolF2uyna1
 eys7g8Kc9w7+4aqz8Tfb0cY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jJZJ108Zpz1prL0;
 Tue,  3 Nov 2026 11:46:41 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id D987D40561;
 Tue,  3 Nov 2026 11:46:44 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 11:46:44 +0800
Message-ID: <06c07f26-f1ce-4e29-b012-cd3f62ced1ea@huawei.com>
Date: Tue, 3 Nov 2026 11:46:43 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/37] hw/arm/mpam: Handle MPAMCFG_PART_SEL selection
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_841229DA998C63C495D7B4DB092844DA5B07@qq.com>
 <20261103011449.4ea8d138@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103011449.4ea8d138@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.219;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout04.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/3 9:15, Jonathan Cameron 写道:
> On Fri, 16 Oct 2026 17:47:03 +0800
> Jinjie Ruan <2118537295@qq.com> wrote:
> 
>> From: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> Add read/write handling for the MPAMCFG_PART_SEL selector: the
>> RIS field switches the per-RIS register bank (rejecting RIS
>> values beyond num-ris, and nonzero RIS on an MSC without RIS
>> support), and PARTID_SEL/INTERNAL record the selected partition
>> for the configuration registers.  Writes are stored per RIS so
>> the selector reads back as written.
> 
> For all these patches, the commit message wrap seems a touch short.
> Probably wrap at 75ish.


Hi Jonathan,

Thank you for the review. Will make it wrap at 75ish.

> 
> Otherwise a suggestion inline.
> 
> With that
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> 
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  hw/arm/mpam.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
>> index 17ca286..c21a737 100644
>> --- a/hw/arm/mpam.c
>> +++ b/hw/arm/mpam.c
>> @@ -329,6 +329,8 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>>          return mpamf->csumon_idr;
>>      case A_MPAMF_MBWUMON_IDR:
>>          return mpamf->mbwumon_idr;
>> +    case A_MPAMF_CFG_PART_SEL:
>> +        return mpamf->cfg_part_sel;
>>      default:
>>          qemu_log_mask(LOG_UNIMP,
>>                        "MPAM: Unexpected read of %lx\n", offset);
>> @@ -339,7 +341,37 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>>  static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>>                                 unsigned size)
>>  {
>> +    MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
>> +    /* Update in the ris setting path */
>> +    Mpamf *mpamf = &s->mpamf[s->ris];
>> +
>>      switch (offset) {
>> +    case A_MPAMF_CFG_PART_SEL:
>> +        if (value & ~MPAMF_CFG_PART_SEL_WRITE_MASK) {
>> +            qemu_log_mask(LOG_UNIMP,
>> +                          "MPAM: Unexpected write to CFG_PART_SEL Mask=%x Value=%lx\n",
>> +                          MPAMF_CFG_PART_SEL_WRITE_MASK, value);
>> +        }
>> +        /* Field matches for all RIS */
>> +        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_RIS) &&
>> +            FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) != 0) {
>> +            qemu_log_mask(LOG_UNIMP,
>> +                          "MPAM: Unexpected write of non 0 RIS on MSC with !HAS_RIS\n");
>> +            return;
>> +        }
>> +        if (FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) >= s->num_ris) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "MPAM: RIS %d out of range (num-ris %d)\n",
>> +                          FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS),
>> +                          s->num_ris);
>> +            return;
>> +        }
>> +        s->ris = FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS);
> It seems like this is reused a fair bit above.  Perhaps put it in a
> local variable.
>       ris = FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS);
> and then here
>       s->ris = ris;

Will reuse it, thank you very much!

> 
>> +        s->part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, PARTID_SEL);
>> +        s->internal_part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, INTERNAL);
>> +        mpamf = &s->mpamf[s->ris];
>> +        mpamf->cfg_part_sel = value;
>> +        return;
>>      default:
>>          qemu_log_mask(LOG_UNIMP,
>>                        "MPAM: Write to unexpected register Addr %lx Value=%lx\n",
> 

-- 
Best regards,
Jinjie


