Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA6FCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw0r-0001Ge-Cz; Fri, 15 May 2026 13:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw0p-0001F8-4T
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:07:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw0n-0001O4-D0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:07:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBjGGC3514759
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ppy4XNBJmlehcTqEN00OoWyv1R1L7Rt8ELpsOAqCvbQ=; b=A1DbuHoFMdLUQs8s
 GCazTM17zQKsgSUWm4UXtwceB4lNIIPFQw5n8VzTJdv3huPmN0YcvQTMS8S5LoJz
 T8RtLkytXPqT2HnYFZ4JDC//eWgNXzqrQy3XiX6nNtGFajuFRJOx754ML+i6Qeuj
 wyQ4HFiYRwVqwboqQLBS5CAmPlqRCU8tIzCpaO1iUv+8sOH80X8GV9D+B45XKJ3h
 5TTzydAup/NRvTiYBErNiVze3Pl1v8XbmDt0XScZfKekF9MKYOlyWtnLkJjKPXxm
 HpCxB32MBWLGq3dt4PI9J+9ZIG032yeFWfus/FiEjB7OLuZq6zzakOqPDeg7NMi3
 JgVe5w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vc5w5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:07:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso46487eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864863; x=1779469663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ppy4XNBJmlehcTqEN00OoWyv1R1L7Rt8ELpsOAqCvbQ=;
 b=jW46S6ei35cru53FYzWmD8iU65DE1T5ucbi8ZY31lUJY/YKO4Db8Dj7G45XV2XlGvU
 /ow/mtkr1aYXBu7iwn758LRqea12dWf6eg23TSLsSMnw6HN6lgMsPEgH4R4RjtRQuNlF
 0RxVJMCqqud1+Fr4VkA4dLJBrjVLO4ZeiIi473LbX/Sty4U8bjhadjFlgcNwKeAoQ4RC
 L5KlAjUtQMMKNEqPKbwub/jolWMrszrsIMJrYpvaON66pKHjsQ+jd2M15xCfkKZMpbJJ
 t0pE0j/z69pZfmC4LeJegr1tX4e2t2RhHd7GiXOdbS+v995sfGilcahr2DwD+qDGlvi/
 sLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864863; x=1779469663;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppy4XNBJmlehcTqEN00OoWyv1R1L7Rt8ELpsOAqCvbQ=;
 b=lromSriEXadCaxv/aXOdPMI1Xq0zyXCZBfiB7/So+JQVlerOK8pwvCALogjBUIFgLo
 zH0KqfbC6/1rSBgJTIIDtZZzRGfFh1UMj0MD48PPaTM2KCFmm6fzHc8FS30q5xBW4s2C
 eHCbAJlmnDG3gGBDht53AoZrh9I3xa9c5oBvKkOPtiHo30i//2l6yi8dqx4PXjzLbtoy
 AKcJM4NscJQkLTuP5P9IEdfJSWYDMzpnAxLfPP4rh1UlWc3CW29sMiF4lwrGjnY+qZ4o
 RO2ma1fhExc+4pLdikw4CIi/2v5oGPeq2tPqhUFRI15zZf2EhGWjMQcGwNs95Fn/HCU+
 xdvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WSHOEdoHsAgw7PUIRWV+GP/T7frXpS80PPe6AdOXEOSmK5OcQrXUOZMNOSIWtPzYf2dekCd0uNN07@nongnu.org
X-Gm-Message-State: AOJu0YyiJjScwH98fZ0+uf1m81KmR+LHmGqkQlkU57W/3OX0OEX0TW5Z
 DV5P2kyfN6LWlN4A8dyBF6B+ZZa9O8gFJd8R4qk71OB91YW7XaWepyuK6ONNQ2YCfkho0bQSe8X
 ZnL/CwKoo9HNQ+DOk0+Tc1GmRDDi0clHgbtSF+9zUskBQhXEhiPa24LmAyw==
X-Gm-Gg: Acq92OHOlGDr2zf4HdMatAaCA375bxGCJYem+95BkZT+X8XU6UR+nzNN7Lgnmg3gmgA
 bAWq4bBnBQ+HQAp15OmJ7nCtvtpOjMypbRuTmwOFX1i3jg8CeUhRA62g1qxXrQ4eDWhrKfack1q
 BZqXeuDtB0sHSZCvi4wMRilkWQkXrNVX3QT9vst3SZH0Kl+scRxVGjlyA0hPavXKnS9PsuX2qgk
 LLxn2ECFcithdionNgv8HnbeTz84vpgeawXHQ0FRADx8b1EuYs3OWTGaAsvCtFR2kBdt5EQI2Di
 lxxXYpacrOiR0ErHpnFpHrqaPs8ckGbnsTt8oSwqYmmrS4MGvmrB3pRKkCs9oQmGu8g55wIOqCX
 k3quxPZqWuoyt5Z0YyiAHJ2/o+bwoK31h9hbBCZGEGTRABbcMJ6HU5vDnimddktYrGcjnBo5peK
 UmppMmiN0JXrPTzg==
X-Received: by 2002:a05:7301:1693:b0:2dd:8ac2:9f7a with SMTP id
 5a478bee46e88-3039816a0a8mr2378951eec.11.1778864863100; 
 Fri, 15 May 2026 10:07:43 -0700 (PDT)
X-Received: by 2002:a05:7301:1693:b0:2dd:8ac2:9f7a with SMTP id
 5a478bee46e88-3039816a0a8mr2378916eec.11.1778864862446; 
 Fri, 15 May 2026 10:07:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6c3sm9065660eec.19.2026.05.15.10.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:07:42 -0700 (PDT)
Message-ID: <622880be-3420-4451-b628-fd4a29f4dd81@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:07:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/20] target/arm: Restrict IDAU interface to TCG
 namespace
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfX5skpsoslwndf
 ku44hO+EAMw/3yQbOjrG2lv3tLXs4HTRzRE/BQS+/w807L0GU7SiZiAj4c9w2ImFq+ASY6pKK9j
 Ywj+klicQqbxY1RNzmX5LoMH0gCp/LX8JCtRuzJK1w+2h90ExNsY86EMVZHOim7bEyx/wmupsCd
 15DqaijaXHHcLSLbzxV9O3g40+8OVKx8WAnM1QcRW6IEJ7uYjDtc4B2j7nnVURFJgfDzi8vumUU
 QfqC965QsOGqWYvLA5YGndaCciJlDcwbo7swze4rb5r+MKkKZuqQnq3B0YdTyMmUiFB8FM4a79A
 LgAdSYYeL+ABFInrXcV7vcP3lte0JTAmhrnq5xSP7+RPEr70O11SZvTbltaVEDaz2JE2n1EQJxe
 WRuFM+trr41kD5nDv4pfToxHUbrFzpTCTTeN2KKJO/BPQpFZ4OVh7oYgsVzruY3VgVSjFxnToU6
 RiqlHrpowhCv/w8EP1g==
X-Proofpoint-GUID: WrxwJlyBeHnCXWs48oNhYfHO9v4kFZ6g
X-Proofpoint-ORIG-GUID: WrxwJlyBeHnCXWs48oNhYfHO9v4kFZ6g
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a0752e0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=npYeWHLxjx11dXknAyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Emphasis the IDAU interface is restricted to TCG by
> moving the header under target/arm/tcg/. Move the
> definition to cpu-v7m.c which also contains v7/v8
> hardware (NVIC), keeping only CPU types in cpu32.c.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/arm/armv7m.h     |  2 +-
>  include/hw/misc/tz-msc.h    |  2 +-
>  target/arm/{ => tcg}/idau.h |  4 ++--
>  hw/arm/armv7m.c             |  2 +-
>  target/arm/cpu.c            |  2 +-
>  target/arm/ptw.c            |  2 +-
>  target/arm/tcg/cpu-v7m.c    | 11 +++++++++++
>  target/arm/tcg/cpu32.c      |  8 --------
>  8 files changed, 18 insertions(+), 15 deletions(-)
>  rename target/arm/{ => tcg}/idau.h (97%)
> 
> diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
> index 98ad08db036..70555962bb9 100644
> --- a/include/hw/arm/armv7m.h
> +++ b/include/hw/arm/armv7m.h
> @@ -13,7 +13,7 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/intc/armv7m_nvic.h"
>  #include "hw/misc/armv7m_ras.h"
> -#include "target/arm/idau.h"
> +#include "target/arm/tcg/idau.h"
>  #include "qom/object.h"
>  #include "hw/core/clock.h"
>  
> diff --git a/include/hw/misc/tz-msc.h b/include/hw/misc/tz-msc.h
> index 07112d8caa3..6cf4c6b09eb 100644
> --- a/include/hw/misc/tz-msc.h
> +++ b/include/hw/misc/tz-msc.h
> @@ -51,7 +51,7 @@
>  #define TZ_MSC_H
>  
>  #include "hw/core/sysbus.h"
> -#include "target/arm/idau.h"
> +#include "target/arm/tcg/idau.h"
>  #include "qom/object.h"
>  
>  #define TYPE_TZ_MSC "tz-msc"
> diff --git a/target/arm/idau.h b/target/arm/tcg/idau.h
> similarity index 97%
> rename from target/arm/idau.h
> rename to target/arm/tcg/idau.h
> index 0ef5251971d..e5736ad848d 100644
> --- a/target/arm/idau.h
> +++ b/target/arm/tcg/idau.h
> @@ -25,8 +25,8 @@
>   * connected to the CPU using a link property.
>   */
>  
> -#ifndef TARGET_ARM_IDAU_H
> -#define TARGET_ARM_IDAU_H
> +#ifndef TARGET_ARM_TCG_IDAU_H
> +#define TARGET_ARM_TCG_IDAU_H
>  
>  #include "qom/object.h"
>  
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index a29eab6c915..68a1cbd6316 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -20,7 +20,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/log.h"
> -#include "target/arm/idau.h"
> +#include "target/arm/tcg/idau.h"
>  #include "target/arm/cpu.h"
>  #include "target/arm/cpu-features.h"
>  #include "target/arm/cpu-qom.h"
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 31e0a12a986..76f5909e902 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -24,7 +24,6 @@
>  #include "qemu/log.h"
>  #include "exec/page-vary.h"
>  #include "system/whpx.h"
> -#include "target/arm/idau.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> @@ -42,6 +41,7 @@
>  #include "hw/intc/arm_gicv5_stream.h"
>  #ifdef CONFIG_TCG
>  #include "hw/intc/armv7m_nvic.h"
> +#include "target/arm/tcg/idau.h"
>  #endif /* CONFIG_TCG */
>  #endif /* !CONFIG_USER_ONLY */
>  #include "system/tcg.h"
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8706dd59dd6..a4842a4b62b 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -17,7 +17,7 @@
>  #include "cpu.h"
>  #include "internals.h"
>  #include "cpu-features.h"
> -#include "idau.h"
> +#include "target/arm/tcg/idau.h"
>  
>  typedef struct S1Translate {
>      /*
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index dc249ce1f14..02abd831e6a 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -11,6 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "accel/tcg/cpu-ops.h"
> +#include "target/arm/tcg/idau.h"
>  #include "internals.h"
>  
>  #if !defined(CONFIG_USER_ONLY)
> @@ -40,6 +41,16 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>      return ret;
>  }
>  
> +static const TypeInfo arm_v8m_types[] = {
> +    {
> +        .name = TYPE_IDAU_INTERFACE,
> +        .parent = TYPE_INTERFACE,
> +        .class_size = sizeof(IDAUInterfaceClass),
> +    }
> +};
> +
> +DEFINE_TYPES(arm_v8m_types)
> +
>  #endif /* !CONFIG_USER_ONLY */
>  
>  static void cortex_m0_initfn(Object *obj)
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 2127d456ad6..73d21c6cf7d 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -12,7 +12,6 @@
>  #include "cpu.h"
>  #include "accel/tcg/cpu-ops.h"
>  #include "internals.h"
> -#include "target/arm/idau.h"
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/core/boards.h"
>  #endif
> @@ -899,17 +898,10 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
>  #endif
>  };
>  
> -static const TypeInfo idau_interface_type_info = {
> -    .name = TYPE_IDAU_INTERFACE,
> -    .parent = TYPE_INTERFACE,
> -    .class_size = sizeof(IDAUInterfaceClass),
> -};
> -
>  static void arm_tcg_cpu_register_types(void)
>  {
>      size_t i;
>  
> -    type_register_static(&idau_interface_type_info);
>      for (i = 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
>          arm_cpu_register(&arm_tcg_cpus[i]);
>      }

That's the patch causing an issue for kvm/xen only build on aarch64 hosts.

../target/arm/cpu.c: In function ‘arm_cpu_post_init’:
../target/arm/cpu.c:1620:47: error: ‘TYPE_IDAU_INTERFACE’ undeclared
(first use in this function); did you mean ‘TYPE_INTERFACE’?
 1620 |         object_property_add_link(obj, "idau",
TYPE_IDAU_INTERFACE, &cpu->idau,
      |                                               ^~~~~~~~~~~~~~~~~~~
      |                                               TYPE_INTERFACE
../target/arm/cpu.c:1620:47: note: each undeclared identifier is
reported only once for each function it appears in

