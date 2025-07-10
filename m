Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BC3C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoyb-0008L9-PE; Thu, 10 Jul 2025 06:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZoyZ-0008JU-3W
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:58:03 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZoyX-0001JP-9a
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:58:02 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so1760962a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752145079; x=1752749879; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6362CF7QurA4HPNtmDK2UXmGBNZSA44Uiw6iYXKcfQ=;
 b=FLOiTY33wgeICie1DXBUkpUV9bkPLXpQJi2MQdql9ZtWBF2T6RLVkObQoi7pYWW8Vo
 Yq75YAN3JzxCjYGlSQehohPuvkWfENC92GLkrVlPkZAK1oghRxIZyXftBvyG5BqHGp4t
 kahIv7zkt69RqwgsOxFjY4113w80vJBYbew2UZRUpFmkQGtl1Ft9murA1nAdaR2ZFwL/
 n0Akd9CCNZd6UV7r8hp+J0N+tzNC6cvqSfFPzK3Ayiftk3Vm9wqBzE8P8hfgVScSOGYy
 4aXW6FVEMVRxgp8uXCHJx/24i9DeWKkn9OUbA3aXL78YUGDOq958l5dBUNbg3AJyjmiK
 O95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752145079; x=1752749879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6362CF7QurA4HPNtmDK2UXmGBNZSA44Uiw6iYXKcfQ=;
 b=l6c6CLI+O4KmnmeQmmWfZTk+FZwnDDxTLjZgj/UHseqq2PDkOyFiV2fOxG78zOmYj6
 qAXeV4UfFt5Pojzy+JC4bnRIhUqpxgn1ZMoMsppQvFQlulEJfpaF8rmxKz6Nl0NIoI3h
 IVlEKmeydzJV5E5IzEtyBsWcjrJVUJFrBDJdB263/7wBXi/yxjoLcikxmi9sLeNIBxmW
 H2qsCBfFmNGErSfgljVEzd675p02OoODZDoJo/OQV+vsww6uWlkMhWCFdSrtzKR2/e9m
 ZfOTJDBYCn22POUehG/mezOWaUx2mAuTZ9cIL4WLfVldc0MWEJsvBGnPEqi9tWe6Daa4
 LrsQ==
X-Gm-Message-State: AOJu0YwtVcGOSwX2RILM8rM5DUlZJtervU4YUdEFU+wDCL2dXStYLqad
 XmVYDOs/HzUeIkgm+X4BsinlhY+f5yHo6VtREIro3meHbiZ7At8yT0kh28usS7NP39R3/E9B3Yc
 RN2QtrM1sH9teHT8VlWHR3IQ7khCJrrKx75XMVqYZhA==
X-Gm-Gg: ASbGncuAZTReS/+PkNPtrreMqx4CZHJMVpqH+C5mdNHVYhFMoqgNumjr6FDZ5K5ZlAW
 inDJ5g/PxckPs+Xp/7w+iODCee1F6qeSsObllJc134hpLUlg8/TUZ6zzh5HrXAn9eYArSNi/Bto
 /tjGx4ja+J6Zf6SzZf8jqDIfzyGVZ+f21Cru26rgljP4E=
X-Google-Smtp-Source: AGHT+IGxdubWt+ObbUDkccBpqEJxE638TwZVvMdx/kZtd638yoS4rYV3ciMkKf/KjYmv/M4BfY5LUknMccd2C+GDwJ0=
X-Received: by 2002:a05:6402:3204:b0:60f:d38f:f3c with SMTP id
 4fb4d7f45d1cf-611c1cd58e6mr2560792a12.6.1752145078664; Thu, 10 Jul 2025
 03:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
 <20250710104531.3099313-3-alex.bennee@linaro.org>
In-Reply-To: <20250710104531.3099313-3-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 10 Jul 2025 13:57:32 +0300
X-Gm-Features: Ac12FXyDCwH4W3SSUE1gc89Fy7Zi3SFGho8GUXnP1LRcc-xU-VXSMOgg5DioESw
Message-ID: <CAAjaMXYyXLMvo2dS=FOHJc2DA3fbRvaHoikAGg7JiBJg5m39sg@mail.gmail.com>
Subject: Re: [PATCH 2/7] gitlab: add -n option to check_units
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, Jul 10, 2025 at 1:46=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Mostly a developer aid for those who want to look at the full backlog
> of multiple build units.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/check-units.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/.gitlab-ci.d/check-units.py b/.gitlab-ci.d/check-units.py
> index cdc62ae5ee..cebef0e8be 100755
> --- a/.gitlab-ci.d/check-units.py
> +++ b/.gitlab-ci.d/check-units.py
> @@ -30,7 +30,7 @@ def extract_build_units(cc_path):
>      return build_units
>
>
> -def analyse_units(build_units):
> +def analyse_units(build_units, top_n):
>      """
>      Analyse the build units and report stats and the top 10 rebuilds
>      """
> @@ -44,7 +44,7 @@ def analyse_units(build_units):
>                                  reverse=3DTrue)
>
>      print("Most rebuilt units:")
> -    for unit, count in sorted_build_units[:20]:
> +    for unit, count in sorted_build_units[:top_n]:
>          print(f"  {unit} built {count} times")
>
>      print("Least rebuilt units:")
> @@ -57,12 +57,14 @@ def analyse_units(build_units):
>          description=3D"analyse number of build units in compile_commands=
.json")
>      parser.add_argument("cc_path", type=3DPath, default=3DNone,
>                          help=3D"Path to compile_commands.json")
> +    parser.add_argument("-n", type=3Dint, default=3D20,
> +                        help=3D"Dump the top <n> entries")
>

FYI this defaults to n=3D20 always, even if -n isn't given.

Either way LGTM:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>      args =3D parser.parse_args()
>
>      if path.isfile(args.cc_path) and access(args.cc_path, R_OK):
>          units =3D extract_build_units(args.cc_path)
> -        analyse_units(units)
> +        analyse_units(units, args.n)
>          exit(0)
>      else:
>          print(f"{args.cc_path} doesn't exist or isn't readable")
> --
> 2.47.2
>
>

