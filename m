Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32276CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 18:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL3KO-0003Vk-1t; Thu, 07 May 2026 14:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wL3KM-0003VQ-8F
 for qemu-devel@nongnu.org; Thu, 07 May 2026 14:20:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wL3KJ-00019o-VW
 for qemu-devel@nongnu.org; Thu, 07 May 2026 14:20:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647HgULn1971787
 for <qemu-devel@nongnu.org>; Thu, 7 May 2026 18:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xr2KcKkWZlTd7WHCaL9ADZQI6lUdTmWQ0hh6nU0GTiE=; b=bsqsUTtk3I3PPrGH
 9te1dcUiyksbGRWdPpyf9iJCLvgVMkZCCo2lWm77+hTyUprQ+dJWaYUuE/R8ri+D
 OpPoVxhIzmqWJ1Y6aQIYZMDtdrJdKZ0Us0+rJuqExEZkkqBcEWoHcVBuoJtlMliZ
 Ug/bswnbgDaCdamGz28X94bWPSUbuLzo++s0Ryw645T2+EcIPgiLx5bUyxrkOcqR
 a1nM9tLSxbx1InMSbORuPvaAzzmojMfXpO54lNDWszMoJ6kHdd1qcY009CpM//Ms
 nFnwaV7fn5XJXfPH4TFBoYhb1V53F2Xzz+iQdCVj+5NiYPvrNqmOwi7gZmn9JbJq
 beu2sA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej9k2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 18:19:57 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dc1c0b7ccso2238232c88.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778177997; x=1778782797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xr2KcKkWZlTd7WHCaL9ADZQI6lUdTmWQ0hh6nU0GTiE=;
 b=TLxrp1lmqo1hvQk7nPXuCuhSsd+wYexiR0+rrCp2fY3Cv99CxQWHNI9yE4EuF7xEeQ
 ydqGTdf8d3/hIWI6zlF1e+hOGjT8R39v1sBox6haGPsofJDAbnGOI1sTScp+GTw+pDJB
 f8WZ154SRFzhiibbHIRNbXTBnhEh0lgh6eAm1v6CFzo0SEuLTCAM8XB/d22T60cSP/Ce
 NdqA5JDF3DqumlkQdCFk4fb6lBezJVhO1knDjZmX4i0e5w2uL7lbfg+0WWYzKFa0u0rV
 OlsevJ5th6V9r5uSvWAxQwTHEe/liop15rliDESEnl+wND39Uy+TlG7vqanVjoT3KD9L
 sZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778177997; x=1778782797;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xr2KcKkWZlTd7WHCaL9ADZQI6lUdTmWQ0hh6nU0GTiE=;
 b=NecyQnnLy4JlTRhp9e5HpI+8fM+d5oigf5WesHOgRALeyvQpWJraAzEV1fEilUaPEz
 VtZl2YvD0hocj18aOasj8vWpjE/vom3Dm+9VZh4mQFwZdbjzb3utYjR45Y6e6pHvdpO/
 9LooqN0E5J4UvNhA9PSTlFTifoKLOjso6rtrxORv6DKlA2elSJIg0MeB0H7UMtpqidMT
 Y7uQNa/0p54jXmAZtLjAoScDn+Y6WT5jGCqLfX9fuUkwdTzfjKPDdTJFyr485Ua5Vu5S
 EVJpIJ3z/TTKSeH9bXbG3WoFKqiYTgEdHVQYWYP1N2jf6JmTv4WspyzRqYfnHJYO/gH1
 ScGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5OS9RfrIS2wwuR3yTwcLN4qH14fAQh9iCl0/XqHn0oxij10Uw4XWGdWK7Cqs+4YWyUvaEcT4Y6bjI@nongnu.org
X-Gm-Message-State: AOJu0YwxmQfBFeeZUYR4X6wgqr7oc2DhMmYT8GiaOdjLN6HhbbWrtPSk
 fz9MBNfqdIediuR3IczHL9XnXoM3ZWFZ3IOL7nArAJEMlp43dKcrCkaKuxc7YfV9kranK2xaqi/
 4XHsPUilse8KzxDJ5ERCuSCdavKrFws+XrMoei9o6T5CHcIXqTzieXBA/I/jVe2XS8g==
X-Gm-Gg: AeBDietev+ftY+eaz+W6d1da0bnrX/ELQELEjw/GNNS4Ay0kSeIZk3RrEPPgfNkS8Lg
 giidIoxdKW8AL5youQT3KH2J13UmITl2yCo5mJtNsqk9TUh89hPdVQQd6IpWlklr/Oda517J5Vx
 S1+txr1pvJHN/PjYYX3ocYxkGG4MTHMwwqltkIDk6qrNw16qLgRbu1plZST0lK2eFCdzmD2ZnTx
 z6UAPc/hlFo/GMMJcZgOFXXl9c9ozXxfa4VWAY7w85ILw0rM5qjaaT/GHUWPP7QeoBKIh9tKMe3
 T+OGQXKbPiplKNaJpQHTyJLfqO9UV5t4PisFbkRSl2bwlb5YdDKA6QzfPBIdVvxiyV8jYmct726
 8Z/z2GvN1F+fkrxtV5GV+a3CibqVwBb13EZZxdeDGXC59mM9ltzqkHy33jKancQpo2XAMc+Ky4v
 iRtUe63Zt76+TGpLWQ79M7zgsg
X-Received: by 2002:a05:7022:f212:b0:132:d1d:ef5a with SMTP id
 a92af1059eb24-1323afaafb4mr1689191c88.12.1778177996730; 
 Thu, 07 May 2026 11:19:56 -0700 (PDT)
X-Received: by 2002:a05:7022:f212:b0:132:d1d:ef5a with SMTP id
 a92af1059eb24-1323afaafb4mr1689172c88.12.1778177996147; 
 Thu, 07 May 2026 11:19:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1326bda2277sm138240c88.3.2026.05.07.11.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 11:19:55 -0700 (PDT)
Message-ID: <bb8a14ef-497a-4fc8-bc66-fadc003d934b@oss.qualcomm.com>
Date: Thu, 7 May 2026 11:19:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Extract IDAU interface to its own unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260507134709.70507-1-philmd@linaro.org>
 <20260507134709.70507-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507134709.70507-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE4NCBTYWx0ZWRfXzxXgKeYljnbE
 KkjPA7TkMqKvrUeDzjDXl6gfcMlPs6JbWwFglGOpQhuqCtPyoTOoCWX8HsMTyO2glIBeiEnHBlj
 2c/F7mXhRnGE/+v5mQHzS5q/YGNmrhcTALBRPtBxrJfgVEvYqiY5n4FT99EieRRBZUfw0eJBnVg
 JZu/9QZgXc3lqRbXBMna2qxn2H8UHDdJD4dsGtDW/am28Nvvq3j4qhB7JLNTTSV6n4K4+C1UDBx
 T/6TS0g9MXa63YXGjYkwkmpPUn9GFyed1ijfuq2tlehQrFi62sBOnHCngjbzyTsmseFJbiCywTh
 lJ+QbsQ5j85BZqG5b9EXf46K2l1lzTe9uoGULzUNHvDn+TEc0tSyLCD8I1a/Hq/i+DHifFZRMj/
 fiIhLEl6e7dxaOdUhW+vzWFgPWCNtyI964PxPuVk68tvUPjqoR0/G5FgHLHy1CyfI3Pr9BGC3NU
 fyAYMSZ5mr9Wv/Jeh8A==
X-Proofpoint-GUID: 3LOgLJyaCKaz4VdrTZ7Qp0_TNsV7MCWZ
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fcd7cd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Nx9mqvFFq6QXWYkHBMUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3LOgLJyaCKaz4VdrTZ7Qp0_TNsV7MCWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070184
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/7/2026 6:47 AM, Philippe Mathieu-Daudé wrote:
> Move IDAU TypeInfo structure to its own source file and
> build it once as common ARM object.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/arm/armv7m.h     |  2 +-
>  include/hw/misc/tz-msc.h    |  2 +-
>  target/arm/{ => tcg}/idau.h |  0
>  hw/arm/armv7m.c             |  2 +-
>  target/arm/cpu.c            |  2 +-
>  target/arm/ptw.c            |  2 +-
>  target/arm/tcg/cpu32.c      |  8 --------
>  target/arm/tcg/idau.c       | 20 ++++++++++++++++++++
>  target/arm/tcg/meson.build  |  1 +
>  9 files changed, 26 insertions(+), 13 deletions(-)
>  rename target/arm/{ => tcg}/idau.h (100%)
>  create mode 100644 target/arm/tcg/idau.c
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
> similarity index 100%
> rename from target/arm/idau.h
> rename to target/arm/tcg/idau.h
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
> index d670ffe4de0..7b29532e6ee 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -24,7 +24,7 @@
>  #include "qemu/log.h"
>  #include "exec/page-vary.h"
>  #include "system/whpx.h"
> -#include "target/arm/idau.h"
> +#include "target/arm/tcg/idau.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 316e201cfe0..ff7b7a4d0c8 100644
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
>

The idau.h -> tcg/idau.h change is fine.
      /*
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
> diff --git a/target/arm/tcg/idau.c b/target/arm/tcg/idau.c
> new file mode 100644
> index 00000000000..57e5c658e9d
> --- /dev/null
> +++ b/target/arm/tcg/idau.c
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU ARM CPU -- interface for the Arm v8M IDAU
> + *
> + * Copyright (c) 2018 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "target/arm/tcg/idau.h"
> +
> +static const TypeInfo idau_types[] = {
> +    {
> +        .name       = TYPE_IDAU_INTERFACE,
> +        .parent     = TYPE_INTERFACE,
> +        .class_size = sizeof(IDAUInterfaceClass),
> +    }
> +};
> +
> +DEFINE_TYPES(idau_types)
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index d2364aa39c4..fa1e3d6640c 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -56,6 +56,7 @@ arm_common_ss.add(zlib)
>  arm_common_ss.add(files(
>    'arith_helper.c',
>    'crypto_helper.c',
> +  'idau.c',
>  ))
>  
>  arm_common_system_ss.add(

Why not, but what does it solves?
The common aspect is not so important since tcg/cpu32.c will be common
pretty soon.

Not blocking though, I'm just curious of the reason to extract this:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

