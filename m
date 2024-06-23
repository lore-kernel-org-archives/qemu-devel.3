Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D05C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 19:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLTBp-0007es-V4; Sun, 23 Jun 2024 15:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLTBo-0007eO-5x
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 15:47:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLTBm-0000ZS-GG
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 15:47:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f862f7c7edso27453175ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719172069; x=1719776869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kGmF1eOD6uOfqmTmXARzhjTQ6w6cvKDAVQYHwJvc0+Q=;
 b=PbjjK+JYFFAbhyoeQh+dbvonV0BPX+tIU93mK8Vmy+Lw78wMZzo1DNsw+or0xIsDx+
 JoHQ5YmJrs/TEe/jTXxut6x1J272CrKK3KgzlT7lzJcX08XZs0ql8lHoAEvOEKvKmCfk
 fO9edP3DgoMJsVli6HDwgLNonS86Sx3v8d3/gdI3Sde8A0Dj2GG6R3gDVp4J4/r7WUUI
 cBfqtdDsrUz1AgFZatL78U872VGYb80b2EOPYgX/mWVgMVNx15f4UbAxMsQXER47myug
 FuQGFWEpLrc8D8pmwbceJC6oWEhOjbz79dU2OqvR8vlqRBih9av4uQRFZMzvjB0kvp3P
 Xy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719172069; x=1719776869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kGmF1eOD6uOfqmTmXARzhjTQ6w6cvKDAVQYHwJvc0+Q=;
 b=fmgXNpPbD2XXdXz2VrYTIQqXnLeQK9MnI7TaOBNjM+bySGvSNqLaRQjEgvM1UF5xUe
 wuxH7zXW4qGZA4FvFTngxaWMudp25Tj+9dIjF2t0KJijjgzocaZfpCbZTqvhwVK0pNoX
 MFAapYU3PoWmHCws5g6wrPmfkomBmaKUvrribmDzoOnOiW3xJpj5Dp1qk8u0eZZVFWbi
 wWTOtuFTAkcPu/vNG6CUyUTenN/cr6aibCvtz68IgPBt79z1suKujvVmNg5qPqgHYbOY
 VD0XR9cVfvtkQ7R0j7NA8pmN1kBvQsdRUyzI7/W68vuxXd6JT5XV2HvFSjAJ2pUrFOvF
 8XwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1aKCYmXrk2unqORSHG7i7munPJbul6/GQDqBkovebhuJA6d76i5ZyNegFtH4V/szgI8icAq+zSizNvzqqaq4RAbUhca0=
X-Gm-Message-State: AOJu0YxC42m1vzwFkT6YK0etPkKFKkWGpFTJACIvpNQ1U28nVOAV4kDQ
 Ngx46XA9IpSRceKvPMljIlVonBi6b+/xcBFGCRxHDmmWSF5yvlnRMFA0UFNtqug=
X-Google-Smtp-Source: AGHT+IGcUYCGJt8Yx09Z3djIOzHK7He31Cfs/wJ/GIXyXfI1cWBicsGtVp2EVOsjoM0vAeTDc+FXWA==
X-Received: by 2002:a17:903:2307:b0:1fa:2ae7:cc67 with SMTP id
 d9443c01a7336-1fa2ae7d52cmr26933915ad.38.1719172068574; 
 Sun, 23 Jun 2024 12:47:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321763sm48636145ad.64.2024.06.23.12.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 12:47:48 -0700 (PDT)
Message-ID: <d8b404d9-dd3b-4cb4-bde9-580649405024@linaro.org>
Date: Sun, 23 Jun 2024 12:47:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/m68k: implement do_unaligned_access callback
 for m68k CPUs
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 laurent@vivier.eu
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
 <20240623115704.315645-2-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240623115704.315645-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/23/24 04:57, Mark Cave-Ayland wrote:
> +G_NORETURN void m68k_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                             MMUAccessType access_type,
> +                                             int mmu_idx, uintptr_t retaddr)
> +{
> +    CPUM68KState *env = cpu_env(cs);
> +
> +    raise_exception(env, EXCP_ADDRESS);
> +}

Surely the address gets stored in the exception frame somewhere?


r~

