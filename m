Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69630C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUhD-0001qM-J5; Tue, 18 Aug 2026 21:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUhC-0001pm-Az
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:02:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUh9-0004ma-8A
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:02:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkYoF2345549
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DkWI5EMoDmxDbLqISYkh9LUeJJUlOHmJvfOsigmvueA=; b=ns/zCeahfrLwad11
 ueRj2+ZWsfc2KThryjSwrQq0vzt79HQdr/RhtPgijGDYEMC6t5rue9WFPTDvHIjd
 XrocLIImmuFAxEcgKlh6jQujgpYgOkA1SaIvKK0QpZdXL5/f8ZRD4dEs3x1KAVJO
 gbPBGkMjZ/81yycH4gX3ZrhRBG9tunluU8VndToP+Nl5vSiiOoF+ExwS6IaBezPp
 J8YDr+xl0Pbx+dUaSC4vmYSBYJbMbVt1gETmhOZBQHKCX0juERMOaJKEDO/q/mtK
 m91dp513jlCkRZa/7H4nsDgTzNpZjWrgPRZ7lOFN4KoIo5ZZF5yoOg9+bJNpDQz5
 YFVqww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm8mem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:02:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93494527488so88347285a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787101335; x=1787706135; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DkWI5EMoDmxDbLqISYkh9LUeJJUlOHmJvfOsigmvueA=;
 b=j81l3PEFBaDLe2IHNR7ELWN0JvuOtPWaNyzP7BZYBPKo6QNwtmLpOg048jW2bX9Jbv
 56W6ealVJlEmYEsWT8gEWxwImRzYDdYBHBlq66JXTYvL6y5gdaCFkqE6uyKOJIs3cExP
 SVMVl4EdodUyGPWu+4yQ7Ya06u3SVw3jishxap56Q/qnLUHIh6a1r0WaN2hpTS6Ov8E6
 V819IwoRjk32AlBhJWvQQ+Kvy5BlJ8YQqxobq2scQXOZaPQ/W3dk08e/HMhaelCc1SZq
 sRRF2r4A0lexr9gli5y50rbeeDotney2hW+0/l4s95wbAzLAm19PeSsauhMwFNj9At/i
 bKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787101335; x=1787706135;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DkWI5EMoDmxDbLqISYkh9LUeJJUlOHmJvfOsigmvueA=;
 b=Wq/jURCqNgoDAY1XUx4wrfBtoW2zX2ZanQrS3IjMMxw1aD6a66KWj4EWp4SmlOvUpO
 rKkpGXn1NWMITGsHgOLLqb7mTu7PiKhjzbf9TX3hrRYmfalQSSTJcHoeL+rqM/5rBHZ7
 RWAqkrUgyXp0DTEun6hmRlt1BHDUj48al8ceCBLlFkIlHPcmn3ekjlAKQzNsMr4VZVll
 ADIa9s89GguNnK6J57ezR05ja8xxAY4tBqDCwa/rrTS2SovnXKtXCNOCx7P0iaammBGL
 qnsw6e17zu/1m6spNH5PA3aCwlzX2g9l41RB5TSlpKGEMetN//eok8PjLl7mZaETY+dx
 CXaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RowrhCjo8D0xyVTu1IobP4rzUcyN9cQVF5uDCmkud5n11ZAg8Q2zeWrcmvEaaRpJF9L6IeFlBcHnQMb@nongnu.org
X-Gm-Message-State: AOJu0Yy7xEAka3hWNL824Se8yBdwguOlzGaCKLyeWl+AgPIRPW3fnJ35
 8yY/KpwEiCG43CFhqUcdwqV8645ZlACgZDL8XYLS4qsVaQPtk3/TwwNxrF0nMv3zI5zZ6Q6ZQQI
 iqMGuqMjDp5SXc3MH4319RbDNs1SX8iZs7AwEu+1D+Jyar31l8l15/rqnow==
X-Gm-Gg: AR+sD11Cy+PYjKzcZxqiTDH2x4p1RNP5biNiQTihkb5bfv2nqGlwnp+8WEImfH3E0dU
 +1L1u3hnF12GA4x24QoC0OMKRQSaZjNarAkPe9ZQVp2O4G08UbMSeQ+w0ILeG8ueJT78/SglY/0
 zpw4jPMvOBXch0FXmj9Bv8C0QJ2YpDIwy5HQL0laKfD+Sm/mIjoH0ejq2emixxuGs3NNSbEX5fV
 gDze4Bz7WMEuTZFwB4dbaLNh5Qd/XeXUpElomyDL35ftNPKqqsIDyc9eihtDUWN54Rt116+Vijh
 UjHbqp57vkrnmnnwRJJ46Bd/g3TZbjjF0FDKXewrTlG3acx6iRcjk/NEykEEiOIpPD15A5uboUc
 BYSKQkqBk8Y0XeXyKL6KKKL/NYcmZWxjZwyY7bCEc
X-Received: by 2002:a05:620a:1b84:b0:936:e18d:763d with SMTP id
 af79cd13be357-9371e31cc97mr143085085a.8.1787101335097; 
 Tue, 18 Aug 2026 18:02:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1b84:b0:936:e18d:763d with SMTP id
 af79cd13be357-9371e31cc97mr143079985a.8.1787101334692; 
 Tue, 18 Aug 2026 18:02:14 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d05a6sm1437988f8f.35.2026.08.18.18.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 18:02:13 -0700 (PDT)
Message-ID: <0e6d8b87-1b26-48f5-a859-57d413f0d77a@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 03:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/28] target/hexagon: Implement wait helper
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Sid Manning <sid.manning@oss.qualcomm.com>
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@linaro.org, Brian Cain <bcain@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-6-brian.cain@oss.qualcomm.com>
 <f9ac74f3-46d9-4958-8635-8c61bff60921@oss.qualcomm.com>
 <210afbdc-ff9a-4743-95ce-1aeb1bf4b200@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <210afbdc-ff9a-4743-95ce-1aeb1bf4b200@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwNSBTYWx0ZWRfX+40pOvucsyaM
 NCdLI946PPdcre8iplkeFcT8jn8m5k8Mn4vvxPK9dnEKlJ8ysJrucyIMSy4vPCYMjbzVjgAGdHp
 /83nQ6ZDfGQR2TrrNlEj73CF5BNuz/M+Un4iMjnZrnatnDyGFm129vU8Gp7HMovwhl0lBclKPAZ
 fkP5sjTjASHxwbG7+1+kcmWpd/DRSzO1IEmbm/E4ATBMuZdxEChrKIWvUHdcwWPjboTV+CuSOmI
 a9DXEO5jPAIt7KzIt9uvmKE+hihxWUBs4YnWkFcsq/EI8gxQ9yawGf84KM3IV/9LIYeYlxhRJYj
 op3UNHrW0NnS6ZT9g0AXW10xR144zhZkolsB8Jt3zt0tao3uj4c13ulYrWau+WHjHngmHFGdkks
 aHNTmj4kGjBPyF7OH2QOcizfk8/RafU6I29kgJ2wdFsb7eFHVOLQPM9YeeBhwYe3pzC4v9ka0MD
 05tm2P1SO7i9XlgF01w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwNSBTYWx0ZWRfX1roB1+bqbKdn
 QYiMnEGUuRAvzrU4CRqQ29jTOAkEXlc1K191+WTBXeJjDDrl//CP14GI1SaQrr/7Ei56siF5Csw
 +lt+pShu0Wrb2J91CjmBl3V3dbwDG90=
X-Proofpoint-GUID: I1ZAH3BvGlNYwhKMEvuNleaFSR6erbW9
X-Proofpoint-ORIG-GUID: I1ZAH3BvGlNYwhKMEvuNleaFSR6erbW9
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a850098 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=nHPdCR_gnaD1jhISe9IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/8/26 21:47, Brian Cain wrote:
> 
> On 8/14/2026 12:29 PM, Philippe Mathieu-Daudé wrote:
>> Hi Brian, Taylor,
>>
>> (now committed as acd2b7a2f19ac04bd313e816e5f9e7f87adc9858)
>>
>> On 29/5/26 23:57, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/gen_tcg_sys.h |  2 +-
>>>   target/hexagon/op_helper.c   | 60 ++++++++++++++++++++++++++++++++++--
>>>   2 files changed, 59 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
>>> index 000fc415c74..98cf6216780 100644
>>> --- a/target/hexagon/gen_tcg_sys.h
>>> +++ b/target/hexagon/gen_tcg_sys.h
>>> @@ -80,7 +80,7 @@
>>>   #define fGEN_TCG_Y2_wait(SHORTCODE) \
>>>       do { \
>>>           RsV = RsV; \
>>> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt->pc)); \
>>> +        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
>>>       } while (0)
>>>     #define fGEN_TCG_Y2_resume(SHORTCODE) \
>>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>>> index 235c70f7370..d40061de06e 100644
>>> --- a/target/hexagon/op_helper.c
>>> +++ b/target/hexagon/op_helper.c
>>> @@ -1486,9 +1486,65 @@ void HELPER(stop)(CPUHexagonState *env)
>>>       hexagon_stop_thread(env);
>>>   }
>>>   -void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
>>> +static void set_wait_mode(CPUHexagonState *env)
>>>   {
>>> -    g_assert_not_reached();
>>> +    HexagonCPU *cpu;
>>> +    uint32_t modectl;
>>> +    uint32_t thread_wait_mask;
>>> +
>>> +    g_assert(bql_locked());
>>> +
>>> +    cpu = env_archcpu(env);
>>> +    if (!cpu->globalregs) {
>>> +        return;
>>> +    }
>>> +    modectl =
>>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
>>> +                               env->threadId);
>>> +    thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
>>> +    thread_wait_mask |= 0x1 << env->threadId;
>>> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, 
>>> thread_wait_mask);
>>> +}
>>> +
>>> +static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
>>> +{
>>> +    CPUState *cs;
>>> +
>>> +    g_assert(bql_locked());
>>> +
>>> +    if (qemu_loglevel_mask(LOG_GUEST_ERROR) &&
>>> +        (env->k0_lock_state != HEX_LOCK_UNLOCKED ||
>>> +         env->tlb_lock_state != HEX_LOCK_UNLOCKED)) {
>>> +        qemu_log("WARNING: executing wait() with acquired lock"
>>> +                 "may lead to deadlock\n");
>>> +    }
>>> +    g_assert(get_exe_mode(env) != HEX_EXE_MODE_WAIT);
>>> +
>>> +    cs = env_cpu(env);
>>> +    /*
>>> +     * The addtion of cpu_has_work is borrowed from arm's wfi helper
>>> +     * and is critical for our stability
>>
>> Could you explain this comment?
> 
> It's a note that was added to our downstream fork when fixing a bug 
> attributed to hexagon_wait_thread() that was a bit challenging to 
> uncover because none of our existing regression suite detected it.  It 
> was only uncovered in a "virtual platform" environment modeling the 
> various cores among the SoC.
> 
> We can follow up with a reword/clarification or deletion if you prefer.

But you recall the bug? Why isn't this an issue with RISCV?

No urgent need for cleanup, I'll likely rework this area in my
generic CPU scheduling work.

> 
>>
>>> +     */
>>> +    if ((cs->exception_index != HEX_EVENT_NONE) ||
>>> +        (cpu_has_work(cs))) {
>>> +        qemu_log_mask(CPU_LOG_INT,
>>> +            "%s: thread %" PRIu32 " skipping WAIT mode, have some 
>>> work\n",
>>> +            __func__, env->threadId);
>>> +        return;
>>> +    }
>>> +    set_wait_mode(env);
>>> +    env->wait_next_pc = PC + 4;
>>> +
>>> +    cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>>> +}
>>> +
>>> +void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
>>> +{
>>> +    BQL_LOCK_GUARD();
>>> +
>>> +    if (!fIN_DEBUG_MODE(env->threadId)) {
>>> +        hexagon_wait_thread(env, PC);
>>> +    }
>>>   }
>>>     void HELPER(resume)(CPUHexagonState *env, uint32_t mask)
>>
> 


