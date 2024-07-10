Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B556AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 00:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRLYY-0001v6-2h; Tue, 09 Jul 2024 20:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRLYU-0001sC-59; Tue, 09 Jul 2024 20:51:34 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRLYS-0003Wd-Mh; Tue, 09 Jul 2024 20:51:33 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-81061d00c0eso809640241.1; 
 Tue, 09 Jul 2024 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720572691; x=1721177491; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLw0p7P7I1DdaCTXqHkXq9G0xh8MePX2A6hYxQuUri4=;
 b=SnkHhPbqZ4vvCC4LxK30il3posooTtVDB7uWtSeIW6dKBAmkwdb85/Wp1zGmszOfB1
 12RpOe+59ExqoHf71wId122nPcTPadI5h+gN6CjLcocTchAT4Z/HonygMrwBoqGVN7zk
 kdH1/zJMHeYqY++dQ7pEOx0ZRUkSCxfX+klexe5/Y3mEguQaEunYySa3MaiULX0Ct/Gx
 2BIlz0WhLySXpDfJqL3oA3iTbgZvEnuZeyKKTmxIfFyyWiqE9kzPl13oMZiVipvbQJ+3
 CrhcF4oDXVbF13raJibnz51xOH3jTGr0bk2JwTGM4JUDR6vOiZDl0/7maVi6Voak9wxU
 2ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720572691; x=1721177491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLw0p7P7I1DdaCTXqHkXq9G0xh8MePX2A6hYxQuUri4=;
 b=TzwSmh9Lxn1hwHJLfD608sVsco6gra/rdBNcovwA8Q16F8IspY7LQZNcdZB1nj590c
 Kwak5NslYJXzfq9n9nW+WsGSjlAMij6VNrz+WxoAcoJRvPJ5/CFezoZ1yV9IBXFim3+h
 7MZGWFdP3OKcJlSQjRykCm9ioLXPBxbewvC3M98x5wLkgkkjymRlRuMzXDDY4SGF73cw
 VF+KtytktOlOjQ3ESIRsG2/7PLznod0SsmfH7Noc0caqVywnBBBMPdb9efh17TuX5UGE
 v5YTm8SRgX5wN+4jLWy0mG7qBYSVdsNjc6y1Sx4JBbXBFgMnIOidUjjeuONseJLYXldo
 zC1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ndy8aPv2UCpqk/imB9YxbOWWXaZP+4bgnJPdAZWlPv5p44VRejIpJzoiPoRutGU1HoB/7ecigO+p+a1NOuFpgfN3Sz8=
X-Gm-Message-State: AOJu0Yw2EV3CGhr+h0xaJmQw68hthaBNu9UI9rtizdoRlMKybIseKASt
 UUNiMiI0gBi1GCQxgsXYZJyC4rcvcJqxKHfdu2NSjEQ1nlRkYkN669GiRvEmHm8/4SgvyMfSN0N
 j0rG4J22zPun5UmBaeNlOun/Y1Vw=
X-Google-Smtp-Source: AGHT+IFtZEdAZMaRXlnHSvgK90R0PFIb7bPPkSio9B7H5b1GPK1AMPDgGXjashBGgWp0Bz+IjFBcyEo/A39n365zpJ4=
X-Received: by 2002:a05:6102:3593:b0:48f:46db:7a11 with SMTP id
 ada2fe7eead31-4903214430fmr4616419137.6.1720572690933; Tue, 09 Jul 2024
 17:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240709085431.455541-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240709085431.455541-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 10:51:04 +1000
Message-ID: <CAKmqyKNNs4q9gKp5Dd=3GoDHS9EBJxrVF_-NiZmg1g=Ozwq+iQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: update KVM regs to Linux 6.10-rc5
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

