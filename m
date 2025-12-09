Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBECD3B980
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0Fd-0007L0-Pe; Tue, 09 Dec 2025 11:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vT0FY-0007Jt-JS
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:07:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vT0FV-0006FS-DP
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:07:40 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B9FhjPZ3978591
 for <qemu-devel@nongnu.org>; Tue, 9 Dec 2025 16:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DJf5Jn2ER7qkG6nEfINsUmhs
 l19So0W4soWBj5YWZnM=; b=ogUulGaP1Y39ttf6geKTjFmAzl7JoU0YTYZmYvNY
 RIJTAX5RuzDSI5RET58H36DoPianwIWNvYXsfIdPGSnp/wUuN1NTzOLF/p+F2LvB
 voaqz8BskxezrCMje4955NLDxLVk7Cwb0DdWpSOjobHSI5ymNfxS6iLTLP5DNqh6
 yFMKfAGDYdu1YcmnvVHcefTtMewckTTthfKqbeIlYHT6BJ/7ua0oKtiZvN/PfIKK
 4XVyNaPHb7eDKO+AO5/ogbA+hHpd02XqwVhCDTcYP+UNCWvVJfs0YIy3+YoWCaf9
 TR83/9A0BYInnbfQT1OrYkoUrKGAba3sAAGwn6dBPRD0RQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axmt80ga9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 16:07:33 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-65747f4376bso8995186eaf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765296453; x=1765901253; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DJf5Jn2ER7qkG6nEfINsUmhsl19So0W4soWBj5YWZnM=;
 b=HgjPQdsr9mq7CSBxlgRJdZXbiHidQ5RRixIQAkkI98KSREwCYbxM8FxKjZa+ojjzs6
 nqkJdFBmMgww7O8J4YYBZoN5Gp0+KZKHTlp/QeXJIX2ojFogQ7hO6cmx1ryu3Hoe/tFW
 fEvTnW3AmOfYsleuDZp9YYSfQXrFp0cPMpoxBfYzkwKrXAXlf2ZUN93xDFnI4BNJtf3y
 OdyoOgl6PmyR/wmBgVEOJokNJGIOvGjjmKExXAQNfPQdlyTJ4wvLfQcRQ58FPVe0u06b
 EwPijDIcLlrK+EzT7nHbIwG1W7YkMQp4ByR214H+/A/uTR3grK96DgRbHlQh3baFaMe9
 9RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765296453; x=1765901253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJf5Jn2ER7qkG6nEfINsUmhsl19So0W4soWBj5YWZnM=;
 b=BwRCNiR9df0Fbb9NNTE57D8UfQjwXp/Juzp6FwEZmXGT5e5kBPcKVSStd10gotLclp
 1q9KPmTk25eQMCUvBQDfUYcVtMqR31Pk1BxkuXBpxmCVbU66e28C2/oVCBTqg41EGtw0
 SL2Giku2f1qVIxZfWYKRqmmVmL+xApwqkHQQCPspZoflfQ4/CpPI6k7VVbNbzmzQAXRv
 5OixK7O+ISHKDuCNAb0FILIKfCxk3vRI+dcSM5I0fBHSXbQNuTYJ4ftNEuScvSWtV+Hg
 JlLSWxnlYabMnMYClcu5hVY04R8buNbfhqo74LHrxGKnXF7NEJqtD47MWZwubQF9G1EE
 rGEg==
X-Gm-Message-State: AOJu0YxR2cyY0BJ9CmLF19rHoAo/mO/qR+CWOBCOtpwEVAwRrFPbXOn/
 WzyVXjo2nSSG5s+CVHLd1EwEIzM5et20rgbi2NzvRW8xWdQtQ0zkXbmwADdH/vApb2qIoF4O0Qt
 wFbl/354xdkc/9rwXyOZBl+0k9s+udd/hzMGZ9RXJG640vys1p7I2+tK0mMa+BLZVMJbJIz520C
 fSu/7BOvQHk6XeOHr6Vq6loSZVT3ZVQNL+
X-Gm-Gg: ASbGnctqWsRum2Vt17wrc2D5z/UHvxFEwkCgXClO3PYpY+HwdFlYTwHuQQGuP0ayAGD
 RWKAFm9oZS9b1pPAhelSCfON4jy+gJCiY/e5Vc4ejtabFn1aWJJzigtvzc7bkBwu8Lj0WhNPmKM
 Io9bOkfRH8QCPqJbZ2A6l6Q2Hw1pzOlmiy7w8UyWHbRnXkLQiPv/gSTh563bYsiHnBCak=
X-Received: by 2002:a05:6820:8107:b0:659:9a49:8e89 with SMTP id
 006d021491bc7-6599a8a0ad3mr4110056eaf.13.1765296452814; 
 Tue, 09 Dec 2025 08:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYKM8Z2DMwp4ypoZ/DOiWlmAsNqc4QA7opEEjkGvUWcYhF5cyEjlpV81mgphN7rAKwn2UnMNXYC/JxQALnjqo=
X-Received: by 2002:a05:6820:8107:b0:659:9a49:8e89 with SMTP id
 006d021491bc7-6599a8a0ad3mr4110040eaf.13.1765296452302; Tue, 09 Dec 2025
 08:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
 <20251209-phys_addr-v1-7-c387f3e72d77@rev.ng>
In-Reply-To: <20251209-phys_addr-v1-7-c387f3e72d77@rev.ng>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 10:07:16 -0600
X-Gm-Features: AQt7F2p8HtEDYiyWWC31J3q7AGPyenWr5UOk4gm9_M8365CUMGrlzS5Wg5dDiFc
Message-ID: <CAEqNhNaM_AnESX3-KBCvyjVsGgm=SBsuiHg65JUGQZ8HHKb=Pg@mail.gmail.com>
Subject: Re: [PATCH 7/7] Drop TARGET_PHYS_ADDR_SPACE_BITS
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f6856d0645871b74"
X-Authority-Analysis: v=2.4 cv=NvXcssdJ c=1 sm=1 tr=0 ts=69384945 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=m1IVfqZT8nEgskcZOMgA:9 a=QEXdDO2ut3YA:10 a=mIIE3iy8ZukfzpTeehoA:9
 a=ZnuhiVND-mtGT1Ic:21 a=lqcHg5cX4UMA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDEyMSBTYWx0ZWRfX+oJUEh0vpK/F
 pLGnBCkRu39jU4GCWu5ZOdqOWY+b3CWh65fLBdH3onakdXJdipILnPIzAwenlNbHH1VlLFBrt7n
 7+79hx/50s7ty1vkAYukXxpk6Ew7/JzrTTU34Jm93siExhUIg+gr/tA18a8liMJtms5LbL4+/G/
 2Znbs48Qi6LngPyHsKGdD2sza+6EzT4CtYBsLbePH98hgqkY4+qlenpAYbDer6n5lEYlQVzzx0b
 3Bq5up4L+bkyY96pHCdSDRIwwZN3xQl4YnW9YpCTuphcCyqisa4pJGxVSZWLS/DeKNTk7sXUiaI
 RShI+HcsWtbGsBlFimn2KDx2xAZqNuOJ0qfbQUSPKC+o64/GHgqkewxS+XDFwBGWMCB0AuuQAhd
 vk184OeldjhK3IxWxhfCyP8jostIOQ==
X-Proofpoint-ORIG-GUID: hOVZUqFbbWroFIS6TwpXIWNqIJMN5xTx
X-Proofpoint-GUID: hOVZUqFbbWroFIS6TwpXIWNqIJMN5xTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512090121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f6856d0645871b74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 7:54=E2=80=AFAM Anton Johansson via <qemu-devel@nong=
nu.org>
wrote:

> The macro is no longer in use and can safely be dropped.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  include/exec/cpu-defs.h       | 3 ---
>  include/exec/poison.h         | 2 --
>  target/alpha/cpu-param.h      | 3 ---
>  target/arm/cpu-param.h        | 2 --
>  target/avr/cpu-param.h        | 1 -
>  target/hexagon/cpu-param.h    | 1 -
>  target/hppa/cpu-param.h       | 2 --
>  target/i386/cpu-param.h       | 2 --
>  target/loongarch/cpu-param.h  | 1 -
>  target/m68k/cpu-param.h       | 1 -
>  target/microblaze/cpu-param.h | 2 --
>  target/mips/cpu-param.h       | 2 --
>  target/openrisc/cpu-param.h   | 1 -
>  target/ppc/cpu-param.h        | 7 -------
>  target/riscv/cpu-param.h      | 2 --
>  target/rx/cpu-param.h         | 1 -
>  target/s390x/cpu-param.h      | 1 -
>  target/sh4/cpu-param.h        | 1 -
>  target/sparc/cpu-param.h      | 2 --
>  target/tricore/cpu-param.h    | 1 -
>  target/xtensa/cpu-param.h     | 1 -
>  21 files changed, 39 deletions(-)
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index e01acb7c90..141b5a9929 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -28,9 +28,6 @@
>  #ifndef TARGET_LONG_BITS
>  # error TARGET_LONG_BITS must be defined in cpu-param.h
>  #endif
> -#ifndef TARGET_PHYS_ADDR_SPACE_BITS
> -# error TARGET_PHYS_ADDR_SPACE_BITS must be defined in cpu-param.h
> -#endif
>  #ifndef TARGET_VIRT_ADDR_SPACE_BITS
>  # error TARGET_VIRT_ADDR_SPACE_BITS must be defined in cpu-param.h
>  #endif
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index a779adbb7a..2caf2d92f1 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -43,8 +43,6 @@
>  #pragma GCC poison TARGET_FMT_ld
>  #pragma GCC poison TARGET_FMT_lu
>
> -#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
> -
>  #pragma GCC poison CONFIG_ALPHA_DIS
>  #pragma GCC poison CONFIG_HPPA_DIS
>  #pragma GCC poison CONFIG_I386_DIS
> diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
> index a799f42db3..e04bfeee12 100644
> --- a/target/alpha/cpu-param.h
> +++ b/target/alpha/cpu-param.h
> @@ -8,9 +8,6 @@
>  #ifndef ALPHA_CPU_PARAM_H
>  #define ALPHA_CPU_PARAM_H
>
> -/* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
> -#define TARGET_PHYS_ADDR_SPACE_BITS  44
> -
>  #ifdef CONFIG_USER_ONLY
>  /*
>   * Allow user-only to vary page size.  Real hardware allows only 8k and
> 64k,
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index 8b46c7c570..08785125ad 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -9,10 +9,8 @@
>  #define ARM_CPU_PARAM_H
>
>  #ifdef TARGET_AARCH64
> -# define TARGET_PHYS_ADDR_SPACE_BITS  52
>  # define TARGET_VIRT_ADDR_SPACE_BITS  52
>  #else
> -# define TARGET_PHYS_ADDR_SPACE_BITS  40
>  # define TARGET_VIRT_ADDR_SPACE_BITS  32
>  #endif
>
> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> index f74bfc2580..066ada1e9c 100644
> --- a/target/avr/cpu-param.h
> +++ b/target/avr/cpu-param.h
> @@ -22,7 +22,6 @@
>  #define AVR_CPU_PARAM_H
>
>  #define TARGET_PAGE_BITS 10
> -#define TARGET_PHYS_ADDR_SPACE_BITS 24
>  #define TARGET_VIRT_ADDR_SPACE_BITS 24
>
>  #define TARGET_INSN_START_EXTRA_WORDS 0
> diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
> index 635d509e74..31da1a239f 100644
> --- a/target/hexagon/cpu-param.h
> +++ b/target/hexagon/cpu-param.h
> @@ -20,7 +20,6 @@
>
>  #define TARGET_PAGE_BITS 16     /* 64K pages */
>
> -#define TARGET_PHYS_ADDR_SPACE_BITS 36
>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
>
>  #define TARGET_INSN_START_EXTRA_WORDS 0
> diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
> index 9bf7ac76d0..8e33d1ac36 100644
> --- a/target/hppa/cpu-param.h
> +++ b/target/hppa/cpu-param.h
> @@ -9,11 +9,9 @@
>  #define HPPA_CPU_PARAM_H
>
>  #if defined(CONFIG_USER_ONLY) && defined(TARGET_ABI32)
> -# define TARGET_PHYS_ADDR_SPACE_BITS  32
>  # define TARGET_VIRT_ADDR_SPACE_BITS  32
>  #else
>  /* ??? PA-8000 through 8600 have 40 bits; PA-8700 and 8900 have 44 bits.
> */
> -# define TARGET_PHYS_ADDR_SPACE_BITS  40
>  # define TARGET_VIRT_ADDR_SPACE_BITS  64
>  #endif
>
> diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
> index ebb844bcc8..9e4cb74e04 100644
> --- a/target/i386/cpu-param.h
> +++ b/target/i386/cpu-param.h
> @@ -9,7 +9,6 @@
>  #define I386_CPU_PARAM_H
>
>  #ifdef TARGET_X86_64
> -# define TARGET_PHYS_ADDR_SPACE_BITS  52
>  /*
>   * ??? This is really 48 bits, sign-extended, but the only thing
>   * accessible to userland with bit 48 set is the VSYSCALL, and that
> @@ -17,7 +16,6 @@
>   */
>  # define TARGET_VIRT_ADDR_SPACE_BITS  47
>  #else
> -# define TARGET_PHYS_ADDR_SPACE_BITS  36
>  # define TARGET_VIRT_ADDR_SPACE_BITS  32
>  #endif
>  #define TARGET_PAGE_BITS 12
> diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
> index 58cc45a377..7779461054 100644
> --- a/target/loongarch/cpu-param.h
> +++ b/target/loongarch/cpu-param.h
> @@ -8,7 +8,6 @@
>  #ifndef LOONGARCH_CPU_PARAM_H
>  #define LOONGARCH_CPU_PARAM_H
>
> -#define TARGET_PHYS_ADDR_SPACE_BITS 48
>  #define TARGET_VIRT_ADDR_SPACE_BITS 48
>
>  #define TARGET_PAGE_BITS 12
> diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
> index 256a2b5f8b..802d8fc674 100644
> --- a/target/m68k/cpu-param.h
> +++ b/target/m68k/cpu-param.h
> @@ -14,7 +14,6 @@
>   * use the smallest one
>   */
>  #define TARGET_PAGE_BITS 12
> -#define TARGET_PHYS_ADDR_SPACE_BITS 32
>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
>
>  #define TARGET_INSN_START_EXTRA_WORDS 1
> diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.=
h
> index e0a3794513..90a0cf2435 100644
> --- a/target/microblaze/cpu-param.h
> +++ b/target/microblaze/cpu-param.h
> @@ -17,10 +17,8 @@
>   * of address space.
>   */
>  #ifdef CONFIG_USER_ONLY
> -#define TARGET_PHYS_ADDR_SPACE_BITS 32
>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
>  #else
> -#define TARGET_PHYS_ADDR_SPACE_BITS 64
>  #define TARGET_VIRT_ADDR_SPACE_BITS 64
>  #endif
>
> diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
> index 58f450827f..d62110e732 100644
> --- a/target/mips/cpu-param.h
> +++ b/target/mips/cpu-param.h
> @@ -8,10 +8,8 @@
>  #define MIPS_CPU_PARAM_H
>
>  #ifdef TARGET_ABI_MIPSN64
> -#define TARGET_PHYS_ADDR_SPACE_BITS 48
>  #define TARGET_VIRT_ADDR_SPACE_BITS 48
>  #else
> -#define TARGET_PHYS_ADDR_SPACE_BITS 40
>  # ifdef CONFIG_USER_ONLY
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 31
>  # else
> diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
> index b4f57bbe69..740cf76ddd 100644
> --- a/target/openrisc/cpu-param.h
> +++ b/target/openrisc/cpu-param.h
> @@ -9,7 +9,6 @@
>  #define OPENRISC_CPU_PARAM_H
>
>  #define TARGET_PAGE_BITS 13
> -#define TARGET_PHYS_ADDR_SPACE_BITS 32
>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
>
>  #define TARGET_INSN_START_EXTRA_WORDS 1
> diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
> index e4ed9080ee..2065915dc5 100644
> --- a/target/ppc/cpu-param.h
> +++ b/target/ppc/cpu-param.h
> @@ -9,12 +9,6 @@
>  #define PPC_CPU_PARAM_H
>
>  #ifdef TARGET_PPC64
> -/*
> - * Note that the official physical address space bits is 62-M where M
> - * is implementation dependent.  I've not looked up M for the set of
> - * cpus we emulate at the system level.
> - */
> -#define TARGET_PHYS_ADDR_SPACE_BITS 62
>  /*
>   * Note that the PPC environment architecture talks about 80 bit virtual
>   * addresses, with segmentation.  Obviously that's not all visible to a
> @@ -26,7 +20,6 @@
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 64
>  # endif
>  #else
> -# define TARGET_PHYS_ADDR_SPACE_BITS 36
>  # define TARGET_VIRT_ADDR_SPACE_BITS 32
>  #endif
>
> diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
> index cfdc67c258..b96e1ce12e 100644
> --- a/target/riscv/cpu-param.h
> +++ b/target/riscv/cpu-param.h
> @@ -9,10 +9,8 @@
>  #define RISCV_CPU_PARAM_H
>
>  #if defined(TARGET_RISCV64)
> -# define TARGET_PHYS_ADDR_SPACE_BITS 56 /* 44-bit PPN */
>  # define TARGET_VIRT_ADDR_SPACE_BITS 48 /* sv48 */
>  #elif defined(TARGET_RISCV32)
> -# define TARGET_PHYS_ADDR_SPACE_BITS 34 /* 22-bit PPN */
>  # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
>  #endif
>  #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
> diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
> index 84934f3bca..4cf6183aa0 100644
> --- a/target/rx/cpu-param.h
> +++ b/target/rx/cpu-param.h
> @@ -21,7 +21,6 @@
>
>  #define TARGET_PAGE_BITS 12
>
> -#define TARGET_PHYS_ADDR_SPACE_BITS 32
>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
>
>  #define TARGET_INSN_START_EXTRA_WORDS 0
> diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
> index abfae3bedf..e46e0757c6 100644
> --- a/target/s390x/cpu-param.h
> +++ b/target/s390x/cpu-param.h
> @@ -9,7 +9,6 @@
>  #define S390_CPU_PARAM_H
>
>  #define TARGET_PAGE_BITS 12
> -#define TARGET_PHYS_ADDR_SPACE_BITS 64
>  #define TARGET_VIRT_ADDR_SPACE_BITS 64
>
>  #define TARGET_INSN_START_EXTRA_WORDS 2
> diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
> index f328715ee8..e2632bb20f 100644
> --- a/target/sh4/cpu-param.h
> +++ b/target/sh4/cpu-param.h
> @@ -9,7 +9,6 @@
>  #define SH4_CPU_PARAM_H
>
>  #define TARGET_PAGE_BITS 12  /* 4k */
> -#define TARGET_PHYS_ADDR_SPACE_BITS  32
>  #ifdef CONFIG_USER_ONLY
>  # define TARGET_VIRT_ADDR_SPACE_BITS 31
>  #else
> diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
> index 45eea9d6ba..4c92862ea3 100644
> --- a/target/sparc/cpu-param.h
> +++ b/target/sparc/cpu-param.h
> @@ -9,7 +9,6 @@
>
>  #ifdef TARGET_SPARC64
>  # define TARGET_PAGE_BITS 13 /* 8k */
> -# define TARGET_PHYS_ADDR_SPACE_BITS  41
>  # ifdef TARGET_ABI32
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>  # else
> @@ -17,7 +16,6 @@
>  # endif
>  #else
>  # define TARGET_PAGE_BITS 12 /* 4k */
> -# define TARGET_PHYS_ADDR_SPACE_BITS 36
>  # define TARGET_VIRT_ADDR_SPACE_BITS 32
>  #endif
>
> diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
> index eb33a67c41..f260a888c2 100644
> --- a/target/tricore/cpu-param.h
> +++ b/target/tricore/cpu-param.h
> @@ -9,7 +9,6 @@
>  #define TRICORE_CPU_PARAM_H
>
>  #define TARGET_PAGE_BITS 14
> -#define TARGET_PHYS_ADDR_SPACE_BITS 32
>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
>
>  #define TARGET_INSN_START_EXTRA_WORDS 0
> diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
> index 7a0c22c900..328176281e 100644
> --- a/target/xtensa/cpu-param.h
> +++ b/target/xtensa/cpu-param.h
> @@ -9,7 +9,6 @@
>  #define XTENSA_CPU_PARAM_H
>
>  #define TARGET_PAGE_BITS 12
> -#define TARGET_PHYS_ADDR_SPACE_BITS 32
>  #ifdef CONFIG_USER_ONLY
>  #define TARGET_VIRT_ADDR_SPACE_BITS 30
>  #else
>
> --
> 2.51.0
>
>
>

--000000000000f6856d0645871b74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 9, 2025 at =
7:54=E2=80=AFAM Anton Johansson via &lt;<a href=3D"mailto:qemu-devel@nongnu=
.org">qemu-devel@nongnu.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">The macro is no longer in use and can safely be =
dropped.<br>
<br>
Signed-off-by: Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng" target=3D=
"_blank">anjo@rev.ng</a>&gt;<br>
---<br>
=C2=A0include/exec/cpu-defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 ---<br>
=C2=A0include/exec/poison.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 --<br>
=C2=A0target/alpha/cpu-param.h=C2=A0 =C2=A0 =C2=A0 | 3 ---<br>
=C2=A0target/arm/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 --<br>
=C2=A0target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0target/hexagon/cpu-param.h=C2=A0 =C2=A0 | 1 -<br>
=C2=A0target/hppa/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 --<br>
=C2=A0target/i386/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 --<br>
=C2=A0target/loongarch/cpu-param.h=C2=A0 | 1 -<br>
=C2=A0target/m68k/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0target/microblaze/cpu-param.h | 2 --<br>
=C2=A0target/mips/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 --<br>
=C2=A0target/openrisc/cpu-param.h=C2=A0 =C2=A0| 1 -<br>
=C2=A0target/ppc/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 7 -------<br>
=C2=A0target/riscv/cpu-param.h=C2=A0 =C2=A0 =C2=A0 | 2 --<br>
=C2=A0target/rx/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0target/s390x/cpu-param.h=C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0target/sh4/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0target/sparc/cpu-param.h=C2=A0 =C2=A0 =C2=A0 | 2 --<br>
=C2=A0target/tricore/cpu-param.h=C2=A0 =C2=A0 | 1 -<br>
=C2=A0target/xtensa/cpu-param.h=C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A021 files changed, 39 deletions(-)<br></blockquote><div><br></div><div=
><div class=3D"gmail_default" style=3D"font-family:monospace"></div></div><=
div class=3D"gmail_default" style=3D"font-family:monospace">Reviewed-by: Br=
ian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.=
qualcomm.com</a>&gt;</div><div class=3D"gmail_default" style=3D"font-family=
:monospace"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h<br>
index e01acb7c90..141b5a9929 100644<br>
--- a/include/exec/cpu-defs.h<br>
+++ b/include/exec/cpu-defs.h<br>
@@ -28,9 +28,6 @@<br>
=C2=A0#ifndef TARGET_LONG_BITS<br>
=C2=A0# error TARGET_LONG_BITS must be defined in cpu-param.h<br>
=C2=A0#endif<br>
-#ifndef TARGET_PHYS_ADDR_SPACE_BITS<br>
-# error TARGET_PHYS_ADDR_SPACE_BITS must be defined in cpu-param.h<br>
-#endif<br>
=C2=A0#ifndef TARGET_VIRT_ADDR_SPACE_BITS<br>
=C2=A0# error TARGET_VIRT_ADDR_SPACE_BITS must be defined in cpu-param.h<br=
>
=C2=A0#endif<br>
diff --git a/include/exec/poison.h b/include/exec/poison.h<br>
index a779adbb7a..2caf2d92f1 100644<br>
--- a/include/exec/poison.h<br>
+++ b/include/exec/poison.h<br>
@@ -43,8 +43,6 @@<br>
=C2=A0#pragma GCC poison TARGET_FMT_ld<br>
=C2=A0#pragma GCC poison TARGET_FMT_lu<br>
<br>
-#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS<br>
-<br>
=C2=A0#pragma GCC poison CONFIG_ALPHA_DIS<br>
=C2=A0#pragma GCC poison CONFIG_HPPA_DIS<br>
=C2=A0#pragma GCC poison CONFIG_I386_DIS<br>
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h<br>
index a799f42db3..e04bfeee12 100644<br>
--- a/target/alpha/cpu-param.h<br>
+++ b/target/alpha/cpu-param.h<br>
@@ -8,9 +8,6 @@<br>
=C2=A0#ifndef ALPHA_CPU_PARAM_H<br>
=C2=A0#define ALPHA_CPU_PARAM_H<br>
<br>
-/* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.=C2=A0 */<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 44<br>
-<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
=C2=A0/*<br>
=C2=A0 * Allow user-only to vary page size.=C2=A0 Real hardware allows only=
 8k and 64k,<br>
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h<br>
index 8b46c7c570..08785125ad 100644<br>
--- a/target/arm/cpu-param.h<br>
+++ b/target/arm/cpu-param.h<br>
@@ -9,10 +9,8 @@<br>
=C2=A0#define ARM_CPU_PARAM_H<br>
<br>
=C2=A0#ifdef TARGET_AARCH64<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 52<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS=C2=A0 52<br>
=C2=A0#else<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 40<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS=C2=A0 32<br>
=C2=A0#endif<br>
<br>
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h<br>
index f74bfc2580..066ada1e9c 100644<br>
--- a/target/avr/cpu-param.h<br>
+++ b/target/avr/cpu-param.h<br>
@@ -22,7 +22,6 @@<br>
=C2=A0#define AVR_CPU_PARAM_H<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 10<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 24<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 24<br>
<br>
=C2=A0#define TARGET_INSN_START_EXTRA_WORDS 0<br>
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h<br>
index 635d509e74..31da1a239f 100644<br>
--- a/target/hexagon/cpu-param.h<br>
+++ b/target/hexagon/cpu-param.h<br>
@@ -20,7 +20,6 @@<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 16=C2=A0 =C2=A0 =C2=A0/* 64K pages */<br>
<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 36<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
<br>
=C2=A0#define TARGET_INSN_START_EXTRA_WORDS 0<br>
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h<br>
index 9bf7ac76d0..8e33d1ac36 100644<br>
--- a/target/hppa/cpu-param.h<br>
+++ b/target/hppa/cpu-param.h<br>
@@ -9,11 +9,9 @@<br>
=C2=A0#define HPPA_CPU_PARAM_H<br>
<br>
=C2=A0#if defined(CONFIG_USER_ONLY) &amp;&amp; defined(TARGET_ABI32)<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 32<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS=C2=A0 32<br>
=C2=A0#else<br>
=C2=A0/* ??? PA-8000 through 8600 have 40 bits; PA-8700 and 8900 have 44 bi=
ts. */<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 40<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS=C2=A0 64<br>
=C2=A0#endif<br>
<br>
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h<br>
index ebb844bcc8..9e4cb74e04 100644<br>
--- a/target/i386/cpu-param.h<br>
+++ b/target/i386/cpu-param.h<br>
@@ -9,7 +9,6 @@<br>
=C2=A0#define I386_CPU_PARAM_H<br>
<br>
=C2=A0#ifdef TARGET_X86_64<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 52<br>
=C2=A0/*<br>
=C2=A0 * ??? This is really 48 bits, sign-extended, but the only thing<br>
=C2=A0 * accessible to userland with bit 48 set is the VSYSCALL, and that<b=
r>
@@ -17,7 +16,6 @@<br>
=C2=A0 */<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS=C2=A0 47<br>
=C2=A0#else<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 36<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS=C2=A0 32<br>
=C2=A0#endif<br>
=C2=A0#define TARGET_PAGE_BITS 12<br>
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h<br=
>
index 58cc45a377..7779461054 100644<br>
--- a/target/loongarch/cpu-param.h<br>
+++ b/target/loongarch/cpu-param.h<br>
@@ -8,7 +8,6 @@<br>
=C2=A0#ifndef LOONGARCH_CPU_PARAM_H<br>
=C2=A0#define LOONGARCH_CPU_PARAM_H<br>
<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 48<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 48<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 12<br>
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h<br>
index 256a2b5f8b..802d8fc674 100644<br>
--- a/target/m68k/cpu-param.h<br>
+++ b/target/m68k/cpu-param.h<br>
@@ -14,7 +14,6 @@<br>
=C2=A0 * use the smallest one<br>
=C2=A0 */<br>
=C2=A0#define TARGET_PAGE_BITS 12<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 32<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
<br>
=C2=A0#define TARGET_INSN_START_EXTRA_WORDS 1<br>
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h<=
br>
index e0a3794513..90a0cf2435 100644<br>
--- a/target/microblaze/cpu-param.h<br>
+++ b/target/microblaze/cpu-param.h<br>
@@ -17,10 +17,8 @@<br>
=C2=A0 * of address space.<br>
=C2=A0 */<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 32<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
=C2=A0#else<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 64<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 64<br>
=C2=A0#endif<br>
<br>
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h<br>
index 58f450827f..d62110e732 100644<br>
--- a/target/mips/cpu-param.h<br>
+++ b/target/mips/cpu-param.h<br>
@@ -8,10 +8,8 @@<br>
=C2=A0#define MIPS_CPU_PARAM_H<br>
<br>
=C2=A0#ifdef TARGET_ABI_MIPSN64<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 48<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 48<br>
=C2=A0#else<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 40<br>
=C2=A0# ifdef CONFIG_USER_ONLY<br>
=C2=A0#=C2=A0 define TARGET_VIRT_ADDR_SPACE_BITS 31<br>
=C2=A0# else<br>
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h<br>
index b4f57bbe69..740cf76ddd 100644<br>
--- a/target/openrisc/cpu-param.h<br>
+++ b/target/openrisc/cpu-param.h<br>
@@ -9,7 +9,6 @@<br>
=C2=A0#define OPENRISC_CPU_PARAM_H<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 13<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 32<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
<br>
=C2=A0#define TARGET_INSN_START_EXTRA_WORDS 1<br>
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h<br>
index e4ed9080ee..2065915dc5 100644<br>
--- a/target/ppc/cpu-param.h<br>
+++ b/target/ppc/cpu-param.h<br>
@@ -9,12 +9,6 @@<br>
=C2=A0#define PPC_CPU_PARAM_H<br>
<br>
=C2=A0#ifdef TARGET_PPC64<br>
-/*<br>
- * Note that the official physical address space bits is 62-M where M<br>
- * is implementation dependent.=C2=A0 I&#39;ve not looked up M for the set=
 of<br>
- * cpus we emulate at the system level.<br>
- */<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 62<br>
=C2=A0/*<br>
=C2=A0 * Note that the PPC environment architecture talks about 80 bit virt=
ual<br>
=C2=A0 * addresses, with segmentation.=C2=A0 Obviously that&#39;s not all v=
isible to a<br>
@@ -26,7 +20,6 @@<br>
=C2=A0#=C2=A0 define TARGET_VIRT_ADDR_SPACE_BITS 64<br>
=C2=A0# endif<br>
=C2=A0#else<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS 36<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
=C2=A0#endif<br>
<br>
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h<br>
index cfdc67c258..b96e1ce12e 100644<br>
--- a/target/riscv/cpu-param.h<br>
+++ b/target/riscv/cpu-param.h<br>
@@ -9,10 +9,8 @@<br>
=C2=A0#define RISCV_CPU_PARAM_H<br>
<br>
=C2=A0#if defined(TARGET_RISCV64)<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS 56 /* 44-bit PPN */<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS 48 /* sv48 */<br>
=C2=A0#elif defined(TARGET_RISCV32)<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS 34 /* 22-bit PPN */<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */<br>
=C2=A0#endif<br>
=C2=A0#define TARGET_PAGE_BITS 12 /* 4 KiB Pages */<br>
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h<br>
index 84934f3bca..4cf6183aa0 100644<br>
--- a/target/rx/cpu-param.h<br>
+++ b/target/rx/cpu-param.h<br>
@@ -21,7 +21,6 @@<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 12<br>
<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 32<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
<br>
=C2=A0#define TARGET_INSN_START_EXTRA_WORDS 0<br>
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h<br>
index abfae3bedf..e46e0757c6 100644<br>
--- a/target/s390x/cpu-param.h<br>
+++ b/target/s390x/cpu-param.h<br>
@@ -9,7 +9,6 @@<br>
=C2=A0#define S390_CPU_PARAM_H<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 12<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 64<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 64<br>
<br>
=C2=A0#define TARGET_INSN_START_EXTRA_WORDS 2<br>
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h<br>
index f328715ee8..e2632bb20f 100644<br>
--- a/target/sh4/cpu-param.h<br>
+++ b/target/sh4/cpu-param.h<br>
@@ -9,7 +9,6 @@<br>
=C2=A0#define SH4_CPU_PARAM_H<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 12=C2=A0 /* 4k */<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 32<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS 31<br>
=C2=A0#else<br>
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h<br>
index 45eea9d6ba..4c92862ea3 100644<br>
--- a/target/sparc/cpu-param.h<br>
+++ b/target/sparc/cpu-param.h<br>
@@ -9,7 +9,6 @@<br>
<br>
=C2=A0#ifdef TARGET_SPARC64<br>
=C2=A0# define TARGET_PAGE_BITS 13 /* 8k */<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS=C2=A0 41<br>
=C2=A0# ifdef TARGET_ABI32<br>
=C2=A0#=C2=A0 define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
=C2=A0# else<br>
@@ -17,7 +16,6 @@<br>
=C2=A0# endif<br>
=C2=A0#else<br>
=C2=A0# define TARGET_PAGE_BITS 12 /* 4k */<br>
-# define TARGET_PHYS_ADDR_SPACE_BITS 36<br>
=C2=A0# define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
=C2=A0#endif<br>
<br>
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h<br>
index eb33a67c41..f260a888c2 100644<br>
--- a/target/tricore/cpu-param.h<br>
+++ b/target/tricore/cpu-param.h<br>
@@ -9,7 +9,6 @@<br>
=C2=A0#define TRICORE_CPU_PARAM_H<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 14<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 32<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 32<br>
<br>
=C2=A0#define TARGET_INSN_START_EXTRA_WORDS 0<br>
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h<br>
index 7a0c22c900..328176281e 100644<br>
--- a/target/xtensa/cpu-param.h<br>
+++ b/target/xtensa/cpu-param.h<br>
@@ -9,7 +9,6 @@<br>
=C2=A0#define XTENSA_CPU_PARAM_H<br>
<br>
=C2=A0#define TARGET_PAGE_BITS 12<br>
-#define TARGET_PHYS_ADDR_SPACE_BITS 32<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
=C2=A0#define TARGET_VIRT_ADDR_SPACE_BITS 30<br>
=C2=A0#else<br>
<br>
-- <br>
2.51.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000f6856d0645871b74--

