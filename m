Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60054C36013
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 16:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzHoL-0002Np-Us; Mon, 31 Mar 2025 12:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzHoG-0002I1-Cx
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 12:16:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzHoE-00009F-Br
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 12:16:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22622ddcc35so8858485ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743437781; x=1744042581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJtFi8D7vhmcfVxTwvz1pcXTXbXta4Z6msoZeGbGGbg=;
 b=BM+Bo1BNBptZFhYVWRnc9sqV/6sohZE3zIExcV0Cua5JxXrZi3ECwWnC5eZH5iysmb
 VX/zG8UbSA9YkZ+6jrND4+jaUK0ZGeWlb8ahBrp9hSUQRDH2Q14VAQHFeg9JCl6mjAJ7
 1yGAYmcxf2PN8hyNw9QmFlYKl7JS5IHBicXtX66lCdN93Lfnr6gwV43pIJVggPUCBZRZ
 inVrN4HE5fRe2fGF5Tv07yRywL8QMz76gV1qfEpVP0KVhTVxYms/1cAGbquqc6RbWa8d
 fqc5fAkBCxmo9B5oM7a4BmmruPznQYJhwMdBaZ4Ks6jpvXTbnWJvUENxez0UffU6kdYG
 5jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743437781; x=1744042581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IJtFi8D7vhmcfVxTwvz1pcXTXbXta4Z6msoZeGbGGbg=;
 b=mJCFELEgVI/O631NeGPcqsNRc5Ql2CX8lhl/00CwBuNmhu/R5W+TcS6EgHhrd8hl/w
 EDE94uc5m9nprSV9ZdZUcBGjXZfX/biC7lDB/O32NVhvq9/JxcwdAwAAiL7aeXxNFn9a
 F9trwNns9rSQJG6MxYR5w1k12NrhzUh9F1kuA98OzwsY5i79nKiWk7+7OkqrY283yzkr
 l6UvdsfT/6fNSz957v87JHXV59mG7zF2Gq9gLyNrZwFbkxKxUeKwO1oAK9QGQenJlyF1
 Ks+S/Whb26S8neY/Xiv69/lgfGW2lHLdc/hHWOfGv6217tuRs5D6OeSIgO9+WMGZzdlg
 KFmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8WT1v9su1rsz/Ss2AZMjRFp7orj+yDjcDB3orKDyc8IOrqX2jZBHi1b6VukQtwo7sLpSWuSs7Bn4A@nongnu.org
X-Gm-Message-State: AOJu0Yzfxy0wukYrl69k0AppEcDIpu0iifXLqQNRrxwB8Tmxa909qid2
 MS/l/SZ7bBd2zCL3jsGpDk6wDSRY5+GJaOo4XyWUwmpvRfNT6uy9Md2AoIfCHWEhKOXlAP5GYUM
 i
X-Gm-Gg: ASbGncum+W64A4gKGnht5mgUTnMTUwX6hP1mjw+beY1lvtQbaPA1YgCbRY/729lLXFx
 VJM9GwDP6Z5wnj2/6xhESJQBU79ImFXjyBQfvyC3m/y8URBHS3/SItCZRSioXe5lSogmnOYC5cf
 Oe1hDer1sOeeruCYxgRZrGKSlR5x3INAsosb7j5OdCgkCLY4p5ObJy0AkHcbx3oT6w3RnJHo1X1
 ouojL/xsFw3U6KmjEXXAoGj57Piv4dT0eiltlFF7svUT4WgxWKems53jWpo3EBRgizneOhrcJoi
 BaWNVgAjJvDHHD6TjBcHIrE8Dy2ZsCklPvsoVoik6YqDRe8iRbOkSQA+
X-Google-Smtp-Source: AGHT+IErW3TOqykc2L/JncQVvNJmR9oC8k8PpzTwaJupQO5cm8GNXgAD9bZYvKf+aCTSmJcVTuQASQ==
X-Received: by 2002:a05:6a00:218d:b0:736:fff2:99b with SMTP id
 d2e1a72fcca58-7398045dfecmr17037177b3a.23.1743437780690; 
 Mon, 31 Mar 2025 09:16:20 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.85])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710a1de3sm7122911b3a.121.2025.03.31.09.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 09:16:20 -0700 (PDT)
Message-ID: <383d3515-4016-4b19-a1e4-a6c1690e79b8@linaro.org>
Date: Mon, 31 Mar 2025 13:16:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/2] hw/pci-host/designware: Use deposit/extract
 API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joey <jeundery@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20250331152041.74533-1-philmd@linaro.org>
 <20250331152041.74533-3-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250331152041.74533-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

Hi Phil,

On 3/31/25 12:20, Philippe Mathieu-Daudé wrote:
> Prefer the safer (less bug-prone) deposit/extract API
> to access lower/upper 32-bit of 64-bit registers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/designware.c | 47 ++++++++++++++--------------------------
>   1 file changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 5598d18f478..3f2282b2596 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -22,6 +22,7 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "qemu/log.h"
> +#include "qemu/bitops.h"
>   #include "hw/pci/msi.h"
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/pci_host.h"
> @@ -162,11 +163,9 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_ADDR_LO:
> -        val = root->msi.base;
> -        break;
> -
>       case DESIGNWARE_PCIE_MSI_ADDR_HI:
> -        val = root->msi.base >> 32;
> +        val = extract64(root->msi.base,
> +                        address == DESIGNWARE_PCIE_MSI_ADDR_LO ? 0 : 32, 32);
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
> @@ -190,19 +189,15 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_BASE:
> -        val = viewport->base;
> -        break;
> -
>       case DESIGNWARE_PCIE_ATU_UPPER_BASE:
> -        val = viewport->base >> 32;
> +        val = extract64(viewport->base,
> +                        address == DESIGNWARE_PCIE_ATU_LOWER_BASE ? 0 : 32, 32);
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
> -        val = viewport->target;
> -        break;
> -
>       case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
> -        val = viewport->target >> 32;
> +        val = extract64(viewport->target,
> +                        address == DESIGNWARE_PCIE_ATU_LOWER_TARGET ? 0 : 32, 32);
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LIMIT:
> @@ -321,14 +316,10 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_ADDR_LO:
> -        root->msi.base &= 0xFFFFFFFF00000000ULL;
> -        root->msi.base |= val;
> -        designware_pcie_root_update_msi_mapping(root);
> -        break;
> -
>       case DESIGNWARE_PCIE_MSI_ADDR_HI:
> -        root->msi.base &= 0x00000000FFFFFFFFULL;
> -        root->msi.base |= (uint64_t)val << 32;
> +        root->msi.base = deposit64(root->msi.base,
> +                                   address == DESIGNWARE_PCIE_MSI_ADDR_LO
> +                                   ? 0 : 32, 32, val);
>           designware_pcie_root_update_msi_mapping(root);
>           break;
>   
> @@ -355,23 +346,17 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_BASE:
> -        viewport->base &= 0xFFFFFFFF00000000ULL;
> -        viewport->base |= val;
> -        break;
> -
>       case DESIGNWARE_PCIE_ATU_UPPER_BASE:
> -        viewport->base &= 0x00000000FFFFFFFFULL;
> -        viewport->base |= (uint64_t)val << 32;
> +        viewport->base = deposit64(root->msi.base,
> +                                   address == DESIGNWARE_PCIE_ATU_LOWER_BASE
> +                                   ? 0 : 32, 32, val);
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
> -        viewport->target &= 0xFFFFFFFF00000000ULL;
> -        viewport->target |= val;
> -        break;
> -
>       case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
> -        viewport->target &= 0x00000000FFFFFFFFULL;
> -        viewport->target |= (uint64_t)val << 32;
> +        viewport->target = deposit64(root->msi.base,
> +                                     address == DESIGNWARE_PCIE_ATU_LOWER_TARGET
> +                                     ? 0 : 32, 32, val);
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LIMIT:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

