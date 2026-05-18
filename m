Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1094ECD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1EQ-00009c-RP; Mon, 18 May 2026 12:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wP1Dr-000089-R4
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:53:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wP1Dp-0000jr-M6
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:53:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEnGGZ2975394
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 16:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 llMtLF45uXqRdnKRDA/t586E1+zajq8sfTGMfPsNYbM=; b=YxSBQXOqAUz1vCu1
 DKry/JCVGl+ySw5uosItq1Gt3QEb+vJq1EbVUASItquBJDsRW011V6xKLZt5TEIi
 6fc21OMVZEW9kcalqyIctCw1EFW3MmkJ0g3Sm8uETsfMG9VQipMs+AYbc2etKQPy
 9OpZ3VX8fEbBPw6xsfyDRK3pdRfRad8uuPk8omfgTHG8SECG0TaBF4/6B/7pXju+
 sMCyqMitTjXBZhFfrwNommQx+u/WLy7evlRQhxxzdnu7CkN9zt0LVM7q6N0IzIOo
 yCFlkP8z684VKaO5RoOGl48o9MTozNmyPMVIXUcZFg/BKXoPumlREiMfxG1GuElU
 XjWJ8Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v48fdf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 16:53:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-910b2b92741so395346585a.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779123218; x=1779728018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llMtLF45uXqRdnKRDA/t586E1+zajq8sfTGMfPsNYbM=;
 b=Cg63A//mxX0D2/bc4dnpRisN3Ht+I4gQOo53SRspmj9lLmmX+NEtmYlFr7/rkTo2uk
 V2FUBLmf6E8mJYOP2N/PX6Xgn0d0l7dlhpmyLqVk6uIPzyQR3t0Oe7OKxmK7bRpWvMca
 boZTZCg40IYDSlSV6Q5HIHzpRI8us+9qA1MMNCaKG/uJG8CeK7IzAMO0fBCCURRBQ0+9
 fsIq10GQkeugAhnh+itO7DeGC0PdMz1hY4oD3XEIWvtzt68UdSzV0Y339RZ52qqOwrIh
 2b6L3AhxUCXL3dUc+4QUFidM/vDfELCaGkQWWlhtW7OxUm6N2VWS7HniikzTCm92SgYs
 ORBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779123218; x=1779728018;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llMtLF45uXqRdnKRDA/t586E1+zajq8sfTGMfPsNYbM=;
 b=CkEvzlSeSot6Aa4K2vlE+Sz1PiQBSW7ASx107tBCT4gn06eemLPk7KHwQY4MocqRhJ
 DVppoVqK2iCpVhyoHciy5gjbctb5lbSA3zAGYBAC42QEW+WfJUMSCc4JJJiNwPgc/4UB
 5qlzUC/DzfgRsjgdrbZ9blmq17JAHDrxdOHDi8cKVDDHrgHt79StNHfnmaz4907QET4O
 uMdXpW60f9EADFF0WzH39Vvs3hTR5NnoQ/4ozeMi1sQvOktegmp42RcmJK1hgex0/fo3
 uxqllgrSOcqM+hmwZte4XHFiYUqLg9iLIKS+MKNNapowfg/jpXcBOVqCR+Qp8emF0E5K
 3fPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VBVMZqO1g0MIQWWx4Oy9MY5v6wBce+GDnPlF+/jHwJunqLQ4sPDWxxzNsh7X93ytuh0Utz/ZVfMPZ@nongnu.org
X-Gm-Message-State: AOJu0YwBz13KdypzeJ9msKuyybEQ3zH+QH8gL+DRYpSrxlLbV+EPspgo
 RRfuD7qi99YSnzupV27b/JYCq9kDH1RnOQXSGW/L3krXC1p1UAfgNU+RNX3n6B7POTT3w19GTDp
 8t6r82jSPNsAWrQF2NTXg+v61Ro5unutOle7FwOc1AB+iLN+UfL9HePIsDA==
X-Gm-Gg: Acq92OGxUEHMV95do0yXsdm3Zt9d1uC4PU/GzkNLQ/KYhe/qqumq4zmZ9daaYn05fdD
 OYFIs6+/aELO62JvUyereBMpMWztTp3b/EwG3u1Sv+AH0GMo8R2fB56FYaFIHt6KgThUxHiATru
 QN5mNvX6hmXm+AEY8zQjVVTTGp2D4hCX9HF+mF58NRD0nwtFpnZLpc5Me/M8SomV5V4X7HAl9TR
 TQUX6djupA2C7I9cfTgt1Iv7pz0dctt0XZ/wCKfuNNywio4rTF2up/+3K6NiUiE7xIPh+4VGxS8
 z48F6INZv4mYVE97eWWY46IRJf8pb+gcqb0aQMdaOWKa5aSdvKUfsq3VBHaKVHRmaHhwfsekVM8
 dYSS3vxNqXT14uds0knmOLBEOTpicXIku3toCdFlIvbMcDrakMjFOTjYFO3o=
X-Received: by 2002:a05:620a:a019:b0:911:e17d:1d78 with SMTP id
 af79cd13be357-911e17d1e4dmr1864934685a.21.1779123217836; 
 Mon, 18 May 2026 09:53:37 -0700 (PDT)
X-Received: by 2002:a05:620a:a019:b0:911:e17d:1d78 with SMTP id
 af79cd13be357-911e17d1e4dmr1864931185a.21.1779123217377; 
 Mon, 18 May 2026 09:53:37 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba36d137sm1528859285a.1.2026.05.18.09.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:53:36 -0700 (PDT)
Message-ID: <ccb35d50-514d-4b17-8018-8d6bf58934f8@oss.qualcomm.com>
Date: Mon, 18 May 2026 13:53:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] target/riscv: Use macros for PMP address alignment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20260518070725.9816-1-jay.chang@sifive.com>
 <20260518070725.9816-3-jay.chang@sifive.com>
 <3bb15715-b11e-46a6-bba5-46a85c036632@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3bb15715-b11e-46a6-bba5-46a85c036632@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0b4412 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=69wJf7TsAAAA:8 a=jV4xrG5E8RH9DHdS76YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=oJz5jJLG1JtSoe7EL652:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: BLjcrzuqWQzlglstlP0D0KTXGq_9FtHg
X-Proofpoint-GUID: BLjcrzuqWQzlglstlP0D0KTXGq_9FtHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NiBTYWx0ZWRfXxzzFyzm6FVSq
 ZGqZT53ZC5nXtYPNT5KXdXPUzL57s7U7B2HXpi9C/kfijsIHNvoCZ2cmVaizBefb2xol53LrYYJ
 NFoHzuCbSdVUFPSWX3KhVQLfPdgBqD0zp+m2nRJ431aqSJPIlxmVOPvIc9pZEKb99RKiOmf7j53
 bZG0foPJq+do3C7kfn3lOwVQjcqXiW1MvI+QCcqAzbIIcBfYbd4ceuN/8iCQNMbWZD0CQYW209t
 zAEeApULCYhWpYcyuhjhk1kIRuCQgbYxaKU/v9kIlTvUqtmjquMZxb2+TXntVVk4xRTQvnEZv78
 quQ8XDMmFRaIeAnPhjpT6MMIhfcofhjTjsYnExnX4BBHYdPeR4t8IAxbWUGtJUaqLv8+X4esBAe
 3NypnO84Ljl5YnmcZRt87fZJkb08zGFWvDf8r1PRSe9rZRldqwu7oaNPI38phZNOepYV/XIlSNa
 GyGMkXVMHA1Ffa81s/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/18/2026 4:19 AM, Philippe Mathieu-Daudé wrote:
> On 18/5/26 09:07, Jay Chang wrote:
>> Replace manual bit manipulation with alignment macros for better
>> readability:
>>
>> - TOR: Use ROUND_DOWN() to clear lower bits
>> - NAPOT: Use ROUND_UP() to set lower bits
>>
>> The behavior remains unchanged.
>>
>> Signed-off-by: Jay Chang <jay.chang@sifive.com>
>> ---
>>   target/riscv/pmp.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
>> index de2157c830..238c7c5162 100644
>> --- a/target/riscv/pmp.c
>> +++ b/target/riscv/pmp.c
>> @@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>>       case PMP_AMATCH_TOR:
>>           /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
>>           if (g >= 1) {
>> -            prev_addr &= ~((1ULL << g) - 1ULL);
>> -            this_addr &= ~((1ULL << g) - 1ULL);
>> +            target_ulong granule = 1ULL << g;
> 
> Maybe better to directly use uint64_t, in preparation of
> https://lore.kernel.org/qemu-devel/20260515180437.23620-1-anjo@rev.ng/

Can we please CC qemu-riscv@nongnu.org for the next version? This might
be the first time the RISC-V reviewers are made aware that this series
exists.  It surely is my first time :D


Cheers,
Daniel


> 
>> +            prev_addr = ROUND_DOWN(prev_addr, granule);
>> +            this_addr = ROUND_DOWN(this_addr, granule);
>>           }


