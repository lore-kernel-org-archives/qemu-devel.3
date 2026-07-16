Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5350C43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 04:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkDin-00079v-Km; Thu, 16 Jul 2026 00:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkDil-00079i-In
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 00:29:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkDij-0005ob-KG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 00:29:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wQKt1299457
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LqLMpoLqu7XlWlqJwbPBFtLYGwg6kmuPpmDufeb5STE=; b=CT9dtz6pk6iO0DfV
 irlHf77La2vBEgyhzy72DJrPXEwA10LYsn7e8of2egvt4ebJWIhIdTqOBM3W7sxL
 cyDdzfyyCiOj3PgyWB9GS5ZIJlIorZvHzLbKKzgGIoMZCrn8Y3y2Hg5A7K9cvb+h
 RDUg7/2heCWeIxL/FRTzlSnn8HJQ5FmCVmQ7dQCyeNsZGLTdMp7Lx8xLAx1M9Zoe
 bP16I1V+kHV5iyfPyswMtUvTYG96AwyRBTv3ckfA2GS3acGO6TPvbDfEBIIL+RqU
 LTvKRaVXXcAqaYtfP6+AYTMv2Q3IQoXSp6TMPXDE5R0BDriwstfjjnIzDgr3RG3X
 e8Hj/A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed062j3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:29:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c892143db7fso2637959a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 21:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784176150; x=1784780950; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LqLMpoLqu7XlWlqJwbPBFtLYGwg6kmuPpmDufeb5STE=;
 b=giUqH3dqh3IB+Rkap1zTn6xCkuSIPtzlWYEsw8rNi4ra/+S+3LoskM30bB8LC7eRDi
 fqR8oxUbUPKAJY4cc5K0g8sOOBHWb83yIZDGQplFSHBrxFPni/X1do0ukLKnfrBgwSRa
 lVrA5b7klcpPD6xDSg4h1w92WpcCV4TYaLHbniCUP2gjrZ47kGoVi7wVCcJ4SYYAD/Vr
 eSFe+V6ounHgHy4l1S8h/Ka/aLNIbSWl1C8f5BQJbSpk5m6tiriF+2wTcA75pb1XGV6+
 hqbkNvql7Tz0677P8Qw3YChsLSq206Qb/1W4YTEBZiuxPqyMr4wJuQ2L8B52sdOxmGr+
 FUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784176150; x=1784780950;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LqLMpoLqu7XlWlqJwbPBFtLYGwg6kmuPpmDufeb5STE=;
 b=ny9LlNDdx2pppcHYqfMv4EHtUf8SDZQi33wOMHz2ujP2NjjZ9HmTVOd0Yeb1ueiz3b
 rZNA9kWQQaEepuPfSXs332Fn6sD1Wn1jXcaCKHedxVz1KqsmoWLxo4sFYtGgeaMZ1kGu
 l1hwR/OkJub0aN2bFOhqbz1VtyiiNLYwqERufWuIRVxb4fRhTBx3I05ihGxThWs4Dhxr
 CjzDNrIHZqrfHUi3fD+Ac6Is7r+C/e258pb76jM+zUsHH7/rJVP0HjKhkmdNe+Sq6R9l
 213kTUYTI4PlvQtBWNcRAojCo7bqnm6KnXsEAEQ1HRi8D5gglwSy5WsQIcfqUN6nAhaF
 yjxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RryBlMmPolcMOxjbo0QqcQ9bm0O9UndbHaW4RvwqihaEJ644H+ihYb4U6ubsRFK9sKMZuGdB0Vv0Mbg@nongnu.org
X-Gm-Message-State: AOJu0YyT3iqfc5RWKnWiY/4kVoaBeekY89dsd1G4qR+04I/TbT13q3C1
 rFBDG0UI6IGmjd/q+JT6aiQqjdcYVwDL6seogPVmN8BpgBjm1svfXdOHpDcBMk1sOU/I5ee8BOC
 Bo6wIxfK4KKEyjgsOXLLJJB/RVlM6poXHeu3OWUzUdqSViSOXiHn9QPi//A==
X-Gm-Gg: AfdE7cnArqNd9wiGLiMfJ2HV9fDrAJxpa4l6rrB30eU85+I/i8553jYXVAo4OFoligz
 Bwiaphe+h0RobxAaits2R9ihkiuR0LvW3IOg9J5/5bbEdmFPLTb26Q8hYe4GBhfK3FfthVYkRca
 eKCLtd76M0yprfhIfZnkx3nJWKcroD8gcoccIeOvE44cC8u1ceHyCnwCFkwYZpMcUxfvsaIrqb0
 Fi6XdINBOjO4diKB+we3+K4t9iTx8bKKumgxmc/Cu1H1esSFbxac1SR9Q9l2mCKINct819h+J+J
 2tq6l7/ZXtZpHmDuCOSCzEI0t1msNW2UB1/SOgCASB9vf2uanb9/HWROVECA1dAbJNCVJfcZEvD
 4TE2XyKSGeyQndhjWP9FT7Z217Ow0dcFov0Hgw28Xv/kmmm6KTQo/D3tsSct6M1h8KIjCnBX9Mg
 ZFiLTo
X-Received: by 2002:a05:6a21:6b12:b0:3c0:adec:b3bd with SMTP id
 adf61e73a8af0-3c110acc837mr23103581637.49.1784176149854; 
 Wed, 15 Jul 2026 21:29:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b12:b0:3c0:adec:b3bd with SMTP id
 adf61e73a8af0-3c110acc837mr23103547637.49.1784176149382; 
 Wed, 15 Jul 2026 21:29:09 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4341a37sm5566627c88.12.2026.07.15.21.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 21:29:08 -0700 (PDT)
Message-ID: <0898dd62-ac10-4a45-bbbd-16c33856bbf4@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 23:29:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 47/98] tests/tcg/hexagon/overflow.c: add missing include
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-48-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-48-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA0MiBTYWx0ZWRfX9fVcS73P2AQY
 7UNzblqDp3VkMHOWqW9Oa6Sa4lPfi4GTZZj9jdsPPT5WF6Jg3Q7Hn5KjqlVkKSM+CP3WNGzrhBF
 nGb95TC0amG/L4B5YwmVb4udpDuLNrc=
X-Proofpoint-GUID: LU8Yws7ptK-XZr4djQbssNEORMExJ--C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA0MiBTYWx0ZWRfX6SELEQpG/9yg
 uJqThlnT7MsmxZtoRPAiUQXPRE/Jq/9/Q250E1LlCDlXunATebb15bt4nK8yYGnJ4taUOU/qvhh
 qXhOG6ombMQhjRDU4rkvuYsVCdiYXwFUWAZUhN+Kc8s74hNL+0PsSkEASOW6EPm2jSCZhlxf+DK
 MGWhyYN/wSD9s6G9Ih/SbycHKUrPMm4h17iQtc7VYYyKct9KN3eQ3cHNnWe0QK+apJuuy6OP8Nt
 ECYBXpx7SmzttnqgAj1AhFW4evni1bR7IPgYTyx+7ePxW8Thw3weUsF7gb3/rhs2QoFO/LjOd8b
 GourYko8F6cmaQ9IbJW0b8sZuL/VMuto0eG5QBH4NMa/NuEd6MpTWeuGf6A8BmG8xhTwxfaX9uh
 qVGWu07Qv9SOLTicGvFtZW8v8A3pLlB9EWWoqAqjmWrzdW8vLnvUhCT035d0eVJk7vE+ahxjZTI
 cExw2UVw1n6B/fIrmEA==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a585e16 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_4Tc7s-AZm4HAsOyU-UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LU8Yws7ptK-XZr4djQbssNEORMExJ--C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160042
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


On 7/10/2026 4:42 PM, Pierrick Bouvier wrote:
> ../tests/tcg/hexagon/overflow.c:59:1: error: unknown type name 'bool'
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   tests/tcg/hexagon/overflow.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/tcg/hexagon/overflow.c b/tests/tcg/hexagon/overflow.c
> index 7b5b9ebdde6..9ac2d6eab62 100644
> --- a/tests/tcg/hexagon/overflow.c
> +++ b/tests/tcg/hexagon/overflow.c
> @@ -15,6 +15,7 @@
>    *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <stdbool.h>
>   #include <stdlib.h>
>   #include <stdio.h>
>   #include <stdint.h>

