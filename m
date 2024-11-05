Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F04D3E77A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Rzb-0003G9-U6; Tue, 05 Nov 2024 17:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8RzZ-0003Fd-2U; Tue, 05 Nov 2024 17:25:41 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8RzX-0000KZ-KD; Tue, 05 Nov 2024 17:25:40 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-84fe1bc5284so2276471241.0; 
 Tue, 05 Nov 2024 14:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730845538; x=1731450338; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHggrVLdK90aIRJ3MiUpg0/17iirYyZWzPNt0PsNzC4=;
 b=Rb9OX6ZFj2qiU4eGKScGlfonTp16aXpc4dnTR+PujHNZ3QyMEvyF7ZqOGBeKB4Zl1X
 nZGHlDje7kaYiDZ6AmziIeafhBVHyoRcFXjJ0oe5r7KW/KvMp4o2qjMoVlxJLepV7emZ
 uqjFBzF50YiMoqk85mlewf4htRpppMpdIUYQuKwwfPerJnHJTBdhTgiFQEDtOa3+pzRp
 n9dHBNZwBqiQm68KzuxVUEcYpiL4WBSwqU5/R+QJwerKcYHM+uIrPvjQ2StiPvrY8THY
 AmEjYJypFjC/zB27+S/p1pEzzT79T1OuISc/buJAWFi1qY2DaZ/60WPO7Xmlte+MHTij
 xbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730845538; x=1731450338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHggrVLdK90aIRJ3MiUpg0/17iirYyZWzPNt0PsNzC4=;
 b=YR4KzCyLkfzLHf8qbmiTG1Xf1phTc2zXx7imTNyXT/GCWvlWdsB8Y/FHxW1y4OpS0S
 LKze55AOzhZ6/lzK38evn5O+BtPUYFq+OMK/SB++47qzaXdHjrGJtHIi67hGxJKNYLsa
 HOE08zr3tAhudIrd9gFqSJeuTmvAL0Qu6CZ2wpknbYdANG9uTWmpFG07kPQKh5z3GAIZ
 m3nePSYeSSa0svT9V1LZKo/2Y76ZCJrCUIfiv7jB6eGaNuKFsERklh+zQ3KQvui/K1mg
 WQ62f4gpeXZ7EHSxtdDqx79k4rjKD2+Xv2RGl4RtJ2mX18Wrq0f45X1SoqqWbn+/SJtl
 Oxtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURouHXM6gEtLobveH6P9L+fpLKnU1Y9RqKMtZV4d2KnKXoP/kbHlnynB9bVjp68sKiRRABYt+l6g==@nongnu.org
X-Gm-Message-State: AOJu0YwDHVGMC2bTYHyzE5du+lrrVaxFZdXnohrUISvTQCFDrjjXuAd4
 LcSdL21m7vO7xtFPJbEyMgmZgLLxCmV6Dty4hYLKUZbiLjlDdOqdcOgLCA2VfilnErDauMu5RiQ
 c9HFn9tJQwcLfRB1d0nFXn4TFrBI=
X-Google-Smtp-Source: AGHT+IHmTViU500WUTSip9R8LrHUYP+z28R6h4cSPAI8g0iw5VRMZID61qaONdOnQ0xpUsgfvMXAfWJIs86CPZVkUX4=
X-Received: by 2002:a05:6102:3909:b0:4a5:c74b:66a7 with SMTP id
 ada2fe7eead31-4a962f3bd39mr16750535137.19.1730845537820; Tue, 05 Nov 2024
 14:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-12-philmd@linaro.org>
In-Reply-To: <20241105130431.22564-12-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 08:25:11 +1000
Message-ID: <CAKmqyKNrr0g6a1yA33TdvYkJFJdNSKP7nNhhb3H5pQtpPHc=_A@mail.gmail.com>
Subject: Re: [PATCH 11/19] hw/timer/xilinx_timer: Allow down to 8-bit memory
 access
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Nov 5, 2024 at 11:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Allow down to 8-bit access, per the datasheet (reference added
> in previous commit):
>
>  "Timer Counter registers are accessed as one of the following types:
>   =E2=80=A2 Byte (8 bits)
>   =E2=80=A2 Half word (2 bytes)
>   =E2=80=A2 Word (4 bytes)"
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/timer/xilinx_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 3e272c8bb39..e9498fc7eec 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -201,7 +201,7 @@ static const MemoryRegionOps timer_ops =3D {
>          .max_access_size =3D 4,
>      },
>      .valid =3D {
> -        .min_access_size =3D 4,
> +        .min_access_size =3D 1,
>          .max_access_size =3D 4,
>      },
>  };
> --
> 2.45.2
>
>

