Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C5BE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 12:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZTLE-0000MN-RN; Sat, 27 Dec 2025 07:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZTLD-0000M4-1c
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 07:24:15 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZTL9-00053G-TO
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 07:24:13 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c03ec27c42eso4405908a12.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1766838249; x=1767443049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m3byx562Ge6n/zPuFTbeCKoOBE0fsSDiJ5PL49daqF4=;
 b=Fs6EGTROhCERCfOD6miOUgYX8aTLQjgF8N2yC7KzvoGsyJcgVm/L814HEXGYjpSSAG
 YnF9c6IMMNiEHdZUAyVBLPnJPy/wvfxK7tUf4HLnMhLPtZ0wYcZmLUGV/nn86R4gyFbH
 GJlt/BXILzrFvaUpN5+dWHUR3JJYtU7c27Mqs9BBT9aq59HPL4exoTKlUwJucZGaxu6Q
 C9h8QtzCKJIlPl1iIMl0cFal4VQ+e0p7CqLRILolUYp9nniNhm+ByYeexlMKWR3iDs/h
 UEPGhHLrJPjYiKYR0N7BSSl6UBy3jLGY69lmANtn5Ibl2z0/9XboYkIR+XtWvLRbcwjN
 VTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766838249; x=1767443049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m3byx562Ge6n/zPuFTbeCKoOBE0fsSDiJ5PL49daqF4=;
 b=UQbYEpQ90uMudj/9xSVl4rRU8vG71Xq3X+hT6ry0xB6/inir37mxlDxgPSxdz1zXhJ
 CKjM+CGSgvJu3TlymXuC55IctO6WnSSdrVnOXwECsFraAYJVAjNO/oEn8+AUBth8duJs
 YSPEjyiz9SGkYF/i7FPz/J8HI2Fjrd22wvJ0xT9g5k9SHaJJ6uR9f1Stzewc82i4PzU0
 j8FjD//Cf0NqxuReuyQy+j2v+px2Z/yn7gzlc41MMd623HQZSI1jtoQyg78/S40+EgF+
 9wLiDFHeSz3cUCVO/8joUBV4hAtdrVn+gjpWPkT9DHeoBpz6t1QI/U9Vo56VdrbP6lC5
 xQRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYVo8W6AURbnH8lj5q6KOw+wLL1jquZdz3h6x3JjbVJ/3qkLHh2jiKYnqCHsgmo1HPzFTBUczQG5xy@nongnu.org
X-Gm-Message-State: AOJu0YxxKGI8/Zv8vh6rflFHHlHFZK46f9Lk0dgFbfyrgZkockjFk/DC
 u1Gh2ukev2bDI+DVpeL3Z7h8REAaiEnRZGmrpiy0eeIf/DtATutbXGVzpomx/Q/aSkg=
X-Gm-Gg: AY/fxX5/ssGQuugnVHnvY3/hJTeoMHvyavARFQ48YUn70Z4oe02ipDqrtxO++pg1aGG
 jni2FUnqbA16WEYC87d403BMOIoYao3mMethyES5idLtQH8StvzOr+QBV3/PjCDRf7aYcBZXNTn
 PIVmCVZiPY9X5g1fUrXCHcxgBKB7CZUX+BkK+CtSBa+QPyRQxZcgTpT40KRKSZgY+3ne49ELPIS
 Ihh1/g7DhJpdoQop1qzD6jpmY6zRajOQETMGftqIVwKwP4qQi04/fI4brL5a7o9By8wHQm/gdtu
 7OQkU1+F/vt2iBWS315GK2ArNTrjy1hXXQS+RWRPYY86MEqqkYmfutf9qpORok2jjEM2COCPrMT
 A03thbOxlwOz9uZpj5HrD98jKUr26zZFpMOlYWenZ/UqUaqbS5BMpgpmiH5NOveffGEjXIxS32Z
 g3qm9iNJjfcgWA7O1Rzg76nHORyNA=
X-Google-Smtp-Source: AGHT+IF6htDuxqqKA0KZ2RhupcSDB+Mcc0EFtDvkO/Way48VC9DrijCNmQy7C/BEUbg5bk2QTAF7EQ==
X-Received: by 2002:a05:7022:6ab:b0:11c:ec20:ea1f with SMTP id
 a92af1059eb24-121722e5acamr30542525c88.33.1766838249433; 
 Sat, 27 Dec 2025 04:24:09 -0800 (PST)
Received: from [192.168.68.110] ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121724cfd95sm94146455c88.1.2025.12.27.04.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 04:24:08 -0800 (PST)
Message-ID: <eb7fb1b5-f95c-423f-8bd0-b0ac22fcf919@ventanamicro.com>
Date: Sat, 27 Dec 2025 09:24:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/riscv: Don't insert DDT cache in Bare mode
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20251211025611.99038-1-jay.chang@sifive.com>
 <20251211025611.99038-2-jay.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251211025611.99038-2-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 12/10/25 11:56 PM, Jay Chang wrote:
> In Bare mode the IOMMU does not perform DDT look-ups, therefore
> caching DDT entries is unnecessary.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 69852f4f13..79eee2e85e 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1312,16 +1312,23 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
>   
>       int fault = riscv_iommu_ctx_fetch(s, ctx);
>       if (!fault) {
> -        if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
> +        if (mode != RISCV_IOMMU_DDTP_MODE_BARE) {
> +            if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
> +                g_hash_table_unref(ctx_cache);
> +                ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
> +                                                  riscv_iommu_ctx_equal,
> +                                                  g_free, NULL);
> +                g_hash_table_ref(ctx_cache);
> +                g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
> +            }
> +
> +            g_hash_table_add(ctx_cache, ctx);
> +            *ref = ctx_cache;
> +        } else {
>               g_hash_table_unref(ctx_cache);
> -            ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
> -                                              riscv_iommu_ctx_equal,
> -                                              g_free, NULL);
> -            g_hash_table_ref(ctx_cache);
> -            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
> +            /* Remember ctx so it can be freed */
> +            *ref = ctx;
>           }
> -        g_hash_table_add(ctx_cache, ctx);
> -        *ref = ctx_cache;
>           return ctx;
>       }
>   


