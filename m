Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F836C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhhM4-00061h-Ed; Tue, 05 Mar 2024 21:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhhM2-00061S-I0; Tue, 05 Mar 2024 21:50:02 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhhM0-0002If-Pb; Tue, 05 Mar 2024 21:50:02 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4d33d049cbaso99866e0c.0; 
 Tue, 05 Mar 2024 18:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709693398; x=1710298198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yV8p/jxSHQGeqxodYmectXNgzFk+bokfX/wqvyoYatg=;
 b=Yc8jY5zvPGIzg+bZSZp8tdDQBGA6PIvcfZP0JK4afP5yEyntUzMmzptNSz2wr89KBJ
 F1Xi/6KTKzBMfpzSdlE+krOw/gmiJGiOh8nj/sutCrfLq0tmeb9VqblxLKYTwTplO6Zt
 cwi3xt8S/5vn8HsHZY3BWpxkVfqT/uu+jHdNQHcoCzgnlROZyoqelS8ukP8Mu0Vlbdzq
 7XqA8WaZ/o6sUTylQSW6hGkvYOXnbxqqJaz2RiEAWlAJTlvpnDciVFgbOPyZBvKvKxZJ
 DqHM3gMEfW4NiLRiI5P9/k409LZX6oQ3b+/P9ZfNN1wANFNPxv+VMefdQI6cN11erV/h
 M2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709693398; x=1710298198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yV8p/jxSHQGeqxodYmectXNgzFk+bokfX/wqvyoYatg=;
 b=hTKIh+ON/oHLgjFssrS+v07mZUL9umQ6+knF6nmEhTPzHbjsdpBNsN45jdMOptgnGv
 EWV3+HQiwvdrmwjKow+BC10iKc3ADzIeLHwBlhbymMLLtKCSljzR4vas4jwPylNoKyOd
 ZRomxrc8bw9s3D/5vKZOf8HmJOlpDR6y/9G9cOmN9+NdoadNZqccxOWsnNgxYTPjT1Z8
 fGjaFV96nkk+tmVI2rTTH8mBGjSa0UB1spPO6kDB9HlRL6MyscxYPvkVWUOB3ljlsKP8
 2q78iDCZ6AWOm+yO0/X5f/PnyvIGpjuYWagOcFMpcSqxINMUS/vCSTZeV2JaFD/RJeZ1
 mVtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkIbj96e89YSMjcO0I4bZQvH1itRsJc/O54jR9zjTU6r3lRMlijy1muwl/zsoPg2TjCQNNW3nXEY+Car+ZzLF/GddJpCM=
X-Gm-Message-State: AOJu0Ywgznu07BiJPdbJn5tIuR2rOrsJcaMWHSV/I6GFalrNDQHisdN/
 Bw2ZO15qF7o1osYElvisbmUl2K+l3D0EfVa/NMksISVsksXOgNveaEPTjCMNfH93XSFS/ZFbpE2
 wpgH+16NX2Nqu0mLXkcZpJ2axnaI=
X-Google-Smtp-Source: AGHT+IGKvmW8n6c3IPYHvMw4i+KcFC5tKQULiRb3Adt7vUh/lu7TtdvakOX3pCagp7ZE71aGOB8HZ9xsKNtnL949wSM=
X-Received: by 2002:a05:6122:1d15:b0:4d3:45a2:ae53 with SMTP id
 gc21-20020a0561221d1500b004d345a2ae53mr3829407vkb.16.1709693398626; Tue, 05
 Mar 2024 18:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20240304134732.386590-1-dbarboza@ventanamicro.com>
 <20240304134732.386590-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240304134732.386590-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 12:49:32 +1000
Message-ID: <CAKmqyKPwpST+x+SKv6vsSCgW2N3oN5fW13ffrhyMYnARjftiNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv/kvm: update KVM exts to Linux 6.8
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Mon, Mar 4, 2024 at 11:48=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The last KVM extensions added were back in 6.6. Sync them to Linux 6.8.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 422e4f121c..c7afdb1e81 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -275,13 +275,42 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
>      KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
>      KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
> +    KVM_EXT_CFG("zicond", ext_zicond, KVM_RISCV_ISA_EXT_ZICOND),
>      KVM_EXT_CFG("zicsr", ext_zicsr, KVM_RISCV_ISA_EXT_ZICSR),
>      KVM_EXT_CFG("zifencei", ext_zifencei, KVM_RISCV_ISA_EXT_ZIFENCEI),
> +    KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL)=
,
>      KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINT=
PAUSE),
>      KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
> +    KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
> +    KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
> +    KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
>      KVM_EXT_CFG("zba", ext_zba, KVM_RISCV_ISA_EXT_ZBA),
>      KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
> +    KVM_EXT_CFG("zbc", ext_zbc, KVM_RISCV_ISA_EXT_ZBC),
> +    KVM_EXT_CFG("zbkb", ext_zbkb, KVM_RISCV_ISA_EXT_ZBKB),
> +    KVM_EXT_CFG("zbkc", ext_zbkc, KVM_RISCV_ISA_EXT_ZBKC),
> +    KVM_EXT_CFG("zbkx", ext_zbkx, KVM_RISCV_ISA_EXT_ZBKX),
>      KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
> +    KVM_EXT_CFG("zknd", ext_zknd, KVM_RISCV_ISA_EXT_ZKND),
> +    KVM_EXT_CFG("zkne", ext_zkne, KVM_RISCV_ISA_EXT_ZKNE),
> +    KVM_EXT_CFG("zknh", ext_zknh, KVM_RISCV_ISA_EXT_ZKNH),
> +    KVM_EXT_CFG("zkr", ext_zkr, KVM_RISCV_ISA_EXT_ZKR),
> +    KVM_EXT_CFG("zksed", ext_zksed, KVM_RISCV_ISA_EXT_ZKSED),
> +    KVM_EXT_CFG("zksh", ext_zksh, KVM_RISCV_ISA_EXT_ZKSH),
> +    KVM_EXT_CFG("zkt", ext_zkt, KVM_RISCV_ISA_EXT_ZKT),
> +    KVM_EXT_CFG("zvbb", ext_zvbb, KVM_RISCV_ISA_EXT_ZVBB),
> +    KVM_EXT_CFG("zvbc", ext_zvbc, KVM_RISCV_ISA_EXT_ZVBC),
> +    KVM_EXT_CFG("zvfh", ext_zvfh, KVM_RISCV_ISA_EXT_ZVFH),
> +    KVM_EXT_CFG("zvfhmin", ext_zvfhmin, KVM_RISCV_ISA_EXT_ZVFHMIN),
> +    KVM_EXT_CFG("zvkb", ext_zvkb, KVM_RISCV_ISA_EXT_ZVKB),
> +    KVM_EXT_CFG("zvkg", ext_zvkg, KVM_RISCV_ISA_EXT_ZVKG),
> +    KVM_EXT_CFG("zvkned", ext_zvkned, KVM_RISCV_ISA_EXT_ZVKNED),
> +    KVM_EXT_CFG("zvknha", ext_zvknha, KVM_RISCV_ISA_EXT_ZVKNHA),
> +    KVM_EXT_CFG("zvknhb", ext_zvknhb, KVM_RISCV_ISA_EXT_ZVKNHB),
> +    KVM_EXT_CFG("zvksed", ext_zvksed, KVM_RISCV_ISA_EXT_ZVKSED),
> +    KVM_EXT_CFG("zvksh", ext_zvksh, KVM_RISCV_ISA_EXT_ZVKSH),
> +    KVM_EXT_CFG("zvkt", ext_zvkt, KVM_RISCV_ISA_EXT_ZVKT),
> +    KVM_EXT_CFG("smstateen", ext_smstateen, KVM_RISCV_ISA_EXT_SMSTATEEN)=
,
>      KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
>      KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
>      KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
> --
> 2.43.2
>
>

