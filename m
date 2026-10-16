Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1C0CC6B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHaim-0003Rb-V6; Fri, 16 Oct 2026 01:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHaii-0003P4-7Q
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:43:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHaig-0002FM-Fs
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:43:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FM92EP2678171
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aT17as96R++M6+aSL3quaAYTq4fH3QqYifJsBrNoDLc=; b=RLCgyKPM+s3uZSc+
 8SC6n4RVKPfVJgByMt20mAaIbS1YC96wL5aELfXAshMRu+GhEc+K+pvMNK1U3zsS
 ei8wwJ80upuuH1l6W/oD3sUiCw/llKh2s4XTD9HUIpLejHT9yjP23B8JZqd/jP9w
 mbVYXMxzyZKow5OWU7pkp9dH+aSdvbnhOdMDZSBpGZgVIuT40qkl62Gnv/Txp5jB
 fEx5BVUkfvCdMpCfK8f0ORvD3RFIb9x2uHpGA2iD/ipldrDnRwZyiU78urRC/bhR
 W8bx5ryRyIAS3/K58tVSL1nwojSFifO6laCCY2fBo9vW71Yk+reiYVdUrUIYQ/pj
 EOVW7g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19tax0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:43:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a082c014aso171604985a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792129382; x=1792734182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aT17as96R++M6+aSL3quaAYTq4fH3QqYifJsBrNoDLc=;
 b=jM+lT900N4rN23hPbD75PWyau4sZAue1xS84JnwqA83PhsLdWpebpE1vtGFOJqZrZD
 L+h7m6rhGWBab1bBHuN8aBLM9ceKQkr6okznpbj/dWlNAIHkugO/jYLlF71J/kR+mz/M
 RjO8J70j2GKscFnWDtubMNZuBhVTjr8Pw2z/dd5/0K81PFrTC7kSKqnTqOS8wOZ4WIXp
 SCPfS+e30tFF85wLbc//7Q83C6kb0JKHYsVH83GLAwQBRx6s0wucTNUH+9n95lPtTVHU
 BeovgAMWNSsfRg5DBFRACPp16t5Enb54c8dhO9Hxj4mNVX0tkXB/sP/LlOvB25RbgR8V
 RuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792129382; x=1792734182;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aT17as96R++M6+aSL3quaAYTq4fH3QqYifJsBrNoDLc=;
 b=XN/FzHFArR6/ZaHdoubr71rkgb7lyLooc1U0wPpaInz0TfUhmu4+BIR0vNddQKK2MX
 kQdY+olcIyVHd1kBFDe8/fSkj4fD513kGW/X5HA8dzW7CuYT79V8Y9+m8M6CLTza3aDY
 fbjmOgnJsTNvHTUIpbveYY+U2dEatBN/TEg703MCC/OSCw5L19TewG9UxWsAwZt6LONM
 437ZNSIxq84KucPhu+SXYVsrNhhOQ5DYPjuwC4/lsrylu958qdobF7d1roPE786p3jBD
 ZKO9sRS9/CKK/k36nenpcJ5Wdagevtut+ft+vFDtMHsUPO8NqVcEuS+sbY7n7PSQT5gR
 zeUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSOww+U2vx0xB8LPxLeGrB8Qppaw1M2M89A1ImzBOQuF6vvSoPx9P+dxvSLW8jf1yHmXc1PkFILTWI@nongnu.org
X-Gm-Message-State: AFq9FYJcM5kiHuRK9jfCSLIuMl13MY/HjT46Tf46hQLHOYt8SSbwGvkn
 V4Z57BnTyVVh4ub8hCA+WwhMZrO3So9eoyTrtucpf0lY/s80cJv+YXhJleO8xgNCB9txf6aKZhw
 HSUOpmC3hZCgH6hMzMCTcE9AyYTW+0c4bPrfM/jKvdk/zU3njEHGxpstr2g==
X-Gm-Gg: AYBFou0qGCHujbLtxqMsUKOuxT+w6j9ul9kBxXpMa0hieK7NnB+Twt9W+vhYDRwq9+I
 KM619e5Q174CxvOIrbt6AjADtYCwQWbRfsY8qTjr5aX5oopXJ1srGH3puO3ntQP5GS3NraOQIrb
 aIhMZEhqJnS1ToPfC0TFpTXVilgQPrnsvg9kCToyBjQNCmyto0VtehIbpZGMvBPE5EAI1aik9qO
 4SRGEE5qI0oDyfDB+14oT0oklFE9T3YtzUKGsW2A6w/Z1w/BcoqfvnSEJ1+P7K5aM7Vjnbu+HZp
 U8SLXnZOJq7yeTasglvFXGsU/K9+binv/6DwwzatkHtQdNmCiYPVyN9jlHZEPYuX6WsoMAYGkVW
 zoRWNYOA60GtUhLPdboC+oPKg2yZEnIg0ew==
X-Received: by 2002:a05:620a:489c:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93f17f7cf36mr373704585a.33.1792129382492; 
 Thu, 15 Oct 2026 22:43:02 -0700 (PDT)
X-Received: by 2002:a05:620a:489c:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93f17f7cf36mr373703385a.33.1792129381986; 
 Thu, 15 Oct 2026 22:43:01 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfe4d2321sm2268256f8f.19.2026.10.15.22.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 22:43:01 -0700 (PDT)
Message-ID: <ae92234d-e6d3-47e9-b8a8-2d43a8855e20@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 07:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] target/i386: implement get_dump_info sysemu op
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261015213236.157767-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sa9Y73EMOBdA7gg_kCx1gfilIK01LNFA
X-Proofpoint-ORIG-GUID: sa9Y73EMOBdA7gg_kCx1gfilIK01LNFA
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1b967 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=61HWBudWGo4Nm84UKJEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyMiBTYWx0ZWRfX2nCsl+hU15OI
 Y7dZxNEgDW7Xg/jkHAU9ZzY85RBtD9CnwZcqqq4JzsXpqk3t1/ZpF7YhFp+EH7okQue3hTH4gjb
 +gpicJfy2lf+fsMAqqkX1hZQz+U8XE+KUaWkI8jY6AJIlu2a1vQXrAMRAMwaJaTYp8YOJHOrjeE
 Ed1NRpDA/wdPXR1tFp9kdFF20zDTGGj+GcDRNTINKApmeUkPUCpfuMNCtaEl4EtvHnkg0GfkJP2
 oMJbHOcYRaRxDdkLwE7nCeRaz884RdALa18FQz1/AqC46cQiPlYnF/kMMDkr4+ffDpZHY1oBxXH
 CdUlfu+r8TOBCC31akCjXdOloHYMdKW6I4NQXRq+07olufmVuSMezPsbQampppfCs7sLb/CstJU
 Zk/WrX0By7Tv6EwQU0kdHiHTUMHmcWKLU421BXYoFu/QkC9ElvIodiCuSFXyOFO6o0s/js1aZF2
 +2ADuI++qfFmM8lRgOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyMiBTYWx0ZWRfX1NL2plhzkt5Y
 KxKkCUCAbORTfLcly17UWP3V0cpQjWEIr3R7/LPni67tJBy10PqFwt+JRd+75/dONO9wwyIK7V4
 +u1bznIYDm4nWotE4I7H5ANZQFyPsp8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160022
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 15/10/26 23:32, Pierrick Bouvier wrote:
> For now, we keep the global cpu_get_dump_info symbol defined.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/i386/arch_dump.c    | 17 ++++++++++++++---
>   target/i386/cpu-internal.h |  5 +++++
>   target/i386/cpu.c          |  1 +
>   3 files changed, 20 insertions(+), 3 deletions(-)


> -int cpu_get_dump_info(ArchDumpInfo *info,
> +int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>                         const GuestPhysBlockList *guest_phys_blocks)
>   {
>       bool lma = false;
>       GuestPhysBlock *block;
>   
>   #ifdef TARGET_X86_64
> -    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
> -    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);

I know this is pre-existing, but I'd like to understand this check, ...

> +    const X86CPU *cpu = X86_CPU(cs);
> +    lma = !!(cpu->env.hflags & HF_LMA_MASK);
>   #endif
>   
>       if (lma) {
> @@ -429,6 +430,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>       return 0;
>   }
>   
> +int cpu_get_dump_info(ArchDumpInfo *info,
> +                      const GuestPhysBlockList *guest_phys_blocks)
> +{
> +    if (first_cpu == NULL) {

... because you kept it. Why do we need it? QTest something?

(goal is to understand when this can be called on a non-vCPU thread)

> +        return -1;
> +    }
> +
> +    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
> +}


