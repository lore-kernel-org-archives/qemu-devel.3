Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A99C5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtGMo-00060o-8T; Sun, 09 Aug 2026 23:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGMn-00060c-JC
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 23:07:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGMl-0006e2-MP
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 23:07:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L8ZB63479214
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8tddyuzEij5AhjOGwaKoRoKe1Fz5djJ6nu04Sr2I2fc=; b=jkt1rQCjgxgB0I7X
 z3LNAiypaxZfkDYJZzjKllLUfgIsPVW0KX8mh+McatijnYu2q2qcAdFqjQIWnfFH
 0m1hFg/42mCq0Z5Pkw8tn3w3BwdIFo8xK3EusqrE29aocIOyi2Enc0n6JEO5B106
 ZusVwobCyfyzGE+l2nWaWWQRuH2WFN1fhaEH9Xf66TJvKOv78+7kOUfHgKedoaNw
 zyQUgKHTiVGM7JISb+/J4oEUZCGCP/W2m/tOBhF/GYCqdQywMBB2pGqQ1kE3QZMC
 jOaTPdXH/h4TbcSX8F6gQ8ZQlsbL0MSNUNfbIIqmxl2YU3m2zAm2iXLAUw3WQqSw
 DUGCrg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fww7cv30h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:07:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a97644aso15635781cf.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 20:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786331272; x=1786936072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8tddyuzEij5AhjOGwaKoRoKe1Fz5djJ6nu04Sr2I2fc=;
 b=WeDAW07gcD/IF+bJ1gayvND6StbBPfb03GEX+reM8PXKAF+WxSw0UL0Fsv/LwUAMjp
 mOSu5nU2jD1EC+E65/qoYfD0KnSD2OmVqQyVVf45MEgQlrPpJVbx5r22SM/0L0brczAS
 JgFVlaD99hf1xoqV/Zhb1g8tAxP68FkBvL94EXkgRNj31DXxMHr7HlQywP0BXYI8Wd+z
 uqMtS4CgPgqu054MkIKdAilo8+hvwdQtIaK5cjYLYH7ZmS2R0kYddcngyviLS7uH4h2G
 Zu54he5rFBniZUE4o5vXyhH+KFhw5bpXDM4g22nQimWdhFTmisktxvVbMoLsvFynLGj9
 0wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786331272; x=1786936072;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tddyuzEij5AhjOGwaKoRoKe1Fz5djJ6nu04Sr2I2fc=;
 b=eCaYtNxX+cpBsQrrCUY7UMLN5gQMBItTP9e3laZ1xlH6dRkEu63NXpZ+CclUsCKHsG
 +yNNCXRQGc6GwVy4NQKl1ycZwav2tf8mh+USXEnDQ04mRND/k5IxbrWqBPemgpOEu9Q8
 x8cxqg/ASmPp1dGvfNNG1rL5lIA9WKqYyB8kw2vkXWBRZ/ew3yxTialwL5zBiapVKqjA
 2A5X3EKurlJrFEuRpi2PQh0YCm8lPlFFxB8i0kAMjtHroJUeR9Y4PsrqlgTmMRKGWbGl
 Wy+Tw1dLop7stXj58TcwYvUSTE95/nIwEhLF8xRaKsx2dR4sraWXiqsGFwEu6G2iuzq4
 eMew==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmcMMOE11lNQhUCGRER+y8xEYMkIL+gAu3MdCwqDK4mBaLyUAv7MJwr6q/du3O0VMhzEWLG3WSsSNT@nongnu.org
X-Gm-Message-State: AOJu0YxAEdo2d0hAvmn6JrPSn4Mpbimljkm7jVmfXpuHHQMKHxhsfQ5E
 Up9VXkQut+u758vOujvw1K5ykyDvhHBnUEMs68OaLzg7VmVDDXQuL5lKmjKEv/Nl5m7mbcVLTXV
 +2HnRXFjyVnlS84SXaGcF1t7rHlHzr6EyPFTnJLASBCG06IyqD2u+sUtmcg==
X-Gm-Gg: AR+sD12GSyDby0OMmHWEmkxVLouZtH41bCiitypdHoshFpB843rsZGlbi7OasCTh80D
 bt5lPwDZwHoyJPGTa/jdBYJ5v5LN0ECaMd7UBUsmks7fVTHFURSVfSaZ6PA7I3InJGkt+pAUEvQ
 N7vpL0lSMY4ySpm/7gYI0ljhvroUfXozziHnoqrJlc9kvzfe41vLyXJI4Vj5432/I0pDsHHcTKe
 ehjpht5WSK8NSB7M4owbDrXF3hXAehtj7+nMRndcBIZfba1uOLi+e2boaHTwYoyiGQfa/nZm/pW
 V4+UA2r8lYSbIgqG+ozK1/NTiQgKT+B0ViNE/e7AaRETl/OAZDAg+x7idxEjNWbX6U+mq7LtC5O
 kQzEJa0iUJNRZ0NBeEf8554lj1cotFV1fUqM=
X-Received: by 2002:a05:622a:5905:b0:517:7e26:36a9 with SMTP id
 d75a77b69052e-52ce62036d0mr473245651cf.39.1786331272351; 
 Sun, 09 Aug 2026 20:07:52 -0700 (PDT)
X-Received: by 2002:a05:622a:5905:b0:517:7e26:36a9 with SMTP id
 d75a77b69052e-52ce62036d0mr473245331cf.39.1786331271947; 
 Sun, 09 Aug 2026 20:07:51 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8cd0sm29469082f8f.17.2026.08.09.20.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 20:07:51 -0700 (PDT)
Message-ID: <ff90f426-2ad2-46c9-a110-d68305994865@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 05:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/mips: Enable disassembly via capstone
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eYll3ck1gyqWL1XdzVZQrULpUFoSsL2v
X-Proofpoint-ORIG-GUID: eYll3ck1gyqWL1XdzVZQrULpUFoSsL2v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX/Cr+U1O5gbju
 9+hyaA+HmN1gjjIgRkIMKvhtvUVWUlM9pIgItd5IgXPoTP5kpexTk4lJXhOY/444JWUc8bFP2vO
 ku5Ld7Dph00G29llM75oDw2tfc9xl8vIjspzoUdj577J2KCZTV26P4DCZqUA+fGFAh6ELqY+eKn
 0D/5K4f3WZd+kr9HrwLWc53pnsh6jwPpu39tDPD2eKTpy8DUiPjA3Sv2le3MYBC8ifbVn3Vk0NO
 SS9e7A9Tqp83MdaJWsl3EBYKUgVhS/Ssn3GkqRNSfLPs2onnwW3pWDXsdyrYAe5s58u3H21j9v/
 nrTZRbEjKY3JgmwNDkQCQd8eUI6ssolR7TBpnxhqhJc8OycWjGJZ+xu6XJpiRCjht6wFVBiDykR
 KUnnf2pD4LznwLQj6ImvrYZ2Cxn/0AFk4L2dwbz4ntB3wX7eerniZL4N9kI/o7nPYkg5IBS7tdW
 T4QCi1lIxBK3a6RAzzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfXyNilZZrEtQJw
 RltGLBkoCdC1kGT9bpykI0TM7/fpxIAoH3eL9cXaIeV62F4dubKwR8IKF/+8Uz92O0Pbby+tcvQ
 kYNUvK3XVqe7N5vZ3/fyidOKkJXv4aI=
X-Authority-Analysis: v=2.4 cv=IPsyzAvG c=1 sm=1 tr=0 ts=6a794089 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Jy0Jx1RpHDu_HnaFQAYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100023
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 9/8/26 03:33, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 24 ++++++++++++++--
>   target/mips/cpu.c        | 60 +++++++++++++++++++++++++++++++++++++---
>   2 files changed, 77 insertions(+), 7 deletions(-)


> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index d72044aef6..7c1e4827b9 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -30,6 +30,7 @@
>   #include "system/qtest.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/qdev-clock.h"
> +#include "disas/capstone.h"
>   #include "fpu_helper.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "semihosting/semihost.h"
> @@ -488,15 +489,66 @@ static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
>   {
>       const MIPSCPU *cpu = MIPS_CPU(cs);
>       const CPUMIPSState *env = &cpu->env;
> +    bool is64 = env->hflags & MIPS_HFLAG_64;
> +    int cap_mode = 0;
>   
> -    if (!(env->insn_flags & ISA_NANOMIPS32)) {
> +    if (env->insn_flags & ISA_NANOMIPS32) {
> +        info->print_insn = print_insn_nanomips;
> +        info->endian = BFD_ENDIAN_LITTLE;
> +        /* nanomips has 16, 32 and 48-bit insns */
> +        info->cap_insn_unit = 2;
> +        info->cap_insn_split = 6;

Cool.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        cap_mode = CS_MODE_NANOMIPS;
> +    } else {
>           info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
>                                            : BFD_ENDIAN_LITTLE;
>           info->print_insn = TARGET_BIG_ENDIAN ? print_insn_big_mips
>                                                : print_insn_little_mips;
> -    } else {
> -        info->print_insn = print_insn_nanomips;
> -        info->endian = BFD_ENDIAN_LITTLE;
> +
> +        if (env->hflags & MIPS_HFLAG_M16) {
> +            cap_mode = (env->insn_flags & ASE_MICROMIPS
> +                        ? CS_MODE_MICRO : CS_MODE_MIPS16);
> +            /* Beware unsupported capstone mode */
> +            if (cap_mode == 0) {
> +                return;
> +            }
> +            info->cap_insn_unit = 2;
> +        } else {
> +            info->cap_insn_unit = 4;
> +        }
> +        info->cap_insn_split = 4;
> +
> +        cap_mode |= is64 ? CS_MODE_MIPS64 : CS_MODE_MIPS32;
> +        if (env->insn_flags & ISA_MIPS_R6) {
> +            cap_mode |= is64 ? CS_MODE_MIPS64R6 : CS_MODE_MIPS32R6;
> +        } else if (env->insn_flags & ISA_MIPS_R5) {
> +            cap_mode |= is64 ? CS_MODE_MIPS64R5 : CS_MODE_MIPS32R5;
> +        } else if (env->insn_flags & ISA_MIPS_R3) {
> +            cap_mode |= is64 ? CS_MODE_MIPS64R3 : CS_MODE_MIPS32R3;
> +        } else if (env->insn_flags & ISA_MIPS_R2) {
> +            cap_mode |= is64 ? CS_MODE_MIPS64R2 : CS_MODE_MIPS32R2;
> +        } else if (env->insn_flags & ISA_MIPS5) {
> +            cap_mode |= CS_MODE_MIPS5;
> +        } else if (env->insn_flags & ISA_MIPS4) {
> +            cap_mode |= CS_MODE_MIPS4;
> +        } else if (env->insn_flags & ISA_MIPS3) {
> +            cap_mode |= CS_MODE_MIPS3;
> +        } else if (env->insn_flags & ISA_MIPS2) {
> +            cap_mode |= CS_MODE_MIPS2;
> +        } else if (env->insn_flags & ISA_MIPS1) {
> +            cap_mode |= CS_MODE_MIPS1;
> +        }
> +        if (env->insn_flags & INSN_OCTEON) {
> +            cap_mode |= CS_MODE_OCTEON | CS_MODE_OCTEONP;
> +        }
> +        if (is64 && !(env->hflags & MIPS_HFLAG_AWRAP)) {
> +            cap_mode |= CS_MODE_MIPS_PTR64;
> +        }
> +    }
> +    /* Beware unsupported capstone mode */
> +    if (cap_mode) {
> +        info->cap_arch = CS_ARCH_MIPS;
> +        info->cap_mode = cap_mode;
>       }
>   }
>   


