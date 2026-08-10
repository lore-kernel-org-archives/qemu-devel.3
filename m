Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D806C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtH05-0001Nq-0U; Sun, 09 Aug 2026 23:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtH03-0001Nh-DE
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 23:48:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtH01-0001xl-AZ
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 23:48:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LxCsf244309
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WaEcZHFJWhFkYjhZt3HLfyhvMSVpcHHP1Ige7NwpnHM=; b=F2Ssd3xQFzEE0RAL
 IrO26wESkWUglSMYEq1FabJXtNtYtUGN50v8a7ucA6xbEUH1ufMgYwF/3huv2DyL
 YLALV/qkRwSwMTgtpM4MIWnzIHFTaukB8Dk/cVzEVF1ra3VOkzlsTMlXuQPcQNDH
 YrYUj705ptckfNBeoRkLZ6lqIqC+4h4V8K7Pyltz0rymQaDLlU9yPthUmqGKTsAi
 efcSiz+zfmzCzU2rKGa5JJZbr6wR9xaWI+TDohSEDDSUwHJh9hB9XkbHCTIZYL11
 Tzxh77MJs2LtQuFZLqljb5rg6n97ghAZz//jnyTpKgMuA93r83NOneIbVb3pmkne
 DNvWfg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwudqmb2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:48:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so116566785a.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 20:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786333706; x=1786938506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WaEcZHFJWhFkYjhZt3HLfyhvMSVpcHHP1Ige7NwpnHM=;
 b=ipYSxvR0gFoWazOMm2CXkTgVel0yMnm8wKiOKI4Je0gEfE+dlZUcjgKKTMy7azFky8
 B00QU5qhxuS2PzsiAZ952k5MqHNDHagEhjesy324Z38tdD0DPhV11MeC47+xTCTqZ1eN
 1dbkzl0fhqHiwDxhUY0rQFUoQ7zdjaojo7FcIn0W9OC83hMG58CyALPxuK9Zs3Hq1SBz
 6ieVBdQN+pXanKpcuwfqhXAadvGtt3Hrssroi+3xzcOOauLDi+RYIKYAqIn3vKnIs3I1
 ++lUroY0byTXD8YPdgdLN/LItjWy7UfxRY4uTfiEasPHLQxN1Hj/bHiNw3ZmMoF8IJGK
 yTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786333706; x=1786938506;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WaEcZHFJWhFkYjhZt3HLfyhvMSVpcHHP1Ige7NwpnHM=;
 b=AHbvySR0IgCjYsb+nYeAqo88j8bpDRJuqPkV4WSf8uiCXVB52W4+JzjD1WZRsrmClK
 OeuSESi/Bu00dqpyL8IKO/TI+r3uZXvsO2IdF2tr5hjVdg7Xf2C/cTkiRRFQRIaOJs/k
 Ejj5xujf7/tzokghP4ocAU77SdNl6lrvuI6vQykDQC1sSU9mskRXhxriBQCTVZ2sxwC/
 uQ3BElHgvjucEDn2TXtsDu/Kl32/66XTP+L+wQSOupbBS211Qn9uBYLs+B/xgcI9IXMG
 MVI5LCSkkefIiznacnITlApF9yqcJpyGzCWFxdHzM5Mi4Ysk6w97s5udvPe95zWBuRBe
 Rv1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe8rwmzX/RDxLFHCgKcFIXOUHj3mdDccf9a65N6+uzyDbAMRE9165aCc4dORCxz0IprEt/sg5KFZwe@nongnu.org
X-Gm-Message-State: AOJu0YwnbjUSXG6G2U7qxGRPbCVqrlUNXZM8Q/bDBr7ZAK/EACdy788J
 +Q8Ie4u6JUeSSW5Zmr6gu3hhYSyCvqwB1ol8VbxYV/9SeAzPbBEfgMT4Ba8xGLpdRY2oQsF/LLw
 YVakWwa69EumiVlggPzh1Sr+N2T5WwDZWKGQYVpecSAJEu4UG2tWyk3vVow==
X-Gm-Gg: AR+sD12ZP7dQ8PLquhZ+lbxC3hvGNxnirjbNyvyBdsP+GzJYjB7Zrq6UM6v0XAQJlBr
 gUPwPw3h/M5CVIWbYGwk0HDcebBSlYP1MB8gwlhfVjkNZ6lq2KBJQHkSZaomn3Z6Z2JRlfKlL8f
 H7GeOwqQM5+xrSrpDaCe3Z4gX6/7fJvf/ZJ+SPnN9P0ltcTnu1FtmioyLSfE2DxC53TjpdZif5b
 XgNb3bahl/ipJCeZV8SBJJT+nfDhxRF6mwHRWoPUrj0TCd3S4Phn3TH+fzXnnkV0x7MKrzmxgxC
 NZULfB0BGd5iEfZsPJ1YzEXodZhEKkj1X2A2ROzQPtilrZfpodAw45PVNjG7mBKUYmlpSKDZ+Xe
 uc8GoajefXxfHPsUWOQQw0pOlp+/lHQrVLOUJN+XdkeFVo9mCB70x7Tmv2k22zFDPGAktYNtd7e
 7HM0Q+
X-Received: by 2002:a05:620a:1b89:b0:932:dfcf:6a4a with SMTP id
 af79cd13be357-93649133c0bmr4150897785a.33.1786333705660; 
 Sun, 09 Aug 2026 20:48:25 -0700 (PDT)
X-Received: by 2002:a05:620a:1b89:b0:932:dfcf:6a4a with SMTP id
 af79cd13be357-93649133c0bmr4150895285a.33.1786333705195; 
 Sun, 09 Aug 2026 20:48:25 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e22995fsm701093485a.29.2026.08.09.20.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 20:48:24 -0700 (PDT)
Message-ID: <17d59ae1-82f4-4af9-b0be-38d032840358@oss.qualcomm.com>
Date: Sun, 9 Aug 2026 22:48:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] hexagon: cpu_helper: add reg reading/writing
 helpers
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
 <b02e7a60814d97b1a259718daa3199f01dcac45b.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <b02e7a60814d97b1a259718daa3199f01dcac45b.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyOCBTYWx0ZWRfX+EcC++dcISeW
 lmhpT1hTWkH/8Wd7XFzE6HCA07DevfcZYX1/KHIapXjdORJEGu6opGBR4RrT5wLYEV+FGjpLugA
 b6C8UWz7fRXqPLgSwJZ2MWeNweYtvzk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyOCBTYWx0ZWRfX+2PRgjLvdFZm
 GJyZO1PlTmILmm6oDgYXFvuyvZ2WPoddXzgGll+vpg4G2vK5lxP/hSlvgl3Y0Ugh2DMqy59rWqM
 X4VqAZX6k39OV91hvddADlQgyijxDjxuypapU0SCA18WlTl608Zw6pGgdTu4uylKitf9VEZl2W2
 /rxnepChmgt6piAeqjED6iavRK5Mv7xaVUuS0ZWvFH7zNgptWiHRdEuXj1TeaLwyq5EHA+cKs2H
 VcPekNFEFqnbm7alivY9mfKom52Qr5utT+6fUUffUyrf7z0dHrLW24hMDOZ6wGfvioYPtB/M9Yb
 vFYG/qNgbethc+LkeJe3i4qL2WdcYwXFI0jKdcSnMTdV6c3I+vvR4MUldWEzaHiQ5b/JnzuaMBl
 d7g2jDKSWbN5g2/Y2pKv2D4J+XN3i8DfnttvBxJWcqoWdYW/sp1+gvhV4anJ6BuqBgHjGbP+4RN
 YzEymNwSm93nCQ8NZBg==
X-Authority-Analysis: v=2.4 cv=BNCDalQG c=1 sm=1 tr=0 ts=6a794a0a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=diOo0N7EqrpE0Udo_b4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: iWKONNWTexZo4vthZVHOy7cbl-SMT9zD
X-Proofpoint-GUID: iWKONNWTexZo4vthZVHOy7cbl-SMT9zD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 7/20/2026 12:41 PM, Matheus Tavares Bernardino wrote:
> And adjust op_helper to use those. They will also be used on upcoming
> semihosting commits.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---


I got rid of arch_{s,g}et_system_reg() from a previous series under 
advice from Taylor.  I think it's probably for the best. In our 
downstream fork we had a nest of functions and macros for accessing 
system registers and if we can avoid those we'll probably be better off.


https://lore.kernel.org/qemu-devel/017c01db9772$3f31b610$bd952230$@gmail.com/


>   target/hexagon/cpu_helper.h | 18 +++++++++++++++++
>   target/hexagon/cpu_helper.c | 40 +++++++++++++++++++++++++++++++++++++
>   target/hexagon/op_helper.c  | 18 ++---------------
>   3 files changed, 60 insertions(+), 16 deletions(-)
>
> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
> index ca2e13ab1d1..757a49fc4d4 100644
> --- a/target/hexagon/cpu_helper.h
> +++ b/target/hexagon/cpu_helper.h
> @@ -7,6 +7,24 @@
>   #ifndef HEXAGON_CPU_HELPER_H
>   #define HEXAGON_CPU_HELPER_H
>   
> +static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
> +                                       uint32_t val)
> +{
> +    g_assert(reg < TOTAL_PER_THREAD_REGS);
> +    env->gpr[reg] = val;
> +}
> +
> +static inline uint32_t arch_get_thread_reg(CPUHexagonState *env, uint32_t reg)
> +{
> +    g_assert(reg < TOTAL_PER_THREAD_REGS);
> +    return env->gpr[reg];
> +}
> +
> +void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val);
> +void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
> +                                uint32_t val);
> +uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
> +
>   void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
>                            void *retptr, uintptr_t retaddr);
>   void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index e981e11a35d..98ce599571e 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -27,6 +27,46 @@
>   
>   #ifndef CONFIG_USER_ONLY
>   
> +uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg)
> +{
> +    if (reg == HEX_SREG_PCYCLELO) {
> +        return hexagon_get_sys_pcycle_count_low(env);
> +    } else if (reg == HEX_SREG_PCYCLEHI) {
> +        return hexagon_get_sys_pcycle_count_high(env);
> +    }
> +
> +    g_assert(reg < NUM_SREGS);
> +    if (reg < HEX_SREG_GLB_START) {
> +        return env->t_sreg[reg];
> +    } else {
> +        HexagonCPU *cpu = env_archcpu(env);
> +        return hexagon_globalreg_read(cpu->globalregs, reg, env->threadId);
> +    }
> +}
> +
> +void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val)
> +{
> +    g_assert(reg < NUM_SREGS);
> +    if (reg < HEX_SREG_GLB_START) {
> +        env->t_sreg[reg] = val;
> +    } else {
> +        HexagonCPU *cpu = env_archcpu(env);
> +        hexagon_globalreg_write(cpu->globalregs, reg, val, env->threadId);
> +    }
> +}
> +
> +void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
> +                                uint32_t val)
> +{
> +    g_assert(reg < NUM_SREGS);
> +    if (reg < HEX_SREG_GLB_START) {
> +        env->t_sreg[reg] = val;
> +    } else {
> +        HexagonCPU *cpu = env_archcpu(env);
> +        hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
> +    }
> +}
> +
>   static bool hexagon_read_memory_small(CPUHexagonState *env, target_ulong addr,
>                                         int byte_count, unsigned char *dstbuf,
>                                         int mmu_idx, uintptr_t retaddr)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 3ce223caba3..324a9632dd4 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1846,28 +1846,14 @@ void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t imask)
>   void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
>   {
>       BQL_LOCK_GUARD();
> -    if (reg < HEX_SREG_GLB_START) {
> -        env->t_sreg[reg] = val;
> -    } else {
> -        HexagonCPU *cpu = env_archcpu(env);
> -        if (cpu->globalregs) {
> -            hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
> -        }
> -    }
> +    arch_set_system_reg_masked(env, reg, val);
>   }
>   
>   static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState *env,
>                                                       uint32_t reg)
>   {
> -    HexagonCPU *cpu;
> -
>       g_assert(bql_locked());
> -    if (reg < HEX_SREG_GLB_START) {
> -        return env->t_sreg[reg];
> -    }
> -    cpu = env_archcpu(env);
> -    return cpu->globalregs ?
> -        hexagon_globalreg_read(cpu->globalregs, reg, env->threadId) : 0;
> +    return arch_get_system_reg(env, reg);
>   }
>   
>   uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)

