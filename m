Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34C9C3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 00:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYEG6-00034k-UG; Sun, 28 Jul 2024 20:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYEG3-000345-JP
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 20:29:01 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYEG1-0005Vo-U1
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 20:28:59 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cf98ba0559so329476a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722212936; x=1722817736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ureO37x2Y0rRaMGSJZRNYyVjA/gsJLNWYunSo0UGE5w=;
 b=QJAksD5ciAJ8ZbcjKcTc/YVWlZdHWeAQy2+8M3mmB3esB9Damt0CkJYI1KqTgoZe1d
 eJ6Io1nt9sNJ6hA3zESpvoaLS/kEtrtsx2hTK1pztJ68cQWIdNHNHvR2FJ7WtX2WgTyB
 yIbe6jhWMt0xCTsHEwSHSjOaZe1LOLtiBl5DWiCbLLODzLXUS992E5F/aEeARSPtPyMV
 Hb/vEBoRDW4ShV+fqWG0yFsdbJn2kpypmAVmpc3MHKOHhDS01Hdi9Uh75E9YujfZFoei
 jeTNkkT+ATG8cMkl7PGAm4ts274C2O0lINilvr66PrM7BN05X1dXga7PYLG9bHwFuYf6
 zHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722212936; x=1722817736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ureO37x2Y0rRaMGSJZRNYyVjA/gsJLNWYunSo0UGE5w=;
 b=ueHateibzY5BXbfj0VDhiUUyhywLT1N5/G2XtJZd+3Ke72OHh3FGtAg2B3upajBuOv
 +m09RRtKtugeqOEy51yyfXgihYzuCqphPrCaI/g0CMG7kX53jmyZ9CuUGVMUqiAH6GVi
 KBXQ4XLU4815Z75050yT7b67efOu9YjNI63KTkSNLz7OMxAQmUuq6y6AntZLhOBqtOC3
 yVno7/5lcQA6G232AtSj/nJ3S1/ZCFn/cL4UMTpQl6Zj95UNhZ41ifQ0U41BuQlII4GC
 lQXYAtZ46eN8TDgeMM0ZdE30Wv1XA7TvXqVoTYogHZW+pLZrNnxl00ol4muqE56vzI7p
 C9AQ==
X-Gm-Message-State: AOJu0YzQjlL1WJtrRSYf0rIfRib7C+KkdfyjK+BvXPkj4k7OlnaS0Ing
 feFtruxQWih9GJx4pBiIQYYLVpdMJzG24W8mSysOXPqFgzpB6JJ8muIKsBb8NWEUV+epurLBOS2
 Ii13KDQ==
X-Google-Smtp-Source: AGHT+IF17SrH8LSIctlVj5klEhzNaGYN2Coa2mMTl+GsLO/1gHhe6e3A99Jcz4GmZ5MImUt26Swr+g==
X-Received: by 2002:a17:90a:ca12:b0:2c9:6401:4d1d with SMTP id
 98e67ed59e1d1-2cf7e5e107emr4032763a91.34.1722212936127; 
 Sun, 28 Jul 2024 17:28:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7f7b0sm7326428a91.23.2024.07.28.17.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 17:28:55 -0700 (PDT)
Message-ID: <54158226-aed4-4af1-83cc-68df9c284087@linaro.org>
Date: Mon, 29 Jul 2024 10:28:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 7/28/24 13:58, Brad Smith wrote:
> util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   meson.build            | 8 ++++++++
>   util/cpuinfo-aarch64.c | 9 ++++++---
>   util/cpuinfo-ppc.c     | 5 +++--
>   util/getauxval.c       | 2 +-
>   4 files changed, 18 insertions(+), 6 deletions(-)

Queued.


r~

> 
> diff --git a/meson.build b/meson.build
> index 5613b62a4f..97f63aa86c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2835,6 +2835,14 @@ config_host_data.set('CONFIG_GETAUXVAL', cc.links(gnu_source_prefix + '''
>       return getauxval(AT_HWCAP) == 0;
>     }'''))
>   
> +config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(gnu_source_prefix + '''
> +  #include <sys/auxv.h>
> +  int main(void) {
> +    unsigned long hwcap = 0;
> +    elf_aux_info(AT_HWCAP, &hwcap, sizeof(hwcap));
> +    return hwcap;
> +  }'''))
> +
>   config_host_data.set('CONFIG_USBFS', have_linux_user and cc.compiles('''
>     #include <linux/usbdevice_fs.h>
>   
> diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
> index 8ca775a14b..57468890c3 100644
> --- a/util/cpuinfo-aarch64.c
> +++ b/util/cpuinfo-aarch64.c
> @@ -17,10 +17,13 @@
>   #  define HWCAP2_BTI 0  /* added in glibc 2.32 */
>   # endif
>   #endif
> +#ifdef CONFIG_ELF_AUX_INFO
> +#include <sys/auxv.h>
> +#endif
>   #ifdef CONFIG_DARWIN
>   # include <sys/sysctl.h>
>   #endif
> -#ifdef __OpenBSD__
> +#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
>   # include <machine/armreg.h>
>   # include <machine/cpu.h>
>   # include <sys/types.h>
> @@ -61,7 +64,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   
>       info = CPUINFO_ALWAYS;
>   
> -#ifdef CONFIG_LINUX
> +#if defined(CONFIG_LINUX) || defined(CONFIG_ELF_AUX_INFO)
>       unsigned long hwcap = qemu_getauxval(AT_HWCAP);
>       info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
>       info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
> @@ -78,7 +81,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
>   #endif
> -#ifdef __OpenBSD__
> +#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
>       int mib[2];
>       uint64_t isar0;
>       uint64_t pfr1;
> diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
> index 1304f9aa80..ccfcaa0754 100644
> --- a/util/cpuinfo-ppc.c
> +++ b/util/cpuinfo-ppc.c
> @@ -14,7 +14,8 @@
>   #  include "elf.h"
>   # endif
>   #endif
> -#ifdef __FreeBSD__
> +#if defined(CONFIG_ELF_AUX_INFO)
> +# include <sys/auxv.h>
>   # include <machine/cpu.h>
>   # ifndef PPC_FEATURE2_ARCH_3_1
>   #  define PPC_FEATURE2_ARCH_3_1   0
> @@ -35,7 +36,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   
>       info = CPUINFO_ALWAYS;
>   
> -#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
> +#if defined(CONFIG_LINUX) || deinfed(CONFIG_ELF_AUX_INFO)
>       unsigned long hwcap = qemu_getauxval(AT_HWCAP);
>       unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
>   
> diff --git a/util/getauxval.c b/util/getauxval.c
> index b124107d61..5bdbb04f8f 100644
> --- a/util/getauxval.c
> +++ b/util/getauxval.c
> @@ -98,7 +98,7 @@ unsigned long qemu_getauxval(unsigned long type)
>       return 0;
>   }
>   
> -#elif defined(__FreeBSD__)
> +#elif deinfed(CONFIG_ELF_AUX_INFO)
>   #include <sys/auxv.h>
>   
>   unsigned long qemu_getauxval(unsigned long type)


