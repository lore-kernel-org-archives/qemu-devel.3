Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7848CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcpm-0001qZ-96; Mon, 11 May 2026 22:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMcpk-0001q7-Rf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:26:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMcpi-0008GZ-RI
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:26:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6ohV2519168
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yEG8tnR/O+KrGP8X6UFAGmF3q4HymcoSJUb70qgLq9U=; b=VQzGvzw0NQkT6wRx
 Kv5dFQq/FcJLsppLgON7OBoW/ZPUhcjeVi5ld2kigTMbdz3WHNHGuCQSgBiDTIyx
 4Fs6RMVer+ktkZHRA0axSbsyIJ4U0ZqE6cvA69BkX+VWopxgkE7MWznsbs5MXEsN
 tCkKu9XQN/X/ZepNG+c3MKgXWxZqzaCeMeJwcilhGcfNwTBBh+fG0FXZYgqsjHIY
 B73cAX99ry81h4HBt4C+pxhM3pp+pNQj/KjJFTLQoXZvIrWJJFy8nkkc4WUxGzjK
 13+SdM/gpIIK7LEDvRsfi4arFo1jD7maoLfgQ+xznzIpx0TBRWtnwRjN6zaeetul
 IhO8XQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1h359-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:26:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4102579eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778552812; x=1779157612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yEG8tnR/O+KrGP8X6UFAGmF3q4HymcoSJUb70qgLq9U=;
 b=AMPBFDSXJZVT8F6WYNNYn/bNuuJbhda+ZKJEOsC/KwNERUbDfnsmHB9UwV8DxUbQIl
 LxSrPW6Ovt8OJjuEda00q5TWnqjAcfpcZ8+NN6uNXLyosWteaEflNg+EXZYlLfxQ14wU
 uKUuq2sVyHg7wInXcRw+MgsqkraxfCAxB+qNTWZOoqOJIV8y9P2J+K3DX91D7+LEUJzP
 9hu+fERkezg4UfwsIDGUuBuCkFKDiSQRfDS8gSxJkzuTJjgBoPCJMaf4ZMjyQGZTPvf9
 B+O7nye4bx4fg2Eyjc86erPGbv2A0QamnKiRBcIUqzz21UQZOhdMpR2D1SvZyZaGoi6X
 nzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778552812; x=1779157612;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yEG8tnR/O+KrGP8X6UFAGmF3q4HymcoSJUb70qgLq9U=;
 b=cHHCZDgKAx1FIatrI+oiTk+peY/Kq6brwBMzfhbzLuKYEmURfoIvQJeIjbuIODfT0h
 c8sx1VCMoSc0qnYHMLe6Da4F2aNPDf0pCsInoywgR4DCkTAj7slH7JgEoOhX7WfE1cux
 +1Uv7+yt2OMpnJZUXn2VI9+iAGeUFpBW57MwfEx4azVOFh8mDSinzvtK0zWjA3Kcb9eQ
 XQUS+eBpIM7jbKmzajdEsuI1YTaK61uvqJWrd5xpapf7xMMWBzrvfCRSszs9TyLoKpCH
 QRC/sLlia9GLaKGcknDorZsyawNstkDmU86ykluFJBsAcJoZYE1C/L/2lJmraPtE8+dK
 ErvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o3nNgcENgf7cmNXlrRQiZJ9g8XDftpwLsS731d4Ngt+vvopcpJlwsUZcoAE6+ryhdAGHY08ERZWiK@nongnu.org
X-Gm-Message-State: AOJu0YxKhCxeFGX3q3WOb0eIXx2+QPXmAXd7i5A8LqiETddjxoXYwTnP
 I6+wRkPdEX9CStgZnQrJOMwK/22TYbEcArlAJ6z4rliJjjUVnbaEBc4gu7ImYFzKNbM0JYZ3oxu
 qMNXearLEppo92avvoIOufXobnEG6MA1A2lJi1JvoGm4GjxJ778FBW4M2Y4bdrgDRbw==
X-Gm-Gg: Acq92OF4KKEaUAa9KdSDuv9EqZAJvqGT3x8TlE5jmAHx6e3COvuEj6BgNpk3/28VL/y
 V2EGIM5ANzOMBgFHvDXAKPw0AZc1jzDAv/k3O3hBf/TILA8mrBSteYAERcMBAj7yzTkC8FdgJtz
 81683t0V4SxERibRUbtaFBNqZwCs8yB7gFaIoboh+SiVf8KSP5uu6rtEVAgCCRYNEAXVU3Y37cp
 IFFCBkMveQSy3smPH6iHvsB+AJ++y4L+eMXc4nbnScQJ1V6Fu/4ltItJCFYq8kNdjSgIkp02oVG
 f9xFrA+bFRPgn7PAJMS4PPVTyWwlTsXy3jBZWtEw6y6LymCOqCv3i8NIaJYa1LNjMLs3gPNYppa
 fp8o11F2H5Ajc1mFY5N4Nywm9OFEGw+u4EE7f+u6IULpzqhlZFjTwDjLH2vXTkQ7JgWzRaMipO/
 ab2dOUeYL10MyJFw==
X-Received: by 2002:a05:7301:1698:b0:2f0:c593:986a with SMTP id
 5a478bee46e88-2ff906d92fbmr1073878eec.0.1778552812056; 
 Mon, 11 May 2026 19:26:52 -0700 (PDT)
X-Received: by 2002:a05:7301:1698:b0:2f0:c593:986a with SMTP id
 5a478bee46e88-2ff906d92fbmr1073856eec.0.1778552811439; 
 Mon, 11 May 2026 19:26:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafc2sm20308438eec.4.2026.05.11.19.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 19:26:50 -0700 (PDT)
Message-ID: <afe841af-f6be-489e-9deb-260c46d4a43a@oss.qualcomm.com>
Date: Mon, 11 May 2026 19:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target-info: Inline accessors
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260511190634.472174-1-richard.henderson@linaro.org>
 <20260511190634.472174-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511190634.472174-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hXkMQ1HL6Cg4bM-G-2YrVZJ9ZOoKcQoo
X-Proofpoint-ORIG-GUID: hXkMQ1HL6Cg4bM-G-2YrVZJ9ZOoKcQoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyMSBTYWx0ZWRfXyvT/SPbk3TFd
 ZhYRuZwCMEedtkAKbbu8oyo1oihubH4ypCgOGXLrl4ozlerao+okSPHJBaVwOU0PvOtvExL7QEm
 Zm5sL35JtETOrwFRpxtwzTntY35hkmSWz1Dy3rmtus9DSgw2THzqCcjoVFxT+SfjDy1OIrLwtt6
 NwlHxovOdRy3q2XzgelneO2M+PReiCXVKH3HnK3tF4irVQs6NVS9FNIH9BB+ZcLEZBD+1tmhpWj
 4OGynYxWUBfNQgrs9FaGBbfFUBlxdO/eRaTyV03CisTdvJJ2doBVCLWwMdG7FqMd65G3suaHtB4
 cuyP2rn3xpmxwKmPmRlSI6Ruy8hOO6AR3XaovHOB5W8X8I2sJtKGdpFenf5iex06nfLUy4X4Ij8
 vILHszJfJ/9eVEooQfKYT0LsktmZvfs9q28b1coGUTkUW9gv4IFzPj92cAg4xo7CLhvNPItkQKq
 CPJJ8d1EUeeBumwpRlw==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a028fed cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=NbRwuLGaaJczqkI6BuYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/11/2026 12:06 PM, Richard Henderson wrote:
> Move the entire contents of target-info.c into target-info.h,
> marking each function inline.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/target-info.h | 82 +++++++++++++++++++++++++++------
>  target-info.c              | 93 --------------------------------------
>  meson.build                |  1 -
>  3 files changed, 68 insertions(+), 108 deletions(-)
>  delete mode 100644 target-info.c
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index d8d2194d9b..2c9f5c78fb 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -45,14 +45,20 @@ TargetInfo target_info;
>   *
>   * Returns: Canonical target name (i.e. "i386").
>   */
> -const char *target_name(void);
> +static inline const char *target_name(void)
> +{
> +    return target_info.target_name;
> +}
>  
>  /**
>   * target_long_bits:
>   *
>   * Returns: number of bits in a long type for this target (i.e. 64).
>   */
> -unsigned target_long_bits(void);
> +static inline unsigned target_long_bits(void)
> +{
> +    return target_info.long_bits;
> +}
>  
>  /**
>   * target_machine_typename:
> @@ -60,21 +66,30 @@ unsigned target_long_bits(void);
>   * Returns: Name of the QOM interface implemented by machines
>   *          usable on this target binary.
>   */
> -const char *target_machine_typename(void);
> +static inline const char *target_machine_typename(void)
> +{
> +    return target_info.machine_typename;
> +}
>  
>  /**
>   * target_cpu_type:
>   *
>   * Returns: target CPU base QOM type name (i.e. TYPE_X86_CPU).
>   */
> -const char *target_cpu_type(void);
> +static inline const char *target_cpu_type(void)
> +{
> +    return target_info.cpu_type;
> +}
>  
>  /**
>   * target_endian_mode:
>   *
>   * Returns: QAPI EndianMode enum (e.g. ENDIAN_MODE_LITTLE).
>   */
> -EndianMode target_endian_mode(void);
> +static inline EndianMode target_endian_mode(void)
> +{
> +    return target_info.endianness;
> +}
>  
>  /**
>   * target_big_endian:
> @@ -86,62 +101,101 @@ EndianMode target_endian_mode(void);
>   * the target, so please do *not* use this function unless you  know very
>   * well what you are doing!
>   */
> -bool target_big_endian(void);
> +static inline bool target_big_endian(void)
> +{
> +    return target_endian_mode() == ENDIAN_MODE_BIG;
> +}
>  
>  /**
>   * target_arch:
>   *
>   * Returns: QAPI SysEmuTarget enum (e.g. SYS_EMU_TARGET_X86_64).
>   */
> -SysEmuTarget target_arch(void);
> +static inline SysEmuTarget target_arch(void)
> +{
> +    return target_info.target_arch;
> +}
>  
>  /**
>   * target_base_arm:
>   *
>   * Returns whether the target architecture is ARM or Aarch64.
>   */
> -bool target_base_arm(void);
> +static inline bool target_base_arm(void)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_ARM:
> +    case SYS_EMU_TARGET_AARCH64:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
>  
>  /**
>   * target_arm:
>   *
>   * Returns whether the target architecture is ARM (32-bit, not Aarch64).
>   */
> -bool target_arm(void);
> +static inline bool target_arm(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_ARM;
> +}
>  
>  /**
>   * target_aarch64:
>   *
>   * Returns whether the target architecture is Aarch64.
>   */
> -bool target_aarch64(void);
> +static inline bool target_aarch64(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_AARCH64;
> +}
>  
>  /**
>   * target_base_ppc:
>   *
>   * Returns whether the target architecture is PowerPC 32-bit or 64-bit.
>   */
> -bool target_base_ppc(void);
> +static inline bool target_base_ppc(void)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_PPC:
> +    case SYS_EMU_TARGET_PPC64:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
>  
>  /**
>   * target_ppc:
>   *
>   * Returns whether the target architecture is PowerPC 32-bit.
>   */
> -bool target_ppc(void);
> +static inline bool target_ppc(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_PPC;
> +}
>  
>  /**
>   * target_ppc64:
>   *
>   * Returns whether the target architecture is PowerPC 64-bit.
>   */
> -bool target_ppc64(void);
> +static inline bool target_ppc64(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_PPC64;
> +}
>  
>  /**
>   * target_s390x:
>   *
>   * Returns whether the target architecture is S390x.
>   */
> -bool target_s390x(void);
> +static inline bool target_s390x(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_S390X;
> +}
>  
>  #endif
> diff --git a/target-info.c b/target-info.c
> deleted file mode 100644
> index f02a033584..0000000000
> --- a/target-info.c
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -/*
> - * QEMU target info helpers
> - *
> - *  Copyright (c) Linaro
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/target-info.h"
> -#include "qapi/error.h"
> -
> -const char *target_name(void)
> -{
> -    return target_info.target_name;
> -}
> -
> -unsigned target_long_bits(void)
> -{
> -    return target_info.long_bits;
> -}
> -
> -SysEmuTarget target_arch(void)
> -{
> -    return target_info.target_arch;
> -}
> -
> -const char *target_cpu_type(void)
> -{
> -    return target_info.cpu_type;
> -}
> -
> -const char *target_machine_typename(void)
> -{
> -    return target_info.machine_typename;
> -}
> -
> -EndianMode target_endian_mode(void)
> -{
> -    return target_info.endianness;
> -}
> -
> -bool target_big_endian(void)
> -{
> -    return target_endian_mode() == ENDIAN_MODE_BIG;
> -}
> -
> -bool target_base_arm(void)
> -{
> -    switch (target_arch()) {
> -    case SYS_EMU_TARGET_ARM:
> -    case SYS_EMU_TARGET_AARCH64:
> -        return true;
> -    default:
> -        return false;
> -    }
> -}
> -
> -bool target_arm(void)
> -{
> -    return target_arch() == SYS_EMU_TARGET_ARM;
> -}
> -
> -bool target_aarch64(void)
> -{
> -    return target_arch() == SYS_EMU_TARGET_AARCH64;
> -}
> -
> -bool target_base_ppc(void)
> -{
> -    switch (target_arch()) {
> -    case SYS_EMU_TARGET_PPC:
> -    case SYS_EMU_TARGET_PPC64:
> -        return true;
> -    default:
> -        return false;
> -    }
> -}
> -
> -bool target_ppc(void)
> -{
> -    return target_arch() == SYS_EMU_TARGET_PPC;
> -}
> -
> -bool target_ppc64(void)
> -{
> -    return target_arch() == SYS_EMU_TARGET_PPC64;
> -}
> -
> -bool target_s390x(void)
> -{
> -    return target_arch() == SYS_EMU_TARGET_S390X;
> -}
> diff --git a/meson.build b/meson.build
> index 9a804dc810..aad149cdb4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3868,7 +3868,6 @@ endif
>  common_ss.add(pagevary)
>  system_ss.add(files('page-vary-system.c'))
>  
> -common_ss.add(files('target-info.c'))
>  system_ss.add(tinfoqom)
>  
>  subdir('backends')

We could evaluate the added performance of this, once we have a
benchmark, with/without target_info being an indirect function call or a
structure access.

Regards,
Pierrick

