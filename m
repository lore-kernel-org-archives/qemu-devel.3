Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A881C531DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0Eq-0001F2-AE; Fri, 16 Aug 2024 12:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sf0Eo-0001Do-Q2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:55:42 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sf0EZ-0005MD-P2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:55:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-710e39961f4so1624066b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723827326; x=1724432126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vZ33VjOzMVGqTRhI6JcBPKSAYch3Wl7d+95HVVN1Ghk=;
 b=hZZPt8xaJajOOl+J9hAZISfzOdXytdkrk3mj5RZasC0oF9eWPDVyKApWGa9k2AcCM8
 KkjNnjpULRzy9KH3gvi7ZcJLuruSrB8MvMe9w5xdV9wNMhO6GhqsnWwHyu2Iehtdk4+F
 yz7zdseD9ir3xzQVYqmZrlIl3snVlzVUr51SPLkLi2ZYy8CYmg4tzgTqQ5aK/Zf5D7Hm
 KstgcwHwx4E/dkGwsufaST+CRs9pSN7GZrtmymI4A3+TXc3vz1L3pziWUoRNw+4zAedw
 hl1dPJs5Dw9KpZhjX11bKxdgBPROINumht6MJXNmTwdkajvjRWmZ42JO1MhB1L3pVyQQ
 AKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723827326; x=1724432126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vZ33VjOzMVGqTRhI6JcBPKSAYch3Wl7d+95HVVN1Ghk=;
 b=nMtcXHEqzkUE26VbEeENc8vTksFSRz2doLVh5bZZW8+S4lvjcon1iY0FUo06HSQT4R
 3ar88noGVIdWpTQP3z5Nup6BEFRGKV5esPPxYWrJcWiZ8D4HNusg/lDIPdLjPvOZ3Ukx
 3Y7GjOYBNsvfFOBqdWNMFosBsjjfBNdPdpC15iiH9Q/ITmJwzAK4rE18Q1iqqEAFZStZ
 wnLZl7IJ23uOFMaukPXFQK2WEerIm86NI4NiGopSF/yrBMFq+d+Y1gAxjSVywWWKgYFU
 PO3+NkscIXRARxozjEZwaHQ5BlJ8lcsGI/KZRtv+Tg94FIGtKnvOhQTT22i/dAkl6Dfq
 ZcdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUomldjFXsJd7TMQIBl/lYFf6x9ZCuNf3MZk73XlDmG2AgrRl7oQyvo8zFwoTSpjCNsx3835vuEugZJzBufPsM2t/pX18=
X-Gm-Message-State: AOJu0YxBj6KW9V5vc2YhTj34ZXpCghsfj1Fh3AkfAZfCjbZsGAjofBhA
 BzJdOPi5VbDPrjdctIF+dpFA0bbfGFC+/kO8hbP+3csLGnCvZ/PDNSRfbJoYevr+TaMPcgSOajs
 5
X-Google-Smtp-Source: AGHT+IGxU9GQNNCh3MUeDyWu6kBw7pMhr9GkZ2p/sLKBH5goiemAPDfude3YrAKx/Owdu9yl6mXCUA==
X-Received: by 2002:a05:6a00:189d:b0:70d:2455:1743 with SMTP id
 d2e1a72fcca58-713c528b93emr3254747b3a.29.1723827326248; 
 Fri, 16 Aug 2024 09:55:26 -0700 (PDT)
Received: from [192.168.68.110] ([179.133.97.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127add8e41sm2825589b3a.24.2024.08.16.09.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 09:55:25 -0700 (PDT)
Message-ID: <303ea731-cdc3-407c-8283-2ae4d947cf2b@ventanamicro.com>
Date: Fri, 16 Aug 2024 13:55:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 1/2] Revert "hw/riscv/virt.c: imsics DT: add
 '#msi-cells'"
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 Anup Patel <apatel@ventanamicro.com>
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-5-ajones@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240816160743.220374-5-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 8/16/24 1:07 PM, Andrew Jones wrote:
> This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.
> 
> Linux does not properly handle '#msi-cells=<0>' when searching for
> MSI controllers for PCI devices which results in the devices being
> unable to use MSIs. A patch for Linux has been sent[1] but until it,
> or something like it, is merged and in distro kernels we should stop
> adding the property. It's harmless to stop adding it since the
> absence of the property and a value of zero for the property mean
> the same thing according to the DT binding definition.
> 
> Link: https://lore.kernel.org/all/20240816124957.130017-2-ajones@ventanamicro.com/ # 1
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


This is indeed a 9.1 fix. Thanks Drew for sending it.

We can discuss whether we should wrap this around the 'strict-dt' flag or not, but
that can wait for 9.2.


Thanks,

Daniel


>   hw/riscv/virt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 9981e0f6c9b9..cef41c150aaf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -552,7 +552,6 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
>                             FDT_IMSIC_INT_CELLS);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> -    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
>                        imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,

