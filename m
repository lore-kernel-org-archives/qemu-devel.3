Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F3BC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 00:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRL9x-0002I0-VF; Tue, 09 Jul 2024 20:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRL9w-0002H0-Nw; Tue, 09 Jul 2024 20:26:12 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRL9v-0007YD-1M; Tue, 09 Jul 2024 20:26:12 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4f2ee99e2d0so1661384e0c.0; 
 Tue, 09 Jul 2024 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720571169; x=1721175969; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkLrg97cSUUoIrwgcJ1QSpTUU9+nbUAppeA4Y0P1ea4=;
 b=fGAk+J4NDw09qYfMlKwxyIBPBU/5qfpFeg4uszf22SJNpAuYxKQu62bmKcMdGF23PY
 RMGjFvvXbj6L5tifQvtrthUWssQVwxewA+H5TJjq7EuFMrHncEbODHO/CJ5PIqTzZcd6
 AVbBi9dfFstj01HM4Osof/LeqolTBOz13mgybSFybmzPz08fSnyRtmi0RlOQ3LvbAyjD
 pJ94ccXD/bBlotcV1JcSYnMlA1D5e+yD+wNg+zREodM2pUuWdq/pPM/gVuTSKCyORPZP
 G05FwMg+98ZDg4qTVqiKLobBeHJ40Nob+tvMwuVxJ/QP4ZlNv6fyFvSiQ1i9udlVjpQ/
 LYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720571169; x=1721175969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkLrg97cSUUoIrwgcJ1QSpTUU9+nbUAppeA4Y0P1ea4=;
 b=I+TMDFdJRJl3/4bALM4aCWJKt+h6UhkF4E1sJ9uyUUwNYKmvfMDsvP/OljeCNGN0yY
 GMAmzMcfLKtID84aECzBdrh2eOiRXIqxyM7KhzmfSktjg4rw49x5nD/riDorGBJoI/43
 DBrl90hRf/0UoAU4nQtZHhd21cPyU1C3sqFIjlDwctybcpPSjk9X4z+7FvwaDtcGzlUo
 q2wNaeDIzfa9NqKtC7QUlnuZZNVhKHLMAORlDQ2UmjwJerC3CJt2AkPxFddLFccu3I+x
 63t79kJa3GusS9kgrh/nEgklH9sqWKfwlF124dI+MCetJ4x8xLNr7XLbHItmO1ChWOYJ
 0vVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX5GQBZWd6/InmN8fQSccSxsFsFGFiKql8TSqi5z0kRqlL2iLNRIQEOIcJk9bp7/sh4Od6SuyrTiZ+EyWhOdUCrjeozT4=
X-Gm-Message-State: AOJu0YxebirdGNl2gpEkZV99ZCMuSgs00yWC1nGxnp37ORkh+A5tCwvu
 pfPXqDsSwW0xGLvhGu2/6xahMClvzVaqLLdE/UbklN149IOz5gZf0AOXZPc7T/WaiSNl2ahlSke
 oXNvU6BzZfHhaXZNRQsjnjnkBt2A=
X-Google-Smtp-Source: AGHT+IGagDs5vDyP8PNilioKQsHBYXezbG26nKamKOrsWLkbU8mYcEgHXwsYvTwXagGONKUaV6UlJI+dB04NBI5Omos=
X-Received: by 2002:a05:6122:2a0b:b0:4d4:21cc:5f4f with SMTP id
 71dfb90a1353d-4f33f2a828cmr4771209e0c.11.1720571168958; Tue, 09 Jul 2024
 17:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240709085431.455541-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240709085431.455541-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 10:25:42 +1000
Message-ID: <CAKmqyKPmLgwexa-N6QH=4QzuzSOkEzSDbH8Hp02UorzbJm96Ng@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: update KVM regs to Linux 6.10-rc5
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Tue, Jul 9, 2024 at 6:55=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Two new regs added: ztso and zacas.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 1047961fed..f6e3156b8d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -281,6 +281,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL)=
,
>      KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINT=
PAUSE),
>      KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
> +    KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
>      KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
>      KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
>      KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
> @@ -298,6 +299,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zksed", ext_zksed, KVM_RISCV_ISA_EXT_ZKSED),
>      KVM_EXT_CFG("zksh", ext_zksh, KVM_RISCV_ISA_EXT_ZKSH),
>      KVM_EXT_CFG("zkt", ext_zkt, KVM_RISCV_ISA_EXT_ZKT),
> +    KVM_EXT_CFG("ztso", ext_ztso, KVM_RISCV_ISA_EXT_ZTSO),
>      KVM_EXT_CFG("zvbb", ext_zvbb, KVM_RISCV_ISA_EXT_ZVBB),
>      KVM_EXT_CFG("zvbc", ext_zvbc, KVM_RISCV_ISA_EXT_ZVBC),
>      KVM_EXT_CFG("zvfh", ext_zvfh, KVM_RISCV_ISA_EXT_ZVFH),
> --
> 2.45.2
>
>

