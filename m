Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B878FC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhutx-0005ul-RM; Wed, 06 Mar 2024 12:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhutl-0005lB-Vm
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:17:48 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuti-0000KQ-TX
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:17:45 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd1d9daf02so23520445ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709745460; x=1710350260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J5RNqeDw1F6dAvBDzNEHEbP6nEgYOdxEs0yn1l3xF0k=;
 b=e0yGU+DruY6uKdu5eDqTH9onrYIg3LSxCNoTkXkCX0K6gfL85gXrGjZ+OfchKbJaJF
 in1qqKNsdjkmwwHAvxT8CauTADhVk+LvqLrd0HMjTMJRnXqGv6+6Mz3hTaLa/641VYVU
 zMkeTF2ndNwK3uhdpCtLmsJRjQti5Lgqj6c2fCkrjPLFZDB0Ut6q6gcUEVjpaZEE/2uy
 eI/PrfHMVr+Rpqs3VtLnomTx6+11/Hy2mA73heJeOS+eWgfBpDdmGHtCpb5ulqKYKRgi
 qgsZC0C6inMt8hDXMuaeN4JeqfPITgERw49tcw495wYuSdBFP5CmgkN3W9pksDgfxVeK
 ZOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745460; x=1710350260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5RNqeDw1F6dAvBDzNEHEbP6nEgYOdxEs0yn1l3xF0k=;
 b=IH79y/n36IZAiU7S6oQD5NNwvG4X1wYJYETFtgMWRbNToDaRxSxVf+YMDEv6DEC4wr
 asNIE1kH0717UeNDyM/PDWhy7kvLv+rP08NcfJqmdu+3jn/r8L3xGJ/BGUDYHNyIOwJN
 V7fO0RYjk2w16pXKTlaLqMjqkrICwgNA/Wq9XPbiR1629hB8awm8StOr5vXrguA39tDf
 7ZbQYUfJWjNJAag1EyD8au3ImX/DJ3UKtQ62szeQoYcyQxlHRyqFX8keYAXk899d6y0d
 g3F8DTXXnhC99oyKEq2Qa1nOrFZUoIWcro+1HxskuUUls4wXNdnE6GQ1+YP07ljkAQX+
 Elkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZpqxovi6Cm0/cmN5EIkbsZTc14A3uzMQu2uped2IwHriPqHh/KUYBiWXGlXvBG7MvaULai7IMf7s4ELp5jhFfj0UGZyg=
X-Gm-Message-State: AOJu0Yx1rxfUqtWfTbzBZXSa0EKA99FroANdjfB6hBDhv33BFsYTm/o3
 cLN2P6gTus1YTyUVOttYgMGVeJmmZ2F7qkaVwl8sBO1S9kuAlrRw2iQjw5hzVpM=
X-Google-Smtp-Source: AGHT+IEUaA5JI8QfHUoQ366JLBP6dMnzSrpvFz8U2ATWNQvzx/FnG6GLVOUA2NSFzC9HVJt6jZYNJw==
X-Received: by 2002:a17:902:e78c:b0:1dc:cf8f:f27f with SMTP id
 cp12-20020a170902e78c00b001dccf8ff27fmr5028798plb.28.1709745460398; 
 Wed, 06 Mar 2024 09:17:40 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm12836754plb.200.2024.03.06.09.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 09:17:39 -0800 (PST)
Message-ID: <99a59762-105a-4982-9c93-ce3e3e242152@ventanamicro.com>
Date: Wed, 6 Mar 2024 14:17:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/vector_helper.c: Avoid shifting negative in
 fractional LMUL checking
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240306161036.938931-1-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240306161036.938931-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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



On 3/6/24 13:10, Max Chou wrote:
> When vlmul is larger than 5, the original fractional LMUL checking may
> gets unexpected result.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

There's already a fix for it in the ML:

"[PATCH v3] target/riscv: Fix shift count overflow"

https://lore.kernel.org/qemu-riscv/20240225174114.5298-1-demin.han@starfivetech.com/


Hopefully it'll be queued for the next PR. Thanks,


Daniel


>   target/riscv/vector_helper.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 84cec73eb20..adceec378fd 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -53,10 +53,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>            * VLEN * LMUL >= SEW
>            * VLEN >> (8 - lmul) >= sew
>            * (vlenb << 3) >> (8 - lmul) >= sew
> -         * vlenb >> (8 - 3 - lmul) >= sew
>            */
>           if (vlmul == 4 ||
> -            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
> +            ((cpu->cfg.vlenb << 3) >> (8 - vlmul)) < sew) {
>               vill = true;
>           }
>       }

