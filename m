Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669AFCD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7cu-000072-AS; Thu, 04 Jun 2026 08:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7cm-0008Vm-EV
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:56:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7ch-0001Eq-N3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:56:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654B6owi994519
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 12:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jx1LntLo667419Mz5lq9il2rm4qkGE1wJsjgzGqPK7Q=; b=Y/wlaftiYUsEWa2h
 gGSsSrxTrVP6Q3hRLZHleMTxx4yBnVmfTFT4vUYsb1rhASgpUHekDJSNCdNHGxmu
 S9ARtZQ993cfumMg1wb8yvWf4gdgcyCvJ7sNWNMrFa0sw4mKMUaxN/BWUTH8D9xa
 l1tB6/PVehieXKnZK02o7zs2Gq3ld7pYYJHeijQsESZl4KCi5jF04Dmkrf0oW4ah
 qUI8sFVBawoFkc2ShqP/Ld4lqKgnOTVGJnXXaQLPx+puha+P1gxcuB17LMtUNnuF
 TijcpNv7EGJNm5xFZeI2aH90PDgqxVf98NnS4s9BiTmmQp/4k+zjdM/lE0xcCP7x
 pDRKvg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek374sm77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 12:56:34 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7ddd34a6336so12134047b3.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780577793; x=1781182593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jx1LntLo667419Mz5lq9il2rm4qkGE1wJsjgzGqPK7Q=;
 b=dNK4gQNl7YTC2cslEcHm5o/vExHbVF1FXrtRrv4wPsCJZdA4iQy2fBFqJjaxvvlizU
 QliQtEV3YMOgKMQdIcG2dT4i5wvoFYYC0IwRW6Q5Oy5y6JBHGHlyzVZEKmrmpGKOS0qZ
 ChROywsGp7f/q6nv/HiqMPbtaqMRQij8YOnB1Wcwwj8DVn059MYUjV9n+ztMpeNDUNjL
 qs5N0GO02t1f3ukXDRBzYjzDLwXVV+zQOn+KStfS/RTTL2HKdPoktZ3jwjBBqUym/u4U
 p/b0XzDFDA5qWGOCvtkI+SNQTzGN6Tr/tWV4YnoHuKVGgYTrZ1yQXSx08d2qClYqFbjK
 VQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577793; x=1781182593;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jx1LntLo667419Mz5lq9il2rm4qkGE1wJsjgzGqPK7Q=;
 b=lGs82pebOZ8g7/Ua4imol9iehIlvYuhVtjGQ2v5lxtNmuFVEjjwngHJOxrQkb3B3P/
 p9Po1pLX/pfC0abh/RH002eOR1jQpcm0SSpsL61PI8eRohycjZOrr6EwSJayI1J/Q0/M
 V8utAKe+zt76/lDTAd/t+WBdSuKkqwSTxV1hgVY51/aMnTvLOrDCRqU5NeGzFT77vlM6
 fxXyYQHuRPRu3/63/WLxCBsbuD76kOdtGpC5mzxaKxDQVAmZHW688kTO021WNJb/ftzi
 MZf7d7va0hIleiFao8rzzBTbL3Y9LawwQ1q6vEY1+tGq25rW+6lFkrvKkanLbg/qbtP4
 Eq4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XtNcyOSTj0JUFxWLtbx7qrPg5mN19lPO3NIZAiI0xpgDiLkS+GjTpIR3DfjuFGwor2i56tRd/1Mef@nongnu.org
X-Gm-Message-State: AOJu0YzocscJT1rWnLpMSvvaVKH5p58Rq2EwlTy9rM0ZaX2SBSntZdb3
 xO1+zvR29epIqQoC9PPSl/9B/eiXJORTWzFaY4kgWlL6djw2GoYrjFtjHL+r10WZrs6j32ddUaH
 92wkkZr3akPxtSQY842Bhs5DLktUzYgSxiS/jg9AbjwWeB9OIeOpeivNqMQ==
X-Gm-Gg: Acq92OFZNrquiKfwWA7FevVuO2EBmI6osMfAgE68/rZn4YOBIGiVWM3k77OOUkVWIda
 NDoZx8KTjwyCdbINmFKKG46nTcQ/AnBcymzXdOjf8RHYmPrYV6T2Se5L2ytD1mlDtuRQukWwFI+
 AbCS5eVbvrlmGUCvJIYqJOab7cWVc0l0tje13KNxQOQMgcfCda2ONpspPc0MDulJsek3L5/vD07
 2GpCHW+zslXbvuAAlA0+8d4tHEcfwz6MOZGgJM0AOTEfnHCHZS40Ttn+dW9ZQLs5LAImPVZXKTt
 YfMJrnkp45JGdOyhmXJriS5h/+ozW/EfDh5G8fjdP15j7pVqMIkz1IN4fISMHaHbtgYBT6CyAtI
 eyjxghEsjullfAkvXw6kcrd8nzjlN/WMys2BjIL0Tt4QJehIvYybxCj69Vcq5zNIxwSuW
X-Received: by 2002:a05:690c:e341:b0:7dc:7764:3e8f with SMTP id
 00721157ae682-7ea4b5f107amr66761887b3.23.1780577793309; 
 Thu, 04 Jun 2026 05:56:33 -0700 (PDT)
X-Received: by 2002:a05:690c:e341:b0:7dc:7764:3e8f with SMTP id
 00721157ae682-7ea4b5f107amr66761637b3.23.1780577792806; 
 Thu, 04 Jun 2026 05:56:32 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea20fa250dsm33005947b3.5.2026.06.04.05.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:56:32 -0700 (PDT)
Message-ID: <7843bbcc-2774-47de-a453-7994d0b2e7e6@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 09:56:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/25] target/riscv/debug: Reset trigger type to
 unavailable
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-19-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-19-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNCBTYWx0ZWRfX6V086Yo4ukE0
 wiJAY7RZgkqluXc0vzbQsTE2sFTnRdS9YXjU/KOWwyiIWLOhC0r1/Y3xfj1aNbvQng92LRL++bL
 9Q+s0ii94nm5asJ729Tvk5aBZVb6MOMmQdXUv6UsF3nmXcfO2BSBxfin/EHpIJiyz995GhwpKf8
 2uRHOnazYgZJ7VmYiyzupvKk2DbqXGH5B2UOGfFJiJJMr2vr+LFpM0I1Iga5t9P+FFVUC/JH3tt
 3r0ponz0rHaHYAqAcwYqjluzmL/BSxcAUhaFmiRIgDHTAQR5uvC9V67523FlLe8p7CuJfHobwQ9
 MyEIvbl90B10IKO2JU4HylPkwbEKLl378cclRiEPtPwlVUTcrSSPeYQF6hMBp74BA+HHa2fpYNO
 5zJ3iy5SLMzX+dAAKko/MeF2vwtT7gkJxwmcRdZwhtcJpcuyMu3ODwEJvTGeb+CxBpLdrng222L
 3xvjKMyWqNDfsLT3AeA==
X-Proofpoint-GUID: u9ZDyqNEmrXWxSJbA-Dhh_RvCUSUXToh
X-Proofpoint-ORIG-GUID: u9ZDyqNEmrXWxSJbA-Dhh_RvCUSUXToh
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a217602 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=9J1GuFoIK1a6cBHHTdYA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040124
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> Reset triggers to type 15 (unavailable). The reset value for tdata1 type
> field is implementation specific, legal values are permitted.
> Unavailable is a legal value, and some implementations may not support
> type2 triggers so use that instead.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 605ed95b14..96b00193e2 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -1043,10 +1043,10 @@ void riscv_cpu_debug_post_load(CPURISCVState *env)
>   
>   void riscv_trigger_reset_hold(CPURISCVState *env)
>   {
> -    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
> +    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
>       int i;
>   
> -    /* init to type 2 triggers */
> +    /* init to type 15 (unavailable) triggers */
>       for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>           int trigger_type = get_trigger_type(env, i);
>   
> @@ -1061,19 +1061,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>               break;
>           }
>   
> -        /*
> -         * type = TRIGGER_TYPE_AD_MATCH
> -         * dmode = 0 (both debug and M-mode can write tdata)
> -         * maskmax = 0 (unimplemented, always 0)
> -         * sizehi = 0 (match against any size, RV64 only)
> -         * hit = 0 (unimplemented, always 0)
> -         * select = 0 (always 0, perform match on address)
> -         * timing = 0 (always 0, trigger before instruction)
> -         * sizelo = 0 (match against any size)
> -         * action = 0 (always 0, raise a breakpoint exception)
> -         * chain = 0 (unimplemented, always 0)
> -         * match = 0 (always 0, when any compare value equals tdata2)
> -         */
>           env->tdata1[i] = tdata1;
>           env->tdata2[i] = 0;
>           env->tdata3[i] = 0;


