Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A4FC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfkX-0002VI-9d; Mon, 24 Jun 2024 05:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1sLfkV-0002Jx-KQ; Mon, 24 Jun 2024 05:12:31 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1sLfkT-000429-L7; Mon, 24 Jun 2024 05:12:31 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f9b213ebf9so1639906a34.1; 
 Mon, 24 Jun 2024 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719220346; x=1719825146; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQmGJCx2a/QLm1eOxOqwGqqV3/kxCAgqSMcL+my6qVo=;
 b=QRnMNK621DHzfV1AVpEx/PvSQysO8NSrX+RfsJgjwaKoe3vi2eJcn/fjrABwK+1YdQ
 nEcBj5ee81+BK9+eT2HPki+okrFsyTRqvqoKEirI6UdcUUPTT+eq3B2uR/V3TmpSxgLM
 ubC113rRwYHWcgfz1s2e5TS4bLnNxiZJ4GmTbXdTY2a35jEm2F+RmOXCehI3YdwvuSQV
 ipDUWoSHAtr8iy5Jgi0I19y3rX2ofcsP6li/xln5NoPQiVUrexdAkFmv6DHxhbD9uEpn
 bbqIY9rGAOU5VRtrgY7+sG1t+Yzc5RoxO4f613M02U0Yb1/j8uAawS6UG6Ob0Yt1iT7c
 BewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719220346; x=1719825146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQmGJCx2a/QLm1eOxOqwGqqV3/kxCAgqSMcL+my6qVo=;
 b=ldHMmoVEm+M4Obji+Cw5URotGldr8tAmkICnj7ZZYm5DFM8cKZ84nYbt3nycc2Xuyn
 8Dq9boeFtBLLemUWvFgzPwAL3zRU0vVMrw/LNwqzfHCj6X8VRlkCaJQvblQiOZ1j+K3l
 CeZehRcUrVTyoNX9iAwT9yaHPkWXTLKHWbs8/e2na/8s4VTLNuP3W9ELm0iZZqJ28tGD
 DIDIrQvukx6vCQJLbY70OmdEMC4FPu2KxRQN4lKKxF+0uBc3KTXZodwgM5bY7GqdH8Ya
 NKtLA39b1tnJiOAfefoCwVj+zV0O+00u0mXg1zR/UK8oQcTpT9JS0pcPb5vblJvhWRvd
 /KhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG314ktbal09OnPUenvGyZ7X0VO/FOktgvKNBGzYW5ACoUvnZUWkiz1lLwVsMJynXTaLk8XhnAccA0XAfGxbYUEDLv
X-Gm-Message-State: AOJu0Yws4l9etAiKfe59TyxjyZgrmaYRxs3tT+s5+sfMu0805nE4XQY9
 ZENb44tjbIYuKp6TgkF1SXd1NUABnja+PGazEVWaHNwrR7CjfOkth1i/TuBtNfCt/bFFcRlceZ4
 8ez5leqF/5qec9yFitY/eRFErnp8=
X-Google-Smtp-Source: AGHT+IHfRJJDHbk7PXLG+NWy8LdtH2ITw55i6iAw7mwl92PzQUEmIoCIXkWVM1T6vPLWCMnKyXY/LTEXW9LrdEVlOUo=
X-Received: by 2002:a9d:6e04:0:b0:700:b405:dac2 with SMTP id
 46e09a7af769-700b405dbe4mr1258600a34.35.1719220346045; Mon, 24 Jun 2024
 02:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
 <CAFEAcA_zBhe+HxOqtAzWSCbzApEhknr+NeheA1uLj641EXMM5w@mail.gmail.com>
In-Reply-To: <CAFEAcA_zBhe+HxOqtAzWSCbzApEhknr+NeheA1uLj641EXMM5w@mail.gmail.com>
From: Rayhan Faizel <rayhan.faizel@gmail.com>
Date: Mon, 24 Jun 2024 14:42:14 +0530
Message-ID: <CAKUh+QfrT3SjxHA0Y5fERwnTnqKKbJg9SFb=5J5pfbci0asjLQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Initial support for One-Time Programmable Memory
 (OTP) in BCM2835
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

The patch series is still not merged.

On Thu, May 30, 2024 at 6:57=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sun, 19 May 2024 at 10:42, Rayhan Faizel <rayhan.faizel@gmail.com> wro=
te:
> >
> > All BCM2835 boards have on-board OTP memory with 66 32-bit rows. Usuall=
y,
> > its contents are accessible via mailbox commands.
> >
> > [Changes in v3]
> >
> > - Forgot to replace constant with macro in one particular spot.
> >
> > [Changes in v2]
> >
> > - Replace read/write with get/set in bcm2835_otp.c.
> > - Use impl instead of valid in bcm2835_otp.c.
> > - Replace all constant values with macros defined in bcm2835_otp.h.
> > - Change memory region size of OTP device to 0x80.
> > - After further testing on a real Raspberry Pi 3, I noticed a few thing=
s
> > contrary to my initial assumptions:
> > -- The customer OTP lock bit is bit 6 of row 32, NOT bit 30 of row 30. =
This is
> > currently undocumented to my knowledge.
> > -- The above lock indeed applies to the private key as well.
> >
> > Rayhan Faizel (3):
> >   hw/nvram: Add BCM2835 OTP device
> >   hw/arm: Connect OTP device to BCM2835
> >   hw/misc: Implement mailbox properties for customer OTP and device
> >     specific private keys
>
>
>
> Applied to target-arm.next, thanks.
>
> -- PMM
--=20
Rayhan Faizel

