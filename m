Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46444C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSVZ-0001yR-N5; Tue, 06 Feb 2024 15:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSVX-0001y2-Fp
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:57:31 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSVT-0003Hw-D6
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:57:28 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so7409263a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 12:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707253045; x=1707857845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oti15MZcmQCWD+rFQFQJSFO3YDk8c1U5K9ovgby+r0Y=;
 b=tFdpC3kCpOebMWERzqHlCHKSIypX2pStx8ZA/4mvEJiqVcwc5k2EUN/83/w/pNGlXs
 MvL/lwJhPgWE7lT7LcLHycOh9UNQqo4UE2Cr5X++LHpfQR2hWEu70yJrSZSM1fmsQatf
 906gKsaD6XwM+bDql7qVJKeFnGdNgiYMaAFBgQj/1/KbfiNeCqCiXJpDIu2kUlBddLS7
 Nrvk3gu+xO/lSOJd27i+g2DGB6ylcstdpjVKrIwNvljlYQBbrhve4dT9gIJpPrc7Dc0C
 qRjnuNDebFQFIs7bkiQZ51dnCeX5svL2pp5Zz8EYrrW2JYGPjG6nrxAoQfjNQUPVVXBh
 6y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707253045; x=1707857845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oti15MZcmQCWD+rFQFQJSFO3YDk8c1U5K9ovgby+r0Y=;
 b=jxvtqXtx/M3cU1w33Do5Fqj6iept88omWenq1ZIhOOr1MKHV7ZK7xEoxYSwGUzG2wf
 QfJ+/LtkepdMgEQWzDj1QH7abMDTfKy5eyQg+y7jzw9aRMe1a7w7eGNbd6rJ+jsVbz2n
 z3Oo0YLPOCT+Ttc7EyDIM+1otiki0d780cGdwHHoKmJJFX87i61zVApsR0Io1IQjyIQ4
 ajBQ27/gH0CCddiQKblhp6Vx2lls3PhkTeeZip79bVd3PtVouNdlQoQEs9zxcTmwGZXS
 qzQEYFx6K1J6lTgJWXkhl1H2nNkOFmK6s+fuV8nAoGzFYAPvtGSFJ9pqmLgY5bo5hszx
 9GDA==
X-Gm-Message-State: AOJu0YyoiqxdL3+gkFaV6D4LF0Leb0yQOw7iLcEmyqQw5+nYWcinNp6c
 z04t3e3beXkpC0P7zb8gioBQkI3QiIpcX9j3YMevCrvQOVQ1T6BZilbwBTw22CVmkR1YZdm6rED
 KMiPZ3AsNxh12sOR36kj6B2nj3ZD6NH9EGqkuOQ==
X-Google-Smtp-Source: AGHT+IH6NuoAvy+aGhHm8R1am4xCyyK++F6wjfxZIEaMgkinx9agD5ai5ArqYz5+vVq35GvKynsnDrf0ap+FQ4R/Kjw=
X-Received: by 2002:a50:fb0b:0:b0:55f:ff7b:3a00 with SMTP id
 d11-20020a50fb0b000000b0055fff7b3a00mr2454639edq.8.1707253045446; Tue, 06 Feb
 2024 12:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-9-peter.maydell@linaro.org>
 <30da5b3b-6b4c-4639-b630-c02e1664821c@linaro.org>
In-Reply-To: <30da5b3b-6b4c-4639-b630-c02e1664821c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 20:57:14 +0000
Message-ID: <CAFEAcA9dh1i_kDO38kod_7X-qE1N5rNvMn2a45D4ar39TWbMrg@mail.gmail.com>
Subject: Re: [PATCH 08/13] hw/arm/mps3r: Initial skeleton for mps3-an536 board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 6 Feb 2024 at 19:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Peter,
>
> On 6/2/24 14:29, Peter Maydell wrote:
> > The AN536 is another FPGA image for the MPS3 development board. Unlike
> > the existing FPGA images we already model, this board uses a Cortex-R
> > family CPU, and it does not use any equivalent to the M-profile
> > "Subsystem for Embedded" SoC-equivalent that we model in hw/arm/armsse.=
c.
> > It's therefore more convenient for us to model it as a completely
> > separate C file.
> >
> > This commit adds the basic skeleton of the board model, and the
> > code to create all the RAM and ROM. We assume that we're probably
> > going to want to add more images in future, so use the same
> > base class/subclass setup that mps2-tz.c uses, even though at
> > the moment there's only a single subclass.
> >
> > Following commits will add the CPUs and the peripherals.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   MAINTAINERS                             |   3 +-
> >   configs/devices/arm-softmmu/default.mak |   1 +
> >   hw/arm/mps3r.c                          | 239 +++++++++++++++++++++++=
+
> >   hw/arm/Kconfig                          |   5 +
> >   hw/arm/meson.build                      |   1 +
> >   5 files changed, 248 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/arm/mps3r.c
>
>
> > +static MemoryRegion *mr_for_raminfo(MPS3RMachineState *mms,
> > +                                    const RAMInfo *raminfo)
> > +{
> > +    /* Return an initialized MemoryRegion for the RAMInfo. */
> > +    MemoryRegion *ram;
> > +
> > +    if (raminfo->mrindex < 0) {
> > +        /* Means this RAMInfo is for QEMU's "system memory" */
> > +        MachineState *machine =3D MACHINE(mms);
> > +        assert(!(raminfo->flags & IS_ROM));
> > +        return machine->ram;
> > +    }
> > +
> > +    assert(raminfo->mrindex < MPS3R_RAM_MAX);
> > +    ram =3D &mms->ram[raminfo->mrindex];
> > +
> > +    memory_region_init_ram(ram, NULL, raminfo->name,
>
> You are not using the parent=3Dmms, is that deliberate?
> (as in: easier to migrate eventually?)

No, I didn't have a particular reason for not setting the parent;
I just copied this bit of code from mps2-tz.c, which also doesn't
set the parent pointer...

-- PMM

