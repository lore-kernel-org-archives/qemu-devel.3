Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C36CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfln-00042h-34; Thu, 28 May 2026 14:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSflh-00042L-El
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:47:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSflf-0001CG-En
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:47:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGtClc3203335
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 18:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8y3h7ZNvHhn4BYQY4eKOMyqyZDumgnYyxS/iR+OjHAo=; b=lr0FN8kat2LC1zy1
 iOw7fN55mJ8fTp0omP9IPyuSzyHcB/p0uv5Vzr9eXu9zPwmzLYxbiDAHz60Dwxie
 5Hzfx/5ZazTmzYW1Pv2frv3I9FXfpG0bhG0glrl+1B/l1ZIUDoIlZCHP2DK8Inlh
 YPGH/qTNYFsQGa6Da54YUim5ouHVXhbLFfVu2eY6wGKHuFmKpAufOw0fsR21wSYF
 pDAg6hHOWgDLvYhczX/DVSVay6RslZyyuaQVz93ZXlqQQ1axav0RPQT0VAdhSu63
 ywfKPgPVUHcuO8uueA5I4KnY1yPYZCf8cS6TPzY/ZweD3j1J3b9y9U6pXgCsWiaB
 BCIZlg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynm8v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 18:47:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304448ab58cso10305500eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779994060; x=1780598860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8y3h7ZNvHhn4BYQY4eKOMyqyZDumgnYyxS/iR+OjHAo=;
 b=ipUXaQdRb8wuB3UFpEpj7pWX4y8Q9Cek2biskTMqsYpfMpxuQySa1nxjqkvnzQUCvH
 +0PSd08pSljFvo0OranMGhZRC5yPknwx0uzKnOdzkHOCjRF1qpFIdUkrZRwR/kKrcqHT
 /7e7OOSby6l/DxA/XVZRjZwoVfFDFRn/SWQqGtCc5gj045yZmds64NxAw6xvgs+FSRME
 dfpj+dda0j+AlLi3HmtA1lOZkB9Hj2Oe8WsBttW3r9N9tTl6+6Vzx9Xd50swkx2FY7en
 1HxWMqbF2d2ogypIJxULdYqzqIcR4IsuXBi3a/punrG9OP5EV3miPjEdbLzcZO6ypdL1
 YvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779994060; x=1780598860;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8y3h7ZNvHhn4BYQY4eKOMyqyZDumgnYyxS/iR+OjHAo=;
 b=fS/hbZ8K5O2+cYU23bEqDvX2kWNC/h18IXKJUHndyq562LXQe9/GKR3p4cwdlTA9/w
 VtYLiLxVBcPQDrT6i6RN8a6DW1srlGXnLY4T/4PxRCWyETON7p8G6YFF5kGcPN7K0L0m
 BTuQ2lEN1u6d6COxGoMNqhzsClswdUKVN14745+6+z6gCKrheCQNcgQ62BxOysOelkYr
 siRad+JdBsOsUFLuK/x9InMUbZeaXTwQoRYi9/OOzNGeLAdbg5pbV22eoVg+ah76ezcE
 zSKNy3nsq6aWRFTS48n8Ng34GQhJIo151r+wwuRqxfCEbKd7LY9AGAsV9+7f9NgKjXPC
 1K8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CNbrdsPAaaN08XgXQXFI5YBo/sJluILwXzozeB+TOhT7SVRf+El3msdTA0UmhmUJbCGjdP/GIAoob@nongnu.org
X-Gm-Message-State: AOJu0YxCjAcnYztYBa+TES+hIZ+XNSYcsQSm0DVatfZdZmbk0diaZzNG
 YQGpBA/ZbW9fDpNtglI447bCZvdVzT2maZ5ry6lSMZ0RTXyAr2tiCCirj4Itqs9igHor6UdADaJ
 rV1pY3GnPwP5SXJ0mLH4k2ARCmTNu7NWL1ouaTHXdhOtOe+YaNhZODzxFQw==
X-Gm-Gg: Acq92OGPlfZgrMKwyU3TB0oS2J/hit0SPNGdJwbrQLP/0VmR/zaMGUrp0p6XX7gbgXG
 //S3Q700gx/ISXJGsnXfE1fQtW6VoqzncQfKs/TJF+VZ8tVnp/huUB7GTNODdVrHO7LN3jcsNL1
 +Ar3xlkuAp4Zuw19gGdM/IS7+b46ERsjYjXsHZ8vYUpF1raJU94XKRILctFU+GpnBI5bnmw5M5o
 0ueeq+7Qk3xntdxyaKW89qJWm5/kOVCkSGbeYegl+Zp6m+9oVpNtm09DhAcvtRUZPOkgq2p3cL4
 8v1RruWTSooXDDTu8HjRt/2HM8Cbh6B5aBXKLz7m3uJh0zl78f0qcnriXUMq340zsiNRFQ8djE9
 oaBCoZ01kK7igSy6bEKcKU5Lrk+EN+XL/Pv7VVIdJQdw5EF3w7eEvEB76ckGW6cd85KIGU2jipy
 HdYCulFGwUqbmkbS3dk3FttqRg
X-Received: by 2002:a05:7300:3708:b0:2ff:c84d:44d2 with SMTP id
 5a478bee46e88-304e8b4fa71mr145935eec.12.1779994059779; 
 Thu, 28 May 2026 11:47:39 -0700 (PDT)
X-Received: by 2002:a05:7300:3708:b0:2ff:c84d:44d2 with SMTP id
 5a478bee46e88-304e8b4fa71mr145921eec.12.1779994059169; 
 Thu, 28 May 2026 11:47:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e971361csm65923eec.9.2026.05.28.11.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 11:47:38 -0700 (PDT)
Message-ID: <b2a58b62-b061-4bdf-b459-9953b7f373fe@oss.qualcomm.com>
Date: Thu, 28 May 2026 11:47:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/common: Remove last bit of target-specific code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260528140857.44130-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260528140857.44130-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4OSBTYWx0ZWRfX32TOkElY4nDn
 ChxwBSo9JIfX+A7FS9RJap6u7vPE1eOagiUNXJcbqHb7sgMk3/wJbgsO8X4ND0akJtOI8X/HLRy
 22A7fSLGtk4yrbHWzPB72TN7gWcJSviaXszamgkZ3j6nNXp++WnhjfwOTI5/zpN5+WNXqv1j9Zs
 +clL0/jvvap+XNtBATGi/tqySYb4B5ftlfTPZ+ZdG9gagJq0rzfnBmOmjNcfR+UE5XUged6R9D1
 UcZFMZuu9YUOqTCqlK5UKaMnBIMpZSNa0d752qZQO/5nfzIE5k3eMzP0A+frYWJhUn3Tn2Ys34a
 lRJOXNd6L+TRhP/3VmVVZIXLYzzhc95B7QLaCTmmd30+0wVk5qJneWp2oRF1Kh3ci3+10nCsXKB
 YskzFdiOcxntw4VBR9NFSlLkeYdTFij5Im5EmgZBWTGWowxMN/VistuUJ29zdZSKKQSYg5tbudw
 DOdXuXzA8NW/UQXnm4Q==
X-Proofpoint-ORIG-GUID: kPO40q_eUzw1NyyhMJzK5QzqGI4Xt99c
X-Proofpoint-GUID: kPO40q_eUzw1NyyhMJzK5QzqGI4Xt99c
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a188dcc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PxziRZNxG1YmHJ00_7IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280189
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

On 5/28/2026 7:08 AM, Philippe Mathieu-Daudé wrote:
> Initialize the TypeInfo structure at runtime using the TargetInfo
> API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
> target_cpu_type(). Since the code is no more target-specific, move
> it to accel-common.c, removing the need for accel-target.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Pierrick, this is an alternative for both
> 20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
> and
> 20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
> for your "single-binary: fix compilation/execution for {arm,
> aarch32, microblaze}" series. WDYT?
> ---
>  accel/accel-common.c | 15 +++++++++++++++
>  accel/accel-target.c | 41 -----------------------------------------
>  accel/meson.build    |  1 -
>  3 files changed, 15 insertions(+), 42 deletions(-)
>  delete mode 100644 accel/accel-target.c
> 
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 9c5b4111c8d..62590a7d9a6 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -134,3 +134,18 @@ static const TypeInfo accel_types[] = {
>  };
>  
>  DEFINE_TYPES(accel_types)
> +
> +static void register_accel_target_type(void)
> +{
> +    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
> +    const TypeInfo accel_cpu_type = {
> +        .name = name,
> +        .parent = TYPE_OBJECT,
> +        .abstract = true,
> +        .class_size = sizeof(AccelCPUClass),
> +    };
> +
> +    type_register_static(&accel_cpu_type);
> +}
> +
> +type_init(register_accel_target_type);
> diff --git a/accel/accel-target.c b/accel/accel-target.c
> deleted file mode 100644
> index 7fd392fbc4a..00000000000
> --- a/accel/accel-target.c
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - * QEMU accel class, components common to system emulation and user mode
> - *
> - * Copyright (c) 2003-2008 Fabrice Bellard
> - * Copyright (c) 2014 Red Hat Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "accel/accel-cpu-target.h"
> -
> -static const TypeInfo accel_cpu_type = {
> -    .name = TYPE_ACCEL_CPU,
> -    .parent = TYPE_OBJECT,
> -    .abstract = true,
> -    .class_size = sizeof(AccelCPUClass),
> -};
> -
> -static void register_accel_types(void)
> -{
> -    type_register_static(&accel_cpu_type);
> -}
> -
> -type_init(register_accel_types);
> diff --git a/accel/meson.build b/accel/meson.build
> index 7da12b9741f..1b5b37e3097 100644
> --- a/accel/meson.build
> +++ b/accel/meson.build
> @@ -1,5 +1,4 @@
>  common_ss.add(files('accel-common.c'))
> -specific_ss.add(files('accel-target.c'))
>  system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
>  user_ss.add(files('accel-user.c'))
>  

I'm open to follow this approach first .
The only downside is that it limits to a single accelerator parent type,
which will be a problem as soon as we have two arch using this framework
for tcg. Nothing we can't solve later though.

Regards,
Pierrick

