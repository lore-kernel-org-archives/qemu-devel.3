Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBAACCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XDE-0000fN-Jf; Thu, 16 Oct 2025 19:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XDC-0000ez-Uj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:16:47 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XDA-0008Hq-Iu
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:16:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-639102bba31so2712653a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760656603; x=1761261403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZOo+KGvbRcoGQKMNiL2X7gorS8tn48uJ05gTWgyKO0=;
 b=h9rbuGJCiVJro0Hh0b1k8oO9mU7KPwMchnPs4cvLgxMCALzLnYBgdk2PJCX8Og5suW
 pz2QjXsznZlAxzRZJu0Ijrr2BdXFdXAssRn8htMrshuwOIj4yyot3lRbfJiBTQ0QaYzE
 ZRl555CMdu7stdwkf+A+286vIti0nIMQZO13pIWT2C5mtSV0tr8o6sm7XfT61L2j/KTD
 bdKEK5JunSvpuCUDlxJeJYU0BpepmHbTRQzR1TQMyH8FLfml8DzazaGD3aHLh6vPIEpg
 HUt5cYyZOPZTF74lI8A8TOBR1l85hTGa2B0UTAjU/0/GN+rMrwBYosrM9gnTfvVjbIwN
 8ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760656603; x=1761261403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZOo+KGvbRcoGQKMNiL2X7gorS8tn48uJ05gTWgyKO0=;
 b=KyawsA+oflBGFyzm7UngZjr6yI6dvmx8Q5r/GzRHOe4bYyPuKLlKqrwRfIEo7yqysQ
 Jjk8L4SeM5tAxAy9uSEcE6FQSZiTs2nM9Ms4dNh1+sV2U5FJMw/SLDi8kyrb8v7Hakhf
 eVYXojQhidZijxn8mWeFUu3zA1x0s+vSjDiKXmmtEaQ8ZnJwQBl+uYbppzwtpzWgmpEg
 T872e55CQct85cKeeq365pTjsK4NwR64NFIdyTezzHcpIH/02b8NihJkX0CpYIFGRXDX
 7xcLBn5J2DDDThJmNeIPiQZ5dFPs0tsJMG13tnOmOEyHCI+fX3z0QnRMuchgpkGkCfCc
 5NGw==
X-Gm-Message-State: AOJu0YyywT1d/DsmmWmBO4bebq4gJtWhkFrOgwKrdpHAA2o3sLkGf7sJ
 3Jjv80f6iorGw8XOE+AC/8dRI5pYzh12jDvG+a4uu6LyEX6CZXiHrNTu092KmCGkJxDc+LpJ80+
 81uq6SOIzkSFPRiULB+JWq4EJzvlF834=
X-Gm-Gg: ASbGncsPtMNMDrXSpwqiz/fwX9As4WdpeV/Osdl2j0a3smHNrmIUPWm1BPDUogZqkSJ
 9uuADsoiY9p4+bi8Aph8tBn3TfTsy74bDvt8FosvMWvx6WdXToby/uzEJoIYRUC8jCEn1Wl2ypD
 eY0Kgdmo8lHai2f9rkynyhkLW7Wk8WwvUeP+efUWryaxnlAr9MFB22tjmVYbmZlm7ziK7npMjG9
 N98Fb02/hS3XcyhdRGZmOoRCtWbdNGx7CUrt0ptp4AFdrXOm4Er47qKZtIgCCt4jp82RkP+eugj
 m1EmGKtbUFuelq6I4tD0h/KXqw==
X-Google-Smtp-Source: AGHT+IFZgwvRUARJ3NtmDUKD5kQjAbLilM41ioN+N8PY+WPMxo1DhOXpj4ZL2Hm9xYy/B5sd/u/W2pcTUbdc6BP33Wg=
X-Received: by 2002:a05:6402:144e:b0:637:e3a2:7678 with SMTP id
 4fb4d7f45d1cf-63c1f641ce0mr1565670a12.9.1760656602656; Thu, 16 Oct 2025
 16:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-27-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-27-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:16:15 +1000
X-Gm-Features: AS18NWA6Lepy82raXoRr0YmqfxvFbkYoyIRKHxRlQ0MoZp5q5-UzUO2ZL1CxOsU
Message-ID: <CAKmqyKMr+jpxiV2zPxt8+VrOKmU1fz5f0Bwofe6WDCF+EEYXQw@mail.gmail.com>
Subject: Re: [PATCH v3 26/34] target/riscv: Indent PMUFixedCtrState correctly
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Oct 15, 2025 at 6:38=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index cb99314679..3072ee0005 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -227,12 +227,12 @@ typedef struct PMUCTRState {
>  } PMUCTRState;
>
>  typedef struct PMUFixedCtrState {
> -        /* Track cycle and icount for each privilege mode */
> -        uint64_t counter[4];
> -        uint64_t counter_prev[4];
> -        /* Track cycle and icount for each privilege mode when V =3D 1*/
> -        uint64_t counter_virt[2];
> -        uint64_t counter_virt_prev[2];
> +    /* Track cycle and icount for each privilege mode */
> +    uint64_t counter[4];
> +    uint64_t counter_prev[4];
> +    /* Track cycle and icount for each privilege mode when V =3D 1*/
> +    uint64_t counter_virt[2];
> +    uint64_t counter_virt_prev[2];
>  } PMUFixedCtrState;
>
>  struct CPUArchState {
> --
> 2.51.0
>
>

