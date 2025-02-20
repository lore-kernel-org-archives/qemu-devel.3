Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DC6C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlAqH-0002Ju-2E; Thu, 20 Feb 2025 13:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlAqF-0002JW-FG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:00:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlAqD-0000VI-Hc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:00:07 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220bff984a0so23741075ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740074404; x=1740679204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=glkzZCvo/wxZi4YIKaS//8YD7Yv/u1Z/fSDSCRt0usI=;
 b=fwBql2pIjt9AKdH61npPk9tuiUQ3nYPmNYEHtIDwGsGpnZwdsA22zqc2WBXKJBoJXw
 tnQgaQJQfDcqxFRZvhmMUT2hbNMf969VeECkHig8V5vfgX4nDiFz6TYDjDquwvmSUcvn
 F/xXJfYwzXuzzb5zZqC9p4Rpsg1kd7NZOUdcBAHuo28NL0TygxOInCtgvaOvCkBrKuUl
 GqsNLLiYItgqZYb0rohrBNMO+Mqh0SYh0mdtB7KqXAq9TZixmM+jVuOtv6uShr8YaXWy
 5r1aKQ9BeXprkT6R8Sk29Do5CQH3VGlKZTqAJu1tUpBEOnNskShF8yPRy4jd+kWT1zDB
 EWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740074404; x=1740679204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=glkzZCvo/wxZi4YIKaS//8YD7Yv/u1Z/fSDSCRt0usI=;
 b=ErwkMFxJiw9VlbHdr1dPOZgiX2LTOur/LsHpkEGG5/nzDXZAPLacnkorK9QFgj6ypu
 RHxoiL1ixeMWIEJ8D+Qw/vRGQWBq0EoClgDzgdp9ZTbcwqa3m9vOAENCs3/wLcEAU6qe
 cS9yfXwzXViCoC4PMLfVOaKOcZqV3E48pfitv/dhteUCb9EWV2iftxKX5BLSX2mgHq/t
 MYfE0ETMcg2B0qOhy2wiAdYUS7CqaMROgjsNWLQGA+e6iKJEGZtbd3eDi+7Z1aU18+Df
 QWDbmkHkAO0z1wk9Fp0H9hXlzn7rwvPL1o/WgTYEJGpcGSzOOyVjN2KJUfeSRHeRHOMR
 NusQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgGLhM33YmRyAw33pgaoraxPkGQmdDH1DVFEyPzhmmMWnr6wDfoQDyl3pNWEwRaI4LLBNpjA5YxXzM@nongnu.org
X-Gm-Message-State: AOJu0YyqNsegFAkoLZ5J+5eu2J6HIgAc3fH9v57RK9OaDXzo6BF7VdCt
 ui1boExQ/oTtnQoMyCxYianSCspStVXLk+7s4Vk+qtsSnOk4ZzjJClTLwCpdznc=
X-Gm-Gg: ASbGncscRZZXZjilx8j/iBOvSoDkPb6tKGOSsECeAII3HAM5MsdNXtdMtkm/ffNRsyN
 NBrR0XIuOnC7GtLdzuKA4rU9b4IwB8TfPbw4ivNefy30Oc3HHMcsFOeCSp/GzivldT0Z7OuFzl9
 yh2mVADlNXRbFa5uSnt8s3gSU+zV5CZl4Dz1LXML1AfvAPk4Xef00VZK0s5H+56Bn5LXN0OUDNt
 dGUmNe5fwaxAcD/vCEE3vsWaVLySpEs3YIJFTUlOq97H1mBChN34rTo6lo4LwA9jgm7TWZkyKRw
 6A3Lic8+j1d1p5aZWTTr76Oi3NM8LQ==
X-Google-Smtp-Source: AGHT+IG1082P+IPJM/r6Uz9F4yfQ8QFPqmvR7SR7+4klDIBPR7gVlEaiyobLbTtxUCMNAPDVQNGrPw==
X-Received: by 2002:a17:902:ce85:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-2219ff3354fmr1175055ad.2.1740074402785; 
 Thu, 20 Feb 2025 10:00:02 -0800 (PST)
Received: from [192.168.68.110] ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53492d0sm124018405ad.35.2025.02.20.09.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:00:02 -0800 (PST)
Message-ID: <3ffe3ecf-4bd8-447e-a984-442c71a94f89@ventanamicro.com>
Date: Thu, 20 Feb 2025 14:59:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix C extension disabling on misa write
To: Vladimir Isaev <vladimir.isaev@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 mjc@sifive.com
References: <20250220163120.77328-1-vladimir.isaev@syntacore.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250220163120.77328-1-vladimir.isaev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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



On 2/20/25 1:31 PM, Vladimir Isaev wrote:
> According to spec:
> Writing misa may increase IALIGN, e.g., by disabling the "C" extension. If an instruction that would
> write misa increases IALIGN, and the subsequent instruction’s address is not IALIGN-bit aligned, the
> write to misa is suppressed, leaving misa unchanged.
> 
> So we should suppress disabling "C" if it is already enabled and
> next instruction is not aligned to 4.
> 
> Fixes: f18637cd611c ("RISC-V: Add misa runtime write support")
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
> ---
>   target/riscv/csr.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index afb7544f0780..32f9b7b16f6f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2067,11 +2067,12 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>       val &= env->misa_ext_mask;
>   
>       /*
> -     * Suppress 'C' if next instruction is not aligned
> +     * Disabling 'C' increases IALIGN to 32. If subsequent instruction's address
> +     * is not 32-bit aligned, write to misa is suppressed.
>        * TODO: this should check next_pc
>        */
> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
> -        val &= ~RVC;

Not related to your changes but it would be nice if we made more use of
QEMU_IS_ALIGNED() instead of doing these bitwise ops to check alignment.
E.g. to check if pc is aligned to 4: QEMU_IS_ALIGNED(GETPC(), 4).


> +    if (!(val & RVC) && (env->misa_ext & RVC) && (GETPC() & 0x3)) {
> +        return RISCV_EXCP_NONE;
>       }

This will abort the write altogether, skipping valid changes to other bits. What
we want is a "val &= ~RVC" if the proper conditions for clearing RVC are met.

Thanks,

Daniel

>   
>       /* Disable RVG if any of its dependencies are disabled */


