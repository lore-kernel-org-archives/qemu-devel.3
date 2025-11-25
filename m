Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ED0D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNuWQ-0007Ib-Aj; Tue, 25 Nov 2025 10:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNuW2-0007FD-Qi
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:59:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNuW1-0000JP-0V
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:59:38 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429c5e0f94eso671888f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764082775; x=1764687575; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqZABIgxDs+y95nG4A8BQlU1Q0nj8xisM5uajw1tEbY=;
 b=V2WzzrnJF9gYTnjd1BNa3KAVX5dpU9SiuaRcp5FsRJcLMk+XJx9xx+KymmgY0wYIUg
 dosWE+/MvMR9+y57KXdIzvrM60VBe9pFeGnyNh7EkVLD19nRmivFsNWZAXhAFRa2KeS1
 I/BWPQfQgsWsxzMWkMlQb6nF8yOsOjFv931wKYM+WsoDtBmnK90v5rLTl/YRmG/mIETj
 DX2/hb9wEy2ThJu/19egg9sYxWVGXbOy1GbgI+MUVx/zS8kwWHVKzTbpRKf8d6vuofQ6
 7XSk/i8gfEITMWu/Xz6Vq/uaoLQSfKIx56i021XWRKA3XkeV5nKqZ8mjyAMn74DwYhdZ
 D22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764082775; x=1764687575;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sqZABIgxDs+y95nG4A8BQlU1Q0nj8xisM5uajw1tEbY=;
 b=VQSISi9cI0uaOo3R2MVTeT7B4MsZBfsFrlTQgmtcg9RhMVZFh1uT4FocsLTfsGwe98
 io8Apu6d60MDwHbveBsOtVa+Zt9AZyhLXs+hJkn9mE/KOWYXrnU0BMYpo01deKmg9lnH
 ELgvrrExBqdsHbBO4sTdQfFNQ5Qb8+KDpWcYJgqRZq4xUi48NR5IkIC7iNIJX4/ytrUs
 VKp0waZQsJ5fVCIuKWJFgsFm+OoW85FC/gxqs/acHhSqfHArtakaj03vcgTFqIfKsbx5
 7N5y0H8IHDV+p1AK2CnUQe7G07OM1jBIxAUlGJxuADc4XAAmAjHSMpFhON9KHbFkhtch
 HBCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3u9x7j2bP9oGl1PNBOVaSFBrHAW6WjnNQbIek8bZi5ojiMpLxKxEbTrN2cFkoDdnZMd9ynSaN9L0P@nongnu.org
X-Gm-Message-State: AOJu0YzkjRa2Eg8xNZ5c1Cc9i/7UN2Z8D4Sg8Q7OclRZxD/yu4EExSv7
 IWG23SxwIP4IoE/RdtLEOLlfDPpSMRBayB/7SNDf8oE7AMgWeKkhuEXPiD8+kFK/+f0=
X-Gm-Gg: ASbGncvnVCMaw7sSoZPwnv0s3lApdBBSILinVme6EExxuFW3wON4OogemrLQ6GQl2qm
 71rhLXgxve1q77LxWIXDap2eN5HR8HUNQAauVali1CUzPJrhzjbLLgsYrm2a6ciZf0iYRaaMJrI
 cIQuQ/w/ZUcocDCXetz47FTNAGqwxhoLxPx6SOnIgOMlyitck1crCWzriA7hcvtmIf/sTPADE3W
 dKMyhjmEybhqORuIzZn/lHgctJHNhl36MiOFXUxqREZE8EMU/avuTS0BZQFEhjdWvpqeZBYb2sn
 Fl49WkCcvmzTGCuVoJu+Ro0wzGzMJWYluHynid5rIN+KuIsDKkLZpSEMrjIERXhGEYttzYhoSEv
 eQqiaH5Ig+jbDeh99EpU0ldBABFgVvbNb/qfdhH9jicYE+gxlaNNc2xj/TMpM
X-Google-Smtp-Source: AGHT+IEgvCXyYVyXDvG8wZqRlkqhI0Gp3epubYdXtR7Kxp93Ew5deReEC+kSzL6L7EZQxRHPiywW+A==
X-Received: by 2002:a05:600c:5254:b0:477:7bd8:8f2d with SMTP id
 5b1f17b1804b1-477c32794f8mr80221015e9.8.1764082775067; 
 Tue, 25 Nov 2025 06:59:35 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-477bf1f365fsm257555715e9.8.2025.11.25.06.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:59:34 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 15:59:00 +0100
Message-Id: <DEHV52Y49XZ0.1VF1MA5VMXMCV@ventanamicro.com>
Subject: Re: [PATCH v2 2/6] target/riscv: Add a helper to return the current
 effective priv mode
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "open list:RISC-V TCG CPUs"
 <qemu-riscv@nongnu.org>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: <frank.chang@sifive.com>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
 <20251121050413.3718427-3-frank.chang@sifive.com>
In-Reply-To: <20251121050413.3718427-3-frank.chang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-21T13:04:09+08:00, <frank.chang@sifive.com>:
> From: Frank Chang <frank.chang@sifive.com>
>
> This helper returns the current effective privilege mode.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> @@ -38,6 +38,46 @@
> +bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)

I wonder if this function shouldn't be defined in a header file, so it
can be inlined, because returning values through pointers is quite
inefficient,

> +{
> +#ifndef CONFIG_USER_ONLY
> +    int mode =3D env->priv;
> +    bool virt_enabled =3D env->virt_enabled;
> +    bool mode_modified =3D false;
> +
> +#ifndef CONFIG_USER_ONLY

We know CONFIG_USER_ONLY is not defined at this point.

> +    if (mode =3D=3D PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
> +        mode =3D get_field(env->mstatus, MSTATUS_MPP);
> +        virt_enabled =3D get_field(env->mstatus, MSTATUS_MPV) && (mode !=
=3D PRV_M);
> +        mode_modified =3D true;
> +    }
> +#endif
> +
> +    if (priv) {
> +        *priv =3D mode;
> +    }
> +
> +    if (virt) {
> +        *virt =3D virt_enabled;
> +    }
> +
> +    return mode_modified;
> +#else
> +    *priv =3D env->priv;

Since it's #ifdef CONFIG_USER_ONLY, we can just say

       *priv =3D PRV_U;


> +    *virt =3D false;
> +    return false;
> +#endif
> +}
> +
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>  {
>  #ifdef CONFIG_USER_ONLY
> @@ -45,19 +85,14 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifet=
ch)
>  #else
>      bool virt =3D env->virt_enabled;
>      int mode =3D env->priv;
> +    bool mode_modified =3D false;
> =20
>      /* All priv -> mmu_idx mapping are here */
>      if (!ifetch) {
> -        uint64_t status =3D env->mstatus;
> -
> -        if (mode =3D=3D PRV_M && get_field(status, MSTATUS_MPRV)) {
> -            mode =3D get_field(env->mstatus, MSTATUS_MPP);
> -            virt =3D get_field(env->mstatus, MSTATUS_MPV) &&
> -                   (mode !=3D PRV_M);
> -            if (virt) {
> -                status =3D env->vsstatus;
> -            }
> -        }
> +        mode_modified =3D riscv_cpu_eff_priv(env, &mode, &virt);
> +        uint64_t status =3D (mode_modified && virt) ? env->vsstatus :
> +                                                    env->mstatus;

It is likely a bug that MPRV=3D1+MPV=3D1 behaves differently from virt=3D1,
but your patch preserves the current behavior, as it should.

I had a few nitpicks, but important parts seem fine

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

Thanks.

