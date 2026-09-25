Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B29C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8gP-00009E-Lo; Fri, 25 Sep 2026 12:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8gM-00008N-0y
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:21:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8gI-0000nQ-G7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:21:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0YY0170052
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xjpB+awvA9TFza8NcpbmEilDAAMXVMmFhXCE+KBKQXE=; b=Xh3NElQM21y6+GcS
 QoiIpp6aWhBrbsojy+QE7E2XnHeihhWHdNgzrBuoIUrj6YwV8byl+595xAKHsyHD
 tkoWGflmuPipAVbkVw6mJTW+FUXo+yW9Oddm7juhFTHhkKnzfbF9h9sviv7C75xA
 Gmktlhr5rZ+ht1CQU9QpmKR/vrCmFPUiGxH5ZJ/P0Kx0bKZrqsFnUB/YjdlnVbYg
 T3D6ME7WE2wj52Zm4tnP07e2jT2688Q39Mc0AtYTQrR+FawDCAuAFe0O/bhxnl3A
 yofBaJ+WSbZK9PgO3OUzIgetyNRkUJRbLVDD8oIr5Uy3TS7H6ZsArx0x6V/XODcX
 HvF1hQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm52c6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:21:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0c7126e7so187805885a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790353307; x=1790958107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xjpB+awvA9TFza8NcpbmEilDAAMXVMmFhXCE+KBKQXE=;
 b=Gkrzk9O12ybVb8Xguya5XOEM80ZyQHirTGDaA80GaHhSl0bwficJqHhHF6llNBG0xx
 p1Zx7Wjp374csp2TRTOK2SNeC2C5otw2fCmxLAv06ABRogpnosV84V8rkEE85ibnyUay
 HnyEbzL8m0X7/c/IJKkgKE35bFvN+5ZvpjaYq2VPN1lDXn2K98dC/YEDEncltB6w2sqV
 oLnbtZTKtdD6IKTI8PxGsGxUXxExGOwlgWkU/attSwoYLcG+fsTovSPPFRZblrt5j61b
 nDstVJsxKtyBe3/R+WNhyMOQEMMXgYHm+pd3FZraOJ/5kzh6cmz5uOW4qb848d0e4NSi
 NRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790353307; x=1790958107;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xjpB+awvA9TFza8NcpbmEilDAAMXVMmFhXCE+KBKQXE=;
 b=WYHkeLv0+HfbV9pJoF4eWL8eKypsnWqG1aIh042F3rJezsKEqqWXlHYZMJGOo5QPJv
 WLwubwK87XsHIyf3vzqEW5xxTwEPidS7vgBeZ9FCMROazOmYVeXmSS7IvUVP6O/mWHRD
 8KCp4YGX2ukXxNq8H+M/tzozbcAwb2sWH56VO3oEsB1SrKGyJBTdi4QAeFE2qI5KMGph
 1SGiqy/0tCmXpHcrsbRJILDnywR4IY3jueqsaEo1cfenuwTKx0gi4o3oc8mdumxDx/cj
 C1IKeoWs819aXRtA42qnuBMomlV3TJfncRGZiC5jwlgAAcB8UE0+OfOU6oQho+bqIS+G
 yeOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNpPXRbTz2Tf3Gpg8UIjRphU1eKLj8tILGwEl4yiG0mzsFJrsa/i9jTTT0/HqWbWBmdC3Dj+SixH1g@nongnu.org
X-Gm-Message-State: AFuF++kLIUSbwSyMK+o3fu106t5MkQYJ380xL8sWKPWyHM6jM5Tx3q2+
 r0TjTMm0SwN4993yI/DAn8CXScT8dFFtnjcqzaTUQtc8XcOivNxwE7o2P1wMwxEQ7tdLRS9vAXi
 qm/6OO66OMqslEVFyWUaJ2yfjtjamsiTgnGA1XNOVqR2LvPBN06q1pWvcfQ==
X-Gm-Gg: AYBFou1hUfkRnuA32CBcIxUvtLZPXE/do9f/SR89MuDD7h1d6rLlLFpNZMtVp6vP0oB
 hB+pMKW4OqHsnr2rienP0MY1HQBWoWH1BL+GsfYTgONPpIOfJ8NK3uJZd8CRUUAfSuzLnE7orsG
 acORDkX+i0x0n0I3nodFu6Tce5N/kb3FRjQ+GJiXqRPwBtyZSZ0Palcek7mlC3OMFYtP7KcvKZA
 Zgy4sPSubySDvn+/U7iDLwWplHOosS/4Wl5R3G2YlQij+qYI8fmynWnf/C0w7qqkCfKXO6yVStb
 veBG0/rFks2t+fcTVppzVffaGGdghkS4SuLD9zNAO7PbSxTMSyhjlCjjs5w7tMtepUsYWhab4Rh
 hJoJBVQKjXBVb7Zyeeowjz4c3kMkTHKtfTg==
X-Received: by 2002:a05:620a:690d:b0:93a:1048:7d2f with SMTP id
 af79cd13be357-93c43cd300bmr575134385a.41.1790353306677; 
 Fri, 25 Sep 2026 09:21:46 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:93a:1048:7d2f with SMTP id
 af79cd13be357-93c43cd300bmr575126185a.41.1790353305945; 
 Fri, 25 Sep 2026 09:21:45 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c449a35e9sm214343585a.47.2026.09.25.09.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:21:45 -0700 (PDT)
Message-ID: <325df496-bcb5-4cdc-804f-bc0865e974ab@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:21:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] target/riscv: Rebuild fixed-event PMU overflow
 deadlines
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-9-5da5159a0c64@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910-riscv-pmu-correctness-v2-9-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OQqGMkCutOjL0TRumxW_mk2PamBjxqqz
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab69f9c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=fkeg9SbLWd2IkRBRDDYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NSBTYWx0ZWRfX2ucdiRlMO68G
 UZy1na4FkZ9gAr5pB1eqSfBK86ugC1Ea2vXAxA17MvKjbIOa1FEimpczEdtrS6aY5YzEXzTVNML
 VkFRIlSkj6ClrmDb+BLEnzv9ed47R55CWMRyVLKlhncc21QcaIomILy7uu0KkaoixG42YG7jnNN
 +yfrDt+vTjVEllqo1bg6oBNE2N3nsZk8C2Rkix+7p+HPBw7Uelc3imxETVAii2hsn8UbdWu+BKa
 ySVYwuHKboFbH+zuCVBxOXtwd8nlYRffqnvIVi3snf/8xS0sT+uD+84qn2c0y3ZTb9sI1PGoMGA
 BnB2wYH8T+0/SxK3J1biyZinKMkgQk2nsj/IuBbFHiT/C1BPyJdcOG8C5qo524uVgkRSJkBt51a
 2lttnpvjC1Gcs1/5f7RZYxJ8ACd/db29F4LQ81WszMxTe9NZfE3yx3E2u5SzkttV7scrW+5vp62
 xAW1phMRatpPhSeTxrQ==
X-Proofpoint-ORIG-GUID: OQqGMkCutOjL0TRumxW_mk2PamBjxqqz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NSBTYWx0ZWRfX6g8AKpuNtVbQ
 hNcovayabBqV7B4WotFADSa33oZ/mHMhJIe2z5pTHNOSbyJ8acAbz8djNqv4LxltbZqj1R22XQ8
 FXZrz9bhQVeq8ITbrvmpivBBZNJ2F1Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
> timer_mod_anticipate_ns() cannot postpone the shared overflow timer when
> a counter is stopped or reconfigured. Recompute the earliest deadline
> from all eligible counters after PMU changes and timer expiry. Check for
> an actual counter wrap before setting OF or LCOFIP.
> 
> Keep counter arithmetic in source units. For timer scheduling, convert
> only raw icount instruction counts to nanoseconds. Check how many fit
> within INT64_MAX - now nanoseconds before conversion, using INT64_MAX as
> the deadline if the count is larger. Recompute the remaining count at
> expiry instead of keeping irq_overflow_left.
> 
> Icount time warp can expire the timer without executing instructions.
> If the instruction source has not advanced, defer its next deadline
> until execution resumes to avoid an endless warp/rearm loop.
> 
> Extend the cycle-control test to cover selector writes while CY is set
> and resuming mcycle after CY is cleared.
> 
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.h                     |   4 +-
>   target/riscv/tcg/cpu_helper.c          |   2 +
>   target/riscv/tcg/pmu.c                 | 239 +++++++++++++--------------------
>   target/riscv/tcg/pmu.h                 |   3 +-
>   target/riscv/tcg/tcg-cpu.c             |  10 ++
>   tests/tcg/riscv64/pmu-cycle-controls.S |  27 ++++
>   6 files changed, 139 insertions(+), 146 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f7b1bfc9cf5069125bc22dc2674d8e67431c5970..17b9929785f668487d2ec851b736d588e025fd91 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -236,8 +236,6 @@ typedef struct PMUCTRState {
>       uint64_t mhpmcounter_val;
>       /* Snapshot value of a counter */
>       uint64_t mhpmcounter_prev;
> -    /* Value beyond INT64_MAX before overflow interrupt trigger */
> -    uint64_t irq_overflow_left;
>   } PMUCTRState;
>   
>   typedef enum {
> @@ -583,6 +581,8 @@ struct ArchCPU {
>       RISCVSATPModes satp_modes;
>   
>       QEMUTimer *pmu_timer;
> +    uint64_t pmu_timer_instret_snapshot;
> +    bool pmu_timer_stalled;
>       /* A bitmask of Available programmable counters */
>       uint32_t pmu_avail_ctrs;
>       /* Mapping of events to counters */
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 07d92226527d85da93b8810e526d044e64fa4e3d..89751cdbf29f5bbd46d0d6b8c9d23eac5e3accac 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -889,6 +889,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>               riscv_cpu_update_mip(env, 0, 0);
>           }
>       }
> +
> +    riscv_pmu_rebuild_timer(env);
>   }
>   
>   /*
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 2f600c5a0fc2d7ba380ef34f89af6366e3e27884..f88f6ae671d877ed874d22c9d4b840edb6f433a5 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -26,13 +26,6 @@
>   #include "system/device_tree.h"
>   #include "system/cpu-timers.h"
>   
> -/*
> - * cpu_get_ticks() does not expose the host tick frequency.  Use a 1 GHz
> - * approximation only when scheduling non-icount overflow checks; fixed
> - * counter values remain in host-tick units.
> - */
> -#define RISCV_PMU_HOST_TICK_HZ_ASSUMED 1000000000
> -
>   static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
>   {
>       if (ctr_idx < 3 || ctr_idx >= RV_MAX_MHPMCOUNTERS ||
> @@ -324,7 +317,6 @@ void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
>                              uint64_t value, uint64_t wr_mask)
>   {
>       RISCVPMUFixedSnapshot snapshot;
> -    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>   
>       riscv_pmu_take_fixed_snapshot(env, &snapshot);
>       if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> @@ -337,10 +329,7 @@ void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
>       if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
>           riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
>       }
> -
> -    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> -        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> -    }
> +    riscv_pmu_rebuild_timer(env);
>   }
>   
>   void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
> @@ -349,23 +338,19 @@ void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
>       RISCVPMUFixedSnapshot snapshot;
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>       bool rv32 = xl == MXL_RV32;
> -    bool running;
>       int start = upper_half ? 32 : 0;
>       int length = rv32 ? 32 : 64;
>   
>       g_assert(rv32 || !upper_half);
>   
>       riscv_pmu_take_fixed_snapshot(env, &snapshot);
> -    running = riscv_pmu_fixed_ctr_running(env, ctr_idx);
> -    if (running) {
> +    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
>           riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
>       }
>       counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
>                                            start, length, value);
>       /* mhpmcounter_prev tracks the source, not the written counter value. */
> -    if (running && ctr_idx > 2) {
> -        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
> -    }
> +    riscv_pmu_rebuild_timer(env);
>   }
>   
>   void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
> @@ -396,11 +381,8 @@ void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
>           if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
>               riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
>           }
> -        if (ctr_idx > 2 && riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> -            riscv_pmu_setup_timer(env, env->pmu_ctrs[ctr_idx].mhpmcounter_val,
> -                                  ctr_idx);
> -        }
>       }
> +    riscv_pmu_rebuild_timer(env);
>   }
>   
>   void riscv_pmu_decr_instret(CPURISCVState *env)
> @@ -512,17 +494,6 @@ static bool riscv_pmu_event_supported(uint32_t event_idx)
>       }
>   }
>   
> -static int64_t pmu_ticks_to_ns(CPURISCVState *env, uint32_t ctr_idx,
> -                               int64_t value)
> -{
> -    if (icount_enabled() &&
> -        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        return icount_to_ns(value);
> -    }
> -
> -    return (NANOSECONDS_PER_SECOND / RISCV_PMU_HOST_TICK_HZ_ASSUMED) * value;
> -}
> -
>   void riscv_pmu_rebuild_event_map(CPURISCVState *env)
>   {
>       uint32_t ctr_idx, ctr_mask, event_idx;
> @@ -551,148 +522,132 @@ void riscv_pmu_rebuild_event_map(CPURISCVState *env)
>       }
>   }
>   
> -static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
> -{
> -    if (!get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
> -        env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> -        return true;
> -    } else {
> -        return false;
> -    }
> -}
> -
> -static void pmu_timer_trigger_irq_counter(RISCVCPU *cpu, uint32_t ctr_idx)
> +static int64_t riscv_pmu_overflow_delay_ns(CPURISCVState *env,
> +                                           uint32_t ctr_idx,
> +                                           uint64_t value, int64_t now)
>   {
> -    CPURISCVState *env = &cpu->env;
> -    PMUCTRState *counter;
> -    int64_t irq_trigger_at;
> -    uint64_t curr_ctr_val, curr_ctrh_val;
> -    uint64_t ctr_val;
> +    uint64_t remaining;
> +    uint64_t max_delay = INT64_MAX - now;
>   
> -    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
> -        return;
> +    if (!value) {
> +        /* A complete 64-bit wrap is beyond the signed timer horizon. */
> +        return max_delay;
>       }
> +    remaining = -value;
>   
> -    /* Generate interrupt only if OF bit is clear */
> -    if (get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
> -        return;
> -    }
> -
> -    counter = &env->pmu_ctrs[ctr_idx];
> -    if (counter->irq_overflow_left > 0) {
> -        irq_trigger_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                        counter->irq_overflow_left;
> -        timer_mod_anticipate_ns(cpu->pmu_timer, irq_trigger_at);
> -        counter->irq_overflow_left = 0;
> -        return;
> -    }
> +    if (icount_enabled() &&
> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> +        /* Use one adaptive-shift sample for both bounds and conversion. */
> +        uint64_t ns_per_tick = icount_to_ns(1);
> +        uint64_t max_ticks = max_delay / ns_per_tick;
>   
> -    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx,
> -                        riscv_cpu_mxl(env));
> -    ctr_val = counter->mhpmcounter_val;
> -    if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx,
> -                            riscv_cpu_mxl(env));
> -        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
> +        if (remaining > max_ticks) {
> +            return max_delay;
> +        }
> +        return remaining * ns_per_tick;
>       }
>   
>       /*
> -     * We can not accommodate for inhibited modes when setting up timer. Check
> -     * if the counter has actually overflowed or not by comparing current
> -     * counter value (accommodated for inhibited modes) with software written
> -     * counter value.
> +     * Cycle under icount is already virtual ns.  Non-icount fixed events
> +     * retain QEMU's existing one-host-tick-per-ns deadline approximation.
>        */
> -    if (curr_ctr_val >= ctr_val) {
> -        riscv_pmu_setup_timer(env, curr_ctr_val, ctr_idx);
> -        return;
> -    }
> -
> -    if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
> -        if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
> -            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> -        }
> -    }
> +    return MIN(remaining, max_delay);
>   }
>   
> -static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> -                                  enum riscv_pmu_event_idx evt_idx)
> +static void riscv_pmu_rebuild_timer_internal(CPURISCVState *env,
> +                                             bool timer_expired)
>   {
> +    RISCVCPU *cpu = env_archcpu(env);
> +    RISCVPMUFixedSnapshot snapshot;
>       uint32_t ctr_idx;
>       uint32_t ctr_mask;
> +    int64_t deadline = INT64_MAX;
> +    int64_t now;
> +    bool have_deadline = false;
> +    bool timer_horizon_exhausted;
> +    bool stalled = false;
>   
> -    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
> -        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> +    if (!cpu->pmu_timer) {
>           return;
>       }
>   
> -    ctr_mask = riscv_pmu_event_counter_mask(cpu, evt_idx);
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    /* No future absolute timer deadline is representable at this point. */
> +    timer_horizon_exhausted = now == INT64_MAX;
> +
> +    ctr_mask = riscv_pmu_event_counter_mask(
> +        cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
> +    ctr_mask |= riscv_pmu_event_counter_mask(
> +        cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
>   
>       while (ctr_mask) {
> +        PMUCTRState *counter;
> +        int64_t candidate;
> +
>           ctr_idx = ctz32(ctr_mask);
>           ctr_mask &= ~BIT(ctr_idx);
> -        pmu_timer_trigger_irq_counter(cpu, ctr_idx);
> -    }
> -}
> +        counter = &env->pmu_ctrs[ctr_idx];
>   
> -/* Timer callback for instret and cycle counter overflow */
> -void riscv_pmu_timer_cb(void *priv)
> -{
> -    RISCVCPU *cpu = priv;
> +        if (!riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
> +            continue;
> +        }
> +        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
> +        if ((env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF) ||
> +            riscv_pmu_counter_filtered(env,
> +                                       env->mhpmevent_val[ctr_idx])) {
> +            continue;
> +        }
>   
> -    /* Timer event was triggered only for these events */
> -    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
> -    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
> -}
> +        /*
> +         * Settle current deltas and overflows even when no future deadline is
> +         * representable.
> +         */
> +        if (timer_horizon_exhausted) {
> +            continue;
> +        }
>   
> -int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
> -{
> -    uint64_t overflow_delta, overflow_at, curr_ns;
> -    int64_t overflow_ns, overflow_left = 0;
> -    RISCVCPU *cpu = env_archcpu(env);
> -    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> +        if (timer_expired && icount_enabled() &&
> +            riscv_pmu_ctr_monitor_instructions(env, ctr_idx) &&
> +            snapshot.instret == cpu->pmu_timer_instret_snapshot) {
> +            /*
> +             * Icount can warp QEMU_CLOCK_VIRTUAL to this deadline without
> +             * executing an instruction. Re-arming the unchanged instruction
> +             * distance would create a warp/rearm loop; defer it until this
> +             * CPU enters execution again.
> +             */
> +            stalled = true;
> +            continue;
> +        }
>   
> -    /* No need to setup a timer if LCOFI is disabled when OF is set */
> -    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf ||
> -        get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
> -        return -1;
> +        candidate = now + riscv_pmu_overflow_delay_ns(
> +                              env, ctr_idx, counter->mhpmcounter_val, now);
> +        if (!have_deadline || candidate < deadline) {
> +            deadline = candidate;
> +            have_deadline = true;
> +        }
>       }
>   
> -    if (value) {
> -        overflow_delta = UINT64_MAX - value + 1;
> +    cpu->pmu_timer_instret_snapshot = snapshot.instret;
> +    cpu->pmu_timer_stalled = stalled;
> +    if (have_deadline) {
> +        timer_mod_ns(cpu->pmu_timer, deadline);
>       } else {
> -        overflow_delta = UINT64_MAX;
> -    }
> -
> -    /*
> -     * QEMU supports only int64_t timers while RISC-V counters are uint64_t.
> -     * Compute the leftover and save it so that it can be reprogrammed again
> -     * when timer expires.
> -     */
> -    if (overflow_delta > INT64_MAX) {
> -        overflow_left = overflow_delta - INT64_MAX;
> +        timer_del(cpu->pmu_timer);
>       }
> +}
>   
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        overflow_ns = pmu_ticks_to_ns(env, ctr_idx,
> -                                      (int64_t)overflow_delta);
> -        overflow_left = pmu_ticks_to_ns(env, ctr_idx, overflow_left);
> -    } else {
> -        return -1;
> -    }
> -    curr_ns = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    overflow_at =  curr_ns + overflow_ns;
> -    if (overflow_at <= curr_ns)
> -        overflow_at = UINT64_MAX;
> +void riscv_pmu_rebuild_timer(CPURISCVState *env)
> +{
> +    riscv_pmu_rebuild_timer_internal(env, false);
> +}
>   
> -    if (overflow_at > INT64_MAX) {
> -        overflow_left += overflow_at - INT64_MAX;
> -        counter->irq_overflow_left = overflow_left;
> -        overflow_at = INT64_MAX;
> -    }
> -    timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
> +/* Timer callback for instret and cycle counter overflow */
> +void riscv_pmu_timer_cb(void *priv)
> +{
> +    RISCVCPU *cpu = priv;
>   
> -    return 0;
> +    riscv_pmu_rebuild_timer_internal(&cpu->env, true);
>   }
>   
>   
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index 1494fbc21f53137a90c1338f6ca8e3c3e750276a..d9238ae680f5e67031511db4f9afc2884212c5c2 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -44,12 +44,11 @@ void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
>                                target_ulong value, bool upper_half, RISCVMXL xl);
>   void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value);
>   void riscv_pmu_timer_cb(void *priv);
> +void riscv_pmu_rebuild_timer(CPURISCVState *env);
>   void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
>   void riscv_pmu_rebuild_event_map(CPURISCVState *env);
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
> -int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
> -                          uint32_t ctr_idx);
>   void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
>                                    bool new_virt);
>   void riscv_pmu_decr_instret(CPURISCVState *env);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b68160af8307c1e46d3f200c5313823d240eb7b3..cdcb94f3bcaf0526512f1994e9f7127209e1adcb 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -247,6 +247,15 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> +static void riscv_cpu_exec_enter(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +
> +    if (cpu->pmu_timer_stalled) {
> +        riscv_pmu_rebuild_timer(&cpu->env);
> +    }
> +}
> +
>   static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
>                                   vaddr result, vaddr base)
>   {
> @@ -283,6 +292,7 @@ const TCGCPUOps riscv_tcg_ops = {
>       .mmu_index = riscv_cpu_mmu_index,
>   
>   #ifndef CONFIG_USER_ONLY
> +    .cpu_exec_enter = riscv_cpu_exec_enter,
>       .tlb_fill = riscv_cpu_tlb_fill,
>       .pointer_wrap = riscv_pointer_wrap,
>       .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
> diff --git a/tests/tcg/riscv64/pmu-cycle-controls.S b/tests/tcg/riscv64/pmu-cycle-controls.S
> index fdd14755f4d196dc2a3ec6c8b8540adc40b3a253..474d46d61baa2c3ec55a5a40d7bdb7ddd3dd7f2f 100644
> --- a/tests/tcg/riscv64/pmu-cycle-controls.S
> +++ b/tests/tcg/riscv64/pmu-cycle-controls.S
> @@ -17,6 +17,8 @@ _start:
>   	 * 1: mcycle changes while M-mode is filtered
>   	 * 2: disabling MINH adds the filtered interval
>   	 * 3: mcycle does not resume after disabling MINH
> +	 * 4: writing mhpmevent3 advances mcycle while CY is set
> +	 * 5: mcycle does not resume after clearing CY
>   	 */
>   	li	t4, 0
>   	csrw	mcountinhibit, zero
> @@ -61,6 +63,31 @@ _start:
>   	slli	t1, t1, 3
>   	or	t4, t4, t1
>   
> +	/* Changing HPM3's event must leave mcycle stopped while CY is set. */
> +	li	t0, 1			/* mcountinhibit.CY */
> +	csrw	mcountinhibit, t0
> +	csrr	s4, mcycle
> +	.rept	128
> +	nop
> +	.endr
> +	li	t0, 1			/* HW_CPU_CYCLES */
> +	csrw	mhpmevent3, t0		/* mhpmevent3; rebuilds PMU timer */
> +	csrr	s5, mcycle
> +	xor	t1, s4, s5
> +	sltu	t1, zero, t1
> +	slli	t1, t1, 4
> +	or	t4, t4, t1
> +	csrw	mcountinhibit, zero
> +	csrr	s6, mcycle
> +	.rept	128
> +	nop
> +	.endr
> +	csrr	t1, mcycle
> +	sltu	t1, s6, t1
> +	xori	t1, t1, 1
> +	slli	t1, t1, 5
> +	or	t4, t4, t1
> +	csrw	mhpmevent3, zero
>   	lla	a1, semiargs
>   	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
>   	sd	t0, 0(a1)
> 


