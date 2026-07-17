Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0DAC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiVO-00052a-Qs; Fri, 17 Jul 2026 09:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiVN-00051k-AO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:21:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiVK-0006je-Un
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:21:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCSu7C1654086
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mehbbA4IlAgICibX1L+OiKpIzel4Duycvz6DG+odCyY=; b=VnBkl7RL8IYMRzOi
 yWKpN0X1GA42ZRoSJO/KI3FALpP0UoMRdlhoJUzT7iPq76Y5Qpb5JoabSdxK/9RO
 JFYUlY5qN9K78HovWLsdCPNCvUghA/lVszP1ZcwU63Z+XkT0nWKOgztBY+CrCfHu
 V7BTwjS9mgqb2jTLoy3QfGku58q1VyBs+77P119QYX8KQFBlpAP7FF6xmPa9D5Ho
 iIfzR8+25mM5yVk8ofv/X5PWr7ppiH1Y2fGIY3mHRa0oDcjOxfB+k5hk6CpfUWY2
 vtHwz9FODikHi+sQfPGEgZap492ks+CjAZU7cp231Fxif3GjHmlOha2jA2d1vb9P
 VsnULw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9p9fq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:21:25 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81e8577d187so184292707b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784294485; x=1784899285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mehbbA4IlAgICibX1L+OiKpIzel4Duycvz6DG+odCyY=;
 b=N5z3l9XKuzVy+2MEMIBacxkUAWnAmxiMvWdmdBswYF1F54iCCdvEq5C/CA3VBWExhY
 HTge53Zs0kTwiqro2dFCWt6mFZwMSk9EH4tSbrV88Tf7RVoEGHFwXes7iwbNVzPEjSoV
 gnHPGKRtKMEeMBOUJTkT5XyuHEcl1tTjZTrB2ex4uq5hXp3+m2EMFGjqk/eDiAR/9skv
 XOSravOqdEmdU0YlCh5H7BA3NEiiSblweuI/okIb9Eg0JRzE13PAbUOkIYn2oXUrndsX
 S/1w2kt8mR7wILlZCVsTtpEaL7wqnTPoVBFuhR1sywEeach6tU5o6hvvNGP4bn9IDPmc
 RXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294485; x=1784899285;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mehbbA4IlAgICibX1L+OiKpIzel4Duycvz6DG+odCyY=;
 b=atT+I2xQlsoPmPgDfGyMUYizNVbIQb1WNg3ZrvGnD2GUOmAMPC5MeNeG8J63Mm857a
 57o1206KuPi7cIHb6DeZ+33Z41KHG+aRSs1wdnk8zvM2m8BoegHpzSefnJSxQM7n65aV
 8pHCPhaqKabKsxitRYMP+Cu8nEEgyrGzqOEnTYXqlB/IGIv3xRQEOYCXmHm8HHoNZuxx
 lIxp0hGalvQMEPbo4G7iMX1bLXnK2BSpst3z7yIs4rqn//Bbnq3LCQvuRukHNv2Ajrdt
 EWwhInPHTQGJ2+B6lePBVsrhNqUfhQmyC+AN3QVZz7Pj9YSw9vhqC0E9M+Xe66B7mtq0
 4v/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RorVvOByyjWjhat93RX4vJsk6C5xCCeOqp1Jd5nqF8kigdV18oJ0Vn4eL2rhteoLdw2TGBXV6XtpGmM@nongnu.org
X-Gm-Message-State: AOJu0YzwPaVUE3S9AOKtnOd8aQ6uEcQ1Zkut2RkJTC+VzfOR5+KhcatY
 fgG0QW704tLOVN5qUb3c8pNcIFxwnu0PVNCZcoJnezUVGy7ZefLFGvXlIcmSpOE5CRibar2A5n/
 QHpZloFMPFIuJaGIqHt4b/ecCPASLXgGcZPWaN/nbnPDpnLQi5fBg9zy2+A==
X-Gm-Gg: AfdE7cl8TEE+G8simZSj0raIPD29Qh4RYswRC41IF1XMKNk7CDMJVyoABRfEs0s2X8/
 dtkITRpPaxIG8wQ62FtO6NPk0kmIGXfX3NzngH3lD5TLz0shts7PFxl9sFQ1QCcp7cwUJO3ksqU
 WSOO1RMtN8dvwnLlfybWH/EkRVIpgBIJUFyCI550k8DwEVKwSc1+GCZtkTRnXn8Vs+qFfdcco4R
 Z9gPvWrnj3rEkqUYQGzQ9Nr9UdsgvsBPhjAihlND5co9V6TuRDqgrYtmfnbmvvhN5YE76KxAxAI
 07+q3YtjkzdfzMjlALQdRO57MP3pfOA9zYbbLgpI86Y9SRYsSsnAlwCM3Oa7TKL3FD+wj0Ae90s
 lzPD74IENaERg6FYrLd38VAh0Us3guxhJvPRmeQ==
X-Received: by 2002:a05:690c:dd2:b0:81e:7075:e2e3 with SMTP id
 00721157ae682-81ef26a561fmr7973657b3.35.1784294485406; 
 Fri, 17 Jul 2026 06:21:25 -0700 (PDT)
X-Received: by 2002:a05:690c:dd2:b0:81e:7075:e2e3 with SMTP id
 00721157ae682-81ef26a561fmr7973517b3.35.1784294484960; 
 Fri, 17 Jul 2026 06:21:24 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81ef4276391sm8859787b3.27.2026.07.17.06.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:21:24 -0700 (PDT)
Message-ID: <add7f2b6-7dd0-43cf-a02b-8fd87a4dede7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:21:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] riscv: add RPMI HSM service
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-7-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714075659.2258023-7-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HIMUfcy6x44g6pkb7bVamB6ZDG4rilTX
X-Proofpoint-ORIG-GUID: HIMUfcy6x44g6pkb7bVamB6ZDG4rilTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNSBTYWx0ZWRfX5UjBLMlKOula
 pbcM4YZyJPpoBrY2GHVLBIh7BX6t9wq6OBwrOQNsvCibSjrAV3P0Kg/RxRA/8VH1NtSVPi9rqnm
 ovCctRAfcYlyjhE0/smwDKB9m+w9Bk0OjRRq/WUAcJsVfTdasK6giimxxh5WM6O3n3+BCt47EPB
 dSQl3eD8HX586KUJqXR7AbHFZiRNCn8YEzuzTpT4yJ47dbgltileBzSJ+XLKC5FWjwdMs5tVXQG
 bIcL45YG3N0wHQ/QS0rutC6PG2wCDVd8n3qKR8onpurmxAlcf22SuIsseInhwh4ECpaf6dM7ybt
 RfHoh4OreKC4ijzLRbg6TnNZ5VkEHjUAP9PHeeoqEG2sVFQIAdEyobPge44qrewR0ieSc4Maqm8
 YjPiTTnp5Esh+S0boUlovdFlSuciiNN68684bQk46aw3b7anPkvX/Gho9LY5ycwbU4/1nc+ZHgu
 hd/90QoAu34TFqG+f3Q==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a2c55 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=TnUOG_C81LtD0xnldFcA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNSBTYWx0ZWRfXxcD8GtgCYlpx
 r5bUs7J5s+TPOiQ65Sb54Pl72VUgbiOTAtkonY79gogES+khh9T2WgjjmJ0Cv0ckrJBW5o9HLAm
 UD82LGUKDunwDEwjN6Is/gKPrFk25Ck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170135
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



On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> Add the RPMI Hart State Management service group for RISC-V virt.
> 
> The service exposes the configured virt hart IDs to librpmi and keeps
> per-hart RPMI hardware state in the RPMI device. Start, stop, and
> suspend requests update QEMU CPU halted state and resume/kick vCPUs as
> needed so firmware can exercise RPMI HSM operations against the emulated
> topology.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/misc/meson.build           |   1 +
>   hw/misc/riscv_rpmi.c          |  46 ++++++
>   hw/misc/riscv_rpmi_hsm.c      | 280 ++++++++++++++++++++++++++++++++++
>   hw/misc/riscv_rpmi_internal.h |   4 +
>   hw/riscv/virt.c               |   6 +
>   include/hw/misc/riscv_rpmi.h  |   6 +
>   6 files changed, 343 insertions(+)
>   create mode 100644 hw/misc/riscv_rpmi_hsm.c
> 
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index bca7819ee0..fc5b11ed57 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -171,4 +171,5 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
>   system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
>     'riscv_rpmi.c',
>     'riscv_rpmi_sysreset.c',
> +  'riscv_rpmi_hsm.c',
>   ), librpmi])
> diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
> index 7a3f570ee7..820b1d5d63 100644
> --- a/hw/misc/riscv_rpmi.c
> +++ b/hw/misc/riscv_rpmi.c
> @@ -171,6 +171,49 @@ static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
>                                             s->a2p_req_size);
>   }
>   
> +typedef struct RiscvRpmiServiceOps {
> +    RiscvRpmiServiceKind kind;
> +    void (*configure)(RiscvRpmiState *s, const RiscvRpmiConfig *cfg);
> +    bool (*add)(RiscvRpmiState *s, Error **errp);
> +    void (*remove)(RiscvRpmiState *s);
> +} RiscvRpmiServiceOps;
> +
> +static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
> +    {
> +        .kind = RISCV_RPMI_SERVICE_SYSRESET,
> +        .add = riscv_rpmi_sysreset_add,
> +        .remove = riscv_rpmi_sysreset_remove,
> +    }, {
> +        .kind = RISCV_RPMI_SERVICE_HSM,
> +        .add = riscv_rpmi_hsm_add,
> +        .remove = riscv_rpmi_hsm_remove,
> +    },
> +};
> +
> +static const RiscvRpmiServiceOps *riscv_rpmi_service_ops_by_kind(
> +    RiscvRpmiServiceKind kind)
> +{
> +    for (uint32_t i = 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) {
> +        if (riscv_rpmi_service_ops[i].kind == kind) {
> +            return &riscv_rpmi_service_ops[i];
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static void riscv_rpmi_configure_services(RiscvRpmiState *s,
> +                                          const RiscvRpmiConfig *cfg)
> +{
> +    for (uint32_t i = 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) {
> +        const RiscvRpmiServiceOps *ops = &riscv_rpmi_service_ops[i];
> +
> +        if (ops->configure && riscv_rpmi_service_enabled(s, ops->kind)) {
> +            ops->configure(s, cfg);
> +        }
> +    }
> +}
> +
>   static void riscv_rpmi_configure_base(RiscvRpmiState *s,
>                                         const RiscvRpmiConfig *cfg)
>   {
> @@ -187,6 +230,8 @@ static void riscv_rpmi_configure_base(RiscvRpmiState *s,
>                                       cfg->hart_count * sizeof(*cfg->hart_ids));
>           }
>       }
> +
> +    riscv_rpmi_configure_services(s, cfg);
>   }
>   
>   static void riscv_rpmi_init(Object *obj)
> @@ -209,6 +254,7 @@ static void riscv_rpmi_reset(DeviceState *dev)
>           memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
>       }
>   
> +    riscv_rpmi_hsm_reset(s);
>   }
>   
>   static void riscv_rpmi_cleanup(RiscvRpmiState *s)
> diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
> new file mode 100644
> index 0000000000..9a9859b10c
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi_hsm.c
> @@ -0,0 +1,280 @@
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
> +#include "librpmi_env.h"
> +
> +static const struct rpmi_hsm_suspend_type riscv_rpmi_hsm_suspend_types[] = {
> +    {
> +        .type = 0,
> +        .info = {
> +            .flags = 0,
> +            .entry_latency_us = 0,
> +            .exit_latency_us = 0,
> +            .wakeup_latency_us = 0,
> +            .min_residency_us = 0,
> +        },
> +    },
> +};
> +
> +typedef struct RiscvRpmiHsmStateTransition {
> +    enum rpmi_hart_hw_state state;
> +    bool halted;
> +    bool resume;
> +} RiscvRpmiHsmStateTransition;
> +
> +static const RiscvRpmiHsmStateTransition riscv_rpmi_hsm_state_transitions[] = {
> +    {
> +        .state = RPMI_HART_HW_STATE_STARTED,
> +        .halted = false,
> +        .resume = true,
> +    }, {
> +        .state = RPMI_HART_HW_STATE_STOPPED,
> +        .halted = true,
> +        .resume = false,
> +    }, {
> +        .state = RPMI_HART_HW_STATE_SUSPENDED,
> +        .halted = true,
> +        .resume = false,
> +    },
> +};
> +
> +static const RiscvRpmiHsmStateTransition *riscv_rpmi_hsm_state_transition(
> +    enum rpmi_hart_hw_state state)
> +{
> +    for (uint32_t index = 0;
> +         index < ARRAY_SIZE(riscv_rpmi_hsm_state_transitions); index++) {
> +        if (riscv_rpmi_hsm_state_transitions[index].state == state) {
> +            return &riscv_rpmi_hsm_state_transitions[index];
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static CPUState *riscv_rpmi_hart_cpu(RiscvRpmiState *s, uint32_t hart_index)
> +{
> +    if (hart_index >= s->hart_count || !s->hart_ids) {
> +        return NULL;
> +    }
> +
> +    return cpu_by_arch_id(s->hart_ids[hart_index]);
> +}
> +
> +static void riscv_rpmi_hsm_set_hw_state(RiscvRpmiState *s,
> +                                        uint32_t hart_index,
> +                                        enum rpmi_hart_hw_state state)
> +{
> +    CPUState *cpu = riscv_rpmi_hart_cpu(s, hart_index);
> +    const RiscvRpmiHsmStateTransition *transition;
> +
> +    if (hart_index >= s->hart_count || !s->hsm_hw_states) {
> +        return;
> +    }
> +
> +    s->hsm_hw_states[hart_index] = state;
> +    if (!cpu) {
> +        return;
> +    }
> +
> +    transition = riscv_rpmi_hsm_state_transition(state);
> +    if (!transition) {
> +        return;
> +    }
> +
> +    cpu->halted = transition->halted;
> +    if (transition->resume) {
> +        cpu_resume(cpu);
> +    } else {
> +        qemu_cpu_kick(cpu);
> +    }
> +}
> +
> +static enum rpmi_error riscv_rpmi_hsm_start_prepare(
> +    void *priv, rpmi_uint32_t hart_index, rpmi_uint64_t start_addr)
> +{
> +    RiscvRpmiState *s = priv;
> +    CPUState *cpu = riscv_rpmi_hart_cpu(s, hart_index);
> +
> +    if (!cpu) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +
> +    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STARTED);
> +    return RPMI_SUCCESS;
> +}
> +
> +static void riscv_rpmi_hsm_start_finalize(void *priv,
> +                                          rpmi_uint32_t hart_index,
> +                                          rpmi_uint64_t start_addr)
> +{
> +}
> +
> +static enum rpmi_error riscv_rpmi_hsm_stop_prepare(void *priv,
> +                                                   rpmi_uint32_t hart_index)
> +{
> +    RiscvRpmiState *s = priv;
> +
> +    if (!riscv_rpmi_hart_cpu(s, hart_index)) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +
> +    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STOPPED);
> +    return RPMI_SUCCESS;
> +}
> +
> +static void riscv_rpmi_hsm_stop_finalize(void *priv, rpmi_uint32_t hart_index)
> +{
> +}
> +
> +static enum rpmi_error riscv_rpmi_hsm_suspend_prepare(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_hsm_suspend_type *suspend_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    RiscvRpmiState *s = priv;
> +
> +    if (!suspend_type || !riscv_rpmi_hart_cpu(s, hart_index)) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +
> +    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_SUSPENDED);
> +    return RPMI_SUCCESS;
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
> +    RiscvRpmiState *s = priv;
> +
> +    if (hart_index >= s->hart_count || !s->hsm_hw_states) {
> +        return RPMI_HART_HW_STATE_STOPPED;
> +    }
> +
> +    return s->hsm_hw_states[hart_index];
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
> +static bool riscv_rpmi_hsm_create(RiscvRpmiState *s,
> +                                  struct rpmi_service_group **group,
> +                                  Error **errp)
> +{
> +    struct rpmi_hsm *hsm;
> +
> +    if (!s->hart_count || !s->hart_ids) {
> +        error_setg(errp, "RPMI HSM service requires hart IDs");
> +        return false;
> +    }
> +
> +    s->hsm_hw_states = g_new0(uint32_t, s->hart_count);
> +    for (uint32_t i = 0; i < s->hart_count; i++) {
> +        s->hsm_hw_states[i] = RPMI_HART_HW_STATE_STARTED;
> +    }
> +
> +    hsm = rpmi_hsm_create(s->hart_count, s->hart_ids,
> +                          ARRAY_SIZE(riscv_rpmi_hsm_suspend_types),
> +                          riscv_rpmi_hsm_suspend_types,
> +                          &riscv_rpmi_hsm_ops, s);
> +    if (!hsm) {
> +        g_clear_pointer(&s->hsm_hw_states, g_free);
> +        error_setg(errp, "failed to create RPMI HSM context");
> +        return false;
> +    }
> +
> +    *group = rpmi_service_group_hsm_create(hsm);
> +    if (!*group) {
> +        rpmi_hsm_destroy(hsm);
> +        g_clear_pointer(&s->hsm_hw_states, g_free);
> +        error_setg(errp, "failed to create RPMI HSM service group");
> +        return false;
> +    }
> +
> +    s->hsm = hsm;
> +    return true;
> +}
> +
> +static void riscv_rpmi_hsm_destroy(RiscvRpmiState *s)
> +{
> +    if (s->hsm_group) {
> +        rpmi_env_free_lock(s->hsm_group->lock);
> +        s->hsm_group->lock = NULL;
> +        rpmi_service_group_hsm_destroy(s->hsm_group);
> +        s->hsm_group = NULL;
> +    }
> +
> +    if (s->hsm) {
> +        rpmi_hsm_destroy(s->hsm);
> +        s->hsm = NULL;
> +    }
> +
> +    g_clear_pointer(&s->hsm_hw_states, g_free);
> +}
> +
> +
> +bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp)
> +{
> +    struct rpmi_service_group *group;
> +
> +    if (s->hsm_group) {
> +        error_setg(errp, "duplicate RPMI HSM service descriptor");
> +        return false;
> +    }
> +
> +    if (!riscv_rpmi_hsm_create(s, &group, errp)) {
> +        return false;
> +    }
> +
> +    if (!riscv_rpmi_context_add_group(s, group, "HSM", errp)) {
> +        s->hsm_group = group;
> +        riscv_rpmi_hsm_destroy(s);
> +        return false;
> +    }
> +
> +    s->hsm_group = group;
> +    return true;
> +}
> +
> +void riscv_rpmi_hsm_remove(RiscvRpmiState *s)
> +{
> +    riscv_rpmi_context_remove_group(s, s->hsm_group);
> +    riscv_rpmi_hsm_destroy(s);
> +}
> +
> +void riscv_rpmi_hsm_reset(RiscvRpmiState *s)
> +{
> +    if (!s->hsm_hw_states) {
> +        return;
> +    }
> +
> +    for (uint32_t i = 0; i < s->hart_count; i++) {
> +        s->hsm_hw_states[i] = RPMI_HART_HW_STATE_STARTED;
> +    }
> +    if (s->hsm) {
> +        rpmi_hsm_process_state_changes(s->hsm);
> +    }
> +}
> diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
> index fe09804e69..42a6708907 100644
> --- a/hw/misc/riscv_rpmi_internal.h
> +++ b/hw/misc/riscv_rpmi_internal.h
> @@ -30,4 +30,8 @@ void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
>   bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);
>   void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
>   
> +bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
> +void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
> +void riscv_rpmi_hsm_reset(RiscvRpmiState *s);
> +
>   #endif
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 273a9aa04f..2b5f367bdb 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1014,6 +1014,12 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
>           .compatible = "riscv,rpmi-system-reset",
>           .service_group = RISCV_RPMI_SRVGRP_SYSTEM_RESET,
>       },
> +    {
> +        .kind = RISCV_RPMI_SERVICE_HSM,
> +        .node_name = "hsm",
> +        .compatible = "riscv,rpmi-hsm",
> +        .service_group = RISCV_RPMI_SRVGRP_HSM,
> +    },
>   };
>   
>   static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
> diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
> index d11db87731..37c56ea2e8 100644
> --- a/include/hw/misc/riscv_rpmi.h
> +++ b/include/hw/misc/riscv_rpmi.h
> @@ -28,6 +28,7 @@
>   #define VIRT_RPMI_P2A_REQ_SIZE 0
>   
>   #define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
> +#define RISCV_RPMI_SRVGRP_HSM            5
>   
>   #define TYPE_RISCV_RPMI "riscv-rpmi"
>   OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
> @@ -36,10 +37,12 @@ struct rpmi_context;
>   struct rpmi_service_group;
>   struct rpmi_shmem;
>   struct rpmi_transport;
> +struct rpmi_hsm;
>   
>   typedef enum RiscvRpmiServiceKind {
>       RISCV_RPMI_SERVICE_INVALID = 0,
>       RISCV_RPMI_SERVICE_SYSRESET,
> +    RISCV_RPMI_SERVICE_HSM,
>   } RiscvRpmiServiceKind;
>   
>   typedef struct RiscvRpmiMachineOps {
> @@ -83,6 +86,9 @@ struct RiscvRpmiState {
>       const RiscvRpmiMachineOps *machine_ops;
>       void *machine_opaque;
>       struct rpmi_service_group *sysreset_group;
> +    struct rpmi_hsm *hsm;
> +    struct rpmi_service_group *hsm_group;
> +    uint32_t *hsm_hw_states;
>       uint32_t *hart_ids;
>       uint32_t hart_count;
>       const RiscvRpmiServiceConfig *services;


