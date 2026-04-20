Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A47F5A8A9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEsp2-0007UI-Vr; Mon, 20 Apr 2026 13:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEsp1-0007Tu-7q
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:54:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEsoz-0001VO-I8
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:54:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KD1AEI3456075
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LnsTm9zpbLn+MoEtS+q88EJx4p8IjpZz4sXSGEbuunQ=; b=AvYrqsOf00nQOknr
 i37+ciazKTpcfhoMHQ6hyydMhAZgwfXmZe1Ho5TF3pc24d4gLcDiDO3Y7UVRO3zS
 0LZmkeSbpZYCapMPXFc8NtmnzMr4ftLEidnD2JU50vQqibzIYDKqJvNyFaK/gRIA
 mEu+xj+2pU7sy1UdX8jy/td4cS/kohIqVcfCxXwEfyVulH/CLdzjba62bCIopWZh
 OUsVIVCoejEuINToG/BYgpk06B15jvlvdaCrbvAagM+iaQ2X9J9TSWPuyc9LHmNu
 w2vhnzqJ06cqjk8msNKjvcbGi0ILxpb4DEcidTLpuOZh4w+SkYYRvCiHW0yQBE8i
 9elbMw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjtgs5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:54:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2d9da2559aeso4725219eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776707646; x=1777312446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnsTm9zpbLn+MoEtS+q88EJx4p8IjpZz4sXSGEbuunQ=;
 b=GW3H43Jg/PReGsrda2RxZxmEnVdlSWrQmD9mlxEUh8JC6kdNRYghpjUT0Gn3L+nEdD
 Z+Lufc/D0vKsykm3T9RcrzvWAjM8PHw4SxfYtobcibZoEVTGUfkXobDymKX2l6urGuJB
 5ADhklZtcoCR5tQaMtYY1Jc+Qo9ZE2iY5K6V3iYqIcUi+9/2uNvBk9xNqqhIv18dPvMY
 1Xh5+2uTI6kTbIrm7sFEnhXSR0QWKUvJW1O3i00ZjLcHbHqLqjfBiH590rKmbHvJ6imb
 /N1D7nH/4QBdwd7QdBTR8+lNpvsXoP7ENetVbjZo5GFcOxT9l23jdyYuVxMAouApdqHz
 UhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776707646; x=1777312446;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LnsTm9zpbLn+MoEtS+q88EJx4p8IjpZz4sXSGEbuunQ=;
 b=oH9BsjYOX9O5/UF5DJTwya2VOuESbbJAVDU6QtgdZZITOqgTZHkdgoB4lSrqJPWZYg
 KZ4CxNN+zxEv0RBcY9hT30am9VoUeMaJ94ooylh9H1JiSHkQ7dbVAjDgIvqFwi/o/JgH
 2MkVJYzm6czUmdY2/+bl2Baw+KD5k29sIGhccPkh5IL+6RB4hDrhrJ+Qu9DMK9T7pSeK
 p+vgUSmz6oAZP0kpzQsWzLDldyUKCu7Pi1fKfBlDZIg7u9XU40DlwGrXeIxeYJJJs52f
 Di4vvbulKBUrW8krZKFPf+uE7cCwyEw1dvC5m7zENajCdkFQsZrJrrj0c+QhEHRJlOWB
 U9gA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/c78aYiP+StUvNzPpEcEndfBXnN0G+1ozOXlpRlkvM6PRb3ZQeMhp7YmGXUoimNPZWZd9jtikAqkkj@nongnu.org
X-Gm-Message-State: AOJu0YwXrY29eACawkl9Y1mrD/yK9DWGLTVGqX3/X8aIURaN7mNy7Z2d
 KxZMlkd4kgySJCzP2s0o9GeXXrKEdIN4OfNI08Zy8mwgyVD+A4kwOnk/GsxbnTZhZSfLvNrNqxo
 EWag2HsH2NA8UMlu0BAx03IyVnSJ7+LFSOYDqaVRwymlgzL3h9Uyh5Aw0Eg==
X-Gm-Gg: AeBDievKky/NdKaoed0OLNlTdM/y3Wo9dA7bb63DtjjZ9MAQvj7CGFYkBJXzRRmoTuc
 9T4SSI3WYDFECP8llh6h5NzQKdHLDc/HuqAIjGxtMj7/JzS8QCV7leo7vHflwYyn1nQLFoXHjIt
 Y8Csh94bjeTYkWNKKMg1TP8r6nVizk4aZvvDD/eXqRaHMVFEhOpngXa6uzZ8egyIAozVpalCYjI
 CT12u9COBf0KXGwaFKNprZfA5h9xBfeYy6JOFFwsXzdD71GOvyq9xZ/vQh5OoEux+mJrC7THt9X
 z50vHCFepu/ECdYYtYYLSsNpJ5yGukl1dp69eapsSTDe/cJnjxkbwKBWO+DM95NniNaRuhZC7oN
 Fhd3RJkgE0Yfie8sN+F57dB4G7zfWptjFGSObWBJ6uT4q32ihOzAxI61tANxydznAgo6j5uT16w
 QtaABu0PU+jokb/bIeP2I3+9Pn
X-Received: by 2002:a05:7301:9f10:b0:2d4:532e:7e45 with SMTP id
 5a478bee46e88-2e47930fdf6mr8004997eec.23.1776707646107; 
 Mon, 20 Apr 2026 10:54:06 -0700 (PDT)
X-Received: by 2002:a05:7301:9f10:b0:2d4:532e:7e45 with SMTP id
 5a478bee46e88-2e47930fdf6mr8004952eec.23.1776707645387; 
 Mon, 20 Apr 2026 10:54:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c38sm15024710eec.5.2026.04.20.10.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 10:54:04 -0700 (PDT)
Message-ID: <ebd8b10e-90d9-4267-b117-9e9a8a564cf5@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 10:54:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 37/37] target/hexagon: Add hex_interrupts support
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-38-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260401152657.314902-38-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gLN0wrJRmm_7tvEnELrjvWC_70JE95Yz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3MyBTYWx0ZWRfX82J4T23hCSTk
 VL9zezdR3/biZnNUvxO4LtxrCdND4Y0adRMVW6gaorEG34PdAellOeLvrzAAQKf5UL+uBTe6d2W
 BfiU2ZgzU0dLYecIOLFNswRRYgiTKCE431EzZQiovFUunehc7CEUuWU5PhpiKSrOYOn+FLEZ6OH
 bAceanlFNW0h6HTx/83WdFT+LJSZD9/DyGodFdaj/dfigSRp7nfcIPnfzEGMSzypQRh6njAyNw4
 NgGUOFoEQQpkgEgjgdOv/fqLmxc6pJXNh2CCwXUHnu5KtcbOkzTfhyKRCMcTg6CxZzob2ywxUBc
 8sKcSM2GApqu9cPJ9cfcEwLIvOz8s1aTCzUqobM8gXntlBoLCUogo57eJlRbgtScPlZ5hTqeDGJ
 zSOxlC2WH+QKPFWiB3Lf2pY4cv9tXJFEf7zzhWQoSl0tOpqmwXC4nQaJ+cxDoeG1wEdO2I29bwm
 feiW0qIy0W0MQJ5aI1A==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e6683f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=EkTfNEHfCvmDPfggmdAA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gLN0wrJRmm_7tvEnELrjvWC_70JE95Yz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200173
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

On 4/1/2026 8:26 AM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h            |   2 +
>   target/hexagon/hex_interrupts.h |  15 ++
>   target/hexagon/cpu.c            |   4 +
>   target/hexagon/hex_interrupts.c | 379 ++++++++++++++++++++++++++++++++
>   4 files changed, 400 insertions(+)
>   create mode 100644 target/hexagon/hex_interrupts.h
>   create mode 100644 target/hexagon/hex_interrupts.c
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index c4fac9c2d38..3049b5a411a 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -196,6 +196,8 @@ struct ArchCPU {
>       bool short_circuit;
>   #ifndef CONFIG_USER_ONLY
>       HexagonTLBState *tlb;
> +    uint32_t boot_addr;
> +    HexagonGlobalRegState *globalregs;
>       uint32_t htid;
>   #endif
>   };
> diff --git a/target/hexagon/hex_interrupts.h b/target/hexagon/hex_interrupts.h
> new file mode 100644
> index 00000000000..6b6f5403633
> --- /dev/null
> +++ b/target/hexagon/hex_interrupts.h
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEX_INTERRUPTS_H
> +#define HEX_INTERRUPTS_H
> +
> +bool hex_check_interrupts(CPUHexagonState *env);
> +void hex_clear_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type);
> +void hex_raise_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type);
> +void hex_interrupt_update(CPUHexagonState *env);
> +
> +#endif
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 4e9c65f785a..9ae8e104043 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -59,6 +59,9 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>   
>   static const Property hexagon_cpu_properties[] = {
>   #if !defined(CONFIG_USER_ONLY)
> +    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffff),
> +    DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
> +        TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
>       DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
>   #endif
I expect global-regs to always be set, and thus cpu->globalregs to 
always be non NULL.
Thus why should be check if it's set in all interrupts related functions?

Regards,
Pierrick

