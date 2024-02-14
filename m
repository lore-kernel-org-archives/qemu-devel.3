Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0BBC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 08:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raAKa-0005eq-G2; Wed, 14 Feb 2024 03:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1raAKY-0005eb-Uu
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 03:09:22 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1raAKX-0005HE-3A
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 03:09:22 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7ce55932330so2081388241.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707898160; x=1708502960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxBT2htgGo1R/dwAOq36JhJUToR3wrORKfW8BQKnxj0=;
 b=R+uvgnzqPo+0EI+PQdAHFX4BzlfXUwTJmGpNQ4Za0WsLgNMGbLWdrWDEu3LYFVzIOi
 kkUHcaf0mld1fipyIREc61PvFnRc3SjeQIAAWj0/SdE4jcS03zLMsVapuXwraZf0TD6F
 5tePp/ZM10zgQi5YwgAy9EKg0dqpeu3RFoRiVksSZ4WVrkSu/zWInDDAjp0WTI35P5/s
 fXLFWqurdibnqbW7xsw2wLKALdo3r4/Z8x/fLhA7lSIUyabped8XipDXU+Uy3geQ7/Mw
 mL/msLBTSybu7yA1J2VJPkY3mZm+tzbxe74hnMuiMKwarmBV05PT9aHrWTP8exJaAPaX
 xLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707898160; x=1708502960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxBT2htgGo1R/dwAOq36JhJUToR3wrORKfW8BQKnxj0=;
 b=qlnogM+b1oLTFugn6w23r6IZzhBifr2ZfAzw9BimO0ZpjOZXak2dx0OazkFAGCYB8X
 ZazOJx9SrtnPPewlkhvAyHJHXCOdLJnmgAZqyFugMXp5xAdBmV1LSNjCNBGqf+zSYbXt
 u33aJPpy5vx3XxNXxA1/lu/alC3lVLbfMBd6sNd+ACk8jnEn5Bxfp2v7LilFNc1R0SWO
 nx+jwbuldvB1y37pilSkTxLzWTSvOwHqLPIbGwQPR1AtKaiKGWfNAfofdrSjRmKTZS4m
 hL2bNdwb5bdSSUn30MKMwxxbR319QtBo/CuGOIOG4JOffF3KaOU1S5gVJyMuL/hC2JOF
 7ZVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSZ+HFCtMEMmeW41zbDtAom+6TvPiC0Ncy79PCP4OPOt+MIWaa3u/1KzMwzX5yKYjt/0uGJlf1c/X/qLIpUdwdU7+PuVM=
X-Gm-Message-State: AOJu0YwNWVz66wJpT6UDv/z/6iyatjWwr3hYPWa70U9xxLxOXlIt/2+W
 4nChLztIPEv1715f+99LCTUEeCzEjPg3jpeJOHfbJLVm2gk7Kllv4U6bjdFyLV4WZ85pp/g7BWo
 jEPiIU+IVll3d22duBtGhO/1cJ88=
X-Google-Smtp-Source: AGHT+IHf5R8T+53tJ4cYZs2pUnEboU7MIxrO7QQRzS2EZ6/GIzhzw/15VTwDhGVah8nOZ8m4Y/nNHzF5QiNTkX4MupE=
X-Received: by 2002:a67:e3ba:0:b0:46e:cb7a:2a3a with SMTP id
 j26-20020a67e3ba000000b0046ecb7a2a3amr1479656vsm.22.1707898159701; Wed, 14
 Feb 2024 00:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 14 Feb 2024 12:09:08 +0400
Message-ID: <CAJ+F1C+7ecoq1hFdXn3pkNqXkWtXTMMyUP__7KnLp2Uk46Nw_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] meson: Fixes for dbus modules
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Akihiko

On Fri, Dec 15, 2023 at 3:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> I found it was failing to build dbus modules when --enable-dbus so here
> are fixes.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Updated MAINTAINERS.
> - Link to v1: https://lore.kernel.org/r/20231215-dbus-v1-0-349e059ac5b2@d=
aynix.com
>
> ---
> Akihiko Odaki (4):
>       Move dbus-display1 out of ui
>       audio: Depend on dbus_display1_dep
>       meson: Explicitly specify dbus-display1.h dependency
>       tests/qtest: Depend on dbus_display1_dep

Can you send a v4 which doesn't move the dbus-display.xml out of
display/ but has the rest of the dependency fixes and r-b?

thanks

>
>  MAINTAINERS                               |  1 +
>  meson.build                               | 21 +++++++++++++++++++++
>  ui/dbus.h                                 |  2 +-
>  audio/dbusaudio.c                         |  2 +-
>  tests/qtest/dbus-display-test.c           |  2 +-
>  audio/meson.build                         |  3 ++-
>  ui/dbus-display1.xml =3D> dbus-display1.xml |  0
>  tests/qtest/meson.build                   |  2 +-
>  ui/meson.build                            | 18 ------------------
>  9 files changed, 28 insertions(+), 23 deletions(-)
> ---
> base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
> change-id: 20231215-dbus-86876ecb7b09
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


--=20
Marc-Andr=C3=A9 Lureau

