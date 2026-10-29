Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mFnMJmH/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSOP-0008Et-K5; Thu, 29 Oct 2026 11:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSOG-0008EX-2L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:50:09 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSOE-0006fv-Gc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:50:07 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-451a49abd8aso2013799fac.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793289005; x=1793893805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZOR46rDQmNkZfMZuCEAOGS7UScTl7ncgVTDyvuBK6as=;
 b=mFnMJmH/4wtYEOtmGDPCHM2pLRmD/P6H0k9EH8+uAdrv+lBMxDJ+h4gtf8vmdB6hN7
 mb0DhXZ1ppMEJInTbpdyT9KnrANe3qCuk4eJ3BZ4ErWOHOFiP7YSh0AvS9nlTdQZ29KV
 TMhiA6eOpB0rHd6Sc+zWUXU4AKdyCte8aeE44daHxAOwtng5A0LZsqo7TvEvEo4A0fOw
 iZwnyypxfzcd6lBJLUjsIoPn3Prc7a38XdfTjKn5hhtYLjtAncJIWsFvtvDfoC85s4hb
 qlqKIWnHYY5UsftvuBkFiloFPkJosDP3iBpONOTxYsQBH7OAdqrJlxpuQ5eU5BxdQ3Eo
 uZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793289005; x=1793893805;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZOR46rDQmNkZfMZuCEAOGS7UScTl7ncgVTDyvuBK6as=;
 b=m9g/ta8W1kBjdWs4/e8Np03664mp+079fesmq7dZU/CI2UTFP8EGh9J/2f4HTtLZN2
 pQXcoF1H3a0qIzxf2O124rX3F7NcvJkLzbF8BzFsBkZN9/+U9T6UAgkOH0QytKdCxLWZ
 pnWlEiIeIjZel57EE7+ikQuIVMV/ALR9H48j3dAAdAFy+hqNCSL67ESUuKREiOkWeqnG
 hoRHIOSL7Ygu5SDrRDoV6oAmscJl0wciPaoQKpP4lY1hrqu+sYTMwpObuvmQoF3W72+X
 z8ckSDte/kMUBD1vsKZrcNbpVvjDFWvltlfeOW79hZHG6xB7BJHw+mPRvEEFtzASnSiR
 LvTA==
X-Gm-Message-State: AFq9FYIvgpsyptr/641WYqkRLQHTY/7Xch8hgfnsUGAs3aeXnQOTQJv5
 Dk0JdNkxdphbqHGHex0WDaKMS5c+rJBHbNia2U6LJg43OvffAH1XJNaid1X3Vwb7rnA=
X-Gm-Gg: AYBFou1mY4wKB2tuj224gk+zWG9X3EVQ7yiVDE8FYxSrZ10lr6RqQ5coo+FoySsgJtq
 ceDPvxwrSDeIj3d+a6cf4iS/CHHrze9gpOOf75Wg/luoWgHznOTMVIxTMGAXDWnB5P4VbvcgGGH
 M94kKmK78D9FvdTuQ9dd0EKeeu6PjCfcn4CWhova6t7DfOQjNV9CALtg6pnCTTFzo7pc72yVCv5
 ahGnx3s9E4fLkOqQfRiZ8kRJrVgjebh4y1y64RAlec12mpGG2RHoF6It6IQd+uHNZUvXknNe8lK
 3DXZ3oltmrQT9uA3d2bAgpSE5wof3Hgh6y8dzuYHQ4BfvVyExJzdUbT1DpWY3kWNP6UIQg716nW
 bXV9qaeDlnnnz2kz74UWg1uR2C3DraQwpKYHxzeM14cIryyeYA2Qg7JjVjQJ07ZuzuZzqoz8KeM
 n4D5CJuir2QMT/O3J6GZJWzSS0OO857DneSVotVBZXz2N2mwZgeFk1DZ5FKRZwHECElV56g39My
 SugQRAOJajL+MtRZBZV9yda3ePZoofztGojUZmppkmbdD4AxpRr6QYkjVaj5JSvOl8Z/aWzAzvN
 VcUANuREr5V5v/SbCvJoH2LIoRPjWMSDMphTDGcZWGAa
X-Received: by 2002:a05:6871:4318:b0:4a7:4a7a:1e27 with SMTP id
 586e51a60fabf-4a8bb933039mr4287905fac.48.1793289004621; 
 Thu, 29 Oct 2026 08:50:04 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9021f9987sm99671fac.12.2026.10.29.08.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 08:50:01 -0700 (PDT)
Message-ID: <7a9574a1-f82d-419f-ae6c-6dd635ce5f3a@linaro.org>
Date: Thu, 29 Oct 2026 10:49:58 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo: Remove obsolete OpenBSD/aarch64 CPU
 detection
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <auLo2X1RwG96lPmu@humpty.home.comstyle.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <auLo2X1RwG96lPmu@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 10/29/26 01:34, Brad Smith wrote:
> util/cpuinfo: Remove obsolete OpenBSD/aarch64 CPU detection
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   util/cpuinfo-aarch64.c | 35 -----------------------------------
>   1 file changed, 35 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
> index e344676214..85df16ba5f 100644
> --- a/util/cpuinfo-aarch64.c
> +++ b/util/cpuinfo-aarch64.c
> @@ -26,11 +26,6 @@
>   #ifdef CONFIG_DARWIN
>   # include <sys/sysctl.h>
>   #endif
> -#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
> -# include <machine/armreg.h>
> -# include <machine/cpu.h>
> -# include <sys/sysctl.h>
> -#endif
>   
>   unsigned cpuinfo;
>   
> @@ -85,36 +80,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_CSSC") * CPUINFO_CSSC;
>   #endif
> -#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
> -    int mib[2];
> -    uint64_t isar0;
> -    uint64_t pfr1;
> -    size_t len;
> -
> -    mib[0] = CTL_MACHDEP;
> -    mib[1] = CPU_ID_AA64ISAR0;
> -    len = sizeof(isar0);
> -    if (sysctl(mib, 2, &isar0, &len, NULL, 0) != -1) {
> -        if (ID_AA64ISAR0_ATOMIC(isar0) >= ID_AA64ISAR0_ATOMIC_IMPL) {
> -            info |= CPUINFO_LSE;
> -        }
> -        if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_BASE) {
> -            info |= CPUINFO_AES;
> -        }
> -        if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_PMULL) {
> -            info |= CPUINFO_PMULL;
> -        }
> -    }
> -
> -    mib[0] = CTL_MACHDEP;
> -    mib[1] = CPU_ID_AA64PFR1;
> -    len = sizeof(pfr1);
> -    if (sysctl(mib, 2, &pfr1, &len, NULL, 0) != -1) {
> -        if (ID_AA64PFR1_BT(pfr1) >= ID_AA64PFR1_BT_IMPL) {
> -            info |= CPUINFO_BTI;
> -        }
> -    }
> -#endif
>   
>       cpuinfo = info;
>       return info;


