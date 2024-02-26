Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F58C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeF8-0003mW-BK; Mon, 26 Feb 2024 11:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeF6-0003lx-LX
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:54:16 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeF4-00072m-FH
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:54:16 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512bd533be0so3938775e87.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966452; x=1709571252; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qizssl5kz7Kj4xa4duADsnx0VnNWR86cx9aqAcWnQsc=;
 b=TKkq4mUrPKrc9UEa7wIlr3kZRyUUC2MDBiO+3Em/uft6c69hyEVgztFD2Mvtz7rhjf
 WYlDaqn/BGi8rBkvVEdypRHR5iGDOiaPWpD9w+3g5ZslEXLZ1pAjYqgpuO2xyGO8wONM
 UKSU6MP71PHg9zdsfm6X6PgNVz9ReVsiDEc6uV7svgJT1Y0T1QQQAFJUlEnYAH4//KQD
 3hnPkhKH5U8cNp+x0uehrl97HfJE3/TSofznTvJcvPS4Mhhj+lEyQqzxBt8/ZqHG1Z3U
 9/ndlbT8ykpFJ4MdaOuoHTq/agdjlWFaSwcEisO3zpnkx0Z/JBkSOwgmG4iBOqyX355c
 vT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966452; x=1709571252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qizssl5kz7Kj4xa4duADsnx0VnNWR86cx9aqAcWnQsc=;
 b=J5oaullUwoTEAUcZo04s/Lk7vrsVjTsmG7ispYMZzZmrZIZJmFx57rYWjX/++pMeLH
 ardO7TuZty1W22I8gRmuHyXM9+Edun2k+CFmiYr2PM/16NprgZFGoaVSsHqN7LWVbB1z
 zK+ZSqIZ4NWlzp1XMvJn4JyktunXPtZd23vxCfS2sNcpVyhkQw30/LaqOv0lvmU1PWFZ
 WnNHmPsBzUcZ1Rk1CylPgS3WBbDBoRaFDUyTZ8OHZk1CoZsWBy4JO9LCIMYTXJkIuAMj
 W5XnJ6oOwuX4ULIKj1I6H9VmNvW9GrYmimAjPevTP8AAIUx2TQyVEUuhtYVftgtCGq8x
 IFng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcImcgTTUJdAabeCWLQ7hllE8OevI0UaAa8bsagy7VX3DjZU56jJyFdgYYYc6yKl4Q9hWuPcmTQPsv1gSfvuUYgWQMV58=
X-Gm-Message-State: AOJu0Yx9lIJlfeH9tU1/ykHUzIG9DzQUwbOcCXYgF0FpA9ldTTa52KhA
 RSn65h5TTSFEN9gvOrOXhyMa8pFo/S/K1o8YRJaV3nPxZ0zIX8KGPt7a4a2Vj8J5TwXyB8Ks/yE
 Qf2qXvCPxvTc3Rn24vwZhiKYQoCtyTL+ii23sA32VQ99IN9zt
X-Google-Smtp-Source: AGHT+IHH5uGCnGjdp8Fhl4sx+ur/9I6TRqBRD+5SS4wpFt62or/zAU/PUrPr6Sb9F0esV32qKHrpCyv9MYFKyNYxUW4=
X-Received: by 2002:a05:6512:2086:b0:512:a4ce:abb1 with SMTP id
 t6-20020a056512208600b00512a4ceabb1mr4313685lfr.32.1708966452447; Mon, 26 Feb
 2024 08:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-42-sergey.kambalin@auriga.com>
 <CAFEAcA_xdowvZkxFC7ypEFRJSTLDkdx+9E3_fwPNY=S2sK5=UA@mail.gmail.com>
 <CAFEAcA88NqshmyH5czz8ZC0Kbb81_-8VHRMCSQDbpHrPwm6AWA@mail.gmail.com>
 <37c4bf08-c3df-4311-9f3c-a4a5c9da215d@linaro.org>
In-Reply-To: <37c4bf08-c3df-4311-9f3c-a4a5c9da215d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:54:01 +0000
Message-ID: <CAFEAcA-9YO+6JvBwuaa4h+gnp2hQg6aHyv84KNxe9xdHhsWriA@mail.gmail.com>
Subject: Re: [PATCH v6 41/41] Add RPi4B to raspi.rst
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Mon, 26 Feb 2024 at 16:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 26/2/24 17:43, Peter Maydell wrote:
> > On Mon, 26 Feb 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> On Mon, 26 Feb 2024 at 00:03, Sergey Kambalin <serg.oker@gmail.com> wr=
ote:
> >>>
> >>> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> >>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >>> ---
> >>>   docs/system/arm/raspi.rst | 11 +++++++----
> >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
> >>> index d0a6f08b2b..c21b27744e 100644
> >>> --- a/docs/system/arm/raspi.rst
> >>> +++ b/docs/system/arm/raspi.rst
> >>> @@ -1,5 +1,5 @@
> >>> -Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3=
ap``, ``raspi3b``)
> >>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3=
ap``, ``raspi3b``, ``raspi4b-2g``)
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>>
> >>>
> >>>   QEMU provides models of the following Raspberry Pi boards:
> >>> @@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry P=
i boards:
> >>>     Cortex-A53 (4 cores), 512 MiB of RAM
> >>>   ``raspi3b``
> >>>     Cortex-A53 (4 cores), 1 GiB of RAM
> >>> -
> >>> +``raspi4b-2g``
> >>> +  Cortex-A72 (4 cores), 2 GiB of RAM
> >>>
> >>>   Implemented devices
> >>>   -------------------
> >>>
> >>> - * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
> >>> + * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
> >>>    * Interrupt controller
> >>>    * DMA controller
> >>>    * Clock and reset controller (CPRMAN)
> >>> @@ -34,6 +35,8 @@ Implemented devices
> >>>    * MailBox controller (MBOX)
> >>>    * VideoCore firmware (property)
> >>>    * Peripheral SPI controller (SPI)
> >>> + * PCIE Root Port (raspi4b-2g)
> >>> + * GENET Ethernet Controller (raspi4b-2g)
> >>
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> For the "no PCI/no ethernet" initial version, I'll drop these last
> >> two lines; we can add them in when we land the pci and ethernet
> >> patches.
> >
> > ...better, I'll move them to "missing devices":
> >
> > --- a/docs/system/arm/raspi.rst
> > +++ b/docs/system/arm/raspi.rst
> > @@ -35,12 +35,11 @@ Implemented devices
> >    * MailBox controller (MBOX)
> >    * VideoCore firmware (property)
> >    * Peripheral SPI controller (SPI)
> > - * PCIE Root Port (raspi4b-2g)
> > - * GENET Ethernet Controller (raspi4b-2g)
>
> When we add them back, no need to precise "raspi4b-2g" IMO.

It is the name of the machine; unless you think we should call
the machine just 'raspi4b', it seems better to me to match it.

-- PMM

