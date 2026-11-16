Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5865606A33B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l4pBNdA6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JNBcP5Rk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Pc-00015J-6B; Mon, 16 Nov 2026 16:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT4PY-000148-K4
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:38:49 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT4PW-0005ig-Qj
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:38:48 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCJN52711022
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TRcK94MSgV4h08vJgaqISlYG4TNoJWnA7+QKeK8QBS8=; b=l4pBNdA6WtOShDbe
 3N1X0dVR3uonoMYe7zQdFU0lIAohEiz4cHYlyfMnHeZrDeUMEeURFetYM8iagD+c
 3xQSQYM0ob/t6CUrskZ6Q7vglhuWK7yCRWRZ6nLV4SVqAUslD123HAHfrqRcctbQ
 nypXjsyCNPDZqwWi8KKmfwIqtb/Ifl5UmSmX89r2YKZ8BpxI3F+SItssmraZJUKd
 4Uz8kSfB4hG5NERwJINUchrei+T9ktEQg/GxD8JtFb2r6bTerNAn89Whlzmm4fDs
 6DCXRYQnrwF8Xm4AWzENSA/c8S0BaPbxngHDyTlJTncFJ8m9W0rfB63kiideMy76
 +GfEOA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htg2rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:38:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so611543285a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865124; x=1795469924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TRcK94MSgV4h08vJgaqISlYG4TNoJWnA7+QKeK8QBS8=;
 b=JNBcP5RkcIqvQqCnpVoJJp5rAUbjaEqXJ+veOaWfCjeB5YaX8oSr1VBB9XcsA+9V/6
 MCjXZPRB62vmz0Wf5epbbSXk5rD/ExdOTbvYDcRh8eIjLc6GFbZvC+toC0Oue538MqOD
 8pAPGn+ZcuNPZApvog7sN7bh0hTHp9LVBsYy3k5KUPnbCtF9PJgFtjWa6XBNycPLeDqK
 HEbzZjSsOxQdWXh7TD+r0YE63erEpnMqQixV0sTLR3+QE+SL6nnJ+0q0JjMyXTRYP+IK
 ScY4+1VgEsS23NxDynTEC4xh2Hswb8UUEo9HRtD1Vka98bUmA2hRRJtr3fAksoH8LldE
 JCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865124; x=1795469924;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TRcK94MSgV4h08vJgaqISlYG4TNoJWnA7+QKeK8QBS8=;
 b=B3cFt6W2MqA2oBg36iBbjU447RvAf7O3EKloS3AqdnLMewnfoSX5Zid0AlzG1eNjkZ
 uHldIhSP5zhhrC8Rk+L6gyLdWT/gwIIc2oA0kH6NkeG0BblzBKIlIlOI80sqZNEoDIMO
 BZqsHujd/Fo4S2+XFd7TFdctnOoQB6aZ8/t6nkzKDl+DCDjOYXDNOignSdnaUI9n3fsN
 eMJL5cCTXwL5Hu6ok/Odz9k1oZptmhNTyB2Iog2fZIDFUfTDMsoT+mDpbg6vFTPnP/3P
 G+7Xkr0toYyHdKI5QlEY+MCS/GW3oVWPDTJ7ZoPTEklSYnYZEqUnwGV8TajYHby8zKTC
 j08w==
X-Gm-Message-State: APuU4Z8qMXKkL88EZvh/BaHQsQEUTh+ogNbciwEx8TkK0x4a0HHN3BXY
 xOGl37OtaXYhM+YYQ4TrnpfpduXoT9kvCeaScLH3PCBxjmXsU2U1RM8WIbVz/UcxcX29qUIwRmx
 fsyplkVi8UoFKIzivM4UlBrAgX56q0CrUuA4s6Vv396y3hKmL8HmGypnjIw==
X-Gm-Gg: AYBFou2aainiw/JLmgMGAlp9+d6ET+Vr27tdwRZayB2qs9xiRjHg8E8fMK9nxixof19
 BWg8ujdSX86SfDqb1RQ1cYxmkSkmoBCGdEEx8d6ASYiyM93SHIvwkWmjp3nxMEBrr3V8xrZgyrQ
 3UYNbqoXgCUY7ZBsUhVXgGs5/u6Kezlfc6l8GqcZEHe/Hl89pJPfSouT1XC3eI+bLEji1Q1Solu
 u/awSGAOC4uTsXTdVVSsiIK39AkOY389dVE7qx2UoeyEWICawNcW44OR91Jvl6DX2g2XA9LXsq2
 YEqiaPU2JsQFgiD2ITWUmoYAAgjqXqiqg6NnR7wB5v6ywfAIZDqqj8zn7qEAs4G+mYJlv6Qmpl0
 RaHJPwIth9EquZbWTFpgJsp1tJsnRi3H6vFJXSIJEezhEAIzVAvZ+Jr9vBuu+UE8InW3tlPOLpd
 lYqoSmxxA=
X-Received: by 2002:a05:620a:a78f:b0:949:6775:4713 with SMTP id
 af79cd13be357-94967754e97mr819396585a.2.1794865123757; 
 Mon, 16 Nov 2026 13:38:43 -0800 (PST)
X-Received: by 2002:a05:620a:a78f:b0:949:6775:4713 with SMTP id
 af79cd13be357-94967754e97mr819393785a.2.1794865123167; 
 Mon, 16 Nov 2026 13:38:43 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm43358161f8f.7.2026.11.16.13.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:38:42 -0800 (PST)
Message-ID: <97118f0f-40d1-4a44-8080-d6df1bbb60e5@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 22:38:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] tcg/riscv64: Fix logical vector immediate matching
 and emission
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-6-philmd@oss.qualcomm.com>
 <auOReLXT3EK7ITyf@aurel32.net>
 <8beb743f-41f0-4275-8baa-38e34e872f08@oss.qualcomm.com>
In-Reply-To: <8beb743f-41f0-4275-8baa-38e34e872f08@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX9G7BOVigDCrc
 Os3UsDDSJ5TvNdX73cQOaY2YIb5GFCWGhf/56YCz9ff5gB1L/ehktcN8U3C2HVvO3TBeZG21S4N
 FuVD6hxUulOIOPnJgbUVAZdosmYk9is=
X-Proofpoint-ORIG-GUID: 85-SsoJXLgg4mLVSRqF3b2Jr3wSYPOuR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX8hHkZwkqXrVv
 3rmHkTrG+8E0im5cmh/PHrjWhD0o+kRIApr8+ruE35hnuFkX6+xZ4/N5LMizYzGF9jbhw71SBEu
 LnDmmLNo0813XQPiqJVahmFW82alA5uFyX8dCKVL69WqM1F1CiTFp9+9vXshVD2hVPxgfH5Af4D
 4WxV+/fN++Q4J/uoPD3wEiq+NvZ7PEdWy+rJH72S5STAV59pHMQS5QRWRSE0rVvkVeKqemUEz/p
 C5Y4czA+s8Ql7YTmXRrC1JXzT65ojPupZchxnkuPmj7AePQRH35LM5nDdSOecS5jCrmRBAtfUYI
 vJxkBI+C0JJPoK2//9ciNmN/KHtkNT14ldstrRHURpD2ca5FROiwkEUJiNOPQHtCXEWas5hMJK1
 xhlpfP+2WfGoHsCm5u14P0naSuBBq1UVL30qT+0HD7XWa587W/swcdEkiO6CsRQgkT8Np9rwC55
 THtrS5s7e69na6PHxuA==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb77e5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=hXZgYZo4AAAA:8 a=U_ULVM1sZVwQ37B4evIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=37BJPeUnzxYkbV1yBC-1:22
X-Proofpoint-GUID: 85-SsoJXLgg4mLVSRqF3b2Jr3wSYPOuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160086
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30/10/26 09:08, Philippe Mathieu-DaudÃ© wrote:
> On 29/10/26 19:33, Aurelien Jarno wrote:
>> On 2026-10-28 15:33, Philippe Mathieu-Daudé wrote:
>>> and/or/xor_vec always have VECE 0, yet their constant was matched
>>> as a byte element and applied at the stale SEW of the previous op:
>>> "bic v4.8h, #0xf0" became "vand.vi ..., 15".
>>>
>>> Add the 'N' constraint: use the smallest element size at which the
>>> constant replicates, if that element fits simm5, and switch SEW to
>>> it. A wider element can't fit when the smallest doesn't: its upper
>>> half repeats the smaller element, which would then be 0 or -1.


>> I am still wondering why not propagating VECE for logical ops at the TCG
>> level, instead of recomputing it at the TCG target level. But this is
>> how TCG is currently designed,
> 
> AND/OR/XOR are bitwise, so VECE doesn't matter to the generic layer.
> Indeed propagating it would be a separate tcg-op change.

Reworded in order to clarify:

   and/or/xor_vec are bitwise, so the generic layer doesn't track a
   meaningful VECE for them (it is always 0). The backend nevertheless
   matched the constant as a byte element, and emitted the .vi form at
   whatever SEW the previous op left behind:
   "bic v4.8h, #0xf0" became "vand.vi ..., 15".

   Add the 'N' constraint: find the smallest element size at which the
   constant replicates; the constant matches if that element fits simm5.
   The emitter then sets SEW to that size. A wider element can't fit
   when the smallest doesn't: its upper half repeats the smaller
   element, which would then be 0 or -1.

> 
>> so:
>>
>> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
>>
> 
> Thanks!
> 
> 


