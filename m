Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5727CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqUv-00070t-8Z; Wed, 14 Oct 2026 00:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqUs-00070e-Tj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:21:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqUr-0005Qk-2L
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:21:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E28wnc3017940
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3uBPVukEC5y1CDQhsXsV8Is6EknH8jKAl8xJR62Leh0=; b=OrNQ/GmOdR61Acb1
 Grp+D5e4m46WdSGQjwZXU3AkFvSOKV1IPcp8N8Fvn2V2yaqGGsV3wxlSaowLz8h3
 q2pq7g/w3px2Cx9rOKoTIVqsyILwvLpxc+A5DFLGCdGpI8l1Vkw7hXuEbmQNXye3
 KV3zG2VfbHn8lP/H4ubQV1DgROEfNruRz9yDQtkJ7zfM814jgni1gl95zMf91RMm
 J5JLdO6DOeDcwcm+ZhoAwCTwAkiPPq16qlfZf+qmIVeNFfpOYci82ghL/FpOqREq
 wn4gfwkRUi++mYzIMTl5eNSY+NHtmWmweCiUuXC0xF4SM2xjEksKs7EhDHCSQiqv
 Itok/Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b2c47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:21:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a109c937so50420736d6.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791951702; x=1792556502; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3uBPVukEC5y1CDQhsXsV8Is6EknH8jKAl8xJR62Leh0=;
 b=iWkNKjUCGME6mr35fAGd64+/i5uScuP1uQs34ZMXwCE6dkOxFq3+9pB0wJL+ZtfS4Y
 ADg4nejtMovLX1+yGzDwcglRbspIEW5fggKuJgzU7oUkWQZD1OFcbh8+IDPSj0OX/Om2
 zxVGBob+Nwjuj7KCPOwrbzCddpTgN6iLahzEIK+jtMzW62DD8eS/++QdJYQNtjbK86gH
 F5eKFg2oa3NSA7jhJ53Cvzno8lJoYWikHg0yLdJEBP3TLg5Qx1+y7C27l1vy1azlWzI/
 ECPA4M2CC1NGpg9ScPy3xN+a5u+xqvqDOSTn8uNm955fysGCSHB4P0eYtGAMFC2ZCKdV
 c69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791951702; x=1792556502;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3uBPVukEC5y1CDQhsXsV8Is6EknH8jKAl8xJR62Leh0=;
 b=v9w/im076Ivef2sxEem8AZjMDP9iHmMKqLd2iUg1qDZykGZJpJhJsrho153Q8fcua2
 y7PkvUrdw/0pdyVB4gjhPuf6Cruzh1+x/W0LB9EpH0sDDIAxifHWDn9e1BzAQsFHQQVS
 aw1/1Q1m+R1Law2Z06bJICuFT8pdpBMBiXYYp+uptWL7Uyy0MM7JxRC9pbtscftfeaSh
 /flnuhkaJtBA83dzhB3kI44FVa7E70q8A8EiAUgLZziNFgrqLGMfK2I8kNPL347sWStS
 MCr6OFCtjvMrBBLZk1ssumSdVdIvY7GIOJRKGLORIt/jjkBBsE9Jj+FrmWpqA2d8NxdW
 tG6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhBHPrD6KXayxSB7L5ZM323AOGFJfesS+yJikPRbFNLpofinWnc8tEcLLYdyGMY8DYPKgmcy8y3llH@nongnu.org
X-Gm-Message-State: AFq9FYKa7BXu5oVpEWp9sHOPJSIflbbt01Go5WMLjpWogczzfRuYAo1U
 0DbwM8eBQa62Dm3/B+3++jiaZLHnoGOwu/eAFGlVAG1bmYVsn7CG1W3zWkAXVUYxSxIvCIPyOK6
 fiPW8e1Ft3vA9krMPsmRJgVHnKaf57rd+trIQ0vB+DzwRkwLEEiFeO6wxkw==
X-Gm-Gg: AYBFou2Iemi62BfkgxYrwYdaRcvgt0tZiLpScKN/WlCzrZsJoBAIflhH/FhcjJFJvo6
 XrerkK0+9mVWGCwtSbpseOzGoKSqG6t9cPRc5WXs2dp8aTFj3ntrruhuGX3Ex0rSh2t+Eqsiznu
 5a/wx9gT8LO052C3CZmJRJ5sr9xNotqku3t6EQ8YgN4xfMWidr/f17kPwiGdF+3iESHVhc0KpI/
 sUy/Tsku0nJD/uHmI94WzNDEnMMGmgrZObln9OasG10badFxk/GX/SkP9JFXcg5hTa9g7MBhMvx
 f8F7VkBWAaf8xZWtGSrWnUIhFtCPY1hp1Wd2Cc7O3SN/n37mS3RyIYC9rllFs/FvU69lWCL60WF
 twco6kY42XzlgbN8rxgnXV575adt7sA2Xz2+mdld+ryI8G94+UzHrxs12V5136cNghfr0bM1c8/
 o9zOc=
X-Received: by 2002:a05:6214:2524:b0:914:5176:a0a6 with SMTP id
 6a1803df08f44-91b553261cdmr259464206d6.2.1791951701529; 
 Tue, 13 Oct 2026 21:21:41 -0700 (PDT)
X-Received: by 2002:a05:6214:2524:b0:914:5176:a0a6 with SMTP id
 6a1803df08f44-91b553261cdmr259464006d6.2.1791951701005; 
 Tue, 13 Oct 2026 21:21:41 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97c4044dsm42653896d6.46.2026.10.13.21.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:21:40 -0700 (PDT)
Message-ID: <4f9b2f40-35ed-483a-8b78-dba6dd57a426@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 23:21:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/arm: declare semihosting ops
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-9-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-9-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acf0356 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=BJ7rpSF3g0RtI8Q15BsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: zfB4o8NP1M_W1aHQ0e7orLZ9n80bIcMe
X-Proofpoint-ORIG-GUID: zfB4o8NP1M_W1aHQ0e7orLZ9n80bIcMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX/OpiIB4vujB+
 c99UTQIg5OKd30c5ZrIWzJoR8owK93i9JrGeQD/1VxY5msyjQyWtFlheignx29PT6kQl8A+RYr9
 7+V04KfwWDs5W8oL9keNJ6oYfjbmkK4fzv8DKrcxzUbZ6WMZFZ1JHYJOfI7E+bzdjH5tbxsVe/v
 riHOyWVNiTv9OzSMQfbfODIk+8s/sLNYzn1OyxxhgRzS04xrpLYJMEJJAA6ysWHu+fYyAk0g+vF
 dJg+iNo88Kdx6DGUpde0tal0lblKR1l7+gMnQYnBgy+f5RXYVkbGmJHFIb1TJ49cZ6h20HuDvju
 GD777pfJ+4ZRJQLPcsmZoPpoC4ut8xlPEeEDXnRitmsTlRMUkyXE1wvsHE716Y8jD4xf46pXguf
 qJbTZOLXZIEYXRcV9XPJUJDPrmCkGLNaDZaOBdSXhmyMs3q7a+FaOvNLs8o0f/QeLVFYEpoj/Ks
 TKJglxUfBXKMEyLGR+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX6wVa4LO5s9GX
 llZQ6HOl9sqjp1Q9h2vSSrsu+OUcje6eylF4KbQFLBgM2i8rD9gT8xvuymgeAhN2HTfEzJaHMI2
 OlQhDi3GOvxeYHMqQkae6M+UMDKxtK4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140017
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> For now, we keep the global common_* symbols defined.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/arm/common-semi-target.c | 72 +++++++++++++++++++++++++++------
>   target/arm/cpu.c                |  4 ++
>   target/arm/internals.h          |  2 +
>   3 files changed, 65 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
> index 38d52deb3d6..5263c0435a8 100644
> --- a/target/arm/common-semi-target.c
> +++ b/target/arm/common-semi-target.c
> @@ -10,9 +10,10 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "semihosting/common-semi.h"
> +#include "internals.h"
>   #include "target/arm/cpu-qom.h"
>   
> -uint64_t common_semi_arg(CPUState *cs, int argno)
> +static uint64_t arm_semi_arg(CPUState *cs, int argno)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
> @@ -23,7 +24,7 @@ uint64_t common_semi_arg(CPUState *cs, int argno)
>       }
>   }
>   
> -void common_semi_set_ret(CPUState *cs, uint64_t ret)
> +static void arm_semi_set_ret(CPUState *cs, uint64_t ret)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
> @@ -34,29 +35,74 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
>       }
>   }
>   
> +static void arm_semi_set_err(CPUState *cs, int err)
> +{
> +}
> +
> +static bool arm_semi_is_64bit(CPUState *cs)
> +{
> +    return is_a64(cpu_env(cs));
> +}
> +
> +static bool arm_semi_sys_exit_is_extended(CPUState *cs)
> +{
> +    return is_a64(cpu_env(cs));
> +}
> +
> +static uint64_t arm_semi_stack_bottom(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    return is_a64(env) ? env->xregs[31] : env->regs[13];
> +}
> +
> +static bool arm_semi_has_synccache(CPUState *cs)
> +{
> +    /* Ok for A64, invalid for A32/T32 */
> +    return is_a64(cpu_env(cs));
> +}
> +
> +const SemihostingCPUOps arm_semihosting_ops = {
> +    .arg = arm_semi_arg,
> +    .set_ret = arm_semi_set_ret,
> +    .set_err = arm_semi_set_err,
> +    .is_64bit = arm_semi_is_64bit,
> +    .sys_exit_is_extended = arm_semi_sys_exit_is_extended,
> +    .stack_bottom = arm_semi_stack_bottom,
> +    .has_synccache = arm_semi_has_synccache,
> +};
> +
> +uint64_t common_semi_arg(CPUState *cs, int argno)
> +{
> +    return arm_semi_arg(cs, argno);
> +}
> +
> +void common_semi_set_ret(CPUState *cs, uint64_t ret)
> +{
> +    arm_semi_set_ret(cs, ret);
> +}
> +
>   void common_semi_set_err(CPUState *cs, int err)
>   {
> -}
> -
> -bool common_semi_sys_exit_is_extended(CPUState *cs)
> -{
> -    return is_a64(cpu_env(cs));
> +    arm_semi_set_err(cs, err);
>   }
>   
>   bool is_64bit_semihosting(CPUArchState *env)
>   {
> -    return is_a64(env);
> +    return arm_semi_is_64bit(env_cpu(env));
> +}
> +
> +bool common_semi_sys_exit_is_extended(CPUState *cs)
> +{
> +    return arm_semi_sys_exit_is_extended(cs);
>   }
>   
>   uint64_t common_semi_stack_bottom(CPUState *cs)
>   {
> -    ARMCPU *cpu = ARM_CPU(cs);
> -    CPUARMState *env = &cpu->env;
> -    return is_a64(env) ? env->xregs[31] : env->regs[13];
> +    return arm_semi_stack_bottom(cs);
>   }
>   
>   bool common_semi_has_synccache(CPUArchState *env)
>   {
> -    /* Ok for A64, invalid for A32/T32 */
> -    return is_a64(env);
> +    return arm_semi_has_synccache(env_cpu(env));
>   }
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 10ac6c98318..81ec1ce21c6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2663,6 +2663,10 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
>   
>   #ifdef CONFIG_TCG
>       cc->tcg_ops = &arm_tcg_ops;
> +#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_LINUX)
> +    /* semihosting is not supported for bsd-user */
> +    cc->semi_ops = &arm_semihosting_ops;
> +#endif
>   #endif /* CONFIG_TCG */
>   }
>   
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index c41fa5225c7..e849e357cfe 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -437,6 +437,8 @@ bool arm_cpu_exec_halt(CPUState *cs);
>   int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
>   #endif /* CONFIG_TCG */
>   
> +extern const struct SemihostingCPUOps arm_semihosting_ops;
> +
>   typedef enum ARMFPRounding {
>       FPROUNDING_TIEEVEN,
>       FPROUNDING_POSINF,

