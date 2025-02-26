Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D16CC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 23:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnQi6-0002MS-JJ; Wed, 26 Feb 2025 18:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnQhu-00028y-Vs; Wed, 26 Feb 2025 18:20:51 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnQht-0001M3-9r; Wed, 26 Feb 2025 18:20:50 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-521b5bd2268so276801e0c.0; 
 Wed, 26 Feb 2025 15:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740612048; x=1741216848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lihyeHMp5H2UMxaKitKFSk6Vszj7Vm/LIP8ICpGjSXQ=;
 b=BaEyucwioNWkERFMUBORVXR+E/PTFmOsimzfXpnlRgtPvxZvKVaGK2jmS4L+Dwg0rI
 JJlVXG2f9roNQjhn62TyVMNZgcaRQC3WMlY3eKeqXQcHXbfken/XTogsCUekF9sOXzwX
 X7UU/snwRokxjeKrVINeyfXPal4wwp0NCBcghYYarXqnwkV83WOEDyO9U+JqmlhJFR8y
 50bpPP3gxJGocubXmtV7Sn5y0gyPHchzLulQ9GnzBbkHWtwpA5h0vkeFqLANlAjZhxPM
 Zp1RjJdllses/nRqsNuZyEwAumiEq0p52SMek/lbp5HhOnH2YEuVdcJC7pT12LDwUPnz
 1JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740612048; x=1741216848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lihyeHMp5H2UMxaKitKFSk6Vszj7Vm/LIP8ICpGjSXQ=;
 b=Jaj8YmOrroIToT6s02ZgI5eLgsAbJ85VQSSQ1OJrqJ9SvZAQUnZy/P7s7nZa4nUfNA
 AXxlUkcInk4P7oHcTTbjVIv6pd2W7EamhG/ByI3yYl9GYLbrjNZzpmX80myVPgekq4Gt
 +19Ne9JuzpYGDSQzc8l3XXVMLX5/Rv3UXFfrXBHgjYnxG/uPJnR4A7XwSfcxoBtsvDW0
 iQLoCRx8ZEfkqxVgGuqb/CMFGFxqQt6s8pF4dkeUcBfC13IBlQ4E0xBOMA+yCOZp7W36
 ddwl7otQ6xZeT779CQoK/AKyQP2emhKsPt+y9n4SjN7uGWakIxHLiN6ZLgOWAugFkbKz
 qwTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVWs+VUftIwiTa0xmeFigU0GEXIMKZITiGVMB0YgkITfRYwNaHHt3SWPVHELRf3mY/RuyhQxyyxSEV@nongnu.org
X-Gm-Message-State: AOJu0YzFLzeDbpA7LjT5r/o9Y2YjPeDUPHIC7RSvETlw7yq/oBBM0BBA
 595iw0We7g19SWo4923a8f9GkHdaBxFFBfiaZiSOMd9jO4OkI2v02+d44eir9FqY+Wx1RnKczp6
 m1Ek620Gq16eYTOBv4/yPtbIWvRk=
X-Gm-Gg: ASbGnctSscDzIeF5GoSUfxuN84D+axUxfFoDwthQDFPKixacW2Jnkmb3b5J2ojrteLN
 KvQ0xfIguOmqWQS+N3ovjIliV6LAcg79mFcP8CwMKWgUi+zQi/wPCXc9UhUBxQDpvZ1hvzmktWx
 WtZ3eZKs9drCzWX5N0dnl+9nxHwugMoOLpSu0YEw==
X-Google-Smtp-Source: AGHT+IHFM1ocPKcHeH+UXQfOGTcdEbK/sUAGxZRwTPzx4zoQjVVlux6tFyUvn5yM2yfM+fFxyI7lZGeflp4Df5OgFe0=
X-Received: by 2002:a05:6122:32d5:b0:516:1ab2:9955 with SMTP id
 71dfb90a1353d-5224cced0b6mr3488737e0c.6.1740612047771; Wed, 26 Feb 2025
 15:20:47 -0800 (PST)
MIME-Version: 1.0
References: <303616ccad2b5309768157b50d93b3e89fecc9cb.1740371468.git.zhouquan@iscas.ac.cn>
In-Reply-To: <303616ccad2b5309768157b50d93b3e89fecc9cb.1740371468.git.zhouquan@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Feb 2025 09:20:21 +1000
X-Gm-Features: AQ5f1Jol6HTKbncCCO9b7LU1RZSmTybESWrWdyWiQmLuJ2_VL_WemsmB6_16Kek
Message-ID: <CAKmqyKNGFj5rzfyMvn-5OEdADBa0-ULikuLczSoOUB+Dg_fQ_w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: Add some exts support
To: zhouquan@iscas.ac.cn
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Mon, Feb 24, 2025 at 2:46=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> When the Sscofpmf/Svade/Svadu/Smnpm/Ssnpm exts is available
> expose it to the guest so that guest can use it.
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 23ce779359..06a9f30841 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -319,9 +319,14 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zvksed", ext_zvksed, KVM_RISCV_ISA_EXT_ZVKSED),
>      KVM_EXT_CFG("zvksh", ext_zvksh, KVM_RISCV_ISA_EXT_ZVKSH),
>      KVM_EXT_CFG("zvkt", ext_zvkt, KVM_RISCV_ISA_EXT_ZVKT),
> +    KVM_EXT_CFG("smnpm", ext_smnpm, KVM_RISCV_ISA_EXT_SMNPM),
>      KVM_EXT_CFG("smstateen", ext_smstateen, KVM_RISCV_ISA_EXT_SMSTATEEN)=
,
>      KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
> +    KVM_EXT_CFG("sscofpmf", ext_sscofpmf, KVM_RISCV_ISA_EXT_SSCOFPMF),
> +    KVM_EXT_CFG("ssnpm", ext_ssnpm, KVM_RISCV_ISA_EXT_SSNPM),
>      KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
> +    KVM_EXT_CFG("svade", ext_svade, KVM_RISCV_ISA_EXT_SVADE),
> +    KVM_EXT_CFG("svadu", ext_svadu, KVM_RISCV_ISA_EXT_SVADU),
>      KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
>      KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
>      KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
> --
> 2.34.1
>
>

