Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F8606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MoZhsg0B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RlveXNh2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ3L-0004hY-ED; Thu, 29 Oct 2026 01:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMJ3K-0004hB-1X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:51:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMJ3I-0001Cl-3J
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:51:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5Hsfq178767
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ebfa5ckWBXEBj8MVhXu2Bl7EdkhG8Oe26xAbSNcP4Gg=; b=MoZhsg0B3dqWWop2
 QXcq2puU/DlSMlGkRmk31E/qWsCUbyaH/1twiWEkk2SgIof0/sI4xf24N+UHDlB4
 n/YkJhIjOPfTHTXeVfuG4jbYFf4iEng2QSGH83G/aouI2HTRI+gDO5R4y2X30aq/
 HBzUx0nxQQr6XhKa6hbaRAO+C1ALGx0pQrZ1iDLVN7ue4lILLpkj/1eURkjR/gnj
 RPrJa6BAiaK6rIuC+aFBl9wX8+LW59a2Sj4DcvgBy0YVrymODlhyDKvk4mx/PZfD
 vzfxel5y2JkCcQ4hL+bShrXib8fASafmOvDDJwWbjanqm2ZWaZrTGv00AzODjYcZ
 BFFX1w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehu3sq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:51:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd67d4bbdffso1341327a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793253109; x=1793857909; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ebfa5ckWBXEBj8MVhXu2Bl7EdkhG8Oe26xAbSNcP4Gg=;
 b=RlveXNh2rr8wH6BRe9l6U1/Ykc/OUeXjYX+vCw+2pOXgDSz1yqIEAmYDiDoQbNxUo8
 V52ZpDOoO26gGLkvGa991fNDtZS+9dXFHdo+udqFtpwCXtDBtuHXyJ8NOUhTATnVQgVU
 X2REr9XeehunoA5sqqGmTfeIOO4ajK4Qn8GAWBKYc00pHGmCc3F42BwkMtI3asBacT7e
 D9fTysbWqjg1ppDagMUAkAIWZG7bVZATfwtBn286OJm79h8ZtAkxYlysBd0ndkAIsBpZ
 Lkk+0lzIHRqAUIfBukCviOy2qMvApf95trWq8+XssnIDNWvHaeji/VBfeR3rG4JRlwbb
 RNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793253109; x=1793857909;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ebfa5ckWBXEBj8MVhXu2Bl7EdkhG8Oe26xAbSNcP4Gg=;
 b=XUVmKKLUhEAIhGFk5c3eOLWfg9AStrcLY7dRnYoEDrXk2pvSTDalItpqCZmW6UYfT5
 +y08t9+PLZQCm09da7tdIR3TX7vSSHZ4+Zptdptw0JbWyOEzdaxVxYlhH467iyRgDOQV
 NtNvBAe1xrMmPE2Kc1TYpC9J8zpVOuMG41a0mWhb7666UTauMZeQsOWgrgDV0KiYkuUk
 4xZt/ToawlFAiQMiEx8/YuK1O25Gc8mpBN/NyfFQdhbKW9SAVPJeKcV0vUuglTYG4xzB
 6nvhrBkUPFXVYfm60+zE/qmIyyPdohZyu/V+SGilDo7ln7yhfo+gBpdEurdgjXfQOwEM
 TDnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFj7rxfLtqiU2iJvBuH0ungA6VhnUgrauz84BG6cT6suWm8HqcJc2+dJdIx4yllKYtj0iCYr32EuaO@nongnu.org
X-Gm-Message-State: AFq9FYKq1M66PtZLqO/wFyrNqFSUcAtj2+LxR8nSrelW1aI7+mwXEw/+
 PI74TnEWjkADPFbQylPD5L5zEJzAv/OshcrSL4IjBadioNmtyZ4ntprxPgIYngtzRtxwEmIl3a5
 LUvo4jA/iuCAEv3RYsnv4QPXXVhPcq4I56mM8+avJtsa9s33ynXw08nYnzA==
X-Gm-Gg: AYBFou1NOsr6oK9ceTEzRbli6KdaN30kc97b4pjr1Zt8XG28afH96z2ZDhQ3tsSDiLo
 BkCDe4XgA0QMLQt3+oZAl5gMjlwRN/EV8aNf2itWSYefjW82UJ3ZfIEUWjK7ZGxueL30l5ocSdj
 sXXyx1QPE1dzTLnpIORpdtNX9FvQ3216ho+tVZ/ereuvEJ9leNGE9o6CeWjsSGGnDesgtdlANl1
 VboIOof7IgK3eMFcya6U0xLWNE8USUJPte7aj/sQ7zBCU3Ppz4xvK1ZSkfykmIVxgDi3M5RgJsU
 DmfSsYP0KBQo2WB/7emrPXIF35e43VH0m7pB4JMBTX2ssowW9HLF1OHWoOI3TezCQkUmdhsCKTq
 ou4mj615xeRFhGXJPGo6wsHPoo6Hiu3PQYO/kDLr9c5IBGh1+KY/HuOs4+nG7XHUPaUKjIFOGrg
 ReReuN4eaiSSyuu039fIsBMJSGUWPaOg==
X-Received: by 2002:a17:90b:1c01:b0:3ac:53e0:4ed5 with SMTP id
 98e67ed59e1d1-3ae5829978emr3719141a91.39.1793253109288; 
 Wed, 28 Oct 2026 22:51:49 -0700 (PDT)
X-Received: by 2002:a17:90b:1c01:b0:3ac:53e0:4ed5 with SMTP id
 98e67ed59e1d1-3ae5829978emr3719116a91.39.1793253108807; 
 Wed, 28 Oct 2026 22:51:48 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e7d429fsm2439940a91.2.2026.10.28.22.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 22:51:48 -0700 (PDT)
Message-ID: <8628b8e5-7138-4f2c-bd32-ce8a8cb9acff@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 22:51:47 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system) +
 sort tcg tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gustavo Romero <gromero@redhat.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
 <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
 <4ef98888-b13d-4033-aa02-f48482fc0b7a@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4ef98888-b13d-4033-aa02-f48482fc0b7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LUOzU4oQ1qApncv1g5IA_bi8W1gfzaTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX494d6V62yXAE
 RI0p7skrqYc2JvVL8MvXO6QnYVYlB13WY0xcCnDWbCmten4tBZaNPMXN3e500O6RXh/rBAceP87
 nY5K+bpQLVZZk+jiHuE/VB4XMc6TZ19bYb+tVkh2Bq748HiH5XU1SZ+9rbaIpfMu1R9CiGQIS2L
 hBpMfr8X0yY050vAQQJsMOijQGDwk/W+T/kC5c0mKXgggKFA/H/ZnP0FibOdS6LDjOOYj5OxkNA
 PsBaPqx7TaZNHOz3L+gYck7ynx8W+Swcw9AdnODhF+5nUBNkYTHL8Nk72G8BaALez3Hs4B7jG4y
 CeV/Yple0q24dXlJHHc5leY9jbg4OUasVBtISDY+qNbyRdGFWXKTr4VfKqsjtvDyomVTIWvhd7o
 MaOLHN7+ItszvG12uCGgaJhNrYyutmwpNjC1e0sjqNgy7uDONdLMgK6SR7T7BMBl6WeIRJ5YqHL
 y4Aa3Kr5ARFaN0UOdow==
X-Proofpoint-GUID: LUOzU4oQ1qApncv1g5IA_bi8W1gfzaTM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX8HqrTYevUf74
 F1TKqLQmpLFWLQn8TmluR7Ba6eL8+cAGYKHWEBzJkWYBnYH9jtRhCE5pQPx4LTLHLysHsN2cnSz
 u3yXoEJjVyj1tvLQFPo96Moo2NgTr8E=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae2def5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=3Jz2w7hd-_ZXcnSlHZkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290021
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 10:46 PM, Philippe Mathieu-Daudé wrote:
> On 29/10/26 06:39, Philippe Mathieu-DaudÃ© wrote:
>> On 29/10/26 06:33, Pierrick Bouvier wrote:
>>> On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
>>>> Add R5900 system tests, code is covered, CPU can come back,
>>>> allowing to fix a bug on PCGT opcode.
> 
> 
>>> See some test failures, related to gdb:
>>> https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/
>>> job/123131480244
>>
>> Ah hmm I had similar failures due to too old gdb, I might have
>> missed to check the version in that container image. IIRC
>> Gustavo had similar problem with ARM I'll see how he fixed
>> that (I suppose check gdb version and skip the tests).
> 
> Found it, this is 'gdb_feat_version' :)
>
That's the right way to deal with it indeed.

That said, the gdb used in this test (on GitHub) comes from debian 
stable, which is fairly recent (16.3).

Is a more recent version needed for complete mips support?
If yes, I can update to the latest gdb so we can get full coverage on 
GitHub. Meanwhile, you can find which minimum version is needed.

Regards,
Pierrick

