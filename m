Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6410DEA3C21
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmDi-0001Eb-Iz; Thu, 09 Apr 2026 06:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wAmDG-00018u-Kw
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:02:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wAmDD-0006x9-Sn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:02:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639A0MXU3326658
 for <qemu-devel@nongnu.org>; Thu, 9 Apr 2026 10:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7/VYxByq+1TzffwEkxYswPtIjBrBCe4rTqciWVg+mq8=; b=PuelqURhdB+5j7gQ
 AH0DmvEpdi0nMF8n3sR+ZUxUW9ghcTt+U/1M5CPJOYnG/3cdPARQ3DSs2DF1qgD6
 o/PiAbmuo+c6Da9LNGSyMgcDIyh9QqidJiwz/9RwYk/3zA7f8PhOguFR5mEhyF+M
 vWIZFGxkpCCd9VHRo0zPR+WYZVh4zGpKRzVG8q7sZPBhjgxMlkad0d046XiNpPgF
 ZDBqYd2m0qGCsxxyuV/avM3WjHm5qZMsqWmXZLRKwJ4fcDWlitS6yBgUtKsQXdNN
 5QginXGjhPJRqh7PGV0IzQwmTcfGEZqVF/c93b0yLY7opQ+JITGfZOylTgXRYydS
 wRE1fA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddw9mtmmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:02:08 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-650119f2503so1234808d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775728927; x=1776333727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/VYxByq+1TzffwEkxYswPtIjBrBCe4rTqciWVg+mq8=;
 b=VJpXCJdRmEqTbGx8x4kMSLYO6UJVb28H2g8aldFeD0Kgs3PJPeGbgLEGCeoDJ0k/Gp
 kJ/9kDtKuIyunRaMgvfuVH+l9Ewa43i9+IT4ljWg1tcD57sI+G83PJEZn0tvPYNv6g7W
 X7eB/Eqy+VaNUE/gQLI+eQxQg1idMUT6rf7nEe0YTv782MjeXKaqPOrkG14WnPuSqElC
 yFbvnFidDNSz/59T9tckiJvyUW83d7Ya2QoRlUdwMiV4baaKTVCnSTtJaCFWaU8y8WqD
 UQEfxTQmYW+WBEL1U9bIcPoXXcglTRF1ngsz65AKLBQGh3xC8JGPGpx7RUzayUTeB1FI
 u+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728927; x=1776333727;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/VYxByq+1TzffwEkxYswPtIjBrBCe4rTqciWVg+mq8=;
 b=E+AnJlW5BjNqCo38XZo9TsVVAN003CHzKQht2kpO+LGjdY5b2XUmvDJJQX/QvDA/tj
 nusu3qFcZqynKJ5bvrh+mkhF/GMtpGg/rT1qxCFDqyI8nm3oRzVBT8yXro8CiOzhFjo+
 kVoP2tGk67G26UplQoDgJFOaWIHkpdHv4cQUrKEfPSwF6kdFcuiAsfkJM7tGpRjWzKmK
 F6Hm6MZQaol+PLtD9hQwmc6//qvm2CspD3884lHc9kh/u1PA1pwum3kdmJNmwG3uajbI
 B7qr2lrSK6dRDh6sS/8uMUoDl2NGmPgaIVcMgZO+bBKI8BsQU4nBrcnsd9So/HUYIuUL
 oIpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqhy3lUcn2lyzCdgUvm7neBTj6+fICCorrsr0FwEWJmAQc01uwE9H0R1wQhK9NY0oE15h+bMAeQmeE@nongnu.org
X-Gm-Message-State: AOJu0Yy1/xc55dkaQ5p0uCE+CVGMM+eAqc5yUYvihEu5BzDf41f6iqXU
 hCJ7rf2p2byIf0dgm6f0uZ4s8SJKWY7WO5MsrHyyPM984DdP+yTUwne4GZKdvp/WvKKB1mdyzWc
 d+XS5JegfVDo5eIwG0RNl8rGlmb5QSypyCZeuivZoMozbKONRqqxXyY2rGg==
X-Gm-Gg: AeBDieswmzDM5FDWvabkK2iZf76FNdjVFknZzfrdKKee7+SjwKRgbo9lKzSJwwcZQGE
 RffrsFEdC+XckvrWb+dVHwVE22GGeq+N+wcBt9nNlcKsicAzf/nuhuLbkE6a/+tLFLrKp87e+NU
 b5tnX7gy6teSC+yKN8HiiVIn2yCgRMAqrmjAv7nbrai71M53svJVyuRjA1EAORrVqAzxpb0CVBk
 2PMDgcUl+GAsU5+wxKUmurY7y5Ol3HjQCk4P14GfTcWkJ2w9KKeedGYGBUgsytHzp1/mT3lAxWw
 1otY2WqQOvv4mu/cxPbAzAvp7wTCgI00/Zhu1hAKR5g1mXiOMiCx7jLuNazK7/U6LAajJrH5zDK
 pSRaDeT/lnPZ7IbRRtRsrHUEWDm8wSFmddf46pmeB6QPBGfAw5KP5cSl4
X-Received: by 2002:a05:690e:120c:b0:650:367f:7f3a with SMTP id
 956f58d0204a3-651877da183mr2449377d50.53.1775728927222; 
 Thu, 09 Apr 2026 03:02:07 -0700 (PDT)
X-Received: by 2002:a05:690e:120c:b0:650:367f:7f3a with SMTP id
 956f58d0204a3-651877da183mr2449324d50.53.1775728926601; 
 Thu, 09 Apr 2026 03:02:06 -0700 (PDT)
Received: from [192.168.68.100] ([177.18.66.130])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d4b8ca0665sm1412285985a.3.2026.04.09.03.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 03:02:06 -0700 (PDT)
Message-ID: <cddf6647-c97c-423d-b63a-202a09e4cc43@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 07:02:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
To: Alistair Francis <alistair23@gmail.com>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
 <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
 <CAKmqyKOg=mtUisSTA5+e9Hy2drnqesEZQEEv3XRyEty6N7rPNQ@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKOg=mtUisSTA5+e9Hy2drnqesEZQEEv3XRyEty6N7rPNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cfPiaHDM c=1 sm=1 tr=0 ts=69d77920 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=Wg2i10Q8swPuJs8jTFC2sw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8
 a=nhjZdmiyYQxdf1z5FHIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: 2Bff_TVRoH4ATqe9bC28mGqePE7JqoJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA4OSBTYWx0ZWRfXxpqW//zloYjs
 8cr3QwMgEScezO2TBfKacTD6PuojWFLMkOVPE2araRkKQ95vwbqg/KZn8+N0H3MiSxdBYBCNm8s
 CPZ3MKJIDSMdFGs0TR99rzigGXhEH0UFdyXE124cVmlqVDB1V0NEJKy9Fy5l2t8RWaD3CUlNqH9
 u8voXTfnkNcJDAXSOJFxvFmGETIEDgxiFabUeUGU0jWQqz39yhVTP1MnW8CCGD6P4iRv+/nILKO
 zQcxGdT3Cka9LNPRY+7pcYkH8Yhs0Qn/yPAx2mUZ3tNHFqkAMvGS6C7TlWRh4BeN9DcIU3TlOpK
 Uqspml1p2utCHa4XYYXsJyYkDV0a64vDY9zdn2YbvyB90VVxiRw3odTD/H88VmIUATHCzU4toFg
 ja/r5AQ2il53dWnlnIBIpR69k7zfT4mseBHVO7wVl2d+nH6tqG71uHU5PfR4OUc4p7n/flk3WEx
 tsIAoWebG9AiRkly4gA==
X-Proofpoint-GUID: 2Bff_TVRoH4ATqe9bC28mGqePE7JqoJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/9/2026 2:38 AM, Alistair Francis wrote:
> On Tue, Apr 7, 2026 at 7:38 PM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> The RISC-V spec states:
>>>
>>> "For the purposes of memory protection, a failed SC.W may be treated
>>> like a store."
>>>
>>> So if the comparison in sc.w fails we should still check for alignment
>>> and do a probe access to check permissions.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
>>> Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
>>
>> Typo: "Resoves"
>>
>>
>> Also, IIRC the bug URL that automatically closes Gitlab issues when
>> merging the patch is on the format:
>>
>> "Resolves: https://gitlab.com/qemu-project/qemu/-/issues/(number)"
> 
> Interestingly trying to access
> 
> https://gitlab.com/qemu-project/qemu/-/issues/3196
> 
> takes me to
> 
> https://gitlab.com/qemu-project/qemu/-/work_items/3196
> 
> So I think Gitlab is changing from issues to work_items
> 
>>
>>
>> Maybe this URL with "work_items" also works, but even with the regular
>> URL Gitlab fails to autoclose the bug sometimes.  I suggest changing the
>> "work_items" to "issues" in all those URLs to be safe.
> 
> Maybe using "issues" is the problem?
> 
> I'm thinking of leaving these as-is, as issues seem to be replaced now.
> 
> I even see https://docs.gitlab.com/development/work_items/#migration-strategy
> and https://gitlab.com/groups/gitlab-org/-/work_items/6033 with more
> details on this

Seems like you're ahead of the curve then :D let's leave it as is and
see if the bug autocloses when the patches are merged.


Thanks,
Daniel

> 
> Alistair
> 
>>
>>
>> That said,
>>
>>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>    target/riscv/helper.h                   |  3 +++
>>>    target/riscv/op_helper.c                | 14 ++++++++++++++
>>>    target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
>>>    3 files changed, 23 insertions(+)
>>>
>>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>>> index b785456ee0..af6cfcfc27 100644
>>> --- a/target/riscv/helper.h
>>> +++ b/target/riscv/helper.h
>>> @@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>>>    #ifndef CONFIG_USER_ONLY
>>>    DEF_HELPER_1(ssamoswap_disabled, void, env)
>>>    #endif
>>> +
>>> +/* Zalrsc" SC write probe */
>>> +DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>>> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>>> index 6ccc127c30..b569366369 100644
>>> --- a/target/riscv/op_helper.c
>>> +++ b/target/riscv/op_helper.c
>>> @@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
>>>        /* We don't emulate the cache-hierarchy, so we're done. */
>>>    }
>>>
>>> +void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
>>> +                           target_ulong size)
>>> +{
>>> +    uintptr_t ra = GETPC();
>>> +    int mmu_idx = riscv_env_mmu_index(env, false);
>>> +
>>> +    if (addr & (size - 1)) {
>>> +        env->badaddr = addr;
>>> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
>>> +    }
>>> +
>>> +    probe_write(env, addr, size, mmu_idx, ra);
>>> +}
>>> +
>>>    #ifndef CONFIG_USER_ONLY
>>>
>>>    target_ulong helper_sret(CPURISCVState *env)
>>> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
>>> index a7a3278d24..62c0fe673d 100644
>>> --- a/target/riscv/insn_trans/trans_rva.c.inc
>>> +++ b/target/riscv/insn_trans/trans_rva.c.inc
>>> @@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
>>>         */
>>>        TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
>>>        tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
>>> +    /*
>>> +     * "For the purposes of memory protection, a failed SC.W may be treated
>>> +     * like a store." so let's check the write access permissions
>>> +     */
>>> +    gen_helper_sc_probe_write(tcg_env, src1,
>>> +                              tcg_constant_tl(memop_size(mop)));
>>>        gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
>>>
>>>        gen_set_label(l2);
>>


