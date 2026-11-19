Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19285606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lTKqXvVr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ecBWfWE+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAYj-0000Ru-Le; Thu, 19 Nov 2026 17:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAYh-0000R2-N6
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:24:47 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAYg-00072m-6K
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:24:47 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLtaNi3570724
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9JYSRK0IuLKJeTvwtG2bnv/KF1XAuuK14CpfcnPmz3k=; b=lTKqXvVrYbMaktyP
 DDrXKeLEM+5zmiulA3OtKYVCgGPPPX/gZxoRevbrfIxohJ2Xt/MTMGrjzUqpeVBh
 E+Do7nsMU82ht7qegMZ0Trh5ALzBw4HUuuSOfjZEkIF8SbQiyxhYDr02OxBxu7Z0
 rFb+LP8D/FblbvVIbfNvbwO+m630Ns5yHBgM6K18v6F9gnQv0ErRJ+Eh1Lc3iNl7
 J0cPfY+BUPMo/IdWHKnKM58O/RLmtM0w0iwB7PHFlUYdn+FTDCoMRkAkwhs2vOJi
 It98rwPr+jdMaE1C15750eyT4S9KowHlkIkpaVh75QDS5UnnUgsy12SM1TXA8rYe
 BT4INA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fygpfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:24:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844cb60so47533485a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795127084; x=1795731884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9JYSRK0IuLKJeTvwtG2bnv/KF1XAuuK14CpfcnPmz3k=;
 b=ecBWfWE+4g1EItbaOjh3bwSXrCDbZ/xfEAr6jRFMAXTIExmIngQS5s6X5Wt/kJJQcq
 TExO9RYRj3ltOksx/xKrqbLQ96+nAp7YdodcwuxvZOyAHKGFcUe/mLKXVLKOV1SoQamq
 uZfrY/4GEGWhLTh/KkE7QGOoYFfu6e0uGiqWAC6thoY9cH8hJ6YbI4WKz+Uxf9FYGMwB
 EzX+pkkj530uSgvESDy7CI48Vylo3DEh7wmaYX7j7KQwZR4LPxUOFqimioMDY/UK2szo
 ZwQ2YyiiWJ5uIfuu09te38JQNa2IAvLTBJZ+R777mcHUiH2TjAJ9DkBhHXM3mknUmEST
 JG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795127084; x=1795731884;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9JYSRK0IuLKJeTvwtG2bnv/KF1XAuuK14CpfcnPmz3k=;
 b=b5JTlJAjF90aznf+SdBa7vspBtTtqeLYhUbfUxPT7fRXQZMdgrEOvw84i2FUITvm4O
 2SWZF6qMl5HRBZFRmUpTyejEJVPHFWB3Vyp6CKxVpbDgtc4cKPq2ImapDTTSKbAmL1tL
 JHftkFPWJjmz1/d21ejQn8eomQPZIU0D4rytQb+GM1fajMEV03FXsNfemWxRTqxLFyeU
 uGC9cb537XuAMjpNym9NSQ/qlgHLCW5Jn66RF3WZ1YooTSjMjNPzqXIa1dwJtdXM6Kjr
 g0TvdTVcYraC+vAyGhhHQKx8Xyo+TYyiKLCrNSbsPKAlI980vMO9OXiWxacBwcafg97y
 zTlw==
X-Gm-Message-State: APuU4Z8teuXDQPwD13rnBvW3JmG8/zeRIsby/XmOYewziwSkJg29Axg+
 TlulVCrgx7U0c+DNLSzMH9QuSYdEwb7/kt3C8VSaoNtYZB75oPLByvO1hn4ugKxXkUkBDD4DXcp
 +S2b5LzvNOxFzl1546dnmU+Eba+PDKcv8p2Cbyl80BT7VU80GEx+XqnObbbUywz75UIbT
X-Gm-Gg: AYBFou36dGbX62cTLMr55yF/IwNp57rLFOOr1DJBKxx3CILZBs8jio/8XpWNHzrrM4d
 mJAnpnaoo5HmkU+LHRwZdj1kxj8MvoT9KarWl8YiP35ZDxC4nQnjSVBTokqrW9Tfx++7rn56aJt
 y1vkocoae7ulIT7WAWjPFjFDc/EZcHELd+bS69NyuU2x/ZI9kIJaHUKDsKG/FvLcCBuppQpfsum
 G8SQdXBPXeR6B3VI8OECjFEIF16wfE6CjyDlMzdng/o0YD2+MpXMvJKmo24fHrbhaTkVjHGgukd
 wIRpdLseUQlCiUTyZTqDS6SadFYcNlkPWHMdOeBR+3QSpUbLYEAzS9Y6yIETzmqfC5VrG2AzwtS
 aPyIZBj5pmCMTbyUvDL5zYYIPX7ZUj3XaKI3qTOorI7XeKv2V0/ZQ6GkqB/9oD0bSW//RXXNng0
 pq9oPQBkY=
X-Received: by 2002:a05:620a:601b:b0:949:692f:f4ed with SMTP id
 af79cd13be357-949b385b33emr375637885a.43.1795127084124; 
 Thu, 19 Nov 2026 14:24:44 -0800 (PST)
X-Received: by 2002:a05:620a:601b:b0:949:692f:f4ed with SMTP id
 af79cd13be357-949b385b33emr375634585a.43.1795127083631; 
 Thu, 19 Nov 2026 14:24:43 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm1784547f8f.49.2026.11.19.14.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 14:24:42 -0800 (PST)
Message-ID: <e48c6f3d-3e0e-4f83-940e-3f55bff3cfdd@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 23:24:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Kick the other vCPUs on SEV under TCG
 round-robin
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Lorand Marton <lorandmarton.dev@gmail.com>,
 Ashish Anand <ashish.a6@samsung.com>, qemu-arm@nongnu.org
References: <20261109142319.73878-1-philmd@oss.qualcomm.com>
 <f24b1be2-d114-4760-a7a5-e292951661e7@oss.qualcomm.com>
 <CAFEAcA8ub6f9D+yBnhqOG+7jTD7uz0k_8FPnRd=H7zTvWgPo1Q@mail.gmail.com>
 <59228ea4-6be9-4814-b7fe-f62232058db0@oss.qualcomm.com>
In-Reply-To: <59228ea4-6be9-4814-b7fe-f62232058db0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MCBTYWx0ZWRfX0tx7fxRdgjS4
 5Dq/PoTu4uYs04mw0QOuQCa0NI8hbWdeu3lQrSi4kDHcSlQ9q37YJvsv8g4K+Z6ysbB+vRqMlWA
 B3ppch5eGNPGED/vMwguNZtXyHVh07A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MCBTYWx0ZWRfX5fzNd6z/vvNr
 igEpkL0bbvi1EZr+tpIZ3L63ZtJjOPhlXVwnNE7Om4cW/9rjfPLr5q6WRGZJtvqBRE/f9rVvAtF
 ucUkDGh34UztSNBPc8flHeYyu4bc7Mf/hNiDTJ6+NKRsvDvKb7av9MT8cZnPkS9ZfuYQZWlFPse
 +KLLk7hIU7eDI3hrTUGMBFqs2A4KXWUqzpztvNloT7AqcHCC5ONMXocPo2/xysjBUbGTxa/WOGe
 QAY0hQgglwt45+/W1Yst2X0scTvgp30eqrWC7uAJ+f7aIavPTyGflortEb188QPK1BVG32vqtlJ
 oVijcCbhxuQv3nEqkVm+Ro4zoaSl2tkGVNWd0v0a9yza/JgrqZHGGPw+S8tJneuYLef8NKXTTVt
 qOINFvuDLg6V+yV5Pdhv7LDm8FPO1O32clBRLpkmXS4pQ6Yko2R6KpDTDne9P/S+PFmzaLYvrQG
 flwKa8YO/1pkCCVDyKg==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6aff772c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QqFT-QDpDwqqdVtg8-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: BkklYFzXaluXBZNlO3opuVGh3xiEWJZg
X-Proofpoint-GUID: BkklYFzXaluXBZNlO3opuVGh3xiEWJZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/26 11:20, Philippe Mathieu-DaudÃ© wrote:
> On 13/11/26 10:59, Peter Maydell wrote:
>> On Tue, 10 Nov 2026 at 07:28, Philippe Mathieu-Daudé
>> <philmd@oss.qualcomm.com> wrote:
>>>
>>> On 9/11/26 15:23, Philippe Mathieu-DaudÃ© wrote:
>>>> In round-robin (single-thread) TCG, all vCPUs share one
>>>> host thread, so qemu_cpu_is_self() is true for every vCPU.
>>>>
>>>> The SEV helper used it to skip the kick of the issuing vCPU,
>>>> and so skipped it for every other vCPU too: a vCPU sleeping
>>>> in WFE is only woken when the RR kick timer fires.
>>>>
>>>> Compare against the issuing vCPU instead.
>>>>
>>>> Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> ---
>>>>    target/arm/tcg/op_helper.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
>>>> index 6a673e5ae6e8..173dd0e5151a 100644
>>>> --- a/target/arm/tcg/op_helper.c
>>>> +++ b/target/arm/tcg/op_helper.c
>>>> @@ -470,11 +470,11 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>>>>
>>>>    void HELPER(sev)(CPUARMState *env)
>>>>    {
>>>> -    CPUState *cs = env_cpu(env);
>>>> +    CPUState *self = env_cpu(env), *cs;
>>>
>>> While rebasing I noticed I did that 1 week before latest ARM PR
>>> and this conflicts with c5ec1bfad103 ("target/arm: don't pass env
>>> to the sev helper"), then I noticed the previous 8def1f30d5d4
>>> ("target/arm: hold bql when SEV sets the event_register") which is
>>> a distinct fix. This patch is still needed but need this to be
>>> squashed now:
>>>
>>>      -    CPUState *self = env_cpu(env), *cs;
>>>      +    CPUState *self = current_cpu, *cs;
>>>
>>> Or even simpler, check @current_cpu in place (no @self local var).
>>
>> Generally speaking, I think we should avoid use of current_cpu
>> where we can -- it's an "action at a distance" global variable.

Besides, that would be the first use of @current_cpu in target/ !

>> If this function needs the CPU pointer for the current CPU then
>> we should revert c5ec1bfad103 so that we pass the env pointer
>> to the helper function again.
> 
> Thanks for the head up, I concur.
> 
> 


