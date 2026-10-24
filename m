Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=odlXK7pT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NVvVXxK9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKeb8-00009O-U7; Sat, 24 Oct 2026 12:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKeb6-00008s-1f
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:27:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKeb4-0001lm-9a
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:27:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0Tn22963406
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kX8xBQb6ECE7nzK8l9mIt4o8HmCWFZIL3IuoB0yM9zE=; b=odlXK7pT+OqPek3+
 SBJfbELDOAjoikbcbkzUFvEnOxfTJbv9wU+A/GiQn7MpZ3NIKJ0fku+VP3oebjzu
 6Upy3wGcq+iUHDLHzD3T6W6DDmld18KyM1+cxvjxvpPM+7V0iQilPFqvPsQnZqHS
 E/O4hQK2SRPPpS38FV4dTc40tDFRRzlwmjJQKnQ+a/v309hcv2RwUWA21bUFsxkQ
 CKMCF8flAio8oFa7Gijwfd7MSg9yvJWEguh8Lwo7AmoAew0DGciA7rJ2/AsM63RV
 DjUXkZyET69WT9Uou9VCWRElZTTs/Gg3d3aDWpFc69rb8U+CdOoFUfpCMhHwfnrB
 qOUp/A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgsnpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:27:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd63a7cdfb3so1150545a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859271; x=1793464071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kX8xBQb6ECE7nzK8l9mIt4o8HmCWFZIL3IuoB0yM9zE=;
 b=NVvVXxK9x4rujCtE2FPw0EQT0Ns9imXoBYiFv1BBhN/LM/+qHFqk4lhdb0YCIm9W8s
 gRi94Cjx8uO+ljoQWsXWlZ2HkufvurHWz35KKTT7r9mCZrc+FQ5fxKbM8W5uxdnFzYG6
 Pc93qc97p5SaIvn53pNn8ZR5h+m4UnWyPJh9rpjyvnoSkkEG7XvXV2MFXIQd6V0C44vv
 7R77+sBMna8jU5OVhPOWOm1rDrxKYm0t8p/tjb7YMf2Wir0oxVc177dMLB6EjBZV17vu
 vkg7oeSlQYqwdPCaz8cbqgsyvvNQ6WvVHp4Uv0xzf19eDb6SM5BB25lB3FUfzcyv6U/2
 h/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859271; x=1793464071;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kX8xBQb6ECE7nzK8l9mIt4o8HmCWFZIL3IuoB0yM9zE=;
 b=Si8bytrQbmgc8E/FszdFAsfiFwQklEzm9u/5HY5eSpGrbwAfUnt02fsyTiFYdPnUXF
 L2ePWDZSKCD3OQWxZk78gZwb51oJib1ytmXRMXpQpypwkLFAtz5DQDMBYY9WBFAjM2TT
 JMv51BbUgoaR9bUtgtCQOB2zOA0St2k3qM0h0KU0685f0wYWv+VOieqmnobndRVQQeDY
 fOJ8kCfQ5m3cAzfVsJ8I8ITKniCvZ5cfq2jI24NOGv3sU3iVDDfl+MV23Okiw3j19aHy
 r4oyh2FwqtLANcmpCrIPTCu0grs1WBhhvqtTbw1sjOjvGCKR35ydR1O5UfSCzgOpY/Sg
 nlOQ==
X-Gm-Message-State: AFq9FYLn99+GHfe1hvv1yckkFBZkSEmtSErBVeAqV3Ka7usvBJHQx9Us
 tC3BHRZYQJ62+qsDmp8IJRQ9BzdAM0K75A9nEhN4ksRH9+/rK5H3CvpyOLG/SZjBZA7cT6l2tYU
 U6FqN81eknUssnwYd5CMkmpwOHQagV800RQ8Z1Fp8MqDdrAoWx6makGERyLGigVniyw==
X-Gm-Gg: AYBFou2y0MV9G2IkqoyooWviKbfbtWcyEu/aAcR+KPIMMnT5nhgCnC2cEnn10czjYn9
 UT5PuCixO6ecaVrMBMEDt6ochV9cZmduNzqoEDoHZDhaXJF5qDje4+YxscwCBhKn8V1fRcQHCig
 qzSGfTyE1i2VlLZKIcpDVLDHAIZsrkMbuaZAmENfAwRPYXFCIQUDSuvejiH3ArfhlktsMy7ILEz
 kbvWIQngZpNBRb40SBmWN1T91XcjLliJxdoEf5dqgrw85UKA+g5vn+FQISy86hMRAXZF9PAaGeb
 /6+IZfXTNU6nvXtrajXG26c1O5Bkzdf4ctC8wEkT5sS3LMqpTGM/E6LH5m1slQZKJhUXM35IFH0
 xN0F96HI+mZ5LWfmO0mAOY/YwbeRMDHjAvoKjSlThcnh4jvc986/+Ko8s
X-Received: by 2002:a05:6a20:914b:b0:3e2:6e7a:bc13 with SMTP id
 adf61e73a8af0-3e7cd4d9f30mr1806152637.79.1792859271039; 
 Sat, 24 Oct 2026 09:27:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:914b:b0:3e2:6e7a:bc13 with SMTP id
 adf61e73a8af0-3e7cd4d9f30mr1806143637.79.1792859270525; 
 Sat, 24 Oct 2026 09:27:50 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8cccbaaa9sm505497a12.23.2026.10.24.09.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 09:27:50 -0700 (PDT)
Message-ID: <8423d93f-dbfc-4c72-b04e-7ffd4b560360@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 09:27:49 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/tcg/loongarch64: fix hang with
 softmmu-gdb-memory test
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX9+Jy/zDJjuPH
 bpfydfIezjUkZd0LaQqPoRLR/hv6LFD1vkbrgilVLiVtiswmUvjJvPVJ3TLKSfZB0yZSGIIlfjF
 0qkwcszwEmeit0oXELiKMXXvv19b5VE=
X-Proofpoint-GUID: A8J-7UtApocM8c-zGHveXSUKuIbB4A_c
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcdc87 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=lVb498s0PqZPE7WSRGgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX630IMqpr1kgE
 uZ3ijhPitnK8bIIVIEXaOPeO59Jck9J5aQVwUwNvFhy1ncTETNcjEmX9AX8puLde/hicLLH1kMz
 ye1sA7P5JEGCNDIvvECMerdskNJqgq5CN7R4POETVX08V6lySrdFgleMFzX6NDa+Hx/AiGhp7CX
 hALT5czV2ze9V+aDBj0i1xX69mc2R40cyV0RkASH8AUK47j1hQnVyyP88yRzExBbLFFcw5eY8qR
 IyQdWP9rdkKHCKrRS766s8E0T0T8T0/bdm9/arYVJo9Fpop2FUKWm/PFGI2by30ySWBe1MlpZZx
 Zce231j2CMJuHQxKLIymtviDyW+x4WR/HmVpqOJYJansMRWYmoKeT1P854bcr8z4+2AVKsJEsI5
 sYGGaaHBTr+yqEIJQaimufcP5GysjbEQIgLTmPTkBPyXdaycCdro1Kga9R7zYN4yXIwCV8GOycu
 8sXfl3GUdIpjWZem7jQ==
X-Proofpoint-ORIG-GUID: A8J-7UtApocM8c-zGHveXSUKuIbB4A_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 1:17 PM, Pierrick Bouvier wrote:
> This series address an issue reported by Peter:
> https://lore.kernel.org/qemu-devel/CAFEAcA846O2jbpDvy+zUnxrpfxKLQpjhHq14zBOGQMC6caXOJw@mail.gmail.com/
> 
> This series introduces a minimal gdb version requirement for loongarch64 gdb
> tests, due to a mismatch between target definition for our gdbstub and gdb.
> 
> This issue was already exposed, but I wrongly assumed it was related to host
> (aarch64 vs x64), instead of gdb version. After reproducing on a x64 host with
> an older gdb, the same problem was found.
> 
> Also, I added a cleanup on top that was on my mind for some time.
> 
> Tested on x64 and aarch64 hosts, with debian stable and ubuntu 24.04.
> 
> Pierrick Bouvier (3):
>    tests/tcg/loongarch64: restrict gdb tests to gdb >= 16.1
>    tests/tcg/loongarch64/system: reenable gdb-memory test on aarch64
>      hosts
>    tests/tcg: remove global meson variables
> 
>   tests/tcg/aarch64/meson.build            | 46 ++++++++++--------------
>   tests/tcg/aarch64/system/meson.build     | 16 ++++++---
>   tests/tcg/aarch64_be/meson.build         |  1 -
>   tests/tcg/alpha/meson.build              |  7 ++--
>   tests/tcg/alpha/system/meson.build       |  4 +--
>   tests/tcg/arm/meson.build                |  7 ++--
>   tests/tcg/arm/system/meson.build         |  4 +--
>   tests/tcg/hppa/meson.build               |  1 -
>   tests/tcg/i386/meson.build               |  7 ++--
>   tests/tcg/i386/system/meson.build        |  4 +--
>   tests/tcg/loongarch64/meson.build        | 21 +++++++----
>   tests/tcg/loongarch64/system/meson.build | 17 +++++----
>   tests/tcg/m68k/meson.build               |  1 -
>   tests/tcg/mips/meson.build               |  1 -
>   tests/tcg/mipsel/meson.build             |  2 --
>   tests/tcg/or1k/meson.build               |  1 -
>   tests/tcg/ppc64/meson.build              | 11 +++---
>   tests/tcg/ppc64le/meson.build            |  5 ++-
>   tests/tcg/riscv32/meson.build            |  3 --
>   tests/tcg/riscv32/system/meson.build     |  4 +--
>   tests/tcg/riscv64/meson.build            | 10 ++----
>   tests/tcg/riscv64/system/meson.build     |  6 ++--
>   tests/tcg/s390x/meson.build              | 21 ++++-------
>   tests/tcg/s390x/system/meson.build       |  7 ++--
>   tests/tcg/sh4/meson.build                |  1 -
>   tests/tcg/x86_64/meson.build             | 10 ++----
>   tests/tcg/x86_64/system/meson.build      |  6 ++--
>   tests/tcg/xtensa/meson.build             |  6 ++--
>   28 files changed, 100 insertions(+), 130 deletions(-)
> 

This was merged into master (9963acf1930536e8f67a2ee4b2201e6187ded93b).

Regards,
Pierrick

