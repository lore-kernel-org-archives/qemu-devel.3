Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C24C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMNd-0006qB-Dd; Thu, 02 Jul 2026 14:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfMNc-0006n0-8K
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:43:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfMNa-0006Nh-FN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:43:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662E3V1D666074
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 18:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dWSlHLHYuGwhQJRyL262tpz3eD7pxLYsTmkGckMVVGg=; b=gcbga0/ZorKbc6cN
 Uruqwm8B6fczwogYxDSFvGxpHgS8mLKMzNDxSAUoLCkTH+/KKB/sWouebrwvvVzI
 owpJ7+tcKwjkkGYDD4mjgzSuqZe7shju7iUbrb8CYNusf5/0MUAH9k0WnlMxwpOg
 w98nBunWnnRTCWgFUXMXA22JopAnvu/kRer7EUeX7CiukSP7IEG1CwxJo6INym05
 WE6LyoPFmQVnU+uI4eC7pGHa04DmjmaCvlZfi7lUsVpxQ0xp52u2Yrx5sfjCPS1Y
 f9gvDHfv13IANm+FmwBBWYUYZc9GG/Xtu6R7IJG+bK5759XJbdr16ngBnQWz+AVK
 0+QjVg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc2rv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 18:43:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eb8914e651so43176946d6.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783017796; x=1783622596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dWSlHLHYuGwhQJRyL262tpz3eD7pxLYsTmkGckMVVGg=;
 b=TpbEqPFW2TabH1Uc6hDyyDa+lrVSkxWAIUXgDl9TtBUWlxnqo+AUCFSLkpOzArEduZ
 sI+JzPUNOu/Zn6I+ifLfZST8Uce6ItCGsGbREu18/V1r9Pku8In3eKj2/G8GDQjeekX0
 VSI4rsnSeYuDPhXXvMEAR/w61bQX/94Ct5Q6fja+9ppAaex1HQ+LJVCJoIZLLAgZkfoa
 6IYj/XnpIh0u1H8bV+6NnmDbp1LujOEm3T3JilU+1KUk1tDx/o3txXqqG6guIIH3bo8x
 avHH/UNEDokgVvq7lVfqhg79I+HODbZ0RcdheB9zEewzWsXZELEY3espky5qpMjHYJid
 4Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017796; x=1783622596;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dWSlHLHYuGwhQJRyL262tpz3eD7pxLYsTmkGckMVVGg=;
 b=koR2Eg4ZMDtjHu+jxhOqI2FN7XEhKPldWT+yg3TsoQxC+6fI0v339W+GuchlbwTffY
 rcIhbAmInxqUHLQ/H7hkyytjaFs3HkYTPV7+HaLVW1Ys6nGCn6PHodF8CMLrXM0dUtfP
 Z4auzeZIC6jTLBpq9LQpv09Rb5L0yJ6EYJu0KOTqh07R0P7jKfzpwiTqwenI5omWhd50
 UCSeV8PNfBqra3rTQBhA0c+WofPki55NDvChFw/BbAWri+oLF8n3D8X3ulKhNTWxnVtH
 fOA0bPSduCt8Zc380yfloE+jSPmHicqHZSuN7GGQ/ljrbOfj3LasyZtWuZDErCP1NJCO
 DYsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUo8OBGc+rCUUHxoCGQbl2LP7i/UoQNfU82HXoVW00HZriI/9PsS+Mtp7+oyVK9x9ERzkeWRSOVWAc@nongnu.org
X-Gm-Message-State: AOJu0YzIJdA2/66izzmmLL0tl0N7oDS86OaAqLQaOMy34EiZ80ST9ldo
 qBa8/uuRszPeE4Mp3XiJ/swos4t8WClCEWuKuxjb//uvjsd6/y9hyt0RrIU2wn0SeoFLSbdMaog
 gvNvOZqM9e85Ry+04Dd6jx+MkzacDpK+/3DpEJtqAmOtfr1awq4AZ2/r2xw==
X-Gm-Gg: AfdE7ckOwKET7RtPjYa0u0CQr1hCXjCoMPI520Nux6hFPHdb20YuBlf42E1XwLXrObE
 m/b3LOr2QSoUqK0jqw6yZroMqHN78UtdkDTOji6Gx80I8zsFZXagAg3RokOmzLjW+4b3VRPrObt
 lNCE1fNf7/XWLFWl6SLYA8lAKDT9QvsW6NFtOhUDuDkbhqgVVDqhSZLGpExrMcrla4GYBuVPCVM
 +yDfnB3oOtUBAavroEHttBXEmn0odt1wkXh6LOdRYreavXH/T4O+0TCm3KSCvGbHRqvRRcf/znD
 VuWuCe3TC1pfInC7OYuZKXufYpFcbyH0KK1+Zoaw3x/g21sl+9uPzwwRWcC8pnYOiuCtkBKf1dA
 09i/PrFncdBWfyHhQR2/AFHLJiEbc2ZlISVxe25ASfNZ8
X-Received: by 2002:a05:6214:4a84:b0:8f1:e1ba:cdfc with SMTP id
 6a1803df08f44-8f421bab001mr131442896d6.16.1783017796280; 
 Thu, 02 Jul 2026 11:43:16 -0700 (PDT)
X-Received: by 2002:a05:6214:4a84:b0:8f1:e1ba:cdfc with SMTP id
 6a1803df08f44-8f421bab001mr131442096d6.16.1783017795687; 
 Thu, 02 Jul 2026 11:43:15 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46e371d55sm32478896d6.10.2026.07.02.11.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:43:15 -0700 (PDT)
Message-ID: <80e0e4a6-3eb4-4c18-bc76-873575cfc91c@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:43:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
To: "Nutty.Liu" <nutty.liu@hotmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260630203155.2103084-1-daniel.barboza@oss.qualcomm.com>
 <SE3PR04MB892210C486C30552B7FCCE09F3F62@SE3PR04MB8922.apcprd04.prod.outlook.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <SE3PR04MB892210C486C30552B7FCCE09F3F62@SE3PR04MB8922.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vgogca5aLhNm7YCCVajwjfdl9_MWuPZ9
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a46b144 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=VMdUOAZnqhEMiYmn0K4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE5NyBTYWx0ZWRfX6KBPY3RWf+dY
 JmRx7esudARcMckB/3Yn90ygH1j2c7YeRz4IJoZ9ZVQM2yQKKfbznA50QZircX7iuvI+0aEyRRg
 GrGlvQYZH+9NLlM3Q7dvxHJ2InXvHuNTvupYJKtrjwtYMWxqOglM1XlIIyP31vTUBKTD7Ws0hMd
 Zar2rMIJyD4YSy4UgNWEuLfpyHU00WnfSDUbGu1IS/VKqGjkleUtDNAx83ZxpO5CqiQgHvw3zOq
 JZASv/Y30udvJUCjCzpTTcLNOc2vX/3d1uu7kT2uZbgIn5MnWTo+02CFdUwBug9gAno61DtFiSZ
 rF4rNH3JTq/wjaFDKHDJ0iShMkNnXT9bAwENpRBE7XKAXW6Oh1AYkqkc9dlw1P59VUvS75tUhu5
 afury2fCMr2QSMA2psQrFrXC48FJz4Bn6I+xIOYjhiX67kX18e2COqg+zK2uSQ9NgHBb0d/r5yz
 SoUxootimG6OtI5AfeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE5NyBTYWx0ZWRfX5TnKiGjJ5L/u
 5xUzIaCOdLw2fE7byZRXBrSenT6kePAoWDLMwCOMJQ8hN86zlkq56DP4ATDSEqj+t0JxLOBrmqt
 4E70Y3u8Wph9U2+4iiLeQ4TK25GKUN0=
X-Proofpoint-GUID: vgogca5aLhNm7YCCVajwjfdl9_MWuPZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020197
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/1/2026 1:02 AM, Nutty.Liu wrote:
> 
> On 7/1/2026 4:31 AM, Daniel Henrique Barboza wrote:
>> We must check if IOHGATP_PPN is 16kb aligned for non-bare GATP modes.
>>
>> qos-riscv-iommu.h needs change too since G_IOHGATP must now be 16kb
>> aligned too.
>>
>> Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3550
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   hw/riscv/riscv-iommu.c               | 14 ++++++++++++++
>>   tests/qtest/libqos/qos-riscv-iommu.h |  2 +-
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index 891a56e731..09990c640f 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -795,6 +795,20 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
>>           return false;
>>       }
>> +    if (gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
>> +        uint64_t iohgatp_ppn = get_field(ctx->gatp,
>> +                                         RISCV_IOMMU_DC_IOHGATP_PPN);
> Seems it should be like the following:
> 
> +        uint64_t iohgatp_ppn = PPN_PHYS(get_field(ctx->gatp,
> +                                        RISCV_IOMMU_DC_IOHGATP_PPN));

Yes, I should.  No wonder I need to change the tests to make it work ... But
for some reason the bug reproducer was working.  Go figure ..


With this correction we're able to both fix the bug and keep the tests
untouched, meaning we're doing the right thing.

Thanks for both yours and Chao's comment in his reply.  I'll send a v2.


Daniel


> 
> Otherwise,
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> 
> Thanks,
> Nutty
>> +        /*
>> +         * One of the conditions for a misconfigured DDT entry
>> +         * according to the riscv-spec: "DC.iohgatp.MODE is not
>> +         * Bare and the root page table determined by DC.iohgatp.PPN
>> +         * is not aligned to a 16-KiB boundary."
>> +         */
>> +        if (iohgatp_ppn & ((1ULL << 14) - 1)) {
>> +            return false;
>> +        }
>> +    }
>> +
>>       fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
>>       if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
>> diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
>> index 90e69a5d73..4a972401f5 100644
>> --- a/tests/qtest/libqos/qos-riscv-iommu.h
>> +++ b/tests/qtest/libqos/qos-riscv-iommu.h
>> @@ -46,7 +46,7 @@
>>   #define QRIOMMU_L1_PTE_VAL          0x0000000000012000ull
>>   #define QRIOMMU_L2_PTE_VAL          0x0000000000013000ull
>> -#define QRIOMMU_G_IOHGATP           0x0000000000020000ull
>> +#define QRIOMMU_G_IOHGATP           0x0000000008000000ull
>>   #define QRIOMMU_G_L0_PTE_VAL        0x0000000000021000ull
>>   #define QRIOMMU_G_L1_PTE_VAL        0x0000000000022000ull


