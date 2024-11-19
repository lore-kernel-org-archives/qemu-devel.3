Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11778D60D18
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDEsY-0004qL-MH; Mon, 18 Nov 2024 22:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEsX-0004q8-GR; Mon, 18 Nov 2024 22:26:13 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEsW-0000kY-05; Mon, 18 Nov 2024 22:26:13 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-856e7566b2cso1182603241.1; 
 Mon, 18 Nov 2024 19:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731986770; x=1732591570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfhAviUlhtggwaL5IR2foPB1URTKHecEyTU/nfD/Ur8=;
 b=HzcRYFfF2uyYsJreILXqOXUe+xWsJ0z/x6oOtU734AiRU8hV0Ky60AWSn/srUOIWzf
 6EazcI6B46F172SaYutGjAE1vi7ufZ/AvOUycfK4yu1UwoR/dJLplCS1DffBqrH1C8Xw
 nD9eirs67hdgGNX1N8iRRvFEN9ZbVMYRIfjB5bGpkHKEiDfI++ZtiidNzJItRdKcC0BQ
 vzfGvwTDVJN2oJDIFX/4YOK/DeokgXMdv+SCesg1vh5OS9xwhHWbve+tLVxsT3JaYDqg
 Q8qfENwNa3+4SxcaiodNmKwCowGKymKGkcsZqkWsBRWpG/8cbfnrRW2pcaa2Pk+y8vTx
 8LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731986770; x=1732591570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfhAviUlhtggwaL5IR2foPB1URTKHecEyTU/nfD/Ur8=;
 b=D/tVkdudG2YkRCWzKsklp+5SGIsnxG0C18ocHVwE8MtvIDza/w3ZZzAtjmokXcRKLj
 fFUg8WP8TkYha943P0+Pian8RuPVFYxXBOHtPZUqheS2jxMUImrF9ZiF3GG/b1rBCPZv
 zEt5lKs8R3KzOewyw/pGmRdhLXO1Me/oyBft7AvqZ94uzFM0Ox8vy+X+Q9Jn8sacjFsH
 uFfIx/RZhv3tpRWv6bKdFSWpY1OukLz28bSAG8fsv3K4hvYnYk9Osd3pNFTI9Y3hzSng
 lnbq7W7JQ9uOenD9qmfIZNfDVgbXq5L3jHRKMnU9Zmw6u8oDpwt4XKmmJElY8MkNuGVb
 TuQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3n/Pagz2SM7awfOGxNW7tvPQTMBcbLqsNTslu52NjXHl3p5YfU8SFzFjUhUA09Si/pXAELOQvjXsz@nongnu.org
X-Gm-Message-State: AOJu0YyxZ87Zle4mLXJSMFfelCS+TtoqgzxNMqyfGPOTYd1aKEk7Df8M
 Kau3+XYGS/JQnuFvuNkmE9cTGPQWXdg3K46RAOooEqdVn99oZTA/2QiQyk+ek6Stwi11UAjR+Ff
 hbelZS79v0cumz2lKXvIt2iANCkY=
X-Google-Smtp-Source: AGHT+IFoaAMHPAKB/Lcr3WuiJNEvZqGQ7bx/5xvWfiBc/ZpekYrlUXNVEthLtyjWCgA4FwDocS4w5f82MNR0ChrDJ6k=
X-Received: by 2002:a05:6102:6d1:b0:4a9:5d96:949b with SMTP id
 ada2fe7eead31-4ad62baf26bmr12049691137.12.1731986770552; Mon, 18 Nov 2024
 19:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-6-fea.wang@sifive.com>
In-Reply-To: <20241112091423.2529583-6-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:25:44 +1000
Message-ID: <CAKmqyKNTnH0=viC67Mt7_c+mwu3wG9kLeh848FOpQx=v3Pj-pQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] target/riscv: Expose svukte ISA extension
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Nov 12, 2024 at 7:14=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Add "svukte" in the ISA string when svukte extension is enabled.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..6d3e9d563d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -199,6 +199,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
> @@ -1595,6 +1596,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> +    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.34.1
>
>

