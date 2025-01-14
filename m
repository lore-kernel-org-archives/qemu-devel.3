Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFB2C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXh3q-0005Ih-9d; Tue, 14 Jan 2025 08:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXh3k-0005Ht-I2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:34:20 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXh3i-0006l2-0y
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:34:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-219f8263ae0so89581465ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736861656; x=1737466456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v6wuaPyDud7y+ceKMEfP/p/5jsuoQbihKSiTay+42Ck=;
 b=EICqMXPW3nbWNOZH9/meYE/io9f+5q6KrOfs1z2MSGDialXKzVg125jblhe34OFSBD
 cwOvyvBGDuSj1Vzv7t/Tsl1C2miJf57x+L7hEKs8RNvm93SQtGr889lFN0WZCU4SuMpS
 zthuRdi8ror5TTgc8I31H1j9MsbkhzAoBmzntWUApF9QmEAfKlT7aEuVotetEvIwV7Qr
 p6kTKhSfms72nR994BsQJ2LYdXU0H24LnV0vQIsG72S3BUlpsNLevsGu9gsDmj+HmzXC
 xVCCGMqnjEAD8FAgkcPmTm25iI6BTTbCYdXmoluyMNZeRiuf4I4kTb2lLYpHJL4VxF9g
 lqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736861656; x=1737466456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v6wuaPyDud7y+ceKMEfP/p/5jsuoQbihKSiTay+42Ck=;
 b=ejp6OoV+K8P4A6whNu/b0zMK/fLy+VmdZ8CsgHluJ3O81nRSbWbDq3px14HjAv446Q
 zD2EGAOPrPy46au3WPVpU8cQkHwEJk765R4vXXoF+2E6fb6vQXaU7fopegp2yeca1UqB
 BQEYIjambPEPJeDz6304bTkfbO3mU7k4qGu9I5cenaMv9UBXq9Lc9QMaKXdLVy4by3WF
 FRfosZMlAfc0B+npvmnni/JyP5lEfFAhM5z5vt4SCxIftyYOWOhnHcGmi4W56MN9XeVm
 Pz9KQb2zt2wFiErp/dOI7PtKGQYYML4Unh4btts7VTLGJ+usD/DwTnPdNRiMagC34OFw
 lCtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVB7QPfVOtNsQ50ZPi+pkf1rVQJf/qVjQ/nupScmpf0rcnx1m5CYJNP0OiJwQvtM8FKUi8FKhRpRQJ@nongnu.org
X-Gm-Message-State: AOJu0Yw9pH1TV0B2r4rwkKaYgHZYlCSmHuYqCONJeg9+iozZyv8cfRBU
 XWMJroPrghRoiWMe65B6TTm+sMq9M5ZIYG438Xfa5Mj8/5eTB3H7kZi/3bN50Hs=
X-Gm-Gg: ASbGnctXxePgijt0ZlGUalMsoGLk8VnsoYHViQNA/VqJc08xbOjJMC5pYdodc8CC8TU
 JKgoXpPTGYAIt8a3yql8KCgVGRS/6e3GbxlGGGnWD2iqnisjeTSborcFtMyWSGzIyctKD8xi33t
 gDXWNQxmOBGczQj08lfIWURr8S0/msLP7PxV/fOEQzT6lyFa1JeX0SoiV1UPrAGXuqJRHi5m7LQ
 VnXV8RASTLnpnMbGjuXpJsMV2yxN69KbBq/ye+cnYwW8xOo5zyCEtQotdOO301WH7Sy6UgO
X-Google-Smtp-Source: AGHT+IFmpExB5c0+dLB6XSDsYdDhchHiQ1KvTViC4Q2a44s2u/3tbu69KSM7hgld6TADCwIyxd3EGg==
X-Received: by 2002:a17:902:ecc7:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-21a83fda87cmr381668165ad.52.1736861656096; 
 Tue, 14 Jan 2025 05:34:16 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f21e279sm67742375ad.134.2025.01.14.05.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 05:34:15 -0800 (PST)
Message-ID: <5ae5a279-36ac-4a44-a5ad-2babc28a8705@ventanamicro.com>
Date: Tue, 14 Jan 2025 10:34:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/riscv/riscv-iommu: Remove redundant variables
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250114093647.4952-1-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250114093647.4952-1-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 1/14/25 6:36 AM, Jason Chien wrote:
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 9424989df4..fa8a50fa24 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -58,11 +58,6 @@ struct RISCVIOMMUState {
>       /* interrupt notifier */
>       void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>   
> -    /* IOMMU State Machine */
> -    QemuThread core_proc; /* Background processing thread */
> -    QemuCond core_cond;   /* Background processing wake up signal */
> -    unsigned core_exec;   /* Processing thread execution actions */
> -
>       /* IOMMU target address space */
>       AddressSpace *target_as;
>       MemoryRegion *target_mr;


