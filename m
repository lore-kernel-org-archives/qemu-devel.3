Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B33C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqX01-00059Y-Sb; Fri, 07 Mar 2025 07:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWzn-0004z9-RF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:40:09 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWzl-0002JT-8i
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:40:07 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3f66dae4db9so1137195b6e.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741351202; x=1741956002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wyVdeXu2D6TSunIj/hbFRqVIEaBOmx3AQY685BxEiaQ=;
 b=VRn0T3X4Bqo6URXAKiBEiMs5qICni1BXftBVZFHmiU4zu3jpJBmOgRL5SQJiItQkrN
 q7ItXl2P9ulObcXjWIkRbJGMd3FR/K9M+ZxhTa1xwHxzLt0+NGmYjWPKVmnTfjl/+guE
 U0QLNmhaMZle8K7zz+Uofy9d4TZGDrv82z3G5pKs2ICHDYp16Qrq3F4nVpdbK7Gc5Tqt
 SA3ofSZoQSoXxataWhNpASo3BZDbSLsVK5P0DXzjAYtmVjyipfT6yoxrO7Hwk5l3YzQ7
 cNUZQ4G+jtt4RusDveFKI2/V5Jfch+KWAxvTEK1Vf3ABeFbJMGVxjMBdI2Uv/ivPyiDs
 r1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741351202; x=1741956002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wyVdeXu2D6TSunIj/hbFRqVIEaBOmx3AQY685BxEiaQ=;
 b=e2jC33HjmMAMeBmqgoekWGNgQg2MqfbSQeY50clwmwBr3AWliLzxCnc9vw0Hzy+hnR
 iUADft1KrVtKKkAghtiGtGQe/FSWq0d9xg3R67hb65ea8KG2qhrsLFo8UumOtm1cZNq0
 Yk4hUIkyJFHvFZwyF78LyaTnus3rHPB8FU5NkPi+j69Y70fg2tqwbj8T/iRGa/uBkLcl
 xt30ll6giTS9xGnQCbs48nEuXKXwQt889pAQBhb5tPY+UntgvRGWG+/rfAj6ShGo2Zlf
 A9sFERPZVdltWBSa+O/R0E9BAukircD4rPc7FEUbzuFRGlTjz5cQM4+mXBJjbYheA+nb
 Y4hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBpG8tSo/4aurbrDW/0s4FZD6XsTPusEAL5b+LKSTcJnQXNGhEUfm1+xmAcCGFqdP+Crzx/r+jVC2K@nongnu.org
X-Gm-Message-State: AOJu0Yxt5Nkx2DXvvmVwu15rGXfknprq/yC49dGmUlcbXEwejUQ4dGcN
 L+LqWRBWwqwq7zORARZDL/DZgSoWY7gsqwvXw57nDHGoCXwcGlvHRCyZiJvpbx0=
X-Gm-Gg: ASbGncuvT/eyBESxBpFucUzlpZHDBPiBkuwuaHh9BN4Ht6Q4N41DT06AfVgwKDHXPGf
 xIH97FEqnng+pCK5BiwIbknChuwn1dXBk1V7HFm8jw6ub9cjhpse3d78KK6EkPyJOecORxkTv9c
 175yDV5bxLPVjJcWQGaxom1/qvSz8VLqEB6qLBSKD4JWvahwRxk9xhTSWmaRbhii06XE/LmayfY
 B3FAk+Kn3/egD+gy3VfG9ABWraC1qsfuoKve4MBG6+064j9c+JM14++lXcKrlauZsgHim4/Jsif
 p41ENzdOua09Fa6rZz3n0xL+NGHDBUkA7d6AT1M+89wDWJKg5OSZyaVCO+o=
X-Google-Smtp-Source: AGHT+IG9LttOnb88gGfkkomSDsTE533uca5EP61J7/ffgSQtS7BK9Efxx2ncM2YAfDj6GCseXI7U4A==
X-Received: by 2002:a05:6808:1819:b0:3f6:7192:6aaf with SMTP id
 5614622812f47-3f697b6635dmr1834719b6e.22.1741351202128; 
 Fri, 07 Mar 2025 04:40:02 -0800 (PST)
Received: from [192.168.68.110] ([177.170.118.40])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f68f0572bdsm650408b6e.46.2025.03.07.04.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:40:00 -0800 (PST)
Message-ID: <0464a115-fbfe-4038-9e2d-409ad133647e@ventanamicro.com>
Date: Fri, 7 Mar 2025 09:39:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] include/hw/pci: Attach BDF to Memory Attributes
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250302091209.20063-1-jason.chien@sifive.com>
 <20250302091209.20063-2-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250302091209.20063-2-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x232.google.com
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



On 3/2/25 6:12 AM, Jason Chien wrote:
> This commit adds the BDF to the memory attributes for DMA operations.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

This looks sensible but I'll feel more comfortable if Michael/Marcel also
takes a look. Thanks,


Daniel

>   include/hw/pci/pci_device.h | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index add208edfa..968f1ba3e9 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -244,6 +244,8 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>                                        void *buf, dma_addr_t len,
>                                        DMADirection dir, MemTxAttrs attrs)
>   {
> +    attrs.unspecified = 0;
> +    attrs.requester_id = pci_requester_id(dev);
>       return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
>                            dir, attrs);
>   }
> @@ -292,6 +294,8 @@ static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
>                                                  uint##_bits##_t *val, \
>                                                  MemTxAttrs attrs) \
>       { \
> +        attrs.unspecified = 0; \
> +        attrs.requester_id = pci_requester_id(dev); \
>           return ld##_l##_dma(pci_get_address_space(dev), addr, val, attrs); \
>       } \
>       static inline MemTxResult st##_s##_pci_dma(PCIDevice *dev, \
> @@ -299,6 +303,8 @@ static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
>                                                  uint##_bits##_t val, \
>                                                  MemTxAttrs attrs) \
>       { \
> +        attrs.unspecified = 0; \
> +        attrs.requester_id = pci_requester_id(dev); \
>           return st##_s##_dma(pci_get_address_space(dev), addr, val, attrs); \
>       }
>   
> @@ -327,8 +333,8 @@ PCI_DMA_DEFINE_LDST(q_be, q_be, 64);
>   static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
>                                   dma_addr_t *plen, DMADirection dir)
>   {
> -    return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
> -                          MEMTXATTRS_UNSPECIFIED);
> +    MemTxAttrs attrs = {.requester_id = pci_requester_id(dev)};
> +    return dma_memory_map(pci_get_address_space(dev), addr, plen, dir, attrs);
>   }
>   
>   static inline void pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len,


