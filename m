Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8643DC531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmrif-0003Df-Nv; Thu, 23 Jul 2026 07:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmrie-0003D7-Dq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 07:36:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmric-0006w5-CP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 07:36:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qi8M3390703
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xKeV2PUBGzSXkTO1r3ppSa6Eo4Pc/7kJNJqPSG+mvG0=; b=nFbuRmk19xKxE1BU
 5PwD8jNmzyYPQjO7jBFvUPzUPvAqXFpE+ZFva9hwTgTKFo8Rjn6lIf6FEluuXXBx
 2okKQJbzaswap1wvgXaCL8kU35diBipb+H+Pgr2Ye8d7hhSX3DE4Iq9QaCM0h0ru
 P4/lJg0YWMvfRQNzkNQIB6XaCqkNhFRcqvYqQ1BzwbZLLmIDHP1suUucDxvC5TUv
 HJ+bdiBZdLA8WJzBfUZB24Ru8OSYBeg95ba4RaonOcjCvNs7Yd6TnJVtn2A6Ngkw
 yPsA3EcIxbLwtaT3BBmX/z1sRKULFGJTl61fNexpQKcVHqchPMB8d8tKGLXFG3Jm
 LCuifQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0ks3y9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:35:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e538afe65so119394685a.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784806559; x=1785411359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xKeV2PUBGzSXkTO1r3ppSa6Eo4Pc/7kJNJqPSG+mvG0=;
 b=EfrsQ6OLUm4M0qNSNt775YX2o2aGHvEhF3fqLqCY9LhSjqx3YwArPEPzT0heHOlbgz
 A80EUI3jZ7VKu3CS7boy/Da/irH+6daxs8MVxv/cCO6Rya/yMvwqA+pBDKJCRXqp6ITc
 K6afbk4DpVFDDPt+bGvxcwgWIQiAUJJRdIugdlpHJOPwg32+TYpwC/brjahxhExYBdvH
 xlFWmiCFSx4KO5tEE03InQRZV6ssOvoegpANDkhZ5ZtWz27dFU63tPrcX8VFEHkC26gA
 9QzCVFrAx0rMg81Yhd0npo4cKDdA5Jpv7xw8XZabZiiQjATAsXXZNX26stuzOFBucpli
 vJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784806559; x=1785411359;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xKeV2PUBGzSXkTO1r3ppSa6Eo4Pc/7kJNJqPSG+mvG0=;
 b=hHkxM6Sny177+vUkN7Ff4WR3oZULV/Ad0s1F+xe60Kw4PHXOseoMXAZznMZjTdLETA
 iCsY/DEA7VZx0Is/c9UlFl12N+s2NeYg+0joOiDjnJ6H0aJA/dCGk9b3l0o8j+3nCrPt
 hSwivzfkwvpYuaNfDXD5K8wBbKqNO8W5NpWopAyEgwXhS38/l8cw9mpDK4AXrwvTtLtk
 WczJ6JrHno2G0EV4SSzPRsQr5+wZ8vhCIafnNlTkpuq0ErhXpLaKhtDtwSobxx3bF8TQ
 uwupLDolOUHRWwY4RuvPd/gNthMUMO1IH6yCtwtnIgJYNCfkFIvELlSbHlJZQQpVjX7Q
 tYgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMOWA6hltDtqr/sXOFe9eNdc+BBjSfIGO3JtN/5XI8OxKhPZ/BNtTwnluSI6TOZ73E0aVaYnR+gVOM@nongnu.org
X-Gm-Message-State: AOJu0Yysfe5s9YhyZmwS4yKfIPkZsuT2o37VZ81HaoXiD0yfgeUEBgNz
 s7akW9iwrBIYRn661rxGOyU8atmDaknpgt34vM+V410sLbGBdWXhuhJdgbKq22sJ9MVTDaB5V2O
 vn0z2i+8sgM6ruEncmIGAu0SsnOHN0lU8ArnhVw8rUTj/C80MxnCGg6tc8Q==
X-Gm-Gg: AR+sD10lXGJx28aFL9JheTL0rlY5z1Gp2j90E5DH0f0gsacLnA3i54Rauc79dTGf+dh
 68dnY7+mGoAoS0hBAm/2/R8P3CclcyyAaLSkqEae8IwTiYXDD7hrN5xmtoAJ+Ntv0HXFrOlK8Cp
 fVwAyWI2rsuEfX+RYcU/X3yVyBE52+e7OaQoKwpbRH3PCArFs+JxB5874jfPwGy5912R8NyyRHb
 EfiD7MvxsPvy/e8FJraOCwARaiAqZkV3sjXwHttEYGlDGIomx37QM9Cxk7vh5V5PB6WoAC26q7y
 /bBvyGNZmFKBkdoSY/RzQlnKus1TzS2QY+j5GGrdl77WgSADyCDCCw4YD0jXvxVfgQxff0nXd7G
 eY0isKLPtxYsaSIeX/xH3Gx0V8gjcOefHcYlSM1y3S6UBYHbzHjk=
X-Received: by 2002:ac8:5812:0:b0:51c:7b12:5fde with SMTP id
 d75a77b69052e-5283dfdd4e4mr22431961cf.74.1784806558924; 
 Thu, 23 Jul 2026 04:35:58 -0700 (PDT)
X-Received: by 2002:ac8:5812:0:b0:51c:7b12:5fde with SMTP id
 d75a77b69052e-5283dfdd4e4mr22431451cf.74.1784806558356; 
 Thu, 23 Jul 2026 04:35:58 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a63fa41sm157661405e9.14.2026.07.23.04.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 04:35:57 -0700 (PDT)
Message-ID: <9882f9e7-5c05-4a76-95f0-eb8ae8366f62@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 13:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix memory leak in riscv_trigger_unrealize()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zeng Chi <zeng_chi911@163.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zengchi@kylinos.cn
References: <20260723095911.3951185-1-zeng_chi911@163.com>
 <0d68a8df-d742-497c-a59a-aab6cda454c5@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <0d68a8df-d742-497c-a59a-aab6cda454c5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oj8dlSsHWadTUsdOyfG7WNQbQV_y20EY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDExMyBTYWx0ZWRfX4sR09+TpvAO8
 OFy1zt3gyp5gaCZwnBElIxe12W1lSChGG7Jrp72rIoZG9Sb/lNF++9m5um/93sI8CdXoNWY5HUc
 cHOJIY0F8PrqGgH4wAMFTt+AnGvi5XY=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a61fc9f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0p7LdH0Lr5XH2CsbspMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: oj8dlSsHWadTUsdOyfG7WNQbQV_y20EY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDExMyBTYWx0ZWRfX6Av4S38iamQ/
 CrdkrhB7I03RgbuP2Fll8vJwj4TqZRniHZJVsy4e4/1Y5fUT5YDumOGZYypkYuAdx3CQqZe7Tbd
 o5O4n5yMD+5dbY/3Iwjl/XQSmomRJFTNWq6/B+eGP/9A0GRcS1s84hS738+uhYYe9XjDeC4dZri
 thRuF4BzIiTb2j1Aq/zNij9yfcSmL1MKI9xJmbaB4/3BxwHQ1UwJioHDapJlQMck0CbSmA57IRu
 L7SVQf0fC329UNox/iIBA/TgV6LBqQupuGLOBl3Yot5WnJJm+wcGZj5brlXfwI9Q8F5RAmAxHrK
 4f6VM4x5dhsdf3d31PFuZKOrNqCJpgiLXqqmRyOkkxYraSfHsY3XoEtovys2vP+70SsInyzgrDY
 MStWJqpOIyRfWNaIb47ViX069SHRtzAv/l9tTpd1Wfhf3vfj4daw5u1QOYI5V6LSU8/McUd6+i3
 zDgCOZl2+1kWZ737T1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230113
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 23/7/26 13:12, Daniel Henrique Barboza wrote:
> 
> 
> On 7/23/2026 6:59 AM, Zeng Chi wrote:
>> From: Zeng Chi <zengchi@kylinos.cn>
>>
>> In riscv_trigger_unrealize(), the per-trigger QEMUTimer objects are
>> created in riscv_trigger_realize() using timer_new_ns().  However,
>> unrealize only calls timer_del() to cancel them, but never frees the
>> timer objects themselves. This results in a memory leak every time a
>> CPU instance is unrealized (e.g., during hot-unplug or machine teardown).
>>
>> Fix it by calling timer_free() for each timer after timer_del().
> 
> I made the assumption that timer_del() calls g_free() under the hood.  
> Seems
> like the best assumption is always to not make assumptions ...

Same, I always gets confused by that method. I once asked on IRC whether
to rename timer_del() to timer_cancel() or not but don't remember the
outcome of the discussion, I suppose there was a reason for not doing
the mechanical change, like "delete" is the appropriate action to cancel
a timer?

> 
>>
>> Fixes: 820552a92e32 ("target/riscv: dynamic alloc of debug trigger 
>> arrays")
>> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
>> ---
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
>>   target/riscv/tcg/debug.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
>> index 3c0fe70101..ffbdc17023 100644
>> --- a/target/riscv/tcg/debug.c
>> +++ b/target/riscv/tcg/debug.c
>> @@ -1081,6 +1081,7 @@ void riscv_trigger_unrealize(CPURISCVState *env)
>>       for (int i = 0; i < env->num_triggers; i++) {
>>           timer_del(env->itrigger_timer[i]);
>> +        timer_free(env->itrigger_timer[i]);

timer_free() also cancel/delete the timer. Could we simply replace
timer_del() -> timer_free()?

>>       }
>>       g_free(env->itrigger_timer);
>>   }
> 
> 


