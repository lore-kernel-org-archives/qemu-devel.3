Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125DEC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3uEb-0001X9-AF; Tue, 08 Sep 2026 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3uEZ-0001Wm-QF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:43:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3uDw-000861-3t
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:43:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688ADbOn3825959
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 11:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hnN/T8WOykzpq8kgmV1otZ2DuIFII8zfh0PSmErxYVQ=; b=bZvtZaJtPZRoGLA6
 4VFfDtwEuUkKzShh8fn+uY24wiRk0kyuhEBkF2CYyIOGWtDYQVabOIoOKwwRnmSj
 QQqMzn6OhjoI/vBhLR8xcB85/994jUDz9p71DnNX4RBTH0DikSQZBGnxPwMgKT+U
 01YhEtK5Uz4SYeWz9WkwBZBRSgNuPPVm3mdPncSJ1yVDv3fE3qBLbR9gzqjkIISu
 mjKnBxsd3K58vK/WvUSty6G8zvjrqcQW7KACz5iSI3zF4nTIytq6xTsP3O50hQPg
 9EUth5yrGgkarlwUL53VyKU+Dc9QswyIDTysyyPqoZeqIWB8JnD9xyzRSyM4Xz7C
 WAGRrg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0p9r09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 11:42:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9375d92d8cdso866557585a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788867764; x=1789472564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hnN/T8WOykzpq8kgmV1otZ2DuIFII8zfh0PSmErxYVQ=;
 b=bfDtlU+C2Bd+Z1fFJ/lOkoOdROChnZm2dPT4t8bl6pyF5SBLeeusiYrTT6Qcmt406E
 +oM8Hp7W0lJwbV59+I2yg9req4ryp40VZUDbjdH4oFp3kRg5QRmyQ25DHzFdbzb0D3B3
 W6VhpDwnpPtgugKrwUCSMzaurZUefBa5DiZmgFGzHk4rYxBWybix3IZSvVztP1uLCg47
 L1VjTXSqK8j2RhZfM9JR6tq/6qlr39C+Jsyq5oXN2gwMZ3HHVQ9S01EeZnDPaPMaA8Ac
 txMlm1IMTA2EUljZMl6eBeCHAkzTAQyD1N55sjsMLNOERKG+tfaazonlhTz8Ok2oXDmi
 Pj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788867764; x=1789472564;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hnN/T8WOykzpq8kgmV1otZ2DuIFII8zfh0PSmErxYVQ=;
 b=VHP6g8cUTQOCmYQRsaNCW/ysHQ8diDeAJnBYwC92QYZznyWl8Vgmwft34tiN9E60zU
 FXyC97R97nxNpSqrk9Y2ts29QOgBVGKXxnfRJb9TISA3ETT+P+F23AF20r0Bf34OiMcc
 QBBULVVjmd3KSc9ecPkVO6GL0ur8XODjFwMjRzKPGGDXoADsPEMYw9tqXxAAiwYUTkw1
 XRvt4TCQSRlwv8RFSUImO6ZvsaM97RDHWEVqbzD6gWxSSo9qB67r0pXo6uAIy6CV8Bak
 AsW3ZvLGTW/AS47E7x/tOjZscHZj7VsWbfLvHjHblErTUh9tui10twncQzvXd9E+Dslv
 Pq3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByVq+MpwzGY3iBdrmWxjIAlNkMCXiaxYbibaij198mBZpiZGLlUNK80afW/L+NY8K8c7AI1hD487XmN@nongnu.org
X-Gm-Message-State: AFuF++kITsE5UoIEHPr+PXty2VRKl92yskPNEpDSPs4iwb85j6Pc96BK
 1OLAk33F7lTJhX/6fXPp6TnXMi6062CeSZNGIPVfBdYZCB+a4oY7vi4dVgrJ5OGI2sV/0yW6Kk9
 0zmjQf/4+HCK4BKhdauwPP5sfx9sOTcQ+Ip6IzoXqCLqRZwttVMdamvVQ1Q==
X-Gm-Gg: AYBFou1CrSMzpYIxOuERQ8KZkmJYSyVQpFL12uoj8D1zBah7vcAuZXBkojW1NmVmWhr
 Niha7upAdiS6lkcvWr5UX/ecMOHED/qg0IKJ5DMmkuNUj9wPJ1fvIMYc4s/URXZgB2o1/sNIZCI
 PuORaVc5WMuE0EKE49RfXWMwgNU0HUahSuV461rVuGgUECYuMHgxopviwddg+pgQIIRbbvYb4pK
 xnQp+myJ/TXL3NzE6xcZ1bIgPaIB0VRhCnxK0r8pWeugJYMh/9zhn5bhJoV9X6cU7K9isf+jgFk
 YQlFhrxVDTxroKWq2KZi62PjifyY72NR2o2XD89qSBd8l6i3kw+i+Hk0TUG2GRNpnhF5HjC5vRy
 wm8OB/XzXIv/ToGPXaaMIgrMt9XQLgzft9aTZ
X-Received: by 2002:a05:620a:3714:b0:939:b0ef:ee9b with SMTP id
 af79cd13be357-939b0efef45mr980604385a.16.1788867764394; 
 Tue, 08 Sep 2026 04:42:44 -0700 (PDT)
X-Received: by 2002:a05:620a:3714:b0:939:b0ef:ee9b with SMTP id
 af79cd13be357-939b0efef45mr980596085a.16.1788867763706; 
 Tue, 08 Sep 2026 04:42:43 -0700 (PDT)
Received: from [192.168.15.12] ([177.214.151.199])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9398c498610sm941495685a.43.2026.09.08.04.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 04:42:43 -0700 (PDT)
Message-ID: <1faf1930-247a-4f71-b49a-c45b377d9b35@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 08:42:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/riscv: Support multiple counters per PMU
 event
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
 <20260907-riscv-pmu-correctness-v1-2-5f1f41458989@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907-riscv-pmu-correctness-v1-2-5f1f41458989@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KiSYCJoor4IVC5-SNb0eNQ2TnqIJslYL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfXwNc6q2fTNHsf
 81BvR+vsS6cyK39l0WkrO653KR8VlEmSt0pkitYDhlHf4GRqS7iqYmz/5Phe1/cU1qBpViAqeRj
 gFLAG9/VFSJubMQsAYvYY+qKz81E/2I=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6a9ff4b5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=lJrVL2S40hk4Skp227i47g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=pndswYKaZ13dySNfk3wA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: KiSYCJoor4IVC5-SNb0eNQ2TnqIJslYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX9phQKslrf9uG
 94Qld8bFFzzmbSdxIMkYwW1yLScdFd/QshwEHSvdFZlp5AweWv38DKS1VG/Py2IspyJwD7OIQlk
 RY6JT+WD+N+I/ZZh1bkgoUvRH73lV25bNXiK+ZW2Y9v9puqv/mqJIJH7YXRoPYjfjYJ/MfksqWM
 g+67k+Af+29o4P0ag46qSOOUjv53aPitHFfdB8a8aEN5q9NDzRN/e1qbcGr/G9HrqLn1KWuLlp0
 KWMIuoJNerJE/FXmwGtP3CG0MUqSAnmSl4AdGKE2liLDFoZew49mbo0rghSJyLJnMs64fhn1Ihz
 Zj9OYU1kh9cdhb7lLO22OQWIMhvfxuqguE+R7qc+GZ+TmincQ8ft6wvN+TT4PiOlayADcyWCVux
 U/qYjxeADFve4cXrF/k/Q9PXxpnGn2bwIigyvzmaE6RufdWUWWVjfJknV1jNrpgeWHP5GHWmzQ4
 hNjcO6l1z6nXOtp9wdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080125
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



On 9/6/2026 1:37 PM, TANG Tiancheng wrote:
> The PMU FDT lists multiple eligible counters for each event, but the
> event map stores only one counter per event. A second selector for the
> same event is accepted by the CSR but ignored by the map, so its counter
> does not count or overflow. Changing a selector between nonzero events
> also leaves the old mapping.
> 
> Store a counter mask per event and rebuild the map from mhpmevent CSRs
> after selector writes and migration. Update event delivery, fixed-source
> accounting and overflow handling to cover every mapped counter.
> 
> Test selector replacement and multiple counters selecting instructions
> or DTLB misses.
> 
> Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/machine.c                |   6 ++
>   target/riscv/tcg/csr.c                |   2 +-
>   target/riscv/tcg/pmu.c                | 182 +++++++++++++++++-----------------
>   target/riscv/tcg/pmu.h                |   3 +-
>   tests/tcg/riscv64/sscofpmf-overflow.S |  80 ++++++++++++++-
>   5 files changed, 176 insertions(+), 97 deletions(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index bf203bffcefb32710ed0f2af4d4f4595e122d1d9..b0ff2fc7f2ac10fab1f2ff845a953649091e1f43 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -24,6 +24,9 @@
>   #include "migration/cpu.h"
>   #include "exec/icount.h"
>   #include "target/riscv/tcg/debug.h"
> +#ifdef CONFIG_TCG
> +#include "target/riscv/tcg/pmu.h"
> +#endif
>   #ifdef CONFIG_KVM
>   #include "kvm/kvm_riscv.h"
>   #endif
> @@ -311,6 +314,9 @@ static int riscv_cpu_post_load(void *opaque, int version_id)
>       CPURISCVState *env = &cpu->env;
>   
>       env->xl = cpu_recompute_xl(env);
> +#ifdef CONFIG_TCG
> +    riscv_pmu_rebuild_event_map(env);
> +#endif
>       return 0;
>   }
>   
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 52664a26f5a97a5dc8ff37abf99b4d10927fb120..d15a2d096cb6e13cd123ff9ae82ee7c643c2a961 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1241,7 +1241,7 @@ static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
>       }
>   
>       env->mhpmevent_val[ctr_idx] = value;
> -    riscv_pmu_update_event_map(env, value, ctr_idx);
> +    riscv_pmu_rebuild_event_map(env);
>   
>       if (enabled &&
>           (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 1a4658319b11a9a8a0edef18fc8a5abd0027eb31..f19f417e90e33a94d00007ef132ef4e154175b19 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -49,6 +49,17 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
>       }
>   }
>   
> +static uint32_t riscv_pmu_event_counter_mask(RISCVCPU *cpu,
> +                                             uint32_t event_idx)
> +{
> +    if (!cpu->pmu_event_ctr_map) {
> +        return 0;
> +    }
> +
> +    return GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> +                                                GUINT_TO_POINTER(event_idx)));
> +}
> +
>   static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
>   {
>       bool virt_on = env->virt_enabled;
> @@ -180,41 +191,41 @@ void riscv_pmu_decr_instret(CPURISCVState *env)
>   
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>   {
> -    uint32_t ctr_idx;
> +    uint32_t ctr_idx, ctr_mask;
>       CPURISCVState *env = &cpu->env;
>       uint64_t max_val = UINT64_MAX;
>       PMUCTRState *counter;
> -    gpointer value;
>   
>       if (!cpu->cfg.pmu_mask) {
>           return 0;
>       }
> -    value = g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                                GUINT_TO_POINTER(event_idx));
> -    if (!value) {
> -        return -1;
> -    }
>   
> -    ctr_idx = GPOINTER_TO_UINT(value);
> -    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu, event_idx);
> +    if (!ctr_mask) {
>           return -1;
>       }
>   
> -    if (riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
> -        return 0;
> -    }
> +    while (ctr_mask) {
> +        ctr_idx = ctz32(ctr_mask);
> +        ctr_mask &= ~BIT(ctr_idx);
>   
> -    /* Handle the overflow scenario */
> -    counter = &env->pmu_ctrs[ctr_idx];
> -    if (counter->mhpmcounter_val == max_val) {
> -        counter->mhpmcounter_val = 0;
> -        /* Generate interrupt only if OF bit is clear */
> -        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> -            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> -            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> +        if (!riscv_pmu_counter_enabled(cpu, ctr_idx) ||
> +            riscv_pmu_counter_filtered(env, env->mhpmevent_val[ctr_idx])) {
> +            continue;
> +        }
> +
> +        /* Handle the overflow scenario */
> +        counter = &env->pmu_ctrs[ctr_idx];
> +        if (counter->mhpmcounter_val == max_val) {
> +            counter->mhpmcounter_val = 0;
> +            /* Generate interrupt only if OF bit is clear */
> +            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> +                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> +                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> +            }
> +        } else {
> +            counter->mhpmcounter_val++;
>           }
> -    } else {
> -        counter->mhpmcounter_val++;
>       }
>   
>       return 0;
> @@ -224,8 +235,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>                                           uint32_t target_ctr)
>   {
>       RISCVCPU *cpu;
> -    uint32_t event_idx;
> -    uint32_t ctr_idx;
> +    uint32_t ctr_mask;
>   
>       /* Fixed instret counter */
>       if (target_ctr == 2) {
> @@ -237,21 +247,15 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>           return false;
>       }
>   
> -    event_idx = RISCV_PMU_EVENT_HW_INSTRUCTIONS;
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(event_idx)));
> -    if (!ctr_idx) {
> -        return false;
> -    }
> -
> -    return target_ctr == ctr_idx ? true : false;
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu,
> +                                            RISCV_PMU_EVENT_HW_INSTRUCTIONS);
> +    return (ctr_mask & BIT(target_ctr)) != 0;
>   }
>   
>   bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>   {
>       RISCVCPU *cpu;
> -    uint32_t event_idx;
> -    uint32_t ctr_idx;
> +    uint32_t ctr_mask;
>   
>       /* Fixed mcycle counter */
>       if (target_ctr == 0) {
> @@ -263,22 +267,23 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>           return false;
>       }
>   
> -    event_idx = RISCV_PMU_EVENT_HW_CPU_CYCLES;
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(event_idx)));
> -
> -    /* Counter zero is not used for event_ctr_map */
> -    if (!ctr_idx) {
> -        return false;
> -    }
> -
> -    return (target_ctr == ctr_idx) ? true : false;
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu,
> +                                            RISCV_PMU_EVENT_HW_CPU_CYCLES);
> +    return (ctr_mask & BIT(target_ctr)) != 0;
>   }
>   
> -static gboolean pmu_remove_event_map(gpointer key, gpointer value,
> -                                     gpointer udata)
> +static bool riscv_pmu_event_supported(uint32_t event_idx)
>   {
> -    return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? true : false;
> +    switch (event_idx) {
> +    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
> +    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
> +    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
> +    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> +    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
> +        return true;
> +    default:
> +        return false;
> +    }
>   }
>   
>   static int64_t pmu_icount_ticks_to_ns(int64_t value)
> @@ -294,48 +299,32 @@ static int64_t pmu_icount_ticks_to_ns(int64_t value)
>       return ret;
>   }
>   
> -int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
> -                               uint32_t ctr_idx)
> +void riscv_pmu_rebuild_event_map(CPURISCVState *env)
>   {
> -    uint32_t event_idx;
> +    uint32_t ctr_idx, ctr_mask, event_idx;
>       RISCVCPU *cpu = env_archcpu(env);
>   
> -    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
> -        return -1;
> +    if (!cpu->pmu_event_ctr_map) {
> +        return;
>       }
>   
> -    /*
> -     * Expected mhpmevent value is zero for reset case. Remove the current
> -     * mapping.
> -     */
> -    if (!(value & MHPMEVENT_IDX_MASK)) {
> -        g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
> -                                    pmu_remove_event_map,
> -                                    GUINT_TO_POINTER(ctr_idx));
> -        return 0;
> -    }
> +    g_hash_table_remove_all(cpu->pmu_event_ctr_map);
> +    for (ctr_idx = 3; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
> +        if (!riscv_pmu_counter_valid(cpu, ctr_idx)) {
> +            continue;
> +        }
>   
> -    event_idx = value & MHPMEVENT_IDX_MASK;
> -    if (g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                            GUINT_TO_POINTER(event_idx))) {
> -        return 0;
> -    }
> +        event_idx = env->mhpmevent_val[ctr_idx] & MHPMEVENT_IDX_MASK;
> +        if (!event_idx || !riscv_pmu_event_supported(event_idx)) {
> +            continue;
> +        }
>   
> -    switch (event_idx) {
> -    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
> -    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
> -    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
> -    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> -    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
> -        break;
> -    default:
> -        /* We don't support any raw events right now */
> -        return -1;
> +        ctr_mask = riscv_pmu_event_counter_mask(cpu, event_idx);
> +        ctr_mask |= BIT(ctr_idx);
> +        g_hash_table_insert(cpu->pmu_event_ctr_map,
> +                            GUINT_TO_POINTER(event_idx),
> +                            GUINT_TO_POINTER(ctr_mask));
>       }
> -    g_hash_table_insert(cpu->pmu_event_ctr_map, GUINT_TO_POINTER(event_idx),
> -                        GUINT_TO_POINTER(ctr_idx));
> -
> -    return 0;
>   }
>   
>   static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
> @@ -348,23 +337,14 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
>       }
>   }
>   
> -static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> -                                  enum riscv_pmu_event_idx evt_idx)
> +static void pmu_timer_trigger_irq_counter(RISCVCPU *cpu, uint32_t ctr_idx)
>   {
> -    uint32_t ctr_idx;
>       CPURISCVState *env = &cpu->env;
>       PMUCTRState *counter;
>       int64_t irq_trigger_at;
>       uint64_t curr_ctr_val, curr_ctrh_val;
>       uint64_t ctr_val;
>   
> -    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
> -        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> -        return;
> -    }
> -
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(evt_idx)));
>       if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
>           return;
>       }
> @@ -408,6 +388,26 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>       }
>   }
>   
> +static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> +                                  enum riscv_pmu_event_idx evt_idx)
> +{
> +    uint32_t ctr_idx;
> +    uint32_t ctr_mask;
> +
> +    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
> +        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> +        return;
> +    }
> +
> +    ctr_mask = riscv_pmu_event_counter_mask(cpu, evt_idx);
> +
> +    while (ctr_mask) {
> +        ctr_idx = ctz32(ctr_mask);
> +        ctr_mask &= ~BIT(ctr_idx);
> +        pmu_timer_trigger_irq_counter(cpu, ctr_idx);
> +    }
> +}
> +
>   /* Timer callback for instret and cycle counter overflow */
>   void riscv_pmu_timer_cb(void *priv)
>   {
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index 2429c01b776693ebb324ed63fee1feb56c821c21..910091690290cac9f77855f479bb9d90b2762efe 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -28,8 +28,7 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
>                                     uint32_t target_ctr);
>   void riscv_pmu_timer_cb(void *priv);
>   void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
> -int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
> -                               uint32_t ctr_idx);
> +void riscv_pmu_rebuild_event_map(CPURISCVState *env);
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
> diff --git a/tests/tcg/riscv64/sscofpmf-overflow.S b/tests/tcg/riscv64/sscofpmf-overflow.S
> index 587c7d3ec430aac984621dfb818f141088be7b23..b91d9dee825f9c9f547785225882b3fc6a87e3da 100644
> --- a/tests/tcg/riscv64/sscofpmf-overflow.S
> +++ b/tests/tcg/riscv64/sscofpmf-overflow.S
> @@ -6,14 +6,18 @@
>   	.text
>   	.global _start
>   _start:
> -	/* Program hpmcounter3 while no event is selected. */
> +	/* Program counters 3 and 4 while no event is selected. */
>   	csrw	0x323, zero		/* mhpmevent3 */
>   	li	t0, -256
>   	csrw	0xb03, t0		/* mhpmcounter3 */
> +	csrw	0x324, zero		/* mhpmevent4 */
> +	li	t0, -512
> +	csrw	0xb04, t0		/* mhpmcounter4 */
>   
> -	/* Start counting retired instructions with overflow enabled. */
> +	/* Count the same event in both counters with overflow enabled. */
>   	li	t0, 2
>   	csrw	0x323, t0
> +	csrw	0x324, t0
>   
>   	/* Cross the 64-bit unsigned overflow boundary. */
>   	.rept	1024
> @@ -26,6 +30,10 @@ _start:
>   	srli	t1, t0, 63
>   	xori	t1, t1, 1
>   	or	t4, t4, t1
> +	csrr	t0, 0x324
> +	srli	t1, t0, 63
> +	xori	t1, t1, 1
> +	or	t4, t4, t1
>   
>   	csrr	t0, mip
>   	li	t1, 1 << 13
> @@ -34,12 +42,68 @@ _start:
>   	xori	t0, t0, 1
>   	or	t4, t4, t0
>   
> -	/* The counter wraps and continues counting after overflow. */
> +	/* Both counters wrap and continue counting after overflow. */
>   	csrr	t0, 0xb03
>   	li	t1, -256
>   	sltu	t0, t0, t1
>   	xori	t0, t0, 1
>   	or	t4, t4, t0
> +	csrr	t0, 0xb04
> +	li	t1, -512
> +	sltu	t0, t0, t1
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
> +
> +	/* After selecting write misses, read misses must not increment HPM3. */
> +	csrw	0x323, zero		/* mhpmevent3 */
> +	csrw	0xb03, zero		/* mhpmcounter3 */
> +	li	t0, 0x10019		/* DTLB read miss */
> +	csrw	0x323, t0
> +	li	t0, 0x1001b		/* DTLB write miss */
> +	csrw	0x323, t0
> +	sfence.vma
> +	lla	t2, stale_probe
> +	lw	t3, 0(t2)
> +	csrr	t0, 0xb03
> +	or	t4, t4, t0
> +
> +	/* Both counters must count a DTLB read miss. */
> +	csrw	0x323, zero		/* mhpmevent3 */
> +	csrw	0x324, zero		/* mhpmevent4 */
> +	csrw	0xb03, zero		/* mhpmcounter3 */
> +	csrw	0xb04, zero		/* mhpmcounter4 */
> +	li	t0, 0x10019		/* DTLB read miss */
> +	csrw	0x323, t0
> +	csrw	0x324, t0
> +	sfence.vma
> +	lla	t2, tlb_probe
> +	lw	t3, 0(t2)
> +	csrr	t0, 0xb03
> +	csrr	t1, 0xb04
> +	sltu	t2, zero, t0
> +	xori	t2, t2, 1
> +	or	t4, t4, t2
> +	sltu	t2, zero, t1
> +	xori	t2, t2, 1
> +	or	t4, t4, t2
> +	xor	t0, t0, t1
> +	sltu	t0, zero, t0
> +	or	t4, t4, t0
> +
> +	/* Disabling HPM3 must leave HPM4 counting the same event. */
> +	csrr	t5, 0xb03
> +	csrr	t6, 0xb04
> +	csrw	0x323, zero		/* mhpmevent3 */
> +	sfence.vma
> +	lla	t2, tlb_probe2
> +	lw	t3, 0(t2)
> +	csrr	t0, 0xb03
> +	xor	t0, t0, t5
> +	or	t4, t4, t0
> +	csrr	t0, 0xb04
> +	sltu	t0, t6, t0
> +	xori	t0, t0, 1
> +	or	t4, t4, t0
>   
>   	lla	a1, semiargs
>   	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> @@ -55,6 +119,16 @@ _start:
>   	j	.
>   
>   	.data
> +	/* Give each DTLB probe a separate page. */
> +	.balign	4096
> +stale_probe:
> +	.word	0
> +	.balign	4096
> +tlb_probe:
> +	.word	0
> +	.balign	4096
> +tlb_probe2:
> +	.word	0
>   	.balign	16
>   semiargs:
>   	.space	16
> 


