Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842ED606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A+2hS8uf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TZqcJRtF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAR2-0006uP-Ij; Wed, 28 Oct 2026 16:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAR0-0006uG-QO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:39:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAQy-0004QU-Po
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:39:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPN9N1898351
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CoPnQOBXP4syJiWw8mpWECdCrNzhvYmOwP+T+HiKKxI=; b=A+2hS8ufCM5ulO5K
 9Zp1K7YAUJttF8LWBdZnIPhaIk4s5/AiM4tKKXgx0Q1MJ3h/KxNDOjkRYKAaHJnY
 F7wPWACOlBs6HSyjAROopGMi9MPVkjGTdNRQwdtcjvl80lSWkzAbZ6UJLvG0vOZP
 tsBcooMQjrHxF4THJsiBMuLAECufKRuguxjkETp8bZMBYGmEkRIBs+iPeH8/zMZ3
 UjytBfOoVNoS0Ouy18z6FZo1xH7YchAHODq6+bVbJADcQ0ZPHLG9Md1qbE34GtOH
 +7noVG1qMGGgiwUjeu6T6AFeysPOhAe79zUOO4Le5jg9Dja0H3r+K2siAiVyyb12
 Eb9TdQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkfehjey4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:39:42 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14373747468so1580927c88.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793219982; x=1793824782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CoPnQOBXP4syJiWw8mpWECdCrNzhvYmOwP+T+HiKKxI=;
 b=TZqcJRtFTso77vT+Gu0x/Pu9RXNg+4I68+iZIerndiP3fdtXQZ5496IBn5ka9s+xUg
 XKq1NSeuXFMepZUubD5Gipxh17lfuZ+vIGdtuqqGM4VShSxhEX1HckOoOCT+F7FpeeQy
 HNcjMwOQTMmaONYc0Ej60M4FWXD1Zs04W32o3sDr8VmMd45zweEWlwcyac3puj0xkHY+
 XWWEiAO4BtDEool5cuErX71pWr07zcbPIOaJUCdTZjbR+AqEEkeMsqCC2ELNs03xwHkr
 LiZvTmAS9cYu+XOt2j4fEhhRnhYC2BF5HnXeY5QkK5fUImBkPSCaeKsjy37sgOad0Mmu
 d6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219982; x=1793824782;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CoPnQOBXP4syJiWw8mpWECdCrNzhvYmOwP+T+HiKKxI=;
 b=RBs75BtPXHVkte8MPf2l21F9MRWvzpb0IeJA6JBf1cmjsSyl9xgjgCyeS1mPpMuCaM
 15YIcxJMadHeJ03kBcTCQhYqOkV4sghR/Rdb8vaMroG1t4sTKlMtmq8rIhh/uST7/125
 AGM/LXThkKhXebKrtCM4aPtW6hqoYcBOUv/gmapyGnLRYn01Rs0R07xmOtV4BqEQVzPN
 n+t6zUdCsuOisRUonXulkjONIUILzUBWqPfEtEl/l/CllXfw39RCza0DLWuRt4pJnMF+
 UuDfU01nfEV3D4OjEkCQDJ+qASOSmW1eR5UUvWkjwCBqHjju/hvb20gq2zUGsochL4pZ
 RHuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKOMLdMxzTGvemKrP2Lasu0KBV+OnQDnEHOBGVKwq+GJsIdFveCtE7+WWOTij9EIGK8IV19Ikf7TYB@nongnu.org
X-Gm-Message-State: AFq9FYLmkjCz/+pUaC63hXzKSkFtOiFRgN5Jlw0u9AtjhJBR5olg226p
 tV/cmgCR9cGfmcly7f8ueAQ3cwMhBG9rLlBIYZoR88jbLrVKtjQVAdESIomucgGX1nyff3Vn8ZV
 1R8EayY232o4hSmzbrX/ZJIMz9uDP8pkga8YBa74D8PTUBr/x4qbZPJIePw==
X-Gm-Gg: AYBFou2uIeHIEoEY4oe3G9BdNg1KffPwQpiMdJb7cpsAeZM1squVmw/YqPDLes/o5MW
 nhG6LLUJe9x+fCCdV3n9/IlfJ2ahbcX6RD9/6YHQs3N+knSncRoB20TdQYEvTSUcBzkL1RF6sNR
 gK9KJvSxsQ0gfqmW+lo/vjflpFCkJvIH/PpnWyIVOC7Edu5Y6DvxkBYZTJateme1+u9MGNV3GW/
 XXmJ9o3GLtDWAn6OE4F/dj8bwFQT/rji+nlig5JzbVDt7qDyoxF6aIz9oPEdyLhnUkKubsx5Q3C
 nXzH+L77SckqwgQlf0o/zBnG5QjApttSIW7SZsduyo376QNfkE0gntiBQcGXY9/zwiVo+VZe6bY
 Xb88lsNk+cT0y7rXqogHuDg0ebaDg8K87AeaxSz3WjuxRtAtA3gGBTZh2AnNLDB24XtNuMiAWCX
 yr+Rf1OEl7mmSyEWzwWh94iZQmsEmryvJnH96q7sWlS5M=
X-Received: by 2002:a05:7022:6989:b0:187:cf46:4c51 with SMTP id
 a92af1059eb24-1a6cf72a70bmr6008425c88.31.1793219981896; 
 Wed, 28 Oct 2026 13:39:41 -0700 (PDT)
X-Received: by 2002:a05:7022:6989:b0:187:cf46:4c51 with SMTP id
 a92af1059eb24-1a6cf72a70bmr6008390c88.31.1793219981312; 
 Wed, 28 Oct 2026 13:39:41 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a76037e2b5sm12774045c88.21.2026.10.28.13.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:39:40 -0700 (PDT)
Message-ID: <aff7564f-c8e6-4c56-8e1e-cd7f7613eefe@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:39:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] tests/tcg/mips64el: Move R5900 tests to system
 mode and build with meson
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-6-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX2fdekJnyVKVG
 GUUslBqhIaVHqduCIClFqacKboFwo7R+d8Q/Vdn6VgfQ7zzr/1vGmG1PbrdrZ2s0FAknk5KF5Yq
 Kcgw9QcLBsOtJ+SY1GBAQhY6zkL98v0AI9WccuOHQe3chwNq5cmK9ar6QpiXRTx/isKfaFC1fRn
 Gsjt8TdwZeesJ079w7NRie2cnI66wU6eKjdr36UW+wYX97DLUgHV5qf3JoUk3zmm+aqk0JnT5uG
 1Fgd4gHoGLX1OVuxfu0ZHmHVTh4xdA3mawFa1cr9/frOIrp93n/trHwU9IPFKsDKFh9TyA3FPF8
 PUv+3/MJpOHiyAk1843xtTPHTngIZgOBnzaXvSXzsSIcpER9wvxtX4c6Mw5e3fxfEnJ7oOEaBQN
 LkxeuZORb2ivPoEM9/SU6sLvP7YpJ/Slqc19FL6IJLiViax+odap8LLL5iO5Pi0ad+XPmGNwCrJ
 GvPJpP6Lov/VCxZ3QNg==
X-Authority-Analysis: v=2.4 cv=A/T5rKWG c=1 sm=1 tr=0 ts=6ae25d8f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Udoxf_ItZd6NPfNeJ-gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: gNoWnvBuTcC3eRAggCp8V7QjKH6Z_gx7
X-Proofpoint-GUID: gNoWnvBuTcC3eRAggCp8V7QjKH6Z_gx7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX2mJdeMHmXAro
 uTXNQFpkvnLzQatoOLGs42RX97+wiMkty3aJfvVIMAQgdAFJ+2+NZx5TdRYaLvYVUtbWkeNuGr8
 T/GVtvBWsbD3wyfXvpC1L3ZU751PHdQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
> The Makefile needs a toolchain we do not have and qemu-mipsel,
> which no longer provides the R5900 CPU. Move the tests next to
> the bare-metal harness, register them in meson.build, and remove
> the Makefile and the obsolete README.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  .../system}/test_r5900_div1.c                 |  0
>  .../system}/test_r5900_divu1.c                |  0
>  .../system}/test_r5900_madd.c                 |  0
>  .../system}/test_r5900_maddu.c                |  0
>  .../system}/test_r5900_mflohi1.c              |  0
>  .../system}/test_r5900_mtlohi1.c              |  0
>  .../system}/test_r5900_mult.c                 |  0
>  .../system}/test_r5900_multu.c                |  0
>  tests/tcg/mips/user/isa/r5900/Makefile        | 32 -------------------
>  tests/tcg/mips/user/isa/r5900/README          |  6 ----
>  tests/tcg/mips64el/system/meson.build         | 20 ++++++++++++
>  11 files changed, 20 insertions(+), 38 deletions(-)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_div1.c (100%)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_divu1.c (100%)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_madd.c (100%)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_maddu.c (100%)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mflohi1.c (100%)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mtlohi1.c (100%)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mult.c (100%)
>  rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_multu.c (100%)
>  delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>  delete mode 100644 tests/tcg/mips/user/isa/r5900/README
> 
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_div1.c b/tests/tcg/mips64el/system/test_r5900_div1.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
> rename to tests/tcg/mips64el/system/test_r5900_div1.c
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c b/tests/tcg/mips64el/system/test_r5900_divu1.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
> rename to tests/tcg/mips64el/system/test_r5900_divu1.c
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_madd.c b/tests/tcg/mips64el/system/test_r5900_madd.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
> rename to tests/tcg/mips64el/system/test_r5900_madd.c
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c b/tests/tcg/mips64el/system/test_r5900_maddu.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
> rename to tests/tcg/mips64el/system/test_r5900_maddu.c
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c b/tests/tcg/mips64el/system/test_r5900_mflohi1.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
> rename to tests/tcg/mips64el/system/test_r5900_mflohi1.c
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c b/tests/tcg/mips64el/system/test_r5900_mtlohi1.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
> rename to tests/tcg/mips64el/system/test_r5900_mtlohi1.c
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mult.c b/tests/tcg/mips64el/system/test_r5900_mult.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
> rename to tests/tcg/mips64el/system/test_r5900_mult.c
> diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_multu.c b/tests/tcg/mips64el/system/test_r5900_multu.c
> similarity index 100%
> rename from tests/tcg/mips/user/isa/r5900/test_r5900_multu.c
> rename to tests/tcg/mips64el/system/test_r5900_multu.c
> diff --git a/tests/tcg/mips/user/isa/r5900/Makefile b/tests/tcg/mips/user/isa/r5900/Makefile
> deleted file mode 100644
> index bff360df6c97..000000000000
> --- a/tests/tcg/mips/user/isa/r5900/Makefile
> +++ /dev/null
> @@ -1,32 +0,0 @@
> --include ../../../../config-host.mak
> -
> -CROSS=mipsr5900el-unknown-linux-gnu-
> -
> -SIM=qemu-mipsel
> -SIM_FLAGS=-cpu R5900
> -
> -CC      = $(CROSS)gcc
> -CFLAGS  = -Wall -mabi=32 -march=r5900 -static
> -
> -TESTCASES  = test_r5900_div1.tst
> -TESTCASES += test_r5900_divu1.tst
> -TESTCASES += test_r5900_madd.tst
> -TESTCASES += test_r5900_maddu.tst
> -TESTCASES += test_r5900_mflohi1.tst
> -TESTCASES += test_r5900_mtlohi1.tst
> -TESTCASES += test_r5900_mult.tst
> -TESTCASES += test_r5900_multu.tst
> -
> -all: $(TESTCASES)
> -
> -%.tst: %.c
> -	$(CC) $(CFLAGS) $< -o $@
> -
> -check: $(TESTCASES)
> -	@for case in $(TESTCASES); do \
> -        echo $(SIM) $(SIM_FLAGS) ./$$case;\
> -        $(SIM) $(SIM_FLAGS) ./$$case; \
> -	done
> -
> -clean:
> -	$(RM) -rf $(TESTCASES)
> diff --git a/tests/tcg/mips/user/isa/r5900/README b/tests/tcg/mips/user/isa/r5900/README
> deleted file mode 100644
> index 18ecfc3bd0a5..000000000000
> --- a/tests/tcg/mips/user/isa/r5900/README
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -This test suite can't be run at the moment. We don't have a qemu target for this
> -architecture, which has single-float arithmetic, and custom 128-bit registers.
> -Also, a specific toolchain has to be compiled for it.
> -
> -We keep the tests here in case someone is interested one day to resurrect this
> -architecture.
> diff --git a/tests/tcg/mips64el/system/meson.build b/tests/tcg/mips64el/system/meson.build
> index 265a2eca4ff1..fd5a759c20fa 100644
> --- a/tests/tcg/mips64el/system/meson.build
> +++ b/tests/tcg/mips64el/system/meson.build
> @@ -19,6 +19,26 @@ qemu_args = ['-M', 'none', '-cpu', 'R5900', '-m', '16M',
>  gdb_test = ['--gdb-args=-ex "set remoteaddresssize 64"',
>              '--test', files('test-r5900.py')]
>  
> +# o32: 32-bit pointers, 32-bit GPRs are enough
> +foreach t: [
> +  'div1',
> +  'divu1',
> +  'madd',
> +  'maddu',
> +  'mflohi1',
> +  'mtlohi1',
> +  'mult',
> +  'multu',
> +]
> +  tests += {
> +    'test_r5900_' + t + '.c': {
> +      'cflags': cflags + ['-mabi=32'],
> +      'qemu_args': qemu_args,
> +      'gdb_test': gdb_test,
> +    }
> +  }

Just a small nit, please keep full file name in the original array
(s/div1/div1.c), All other meson.build for tcg/tests do this also.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

