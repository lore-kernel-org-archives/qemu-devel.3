Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A273DC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZvU-0001zw-N3; Thu, 01 Feb 2024 11:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZvT-0001zg-F2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:28:31 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZvR-0005XU-2J
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:28:30 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cf33035d1dso11572721fa.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706804907; x=1707409707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdRWbu5FXaABeFEoDyxusWA9wF0lQKWgC0yG9ay+aEg=;
 b=wbAd4qT/UIpcVVOM/Gv3RtWwDmZK0eYybvWx99lvFuakn98xI+T3hqEmx0Cwx0u5zz
 HBkQ4BFXEnqH05C/aJ3LA7VYuVrNSxyobyflrKWV04NOw3ZXrFtw8a1DZUQmXZu4P+iq
 9Ijt6OlCT72sVzrbGYn2S5fotQN5Ti1uf1aXbcyJILE/x5wOfMw2JulJ2I3VIO1Nz/25
 ISsX4f3Xc91Cq0rGMobq0EuLJoIoRly8O4ySR2/LsgCJM8NoLmA0CfzPVQ9YEctdwTuT
 jmrqFWKbzUY6pD3ljYZNP16eHEC3d20SvbxwdgFLWpI2cmzMIac4uoG39Ekb/b7wnha7
 vFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706804907; x=1707409707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdRWbu5FXaABeFEoDyxusWA9wF0lQKWgC0yG9ay+aEg=;
 b=VCP6K5/mq7OQBIkjf+oOw/CE49QSL7bUQl1VIJtjahaNChK7ngxhGDGKXiLiTrRrB1
 vqdhvtnwYJ8VMAsbiepmVvgQy0RsCdifv3sbfcl+L/gh1EcafjEwBbyg+iO5sXP8hqqQ
 NTOsw8UKYdvSdcWQfQtJI3ymil/P6QadEnIPcr7WhUTO+b/DJiVlrWgMlCJ/heX+JwTz
 dv3sxRLMwQO9E2PFGGwI+djylws6AkmUg2tNbqkUIF+fhY9wktU1/QYnS0s5XYyCr43H
 8SkxPNhQkyqgO+dgn55F3mW1JyDoKM3je9/VsxbfMvs0xGLzudtrM4X4Rd1uIiAsNq1J
 LU2g==
X-Gm-Message-State: AOJu0YxNwhNPT03JlSphD2L3wUH26LUCJEYQZ+wi4T6tYARmLfBzyOII
 5i/W4xDzb4w3nks0j+NHW7NrGZALRA5iwnqe+kp2XMdWNtv9lqR/obpn0Vf8I3oyKzQJDc14B5/
 wDuAJ483XT812R3Ev0H6BULvb403HXgBB8VTP0Q==
X-Google-Smtp-Source: AGHT+IFDx61ru6IEuGzNC4RP+/4dltN5SIdQ08c90ryVxk9iU5UdLlxx4hBdxMKN11Ir1BiBHx1HK1zHBtoIn+LGdWE=
X-Received: by 2002:a2e:b5a8:0:b0:2d0:6d69:7d25 with SMTP id
 f8-20020a2eb5a8000000b002d06d697d25mr2730187ljn.11.1706804907040; Thu, 01 Feb
 2024 08:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-4-philmd@linaro.org>
In-Reply-To: <20240130190317.25692-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:28:16 +0000
Message-ID: <CAFEAcA-w+=dy3_oiz63eg2AcS-vu93ZFrV1ZKF7iTC3eSYRHTQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm/stellaris: Add missing QOM 'machine' parent
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 284b95005f..bb88b3ebde 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1247,10 +1247,13 @@ static void stellaris_init(MachineState *ms, stel=
laris_board_info *board)
>                                     &error_fatal);
>
>              ssddev =3D qdev_new("ssd0323");
> +            object_property_add_child(OBJECT(ms), "oled", OBJECT(ssddev)=
);
>              qdev_prop_set_uint8(ssddev, "cs", 1);
>              qdev_realize_and_unref(ssddev, bus, &error_fatal);
>
>              gpio_d_splitter =3D qdev_new(TYPE_SPLIT_IRQ);
> +            object_property_add_child(OBJECT(ms), "splitter",
> +                                      OBJECT(gpio_d_splitter));
>              qdev_prop_set_uint32(gpio_d_splitter, "num-lines", 2);
>              qdev_realize_and_unref(gpio_d_splitter, NULL, &error_fatal);
>              qdev_connect_gpio_out(
> @@ -1287,6 +1290,7 @@ static void stellaris_init(MachineState *ms, stella=
ris_board_info *board)
>          DeviceState *gpad;
>
>          gpad =3D qdev_new(TYPE_STELLARIS_GAMEPAD);
> +        object_property_add_child(OBJECT(ms), "gamepad", OBJECT(gpad));
>          for (i =3D 0; i < ARRAY_SIZE(gpad_keycode); i++) {
>              qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
>          }
> --

We create almost all the devices in this board with
qdev_new(), and we don't use object_property_add_child()
on any of them. What is it about these three devices in
particular that means we need to call that function?

thanks
-- PMM

