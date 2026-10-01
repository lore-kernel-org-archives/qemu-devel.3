Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941C3CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCFWF-0002Vj-BR; Thu, 01 Oct 2026 08:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCFVw-0002NN-SC
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 08:03:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCFVu-0003JX-3y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 08:03:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xNBg1932325
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 12:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FyWQZBIDMMX0sgWn/UaLxEh8Xnt9Yh8i1P6UdPwFnwk=; b=Kk1Xc7+g/HKFpQrV
 ZCGuELGWT+QDxYOC2vTN8QIi1FF3D6dtvG9JcETtyKN17/WqtH1qbsFGvvckY/mP
 D6zAGTs9LNSUJXS6cZDx/hkViuoRMPOthrd76kkE4gIo+Y4IU7B8mKqg5ZwcHrCi
 jfEzPr4l/Tgw2e5HWbMNsk7n2mz/S9ASKN3Z/j56lrsGDYVMzuMldjifBAW3uhtz
 Xi/cKth7XQmC0uK+k+vb4jjgjO0ckkbWpVrm+EZCFziTsffk4I7pLtXc26sZMu0h
 obft9NRpTVYQqPTgSpV+QFcR+6tZfUCppqT/DTYW9l+Z6PKdiCTr6DSFTxHLpXqr
 PND0Qw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5aua6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 12:03:42 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf6e54f4cdso856695137.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790856218; x=1791461018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FyWQZBIDMMX0sgWn/UaLxEh8Xnt9Yh8i1P6UdPwFnwk=;
 b=e3GqNzaqODrrv+Skk9dvIOlL3j4ibkmlveD2RaZzz8rTg0deK/NIJeeEWk07NuA21S
 iS9ogg9H3HHBSjVEkMJtZcQ8Efj7ZRco/1btnEESlPZC5Lpxem2vYgvMEUVC8Ie/SMaT
 lRlptGkMgIRPde+573wK9WSjyqnf7sqGT6ezfEur4iFSUerVagdgn8O7LJ0/AXxq93pc
 FBg7+rUYFufAnwGKo88y6zztAUYlpP8RzgyICWYGpyCtt0JSapvDvWffHRB0TYHuA4RP
 d+mphG4gXtZUx1XMDqem7qszMIrzXdkyTnOxAm/SrzuDSMQILjKOhIJjkCV7osGdb79q
 c9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790856218; x=1791461018;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FyWQZBIDMMX0sgWn/UaLxEh8Xnt9Yh8i1P6UdPwFnwk=;
 b=wS0WaE83toPAa3zPF6SNk5qyzDOB1nE7JZvIfiZgjUBrU8POZj8MT+bGJWBy64tuEy
 b66CXlBWRkesVwz1h1yI6IZiaj7WRYqqR65kMvgLQeBkTx1z0qegws9O1n64ub+Uwo4U
 QyYUHcAvhXtAwhAat0+d+EaV409jh8TDTy61QgKaUc0T/I0lbIN4yPSwRwyOngW77Wrq
 GzzUEe474q0TY/Q5XFzBSWEfCf+i4xl5kxGfrAQtbwOxof4CS2n3vTIVn2e1ns8fevhx
 lxbDvW9qjQ24lYXFk5CN8wJIPq0Qn3RMQNT8Hczdkym+WSjh6BbOphvmq+apPjbAaAkX
 qlJw==
X-Gm-Message-State: AFq9FYKfX0xWNLk0p2Iz3SI+7ZAvPF7H/Xpd/xgxGwpmsuIsChuzkkda
 5XEqkXyVhv2bc+ud8zcsxHRlhC1OORQir6nXBlngeBO/RYv7d3Y6YsfNsVQrjC+GP00/peMu9bl
 L/Nb81kowoBn1OPV7tplHuxjXWDj6B+eE4HUqNFkqwvNyuIqWhq5YohuBXw==
X-Gm-Gg: AYBFou0LlzjZDv712oWPnvV83yK3Jhul0QLvy2SUT/WZF3UdR4vjZBTvINP9BAMb7Qm
 0GhXSk84G6zSSIlk0Qg/5eUjjp0EfvNeCBahaY0z0E8aBN232WuEet5rVKhiST0/Z3LSZoHtJN3
 WMcbEKY1doFHYVy0qrHw7n8b3gWFhDB1jT5FbNUvaYV1IjSRehI8eQ623e9vPuCElKS2o1zy4KC
 40zxGtSQrZHrd7CyE35EBNeGRFP5KrpGiISjpnkkOujEnKKFhCOjCJcS77H6+KOlU9iLS10EhRQ
 wMat3jrUz3SP6Fik5AFrJGxM4y22yaYApwB1KaaUEIs49QpGKjeKNTvVTqBqGiFi2aC6hAjiZoo
 QxwxFnuvSRU2gCsAfbiUQqw==
X-Received: by 2002:a05:6102:2ad0:b0:7ba:5d33:7ff6 with SMTP id
 ada2fe7eead31-7be72ab783amr1422827137.11.1790856218345; 
 Thu, 01 Oct 2026 05:03:38 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad0:b0:7ba:5d33:7ff6 with SMTP id
 ada2fe7eead31-7be72ab783amr1422815137.11.1790856217750; 
 Thu, 01 Oct 2026 05:03:37 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01fdfcacdsm74245e9.1.2026.10.01.05.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 05:03:36 -0700 (PDT)
Message-ID: <4d1e3aa2-f725-405b-88a7-d2ad47e054d8@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 14:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] target/arm: Call arm*_cpu_do_interrupt directly
 instead of via TCGCPUOps
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-2-philmd@oss.qualcomm.com>
 <CAFEAcA-w24c71SHh1Sr7JkO5RTVK7THH8GP_ixVvnWiBXWQMdg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-w24c71SHh1Sr7JkO5RTVK7THH8GP_ixVvnWiBXWQMdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IlrqlFI4JbuToHv1yL0GZLapsVrkB_ye
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NyBTYWx0ZWRfXwnrUmHaylxwO
 ipL8DC7yl24EGMwZMmJ1Fl2Wv64C024PZLf9PnCfzk8xzkmWLDYrdqjf845Fx5Ifjdew5Fz5Gqs
 8xw+exUo61uRvOTj2O9dcSzGMkwRjZY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NyBTYWx0ZWRfX/kZzHul2ooPb
 BwoRpIiHstFtID73jqRuhdpeoI65bcBVMLYRD17toopJqY+hJsHKNkG3eCbNZvT3WkdNE1mZxGp
 B8yDN6xmbZ3pCv85l9+nX7YQpHfFrEmAn74kfy6TpNSHRR+R84Aw5lB//eQRLmwbvfBe7zIewAB
 r6B4hOaASpn++7SBDBHvbIEbeTNjsyoX2jwJRkkN7RKcl3zzXi4hI/Qg9z3ZgRPfAoaKLcoLMWy
 sYIIM17J0eQ5nWVVvtgUiLYVmcQF4dReWYfrpmbEPtRrKyotRV2SJD7OYVq7Fbgy2bkx18qjesi
 GPudIVD3HBaFaT4NNouCrNaw1C2kxJaD3gFewMZzTC1l2f9n5OwKaY32w7ugA510PazLIUjemQr
 mQBoLKcSRtfxQjs/acQB1k6MB0UZFKxJr7MkGB8GL2wce1nFAuX0I87EZgykF4EIjp02dS3PzLy
 PSJkum3VBc/RhlVhzXw==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe4c1e cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=PwczH0WBcc6DY_pivE8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IlrqlFI4JbuToHv1yL0GZLapsVrkB_ye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010047
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

On 2026-09-08 18:09, Peter Maydell wrote:
> On Wed, 2 Sept 2026 at 16:20, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> The TCGCPUOps.do_interrupt handler is a target-specific
>> callback installed for use by target-agnostic TCG core methods.
>> Target-specific code should not dispatch through this indirection;
>> call the ARM implementation directly instead.
>>
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/arm/cpu-irq.c     | 2 +-
>>   target/arm/tcg/cpu-v7m.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/cpu-irq.c b/target/arm/cpu-irq.c
>> index 883e8a176c3..e8a6520e5ca 100644
>> --- a/target/arm/cpu-irq.c
>> +++ b/target/arm/cpu-irq.c
>> @@ -270,7 +270,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>    found:
>>       cs->exception_index = excp_idx;
>>       env->exception.target_el = target_el;
>> -    cs->cc->tcg_ops->do_interrupt(cs);
>> +    arm_cpu_do_interrupt(cs);
>>       return true;
>>   }
>>   #endif /* CONFIG_TCG */
>> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
>> index 48b31d5eac8..502998dbd1c 100644
>> --- a/target/arm/tcg/cpu-v7m.c
>> +++ b/target/arm/tcg/cpu-v7m.c
>> @@ -34,7 +34,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>       if (interrupt_request & CPU_INTERRUPT_HARD
>>           && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
>>           cs->exception_index = EXCP_IRQ;
>> -        cs->cc->tcg_ops->do_interrupt(cs);
>> +        arm_v7m_cpu_do_interrupt(cs);
>>           ret = true;
>>       }
> 
> This works because we have separate cpu_exec_interrupt
> methods for M-profile and A/R-profile, so we can drop the
> indirection. If we had anywhere where we were trying to
> do "call the appropriate do_interrupt function" from
> code that's agnostic to M vs A/R this wouldn't work, but
> happily we don't.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Thanks for the clarification, I amended:

   This is valid because M-profile and A/R-profile have separate
   cpu_exec_interrupt() implementations. Code agnostic to these
   profiles would still require an appropriate dispatch mechanism,
   but no such caller exists here.

Regards,

Phil.

