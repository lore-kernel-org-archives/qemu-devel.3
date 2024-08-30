Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8316ACA0EEC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 08:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjwdL-00021R-V1; Fri, 30 Aug 2024 04:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sjwdL-00020Y-8s; Fri, 30 Aug 2024 04:05:27 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sjwdJ-0001Rg-Cg; Fri, 30 Aug 2024 04:05:27 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5353cd2fa28so1939943e87.3; 
 Fri, 30 Aug 2024 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725005123; x=1725609923; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MC7aFzaY1FZaEi2O4l4eCXSkJoXGvCzyVJYM3mZE2S0=;
 b=It8HHJHLWH5jW1F1LCnbfkyXuSNDWGx/Vf8g/sVHgaKN3+gNEuqvR5eq/GIkdnOXo5
 91mTxIme/FeDzBEKkc+4yrovyyGkSeFbn64fLUmETzaWX5zmIcE8AZhvcDuEsxvfhpYn
 zCk06r40v/3MJuTfCG5Tg2H+++yzWs329QoTJm4WwU4PDXJHZGS35DROGgSQV76ubqjI
 urxpkorCOWk/rKMmQhS3zqoTlblWPjbvfui3JEd218ialQxi0AEQoEDpMWggExc5Zrlb
 4CdsNs2KZo5KHP2Zs0U3V8SKsU7qtEviVC38CycvvFhw21+EWxk9WTh8GRxqpwL8eZGx
 2zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725005123; x=1725609923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MC7aFzaY1FZaEi2O4l4eCXSkJoXGvCzyVJYM3mZE2S0=;
 b=jjhJj0h2qMZ9Wrb9ss1aLkMnhHzfNogSiNhQmtwH3gbJ+cUAUZ+Chzavgn4dGOZ4Ag
 3gzNwlvQNefaybdRzTPujdR0uwfcIlrI6rCqrjCp0Qs2HCenaGx9BZipx69TflRZEyJg
 pT+DScfHVORJ9ys5lYr9X2XxjxDnyS3Q6IspbMpAhTiDwzSWrKP56Y6ak9oe1jIdHTS4
 n2UzaCilsm6+9QGybAP6wOFudNrVJm8IuoaJQAgjmeIyd9rsthY/WQlT2DyRrMauztTL
 oo7z/MMMYhQVseClzpwRU4LimXXwkxtae/UgJusUFoGDDoqw18EHwYoQqLIbLArPDUUC
 d+Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk2Ii/+VPs1oxekI13BbJgV0xrrhOLD8zd5UD8AybLGsvvh/p+b40wJExJhfSfH83dlwAprqDzq2ARBw==@nongnu.org,
 AJvYcCXissrGKWJbUSOlSnwpPf6RdGVgfiuqwmYvG2ski0RZLB+6E3PzMKwIFMjsvFh3WdAxtzz/1kEqlA==@nongnu.org
X-Gm-Message-State: AOJu0Yx6wYmvEruYtzbRy0idY/Dnn4Y6uYFd6pj7gE5CyKK2yw+BhuED
 cmVG3xErokE1ZeraR8aZ0w/KA6pTVmR7hK1jqXEba3TynnWnv1rZ
X-Google-Smtp-Source: AGHT+IHw90eSNuHVIV7FmKSoQVDshPPnIysG/chwVnt/h0rUnsSVy4wE8Uruh/8WwcyJGN77KmU/wg==
X-Received: by 2002:a05:6512:3b0b:b0:530:aa82:a50a with SMTP id
 2adb3069b0e04-53546ba0471mr890486e87.45.1725005122066; 
 Fri, 30 Aug 2024 01:05:22 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-535408412a0sm479985e87.192.2024.08.30.01.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 01:05:20 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:05:19 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sebastian Huber <sebastian.huber@embedded-brains.de>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Enable Security Extensions
Message-ID: <ZtF9P_QtnH1nAYuu@zapote>
References: <20240828005019.57705-1-sebastian.huber@embedded-brains.de>
 <CAFEAcA-p+CBeKTgH-YXzrATKDpwG5iY+A3WGaVkbEeHCXxTzug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-p+CBeKTgH-YXzrATKDpwG5iY+A3WGaVkbEeHCXxTzug@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
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

On Thu, Aug 29, 2024 at 01:50:02PM +0100, Peter Maydell wrote:
> On Wed, 28 Aug 2024 at 01:51, Sebastian Huber
> <sebastian.huber@embedded-brains.de> wrote:
> >
> > The system supports the Security Extensions (core and GIC).  This change is
> > necessary to run tests which pass on the real hardware.
> >
> > Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> 
> (Added the maintainers to cc.)
> 
> Does the system have any secure-only devices, RAM, etc?

Yes, on real HW there are but I don't think we've modelled any of it yet.
There's TZ both on the SoC and also ability to create FPGA logic that
can issue secure/non-secure transactions. Here's an overview:
https://docs.amd.com/v/u/en-US/ug1019-zynq-trustzone

The primary use-case for the upstream Zynq-7000 QEMU models has historically
been to run the Open Source SW stack from Linux (some times from u-boot)
and up. It's important that we don't break that.

So as long as we add additional support without breaking direct Linux
boots, I think it's OK to incrementally enable missing pieces even
if there's not yet coherent support for firmware boot.

In this case, IIUC, when doing direct Linux boot, TYPE_ARM_LINUX_BOOT_IF
will take care of the GIC setup for us.

> 
> How much testing have you done with this change? (The main
> reason we disabled has-el3 on this board back in 2014 was
> as a backwards-compatibility thing when we added EL3 support
> to the CPU model -- we didn't have a ton of images for the
> board so we erred on the safe side of not changing the
> behaviour to avoid potentially breaking existing guest code.)


I tried this patch on a couple of my images and it works fine for me!

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> 
> > ---
> >  hw/arm/xilinx_zynq.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> > index 3c56b9abe1..37c234f5ab 100644
> > --- a/hw/arm/xilinx_zynq.c
> > +++ b/hw/arm/xilinx_zynq.c
> > @@ -219,14 +219,6 @@ static void zynq_init(MachineState *machine)
> >      for (n = 0; n < smp_cpus; n++) {
> >          Object *cpuobj = object_new(machine->cpu_type);
> >
> > -        /*
> > -         * By default A9 CPUs have EL3 enabled.  This board does not currently
> > -         * support EL3 so the CPU EL3 property is disabled before realization.
> > -         */
> > -        if (object_property_find(cpuobj, "has_el3")) {
> > -            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
> > -        }
> > -
> >          object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
> >                                  &error_fatal);
> >          object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
> 
> thanks
> -- PMM

