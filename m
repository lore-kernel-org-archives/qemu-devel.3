Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B295FC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 14:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7xgD-0000m3-Ui; Thu, 24 Apr 2025 10:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u7xgB-0000lD-73
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:35:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u7xg9-0003c6-1W
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:35:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OC3ETV011387
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 14:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 grdkcIv8kdAuNk/zK5IW9uFXfG5YfyzPBZlOmgd+4rg=; b=Urfe6ltUqv63T1t8
 i4UWGqTstAx0wLFbcLyGkARSAfVcX/Z682mWElrg6soLUdamaKiPXoYZQwY0r/m4
 5ZSxe8EiOFeDYbTA89/OQ/0gyZqerJOTbs0cMaXdk4oK26m+AdBgW/w+KwLp1sqe
 EVi6Gu5GSMNHAIkUKf3ZlxQjEZLw28dGTdxgHkFGSnAK6wRMzW2Lw9KYr68NoOOg
 DlmOMyT42E/2RQFThKz5QiLi1ia/sKUsZg0ob62O/7fmmq5RRMARFWaE31Uub7VT
 rQChKj+USHf0hoCX7awJ+aNI0LGa118TyGM128AqQS2NJwRZC7uas4R+X3WR+3G2
 4CrnlQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3dvwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 14:35:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c791987cf6so226446785a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 07:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745505340; x=1746110140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=grdkcIv8kdAuNk/zK5IW9uFXfG5YfyzPBZlOmgd+4rg=;
 b=ivqTJz/JJXLATv87WYYKRAmsT2yPkRw8IKbSVVM6gilCRaxpb5t3Qd8pz2nMhQGa8r
 PFzY6x08PpCU+hUPvJaLaSQU6JERMbdfY8n6Xr/+xHjbKYMWoXkSccFGKHzNG38B2bJA
 Y0wg64NTrpxDQoEnRMl5a2R+5NYLvcYmfI46NrcQnoYdUlxYxdj7aY9FUTJfGr7QGe/P
 fnz7UbwlUwpBouYGSNwhID6R0nqpHU2bsAYhiMXLeOdLm8pskBN6/usAsmckoXPmutP8
 3X/iITdBDBxlVSm214R0dxVOtB8iAXezF6uIckvepn3lPfLrRI8KgQ7tEqJDWIu792Jo
 MgHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCv214H6ShQq3rPCcIbZvPuG6orXEP6d45cDB5gRvzgEEFhrQBwBt+CDb1eYQxSlZgyUnW1FEWdCOB@nongnu.org
X-Gm-Message-State: AOJu0Yyzq0QUTnZbbVC1emGHyoZ9MFsoojf/aJ9iMK037n5vunoFn8e9
 r2OGlXTyY/b6gFaF98Q60ZUqbmgjD9MsxHMWIi/P9pj1FlDd1iLYXZ4fCg8Son/UnJ1XipFZWza
 GPStkr8GhDhIsM/vQBcsMUzF1r9PmuM0n2mlVlikVr5Og0saI04z9zw==
X-Gm-Gg: ASbGncvoSlrpe7qBgxARzifRbWV8KoaWiu+mcppeXSxGIe07uU8G5joWQvs5l81M716
 bSnQDqoa0ib1TlGrTyOBPqaTRNQY3SG9Njdc4p9XyFJ05UmRFrDo2wdAHE04lXictl1cxRPTQh+
 eyGoNXUNrc0g4A0Lf6V9T2pxjj5u7OZ6kRktoCCZmzolSj1mJBqzjsV1pmnCOMTT3HsKeMY8kfu
 GFMnCKrTA5LhP1VC4MIMURJK9LDyniPvTxWS885UXyUWpo8fk9jHXyQGEgzDu5uZUHBJtrJpKZe
 zl21ZxWnr/KC8x92+SRQc1ZQLjewmwwuHNgiuceSr0zBxUrbzkYWzWpcKJzmZ0r3Pm3tGQ==
X-Received: by 2002:a05:620a:2613:b0:7c5:9c13:2858 with SMTP id
 af79cd13be357-7c956d9e03amr433399485a.0.1745505340332; 
 Thu, 24 Apr 2025 07:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFImhYdTix0UyJkhPbh8gjihU8TQhrCr9m2mPJkOiXX3VH1p0dB5dPXstEO9jnschs+M1rAkA==
X-Received: by 2002:a05:620a:2613:b0:7c5:9c13:2858 with SMTP id
 af79cd13be357-7c956d9e03amr433394385a.0.1745505339838; 
 Thu, 24 Apr 2025 07:35:39 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958d86bc3sm93049985a.67.2025.04.24.07.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 07:35:39 -0700 (PDT)
Message-ID: <84c853c6-0fc0-41c6-bf78-19a53db225ff@oss.qualcomm.com>
Date: Thu, 24 Apr 2025 09:35:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] target/hexagon: Include missing
 'accel/tcg/getpc.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-9-philmd@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250424094653.35932-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -NLOt6U-xZIIC3E_b6Kixx42mAhE_Xk1
X-Proofpoint-GUID: -NLOt6U-xZIIC3E_b6Kixx42mAhE_Xk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5OCBTYWx0ZWRfXw7g3wzsbFTrI
 yIy5v35x7EuDt3kav8h6i+3aQCgpiSi3KKi8iX2q8TJ/JSjWno3UlOkP/GdBID5ap9/INvPQVZo
 atg15KkxZBlS+aXPwNkNIdC96z/0r1s915J7+ehXcCcDsypB+1Me9PMaNPkTdkN+EJKtrxhv3Bo
 2CUe+oqfQ27m/by+QNh7ediq2CKj9DgBT9z21IQIxLUZNQ6fICRXYn5Tb0HaP8GtGb3+fbL5tS1
 afd57+MRN6WbTfvkXuWp8mWpPbD/LpNODtUgeff3tGdkcFjcAKbxtTvwrapyVxnj532Mn+62uGa
 7PRPi3O6okwrzNetY7ijee/uHCFeCgQIboqZmLGY0/BLTF7Cq7WodILYfgR0Qb6xzYhTZUvcKG8
 FfBznZAR+WwnUNzD8Vp5pu0fFrhgOshdHLPBmYgv2F3nlzAMDteHPS/t6G1hFPWjdwghzeEQ
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=680a4c3d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=jRY41X2Sxa7IWVYATAQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=832 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/24/2025 4:46 AM, Philippe Mathieu-Daudé wrote:
> Since the macros.h headers call GETPC(), they need to
> include "accel/tcg/getpc.h", which defines it.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/macros.h       | 1 +
>   target/hexagon/mmvec/macros.h | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index ee3d4c88e7b..6f82277a415 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -21,6 +21,7 @@
>   #include "cpu.h"
>   #include "hex_regs.h"
>   #include "reg_fields.h"
> +#include "accel/tcg/getpc.h"
>   
>   #define GET_FIELD(FIELD, REGIN) \
>       fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index bcd4a1e8973..c1a88392c05 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -21,6 +21,7 @@
>   #include "qemu/host-utils.h"
>   #include "arch.h"
>   #include "mmvec/system_ext_mmvec.h"
> +#include "accel/tcg/getpc.h"
>   
>   #ifndef QEMU_GENERATE
>   #define VdV      (*(MMVector *restrict)(VdV_void))

