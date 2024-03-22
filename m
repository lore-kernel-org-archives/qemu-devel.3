Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB1BC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWCH-0002aS-Px; Fri, 22 Mar 2024 00:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWCF-0002aD-K8; Fri, 22 Mar 2024 00:07:59 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWCE-0004YJ-7e; Fri, 22 Mar 2024 00:07:59 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7dfacd39b9eso1393500241.1; 
 Thu, 21 Mar 2024 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711080477; x=1711685277; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsxMKOrXL/7R5maBQoltyot6XJvo6YJofRsyHpwAh5c=;
 b=V98YshVJe/yIeRHOhwNJU5OgLQPTXnJEDcp/es9xIAskaLp4KR4PkIGe0Lpx9wKqx1
 bihp2W5Y+skIYzJhb7vNIxRj8YaiOfWHvdScNtpCFj8Z6aVGrJrVh6SVxDzo5gL7Q2b1
 xgMCwXLb42K9/y3AFD656TOhkvSPZzewLh5dFfwL0hxJbNG9vOFewewuL3BccfqVoWuA
 IDXVIvT6uT1Dn574nnrm4ypO2gNVh6fiPFyMrOvmUoirrPXQCkvfC6wscpRTr774kEoN
 GHyEGwoBO7XcvPW2GLqqUP9B95cm7y0VG1aHGIhC8x91oxCSFaDWFIRKAV+f0cvfEsuZ
 JQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711080477; x=1711685277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsxMKOrXL/7R5maBQoltyot6XJvo6YJofRsyHpwAh5c=;
 b=e4T8MwitZCUrubhwWHDZM2XPq9eqRr62SjXLpAxJRICPX6IdjFzdInweIcHhhzCkbZ
 CuHNdD6sM725O1zPJwa2XpBfQL/TRIUc6ClFQRXh4nb86Wh9SQtb2305STrJZlHWaIyf
 IN+cMeyyG/y295ALGCneru8VenCyM60xkXLq658tVxSztrqqmLssCJb4Y2XWGYeyecuW
 yznwkW54y8O4TVgKQYVK37ARmp/5dngpyKyoziUShnvxBesTG+jx2pFUmRNhVyCBIa3b
 /P2dezLslZCv0FNWHseNtCzFC1XsqXkVEax355y7/YnqEq9U0NcA7Vw36sljiEzA4wAp
 5mFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8V6R2qW4N8EDluomGKgsKA13lva9zEjGn6+6hHjmX3wPr7aRwJeiWRL9hd8e1dVb8ofhvjCf2x+TtkrFxpVTRFio7xz0=
X-Gm-Message-State: AOJu0Yz7uOs/3D9aKQvraB3CjiSBkwFGH1+TFZMi98176LGKTpoexxvO
 Ti2iR1nYSUNB88eileqUQBTd+keU/AujlH415tw5ynXhTlarqkkr4eYCzksgPWnO/zjVpAWGEDI
 LwKPekaPbG3IO4U9vmr/0IG7cKy6e7THefYidyw==
X-Google-Smtp-Source: AGHT+IE063wtAJzx4iifP384vC5/Gej2A6VuFjWcKMF5OD3exAcfr4qjqxfpFtk9Y1sco74CIks2sKG7OqgljsZ0oL0=
X-Received: by 2002:a05:6102:38cd:b0:476:a861:8089 with SMTP id
 k13-20020a05610238cd00b00476a8618089mr670273vst.12.1711080476840; Thu, 21 Mar
 2024 21:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240321104951.12104-1-frank.chang@sifive.com>
In-Reply-To: <20240321104951.12104-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:07:30 +1000
Message-ID: <CAKmqyKOH_hXi4GhU6UN1pU3HFbrA=RL2c=cbF9+OME_ungX5_Q@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: Update APLIC IDC after claiming iforce register
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Jim Shu <jim.shu@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Thu, Mar 21, 2024 at 8:50=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Currently, QEMU only sets the iforce register to 0 and returns early
> when claiming the iforce register. However, this may leave mip.meip
> remains at 1 if a spurious external interrupt triggered by iforce
> register is the only pending interrupt to be claimed, and the interrupt
> cannot be lowered as expected.
>
> This commit fixes this issue by calling riscv_aplic_idc_update() to
> update the IDC status after the iforce register is claimed.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aplic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 6a7fbfa861..fc5df0d598 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -488,6 +488,7 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICStat=
e *aplic, uint32_t idc)
>
>      if (!topi) {
>          aplic->iforce[idc] =3D 0;
> +        riscv_aplic_idc_update(aplic, idc);
>          return 0;
>      }
>
> --
> 2.43.2
>
>

