Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9267C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16Oc-0003wq-P1; Mon, 31 Aug 2026 14:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16OY-0003wI-6I
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:06:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16OU-0002zI-PN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:06:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFrS5N3891249
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SUr4coHG6SHatQQ+icyGqqHTZ+Kw/yIQBZoRbeqyCoA=; b=D8l60UyaUO0+jYyh
 qzu091WtXCPXy93ZZ0WE1jPcAbfjxlk8An0UK+XeBFzXqPJN9UsVCvTaFpqSzMxq
 BvZsSmOhCTt1XKVy6oC98D09juzesc27U6iM9Bj85+SZVpH06EC6Wz3Q5ZRuTGPV
 jQT300R+q6UXF3OrqC0ZWJWRkPUS5I16tD/YpQRFiuQ+bl9MOQxcm67aO9HlP9E+
 1UdhaD63wiyT6EhWyC8Qm06V4senA3PDwrln1PPhZ55g7U+KURoh89rGJUh4YTwR
 I44wONLShmpPb7+O3UxQep8wByfiIwXdqsygPdgXrC5PQWMP2GZ7pvHUV77XPV85
 A3K6JA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yatbvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:06:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so77316915ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199564; x=1788804364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SUr4coHG6SHatQQ+icyGqqHTZ+Kw/yIQBZoRbeqyCoA=;
 b=SL8kJUIPM6dOTw9LsCebPf20PNT9DubA9rctCPtNc5W2O3QOx+7iSO0BKXoi9OKq7p
 EWkxAmwqcFCCIA/8AIb80qLQ63chyFOds6W5fjid2DYUph5uAqqju3kccBgBpCOAuDzs
 nwTQWJvp2S6MlxmMGlLX6m7Xgw9+gJ6qMB+GvqDACxmMSkY2LyRqNQ2uVRZsGsePSNnA
 dBOAHm9nMH+x78K4mrQ8PV3tOaS4luwTb1djFYxQ1hUqR3UaFTseqvTNtU6fZC9TlOSo
 g9ZdA6wtWKbZFTXbCGnADtLhGmNe7Qq1WpX3JErqbkKMPEqRUcluZKT3uD32amVFKs8F
 I17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199564; x=1788804364;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SUr4coHG6SHatQQ+icyGqqHTZ+Kw/yIQBZoRbeqyCoA=;
 b=L8POlBIRYB07kxvXbAXf+CsWcjnQJIb6/VVHv+mcX4NEK+QDnZVEWeZdHTuW6iJ+dW
 gkY6ymSW9sXsIPoJ2yToQaHNZ+WShdY9Pw1xBDvW3wXWqEDO19yhcrN3b2cHWtqsLCCM
 bjmlq1mTYcdsAI8d9U5XBm2FrMvTTK9/TRr3Mr5g82FS6ZoGZkog6dH414bDaRXO8dPD
 s5x6r4RbPeEGTpanbyZ+gBL3v0YY8hG2U0a1Q11EKO3flxcYk1smGcCXveRyZOollutP
 BSGAdr0Awk3XDjxsH/lqe/FgWAO+wBj2nkWxFr95uapBDC+0Fy9XaGWhneLhYPDU1yrx
 6ltw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8Xn1louSPfDylJcqMRXl8GEjY7DUL7S78Xcr1uTLNxM6Z/NmrSVfyBKdlQikzB14bwalgozuBgSQz@nongnu.org
X-Gm-Message-State: AFuF++nalDRWHuPh/dZem9w6ounXJcuhbYN7q8yA8eH1Q478sx3+omb4
 kbQpixUsaP4OhTgXpLgoBVQVe3DtGDIo3OU4yszFq5tpOSs4XLaLSMk27b2GIKxNOm1MV5Tt+BM
 Qpitnw09EXA598Q+Q8iORY64bZZaxFl0Kmo1O66ls+gjfsXOEqUXt9F8zXg==
X-Gm-Gg: AYBFou3KmmkPR1bDQsX6hDrrmiqAY7XJn93xpsDxvW80BZkq4L8nJwJt4dhpVj9NIS3
 JyZXJvNt1KsqUta8V8FIVQOCIwIWQX6xI2qGlrsR9lUFXKjvcAh8v5tVpeB8ZB8f9Zlqu/wyo/E
 8LfgCc0goA+R3FlsKh4t85tM4InhNMxHjBjo/AKN6wBJU+dpktu+oliiahbjYGQ7kZXsF6ZhkSU
 UfRKwPe6zsDwULIiWsG5mtbWsJmGnempEtJpIgx5J9HnL4DeGmn3y9uPNMCPlA86iUkaIOtdiCw
 4oA14STL1Ba78THa+7AQ/RAyqZVUH3N7E0PxgVnHULv1E5to3oIexsYCzNvr8vBH2I9APXhthEA
 0OpmrQkQgHpQyu8Yd6KrX8LBU7H3UniJ1j++lgbqnV3p9lMgeo2+CuBXOmmpHzBpcaVtc
X-Received: by 2002:a17:903:2411:b0:2d8:d4cc:be67 with SMTP id
 d9443c01a7336-2d94a90b2f8mr36479945ad.20.1788199564119; 
 Mon, 31 Aug 2026 11:06:04 -0700 (PDT)
X-Received: by 2002:a17:903:2411:b0:2d8:d4cc:be67 with SMTP id
 d9443c01a7336-2d94a90b2f8mr36477035ad.20.1788199562202; 
 Mon, 31 Aug 2026 11:06:02 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32874498f9esm28184278eec.20.2026.08.31.11.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:06:01 -0700 (PDT)
Message-ID: <9b3d2f95-b985-48a2-bf35-697afe88a630@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:05:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/47] target-info: add target_config_nitro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-26-pierrick.bouvier@oss.qualcomm.com>
 <4b9aa2f9-8546-4aee-92f0-d27e935be53c@oss.qualcomm.com>
 <0edef42e-06b2-4fca-af6f-8d17b0f15a3f@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0edef42e-06b2-4fca-af6f-8d17b0f15a3f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX36UrmQOQzy9q
 awqP/hlLPNOQrKzxdJcGa6IzeEio0BtdLs7fCCsRj8JuiV942IrJnMjPkETR6jkd+zJUN9w90bh
 R1P0IpcF6jbiQB8J2osisge0wJkVkWE=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a95c28d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qdQcSZdkZgsBmJ2unJ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfXx+vF0hTJzGDf
 Ya0KGS6cDyaU+nvYvqT7CStyeXcIq6tlPbE6g41kOySvjrOqROiKya4WDLqW2byttXLKW9DPaxt
 JzAP6Y3JMPt1h/YybSmhNBKzOCXSsPZT5GKQujVGRqd0ZucYdnm9OBKAIqmDzvQod3m1zDerEKy
 sQl6Olxlt/v22TSnSTxKmAj1ZsAkSPf4N4XVVpmAHt1iQuEJGVT3zQkbjzbKpNJbbbTjs8el6bR
 O5AqOkgYqvZN0q/zfd7MwKY+vtAOokLiYNOWgU2U20je+7kpH6pbkmcWfGjFnv5lMtRb5Ek99qU
 6a2UlgcWKCYFugVyX1RFClYmlGiznGEZKPmBKoWqpbQugwQ5MGddB3ExR69msOUrnqb6mZQvNya
 L81/Z5mrm2khOO2sEw2I8m/kmiTIx0gG84LQ3i04AxIynN1jfpsA64RtYl04Ate4T9SQ+aVCxqn
 qaIpklwBZ7Qg+8b9tlQ==
X-Proofpoint-ORIG-GUID: -NXsYQ9QYkCiuWG0c0DJYYm0vWl35Gvx
X-Proofpoint-GUID: -NXsYQ9QYkCiuWG0c0DJYYm0vWl35Gvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310156
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/31/2026 7:33 AM, Philippe Mathieu-Daudé wrote:
> On 2026-08-31 9:15, Philippe Mathieu-DaudÃ© wrote:
>> On 29/8/26 00:58, Pierrick Bouvier wrote:
>>
>> Also wondering why we need a special config for a target device.
>>
>> So why are we listing we can not plug? Maybe the bus Kconfig is
>> missing the accelerator dependency?
>>
>> -- >8 --
>> diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
>> index cfae85920a0..2e4125f8710 100644
>> --- a/hw/nitro/Kconfig
>> +++ b/hw/nitro/Kconfig
>> @@ -1,4 +1,5 @@
>>   config NITRO_VSOCK_BUS
>> +    depends on NITRO
>>       bool
>>
>>   config NITRO_SERIAL_VSOCK
>> ---
>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   include/qemu/target-info-impl.h | 2 ++
>>>   include/qemu/target-info.h      | 7 +++++++
>>>   target-info-def.c               | 3 +++
>>>   target-info.c                   | 5 +++++
>>>   4 files changed, 17 insertions(+)
>>>
>>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-
>>> info-impl.h
>>> index dbd7a5a2071..4f6c898c707 100644
>>> --- a/include/qemu/target-info-impl.h
>>> +++ b/include/qemu/target-info-impl.h
>>> @@ -33,6 +33,8 @@ typedef struct TargetInfo {
>>>       /* CONFIG_MULTIPROCESS */
>>>       bool config_multiprocess;
>>> +    /* CONFIG_NITRO */
>>> +    bool config_nitro;
>>>   } TargetInfo;
>>>   /**
>>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>>> index 579c43332fb..d775c94d1e3 100644
>>> --- a/include/qemu/target-info.h
>>> +++ b/include/qemu/target-info.h
>>> @@ -49,6 +49,13 @@ bool target_big_endian(void);
>>>    */
>>>   bool target_config_multiprocess(void);
>>> +/**
>>> + * target_config_nitro:
>>> + *
>>> + * Returns true if target defines CONFIG_NITRO.
>>> + */
>>> +bool target_config_nitro(void);
>>> +
>>>   /**
>>>    * target_base_arm:
>>>    *
>>> diff --git a/target-info-def.c b/target-info-def.c
>>> index 9d51371f766..96fd1f8c73d 100644
>>> --- a/target-info-def.c
>>> +++ b/target-info-def.c
>>> @@ -46,6 +46,9 @@ static const TargetInfo target_info_stub = {
>>>   #ifdef CONFIG_MULTIPROCESS
>>>       .config_multiprocess = true,
>>>   #endif
>>> +#ifdef CONFIG_NITRO
>>> +    .config_nitro = true,
>>> +#endif
>>>   };
>>>   target_info_init(target_info_stub)
>>> diff --git a/target-info.c b/target-info.c
>>> index 5db2a6049ac..67127da16fe 100644
>>> --- a/target-info.c
>>> +++ b/target-info.c
>>> @@ -47,6 +47,11 @@ bool target_config_multiprocess(void)
>>>       return target_info()->config_multiprocess;
>>>   }
>>> +bool target_config_nitro(void)
>>> +{
>>> +    return target_info()->config_nitro;
>>> +}
>>> +
>>>   bool target_base_arm(void)
>>>   {
>>>       switch (target_arch()) {
>>
> 
> Since the goal of this effort is solely to keep the CLI
> output unchanged, we can do simpler without having to add
> TargetInfo::config_nitro:
> 
> -- >8 --
> diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
> index cfae85920a..2e4125f871 100644
> --- a/hw/nitro/Kconfig
> +++ b/hw/nitro/Kconfig
> @@ -1,2 +1,3 @@
>  config NITRO_VSOCK_BUS
> +    depends on NITRO
>      bool
> diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
> index b9bd0d4300..39a087f8d7 100644
> --- a/hw/nitro/meson.build
> +++ b/hw/nitro/meson.build
> @@ -1 +1,2 @@
> +system_ss.add(when: 'CONFIG_NITRO', if_true: files('nitro-common.c'))
>  system_ss.add(when: 'CONFIG_NITRO_VSOCK_BUS', if_true: files('nitro-
> vsock-bus.c'))
> diff --git a/hw/nitro/nitro-common.c b/hw/nitro/nitro-common.c
> new file mode 100644
> index 0000000000..cfb47a9a49
> --- /dev/null
> +++ b/hw/nitro/nitro-common.c
> @@ -0,0 +1,15 @@
> +/*
> + * Nitro common helpers
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/target-info.h"
> +#include "system/nitro-accel.h"
> +
> +bool target_config_nitro(void)
> +{
> +    return (target_aarch64() || target_x86_64()) && nitro_enabled();
> +}

This duplicates information we have in root meson.build, where NITRO is
set. NITRO is a bit special, since it's set from meson.build, and not
from Kconfig constraints.

> diff --git a/include/system/nitro-accel.h b/include/system/nitro-accel.h
> index a93aa6fb00..a5126bcf02 100644
> --- a/include/system/nitro-accel.h
> +++ b/include/system/nitro-accel.h
> @@ -18,2 +18,4 @@ static inline bool nitro_enabled(void)
> 
> +bool target_config_nitro(void);
> +
>  #define TYPE_NITRO_ACCEL ACCEL_CLASS_NAME("nitro")
> ---
> 
> Amending in patches #30 "hw/nitro: filter from CONFIG_NITRO":
> 
> -- >8 --
> diff --git a/hw/nitro/heartbeat.c b/hw/nitro/heartbeat.c
> index dc41323266..c4d2a4637e 100644
> --- a/hw/nitro/heartbeat.c
> +++ b/hw/nitro/heartbeat.c
> @@ -21,2 +21,3 @@
>  #include "hw/nitro/heartbeat.h"
> +#include "system/nitro-accel.h"
>  #include "trace.h"
> diff --git a/hw/nitro/serial-vsock.c b/hw/nitro/serial-vsock.c
> index 1d56c33804..ec5aea4617 100644
> --- a/hw/nitro/serial-vsock.c
> +++ b/hw/nitro/serial-vsock.c
> @@ -25,2 +25,3 @@
>  #include "hw/nitro/serial-vsock.h"
> +#include "system/nitro-accel.h"
>  #include "trace.h"
> ---
> 
> And with another preliminary patch introducing target_x86_64():
> 
> -- >8 --
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 5cce27d4f6..f71a1b8bb6 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -128,2 +128,9 @@ bool target_riscv64(void);
> 
> +/**
> + * target_x86_64:
> + *
> + * Returns whether the target architecture is 64-bit x86.
> + */
> +bool target_x86_64(void);
> +
>  #endif
> diff --git a/target-info.c b/target-info.c
> index c9e0be3279..6f03f412b7 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -116 +116,6 @@ bool target_riscv64(void)
>  }
> +
> +bool target_x86_64(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_X86_64;
> +}
> ---
> 
> Only tested on Linux/Aarch64, not Linux/x86_64.

Also, it solves maybe one case, but there are dozens of other CONFIG_*
defines we'll have to deal with also.

Thus why I mentioned in answer to cover letter that maybe we could
generate this (functions + target-info struct fill) from Kconfig
directly to avoid boilerplate.

