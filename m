Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A958606A33A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KsbouDD7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZRHhTM+2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTj0-0007T1-Va; Mon, 23 Nov 2026 08:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTiJ-0007Nj-TD
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:04:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTiG-0001Ju-FX
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:04:07 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANCFx8O2225894
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7qZo/yrXjbMqjQBDYG9UyuTKNcNF6kZXsk0Ch4SOzGw=; b=KsbouDD7/Iebc3Qp
 8MV9YYbieFIS2xez01ZEzUTUOFr9yWnisM9J2y4VEnr2O106uHjJBDtn7qoL7b9x
 mtmR6kKUugKuWUScR3/dPust+ZU6U2jUQIxPA3jGEQRBHRsHMvsY52YWtOnxp0tz
 MAenCiueL2aEGACg4vB1xQj5Ox3+XfuLYDfzMshxNJYeG/LVLH5AUAd/TQScD7f+
 3fUKiYVSq+2afflzQNM9rGLShZ7bc8TiPc7AB+Fc4wwYXnh8+x4Gg4Tdc1JvZfw3
 7zWF1cjb3JIW0FxAk6QzFscUCmZPUyIsat548vuPvwchfFuVd//1l6SYJ8busUvp
 PnFPjg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1p9e4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:04:02 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b0f1c06332so49081997b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795439042; x=1796043842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qZo/yrXjbMqjQBDYG9UyuTKNcNF6kZXsk0Ch4SOzGw=;
 b=ZRHhTM+2bawQxbCDy9M8JweWNn2gJcxwDnsLrTQs3/uIU91TTGgT84XTlJ40m8Z0K2
 kPfGWZ+yAkzx7SmTOFhNOAtFZi6KIlOrscklwc34AN9AwilhTm1JdC88WtB5Tj4SKcV6
 ypIBklGSBGHl7nPDvsl8xqhu15YCqsBryMexMG3RrouwxSQe9L2XmTul8BzmiHh4Ax+O
 j3nQ+qUMKGKpYeki5NPbHd6jBgTVWacUDbZiljCouixX1C+hxqqxcPP/h31KjpPiB0MI
 +7LK6WSVRgLfY4a2x2o2V1YaW+OnEJlwMkdFzwC12j9WbpoBgwdjNkQDNnpeCLvWon8A
 THOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795439042; x=1796043842;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7qZo/yrXjbMqjQBDYG9UyuTKNcNF6kZXsk0Ch4SOzGw=;
 b=ynEv58NCT+HjSMNzT5jPOAzpLp7HfvlBQ47xGRIvQQHNqeoJAZDDK7CMkbTeWbFfH3
 KJWBLjXN9lYrH1qgjBUZZXshcViuzXI3HRM2RMruGZ1ZxR4TNDN6e1Qy7WXx73sDUvrp
 TcOg1jkWfQVUjXQHvA1Oaiz5lwEOOA5LxVHsPkRO3VFx0Ha71WTrP9I53Yo/9XXkDQJu
 ku/qdH/oWwYUFucEFis+S6gJIGLuydnd09eXPnBbLB9dI5gQXEeUTvygHPMonlrva0et
 yaZdoGpUD1yB4nb1XSf3rPrmxNGnkBSBlrnO87oDalvRlXD7ihoC1HmzUTkF/+Bly4Fn
 UzzA==
X-Forwarded-Encrypted: i=1;
 AL+hErHAVhAdyxODr51MEaTk9fZ+xbSckJWobvrYmtrdAlug0Ve2u/2FS3mBEkXl4XeqXiUKRrAA2ZC+v1aO@nongnu.org
X-Gm-Message-State: APuU4Z9BIbakpLZnqa2ZYBD1Cb90+RZtqDRtbnSNT1E6rBSif/9+ZQB8
 R39yiF/ZREfkPkaKbvMY7/3rY/kTssSHS+f7V3XL5mFOxCg6h3qmGr/uy8jZl0hsVJtjmKKzu+z
 RaJdPmHT8N1+2/ev76HhsqG53p9X+S6g8JtavUO/FIjVVERoMYN2t8H4PPw==
X-Gm-Gg: AZFdTZfyqprdylpqz1Jx/ZDqk9r3o1o5qEYpUtmOdFZZgyXbg1TKKZHz6HV5YFE0W6p
 lfFX/1k0aVpoeuTia5mw03DAUa3XBQg7rswl6DCNDfKESSb/VRuJGBLyZCaSJ7RRMgTU2+BtUi6
 L9Q1z6MqkxXe6NfuLnWriUqlfhYyADg2z3+oOXvCJ7Gl0ekrROmhk+y2Iw8JdWRx4W1aF7Xt8L0
 LTnCO9r66qhjZrKagrBpOqVngrTDXE8E7K5yh5yfQJ0I+Wldh260G30te+wwpNYDXl2MBXQL3Hd
 OL3IzCwwIiGrREK0Jit85qiIPzfhVQuIwZek5mFZXQ9JjT3dBLu+OUpP9oWVgck1X6NecCG2tC+
 tJizC3+fPPixNLMRY9PSne0654kk5QrtldgvrbTKoRrtmN2gGHfRnpJqZ1/rxwQ/M8boUpNRQe6
 HpkFnP6VS6
X-Received: by 2002:a05:690c:c96:b0:8b4:f7af:d1b2 with SMTP id
 00721157ae682-8b5204f7201mr48060217b3.51.1795439041114; 
 Mon, 23 Nov 2026 05:04:01 -0800 (PST)
X-Received: by 2002:a05:690c:c96:b0:8b4:f7af:d1b2 with SMTP id
 00721157ae682-8b5204f7201mr48059197b3.51.1795439040366; 
 Mon, 23 Nov 2026 05:04:00 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm103602996d6.34.2026.11.23.05.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:03:59 -0800 (PST)
Message-ID: <0662c682-7ba7-49a9-8f1c-b6c9b77ca1f0@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:03:56 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 06/10] riscv: add RPMI HSM service
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20261111060403.3777501-7-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111060403.3777501-7-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MSBTYWx0ZWRfX3Z3qGKhjC5IV
 KaQspT/ng3BQYFUOnJ4t9J6Bsp13Pm/gLlFBmBZMRotLze/UKu4DQ5E8POVKInvyxGMtFxE8yvI
 RKRqtvXHjn5f7DiqHTnyrRnx/2f6537d5j7a6ZUFTYBxuzBY1EhPzr5JdI/y7E66OpIAXTdeJ61
 EW9VRkjEbX9BUJsE8DOkfRSVxN3LLVe3ltLxJhRPAgkgc6L23En/mtP3G+x0jmW4LL7nhR5MYdo
 herYpu3kiMM5s6qOoUWcLkoOf8dS0VjQNx3GM7xXxa3hyAyCM1u9doMccCT8mU2KXDY+YToNwx3
 EzxABhJCylNPRxr2YF39V5ajFJIgAaQXHzhvBcEaCSjOYRl3OGjTIhYn0EHMFTaDA5KLafrFTmR
 Mnjkn5XdBsnl1llX0f8CuGJjJYee/OOoonfH0J53OxzRq8kUD7DRAmlSm0OWdzoHbEX6BDaZ4iy
 oYQEvdabNsn1wQqEKBw==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b0439c2 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jgeTgkBWBOs6A0Robj0A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: ypraYsHUDI1UIBwRufLihlAQTola81c1
X-Proofpoint-ORIG-GUID: ypraYsHUDI1UIBwRufLihlAQTola81c1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MSBTYWx0ZWRfX0H3kbiyWyuBb
 BlD/til7gOPaQQpjpXxaBigRtpvE3LLplTHDb9iupgfBllGZANKbhBtA8irI7/o3AIZVE1Q1SSB
 DKs4fKheIR70OWYVcG0t4qosklmq2LE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230051
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 3:03 AM, Subrahmanya Lingappa wrote:
> Add the RPMI Hart State Management service group for RISC-V virt.
> 
> The service exposes configured hart IDs to librpmi and keeps stable
> per-hart state in the RPMI device. A persistent observer on each target CPU
> makes actual WFI entry authoritative for stop and suspend completion, while
> CPU work handles starts and requests received after a hart has already
> entered WFI.
> 
> Keep RPMI-stopped harts off despite pending interrupts, timer events,
> kicks, or generic resume attempts. HART_START is the normal path that
> restores the hart power state and execution address.
> 
> Serialize librpmi state publication under the BQL, drain target-CPU work
> during teardown, and reconstruct the external librpmi HSM object during
> machine reset so pending operations return to the STARTED baseline.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/misc/meson.build           |   1 +
>   hw/misc/riscv_rpmi.c          |   7 +
>   hw/misc/riscv_rpmi_hsm.c      | 344 ++++++++++++++++++++++++++++++++++
>   hw/misc/riscv_rpmi_internal.h |   5 +-
>   hw/riscv/virt.c               |   5 +
>   include/hw/misc/riscv_rpmi.h  |   5 +
>   target/riscv/cpu-qom.h        |  16 ++
>   target/riscv/cpu.c            |  61 ++++++
>   target/riscv/cpu.h            |   7 +
>   target/riscv/tcg/op_helper.c  |   4 +
>   target/riscv/tcg/tcg-cpu.c    |   1 +
>   11 files changed, 455 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/riscv_rpmi_hsm.c
> 
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index a091d393a3..6d93cd4ab0 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -186,4 +186,5 @@ system_ss.add(when: 'CONFIG_QCOM_QDSP6SS_CLK', if_true: files('qcom-qdsp6ss-clk.
>   system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
>     'riscv_rpmi.c',
>     'riscv_rpmi_sysreset.c',
> +  'riscv_rpmi_hsm.c',
>   ), librpmi], if_false: files('riscv_rpmi-stub.c'))
> diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
> index 82a457241c..1bf9d77b04 100644
> --- a/hw/misc/riscv_rpmi.c
> +++ b/hw/misc/riscv_rpmi.c
> @@ -210,6 +210,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
>           .service_group = RPMI_SRVGRP_SYSTEM_RESET,
>           .add = riscv_rpmi_sysreset_add,
>           .remove = riscv_rpmi_sysreset_remove,
> +    }, {
> +        .service_group = RPMI_SRVGRP_HSM,
> +        .add = riscv_rpmi_hsm_add,
> +        .remove = riscv_rpmi_hsm_remove,
>       },
>   };
>   
> @@ -259,6 +263,9 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
>           memset(memory_region_get_ram_ptr(&s->shmem), 0, s->shmem_size);
>           memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
>       }
> +    if (!riscv_rpmi_hsm_reset(s, &error_abort)) {
> +        return;
> +    }
>   }
>   
>   static void riscv_rpmi_cleanup(RiscvRpmiState *s)
> diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
> new file mode 100644
> index 0000000000..42a4f3b096
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi_hsm.c
> @@ -0,0 +1,344 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI HSM service.
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "riscv_rpmi_internal.h"
> +#include "hw/core/cpu.h"
> +#include "qemu/main-loop.h"
> +#include "system/cpus.h"
> +#include "target/riscv/cpu-qom.h"
> +#include "librpmi_env.h"
> +
> +static const struct rpmi_hsm_suspend_type riscv_rpmi_hsm_suspend_types[] = {
> +    { .type = 0 },
> +};
> +
> +struct RiscvRpmiHsmHart {
> +    RiscvRpmiState *rpmi;
> +    CPUState *cpu;
> +    enum rpmi_hart_hw_state state;
> +    enum rpmi_hart_hw_state wfi_state;
> +    uint64_t start_addr;
> +};
> +
> +/*
> + * RPMI requests and queued CPU work hold BQL. Natural WFI transitions use an
> + * atomic armed-state check and take BQL only when a transition is pending.
> + */
> +static RiscvRpmiHsmHart *riscv_rpmi_hsm_hart(RiscvRpmiState *s,
> +                                              uint32_t hart_index)
> +{
> +    if (!s->hsm_harts || hart_index >= s->hart_count ||
> +        !s->hsm_harts[hart_index].cpu) {
> +        return NULL;
> +    }
> +
> +    return &s->hsm_harts[hart_index];
> +}
> +static void riscv_rpmi_hsm_wfi(CPUState *cpu, bool entering, void *opaque)
> +{
> +    RiscvRpmiHsmHart *hart = opaque;
> +    enum rpmi_hart_hw_state wfi_state;
> +    bool need_bql = !bql_locked();
> +    bool changed = false;
> +
> +    wfi_state = qatomic_read(&hart->wfi_state);
> +    if (wfi_state == RPMI_HART_HW_STATE_MAX) {
> +        return;
> +    }
> +    if (need_bql) {
> +        bql_lock();
> +    }
> +
> +    wfi_state = qatomic_read(&hart->wfi_state);
> +    if (entering && wfi_state == RPMI_HART_HW_STATE_STOPPED) {
> +        qatomic_set(&hart->wfi_state, RPMI_HART_HW_STATE_MAX);
> +        riscv_cpu_set_powered_off(cpu, true);
> +        hart->state = RPMI_HART_HW_STATE_STOPPED;
> +        changed = true;
> +    } else if (wfi_state == RPMI_HART_HW_STATE_SUSPENDED) {
> +        hart->state = entering ? RPMI_HART_HW_STATE_SUSPENDED :
> +                                 RPMI_HART_HW_STATE_STARTED;
> +        if (!entering) {
> +            qatomic_set(&hart->wfi_state, RPMI_HART_HW_STATE_MAX);
> +        }
> +        changed = true;
> +    }
> +
> +    if (changed) {
> +        rpmi_hsm_process_state_changes(hart->rpmi->hsm);
> +    }
> +    if (need_bql) {
> +        bql_unlock();
> +    }
> +}
> +
> +static void riscv_rpmi_hsm_set_observer(CPUState *cpu, run_on_cpu_data data)
> +{
> +    riscv_cpu_set_wfi_observer(cpu, riscv_rpmi_hsm_wfi, data.host_ptr);
> +}
> +
> +static void riscv_rpmi_hsm_clear_observer(CPUState *cpu, run_on_cpu_data data)
> +{
> +    riscv_cpu_set_wfi_observer(cpu, NULL, NULL);
> +    riscv_cpu_set_powered_off(cpu, false);
> +    cpu->halted = false;
> +    cpu_resume(cpu);
> +}
> +
> +static void riscv_rpmi_hsm_start_cpu(CPUState *cpu, run_on_cpu_data data)
> +{
> +    RiscvRpmiHsmHart *hart = data.host_ptr;
> +
> +    g_assert(bql_locked());
> +    riscv_cpu_handle_wfi_resume(cpu);
> +    cpu_set_pc(cpu, hart->start_addr);
> +    riscv_cpu_set_powered_off(cpu, false);
> +    cpu->halted = false;
> +    cpu_resume(cpu);
> +    hart->state = RPMI_HART_HW_STATE_STARTED;
> +    rpmi_hsm_process_state_changes(hart->rpmi->hsm);
> +}
> +
> +static void riscv_rpmi_hsm_replay_wfi(CPUState *cpu, run_on_cpu_data data)
> +{
> +    riscv_cpu_replay_wfi_observer(cpu);
> +}
> +
> +static enum rpmi_error riscv_rpmi_hsm_start_prepare(
> +    void *priv, rpmi_uint32_t hart_index, rpmi_uint64_t start_addr)
> +{
> +    RiscvRpmiHsmHart *hart = riscv_rpmi_hsm_hart(priv, hart_index);
> +
> +    g_assert(bql_locked());
> +    if (!hart) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +
> +    hart->start_addr = start_addr;
> +    async_run_on_cpu(hart->cpu, riscv_rpmi_hsm_start_cpu,
> +                     RUN_ON_CPU_HOST_PTR(hart));
> +    return RPMI_SUCCESS;
> +}
> +
> +/* librpmi requires finalize hooks even when QEMU has no second phase. */
> +static void riscv_rpmi_hsm_start_finalize(void *priv,
> +                                          rpmi_uint32_t hart_index,
> +                                          rpmi_uint64_t start_addr)
> +{
> +}
> +
> +static enum rpmi_error riscv_rpmi_hsm_arm_wfi(
> +    RiscvRpmiState *s, uint32_t hart_index, enum rpmi_hart_hw_state state)
> +{
> +    RiscvRpmiHsmHart *hart = riscv_rpmi_hsm_hart(s, hart_index);
> +
> +    g_assert(bql_locked());
> +    if (!hart) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +
> +    qatomic_set(&hart->wfi_state, state);
> +    async_run_on_cpu(hart->cpu, riscv_rpmi_hsm_replay_wfi,
> +                     RUN_ON_CPU_NULL);
> +    return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error riscv_rpmi_hsm_stop_prepare(void *priv,
> +                                                    rpmi_uint32_t hart_index)
> +{
> +    return riscv_rpmi_hsm_arm_wfi(priv, hart_index,
> +                                  RPMI_HART_HW_STATE_STOPPED);
> +}
> +
> +static void riscv_rpmi_hsm_stop_finalize(void *priv,
> +                                         rpmi_uint32_t hart_index)
> +{
> +}
> +
> +static enum rpmi_error riscv_rpmi_hsm_suspend_prepare(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_hsm_suspend_type *suspend_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    if (!suspend_type) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +
> +    return riscv_rpmi_hsm_arm_wfi(priv, hart_index,
> +                                  RPMI_HART_HW_STATE_SUSPENDED);
> +}
> +
> +static void riscv_rpmi_hsm_suspend_finalize(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_hsm_suspend_type *suspend_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +}
> +
> +static enum rpmi_hart_hw_state riscv_rpmi_hsm_get_hw_state(
> +    void *priv, rpmi_uint32_t hart_index)
> +{
> +    RiscvRpmiHsmHart *hart = riscv_rpmi_hsm_hart(priv, hart_index);
> +
> +    g_assert(bql_locked());
> +    return hart ? hart->state : RPMI_HART_HW_STATE_STOPPED;
> +}
> +
> +static const struct rpmi_hsm_platform_ops riscv_rpmi_hsm_ops = {
> +    .hart_get_hw_state = riscv_rpmi_hsm_get_hw_state,
> +    .hart_start_prepare = riscv_rpmi_hsm_start_prepare,
> +    .hart_start_finalize = riscv_rpmi_hsm_start_finalize,
> +    .hart_stop_prepare = riscv_rpmi_hsm_stop_prepare,
> +    .hart_stop_finalize = riscv_rpmi_hsm_stop_finalize,
> +    .hart_suspend_prepare = riscv_rpmi_hsm_suspend_prepare,
> +    .hart_suspend_finalize = riscv_rpmi_hsm_suspend_finalize,
> +};
> +
> +static bool riscv_rpmi_hsm_create_external(
> +    RiscvRpmiState *s, struct rpmi_service_group **group, Error **errp)
> +{
> +    s->hsm = rpmi_hsm_create(s->hart_count, s->hart_ids,
> +                             ARRAY_SIZE(riscv_rpmi_hsm_suspend_types),
> +                             riscv_rpmi_hsm_suspend_types,
> +                             &riscv_rpmi_hsm_ops, s);
> +    if (!s->hsm) {
> +        error_setg(errp, "failed to create RPMI HSM context");
> +        return false;
> +    }
> +
> +    *group = rpmi_service_group_hsm_create(s->hsm);
> +    if (!*group) {
> +        rpmi_hsm_destroy(s->hsm);
> +        s->hsm = NULL;
> +        error_setg(errp, "failed to create RPMI HSM service group");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void riscv_rpmi_hsm_destroy_external(RiscvRpmiState *s)
> +{
> +    if (s->hsm_group) {
> +        rpmi_env_free_lock(s->hsm_group->lock);
> +        s->hsm_group->lock = NULL;
> +        rpmi_service_group_hsm_destroy(s->hsm_group);
> +        s->hsm_group = NULL;
> +    }
> +    if (s->hsm) {
> +        rpmi_hsm_destroy(s->hsm);
> +        s->hsm = NULL;
> +    }
> +}
> +
> +static void riscv_rpmi_hsm_reset_cpu(CPUState *cpu, run_on_cpu_data data)
> +{
> +    riscv_cpu_handle_wfi_resume(cpu);
> +    riscv_cpu_set_powered_off(cpu, false);
> +    cpu->halted = false;
> +}
> +
> +bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp)
> +{
> +    struct rpmi_service_group *group;
> +
> +    if (s->hsm_group) {
> +        error_setg(errp, "duplicate RPMI HSM service descriptor");
> +        return false;
> +    }
> +    if (!s->hart_count || !s->hart_ids) {
> +        error_setg(errp, "RPMI HSM service requires hart IDs");
> +        return false;
> +    }
> +
> +    s->hsm_harts = g_new0(RiscvRpmiHsmHart, s->hart_count);
> +    for (uint32_t i = 0; i < s->hart_count; i++) {
> +        RiscvRpmiHsmHart *hart = &s->hsm_harts[i];
> +
> +        hart->rpmi = s;
> +        hart->cpu = cpu_by_arch_id(s->hart_ids[i]);
> +        hart->state = RPMI_HART_HW_STATE_STARTED;
> +        qatomic_set(&hart->wfi_state, RPMI_HART_HW_STATE_MAX);
> +    }
> +
> +    if (!riscv_rpmi_hsm_create_external(s, &group, errp)) {
> +        g_clear_pointer(&s->hsm_harts, g_free);
> +        return false;
> +    }
> +    if (!riscv_rpmi_context_add_group(s, group, "HSM", errp)) {
> +        s->hsm_group = group;
> +        riscv_rpmi_hsm_destroy_external(s);
> +        g_clear_pointer(&s->hsm_harts, g_free);
> +        return false;
> +    }
> +
> +    s->hsm_group = group;
> +    for (uint32_t i = 0; i < s->hart_count; i++) {
> +        RiscvRpmiHsmHart *hart = &s->hsm_harts[i];
> +
> +        if (hart->cpu) {
> +            run_on_cpu(hart->cpu, riscv_rpmi_hsm_set_observer,
> +                       RUN_ON_CPU_HOST_PTR(hart));
> +        }
> +    }
> +    return true;
> +}
> +
> +void riscv_rpmi_hsm_remove(RiscvRpmiState *s)
> +{
> +    if (!s->hsm_harts) {
> +        return;
> +    }
> +
> +    for (uint32_t i = 0; i < s->hart_count; i++) {
> +        CPUState *cpu = s->hsm_harts[i].cpu;
> +
> +        if (cpu) {
> +            run_on_cpu(cpu, riscv_rpmi_hsm_clear_observer, RUN_ON_CPU_NULL);
> +        }
> +    }
> +    riscv_rpmi_context_remove_group(s, s->hsm_group);
> +    riscv_rpmi_hsm_destroy_external(s);
> +    g_clear_pointer(&s->hsm_harts, g_free);
> +}
> +
> +bool riscv_rpmi_hsm_reset(RiscvRpmiState *s, Error **errp)
> +{
> +    struct rpmi_service_group *group = NULL;
> +
> +    if (!s->hsm_harts) {
> +        return true;
> +    }
> +
> +    for (uint32_t i = 0; i < s->hart_count; i++) {
> +        RiscvRpmiHsmHart *hart = &s->hsm_harts[i];
> +
> +        if (hart->cpu) {
> +            run_on_cpu(hart->cpu, riscv_rpmi_hsm_reset_cpu,
> +                       RUN_ON_CPU_NULL);
> +        }
> +        hart->state = RPMI_HART_HW_STATE_STARTED;
> +        qatomic_set(&hart->wfi_state, RPMI_HART_HW_STATE_MAX);
> +    }
> +
> +    riscv_rpmi_context_remove_group(s, s->hsm_group);
> +    riscv_rpmi_hsm_destroy_external(s);
> +    if (!riscv_rpmi_hsm_create_external(s, &group, errp)) {
> +        return false;
> +    }
> +    if (!riscv_rpmi_context_add_group(s, group, "HSM", errp)) {
> +        s->hsm_group = group;
> +        riscv_rpmi_hsm_destroy_external(s);
> +        return false;
> +    }
> +    s->hsm_group = group;
> +    return true;
> +}
> diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
> index e5880aebe2..e56dba5b1a 100644
> --- a/hw/misc/riscv_rpmi_internal.h
> +++ b/hw/misc/riscv_rpmi_internal.h
> @@ -27,8 +27,11 @@ bool riscv_rpmi_context_add_group(RiscvRpmiState *s,
>                                     Error **errp);
>   void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
>                                        struct rpmi_service_group *group);
> -
>   bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);
>   void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
>   
> +bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
> +void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
> +bool riscv_rpmi_hsm_reset(RiscvRpmiState *s, Error **errp);
> +
>   #endif
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 1e313e078e..32aa13325e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -485,6 +485,11 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
>           .compatible = "riscv,rpmi-system-reset",
>           .service_group = RPMI_SRVGRP_SYSTEM_RESET,
>       },
> +    {
> +        .node_name = "hsm",
> +        .compatible = "riscv,rpmi-hsm",
> +        .service_group = RPMI_SRVGRP_HSM,
> +    },
>   };
>   
>   static uint32_t virt_rpmi_service_count(void)
> diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
> index 1ab648359d..3a240941cd 100644
> --- a/include/hw/misc/riscv_rpmi.h
> +++ b/include/hw/misc/riscv_rpmi.h
> @@ -42,6 +42,8 @@ struct rpmi_context;
>   struct rpmi_service_group;
>   struct rpmi_shmem;
>   struct rpmi_transport;
> +struct rpmi_hsm;
> +typedef struct RiscvRpmiHsmHart RiscvRpmiHsmHart;
>   
>   typedef struct RiscvRpmiMachineOps {
>       void (*system_reset)(void);
> @@ -82,6 +84,9 @@ struct RiscvRpmiState {
>       char *platform_info;
>       const RiscvRpmiMachineOps *machine_ops;
>       struct rpmi_service_group *sysreset_group;
> +    struct rpmi_hsm *hsm;
> +    struct rpmi_service_group *hsm_group;
> +    RiscvRpmiHsmHart *hsm_harts;
>       uint32_t *hart_ids;
>       uint32_t hart_count;
>       const RiscvRpmiServiceConfig *services;
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 61234842e3..f6b6023835 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -64,4 +64,20 @@
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>   
> +#ifndef CONFIG_USER_ONLY
> +/*
> + * WFI observers persist across entries and exits. Access observers and WFI
> + * state only on the target CPU thread; use run_on_cpu() to register or remove
> + * an observer and drain earlier CPU work before freeing its opaque state.
> + */
> +void riscv_cpu_set_wfi_observer(
> +    CPUState *cpu,
> +    void (*observer)(CPUState *cpu, bool entering, void *opaque),
> +    void *opaque);
> +void riscv_cpu_handle_wfi(CPUState *cpu);
> +void riscv_cpu_handle_wfi_resume(CPUState *cpu);
> +void riscv_cpu_replay_wfi_observer(CPUState *cpu);
> +void riscv_cpu_set_powered_off(CPUState *cpu, bool powered_off);
> +#endif
> +
>   #endif /* RISCV_CPU_QOM_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a0529fbda..e516a6b98f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -58,6 +58,61 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
>    */
>   #define RISCV_CPU_MARCHID 42
>   
> +#ifndef CONFIG_USER_ONLY
> +void riscv_cpu_set_wfi_observer(CPUState *cpu,
> +                                void (*observer)(CPUState *, bool, void *),
> +                                void *opaque)
> +{
> +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> +
> +    g_assert(qemu_cpu_is_self(cpu));
> +    rcpu->wfi_observer = observer;
> +    rcpu->wfi_observer_opaque = opaque;
> +}
> +
> +void riscv_cpu_handle_wfi(CPUState *cpu)
> +{
> +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> +
> +    g_assert(qemu_cpu_is_self(cpu));
> +    rcpu->wfi_active = true;
> +    if (rcpu->wfi_observer) {
> +        rcpu->wfi_observer(cpu, true, rcpu->wfi_observer_opaque);
> +    }
> +}
> +
> +void riscv_cpu_handle_wfi_resume(CPUState *cpu)
> +{
> +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> +
> +    g_assert(qemu_cpu_is_self(cpu));
> +    if (!rcpu->wfi_active) {
> +        return;
> +    }
> +    rcpu->wfi_active = false;
> +    if (rcpu->wfi_observer) {
> +        rcpu->wfi_observer(cpu, false, rcpu->wfi_observer_opaque);
> +    }
> +}
> +
> +void riscv_cpu_replay_wfi_observer(CPUState *cpu)
> +{
> +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> +
> +    g_assert(qemu_cpu_is_self(cpu));
> +    if (rcpu->wfi_active && rcpu->wfi_observer) {
> +        rcpu->wfi_observer(cpu, true, rcpu->wfi_observer_opaque);
> +    }
> +}
> +
> +void riscv_cpu_set_powered_off(CPUState *cpu, bool powered_off)
> +{
> +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> +
> +    qatomic_set(&rcpu->powered_off, powered_off);
> +}
> +#endif
> +
>   /*
>    * From vector_helper.c
>    * Note that vector data is stored in host-endian 64-bit chunks,
> @@ -967,6 +1022,10 @@ static bool riscv_cpu_has_work(CPUState *cs)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
> +
> +    if (qatomic_read(&cpu->powered_off)) {
> +        return false;
> +    }
>       /*
>        * Definition of the WFI instruction requires it to ignore the privilege
>        * mode and delegation registers, but respect individual enables
> @@ -988,6 +1047,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>           mcc->parent_phases.hold(obj, type);
>       }
>   #ifndef CONFIG_USER_ONLY
> +    riscv_cpu_set_powered_off(cs, false);
> +    cpu->wfi_active = false;
>       env->misa_mxl = mcc->def->misa_mxl_max;
>       env->priv = PRV_M;
>       env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 49a1186bdb..ac79397858 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -577,6 +577,13 @@ struct ArchCPU {
>   
>       CPURISCVState env;
>   
> +#ifndef CONFIG_USER_ONLY
> +    void (*wfi_observer)(CPUState *, bool, void *);
> +    void *wfi_observer_opaque;
> +    bool wfi_active;
> +    bool powered_off;
> +#endif
> +
>       GDBFeature dyn_csr_feature;
>       GDBFeature dyn_vreg_feature;
>   
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index f9c79fe6b9..b0fb3c2cf8 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -644,6 +644,10 @@ void HELPER(wfi)(CPURISCVState *env)
>               return;
>           }
>           cs->halted = 1;
> +#ifndef CONFIG_USER_ONLY
> +        /* Publish WFI only after QEMU has entered the halted state. */
> +        riscv_cpu_handle_wfi(cs);
> +#endif
>           cs->exception_index = EXCP_HLT;
>           cpu_loop_exit(cs);
>       }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 2a7796c382..2bd198c016 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -305,6 +305,7 @@ const TCGCPUOps riscv_tcg_ops = {
>       .tlb_fill = riscv_cpu_tlb_fill,
>       .pointer_wrap = riscv_pointer_wrap,
>       .cpu_exec_enter = riscv_cpu_exec_enter,
> +    .leaving_halt = riscv_cpu_handle_wfi_resume,
>       .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
>       .cpu_exec_reset = cpu_reset,
>       .do_interrupt = riscv_cpu_do_interrupt,


