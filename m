Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2537E65D26
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELma-00043j-NW; Fri, 22 Nov 2024 00:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tELmW-00043H-Ch; Fri, 22 Nov 2024 00:00:36 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tELmQ-0006CW-BO; Fri, 22 Nov 2024 00:00:32 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-50d3998923dso623650e0c.2; 
 Thu, 21 Nov 2024 21:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732251629; x=1732856429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqwmn+V/rp55rS0C4tS3U0SNoTJC8vM8+lYOR5LPbAY=;
 b=B70uoenxKVKl20QOnykcvtBe1ishLiVpqqjfPxlx8JKRrFYITlxHarY+uOAxtOHX2z
 R8caM4uxeoKdNIY5QxK6Sl9jwzC1aKgsui0vvsOcwrTT2WOm+uN4xJ36U4bSsA4Gs6Bv
 hJU/4Vl2D1TNmsGO/2ZHqnh6Xp6UVgE9tdMAM2VpR4RGWsfpcokzIm9vSH8AMwFDLGZW
 +bNPssjUtbh55ZP5JlHRt7KdbP3qUR/PDCx8Y4yU43oh65k+356/Iy6qECNL69nXS9ms
 O/3tscBhj5wmBIKrQ5jXfKB42+KP/dBGeP8QuMdZBakU50axv8KXVbtLws4sA0CMTewM
 WM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251629; x=1732856429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqwmn+V/rp55rS0C4tS3U0SNoTJC8vM8+lYOR5LPbAY=;
 b=HixTuIM0Jk5yF4G3A/NLnCJYQQWaj+p4UZO/OPNi7fgEePAMxcC/bfHDyaOwxBDmMn
 563hoX50qM6LeCPhhK0O7o7fAKsi9xEn2hoZr+R9bIyGfOnZNi9wt37n5wKxhE+vGFUj
 Nww1ovMCLlMgJ8girpf1a8zGaNqL0+Isw48CumVA0goVGS0zs4ktkBlNsK9eL2BGz49z
 cc5N+qw1HpHgiGSC/ErrlnjojmO9oA7J3p7Z/Xo5HthegIyfxcgmY8HzGUo1vdQ97GuJ
 u58WxSMXVDWoKYPU6k5feSUhF71YnSgx7cTNtaUgpliclqarZLaJ9H2ilvKIXT6lhRcY
 nI3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXN8JSXORr7ZBnRc+/pbWA+PibSvltCW1ILvYm/5L2pgjAcetI63EilXuGY2IwvrMs2kggfD6rhiFs@nongnu.org
X-Gm-Message-State: AOJu0YwmHuzKtvSzyhRKiPse8BxJRn5lfa3nnW3ZfDOX4sGl4DcEtKyk
 +jlb+YNI/lt0rC73uHeW2hJyJZDziRWkhzX1tL1NM1XdzAd50WXTqvkvtkkg/sn4Yv9Pefrfjvb
 5Jj3If8IDCoEJYay6GGlHAxe6zF4uSTMP
X-Gm-Gg: ASbGnctAvf0GcQjufeqo+nvvjRUiOxAJvSXUAcrT4vxfv8MoPhatKzQbhunHsp5D3BN
 rJXyx4PC8CwOk/UWr7oUc6XpLhtJq6gym8E8oITVpIKGQMd37rgVCgXkxp/5ltg==
X-Google-Smtp-Source: AGHT+IHn0WCcbh8BS3f7YBxnxhGDRjX86qe0gSYeycVLgexPgV4c6FXVPD3A7DA9VA1OFKgwJwPgVO2aiFhivfsjVpo=
X-Received: by 2002:a05:6122:3220:b0:50d:2769:d741 with SMTP id
 71dfb90a1353d-515009ba4bfmr1934132e0c.11.1732251628912; Thu, 21 Nov 2024
 21:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20241120074854.1767780-1-fea.wang@sifive.com>
 <20241120074854.1767780-7-fea.wang@sifive.com>
In-Reply-To: <20241120074854.1767780-7-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Nov 2024 15:00:02 +1000
Message-ID: <CAKmqyKOFp3dXjvX-Q2=a2ny3aDv33B064dFGzxgUB1cD0M5M_g@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] target/riscv: Check svukte is not enabled in RV32
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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

On Wed, Nov 20, 2024 at 5:47=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Based on the spec, svukte depends on SV39, so it should not be enabled
> in RV32.

The spec explicitly says it doesn't support RV32.

>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c62c221696..4273f1f472 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> +    if (mcc->misa_mxl_max =3D=3D MXL_RV32 && cpu->cfg.ext_svukte) {
> +        error_setg(errp, "svukte is not supported by to RV32");

"svukte is not supported for RV32"

Alistair

> +        return;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> --
> 2.34.1
>
>

