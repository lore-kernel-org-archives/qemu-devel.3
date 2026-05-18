Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD8DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0od-0000Am-Pj; Mon, 18 May 2026 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wP0oc-0000AQ-CE
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:27:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wP0oY-0000DC-Od
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:27:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEnP9Y2975577
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 16:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i5N3x052AF3kgwEQ8CmARh3ftxxtd17dmYqlScgG5Dw=; b=Tg/drkeMsLKUZYzp
 rhPM3sGN5TK8QuZMN7UlbEoMBqFIH7MYa9fzpwLor1FgSFxtMU+Zw7TAgfbpGiAl
 b61He5L3UMqVcz45Q5AMoayD2sc2UmS2RVdDRnxvUtHWFAG75Ok4P5YzHeNjbklb
 JmT4xG5MvJAEwfAJvph9K1DwjqCcguBiMp594zT0/B/JsIa7+/jb47tJW1qWbr6s
 z53opk05f/2bwMt6pKA+yIlLcwBAv+dy7yAkvFZfMpll+DqDEwmvUHKNGB0Ds6Tc
 UVkhrtaPOkgwYYJfU1QMnnJmuQC+S13kzSii8zNytGVgN1bm8VAhJeYRi4nWU/IU
 hf/ZLA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v48cgy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 16:27:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ca1e0f5a4bso76367116d6.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779121651; x=1779726451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5N3x052AF3kgwEQ8CmARh3ftxxtd17dmYqlScgG5Dw=;
 b=TLstAQjhvp9gFHQpKyCWQzWFPL0ieKQr3ove7uIO1qBSAi5U24sPLA94k78iPkRwRR
 9+pAUjlq4MfjXdBR5+jr76nJZLz+C2TCv20ipEbhVwCefpMl5TSO4CMh/yC0lWNgq4ys
 b1vHh+fgNIhYcB4foWCra5EvLaeFWm2gJviLJFdCB0tLFqTO/41ttmEUd1/GImty/xbI
 sEBr+WzusBMLklC0mfCLFBziMn+LORHC9oI9zgbVQsqJW100khbcDxeJMgEJsIuYNU/i
 +e4rMoU/js3Sx+pRTmSbaKgl81qJyAabcOYY/717F2a3C6KvhZlxyJvdFc9JxU+omzT9
 C9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779121651; x=1779726451;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5N3x052AF3kgwEQ8CmARh3ftxxtd17dmYqlScgG5Dw=;
 b=OFVMw2w1j2knJK61uBontncfD155evlbl5kE2Y1CIHeLMcatpv6aEVTkIfYT26wngC
 0VgGpnXzIKeEXPQ5vP55o80VeUV8JXmmO2II9fC9YUU5XfdWdisXWx38J2NmDUDTVLWe
 81qs3tEW58Jh95z0soRuy/5UZEqpd0F2+M/yxFcQ/40I9EbUqH9DdfwPk+SM/d0SjSCR
 Kslanp3a9ZoM4nMaS3pAKZPNKB8aqBhcTp79mtX14QQ08Q0bUiEFRPSGvkr16Vw/CBFd
 D2HvwONMf955VduGvmvVi+Tw+rmhWNi8SM0DTtLFLp97GyX8CuCRBV95wZzNpSYlothu
 zdYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8G3PapaLF5mN9oDYwp2uNxqaZcwxNS4gJnwuuBF6yjolNhLe8wxXli4embpg+3cIdikvYczjF2kIGx@nongnu.org
X-Gm-Message-State: AOJu0YwZHW83JI5SmpFkiqynOwsFBY1iNBKyxi5IjY+3w/LQGLR2nTy0
 uf90FdGVL3apbovvgAruuYvEbs3t4GvU2FrKFF759nbETsFXQGwjoD1Zupg3Wy4fBUD2CvvX8df
 pwesE3va5dYgOn+q/rChz5glj81So2FxskeACT9b6rZfMOFY18YIFobr/jg==
X-Gm-Gg: Acq92OHJui+BI6xculmt+Wgj5u7vVzubla8QZmrPRUvhxI8gZcluUYz9t4LQOMrYa4D
 51CAfXrg0Ss4gBztOXq7/qT4Uk4/XBDRK+pSDrTePIOCIy1SaBOcYYv8m6Gmzachb0a5drpRbU4
 M+WnJeLz/AGwn/tQztOoWFckdqv5cY40DycQE6KnJPmwPNNA0GNr2R6ecta7TtoHlSDAlWlwXem
 7WAe4vkjNaC/J2Z/A2v3tZrEZsKO2HfpxC/DisT0cReLHlYVSpSxjLpNFY1XWvrKLlLtOVa4Jk/
 GwFXK8WyU7Rp9v9pAflzJIU6qRxe5ogT4FRQQpeOog6QZ9z+Ob1GstyIJVPpjIovz5n1U05tCtW
 wfJ+AFcoYzaEbW8MJHUq1L45f1rkWW63Nr4B18GI4R69t/gghSf5pupzjQ/U=
X-Received: by 2002:a0c:d602:0:b0:8ad:d530:34b9 with SMTP id
 6a1803df08f44-8ca0f69c82bmr177772506d6.34.1779121650718; 
 Mon, 18 May 2026 09:27:30 -0700 (PDT)
X-Received: by 2002:a0c:d602:0:b0:8ad:d530:34b9 with SMTP id
 6a1803df08f44-8ca0f69c82bmr177771936d6.34.1779121650067; 
 Mon, 18 May 2026 09:27:30 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca361bcb15sm63412126d6.47.2026.05.18.09.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:27:29 -0700 (PDT)
Message-ID: <b64391a3-f1fd-48e7-9878-2a37d2005be7@oss.qualcomm.com>
Date: Mon, 18 May 2026 13:27:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Convert priv_spec property from string to
 enum
To: khaled saleh <khaled.saleh.req@gmail.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com
Cc: liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0b3df3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=Dn_QJLzWNYQnouRYr5oA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: pvrKjU9MrfZbrGBiCOaBasT_cnP0UGzw
X-Proofpoint-GUID: pvrKjU9MrfZbrGBiCOaBasT_cnP0UGzw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2MiBTYWx0ZWRfX7gtqqAi7Lhgz
 WKC+6ZJdiZJoMNAlboedDWspjkLoBzzpWcFd/RLpe2BA4k5mUQbj8yK1ZBpq5JEy4hzUXu6sga5
 wDZSovWZHIrlifgEGYVtdAaYLircPK+dRa1ezEyik53fyIn7yCslWYrl8myNUOunC72YaRUC/99
 j9ukNWjGkeZq3YWfJgJhNrBmCuMYMJ0w1zA/3HJvVx6x2Is1Jmh8YX+J8uoDy+v1ZELUJpSO8Lb
 I7jlZ5RWKAfLtKSTSk7RFVZjegfhRyNmSk89hgTe98fmKSZGGJ5XjixcyZ48vCAgunOc6cHQyqn
 U62XGeemUdtFls2ohpMu1iA+bZPECWUbmri7PaBZSu66C8A2ZE7WP9GoFkgbb5kUyTvhia5/tqB
 6rcBgOK+a3+9I94ob9hD2eCZDqfNFtQi6Moxkqt2mf3R5NWhIj1kjYnGoDpO7jackMTahy39Ie+
 c2lC+O/IPH5TgAN/D9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180162
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/17/2026 4:28 PM, khaled saleh wrote:
> The priv_spec property accepts a fixed set of values (v1.10.0, v1.11.0, v1.12.0, v1.13.0) but was implemented as a string type with manual string-to-enum conversion in custom getter/setter functions.
> 
> Convert it to use QEnumLookup with visit_type_enum() for:
> - Automatic input validation by the visitor framework
> - QMP introspection support (valid values are discoverable)
> - Reduced boilerplate (priv_spec_from_str/to_str removed)
> 
> This resolves the "FIXME enum?" comment in cpu.c.
> 
> Signed-off-by: khaled saleh <khaled.saleh.req@gmail.com>
> ---

We usually send patches rebased on top of this tree:

https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Using that tree this patch yields a trivial conflict in cpu.h.
If you can re-send it based on the tree above that would be great.


Patch LGTM otherwise. Thanks,
Daniel


>   target/riscv/cpu.c         | 59 +++++++++++---------------------------
>   target/riscv/cpu.h         |  1 +
>   target/riscv/tcg/tcg-cpu.c |  3 +-
>   3 files changed, 20 insertions(+), 43 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 506a018d52..8365471572 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -26,6 +26,7 @@
>   #include "internals.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> +#include "qapi/util.h"
>   #include "qemu/error-report.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/qdev-prop-internal.h"
> @@ -1655,51 +1656,25 @@ static const PropertyInfo prop_pmp_granularity = {
>       .set = prop_pmp_granularity_set,
>   };
>   
> -static int priv_spec_from_str(const char *priv_spec_str)
> -{
> -    int priv_version = -1;
> -
> -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> -        priv_version = PRIV_VERSION_1_13_0;
> -    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> -        priv_version = PRIV_VERSION_1_12_0;
> -    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
> -        priv_version = PRIV_VERSION_1_11_0;
> -    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_10_0_STR)) {
> -        priv_version = PRIV_VERSION_1_10_0;
> -    }
> -
> -    return priv_version;
> -}
> +static const char *const priv_spec_str[] = {
> +    [PRIV_VERSION_1_10_0] = PRIV_VER_1_10_0_STR,
> +    [PRIV_VERSION_1_11_0] = PRIV_VER_1_11_0_STR,
> +    [PRIV_VERSION_1_12_0] = PRIV_VER_1_12_0_STR,
> +    [PRIV_VERSION_1_13_0] = PRIV_VER_1_13_0_STR,
> +};
>   
> -const char *priv_spec_to_str(int priv_version)
> -{
> -    switch (priv_version) {
> -    case PRIV_VERSION_1_10_0:
> -        return PRIV_VER_1_10_0_STR;
> -    case PRIV_VERSION_1_11_0:
> -        return PRIV_VER_1_11_0_STR;
> -    case PRIV_VERSION_1_12_0:
> -        return PRIV_VER_1_12_0_STR;
> -    case PRIV_VERSION_1_13_0:
> -        return PRIV_VER_1_13_0_STR;
> -    default:
> -        return NULL;
> -    }
> -}
> +const QEnumLookup priv_spec_lookup = {
> +    .array = priv_spec_str,
> +    .size = ARRAY_SIZE(priv_spec_str),
> +};
>   
>   static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
>                                  void *opaque, Error **errp)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> -    g_autofree char *value = NULL;
> -    int priv_version = -1;
> -
> -    visit_type_str(v, name, &value, errp);
> +    int priv_version;
>   
> -    priv_version = priv_spec_from_str(value);
> -    if (priv_version < 0) {
> -        error_setg(errp, "Unsupported privilege spec version '%s'", value);
> +    if (!visit_type_enum(v, name, &priv_version, &priv_spec_lookup, errp)) {
>           return;
>       }
>   
> @@ -1718,15 +1693,15 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
>                                  void *opaque, Error **errp)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> -    const char *value = priv_spec_to_str(cpu->env.priv_ver);
> +    int value = cpu->env.priv_ver;
>   
> -    visit_type_str(v, name, (char **)&value, errp);
> +    visit_type_enum(v, name, &value, &priv_spec_lookup, errp);
>   }
>   
>   static const PropertyInfo prop_priv_spec = {
> -    .type = "str",
> +    .type = "RISCVPrivSpec",
>       .description = "priv_spec",
> -    /* FIXME enum? */
> +    .enum_table = &priv_spec_lookup,
>       .get = prop_priv_spec_get,
>       .set = prop_priv_spec_set,
>   };
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fae839cade..522b63016f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -70,6 +70,7 @@ typedef struct CPUArchState CPURISCVState;
>   #define RVG RV('G')
>   #define RVB RV('B')
>   
> +extern const QEnumLookup priv_spec_lookup;
>   extern const uint32_t misa_bits[];
>   const char *riscv_get_misa_ext_name(uint32_t bit);
>   const char *riscv_get_misa_ext_description(uint32_t bit);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 02c98cc2db..2ec4b8e98e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -27,6 +27,7 @@
>   #include "time_helper.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> +#include "qapi/util.h"
>   #include "qemu/accel.h"
>   #include "qemu/error-report.h"
>   #include "qemu/log.h"
> @@ -86,7 +87,7 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
>   
>   static const char *cpu_priv_ver_to_str(int priv_ver)
>   {
> -    const char *priv_spec_str = priv_spec_to_str(priv_ver);
> +    const char *priv_spec_str = qapi_enum_lookup(&priv_spec_lookup, priv_ver);
>   
>       g_assert(priv_spec_str);
>   


