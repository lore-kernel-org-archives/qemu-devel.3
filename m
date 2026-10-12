Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65BFCA9EDC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGeU-0008Vr-1T; Mon, 12 Oct 2026 10:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGGeQ-0008Uy-3b
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGGeN-0005vR-Vh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0J9h1686600
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eRDiW9bPGUFH82En+pBA+4mvT6fjNyz2EOOlKXIZR04=; b=b0ho9APaOFUpSGTd
 bMd8HxiMvHVO1i9/5MeFRSh46q5sH7FOtSa3EfLVXQ1OyxXjXjZhTJcNUW/pfKqh
 z+ntEslMHJBNyY/Szy7VOOwgP0RLGaElnY2sBOUD/Twl2OS3Kq5lSoHjRdOAlS9r
 R76FOh+pDiyXUj8lzNYBezTQjFa5k/3U8/e7SaZz8sHpLsGmGIyiSjuhzHNhNvrq
 VnaHIboPef5vTjBB/fQxRSCQkmuoHIcQ7MMoN1wMz1fSnJSYd/UFjxkeqkguyX1O
 klf+aEpjfONMSuCxgiHzMsaubdQM3mqwO4LTLaAY5jt9eOoGpmu07Pm5+e21C+zG
 9IUOYQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc142a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:05:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917baea8e5dso37228356d6.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791813908; x=1792418708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eRDiW9bPGUFH82En+pBA+4mvT6fjNyz2EOOlKXIZR04=;
 b=iVu1ABaZi0Kncxfn6mcuMOeAbcJZ3E/VrxT86Bm3mUTSwr5ybrvAuSWDk9+gL9QeuH
 GiL9uR2hN+aNq9ZUJzKRDvCygp/HsO8aJJgKuo0RR40rCQ85aZ9KavcwiSlQaTKOaWgd
 dMqJ9b7dgyFjSI9QQGFZsJ749ikAwvt9JApJipLVogHutJOdme6h78QgE86Do2xWOKB0
 dix51KCVrrxm6ddIj/U5DD2VxneWPhgTgPA3kKgF61KOglHF7ZhY+H0+iR/B+YjGHhDd
 OkE+jFN3SK67GTvjSwYxJw2TavESjdNet3m/bxW6kBn6G9pNIZBnSisKWR1JBDNqfMbq
 ACxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813908; x=1792418708;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eRDiW9bPGUFH82En+pBA+4mvT6fjNyz2EOOlKXIZR04=;
 b=o0TmjwHpQWqxAisNgPCMxl0GkZrXdo6zTcOnvEQuuSvEb7lZDJ1G2ueoAlXL9PtCoS
 vEtB5Fyrz0RvI//lEwaF+30zQI7v3w86ZjdjwtiEhk/mbrARQ7ablZjvirrkBmU+viE1
 Xc3c9maeyUq66DX8Dh9owP4827bVwOlT6IitjLQLxYb03WrCK2mAzk5TuaU02ECA+GuC
 3XCSr95ay8wJnIux4gsBM5qvOLuB+it/x7x8Fof6Po5wMCmUX8nUHDDYAGMKjE5ynoy3
 0PaAToEpY6s0zSrj4CKZz1CSR78vHSp4J7s4L+bdiVXaMdlSQND4c3v0fXuo9atLfOJB
 VYwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBytksm2sUlYitkLdZJPGLKVDku5xgYw8VNJNB354bFx9/kFsdJABrutNhBjweV8cL5TpxKsdt5YDSDj@nongnu.org
X-Gm-Message-State: AFq9FYIAn93313QwRhZlNMse17nrlIzhDiizPVVDo/RGZXXOVsKgDvx8
 IxdxmMd9PtpoF848lahyYshBFt6Av4+/RAFn6mVDkM5KwgCYEE0RuvILTztyfEPA/l9vCRkcO23
 oRp26/FUBLCBdweFrHOqbwz3XrDCYKaXbM9lks5zyHHFpxQnVnqoRkCdRjw==
X-Gm-Gg: AYBFou05K5qVhZkZmz5GW4B5g5IcOssBPv8vBZkhUBSQv8iKgJ82IsiuuR61WV2Bdf9
 LHR/iET30/ZVymACb2h1K10pGd46pR1mC14Tf3cpy1MYgNamo9/V695iAxI01qnX4GF7l8rxhJP
 IxwAIxnGAoiga4ZjEHeDQBU860vHW6Mjl1za7lbgzLO+VaFD8Dbv7wHn0vcGclLk4OZCd+xEyiE
 /WG3y7pMi17W7AKiVraicDfCGT13mnhll/b9/pgoy5CNJ7nnnz/cLcSlfQrK23s4s2beGfVH6mX
 TPnF3J86NWoT5eTmv4niD8AON6NAfV/WB5T4zs5HXyUp0cdMig52ryILvFqmI9aK/5+wZWptW9d
 BfsctN7R3sqEk8xcQBalGbLlvm0/OAE5cwytICHwVTfiRLyoxLuNpCj8If0gk99zDvMb2Y6ncEJ
 EDqRg=
X-Received: by 2002:a05:6214:6101:b0:91b:9694:c217 with SMTP id
 6a1803df08f44-91b9694c38amr49946d6.8.1791813907998; 
 Mon, 12 Oct 2026 07:05:07 -0700 (PDT)
X-Received: by 2002:a05:6214:6101:b0:91b:9694:c217 with SMTP id
 6a1803df08f44-91b9694c38amr49116d6.8.1791813907282; 
 Mon, 12 Oct 2026 07:05:07 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b5501f2e3sm96254096d6.8.2026.10.12.07.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 07:05:06 -0700 (PDT)
Message-ID: <dd827db4-6a73-4ac3-8821-8c6da4855521@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 09:05:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] target/hexagon: declare semihosting ops
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-8-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-8-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXwV/wjG7qQh7E
 arIScbvUKlNrJ7NEjVb/gFwlfWzKVEtLjT7eFTukQuuRIRao5c7jrFtKJR95zb/3a/A5rQ70P4R
 C6C9BDYCNkNr7ZQWBEL/NzWQfYRYc8w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX/KA+OeSlatgV
 GstzmfAWauWshqt9n8LY5jiRBPKLArG6phsMjJTmeAPMvu4VV6c2oofHjtTrz7sD5nifJU8CLVI
 3q/oPD7iTKrOklt2FDJGOQvQsQ/H4Yp514+ODD9mllNHdygEe314MpmtATwQib5oQwdCndsUT6d
 guHvo87aH3oFkDSXb1iuFLbJZMzI8YBy/KRv6WolOPfGW1NzY22TiS4ofshmmGk4MBaW/lZUcWX
 ZZlNxYCpMpWbb40IfKhR9imlh0UdkXYlfo/obu1+NlR1QSgRa8xYvOMZ+60ngeYoLZZNplSls26
 qLEOfJXLL7lHOhE+TXecO3iVGbZiGBNWasFUazebEI/1om5hjj4lNSbwbgNEWpt7TfgyYhJ7twR
 nQxO1P++/y2b+776wETms41vdGDvYK1HQxYIM4i+RXiOyBLlykGRNs06AD+jBHlkcFyGyhn7Uq0
 o4sv3uVTFIaqAd2LVaQ==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6acce915 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=G0VRknOCk35oKUKNRGMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: kjJIJ4LGqGkptf9_GjGTah3OttVC6maC
X-Proofpoint-GUID: kjJIJ4LGqGkptf9_GjGTah3OttVC6maC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056
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


>   target/hexagon/common-semi-target.c | 63 ++++++++++++++++++++++++-----
>   target/hexagon/cpu.c                |  2 +
>   target/hexagon/internal.h           |  2 +
>   3 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
> index 210d33e54e2..b97ed6796f8 100644
> --- a/target/hexagon/common-semi-target.c
> +++ b/target/hexagon/common-semi-target.c
> @@ -8,44 +8,89 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "cpu_helper.h"
>   #include "semihosting/common-semi.h"
> +#include "internal.h"
>   
> -uint64_t common_semi_arg(CPUState *cs, int argno)
> +static uint64_t hexagon_semi_arg(CPUState *cs, int argno)
>   {
>       CPUHexagonState *env = cpu_env(cs);
>       return env->gpr[HEX_REG_R00 + argno];
>   }
>   
> -void common_semi_set_ret(CPUState *cs, uint64_t ret)
> +static void hexagon_semi_set_ret(CPUState *cs, uint64_t ret)
>   {
>       CPUHexagonState *env = cpu_env(cs);
>       env->gpr[HEX_REG_R00] = ret;
>   }
>   
> -void common_semi_set_err(CPUState *cs, int err)
> +static void hexagon_semi_set_err(CPUState *cs, int err)
>   {
>       CPUHexagonState *env = cpu_env(cs);
>       env->gpr[HEX_REG_R01] = err;
>   }
>   
> -bool common_semi_sys_exit_is_extended(CPUState *cs)
> +static bool hexagon_semi_is_64bit(CPUState *cs)
>   {
>       return false;
>   }
>   
> +static bool hexagon_semi_sys_exit_is_extended(CPUState *cs)
> +{
> +    return false;
> +}
> +
> +static uint64_t hexagon_semi_stack_bottom(CPUState *cs)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    return env->gpr[HEX_REG_SP];
> +}
> +
> +static bool hexagon_semi_has_synccache(CPUState *cs)
> +{
> +    return false;
> +}
> +
> +const SemihostingCPUOps hexagon_semihosting_ops = {
> +    .arg = hexagon_semi_arg,
> +    .set_ret = hexagon_semi_set_ret,
> +    .set_err = hexagon_semi_set_err,
> +    .is_64bit = hexagon_semi_is_64bit,
> +    .sys_exit_is_extended = hexagon_semi_sys_exit_is_extended,
> +    .stack_bottom = hexagon_semi_stack_bottom,
> +    .has_synccache = hexagon_semi_has_synccache,
> +};
> +
> +uint64_t common_semi_arg(CPUState *cs, int argno)
> +{
> +    return hexagon_semi_arg(cs, argno);
> +}
> +
> +void common_semi_set_ret(CPUState *cs, uint64_t ret)
> +{
> +    hexagon_semi_set_ret(cs, ret);
> +}
> +
> +void common_semi_set_err(CPUState *cs, int err)
> +{
> +    hexagon_semi_set_err(cs, err);
> +}
> +
>   bool is_64bit_semihosting(CPUArchState *env)
>   {
> -    return false;
> +    return hexagon_semi_is_64bit(env_cpu(env));
> +}
> +
> +bool common_semi_sys_exit_is_extended(CPUState *cs)
> +{
> +    return hexagon_semi_sys_exit_is_extended(cs);
>   }
>   
>   uint64_t common_semi_stack_bottom(CPUState *cs)
>   {
> -    CPUHexagonState *env = cpu_env(cs);
> -    return env->gpr[HEX_REG_SP];
> +    return hexagon_semi_stack_bottom(cs);
>   }
>   
>   bool common_semi_has_synccache(CPUArchState *env)
>   {
> -    return false;
> +    return hexagon_semi_has_synccache(env_cpu(env));
>   }
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 1f7d8a8df70..24e39531b95 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -837,6 +837,8 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
>   #ifndef CONFIG_USER_ONLY
>       cc->sysemu_ops = &hexagon_sysemu_ops;
>       dc->vmsd = &vmstate_hexagon_cpu;
> +    /* semihosting is only supported in system mode for Hexagon */
> +    cc->semi_ops = &hexagon_semihosting_ops;
>   #endif
>   #ifdef CONFIG_TCG
>       cc->tcg_ops = &hexagon_tcg_ops;
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 05d1129916e..38eb84f319d 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -30,6 +30,8 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
>   void hexagon_debug(CPUHexagonState *env);
>   void hexagon_dump(CPUHexagonState *env, FILE *f, int flags);
>   
> +extern const struct SemihostingCPUOps hexagon_semihosting_ops;
> +
>   extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
>   #ifndef CONFIG_USER_ONLY
>   extern const char * const hexagon_sregnames[];

