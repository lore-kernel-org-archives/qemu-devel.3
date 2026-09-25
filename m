Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFD4C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA93g-0001eN-LY; Fri, 25 Sep 2026 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA93e-0001dY-5t
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:45:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA93Z-0002xP-JX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:45:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG1Mta796776
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7x8CJI8ZcOeO0a1BAcwgUjsHel5oGzBDcWMojHdLsvo=; b=Zxuac1QcT9+eSp5/
 rYm4Z/C8fuwWILyxLFspnFIdnD9kW4fMqogvEm+RArHQD+8oQvjrJdtAgFNpUThh
 BJRyORhUTFytbfT24mtK4rTdb5uU0dgI27exp/H0eM/+jWvUD2lPO/JVILAQkTqV
 Mou21UR9kTr1z/XwB0ihr9AZm6p3p27Kc2q4/Y5wbFF01pDRqUIWLwkK/6iH6UKi
 Fvea1DFDdz+sexO/rKGjzncyExnjOqIxLDbu7V3qVynDz+eEtd8GL/ODDmlARoRL
 D/CEWd6IXNlmelBHoeHNwpMQudebAVTPruSGM5wMpEK0REmeiIit2dQJUFOt6z28
 PMTxYw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3aa65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:45:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530e39c5625so23738891cf.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790354750; x=1790959550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7x8CJI8ZcOeO0a1BAcwgUjsHel5oGzBDcWMojHdLsvo=;
 b=DBAaHImWznViRLtWt+talzQVuO9OqslV3OMjU4JbtlbH7bB9CI1Pbsc9vuZcr2gHgi
 8NAv45HIO0noZmQ+z84pvb2oxG33Ud28RKugeQc3Dn5fJm3Z8FOhn2WIybrmO0kRVHBz
 0eBBDpnQoGS756h+ORGw55krSQkBMDRiBP2A9kVvyW9ZxONck/SWOg6ZupTbaYAEPTQM
 wZdKIjKblt/8n8wyN96uY824j58yNjTXnZMSRxk5c2jlYLDjishxIQlObbmbWweVY879
 gNf0gPRTM9vLqJ58Jl+lE6q0onaADox9FnyiHqcZjuD4D95DTPgtufpyOVP+xv1fT1Gh
 z0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790354750; x=1790959550;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7x8CJI8ZcOeO0a1BAcwgUjsHel5oGzBDcWMojHdLsvo=;
 b=KQeWZQNeKpLmFtlkKGMI+GN7B9SDDvvczg10PaTKQ7aie5a19Qv5q/+ryIsQ0GpvLM
 Jm9RWwRIqSphywQT+GPYZMU6Rbs3TqOuWZK8xhG7GvlGOgkF9z03y0HqCFAuaosBBJiH
 /D1IDNVTKGxE0WuJ8JuIG7jrHGCCkCNFsAG7k9mD40nz1ESjjtmz3hCMqnrAOjO6+3Zk
 SfXwr4xSZ8B3adbXQKnoAAnQAwqRcNb5zysj7VmIZNrlc425dWpW6mMscKGf5+ZGAs8f
 exupcu3cWmxzGETfZLmbfTwLLz0U6hp2TI/oKQMLupgG+ebLua2Movzwnfcv2TTbUXA1
 7M9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbtht2dDg/goVkTaRoVy6UWOdfhOqFf7I55N/F5pro2cJr8EAaadDjHtj8baZNTAfILaqihxIl2S7/@nongnu.org
X-Gm-Message-State: AFuF++nrW2uwJHZ92D/y7lfNERV3txo4hipNY7zsZbxXJqf6oNHOFxSs
 eZalMpJzI+YMky3m7TgmivKFxDhL3BRqbCpqHiipXfU+C9SZcURVICLhqhMbusobrnfXtFoHYg6
 iNfJliEWVJI8ed3L7cYFzwE+nnWwRfacmrsHYhVcF8N3wC2JQXPPOjL0cww==
X-Gm-Gg: AYBFou1ALYPxfVGgylPTZV4/iq6DJpycAMaYetedy8Snn+Fk5nHns4LZb3K0oxhGu3F
 +X4aPXodKCFou2H/wA+D73ijHRgsYS/jFB89t33KP2Zy2Tf+ESzJ6mUWzjkLW+zM8C5N8Um//Q8
 aMQvWp88te6elIeVbMcjhnnWPqcA8E92XPI7TL37AZBecnGeQ+yUgwerlde5lTI4uJLLDP5gBv1
 FEvUqTWIeRoPLRU89Cku6iZCPHCnrExoPUqPXZ8DFhi9/3I1mUhl9ZUnzZcvKoZ4INDKbS7bWnM
 So+3YvEO9WYtxxN3VPRQmheX2+WCw/y/Reg2stDqvSuHwP0AmIH/I/dqba12peFatfKe3gM8n+h
 SssxLeuC3wmU/KPpMMfZyZc4vLH7JAjnVKw==
X-Received: by 2002:a05:622a:1a8b:b0:532:d3ad:c537 with SMTP id
 d75a77b69052e-5330b703f1amr54918361cf.59.1790354749654; 
 Fri, 25 Sep 2026 09:45:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8b:b0:532:d3ad:c537 with SMTP id
 d75a77b69052e-5330b703f1amr54917261cf.59.1790354748767; 
 Fri, 25 Sep 2026 09:45:48 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430df77adsm20612006d6.26.2026.09.25.09.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:45:48 -0700 (PDT)
Message-ID: <ee7f09b9-7313-40a7-986b-063465272841@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:45:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] target/riscv: Preserve fixed PMU state across
 reset
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-14-5da5159a0c64@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910-riscv-pmu-correctness-v2-14-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfXw2mGRmWFnsY2
 n8RJMM9z/YMzz+dyDMbHSSVYSFfphakYq//3Yu33XEczPhkyziQ0rjFAyG+4rS/lQx96nVJE+46
 +Bz78rvxj5xNTtxvGlBdyZ540dNnZpU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX4+7xE38j+n44
 efFTthyujvljNTvrkREVyXKKzhcDhFOgGE/9Qgzz/ylHtdu33D6NBFaLLUqVWF3rJdRz1VJz9V3
 s3YClhwVdtLy1M+NZjlhesHgGErNB9IVXVo29YpV+sVP7+YkdCqO8Q7+Tg8uyoee8m3NncDQWZ5
 HDV7gRTJA2+4+sJOaK5jT9lMhHTdisvr89wzxqT04BVIVN4P/8Q06tFzZp7eTFiVbnM0uHapQU4
 p13dYe6ZTG9uJpJUPjQUgbs4/o09Iwd1FNIAhoAj6n6+VBQGYnVURiMEqwrx3ILl9cYw8ieRJSr
 2JxRP9UUbATBNsX00uAJ8Uh95uTS/H+Qv2OXrRHo5fKMjP2bQca5k7IpkvuKPo8w0+SyC15lKHf
 P9vIIOwd70CQzjkW2PoXaU7ZNx9KtCx6fP4W2U9lqab2wLGW6av9crg5QLScc4qmsHq6rQoYc9r
 YV9NvkOkXa9vIDFlQxw==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab6a53e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=UiZdoYEBrJGKmPSr0pwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: kEZjLhIJBHOeXfMUkcmjDhX_ecvXd4gG
X-Proofpoint-ORIG-GUID: kEZjLhIJBHOeXfMUkcmjDhX_ecvXd4gG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250066
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 9/10/2026 11:39 AM, TANG Tiancheng wrote:
> Privilege filtering records cycle/instruction increments per mode. Reset
> overwrites privilege/V without adding the final interval to the old
> mode's total, so a counter filtering for that mode loses those counts.
> 
> Account for the old mode before entering M-mode with V=0 and rebuild the
> overflow timer after reset. On initial reset, only initialize baselines:
> no guest code has run, so pre-execution QEMU time must not count.
> Preserve architectural counter and selector state, as before.
> 
> Test that a VS-only cycle counter retains its counts across reset.
> 
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                   |  16 ++++++
>   target/riscv/tcg/pmu.c               |  11 ++++
>   target/riscv/tcg/pmu.h               |   1 +
>   tests/tcg/riscv64/pmu-reset-vs.S     | 105 +++++++++++++++++++++++++++++++++++
>   tests/tcg/riscv64/system/meson.build |   7 +++
>   5 files changed, 140 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f60d7cca1e2f0008b09b1055c5cdeed3ec4ad1d3..e27312ac505dbee072c5a3c52073b00d703fd81d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -42,6 +42,9 @@
>   #include "disas/capstone.h"
>   #if !defined(CONFIG_USER_ONLY)
>   #include "target/riscv/tcg/debug.h"
> +#ifdef CONFIG_TCG
> +#include "target/riscv/tcg/pmu.h"
> +#endif
>   #endif
>   
>   /* RISC-V CPU definitions */
> @@ -979,6 +982,16 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       }
>   #ifndef CONFIG_USER_ONLY
>       env->misa_mxl = mcc->def->misa_mxl_max;
> +#ifdef CONFIG_TCG
> +    /* The initial reset has no guest execution to count. */
> +    if (tcg_enabled()) {
> +        if (qdev_is_realized(DEVICE(cpu))) {
> +            riscv_pmu_update_fixed_ctrs(env, PRV_M, false);
> +        } else {
> +            riscv_pmu_init_fixed_counter_baselines(env);
> +        }
> +    }
> +#endif
>       env->priv = PRV_M;
>       env->virt_enabled = false;
>       env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> @@ -1092,6 +1105,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>   
>   #ifndef CONFIG_USER_ONLY
>   #ifdef CONFIG_TCG
> +    if (tcg_enabled()) {
> +        riscv_pmu_rebuild_timer(env);
> +    }
>       if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>           riscv_trigger_reset_hold(env);
>       }
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index df99b572a4c16cb1ac65c2f7cde35c6f8349e681..1d692a0a8e3f7759e033214d579103627d070b5b 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -171,6 +171,17 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
>       riscv_pmu_update_fixed_ctrs_snapshot(env, newpriv, new_virt, &snapshot);
>   }
>   
> +void riscv_pmu_init_fixed_counter_baselines(CPURISCVState *env)
> +{
> +    RISCVPMUFixedSnapshot snapshot;
> +
> +    riscv_pmu_take_fixed_snapshot(env, &snapshot);
> +    env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_CYCLE]
> +        .counter_prev[PRV_M] = snapshot.cycle;
> +    env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_INSTRET]
> +        .counter_prev[PRV_M] = snapshot.instret;
> +}
> +
>   uint64_t
>   riscv_pmu_ctr_get_fixed_value(CPURISCVState *env, uint32_t ctr_idx,
>                                 const RISCVPMUFixedSnapshot *snapshot)
> diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
> index 1cfe6acf55b5468f5c00c4a136ece88981384341..fac84dbb1a8a6c637f7241ca27910e5e212223e9 100644
> --- a/target/riscv/tcg/pmu.h
> +++ b/target/riscv/tcg/pmu.h
> @@ -53,6 +53,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>   void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
>                                    bool new_virt);
> +void riscv_pmu_init_fixed_counter_baselines(CPURISCVState *env);
>   void riscv_pmu_decr_instret(CPURISCVState *env);
>   RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>                                     bool upper_half, uint32_t ctr_idx,
> diff --git a/tests/tcg/riscv64/pmu-reset-vs.S b/tests/tcg/riscv64/pmu-reset-vs.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..d216faef17a2a395120cb3a71166a821a43dee88
> --- /dev/null
> +++ b/tests/tcg/riscv64/pmu-reset-vs.S
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* CSR number for older assemblers. */
> +#define CSR_MCYCLECFG        0x321
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.equ	MSTATUS_MPP_S,  (1 << 11)
> +	.equ	MSTATUS_MPP,    (3 << 11)
> +	.equ	MSTATUS_SPP,    (1 << 8)
> +	.equ	HSTATUS_SPV,    (1 << 7)
> +	.equ	SIFIVE_TEST,    0x100000
> +	.equ	MTIMECMP,       0x2004000
> +	.equ	FINISHER_RESET, 0x7777
> +
> +	.text
> +	.global _start
> +_start:
> +	/* Preserve the reset marker and saved count in MTIMECMP. */
> +	li	t0, MTIMECMP
> +	ld	t1, 0(t0)
> +	srli	t2, t1, 48
> +	li	t3, 0xa5a5
> +	beq	t2, t3, after_reset
> +
> +	/* Count VS only, then remember the value before entering VS-mode. */
> +	li	t0, 0x1d		/* MINH | SINH | UINH | VUINH */
> +	slli	t0, t0, 58
> +	csrw	CSR_MCYCLECFG, t0
> +	csrr	t1, mcycle
> +	slli	t1, t1, 16
> +	srli	t1, t1, 16
> +	li	t2, 0xa5a5
> +	slli	t2, t2, 48
> +	or	t1, t1, t2
> +	li	t0, MTIMECMP
> +	sd	t1, 0(t0)
> +	li	t0, -1
> +	csrw	pmpaddr0, t0
> +	li	t0, 0x1f		/* RWX, NAPOT */
> +	csrw	pmpcfg0, t0
> +
> +	/* Enter HS-mode first. */
> +	csrr	t0, mstatus
> +	li	t1, MSTATUS_MPP
> +	not	t1, t1
> +	and	t0, t0, t1
> +	li	t1, MSTATUS_MPP_S
> +	or	t0, t0, t1
> +	csrw	mstatus, t0
> +	lla	t0, hs_enter
> +	csrw	mepc, t0
> +	mret
> +
> +hs_enter:
> +	li	t0, HSTATUS_SPV
> +	csrs	hstatus, t0
> +	li	t0, MSTATUS_SPP
> +	csrs	sstatus, t0
> +	lla	t0, vs_reset
> +	csrw	sepc, t0
> +	sret
> +
> +vs_reset:
> +	/* These VS-mode cycles must remain in mcycle after reset. */
> +	li	t0, 128
> +1:
> +	addi	t0, t0, -1
> +	bnez	t0, 1b
> +
> +	li	t0, SIFIVE_TEST
> +	li	t1, FINISHER_RESET
> +	sw	t1, 0(t0)
> +	j	.
> +
> +after_reset:
> +	csrr	t0, mcycle
> +	slli	t1, t1, 16		/* Clear the MTIMECMP marker. */
> +	srli	t1, t1, 16
> +	addi	t1, t1, 128
> +	bgeu	t1, t0, fail
> +	li	t3, 0
> +	j	exit
> +
> +fail:
> +	li	t3, 1
> +
> +exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	t3, 8(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +
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
> index d2355090121ba7a7d0046c1fc1824d6a89c1267f..3f2043d100ff88cc39a21002a1e90ccab319001b 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -142,6 +142,13 @@ tests += {
>     },
>   }
>   
> +tests += {
> +  'pmu-reset-vs.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max,smcntrpmf=true', '-icount', 'shift=0', qemu_args],
> +  },
> +}
> +
>   if 'qemu-system-riscv64' in emulators
>     tcg_tests += {
>       'riscv64-softmmu': {
> 


