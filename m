Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C622CE94110
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 06:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaT4E-0001NB-4Z; Tue, 30 Dec 2025 01:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaT4C-0001Mt-MN
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:18:48 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaT49-0005WU-VP
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:18:47 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b79af62d36bso1645354866b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 22:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767075524; x=1767680324; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPa2nSKspOcaMDlZdktnwG9tq8ZSvPY1cl/vu337I6Y=;
 b=jdt1sPfuMNef9cLuBxcOwemF0ZUGAtRZv33+NcxTHL2DYScmhqsNoZmTAX0CuIWkJX
 DeenSq3gXOYvfmmtLbKdnHgLlYD+7x6BEvGfGcoPWiWF22W+uvk9j+/CfzW/nsEFas2O
 9aLJmK4DCkpozGOILKnmqEHWuFhqKc5IQ//P23slV3RoVsW36RIhVuC7Ge6DLz8vt7id
 ZYESttbAOmHm75MONg/VnMwUx6kjgUlSFlzqxcEwC83+xdAXb/wqgSPy855jkda2guP8
 f++yB/mTwDll9DivYawEH+uwDQc7JpussJeT20m/3X+Q3vK7dBHE4U6+MN57xuvEW2CY
 UMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767075524; x=1767680324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WPa2nSKspOcaMDlZdktnwG9tq8ZSvPY1cl/vu337I6Y=;
 b=g1Lp6KGqh1thp7aNzy+xkT8i5Nw7A4bWQvIUGc700qDWtIFzrRCDl/yS/5EPCfVvh7
 azo3H/4KN4rGN/9valeVkqU7GxeumDVTbSyfkk1sBgovEXfiY4InuHPuy46HJ/2wcVDY
 2Y5mP73TaMjCdg8n1RLv9Dm+/7SE0WZp+90p6zD4H0GAseQr0O+gFtYEA6OZ54ZQv1cw
 7bXWbo2PBsYoLsij5TwnDhShzJ++OLjveNdvMyDzcsmnBtObBKtLTKqXA/mogPhEB9p4
 DlVxCgzDVATKGa4Om60tPSjBUxPr3ICFyAzYyhu/hGkPv4mmmvlEuUL8yt+GiYKMGbCl
 zAlQ==
X-Gm-Message-State: AOJu0YxuII8oSRgUNWx4XhUmvIR1SqKCEVYq591MQOwwGHpwayBGzsAf
 +xSG9DPR0WMSiyACzVDO5gi4ulvC8UZlHB3J22m7A6nvLhH5LO6jASemROgpHRrHG/Q4eN7waa1
 7vZwOU77v3oLjJgjr62eL+XDifUjZIiaiL+NTn2vHGg==
X-Gm-Gg: AY/fxX4H9Se/pRzpVju8ir1W/sy3jgsimc4aXMtqqMdpdRGQjUeVBDMhY1jKAeixkKA
 EmbCLb041TMuZabtyS3/Ny1WUS67FEYcGkuF3WY4FkRRqlSVXe9Y0bKgfDUwrgP6D7uAnN806iy
 TZ+A7ogJN3HdFMAatkygECgQzTXxM32lUB1/Tgh9Awivue2a/41KQPf0ELmQpJGDy/ixk7V5dSP
 2xOaln2g39LaX2Fq3Ed7WYP3dF1lkKyGy7CXoxZTUE45JZp6dx40NvNnK0e80FiFGahWdnoLJuu
 mN1zZ3SkJn2X/3YWwd4zCNB4d6d7e1QoY7/HekDsVG7LIAiB1Q==
X-Google-Smtp-Source: AGHT+IEIzHmoE6pLlS2WrJZwkHA9pivOwo+keYZD+aLW4KnohBG+kFoZxWNGK263UG+1v3CDYGvDV5qKOtFBuoGP8yI=
X-Received: by 2002:a17:907:6e8e:b0:b73:b0eb:16f5 with SMTP id
 a640c23a62f3a-b8037152abcmr3025584266b.31.1767075524082; Mon, 29 Dec 2025
 22:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20251229225517.45078-1-philmd@linaro.org>
 <20251229225517.45078-4-philmd@linaro.org>
In-Reply-To: <20251229225517.45078-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Dec 2025 08:18:18 +0200
X-Gm-Features: AQt7F2oB-7Bmw7Q-hGq_DlQukhK_BJ184qaf9QuKnvPfF2T1PpG1QomyKHnfvRo
Message-ID: <CAAjaMXbOeGRZaNCu=8iK3383SZAPohUwBFunk3odHUkTdL5YiQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] target/hppa: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, Sven Schnelle <svens@stackframe.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Dec 30, 2025 at 12:55=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The HPPA architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>
> Mechanical change using:
>
>   $ end=3Dbe; \
>     for acc in uw w l q tul; do \
>       sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>              -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>         $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hppa/); \
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/hppa/gdbstub.c    | 2 +-
>  target/hppa/int_helper.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
> index 0c5e41410a0..4f016a0e61d 100644
> --- a/target/hppa/gdbstub.c
> +++ b/target/hppa/gdbstub.c
> @@ -168,7 +168,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t=
 *mem_buf, int n)
>          return 0;
>      }
>
> -    val =3D ldn_p(mem_buf, hppa_reg_size(env));
> +    val =3D ldn_be_p(mem_buf, hppa_reg_size(env));
>
>      switch (n) {
>      case 0:
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index 4e4869285b5..d5a20cd549d 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -178,7 +178,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>                          break;
>                      }
>                  }
> -                env->cr[CR_IIR] =3D ldl_phys(cs->as, paddr);
> +                env->cr[CR_IIR] =3D ldl_be_phys(cs->as, paddr);
>                  if (i =3D=3D EXCP_ASSIST) {
>                      /* stuff insn code into bits of FP exception registe=
r #1 */
>                      env->fr[0] |=3D (env->cr[CR_IIR] & 0x03ffffff);
> --
> 2.52.0
>

