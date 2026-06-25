Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087EBCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wchSH-0003Ky-Iv; Thu, 25 Jun 2026 06:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wchSF-0003KT-GA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:37:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wchSD-00057q-Ll
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:37:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jsA82009320
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 10:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MZUMH+vxSZcEObYxO4IpOT2cwzk2xrnGaFHrz5b8v60=; b=BzpQRSXkeLQMZrci
 3zfkpUZ08awnUtU2vKHCBR89XvqSK+DVYlwsjM73GFvNRiksWTzkeIErhub5Pcnf
 Sf5ud5i2kPJxcYQXD33oIrBKW93Q8+AjpA8wvuqr3GLeBhmT/VwAxRLp/RZjSWHD
 MJDqAIaRfJCvJ/FtT/YkOBovn2ZnWmICMgQ9bzyTXnyKW8K3kzxwGvcUs8zYmvB4
 a/O4WdBSTv/zs96ezJTXr5/aStuDtGRmqS3LqooyEFTqW64z4rYVHMhweZWXPgWK
 E8E4pRM/XLtkbl6XrYqXqZEJB/4e+IsvOLS5SgZPUA0/YaLUko6fXyTJGO7BNDuj
 ktUc1Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmhs63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 10:37:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8de60a7a813so51449206d6.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782383823; x=1782988623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MZUMH+vxSZcEObYxO4IpOT2cwzk2xrnGaFHrz5b8v60=;
 b=HcDom7jBkAbsPOclqJIRHSQXnRkPx4/7wLck8NuaDyzFs7whfFNpnFyEaqRVRIoHkE
 HoMVBFA4C43fqksu8hz8bUKj4xXur6tC7DwMaHUGCezBqIFeGI1rWA8K4VuYAUOmIkUu
 WyTrYDzrPva68Dqux39AovleL5cvwdJgXFyz5LEPZthgN+oELKXlssWFE6Q8ZyPNTGa1
 hi0RRrZaR3rES00/jU4G8yOVcyaetrrjvMPSneLTzz2vmoAwEM1TueAJFPTcULXNl8h3
 7GVUykyfuR/CaT6c3po17UFuloa2uoBeaRbcLsaY4GG7ZIYVaqQBTjHpiqwbEdGieDgZ
 6zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782383823; x=1782988623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MZUMH+vxSZcEObYxO4IpOT2cwzk2xrnGaFHrz5b8v60=;
 b=UpkU3SG0KGOAgVDgBHEsxa0MBqrqo2aGBGJkB4EtGv7pl2mCm/AJ9zWR8CpwdvxVwt
 VNE3+e5n2N+1pE8C3bSIuT43A3enUs1S67QsBNr+HNLbCXEIC9/gbgrM3nth2rgnqo19
 cG19/s2I3K5Y/MfddqkCMqBDZQHZdFxsm4Tb5WAr64TDFE86ODIi89gWkg2arAgJHmlk
 tzhFpAUhZL1yN9aQx2ryZdwUtHRBDMdikim8kNoJDwmai+cBKrMd9z12kBiszuEFkVAQ
 /DS3t0OZHPwF7FO90xLL3vYawx8Vww2qziYZeXWO4h0TYT9XAmfDpxMDL+/gW6H8rk1r
 1RMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/snNUyB2JORGmvo4W99T63die2XOeF95GALxXdMtrh8FddvVoS/3soAOXFJfOmjb8clAjxbD37LKW1@nongnu.org
X-Gm-Message-State: AOJu0Yy518MHCtUStR/yRNR/05UgwI3FUpt9QoNp8PABf9/yq7veVzJk
 +kBnLEqtxPWGEVE73QgYKOwyvf+4PQzfopqf6X+ZAQizJGrnAHBHk5zRmyid2fAxz+D8QJ6h+AN
 gOC8/ODsofO+YbS9CLiIK3gVRXe18PrmkQgqDTV1p+l91A2D91r8xEJ3zmA==
X-Gm-Gg: AfdE7cl2UBNoYTreKNxlabl2atCJiicKuJucdkXqWD8kCrLGu8FfGhMseRMZjtfVYDF
 lu7VnGTXFrNs84f0WBMyMyXGg17GwpT6bqJ3kFQabQp5/9mrIBBOvVvaqX/omEl3YUHhNi7gmj3
 ryLqnWAIyaXqG2JA02F7AvqLfGem108otgciEYbweKR/nFxq05s1uwkeNDK3WC+nKTRzuDZG9RW
 xsIFXx5+GWOGP0e+ko59ltsqHs8/J6ujbf9Z7W2rv5J+ic+PhE/5rkUgapU/JH5CCPniTo/Vg7J
 1NwuHh83pq4wFLBwg7sTJFMqbn+9kINbetLcT4pdpzF+mkDTgzOMyc2HlM4B3tbO7UveYAm/bIv
 A/D/hX9t/etqestgtofgih3kdTPclfK9L/KFQLTxi6kb9g0i1btDNpkHN5GifIA==
X-Received: by 2002:a05:620a:46a0:b0:914:7e9a:2716 with SMTP id
 af79cd13be357-9293c506503mr270635285a.38.1782383823310; 
 Thu, 25 Jun 2026 03:37:03 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:914:7e9a:2716 with SMTP id
 af79cd13be357-9293c506503mr270631085a.38.1782383822848; 
 Thu, 25 Jun 2026 03:37:02 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b7d7sm14073249f8f.31.2026.06.25.03.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 03:37:02 -0700 (PDT)
Message-ID: <e217579b-50be-431d-8703-a19b3058f90b@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 12:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Content-Language: en-US
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
 <1fdb2816ac1592b4d08bc0060927bfeb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1fdb2816ac1592b4d08bc0060927bfeb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d04cf cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VnNF1IyMAAAA:8 a=yFRDIQdNgmOVVyJK8FYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfX2AqLvPXl3ehk
 o0L+a8r1k9nYRPBda7/Xgf3s2wZId2d8IflE1MQldeJIVWEi8VmAKw5rkYDcLL8r7Sn6A4Qbb2x
 /WaNaYKgzajnFXHa3XXV3abvaVfqm+MeF0Is1IlzwhRPaBuJmPCRGnb6lrbuDQPWfL1vJshbn1Y
 kn035ztxnRMQq3zmgrsOMnmDa4jcULWNmqy+o8iX2KaRZz19FKnLhCLdT7WeMRfBf3HvjH1SQuZ
 vl2sBxhA/+g4ZsixuTuB8lNI5wgIpEQWWI8NPYCXNBk125J1G1/fDWFw661ThvuAy4l0/UAyQdS
 H8GjeLXMhuEtq5FZLDG7G81sHqo5Bm4mdywsqzig9PUBmop3nLadMdWPuRmlhHrNhDNgY0OHL1R
 zXvNLsjxKuLvKbcoDFipqdTfgYyyN8riEdxEDNURIL98snTlzpoUvUmMR6KwYW7rFSZId00lzHp
 5T8jm0qTVv02ReIi43A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfX/f/nHRs0+kMw
 XzbAt5kHOJDoIVYzVkLW2prFpblmwVbCSDc60vFvialGTOxwglzMNQKD551129NTQQ70d60Tyrv
 GC+5Wvlvh6mT+Ui9xg3qfrJJpJa2ErI=
X-Proofpoint-GUID: GoXlTgm6i8NkfK1dfVVOtQlD8tFRg_TX
X-Proofpoint-ORIG-GUID: GoXlTgm6i8NkfK1dfVVOtQlD8tFRg_TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250090
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

On 25/6/26 09:31, Harald Freudenberger wrote:
> On 2026-06-24 12:05, Philippe Mathieu-Daudé wrote:
>> Hi Harald,
>>
>> On 24/6/26 10:09, Harald Freudenberger wrote:
>>> With the introduction of the address wrapping function
>>> wrap_address() the result can't be used to walk the
>>> source address any more. So introduce a new local variable
>>> to hold the wrapped address to avoid mixing source and
>>> wrapped address value.
>>>
>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>> argument")
>>
>> This commit merely added an argument. I suppose you meant
>> 9f17bfdab42 ("target/s390x: support SHA-512 extensions").
>>
> 
> No. Commit fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
> argument")
> introduces the mmu_idx with the wrap_address() function or macro.

You are saying the same, not really explaining, I'm not following...

> And the result was something like this:
> 
>    for (int i = 0; i < 8; i++, addr += 8) {
>      addr = wrap_address(env, addr);
>      a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>    }
> 
> This code reuses the addr variable in the loop
> by setting addr to the wrapped address but after
> that the loop adds +8 to this wrapped address.
> This code only works as long as the wrapped address
> is equal to the address put put in.
> Thus introduce another intermediate variable which
> holds the wrapped address:
> 
>    for (int i = 0; i < 8; i++, addr += 8) {
>      uint64_t _addr = wrap_address(env, addr);
>      a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>    }
> 
> Of course it would also work with a direct replacement:
> 
>    for (int i = 0; i < 8; i++, addr += 8) {
>      a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>    }
> 
> but this isn't that readable.
> 
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>> crypto_helper.c
>>> index ae392bce0e..29ad2aff43 100644
>>> --- a/target/s390x/tcg/crypto_helper.c
>>> +++ b/target/s390x/tcg/crypto_helper.c
>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>>> const int mmu_idx,
>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>>> mmu_idx);
>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>> -        addr = wrap_address(env, addr);
>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>> +        uint64_t _addr = wrap_address(env, addr);
>>
>> s/_addr/wa/ or even directly inline?
>>
>>            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>>
>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>       }
>>>   }
> 


