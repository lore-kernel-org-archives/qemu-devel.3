Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605B606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AiuLniX1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q182e1rK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJbOr-0003wF-IE; Wed, 21 Oct 2026 14:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJbOq-0003sn-B4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:50:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJbOo-0004A5-7B
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:50:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpAFM1359164
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o2Dp3S3JPLh03/tNEB7AIFX/p8Hdvb1C6Z1SsbCdJpU=; b=AiuLniX1mpRECtNH
 us3+ti4mUTzywWxCzjDo8mXHisJe3XZZkS5ODDRyhpalRDx+DctPzR/SXVkm6Vvh
 7i6dAmo4YE3JVfmYDryCuLiKisCF4jYcdi8HH5tevovNOAId2uXxFzp9GRZ40/fL
 TogKTpBO+g9qdn73+xK8Ibdg0BSKQpSSVZmuHFSQqxnm1gmhHH9vfG8J09OhHhBb
 mFgMWVjeZY34SDmJS84l9ef1g616uaqHnsbELg9qyIK+ftTdCAHSgOn3dbbqBKKD
 GkQj8mrMb/QDYLo4gRXEKaPHop1kCtJKst8UInM7BrAUB3ibMUNNTOc1yqV29Cob
 ELN+2Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4abpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:50:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338974c0ceso30608171cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792608651; x=1793213451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o2Dp3S3JPLh03/tNEB7AIFX/p8Hdvb1C6Z1SsbCdJpU=;
 b=Q182e1rKYfNCzoXkuoueyIpIA3tRgVKzDX3OxkZQ42Ds3zQaI4+hym4czeRwzBfe5C
 aSpLp9VOTXhEr5dgjYjShDgTKgAJ5gpfGsEqULZubv7RGbPbifj0Qir21W8BmCxS9Hnc
 SMI6OoFkS6psE8vYXTFyOsXtlYoB00OxoDN6JLgan2kY5W8kUDpsACu3ZAISnKJBIU5Q
 YKeO6/gvFc9JKIQ8LNrSa33JxETCc8WPD6CcwIlb9XH6Y8WMORQURBXE3YSfUTuo+7PA
 6/GHrS8n4iVnqdICxW9OAmLj0CHYJdQ7YHM3dNoYPimTxrD+cdeHQH03M9HVhNwXSuO6
 oMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792608651; x=1793213451;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o2Dp3S3JPLh03/tNEB7AIFX/p8Hdvb1C6Z1SsbCdJpU=;
 b=LYpnqEc0XHwPvZTH0Ld9irccmgqQaLPA22/uyeOO/grrcdeD773nLN2iuV7YBrzLGG
 j9MKFBIhInpun/JTP/90ziTvjzb4X9Kw4muJqp3qfrR8jkW0vhBud+lZZXTwJDVPek0G
 toB5VKrGtJqOAwWLmFboGkPu9QCQGLxxLlkZS4NwiCZXQFO4Hon1yoGhdIJOJaaKw4nx
 cwppt+vPgzSMF8TJOHqGKyWy5zcHIN+QHocYkNkwToEQ+k1WL4RcA+5CUi+nSkLLdWMN
 oO5CXfqyKKxDxBZvmAw+C+CAhz/fPntFbZXkcf+v+ZYhovpD6R3gbzIVmnwEyUwmfMaQ
 bINA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE70oewL961tMAQh6nWDuxyE8JmYsknbcIcXb7Bo7aMh4fkudT5cYJfGEJ8R7+gXdjM8uxbiX1HpWS@nongnu.org
X-Gm-Message-State: AFq9FYI1TphdTSeatT0f5o6fuGK2FJqeTLy6w+nDCBKMu1Yzl40+CnDx
 opvZPtxNZdlXqyPe7Mh+IcmT51SjTkZNKYl8uqyvuNusuTZpKy12Ly5q9LPoe1ANGrFSUJ0dl7N
 LzZVbeHq5l9VZzb1UtAmER3oToAzN/ApG6/QUWhpaxmMRfgbFkmehgycWFg==
X-Gm-Gg: AYBFou2LaK0B03LMb7+NvBL3R9BvOjLMJNxeP1DgGasvh0zEMZyfXaQge9iIBdYZzGT
 l5EyEi6cIJgKWWSlt3BskSCzkoSGhKVweU28H6D69TvZcadYiuEwYBe095RAcQziZkwo06gaNtd
 p1iITFQHzRkQGuH1uD6H+RfQHjBErwOEiOENN/MEkIa+zmdYpyE9lVAe754YDp4IOzOQM3+dMOB
 EM1lzQcNtGyUHgNDLawLsdgh2C3lxNenCmIhkOCQA0ziA4GChh5AetDHKddhwXmwmhi7Fparn+1
 zui/qu5/0+TMFVn3tePZbOROS9BsnqMPhJXJhqa8PTNnTxguoczvqVq9/18xpdDQMyA7IMDMAq1
 FzXXVLS5pKTKUR6iyxs4DZ1Xug3Lf7AqjVPsN2+/X6U3TUXVkWfirUau9tvapykQkDXQuouUB
X-Received: by 2002:ac8:5ac4:0:b0:536:1f7a:610e with SMTP id
 d75a77b69052e-5369b5a5426mr49637351cf.6.1792608650425; 
 Wed, 21 Oct 2026 11:50:50 -0700 (PDT)
X-Received: by 2002:ac8:5ac4:0:b0:536:1f7a:610e with SMTP id
 d75a77b69052e-5369b5a5426mr49637061cf.6.1792608649919; 
 Wed, 21 Oct 2026 11:50:49 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab723d98sm6330791cf.13.2026.10.21.11.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:50:49 -0700 (PDT)
Message-ID: <2949aabb-200f-44bd-9b9d-4d0ceaaf77e4@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:50:46 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hw/riscv: share the PLIC interrupt cells between
 boards
To: Ralf Ramsauer <ralf@vmexit.de>, qemu-devel@nongnu.org
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
References: <20261021110838.3097959-1-ralf@vmexit.de>
 <20261021110838.3097959-5-ralf@vmexit.de>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021110838.3097959-5-ralf@vmexit.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rDm0TaxGoBxrDc5yHEwi3NVqt2XHRzqi
X-Proofpoint-GUID: rDm0TaxGoBxrDc5yHEwi3NVqt2XHRzqi
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad9098b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=MtFd9EPPngaKLdiOwr0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NSBTYWx0ZWRfX3u2zS51w0Y4v
 fg0KTH7NbKLMmFCDUtiVddvaw5TJONjVdiJfmD7CczhuNX35Q3hZgE5iS9kAD0OaMTkd62cPwuM
 m37LWw2vrXuz1RPaNEKvQC7J5dGFvXr5AEbVGuqw/2gycFZlxWnSRYIFmG/rOctpIMSSzX+f9c2
 RhPz4QXY9DxOeOZbMqzJPvnuq9q1g3Rcmo7MLAZFNNkG3xbqYVCYhYrP4QOZL7IQzGCmTeysw4C
 eZqjUhIVYd+/sNCfv9+L/BeMelyX2SNt3P0L46cQs8QvHQaZ0ktW6rXvaAzj+T7w082Wyc8jINQ
 BZVK61ChRc21ShF0WbVL9XfSex83k3v+iq10vuiEmv1CJoN9hy7serzfIwS4qUfmskjriBUofxG
 EoscYRCaud1dvzVtfjsWd9aNWviUi3w0Q5aeNA6D3XHTnoYO3eoMaYr3FQqrzmfBFHMCi9POuyO
 AVqejilK7XsCJyfnpfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NSBTYWx0ZWRfX9N3aN8uLakEw
 7dJ7nGojhwegCLoggct4qJiWNmPcApTifnLv1kSbbVI4Xgj3nRhgdSEDK8Z3GyKFwC5DnOp83Z3
 ihx2R9W1xyoziH4Vh0K37DFrnVKXp+Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/21/2026 8:08 AM, Ralf Ramsauer wrote:
> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> 
> virt and sifive_u now describe a hart's PLIC contexts with the same rule:
> a machine context unless the hart runs under KVM, where there is no
> M-mode, and a supervisor context if the hart has supervisor mode.
> Writing that rule down twice is what let the virt device tree drift away
> from riscv_plic_hart_config_string().
> 
> This makes the sifive_u device tree ask whether KVM is in use, which it
> did not do before.  Its PLIC device already does, so the two now agree.
> 
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---
> Cleanup, not a fix.  Can be dropped, the rest does not depend on it.
> 
>   hw/riscv/fdt-common.c         | 20 ++++++++++++++++++++
>   hw/riscv/sifive_u.c           | 10 ++--------
>   hw/riscv/virt.c               | 12 +++---------
>   include/hw/riscv/fdt-common.h |  3 +++
>   4 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index ce2dcb43b4..70f96734b4 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -10,6 +10,7 @@
>   
>   #include "qemu/error-report.h"
>   #include "system/device_tree.h"
> +#include "system/kvm.h"
>   #include "hw/core/boards.h"
>   #include "hw/core/sysbus-fdt.h"
>   #include "hw/riscv/fdt-common.h"
> @@ -212,6 +213,25 @@ riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
>                                      phandle, intc_phandles, false, false);
>   }
>   
> +uint32_t riscv_plic_hart_fdt_cells(uint32_t *cells, RISCVCPU *hart,
> +                                   uint32_t intc_phandle)
> +{
> +    uint32_t len = 0;
> +
> +    /* harts running under KVM have no M-mode */
> +    if (!kvm_enabled()) {

In this file we're trying to keep it as bland as possible w.r.t accelerator logic.
The idea is that the boards will do accelerator considerations and just point
the fdt functions what to write in the fdt.  This will make it less annoying to deal
with accel differences across multiple files ... ideally.

For example in virt.c we have:

     riscv_fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);

The above calls this fdt helper:

void riscv_fdt_create_cpu_socket_subnode(void *fdt,
                                          uint64_t timebase_frequency)

I.e. the fdt helper only cares about timebase_frequency to blindly put it in the
fdt.  It doesn't care if it's kvm or not.

So for this helper I suggest something like:

uint32_t riscv_plic_hart_fdt_cells(uint32_t *cells, RISCVCPU *hart,
                                    uint32_t intc_phandle, bool has_m_mode)

{
     uint32_t len = 0;

     if (has_m_mode) {
         ...
     }
     ...
}

And then virt.c and sifive_u.c makes accellerator considerations if needed.
E.g.:


riscv_plic_hart_fdt_cells(&cells[cells_length], hart,
                           intc_phandles[cpu], !kvm_enabled());


Thanks,
Daniel

> +        cells[len++] = cpu_to_be32(intc_phandle);
> +        cells[len++] = cpu_to_be32(IRQ_M_EXT);
> +    }
> +
> +    if (riscv_cpu_has_supervisor_mode(hart)) {
> +        cells[len++] = cpu_to_be32(intc_phandle);
> +        cells[len++] = cpu_to_be32(IRQ_S_EXT);
> +    }
> +
> +    return len;
> +}
> +
>   void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
>                              uint32_t plic_phandle, uint32_t int_cells,
>                              uint32_t addr_cells, uint32_t *plic_cells,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 8f50c67a14..456b6da3e6 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -201,14 +201,8 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>       for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
>           /* cpu 0 is the management hart that does not have S-mode */
>           hart = cpu ? &s->soc.u_cpus.harts[cpu - 1] : &s->soc.e_cpus.harts[0];
> -
> -        cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> -        cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
> -
> -        if (riscv_cpu_has_supervisor_mode(hart)) {
> -            cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> -            cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
> -        }
> +        cells_length += riscv_plic_hart_fdt_cells(&cells[cells_length], hart,
> +                                                  intc_phandles[cpu]);
>       }
>   
>       riscv_create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a2851b506d..a325891dca 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -161,15 +161,9 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>       cells_length = 0;
>   
>       for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> -        if (!kvm_enabled()) {
> -            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
> -        }
> -
> -        if (riscv_cpu_has_supervisor_mode(&s->soc[socket].harts[cpu])) {
> -            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
> -        }
> +        cells_length += riscv_plic_hart_fdt_cells(&plic_cells[cells_length],
> +                                                  &s->soc[socket].harts[cpu],
> +                                                  intc_phandles[cpu]);
>       }
>   
>       plic_phandles[socket] = (*phandle)++;
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index eb9db8278d..14116a95cf 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -93,6 +93,9 @@ void riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
>                                           int socket_hartid_base,
>                                           uint32_t *phandle,
>                                           uint32_t *intc_phandles);
> +/* Describe one hart's PLIC contexts, returns the number of cells written */
> +uint32_t riscv_plic_hart_fdt_cells(uint32_t *cells, RISCVCPU *hart,
> +                                   uint32_t intc_phandle);
>   void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
>                              uint32_t plic_phandle, uint32_t int_cells,
>                              uint32_t addr_cells, uint32_t *plic_cells,


