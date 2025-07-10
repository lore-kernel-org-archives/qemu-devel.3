Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87DAC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoqj-0006rX-PO; Thu, 10 Jul 2025 06:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZoqJ-0006cE-Qy
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:49:34 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZoqD-0007zs-Tv
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:49:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so1548362a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144564; x=1752749364; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bJ3kf7dwHAEdzkxX+CWjkNy/EKVyNN7GPrpQsuLSIg=;
 b=ffFbgv6KnCylFyCvLVfUUdZctAUT3n/5NK1maGMGNMp9ffIE6WXRH30AAoydtKDPVB
 nbellmgXaJYaCxpQZFoWCZ419emSpERiCIIjS7QJOeVsGsHYh3lzswdcFIbbRHOwExo5
 qLqZkdxH7TkOfcuP0OzDGHN6gtaBGNYA6L+PkudeTzywN9lQ7P+qAKADPPsA8IB1uhLD
 9jfZo+a4s2+ty/3vOOlB1fMhUlK2xT1eKk4QZBiJ+OruXI4qFTIxiIrNRQX9yWzgy65a
 pJZANa84H3Qc8CBLNe99rCpDufL9ruw6EvrObEqOKckSmTWY60Ypla8HFGJVVO3fw9nU
 XT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144564; x=1752749364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bJ3kf7dwHAEdzkxX+CWjkNy/EKVyNN7GPrpQsuLSIg=;
 b=PhrG+WBx8oOJOdhtvaRWO4wBl8+hK/xmZCUG+xCyimBMmes3MhZoItERfMetMBQzo8
 C9UROTL8wgyIKTmm7u2CbVKuMZf1dOug2RiXFTu7vBxxzAdLpNW35Vmc+W7SMhl+8QlS
 hIBcdIGPTfpKV2JXN0NBvz2X069O1IPAkHTwQTRA+Fkx71kyvvx8FjWmMPINXAqqe/fr
 UMG3tl8PG4HFMh0G890gM87tQaDloOln2fjCwP24MUVVobQerRUeN+uXje8uHK79Yz26
 tuV1xORqmAduC1EtWMhEvc+EFnBmRjr+Rr3BVoDFoqoBLd2rW7uA7BE08K0I95vTPrjz
 fmYQ==
X-Gm-Message-State: AOJu0YxmlWMtV1D65YIYiv8gpm9SDDQjoUKtciTFEvJ0UIeAEM4xYRtm
 sYR4peLK+gwDZgg0gTKfFbN6Nogfqplz/CJJiNctRbkR0JvZ0nySY15Iqu4k6ic3U7CrJPsL6uI
 RZXSkDINdipFFxzhB4tvkoFGbPg1y5q1dxo6u8RWVAg==
X-Gm-Gg: ASbGncsfGyfQCeGbJnTaIP2WvlPMMVNTNWNQqnyqJ2Lf/CXWuv7Q/7AFqxGO3wBLfNn
 CS9ULvoA45oKnUkaGf75KVP0dtKlZXcFPkkaz4iMmuza+fW4XR5GWV7+YxbHvQfejPQEZ0lL2lR
 HshpGd7FOC0Div/RaOedmcg4bQW7s50G2iAYYF3oMOD9Q=
X-Google-Smtp-Source: AGHT+IFTWdJoDKh0/zOXQNmHAE6v+bvT8xarH7OVHAlqu35zo8EEytso8MWzWi5Nq7qp8ryfib7foXaxj5BGRsylZU4=
X-Received: by 2002:a05:6402:2553:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-611c83fb712mr1623434a12.6.1752144564100; Thu, 10 Jul 2025
 03:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
 <20250710104531.3099313-2-alex.bennee@linaro.org>
In-Reply-To: <20250710104531.3099313-2-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 10 Jul 2025 13:48:58 +0300
X-Gm-Features: Ac12FXzb5EKs7UDVsHwFsu_Wbt7NRAnnyTfvho4TSczVicVcJUuR4PH3uW97QhM
Message-ID: <CAAjaMXbhWW-TX8zW8nNu77Oy0_v5W6+xT=cGeonvxPmdFwRCzA@mail.gmail.com>
Subject: Re: [PATCH 1/7] gitlab: use argparse in check-units script
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
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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
> Modernise the argument parsing so we can easily add to the script.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/check-units.py | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/.gitlab-ci.d/check-units.py b/.gitlab-ci.d/check-units.py
> index 268a4118d5..cdc62ae5ee 100755
> --- a/.gitlab-ci.d/check-units.py
> +++ b/.gitlab-ci.d/check-units.py
> @@ -8,8 +8,10 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
>  from os import access, R_OK, path
> -from sys import argv, exit
> +from sys import exit
>  import json
> +import argparse
> +from pathlib import Path
>  from collections import Counter
>
>
> @@ -51,16 +53,17 @@ def analyse_units(build_units):
>
>
>  if __name__ =3D=3D "__main__":
> -    if len(argv) !=3D 2:
> -        script_name =3D path.basename(argv[0])
> -        print(f"Usage: {script_name} <path_to_compile_commands.json>")
> -        exit(1)
> +    parser =3D argparse.ArgumentParser(
> +        description=3D"analyse number of build units in compile_commands=
.json")
> +    parser.add_argument("cc_path", type=3DPath, default=3DNone,
> +                        help=3D"Path to compile_commands.json")
> +
> +    args =3D parser.parse_args()
>
> -    cc_path =3D argv[1]
> -    if path.isfile(cc_path) and access(cc_path, R_OK):
> -        units =3D extract_build_units(cc_path)
> +    if path.isfile(args.cc_path) and access(args.cc_path, R_OK):
> +        units =3D extract_build_units(args.cc_path)
>          analyse_units(units)
>          exit(0)
>      else:
> -        print(f"{cc_path} doesn't exist or isn't readable")
> +        print(f"{args.cc_path} doesn't exist or isn't readable")
>          exit(1)
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

