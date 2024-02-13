Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600DCC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZuUb-0005rA-Lu; Tue, 13 Feb 2024 10:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZuUX-0005qm-Qf
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:14:38 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZuUW-0007IS-5G
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:14:37 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so7039502a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707837273; x=1708442073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F9lptCMXDd3pYbUTjObBYOXK1sjQJkuMrh6QD+KpXig=;
 b=ERP4e25uZm29wrGgFdV0Oyz+acvSZFP6SAZVli2w8vZk4dBJZcPwnCcXjTeEvDmSbv
 5NGzDXg0f210L/gnmQRRAJWG1E8sBnBi7Duf2CymtxqCjW9YXZ110788yHUvYlPcDVHc
 p74thGXyug6/2dfOG4MNSYXh/aSdONlOpD2MBOuJB/+6hzWKs6jqNWb0AX1hIa0dxwOQ
 5jLbp9MLhHWptHjpwsU7GDX+kp8pMxxnZQ0EsgnTFWkgY5QL50pMko7dvJVl2W4MVhHi
 7L2/umZdkiuEhZ66ESQsrT0SioZ7FgSGuTnMGCNCj4ape29WyT7Y4X1Ci1Jv6A9EeMdl
 4t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707837273; x=1708442073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9lptCMXDd3pYbUTjObBYOXK1sjQJkuMrh6QD+KpXig=;
 b=mCsYAscEFHPek//Qxuy3xhliLDrUPIaFq77vfWCG0GS2T16+qc68ZllGNx4OElgeQh
 S6Csn4v7G5tYtKavpKfB8qDT61k2oVUY6p8Ag3DpMy210DLwG27VZ8Z2jcgXs4GqinYi
 gBf9fiCror7bQR3LHuTNGvBgiHsiUKsniFdxHnMaa1j+vEOZE/I4RXvsvDgnK4ndAqK+
 AI/cQsyEP2+VYN4kR11Ui8JlC1/rA3dbClB/ZJmMO662dGbztA/hiDBYKAzl02mRAXde
 kGWwQ6MIo4oye0WDMz2IqOoPWT0Rd/KZkPQBcYxuiGh7V7m9E98kM7BISC+5CNvX48Wu
 MZBw==
X-Gm-Message-State: AOJu0Yyf6QHg8MvcVtrExiujf9UCtF6CdefHAKB2YovsFnC07Cf8wmme
 K/Uk+wc5F8V7Le2aYYw/YzLwX0B/0KwiG/Kn1fORLBDaukvrSSr7cWCGD1mApvp9gODOAEvK9Ic
 +6t5EJoor0U5s8L1MAVjzW7kuU9V7kZWGyzADrw==
X-Google-Smtp-Source: AGHT+IFybEnczV1XUThqsidCxcgloRSZMWR1NJq5/oSpXitTssUUN39TA/ksCkt6KeDlKOdimVayLZNW7EhQ47oyJMs=
X-Received: by 2002:aa7:c415:0:b0:55f:e147:2524 with SMTP id
 j21-20020aa7c415000000b0055fe1472524mr6657153edq.38.1707837272905; Tue, 13
 Feb 2024 07:14:32 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
In-Reply-To: <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2024 15:14:21 +0000
Message-ID: <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 12 Feb 2024 at 14:36, Guenter Roeck <linux@roeck-us.net> wrote:
> On 2/12/24 04:32, Peter Maydell wrote:
> > The machines I have in mind are:
> >
> > PXA2xx machines:
> >
> > akita                Sharp SL-C1000 (Akita) PDA (PXA270)
> > borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
> > connex               Gumstix Connex (PXA255)
> > mainstone            Mainstone II (PXA27x)
> > spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
> > terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
> > tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
> > verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
> > z2                   Zipit Z2 (PXA27x)
> >
> I test akita, borzoi, spitz, and terrier. Upstream Linux removed support
> for mainstone, tosa, and z2 from the Linux kernel as of version 6.0, so
> I am no longer testing those.
>
> I never managed to boot connex or verdex.
>
> > OMAP1 machines:
> >
> > cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> > sx1                  Siemens SX1 (OMAP310) V2
> > sx1-v1               Siemens SX1 (OMAP310) V1
> >
> I test sx1. I don't think I ever tried cheetah, and I could not get sx1-v1
> to work.
>
> > OMAP2 machines:
> >
> > n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> > n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> >
> I never managed to get those to boot the Linux kernel.
>
> > The one SA1110 machine:
> >
> > collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> >
> I do test collie.
>
> All the ones I use still boot the latest Linux kernel.
>
> > Obviously if we can remove all the machines that used a given
> > SoC, that's much more effective than if we just delete one or two.
> >
> > I don't have any test images for the SA1110 or OMAP1 machines,
> > so those are the ones I am most keen to be able to drop.
> > I do have test images for a few of the pxa2xx and the OMAP2 machines.
> >
> I don't mind dropping them, just listing what I use for testing the
> Linux kernel. I suspect I may be the only "user" of those boards,
> though, both in Linux and qemu.

Mmm; there's not much point in both QEMU and the kernel
maintaining code that nobody's using. Are you considering
dropping support for any of these SoC families from the kernel?

It sounds like between the two of us we do have at least one
test image per SoC type if we do keep any of these, but
if it isn't going to inconvenience kernel testing I'm
inclined to go ahead with deprecate-and-drop for the whole lot.
(With QEMU's deprecate-and-drop policy, that would be "announce
deprecation now for 9.0, keep in 9.1, remove before 9.2 release
at the end of the year".) At a minimum I would like to drop
the OMAP1 and OMAP2 boards, as that's the biggest code burden.

thanks
-- PMM

