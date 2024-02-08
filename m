Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E22C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 17:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7nO-0006Dq-Nm; Thu, 08 Feb 2024 12:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7nM-0006Bp-VH
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 12:02:41 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7nJ-0002WT-Qi
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 12:02:40 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55ff5f6a610so108534a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707411755; x=1708016555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oz9YJ0k5/LxPewQzp/IOnMItidEE4Xau/bFwmErfle8=;
 b=amo1GPFXKrSaBAP0iNSnSTlYs3+Coyz6otWBqRr6Yi2f4zeW5iZt8Nek2tSkiGAc2H
 +uZ8HaNTR8ShAt5SRYw2vZypFMriwQRdXZb40Nj/cRtoPrUTzkDFKqzqTxMX3Vzb9JqC
 27kvd36txgi97m5J5frJJksucuFpcCB2gUSQC9bmTsEH4lVsmc/Uuawi9gr10OGZOB16
 6zYGjWFizcE+C62a8osRwB4LhCTHjVtpjdTmVIWEm1vB+nRZMTl/jpLSeqKYr36yslho
 UlchxnBFOEtHtQ93m7dYRM0b6467I9DwuACgK31WvoCazVJPXd6L49h2F0itdShgd47p
 DzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707411755; x=1708016555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oz9YJ0k5/LxPewQzp/IOnMItidEE4Xau/bFwmErfle8=;
 b=Bbh2Y2K8xofLO1J8NThY20aKQLZ9q5ZD+quBuIW84voUH55J7lKf32WIz6g/bZu9gu
 RflsIKntMWZ0v/U/sU9y+2TFWzulLg0xOvljfzchJvEzlVpbInnldR3hqH8Ge1qm9deQ
 VISbIlmzJiCRgnIQrcyItMlwimo5SV9UoLvjyHS1nDSYzED0GHZU0wxXzTT2o5yhqcFT
 361qYzX1rsPU0VWYOMfgH5e3YeOpkOt3DqNrLduRQQRKtdwrxKEFefQEfvbN1Ck7+2jc
 UiMi8T7RZ7SXj1biTDgfa6jmyqVtaSkIVRBWMlqK9jcPqX69ZkLxaFcESCDS+Joqpmt3
 YBIQ==
X-Gm-Message-State: AOJu0YziLIGlDKpcs+OXaKkeIbSuF1prbpISs0J7YgLalAo3ADGJ8FL9
 n+XTJKmHwD0BUEwmb5AMV8eYuc2FLktrKhKHO15QmFeT7ac1JzxwB2ZN3r8dN5UmB/OEN4gLakS
 o+oJ4IRSHtKFt0i6LKDc7fr37W5iHW8/iYVVUPQ==
X-Google-Smtp-Source: AGHT+IEetygD5Lit9KtI5tnHx+HNFY0qh8sSIRyIm7df209S89B3zNJAI6WV/j8AFB9qbJd+4pAWL+F9u+wF0kaC13I=
X-Received: by 2002:aa7:d902:0:b0:55f:f500:35ee with SMTP id
 a2-20020aa7d902000000b0055ff50035eemr6374859edr.40.1707411755113; Thu, 08 Feb
 2024 09:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-9-peter.maydell@linaro.org>
 <b8fbf313-1b24-4cf3-b5c1-f9289b413a75@linaro.org>
In-Reply-To: <b8fbf313-1b24-4cf3-b5c1-f9289b413a75@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 17:02:23 +0000
Message-ID: <CAFEAcA8UqeGKf8pP90i6Jn=AYgqtzFw141ptir=5BEZtpwjD2Q@mail.gmail.com>
Subject: Re: [PATCH 08/13] hw/arm/mps3r: Initial skeleton for mps3-an536 board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 7 Feb 2024 at 09:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
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
> > +/*
> > + * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
> > + * emulation of that much guest RAM, so artificially make it smaller.
> > + */
> > +#if HOST_LONG_BITS =3D=3D 32
> > +#define MPS3_DDR_SIZE (1 * GiB)
> > +#else
> > +#define MPS3_DDR_SIZE (3 * GiB)
> > +#endif
>
> Generically, can we migrate a VM started on a 32-bit host to a 64-bit
> one?

I think it's one of those things that in theory is supposed
to be possible and in practice nobody tests so it might well
not work. At any rate, this is the same thing we do already
in mps2-tz.c for the 2GB DRAM those boards have.

> > +static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
> > +{
> > +    /*
> > +     * Set mc->default_ram_size and default_ram_id from the
> > +     * information in mmc->raminfo.
> > +     */
> > +    MachineClass *mc =3D MACHINE_CLASS(mmc);
> > +    const RAMInfo *p;
> > +
> > +    for (p =3D mmc->raminfo; p->name; p++) {
> > +        if (p->mrindex < 0) {
> > +            /* Found the entry for "system memory" */
> > +            mc->default_ram_size =3D p->size;
> > +            mc->default_ram_id =3D p->name;
>
> Nice.
>
> > +            return;
> > +        }
> > +    }
> > +    g_assert_not_reached();
> > +}
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks.

I have remembered why we don't pass the MachineState as the
owner pointer for memory_region_init_ram(): in that function
we do a cast of the owner pointer to a DeviceState, so we
can hand it to vmstate_register_ram(). And a MachineState
inherits directly from Object, not from DeviceState.
There's a paragraph in the doc-comment for
memory_region_init_ram() explaining this: currently we
require the owner pointer to be either NULL or a DeviceState.

thanks
-- PMM

