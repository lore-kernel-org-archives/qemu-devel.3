Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC034CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 21:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4QPT-0004J8-Ip; Thu, 02 Oct 2025 17:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4QPQ-0004Hy-CU
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 17:00:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4QPG-0002f1-W1
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 17:00:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-27c369f8986so14447175ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759438798; x=1760043598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZgaG6L7w/32t1z5NHsy7W/Ry/MRI+p/rGm6RDRjO0Ok=;
 b=nGt9cRcd9Ge7dDUWl7rDo2hvjhokfis+3wcZ4bqWDvWjGOQWpK5W5jiLvHBjMzMRWn
 scT7DlGgm2s+u9xiKJ6F0aYIGBpzEAHOHS2vontw58KDo6jnCP0RGvnQg0rZ5F0HER+M
 6FW8SUKCY6jGRut8fztZPK3at6Mm6OvAolaVYFLa9IyArqGLpLzK5oy5X+9M7HhdGMHr
 +mhTRm0QRhPhyt2/k/BOuLZebvzHAgd63cE4wXLznT1vuAyDGdBL2RNZkflo9rHsAexC
 Ghw3GeSkTOBneACH9furOp3i1ZWhcHDwrRUAaQ7Jmy8g42ZVFNWXbANsUDWYK/kM2p58
 R7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759438798; x=1760043598;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgaG6L7w/32t1z5NHsy7W/Ry/MRI+p/rGm6RDRjO0Ok=;
 b=lb0vcjPWGJUWud/I3ypz7ePPsvCtzBnraOAYicU493vd+Bb919JpNZswYNvneghZz6
 9wfjRyEWVodabagoeoen3x6v9ABFm851lwovKK6gYYijIS1yA9f8eAYmJj2/a4Y29Ldu
 RcYwd5ge8yxzC6BNuvvzyULHF3O4UsZ72pO7RI4xV+lH2X23tDWOYF8lz128XscZ/tQx
 qEOFSsIdtd+OWZ0MZLKuoi6LwwvnrlQsXWv+HZwEUTZo7iaIkuyyOdH0W9TtyVYSBi3n
 D+ylYpe8ZXsGMhdSrMvqdUqGR2fvVWDoVMeDBAz0+ikPZhdlW39ThhQPjdetnJM6O5ro
 3Uug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU3IaSzgLT5JuL+6/lowP52NqcJcnTiMMlYcXVGkNxKIC1dVs9TzeMR2UOegECU3C2SffzaRG+XM1o@nongnu.org
X-Gm-Message-State: AOJu0YwQjF3VS+eyRKnidxjKkYJpM+moEZmlGS+mCHmqimB66hVdTesV
 YTDn3OGPe4I0szryaISWKKZ514jo0IXAm0ycDtfEoLi4D+X5fubc+TAd1trJUaPJTMk=
X-Gm-Gg: ASbGncuMBBDqQxZxA/gMVMFakMDQbH2SwApkMzZwrsDNVDZZ5QDe3Yo9wTjuebwVMdt
 +F2qmRi71mIN3TaDbbOQsN+ZqDR2mcBjJMFegDqJT7865M+UmCC8IDbGirl/YOeVw+HCzD7YSU1
 uHo2/QN8pWV1mqv0uw4VJMa1BBjTipD02H3qw72V7pCd7UPyP1Pc+lopguAQaF38GT7CRIrz981
 KnQxDyP2o6GSt4LngwSF/IWTFWXVsiqOhbJBs8AMx3Js51Tp74Sco6F4ZJO+W5i6/IZFGrGsYVW
 Ppkm1cR0wEiOzml86Zwy+j26K/hp3Gap80B+1t/cS9ovn/AKJJ48cPg9+RUSbbASWre4YtvfjPW
 znL4Po/DDTN74ObUX1ZxbkEhPvxoNzq/33KOg3yLvVwJNoGJBZufIDMEJKLrrGyA=
X-Google-Smtp-Source: AGHT+IEUzgIXqptPmhG2+RG7AUHp/NureYwrzhBce1JpE5n32P+Ql8KgZMZwW8dK0Ac8H8cUM2hPWg==
X-Received: by 2002:a17:903:240c:b0:28e:9a74:7b58 with SMTP id
 d9443c01a7336-28e9a747d94mr5139055ad.31.1759438798343; 
 Thu, 02 Oct 2025 13:59:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d12bc5asm29698295ad.55.2025.10.02.13.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:59:57 -0700 (PDT)
Message-ID: <7199d49a-e643-4c20-9938-2b72beedc237@linaro.org>
Date: Thu, 2 Oct 2025 13:59:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Enable firmware support for PIE and GCS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251002185910.584990-1-richard.henderson@linaro.org>
 <20251002185910.584990-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251002185910.584990-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/2/25 11:59 AM, Richard Henderson wrote:
> ---
>   build_arm_trusted_firmware.sh                 |  1 +
>   ...arm-trusted-firmware-support-PIE-GCS.patch | 30 +++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 patches/arm-trusted-firmware-support-PIE-GCS.patch
> 
> diff --git a/build_arm_trusted_firmware.sh b/build_arm_trusted_firmware.sh
> index d223142..0b148ef 100755
> --- a/build_arm_trusted_firmware.sh
> +++ b/build_arm_trusted_firmware.sh
> @@ -18,6 +18,7 @@ clone()
>           git clone $url --single-branch --branch $version --depth 1 $src
>           pushd $src
>           git am ../patches/arm-trusted-firmware-support-FEAT_TCR2-and-FEAT-SCTLR2.patch
> +        git am ../patches/arm-trusted-firmware-support-PIE-GCS.patch
>           popd
>       fi
>       ln -s $src arm-trusted-firmware
> diff --git a/patches/arm-trusted-firmware-support-PIE-GCS.patch b/patches/arm-trusted-firmware-support-PIE-GCS.patch
> new file mode 100644
> index 0000000..132e939
> --- /dev/null
> +++ b/patches/arm-trusted-firmware-support-PIE-GCS.patch
> @@ -0,0 +1,30 @@
> +From 0925eadf8922bbe811ec41fb983347928f3bc63b Mon Sep 17 00:00:00 2001
> +From: Richard Henderson <richard.henderson@linaro.org>
> +Date: Thu, 2 Oct 2025 11:43:11 -0700
> +Subject: [PATCH] plat/qemu/common/: add support for FEAT_{S1PIE,S2PIE,GCS}
> +
> +---
> + plat/qemu/common/common.mk | 7 +++++++
> + 1 file changed, 7 insertions(+)
> +
> +diff --git a/plat/qemu/common/common.mk b/plat/qemu/common/common.mk
> +index 6bc1084..2c344b6 100644
> +--- a/plat/qemu/common/common.mk
> ++++ b/plat/qemu/common/common.mk
> +@@ -126,6 +126,13 @@ ENABLE_FEAT_HCX		:=	2
> + ENABLE_FEAT_TCR2	:=	2
> + ENABLE_FEAT_SCTLR2	:=	2
> +
> ++# 8.9
> ++ENABLE_FEAT_S1PIE	:=	2
> ++ENABLE_FEAT_S2PIE	:=	2
> ++
> ++# 9.4
> ++ENABLE_FEAT_GCS		=	2
> ++
> + # SPM_MM is not compatible with ENABLE_SVE_FOR_NS (build breaks)
> + ifeq (${SPM_MM},1)
> + 	ENABLE_SVE_FOR_NS	:= 0
> +--
> +2.43.0
> +

Good for me.

