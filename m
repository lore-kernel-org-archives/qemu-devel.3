Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1715AC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNP3-0006Pg-An; Sun, 25 Aug 2024 20:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNOz-0006Nv-Fn; Sun, 25 Aug 2024 20:16:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNOx-0002Ds-Q6; Sun, 25 Aug 2024 20:16:09 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a869332c2c2so549796366b.0; 
 Sun, 25 Aug 2024 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724631366; x=1725236166; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdp77mtViXFvy4lTKoMqSWUpZcL9A3ni7E64T/p5otI=;
 b=WsB367YDctFKtSnF9BjkyoLNkB1tW89rXz7vYk7aJCsh5trPabOyO7UF5a7/HYWP5C
 IyfSzb67MMigjJKP1Hui70o1rLhdJaffTkpBeFRaHYDPn/cqIzGHu4Rt1GKWURAJDSuK
 2x5nO9RRyMqZ8auhYp93kpgC1M5Sq0dp3TzgSfFQvwF1Jv9k/50+oDIxEYhoPMv8VbQF
 JezK+d3peQJiQ+2+9mRY2H4alFN3jzr3lJjuO3cFMC7OpI4ZRLNjdZcNIVSgsJJZZuCn
 1MOq07dzz3+rC646CBue6rsOYh/gI37O0r6U+Jb6pdHxFt+33iaWOtMv8uY9E5tJSAaJ
 VH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724631366; x=1725236166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdp77mtViXFvy4lTKoMqSWUpZcL9A3ni7E64T/p5otI=;
 b=J3ZkIIWDpZkblrvE6PWwoz5xYIhYrBsAvNoJz+XNzy2QZjNqoGow/L7qml+HbAWD+8
 b2jfVfbl0dY3sCy9ejnv1NQ9W/Fh8xXuN1nOdclg0QmfvYG1GfG+rBK+AIwokSXWzwFQ
 O7AxNa1eYwYiqif2CAemRMAV9oNiBhCwH6aC/WIDVPHS/VuQNZveTEvo1aGmhhQM02aZ
 P36kvaNi0yR+ESZUOOVaFh/SIvj/6c5zFUPzY/BOBXdofMIubpiWrXMeJ/rjN7RgsHG5
 ZdVPSaBeN7LlUekNRTcLr8Am518K2Lc0nYGmEGrS9JInlRpF1+v7rq59DORAgCXzckUj
 Kl+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUywNFFF4PVtk7AFi9voyBDos9FdAHSi1F7w78S4qKfILAe6JMc1hEOdObz/EgRRCUQtDvEjE/Pyo3i@nongnu.org
X-Gm-Message-State: AOJu0Ywq7oJTm9lNqGwsHc5OALpcCfVouIM9Xi/M9kvPEjNWQ22rpOU6
 2aNcW8XpKxH1/CvSw7fAdr3WIhpizFZ/uEprHOaNbxjiyOWFaTm2Gj4OuT3ane47pZF+6fSD1l8
 te0/1HPH71sGsmsSedJv6pQqOG0w=
X-Google-Smtp-Source: AGHT+IFE0vZ3/oiGa2rD2UiIYsTL6xgmfhcCWphepvL3eImnn6vcrb+ivN/equHSwn9KnMjxB4qVVbger002rtWT+RI=
X-Received: by 2002:a17:907:60d1:b0:a7d:895b:fd with SMTP id
 a640c23a62f3a-a868a5a9785mr1283799166b.6.1724631365592; Sun, 25 Aug 2024
 17:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240823063431.17474-1-vladimir.isaev@syntacore.com>
In-Reply-To: <20240823063431.17474-1-vladimir.isaev@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:15:38 +1000
Message-ID: <CAKmqyKMMrH9WTT8jPtvr52FVXHtbdMDiS2QNOnQF9_t5NZjyag@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix za64rs enabling
To: Vladimir Isaev <vladimir.isaev@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Fri, Aug 23, 2024 at 4:39=E2=80=AFPM Vladimir Isaev
<vladimir.isaev@syntacore.com> wrote:
>
> za64rs requires priv 1.12 when enabled by priv 1.11.
>
> This fixes annoying warning:
> warning: disabling za64rs extension for hart 0x00000000 because privilege=
 spec version does not match
>
> on priv 1.11 CPUs.
>
> Fixes: 68c9e54beae8 ("target/riscv: do not enable all named features by d=
efault")
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3bace..07a7af59b6d9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -115,7 +115,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> -    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> --
> 2.45.2
>
>

