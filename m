Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAD6CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqdc-0001dm-8U; Wed, 14 Oct 2026 00:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqda-0001Zg-7D
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:30:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqdY-0006Gv-Ay
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:30:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E24ZS42333507
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WNcoK2FbN/T25VV/WJ0/Hf9qdy5edUNuk1pquNE81HY=; b=hV/70OFvb4RONxSc
 mw+37zUYwcU0A0SFtopCgn/1ugIpORhCjPksxEJ/F45uQzPNszJ8cfNkDHCZK3x1
 zm4gA8zbOO3CZD7eEQJPqCuljMUiHXAFEsCySN0xX3IlxYHhnlzn4jpBWVtFapfQ
 oVURf0VFP6wsosnf5rSW7GR5n9Uuclk+0L/Ifdo2ftj4jDj9OKwYKYkqhA3VF/zA
 i3a1kimJpPJ0YT5+oxAsV/D47W9BoqZb1BI4oF1j512t6/Xd+nepwoczG+XxWPtq
 92mRhqB2c9lOk4AD32nVGbmh7CWnMrSa60tkOodDxe+G0UCYXJWNeWTb5zfbntDU
 zZeQMw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s0hjag3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:30:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5338cfe567eso77436901cf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791952243; x=1792557043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WNcoK2FbN/T25VV/WJ0/Hf9qdy5edUNuk1pquNE81HY=;
 b=AAlWgSpXK/HvE6JHjUrrZctVfeaER8hbFdmo6iAvKXWYY+L8oMEBhmmUcJachb9UDd
 iaYrYpC1nKwezFPVOiZ3gvw8TsIB3hpw0Sflso9M3OvDUB8sPHrPiMjoneC6dvRgZrtJ
 7P1nVhM+IQjgCzlxq3vf4taRCRBOYuXiKv+8x8m5I/U4uCT1kVgzPdVPk4LF64Iy7Tec
 jMpwIAviyZiWYzPgzRXYFiueTiyyptzOiDtamjRx8kT7dexF3w7A/gcMDKjWb0LtfY08
 M71giK2HHCOMnAxHDhHXp9j5d8hIrOW+G0g7BFdyWx7ntYhK3faFY9OV+vMJLbD8ds+X
 lg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791952243; x=1792557043;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WNcoK2FbN/T25VV/WJ0/Hf9qdy5edUNuk1pquNE81HY=;
 b=n7vLaggQUzffd6jLWevVkG9vDeKIP15a+q+1mzUEVyxBn5PYefpVDYtPYPAujCJHI0
 yO4KdH+uQOlU1+CE5a/V+LrFXhO3giK+06GzDvXkbnHsLGVy1HB3t4rZTZxNaO8O/U5b
 FzTuR722nkSHIqPoqEFSYJceu3cxwq691SsbpLK0+gbaWf7cNoAQZ+RPyghRtaAfHRGD
 YxL2Yyha8wKP4xAL89p7ZoCjHlJmy1V2d7ArV1FO84iPWTJoWJeyR1/4iRSV/sKoCxh0
 pDw1A6huWOVueLZR55fdFYcmrjzouBmnfaHlyqgpIa0MGuGqB2a3Z8+AMQfTZFwrGJwA
 yJfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgM9HeODNx+pZYOMlGfukquieOoMbe6Qvrr4+lkVYhcugIvE1fxhZ3zxMrzQIpQ5WJGSXa/jr0qQV0@nongnu.org
X-Gm-Message-State: AFq9FYKW69PlAPTmSJJIdn4bONlJM0tdf/BwOPZm0o09cFT8PyFCYFsY
 FSJ/Dwqs6hxmAPrLr+MtROsyjxDWncA6k/njbAB+4HsDre0GMPTPDG79EGFx3m9MvDvmOQkiun7
 8kkCWHOBK7YosKCUPvJqTzEJBS4ioC7wHBTUgJWwyIm6+hnysh+D31vB9Kg==
X-Gm-Gg: AYBFou2Dn99HrsV9F/Tww4n+hbGsRwBoLO9qU8J8x700/J9lx02Oc6BSdO1E+bY6TvV
 UMjN60aPIkI3d6B7a+kEu9HCsmsr0CMWiI0uykUy41GY7x3aRxUIoI/JpfNES6jGN412KokiGv5
 ZhS0Q2mqd0Yulre2sj55p6QCVX4Yj0YMZohRGpT0gBdkDJTskKVowb7t/TSdIndLxUppXfiV6z3
 z8U3omAaZkvLHjPAHR2giIiLo7RA93nB7xjVf5bq1imzOd2D7NkE1hngdnoSF+JHwtqwP0Pwy5w
 JSMbglzSMn5qWtYVl6w1nsJRaMKunq2oBSxccO/pspf/Yb+DDXRU496vP5MC5mOKvhUGxJPQBq7
 go/uGQ5X15sHMVc2cF7RFhWsa4sHbZWA9CIkAM9/KGQwSp8KlKu0IzSdoly2JCpwO5epAy7FVP2
 f43Aw=
X-Received: by 2002:a05:622a:511:b0:533:3ec8:a834 with SMTP id
 d75a77b69052e-5359fb3dce3mr247490721cf.40.1791952242722; 
 Tue, 13 Oct 2026 21:30:42 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:533:3ec8:a834 with SMTP id
 d75a77b69052e-5359fb3dce3mr247490471cf.40.1791952242056; 
 Tue, 13 Oct 2026 21:30:42 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7a34b5sm116352461cf.22.2026.10.13.21.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:30:41 -0700 (PDT)
Message-ID: <57045b8c-dec0-4964-b196-cb0a8476d863@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 23:30:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/riscv: declare semihosting ops
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-7-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-7-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GL+dgeNK c=1 sm=1 tr=0 ts=6acf0573 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=BJ7rpSF3g0RtI8Q15BsA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: -C0FhFSX2oXw9vjA5Ppg0FMNYLR0KdGQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfXwiRzMQ8oF6XR
 eIYT4iGnUF45yZJx/NKq2kS0ivhzekxHRfBOuUjYNn5CDHdbwHT9GhkQg7YWUgdxRfwD3Eiy0SO
 xthDgLNp32SDJf3aHTms836FQC67xcI=
X-Proofpoint-GUID: -C0FhFSX2oXw9vjA5Ppg0FMNYLR0KdGQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX/w7g+hYv8MPX
 z+V/eby06y22C1ZHdHljSdJSjDf43G/jWUHSwvWEbkthwdfNrF4+dOhcP/4mdcQcAhtCdfHYmLR
 2rskGrKOPv9GuHXRR7ztYM/INC2cjCwQzip7ExISno1VZBtdz5JlmrFqjggSB7+BCDLqVK63j7q
 3dBMCGOTBlIwbE0qqnfxEBxkxPm4DRmHIZKUuuJRJ7XRZHlhM3tgEEJkUjXn0xDeVXnQcnjx6Je
 DUZpJj36kVuIwxtL4arnhbBkugI2A6b+w8gf96QFflLXniElY7+yodryM3PH7r+RTymEQSCCr1t
 6R/58sbVjS5NvaBqEaW+N7qIL8FpRSG+3dKb/CVtWGbherJ17GiLwOP1TKMZElZlxBpoaqD6+fp
 v/k+FAgxuvaCm8C/Wo9IQNqK/ZXdLRpm6qXyXfpCahoGUO8siyyj51FXlTd8mVh2KqJOTzpepa5
 Xa6sV3VX1kUmjmEKRxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140017
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

>   target/riscv/common-semi-target.c | 62 +++++++++++++++++++++++++++----
>   target/riscv/cpu.c                |  4 ++
>   target/riscv/internals.h          |  2 +
>   3 files changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
> index 38a00e160c3..7fa3bef6883 100644
> --- a/target/riscv/common-semi-target.c
> +++ b/target/riscv/common-semi-target.c
> @@ -11,43 +11,89 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "semihosting/common-semi.h"
> +#include "internals.h"
>   
> -uint64_t common_semi_arg(CPUState *cs, int argno)
> +static uint64_t riscv_semi_arg(CPUState *cs, int argno)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
>       return env->gpr[xA0 + argno];
>   }
>   
> -void common_semi_set_ret(CPUState *cs, uint64_t ret)
> +static void riscv_semi_set_ret(CPUState *cs, uint64_t ret)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
>       env->gpr[xA0] = ret;
>   }
>   
> +static void riscv_semi_set_err(CPUState *cs, int err)
> +{
> +}
> +
> +static bool riscv_semi_is_64bit(CPUState *cs)
> +{
> +    return riscv_cpu_mxl(cpu_env(cs)) != MXL_RV32;
> +}
> +
> +static bool riscv_semi_sys_exit_is_extended(CPUState *cs)
> +{
> +    return riscv_semi_is_64bit(cs);
> +}
> +
> +static uint64_t riscv_semi_stack_bottom(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    return env->gpr[xSP];
> +}
> +
> +static bool riscv_semi_has_synccache(CPUState *cs)
> +{
> +    return true;
> +}
> +
> +const SemihostingCPUOps riscv_semihosting_ops = {
> +    .arg = riscv_semi_arg,
> +    .set_ret = riscv_semi_set_ret,
> +    .set_err = riscv_semi_set_err,
> +    .is_64bit = riscv_semi_is_64bit,
> +    .sys_exit_is_extended = riscv_semi_sys_exit_is_extended,
> +    .stack_bottom = riscv_semi_stack_bottom,
> +    .has_synccache = riscv_semi_has_synccache,
> +};
> +
> +uint64_t common_semi_arg(CPUState *cs, int argno)
> +{
> +    return riscv_semi_arg(cs, argno);
> +}
> +
> +void common_semi_set_ret(CPUState *cs, uint64_t ret)
> +{
> +    riscv_semi_set_ret(cs, ret);
> +}
> +
>   void common_semi_set_err(CPUState *cs, int err)
>   {
> +    riscv_semi_set_err(cs, err);
>   }
>   
>   bool is_64bit_semihosting(CPUArchState *env)
>   {
> -    return riscv_cpu_mxl(env) != MXL_RV32;
> +    return riscv_semi_is_64bit(env_cpu(env));
>   }
>   
>   bool common_semi_sys_exit_is_extended(CPUState *cs)
>   {
> -    return is_64bit_semihosting(cpu_env(cs));
> +    return riscv_semi_sys_exit_is_extended(cs);
>   }
>   
>   uint64_t common_semi_stack_bottom(CPUState *cs)
>   {
> -    RISCVCPU *cpu = RISCV_CPU(cs);
> -    CPURISCVState *env = &cpu->env;
> -    return env->gpr[xSP];
> +    return riscv_semi_stack_bottom(cs);
>   }
>   
>   bool common_semi_has_synccache(CPUArchState *env)
>   {
> -    return true;
> +    return riscv_semi_has_synccache(env_cpu(env));
>   }
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index da4c1a090b9..63c709ac738 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3053,6 +3053,10 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
>       cc->gdb_arch_name = riscv_gdb_arch_name;
>   #ifdef CONFIG_TCG
>       cc->tcg_ops = &riscv_tcg_ops;
> +#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_LINUX)
> +    /* semihosting is not supported for bsd-user */
> +    cc->semi_ops = &riscv_semihosting_ops;
> +#endif
>   #endif /* CONFIG_TCG */
>   
>       device_class_set_props(dc, riscv_cpu_properties);
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 5d84e4de960..f17d011d22f 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -206,6 +206,8 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
>   bool riscv_cpu_has_work(CPUState *cs);
>   #endif
>   
> +extern const struct SemihostingCPUOps riscv_semihosting_ops;
> +
>   /* Zjpm addr masking routine */
>   static inline target_ulong adjust_addr_body(CPURISCVState *env,
>                                               target_ulong addr,

