Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G3jyRlZG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZhY0nDY8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW1l-0006xN-5u; Thu, 29 Oct 2026 15:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMW1W-0006uo-4Z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:42:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMW1S-00089a-Bv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:42:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJg8C4766133
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ldpyd0FnPB/Wi2QVCWo3iKTpE6F+kGlQqJ7hi1wXcwQ=; b=G3jyRlZGPLLVLJt1
 f1mSmx7/KpkCKJZcPLKwFzr+tfT97DLmdhAtTV7MAY699nJitrVjWCSL1CI6qkal
 0ZsJefw957aF2FxuAuQlUwmlIeOyZaJCrB7gGxZR//vyKo09EazD4Ry5+VGFrPqa
 W0Mb1smdd8zG3ail34Hb8bA3H0hsAgeXmjpAH99wHSn4Y8Yj2sky58WYtdRfxRl6
 E4NCWcSxL5MstgT4XwvpTqajsTgjcZDNolaKHjwGFvlXnsnvuduCEu0MLGgStc+h
 weOsdfu6iq+ab4SEmiyq18Tee3/DLkPRXiltTG2LWGeEag3qVnJ9gg0ykdj/PoxF
 jPayaQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmchhr045-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:42:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f20addba1so454825785a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793302969; x=1793907769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ldpyd0FnPB/Wi2QVCWo3iKTpE6F+kGlQqJ7hi1wXcwQ=;
 b=ZhY0nDY8Ud0ojCjEF5JvGHhXnGdr4FTaoMP77QWCC1VotOT9ITtQIJJANs3MWG8/u0
 +8LnN6RuADIYy9IFsTqzkD0Pum5CcL2PjtB7+EXSI/4i5rBSFXOrTOdnndhu1Jv6oMFV
 noku1ahzebL7QMpLTLI+3cnNWhm+JyygashTT5NKx2Tf/UPRSdM35tFTZZz605fzTNob
 rfreHevr8hDn3s9tiMQtkTe/lKMEHsF5sK9J/cL88Jyic1ym6LxCuWITs+XshNDSqDFL
 pWKeBu6kPzzlt2kVmYHKb4YYUkN84oQGIjEZ2dNbYDndL5cLdD6IQsqULwW6KJtrS45x
 kOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302969; x=1793907769;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ldpyd0FnPB/Wi2QVCWo3iKTpE6F+kGlQqJ7hi1wXcwQ=;
 b=mvvBoQKMl+aoCJClZc2V53e/W6lLkSEOeX/6JzT7ggS0Sib8B+oVr03ODU1kkUUgpZ
 DVUcM3lbZK51K6fiIK+94kvJQpyw7xsEl6oP812+Kb6weWmHdrlSAG9i5JLNWN4NaDfR
 0WJL5YEb+RS+X4D1un2TCCMnAfwVE1zSJSy10a2r28dG0GwhNtRwuAtlL60ufhy+TP3p
 bfSDq7ggEaZNxqAgeXGf7xkxSe+1EXrsH+za/AWV0YO6sRhdnnLGofjJF3/sAABstGvf
 GJfgOhq+YfTgiR9L95R1CmguJiYr0pyfZWsO61VpZaGYfdTWuDVojmNqOW7rtq0toz7m
 IlDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLhkYvtyS+p3IKf6TPVdyq/72sfdHvN/+zNM8E5UcCjGeoxkgNbB3BuuZc7RZPodPz9rUQwE2dqThi@nongnu.org
X-Gm-Message-State: AFq9FYKs99DOWeMREnK4ocntdYRbmefXGSTW2NHkSOo3T5LsFEcXvfPz
 NYk41IpOjUC+KgmMSVPb+eR17emLvn7ceD7wcAMjWjwNcMsqMEb0nBc2qEYHKIp7C93KOOAfiUY
 viS6HqEfYSLhghXf8OMTVfWwS3JG+k8N9yPip7SQlpaMzWxgCJDVS58DMOA==
X-Gm-Gg: AYBFou0Q5lve07pI2dQhDuys3kFJd1u8a7gaj4osTJS3NhBEW7mju2ARQzlemmlLldu
 wAVrQukl5vYWUyCvbbSrmyOLj/Jvp2iOaltfAuTgmA0gNcPk04BiEXFyLAvMOhNQ1kmqdkbNPM0
 ZtiNaAoCu4UcChjyRV+dux4tdU6wsyCK9L3jjy0q2V/6h7ZqoJ2R7Xu018z4nnTXm+Sl5kxTyEr
 XcgpYeZoka6J7nse4HYT/qW3mCqb17zy98xzxaGxa1q+cwXzRiQwE+/3VPFlOTmPmrQSfcMV9wt
 RIneoP5VT52YPXgT4zcrYktMbJnZYz9HP7BTzr43MCCK8uXgcCausr9KIZNV6RlIwlaVzXC7iVQ
 rKxc/c6UjPqLFm0BJ5HprEmfKdqA7lhz3JbajTJTegdEh5G/eV73GKWZd5lB/nNOpOujPd38si+
 2ZDs3nuIOipXt+QM1LOPbszUtruvMP7/i1LURmig==
X-Received: by 2002:a05:620a:3942:b0:93f:334e:df26 with SMTP id
 af79cd13be357-9442177dd45mr34419885a.51.1793302968747; 
 Thu, 29 Oct 2026 12:42:48 -0700 (PDT)
X-Received: by 2002:a05:620a:3942:b0:93f:334e:df26 with SMTP id
 af79cd13be357-9442177dd45mr34416085a.51.1793302968277; 
 Thu, 29 Oct 2026 12:42:48 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca314fb6csm4423926d6.34.2026.10.29.12.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:42:47 -0700 (PDT)
Message-ID: <ec47a4b2-0d88-484a-8cb0-d312497adcac@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:42:46 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] target/hexagon: add an HLX instruction trace event
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-4-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-4-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NyBTYWx0ZWRfXyikmyROt/4RB
 UwatYEOa+o5i8zPQll5ze0RS391mALDRgqFVMY2/RpgQs8B32CWz75jKJOBFKhrOnJ9JnFSoJB7
 8AfoAW/l13JbffjFb52kwBBDkoPqbSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NyBTYWx0ZWRfX3VDd0ZnVsmX9
 BT40/8be3Y15UDpmsvw7K35qfjbldPhA3z4LiMWk8zkagPJ9MMYDSuOnvCxB3UhnbzWOgXxwroj
 nPRVupVFZbNWvf+0593yT5WoKmSA1HsrSa6hhhnowhPI6dK172Z+hJMJGvRlQQo3KerAK/vTESF
 OOM5jOzrZb+poMTCDj2BQPfPrwGw80EerPSytJboaeKP5lD7Nb8rbq6c1atdaJq455rDMEHvtn+
 CcHG+MZ8QwBEi4PqVGWsJyYQtsuKG2HNvVMKMIDgkGrv+Lsk7h1/3uxtVVd+r//MVf30oIQ6XYY
 KVF10Zf31Ki0fVRfHj+CZ7yGwujIFNnVXYHRgFwoOnDEMcGckM2KQH3f7YUCbqDZSG4pyX6WNn8
 9Yfl2u0RLPZgzvTrz6wC3fUxTWR5gWWJjUXRaIYHdmNLj61blhwMmAJoi+DDAfh8CY5nVU0yzLQ
 eRnbYVQRvmEnSomeisg==
X-Proofpoint-ORIG-GUID: U39AWsYrzf_R2CUqDN603cQIVkB1kils
X-Authority-Analysis: v=2.4 cv=ffc4WEQF c=1 sm=1 tr=0 ts=6ae3a1b9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rlftf9Dev7_M7pFHp34A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: U39AWsYrzf_R2CUqDN603cQIVkB1kils
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 12:43 PM, Marco Liebel wrote:
> Add a trace event that reports the executed HLX opcode and name.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   meson.build                 | 1 +
>   target/hexagon/helper.h     | 3 +++
>   target/hexagon/op_helper.c  | 7 +++++++
>   target/hexagon/trace-events | 6 ++++++
>   target/hexagon/trace.h      | 2 ++
>   5 files changed, 19 insertions(+)
>   create mode 100644 target/hexagon/trace-events
>   create mode 100644 target/hexagon/trace.h


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>
> diff --git a/meson.build b/meson.build
> index 7ec3fb9023..71f135f053 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3695,6 +3695,7 @@ if have_system or have_user
>       'target/arm',
>       'target/arm/hvf',
>       'target/arm/tcg',
> +    'target/hexagon',
>       'target/hppa',
>       'target/i386',
>       'target/i386/kvm',
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 8a2a6563d2..245cd50b89 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -31,6 +31,9 @@ DEF_HELPER_FLAGS_4(vacsh_pred, TCG_CALL_NO_RWG_SE, s32, env, s64, s64, s64)
>   DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64)
>   DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s64)
>   
> +/* HLX helpers */
> +DEF_HELPER_FLAGS_2(hlx_trace_op, TCG_CALL_NO_RWG, void, env, i32)
> +
>   /* Floating point */
>   DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
>   DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 477c8d6b66..27106fe1ad 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -37,8 +37,10 @@
>   #include "mmvec/mmvec.h"
>   #include "mmvec/macros.h"
>   #include "op_helper.h"
> +#include "opcodes.h"
>   #include "cpu_helper.h"
>   #include "tcg/tcg-gvec-desc.h"
> +#include "trace.h"
>   #include "translate.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "qemu/timer.h"
> @@ -68,6 +70,11 @@ uint64_t HELPER(utimer)(void)
>   }
>   #endif
>   
> +void HELPER(hlx_trace_op)(CPUHexagonState *env, uint32_t opcode)
> +{
> +    trace_hexagon_hlx_op(opcode, opcode_names[opcode]);
> +}
> +
>   #define SF_BIAS        127
>   #define SF_MANTBITS    23
>   
> diff --git a/target/hexagon/trace-events b/target/hexagon/trace-events
> new file mode 100644
> index 0000000000..4235dc6ac2
> --- /dev/null
> +++ b/target/hexagon/trace-events
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# See docs/devel/tracing.rst for syntax documentation.
> +
> +# HLX instruction tracing
> +hexagon_hlx_op(int opcode, const char *name) "opcode: 0x%x (%s)"
> diff --git a/target/hexagon/trace.h b/target/hexagon/trace.h
> new file mode 100644
> index 0000000000..e886ce0b63
> --- /dev/null
> +++ b/target/hexagon/trace.h
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "trace/trace-target_hexagon.h"

