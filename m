Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B13C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2KD-0002Sg-1x; Wed, 20 Mar 2024 16:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn2KA-0002Pz-DC
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:14:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn2K7-0006Hq-KB
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:14:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6f6d782e4so293877b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710965640; x=1711570440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R57tYoMxWo7WYEDyK0BOXMp2utsyWkna/XVVHMQMyOI=;
 b=JyqgB5dvP9oNWnwiqxeAWnEKlMQVlEkcWjzirJUJB2jU7uqEMvl28ep+BwtmXa11Sb
 7QTCabNi4es2IR3YHevocRnXQv3hSvzMpHRW7Htr9VsO0ku9lf0H8UOsPArH+9TJPWfH
 eGZGzRKzEwhIZzqCh0wkKBsaej947qIYlS99vQy69LXn8PABNndsHh7b3laSLd4aUH9C
 Ql8RWAYeUMZA+2w7y6WpY4MncpoWsvhVe2Mftk4OiyUFc9hFEdI0Y+oP4A8XbqPWdwBc
 WiT1e7DW0z0SJv0vOLW0OOIcItZV6jVUHqyEePEqypI58c8dll1NEtVIeb/3iq0uOFsq
 wAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710965640; x=1711570440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R57tYoMxWo7WYEDyK0BOXMp2utsyWkna/XVVHMQMyOI=;
 b=ezv//agJ7nbkY5GXKk/kYQE6tDiLImxppC4lja87pccs+sNfTN6Rq2k7Kli+QA4nAt
 tgp4arKo7BdZSCf1FCK06glExQ/JXMN8BVeaZryLpSEOLLDyK4yBbQAgWRVNKKeKwEkB
 FyEejYWgilWhx9ejSXf4DU0QF1W+QaOZTZeXQxdTZFfaGDm1pG9UVhoh6ky6ObOAHwjE
 xNC1TTWGaUXPe+pr0nXhvMLfreA+CqITSVwKGCuEJnQZE1LweiSZX4wVpowUNzGtv2NV
 Cu01KEJtUztViIcpT27k59H8daIml3/w/0fMUqW0gwW0YuDLfz8++OSvSQ1Y/e7lAeAT
 PGfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs7OXY0Rs8+428wYocWFefIyo+2oWrxDvs20X4rEemsQN77pKUEhx+K31Jqi756FTeXzywRgbU3eqSv9SWOGq9Igyohws=
X-Gm-Message-State: AOJu0YwQsonQ9iUHpz0doc1UVRHSsEtmbpnztErm5vw+m6f05QWA53F4
 /L6i2hCDpzuWj8gzLOZy4Q6v+NhieX9v6X0VmFNKWq8xRvVPlIywGQbWBWMf+5A=
X-Google-Smtp-Source: AGHT+IGpLVpi0JOs/lOC2seJgW6HKiNOFpi9DBXNGp2a1ThPBaUyEiRKJDGfeJob9fE4Sbmt1N4MOg==
X-Received: by 2002:a05:6a20:5042:b0:1a3:5d0b:456a with SMTP id
 o2-20020a056a20504200b001a35d0b456amr41756pza.32.1710965639692; 
 Wed, 20 Mar 2024 13:13:59 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a62e908000000b006e731b44241sm5360312pfh.42.2024.03.20.13.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 13:13:59 -0700 (PDT)
Message-ID: <cc0ce8d0-74de-40b2-8425-9f0743be93ed@ventanamicro.com>
Date: Wed, 20 Mar 2024 17:13:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvv: Check single width operator for
 vfncvt.rod.f.f.w
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240320072709.1043227-1-max.chou@sifive.com>
 <20240320072709.1043227-4-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240320072709.1043227-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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



On 3/20/24 04:25, Max Chou wrote:
> The opfv_narrow_check needs to check the single width float operator by
> require_rvf.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 6cb9bc9fde..19059fea5f 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2817,6 +2817,7 @@ static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
>   static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
>   {
>       return opfv_narrow_check(s, a) &&
> +           require_rvf(s) &&
>              require_scale_rvf(s) &&
>              (s->sew != MO_8);
>   }

