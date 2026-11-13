Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6E606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctU1rJtY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JMqPpOwt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRoP5-00035b-ES; Fri, 13 Nov 2026 05:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRoP4-00035K-8L
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:21:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRoP2-0001ps-PB
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:21:06 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8VS2U1527726
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8bGUHE6lAo2515tQJdLZrZbzzgFhMqoEk7M3SbiOKZs=; b=ctU1rJtYDm0Srp57
 5+v09sjFuolSJXbc+ITyxzHedAinVf+E03QTwPyHdqVe4o18ML89J7taGPpd5t7a
 TZsDa4s1ADC/iVw203whbrt1d/BpdfVLxVgFcvzsW53xcKeRAvOi0FXSX5SDJHQC
 NfYa1YloJyrI7sl//nUZR5KSQzMFF8Uu1iwO0D01FhgQu2F1q5TmrEV2vZhFlVHh
 2lc9NcySM6aw2+puyrg4yHqUxMY/d/Au6/dGc6P/TXTQRAnDulsjwTlmaaiLb/sA
 KVupKjDVm3EaXo466w7F9oLQHJRdqSrUet+jLx04qKysSVQ5lCtmHqSETq5UqQFM
 hDkJRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hww5r8t95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:21:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-533928ef33aso8610961cf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794565261; x=1795170061; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8bGUHE6lAo2515tQJdLZrZbzzgFhMqoEk7M3SbiOKZs=;
 b=JMqPpOwt/5y9pvaL8OG+FWVTfxgUJCGEdBQc33FASwRdB/TTAz3ec4kFV3hvc2JUv8
 mJdtX2db/OX/lgiAXcV/s0D2k1bnGszSzV5P67BvyQ68M+uO8sWTr8PZScUOQO9OIbrZ
 jXZ4DGWQR7UhkmK345wjxl3AES9/a40Qlpldhi3uhFMZzNRugiyuaXdvZuzlqZ62XLXp
 a3XKsnzWT5dbnSvs1p4LQ3iLffKH/Q6sBhl9Piaa2n6ixxPhtYqBaZMVTDFMGe8AqKcy
 cHRpw50oOEFTmcTQLbVFL48Kuw4U7XX8GRdgxSYJ14AIYQgK+xFnEnctQS4WZWusfc3U
 Gqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794565261; x=1795170061;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8bGUHE6lAo2515tQJdLZrZbzzgFhMqoEk7M3SbiOKZs=;
 b=zphYhPiuc4Rb8Vc9MtKRltGexgEm0t3fw5Ljb7DWN9726z5NXVAymhE5hO/qxXOWUX
 aGCmGlodlxYz3X6P+dLNld76c9n/arxdS8kdLZJJZcgcP0n1pfXtGFXSVaetQi5JEVkz
 T7/Al8o0W7AhOzCJ+Rjch1GRkW/nTL0F6hGwDrkQa3m0IMMr7bJWMRCvdUp6xjrQR1Z1
 lAAHLg6wDYhzIWs+2ybV/RjHxtywIOQ58WIAfQU7YzUuhIjs2ZU8hv7dZd+AiLwmF1iF
 Eb+ZPNGRHaSdU8Z6vT55bV5RAjrudq2jlcCIU5cuHq7Z7vBHOfFRp+il6dISz2tEAFvt
 7CHw==
X-Gm-Message-State: APuU4Z9qM6jL4d+rzl5kMLQSI52xh9hxGadr6JR59sB44jvBVsnwUCzJ
 Gbc2GlfoIGbiwUXxIzONNqt2KmM/reSKjrvk2MHxuJU+x1y0dkPvovnUSGFs7Y2qBBJJ1b+uVfe
 XAft4UiqokW0DlOtSXFMJiWmo4/dCGugkzlGQkPBDSZYgm4mGIgBbX5zcsg==
X-Gm-Gg: AYBFou1rH52C/4/CxMlQTLyA6QfsnTMwc2+IWPrev5f/b4QXyYT9QdDMHJQthaLJjPr
 ZwP6h7BNlwB9Og8N3y3evtKmcvsHteS7Lep8+kjofG8MvT7+uof6EQGIKg0dIRdAfZUSYXRs2cJ
 TQJX1mP9GFB91rXAfg1aqpVtH/jslZY3VFQSXOi/dQuNcTkLtJ84TGbwdbBcgOtFw2r9WuTbuk5
 nQ4Qv6vw3SE9n5oiVnrljdFLRPnemcNk3Rk5yKj2x4YQ4RaAcSVbr2rJhEZSDo6Z9I6Frnv2DSj
 ZFerUWQ9pVLwih2xhfM5Al1xqc0YzQVXVareNqX6j1KCDnxVFLKUrLiMO2bjJIA4v9i+hg+hxLx
 5gv6oLPErymOTamRitWoCA8UYLr8/W04+cZI++EwfAQWTveQDA+oZ8jUo7aLsfwOqQTN+ANR3Rw
 11y+DA1QE=
X-Received: by 2002:a05:620a:8398:b0:93f:a63:15f8 with SMTP id
 af79cd13be357-9494b9e1c61mr319224185a.8.1794565260937; 
 Fri, 13 Nov 2026 02:21:00 -0800 (PST)
X-Received: by 2002:a05:620a:8398:b0:93f:a63:15f8 with SMTP id
 af79cd13be357-9494b9e1c61mr319222085a.8.1794565260413; 
 Fri, 13 Nov 2026 02:21:00 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae4414sm53627325e9.9.2026.11.13.02.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 02:20:59 -0800 (PST)
Message-ID: <59228ea4-6be9-4814-b7fe-f62232058db0@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 11:20:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Kick the other vCPUs on SEV under TCG
 round-robin
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Lorand Marton <lorandmarton.dev@gmail.com>,
 Ashish Anand <ashish.a6@samsung.com>, qemu-arm@nongnu.org
References: <20261109142319.73878-1-philmd@oss.qualcomm.com>
 <f24b1be2-d114-4760-a7a5-e292951661e7@oss.qualcomm.com>
 <CAFEAcA8ub6f9D+yBnhqOG+7jTD7uz0k_8FPnRd=H7zTvWgPo1Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8ub6f9D+yBnhqOG+7jTD7uz0k_8FPnRd=H7zTvWgPo1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MSBTYWx0ZWRfX6PK5YtRZo67M
 LUEOZrlQkVPx+Q/dznz1kAT9DjAUV8aCA4uo2AULxXBXOQrtQO70wMuNPm+3tH1rTR264rAzM0y
 3VPtemoMHU4Pd/FCH0i4E/tOop4A2z4q/j1XmGrSFVnCDNalzUBII+VVhxhCPpN/ZOFLNlmDpBK
 xwuTUpKMXf/Ssy1mbNNh+VGsWprrP50uVkWHM/tawaL0hDEEXlVHO10eTBL91aky9WNK2yqRo8l
 mlpE4KPlDAnQC02pSEP7X1Vhsf7fTaOJnub+tw+Gt11zEFDk+IUqfpJgAhBhuyOF3vq1GP9tcCA
 vlWCFepK9dK2xj/2BOy5nNV2kD0ldQSshUsmLOExYUA96QtBmssCwj8OGm+lp4Nw9xHtJTK3l1q
 pmJasIz2nrfBSfTmWZvSX26Cw+cJbt4VkqaGoFEjEshls7urmRP7vv8xThEq7ctGFx2lHz2k6+v
 Lz4zNUelDKg9fdTNftg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MSBTYWx0ZWRfX2ojg4/ds5aXh
 TabzJdQlVB06ZffSsqmAltzdBmYJVa6xFc1A4sfqzXY4dzynIOZibr0/vVy+BhKhYmuNdq/3evR
 mhrRJLF/dnqhmhb6DlsEXfmDDoMSad8=
X-Proofpoint-ORIG-GUID: rsNt1LUnG2GPhAyON_zqvbB7qw3IaO8h
X-Authority-Analysis: v=2.4 cv=Vqq2kO2n c=1 sm=1 tr=0 ts=6af6e48d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=gNbYuatrb8QfYtHaMDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: rsNt1LUnG2GPhAyON_zqvbB7qw3IaO8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130041
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

On 13/11/26 10:59, Peter Maydell wrote:
> On Tue, 10 Nov 2026 at 07:28, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 9/11/26 15:23, Philippe Mathieu-DaudÃ© wrote:
>>> In round-robin (single-thread) TCG, all vCPUs share one
>>> host thread, so qemu_cpu_is_self() is true for every vCPU.
>>>
>>> The SEV helper used it to skip the kick of the issuing vCPU,
>>> and so skipped it for every other vCPU too: a vCPU sleeping
>>> in WFE is only woken when the RR kick timer fires.
>>>
>>> Compare against the issuing vCPU instead.
>>>
>>> Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>    target/arm/tcg/op_helper.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
>>> index 6a673e5ae6e8..173dd0e5151a 100644
>>> --- a/target/arm/tcg/op_helper.c
>>> +++ b/target/arm/tcg/op_helper.c
>>> @@ -470,11 +470,11 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>>>
>>>    void HELPER(sev)(CPUARMState *env)
>>>    {
>>> -    CPUState *cs = env_cpu(env);
>>> +    CPUState *self = env_cpu(env), *cs;
>>
>> While rebasing I noticed I did that 1 week before latest ARM PR
>> and this conflicts with c5ec1bfad103 ("target/arm: don't pass env
>> to the sev helper"), then I noticed the previous 8def1f30d5d4
>> ("target/arm: hold bql when SEV sets the event_register") which is
>> a distinct fix. This patch is still needed but need this to be
>> squashed now:
>>
>>      -    CPUState *self = env_cpu(env), *cs;
>>      +    CPUState *self = current_cpu, *cs;
>>
>> Or even simpler, check @current_cpu in place (no @self local var).
> 
> Generally speaking, I think we should avoid use of current_cpu
> where we can -- it's an "action at a distance" global variable.
> If this function needs the CPU pointer for the current CPU then
> we should revert c5ec1bfad103 so that we pass the env pointer
> to the helper function again.

Thanks for the head up, I concur.


