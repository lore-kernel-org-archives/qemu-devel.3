Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F08606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N3uAb78t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TItBCfLg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMASy-0007ri-Q8; Wed, 28 Oct 2026 16:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMASv-0007r4-00
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:41:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMASr-0004hG-Ak
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:41:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPJcm1942031
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 awXBHGvqWbYn8GyhNq6f8Jj03PU5qHpf9Ldg8qm2978=; b=N3uAb78tgBc5Or15
 ZXwNYfU6MLn/tVVnjoR6OOrhlzxP9d0VVMNGm5cKNl2tBVoJ5HRbitEO5m2eZmBp
 Qe9XKWmlgfaCVDTNjzQdOEu8SvBRwJ8xku4yVeQvznGMCcl/GGw5Ve0PnfM42XjJ
 k5DaiNPGJe+x8DiHcMv2NMu1k/puHiV3EZI0x+6nK1rCmmlvUPvxsziwyAzskabr
 bBKYIgT+fXDL+zgX0rfzgWcpqN2GT0AFd25JDeeH5Kn7QHSux/zXG1iroHAVZLDj
 D3ZVUsWK3qyO2X+C4g/UuTEfHW+dgcUhCdbcOVoBBos5F9KrONTiN/+GQSmamwVb
 yepADw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwbds8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:41:38 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so4035135c88.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220098; x=1793824898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=awXBHGvqWbYn8GyhNq6f8Jj03PU5qHpf9Ldg8qm2978=;
 b=TItBCfLgdNdYCMWKfBNrDLQlEkuD1b1Im7VzQuCbpBff0eJOy84+aGc+JM8zveTzUD
 GsWqt+heQRc7P8LfCgH8fyaaLJEPjF5cIP56tu4frqCChbOQBImD/nQQcalHGdawiEco
 M4MCBPFWKUpEIK/qmd0p75xXDVqV30Ha93wtAH6AB+xFLfDjPyLVueYpUwiIyCXVCsQb
 dq3NTYTsF7surltwxNf5K29QmP/eNOKuyEfWm5oz2zzBM4l3Hjdw3/cOPeY+13h1ZUxj
 MXVyFdB25jmrr/AVDI37PJkIp9PoEF76Zx9Bc6Tjqf9jmsLoJjHyabgIEmfETyVqdOmw
 I5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220098; x=1793824898;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=awXBHGvqWbYn8GyhNq6f8Jj03PU5qHpf9Ldg8qm2978=;
 b=Qou0geqUxFzDKX3yPuZCmqibPJugNnOjBsex+1stSSTK6mPGu0kVDgmlOV2zwlk6VR
 J5GZPoBfCVX68q9NfoHGyHmqpctEQHofMVrUjxLLbz/LWFRzqid/pY9oLViJXff9EKeM
 HHEvogx6tq9/taaiefWPcwmDOcQFGnJOV7QRMCJN2TNldbGAK3PGuRABVifz+xwBstUO
 dmvU3FPu7L80pUgbOw/4QZIm/lWDmWp72aa84Qm8mj3+/hP68o6ySvr5R+RkS5dwKejc
 uNpAYDj9IZivZatkVGLmsBRbvLVAXZah3vvCmfJ0vdEl7d8/3CvN/IaztIwYaBODZ65S
 2CyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrEBqc643Js8oofdhnWVvXxOo+wUuB+tXKQ0Q4JIuxAjTzsFV0v/V5+1MUEBNb8jiG7Iw0urUg6FuW@nongnu.org
X-Gm-Message-State: AFq9FYJ6ZYOBE9XQKnWg880w3G+GA46V5CK954GrtW5/2AXlpbDW5dEk
 o+mPu5c1+gWC6v+joGXxZ9+IMs9hn1+eEB7cD4FtJX7WxZQv4+xr86IHM6H+SdO97vqVwNUmU4Z
 zvUuOMtxF1nJMd6pNXlaVx3X9AkxT4zgHOIwwynYyfdaDsvqcXzUuK4On5w==
X-Gm-Gg: AYBFou3oVrHBkrJ8Ik+RDBaKxK7nLCZpZVloOsJJLt2Q3/u5kk9I3KZP/LCIkOuJiQ0
 kPXiTKOZu+m5Se6ii+hXM4aMnGK0QlDR1u0gfXOM+hF0gsWhi5HYecBa9rlusAdaPzQ2blLbpRM
 rsOa7oGXXHHsATX0dB+ncEMIQsJnx3Kr3DGtUgGTNyMkUc3HNHNMJOkCP/X2hi0/pO8pkaZAuzt
 /BayRfs+NHyE85oj6SdMUhhk5c2ZyBdHtrotSyo5boMWm3T+M06V5dRdw/0+2Bs2xoGhTgph3QB
 dFfwX69JRbxc152fgywKn/cCy+q9ydlpriMtUrKn1X1VttLhNY15cxBcDE3DiZWQyyxxuKcZOpE
 i1uZFocl5xPRQ24PnlFFLKAjO8kRkO790Vvmy332kzouhM8wYkVDsWWrW1Ld5KQLkGhR3Nfhtfh
 9WocgPyYFS6MDsSqQ4kGdt0T7Cn/C8X3JqpKad/b3Ngno=
X-Received: by 2002:a05:7022:f50f:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-1a6c84dc756mr4755349c88.2.1793220097448; 
 Wed, 28 Oct 2026 13:41:37 -0700 (PDT)
X-Received: by 2002:a05:7022:f50f:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-1a6c84dc756mr4755320c88.2.1793220096865; 
 Wed, 28 Oct 2026 13:41:36 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm14750292c88.14.2026.10.28.13.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:41:36 -0700 (PDT)
Message-ID: <7e6c2d31-9bca-41ae-84b9-10b6dd11c6d3@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:41:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] tests/tcg/mips64el: Move R5900 tests to system
 mode and build with meson
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-6-philmd@oss.qualcomm.com>
 <aff7564f-c8e6-4c56-8e1e-cd7f7613eefe@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aff7564f-c8e6-4c56-8e1e-cd7f7613eefe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8f0gPtTSBv9Lkx6IvzI7eEu7H1Ol2iLS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX5QbkJ5A0QGoy
 eDnPJ0o8ogBwr1wtPFbnWrHmZQ8UYu5EnwXBkuC8gXfeepRk2l091DDfANtEMblQwk5LWvVyOjP
 BvHoQDZ64QKvyNwmGTgDr8L+0B7PaTE=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae25e02 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=EgU4di2TmvYpUD7sGBAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 8f0gPtTSBv9Lkx6IvzI7eEu7H1Ol2iLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX13kJ6cVqAHWu
 RUkMCT7NGUrmdpCz4UwAhJsnp2V11BKBWc1cmLPwJat6aEwTZIRYhLI9GU/MOl12Y2s4utpYNlK
 F8QpYcHYdVrqoYY0llwNaV3Kyt7iK0/Bb5s/TdM7YUbYGBJHsDNrGRJT4jNzJSuVGvnCzrFob0v
 nJW8X1e7Zd/7+dP7OWaffjm/jdpqPthx3WvFWw6Yr9TSczoazvi6fvaOollUDWl+s9OBofJbURS
 1BuHb+Lculc7yG3ozpXIqttTLQO/9or2UGybBqGdBlYSu5Dv5qsfOmBxcUmUzscWCqSt3I6zzD1
 I/fxZIZp14zbtwLL+dR4yyzQouk+OUBeXW51Snv5YECKa2UWUmuLYPE/3ZhFdd/HaVJZv22yvb1
 wt4Y9z47QukvSe2kJ9EwSlMpxVpgl469vG9z1Buf5wXpt0BQGvb/cok1/xGdgRdispTpz5l2LE+
 RhXi9BePE5E+szuGUxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:39 PM, Pierrick Bouvier wrote:
> On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
>> The Makefile needs a toolchain we do not have and qemu-mipsel,
>> which no longer provides the R5900 CPU. Move the tests next to
>> the bare-metal harness, register them in meson.build, and remove
>> the Makefile and the obsolete README.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>  .../system}/test_r5900_div1.c                 |  0
>>  .../system}/test_r5900_divu1.c                |  0
>>  .../system}/test_r5900_madd.c                 |  0
>>  .../system}/test_r5900_maddu.c                |  0
>>  .../system}/test_r5900_mflohi1.c              |  0
>>  .../system}/test_r5900_mtlohi1.c              |  0
>>  .../system}/test_r5900_mult.c                 |  0
>>  .../system}/test_r5900_multu.c                |  0
>>  tests/tcg/mips/user/isa/r5900/Makefile        | 32 -------------------
>>  tests/tcg/mips/user/isa/r5900/README          |  6 ----
>>  tests/tcg/mips64el/system/meson.build         | 20 ++++++++++++
>>  11 files changed, 20 insertions(+), 38 deletions(-)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_div1.c (100%)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_divu1.c (100%)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_madd.c (100%)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_maddu.c (100%)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mflohi1.c (100%)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mtlohi1.c (100%)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mult.c (100%)
>>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_multu.c (100%)
>>  delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>>  delete mode 100644 tests/tcg/mips/user/isa/r5900/README
>>
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_div1.c b/tests/tcg/mips64el/system/test_r5900_div1.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
>> rename to tests/tcg/mips64el/system/test_r5900_div1.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c b/tests/tcg/mips64el/system/test_r5900_divu1.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
>> rename to tests/tcg/mips64el/system/test_r5900_divu1.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_madd.c b/tests/tcg/mips64el/system/test_r5900_madd.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
>> rename to tests/tcg/mips64el/system/test_r5900_madd.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c b/tests/tcg/mips64el/system/test_r5900_maddu.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
>> rename to tests/tcg/mips64el/system/test_r5900_maddu.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c b/tests/tcg/mips64el/system/test_r5900_mflohi1.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
>> rename to tests/tcg/mips64el/system/test_r5900_mflohi1.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c b/tests/tcg/mips64el/system/test_r5900_mtlohi1.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
>> rename to tests/tcg/mips64el/system/test_r5900_mtlohi1.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mult.c b/tests/tcg/mips64el/system/test_r5900_mult.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
>> rename to tests/tcg/mips64el/system/test_r5900_mult.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_multu.c b/tests/tcg/mips64el/system/test_r5900_multu.c
>> similarity index 100%
>> rename from tests/tcg/mips/user/isa/r5900/test_r5900_multu.c
>> rename to tests/tcg/mips64el/system/test_r5900_multu.c
>> diff --git a/tests/tcg/mips/user/isa/r5900/Makefile b/tests/tcg/mips/user/isa/r5900/Makefile
>> deleted file mode 100644
>> index bff360df6c97..000000000000
>> --- a/tests/tcg/mips/user/isa/r5900/Makefile
>> +++ /dev/null
>> @@ -1,32 +0,0 @@
>> --include ../../../../config-host.mak
>> -
>> -CROSS=mipsr5900el-unknown-linux-gnu-
>> -
>> -SIM=qemu-mipsel
>> -SIM_FLAGS=-cpu R5900
>> -
>> -CC      = $(CROSS)gcc
>> -CFLAGS  = -Wall -mabi=32 -march=r5900 -static
>> -
>> -TESTCASES  = test_r5900_div1.tst
>> -TESTCASES += test_r5900_divu1.tst
>> -TESTCASES += test_r5900_madd.tst
>> -TESTCASES += test_r5900_maddu.tst
>> -TESTCASES += test_r5900_mflohi1.tst
>> -TESTCASES += test_r5900_mtlohi1.tst
>> -TESTCASES += test_r5900_mult.tst
>> -TESTCASES += test_r5900_multu.tst
>> -
>> -all: $(TESTCASES)
>> -
>> -%.tst: %.c
>> -	$(CC) $(CFLAGS) $< -o $@
>> -
>> -check: $(TESTCASES)
>> -	@for case in $(TESTCASES); do \
>> -        echo $(SIM) $(SIM_FLAGS) ./$$case;\
>> -        $(SIM) $(SIM_FLAGS) ./$$case; \
>> -	done
>> -
>> -clean:
>> -	$(RM) -rf $(TESTCASES)
>> diff --git a/tests/tcg/mips/user/isa/r5900/README b/tests/tcg/mips/user/isa/r5900/README
>> deleted file mode 100644
>> index 18ecfc3bd0a5..000000000000
>> --- a/tests/tcg/mips/user/isa/r5900/README
>> +++ /dev/null
>> @@ -1,6 +0,0 @@
>> -This test suite can't be run at the moment. We don't have a qemu target for this
>> -architecture, which has single-float arithmetic, and custom 128-bit registers.
>> -Also, a specific toolchain has to be compiled for it.
>> -
>> -We keep the tests here in case someone is interested one day to resurrect this
>> -architecture.
>> diff --git a/tests/tcg/mips64el/system/meson.build b/tests/tcg/mips64el/system/meson.build
>> index 265a2eca4ff1..fd5a759c20fa 100644
>> --- a/tests/tcg/mips64el/system/meson.build
>> +++ b/tests/tcg/mips64el/system/meson.build
>> @@ -19,6 +19,26 @@ qemu_args = ['-M', 'none', '-cpu', 'R5900', '-m', '16M',
>>  gdb_test = ['--gdb-args=-ex "set remoteaddresssize 64"',
>>              '--test', files('test-r5900.py')]
>>  
>> +# o32: 32-bit pointers, 32-bit GPRs are enough
>> +foreach t: [
>> +  'div1',
>> +  'divu1',
>> +  'madd',
>> +  'maddu',
>> +  'mflohi1',
>> +  'mtlohi1',
>> +  'mult',
>> +  'multu',
>> +]
>> +  tests += {
>> +    'test_r5900_' + t + '.c': {
>> +      'cflags': cflags + ['-mabi=32'],
>> +      'qemu_args': qemu_args,
>> +      'gdb_test': gdb_test,
>> +    }
>> +  }
> 
> Just a small nit, please keep full file name in the original array
> (s/div1/div1.c), All other meson.build for tcg/tests do this also.
>

(s/div1/test_5900_div1.c)

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Regards,
> Pierrick


