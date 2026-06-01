Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208FDCD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8h8-0000XZ-Ba; Mon, 01 Jun 2026 15:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8h6-0000Wr-Bp
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:53:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8h4-0001OW-Ho
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:53:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651Ed1vO1214120
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zqCsRD9VF6mxINBvzOl7Rc9aeCkfjhdFBCsLQgKsG2Q=; b=D+GszdymeCmJddwd
 gzPZohNa/ZhnVZPpTG8Ts159jU0qOFvKibxUwWkKXWAlKaUA74ll4HL9Z9S8/AMF
 2U7eFcssG2v48KOU439sIjnxM5y/H3m07bEi8htl75gh8fChy/6kpm0eht9llc7b
 mjyeQCV7smM9q2SKU9cAo5n0gd5CFpflxO3ntXX5XyK5NUqsXigzcY1czEWeu7sD
 j3B8JYOVfHO+PxaU987F6Q7lODs7RxcwpdsQySFlvzhr3yvPmdDiIsUX7vkdj7pP
 nPKl3DNXngY49MN812ysOTEFovq74SJX8Bo14hN/1/l4Buu/463Thru94frSna42
 rR6SzQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s9asgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:52:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so16833134eec.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780343579; x=1780948379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zqCsRD9VF6mxINBvzOl7Rc9aeCkfjhdFBCsLQgKsG2Q=;
 b=XvS0dmMHCfnmxt3/B2aWNAIBWYXE15bA14UG/C/n2E+442ExrF4rMNrxPgBV6O3CcF
 bUKWiFm9vZzPstDrbsU/evUBKsO3r0LJe/GMkafEtkXmIZYOVcYwQRtfpPldc4Hn361X
 Nhhht2jR06/2S/sGml5E5kTARKip5uRRuaTPAJkpUnhuPGfGyzKo86s56DTk2JhYk4pj
 bD2InmVFyi2ex8MK0mgakyYkc5Pbgb2T1I3K1Vl0dQpNIC4zCgT9581N5utSXBfwcBhc
 zJfN7g+AtoLy7M7XmH5El39VW2bg/OMmEd0jyS29x7unCN5cOZHJTJcwNOBMNk3FbonT
 q8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780343579; x=1780948379;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zqCsRD9VF6mxINBvzOl7Rc9aeCkfjhdFBCsLQgKsG2Q=;
 b=WdXxoozWL8B2rSS23lrbEDPTI29xPOmt6vU22TcBLi7l9+6e/tEskNkKYTI1hFVa9E
 ogBdkMviNJtD2h+C0JU0FCzcCbhwqB+5u28LgXaJ0/euFvmb7aI9ERsZHpn3EEE1ft7i
 +CjxsVlQX9EC8oACVNLB4CybFuxcjsp/UlCsgkCgNUJMTLuylmjvk5vmAiclS/mxY8SN
 xtpjtjT5efmKKBPOjTc9jIkRwcEKuDlLoTt/68jC6LnNqjvzH/K3qjsN91u1e3y3MWsg
 B+8fxht6F1WXOSq2zltbn70y0XtBUH9r1wGBOtDup/RUS6SCiSCgTVaN9RpI0n0tJMNZ
 ENvg==
X-Gm-Message-State: AOJu0YyBNgxUTATXN8JTr8ARuq5hNCkz4DhbLLAbyg/QOoreSe1Tvvms
 I7xrSMqQPNYU7uCBEgcHX4TU9ayXYg0DymIIhvwGzBs0XaSfJofdXisB6YHesZLqPKW8QEDt+zy
 TtCAna/1rm1CCCKzqD4+eUGHIWAYVQv8sgOF9yEp8pXQYdSodHL+HLr06og==
X-Gm-Gg: Acq92OGkrT7i3bAKfhta9RiD6XRFR8SB+OHJB14ko2I0tXL8zy7n+iTqV74RxawU/Gb
 EMqFDgk6M70VWyasadB21GByLJnziRJVhkRiarvGZUpz4wTEFO3dhpBpdkwdfOYNy5oEwAdQBQy
 7uBs33mKLogWw78zWlecK/y02WXPwpdYtBh0ic07mIYC7WYRID/Wx623HT1V6zrdrFlDolXzsth
 Am3NknlacktQndCa8BbhSoHZL/jmTr6dPTkKQLKRHG+TYo83Simw7gJ7L0tkNy8SvFgPv/XSUzd
 R5XuLVtDEtO+29zEE4QENDRQ+Z52gJByYaKvQjCOQKEXGlNsue2xu6MmlLDZWTG589HdxirDNQk
 NCensOaXwfZ6Gnudnv2kwOqwxruV6dBjtTNNkA+lInl4ikloPwuDKIx2TJ/7vwp9NGGkl66NNMA
 GET+/EvL/xQiSp1adY4HPXSXxt
X-Received: by 2002:a05:7300:ef83:b0:304:ba84:a0cc with SMTP id
 5a478bee46e88-304fa74682bmr5874967eec.33.1780343579027; 
 Mon, 01 Jun 2026 12:52:59 -0700 (PDT)
X-Received: by 2002:a05:7300:ef83:b0:304:ba84:a0cc with SMTP id
 5a478bee46e88-304fa74682bmr5874950eec.33.1780343578472; 
 Mon, 01 Jun 2026 12:52:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed563d09sm9451757eec.15.2026.06.01.12.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:52:57 -0700 (PDT)
Message-ID: <43722c1e-f2a1-4c99-80b9-eb139388c14a@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:52:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/28] target/hexagon: Implement setprio, resched
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@linaro.org, Brian Cain <bcain@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-16-brian.cain@oss.qualcomm.com>
 <1835eaa9-c9ca-45b7-a5de-3ac653aa535e@oss.qualcomm.com>
 <CAEqNhNbqCk0VJ=_pj4F3BNTXimA6G=voMcD3CieASCmOFOSYNQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAEqNhNbqCk0VJ=_pj4F3BNTXimA6G=voMcD3CieASCmOFOSYNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Tip4vZLqYnXyjcJoXmDnlb38FTBr0zl3
X-Proofpoint-GUID: Tip4vZLqYnXyjcJoXmDnlb38FTBr0zl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE5NCBTYWx0ZWRfX3SDCy1Dd9QmA
 VCLrQGKR6Gdt4rBilIGsfgCRF6eUSgALOH+DiW10dxLS6s0fL3qqMB/y02WJetpz+i1Hd0PEhkB
 OvF9rPIuxS2c625ciJeWwtoMDwymen82eLdfBT+5B8Va1WeN/j2HvHUlUKq4XR8IfhbUxJtxMl9
 zzUpIHZZW85T+GhDSvugW8/GsmjjmpwIpoW28vduCGrxSj1f0m/2GsJYfdRYu75P9D8YPRfdtVd
 ululHPSayNVNCDgdg8ev1a0twMmW2sFW4la6oXzr7KXAEXX/8SzMaUgg0gXX8CVrGN4RIo8hoxj
 M6T4NcAO4uhmTZfZcWvb7CzC2OxPdpjrwbSAJy7Dr/VsL4+PVLaqFwkre6zw8sSvOxroyVkY+Ar
 uy2gbHrnH86a/zOlQcR5SMSpOuCa8PUudygu5cI2Uj9LpJEp2mRIdfzMitpamvnc0mimOAyt1SD
 inn1VpqHRnB3Lo74jfQ==
X-Authority-Analysis: v=2.4 cv=Zo7d7d7G c=1 sm=1 tr=0 ts=6a1de31b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=jQXZ3lIEsd1yHNy0QlMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010194
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 6/1/2026 12:39 PM, Brian Cain wrote:
> On Mon, Jun 1, 2026 at 2:23 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 5/29/2026 2:57 PM, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> The hardware-assisted scheduler helps manage tasks on the run queue
>>> and interrupt steering.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>  target/hexagon/op_helper.c | 77 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 77 insertions(+)
>>>
>>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>>> index 64f1fb2043f..82062a2f802 100644
>>> --- a/target/hexagon/op_helper.c
>>> +++ b/target/hexagon/op_helper.c
>>> @@ -1589,6 +1589,64 @@ static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
>>>      cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>>>  }
>>>
>>> +static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
>>> +{
>>> +    uint32_t schedcfg;
>>> +    uint32_t schedcfg_en;
>>> +    int int_number;
>>> +    CPUState *cs;
>>> +    uint32_t lowest_th_prio = 0; /* 0 is highest prio */
>>> +    uint32_t bestwait_reg;
>>> +    uint32_t best_prio;
>>> +    HexagonCPU *cpu;
>>> +
>>> +    BQL_LOCK_GUARD();
>>> +    qemu_log_mask(CPU_LOG_INT, "%s: check resched\n", __func__);
>>> +    cpu = env_archcpu(env);
>>> +    schedcfg = cpu->globalregs ?
>>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SCHEDCFG,
>>> +                               env->threadId) : 0;
>>> +    schedcfg_en = GET_FIELD(SCHEDCFG_EN, schedcfg);
>>> +    int_number = GET_FIELD(SCHEDCFG_INTNO, schedcfg);
>>> +
>>> +    if (!schedcfg_en) {
>>> +        return;
>>> +    }
>>> +
>>
>> Is that really a noop in this case?
>> Or should it trigger an exception if sched is not enabled?
> 
> It's a noop, the scheduler has no effect when SCHEDCFG_EN is disabled.
>

Ok.

>>> +    CPU_FOREACH(cs) {
>>> +        HexagonCPU *thread = HEXAGON_CPU(cs);
>>> +        CPUHexagonState *thread_env = &(thread->env);
>>> +        uint32_t th_prio = GET_FIELD(
>>> +            STID_PRIO, thread_env->t_sreg[HEX_SREG_STID]);
>>> +        if (!hexagon_thread_is_enabled(thread_env)) {
>>> +            continue;
>>> +        }
>>> +
>>> +        lowest_th_prio = (lowest_th_prio > th_prio)
>>> +            ? lowest_th_prio
>>> +            : th_prio;
>>> +    }
>>> +
>>> +    bestwait_reg = cpu->globalregs ?
>>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_BESTWAIT,
>>> +                               env->threadId) : 0;
>>> +    best_prio = GET_FIELD(BESTWAIT_PRIO, bestwait_reg);
>>> +
>>> +    /*
>>> +     * If the lowest priority thread is lower priority than the
>>> +     * value in the BESTWAIT register, we must raise the reschedule
>>> +     * interrupt on the lowest priority thread.
>>> +     */
>>> +    if (lowest_th_prio > best_prio) {
>>> +        qemu_log_mask(CPU_LOG_INT,
>>> +                "%s: raising resched int %u,"
>>> +                " cur PC 0x%" PRIx32 "\n",
>>> +                __func__, (unsigned)int_number, env->gpr[HEX_REG_PC]);
>>> +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO, ~0);
>>> +        hex_raise_interrupts(env, 1 << int_number, CPU_INTERRUPT_SWI);
>>> +    }
>>> +}
>>> +
>>>  void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
>>>  {
>>>      BQL_LOCK_GUARD();
>>> @@ -1697,8 +1755,27 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
>>>      g_assert_not_reached();
>>>  }
>>>
>>> +/*
>>> + * setprio/resched - hardware-assisted scheduler helpers for managing
>>> + * the run queue and interrupt steering.
>>> + */
>>>  void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
>>>  {
>>> +    CPUState *cs;
>>> +
>>> +    BQL_LOCK_GUARD();
>>> +    CPU_FOREACH(cs) {
>>> +        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
>>> +        CPUHexagonState *found_env = &found_cpu->env;
>>> +        if (thread == found_env->threadId) {
>>> +            SET_SYSTEM_FIELD(found_env, HEX_SREG_STID, STID_PRIO, prio);
>>> +            qemu_log_mask(CPU_LOG_INT,
>>> +                          "%s: tid %" PRIu32 " prio = 0x%" PRIx32 "\n",
>>> +                          __func__, found_env->threadId, prio);
>>> +            resched(env);
>>> +            return;
>>> +        }
>>> +    }
>>>      g_assert_not_reached();
>>>  }
>>>
>>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


