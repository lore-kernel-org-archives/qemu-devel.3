Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C599EC25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MOC-0006Fi-QV; Sun, 12 May 2024 23:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6MOB-0006FP-7f; Sun, 12 May 2024 23:30:11 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6MO1-0003rp-Af; Sun, 12 May 2024 23:30:10 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4e12478c3f8so189614e0c.3; 
 Sun, 12 May 2024 20:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715570999; x=1716175799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKqoXSKL2OiQgLPxrNJOEgJBv5k5HlX2kE2+Xn9eBr8=;
 b=YIf2Q1PyZi1ULJa2OU+uHY8s9i4Lj4NkQGvUVQBPzuRVj211+c1cpXjtiCfKyx2123
 7ztd3H0fbrRxRrX3mhz+NINzaRWKS/2TjB7/0lAgLfZRTuZbDZVRumL+GxJWrqwIEoR2
 cndS2HvbCxMILuHJrjglbRCiZNrOAS5p5qkatKBNjcTTddERZXP/kZf618dxziGDjHh5
 7OxPxLP4PnjgaWSYtLpA2mBcNYaHoyfJQkHSN+NJfd4KvENifNM+FBdGMWxGxUOOAUkF
 7mH1lZNGmyk5g3VwNgZvFOUaa3EEDCEzclIx32NMLlkKe7BygFn5SomU0TFi8QpUmw7M
 clrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715570999; x=1716175799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKqoXSKL2OiQgLPxrNJOEgJBv5k5HlX2kE2+Xn9eBr8=;
 b=Vpy9edZCdvG3lyAMtecO2gzQ0EeOh5uSc6dfX4h2e20pmTbSbSEzUgL1Es8t7bGWHO
 tv+0qrYLrMjTjbPdsL5i8rLaLTGltLkuLa6IuieckapYHnq2atSkaiESSwVn89SqACt8
 CFFgOaswzCfIitG/eH+QyqUWXJgIjgFiCZT8kJk0QbihSphyTvnhoNIRDQZ0ExhCLrm6
 l/+UTAQVHh6sapZ7Ww/CIJsqQlUAPTeLn7EjfLIRwsWwasUsQL9oktie/0Oy9UQSrIgZ
 cMm4mcIGwCV3aTvo7duMjFxkaggYsQWz3nplLRx28gnm3xDW5MTbBNSxsCyFGZbaEX6w
 aaxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4nwHWxg/fO6oS7cB/8j7aUwfgoH/4+iIrpXs7c4arRz7EbUlDg9u6qL4VC6t0gMsizcWg8VvT691aSf7E02iuADPlVss=
X-Gm-Message-State: AOJu0YxhdSxrgD6bxlc1Proq+QejwdeaLzmDEOMVpWMHucBo/kjcQmKT
 LGlJNjVxlasygcsL+8bsTqopCC6FW8AHTikxO2aoAv/1ushQ8J5gT1H7xPlAbEydYAOszxZ8U+C
 KpMPtNt5Bhs6bIFGD24NIUAHuv7o=
X-Google-Smtp-Source: AGHT+IGiajIcYAmGAl3FATzoLBR9f3iJY3Apify8Li1XcihuxVZiacGeab9CL8MU5pKgf62N4wtTlCgg0jBYdJYA658=
X-Received: by 2002:a05:6122:178f:b0:4d8:690d:c02a with SMTP id
 71dfb90a1353d-4df8829eb9bmr5678866e0c.6.1715570999251; Sun, 12 May 2024
 20:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
In-Reply-To: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 13:29:33 +1000
Message-ID: <CAKmqyKPOmcJxXhb-RGqxj=hPWOk-dkSVb7kt9vBCFXfnzp-Hhw@mail.gmail.com>
Subject: Re: [PATCH RESEND] target/riscv/cpu.c: fix Zvkb extension config
To: Yangyu Chen <cyy@cyyself.name>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, May 11, 2024 at 9:28=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> This code has a typo that writes zvkb to zvkg, causing users can't
> enable zvkb through the config. This patch gets this fixed.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to risc=
v_cpu_extensions")
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..13cd34adbd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      /* Vector cryptography extensions */
>      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
>      MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
> +    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
>      MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
>      MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
>      MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
> --
> 2.43.0
>
>

