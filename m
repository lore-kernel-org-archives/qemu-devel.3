Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BA4C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9487-0001iU-Pb; Mon, 20 May 2024 10:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s947z-0001by-W8
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:36:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s947x-0007hC-Re
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:36:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so2374652a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716215796; x=1716820596; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmtG5oN62yyAmZnv258bmJDRpCA4+HfX3KYlwsEc8SM=;
 b=nl/uQtjYnLeEnJUHNpB5BJ/03Gnq05uwS2rNC2O/W/bEwad1j54Zb1hcVFua5FYRxu
 OAyTvC+rLSGbhOKo22BaghNfkOfFjYAqn/PlVzsoZ4rQDuCom262CHE+llC9TmKe4fHj
 ebKxTHYu+MD4h5CU8F5DVY2RZ5d8i3LlfB4vAOXs1po+wMQbE3IZsifSPhUnj+iJJlFI
 cUbcbOc0JeqAd+cpTYhGE/78NgNeg4chmfMZqjQ5jOf5HwQC3HoUQEi2YOOsyfm6hdNK
 b8OD3sLWZgocbephUPDLAeXsPyj2kuYZmDNnkaGMEIXrREb6P9YYvitCgVnveG1N2uzc
 ibNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716215796; x=1716820596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmtG5oN62yyAmZnv258bmJDRpCA4+HfX3KYlwsEc8SM=;
 b=ifAAv6PEfF8j+DRCcxYuz8I+CRJttNUS3BHC3p1k8s5fsb1pC6TbVpmrFcH/lXQYJI
 9aaeJd2SbZiAIcIJTH20a5rFQpb/N4sqnyfrPeXBFIvOjzorGcfxcIl+sY/3B6ectx1C
 y1v+ngB7GDiLucnYd3li8hoTgvtXxnsVbNtlg72Ej/QahfAAcyLl303TS+gU2aSctOHo
 Y2BX6glHqz+ve7e3aamwQGKS9ImTgmS9RdNi5O9D/qoqvWn1sztRAuZUBNuU7KRs2MDj
 hujnofbnfK8iDob+mKj/x8XF5PXVC3RYHduaY8cpAHJPAw/4yXZviDKels0r7pMIFK3o
 0pFg==
X-Gm-Message-State: AOJu0Yy/DAQx0lR5i/y4FyOJIyU4VBqYPvs2yCrEKetRUmx6QEues5G6
 3Be1eu2eOr15VF23dNFHtQF8VwCfNIw7ExI3A0yE6qrxFHRow5bbS/MGXBmx8aFoMfHbh0dm7+7
 6ZNWJb2PiKIRGyo2gbR4BlxbLTtNDcECgnIIi+g==
X-Google-Smtp-Source: AGHT+IF96pZJU1sqgtTLzYOUVh+RXVgdTkc0H8l+m3R0yuwzkMD1r4P+15NvXDDJEGiPA6KGq7p1DCe+RNBIosKbnHY=
X-Received: by 2002:a50:ab59:0:b0:572:a711:3daf with SMTP id
 4fb4d7f45d1cf-5734d7047damr17408817a12.40.1716215796122; Mon, 20 May 2024
 07:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 15:36:24 +0100
Message-ID: <CAFEAcA8=vnpPU7bXmd89PSXOB31aEp+RP41BrM1N2kY=nhc8fw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Check clock connection between STM32L4x5 RCC and
 peripherals
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 7 May 2024 at 19:59, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> Among implemented STM32L4x5 devices, USART, GPIO and SYSCFG
> have a clock source, but none has a corresponding test in QEMU.
>
> This patch makes sure that all 3 devices create a clock,
> have a QOM property to access the clock frequency,
> and adds QTests checking that clock enable in RCC has the
> expected results.
>
> Philippe Mathieu-Daud=C3=A9 suggested the following :
> ".. We could add the clock properties
> directly in qdev_init_clock_in(). Seems useful for the QTest
> framework."
>
> However Peter Maydell pointed out the following :
> "...Mostly "frequency" properties on devices are for the case
> where they *don't* have a Clock input and instead have
> ad-hoc legacy handling where the board/SoC that creates the
> device sets an integer property to define the input frequency
> because it doesn't model the clock tree with Clock objects."
>
> You both agree on the fact that replicating the code in the
> different devices is a bad idea, what should be the
> alternative?

I think we should use the approach discussed in the review
comments on Philippe's patch
https://patchew.org/QEMU/20240508141333.44610-1-philmd@linaro.org/
where if we're running a qtest then the core clock code creates a
QOM property which is the clock period; the test code can then use
that.

thanks
-- PMM

