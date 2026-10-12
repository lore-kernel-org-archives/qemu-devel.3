Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF61CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHsi-0000gI-EP; Mon, 12 Oct 2026 11:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGHsd-0000bz-Bd
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:23:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGHsb-0001ER-Kk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:23:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0Wth2252698
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uYJhBKxKrp647X5WvhxR/lgNGjvDyTF5ragrJ/x+nQU=; b=poAQ0bsB6c9RZSIL
 1UTAbWO9P3liEUmCXnjF6zFJiq1DQR8RcF8H8ppbXm0Jd/CR0j+k/CeWhKXf5ON5
 6Rpg7ka8kT8mhwzp6i15cCquvzXrujf/4WjAiv8tkMnn0HjvUVsNreI4V/0wrJPM
 q/j7kZhQqIJVJAamA1ltcz1Rb4iFA05PDhSOew2XbmguOcrA9F1GhS8pmUtQ0kel
 bsFwjSkDCR0y9e6AMiWbZR0U6J5kz5Ksuupk1fniPAsPJS0EEyqCi4yhAJZT0fk1
 xavArUMJhc7QEinjBeZv/GubTP4uHnU/ppJI6Xj8txX7+GOSls2LVLDYmui3tSz8
 ZkoktQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j713p8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:23:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so398341485a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791818636; x=1792423436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uYJhBKxKrp647X5WvhxR/lgNGjvDyTF5ragrJ/x+nQU=;
 b=P3eHOWvhzQqmi13c710+bbx0gFpiGGWdQhmhNGwdG+sK/GBs1VOrEY/DGqhZ4lmZck
 AKf3rMpC6inmCEd+ulKu8sgvUmn5XwDlS29nDaXsDO3v+9xN3rzlstH2y3YPKyO9TyXs
 /izRv4IpDbV1CLNxaeXM60UmPPBIuaXo5T6x40spG9+xP1xSy6A48qTzSsdRKa6a0HKr
 Fcarq9zU36cwN4BN912RcLmm24S1/1cNmCksERDbuEMJm0cAp72Mqd7KSHY2/dvJDmr+
 lGdXuDACqsFf+rz5H1/xGhn0HcSOWAoyi7d3kfN96sT52u78yrlYheNXf/hDC4m9UB/g
 TivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818636; x=1792423436;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uYJhBKxKrp647X5WvhxR/lgNGjvDyTF5ragrJ/x+nQU=;
 b=nGITb8Uos6rV1S5LbE2HSouV9y0Tb+R4f/UuRaXkv/saET6qS99kd4YOHN4Kv/2wp2
 lHr6PV1tI7LHe3YgzSVwp7KSu0OYVjW/22fWUCP3KcQtcUB8MLjnR+z3ixXOEwzvjFAq
 9Um10nOf6RwPKgPm9jlmxdJdOyr83h+n90WZwyDHCdWfrJPaWkSTBWw9gkdc218oR1yL
 LcvSD9lUhk60BLKJ5fwK+VYTsIFM0z8oRANRsJXqNkBnHxq+2ICox+HpnhFwM0+Fj320
 GVkidEY6mJCecY0eCVk6Kj9JGRLLbZV327n4pT/fwXcEmDO3GFJhFM/+c7J0XKJshebf
 +pug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxG53SgVSKlWt7N5u2KiH49cvYE3WTLtdcp3TQaUJXhgUfBHSnvy4dXfOmPybpfLOTA3yBhu5LAKqdw@nongnu.org
X-Gm-Message-State: AFq9FYIdYVxk4cU5oSc4ZelhhgCisAbn0n+bB9OdF3/V+MQfph6Qj1YK
 eGTQ+bMHJ0VjXVjGCLuZm3ujl5aXFG+SSNLnPev35VnI5apJg6peu6ZhUu0hiv4Gus3ejlpFFh/
 UeDkQZhiSIEmHMW+HNiZ4MIm3vDg7UAw/ew2ToVLO4gE2Q/MtwulIQ1yHzg==
X-Gm-Gg: AYBFou30mH03JIsEAHA/EhR1xumvHBJ240lQZX1o8LuDx476mVnBIJLTZTIrCYpMCwM
 Hv/q6KqwyzCUOo/rFVzKkP+Adsjqtb/ZjvBmKb8gGceQuqiKd7oG7THl+ZEUYEhMYrFdIZAFkRR
 NN8vZsr0czIQJgLEDnaY/OhloTZQ7DTVcyuS/wWGwsnb5GIL3NgD648EqXk9fpnpy+lizdSgGfl
 DD3aYqxzJeUskFDLFnofuO6SvgEuXwBtGmKZexc7jDfDAJPnOoLgd+18GuAMkbEhiqzj44Z3cH5
 1IRKq+5XqEcY6BI0SeBOdKP20SERRTZeNiDWYRm87OB0X+MYmm5xM2Y+q6PHkwbH31CzvigqxRd
 eNcdijlnwAqlhp1MwH6sRgFxHKMFkCD38YGcMmOnTPmghT7DulWUThFruUF1p9Jwo
X-Received: by 2002:a05:620a:a0cd:10b0:93e:c12c:f127 with SMTP id
 af79cd13be357-93ec12d079fmr1029278785a.83.1791818635690; 
 Mon, 12 Oct 2026 08:23:55 -0700 (PDT)
X-Received: by 2002:a05:620a:a0cd:10b0:93e:c12c:f127 with SMTP id
 af79cd13be357-93ec12d079fmr1029274785a.83.1791818635098; 
 Mon, 12 Oct 2026 08:23:55 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5086fe3sm8395485a.37.2026.10.12.08.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 08:23:54 -0700 (PDT)
Message-ID: <215ee4da-7c9b-42b0-bba1-3326e69e2130@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 10:23:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] semihosting: remove common_* functions
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-11-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-11-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfXySS2Uf31ZapD
 YDEM5TKjwyGXw/JTQM7fqUeVzUUnRLYmUH9tH/o4e6Kz7f29A0uxW2ELaLiHQI7rjcQ0u4euN4g
 jIDzQ4u88fJDD/8qPClw3KbmrOiq2c8=
X-Proofpoint-GUID: it2seAh5FZLkIn8dJ12S9KFissdPvt4g
X-Proofpoint-ORIG-GUID: it2seAh5FZLkIn8dJ12S9KFissdPvt4g
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6accfb8c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LthiD6cAUoPiOF7c2bgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfXyRSoD3CptJgH
 N9k1j0T/lJPddaEP4YvZtsiAfGkMPG5owQAAXxcdJGqQDNVzal1rdI5gfL/CkGwBj0yDJakBVYg
 o6TIaZ4+BTf8suo3Xa7kRxgBV0AFG5qvrQd4A18Lf90v6fE6Rh5Y0QAHWVx+eY2XuqQM04xt8pA
 y/vqgrA+RDHdSpOcFHx6Fk5iML1jM8ctLkeBWn89kH6cmWGf0EJA55pory9S7hdI2ZDrAvmiD52
 uHa9E5pJdVBToGK74COMPA6NlhGEdVxiLr0KcBj1+Ofh5hg+GlGUjWJddoa1IxifFLjg+x73lYy
 z4Dmw5qw4ALN01vDJPVadldfETngV8T06eVD/7tvAg/MnBX5PrD+k8lvhKppxoHoHqNt0LawVKC
 RxaWeh0ObO32KLip4znzF9vU50lHRVYU0tBMmT+bi5acI15exBydTjioIbwx49tpwN5N0buPm39
 hkT3+l6dzuZ0fnf4Lkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120061
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
> Now that both targets and semihosting implementation both use the
> semihosting ops interface, we can remove all common_* functions.
> This allows us to link together the three targets concerned: arm,
> hexagon and riscv.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   include/semihosting/common-semi.h   |  7 ------
>   target/arm/common-semi-target.c     | 35 -----------------------------
>   target/hexagon/common-semi-target.c | 35 -----------------------------
>   target/riscv/common-semi-target.c   | 35 -----------------------------
>   4 files changed, 112 deletions(-)
>
> diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
> index 618f60f76e7..8875aec3c86 100644
> --- a/include/semihosting/common-semi.h
> +++ b/include/semihosting/common-semi.h
> @@ -53,12 +53,5 @@ typedef struct SemihostingCPUOps {
>   
>   void common_semi_cb(CPUState *cs, uint64_t ret, int err);
>   void do_common_semihosting(CPUState *cs);
> -uint64_t common_semi_arg(CPUState *cs, int argno);
> -void common_semi_set_ret(CPUState *cs, uint64_t ret);
> -void common_semi_set_err(CPUState *cs, int err);
> -bool is_64bit_semihosting(CPUArchState *env);
> -bool common_semi_sys_exit_is_extended(CPUState *cs);
> -uint64_t common_semi_stack_bottom(CPUState *cs);
> -bool common_semi_has_synccache(CPUArchState *env);
>   
>   #endif /* COMMON_SEMI_H */
> diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
> index 5263c0435a8..aa5190ee16c 100644
> --- a/target/arm/common-semi-target.c
> +++ b/target/arm/common-semi-target.c
> @@ -71,38 +71,3 @@ const SemihostingCPUOps arm_semihosting_ops = {
>       .stack_bottom = arm_semi_stack_bottom,
>       .has_synccache = arm_semi_has_synccache,
>   };
> -
> -uint64_t common_semi_arg(CPUState *cs, int argno)
> -{
> -    return arm_semi_arg(cs, argno);
> -}
> -
> -void common_semi_set_ret(CPUState *cs, uint64_t ret)
> -{
> -    arm_semi_set_ret(cs, ret);
> -}
> -
> -void common_semi_set_err(CPUState *cs, int err)
> -{
> -    arm_semi_set_err(cs, err);
> -}
> -
> -bool is_64bit_semihosting(CPUArchState *env)
> -{
> -    return arm_semi_is_64bit(env_cpu(env));
> -}
> -
> -bool common_semi_sys_exit_is_extended(CPUState *cs)
> -{
> -    return arm_semi_sys_exit_is_extended(cs);
> -}
> -
> -uint64_t common_semi_stack_bottom(CPUState *cs)
> -{
> -    return arm_semi_stack_bottom(cs);
> -}
> -
> -bool common_semi_has_synccache(CPUArchState *env)
> -{
> -    return arm_semi_has_synccache(env_cpu(env));
> -}
> diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
> index b97ed6796f8..0a33b872e3a 100644
> --- a/target/hexagon/common-semi-target.c
> +++ b/target/hexagon/common-semi-target.c
> @@ -59,38 +59,3 @@ const SemihostingCPUOps hexagon_semihosting_ops = {
>       .stack_bottom = hexagon_semi_stack_bottom,
>       .has_synccache = hexagon_semi_has_synccache,
>   };
> -
> -uint64_t common_semi_arg(CPUState *cs, int argno)
> -{
> -    return hexagon_semi_arg(cs, argno);
> -}
> -
> -void common_semi_set_ret(CPUState *cs, uint64_t ret)
> -{
> -    hexagon_semi_set_ret(cs, ret);
> -}
> -
> -void common_semi_set_err(CPUState *cs, int err)
> -{
> -    hexagon_semi_set_err(cs, err);
> -}
> -
> -bool is_64bit_semihosting(CPUArchState *env)
> -{
> -    return hexagon_semi_is_64bit(env_cpu(env));
> -}
> -
> -bool common_semi_sys_exit_is_extended(CPUState *cs)
> -{
> -    return hexagon_semi_sys_exit_is_extended(cs);
> -}
> -
> -uint64_t common_semi_stack_bottom(CPUState *cs)
> -{
> -    return hexagon_semi_stack_bottom(cs);
> -}
> -
> -bool common_semi_has_synccache(CPUArchState *env)
> -{
> -    return hexagon_semi_has_synccache(env_cpu(env));
> -}
> diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
> index 7fa3bef6883..24c42254558 100644
> --- a/target/riscv/common-semi-target.c
> +++ b/target/riscv/common-semi-target.c
> @@ -62,38 +62,3 @@ const SemihostingCPUOps riscv_semihosting_ops = {
>       .stack_bottom = riscv_semi_stack_bottom,
>       .has_synccache = riscv_semi_has_synccache,
>   };
> -
> -uint64_t common_semi_arg(CPUState *cs, int argno)
> -{
> -    return riscv_semi_arg(cs, argno);
> -}
> -
> -void common_semi_set_ret(CPUState *cs, uint64_t ret)
> -{
> -    riscv_semi_set_ret(cs, ret);
> -}
> -
> -void common_semi_set_err(CPUState *cs, int err)
> -{
> -    riscv_semi_set_err(cs, err);
> -}
> -
> -bool is_64bit_semihosting(CPUArchState *env)
> -{
> -    return riscv_semi_is_64bit(env_cpu(env));
> -}
> -
> -bool common_semi_sys_exit_is_extended(CPUState *cs)
> -{
> -    return riscv_semi_sys_exit_is_extended(cs);
> -}
> -
> -uint64_t common_semi_stack_bottom(CPUState *cs)
> -{
> -    return riscv_semi_stack_bottom(cs);
> -}
> -
> -bool common_semi_has_synccache(CPUArchState *env)
> -{
> -    return riscv_semi_has_synccache(env_cpu(env));
> -}

