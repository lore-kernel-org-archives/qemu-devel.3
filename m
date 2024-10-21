Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7302D3C935
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 00:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2gF0-0001du-7E; Sun, 20 Oct 2024 20:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gEy-0001dO-H1; Sun, 20 Oct 2024 20:25:44 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gEx-0000az-4D; Sun, 20 Oct 2024 20:25:44 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4a482407e84so1136719137.0; 
 Sun, 20 Oct 2024 17:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729470341; x=1730075141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4kcMr2tYJi+GCbrUEHltzPeR1Jp+CZjIEfKAMZonAo=;
 b=XX+/9aZijegY/zoBf4pI6k4j2ePg2dZTy8s/gwWFUoSSjWamnDcoIP+njgBMzxNBMn
 HaHxa5ADCH8jC4M4XQ58wljm2aenSI464kh1wdM3xvzHcDjn6Eg/R1DnKkFkXNPxGdhY
 iVrR/ZR5e7jW1Ybe7XteA2/PSqvelqEoloT/TTBIfHOQ6q1ci20JFGZGh7P+JysndNhb
 Q1lb8871CJ2JcBiK+HdmrsDN3Z8evCBPBlqjwrxkTZ4y4RJ2XpQQ+mpNaTcTp0KEVnip
 zsPplrMOpOeT5ANBRzws01+RlShkNaXQPM7TPradu9sGfjkuHZ7lIyQPt+8k6wzgYzkz
 FOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729470341; x=1730075141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4kcMr2tYJi+GCbrUEHltzPeR1Jp+CZjIEfKAMZonAo=;
 b=VHD/6BNFfAhP0bHHePWsRmH02SOievMY7fJQQJCPmVWjSo8Zm9XylyxntApjmTLiDu
 4BbWy0/a5PRdnJCEbkkML18ClzhPnfUVriBWdJ7flogunh2o1ifPoqLCNTx4rjJ+uVAg
 FcP8hOC6rAbX0O7DEpSzPZGDqpPUBGra7X4X67qUjIoVn3rcC4UtY2Wn3xTutS0W3bwh
 X1HPD4mlZ2JnR//uvybK+BNmNZjD5YzziRWMTtC+xcONB1YK9hWcvGu0clZ75JRrcgfX
 TrFt+2swdx0i/Efpw57JbCFW4LIucmsGxXvoJvZNsWw3m9UmLs1s/JDVhzOUBlCws+0D
 1GOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDseccuxNSWEZFGo1vUFTIPIfxWDd9yTO7HeHQVj8hHp2CKlR83NEBJeeHvLtKhzGA+lltazoB8a7D@nongnu.org
X-Gm-Message-State: AOJu0Yy/9GkgDne8hcHeyMcGvLAlJ+0RgL38wO0JcynQuQN/z+04XADY
 NrvdMuMPxQMxw8E9N4Xj+hpf0YfupgMWJrs7k44YIDFBfPoM13COzeBWiRXUVWYceJAOPxDoFsf
 xkPb5whk/IzafHG8HZ90/rNaIlJA=
X-Google-Smtp-Source: AGHT+IF51FSe8gEszLk78SfmP4WTSa7GS9OGLveb3URbmkK1p34DMfn2ibVRTmLDb9CqtHfifgEjl1BHe1PXWNRke7M=
X-Received: by 2002:a05:6102:3a07:b0:4a4:8d6d:a37d with SMTP id
 ada2fe7eead31-4a5d6bee7d4mr6647088137.28.1729470340820; Sun, 20 Oct 2024
 17:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241018141332.942844-1-peter.maydell@linaro.org>
 <20241018141332.942844-8-peter.maydell@linaro.org>
In-Reply-To: <20241018141332.942844-8-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 10:25:14 +1000
Message-ID: <CAKmqyKMYxMW5KbeJAGyGtUwHS72C7JuGS0-LP7cmZRF7irioag@mail.gmail.com>
Subject: Re: [PATCH 7/7] docs/system/target-arm.rst: Remove "many boards are
 undocumented" note
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Sat, Oct 19, 2024 at 12:14=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> We now have at least placeholder documentation for every Arm board,
> so we can remove the apologetic note that says that there are
> undocumented ones which you can only find out about via the
> ``--machine help`` option.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/system/target-arm.rst | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 1f806cf4a46..9aaa9c414c9 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -63,10 +63,6 @@ large amounts of RAM. It also supports 64-bit CPUs.
>  Board-specific documentation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> -Unfortunately many of the Arm boards QEMU supports are currently
> -undocumented; you can get a complete list by running
> -``qemu-system-aarch64 --machine help``.
> -
>  ..
>     This table of contents should be kept sorted alphabetically
>     by the title text of each file, which isn't the same ordering
> --
> 2.34.1
>
>

