Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F31C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZmp-00024v-Bn; Tue, 14 Jul 2026 05:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wjZmn-00023P-Pl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:50:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wjZmi-00035c-9o
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:50:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SYVo3954663
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /9jRxHddWr5/69MwxIKP3gBixQB7Iwg53DvuHHUn6gk=; b=f6B07DamNdb9Opm1
 xvMCLDTokXjakwYkRCa2KHDla6l8YQ35dFO9He1jpQyIT86sx4hAGkvzNr91DSwl
 aBIIhCeTnNPjsKKsfBjYnKNcrvAPpGQH+EEUwprcbSC8aQi+r3xoQLJklxHXADDM
 G3hp5RTu84/9ZnsdORUn7jCt+u1/xwKc4rVBqndicoaCoPJQacAc7Gndohw9HyLe
 wlhFoSxk0SFbd6f99Tc1XSJblN0kJT0OQ3NAxErouthNu9Il4CWibUcSCW6+TJul
 Hs/q1Z3A70rvW5YTctpq+ZZbMSiSb+r1lTrMD7YySeaFleaEq4jUnNMVhXq2bMwV
 S5slqA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ju690-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:50:28 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81e67e87752so10915537b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022628; x=1784627428; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/9jRxHddWr5/69MwxIKP3gBixQB7Iwg53DvuHHUn6gk=;
 b=a6zCOmleA+Vq2jt6Z/Ktl8FHkUrIpNDfbF001M2TyTNvk8qTdrETaZZqGGBClKfNcB
 HNWztRUvV0IF0ESqNzB9Y5Z8YPoYpYAwWReif2u8SRqCr4Shj293cWV4WtEmQop1FUtl
 vIPZ9rtxryZI1We4DeeiXEIYuRCSySITHZA1+Q0sRJCeZeE9FV6ieboJhySk3rnw9fBr
 E3LruQLVF9Z4Tj9gwtWUOfrOm9U0e/rduSnhO24TLqsnHe3RCRzvR8Je840DL/rXT0ym
 GjRIv+rx672zuR7LLS8RMWMzVKpTMUIC0G7GFJK4ofbDWHsIubzBG5+foM1iqdLUt6Qd
 0PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022628; x=1784627428;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/9jRxHddWr5/69MwxIKP3gBixQB7Iwg53DvuHHUn6gk=;
 b=TOl5zmNh6IgTrdeGLLF+wzZNGOF1xdtr8+Q+0pOmp8Ssl9KrsGZizBFPTAXAwcZsXD
 xhmt/G7vYsBJ2U6sBpwKq99yrMO796bv4MYkm3I/KRLhxRgkSDzL/0LDIfyLuIPZYHzN
 NETI50mVp7xkiDXCAnTW5VHIiNs2XEQ7iMmGrQXWWcyyNxFk3jlP16FPsCBfvg2W5wZQ
 EAthS0bukmy2Z71JpZxLp6bhXJoToenOD2ntpNfYb5SYA13467Cmik9FqOpuMN82SHD0
 fZo3BE+/5BQelqzbDYycL+SVn520PkBRknSceNADe1L9JOsFkDJONnZwt5r/k3OwZQ+4
 pNPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQBrPTSPSPoZSWmtr3YNs7tvQBHd5LLoOHY8nSTt8uAcpeu7EZPeFvPTk5kI2XIBTohFucLu/cS2CZ@nongnu.org
X-Gm-Message-State: AOJu0YxRR8eBwSr7srJvlFy6nAjJDibyNscZjNo/yxyZrSx+pOiPVZ86
 2Y0Dc0VZPwHMPc9Dii8sJBc3wBB3oAG9jirB5zfA2zBe0w/WpcmuWA833RWIrLdpZelK6R4JH4i
 4GXyzyDImDJcyoQvcSWNeYZUpZKDxGIp5jspzPURON0qOYaAZ0nmLKFcH4w==
X-Gm-Gg: AfdE7ckAFiwlg0UZRIgi5ULVPoPGKywNZHJvrsp0Pj0bq3/9G5D1EZol0O8m6J5dUVv
 UxVez8GdW20hl8wuFL/3GoTnQipDwCezYmeDVuHDgLW1CInPmNpP8a13BnO4M5JxsIH7yyzGPr/
 bnStlFGj+toZJZH2ioG6vrFJaoomm4KCu51qSU9UmYgwiHo6l76KhV5hz9uNvT9f8aiUpQNNwZk
 aguIlFjMfckWVhhuxRqVz5VibJsH23HOBcPguQCcRxD6A9xRSkS4upUE+zY1ps4bNL9VPMPPpGC
 1OJrFxv4H2XdUGHSohq7l9YiaS1kOvW+mhtYR10n+QnmZP1jwup8OnXOm+DmnrAdubHUMbqufIe
 kq8SQwTjHRRd/PahRR/RXrbo56T6C1uA1lRNDPizQxAPo
X-Received: by 2002:a05:690c:9a8d:b0:80d:f9bb:3d3c with SMTP id
 00721157ae682-81e90139c81mr89895137b3.36.1784022627952; 
 Tue, 14 Jul 2026 02:50:27 -0700 (PDT)
X-Received: by 2002:a05:690c:9a8d:b0:80d:f9bb:3d3c with SMTP id
 00721157ae682-81e90139c81mr89894917b3.36.1784022627451; 
 Tue, 14 Jul 2026 02:50:27 -0700 (PDT)
Received: from [192.168.68.105] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6bc4285asm137628877b3.0.2026.07.14.02.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:50:26 -0700 (PDT)
Message-ID: <fa72c68a-141e-4b8a-9445-4131dd83f353@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 06:50:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] semihosting: add callback to set error
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <df1607f5ee373a1ecaa6f88bb56fc64101d818f8.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <df1607f5ee373a1ecaa6f88bb56fc64101d818f8.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mYXV8ZVwLF8B-QC9dfk8qVkdivRksyHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMiBTYWx0ZWRfX6fYuUp/GYYue
 VfLPG8l584mq7bFLDgF7IMhNm5aWQH5SRfz61oLJuE5//KSUPsffXlCxn3QUcEOwDF4Clm2G3Rg
 y7o4dnyDHnhhE2QvB7R+bT6m+isFGGa22PsbPxK06WnbbQRcAcgoH6FIbsLhTwcrd9IAfE8xLmh
 LgxqxI+GUhcTO8AJgwDzfoqdZC0BQBZTvMwZcssdYtYqint+FSTB60eGsYSwhF0j9VAhBFg3Y63
 7A1L4SfODVB78J2kFzeHQU7R5QctlJQbWjrVR6Kl0mQ2xqitpKBX8yphI15D55z3nIP6nQRE2c7
 OBacGLgA9aNApitXrn6yM/YHBfLAbvR1v/chZn2HCjwBgDfXic9L6Ol7lrkDmSm6Nn7TvVrVJUw
 Sv3giHUt7LzjSKZNSB6qZJcYqvDnAUbfCxNsX2B9L6adbGEVyfR6wj/NV6utqhn6zaGa5V3axI1
 8uH0QfOJZ3bI8fLy+Cw==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a560664 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=kPOZBpqBqiv7Ng3vFtoA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: mYXV8ZVwLF8B-QC9dfk8qVkdivRksyHY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMiBTYWx0ZWRfX7yfy08nCc8VF
 nBiI2TpUfsf8pLXPpeaLDZUZSy/i3xfsYmcrmfx5Ke7ifvJ88nQ2Nruim1CZdoLGfuRuNcK+IjV
 qoEabORcFIvvU+oHJaf7Tec0IZLrpvk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140102
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/13/2026 5:07 PM, Matheus Tavares Bernardino wrote:
> This is currently unused by existing semihosting targets, but it will be
> used by hexagon.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---

I suggest making it patch 06 in the series, right before you use in patch 7.  You
can even mention "next patch will use it" in the commit msg for extra clarity.

As for the code:

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/semihosting/common-semi.h | 1 +
>   semihosting/arm-compat-semi.c     | 1 +
>   target/arm/common-semi-target.c   | 4 ++++
>   target/riscv/common-semi-target.c | 4 ++++
>   4 files changed, 10 insertions(+)
> 
> diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
> index aa511a46f42..a11905ef4ef 100644
> --- a/include/semihosting/common-semi.h
> +++ b/include/semihosting/common-semi.h
> @@ -37,6 +37,7 @@
>   void do_common_semihosting(CPUState *cs);
>   uint64_t common_semi_arg(CPUState *cs, int argno);
>   void common_semi_set_ret(CPUState *cs, uint64_t ret);
> +void common_semi_set_err(CPUState *cs, int err);
>   bool is_64bit_semihosting(CPUArchState *env);
>   bool common_semi_sys_exit_is_extended(CPUState *cs);
>   uint64_t common_semi_stack_bottom(CPUState *cs);
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index 5e5f181b908..c54753f696f 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -237,6 +237,7 @@ static void common_semi_cb(CPUState *cs, uint64_t ret, int err)
>           ts->swi_errno = err;
>   #else
>           syscall_err = err;
> +        common_semi_set_err(cs, err);
>   #endif
>       }
>       common_semi_set_ret(cs, ret);
> diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
> index 2b77ce9c17b..38d52deb3d6 100644
> --- a/target/arm/common-semi-target.c
> +++ b/target/arm/common-semi-target.c
> @@ -34,6 +34,10 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
>       }
>   }
>   
> +void common_semi_set_err(CPUState *cs, int err)
> +{
> +}
> +
>   bool common_semi_sys_exit_is_extended(CPUState *cs)
>   {
>       return is_a64(cpu_env(cs));
> diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
> index aeaeb88d536..38a00e160c3 100644
> --- a/target/riscv/common-semi-target.c
> +++ b/target/riscv/common-semi-target.c
> @@ -26,6 +26,10 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
>       env->gpr[xA0] = ret;
>   }
>   
> +void common_semi_set_err(CPUState *cs, int err)
> +{
> +}
> +
>   bool is_64bit_semihosting(CPUArchState *env)
>   {
>       return riscv_cpu_mxl(env) != MXL_RV32;


