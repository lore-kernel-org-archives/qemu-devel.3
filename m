Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A0EE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgSE-0000MI-GK; Tue, 03 Dec 2024 22:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgSC-0000K2-3B; Tue, 03 Dec 2024 22:53:32 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgSA-0006SE-DY; Tue, 03 Dec 2024 22:53:31 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4adc672f2ffso1547006137.3; 
 Tue, 03 Dec 2024 19:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733284409; x=1733889209; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvxEmYFvNmqFukmOLQceNCl2PK01fa8aFTApEmzJLzY=;
 b=aeGlVojwQNh6jNrujs/y+X3t0oaSHx88OoKV9MeUNYR1+FQxqvGE71xckjv31hBZqO
 MZ6aIpHaQtgrA5FnFb0fRDpyHwzql/bYznnII1SHo0M2eoX3jMMSke8liPYCHoJDaqCJ
 tOkX2otXZQvPUj7NU0+jDB5eF0rpCDL0zdPzzI0G4ACrLOk2wksR8sbK9XXCLDg6/8Tw
 wXSOSIFQ7DjRQTb8Wmmn/2m8Z7IUIBORapTiv8Zk+OVp1oc3xi+RddASag5+qXDStci7
 wFJ/k6njF7V3zQ7XXPMFyqv/9F5D3hMv3oD0/3DHmnbmEgHFWrj91xMGZIvpUf43e6jS
 /tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733284409; x=1733889209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvxEmYFvNmqFukmOLQceNCl2PK01fa8aFTApEmzJLzY=;
 b=CgNJjnetOPlGsN+5mjP2omaEJ+ddRAmjwIOtsCC/DZrAvVCJXGQvaXk4fP3hxyIjpj
 zWlr0tGa87PasBRx2CgxG5Hi9O9kAkmGqjVa7GY1CIwL43Suky+5rqYLmrkvb4mWoGO8
 BYGGeSBbQsikT+6AS+ZlRlIMrF33vQ3ElcNq3qEDQ5+Gvh4a8FO4TJ00LPXwRvYCUEsj
 MzhMqa42Ogd6fr9p5j5dr0FdW+34iVEdNJglGl/h8uZE7dL7lcCNljzi6kC7gHX6EoUE
 3mUA8e9m15Pz4eeFWmHTpXFZtsTVVW4NAiFQrC8dKRYzR6DQ2cpNvLp22g3KvlAEtfB3
 VtHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd06pm6UL/P8naGaouaiS8mSfQhs0ryBQ2noOGUVKvm4tounOziR+I5pya2KOpaCWeumdARLmFBarB@nongnu.org
X-Gm-Message-State: AOJu0YyAxacdKuyVrXcinuZEcVRL3TUCwR35Plnr6RHlbgfoiOcRVN/t
 w504wZLMyr/uTmzI7ql0C6AIVsXB9x9Ve/FxcwIbwmy0oubi5byYS+/Qdj7mPpManhHaFu+PRW8
 pjhcT07slMYaO7jBHBly+ox+FkkQ=
X-Gm-Gg: ASbGncsmA6BFxCVC3ENh+4hj6WwqGKjHoEJJqrsrRQp9LlD2jatfk0VU+xZu3qsu7cf
 kF8C1X/8Ik9Nc8US8mdH46WrIyIdSN7Zk
X-Google-Smtp-Source: AGHT+IGeLyj/mipDK2IZl0TiEY6pGnfOWGvMXSmLKufX2ILRnX7I7dr1GSXpSYt4Qnb17JaVAE9gQoN0utTqlLUKFT4=
X-Received: by 2002:a05:6102:c09:b0:4af:1a50:bef0 with SMTP id
 ada2fe7eead31-4af9733dfdcmr6611733137.27.1733284408961; Tue, 03 Dec 2024
 19:53:28 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-8-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:53:02 +0900
Message-ID: <CAKmqyKORoSDe0Fqzm9y4NEYJ8aKyG8CnV=RrOWkj7swtOR5g0g@mail.gmail.com>
Subject: Re: [PATCH for-10.0 7/9] target/riscv: add shvsatpa
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> shvsatpa is defined in RVA22 as:
>
> "All translation modes supported in satp must be supported in vsatp."
>
> This is always true in TCG so let's claim support for it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ae5676976b..068b019564 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -185,6 +185,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> --
> 2.47.0
>
>

