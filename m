Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52B606A69A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uvv/apN1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J7XYDDES
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUHm-0003q2-Ek; Mon, 23 Nov 2026 08:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUHd-0003i8-Nb
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:40:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUHZ-0003DW-Of
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:40:36 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDL45E3072614
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S4q7mqd46LjCgGPWPaesCDlWvj+VzOK+/hpkAjTf4pU=; b=Uvv/apN1/cB/exiy
 ScG2jyv6Lw1OtCJHV1C3CRLVswqbkT5e7bk7b0s5tawAAE3q+eDpc09E7g8GyMT1
 K8soekjIVjuyrnictL75IEozn3RFmJ3vERVLu3h95wHMAlsZ5Tf5vfyjpv9B3P57
 4iSWDz8z81PjBMzMdg8VKLhw8Z8femSD6obLiRi805ZJvcMsYrUCtXb/JEdci6ZS
 Gnogr/nHCXjPZbXGtY+50YLkVzhy8Kd4v+jd8u5JgwNWxQv1MS7OR4qGwbOV6fwO
 L/u2gwVZV71+rTKqk96MNxTscF+nJAJN2KTWTFz4f3/FqI+XkNl6J2JwRQ7LkPpR
 JdY/mQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7s7mk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:40:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso73216036d6.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795441232; x=1796046032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S4q7mqd46LjCgGPWPaesCDlWvj+VzOK+/hpkAjTf4pU=;
 b=J7XYDDES+o4hOmzD1X4ggVIrFL2OucoCW8+dAUhzSk+n2pmAfhQDDr+uSOOMfhX/+i
 cQ7+azGZ56OmoXFlMVcclMgpxCJzJ4A8BfgyyI4fICMj30NyCcVdYJ9kkVwF7dXHxT62
 9nc8PIuIn0s/eSRdgdj+Nezp/k+GmjV2D1sr/XM+uGevnpLKUSRMdk4AxNE01cPklL9x
 j7OCwnrk03E3+2uC3eskeAJvQsKpJx3dQtXYjQCJvyaTpcX5hi36WIygoUyGLBNKR8P+
 bRAMr74fhEnMKbjrboJTrfi4bPu1+Qvs2p/oF0OEd+16775Nj/elVmXiWL0AEHTaT71F
 /fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441232; x=1796046032;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S4q7mqd46LjCgGPWPaesCDlWvj+VzOK+/hpkAjTf4pU=;
 b=AVWROGcCw4X/pJ30x3pIgSt6CTOo8YrL/cX6z1PZnX4F7z1vE3AYfzRL/j69FuO1XH
 IfLHgpWAYe8C9cErkcrqnILoketme1qjZLBuLLmNuXkCURZCb3hjo4obZsV1GLnQCxyX
 oIUMr71XY7Eaxjn24e0iZHReGL4ISeK2nz3S1L8xVjg5KrckjxHi9NUyR4/GVfjrvQPI
 TLznWMgYjSMnb+D8LEWBpi+/w4nCJMfMQOI7kBSbhvyP3lJz8PoeMOpN+bFZQniefaTW
 FbSwnlolxUiv+ypJ+RaXD61dGgf0Fyp4NenqDgggV6//d9jJv1UpjshrbZASG8iH6SFT
 GSig==
X-Forwarded-Encrypted: i=1;
 AL+hErFGBDphn1KcateCbFwkthLi5qUT67LJ80CJbNgoanF1wjLXPgaWusiPKC66fNsNzjyOQQ6Mx+1FxEnV@nongnu.org
X-Gm-Message-State: APuU4Z9b6R42yX209+awaM2Xf7mSks3YYoDWzOUwY9Fq401ppZ7qowpJ
 BBA5HGcjy5XsdedzIjMxJmDRYS8PLdAMhhfA5yhcFrbXr7YKPXA0Lk7z7gHH3oyQo2eDgd/yhvy
 6pPTf1md5i/FqBrpxuuUGUWbwiB9EpFzuPscNFjUopymH9dpYv9GjutyScg==
X-Gm-Gg: AZFdTZfZz0y5u+ldgzZicEak98OEQR8ggU1nho3/ZLaTww0e51V3abina23yc5HRPbC
 O3QdwPNi+V32N6PPwEIsIDLQZe8Q9IO4gyedmdjUQ07To0FHa3eAg+tHBKn81W9cHZBZaf7mL7u
 73pOVd99uUXmBUDfl3K9nEZV43JpByAMmFC368pasZYWJazDH3MMHlRzWWE6i7ToXFfB9ZS92rz
 9ZAc+UCMfvXdNssZAzuPW9P45+JZyX90tEwl9TuxkDojxf4BrneRB+IIYZXcoAu6qidFR0rGrHG
 9HqvFYrLGe+wOD6DMu7Z2FWsHlbD/uY1/l8ySc8UR9BGJLHtlNvTI5rN9kVbkxs/PEtRdjmtEkg
 GpsChSLpZEfuQWqr91CWEy2Ovb0eGmntvsbl5unPzNRJik4n0ZjSYd02Ef258HhrpbOeW234I7B
 Gms/eE4ULf
X-Received: by 2002:a05:6214:3bc5:b0:91e:9ada:f270 with SMTP id
 6a1803df08f44-9212e1057e2mr262635196d6.27.1795441231667; 
 Mon, 23 Nov 2026 05:40:31 -0800 (PST)
X-Received: by 2002:a05:6214:3bc5:b0:91e:9ada:f270 with SMTP id
 6a1803df08f44-9212e1057e2mr262634486d6.27.1795441230844; 
 Mon, 23 Nov 2026 05:40:30 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349ec64csm106376886d6.28.2026.11.23.05.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:40:30 -0800 (PST)
Message-ID: <5765954d-e262-47e6-89b9-3d34af6342ef@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:40:27 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/riscv: Fix icount trigger exception PC
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20261113084622.738278-1-himanshu.chauhan@oss.qualcomm.com>
 <20261113084622.738278-3-himanshu.chauhan@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261113084622.738278-3-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b044250 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Xt3aY7vK3ztYvYV0jf0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX+1Dw6QwJ+/T4
 G67YrGD0+OqvpMd81XQNy/iRJCwvdY43tEZkpvAkGfz5QuVeNnthaobL8yzQepAn8LTa6k4hj9a
 FsOgCVl3z2u6FuBVhGpsnwoLCzH3gtcFYnoXoJ6qmax9AdN8Eknmt0tleTL9tKya3YeSl5BqbE7
 jLJvJkA2twHCqsynH6jNdBnN/+tVg81nGuqvvR6WCv/8XDY72/waE0lzH/UWLgLaP8B2mRj7k/N
 G9N1sUr2VSo9lDXGgjTh3p0lpgfsGRvjiZ5nfaZPVfJlS+OVlnjEAb2sD4xS2MSaD8zfpXeVe7d
 92zkcTj9gtkHGNSDA45uyewl3pPBrHAsE0g2P1uncglyYxAnMS4LIFh1F/XE2/dFh6kDZJUoTNx
 vmeWC+9FkBjKeKP+qCUxD5cDmrmgFRiV6g50DOb9wcxR8s0h0lzlTs0DjP2OPUxWYG4JSAssQxR
 QgYpUk+ElkOcPXI7u1g==
X-Proofpoint-GUID: XQspZsggG-4HJlibQiEaz6PJOFeJ_AmA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX0ZWwc5LHR2CA
 v+BebNb8FgHF74JuaxAXf/i8qau+/gk1F5qt/hd2CWA1OVmYEMknEPpOWvWIP5HFcfwYQRTck0W
 0BOvTQX5Qz+ehqQ2S3mPMU219PjTiNE=
X-Proofpoint-ORIG-GUID: XQspZsggG-4HJlibQiEaz6PJOFeJ_AmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230054
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/13/2026 5:46 AM, Himanshu Chauhan wrote:
> Per the Sdtrig specification, on a breakpoint exception with icount, xepc
> must contain the virtual address of the next instruction to execute so
> program flow is preserved. A one-instruction trigger must therefore fire
> only after the counted instruction retires, and xepc must contain the
> architectural successor PC: the branch target for a taken branch, or the
> fallthrough PC otherwise.
> 
> QEMU previously disabled the translated-block trigger flag when icount was
> enabled and relied on timer and privilege-change callbacks to update the
> count. That allowed the trigger to fire outside instruction retirement
> before the guest PC advanced, causing Linux to observe the old PC and
> re-enter the same breakpoint while single-stepping with icount.
> 
> Fix this by publishing the icount trigger flag in translated blocks even
> with icount enabled. The translated helper now decrements the trigger count
> after the instruction has committed its successor PC and raises the trigger
> action only then. Privilege-mode changes, context CSR writes and migration
> post-load refresh the cached enabled state because icount trigger matching
> depends on the current mode and context.
> 
> Remove the old itrigger timers because instruction counting is now tied
> to translated instruction retirement instead of virtual-time callbacks.
> 
> Fixes: 5a4ae64cac49 ("target/riscv: Add itrigger support when icount is enabled")
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.h            |   5 +-
>   target/riscv/machine.c        |   5 +-
>   target/riscv/tcg/cpu_helper.c |  10 +--
>   target/riscv/tcg/csr.c        |   3 +
>   target/riscv/tcg/debug.c      | 121 +++++-----------------------------
>   target/riscv/tcg/tcg-cpu.c    |   7 +-
>   6 files changed, 33 insertions(+), 118 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 49a1186bdb..3109d71470 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -484,8 +484,7 @@ struct CPUArchState {
>       uint8_t trigger_cur;
>       /*
>        * num_triggers is the length of tdata1, tdata2, tdata3,
> -     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
> -     * arrays.
> +     * cpu_breakpoint and cpu_watchpoint arrays.
>        */
>       uint32_t num_triggers;
>       uint64_t *tdata1;
> @@ -493,8 +492,6 @@ struct CPUArchState {
>       uint64_t *tdata3;
>       struct CPUBreakpoint **cpu_breakpoint;
>       struct CPUWatchpoint **cpu_watchpoint;
> -    QEMUTimer **itrigger_timer;
> -    int64_t last_icount;
>       bool itrigger_enabled;
>   
>       /* machine specific rdtime callback */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0de06e9588..74176e7c6e 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -22,7 +22,6 @@
>   #include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "migration/cpu.h"
> -#include "exec/icount.h"
>   #include "target/riscv/tcg/debug.h"
>   #ifdef CONFIG_KVM
>   #include "kvm/kvm_riscv.h"
> @@ -339,9 +338,7 @@ static int debug_post_load(void *opaque, int version_id)
>       RISCVCPU *cpu = opaque;
>       CPURISCVState *env = &cpu->env;
>   
> -    if (icount_enabled()) {
> -        env->itrigger_enabled = riscv_itrigger_enabled(env);
> -    }
> +    env->itrigger_enabled = riscv_itrigger_enabled(env);
>   
>       return 0;
>   }
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 58e98e975c..0375b930be 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -940,10 +940,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>   
>       if (newpriv != env->priv || env->virt_enabled != virt_en) {
> -        if (icount_enabled()) {
> -            riscv_itrigger_update_priv(env);
> -        }
> -
>           riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
>       }
>   
> @@ -982,6 +978,12 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>               riscv_cpu_interrupt(env);
>           }
>       }
> +
> +    /*
> +     * Icount triggers are scoped by U/S/M and VU/VS mode bits.  Refresh the
> +     * cached translated-block flag after privilege or virtualization changes.
> +     */
> +    riscv_itrigger_update_priv(env);
>   }
>   
>   /*
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index af444e3e6f..7c05c866fd 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -5732,6 +5732,9 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
>       }
>   
>       env->mcontext = val & mask;
> +#if !defined(CONFIG_USER_ONLY)
> +    env->itrigger_enabled = riscv_itrigger_enabled(env);
> +#endif
>       return RISCV_EXCP_NONE;
>   }
>   
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index 2067657c81..a84d8eb4cf 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -32,8 +32,6 @@
>   #include "trace.h"
>   #include "exec/helper-proto.h"
>   #include "exec/watchpoint.h"
> -#include "system/cpu-timers.h"
> -#include "exec/icount.h"
>   #include "accel/tcg/cpu-loop.h"
>   
>   /*
> @@ -768,21 +766,6 @@ itrigger_set_pending(CPURISCVState *env, int index, int val)
>                                      ITRIGGER_PENDING, val);
>   }
>   
> -static bool check_itrigger_priv(CPURISCVState *env, int index)
> -{
> -    target_ulong tdata1 = env->tdata1[index];
> -    if (env->virt_enabled) {
> -        /* check VU/VS bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_VU) == env->priv);
> -    } else {
> -        /* check U/S/M bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_U) == env->priv);
> -    }
> -}
> -
>   bool riscv_itrigger_enabled(CPURISCVState *env)
>   {
>       int count;
> @@ -790,7 +773,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
>           if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
>               continue;
>           }
> -        if (check_itrigger_priv(env, i)) {
> +        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
>               continue;
>           }
>           count = itrigger_get_count(env, i);
> @@ -817,7 +800,12 @@ void HELPER(itrigger_match)(CPURISCVState *env)
>           if (!count) {
>               continue;
>           }
> -        itrigger_set_count(env, i, count--);
> +        /*
> +         * This helper is emitted at TB exit after one guest instruction and
> +         * after the translator has committed env->pc to the successor PC.
> +         */
> +        count--;
> +        itrigger_set_count(env, i, count);
>           if (!count) {
>               /*
>                * From the 1.0 spec: "When pending is set, the trigger
> @@ -832,6 +820,9 @@ void HELPER(itrigger_match)(CPURISCVState *env)
>                *
>                * Note that itrigger_set_pending() is a no-op if we're
>                * running debug 0.13.
> +             *
> +             * Software writes still validate pending as a read-only field;
> +             * QEMU only toggles it internally around the trigger action.
>                */
>               itrigger_set_pending(env, i, 1);
>   
> @@ -844,53 +835,13 @@ void HELPER(itrigger_match)(CPURISCVState *env)
>   
>   static void riscv_itrigger_update_count(CPURISCVState *env)
>   {
> -    int count, executed;
>       /*
> -     * Record last icount, so that we can evaluate the executed instructions
> -     * since last privilege mode change or timer expire.
> +     * Icount triggers are matched from translated code after an instruction
> +     * has committed its successor PC.  Timer and privilege-change callbacks
> +     * therefore must not decrement count or fire the action here; they only
> +     * refresh the cached TB flag state.
>        */
> -    int64_t last_icount = env->last_icount, current_icount;
> -    current_icount = env->last_icount = icount_get_raw();
> -
> -    for (int i = 0; i < env->num_triggers; i++) {
> -        if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
> -            continue;
> -        }
> -        count = itrigger_get_count(env, i);
> -        if (!count) {
> -            continue;
> -        }
> -        /*
> -         * Only when privilege is changed or itrigger timer expires,
> -         * the count field in itrigger tdata1 register is updated.
> -         * And the count field in itrigger only contains remaining value.
> -         */
> -        if (check_itrigger_priv(env, i)) {
> -            /*
> -             * If itrigger enabled in this privilege mode, the number of
> -             * executed instructions since last privilege change
> -             * should be reduced from current itrigger count.
> -             */
> -            executed = current_icount - last_icount;
> -            itrigger_set_count(env, i, count - executed);
> -            if (count == executed) {
> -                do_trigger_action(env, i);
> -            }
> -        } else {
> -            /*
> -             * If itrigger is not enabled in this privilege mode,
> -             * the number of executed instructions will be discard and
> -             * the count field in itrigger will not change.
> -             */
> -            timer_mod(env->itrigger_timer[i],
> -                      current_icount + count);
> -        }
> -    }
> -}
> -
> -static void riscv_itrigger_timer_cb(void *opaque)
> -{
> -    riscv_itrigger_update_count((CPURISCVState *)opaque);
> +    env->itrigger_enabled = riscv_itrigger_enabled(env);
>   }
>   
>   void riscv_itrigger_update_priv(CPURISCVState *env)
> @@ -925,18 +876,10 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
>   
>       switch (tdata_index) {
>       case TDATA1:
> -        /* set timer for icount */
>           new_val = itrigger_validate(env, val);
>           if (new_val != env->tdata1[index]) {
>               env->tdata1[index] = new_val;
> -            if (icount_enabled()) {
> -                env->last_icount = icount_get_raw();
> -                /* set the count to timer */
> -                timer_mod(env->itrigger_timer[index],
> -                          env->last_icount + itrigger_get_count(env, index));
> -            } else {
> -                env->itrigger_enabled = riscv_itrigger_enabled(env);
> -            }
> +            env->itrigger_enabled = riscv_itrigger_enabled(env);
>           }
>           break;
>       case TDATA2:
> @@ -945,33 +888,17 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
>           break;
>       case TDATA3:
>           env->tdata3[index] = textra_validate(env, val);
> +        env->itrigger_enabled = riscv_itrigger_enabled(env);
>           break;
>       default:
>           g_assert_not_reached();
>       }
>   }
>   
> -static int itrigger_get_adjust_count(CPURISCVState *env)
> -{
> -    int count = itrigger_get_count(env, env->trigger_cur), executed;
> -    if ((count != 0) && check_itrigger_priv(env, env->trigger_cur)) {
> -        executed = icount_get_raw() - env->last_icount;
> -        count += executed;
> -    }
> -    return count;
> -}
> -
>   target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
>   {
> -    int trigger_type;
>       switch (tdata_index) {
>       case TDATA1:
> -        trigger_type = extract_trigger_type(env,
> -                                            env->tdata1[env->trigger_cur]);
> -        if ((trigger_type == TRIGGER_TYPE_INST_CNT) && icount_enabled()) {
> -            return deposit64(env->tdata1[env->trigger_cur], 10, 14,
> -                             itrigger_get_adjust_count(env));
> -        }
>           return env->tdata1[env->trigger_cur];
>       case TDATA2:
>           return env->tdata2[env->trigger_cur];
> @@ -1163,8 +1090,6 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>   
>   void riscv_trigger_realize(CPURISCVState *env)
>   {
> -    int i;
> -
>       if (env->num_triggers > RV_MAX_TRIGGERS) {
>           error_report(
>                   "Invalid configuration: 'num-triggers' must be less than %u",
> @@ -1177,12 +1102,6 @@ void riscv_trigger_realize(CPURISCVState *env)
>       env->tdata3 = g_new0(uint64_t, env->num_triggers);
>       env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
>       env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
> -    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
> -
> -    for (i = 0; i < env->num_triggers; i++) {
> -        env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              riscv_itrigger_timer_cb, env);
> -    }
>   }
>   
>   void riscv_trigger_unrealize(CPURISCVState *env)
> @@ -1193,11 +1112,6 @@ void riscv_trigger_unrealize(CPURISCVState *env)
>   
>       g_free(env->cpu_breakpoint);
>       g_free(env->cpu_watchpoint);
> -
> -    for (int i = 0; i < env->num_triggers; i++) {
> -        timer_free(env->itrigger_timer[i]);
> -    }
> -    g_free(env->itrigger_timer);
>   }
>   
>   void riscv_trigger_reset_hold(CPURISCVState *env)
> @@ -1225,7 +1139,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>           env->tdata3[i] = 0;
>           env->cpu_breakpoint[i] = NULL;
>           env->cpu_watchpoint[i] = NULL;
> -        timer_del(env->itrigger_timer[i]);
>       }
>   
>       env->mcontext = 0;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5834ec1524..027fe5b46a 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -181,8 +181,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>       }
>   
> -    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
> -        && !icount_enabled()) {
> +    /*
> +     * Publish itrigger state even when QEMU icount is enabled.  The helper
> +     * runs from translated code after committing the guest successor PC.
> +     */
> +    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>           flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>       }
>   #endif


