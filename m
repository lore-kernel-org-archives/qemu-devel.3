Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB8AC982FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9bh4-00045A-KR; Thu, 24 Sep 2026 01:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bh1-000450-0n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:08:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bgz-0000Td-8j
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:08:22 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O36jj11208362
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iPARFZ8gXnIzohb65RUugnxtnzAKwgIbXl9jKDC/RJI=; b=heppe1nGvyDVrehb
 NGrPzNgq2KALmy+PjTThLj0kt5TwR115r12EiiUw86wi6KWALrwTyaHw+DwioyLo
 UPToNQRF6Vn36mIxXuFGWe5wYX2iwxWvXkYB5nt3inazsD4eXo0LTRZdd5vowx7S
 XOyDPkFjnZSK5cN0l348SgVS5uiCTASMqvgY7MGU8x8tAlSMTMelKRi5HgoVnrid
 oK8j/olRFhgaogG1L5ZgFatbaaB9i93nboIZVGHzrcKioTfZe4TfPtmm+MQdJtb1
 RNvrOh8UG47fdGOcLu53WrmdpeNaKYPvImablLovQOFrgrQwtqHePKfMpADVh3Si
 kBf9Hw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvsfgrr8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:08:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93be6ed214eso252366985a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790226499; x=1790831299; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iPARFZ8gXnIzohb65RUugnxtnzAKwgIbXl9jKDC/RJI=;
 b=P1beMd1q9hrXCQF6k9g2VdqKHx1g33GOPTuSoTC1Sx2mHLlIgzIe1edB86hhItavtT
 wKTPQGZ8p2zddqVYmzQ1OW8H/t/Gx+CJIhe3hKAqNuda6H2KJlcQlZoaPHLO0AauHqPC
 RyMuXRGIhvSC7TJ+bN7ZFuT67ExsBICP10ER0/zKprIaP354oZSLL9L/xEWcfxdfxjcs
 1hleYsKQ7ukpuIhVFhc7zBCiE1asQUCdKYzxpnnMzaZA14xvWMuKKvEGy1AL3EIjFsdH
 m6yituaWheLvMS9uxIIqg4VwOQQORqSQ5jZIaXsfUhyHhswcyNjFAxPUtmv/ZRtWKLbj
 VYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790226499; x=1790831299;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iPARFZ8gXnIzohb65RUugnxtnzAKwgIbXl9jKDC/RJI=;
 b=Mv6FobTRPGKsuAzYRa1pLTXhEuxGRxwbZYaE9bFo//RuIeYH6VFRxPE8ZRZYS9E0s8
 Pmx5SBn7YI0pEczRNX35qhPjQgnmOduyadThUrLMfYQiBBerQzuQy6HTTInGpUEocrvR
 P5p6qBS/fXuUXBgPFQDz9q9jVvmYKfuc49OWoe2IWRGs0y3tQr/XSZmFq12qd/ofoRIL
 Y/OczOaK3DMT8xMFgVOKcY0NCJj3li0NQL+oXYIf7ecAZnVeanSPJ/52xTeMJaIDjCk9
 ivv23WLjZAjaFkKyzN3jDdjGqnGfYyJayycs2DpwR2RlY1bZgOZXJ9IWGMn4EaiL10pn
 WHEA==
X-Forwarded-Encrypted: i=1;
 AKwUvByDAg/jFPSpAsJioNvfEBHC3RnnWa9gWLtuyDxKNQ7Wgcglw2VZsUE5KvRMEk+r/UqG1k/oWd8Ln9vZ@nongnu.org
X-Gm-Message-State: AFuF++kcwvyUhjtVT5FKQtodmCud5SfhCSsC+r09s8E0fOkKmxu3PCJJ
 YAk+/36ppIvN6JUcWVnCmfxDJpNh1BreRhppWXGo5LV965gm4tES5u5b9cw0nUa/oYl9WSPLKPG
 sanJfaB3Lrhwf7cBqN+teveMWu2eXshAXHyx8jJqNWt53W1trdF5j/PCJBw==
X-Gm-Gg: AYBFou28ga0z1USnubIkAcDnhHcG9inChGQfi/mcGyOWnRBIGyOxBQHDk8NS+5kBZr0
 Af650mP+QafO8SuImwsVilSRZ4wUFfjsW3eGXHiWL/9K/lagZpLqL5ECooBxkBstTAWIsq3Vrhb
 7J1wEIjBUGr8+6O/0PeRQgm9SZcIllwa4Oz3R3PnIvpYuBrWVx9go9jchAK4NyB2kRIHSMLzJCc
 JP/DJ4DCmrRZUJqVPNRF9K0aaBlGKLUd3bSPVe5TXs2P476uIy3FI04iTvCmJEiMeymAZfjdEcA
 HSAAPjMcQAYbY5TYXIYw7ei5YNJjvjg1wKOiOWgx0sjAYanlByRWUVtQRYrkYbXa4rPYRysz0EY
 v5noZHMZN/S5OW6QCu4Uaae+lGEc4x5Qvbg==
X-Received: by 2002:a05:620a:280d:b0:93b:d7a0:d9e8 with SMTP id
 af79cd13be357-93c363fbc26mr130921485a.66.1790226498693; 
 Wed, 23 Sep 2026 22:08:18 -0700 (PDT)
X-Received: by 2002:a05:620a:280d:b0:93b:d7a0:d9e8 with SMTP id
 af79cd13be357-93c363fbc26mr130918985a.66.1790226498192; 
 Wed, 23 Sep 2026 22:08:18 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4271sm58704855e9.5.2026.09.23.22.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:08:15 -0700 (PDT)
Message-ID: <b4ff3bec-258b-4989-adb6-34a18f5ab8fb@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] target/hexagon: share HVX contexts among CPUs
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
 <20260923171516.3794996-7-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923171516.3794996-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfoodARf c=1 sm=1 tr=0 ts=6ab4b043 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kdOqEb2GBX2ivy2f6Q0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3dc4Nied6Dr0nN7BH0Nsfd6ob1yiCJ8R
X-Proofpoint-GUID: 3dc4Nied6Dr0nN7BH0Nsfd6ob1yiCJ8R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMiBTYWx0ZWRfX1OlXBz25zSRo
 CDa7lDM/i5tVxDBa/bk+fq0CcxO3fCTY2gshwBThJ/MEdlSftcRYiGdROUrlvHa5/Zq5GeOV0b1
 WlQQQ+7HQ5b2E5Fyitgcw3XnhdLiZ+k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMiBTYWx0ZWRfXziRi2FtkF/z4
 4LGyQN4yY3V2fume7A80Wa1ka3rDkChxkjZOic3c/VcGtFGdAjez3FpxBOnTi6IffZUefEAg/9V
 A7sqYg3jUqvNZe4Hmy9LpWz8fAeAB+6JZ/M4fqow+hLpKSw0BS37LxSR0GzQUtvXVLDthESyDoL
 WfsAyPMICJWQLX7i7SslOGJ6DP7I/BwbJG/ZcG3t47GTHteIqKtQucnojUo0IiEVu9BO3pu3BLQ
 0/2tQfwgYNM+G1G55UmGyDZYC29hZn1FxfuAogqLYlHx3KKHXOlydk2FWP7ZjpKSeTUxh7rA5Vu
 QdBWCp/my6e+PV83ZPKhh37bg8lQbRW/h78S5s6eil0JaF53qTC2rEXxQL/89VNgD12OoUTmhgp
 FB9z3rZc4MFK/Y1c0s+p3j/+gpDtPmZPhl8Af2r1dJcehq3jG04bLub9Zv0FKJc29Lttd/4W+Fz
 WrecK4vYG7tdsIW9ZmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240022
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 23/9/26 19:15, Brian Cain wrote:
> The HVX register file belongs to an extension context, not a hardware thread.
> Model each system-emulation context as a QOM device, link the contexts to
> each vCPU, and use SSR:XA to select the active context.
> 
> Keep one embedded context per linux-user CPU.  Carry the selected register-file
> base with HVX operands so translated code can address the selected context
> at run time.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hexagon.h             |  1 +
>   include/hw/hexagon/hexagon_hvx_context.h | 27 ++++++++
>   target/hexagon/cpu.h                     | 24 +++++--
>   target/hexagon/cpu_helper.h              |  1 +
>   target/hexagon/translate.h               |  7 +-
>   hw/hexagon/hex-subsys.c                  | 36 ++++++++++
>   hw/hexagon/hexagon_hvx_context.c         | 84 ++++++++++++++++++++++++
>   target/hexagon/cpu.c                     | 17 +++++
>   target/hexagon/cpu_helper.c              | 82 +++++++++++++++++++++++
>   target/hexagon/machine.c                 | 12 ++++
>   target/hexagon/translate.c               |  9 ++-
>   hw/hexagon/meson.build                   |  1 +
>   12 files changed, 294 insertions(+), 7 deletions(-)

Now much easier to review :)

>   create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>   create mode 100644 hw/hexagon/hexagon_hvx_context.c


> +/*
> + * Create the core's HVX extension contexts.  There are fewer of them than
> + * there are hardware threads, and SSR:XA picks which one a thread uses, so
> + * they belong to the subsystem rather than to any one CPU.
> + */
> +static void hvx_contexts_create(HexagonCommonMachineState *hms,
> +                                const struct hexagon_machine_config *m_cfg)
> +{
> +    unsigned n = m_cfg->cfgtable.ext_contexts;
> +    unsigned i;
> +
> +    if (n > HVX_CONTEXTS_MAX) {

That would be 'if (n >= HVX_CONTEXTS_MAX) {' but since it is a
programming error when creating a machine, simply assert:

        assert(n < HVX_CONTEXTS_MAX);

Can be updated locally before sending the PR, no need to repost.

> +        error_report("machine declares %u HVX contexts, only %u are usable",
> +                     n, HVX_CONTEXTS_MAX);
> +        exit(1);
> +    }
> +    for (i = 0; i < n; i++) {
> +        DeviceState *ctx = qdev_new(TYPE_HEXAGON_HVX_CONTEXT);
> +        g_autofree char *name = g_strdup_printf("hvx-context[%u]", i);
> +
> +        object_property_add_child(OBJECT(hms), name, OBJECT(ctx));
> +        qdev_prop_set_uint32(ctx, "index", i);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ctx), &error_fatal);
> +    }
> +    hms->num_hvx_ctx = n;
> +}
> +
>   static DeviceState *cluster_create(HexagonCommonMachineState *hms)
>   {
>       DeviceState *cluster = qdev_new(TYPE_CPU_CLUSTER);
> @@ -140,6 +169,7 @@ void hex_subsys_create(HexagonCommonMachineState *hms,
>       hms->qtimer = qtimer_create(hms, m_cfg);
>       hms->glob_regs = globalreg_create(hms, m_cfg, rev);
>       hms->tlb = tlb_create(hms, m_cfg);
> +    hvx_contexts_create(hms, m_cfg);
>   }
>   
>   void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
> @@ -151,6 +181,12 @@ void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
>                                &error_fatal);
>       object_property_set_link(OBJECT(cpu), "l2vic", OBJECT(hms->l2vic),
>                                &error_fatal);
> +    for (unsigned i = 0; i < hms->num_hvx_ctx; i++) {

Good style with reduced variable scope, ...

> +        g_autofree char *name = g_strdup_printf("hvx-context[%u]", i);
> +        Object *ctx = object_resolve_path_component(OBJECT(hms), name);
> +
> +        object_property_set_link(OBJECT(cpu), name, ctx, &error_fatal);
> +    }
>   }


> @@ -554,7 +561,17 @@ static void hexagon_cpu_init(Object *obj)
>   {
>   #ifndef CONFIG_USER_ONLY
>       HexagonCPU *cpu = HEXAGON_CPU(obj);
> +    int i;
> +
>       qdev_init_gpio_in(DEVICE(cpu), hexagon_cpu_set_irq, 8);
> +
> +    for (i = 0; i < HVX_CONTEXTS_MAX; i++) {

... but sometimes the style differ, better to keep the same.

(also easy enough to fix locally before PR).

> +        object_property_add_link(obj, "hvx-context[*]",
> +                                 TYPE_HEXAGON_HVX_CONTEXT,
> +                                 (Object **)&cpu->hvx_ctx[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
>   #endif
>   }

