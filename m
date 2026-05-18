Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA585CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvLQ-0000vu-IM; Mon, 18 May 2026 06:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOvLE-0000ub-UM
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:36:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOvLB-0003Jw-L3
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:36:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I6cMEj145990
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aar5qN79qgthTV4OdX1SaJJCC4QwW4ZbvWFUAJ1cEIE=; b=XoxiLXogZ43dzIBY
 SXX+KX08NllGZB/oaTgeNzfnf7ph3bYT9XXJuiuRCZA8VEKPSl2WHbFdyCKCwXAn
 eKw6rR3HMydWF3pRQAwkpGY0dqwR2yCdpvbXNALyp/3hJz2+07EezHs05Fdt0LFu
 IMBL6Ha2ORMxq5BnpHookEUgxfR0eSe7tKXC7u8ZMoJKcc0OMKZpwCWPdpmK3BWX
 Ch/IG5ghiyVPTckB9rQNzP5xOHEGpSsYnzwZJNFimgDrXXgI+xqqZ5DuscyLEZI5
 SosUEjvX+0LaJiOOLo/Fn8fD3N2AL2zf4xOOz410/iBAPWcfnCQeRdAqAJ5SxPtI
 //LlFQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gx6x15n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:36:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9112b2755abso568962385a.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779100609; x=1779705409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aar5qN79qgthTV4OdX1SaJJCC4QwW4ZbvWFUAJ1cEIE=;
 b=R/DsDBva8jcQVefOCSWPmjUcmR/YmTTHGi3/FpFMFaZrGQLRiRWa5dxcMIr+iqBLbL
 dhzSQWWHOd861uNlh+kOk+y7TzbUxreuwny0sZa0F6ucwPxNB+ZrhtSZS/x4nHN/NgPP
 YWQ8xWdjWBu3lM+7RfU3IVB7zWZWzXwjXGfoj2EZB8fH4XV1mk/wbmlzD8+CAAc3i4SH
 4Dn+v6qRkLD1S/c/TdsOIbNJdATiCm/eIUHkGW+wo72mEzVYr3dlJ8hnx4Op3cAbHBbZ
 EAZF5ZsueG+x3s+etALHO0GRqapAu6a1ngKmB5pwWK5+zGr/Ya5QLs3LsjVlL6CBYRqM
 uBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779100609; x=1779705409;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aar5qN79qgthTV4OdX1SaJJCC4QwW4ZbvWFUAJ1cEIE=;
 b=dF6L11qSb7oPBBjRdXmLoAgchOKt0gzblzwNNc6eqfGg8luRJn+8NRacm4ayrX60e4
 eQTC9iCfVKW1h8fHuqcTXwEO8x/CsETOfSu5x3nlNukkYYwbGgKKaLItsyncjW4udeMT
 Lo2cHuTtc5cKn63QV+7bn/H2khSij0c76eB0ipTGGGftNZsK/ly/dKqFQaoO3s3NJaN7
 JnGsvJHr1ZLbEGP/Bdo+7a8c7u1BQDjdaClHioZcf22KPdtOvF0xPJueAdnpL2PDtaxp
 ygywSSYoCYPXdkm60PiaWnOgM3Qt/NmsgtC39YQjxmyk+bF0pHkc7WQzUCtKDn/UZ7nY
 iwAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/27ApH3d+z+bgHfzO5/sFVVzwrE1XZba8Gs/IBFD6KcLmM0PSxZtgccpsiBrtlNVkWpthI5GDtEyZn@nongnu.org
X-Gm-Message-State: AOJu0YxvVQimCCmo8D6yiUgJoXVPIyjjykcZcypRVdFVwY4vtO/+x2I+
 UeZN9N8OSzLhQzW8ScP0pcOZUEArcFfwjKQGXw1hGKTRDyCC+PFkSqZ3Mww1jmSoBZQovoPd7Cw
 Q/WYKXvYd845bsTV1i/X+Z0cGK5W78wqjMZ2L2drhf/INX84JPtcebKCeWA==
X-Gm-Gg: Acq92OEfbl26Xtdx09MF7MXWNMkXmh0+SBa/fGv6SEyFNMID1hKjeiLMSBzrBxlwoWj
 5rdupaIaKb+7vStzz3HcMiBpCIJ/LxZv2XwzFcD4fttwBCqQpfVLjFe4if8lHOKP9zfdMmtfg3N
 xQpZTZPquR+X7k16C20uHjJoMjv7HVldzfN9s+uVdCIDVED7IQzaK68ms8yl9fqs9GYyok1nbix
 uKfPaI9XPNUJyEMw8gQYfvzyFPk85T5bIGZEjKbTl8rGOYb0kz6TWtEKwoPVzALUb7PKM/Q6R/H
 R0RduQ398tkBnU6n6ALVt4aLMI/ycELrOSzi0FLOeZBoq82HNCUqHeG/GRmN88r5b2BWjhg4UQn
 dY4NRQb+KPRpap4kYK5j5u/lHQ1AbdJjRkpPFM4ZMTBQcCHeaI+Pe1qqiSHI=
X-Received: by 2002:a05:620a:2915:b0:913:e5bb:3dc9 with SMTP id
 af79cd13be357-913e5bb547fmr687762185a.57.1779100608612; 
 Mon, 18 May 2026 03:36:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:913:e5bb:3dc9 with SMTP id
 af79cd13be357-913e5bb547fmr687758185a.57.1779100608016; 
 Mon, 18 May 2026 03:36:48 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba36d137sm1434282885a.1.2026.05.18.03.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 03:36:47 -0700 (PDT)
Message-ID: <4f53cc45-ba10-4a94-a2b5-45b5d0259727@oss.qualcomm.com>
Date: Mon, 18 May 2026 07:36:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Convert priv_spec property from string to
 enum
To: khaled saleh <khaled.saleh.req@gmail.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com
Cc: liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>
References: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Fuc83YjNPWfABSF73IgRRqawjuUHpOCx
X-Authority-Analysis: v=2.4 cv=f614wuyM c=1 sm=1 tr=0 ts=6a0aebc1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=F15vZjVpeT7eTLCjKfUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Fuc83YjNPWfABSF73IgRRqawjuUHpOCx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEwMiBTYWx0ZWRfX2Ui7OhJ55j/j
 cwNuq4eAHcXhGXwZsb5WQIs9IZRcgNCvxMl3xJeFi1DYCaWM02iogOP8JrS4vAKRgKmipjxff3O
 H+UtSEUy7haSdYG3mzvyaWq+UvXlYZAU5nXqayY61x5eUTY2gMeXOo5nYLk12hEJBE6I3D5BhM2
 iWeFMcjGzC2YdW6QWhwA4PdTvdM0EdWb+7UxuwdA+cbgKKJqjh0d5nFWLx5/tuHxiQtXoPaamVr
 t/Od4+0qqzvIcLBDgUnkNJnbK/oTHzw9dx//xLT5URTnyGDIIW4qgw6yq1otBlNmmkZy6tJ6bHO
 X+EmYMBCK8cYFUmgeCWg7xu6Hp/c6iZDUxE+iHCqeq9bGrGBjgxHfvrtXhKr/lF+hJ0jYsCIgTl
 0cXk4bKwebn99rb2Mqu0dBA2ZFuv6dZgYhkNJuCSDIwTrS9ZjnZQIEfsEjIW/8wyjcctqIfgEhP
 7Wu60h+r8HDmqBQZAhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180102
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

Ccing Drew Jones

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

This would be an improvement from what we have but I'm not sure if 'enum'
is what we want either.  We tend to go towards on/off flags that are more
QMP friendly.  So instead of enum property called 'priv_spec' we would have
booleans like "priv_ver_1_11 = on/off" and etc.

And I believe we can't just get rid of the existing string properties all of
a sudden too.  The string option would need to go through a deprecation
cycle first, and I'm not even sure if we can re-use the same property name
with 'enum' instead of string (my guess is we can't).  So it seems to me that
the 'priv_ver' property is basically doomed to be a string type until it goes
away.


Thanks,
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


