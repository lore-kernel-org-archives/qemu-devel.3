Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA5DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHRh-0001Cn-PF; Thu, 02 Jul 2026 09:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHRe-0001Bu-Uj
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:27:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHRb-0004ha-VO
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:27:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0ZXs406354
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hf2Sr8ybtI3aIA2En3KFtBnGp5amffLq5yuFtsSmius=; b=GHLbD8MIb1ys2gBd
 6fWqCnlSHJb7Xh0XT6FwPNt3ShIOPJaXXvIoqAcuctTgPG56sGgJf0pnWT8AotSI
 +1dmb77BVYoaAm4VJZKvV7DYUSr3NUEdj5X+fGxjzz+njcVxH2eQnRUIq9N3poyM
 ffUBDBZLPEYDJZ4jFvH3LKcnPC9ZalVQ5xIdFIcybhJjKnXVRNm1vRYcKUXO73VU
 tDj0abz+y/qJHKIFhcGn3B9yGAz46kIBpUMUSBBaUW3nkAwh8ABpe+Hx8NbWgl4L
 IQY2yn2r8Z0kqdM8AnzOJbbXcBcvbgcdFfr/4o/DUiBW8qxVyRFo0GoD6NmqEwmd
 ZCxEIA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98hw5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:27:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c33f48ee4so5451251cf.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998826; x=1783603626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hf2Sr8ybtI3aIA2En3KFtBnGp5amffLq5yuFtsSmius=;
 b=HXlGS1K2RTzttun2NrbbgOQohER43OoHi1GyUwlAeZQei90yiXA6eg+Lu7UOrREUcW
 tO0m3CZ2G4KSv5Jqv9++gFrvsSgnb6AexwPORerNfcg6twS9Illxua5ECz5l2R37oNnV
 caOZjuZGCE33FqmrK8K2XKl1jf/+A8dtmmBCTHbRP5rsY5dk0yUKsuq0quFJiTPRIVF1
 3xippPEneFRYvkMmGblE1btRug1IOlLSSR+O6XQGIhuO/gZU7rBbO9q/4mbRH9IIOAl5
 Sr2of/HXmr3wYcA+4+vR+l9s/fY6NnSwDMdeJ1TJ3AiwUteYwz2fvMgLSQeScPPAGU4d
 8B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998826; x=1783603626;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hf2Sr8ybtI3aIA2En3KFtBnGp5amffLq5yuFtsSmius=;
 b=RUHxISQWp4/H8KSPk7iiwviV4M9zglMj1j9zJQQZoxwxSTD6BPWqZAsZ24mG3sLQTY
 u0pRCJtIQzX6ApMZiu49F7sWKAtZd3Rt20bZ0FHBuzfmOUrqTE0Mz57o0EUxl/8lSJxa
 NBQv5sUUkVhodPDwGS3cE4Nn32+alMRM0Ae8rK2nMF+8xECJlJrzPqes1jtAAtR69B1A
 ALC/K1I824o0txVR/21Fcc6XvxP6C835JogiihzjoN/oVncDjy0DDlz5ZfDPnWEOAvzd
 o+JyiyjVdPA5lxZrAyFd1JOJKfBhBsj+QSa2G/yMGEony+ULBSXXKnySefCAcPb1KRrP
 ap/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XFK2zTFCrMFG3STiu5E40wR7Ya3Sm+q0f7rY7Jxtnq/h0CFBTzPw+6DMkd0E0qwXCRnZ6x6aQtM4I@nongnu.org
X-Gm-Message-State: AOJu0Yz3/vBWAeQgI/LyXuim6QMyBmkxeroidOwk/sbrdmDAWitT+4Lb
 h+zBscIFY599Qi7j9SL9ta13BW2FASlw7F+jNkM91d24qZ8rSpigO+SR2kRwuSQLXbbIBC7w3kv
 nEKfDoAXD/iDeut7yeB0N5jn8QpTjhJaEVyEDWHSGanUQ1mjLpT3B34Bcrg==
X-Gm-Gg: AfdE7cnPB/oW6NbW2z4F9U+zKk/d8l5kGU+mNEQrJZBjlEjuV3zUU0mjCPbSWtrDS+n
 j0eIuyL5z6ewG1LuzR4ClIM4Dz8JvkUL+aYl2FWqu2cE9nzBBOd1j6dS6hIRiTZnAjHIr9Ag1Ev
 KB2gBbEXVUgif7X8j6xsWQr1adXDR98wadbgL1RTqbCvsbVFYpNglSyGMscpcWh/7RZ07W13Cfi
 vXVi7LIW25Eemhh6w9z7YMg7v+akVooLCXHQkhaxexREnSOUNNi9d9CrywrHuy802+0amSz5qfl
 R03YXlzN7cxl+05Mg4QSKFO0qlq9rCC23cuS20SvH53BhBqV0uDnS6Rj94q/0dGEYRPd0w/CSvZ
 4qrid+IHZKz1tEgEtzeCL5Y8jXAbba5IZWlXDAdIT1WBt
X-Received: by 2002:a05:622a:558c:b0:51b:fd82:22e0 with SMTP id
 d75a77b69052e-51c26a3c673mr95537931cf.3.1782998825920; 
 Thu, 02 Jul 2026 06:27:05 -0700 (PDT)
X-Received: by 2002:a05:622a:558c:b0:51b:fd82:22e0 with SMTP id
 d75a77b69052e-51c26a3c673mr95537471cf.3.1782998825503; 
 Thu, 02 Jul 2026 06:27:05 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c30aef6bbsm14535271cf.5.2026.07.02.06.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:27:04 -0700 (PDT)
Message-ID: <bf72fbc2-ad0f-45c0-8226-2fe1741d48c9@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:27:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] accel: Remove unnecessary 'inline' qualifier in
 remove_all_breakpoints
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-20-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-20-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pUVwsgmwJ1rR0PRtprPdxelqg45X6Evt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX4UR7RUc0fjjN
 g+o/cGVBs6rMyqrpxujibH2G+g1G0SjGMDCd0D/h3pfAJPHR6PNC0KQHOox6rfnH/VOsg5Vb1Ge
 o1qd20BDGBWHSGUWVIQ218uP/Jyg6l7YcL6pIJjXj+yiF8GGRgBPrcJn+di7YWwXDpiM2guLliG
 SKMbLky3VcTxAFnzE+cXqAvBnBhBwby6n5pT++60D8ebUU0NMRlhq+MeDypU5GmUz08t72lgEZz
 bFc94Yr4mz79SC6qhKkHrb6/Vy+2rUJtfY00ra4CrPiOzyEfyDecd0iMpy5Cc4S570SLhND87Tl
 T5FPkV0FiN0MoM/fKa0rMKR5qnn1mhMkCCNW8ytJ3AF8Zy93+/p8mg7E3ukXB4lABDWGjKhVDJx
 Z0gx7fkaAZp729VyBJs6LYY88ftdSXmpZhgk0l7qQARJ0i3gtnVnYODE/4WhI+yYrfOvW6mOkP6
 xo3sWbsUwuzTIgJYx+w==
X-Proofpoint-GUID: pUVwsgmwJ1rR0PRtprPdxelqg45X6Evt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX2xQlE2tAyw5i
 6T23WVQ1wZH5gRKJwSh6Dd6Fq4qTK6u4GT8ZUytykaek2NumIVndzQdVA6PaKGwf9mE8kuCgSq1
 EyLVdHGGEMKu4egCmFeEhDNCrnKbrF0=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a46672a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=P6pmemUla5q9Y3PKolkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   accel/tcg/tcg-accel-ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 26d34c72d9a..c54acc770e3 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -188,7 +188,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
>       }
>   }
>   
> -static inline void tcg_remove_all_breakpoints(CPUState *cpu)
> +static void tcg_remove_all_breakpoints(CPUState *cpu)
>   {
>       cpu_breakpoint_remove_all(cpu, BP_GDB);
>       cpu_watchpoint_remove_all(cpu, BP_GDB);


