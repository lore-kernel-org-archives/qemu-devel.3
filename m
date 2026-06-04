Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAC2CD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVAAx-00018N-73; Thu, 04 Jun 2026 11:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wVAAr-00015R-1o
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:40:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wVAAo-0008OE-9j
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:39:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654E0GXh141860
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 15:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ng/HlOfLezmtpGsLViei8P9NLX/8Ld0UaP334CUhozs=; b=CusH90UjUiat8XUg
 zAsQan2Nk6lEncnm2ee1+YOnj2zhMuSBR6TQ8Y/yYEZ66YGFbaV72qhnKVBp2k1H
 ivLFiVGBunyEsQUTbwrHuYCgI6E09vMvnOETj4EhQ+v+7N4TXqVFm0nNeu0aytkb
 w4RxdIk2HgN0zQg7sJltqbqFpt7mKBOWrpZFRUEXUB1a3Soim7fWlIyFiPFP+tdH
 Z55hxvmAfnmJ7JOQ/Xisoc0iRUOh85mHZosZLssv4FIRrW6erqVUfz229KeklnBt
 fxLCFThircErQHlfUNkMiATJh4h/EMhb4HaoNn7VDs4nvAhBc28bIRgnMyhXl4px
 HZDS5w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejyenb6cc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 15:39:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f1820babso1012441eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780587595; x=1781192395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ng/HlOfLezmtpGsLViei8P9NLX/8Ld0UaP334CUhozs=;
 b=JpAfiXu4c/P1ETSzXuW2fv3KrsoN0tVYGe9D8Ho8E5ak/Klz/PYFJuJx0JXyl7tN1I
 ek7Pq7DOo4sFTzas0pGlnsawZZyHpK8qecjgR7OMwzuGW7Hiindjb3E9McARC17EixKE
 9mhi83BSy9kv8gJMGJ/rlG+9CJc0Urv4sB81eZHvAbfNvPaxaFVzqB8LX1H/pdEnY3UA
 Y0MCEobuay54AoEVpsffRfq6BgBt4RVOX6pRp0L1fdGJGqRP5Dt1rc3Pn4CnOKJhpAz9
 jv3RNhwo070BAcujN4I8jd3ARcJqtzjPr3JGNBWRIb3uijCQUXwRdNF5pL+ENwL8R53g
 +dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587595; x=1781192395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ng/HlOfLezmtpGsLViei8P9NLX/8Ld0UaP334CUhozs=;
 b=XpBIXK4ndI4Cfmnx9mFhXpPm0LkDhaf5PpsBHx4aSIqnIFNTLmLTJnfARs9qgWNw+/
 26eFGJxKZpUpF7VH11hl6Wbu2BgYP6hVJBQuer1iKfybIM8N0AIMEIdYH/sXuqmkK/mj
 6JS91MQDgl5VKXBWxfMMVd8n/7c+siXuh85M5mdaFDpV+hW7rOgEYrCg4OgQwH1bs3jh
 RP7PG/Ggc0eqggNk7fxl5+9NhYDb5JdThkAVa6UbfC+dXXf3pKp++kDhNpucyqloSXCX
 1HzUeNW0b4osbXY9LyQxvvvGLZLqtTNfhBV/8sukfvGevaCwIrubFeNp7j9rx4vLmPv+
 Aung==
X-Forwarded-Encrypted: i=1;
 AFNElJ++PLEaFajGh3ComQwCmg2oODf2xcx4fnpWCufCL33kZIMOu4bYIrpYKL16Ks9M2+kldANfgQzdEHlj@nongnu.org
X-Gm-Message-State: AOJu0YwoVOteJtSQ61WLT3/2auqiryAkAfavvSOGI1Az6Hjj5C6ONA0j
 oFJYVxGxuzVdfxFJhhiO/78Ixj4b+JjIveyOneNvU/wEhNwF9WGPYnVtxRK7LFYwM/jFv+BzShO
 aaHZCdvLnGUj4msKltz9rvhyci8pkm21RfdTUUHQru3sFZEmGOuc+8qFCWA==
X-Gm-Gg: Acq92OFvy9qNJSOemBp0DqTrVBYmRGByP1w/xL0uNFYm0T6Tltx6jYVOlE7FRDsxN1Q
 Y8Mt/MEsN2z+XObBE1siIEHR9BQsr8pNVy4gmHLVz9PW6/s7gl6A4V//geFPfdE4cvL29HdfMut
 UBC4KsU2Sa5JZDjiT+Tx7WZWSy4UlD8lU1c8GzOWtyfK5RM/8tXheALLj6MKAiGU0Yn0Dt8iSxp
 T8BICTioFwWTrFDuww0Fllx/qPS5A357F6YQlYAhjVm5YvbYdHA4Dv8asdCrt4eTQ/AoZlvl/AE
 Gi8KbHXksXvmM3/OrpZaYJsTs38tsqKu09xlaNpWMDMAO1BWpe4RQWxYSL1jyiVYF4ntwahf6vf
 9NIvd/p4ZdbyPWHoe/uNhYYwc+Qd/sLuKnMS6u7bTClqiLTcF7uAre+1OytfxodvLJrnVMbNQgJ
 jyF6Le//mJNWjIwg==
X-Received: by 2002:a05:7300:2391:b0:2f2:6dde:df50 with SMTP id
 5a478bee46e88-3074fbc7eb5mr4704143eec.17.1780587595373; 
 Thu, 04 Jun 2026 08:39:55 -0700 (PDT)
X-Received: by 2002:a05:7300:2391:b0:2f2:6dde:df50 with SMTP id
 5a478bee46e88-3074fbc7eb5mr4704124eec.17.1780587594802; 
 Thu, 04 Jun 2026 08:39:54 -0700 (PDT)
Received: from [10.110.73.124] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm4831358eec.28.2026.06.04.08.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 08:39:54 -0700 (PDT)
Message-ID: <2c79c0cb-e989-4c06-9fb7-9fa49b30940b@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 08:39:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, jamin_lin@aspeedtech.com,
 komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, qemu-devel@nongnu.org
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
 <4696cf03-08ad-4de4-b782-4d5c253b2cef@kaod.org>
 <3a076897-ee9f-4422-8daf-ea44223eab59@oss.qualcomm.com>
 <6b932f59-7d34-4931-a68d-56e96030e67d@kaod.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <6b932f59-7d34-4931-a68d-56e96030e67d@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JaSMa0KV c=1 sm=1 tr=0 ts=6a219c4c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=aEx-WPjuRe2x_90x2xgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: hdkwkYii0TdyUP30esBquIkTCayxR8tv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1MiBTYWx0ZWRfXxk2iGmSqh6h2
 w9MHo7QZuj64EmqdWavbnA9Y9pZmCfNolwX3LcWpYmzxK83pfpdFelxWtZqXRJMXvp6eLWb3oIg
 AxUecSRjjPLTKl6TUAcY1b3OjWiCSuz645umpeWNBD5KZwfO4Ys63kd5+a1Ev40o95J96ucK3Io
 dq2PA+W548mCbAeQnyxu7fTsXeApRK0kMSYjHx64dVWKd3GBz+o6fEb3JZgBcPxBeTAlvbmr0bz
 b4x1dvXoAtpspcqjKCp10zFIKaaeswm2aLB+b2JfZOBX5CkASsyXCUq6rmtLy98AuQES96wGxyy
 PEfh/EXZ4Savq+S35yByzpjOU5wsWTN2sDoHczxBHuZPzpU3Ue57AgUCFR2SmG6Vms4ZfJ9ZX+b
 Lx7L+VTiwOTjiCvtfzlqdo9zBzjsb8hWzj+2qaTw3Xr5VYPcfmfLgJcgJAGRyc9yI8jsjAHwUDr
 r7+MTfsdJuNTqoVUXeA==
X-Proofpoint-GUID: hdkwkYii0TdyUP30esBquIkTCayxR8tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040152
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 6/4/2026 8:33 AM, Cédric Le Goater wrote:
> On 6/4/26 17:24, Jithu Joseph wrote:
>> On 6/4/2026 1:28 AM, Cédric Le Goater wrote:
>>> On 6/4/26 02:07, Jithu Joseph wrote:
>>>> This series corrects the DesignWare I3C controller's advertised CMD/data
>>>> FIFO depths and cleans up the misleading queue-capacity field names that
>>>> made the bug easy to overlook.
>>>>
>>
>> ...
>>>
>>>
>>> Jithu,
>>>
>>> When you sent this v2, you did as a thread reply to :
>>>
>>>    https://lore.kernel.org/qemu-devel/20260529014034.864722-1-jithu.joseph@oss.qualcomm.com/
>>>
>>> This confuses the b4 tool and, in consequence, Jamin's Reviewed-by
>>> is not collected it seems.
>>
>> Sorry Cédric that it broke your MAINTAINER flow ...
> 
> Well b4 isn't smart enough to grab the trailers on v2. Try it.
>

Yes I tried it, and I could see that b4 didn't pick the tags
 

>> (I used to follow similar threading while sending newer revisions in LKML a while back)
> 
> I would recommend  to start a new email thread for each respin else
> the newer version of a series is "hidden" under the previous thread.
> 

Noted will follow this for future patches

>>>
>>> Can you please resend as new thread ? If you can can collect Jamin's
>>> Reviewed-by trailers it would be nice.
>>
>> I just sent out v3 with Jaimin's tag here
>> https://lore.kernel.org/qemu-devel/20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com/
> 
> 
> Applied to
> 
>     https://github.com/legoater/qemu aspeed-next

Thanks

Jithu



