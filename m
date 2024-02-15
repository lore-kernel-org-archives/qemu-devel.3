Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62835C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radkJ-000462-Ig; Thu, 15 Feb 2024 10:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radkF-00043n-Rp
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:33:52 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radkE-000248-8s
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:33:51 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a3cc2f9621aso104078466b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708011228; x=1708616028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KiA5fxKEHs1HuarSxxPG+s1cSmN1+KDdrLBBwz4U2Tk=;
 b=NzZdTS7ZtikorWc6znzrJf6GdF5tXM8PT5184WlwxaVBLli+Z7+nwvfCNE7T2N5Ltx
 4bcLRG6Y1IU6n9O+YhOOAj83eB0YJ2cILgDq1Uf5PnexOH4jagU2dMwiUGlt27bx7J3w
 cYysm9ow2eaP4i6Cd2Pl2foO1E9bCLfejFUtpW1GxK1vaFYmMU+X2slIPfDVhlOO1Oaf
 +dus0wt9Q8x/NSTk4Cs/bJaBdx5swuUMPIRBGYqGM/yJXmW0ZV/QugjKSgVgToMGnFQ7
 9ltDpCFYS073Loe0zr1G8PaTK8qBA4g2qaVfp1LiPJl+AP/YDM6Rql3XNErCZh+HZ5YW
 w5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708011228; x=1708616028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KiA5fxKEHs1HuarSxxPG+s1cSmN1+KDdrLBBwz4U2Tk=;
 b=uZ9yq2uoNISU0dq0smHmL2irsBnVeAsKmlPxrgfTSpWwv6HBwzB4Qhx6SAklZSgz+a
 kznrV75NxlTsV2B2LG8oMspJslzopnQZPAd0m0uCB78wQ2ktgiDgLX5eXx65mbQTpYpU
 0pvxEeSpxLEJQnHTAhEAeNHGwlQ7jFZKEoontc6v2KZa1rBYQQmHqQ4mccCC1ZtXmT+Q
 xnn92GbhxhodLacGEFNkAUcm6Fe6v0xfxMMgTkCdoxs+48E9FKJ6iBotCt8vkAhHvCwX
 gi6A3q5dfPTDaxWsoWBYTxGUVwFtJQJ2J76kj2cDKTVi8vVORsA49N9X63sxmQyEzgd2
 U7yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx7kvkq7FOMVDiGKakqG3CFVKRFd+YjLR3v1aOOP7GiABDX+Wc9G5zCUL2EDsiTmcdjCjvJ8Y6b0yUI8FTaW6Qq2A0css=
X-Gm-Message-State: AOJu0YzvaXrCujN5A15GtauRX9d74pdodT+FibmvhXtkxzpvObunsrms
 LnC209iqK7eCgfMsQAuVBeijzKQTTUlkxf0drbPifi81WIH8e7F8Epzu0SbUlFE=
X-Google-Smtp-Source: AGHT+IFeXaq29rbgD+Vi1PkfsSNtK04QWm6IerTb9I96DgkHoeOSMnsdizDAnrvYykJRDKZt1gtkYw==
X-Received: by 2002:a17:906:a88c:b0:a3d:b130:560f with SMTP id
 ha12-20020a170906a88c00b00a3db130560fmr688584ejb.13.1708011228659; 
 Thu, 15 Feb 2024 07:33:48 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 dk24-20020a170906f0d800b00a3d81b90ffcsm661462ejb.218.2024.02.15.07.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 07:33:47 -0800 (PST)
Message-ID: <bdeb194e-28f6-4dda-bf85-bd1a0b983ecd@linaro.org>
Date: Thu, 15 Feb 2024 16:33:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be in
 mmio memory.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 16:01, Jonathan Cameron via wrote:
> On i386, after fixing the page walking code to work with pages in
> MMIO memory (specifically CXL emulated interleaved memory),
> a crash was seen in an interrupt handling path.
> 
> Useful part of bt
> 
> Peter identified this as being due to the BQL already being
> held when the page table walker encounters MMIO memory and attempts
> to take the lock again.  There are other examples of similar paths
> TCG, so this follows the approach taken in those of simply checking
> if the lock is already held and if it is, don't take it again.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   accel/tcg/cputlb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 047cd2cc0a..3b8d178707 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>                                  int mmu_idx, MMUAccessType type, uintptr_t ra)
>   {
>       MemoryRegionSection *section;
> +    bool locked = bql_locked();

Maybe clearer as:

        bool need_lock = !bql_locked();

>       MemoryRegion *mr;
>       hwaddr mr_offset;
>       MemTxAttrs attrs;
> @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
>       mr = section->mr;
>   
> -    bql_lock();
> +    if (!locked) {

if (unlikely(need_lock)) {

> +        bql_lock();
> +    }
>       ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>                             type, ra, mr, mr_offset);
> -    bql_unlock();
> +    if (!locked) {

Ditto.

> +        bql_unlock();
> +    }
>   
>       return ret;
>   }


