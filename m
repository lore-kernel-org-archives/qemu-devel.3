Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C192DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuvms-0001t4-GS; Fri, 14 Aug 2026 13:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuvmn-0001sp-RF
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:33:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuvmk-0002Ep-RF
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:33:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EGhVSk1870257
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 17:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A+rqhgjovXNqIX9GqPepDqt/SJqIGH/Y6WhEtBz8UjU=; b=eYvy2B8AwkH9alMY
 R/rjjR3yyoyUkOsf2rnpja0kTGvesCt2G9YswYFuCvJEDFmMllXGH7vxrgAP26s4
 ehgDuoowhpCATbN7YddEkVTXI/1uUxluii8CDLz/HnjgiLrBAmtf11VQfLQBvo5I
 5N6vrtikpBLjQnJZtlTu4Cy4vRfAy+AhGeQZ5ICSEMbexaQK9DM5c6hjoOpBjYAx
 pt7gn30nNbJvyTNXLgmR34R+wTCev07cVEQObm1/UGRX2fOpbH3z4cBVAR5KG4m1
 VbEq4sMOkCA5fWiedbW8TwjMyTODhpbCKg8vxiCIV0JX+cyXkqX3JELcClo7M0QY
 83BH3A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g26450cmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 17:33:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so15388521cf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786728815; x=1787333615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A+rqhgjovXNqIX9GqPepDqt/SJqIGH/Y6WhEtBz8UjU=;
 b=Uy5zV7E2qjz6RSzqxSclnqZxGVyJ7UW5yBlyaSh7IM4UrcgjtKGGK4ArQm43RfDRCy
 Ejl4mC0QE9B+CRTlFUPs23zI/NDGoR23TizNPMGpgvaBSSCmRpMpDOt6SdfAqo1QhK+q
 GOvGAqWYH/PgIZL8AgLBfxmwmhjTzBLNgoA4/fTxJmEVi2dUjct2C2K154CcuWkIM+OU
 vI9Eh5YQshVA4rHU/mwLA9v2+ZwyfJPZ1GS5HEewNT6K8T2E1ItLkgWQSIiEvqEiOn86
 fIB75uEpiTuYYwJMt18zNxXwBztNy9aAmbddfIML/8vrU9X9Boh9VUJuLHsMKmH58S2B
 Pcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786728815; x=1787333615;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A+rqhgjovXNqIX9GqPepDqt/SJqIGH/Y6WhEtBz8UjU=;
 b=JjIO1sbs69+f1mqwV6GAxhCJbyhwZ31OSeyRtq3n0kVoscJKbbGOWICixBR8cz7fu2
 ZfFOqMw2oU7rAJ3LIGURXHm4NGycEG+YS0Eax+rUdjoizOW1GxHgNUI2hIObktMGGwh1
 CppkbP0mtATIpHj8S8BzC8Uxc42ESe4abRkvArJit4fsSqTU4gdUkbpoILKwl0vLJr/3
 aws5T9FEgcixVhjTGjyERz7PWMSplX1E+QWgyfwg521oOx3EraC7nRvTqjatuFrAzJKC
 S/I//A+evlTvruqkBUP+kyJbmKGoOsT6wGTmneVSLzK8feGCyFj+06gyqjnyc8CoChkp
 +nzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqagEequk9Yuv+VJ8XEGpj4qvmOWVOqV43OEdeZlh/w1hgFbw1rALpsnZ7ILW30Ms8PaV9IKJCLHXBV@nongnu.org
X-Gm-Message-State: AOJu0YygyAnb2yaNPtRVFnI17CFrsDQ7NySMJ8iWeuhOdirtFpouDXD1
 7YwZPzV2Z5F7G0BGbuf9pzuBhlXRcvrQ7gAYyIn7Il1lhyapUqNgjReIzCwv87gZQIdmMwiut7L
 Kc+NZG5aUrGgPfi9bgoE1wbyTtjvtn4sRCIPTE/q1ARZGvCfRX+rnxcJP88LFAKhToOFK
X-Gm-Gg: AR+sD11K1/MvgQWdkx6PZr5NQwjoOVvw8y5KN/iL+TKMTJP/MEOnm7j+C+24pxVQmn6
 WNRMHAOg2XiX0RlH8ei/OgbdBDCl5ZAF3uTI19JQH2aIk//oYBcWS0DtWqH0j7x9Po1y+hWFVla
 H81YGDUH/sCgucQK+vdiSFlfT7CakKm7JWNia8wka9loeW4UBfggU9svgWzA5lVNYYjvemm7dFq
 3NB1Jhy7EzvqcpxzOFUcoLVxc0rsckrTlEUaI897iyLcnmXWw8UVi2R7ST6+K75fsmt/OXXVuzg
 C/VVAC60C59bZHOpi7q3eWo0IVjET9FQKetWSVIom1xHRyCLGqylYWWbNlw8WiHx8vcbRQocl3z
 g/D7Xr8nyVoLMZvm8bFq3mKoVHyAM9Gos33c=
X-Received: by 2002:ac8:7f13:0:b0:51c:a7b:f730 with SMTP id
 d75a77b69052e-52d85569e6dmr77061401cf.33.1786728814869; 
 Fri, 14 Aug 2026 10:33:34 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:51c:a7b:f730 with SMTP id
 d75a77b69052e-52d85569e6dmr77060821cf.33.1786728814475; 
 Fri, 14 Aug 2026 10:33:34 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d5548sm58612565e9.1.2026.08.14.10.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 10:33:33 -0700 (PDT)
Message-ID: <96255543-c899-48a7-882f-a436c3df7367@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 19:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] target/hexagon: Add sreg_{read,write} helpers
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@mailo.org,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
 <20260611052857.3911981-29-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260611052857.3911981-29-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n0eGtDZBEq_kxArInlrIEVX1-6ZCzbMy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzNCBTYWx0ZWRfXzHPptkj079Z5
 0QG8XZJx8cXuLpb2ChtKWY1nCdAYpSXM9q24+F7IS+6dovOEcad5KH299SD4RkcuS9ZUjBJHrjz
 c1DDBwOG5ghLHOqs76kMzhxWLzuYsCE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzNCBTYWx0ZWRfXzYSgYdNbG4rq
 6E4afFz+q9Sj+c7JHkUdfsBWgUiPbti7FaAUkTUmpaKehUYUu2zAUYeWOPw/igBQNqw6BWbdtLh
 xDz0Og/C5N84t/McRIJr9NAoBtnJa31OAbnYQOU1jtzgtee2LaxLRyn+hoDIm3B47krjRWe/Jzl
 lfAZQaW75HwK8tPAjosH3TtZly0Tq4PtLIJtQl7BNM2rHFShg3VZMDPEUvhIaWRrnogRLom54pF
 RcP2Iq6vG4/3jTLfIxgZWvtj3UxILnzxFaseptKoXUVEk9Fb6DfQg1YJQIphsmWkmZHIX/3FZum
 SzHcbT2CO2j1VuLeM5abFD+OHq+ryfhvhsJekXYuZ4UDe+2ybARAWeSSOa0xuVDcSUsDvlbuhT2
 1YFmqmDol0ZYGoxA+CELjUAC15m6j18zjJeMnSgcn72AzkjUQJxz2MeiyUUjleazduP88owvf5b
 SCRKVMprduxM2ch6jtQ==
X-Proofpoint-ORIG-GUID: n0eGtDZBEq_kxArInlrIEVX1-6ZCzbMy
X-Authority-Analysis: v=2.4 cv=OamoyBTY c=1 sm=1 tr=0 ts=6a7f516f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=T6Ahx4nIaRzYj6CtocwA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140134
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

(merged as 9b63a54dd2c0ea9a667c9e9dc662755b9feffa7e)

On 11/6/26 07:28, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c        |   1 -
>   target/hexagon/cpu_helper.c | 354 ++++++++++++++++++++++++++++++++++++
>   target/hexagon/op_helper.c  |  33 +++-
>   3 files changed, 384 insertions(+), 4 deletions(-)
>   create mode 100644 target/hexagon/cpu_helper.c


> +static void hexagon_resume_thread(CPUHexagonState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    clear_wait_mode(env);
> +    /*
> +     * The wait instruction keeps the PC pointing to itself
> +     * so that it has an opportunity to check for interrupts.
> +     *
> +     * When we come out of wait mode, adjust the PC to the
> +     * next executable instruction.
> +     */
> +    env->gpr[HEX_REG_PC] = env->wait_next_pc;
> +    cs = env_cpu(env);
> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
> +    cs->halted = false;
> +    cs->exception_index = HEX_EVENT_NONE;
> +    qemu_cpu_kick(cs);

Why not call cpu_resume()?

If you don't mind I'll send a patch to clean that up.

> +}


