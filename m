Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E14C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEecq-0008AN-Id; Tue, 04 Jun 2024 20:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEecm-00088W-NW; Tue, 04 Jun 2024 20:35:32 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeck-0005Kl-CU; Tue, 04 Jun 2024 20:35:32 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-48bd59a3192so853923137.3; 
 Tue, 04 Jun 2024 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717547729; x=1718152529; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zp7gItEvx8fJotIEuV9EHuhbF8WvUQ2x4GqcDH27QE=;
 b=dH7GyIunTjKHriw+m6mzCppOZQOhGPEIjO9XkxWu9f/MCRX0tBILwjvXbwJDDS506e
 Yt/3Ch0KbJ7Asq6HgHTD4WJw00cID2tQ0fANr5FPCCaLWyd5hDleRHmfoGsA6Zzka5az
 kMqvokRcIYNBAWlgrA1bsjAv1OhY3fwsfJqCaCkqU7rnQuKClOXK1IgqF6OXrguQRSfy
 aZReq/79wJnVM8n6pAdzhCyyB6uRRI1VAuAdi+jcdxnasgrfQtz+gSdZ0CbsCtEec9N0
 hnJxWS3slBNPk/YRVg8B4GLcPYZYN0mHAcbH8qsqzKbQds5609Moe29pS1JWGA8BdFc+
 CxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717547729; x=1718152529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zp7gItEvx8fJotIEuV9EHuhbF8WvUQ2x4GqcDH27QE=;
 b=aP43tzjlIlQSR7XlaIrp/zYncpZ78fBoU/FOF1lPWiEUCIzRj+7JtGVbJAGUMnRSjR
 9+W0/Xbk80aNehsESfwagK2/sPgVFsdOrWhmFdWYvKkV6ppmqkJAmFDHTD/lxckghP2B
 GXdsGkzzrvtG685TN/iaxi77pH3UnSyTY9luM/Ny3OolNK8mPiAfeRTAufgi4fEt3clB
 /w0FXnOBABlWY+2Kss4Wv48tkjdJ56+R7dqaBNlu/0mXStcw1LMY+ONddX82sImW4rYK
 pRaUeSZL49cNaU5mRnZkjPQS2MEnp4ByhOgI37+1sdLCFtx9EcRJGtu08nReQYJ8tzSX
 w7fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWshPwp3VLUzPGqI2W6MtkhndxUOWXutjVoP0VFqfKcOj0iTqkt2a8Sbeu8KavX5HfXsdamlyYGS8GelenVWMpe5uxk5gQ=
X-Gm-Message-State: AOJu0Yxu9SwOYGFO8U5df4jYwcTtvM7WlvzHFkdeqwFL6jupR/3eom5r
 o8gLVlRRDlUmS6gSexyldD+zfgaG/BmenkUu6lcmygX7Hvg8hnxQkO7stpNMPdCiWt4aQrBzBm3
 1Zzf1OCsL3DZDb+Fpl/u2X7YA1Pc=
X-Google-Smtp-Source: AGHT+IHi1Zn8lhi+0EsM1oP9olmPpAI3buU9neWutBJ95Mb9j6MJfZiGHcjIKClywL2HvBgIoYe1HJDl75hHvLqELAw=
X-Received: by 2002:a05:6102:4c10:b0:47e:f6fd:76b7 with SMTP id
 ada2fe7eead31-48c04a48884mr1109757137.35.1717547728606; Tue, 04 Jun 2024
 17:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:35:02 +1000
Message-ID: <CAKmqyKOXxj4n5yD16qX6wMoOPnE_8JAyJRdsQq=kT5On9oLHQQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] hw/riscv/virt.c: aplic DT: rename prop to 'riscv,
 delegation'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jun 1, 2024 at 6:31=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The DT docs for riscv,aplic [1] predicts a 'riscv,delegation' property.
> Not 'riscv,delegate'.
>
> [1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.ya=
ml
>
> Reported-by: Conor Dooley <conor@kernel.org>
> Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to v=
irt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 366fe042cc..0a18547c6d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -640,7 +640,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>      if (aplic_child_phandle) {
>          qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
>                                aplic_child_phandle);
> -        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> +        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
>                                 aplic_child_phandle, 0x1,
>                                 VIRT_IRQCHIP_NUM_SOURCES);
>      }
> --
> 2.45.1
>
>

