Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F11CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6ww-0005mk-GG; Mon, 15 Jun 2026 09:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZ6wt-0005mF-Dm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:01:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZ6wr-0005Vn-KU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:01:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FCbbWe386584
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUHcU1V/1c+24BRWz761wIQ/26MSKmQQQ2vGWP21ynw=; b=MfhW3AwFdN1rcT6K
 cBCJnINudRwLVChbcSyv6N0z1Ca6vryM3CH/hHkB6PHi1kVZpsLoCweumAsd/1PV
 WeLnhlCH+9N6WHgTxQZUN+xKQVUiEWxLid+vMO5AHyTjOBegfvC7uDGKTmIIV7Wc
 ZvuWOSj3VM877G5njBUPTVI39T45J2HFOmUzeD7tkRC+ZJkzwwugqnwtuvJHmLxW
 d7so64HUXjU8woimT7tTRDVjeiGWR82hak1sb/WaBt3835ZuZoYbUj3aSoBv9Yr3
 smoLp0+iWiUH6NB9vqBOinvyiJJTuZgwNOd+6O0BgyhT5gZzbIhUfri/5EyH0zze
 SeZDtA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf0rs8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:01:52 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6607988ca90so4400926d50.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781528512; x=1782133312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WUHcU1V/1c+24BRWz761wIQ/26MSKmQQQ2vGWP21ynw=;
 b=BZP+dpf6hFoend1Z+0SqoHtW8UA7IIUO8gV9IQb44iGEyN8g8pOXri6cOJqY5FqflS
 Ls1qCI8QJlmn1n6Nj+AGXWZ+bL/LXTxGoxWhQKA0OoNalTpZJ5n9JUuXHNI1AcLIao3t
 DMJYKdtdpLM/ySZ+oOJ5I26I8WKofs2MKIIAk2SGkqevhvh5s74spvhJa+10f/hDsngR
 VfG6ZTb/Ncd6C2mab1aoR5Q5+setb9pupdSEV7UhU54Lw+KgI6bZLQ1AfYNyZkfzzbPu
 2VcYXNrWm8nrC5PDlPFyOkvEUoUai2TAUvm2y/MYi8yjg9xuruUhFB4CU4wnjQF36e1D
 tIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781528512; x=1782133312;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUHcU1V/1c+24BRWz761wIQ/26MSKmQQQ2vGWP21ynw=;
 b=AhmdQwXBeEbGflURvzWTtMGNnJelJyWvTThpqImaoBFH4CKH9aIk2t+u3aBONPxFRA
 aUPmh5Yfz+yUGWGq/9IOOMuJOVaGV4rxRRFsdCM9/tB3JEAIGiZjOnhrUpQD9bj29LtS
 HeIWT2AdSVSOViTxZiBBc6zoYQtPLGkVMwnevFKlu7dqmWxHnl/mKNkPubymSItdG2gO
 xuh808XzzPQuj5l7CZ01FRqMJTHU8RIRRyosg1d6/B+SaCK/zVJ25Msivm+WnTzLEVwP
 X62LQn6mZuxEFS0ViVdP1KCq16GkDACrSFKQcEsSaAkkTlF4wB0AnfBFbDiKX+vAUMLM
 dxfQ==
X-Gm-Message-State: AOJu0Yw/PPM6Q914BB7T3layL5J/BoxuhvrhJ4SN9yxBXw+Slia79fLv
 Zw9aWES39yKTK9tQh7IEYTcvkaREMQkxonzZxxneakQqvhM3SBW1wrJ1hqnSZTlesD8+WnnAY7j
 2o5tJhdb1Gvzhb5wz+hO+V0nqjjZ4v/4IFADJ/Ukk3FDSl9JE6ZdqYQz2RQ==
X-Gm-Gg: Acq92OG/GxXVV+Tn/12AKIJzAVigH+9qtfTkPtc1+4A0+OqjJSQCG9xuZyL4y8/DneK
 ZlWzEbByqJ0knnAvCBM5MWOc3rcKOm1lHbzXf/52wEbeaq4OMk0ADdRpFKMP2kZz91e6lTo8C53
 M9rLHV+FE4sfzN6KbjGxLrmXZBdmIDazEu9Z93j22MKt36jG4y/9gJTjJYi6eEeUA4jNeCRCvZs
 X7cMaRbrjKpNTIVy3YN4eRywBBNpFZw5GUCsX1xVqduQ8DnMc1nD1nhQ7CL7xtSKa91SVXW1/60
 9oLa5PaaCtHy/JVx7Ml1bDO6hDPe5lnWLY8+y4tWExEwpJZfcpE+sIFrqkM4gR8m4H4tIivMmfJ
 fKisKECKTNyee8R1SVWlDx5o1Bk5BiUMFdbJXAL96JqM+/kPxmEa/lwHBxg==
X-Received: by 2002:a05:690e:b88:b0:662:7533:5927 with SMTP id
 956f58d0204a3-662782ccf2bmr11379417d50.38.1781528506627; 
 Mon, 15 Jun 2026 06:01:46 -0700 (PDT)
X-Received: by 2002:a05:690e:b88:b0:662:7533:5927 with SMTP id
 956f58d0204a3-662782ccf2bmr11379283d50.38.1781528505627; 
 Mon, 15 Jun 2026 06:01:45 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66274e55ee5sm4888040d50.18.2026.06.15.06.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 06:01:44 -0700 (PDT)
Message-ID: <393da8db-e360-42f1-9563-babf0fdb63e7@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:01:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv/cpu.c: do not default to svbare for bare
 CPUs
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
 <20260611162223.2361941-3-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKP=nFiDXGdGCvEPbKoUvWkNedNjggd7nXYYqFgz4WO8Qw@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKP=nFiDXGdGCvEPbKoUvWkNedNjggd7nXYYqFgz4WO8Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a2ff7c0 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=o-Yv1TYGoLSqRNxq_U8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: E31mtL-vldg3oSuuOqronJJYqA4Pxh8D
X-Proofpoint-ORIG-GUID: E31mtL-vldg3oSuuOqronJJYqA4Pxh8D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzNyBTYWx0ZWRfXz94lRScgNnc6
 tqeiNjcQLBowDflzJJ2cWWBv9HbakDRnPIKA0Sy1maEdKn8HLsXkC6A+1ytO0V14M9Loogh6xDp
 pWqdycvBSHigOxIuCsoRUgKgKvS4buM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzNyBTYWx0ZWRfX2V/cf/7Nah0p
 JtjZHsyvsy92/9S3JtBLOxURbq3Cy9jW8o2CuvdJQfluBiS2YXQH8lzz+hEdRZIWiHzmoSgVhz3
 bIb/qgtJWBBbuk3pAJ8zJbIrRW3hJlwklDms1CdtWyVMLpS4SN12vEeuuMNHhEivUWL3xqfTxcN
 37br/V8qvSIdQrhsBLW77AR4baVaw4Wf1NJ5W9IJwyghXpgxIFOvJi6lqPmKrIBg8VUj334Y65t
 iebEojw8BVgOsafOEqlafFeUWVDPCOkl1ULLzH0iHn/R0jZAVMj+DOf3z3OkgOsDCKHbR6xjVWR
 cgWCzmweOUyUKWN7E7TZd1Q0Sna4V6lYR5n50bFfoZjwmOkvfmMtFTBCixZfFIqf6NVJFW1KgSl
 bf0Gvz0uNpoEa/AeaMFir57dQ30UCz3Niiy7lOh2rW3xyXig6TOm0WpECmhr//4F0mzsfdLLcMa
 7o4HDIjRzukFo49POYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150137
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 6/15/2026 1:11 AM, Alistair Francis wrote:
> On Fri, Jun 12, 2026 at 2:23 AM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> Back when we added bare CPUs (rv64i and friends) we didn't had a way of
>> easily setting satp-mode to 'bare' in the command line, so we decided
>> that if the user didn't specify a satp-mode we would limit the CPU to
>> max_satp_mode = bare.
>>
>> We don't need to do that anymore now that we can set 'svbare' in the
>> command line, thus users can confortably set 'svbare=on' if they want.
>>
>> Besides, setting svbare if no satp-mode is provided in the command line
>> just for bare CPUs, while every other CPU will default to its
>> max_satp_mode value, is yet another random stuff users have to deal with
>> for no good reason.  And, on top of all that, this will make it weirder
>> to use CPUs that uses bare CPUs as their parent type.
>>
>> Remove this special handling for bare CPUs.
> 
> This is a breaking change though. I think this should follow our
> deprecation process.

I don't consider this a breaking change because we're changing the default
to a higher satp mode.  Existing software that is running these CPUs with
'bare' will keep working because the satp mode in use is defined by
the firmware. A software using 'bare' does not care, or it definitely
shouldn't care at least, if the underlying virtual CPU happens to support
more satp modes.

The most impactful different here is to CPUs that might be created using
'Bare' as a parent.  We don't have that ATM but I did do that in the
riscv-server-ref board at some point.  This new CPU will have the same
satp behavior as the Bare CPU, i.e. the default max_satp_mode will be
defaulted to 'bare' too, ignoring any cfg.max_satp_mode that this new
CPU made at its own init.

Maybe we need more debate on this.  I'm okay with applying just patch 1
for now while we dwell on this one a bit.

> 
> Although I'm not sure we even want to make this change. The idea of
> the bare CPUs was to disable everything by default (which we don't do,
> but that doesn't mean we should be worse at it)

I think we do a good job with bare CPUs, although from my understanding the
most usage they have is to be a backbone for the profile CPUs.



Cheers,
Daniel


> 
> Alistair
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.c | 20 +-------------------
>>   1 file changed, 1 insertion(+), 19 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index d968daa404..c2f79a1ca0 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -510,21 +510,6 @@ static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
>>       }
>>       return true;
>>   }
>> -
>> -/* Set the satp mode to the max supported */
>> -static void set_satp_mode_default_map(RISCVCPU *cpu)
>> -{
>> -    /*
>> -     * Bare CPUs do not default to the max available.
>> -     * Users must set a valid satp_mode in the command
>> -     * line.  Otherwise, leave the existing max_satp_mode
>> -     * in place.
>> -     */
>> -    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) != NULL) {
>> -        warn_report("No satp mode set. Defaulting to 'bare'");
>> -        cpu->cfg.max_satp_mode = VM_1_10_MBARE;
>> -    }
>> -}
>>   #endif
>>
>>   #ifndef CONFIG_USER_ONLY
>> @@ -896,10 +881,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>>       }
>>
>>       if (cpu->satp_modes.map == 0) {
>> -        if (cpu->satp_modes.init == 0) {
>> -            /* If unset by the user, we fallback to the default satp mode. */
>> -            set_satp_mode_default_map(cpu);
>> -        } else {
>> +        if (cpu->satp_modes.init != 0) {
>>               /*
>>                * Find the lowest level that was disabled and then enable the
>>                * first valid level below which can be found in
>> --
>> 2.43.0
>>
>>


