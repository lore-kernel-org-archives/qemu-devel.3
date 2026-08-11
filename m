Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEED3C5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgbf-0001W9-9P; Tue, 11 Aug 2026 03:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgbd-0001Vj-Ne
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:09:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgba-0002Mv-17
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:09:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B72fdo2996877
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ANT4OlntRP7/5xC8lR4Vm1Kp5J4Ug3T8FfLaouWZrHE=; b=W8ta8Df71DaX3g1F
 Cm5paaCYv2N8RSP63XrKTTjl06YqrRNx9RAmhn4waM0FoUvsMtB2Shl6MWM1um63
 14xJ439+47QIT5w+lYn5jwBHG2IGl340EG0pPh7cEmu1VeiLLnfi4tO2AhRe011q
 z8oFqdALQH/lSl98F/TYKx9R0QwUtDG3x4BonHQ7VRgS6R8IQAHchYaIzuHluq77
 I0Uhc4y/9iza8ZpvzJ6QF+5kKnaFqnQZdaRjfo8iWm4bKaxOcexHhgH1OeCQC5OK
 j/PwRZu9bposjZUTKHEfpJBne/wWDst22RxPdaLbO4RmK1j7BDQnn3A5Ts2l+ZMD
 0S9BLQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf2rq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:08:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c12e43b98so5990551cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786432135; x=1787036935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ANT4OlntRP7/5xC8lR4Vm1Kp5J4Ug3T8FfLaouWZrHE=;
 b=Z/05zzvXLljGvO+9vbUUZ2xGh+OuY5i4Gi8Op1tzsAxtQfr1prHv2XTSSTsunVWdmw
 UsU9G6nTD4v5+gsmm5bmOGLXxB7Gut5Q5nldL4suo92hHFW1ONtm0VivXKU0/jq7L3+/
 c9nV1t8W7Q6fkhMSHq9l9BcIJ+UEb96MmkDyvwlFVikrEea2Wjbw6AbxEVHMfNgp6kNE
 h4qyOaE+BhTuPjSWwAJ7w2512Qd7RI+LS5akX1VZOl85BM3GYhbVkOkzPZUXi497iwDJ
 BTgDxnBc1d0xxCaolkXkpSGvvlTg/uPCrMN1q10p2YnjdYVJBbFYTK48CtvEOsEvxXOQ
 VlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786432135; x=1787036935;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ANT4OlntRP7/5xC8lR4Vm1Kp5J4Ug3T8FfLaouWZrHE=;
 b=T4H2Oqc2yUbGBAu/D7Av2iuKeYNjk89WgAgVIvUX9FuMcE6e/PziTKuJOJvR0EfFgl
 Vcbb8QKJXudfJJuIg32DT5Bgl1C90gBSgh9LTsQA/sN31vTxjH80pGQHHBqas1hX64j5
 yQgber4e6XrB/Nse5G6uNgLkS8MtPuBOGkWPVTY4ddX3Z2OgqFJyu8wbCKQ7s5Pz7Hqo
 1NY4IIsw5ca4FHuzU8BKM8cpcCNYKfXHR8jY0EblzyGPvnZZ/+D06GQUgxBzrZqJ17eJ
 0G1RZcPHazWUXd0iIgtQjfGM6/PgD5O7S+ZK2J2hvYomckd9O3xJ9DSF7OvyeFeEVo4k
 VazQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqokvawrsqTlAa27GKw1t9T6C4AkP2bb87pUucHTwFitCuLuvwv5gVJDvPdDui90Shcng7Hm4vArH4r@nongnu.org
X-Gm-Message-State: AOJu0Yz5xdnA+haYC1Hh11VEzkVW5h6ifxUoQ54qb9obg9whrrnKczuB
 WYzqTofTFFrbSF9dc1wQn+RfrniGbrqOAdKS2qxRcx98akrErayHedu8CjubCNvf7Z5kaUscRig
 23Eetl3+hUCs2uFu+GsPRDse7oZ0guRblZF+yZWHrsMJyYDwAyhPMG8L8Pw==
X-Gm-Gg: AR+sD105tsSg8FuPj04o6UoxPvhySjB6Etjq+tRr+bYIpb0koQFtbD4cE8YNT+1MG/H
 KvwB5Ez8zb/4b4mIP+eX2vFwfPRh7mkH25EwN1ayw3F5jWCBlDgVB2Xayv8bvKi7Lxj0dpYKTk6
 XmAZVaJfjmIGQIbI9Qgy+oyd7UVWwDlk129xx9tv4f9wJP7Ttp95ltRZYYhHoV1Wd8NjjNBcWqJ
 c2NdixvHlRhFMCxVKcZRF7R+XRTIFsavTgHJCW5SW8aj53/9wDsQJXyBvUZ4kFeo96X9i3Is0dS
 NFHjnpn50UeZkPyg4JMt71sOSRGKlBPrOL9Gfs4SQsoFGm3X42Ps4qrLBw2IJDw6HOUGxo6zEls
 vEsEnB05WK/II/O6PIyUrsTZkI0VMprEmFIW9RW9y
X-Received: by 2002:a05:622a:999:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-52d58616b9dmr9724291cf.21.1786432135192; 
 Tue, 11 Aug 2026 00:08:55 -0700 (PDT)
X-Received: by 2002:a05:622a:999:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-52d58616b9dmr9723961cf.21.1786432134602; 
 Tue, 11 Aug 2026 00:08:54 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977bab2f5sm15994965e9.0.2026.08.11.00.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 00:08:52 -0700 (PDT)
Message-ID: <5258455f-7946-46df-baa1-44e31329d4ed@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 09:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/timer: add DesignWare APB timer model
Content-Language: en-US
To: raoyi <rao232328@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, bmeng.cn@gmail.com
References: <20260811064612.16517-1-rao232328@gmail.com>
 <20260811064612.16517-2-rao232328@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811064612.16517-2-rao232328@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nQJle4rjjCbvH7BIxSX_X37JyQ7dTyDB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1OCBTYWx0ZWRfX9JMfSI59xm3n
 SydO+5xttPa8XiH0tQeB9EstUNvNrd/uQSf+Elqt/gAInoO/d/mdsGEdMmCJ9/8EVE/9mS0LwBp
 yaYtGcK1rRaofozxMEQGvoACZB8nrb8=
X-Proofpoint-GUID: nQJle4rjjCbvH7BIxSX_X37JyQ7dTyDB
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7aca87 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=VcPOkW3q745Xs-ZT0bIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1OCBTYWx0ZWRfX8l/+c9SKdifh
 nCt1IdY8aI24+oaVN7J6GKDVrV999vPszbSYW/ooht4piuEeGRjk17PPDOMPltpaEgqo8y6HNAr
 FFG2pO6Q0sPKyLJBXqzPR0xUWF1vSRRGCaLZ8yXSE3kISefikUtCnI/7/WAO5WMN3m3kpgef7Tn
 3OSx/y7Co+j+1iYhQ+BWhlix5A3tphn5H1rrqOI/6hYumLhLhhyw8DtkTKCWyln4SbmCaMn8GQO
 vvzELlelurSLtvfGgsQLfv6TbT4km+mtloqwS57FQBrBtkDNW6uwi4b/FNxy/hvBhI86wCQO42t
 4Sz/k/3vD71Pn/aNgQY+l1CPjZJqoVBUVoKfp6x34izQjEnnDYvQu08tBwMb0JPgDurjKsBwPRT
 VIlt2jtJsJsuDWk+7nfJD9dRa3+PTdCaKTf/kDGPYJ9GBe+VVJidHbNXFm1o0JPNxBOlwR//J8x
 kGPyl9uOj//u/eZgquA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110058
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi raoyi,

On 11/8/26 08:46, raoyi wrote:
> Add generic DesignWare APB timer device model.
> The timer uses the Clock framework for frequency input
> and supports a configurable number of timer channels
> via the num-timers property (max 8, default 6).

Scratch "uses the Clock framework for frequency input and",
this is an irrelevant implementation detail.

> 
> Signed-off-by: raoyi <rao232328@gmail.com>
> ---
>   hw/timer/Kconfig                |   4 +
>   hw/timer/dw-apb-timer.c         | 341 ++++++++++++++++++++++++++++++++
>   hw/timer/meson.build            |   1 +
>   hw/timer/trace-events           |   8 +
>   include/hw/timer/dw-apb-timer.h |  65 ++++++
>   5 files changed, 419 insertions(+)
>   create mode 100644 hw/timer/dw-apb-timer.c
>   create mode 100644 include/hw/timer/dw-apb-timer.h

Please cover this device in MAINTAINERS.

> 
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index b3d823ce2c..b533cf1ba9 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -65,3 +65,7 @@ config STELLARIS_GPTM
>   
>   config AVR_TIMER16
>       bool
> +
> +config DW_APB_TIMER
> +    bool
> +    select PTIMER
> diff --git a/hw/timer/dw-apb-timer.c b/hw/timer/dw-apb-timer.c
> new file mode 100644
> index 0000000000..385eff3ba4
> --- /dev/null
> +++ b/hw/timer/dw-apb-timer.c
> @@ -0,0 +1,341 @@
> +/*
> + * Synopsys DesignWare APB timer
> + *
> + * Copyright (c) 2026 raoyi <rao232328@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "hw/core/ptimer.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/timer/dw-apb-timer.h"
> +#include "trace.h"
> +
> +static void dw_apb_timer_update_irq(DWAPBTimerChannel *t)
> +{
> +    qemu_set_irq(t->irq, t->int_status &&
> +                 !(t->control & DW_APB_TIMER_CONTROL_INT));
> +}
> +
> +static void dw_apb_timer_clk_update(void *opaque, ClockEvent event)
> +{
> +    DWAPBTimerChannel *t = opaque;
> +
> +    if (!t->ptimer) {
> +        return;
> +    }
> +    ptimer_transaction_begin(t->ptimer);
> +    ptimer_set_period_from_clock(t->ptimer, t->clk, 1);
> +    ptimer_transaction_commit(t->ptimer);
> +}
> +
> +static void dw_apb_timer_enable(DWAPBTimerChannel *t)
> +{
> +    ptimer_transaction_begin(t->ptimer);
> +    ptimer_set_limit(t->ptimer, t->load ? t->load : 1, 1);
> +    ptimer_run(t->ptimer, 1);
> +    ptimer_transaction_commit(t->ptimer);
> +
> +    trace_dw_apb_timer_enable(t->id, t->load);

We usually trace on entry. If you want to notify the realized
action, then rename as trace_dw_apb_timer_enabled() for clarity?

> +}
> +
> +static void dw_apb_timer_disable(DWAPBTimerChannel *t)
> +{
> +    ptimer_transaction_begin(t->ptimer);
> +    ptimer_stop(t->ptimer);
> +    ptimer_transaction_commit(t->ptimer);
> +
> +    t->int_status = 0;
> +    dw_apb_timer_update_irq(t);
> +
> +    trace_dw_apb_timer_disable(t->id);

Ditto trace_dw_apb_timer_disabled().

> +}
> +
> +static void dw_apb_timer_tick(void *opaque)
> +{
> +    DWAPBTimerChannel *t = opaque;
> +    uint32_t reload;
> +
> +    trace_dw_apb_timer_tick(t->id);
> +
> +    t->int_status = 1;
> +    dw_apb_timer_update_irq(t);
> +
> +    if (t->control & DW_APB_TIMER_CONTROL_MODE_PERIODIC) {
> +        reload = t->load ? t->load : 1;
> +    } else {
> +        reload = UINT32_MAX;
> +    }
> +
> +    ptimer_set_limit(t->ptimer, reload, 1);
> +    ptimer_run(t->ptimer, 1);
> +}
> +
> +static uint64_t dw_apb_timer_read(void *opaque, hwaddr addr,
> +                                  unsigned int size)
> +{
> +    DWAPBTimerState *s = DW_APB_TIMER(opaque);
> +    uint32_t value = 0;
> +
> +    addr &= 0xfff;

Masking address like that is dubious. Users should map aliased / banked
regions with memory_region_init_alias() / memory_region_add_subregion().

> +
> +    if (addr < DW_APB_TIMER_INT_STATUS) {
> +        unsigned int idx = addr / DW_APB_TIMER_STRIDE;
> +        hwaddr reg = addr % DW_APB_TIMER_STRIDE;
> +
> +        if (idx < s->num_timers) {
> +            DWAPBTimerChannel *t = &s->timers[idx];
> +
> +            switch (reg) {
> +            case DW_APB_TIMER_N_LOAD_COUNT:
> +                value = t->load;
> +                break;
> +            case DW_APB_TIMER_N_CURRENT_VALUE:
> +                if (t->control & DW_APB_TIMER_CONTROL_ENABLE) {
> +                    value = ptimer_get_count(t->ptimer);
> +                }
> +                break;
> +            case DW_APB_TIMER_N_CONTROL:
> +                value = t->control;
> +                break;
> +            case DW_APB_TIMER_N_EOI:
> +                t->int_status = 0;
> +                dw_apb_timer_update_irq(t);
> +                trace_dw_apb_timer_irq_clear(t->id);
> +                break;
> +            case DW_APB_TIMER_N_INT_STATUS:
> +                value = t->int_status &&
> +                        !(t->control & DW_APB_TIMER_CONTROL_INT);
> +                break;
> +            default:
> +                break;
> +            }
> +        }
> +    } else {
> +        switch (addr) {
> +        case DW_APB_TIMER_INT_STATUS:
> +            for (int i = 0; i < s->num_timers; i++) {
> +                DWAPBTimerChannel *t = &s->timers[i];
> +
> +                value |= (t->int_status &&
> +                          !(t->control & DW_APB_TIMER_CONTROL_INT)) << i;
> +            }
> +            break;
> +        case DW_APB_TIMER_EOI:
> +            for (int i = 0; i < s->num_timers; i++) {
> +                DWAPBTimerChannel *t = &s->timers[i];
> +
> +                t->int_status = 0;
> +                dw_apb_timer_update_irq(t);
> +            }
> +            break;
> +        case DW_APB_TIMER_RAW_INT_STATUS:
> +            for (int i = 0; i < s->num_timers; i++) {
> +                value |= s->timers[i].int_status << i;
> +            }
> +            break;
> +        case DW_APB_TIMER_COMP_VERSION:
> +            value = s->comp_version;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    trace_dw_apb_timer_read(addr, value);
> +    return value;
> +}
> +
> +static void dw_apb_timer_write(void *opaque, hwaddr addr,
> +                               uint64_t value, unsigned int size)
> +{
> +    DWAPBTimerState *s = DW_APB_TIMER(opaque);
> +
> +    addr &= 0xfff;
> +
> +    if (addr < DW_APB_TIMER_INT_STATUS) {
> +        unsigned int idx = addr / DW_APB_TIMER_STRIDE;
> +        hwaddr reg = addr % DW_APB_TIMER_STRIDE;
> +
> +        if (idx < s->num_timers) {
> +            DWAPBTimerChannel *t = &s->timers[idx];
> +
> +            switch (reg) {
> +            case DW_APB_TIMER_N_LOAD_COUNT:
> +                t->load = value;
> +                break;
> +            case DW_APB_TIMER_N_CONTROL: {
> +                uint32_t old_control = t->control;
> +                uint32_t new_control = value & DW_APB_TIMER_CONTROL_RW_MASK;
> +
> +                t->control = new_control;
> +                if ((new_control ^ old_control) &
> +                    DW_APB_TIMER_CONTROL_ENABLE) {
> +                    if (new_control & DW_APB_TIMER_CONTROL_ENABLE) {
> +                        dw_apb_timer_enable(t);
> +                    } else {
> +                        dw_apb_timer_disable(t);
> +                    }
> +                }
> +                if ((new_control ^ old_control) &
> +                    DW_APB_TIMER_CONTROL_INT) {
> +                    dw_apb_timer_update_irq(t);
> +                }
> +                break;
> +            }
> +            default:
> +                break;
> +            }
> +        }
> +    }
> +
> +    trace_dw_apb_timer_write(addr, value);
> +}
> +
> +static const MemoryRegionOps dw_apb_timer_ops = {
> +    .read = dw_apb_timer_read,
> +    .write = dw_apb_timer_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void dw_apb_timer_realize(DeviceState *dev, Error **errp)
> +{
> +    DWAPBTimerState *s = DW_APB_TIMER(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    if (s->num_timers == 0 || s->num_timers > DW_APB_TIMER_MAX_TIMERS) {
> +        error_setg(errp, "dw-apb-timer: num-timers must be between 1 and %u",
> +                   DW_APB_TIMER_MAX_TIMERS);
> +        return;
> +    }
> +
> +    for (int i = 0; i < s->num_timers; i++) {
> +        DWAPBTimerChannel *t = &s->timers[i];
> +
> +        if (!clock_has_source(t->clk)) {
> +            error_setg(errp, "dw-apb-timer: timer[%u] clock must be connected",
> +                       i);
> +            return;
> +        }
> +    }
> +
> +    for (int i = 0; i < s->num_timers; i++) {
> +        DWAPBTimerChannel *t = &s->timers[i];
> +
> +        t->ptimer = ptimer_init(dw_apb_timer_tick, t,
> +            PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
> +            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
> +            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
> +        ptimer_transaction_begin(t->ptimer);
> +        ptimer_set_limit(t->ptimer, UINT32_MAX, 1);
> +        ptimer_transaction_commit(t->ptimer);
> +        sysbus_init_irq(sbd, &t->irq);
> +
> +        /* The source may have been connected before the ptimer existed. */
> +        dw_apb_timer_clk_update(t, ClockUpdate);
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &dw_apb_timer_ops,
> +                          s, TYPE_DW_APB_TIMER, DW_APB_TIMER_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void dw_apb_timer_reset(DeviceState *dev)
> +{
> +    DWAPBTimerState *s = DW_APB_TIMER(dev);
> +
> +    for (int i = 0; i < s->num_timers; i++) {
> +        DWAPBTimerChannel *t = &s->timers[i];
> +
> +        ptimer_transaction_begin(t->ptimer);
> +        ptimer_stop(t->ptimer);
> +        ptimer_transaction_commit(t->ptimer);
> +
> +        t->load = 0;
> +        t->control = 0;
> +        t->int_status = 0;
> +        dw_apb_timer_update_irq(t);
> +    }
> +}
> +
> +static const VMStateDescription vmstate_dw_apb_timer_channel = {
> +    .name = "dw-apb-timer-channel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_PTIMER(ptimer, DWAPBTimerChannel),
> +        VMSTATE_CLOCK(clk, DWAPBTimerChannel),
> +        VMSTATE_UINT32(load, DWAPBTimerChannel),
> +        VMSTATE_UINT32(control, DWAPBTimerChannel),
> +        VMSTATE_UINT32(int_status, DWAPBTimerChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_dw_apb_timer = {
> +    .name = "dw-apb-timer",
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT_VARRAY_UINT32(timers, DWAPBTimerState,
> +                                     num_timers, 0,
> +                                     vmstate_dw_apb_timer_channel,
> +                                     DWAPBTimerChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const Property dw_apb_timer_properties[] = {
> +    DEFINE_PROP_UINT32("num-timers", DWAPBTimerState, num_timers, 1),
> +    DEFINE_PROP_UINT32("comp-version", DWAPBTimerState, comp_version,
> +                       0x3231312A),

Why expose "comp-version"? What is this default magic value?

> +};
> +
> +static void dw_apb_timer_init(Object *obj)
> +{
> +    DWAPBTimerState *s = DW_APB_TIMER(obj);
> +
> +    for (int i = 0; i < DW_APB_TIMER_MAX_TIMERS; i++) {
> +        DWAPBTimerChannel *t = &s->timers[i];
> +        g_autofree char *name = g_strdup_printf("timer[%d]", i);
> +
> +        t->id = i;
> +        t->clk = qdev_init_clock_in(DEVICE(obj), name,
> +                                    dw_apb_timer_clk_update, t,
> +                                    ClockUpdate);
> +    }
> +}
> +
> +static void dw_apb_timer_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = dw_apb_timer_realize;
> +    dc->vmsd = &vmstate_dw_apb_timer;
> +    dc->desc = "Synopsys DesignWare APB timer";
> +    device_class_set_legacy_reset(dc, dw_apb_timer_reset);

Please do not use device_class_set_legacy_reset().

> +    device_class_set_props(dc, dw_apb_timer_properties);
> +}
> +
> +static const TypeInfo dw_apb_timer_info = {
> +    .name          = TYPE_DW_APB_TIMER,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(DWAPBTimerState),
> +    .instance_init = dw_apb_timer_init,

Missing deallocation:

        .instance_finalize = dw_apb_timer_init,

(Adding dw_apb_timer_unrealize would also be cleaner).

> +    .class_init    = dw_apb_timer_class_init,
> +};
> +
> +static void dw_apb_timer_register_type(void)
> +{
> +    type_register_static(&dw_apb_timer_info);
> +}
> +
> +type_init(dw_apb_timer_register_type)
> diff --git a/hw/timer/meson.build b/hw/timer/meson.build
> index 201b5d8316..fccc36540c 100644
> --- a/hw/timer/meson.build
> +++ b/hw/timer/meson.build
> @@ -34,3 +34,4 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
>   
>   system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
> +system_ss.add(when: 'CONFIG_DW_APB_TIMER', if_true: files('dw-apb-timer.c'))
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 634ba1da27..7f592a96c8 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -1,5 +1,13 @@
>   # See docs/devel/tracing.rst for syntax documentation.
>   
> +# dw-apb-timer.c
> +dw_apb_timer_read(uint64_t addr, uint32_t val) "DW APB timer read: [0x%" PRIx64 "] -> 0x%" PRIx32
> +dw_apb_timer_write(uint64_t addr, uint64_t val) "DW APB timer write: [0x%" PRIx64 "] <- 0x%" PRIx64
> +dw_apb_timer_tick(int idx) "DW APB timer %d tick"
> +dw_apb_timer_irq_clear(int idx) "DW APB timer %d IRQ cleared"
> +dw_apb_timer_enable(int idx, uint32_t load) "DW APB timer %d enabled load=0x%" PRIx32
> +dw_apb_timer_disable(int idx) "DW APB timer %d disabled"
> +
>   # slavio_timer.c
>   slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit 0x%"PRIx64" count 0x%x0x%08x"
>   slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x%x0x%08x"
> diff --git a/include/hw/timer/dw-apb-timer.h b/include/hw/timer/dw-apb-timer.h
> new file mode 100644
> index 0000000000..b08b713fa3
> --- /dev/null
> +++ b/include/hw/timer/dw-apb-timer.h
> @@ -0,0 +1,65 @@
> +/*
> + * Synopsys DesignWare APB timer
> + *
> + * Copyright (c) 2026 raoyi <rao232328@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef DW_APB_TIMER_H
> +#define DW_APB_TIMER_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/clock.h"
> +#include "qom/object.h"
> +
> +#define TYPE_DW_APB_TIMER "dw-apb-timer"
> +OBJECT_DECLARE_SIMPLE_TYPE(DWAPBTimerState, DW_APB_TIMER)
> +
> +#define DW_APB_TIMER_MMIO_SIZE    0x100
> +#define DW_APB_TIMER_MAX_TIMERS   8
> +#define DW_APB_TIMER_STRIDE       0x14
> +
> +/* Per-timer register offsets */
> +#define DW_APB_TIMER_N_LOAD_COUNT    0x00
> +#define DW_APB_TIMER_N_CURRENT_VALUE 0x04
> +#define DW_APB_TIMER_N_CONTROL       0x08
> +#define DW_APB_TIMER_N_EOI           0x0c
> +#define DW_APB_TIMER_N_INT_STATUS    0x10
> +/* Global register offsets */
> +#define DW_APB_TIMER_INT_STATUS        0xa0
> +#define DW_APB_TIMER_EOI               0xa4
> +#define DW_APB_TIMER_RAW_INT_STATUS    0xa8
> +#define DW_APB_TIMER_COMP_VERSION      0xac
> +
> +/* Control register bits */
> +#define DW_APB_TIMER_CONTROL_ENABLE        BIT(0)
> +/* 1: periodic, 0:free running. */
> +#define DW_APB_TIMER_CONTROL_MODE_PERIODIC BIT(1)
> +#define DW_APB_TIMER_CONTROL_INT           BIT(2)
> +#define DW_APB_TIMER_CONTROL_RW_MASK       0x7

Please keep offsets / bits definitions within the C file,
no need to expose them.

> +
> +typedef struct DWAPBTimerChannel {
> +    struct ptimer_state *ptimer;
> +    Clock *clk;
> +    qemu_irq irq;
> +    unsigned int id;
> +    uint32_t load;
> +    uint32_t control;
> +    uint32_t int_status;
> +} DWAPBTimerChannel;
> +
> +struct DWAPBTimerState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */

Please drop those private/public comments.

> +    MemoryRegion mmio;
> +    uint32_t num_timers;
> +    uint32_t comp_version;
> +    DWAPBTimerChannel timers[DW_APB_TIMER_MAX_TIMERS];
> +};
> +
> +#endif

Besides the minor comments, the overall patch LGTM!

Regards,

Phil.

