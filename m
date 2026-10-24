Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77390606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dmbDjn4h;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ujov0RCJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVmZ-0006ys-QT; Sat, 24 Oct 2026 03:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKVmU-0006y8-Cg
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:03:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKVmS-00081G-OH
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:03:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2Bjii820125
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SdaCXhoZL27RkieLtPKWbr6u3llHXQP0Y1zWZvMtRBA=; b=dmbDjn4hoG6YH96x
 XqeB9kNMPT6Ffub1Zl6lvBJ7Ax22ZzEc3ekM5yit7Df0iZFzslA2Yhcel0vcZsmN
 MUqybxIgtNWAq+jnc2U1NxbAtIvImEFgpZmgnFXuCIiYgkoEZ5PYZvuka7d4fhJd
 ozcGkxHYU2yLyg3a7aUTH3up91B6KB/F5CAqCi/wm6uellPk9a3jtZEmN3m0vRs5
 k9GPVhvMAUntPqQZhEn2W199OY/l936355eguz5Cc10tWBFnTb/WGVJftauqPP1P
 ikbnFGtv59nqje4l0KzKXEKfTww+RyFdQeysTWszksd2VKkH4Iq2oYJM3KnUKSbZ
 cEBHBA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6gh8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:03:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5352436cd78so8985951cf.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792825383; x=1793430183; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdaCXhoZL27RkieLtPKWbr6u3llHXQP0Y1zWZvMtRBA=;
 b=Ujov0RCJFHHVhKCjLPOCjXNf6MUzR3ACQ8jFi7d8J6NG87u8Yf0lY9pvWlxcYD/IAe
 hQK6ldAaKe3Fh6ql0l+h80xPc/oj51H4ywsVvzyvaRJApM9ghwJtgQu0rQV1Hig1FjEN
 4OE4B684dnkBOtc1l22W3e6wPGLHskVqUY3UPyoeJK5DWx/zoCg9jzMhN9hbC6sO+TpI
 LInyCoFFY5U4YVXjWd+QL7wMM7M0GaG1FBBI5TErAghO2tO33lgn2z60Y+BJdCHU0RFw
 QP7Piby7Ma++9+kM2QW8E9DU2ZAJUh0vPqlfKeib6S7p+6qck9Od0hrI+uDxUkXS64lM
 2L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825383; x=1793430183;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdaCXhoZL27RkieLtPKWbr6u3llHXQP0Y1zWZvMtRBA=;
 b=X/zxzorHeqNeRnZYp6fWeOai/eCkwE2lTtPo9OC2B5CjhHD6LP/7YtMHu3QzYyISa0
 a6y6ke16ANxjshJQbpNG5T538oyT8b6hrfD/blQ16uNXUQaUTVBeUoXzfO5sPK2fGJat
 FJIyvTf+h/mGON85UDtJndE2wHT9yhLrgc7xOSc45miEiFMGJcyx57TC45iUIkFzewVa
 VnkeHOR53IB1CJhiqqZOzFTYtZbBt+9eOorKR0zDviicocmzObsrLre9z7aAMzfbMxVn
 iGlcFRdSrUCReNL3IWdn5P5sMKa6NoVDBNaAa5Z0TsWwzdz7gbZjqQjcnLP+vGD076rW
 G+hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZnJCaHzOgoPFwgpJYUNIkWRfLMmdZnR6/97rdT8t0bVKPQPygQ5u7EU7BFcyMAFzMNLJXU3wDBmpW@nongnu.org
X-Gm-Message-State: AFq9FYLLzcTlOxMgIfTC+HdK34DIyauW0uk+pICYKS+pWG1BrJ1i33pe
 a0mr/CZhpg5CT+siy6LiTi6xZOuKcUZDG1aKNcWBkGiAN5WutgVfpwt3pXftzRZ91Fa6lh6CQsM
 t3eUfNiENuLSAaCdXn0g92PZN/AjOB2M3OZ5F4DmTVvcQ4XiYN8Y31zApoA==
X-Gm-Gg: AYBFou3RodF8u4MmsXUXujuiUJiVhQhXjGhrvzOG+mS6rYl0LktoqqEgxv+J4EEufte
 clqZUte+YC1sMRAZ6v4N2x5bfv29XmjtaNWx6r2Dm0no2u8KsNuyaXBJ+krmZjUakeVDcfkMDQE
 k5qZDhwUAY3Ilg81vtU9n9To3a7BBVFxbG76rx4AToQh4406TryLDFPgDK8jzD396jAgElcPMpl
 SJJHdyPDeThOylPfO2VfEgMTIU1DyLRVsfvQkPlHgBIgvb6lQf7geBBLPG92XnDydbEGou4NYJ1
 ThzAFckatGavUhWpuWm5q8Z/nAc84jt3TU8OxnQoaD+z5oOQ807cB/HYXgbNBrPrmre3hvxk/tS
 5zPNa8Twl92ndHXupWDyOvRKZ1VuJPPs+bRmp
X-Received: by 2002:a05:622a:1aa0:b0:536:8bb4:2a83 with SMTP id
 d75a77b69052e-5383b64c96fmr16487421cf.74.1792825382568; 
 Sat, 24 Oct 2026 00:03:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa0:b0:536:8bb4:2a83 with SMTP id
 d75a77b69052e-5383b64c96fmr16487101cf.74.1792825382074; 
 Sat, 24 Oct 2026 00:03:02 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c54cbdsm14557836d6.26.2026.10.24.00.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 00:03:01 -0700 (PDT)
Message-ID: <b1e589f7-dc16-4898-85c8-c20e85c56df5@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 04:02:58 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv/csr.c: do not allow mstatus MPV/GVA
 writes
To: fangyu.yu@linux.alibaba.com
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com, liwei1518@gmail.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
References: <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
 <20261022120111.24298-1-fangyu.yu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022120111.24298-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6qEDNTlKonHzKarYa6fmSdqdO2_gQ3pF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNyBTYWx0ZWRfX2YjJEakAOl4f
 h3X4zu/d5eWcn+g4EN4ErXazhbLkQiKiWEJRKvSKsFLEf5lH0p8II4FBJsS+5hKqF27tQhVQj0C
 +5ILKzkDsXHNjZG0mqSfb3o5Uq5TIX0=
X-Proofpoint-GUID: 6qEDNTlKonHzKarYa6fmSdqdO2_gQ3pF
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adc5827 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=UDRo9PCKy471BPd3udMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNyBTYWx0ZWRfX9K4tX7O2Mi1O
 Ml+A3JHiuVuBQvyV/0L27KLPETbhqq4v5VexKTouxIHesZacJ01ehjY0NB9wk3nsLBmC0imL/FV
 Tm9BlBAzRf5raMynM7EA338WbV3QKi3GrsEG4mkF8jxLijxtMB2TFfPg2LPTZH3j2mn8kuh/CQN
 zsPbZL5Ef8FXlRzpk7BSUFlxVePxqpwUE0JSEQhvRsJk8Nel4hYWC/bQ6vc8JfsdupjDiLBO4DV
 eyOB4iwnk7cJ6FWMbsEd5UdP1Wjd0B+Fft67LH9f4EF/YCm4fC/2gysEMHc5sYnXKr4H2ZkZDm4
 /F03QlokBDwrjHirQA5fT9ZjMKUTyoAbLHO5bGli9ZDzrBuqx0+UR5+wpU0TVYltiwUY2/LEtuO
 5ZH+HykZ2qBRip8HwNPT7bfbdyVMtRHigTY4lrmhXKEbsUGIpCErR1toOs8eg9qdbzdVS9GMXjw
 S5p3Lm3HVIyKuYzuxbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240027
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

Hi!

On 10/22/2026 9:01 AM, fangyu.yu@linux.alibaba.com wrote:
>> The priv spec states the following about mstatus.MPV:
>>
>> "The MPV bit (Machine Previous Virtualization Mode) is written by the
>> implementation whenever a trap is taken into M-mode."
>>
>> And, about mstatus.GVA:
>>
>> "Field GVA (Guest Virtual Address) is written by the implementation
>> whenever a trap is taken into M-mode."
>>
>> Both are written during riscv_cpu_do_interrupt().  They're not supposed
>> to be written by userspace.  As far as write_mstatus goes these fields
>> are read only.  The same applies for mstatush.MPV/mstatush.GVA.
>>
>> Fixes: 03dd405dd5 ("target/riscv: Support MSTATUS.MPV/GVA only when RVH is enabled")
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>> target/riscv/csr.c | 5 +----
>> 1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index e1cd4a299c..74f5f868f0 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -2040,9 +2040,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>>      }
>>
>>      if (xl != MXL_RV32 || env->debugger) {
>> -        if (riscv_has_ext(env, RVH)) {
>> -            mask |= MSTATUS_MPV | MSTATUS_GVA;
>> -        }
> 
> Hi Daniel,
> 
> Could you share the motivation for making MPV/GVA read-only here? Was
> this based on a real misbehavior, or mainly on the spec wording.
> 
> I noticed that the current OpenSBI code modifies MPV in several places
> (sbi_hart_switch_mode, sbi_trap_redirect, sse_event_resume). With this
> patch, those writes are dropped.

I read the ISA again and couldn't justify what we did in that patch.  Unless
clearly stated in the ISA that "software can't write bit X"  we cannot make
assumptions about it just because says "hardware is writing bit X".

Thanks for bringing this up to our attention.  I just sent a revert.


Cheers,
Daniel



> 
> Thanks,
> Fangyu
> 
>>          if ((val & MSTATUS64_UXL) != 0) {
>>              mask |= MSTATUS64_UXL;
>>          }
>> @@ -2079,7 +2076,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
>>                                       target_ulong val, uintptr_t ra)
>> {
>>      uint64_t valh = (uint64_t)val << 32;
>> -    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
>> +    uint64_t mask = 0;
>>
>>      if (riscv_cpu_cfg(env)->ext_smdbltrp) {
>>          mask |= MSTATUS_MDT;
>> --
>> 2.43.0


