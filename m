Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C789FC6168
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9xc-0008Rx-6l; Fri, 13 Sep 2024 13:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sp9xZ-0008Qd-Qd
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:19:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sp9xY-0004pV-0J
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:19:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-374c7e64b60so1516146f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726247990; x=1726852790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5+AnuVLfHd7PvYvooJv0ht2T97eI71ciQx+O8WpxzLc=;
 b=QuZWAbgrVs+nfADewFrvdsjcs/SmuEYt3jJqe4I9CChGzxHNRm826YgD2QoMh0s7d+
 T0/gpyOK4vOfoGQzR0uRCNWfuDsqsJsRj5tjAheaLH86JNKJVlC7bVcjx7rJSPXm01Z6
 U/Y7J2320K445dQviN9jkRHNIyRtA4FOBC/7xItQMni87uL/3lzRJF0xHGux57wP/YEG
 dE6oJP1TSpfr+V0U3AF3j3IYwirYPB4jCR0Rit38CG/VotnN728R8woB9t8v2iGh9BF9
 XCcs+9JDqx2cJ6/tuIP4NnKlbbHUxbNKgqgzPBLkXRKRU1TOF7CKFJQBgY3ZPPk8Z8u4
 lhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726247990; x=1726852790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+AnuVLfHd7PvYvooJv0ht2T97eI71ciQx+O8WpxzLc=;
 b=Nhzq/KFTL6N1SQNBSXWzlvCWKtGM1oI4XKDv7JmesPeYzCUDYVnDBgJ9KtjaJaR3NF
 e+yL2Se3Z3g+lphgMyq2IHh+A5mUveOiLgzlVdoHkY5jbBwh1vHkfeZzPR8FnUaFc/fe
 Nmpklgk5l+5pBg1w0wPa4Qj8VoLRLo/ZApfF8Q/KPl4M2S58855WB1nRFwk2FvbtUExt
 U1nLQfeSOrkvNAjfJEfLPc8/N16zUdp/Ib+zV7WYjtvabwL8tE16Cmr3a16XFH2ubOjl
 OU1MvO5LRVgA5F22+wxTjgbPMas9/v9LoxmqG8ZyUNPRmLcMgSD+tc2+GhsCmO8Dpc+A
 KxDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO2uyJBRlbITgM7y+Hh/Y96VgSzhY2+SxX8aCObx2b1RSaO3hqmJEREh4KLwnD7zkMvCA7GF/Hn6XC@nongnu.org
X-Gm-Message-State: AOJu0YzwqTunYIsg/2FW3H7Jzs62k5vm1rm+baIbk7L9sO+x54vKuBRz
 5l2VPiFEIZze4aUgNr/KumsI27oR9LrGEKc78xu8HoDaK2OnttAUcea9Sw4cPi825v3bkdAf+H7
 w
X-Google-Smtp-Source: AGHT+IGWQYy2/FVJT7peoyHuU//rhKhotbpYCkDaPa974O1iE/MF8LqMMgNQzJy+/Ao7OcL2L21uTg==
X-Received: by 2002:a05:6000:ac4:b0:366:ee9b:847 with SMTP id
 ffacd0b85a97d-378c2d05d7emr4030923f8f.14.1726247989640; 
 Fri, 13 Sep 2024 10:19:49 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05d4e1sm32321805e9.12.2024.09.13.10.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 10:19:48 -0700 (PDT)
Message-ID: <cdd1803b-6db6-42d0-b9a7-0803c5ea0f71@linaro.org>
Date: Fri, 13 Sep 2024 19:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] include: Add loongarch_pic_common header file
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20240912023537.1004979-1-maobibo@loongson.cn>
 <20240912023537.1004979-4-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240912023537.1004979-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 12/9/24 04:35, Bibo Mao wrote:
> From: bibo mao <maobibo@loongson.cn>
> 
> For header file hw/intc/loongarch_pch_pic.h, add common file
> hw/intc/loongarch_pic_common.h and remove duplicated macro definition
> in file loongarch_pch_pic.h
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   include/hw/intc/loongarch_pch_pic.h | 36 +++++------------------------
>   1 file changed, 6 insertions(+), 30 deletions(-)

Maybe easier to review if moved as first patch, moving definitions
to the new include/hw/intc/loongarch_pic_common.h

> diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
> index d5437e88f2..c71ee59de2 100644
> --- a/include/hw/intc/loongarch_pch_pic.h
> +++ b/include/hw/intc/loongarch_pch_pic.h
> @@ -5,42 +5,16 @@
>    * Copyright (c) 2021 Loongson Technology Corporation Limited
>    */
>   
> +#ifndef HW_LOONGARCH_PCH_PIC_H
> +#define HW_LOONGARCH_PCH_PIC_H
> +
>   #include "hw/sysbus.h"
> +#include "hw/intc/loongarch_pic_common.h"
>   
>   #define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
>   #define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
>   OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
>   
> -#define PCH_PIC_INT_ID_VAL              0x7000000UL
> -#define PCH_PIC_INT_ID_VER              0x1UL
> -
> -#define PCH_PIC_INT_ID_LO               0x00
> -#define PCH_PIC_INT_ID_HI               0x04
> -#define PCH_PIC_INT_MASK_LO             0x20
> -#define PCH_PIC_INT_MASK_HI             0x24
> -#define PCH_PIC_HTMSI_EN_LO             0x40
> -#define PCH_PIC_HTMSI_EN_HI             0x44
> -#define PCH_PIC_INT_EDGE_LO             0x60
> -#define PCH_PIC_INT_EDGE_HI             0x64
> -#define PCH_PIC_INT_CLEAR_LO            0x80
> -#define PCH_PIC_INT_CLEAR_HI            0x84
> -#define PCH_PIC_AUTO_CTRL0_LO           0xc0
> -#define PCH_PIC_AUTO_CTRL0_HI           0xc4
> -#define PCH_PIC_AUTO_CTRL1_LO           0xe0
> -#define PCH_PIC_AUTO_CTRL1_HI           0xe4
> -#define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
> -#define PCH_PIC_ROUTE_ENTRY_END         0x13f
> -#define PCH_PIC_HTMSI_VEC_OFFSET        0x200
> -#define PCH_PIC_HTMSI_VEC_END           0x23f
> -#define PCH_PIC_INT_STATUS_LO           0x3a0
> -#define PCH_PIC_INT_STATUS_HI           0x3a4
> -#define PCH_PIC_INT_POL_LO              0x3e0
> -#define PCH_PIC_INT_POL_HI              0x3e4
> -
> -#define STATUS_LO_START                 0
> -#define STATUS_HI_START                 0x4
> -#define POL_LO_START                    0x40
> -#define POL_HI_START                    0x44
>   struct LoongArchPCHPIC {
>       SysBusDevice parent_obj;
>       qemu_irq parent_irq[64];
> @@ -67,3 +41,5 @@ struct LoongArchPCHPIC {
>       MemoryRegion iomem8;
>       unsigned int irq_num;
>   };
> +
> +#endif /* HW_LOONGARCH_PCH_PIC_H */


