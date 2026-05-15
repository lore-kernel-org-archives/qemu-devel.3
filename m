Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D26CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwFC-0008Kp-79; Fri, 15 May 2026 13:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwF3-0008KD-AT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:22:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwF1-00006S-Cn
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:22:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGTRnP3552376
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VDUGGRLnPallEskdhXeIRrVk1EcxEXU7Eu0dNlaiBVY=; b=gtVgCh3i47OI6vuQ
 4a7O8KpMEWHbDakpvFuE5Rji+VlqiRqY9iC5LA9M122nbzUzrl3M1QoevTvw/Fi3
 tS99Qqdhwm7Ve6SEEmC70+cl2SMzwKiD9w+I2ZVSjrmRIKG3GiCrIFzJDv3bFDlQ
 MkOiegcK+uy3S8PrAr6hdhqrh5qxHGWvm+QNidKiAnFrpN9INRxCBIkIsJcK7eZY
 Zvlp+wcc1tE26rT/pJSxnF0pjqYgdDtBDpjYv6Fir8gctcfiFYsOmf9DTB7YJcJo
 km1DBEXeoJi2TcIEW03Aogq3CghaX4e3Am5+EVcx6sSubmrI0iehKmdV4CYmUkaP
 mKK80A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e672985h5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:22:24 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1306c2f7037so1751c88.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865744; x=1779470544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VDUGGRLnPallEskdhXeIRrVk1EcxEXU7Eu0dNlaiBVY=;
 b=E13fZMOWxXrYOLlabTj/d8CYDeCMzAIBVtK215cuUMjJ7+3K5NNImYPbL53VjW2HYR
 UwgBz2L+mYOvmXXtghr0+VRjYqAkO1OASIpE7dWm8R9tIBxGezNbFFqISiJuTO2Rw94F
 utQD0lfDBiFF3ku3dLfJZPFAY6xpHdtqb6ylwMCtj9sloKvP4UvFIboVPo1xszuW5TU6
 2V6DYxf5PIeYjUYqi8yLUsD49NIjV8qqEcSF57ZB+Skvxzj/pDpnwfkC7Sx7yzre5INX
 YNrj0mo3TsICxU4M5njj0q4AWUM/FW+4b5muOaFkYxM2gj9uJpqzEijEjoBOp2eFuWpR
 y1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865744; x=1779470544;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VDUGGRLnPallEskdhXeIRrVk1EcxEXU7Eu0dNlaiBVY=;
 b=lFH4Y1q1KCFzLnECWQESLYEyYUo1moaBMBFyENS3nX0PvYgI4tpoxr9LRo9QaLH1qu
 IfBvb0MmYXAlX65Q4HcLjIKWeqiMb3u7bi1a40YIa4caA1eoHc4dxpu52ZbPLe4Ic5h7
 QOk7IZqwg5NVGDraHv8tyzLKnYeEJ/9Ik6IAKMQFOTtWVQ950R5wXvCAuqMfcaZawqjl
 DZuoLhSBd0++QTdbFa7cYxLo/i4NBe/uvF9vfE1qjWm+79pzAClAVA28htjm3ngngMGu
 +nv78POJeixQ6Dj9OC5U/JzoEd1PSf+O9+p+kxxtsMb8eXitlrtnNq39HJvtO7S1BJwh
 8XGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dmQvYRFoJ4yyFOnNqHGiUoBaPpSl01Y8MNIlp8re2gAdWPGD3e0IotN6FYI67Kklqv+MVtH71smwa@nongnu.org
X-Gm-Message-State: AOJu0YzSxOCAhAXL7xn1yu/WdIgueQmsBhUOR5OpIXiIQhptOs0Io5En
 CcGxzoLOCyIOKoE3KeXkTvD2IojbcacGDy1x4vW4wWVyqPXX/1D/rBt6vucPasSEY60VHUJdKlp
 GcfRziWpKN7ZDU2KZzJ9RnwonmMTLETQW8AtkI4KYehwsUq2lmBlNVYiQOg==
X-Gm-Gg: Acq92OGFb+Crm6hKDULVK/cWxicvFeQ4pbyBuxOLOpQKe45k8Ix4GC8uG0WpI6gC/Fp
 wKBt4UmzOq9zJdNacpdO81MePmkErlf1z33RpsFdPQ+79zR/KWvoavVvoI3EUiQ0db++AN1RjXD
 r5au3fPMsLO9CH5Fyw28b5BhsVdlsch8iL9QXrjMKFlfoQGw2x3JBiyRTu94lytGZF2Hx7lTKyI
 IfSSsyi2bD3jWMlhxWz65G7iss85X4PbNTxlfHoVJK/j69w6knlfVUKr39b/gYQ1+x2tm2IW+xl
 1Qaqplqg2FWukBrqbsDhl0xY3wuDQiu46jNVDMZZs2dA2JpqExTjriyQ/BX32anhdsBIaXO7fTK
 GrLKDgg04q0Nj8zNYb1A3FkADmgrfdNDTNUnHoRCaPHNO64nBks7gX1OJzi/UNp398cXkwQ/8PS
 Csu/pE2alrroFRgQ==
X-Received: by 2002:a05:7022:f9a:b0:132:5d31:dcb4 with SMTP id
 a92af1059eb24-1350483cd3bmr2218153c88.23.1778865744285; 
 Fri, 15 May 2026 10:22:24 -0700 (PDT)
X-Received: by 2002:a05:7022:f9a:b0:132:5d31:dcb4 with SMTP id
 a92af1059eb24-1350483cd3bmr2218131c88.23.1778865743665; 
 Fri, 15 May 2026 10:22:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33a67csm10408832c88.13.2026.05.15.10.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:22:23 -0700 (PDT)
Message-ID: <64a611a9-a509-412b-8ff4-5bcd85348b97@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:22:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/20] hw/arm/aspeed: Initialize 64-bit CPU types
 during DeviceRealize()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-5-philmd@linaro.org>
 <e8e1d0f8-b5b9-49a3-9478-f58f72e962e7@kaod.org>
 <99983366-9174-40cf-a158-a663daa7965f@oss.qualcomm.com>
 <3db1823e-bdb3-4801-81a0-dc901bf75655@kaod.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3db1823e-bdb3-4801-81a0-dc901bf75655@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NyBTYWx0ZWRfX33rlzUKqDhuj
 CU35w8tHn6EtPKwk+tWvFQ3Pd1Jiq0/7LIyvMbnneCi+o60zu3W4m7KxAZALtZzi5ZXIk5Ic8/t
 e0ewoTpju7TdSHjWdWUsqHhPebrY9Ha3mcK671nvZ90BSJ0BE/kNhXA4rA7XRQevy6r9kR2zcy8
 8T+KWL1Ee7wE14N/1k5r1ewYHipeS08t7GdrQgAQTdJ4Rv3orq71HeKMeCf2Z/tqUhAJy6y/QkP
 H6sHuk05oxwQZ+2OybMwEuvyAJHi4glXYAbSJnjy5yyVF5LHrAtZ/ab/BshbSF27rUeXgeZBAdU
 xTyGUCqrfuWyJ3GLn40Jm5f6KZE0pUigSKbVf4Ao+13a/DpBkhZGmzhS2CdwgqcWt4WIG5aKjJL
 6CHB9xLi8hQApRSHrF5nVIvRFnBOX/ih7xNxLjreZlEDynO1SGf1GogHd5T9fZ/NFQxTkLPN/Fn
 ZbOPfLp4Y0d7xkEhx+w==
X-Authority-Analysis: v=2.4 cv=boZ8wkai c=1 sm=1 tr=0 ts=6a075650 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=d5BFOicfw9AJO1EOJmYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: 5g7W5bVFzsJmU8c0Rsx9aCAZphBfH1FR
X-Proofpoint-ORIG-GUID: 5g7W5bVFzsJmU8c0Rsx9aCAZphBfH1FR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150177
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/15/2026 10:18 AM, Cédric Le Goater wrote:
> On 5/15/26 19:00, Pierrick Bouvier wrote:
>> On 5/15/2026 9:29 AM, Cédric Le Goater wrote:
>>> On 5/15/26 16:10, Philippe Mathieu-Daudé wrote:
>>>> aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
>>>> CPU (Cortex-A35), only available in the 64-bit binary.
>>>>
>>>> If we build this file as common object, these SoCs become
>>>> available in both 32 and 64-bit binaries; however when running
>>>> the introspection test on the 32-bit binary, the init() method
>>>> tries to init the Cortex-A35 type -- although not realizing it
>>>> -- which is not available. This can be avoided by deferring the
>>>> CPU type initialization to the SoC DeviceRealize step (this is
>>>> safe because nothing uses the CPU type before, only the GIC
>>>> access them, just after their realization).
>>>
>>> I understand this is a qtest workaround. Could we introduce
>>> instead a (qtest_enabled() && 32-bit binary) helper ?
>>>
>>
>> In general, it exposes a dependency issue in QOM type system.
>> In this case, we get a class depending on another one through
>> class_init. Moving this to realize seems like the best fix.
> 
> My feeling is that this goes against the best modeling practices
> we have tried to put in place over the last decade.
>

In this case, adding the workaround you suggested might be the best
approach indeed.

> C.
> 


