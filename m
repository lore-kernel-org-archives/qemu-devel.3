Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECC8E9270E
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 12:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZTLl-0000Us-GC; Sat, 27 Dec 2025 07:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZTLk-0000U4-8h
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 07:24:48 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZTLi-00056x-S9
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 07:24:48 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo8836522b3a.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1766838285; x=1767443085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLSK/Ba+sSg+pOC6zImzmZs/l+0OXc+3Jj36fclfvCE=;
 b=LZjAZ7m54to8O00xtI7DYx3OAkHrMYyfoLxW5aA9Tzupz0+ISfjea6n9cvUDnnbfMr
 6xyM8klT2FFudSkyOlacAfKFeLkJ+g+g7aqt+n0eefgybHMlPswWaflNFrP0uXFIoHxW
 m/SPcSGf26ujlAw0j8eZNSiJRSJd3sr34ZR3Wlg87Tm2YOkA7r3M1s6UYclqYMZ2UQxo
 IaYZJiWsteAYEF65RcY4cm9ufbIwBfnSobxr1KPpBR8UWG6fa8j4JZiYWITogsSbUuvZ
 HXDikO9N1PfPtI5DwDl128tGhheiZT5pR1w414KO4bU0lQJtEVRFBuOO9w6ZsWvFWm6I
 099A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766838285; x=1767443085;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLSK/Ba+sSg+pOC6zImzmZs/l+0OXc+3Jj36fclfvCE=;
 b=RG58GII5A1C7D2zvoymD5I45fPgVzZct5i9aKRxs0vEIHCz1Z6C7SyU1PZSqRRvr1k
 s7qFqBpnbjK8bYOGzXNJiVB8JqkDjxipy1OW3xQaFBeot/iQlftdVhaMx/fi4XytTQgz
 IzbmXxyhcxVLiaxk2rJR3Q8NFRxGqjvciht7y42noqYY50IHpIf+rLDfLKBRtfQjtTb1
 abifxAZNNhYPRCqrL7H2SNyHD9MFAJO5k+67KoXdRCtnqge+GQXGa8HoAi2IXkPwaVVt
 ZBXXANBDMTkA+v/cH9p3fBXDhboxvNjG1hTyTziY00V8bXkkunh41tCrUuzk0a4KOhX5
 QcaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUGDy1Fin0tAqvIrDY8IrNcdMm+9vj+nLec7qjwPEOgMlpDEXrLdsZGHTHArhGjEEO0ZX7R3xcVk8g@nongnu.org
X-Gm-Message-State: AOJu0Yzf4Yvclzc52jOQf5pzkh8Shu5zJXjoG0OTeIiCqAkT7KHo156u
 Unb3xdMF4k1HdpfdDTYR5tilQovlcxmR0czRIr3BEPG85wQ2F9M2qM/TSNPFthCyZps=
X-Gm-Gg: AY/fxX6IX3BJzO4tQPBj3dLkUv/VM98bkJy2zy6Iy6W6Xqq0UPRrXHiZcIF7jpE5zyT
 E/h1oLqy/iRVCtONnAWhBwTt7b9q3NsGYmvnRgEsHNTW0aJ6GKCo2Cv6gkX9c3UuaxDyZIa8Mwv
 F0r26c3BgUzv3+bMZiOy0xxg1liQ951vpg0Rz25I9iy6OoutKtCXfGeKs+wsU/jm53To1RaFzOP
 UvgUvV9gWCSDPJBaUjpwu+xnB/Usa5+lFRTMBuQQcLA8JgnrugJcdn3KH6N8ryptVjAnAiX0+9p
 V8N4Dz8omqAbVveAZMn0otiz46gd1mca/cAU7YV0wFFaTUiGFGy9AnCdWTX9bd8tyiUL0WHjfrJ
 lmBx+fRa+pckbpAmfaEGoprfczqsVGvAxfvZd+UUnT9n/ub74vehh2YlUoz6yBgbUG4Fo+e98Lu
 LHzzvfkwmme3iudMcawLRB6urx1ZM=
X-Google-Smtp-Source: AGHT+IEmXS0Hd+Z9pC70fegWMFhui+DUtuw0vjEeyI4Lkz1fwb4hFXtBQVt41DOtBl4Blh7z6QjDlA==
X-Received: by 2002:a05:7022:6294:b0:119:e569:f26d with SMTP id
 a92af1059eb24-121722b509emr27691765c88.22.1766838285420; 
 Sat, 27 Dec 2025 04:24:45 -0800 (PST)
Received: from [192.168.68.110] ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217254c734sm99671996c88.13.2025.12.27.04.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 04:24:44 -0800 (PST)
Message-ID: <032d9816-fac2-4e3f-a4e5-a1ad609deb57@ventanamicro.com>
Date: Sat, 27 Dec 2025 09:24:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv: Refactor riscv_iommu_ctx_put() for Bare
 mode handling
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20251211025611.99038-1-jay.chang@sifive.com>
 <20251211025611.99038-3-jay.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251211025611.99038-3-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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



On 12/10/25 11:56 PM, Jay Chang wrote:
> Align SPEC: Bare mode contexts are not cached, so they require
> direct memory deallocation via g_free instead of hash table cleanup.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 79eee2e85e..fca5763858 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1344,7 +1344,16 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
>   
>   static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
>   {
> -    if (ref) {
> +    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
> +
> +    if (!ref) {
> +        return;
> +    }
> +
> +    /* ref is pointing to ctx in Bare mode. Bare mode ctx is not cached */
> +    if (mode == RISCV_IOMMU_DDTP_MODE_BARE) {
> +        g_free(ref);
> +    } else {
>           g_hash_table_unref((GHashTable *)ref);
>       }
>   }


