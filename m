Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1196AC98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA89w-0006pJ-KG; Fri, 25 Sep 2026 11:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA89h-0006jm-NH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:48:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA89d-0005c0-B7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:48:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PE10Mq756987
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pbe/UC4/CVPL7EJDekiEQApXlBRFtFsBqBmEbC+tB1A=; b=R8ZXEe2veSV56ojK
 6AKQdMo6NGfZj29/XlQauazoeHEYbaf685tVUYSB9JcSp5TZ0EppJr1zG7V+N9as
 P5t55aGyejhFvtjeH9pMKw/tOqZpRHXDcCmmhKILt9M+kUkkUPXTZx/lUyuAB7au
 N1W6ikEhMlMuiUJVSezd8YGoHBZoLcFxGdoXcQzYxXWp0hB7w8HgBfx0oKudM8rW
 LFeIN8AOrL517rEf+g8ddU11ZABeVK02vbjBIXtmYUOUO8RiNd7YfQP63I8zcW+e
 uZmACKJYGopM9fadQ06Pn1ohOZZhoK/SeZkXO19xERTz9KRlLF/yi/ehbafcF7Q5
 PtzqTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq0a22r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:48:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53001b668a6so29604881cf.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351283; x=1790956083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pbe/UC4/CVPL7EJDekiEQApXlBRFtFsBqBmEbC+tB1A=;
 b=aibABxrvwOb/NAgCrqyaY0SsDWHbHxABItIiTMu8fAWJjDSQ+1cnmkuJjq2tQ5C1+S
 OZfwRza1SzBfzIcQ2SnThRF+Wq4dVGdAk4bqt0fvXb9Q1u3BdnsTWnR0VSAL6qa34nuN
 NyDODhDtSZIPcI+IqILbRz88xA71k+mwLGcSkzMAwCEiiNnh3Pb8Brgjo7DFkFEhclrL
 +xhdEmY+DrfF2r73lbIcBiCccezpD2ozn87jvY/pDvWy0AMZ6QfebdLCOW4s7TnYXo40
 bWa+plBAEHA7d4jNCbb7qpd/dDarv+RQi4zVNR7a76MY6TLTAgqVBIlyiarUWBRktp5f
 XoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351283; x=1790956083;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pbe/UC4/CVPL7EJDekiEQApXlBRFtFsBqBmEbC+tB1A=;
 b=XDT1SUF4QfhGkuHXxJx/wAIptXyYovg//21XHMtMcaIBoxMj7jJAqzwso4hgeo1GiZ
 ATgwG194PrIshr+GWU22iE60j0uaW3AAGrEarkIps0iyOOmqoZIjYcVfS7bYq4Qb2O4r
 E0Ul/x4CPzJqYmVWxl3XZ+h92Mq+P+sdwVEURcNxLNG8ZxfYdfWgbyaD7dqi4TmvkYJD
 NuIh1seC/Jlp4zFAwupw1sEh8Iz9LWUHNQRJNbWYch+bVS/PXw7sSeKBg4OMrjAsTyUu
 o5olHUPoT6ZRNuXpPMC0cm1p0s5MUYbarGmLnYVWzosTochEhPehCv04numI1KHc+y+c
 9XzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1I8/B93WYDB1efsNvYYGEHSqxXrYeJcxxBCAZBJ6RnCN/ccqIIUWSq2oT2YGm9AYOeJ7M4i+2PRKZ@nongnu.org
X-Gm-Message-State: AFuF++l7tENjaOyG1vjbmiMvip94wg0qPodVdecaV8J7heYT6ioQ1Itt
 lurrE1jO8Uesp3lspigdaRQobRIaAMZBBjPwpXjjE5wFKVmGRgnECGzeZfxOIzO4Ipi601pVSYR
 fp0Zi8DCR4I/eE/U3P+xQJdpimDaId1Jae4949VtTauY7XvCrJ3WKrf4IOpBOuLJabw==
X-Gm-Gg: AYBFou2VBypepF7s7R9m7P6Kh62Z6q02UKfE3m+zUCOUIp25JiZiUYskqOAas9WwTtr
 nTxmBP6b6x/joy50H7XincJ5LE3asFqPbCP8BJe2QynXXD4aTVEdxugQ+lBKfAtt7EsYRBj1iB6
 3nV7d71ssZp0AA4yzfaO9v5351w36PCXY0rYQ9hSn3UflA9udSmpHnOOGiR2Hnmx85RdpIRZ5I2
 877GNKFPRM2pUQIsR/ZHkrFr78oi80jyQVw6emE4TuaWM4gvGgvEJTRUh5z33nTfDMrBv1fCGon
 AoMUrsm4tTH17nz1tXotM+LQ+qhsXloDHp/s0VQHjeqHLP82t66JXNsBURmOXM+V1YQG8z56A6q
 2vwmyAaGAmVmM2U6b07NmbE+A02uTK5uaGw==
X-Received: by 2002:a05:622a:17c4:b0:52f:c0f4:8 with SMTP id
 d75a77b69052e-5330dd106acmr46345531cf.40.1790351282568; 
 Fri, 25 Sep 2026 08:48:02 -0700 (PDT)
X-Received: by 2002:a05:622a:17c4:b0:52f:c0f4:8 with SMTP id
 d75a77b69052e-5330dd106acmr46344581cf.40.1790351281584; 
 Fri, 25 Sep 2026 08:48:01 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5330beb3a6fsm17718631cf.9.2026.09.25.08.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 08:48:00 -0700 (PDT)
Message-ID: <f2ca028c-35c5-4aa0-a99d-daea27b51600@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 12:47:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] target/riscv: Preserve fixed counters across PMU
 state changes
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-7-5da5159a0c64@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910-riscv-pmu-correctness-v2-7-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MiBTYWx0ZWRfX4ku4ppzeX9ke
 /zDkeyWVRyZYVeuUo1G3o5ZZXNyIs1ng+IDnk9dFveQGWqMkb40OnY1bUlTOYlkNWTI/9YE1bdi
 8unQ9tPa9B5+rIq79hNpTSlEb0G+np0=
X-Proofpoint-GUID: EifflqYB3T_m2JZm5TAc25YTQcQzza8h
X-Proofpoint-ORIG-GUID: EifflqYB3T_m2JZm5TAc25YTQcQzza8h
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab697b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=ID6Dd6NAFtV04VqhsKIA:9
 a=APbav9yp40qIH8G8:21 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MiBTYWx0ZWRfX2zL78gtR5h4U
 InoN/PsXbKbsKTxDW/92uEzhgip0GRsQt1L823lGW5gJ1A2EoDW+yldUyeyaPJ4J+U2WCelFgT1
 /Y960AkS8xh3lih2a7Kk89r3XCspTeuuwxTcecRgGYiDZeGDXo3SLBcwnMMDIatCBkoLnUohMc3
 jj4DOA5r0QGgT/5cwqljSR57vU6o1xEuiXJq/ZbFTUiXt3bnm7NO/UW6/ugy916d278PeY6tPka
 pQjLS2O3WYdgrDRJVHdKMUw9E09e1B42Q1Bj9Mk0c2Ns5hr7AhraRBwUA+x5NgX9Z7XhV2sYXQ8
 DroXFGnc5zEUQmoWYQppDE3XW6MHE7R1Wtn7zV1MaSazYtHWWg5QEUsHDFF77aPlG8orQ0Zyxpl
 DLjdpDaenLMI0UB71oVsn73tBUwfxnZbU3l4hcTKtMZSv/AfZwmWbfc6doJHmz2eZedDNtgM1Kf
 6FLKp5MazkdV0kzEbcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250062
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



On 9/10/2026 11:39 AM, TANG Tiancheng wrote:
> mcycle/minstret and HPM cycle/instruction counters use a stored value plus
> the increment since a source baseline. Changing selectors, filters or
> inhibit bits before accounting for the old settings can lose counts or
> add inhibited time.
> 
> Take one snapshot, add the increments allowed by the old settings, apply
> the write and establish the new baseline from that snapshot. Share this
> sequence between direct and indirect CSR accesses.
> 
> Merge selector bits after accounting so low-half writes preserve OF set
> by a pending wrap; explicit high-half or RV64 writes can still clear it.
> Preserve full-width arithmetic for RV32 accesses and keep source baselines
> independent of written counter bits. Delegated writes must preserve
> machine MINH.
> 
> Test filter changes, RV32 counter halves and OF across partial selector
> writes.
> 
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.h                      |   8 +-
>   target/riscv/tcg/csr.c                  | 243 +++++--------------------
>   target/riscv/tcg/pmu.c                  | 309 +++++++++++++++++++++++++++-----
>   target/riscv/tcg/pmu.h                  |  18 +-
>   tests/tcg/riscv32/pmu-fixed-rv32.S      |  90 ++++++++++
>   tests/tcg/riscv32/sscofpmf-event-rv32.S |  99 ++++++++++
>   tests/tcg/riscv32/system/meson.build    |  14 ++
>   tests/tcg/riscv64/pmu-cycle-controls.S  |  80 +++++++++
>   tests/tcg/riscv64/system/meson.build    |   7 +
>   9 files changed, 622 insertions(+), 246 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c2138dbd4ba312a5cb17f0916bce64d6faad38a9..f7b1bfc9cf5069125bc22dc2674d8e67431c5970 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -240,6 +240,12 @@ typedef struct PMUCTRState {
>       uint64_t irq_overflow_left;
>   } PMUCTRState;
>   
> +typedef enum {
> +    RISCV_PMU_FIXED_DOMAIN_CYCLE,
> +    RISCV_PMU_FIXED_DOMAIN_INSTRET,
> +    RISCV_PMU_FIXED_DOMAIN_COUNT,
> +} RISCVPMUFixedDomain;
> +
>   typedef struct PMUFixedCtrState {
>       /* Track cycle and icount for each privilege mode */
>       uint64_t counter[4];
> @@ -465,7 +471,7 @@ struct CPUArchState {
>        */
>       uint64_t mhpmevent_val[RV_MAX_MHPMEVENTS];
>   
> -    PMUFixedCtrState pmu_fixed_ctrs[2];
> +    PMUFixedCtrState pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_COUNT];
>   
>       uint64_t sscratch;
>       uint64_t mscratch;
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index ec6cc6081cb1aa43dc8ee0755b1a4eba1b63350d..ac073e712a4ee3ddc5c97d40c6ac33c1539fc6e5 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1110,9 +1110,10 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
>                                         target_ulong val, uintptr_t ra)
>   {
>       uint64_t inh_avail_mask;
> +    uint64_t value;
>   
>       if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        env->mcyclecfg = deposit64(env->mcyclecfg, 0, 32, val);
> +        value = deposit64(env->mcyclecfg, 0, 32, val);
>       } else {
>           /* Set xINH fields if priv mode supported */
>           inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
> @@ -1122,8 +1123,9 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
>                              riscv_has_ext(env, RVU)) ? MCYCLECFG_BIT_VUINH : 0;
>           inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                              riscv_has_ext(env, RVS)) ? MCYCLECFG_BIT_VSINH : 0;
> -        env->mcyclecfg = val & inh_avail_mask;
> +        value = val & inh_avail_mask;
>       }
> +    riscv_pmu_write_ctr_cfg(env, 0, value);
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -1149,7 +1151,9 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
>       inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                          riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
>   
> -    env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, val & inh_avail_mask);
> +    riscv_pmu_write_ctr_cfg(env, 0,
> +                            deposit64(env->mcyclecfg, 32, 32,
> +                                      val & inh_avail_mask));
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -1165,9 +1169,10 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
>                                           target_ulong val, uintptr_t ra)
>   {
>       uint64_t inh_avail_mask;
> +    uint64_t value;
>   
>       if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        env->minstretcfg = deposit64(env->minstretcfg, 0, 32, val);
> +        value = deposit64(env->minstretcfg, 0, 32, val);
>       } else {
>           inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH;
>           inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UINH : 0;
> @@ -1176,8 +1181,9 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
>                              riscv_has_ext(env, RVU)) ? MINSTRETCFG_BIT_VUINH : 0;
>           inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                              riscv_has_ext(env, RVS)) ? MINSTRETCFG_BIT_VSINH : 0;
> -        env->minstretcfg = val & inh_avail_mask;
> +        value = val & inh_avail_mask;
>       }
> +    riscv_pmu_write_ctr_cfg(env, 2, value);
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -1201,8 +1207,9 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
>       inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                          riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH : 0;
>   
> -    env->minstretcfg = deposit64(env->minstretcfg, 32, 32,
> -                                 val & inh_avail_mask);
> +    riscv_pmu_write_ctr_cfg(env, 2,
> +                            deposit64(env->minstretcfg, 32, 32,
> +                                      val & inh_avail_mask));
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -1217,50 +1224,17 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
> -                                                     int counter_idx);
> -
> -static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
> -                                      uint32_t ctr_idx, uint64_t value)
> -{
> -    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> -    bool enabled = !get_field(env->mcountinhibit, BIT(ctr_idx));
> -
> -    /*
> -     * A programmable counter backed by a fixed source uses mhpmcounter_val
> -     * as its base and mhpmcounter_prev as the source snapshot.  Preserve the
> -     * visible value before changing the source or its privilege filters.
> -     */
> -    if (enabled &&
> -        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        uint64_t source = riscv_pmu_ctr_get_fixed_counters_val(env,
> -                                                               ctr_idx);
> -
> -        counter->mhpmcounter_val += source - counter->mhpmcounter_prev;
> -    }
> -
> -    env->mhpmevent_val[ctr_idx] = value;
> -    riscv_pmu_rebuild_event_map(env);
> -
> -    if (enabled &&
> -        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        counter->mhpmcounter_prev =
> -            riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> -        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> -    }
> -}
> -
>   static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>                                         target_ulong val, uintptr_t ra)
>   {
>       int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
>       uint64_t mhpmevt_val;
>       uint64_t inh_avail_mask;
> +    uint64_t wr_mask = UINT64_MAX;
>   
>       if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        mhpmevt_val = deposit64(env->mhpmevent_val[ctr_idx], 0, 32, val);
> +        mhpmevt_val = val;
> +        wr_mask = UINT32_MAX;
>       } else {
>           inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
>           inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
> @@ -1272,7 +1246,7 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>           mhpmevt_val = val & inh_avail_mask;
>       }
>   
> -    riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
> +    riscv_pmu_write_event(env, ctr_idx, mhpmevt_val, wr_mask);
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -1301,9 +1275,9 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>       inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                          riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
>   
> -    riscv_pmu_write_mhpmevent(env, ctr_idx,
> -                              deposit64(env->mhpmevent_val[ctr_idx], 32, 32,
> -                                        val & inh_avail_mask));
> +    riscv_pmu_write_event(env, ctr_idx,
> +                          (uint64_t)(val & inh_avail_mask) << 32,
> +                          MAKE_64BIT_MASK(32, 32));
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -1311,106 +1285,10 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>   static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
>                                                        int counter_idx)
>   {
> -    int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
> -    uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
> -    uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
> -    uint64_t curr_val = 0;
> -    uint64_t cfg_val = 0;
> -
> -    if (counter_idx == 0) {
> -        cfg_val = env->mcyclecfg;
> -    } else if (counter_idx == 2) {
> -        cfg_val = env->minstretcfg;
> -    } else {
> -        cfg_val = env->mhpmevent_val[counter_idx];
> -        cfg_val &= MHPMEVENT_FILTER_MASK;
> -    }
> -
> -    if (!cfg_val) {
> -        return riscv_pmu_read_fixed_source(env, inst);
> -    }
> -
> -    /* Update counter before reading. */
> -    riscv_pmu_update_fixed_ctrs(env, env->priv, env->virt_enabled);
> -
> -    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
> -        curr_val += counter_arr[PRV_M];
> -    }
> -
> -    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
> -        curr_val += counter_arr[PRV_S];
> -    }
> +    RISCVPMUFixedSnapshot snapshot;
>   
> -    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
> -        curr_val += counter_arr[PRV_U];
> -    }
> -
> -    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
> -        curr_val += counter_arr_virt[PRV_S];
> -    }
> -
> -    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
> -        curr_val += counter_arr_virt[PRV_U];
> -    }
> -
> -    return curr_val;
> -}
> -
> -static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
> -                                          uint32_t ctr_idx, RISCVMXL xl)
> -{
> -    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> -    bool rv32 = xl == MXL_RV32;
> -    int deposit_size = rv32 ? 32 : 64;
> -    uint64_t ctr;
> -
> -    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
> -        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> -        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
> -        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                             0, deposit_size, val);
> -        counter->mhpmcounter_prev = ctr;
> -        if (ctr_idx > 2) {
> -            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> -        }
> -     } else {
> -        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                             0, deposit_size, val);
> -        /* Other counters can keep incrementing from the given value */
> -        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
> -                                              0, deposit_size, val);
> -    }
> -
> -    return RISCV_EXCP_NONE;
> -}
> -
> -static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
> -                                          uint32_t ctr_idx)
> -{
> -    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> -    uint64_t ctr;
> -
> -    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
> -        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> -        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
> -        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                             32, 32, val);
> -        counter->mhpmcounter_prev = ctr;
> -        if (ctr_idx > 2) {
> -            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> -        }
> -    } else {
> -        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                             32, 32, val);
> -        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
> -                                              32, 32, val);
> -    }
> -
> -    return RISCV_EXCP_NONE;
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    return riscv_pmu_ctr_get_fixed_value(env, counter_idx, &snapshot);
>   }
>   
>   static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> @@ -1418,7 +1296,8 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>   {
>       int ctr_idx = csrno - CSR_MCYCLE;
>   
> -    return riscv_pmu_write_ctr(env, val, ctr_idx, riscv_cpu_mxl(env));
> +    riscv_pmu_write_counter(env, ctr_idx, val, false, riscv_cpu_mxl(env));
> +    return RISCV_EXCP_NONE;
>   }
>   
>   static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
> @@ -1426,7 +1305,8 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>   {
>       int ctr_idx = csrno - CSR_MCYCLEH;
>   
> -    return riscv_pmu_write_ctrh(env, val, ctr_idx);
> +    riscv_pmu_write_counter(env, ctr_idx, val, true, riscv_cpu_mxl(env));
> +    return RISCV_EXCP_NONE;
>   }
>   
>   RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> @@ -1515,7 +1395,7 @@ static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
>       if (!wr_mask && val) {
>           riscv_pmu_read_ctr(env, val, false, ctr_idx, env->xl);
>       } else if (wr_mask) {
> -        riscv_pmu_write_ctr(env, new_val, ctr_idx, env->xl);
> +        riscv_pmu_write_counter(env, ctr_idx, new_val, false, env->xl);
>       } else {
>           return -EINVAL;
>       }
> @@ -1534,7 +1414,7 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
>       if (!wr_mask && val) {
>           riscv_pmu_read_ctr(env, val, true, ctr_idx, env->xl);
>       } else if (wr_mask) {
> -        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
> +        riscv_pmu_write_counter(env, ctr_idx, new_val, true, env->xl);
>       } else {
>           return -EINVAL;
>       }
> @@ -1560,9 +1440,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
>           }
>       } else if (wr_mask) {
>           wr_mask &= ~MHPMEVENT_BIT_MINH;
> -        /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
> -        mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
> -        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
> +        riscv_pmu_write_event(env, ctr_idx, new_val, wr_mask);
>       } else {
>           return -EINVAL;
>       }
> @@ -1588,9 +1466,8 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
>           }
>       } else if (wr_mask) {
>           wr_mask &= ~MHPMEVENTH_BIT_MINH;
> -        mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
> -        mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
> -        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
> +        riscv_pmu_write_event(env, ctr_idx, (uint64_t)new_val << 32,
> +                              (uint64_t)wr_mask << 32);
>       } else {
>           return -EINVAL;
>       }
> @@ -1609,7 +1486,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
>       case 0:             /* CYCLECFG */
>           if (wr_mask) {
>               wr_mask &= ~MCYCLECFG_BIT_MINH;
> -            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
> +            riscv_pmu_write_ctr_cfg(env, 0,
> +                                    (new_val & wr_mask) |
> +                                    (env->mcyclecfg & ~wr_mask));
>           } else {
>               *val = env->mcyclecfg & ~MCYCLECFG_BIT_MINH;
>           }
> @@ -1617,8 +1496,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
>       case 2:             /* INSTRETCFG */
>           if (wr_mask) {
>               wr_mask &= ~MINSTRETCFG_BIT_MINH;
> -            env->minstretcfg = (new_val & wr_mask) |
> -                               (env->minstretcfg & ~wr_mask);
> +            riscv_pmu_write_ctr_cfg(env, 2,
> +                                    (new_val & wr_mask) |
> +                                    (env->minstretcfg & ~wr_mask));
>           } else {
>               *val = env->minstretcfg & ~MINSTRETCFG_BIT_MINH;
>           }
> @@ -1640,7 +1520,8 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
>           if (wr_mask) {
>               wr_mask &= ~MCYCLECFGH_BIT_MINH;
>               cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
> -            env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
> +            riscv_pmu_write_ctr_cfg(env, 0,
> +                                    deposit64(env->mcyclecfg, 32, 32, cfgh));
>           } else {
>               *val = cfgh & ~MCYCLECFGH_BIT_MINH;
>           }
> @@ -1650,7 +1531,8 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
>           if (wr_mask) {
>               wr_mask &= ~MINSTRETCFGH_BIT_MINH;
>               cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
> -            env->minstretcfg = deposit64(env->minstretcfg, 32, 32, cfgh);
> +            riscv_pmu_write_ctr_cfg(env, 2,
> +                                    deposit64(env->minstretcfg, 32, 32, cfgh));
>           } else {
>               *val = cfgh & ~MINSTRETCFGH_BIT_MINH;
>           }
> @@ -3089,44 +2971,7 @@ static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
>   static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
>                                             target_ulong val, uintptr_t ra)
>   {
> -    int cidx;
> -    PMUCTRState *counter;
> -    RISCVCPU *cpu = env_archcpu(env);
> -    uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
> -    target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
> -    uint64_t mhpmctr_val, prev_count, curr_count;
> -
> -    /* WARL register - disable unavailable counters; TM bit is always 0 */
> -    env->mcountinhibit = val & present_ctrs;
> -
> -    /* Check if any other counter is also monitoring cycles/instructions */
> -    for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> -        if (!(updated_ctrs & BIT(cidx)) ||
> -            (!riscv_pmu_ctr_monitor_cycles(env, cidx) &&
> -            !riscv_pmu_ctr_monitor_instructions(env, cidx))) {
> -            continue;
> -        }
> -
> -        counter = &env->pmu_ctrs[cidx];
> -
> -        if (!get_field(env->mcountinhibit, BIT(cidx))) {
> -            counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
> -
> -            if (cidx > 2) {
> -                riscv_pmu_setup_timer(env, counter->mhpmcounter_val, cidx);
> -            }
> -        } else {
> -            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
> -
> -            mhpmctr_val = counter->mhpmcounter_val;
> -            prev_count = counter->mhpmcounter_prev;
> -
> -            /* Adjust the counter for later reads. */
> -            mhpmctr_val = curr_count - prev_count + mhpmctr_val;
> -            counter->mhpmcounter_val = mhpmctr_val;
> -        }
> -    }
> -
> +    riscv_pmu_write_inhibit(env, val);
>       return RISCV_EXCP_NONE;
>   }
>   
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 54fff2ba49c1034d5fa6db1c7b19ff59003cd1e1..16942e53489cd5a2d2dd055fdffef07d04d59465 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -85,15 +85,27 @@ static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
>    * VM-elapsed ticks stop advancing while VM ticks are disabled.  Under
>    * icount, instruction events retain raw instruction-count units.
>    */
> -uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret)
> +static uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env,
> +                                            RISCVPMUFixedDomain domain)
>   {
> -    if (instret && icount_enabled()) {
> +    if (domain == RISCV_PMU_FIXED_DOMAIN_INSTRET && icount_enabled()) {
>           return icount_get_raw();
>       }
>   
> +    g_assert(domain == RISCV_PMU_FIXED_DOMAIN_CYCLE ||
> +             domain == RISCV_PMU_FIXED_DOMAIN_INSTRET);
>       return cpus_get_elapsed_ticks();
>   }
>   
> +void riscv_pmu_take_fixed_snapshot(CPURISCVState *env,
> +                                   RISCVPMUFixedSnapshot *snapshot)
> +{
> +    snapshot->cycle =
> +        riscv_pmu_read_fixed_source(env, RISCV_PMU_FIXED_DOMAIN_CYCLE);
> +    snapshot->instret =
> +        riscv_pmu_read_fixed_source(env, RISCV_PMU_FIXED_DOMAIN_INSTRET);
> +}
> +
>   /*
>    * Information needed to update counters:
>    *  new_priv, new_virt: To correctly save starting snapshot for the newly
> @@ -106,82 +118,289 @@ uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret)
>    *  env->priv and env->virt_enabled contain old priv and old virt and
>    *  new priv and new virt values are passed in as arguments.
>    */
> -static void riscv_pmu_icount_update_priv(CPURISCVState *env,
> -                                         privilege_mode_t newpriv,
> -                                         bool new_virt)
> +static void riscv_pmu_fixed_update_priv(CPURISCVState *env,
> +                                        privilege_mode_t newpriv,
> +                                        bool new_virt,
> +                                        RISCVPMUFixedDomain domain,
> +                                        uint64_t source)
>   {
> +    PMUFixedCtrState *fixed = &env->pmu_fixed_ctrs[domain];
>       uint64_t *snapshot_prev, *snapshot_new;
> -    uint64_t current_icount;
>       uint64_t *counter_arr;
>       uint64_t delta;
>   
> -    current_icount = riscv_pmu_read_fixed_source(env, true);
> -
>       if (env->virt_enabled) {
>           g_assert(env->priv <= PRV_S);
> -        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
> -        snapshot_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
> +        counter_arr = fixed->counter_virt;
> +        snapshot_prev = fixed->counter_virt_prev;
>       } else {
> -        counter_arr = env->pmu_fixed_ctrs[1].counter;
> -        snapshot_prev = env->pmu_fixed_ctrs[1].counter_prev;
> +        counter_arr = fixed->counter;
> +        snapshot_prev = fixed->counter_prev;
>       }
>   
>       if (new_virt) {
>           g_assert(newpriv <= PRV_S);
> -        snapshot_new = env->pmu_fixed_ctrs[1].counter_virt_prev;
> +        snapshot_new = fixed->counter_virt_prev;
>       } else {
> -        snapshot_new = env->pmu_fixed_ctrs[1].counter_prev;
> +        snapshot_new = fixed->counter_prev;
>       }
>   
> -     /*
> -      * new_priv can be same as env->priv. So we need to calculate
> -      * delta first before updating snapshot_new[new_priv].
> -      */
> -    delta = current_icount - snapshot_prev[env->priv];
> -    snapshot_new[newpriv] = current_icount;
> +    /*
> +     * new_priv can be same as env->priv. So we need to calculate
> +     * delta first before updating snapshot_new[new_priv].
> +     */
> +    delta = source - snapshot_prev[env->priv];
> +    snapshot_new[newpriv] = source;
>   
>       counter_arr[env->priv] += delta;
>   }
>   
> -static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
> -                                        privilege_mode_t newpriv,
> -                                        bool new_virt)
> +static void
> +riscv_pmu_update_fixed_ctrs_snapshot(CPURISCVState *env,
> +                                     privilege_mode_t newpriv, bool new_virt,
> +                                     const RISCVPMUFixedSnapshot *snapshot)
>   {
> -    uint64_t *snapshot_prev, *snapshot_new;
> -    uint64_t current_ticks;
> +    riscv_pmu_fixed_update_priv(env, newpriv, new_virt,
> +                                RISCV_PMU_FIXED_DOMAIN_CYCLE,
> +                                snapshot->cycle);
> +    riscv_pmu_fixed_update_priv(env, newpriv, new_virt,
> +                                RISCV_PMU_FIXED_DOMAIN_INSTRET,
> +                                snapshot->instret);
> +}
> +
> +void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
> +                                 privilege_mode_t newpriv,
> +                                 bool new_virt)
> +{
> +    RISCVPMUFixedSnapshot snapshot;
> +
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    riscv_pmu_update_fixed_ctrs_snapshot(env, newpriv, new_virt, &snapshot);
> +}
> +
> +uint64_t
> +riscv_pmu_ctr_get_fixed_value(CPURISCVState *env, uint32_t ctr_idx,
> +                              const RISCVPMUFixedSnapshot *snapshot)
> +{
> +    RISCVPMUFixedDomain domain;
> +    PMUFixedCtrState *fixed;
> +    uint64_t *counter_arr_virt;
>       uint64_t *counter_arr;
> -    uint64_t delta;
> +    uint64_t cfg;
> +    uint64_t value = 0;
>   
> -    current_ticks = riscv_pmu_read_fixed_source(env, false);
> +    if (riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        domain = RISCV_PMU_FIXED_DOMAIN_INSTRET;
> +    } else {
> +        domain = RISCV_PMU_FIXED_DOMAIN_CYCLE;
> +    }
>   
> -    if (env->virt_enabled) {
> -        g_assert(env->priv <= PRV_S);
> -        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
> -        snapshot_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    fixed = &env->pmu_fixed_ctrs[domain];
> +    counter_arr_virt = fixed->counter_virt;
> +    counter_arr = fixed->counter;
> +
> +    if (ctr_idx == 0) {
> +        cfg = env->mcyclecfg;
> +    } else if (ctr_idx == 2) {
> +        cfg = env->minstretcfg;
>       } else {
> -        counter_arr = env->pmu_fixed_ctrs[0].counter;
> -        snapshot_prev = env->pmu_fixed_ctrs[0].counter_prev;
> +        cfg = env->mhpmevent_val[ctr_idx] & MHPMEVENT_FILTER_MASK;
>       }
>   
> -    if (new_virt) {
> -        g_assert(newpriv <= PRV_S);
> -        snapshot_new = env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    if (!cfg) {
> +        return domain == RISCV_PMU_FIXED_DOMAIN_INSTRET ?
> +               snapshot->instret : snapshot->cycle;
> +    }
> +
> +    riscv_pmu_update_fixed_ctrs_snapshot(env, env->priv, env->virt_enabled,
> +                                         snapshot);
> +
> +    if (!(cfg & MCYCLECFG_BIT_MINH)) {
> +        value += counter_arr[PRV_M];
> +    }
> +    if (!(cfg & MCYCLECFG_BIT_SINH)) {
> +        value += counter_arr[PRV_S];
> +    }
> +    if (!(cfg & MCYCLECFG_BIT_UINH)) {
> +        value += counter_arr[PRV_U];
> +    }
> +    if (!(cfg & MCYCLECFG_BIT_VSINH)) {
> +        value += counter_arr_virt[PRV_S];
> +    }
> +    if (!(cfg & MCYCLECFG_BIT_VUINH)) {
> +        value += counter_arr_virt[PRV_U];
> +    }
> +
> +    return value;
> +}
> +
> +static bool riscv_pmu_fixed_ctr_selected(CPURISCVState *env,
> +                                         uint32_t ctr_idx)
> +{
> +    return riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> +           riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
> +}
> +
> +static bool riscv_pmu_fixed_ctr_enabled(CPURISCVState *env,
> +                                        uint32_t ctr_idx)
> +{
> +    return !(env->mcountinhibit & BIT(ctr_idx)) &&
> +           riscv_pmu_fixed_ctr_selected(env, ctr_idx);
> +}
> +
> +static bool riscv_pmu_fixed_ctr_running(CPURISCVState *env,
> +                                        uint32_t ctr_idx)
> +{
> +    return riscv_pmu_fixed_ctr_enabled(env, ctr_idx);
> +}
> +
> +static void riscv_pmu_set_overflow(CPURISCVState *env, uint32_t ctr_idx)
> +{
> +    if (ctr_idx < 3 || !riscv_cpu_cfg(env)->ext_sscofpmf ||
> +        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> +        return;
> +    }
> +
> +    env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> +    riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> +}
> +
> +/*
> + * Accumulate the delta from mhpmcounter_prev to the fixed source snapshot,
> + * then align mhpmcounter_prev with that snapshot.
> + */
> +static void
> +riscv_pmu_accumulate_fixed_delta(CPURISCVState *env, uint32_t ctr_idx,
> +                                 const RISCVPMUFixedSnapshot *snapshot)
> +{
> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> +    uint64_t source, delta, value;
> +
> +    g_assert(riscv_pmu_fixed_ctr_selected(env, ctr_idx));
> +
> +    source = riscv_pmu_ctr_get_fixed_value(env, ctr_idx, snapshot);
> +    delta = source - counter->mhpmcounter_prev;
> +    value = counter->mhpmcounter_val;
> +
> +    if (delta > UINT64_MAX - value) {
> +        riscv_pmu_set_overflow(env, ctr_idx);
> +    }
> +
> +    counter->mhpmcounter_val = value + delta;
> +    counter->mhpmcounter_prev = source;
> +}
> +
> +static void
> +riscv_pmu_set_fixed_baseline(CPURISCVState *env, uint32_t ctr_idx,
> +                             const RISCVPMUFixedSnapshot *snapshot)
> +{
> +    g_assert(riscv_pmu_fixed_ctr_selected(env, ctr_idx));
> +    env->pmu_ctrs[ctr_idx].mhpmcounter_prev =
> +        riscv_pmu_ctr_get_fixed_value(env, ctr_idx, snapshot);
> +}
> +
> +void riscv_pmu_write_ctr_cfg(CPURISCVState *env, uint32_t ctr_idx,
> +                             uint64_t value)
> +{
> +    RISCVPMUFixedSnapshot snapshot;
> +
> +    g_assert(ctr_idx == 0 || ctr_idx == 2);
> +
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> +        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
> +    }
> +    if (ctr_idx == 0) {
> +        env->mcyclecfg = value;
>       } else {
> -        snapshot_new = env->pmu_fixed_ctrs[0].counter_prev;
> +        env->minstretcfg = value;
> +    }
> +    if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
> +        riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
>       }
> +}
>   
> -    delta = current_ticks - snapshot_prev[env->priv];
> -    snapshot_new[newpriv] = current_ticks;
> +void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
> +                           uint64_t value, uint64_t wr_mask)
> +{
> +    RISCVPMUFixedSnapshot snapshot;
> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>   
> -    counter_arr[env->priv] += delta;
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> +        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
> +    }
> +    /* Accumulating the old source can set OF outside the written bits. */
> +    env->mhpmevent_val[ctr_idx] = (value & wr_mask) |
> +                                (env->mhpmevent_val[ctr_idx] & ~wr_mask);
> +    riscv_pmu_rebuild_event_map(env);
> +    if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
> +        riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
> +    }
> +
> +    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> +        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> +    }
>   }
>   
> -void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
> -                                 privilege_mode_t newpriv,
> -                                 bool new_virt)
> +void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
> +                             target_ulong value, bool upper_half, RISCVMXL xl)
> +{
> +    RISCVPMUFixedSnapshot snapshot;
> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> +    bool rv32 = xl == MXL_RV32;
> +    bool running;
> +    int start = upper_half ? 32 : 0;
> +    int length = rv32 ? 32 : 64;
> +
> +    g_assert(rv32 || !upper_half);
> +
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    running = riscv_pmu_fixed_ctr_running(env, ctr_idx);
> +    if (running) {
> +        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
> +    }
> +    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                         start, length, value);
> +    /* mhpmcounter_prev tracks the source, not the written counter value. */
> +    if (running && ctr_idx > 2) {
> +        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> +    }
> +}
> +
> +void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
>   {
> -    riscv_pmu_cycle_update_priv(env, newpriv, new_virt);
> -    riscv_pmu_icount_update_priv(env, newpriv, new_virt);
> +    RISCVCPU *cpu = env_archcpu(env);
> +    RISCVPMUFixedSnapshot snapshot;
> +    uint32_t present = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
> +    uint32_t old = env->mcountinhibit;
> +    uint32_t changed = (old ^ value) & present;
> +    uint32_t ctr_idx;
> +
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    for (ctr_idx = 0; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
> +        if ((changed & BIT(ctr_idx)) && !(old & BIT(ctr_idx)) &&
> +            riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> +            riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
> +        }
> +    }
> +
> +    env->mcountinhibit = value & present;
> +
> +    for (ctr_idx = 0; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
> +        if (!(changed & BIT(ctr_idx)) ||
> +            (env->mcountinhibit & BIT(ctr_idx))) {
> +            continue;
> +        }
> +
> +        if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
> +            riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
> +        }
> +        if (ctr_idx > 2 && riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> +            riscv_pmu_setup_timer(env, env->pmu_ctrs[ctr_idx].mhpmcounter_val,
> +                                  ctr_idx);
> +        }
> +    }
>   }
>   
>   void riscv_pmu_decr_instret(CPURISCVState *env)
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index bf2e8373474d471d914f8801c55d2f6ffbb5cdd3..1494fbc21f53137a90c1338f6ca8e3c3e750276a 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -22,11 +22,27 @@
>   #include "cpu.h"
>   #include "qapi/error.h"
>   
> +typedef struct RISCVPMUFixedSnapshot {
> +    uint64_t cycle;
> +    uint64_t instret;
> +} RISCVPMUFixedSnapshot;
> +
>   bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>                                           uint32_t target_ctr);
>   bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
>                                     uint32_t target_ctr);
> -uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret);
> +void riscv_pmu_take_fixed_snapshot(CPURISCVState *env,
> +                                   RISCVPMUFixedSnapshot *snapshot);
> +uint64_t riscv_pmu_ctr_get_fixed_value(CPURISCVState *env,
> +                                       uint32_t ctr_idx,
> +                                       const RISCVPMUFixedSnapshot *snapshot);
> +void riscv_pmu_write_ctr_cfg(CPURISCVState *env, uint32_t ctr_idx,
> +                             uint64_t value);
> +void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
> +                           uint64_t value, uint64_t wr_mask);
> +void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
> +                             target_ulong value, bool upper_half, RISCVMXL xl);
> +void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value);
>   void riscv_pmu_timer_cb(void *priv);
>   void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
>   void riscv_pmu_rebuild_event_map(CPURISCVState *env);
> diff --git a/tests/tcg/riscv32/pmu-fixed-rv32.S b/tests/tcg/riscv32/pmu-fixed-rv32.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..85917fe0caa40621d873be2a70426552bde975c3
> --- /dev/null
> +++ b/tests/tcg/riscv32/pmu-fixed-rv32.S
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/*
> +	 * Failure bits:
> +	 * 0: selecting cycles changes the initialized high half
> +	 * 1: a low-half write discards a carry into the visible high half
> +	 * 2: the high-half read does not match the value just written
> +	 */
> +	li	t4, 0
> +	csrw	mhpmevent3, zero
> +	csrw	mhpmcounter3, zero
> +	li	t0, 1
> +	csrw	mhpmcounter3h, t0
> +	li	t0, 1
> +	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
> +
> +	/* Starting the counter must preserve its initialized high half. */
> +	csrr	t0, hpmcounter3h
> +	li	t1, 1
> +	xor	t0, t0, t1
> +	sltu	t0, zero, t0
> +	or	t4, t4, t0
> +
> +	/*
> +	 * Start 256 cycles below 2 << 32.  With -icount shift=0, the
> +	 * following instructions carry into the visible high half.  A
> +	 * low-half write must replace only bits 31:0 and preserve that carry.
> +	 */
> +	csrw	mhpmevent3, zero
> +	li	t0, -256
> +	csrw	mhpmcounter3, t0
> +	li	t0, 1
> +	csrw	mhpmcounter3h, t0
> +	li	t0, 1
> +	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
> +	.rept	512
> +	nop
> +	.endr
> +	li	t0, 0x1234
> +	csrw	mhpmcounter3, t0
> +	csrr	t0, hpmcounter3h
> +	li	t1, 2
> +	xor	t0, t0, t1
> +	sltu	t0, zero, t0
> +	slli	t0, t0, 1
> +	or	t4, t4, t0
> +
> +	/*
> +	 * Restart with a small low half so no carry can affect this check.
> +	 * Writing 2 to the running counter's high half must read back as 2.
> +	 */
> +	csrw	mhpmevent3, zero
> +	li	t0, 0x1234
> +	csrw	mhpmcounter3, t0
> +	li	t0, 1
> +	csrw	mhpmcounter3h, t0
> +	li	t0, 1
> +	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
> +	li	t0, 2
> +	csrw	mhpmcounter3h, t0
> +	csrr	t0, hpmcounter3h
> +	li	t1, 2
> +	xor	t0, t0, t1
> +	sltu	t0, zero, t0
> +	slli	t0, t0, 2
> +	or	t4, t4, t0
> +
> +	la	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sw	t0, 0(a1)
> +	sw	t4, 4(a1)
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
> +	.space	8
> diff --git a/tests/tcg/riscv32/sscofpmf-event-rv32.S b/tests/tcg/riscv32/sscofpmf-event-rv32.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..0c769c5f6bea4350a197dd044e6959b28fc69700
> --- /dev/null
> +++ b/tests/tcg/riscv32/sscofpmf-event-rv32.S
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* CSR numbers for older assemblers. */
> +#define CSR_SISELECT         0x150
> +#define CSR_SIREG2           0x152
> +#define CSR_SIREG5           0x156
> +#define CSR_MENVCFGH         0x31a
> +#define CSR_MHPMEVENT3H      0x723
> +
> +/* Low-half selector writes preserve OF; high-half writes can clear it. */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.macro	check_selector_write low_csr, high_csr, first_failure
> +	li	t4, \first_failure
> +	li	t0, 8			/* mcountinhibit.HPM3 */
> +	csrs	mcountinhibit, t0
> +	li	t1, 1 << 29		/* SINH: still count in M-mode. */
> +	csrw	CSR_MHPMEVENT3H, t1		/* mhpmevent3h: OF is clear. */
> +	li	t1, 2			/* HW_INSTRUCTIONS */
> +	csrw	mhpmevent3, t1
> +	/* Set the counter to UINT64_MAX while inhibited. */
> +	li	t2, -1
> +	csrw	mhpmcounter3, t2
> +	csrw	mhpmcounter3h, t2
> +	li	t3, 1 << 13		/* mip.LCOFIP */
> +	csrc	mip, t3
> +
> +	/*
> +	 * With icount, this write accounts for the first increment after
> +	 * enabling HPM3. The counter wraps, setting OF. Updating bits 31:0
> +	 * must preserve both that OF and the existing SINH in bits 63:32.
> +	 */
> +	csrc	mcountinhibit, t0
> +	csrw	\low_csr, t1
> +	csrr	t2, CSR_MHPMEVENT3H
> +	li	t1, 0xa0000000		/* OF | SINH */
> +	bne	t1, t2, exit
> +	csrs	mcountinhibit, t0
> +
> +	li	t4, \first_failure + 1
> +	csrr	t2, mip
> +	and	t2, t2, t3
> +	beqz	t2, exit
> +
> +	/* Explicitly writing the high half must still be able to clear OF. */
> +	li	t4, \first_failure + 2
> +	li	t1, 1 << 29		/* Keep SINH, clear OF. */
> +	csrw	\high_csr, t1
> +	csrr	t2, CSR_MHPMEVENT3H
> +	bne	t1, t2, exit
> +
> +	/* The high-half write must not change the selected event. */
> +	li	t4, \first_failure + 3
> +	csrr	t2, mhpmevent3
> +	li	t1, 2
> +	bne	t1, t2, exit
> +	.endm
> +
> +	.text
> +	.global _start
> +_start:
> +	/* Unexpected exceptions report the check in progress. */
> +	li	t4, 9
> +	lla	t0, exit
> +	csrw	mtvec, t0
> +	li	t0, 1 << 28		/* menvcfgh.CDE */
> +	csrw	CSR_MENVCFGH, t0
> +	li	t0, 8
> +	csrw	mcounteren, t0		/* Delegate counter 3. */
> +	li	t0, 0x43
> +	csrw	CSR_SISELECT, t0		/* siselect: counter 3 */
> +
> +	/* Checks 1-4 use machine CSRs; checks 5-8 use delegated aliases. */
> +	/* mhpmevent3, mhpmevent3h */
> +	check_selector_write mhpmevent3, CSR_MHPMEVENT3H, 1
> +	check_selector_write CSR_SIREG2, CSR_SIREG5, 5	/* sireg2, sireg5 */
> +	li	t4, 0
> +
> +	.balign	4
> +exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sw	t0, 0(a1)
> +	sw	t4, 4(a1)
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
> +	.space	8
> diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
> index 800c754093e275cd25be7878a96a8c551f73dbce..37cabafcc2b71a50a2f2a35731456fe7eecf01ff 100644
> --- a/tests/tcg/riscv32/system/meson.build
> +++ b/tests/tcg/riscv32/system/meson.build
> @@ -22,6 +22,13 @@ tests += {
>     },
>   }
>   
> +tests += {
> +  'pmu-fixed-rv32.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
> +  },
> +}
> +
>   tests += {
>     'smcdeleg-minh-rv32.S': {
>       'cflags': cflags,
> @@ -43,6 +50,13 @@ tests += {
>     },
>   }
>   
> +tests += {
> +  'sscofpmf-event-rv32.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
> +  },
> +}
> +
>   if 'qemu-system-riscv32' in emulators
>     tcg_tests += {
>       'riscv32-softmmu': {
> diff --git a/tests/tcg/riscv64/pmu-cycle-controls.S b/tests/tcg/riscv64/pmu-cycle-controls.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..fdd14755f4d196dc2a3ec6c8b8540adc40b3a253
> --- /dev/null
> +++ b/tests/tcg/riscv64/pmu-cycle-controls.S
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* CSR number for older assemblers. */
> +#define CSR_MCYCLECFG        0x321
> +
> +/* Check cycle-counter behavior across filter and inhibit control writes. */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/*
> +	 * Failure bits:
> +	 * 0: enabling MINH discards the previously accumulated value
> +	 * 1: mcycle changes while M-mode is filtered
> +	 * 2: disabling MINH adds the filtered interval
> +	 * 3: mcycle does not resume after disabling MINH
> +	 */
> +	li	t4, 0
> +	csrw	mcountinhibit, zero
> +	csrw	CSR_MCYCLECFG, zero
> +
> +	/* Filtering M-mode must not discard the value accumulated so far. */
> +	csrr	s0, mcycle
> +	.rept	64
> +	nop
> +	.endr
> +	li	t0, 1
> +	slli	t0, t0, 62		/* MINH */
> +	csrw	CSR_MCYCLECFG, t0
> +	csrr	s1, mcycle
> +	sltu	t1, s0, s1
> +	xori	t1, t1, 1
> +	or	t4, t4, t1
> +	.rept	128
> +	nop
> +	.endr
> +	csrr	s2, mcycle
> +	xor	t1, s1, s2
> +	sltu	t1, zero, t1
> +	slli	t1, t1, 1
> +	or	t4, t4, t1
> +
> +	/* Removing the filter must not add the inhibited interval. */
> +	csrw	CSR_MCYCLECFG, zero
> +	csrr	s3, mcycle
> +	sub	t1, s3, s2
> +	li	t2, 64
> +	sltu	t1, t1, t2
> +	xori	t1, t1, 1
> +	slli	t1, t1, 2
> +	or	t4, t4, t1
> +	.rept	128
> +	nop
> +	.endr
> +	csrr	t1, mcycle
> +	sltu	t1, s3, t1
> +	xori	t1, t1, 1
> +	slli	t1, t1, 3
> +	or	t4, t4, t1
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
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index cfb868c45704e210e8fe951be0cbb752b589d51d..1dd0402631036d0d377bb90d7cb1da2bae34ead4 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -113,6 +113,13 @@ tests += {
>     },
>   }
>   
> +tests += {
> +  'pmu-cycle-controls.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
> +  },
> +}
> +
>   if 'qemu-system-riscv64' in emulators
>     tcg_tests += {
>       'riscv64-softmmu': {
> 


