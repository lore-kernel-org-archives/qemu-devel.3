Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E912E7E0DA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 19:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpWwJ-0006uW-D1; Mon, 09 Feb 2026 14:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vpWwB-0006pc-Oe
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 14:28:49 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vpWw9-0002fD-7l
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 14:28:47 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8c5384ee23fso374910385a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770665324; x=1771270124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gRBcNGjEBVc6BCVS/OYlUxmig+ooczgGi8xwtlTFXw0=;
 b=neejPiU1rQuIxWaIv1ncETfDLJQnlrbtp9uCkCEqQ4aLHF6HZbAz9Jaj8YGw0ZY+Vc
 0xu4OgY5aAzFn9Dk+pQjT/vn4ONkSYO+QXS0D3bvrkKhC0l5BSLiHHQHxlfRVwi3gdoT
 /S60h7FO2y4uqknYmC2nt1jvxMuOleGLu4efeEr59m+UXaoluRHvfY2iZ/Cxs646s45Z
 i4uyrp5F+/MGz8OgMmwhDQjQQejT3/3UPW4Si2ECpNH5j48ZxFTahUko8IETd79uB1Sa
 vwAbHc4n2GZ1juQljFW3ueCJuHXR/SjokfbWGiBoBiTsClL/Ht35h9eC/XeqPwmiREGw
 yfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770665324; x=1771270124;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRBcNGjEBVc6BCVS/OYlUxmig+ooczgGi8xwtlTFXw0=;
 b=doQZzAHbDGYkZxMJRD3vMcjbkPhos8C1hLJgw1PUJJG/KeJsGFp5sS1z9rEYcmVgjd
 D3Iinl9jR31eZx6N61XoZlKnBaarOANPIxFyFIDN8MWq5guWvkOkpXLTqYv5oh5KDCSj
 kVvyLkb5NXqWQ3eQ4TYs2Uhc0/yhiPKYzKX3LtvDV5rKiHxQGU3cBDE7LVRpJGsEMki+
 bomi5nhZgruaQ21sJDkCLjH7XfVJeKr+9do1QjUDD7WxiISsDhOeCiqZI+hKdVDddgFu
 n6cMMoY1LvV+84EPAvNrtgSBxrng1frsCdVOBhp/fBFEUEFweQKDZYPPrWqltPyxA8xB
 bBHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqXF7up8XFUl2wCPCKKDcJyQSKuQDYWgXktnUzBUwz9pOTWOxVZFqn52hYff3MBZJ6maPnuLoXDm3m@nongnu.org
X-Gm-Message-State: AOJu0YyuCfwO3SmdakTQjdilhca6/gd+pUUJf5fYmvBkKK42rsqh9qPG
 wLQY26k7hH59sLpxK+nFMQcrH3zeGDOagiTE3xpU6293xwnxrNCQYS2PMXUhPO3Jww4=
X-Gm-Gg: AZuq6aIWOlFl1DDB4BjWUgF1XSLJ/D/HLWw93DTLLVkeOBvLo3w9npWFuq5V0sujviU
 Yd6z1nly0wuyoamSaz3vAl/+hlWT12mOZgVYG3DhZ8VUqFGqYkG4g6Q1pv1rnNNa6p5NBAA2zzA
 sGnGrIBlNAERt1ozWq4+hZcdT26Dul9N17wAFeK7KfJnE0IvjHLPdWgxHMiAw20FHYwrSdLCs+i
 lhCeGnuUWnHyVZtI1JoJ+qDG2DIwQPKA24KI1cNbH8HIVxjFWHS0qwo0bhqWBtaqxRsH00G95zs
 cfI7Fq7otz1vL4w8bJXpuBB07uIZicfTTcnbqzEeSPl51T5IhFiodOU74AGUT7DPF0aLqHsB+wV
 N1Zwqu73wweuFsMv4rIZhGpSLPxiSh9zBHo7RGhaDK7Ok88urJdOMZ1Ts/hsq4/9vYEi19uFZuf
 eVmiIltHdhOHCydIkUhbOPcnwvsUIImw9mxf2nCA==
X-Received: by 2002:a05:620a:4510:b0:8c7:136e:bad7 with SMTP id
 af79cd13be357-8caf17e7506mr1625899885a.85.1770665323905; 
 Mon, 09 Feb 2026 11:28:43 -0800 (PST)
Received: from [192.168.68.104] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506392902f9sm82464771cf.18.2026.02.09.11.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:28:43 -0800 (PST)
Message-ID: <700ebbd9-a0a2-492d-9c26-44c7bc6d6d31@ventanamicro.com>
Date: Mon, 9 Feb 2026 16:28:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] target/riscv: Introduce BF16 canonical NaN for
 Zvfbfa extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
 <20260127014227.406653-8-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260127014227.406653-8-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x733.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/26/2026 10:42 PM, Max Chou wrote:
> According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
> f-register operands must substitute the BF16 canonical NaN instead of
> the FP16 canonical NaN for some vector floating-point instructions.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
>   target/riscv/translate.c                |  8 ++++++++
>   2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 2a487179f6..3315397257 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2347,17 +2347,17 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
>    */
>   static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
>   {
> -    switch (s->sew) {
> -    case 1:
> -        gen_check_nanbox_h(out, in);
> -        break;
> -    case 2:
> +    if (s->sew == MO_16) {
> +        if (s->altfmt) {
> +            gen_check_nanbox_h_bf16(out, in);
> +        } else {
> +            gen_check_nanbox_h(out, in);
> +        }
> +    } else if (s->sew == MO_32) {
>           gen_check_nanbox_s(out, in);
> -        break;
> -    case 3:
> +    } else if (s->sew == MO_64) {
>           tcg_gen_mov_i64(out, in);
> -        break;
> -    default:
> +    } else {
>           g_assert_not_reached();
>       }
>   }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 911d3932f9..a1c4b325e5 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -214,6 +214,14 @@ static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
>       tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
>   }
>   
> +static void gen_check_nanbox_h_bf16(TCGv_i64 out, TCGv_i64 in)
> +{
> +    TCGv_i64 t_max = tcg_constant_i64(0xffffffffffff0000ull);
> +    TCGv_i64 t_nan = tcg_constant_i64(0xffffffffffff7fc0ull);
> +
> +    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
> +}
> +
>   static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
>   {
>       TCGv_i64 t_max = tcg_constant_i64(0xffffffff00000000ull);


