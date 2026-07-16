Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E862C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTK9-0004GM-J2; Thu, 16 Jul 2026 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkTK7-0004Fz-Hb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:08:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkTK4-00029v-W2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:08:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJohGT3626983
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 16bsJRfm+Uuf12oJWrKrh8BJaDhtshRqeudND0AZKkc=; b=HU3OtEaUUL7M85U1
 pzr5OLo8evFEFRXswRs0UIioErJF/zWKttbHCOeKw2b8mIJtC/1AB76vn2a09B7k
 iuH04fL6KcP0sFd/aFM2h050suSHr3X1MzC2LUwSaPmY2ss24FJIdDKI61XBRFEG
 dYrhC4az0iQWKmOt/Dbolj/bOaequp8e50YeeAtmqw3gDv+y9Hk9cVMurBZH6ymy
 E7unimwUtDmK8P7cHY7qyv1XtWo6V8gue2Cu8wmvUyN9KyKnvbz5K9cjDw4KJvF6
 vpYO4JyLDqlMQY0sjM8RN/nnXXot8ZARFtIe05tqE8HQoNMvGY2JsrXwX7ntKEla
 xSTyHw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv319c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:08:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so51705841cf.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 14:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784236127; x=1784840927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=16bsJRfm+Uuf12oJWrKrh8BJaDhtshRqeudND0AZKkc=;
 b=c7mcbX0Ym0ya/WgtOKhsXq54/a+Onn2eIAzvLZ9ILhcV2tveMv74Uxkw0MXbZ0s8M0
 sZ8JhPO5Jo+Pj9gkuok/mmQuq1AigPdxpRgzYcoedcB6wn0DBzwZFne4rbkhNeZ0zoxO
 0ofCOcPkJbWWgTA9Ft07NwDn4ql7paQkZQubWIL8WgdkVSyTLGM8YgtLObtP/qxpm/d9
 kNrIGA1p9KoCqAiz2WGgKJ9aGOULuHOMJXtCgQUCtqO6MDNl3mGAt8+LRwFMckvz2ANL
 CW2xIzA7MsoGWqa/CypC2puBRf3bK9JOPSd8VAPIcjBeesjdUrPtN9/EHBUQHrJN2AeE
 sFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784236127; x=1784840927;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=16bsJRfm+Uuf12oJWrKrh8BJaDhtshRqeudND0AZKkc=;
 b=ALsD8ehhd1WHpJWuiu5PFx01JuKq0thyFdrteUfEouJdccbPxIgrSplwf1kvWzOkGj
 0DD8709tMmGNkiwHF3D6kqQ+y/VC0JcOr5Tj1ak3/G2MEN6WksQdjt2yM5y0tsZx25in
 vkl++ykFv98uIkw0jXqgFkejL9zXqLu9FkhDfg9NsQrVMGceLHippaZeeVgOWF4MTIAR
 OsvLrpXrNTMM7gYzqtfCr6Uu/gLcPf7/tlZcNyUGHJVuXbPfMokPahBoYnHOoYNCKXeU
 s0DKOkdcGDKCvvSL5l+ZiiK4L+CEqDAnErvvv0fXGP9tvDHWGCkD42c/DGFOQe3DEm5u
 oOHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDsrcNF7fPMtm9iok99cgkhOrjm6LUYpCHkFav2OJbhmdzdooO1Lhp738dfykd80rrRycQ9U4y8WIS@nongnu.org
X-Gm-Message-State: AOJu0Yx/gTlWO9iVIFxynljKRZI8MDdo3b6zJ/CPpiwS/GjMnUE9VSte
 rOMwuiqoCBSF3s2irpF+qbeQ1pCBAXHySCdlL4/U/5FmEwb80jsjDYA6tNK6M95KqC9HzMhMVaA
 hg+ET50qnCzrTPyPYngBoDWCLCEYi6DdcHyq0mcVC6i5iBV4fwkwuowJYZw==
X-Gm-Gg: AfdE7cmuTstRTJgQoE3YVMM4zIUsDiM43L9etDV5XxPYYZNhv+VyTrZ5uSWlxGaoodq
 6ykvDYP95dQ1NO52vrc2FOpYElfCw+EIN2i/FmUcy9kHEoQqdYS1qStvHkAw6KNRE5kz25gKym6
 LuRO1gOKA7WnsDKmCX0nILGrj/zER9JGnF+9wBiy0KtstKSaILU9rcszyIxIFEU/e6iQwihng00
 77xNjUTi9IyPADzJVR/B4cbjFrCBt5mIXbhvLnRKasKyakMxtzxBY6L0+EwotRQV1rgdlvDC+EB
 jn52Xe1irpu7gbhEOcXH52lH0itM2pmRb2SBd9elLa5fdVwf/yPFE6kUJJGMaL/6BAR7Ou7DtOh
 Y1OzWkmdU+7g1ftEDOnje0YukRn8O6VDZ8FY9VicSMDQtKPbsWKoahuWtuFt6pmgy
X-Received: by 2002:a05:622a:4291:b0:516:df59:32cf with SMTP id
 d75a77b69052e-520bb76149bmr14150031cf.7.1784236126492; 
 Thu, 16 Jul 2026 14:08:46 -0700 (PDT)
X-Received: by 2002:a05:622a:4291:b0:516:df59:32cf with SMTP id
 d75a77b69052e-520bb76149bmr14149501cf.7.1784236125798; 
 Thu, 16 Jul 2026 14:08:45 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51fca094208sm19460581cf.10.2026.07.16.14.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 14:08:44 -0700 (PDT)
Message-ID: <3cd3a419-ee2c-4d7a-9396-60eab8d26908@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 16:08:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] target/hexagon: add semihosting support
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
 <5c5c06f35f798a87ffd29419ae1bfd346957daca.1784225209.git.matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <5c5c06f35f798a87ffd29419ae1bfd346957daca.1784225209.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxNSBTYWx0ZWRfX6fiGA9HFsYxl
 WCGzvP/azYGkFw7JA8fHURarEQfdT0p/cYTFOWC6X0GEfg18HTt/tS2Tjw0pm1p8B25XX2D6z/o
 PwF6QndHCteOqfzL7uwMell95GqtPKbYqXHhul0elzkqP+XR+nwDlHJcH72CHC6w7X3gfgOZgxE
 yOcAbNHEbjR5gyzus1sjazsLe2eWvxOT+JMH9obUey7wwU9jSANA/ZO1AoU5NoV2LdeOLrhssEj
 Coeo6n84quaJXzuto/6grFMfZtBY2vs+XeXaotcmcf5cAoyXxgCo/Cs0zo4vZ84OPSdh9RtNUeI
 MYDG6ihWBG2JW47ab0BKVF5+6u7tQYm6oKQ6xGJlnHn8I/V5J8fzwK+vdFgRIU2x3XkBVN8o/O7
 pPFjMjn1kPW2ljC5O0HIcBONHnhfj/egRePEJKwqudl/3kV20gXmUfbXwQtNcFdwHJbI5iFQALc
 PWzDpRZJz1KqZAZWKFQ==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a59485f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=cusfn0aTb8E9U8-I2egA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: bzlr5ZbPsT4_TbQG0vhZYQg5KKbhW4T0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxNSBTYWx0ZWRfX0+XGAYkHMg8x
 SAvevDvk2BxRqJaG7NlGjtSMRrBJgBIG1yfgbtyuqtTulKlB2szckluDPy7RnLgujwYIbboMPgk
 4Gc3vRkFmqEoBiBSTtUoYVyKQp4uqEQ=
X-Proofpoint-ORIG-GUID: bzlr5ZbPsT4_TbQG0vhZYQg5KKbhW4T0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160215
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


On 7/16/2026 1:06 PM, Matheus Tavares Bernardino wrote:
> Baremetal Hexagon programs use trap0 #0 to invoke
> semihosting calls for I/O and process control.  Wire up the
> arm-compatible semihosting framework for softmmu by enabling
> CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
> semihosting handler.
>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   docs/system/target-hexagon.rst      |   8 +-
>   configs/targets/hexagon-softmmu.mak |   2 +
>   hw/hexagon/hexagon_dsp.c            |   2 +
>   target/hexagon/common-semi-target.c |  51 +++++++++
>   target/hexagon/hexswi.c             | 167 +++++++++++++++++++++++++++-
>   hw/hexagon/Kconfig                  |   1 +
>   qemu-options.hx                     |   8 +-
>   target/hexagon/meson.build          |   3 +
>   8 files changed, 232 insertions(+), 10 deletions(-)
>   create mode 100644 target/hexagon/common-semi-target.c
>
> diff --git a/docs/system/target-hexagon.rst b/docs/system/target-hexagon.rst
> index 416b8f7be76..36115137626 100644
> --- a/docs/system/target-hexagon.rst
> +++ b/docs/system/target-hexagon.rst
> @@ -91,9 +91,11 @@ Semihosting
>   -----------
>   Hexagon supports a semihosting interface similar to other architectures'.
>   The ``trap0`` instruction can activate these semihosting calls so that the
> -guest software can access the host console and filesystem.  Semihosting
> -is not yet implemented in QEMU hexagon.
> -
> +guest software can access the host console and filesystem. Read the
> +`Hexagon Semihosting Specification
> +<https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html>`__
> +for details. Semihosting is enabled on qemu-system-hexagon machines by default,

It's enabled on most of them, but not `virt`.  So probably mention that 
exception or just describe it as being enabled on the "hexagon-sim-style 
machines"?


> +and it can be configured through ``-semihosting-config``.
>   
>   Hexagon Features
>   ================
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> index a77c100f0c5..6cbdc64be56 100644
> --- a/configs/targets/hexagon-softmmu.mak
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -6,3 +6,5 @@ TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
>   TARGET_NEED_FDT=y
> +CONFIG_SEMIHOSTING=y
> +CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index aa493993229..315733cded3 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -27,6 +27,7 @@
>   #include "target/hexagon/internal.h"
>   #include "system/physmem.h"
>   #include "system/reset.h"
> +#include "semihosting/semihost.h"
>   
>   #include "machine_cfg_v66g_1024.h.inc"
>   
> @@ -178,6 +179,7 @@ static void init_mc(MachineClass *mc)
>       mc->no_serial = 1;
>       mc->is_default = false;
>       mc->max_cpus = 8;
> +    qemu_semihosting_enable();
>   }
>   
>   /* ----------------------------------------------------------------- */
> diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
> new file mode 100644
> index 00000000000..9a7720514bb
> --- /dev/null
> +++ b/target/hexagon/common-semi-target.c
> @@ -0,0 +1,51 @@
> +/*
> + * Target-specific parts of semihosting/arm-compat-semi.c.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_helper.h"
> +#include "semihosting/common-semi.h"
> +
> +uint64_t common_semi_arg(CPUState *cs, int argno)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    return arch_get_thread_reg(env, HEX_REG_R00 + argno);
> +}
> +
> +void common_semi_set_ret(CPUState *cs, uint64_t ret)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    arch_set_thread_reg(env, HEX_REG_R00, ret);
> +}
> +
> +void common_semi_set_err(CPUState *cs, int err)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    arch_set_thread_reg(env, HEX_REG_R01, err);
> +}
> +
> +bool common_semi_sys_exit_is_extended(CPUState *cs)
> +{
> +    return false;
> +}
> +
> +bool is_64bit_semihosting(CPUArchState *env)
> +{
> +    return false;
> +}
> +
> +uint64_t common_semi_stack_bottom(CPUState *cs)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    return arch_get_thread_reg(env, HEX_REG_SP);
> +}
> +
> +bool common_semi_has_synccache(CPUArchState *env)
> +{
> +    return false;
> +}
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index 43c373ea2ee..2aedd8368e2 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -24,9 +24,171 @@
>   #error "This file is only used in system emulation"
>   #endif
>   
> +#include "semihosting/common-semi.h"
> +#include "semihosting/console.h"
> +#include "semihosting/syscalls.h"
> +#include "semihosting/guestfd.h"
> +#include "system/runstate.h"
> +
> +/* non-arm-compatible semihosting calls */
> +#define HEXAGON_SPECIFIC_SWI_FLAGS \
> +    DEF_SWI_FLAG(OPEN,             0x01) \
> +    DEF_SWI_FLAG(ISTTY,            0x09) \
> +    DEF_SWI_FLAG(HEAPINFO,         0x16) \
> +    DEF_SWI_FLAG(EXCEPTION,        0x18) \
> +    DEF_SWI_FLAG(SEEK,             0x0A) \
> +    DEF_SWI_FLAG(READ_CYCLES,      0x40) \
> +    DEF_SWI_FLAG(PROF_ON,          0x41) \
> +    DEF_SWI_FLAG(PROF_OFF,         0x42) \
> +    DEF_SWI_FLAG(WRITECREG,        0x43) \
> +    DEF_SWI_FLAG(READ_TCYCLES,     0x44) \
> +    DEF_SWI_FLAG(LOG_EVENT,        0x45) \
> +    DEF_SWI_FLAG(REDRAW,           0x46) \
> +    DEF_SWI_FLAG(READ_ICOUNT,      0x47) \
> +    DEF_SWI_FLAG(PROF_STATSRESET,  0x48) \
> +    DEF_SWI_FLAG(DUMP_PMU_STATS,   0x4a) \
> +    DEF_SWI_FLAG(READ_PCYCLES,     0x52) \
> +    DEF_SWI_FLAG(COREDUMP,         0xCD) \
> +    DEF_SWI_FLAG(FTELL,            0x100) \
> +    DEF_SWI_FLAG(FSTAT,            0x101) \
> +    DEF_SWI_FLAG(STAT,             0x103) \
> +    DEF_SWI_FLAG(GETCWD,           0x104) \
> +    DEF_SWI_FLAG(ACCESS,           0x105) \
> +    DEF_SWI_FLAG(OPENDIR,          0x180) \
> +    DEF_SWI_FLAG(CLOSEDIR,         0x181) \
> +    DEF_SWI_FLAG(READDIR,          0x182) \
> +    DEF_SWI_FLAG(EXEC,             0x185) \
> +    DEF_SWI_FLAG(FTRUNC,           0x186)
> +
> +/*
> + * We use the arm-compatible semihosting routines for these ones, but we do
> + * need some hexagon-specific preprocessing.
> + */
> +#define HEX_SYS_WRITE       0x05
> +#define HEX_SYS_READ        0x06
> +#define HEX_SYS_READC       0x07
> +
> +#define DEF_SWI_FLAG(name, val) HEX_SYS_ ##name = val,
> +enum hex_swi_flag {
> +    HEXAGON_SPECIFIC_SWI_FLAGS
> +};
> +#undef DEF_SWI_FLAG
> +
> +#define DEF_SWI_FLAG(_, val) case val:
> +static inline bool is_hexagon_specific_swi_flag(enum hex_swi_flag what_swi)
> +{
> +    switch (what_swi) {
> +    HEXAGON_SPECIFIC_SWI_FLAGS
> +        return true;
> +    }
> +    return false;
> +}
> +#undef DEF_SWI_FLAG
> +
> +static void init_semihosting_guestfds(void)
> +{
> +    static gsize initialized;
> +
> +    if (g_once_init_enter(&initialized)) {
> +        if (qemu_semihosting_console_has_chardev()) {
> +            alloc_guestfd();
> +            console_guestfd(0);
> +            alloc_guestfd();
> +            console_guestfd(1);
> +            alloc_guestfd();
> +            console_guestfd(2);
> +        } else {
> +            alloc_guestfd();
> +            associate_guestfd(0, 0);
> +            alloc_guestfd();
> +            associate_guestfd(1, 1);
> +            alloc_guestfd();
> +            associate_guestfd(2, 2);
> +        }
> +        g_once_init_leave(&initialized, 1);
> +    }
> +}
> +
> +static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
> +{
> +    uint32_t addr, count;
> +    uintptr_t retaddr = 0;
> +
> +    hexagon_read_memory(env, swi_info + 4, 4, &addr, retaddr);
> +    hexagon_read_memory(env, swi_info + 8, 4, &count, retaddr);
> +    hexagon_peek_memory_range(env, addr, count, retaddr);
> +}
> +
> +static void sim_handle_trap0(CPUHexagonState *env)
> +{
> +    target_ulong what_swi, swi_info;
> +    CPUState *cs = env_cpu(env);
> +
> +    g_assert(bql_locked());
> +    init_semihosting_guestfds();
> +
> +    what_swi = arch_get_thread_reg(env, HEX_REG_R00);
> +    swi_info = arch_get_thread_reg(env, HEX_REG_R01);
> +
> +    qemu_log_mask(CPU_LOG_INT,
> +                  "sim_handle_trap0: swi=0x%" PRIx32
> +                  " info=0x%" PRIx32 " PC=0x%" PRIx32
> +                  " thread=%" PRId32 "\n",
> +                  (uint32_t)what_swi, (uint32_t)swi_info,
> +                  (uint32_t)arch_get_thread_reg(env, HEX_REG_PC),
> +                  (uint32_t)env->threadId);
> +
> +    if (!is_hexagon_specific_swi_flag(what_swi)) {
> +        if (what_swi == HEX_SYS_READ || what_swi == HEX_SYS_READC ||
> +            what_swi == HEX_SYS_WRITE) {
> +            /*
> +             * Avoid page faults if the buffer is not in memory yet.
> +             * NOTE: Counterintuitive, but a WRITE must be able to LOAD from
> +             * the input address. The contents of that buffer will be
> +             * directed to the SWI interface.
> +             */
> +            do_preload(env, swi_info, (what_swi == HEX_SYS_WRITE));
> +        }
> +        /*
> +         * ARM-compat semihosting SWI numbers are all <= 0x31.
> +         * If R0 holds a value outside that range (e.g. guest code
> +         * executing trap0(#0) with an arbitrary R0), treat it as an
> +         * unrecognized request rather than forwarding to
> +         * do_common_semihosting() which would abort.
> +         */
> +        if (what_swi > 0x31) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trap0(#0): unrecognized request in r0: "
> +                          "0x" TARGET_FMT_lx "\n", what_swi);
> +            return;
> +        }
> +        do_common_semihosting(cs);
> +        return;
> +    }
> +
> +    switch (what_swi) {
> +
> +    case HEX_SYS_EXCEPTION:
> +    {
> +        uint32_t ret = arch_get_thread_reg(env, HEX_REG_R02);
> +        arch_set_system_reg(env, HEX_SREG_MODECTL, 0);
> +        gdb_exit(ret);
> +        exit(ret);
> +    }
> +    break;
> +
> +    /* TODO: implement other hexagon-specific semihosting calls */
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "unknown swi request: 0x%" PRIx32 "\n",
> +                      (uint32_t)what_swi);
> +        common_semi_cb(cs, -1, ENOSYS);
> +    }
> +}
> +
>   static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
>                             uint32_t exception_index)
> -
>   {
>       HexagonCPU *cpu = env_archcpu(env);
>       uint32_t evb = cpu->globalregs ?
> @@ -95,8 +257,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
>       switch (cs->exception_index) {
>       case HEX_EVENT_TRAP0:
>           if (env->cause_code == 0) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "trap0 is unhandled, no semihosting available\n");
> +            sim_handle_trap0(env);
>           }
>   
>           hexagon_ssr_set_cause(env, env->cause_code);
> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> index 52065ab3b22..3a8ff17812b 100644
> --- a/hw/hexagon/Kconfig
> +++ b/hw/hexagon/Kconfig
> @@ -2,6 +2,7 @@ config HEX_DSP
>       bool
>       default y
>       depends on HEXAGON
> +    select ARM_COMPATIBLE_SEMIHOSTING
>   
>   config HEX_VIRT
>       bool
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 34970fffc94..56f42b02c8a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5507,7 +5507,7 @@ ERST
>   DEF("semihosting", 0, QEMU_OPTION_semihosting,
>       "-semihosting    semihosting mode\n",
>       QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
> -    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
> +    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_HEXAGON)
>   SRST
>   ``-semihosting``
>       Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, RISC-V only).
> @@ -5523,11 +5523,11 @@ DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
>       "-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]\n" \
>       "                semihosting configuration\n",
>   QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
> -QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
> +QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_HEXAGON)
>   SRST
>   ``-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]``
> -    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V
> -    only).
> +    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V,
> +    Hexagon only).
>   
>       .. warning::
>         Note that this allows guest direct access to the host filesystem, so
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 59cb09c1070..69f01bd2f70 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -262,6 +262,9 @@ hexagon_softmmu_ss.add(files(
>       'machine.c',
>   ))
>   
> +hexagon_softmmu_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
> +                       if_true: files('common-semi-target.c'))
> +
>   #
>   # Step 4.5
>   # We use flex/bison based idef-parser to generate TCG code for a lot

