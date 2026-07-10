Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C87C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJVE-0001pm-M1; Fri, 10 Jul 2026 18:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJVD-0001oi-0p
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:15:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJVA-0003hF-Of
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:15:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALDHwN1932812
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VMB8AqdtmSCfj4Cx44YJcf7LFD6YK74/TqfsLerL7sM=; b=HS78gs8xwQomAv/W
 WP7qHE25CTE63185+JBcCx4zBCPoubVYHZDaHcJeQA/HvahZwHqG26YG6qlfDVTu
 E6k+cr+MBzSh6kr42RAK0rkkBWZXOGrXHJ3IgSFIutqOvKyos00U3D+eWAyxApmG
 HkpSK22Uzm4OEZeA12UX/jD74L8Qi3RoGlJWt88gFN4Wdl50ZlDc5vU076pgDSmT
 bNHa4Ho1pM/l9+dmOnzCbL1entFGSoElaKZVTNCtnHtBkt+36lmx5DLgT8QLvJwv
 3rT6BJ38kvDXmmDzl1mW6BvkRJNpp9S45Qvw9yGdgobQcWfbSbw4n3c+2LmqFUMg
 0+dC1g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r5j0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:15:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so14844501cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783721718; x=1784326518; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VMB8AqdtmSCfj4Cx44YJcf7LFD6YK74/TqfsLerL7sM=;
 b=KDLKOP8BGC2WyjMRsHbR8HGl0ZUzMN9YANp9DIvejqZUXE8uTnRkyF8haS0oQHfVnm
 f9k2kMPQpaNmU2wtUnjDHEDQMLt9pCWM5UfZzpKfRYdPmUFknMKZbOek5kRrDa6kt6qG
 xanYyf1jHS//WnlttAuQ+OBf66ZWsvhdeBHJ8PHm4w+zqqBmx80vF6mB4Vri9RW/eGhC
 yoioGpeBYuo12ItLjLBjH5Yg1eJWKbGEGpQiEP9abAwkhYuYEZtT6yz0tmi1zqcoWTUf
 zsHoyq6LVpz/ZA2ISCu95RNuRQZoDK1GJCs3JpGp+T0uS0uwSTF56XUwXhpJhutRbxHE
 eHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721718; x=1784326518;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VMB8AqdtmSCfj4Cx44YJcf7LFD6YK74/TqfsLerL7sM=;
 b=QVhqAQ5LMNHuvqBD4097FUymyJRLMJj+ljN+V8IyubOmx/Oh5XypQVBeCrHezi1Job
 MTgFl/zi8r0cAeJrvs5/BZ0+YTCb6OZZoDW08aXIVyp5blOWsRdyZrfRdayal4Elqhmh
 1jndk63hCIGI5kRL7AHDYJgpWUjXl+0MzXNryrtcXFGF5oKNQUx6LJpt4sP/KcsEpj8u
 PBOw8+TYXaFVigjFK7CfvPJOtILzFGH0IsEFDsEdJGgqJrDZUjj1RfcNCRLu99pzap37
 11WFKmYtZfWR0J8+qm6rpoFmgt6fco30+8GYTnorxj4mAYrvg5ZUIqqiWrvEBGdlLOdN
 vknA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZ9xcUpwwO9cWdqKaMz08J9dIYJQ8AMLrWBr4mpeC2XtiEf71uXeDbdeDBhKJX/XT+nJ84GbDBi6BN@nongnu.org
X-Gm-Message-State: AOJu0YwOzpMEdqD7CkzzvioOfNqS+Nr1asdNE2/uIVnGgTpLP4S0yx34
 FNCgqFdq52btMFfN4VVhZoF1jzWXnu5W2JOvxaH+h9/t/xBpY8EwMfZWn7sL0CD+xM0AXUd3mi1
 AZkLaQdMaAYbYg9enky6REbjbT2hvQJGXdLTisnM91sVr1AQymrZ3JO1vQQ==
X-Gm-Gg: AfdE7cl3eUi6OT7LxZ3N4GRiJ0LCrZ/gMIM2J6P1HxgAOKpN1S793d2+m0FrlLTFBHw
 c1giNJsWvXuXyzEFrv4MqSZCk3ToWgjaa3FvNVeRf8f9NhzLt+j38gzz4ylda81isJ9Ue/KqdH7
 zuSUOsD5/b4oPeWw+Vs2CqLM2fc7tHmu5BooJsIF3Gz5sC/X2Ae9HwQywZsFWIip84nV9aTMwuj
 Xfd43nYkcGbFyznkrZdprFPIfo/hUF2ptWiH7xNawXL81ZoqJDHiGXH4392YQax4ytvnnBeW7+H
 CN9ZcEPo3tAybUsBLq+nB6rxzGvCQG9++nSBA5c/MLRefsXXf573JfJvETU9NLDT8aIRh8xFaPo
 Xjdl/kYysnxDcp9/5ff4vrtg5EcavfEikWLvGVRmATZtUfkNiFVVVuS50Nac+aw==
X-Received: by 2002:a05:622a:14d0:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-51cbf27f8e9mr8298021cf.41.1783721717977; 
 Fri, 10 Jul 2026 15:15:17 -0700 (PDT)
X-Received: by 2002:a05:622a:14d0:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-51cbf27f8e9mr8297491cf.41.1783721717450; 
 Fri, 10 Jul 2026 15:15:17 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm64314310f8f.15.2026.07.10.15.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:15:16 -0700 (PDT)
Message-ID: <3c6e2c1d-baeb-4b49-9fda-3945c73e83b2@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/51] accel/tcg: Merge CPUState.{break, watch}point_hit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-43-richard.henderson@linaro.org>
In-Reply-To: <20260710205401.836304-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a516ef6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=E4T4awTXxgq4vhBkndIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZtDm1Rc4ft6nzIEeih2ZSMu5vmral-Qy
X-Proofpoint-ORIG-GUID: ZtDm1Rc4ft6nzIEeih2ZSMu5vmral-Qy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMyBTYWx0ZWRfX2KsXxRKZNw8j
 RpknvspDoo3GVpzDBROI12NQdaJCS6/d3IzKeeTtwZbWGKQv3RTIqe//RUCmrgcZfn4vc6GuF+s
 /mFPRPMBUc05z3rKHIlTVt0+Kmgc09I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMyBTYWx0ZWRfX0mdMm2jITiUa
 l/GN4BN8mVs7oI7mzEuO42hYyHFh9ButU2y4UjOlwuvlXHQ5O18Nc1rhS9GcevN1IqPkSqY15qh
 vTmr3203jOQ/h/722cpbK86ZoWCUGziAIO5Dwb705i5077MRcQrtYNsNQHrtYymkHlxVfrfEACu
 3VL6rL3T7dVopt4Cic0Tww8MkGQ52Mah87x06d4siLxDTKHoESLBsdsosIrIphyP/RQ4HtZ2eeW
 APNpHIIp4bAJ2rKXFnibIu4LdOAUKekWjiIq7HWyvh+dsRH93bB9+EacBXeYTrjygcsWAVUva8d
 k6qI0wSXOCbqgdYA5PNps0KRi2dxICbyAhs24lW+VSlbEjaG/sC4hf/MDYaha5X6O6jtGpPzXMG
 FQolrCHH4JTd8B0LVquVZ3lT7E52k6YzZJwJoEmXUl+jOdHZd8Nf50DDdIJm5/C5hmvMJvIxqTJ
 H+qlOkyqv+/7j4FPj6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100223
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Reply-to:  =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
From:  =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/7/26 22:53, Richard Henderson wrote:
> Merge and name bp_wp_hit.  Now that all targets have been
> converted to use debug_excp_handler hit argument, we only
> need one pointer to an outstanding debug event.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h  |  3 +--
>   accel/tcg/cpu-exec.c   |  7 +++---
>   accel/tcg/watchpoint.c |  4 ++--
>   gdbstub/system.c       | 50 ++++++++++++++++++++++--------------------
>   target/arm/hvf/hvf.c   |  5 ++---
>   target/arm/kvm.c       |  2 +-
>   target/i386/kvm/kvm.c  |  4 ++--
>   target/ppc/kvm.c       |  2 +-
>   target/s390x/kvm/kvm.c |  2 +-
>   9 files changed, 39 insertions(+), 40 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 1a42940d92..5401d7c14b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -526,8 +526,7 @@ struct CPUState {
>       /* ice debug support */
>       IntervalTreeRoot breakpoints;
>       IntervalTreeRoot watchpoints;
> -    CPUBreakpoint *breakpoint_hit;
> -    CPUBreakpoint *watchpoint_hit;
> +    CPUBreakpoint *bp_wp_hit;

During the last QEMU community call Alex said these fields are for
TCG, and this series confirms it (also this patch $subject).
I planned to move that to the TCG accelerator state at some point,
but then I'm confused by the uses in the hw accelerators...

> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index c78fb330c4..3f31b75173 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -150,34 +150,36 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
>   
>       switch (state) {
>       case RUN_STATE_DEBUG:
> -        if (cpu->watchpoint_hit) {
> -            const char *type;
> +        {
> +            CPUBreakpoint *hit = cpu->bp_wp_hit;
>   
> -            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
> -            case BP_MEM_READ:
> -                type = "r";
> -                break;
> -            case BP_MEM_ACCESS:
> -                type = "a";
> -                break;
> -            default:
> -                type = "";
> -                break;
> +            if (hit) {
> +                unsigned watch = hit->flags & BP_MEM_ACCESS;
> +
> +                hit->flags &= ~BP_WATCHPOINT_HIT;
> +                cpu->bp_wp_hit = NULL;
> +
> +                if (watch) {
> +                    static const char hit_type[4][2] = {
> +                        [BP_MEM_READ] = "r",
> +                        [BP_MEM_WRITE] = "",
> +                        [BP_MEM_ACCESS] = "a",
> +                    };
> +                    const char *type = hit_type[watch];
> +
> +                    trace_gdbstub_hit_watchpoint(type, gdb_get_cpu_index(cpu),
> +                                                 hit->hitaddr);
> +                    g_string_printf(buf, "T%02xthread:%s;%swatch:%"
> +                                    VADDR_PRIx ";",
> +                                    GDB_SIGNAL_TRAP, tid->str, type,
> +                                    hit->hitaddr);
> +                    goto send_packet;
> +                }
> +                /* else breakpoint */
>               }
> -            trace_gdbstub_hit_watchpoint(type,
> -                                         gdb_get_cpu_index(cpu),
> -                                         cpu->watchpoint_hit->hitaddr);
> -            g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
> -                            GDB_SIGNAL_TRAP, tid->str, type,
> -                            cpu->watchpoint_hit->hitaddr);
> -
> -            cpu->watchpoint_hit->flags &= ~BP_WATCHPOINT_HIT;
> -            cpu->watchpoint_hit = NULL;
> -            goto send_packet;
> -        } else {
>               trace_gdbstub_hit_break();
> +            ret = GDB_SIGNAL_TRAP;
>           }
> -        ret = GDB_SIGNAL_TRAP;
>           break;
>       case RUN_STATE_PAUSED:
>           trace_gdbstub_hit_paused();
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 32e5f43ee3..0fd72c5bde 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2370,13 +2370,12 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>   
>           cpu_synchronize_state(cpu);
>   
> -        CPUBreakpoint *wp =
> -            find_hw_watchpoint(cpu, excp->virtual_address);
> +        CPUBreakpoint *wp = find_hw_watchpoint(cpu, excp->virtual_address);
>           if (!wp) {
>               error_report("EXCP_DEBUG but unknown hw watchpoint");
>           }
>           wp->hitaddr = excp->virtual_address;
> -        cpu->watchpoint_hit = wp;
> +        cpu->bp_wp_hit = wp;
>           break;
>       }
>       case EC_DATAABORT: {
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index c2f921095a..f66332299c 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1520,7 +1520,7 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
>           CPUBreakpoint *wp = find_hw_watchpoint(cs, debug_exit->far);
>           if (wp) {
>               wp->hitaddr = debug_exit->far;
> -            cs->watchpoint_hit = wp;
> +            cs->bp_wp_hit = wp;
>               return true;
>           }
>           break;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 2e1ecb1c83..c4f0dc1e02 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6263,13 +6263,13 @@ static int kvm_handle_debug(X86CPU *cpu,
>                           break;
>                       case 0x1:
>                           ret = EXCP_DEBUG;
> -                        cs->watchpoint_hit = &hw_watchpoint;
> +                        cs->bp_wp_hit = &hw_watchpoint;
>                           hw_watchpoint.hitaddr = hw_breakpoint[n].addr;
>                           hw_watchpoint.flags = BP_MEM_WRITE;
>                           break;
>                       case 0x3:
>                           ret = EXCP_DEBUG;
> -                        cs->watchpoint_hit = &hw_watchpoint;
> +                        cs->bp_wp_hit = &hw_watchpoint;
>                           hw_watchpoint.hitaddr = hw_breakpoint[n].addr;
>                           hw_watchpoint.flags = BP_MEM_ACCESS;
>                           break;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f161ba6415..f11f8457d0 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1592,7 +1592,7 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>               n = find_hw_watchpoint(arch_info->address, &flag);
>               if (n >= 0) {
>                   handle = DEBUG_RETURN_GDB;
> -                cs->watchpoint_hit = &hw_watchpoint;
> +                cs->bp_wp_hit = &hw_watchpoint;
>                   hw_watchpoint.hitaddr = arch_info->address;
>                   hw_watchpoint.flags = flag;
>               }
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index b75dab5f3c..5c3cde97b8 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1863,7 +1863,7 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
>       switch (arch_info->type) {
>       case KVM_HW_WP_WRITE:
>           if (find_hw_breakpoint(arch_info->addr, -1, arch_info->type)) {
> -            cs->watchpoint_hit = &hw_watchpoint;
> +            cs->bp_wp_hit = &hw_watchpoint;
>               hw_watchpoint.hitaddr = arch_info->addr;
>               hw_watchpoint.flags = BP_MEM_WRITE;
>               ret = EXCP_DEBUG;


