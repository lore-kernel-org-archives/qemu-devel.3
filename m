Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E20BC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiWT-0005s0-Sl; Fri, 17 Jul 2026 09:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiWK-0005qh-Ny
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:22:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiWI-0006mP-7o
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:22:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCTEPQ2903250
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S5lAUjIU8c1R294RkhWlHXqISoI/T/9H0emn7OCCwqo=; b=QeqU80mby6rNe/Wu
 A+r7SP1iuKLNFuA0s2M1EhwAy3X0iYjcZuhHATQJ33X5iIXNMl04f/zb5CoYFEDn
 qcaf7Dgbi4TjKDZmddvWnjcU0IPpuCxFi1DB0YjgznHPiOkYMhp0/CxTk2trk7AN
 w3BTUOPadHtR1qaRihc6MlLLMdFJEDsdEzybRPp4AnuXqUorNZwOe0xmTbXx7k6f
 zMrUVyCLTyrE+arnOFIUpEFRIR+YvSv0IL/fOUzO3N/zOxi05iQzLFunk2CgEtVz
 0arbfY4yA/wVkDdCqEeP6tU4ubxZjRpIcV5rHGlI86DXGvUtVQyAD1bJ2eHYBqJJ
 3zVUSQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6kvfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:22:24 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-81eddfe28b4so64241697b3.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784294543; x=1784899343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S5lAUjIU8c1R294RkhWlHXqISoI/T/9H0emn7OCCwqo=;
 b=HvizF6giU8I75vHMD4MW5xsZvWLbuShSG6bScabH6yaTNobttdB/XuexN0zfuXQjYe
 OIB1WLcmBF8p8+WctoCpROUJ/uqgH+rIY+cBY3tsNyWXx7ZMMGp8LvBbp+OVlzfU7E5E
 jDqlCZZsxZM8V9qJyBfBZtvwdPDxFnTNQ4rDeMp7XI5IaGRjqqJrUPKjA2oYwHwrl1dz
 Gve9uxRCaB7hYIfYvtxDlUh80IUshsa7tR8jaeDVC2uFHqjQJKPS0AFETih3/zSONVJo
 L6Ptm3XmNjcnlNn/ziCcrgcQiR3GrIBIuC5m9GGUeFxdSw9Ue/xFIPBcL562h2TGEq/E
 uybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294543; x=1784899343;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S5lAUjIU8c1R294RkhWlHXqISoI/T/9H0emn7OCCwqo=;
 b=tToYFUddknywp1KuMRvYk8GTjVZNXiWZVYaXZCn2eaf3Z2UaKtmjAddhNq4588QrRT
 GSz52bWsJzQcJql4KtRsEPUz331XZiADkXK/Gva//M5XQELwVxZIynLFXeRYvR8x39RN
 kAF+OU8BGV0Md38IUo30dVNPe4FOMWkEKPsDeD1UAYberLEVAyohOn7aPB9IJjD8R3cC
 RsA3f+zCg/1FuhsuT80o8810oQnW+TT23/uxUlPiwI7YEeDbo3f3ZhYH/d9MmfLxVKEG
 zqDbktWJk53BDx7Nl0eT5xcqb4A5zGYEjNU0s+sF4z0xjTEz60YN6bNl29tqLD4a+qfo
 4Dzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RroWFI702p13eqH9h5QqJwm5ysFqrs2DYXY8gwYFzXE4123xAMilOaWL806lL22dlcOwpZndJW0ZUOS@nongnu.org
X-Gm-Message-State: AOJu0YydOT2F2/eJ1PB1oUQVq5pFpuMgp4Aq3Jff/wtogu7ARequC5aA
 nMRA2zi9KgvliEz/Fu+SdOU5OSFD90w0REfMCm3x9Qb5POfZfITd0M3J6WUiIFXbXDvcEwXQEO8
 cPwltuqzJT1aFwqBiNtqTlwClsVRJVU+C1k4x4EpxBo2SeOh9qbaUCh6fmQ==
X-Gm-Gg: AfdE7cnmp6fhdJG9n7ybHQidyQurHEdR6sJqE8l/Eu8aRKHMpYhxl11GBFjzxd+UFiZ
 5mEEJzoksK96JpxgMhgeB3HRC4BLNYnyKsuZeN2pJDlGtXN8k4dB5DLc7PRNW8BE/LADCSECpdZ
 Y5Qahzyj7V4S+6Twt2MxZ/YUpoMeRQV9rmMrT7GCaA82PlA0j08vz9nUnr/7hVp7q3Kfwn4utDC
 cyNol09c2XhWRh7C+gcxYhLLr6XA5TjaSe/zaY09eU025JvwMnr3iD6WuEThtF39fe17PaIHTzW
 nA+ZGqbAGmwhnWAkTzszEsr3XrJFLSygkGNJhXz3WOZ98D8j1I1bbQUDMlRcE4HcBQ7Nhee4dEm
 VmRBTagUEOiww1uxCuraJWzvPX4o5S6FnOtd8bQ==
X-Received: by 2002:a05:690c:360e:b0:80c:85e5:8739 with SMTP id
 00721157ae682-81ef26dfcdbmr8518067b3.71.1784294543001; 
 Fri, 17 Jul 2026 06:22:23 -0700 (PDT)
X-Received: by 2002:a05:690c:360e:b0:80c:85e5:8739 with SMTP id
 00721157ae682-81ef26dfcdbmr8517877b3.71.1784294542495; 
 Fri, 17 Jul 2026 06:22:22 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81ef405afa2sm9074437b3.20.2026.07.17.06.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:22:21 -0700 (PDT)
Message-ID: <6ec4ca58-bc4a-497b-ba43-ddb1050060af@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:22:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] riscv: add RPMI system suspend service
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-8-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714075659.2258023-8-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfX06msNsVtZ062
 bgfwCsBkHNZ9eOCG/zBfHcR0/W4xG6q5u439oFuggwm/YByifdvWMUQ1hzSSyPgeAlleh+3p9z/
 9Zf1aBqj94OOQa6SXnv086afSPQrJEHK2h5x4rKYugE0LA0LvsB/vsAH5lSnkF9+rTLe2OzjtIz
 bj6P1gBYyLn2rOczAvcJff7A/lGW4t5pkj4B8RziRb9ySXf3l1u+xeM6g/tMDruLHidZv0RH+lL
 WMRyqTw9Txs9KAr5GtZLmRN3/ouZlpffSsz/hopH8LUjh1w6k8hMmPKEvx1Cy0diE5vzTcOF73B
 /vaTakGxu6WBUCgpo/GTeK9JTkG1RVdUjfIyEFINSzPu27ULyQ3ZFxW7sdRQbmac+/t6U1iI1wP
 CXxPOWSkzVRwQ1wxVhvT4bIetJaDhNpmrbKX+Wigf3kSyqil+S9NYr32IFnbgoLPGxwKi4SRW1v
 db9Zjzsj0E9O4ZWTxyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfX3V4ba2H8AIMN
 NMUvHcPOp27zJ9nZm0Ysjrs9/pdHoYzCULUDhgSXkKob0syuJ6AgjiOUSLayD4uBMbCgWV/AmMs
 7qOtqIEkWkcPbJ8erO1FHdBWbLOOsDs=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5a2c90 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=e5ba9WNkjTCz8pKyT8cA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: GJj9OOBVGV6Qy9qzE0VFNmd1hu8CFXZU
X-Proofpoint-ORIG-GUID: GJj9OOBVGV6Qy9qzE0VFNmd1hu8CFXZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170134
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



On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> Add the RPMI System Suspend service group for RISC-V virt.
> 
> The service advertises suspend-to-RAM support through librpmi,
> registers QEMU wakeup support, and routes the suspend finalize callback
> to the machine suspend path. On wakeup it processes RPMI group events
> and defers the HSM hart resume until vCPUs are ready to run again.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/misc/meson.build           |   1 +
>   hw/misc/riscv_rpmi.c          |   4 +
>   hw/misc/riscv_rpmi_hsm.c      |   9 +-
>   hw/misc/riscv_rpmi_internal.h |   5 +
>   hw/misc/riscv_rpmi_syssusp.c  | 191 ++++++++++++++++++++++++++++++++++
>   hw/riscv/virt.c               |  25 +++++
>   include/hw/misc/riscv_rpmi.h  |  11 ++
>   7 files changed, 245 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/riscv_rpmi_syssusp.c
> 
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index fc5b11ed57..cb093a8642 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -172,4 +172,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
>     'riscv_rpmi.c',
>     'riscv_rpmi_sysreset.c',
>     'riscv_rpmi_hsm.c',
> +  'riscv_rpmi_syssusp.c',
>   ), librpmi])
> diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
> index 820b1d5d63..08691861b0 100644
> --- a/hw/misc/riscv_rpmi.c
> +++ b/hw/misc/riscv_rpmi.c
> @@ -187,6 +187,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
>           .kind = RISCV_RPMI_SERVICE_HSM,
>           .add = riscv_rpmi_hsm_add,
>           .remove = riscv_rpmi_hsm_remove,
> +    }, {
> +        .kind = RISCV_RPMI_SERVICE_SYSSUSP,
> +        .add = riscv_rpmi_syssusp_add,
> +        .remove = riscv_rpmi_syssusp_remove,
>       },
>   };
>   
> diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
> index 9a9859b10c..bacdabcac6 100644
> --- a/hw/misc/riscv_rpmi_hsm.c
> +++ b/hw/misc/riscv_rpmi_hsm.c
> @@ -235,7 +235,6 @@ static void riscv_rpmi_hsm_destroy(RiscvRpmiState *s)
>       g_clear_pointer(&s->hsm_hw_states, g_free);
>   }
>   
> -
>   bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp)
>   {
>       struct rpmi_service_group *group;
> @@ -278,3 +277,11 @@ void riscv_rpmi_hsm_reset(RiscvRpmiState *s)
>           rpmi_hsm_process_state_changes(s->hsm);
>       }
>   }
> +
> +void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index)
> +{
> +    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STARTED);
> +    if (s->hsm) {
> +        rpmi_hsm_process_state_changes(s->hsm);
> +    }
> +}
> diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
> index 42a6708907..34cab35c32 100644
> --- a/hw/misc/riscv_rpmi_internal.h
> +++ b/hw/misc/riscv_rpmi_internal.h
> @@ -33,5 +33,10 @@ void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
>   bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
>   void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
>   void riscv_rpmi_hsm_reset(RiscvRpmiState *s);
> +void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index);
> +
> +bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp);
> +void riscv_rpmi_syssusp_remove(RiscvRpmiState *s);
> +
>   
>   #endif
> diff --git a/hw/misc/riscv_rpmi_syssusp.c b/hw/misc/riscv_rpmi_syssusp.c
> new file mode 100644
> index 0000000000..d455e08163
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi_syssusp.c
> @@ -0,0 +1,191 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI System Suspend service.
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "riscv_rpmi_internal.h"
> +#include "qemu/timer.h"
> +#include "system/runstate.h"
> +
> +static const struct rpmi_system_suspend_type riscv_rpmi_syssusp_types[] = {
> +    {
> +        .type = RPMI_SYSSUSP_TYPE_SUSPEND_TO_RAM,
> +        .attr = RPMI_SYSSUSP_ATTRS_FLAGS_RESUMEADDR,
> +    },
> +};
> +
> +static enum rpmi_error riscv_rpmi_syssusp_prepare(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_system_suspend_type *syssusp_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    RiscvRpmiState *s = priv;
> +
> +    if (s->machine_ops && s->machine_ops->register_wakeup_support) {
> +        s->machine_ops->register_wakeup_support(s->machine_opaque);
> +    }
> +    return RPMI_SUCCESS;
> +}
> +
> +static rpmi_bool_t riscv_rpmi_syssusp_ready(void *priv,
> +                                            rpmi_uint32_t hart_index)
> +{
> +    return true;
> +}
> +
> +static void riscv_rpmi_syssusp_finalize(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_system_suspend_type *syssusp_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    RiscvRpmiState *s = priv;
> +
> +    if (s->machine_ops && s->machine_ops->system_suspend) {
> +        s->machine_ops->system_suspend(s->machine_opaque);
> +    }
> +}
> +
> +static rpmi_bool_t riscv_rpmi_syssusp_can_resume(void *priv,
> +                                                 rpmi_uint32_t hart_index)
> +{
> +    RiscvRpmiState *s = priv;
> +
> +    if (s->machine_ops && s->machine_ops->system_can_resume) {
> +        return s->machine_ops->system_can_resume(s->machine_opaque);
> +    }
> +
> +    return true;
> +}
> +
> +static enum rpmi_error riscv_rpmi_syssusp_resume(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_system_suspend_type *syssusp_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    RiscvRpmiState *s = priv;
> +
> +    s->syssusp_resume_hart_index = hart_index;
> +    s->syssusp_resume_pending = true;
> +    return RPMI_SUCCESS;
> +}
> +
> +static const struct rpmi_syssusp_platform_ops riscv_rpmi_syssusp_ops = {
> +    .system_suspend_prepare = riscv_rpmi_syssusp_prepare,
> +    .system_suspend_ready = riscv_rpmi_syssusp_ready,
> +    .system_suspend_finalize = riscv_rpmi_syssusp_finalize,
> +    .system_suspend_can_resume = riscv_rpmi_syssusp_can_resume,
> +    .system_suspend_resume = riscv_rpmi_syssusp_resume,
> +};
> +
> +static void riscv_rpmi_wakeup_timer(void *opaque)
> +{
> +    RiscvRpmiState *s = opaque;
> +
> +    if (s->syssusp_resume_pending) {
> +        riscv_rpmi_hsm_resume(s, s->syssusp_resume_hart_index);
> +        s->syssusp_resume_pending = false;
> +    }
> +}
> +
> +static void riscv_rpmi_wakeup_notify(Notifier *notifier, void *data)
> +{
> +    RiscvRpmiState *s = container_of(notifier, RiscvRpmiState,
> +                                     wakeup_notifier);
> +
> +    if (s->context) {
> +        rpmi_context_process_group_events(s->context,
> +                                          RPMI_SRVGRP_SYSTEM_SUSPEND);
> +    }
> +    if (s->wakeup_timer) {
> +        /*
> +         * Wakeup notifiers run before vCPUs resume. Defer the HSM
> +         * kick so OpenSBI can leave WFI after QEMU restarts execution.
> +         */
> +        timer_mod(s->wakeup_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 10);
> +    }
> +}
> +
> +static bool riscv_rpmi_syssusp_create(RiscvRpmiState *s,
> +                                      struct rpmi_service_group **group,
> +                                      Error **errp)
> +{
> +    if (!s->hsm) {
> +        error_setg(errp, "RPMI system suspend service requires HSM service");
> +        return false;
> +    }
> +
> +    if (s->machine_ops && s->machine_ops->register_wakeup_support) {
> +        s->machine_ops->register_wakeup_support(s->machine_opaque);
> +    }
> +    if (!s->wakeup_timer) {
> +        s->wakeup_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> +                                       riscv_rpmi_wakeup_timer, s);
> +    }
> +    if (!s->wakeup_notifier_registered) {
> +        s->wakeup_notifier.notify = riscv_rpmi_wakeup_notify;
> +        qemu_register_wakeup_notifier(&s->wakeup_notifier);
> +        s->wakeup_notifier_registered = true;
> +    }
> +
> +    *group = rpmi_service_group_syssusp_create(
> +        s->hsm, ARRAY_SIZE(riscv_rpmi_syssusp_types),
> +        riscv_rpmi_syssusp_types, &riscv_rpmi_syssusp_ops, s);
> +    if (!*group) {
> +        error_setg(errp, "failed to create RPMI system suspend service group");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void riscv_rpmi_syssusp_destroy(RiscvRpmiState *s)
> +{
> +    if (s->wakeup_notifier_registered) {
> +        notifier_remove(&s->wakeup_notifier);
> +        s->wakeup_notifier_registered = false;
> +    }
> +    if (s->wakeup_timer) {
> +        timer_free(s->wakeup_timer);
> +        s->wakeup_timer = NULL;
> +    }
> +
> +    if (s->syssusp_group) {
> +        rpmi_service_group_syssusp_destroy(s->syssusp_group);
> +        s->syssusp_group = NULL;
> +    }
> +}
> +
> +bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp)
> +{
> +    struct rpmi_service_group *group;
> +
> +    if (s->syssusp_group) {
> +        error_setg(errp, "duplicate RPMI system suspend descriptor");
> +        return false;
> +    }
> +
> +    if (!riscv_rpmi_syssusp_create(s, &group, errp)) {
> +        return false;
> +    }
> +
> +    if (!riscv_rpmi_context_add_group(s, group, "system suspend", errp)) {
> +        s->syssusp_group = group;
> +        riscv_rpmi_syssusp_destroy(s);
> +        return false;
> +    }
> +
> +    s->syssusp_group = group;
> +    return true;
> +}
> +
> +void riscv_rpmi_syssusp_remove(RiscvRpmiState *s)
> +{
> +    riscv_rpmi_context_remove_group(s, s->syssusp_group);
> +    riscv_rpmi_syssusp_destroy(s);
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2b5f367bdb..21c218a78d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -51,6 +51,7 @@
>   #include "chardev/char.h"
>   #include "system/device_tree.h"
>   #include "system/system.h"
> +#include "system/runstate.h"
>   #include "system/tcg.h"
>   #include "system/kvm.h"
>   #include "system/tpm.h"
> @@ -1020,6 +1021,12 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
>           .compatible = "riscv,rpmi-hsm",
>           .service_group = RISCV_RPMI_SRVGRP_HSM,
>       },
> +    {
> +        .kind = RISCV_RPMI_SERVICE_SYSSUSP,
> +        .node_name = "suspend",
> +        .compatible = "riscv,rpmi-system-suspend",
> +        .service_group = RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND,
> +    },
>   };
>   
>   static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
> @@ -1037,9 +1044,27 @@ static void virt_rpmi_system_shutdown(void *opaque)
>       qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>   }
>   
> +static void virt_rpmi_system_suspend(void *opaque)
> +{
> +    qemu_system_suspend_request();
> +}
> +
> +static void virt_rpmi_register_wakeup_support(void *opaque)
> +{
> +    qemu_register_wakeup_support();
> +}
> +
> +static bool virt_rpmi_system_can_resume(void *opaque)
> +{
> +    return runstate_check(RUN_STATE_RUNNING);
> +}
> +
>   static const RiscvRpmiMachineOps virt_rpmi_machine_ops = {
>       .system_reset = virt_rpmi_system_reset,
>       .system_shutdown = virt_rpmi_system_shutdown,
> +    .system_suspend = virt_rpmi_system_suspend,
> +    .register_wakeup_support = virt_rpmi_register_wakeup_support,
> +    .system_can_resume = virt_rpmi_system_can_resume,
>   };
>   
>   static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
> diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
> index 37c56ea2e8..a4fe2aac63 100644
> --- a/include/hw/misc/riscv_rpmi.h
> +++ b/include/hw/misc/riscv_rpmi.h
> @@ -29,6 +29,7 @@
>   
>   #define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
>   #define RISCV_RPMI_SRVGRP_HSM            5
> +#define RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND 4
>   
>   #define TYPE_RISCV_RPMI "riscv-rpmi"
>   OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
> @@ -43,11 +44,15 @@ typedef enum RiscvRpmiServiceKind {
>       RISCV_RPMI_SERVICE_INVALID = 0,
>       RISCV_RPMI_SERVICE_SYSRESET,
>       RISCV_RPMI_SERVICE_HSM,
> +    RISCV_RPMI_SERVICE_SYSSUSP,
>   } RiscvRpmiServiceKind;
>   
>   typedef struct RiscvRpmiMachineOps {
>       void (*system_reset)(void *opaque);
>       void (*system_shutdown)(void *opaque);
> +    void (*system_suspend)(void *opaque);
> +    void (*register_wakeup_support)(void *opaque);
> +    bool (*system_can_resume)(void *opaque);
>   } RiscvRpmiMachineOps;
>   typedef struct RiscvRpmiServiceConfig {
>       RiscvRpmiServiceKind kind;
> @@ -86,9 +91,15 @@ struct RiscvRpmiState {
>       const RiscvRpmiMachineOps *machine_ops;
>       void *machine_opaque;
>       struct rpmi_service_group *sysreset_group;
> +    struct rpmi_service_group *syssusp_group;
>       struct rpmi_hsm *hsm;
>       struct rpmi_service_group *hsm_group;
>       uint32_t *hsm_hw_states;
> +    Notifier wakeup_notifier;
> +    bool wakeup_notifier_registered;
> +    QEMUTimer *wakeup_timer;
> +    bool syssusp_resume_pending;
> +    uint32_t syssusp_resume_hart_index;
>       uint32_t *hart_ids;
>       uint32_t hart_count;
>       const RiscvRpmiServiceConfig *services;


