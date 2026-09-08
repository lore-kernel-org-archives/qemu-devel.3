Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE723C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3u8F-0008MD-SX; Tue, 08 Sep 2026 07:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3u8E-0008LZ-DX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:36:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3u8C-0007FO-7C
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:36:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688ADR8a3235888
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 11:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zxrdnxfHj9oNG0R3pd5brAV5Flk6wKJD3rv6NiOdKKw=; b=Whsw2g7L1z7L3wDa
 XWLceXxm0ODzC8m3752vNlnav6d7wNPeMXdvJOteAhVoySbIVnS0iwK/senJ2s58
 ZOsR7cx5IwZL86IPNBytaxWANzRFeFXuvvU+bbb28coT0b8kW6wMwCnyK08hSF1D
 v7/rlMHtCyEe8TaldfaB/tiLUYsbBQAAegh5lR2tSee3W+e6/atjrweWZstpetDp
 qWxgZrV2z1/Ym745f8sfh0rU4qR0bS+r9JaVLbWfAyPGdVoGH+Yi8Rut4UtxLqb7
 MYAs49dan0syi5OiT/R1tBwTfCZx7k8EZ8JeCnRdpWt9s0yps2kB8RKFUhsDhJ3t
 dVZiOQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp48gcq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 11:36:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9394ad7f64aso697618985a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788867410; x=1789472210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zxrdnxfHj9oNG0R3pd5brAV5Flk6wKJD3rv6NiOdKKw=;
 b=V7wBMHGOyC5SRB3NJTLkqN3mW5m8k8PkSkA5+M+w7w67yNnPtBDbleqKtyJ2WmTKhF
 jfZmM+LOdjFR1Fyio48gLZsd8tga0x47xgWtDwMF4WiJcPpwVEtKsJAWAOBWct0d4lho
 1ytPgqLtJZ+C/A6YDPb4NPw+J+8o7HI4lg9dPi2TVJFBXLlAxi+p5keqP0hb/Y8pKFXV
 ZDTz02wW0+ksriVP+SLKABNQ8eKW8464LjnPXbVjcIGCTLYtu4kaOBqdH8lI+rbcuwdz
 NHNFuoxE5dGa7I7+ycut9rYMerfFOCrFSx0TMB5PdoG+4qi83tA/3IZCSS0mrvbl7iMm
 47Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788867410; x=1789472210;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zxrdnxfHj9oNG0R3pd5brAV5Flk6wKJD3rv6NiOdKKw=;
 b=i08e3Q7vH1V+jZB48WPfXcA6QJa4OAfyWRoRy1zBmMWNEoxvTmF+17ihb2i+TidpUV
 zIDJEcyIaVHYHTlyW5Rheubiz1SH18lKRnFroPtIHa0Yr8A21NAmC3Lp//az2Vr2x8Fo
 MYp66cTAl7th60dpnRVR+pXLc5s0yxQd/jkcRWVNGkWhqDKJvKTBEMs9r2QyOX+2r5Rs
 GhUS2nK7atClThWcS61Nw6i53pJMjBtWzHkZXhCTZ5yWhvIP+byXYer7C06nG2LEXGJZ
 p5jXyBK9Xzhk4nQTd05qCF7CGm2SqOWvEg6JyTK6DvDlAyWopAmXo5X2li469x7TGPd1
 zcMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/TTYkn1Z9yiLR+H6LtTsbZUIwiFK0cF0+KsOB0mWwuQk4Euz6kXY3x8GTdXkCDeQivg8DiGYH57E6@nongnu.org
X-Gm-Message-State: AFuF++nLD1Z/QkClwTmaHABxXpJIp5c+7tWg7TRJUJxjknvaUE0ns/He
 4VJ9emqOYhLfTvHP6PiGfV/bQLd1KaYJNaSbMn6XGkjAwpLhy3lko1hB77PiLW56iCzftnRxug8
 YwGhspUyu+6hN5kg1vAYoSX9OhgOVhCa5BiSs4xr1CgZjhkoYcXuR9OXQpQ==
X-Gm-Gg: AYBFou2bHAOxFN+tgCZNcn3iKyIZhDSLPSRNjeTav/l3LoWW8EIwPcP4wx+nbE98yP4
 BLrCyUTsGTF8tsL5lT9BXeudlM0Z9TS7YICdbk42F7Wu0iC+7AKlactdgCnDQjEv5v85M8G2Vct
 mjJpZSc4utLEL9RTA8F9HnCxkvFfOTgK62j/DGb6uTswsbF9+xNzFuTki5sTojKIr35FFywcf5u
 grwyVgCcDMTo+eMQO1zf3wB82/gqTTrPZpkLSNlZ3qeHYBi69UnkpInwS0QYzAadUrv1qbf4MoR
 FFdbfUS5yZLQpZtmbg7fQPIOxKIts5MYEYUSd1ikQlXjKK1tuOEZEsLthJcF+LcTbyXOZH7rYnZ
 dpTGCibkQ/I++nIPT4xeILrimNaz/NcUrwCWQ
X-Received: by 2002:a05:620a:8010:b0:939:bd4e:b2fd with SMTP id
 af79cd13be357-939bd4eb545mr435745085a.43.1788867409661; 
 Tue, 08 Sep 2026 04:36:49 -0700 (PDT)
X-Received: by 2002:a05:620a:8010:b0:939:bd4e:b2fd with SMTP id
 af79cd13be357-939bd4eb545mr435738785a.43.1788867409053; 
 Tue, 08 Sep 2026 04:36:49 -0700 (PDT)
Received: from [192.168.15.12] ([177.214.151.199])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397f9f0734sm1125395885a.4.2026.09.08.04.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 04:36:48 -0700 (PDT)
Message-ID: <4fb10e67-3286-4b0f-8b6f-989700767470@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 08:36:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/riscv: Preserve PMU state across event
 selector writes
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
 <20260907-riscv-pmu-correctness-v1-1-5f1f41458989@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907-riscv-pmu-correctness-v1-1-5f1f41458989@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6a9ff352 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=lJrVL2S40hk4Skp227i47g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=0sHDs-0P4d0gPBeefFwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: q_K90S_dXK2DiH_sdMsokx7L-Q8CLwu-
X-Proofpoint-GUID: q_K90S_dXK2DiH_sdMsokx7L-Q8CLwu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEyNCBTYWx0ZWRfX/dafVgXvLyZx
 jzVTXtOF46+0ZmHKTR8X2ySl4ZUcV7Yr/ri+9tsA2pFJfpuqISnu5bbUKooM/KtFkMaBj02/Heo
 61PvLC7zc7HwMthDxq24ZnPQLDjcN7jxVGzc8LKiYmFq+vdurGQk6WOK/HeBeqcTBoOAmNtW6/d
 6H0sp1ZyLPpIUL2RaAny4DJEJTFXlwzJEY5kGtg5P042jWOo8hCUTTKICO0Qtc8NqZrEVqnAxDR
 ilo7zxptZ01hFPaGss6m3UhSqazdEV+cS7JLkl9dzDfH2ila1yHHnG5u5BTWR7Xsh4+7crKuKlZ
 LCTCDfBebQItxysS/cy0V3PrDaRgVRfWIdNgFISAfdOQpPMOlz+MpAfolLEq2c5HEaXPkvT53a3
 A029kIaEB8flTITvi2B1i7IUmqynnyjZnU4MJDtqWN1A1n6Nt03wjYwq1pidHXVXkhcFVeb73TI
 Ys6smrfMx7W6uwBOepw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEyNCBTYWx0ZWRfX47OFjPyfA4Mg
 rMecQcSom6w6pZBz651CGT2oT9G1HK3azJ8872udbQ6WnCVwsAK1Gzw7ZmruZQpQZ4DyoMu3a4c
 1OvYAbVWI6cc5VjK31Q1nXnfoncJSKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080124
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/6/2026 1:37 PM, TANG Tiancheng wrote:
> Changing mhpmevent can lose pending cycle/instruction counts or leave a
> new fixed source without a baseline and overflow timer.
> 
> Account for the old source before replacing the selector, then establish
> the enabled counter's new baseline and timer. Apply this to direct and
> indirect writes.
> 
> Test overflow after initializing a counter with event zero and then
> selecting instructions.
> 
> Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/csr.c                    | 73 ++++++++++++++++++++++---------
>   tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
>   tests/tcg/riscv64/sscofpmf-overflow.S     | 60 +++++++++++++++++++++++++
>   3 files changed, 116 insertions(+), 21 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 65985efb220c80023cfd9d08e1878a19342aa879..52664a26f5a97a5dc8ff37abf99b4d10927fb120 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1209,23 +1209,58 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
>   static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>   {
> -    int evt_index = csrno - CSR_MCOUNTINHIBIT;
> +    int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
>       bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
>   
> -    *val = extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : 64);
> +    *val = extract64(env->mhpmevent_val[ctr_idx], 0, rv32 ? 32 : 64);
>   
>       return RISCV_EXCP_NONE;
>   }
>   
> +static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
> +                                                     int counter_idx);
> +
> +static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
> +                                      uint32_t ctr_idx, uint64_t value)
> +{
> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> +    bool enabled = !get_field(env->mcountinhibit, BIT(ctr_idx));
> +
> +    /*
> +     * A programmable counter backed by a fixed source uses mhpmcounter_val
> +     * as its base and mhpmcounter_prev as the source snapshot.  Preserve the
> +     * visible value before changing the source or its privilege filters.
> +     */
> +    if (enabled &&
> +        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> +        uint64_t source = riscv_pmu_ctr_get_fixed_counters_val(env,
> +                                                               ctr_idx);
> +
> +        counter->mhpmcounter_val += source - counter->mhpmcounter_prev;
> +    }
> +
> +    env->mhpmevent_val[ctr_idx] = value;
> +    riscv_pmu_update_event_map(env, value, ctr_idx);
> +
> +    if (enabled &&
> +        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> +        counter->mhpmcounter_prev =
> +            riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> +        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> +    }
> +}
> +
>   static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>                                         target_ulong val, uintptr_t ra)
>   {
> -    int evt_index = csrno - CSR_MCOUNTINHIBIT;
> +    int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
>       uint64_t mhpmevt_val;
>       uint64_t inh_avail_mask;
>   
>       if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
> +        mhpmevt_val = deposit64(env->mhpmevent_val[ctr_idx], 0, 32, val);
>       } else {
>           inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
>           inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
> @@ -1237,8 +1272,7 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>           mhpmevt_val = val & inh_avail_mask;
>       }
>   
> -    env->mhpmevent_val[evt_index] = mhpmevt_val;
> -    riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +    riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -1246,9 +1280,9 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>   static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>   {
> -    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
> +    int ctr_idx = csrno - CSR_MHPMEVENT3H + 3;
>   
> -    *val = extract64(env->mhpmevent_val[evt_index], 32, 32);
> +    *val = extract64(env->mhpmevent_val[ctr_idx], 32, 32);
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -1256,7 +1290,7 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
>   static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>                                          target_ulong val, uintptr_t ra)
>   {
> -    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
> +    int ctr_idx = csrno - CSR_MHPMEVENT3H + 3;
>       target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
>                                                     MHPMEVENTH_BIT_MINH);
>   
> @@ -1267,10 +1301,9 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>       inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                          riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
>   
> -    env->mhpmevent_val[evt_index] = deposit64(env->mhpmevent_val[evt_index],
> -                                              32, 32, val & inh_avail_mask);
> -
> -    riscv_pmu_update_event_map(env, env->mhpmevent_val[evt_index], evt_index);
> +    riscv_pmu_write_mhpmevent(env, ctr_idx,
> +                              deposit64(env->mhpmevent_val[ctr_idx], 32, 32,
> +                                        val & inh_avail_mask));
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -1512,11 +1545,11 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
>       return 0;
>   }
>   
> -static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
> +static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
>                               target_ulong *val, target_ulong new_val,
>                               uint64_t wr_mask)
>   {
> -    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
> +    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
>   
>       if (wr_mask != 0 && wr_mask != -1) {
>           return -EINVAL;
> @@ -1531,8 +1564,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
>           wr_mask &= ~MHPMEVENT_BIT_MINH;
>           /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
>           mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
> -        env->mhpmevent_val[evt_index] = mhpmevt_val;
> -        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
>       } else {
>           return -EINVAL;
>       }
> @@ -1540,11 +1572,11 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
>       return 0;
>   }
>   
> -static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
> +static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
>                                target_ulong *val, target_ulong new_val,
>                                target_ulong wr_mask)
>   {
> -    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
> +    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
>       uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
>   
>       if (wr_mask != 0 && wr_mask != -1) {
> @@ -1560,8 +1592,7 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
>           wr_mask &= ~MHPMEVENTH_BIT_MINH;
>           mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
>           mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
> -        env->mhpmevent_val[evt_index] = mhpmevt_val;
> -        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
>       } else {
>           return -EINVAL;
>       }
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index cd1ec0b8219bdb63dfe6a45bb9674fa22e62ee4e..97978c6707247bb786f41549ada69e12aab619ce 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -40,6 +40,10 @@ run-test-mcycle-rv32: test-mcycle-rv32
>   	$(call run-test, $<, \
>   	  $(QEMU) -cpu rv32 -icount shift=1 $(QEMU_OPTS)$<)
>   
> +TESTS += sscofpmf-overflow
> +run-sscofpmf-overflow: sscofpmf-overflow
> +	$(call run-test, $<, $(QEMU) -cpu max -icount shift=0 $(QEMU_OPTS)$<)
> +
>   EXTRA_RUNS += run-plugin-doubletrap
>   run-plugin-doubletrap: doubletrap
>   	$(call run-test, $<, \
> diff --git a/tests/tcg/riscv64/sscofpmf-overflow.S b/tests/tcg/riscv64/sscofpmf-overflow.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..587c7d3ec430aac984621dfb818f141088be7b23
> --- /dev/null
> +++ b/tests/tcg/riscv64/sscofpmf-overflow.S
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/* Program hpmcounter3 while no event is selected. */
> +	csrw	0x323, zero		/* mhpmevent3 */
> +	li	t0, -256
> +	csrw	0xb03, t0		/* mhpmcounter3 */
> +
> +	/* Start counting retired instructions with overflow enabled. */
> +	li	t0, 2
> +	csrw	0x323, t0
> +
> +	/* Cross the 64-bit unsigned overflow boundary. */
> +	.rept	1024
> +	nop
> +	.endr
> +
> +	/* OF must be sticky and LCOFIP must pend even with LCOFIE clear. */
> +	li	t4, 0
> +	csrr	t0, 0x323
> +	srli	t1, t0, 63
> +	xori	t1, t1, 1
> +	or	t4, t4, t1
> +
> +	csrr	t0, mip
> +	li	t1, 1 << 13
> +	and	t0, t0, t1
> +	sltu	t0, zero, t0
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
> +
> +	/* The counter wraps and continues counting after overflow. */
> +	csrr	t0, 0xb03
> +	li	t1, -256
> +	sltu	t0, t0, t1
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
> +
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	t4, 8(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence. */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16
> 


