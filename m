Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CEDC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Rs-0006B1-4W; Wed, 05 Jun 2024 19:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0Rq-00069U-8K; Wed, 05 Jun 2024 19:53:42 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0Ro-0000Vg-Lh; Wed, 05 Jun 2024 19:53:42 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4eb05e29e69so150420e0c.3; 
 Wed, 05 Jun 2024 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717631619; x=1718236419; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aF7i7hU14oOVTsKR++BSoNSVqwNNWrllTV4l6fGE1iU=;
 b=baR2flDXBpn+vZ0CrENfnQmAjLDHAH1/nwVqdkQnzh70TnFxiBIlBHQfW7JP9QkP1F
 IZzgDI16pu7OzCNCuUzcluY2lcGqhDHdIP9O89oG2VOtsK2Cc+aO+dmTnTeJM3FIsKgj
 ov7Zwtg14uvlUmBfwNFvyHoAvkPcHOIIOBHiHoQLPsPCj7LB9t+kqxHWu3OdbUnRLnBA
 NCIWmz/86gfD56lLnlesrzP8Ek3Yf5TJAWbMTAr3V/xaOVt52sVTGGbnZWtp3VSv4Fag
 F0Gxla8z1KzEFYczxqnXkwIq5O2l0Qx80Y/pWiPh7FaDXCHNcTZhPyyFjMz5Itgk1JBU
 yJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717631619; x=1718236419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aF7i7hU14oOVTsKR++BSoNSVqwNNWrllTV4l6fGE1iU=;
 b=p24RNPSlmnQIsZ/y+EkLS6uUX4xiwDNtMQy2YIWEzX977y51RI/LkUmqLBLg99BYih
 4n0BE6xNli/3X6Acy+EzBKAZ6QmkBoUVUIW9JnzSBelQQgxmojHanY8Q5Xy5V0Yw1QTS
 muS7s9gTwq/rP3HGwkADCHiUl04Z9XnR5pE6l0uCRcWw5Bd1Gun9QYLppSJbfiUhKU9g
 e1DVOSclAkxkfY93iVd8SwHnllJfLHJiqEVl4qpSckjH4sIpvzyQuDAf0slq6+XLD4Vd
 YS/vgdVQ6RGnH2XLflVzi52XjuAV2GT03spzlpmZgdjDxljZPqjgdSwrrZCwi35a88D/
 vbzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW9X3g9fozuRczU4DiYx0QPxjG9Ih/fj/nt3kH5qoe3Kn2W1fNNgSIPTGvkqGjEU7ChnLfGFjKGXN7Y+ilMyPtzfOWliM=
X-Gm-Message-State: AOJu0YytpztkEAyT+Jl5MMgRxYW2pjcjeBU2RCEeqtvKg52WrlBHPO3V
 963ooGyYqbgAQWVBFqxhRUtgNNhx859Q4Kllj0q7DaYHWKz0K13Oi1esGeblXyhkaYZo7QNjgcR
 qG6TRow3OFk2+tuVsNLwnbUkBfSPAmg==
X-Google-Smtp-Source: AGHT+IEj0FIFGwdwfsOobR6tPYwZA5kAuPCBCr/dtwYcWRQjLEQl1qkQOLhPtWJEC9CbrYGIj6A+KcoT4reVokmnIOo=
X-Received: by 2002:a05:6122:2528:b0:4eb:3789:4bcb with SMTP id
 71dfb90a1353d-4eb3a4c5495mr5536844e0c.10.1717631619011; Wed, 05 Jun 2024
 16:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240604062747.9212-1-fea.wang@sifive.com>
 <20240604062747.9212-3-fea.wang@sifive.com>
In-Reply-To: <20240604062747.9212-3-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2024 09:53:13 +1000
Message-ID: <CAKmqyKOp0a4nusSc2XcVsnVekB=pv9hPKXdq-kW19DXDQ5Scrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] target/riscv: Define macros and variables for
 ss1p13
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Tue, Jun 4, 2024 at 4:23=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrote=
:
>
> Add macros and variables for RISC-V privilege 1.13 support.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Weiwei Li <liwei1518@gmail.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     | 4 +++-
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 94600b91fa..4d73486ea2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
>  #define PRIV_VER_1_10_0_STR "v1.10.0"
>  #define PRIV_VER_1_11_0_STR "v1.11.0"
>  #define PRIV_VER_1_12_0_STR "v1.12.0"
> +#define PRIV_VER_1_13_0_STR "v1.13.0"
>  enum {
>      PRIV_VERSION_1_10_0 =3D 0,
>      PRIV_VERSION_1_11_0,
>      PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_1_13_0,
>
> -    PRIV_VERSION_LATEST =3D PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_LATEST =3D PRIV_VERSION_1_13_0,
>  };
>
>  #define VEXT_VERSION_1_00_0 0x00010000
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..fb7eebde52 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -136,6 +136,7 @@ struct RISCVCPUConfig {
>       * TCG always implement/can't be user disabled,
>       * based on spec version.
>       */
> +    bool has_priv_1_13;
>      bool has_priv_1_12;
>      bool has_priv_1_11;
>
> --
> 2.34.1
>
>

