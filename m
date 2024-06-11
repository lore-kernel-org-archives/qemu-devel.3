Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C96DC27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 01:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGqQV-0001Mb-RA; Mon, 10 Jun 2024 21:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGqQJ-0001Iv-7W; Mon, 10 Jun 2024 21:35:46 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGqQH-0004Sh-LN; Mon, 10 Jun 2024 21:35:42 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-80b8fd76e6dso1189370241.1; 
 Mon, 10 Jun 2024 18:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718069740; x=1718674540; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjKyUNDafP6eN9ei/IGL4jIldbKfhanNb1XOPK1uRn4=;
 b=SMok/xSxFdlUeJ42knaDlrtmWm9Edk7a5nTjQ7TwRNxIO43WGvh0Dhnxh3FRhylB2c
 oHW2TOJG/S79fyKVs8hd5sCAJzMgwguOC+SPBqxyS0oNsJ7B9Pag01G2os11c4wxdQpq
 CXdzscTkdjnJtS9baYQSBmWkzNlHwwCWRAqtAQZyBriCoz5V9vnN3K2TU2bfo0qlvv87
 hZ9daIb0TEjentcLTJ4cnc35qvLTAOg9c/D1LwKTJRkiDltxky4Z7qPUhw/WVEo2En2Y
 Sjf03iRi76jIdJDh60OES/82tEwMufC5TjdZ5tENvkjw0IuUFv4xL/H4UDmEoN0mAlVR
 v3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718069740; x=1718674540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjKyUNDafP6eN9ei/IGL4jIldbKfhanNb1XOPK1uRn4=;
 b=vwBLxJqorQpSjJPjr2jqlezAKw+qhRLJ9AhWPM0t0ZYl4ggRrVt4F2KW73HhbUXpTr
 EYNe4XhZTcr4zmKY8JhvpxfyxGRgbSVBfyDrHu3Q+hsYVrewH0IEqN//rGyztWcZvnKh
 kvD8wmGes1wVbmUMWNLAFh8CvyBXz+rEAN8mgtjs5p3eXgtcTZgvKtEDOW/wzownLNwH
 tTD6y6EDH+8rNumO+DtgjaPtodS0trmXPEi2faOVpDUmuRP23zOFLdz4dCQh3gn8wy/4
 nKhlz8rOq/9LWy7CFRjPmeRGV45mca9xhhHYVPVnfRqQkUHkz+3uLeK8xuYyuj5ML2/8
 6Lhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfetcgNlP5KPSl3f67e+iwkRhes3vF5Do8XsFipxhcFCTCchldwDUH3N0ByOp7mLBeM+1id8dp8I1LOTqUiRbMpRTRGGw=
X-Gm-Message-State: AOJu0YwsioQHWSM4GlRhyWhssc4QSNEExJwWy8M+BH/s2HT0MXkYhNXU
 3n4IxPDzlJNy7eG5nyn/vC09XQKzVcoRWYvlHwo4B0fOX2OlXspp0ObzRBdKMRUgZWxNcWfo603
 PmkOKvMCrmDDRl2FBJBQBgnHyTWA=
X-Google-Smtp-Source: AGHT+IHdyf3dFU+fDAFCR+Na+cwiNDOmgf+zPraYSDvzv8qXakWYk7n9X6SXhdinKDL9bCJmv6qA70Ikq24RT83+Fz8=
X-Received: by 2002:a05:6102:3647:b0:48b:bc7a:8136 with SMTP id
 ada2fe7eead31-48d816c9f24mr1378417137.2.1718069739557; Mon, 10 Jun 2024
 18:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063154.31298-1-frank.chang@sifive.com>
 <20240605063154.31298-2-frank.chang@sifive.com>
In-Reply-To: <20240605063154.31298-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jun 2024 11:35:13 +1000
Message-ID: <CAKmqyKN8J1g_1XyAVxpjWiSQDDhPuKrQk9x3ys2JCbiaGyf=AA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/6] target/riscv: Introduce extension implied
 rules definition
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Wed, Jun 5, 2024 at 4:35=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> RISCVCPUImpliedExtsRule is created to store the implied rules.
> 'is_misa' flag is used to distinguish whether the rule is derived
> from the MISA or other extensions.
> 'ext' stores the MISA bit if 'is_misa' is true. Otherwise, it stores
> the offset of the extension defined in RISCVCPUConfig. 'ext' will also
> serve as the key of the hash tables to look up the rule in the following
> commit.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.c |  8 ++++++++
>  target/riscv/cpu.h | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cee6fc4a9a..c7e5cec7ef 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2242,6 +2242,14 @@ RISCVCPUProfile *riscv_profiles[] =3D {
>      NULL,
>  };
>
> +RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] =3D {
> +    NULL
> +};
> +
> +RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] =3D {
> +    NULL
> +};
> +
>  static Property riscv_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1501868008..b5a036cf27 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -122,6 +122,24 @@ typedef enum {
>      EXT_STATUS_DIRTY,
>  } RISCVExtStatus;
>
> +typedef struct riscv_cpu_implied_exts_rule RISCVCPUImpliedExtsRule;
> +
> +struct riscv_cpu_implied_exts_rule {
> +    /* Bitmask indicates the rule enabled status for the harts. */
> +    uint64_t enabled;

I'm not clear why we need this

Alistair

> +    /* True if this is a MISA implied rule. */
> +    bool is_misa;
> +    /* ext is MISA bit if is_misa flag is true, else extension offset. *=
/
> +    const uint32_t ext;
> +    const uint32_t implied_misas;
> +    const uint32_t implied_exts[];
> +};
> +
> +extern RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[];
> +extern RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[];
> +
> +#define RISCV_IMPLIED_EXTS_RULE_END -1
> +
>  #define MMU_USER_IDX 3
>
>  #define MAX_RISCV_PMPS (16)
> --
> 2.43.2
>
>

