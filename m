Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD091C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUT-00089E-KF; Fri, 08 Mar 2024 10:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ricUR-0007y9-9R; Fri, 08 Mar 2024 10:50:31 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ricUO-0004Yo-Pm; Fri, 08 Mar 2024 10:50:30 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dcc7f4717fso7894825ad.0; 
 Fri, 08 Mar 2024 07:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709913026; x=1710517826; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=23oOzcuTB1Gfk7Qn6xARYHnZuwpEyvIMScPizHFsYdE=;
 b=N0YXBTZXnVIsAnNeLsus9AAG/HeAOlx+EDgwrsyL2xCZhY8dDQMyDBWVUBoQTUPc8a
 9Nw32OY4ztY6ipHu5oy25cn2lpCJb6h4Ytkl2nAaQpuIRE0yp94hNDIRs32tEu3L9NMC
 XCLj589LjvLil7MI+zIQRGXIxMvcc4RCetDRs5yIWCPbu0hW2C3JTacc+udTss6nUKYZ
 SQsvgcU5eEcCrqmFRvGeizyMbBsWMxrQT+rcbHMoJm1fgZyDXy29zlzF8B/0mD1IRHyB
 3JI38/pxTdDvQzWSHxtLVFKx5wOJ+KpTjkxjX1ORLKYbzklTI69EtaJsC09qIBSqGo8L
 yCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913026; x=1710517826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23oOzcuTB1Gfk7Qn6xARYHnZuwpEyvIMScPizHFsYdE=;
 b=CNznFJBMe6Gy78qBM+dn9+MAgUKTBGWeaAemlbOJ0/zzEH9TKFXSGssm4eCrOH+tBd
 PLH+zuxGRxtVHoVZ1DmrRX0YFh6lZNvFYpD1IOhVciS/o5VGCYJzj17+47Wc5GTy+UKB
 OZhCY5ueVlsAeUNDWLAw7abBMjR2Z7r0azMS5hdyDWP59y62gy922LFsjYq8F7N06llI
 9GyfGIrUGyTtRTmhieahEHyAWuzrSaksaYyPiQ438XNecjO423kFepTN3Yc5wlda4KQo
 iCI4W5AEU7crp+/ZFnC+ie6U5fkgri3qay2xi0sSaZ6RfuvvqN7JmG0A45alynARxcu+
 FMvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYK4jCmwbQmoEDEcyf1UFvrRqwMZt2/c4jR4oStW4b8y60/DePGb2iBdTFEbR7ACKG85pD7O6NKFMS23OIsR/pr93r
X-Gm-Message-State: AOJu0YyOBh7KIBiK7ybQiE8H8ifUTNpypJM+uPQ5f1mnbVWefV6MRCmu
 5arT1DzcVOmrg2H2Vpf6So9r8ES8IHITSUKIjRtV26r4vFOHS3LE
X-Google-Smtp-Source: AGHT+IHalrECY7UAyk7uokIYRcz2OQHqxIaVOP9fz0RsWjLNZUEH8o1YKMfXdxMizt4wEV472nWRdg==
X-Received: by 2002:a17:902:d503:b0:1dd:1c6f:af57 with SMTP id
 b3-20020a170902d50300b001dd1c6faf57mr12971152plg.42.1709913026233; 
 Fri, 08 Mar 2024 07:50:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a170903110700b001dc9893b03bsm16356588plh.272.2024.03.08.07.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:25 -0800 (PST)
Date: Fri, 8 Mar 2024 07:50:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Message-ID: <d5dd9334-e25a-44f5-afc4-c01ea59c02be@roeck-us.net>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Mar 08, 2024 at 03:41:48PM +0000, Peter Maydell wrote:
> On Tue, 13 Feb 2024 at 15:36, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
> > > On Mon, 12 Feb 2024 at 14:36, Guenter Roeck <linux@roeck-us.net> wrote:
> > > > On 2/12/24 04:32, Peter Maydell wrote:
> > > > > The machines I have in mind are:
> > > > >
> > > > > PXA2xx machines:
> > > > >
> > > > > akita                Sharp SL-C1000 (Akita) PDA (PXA270)
> > > > > borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
> > > > > connex               Gumstix Connex (PXA255)
> > > > > mainstone            Mainstone II (PXA27x)
> > > > > spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
> > > > > terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
> > > > > tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
> > > > > verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
> > > > > z2                   Zipit Z2 (PXA27x)
> 
> > > > > OMAP1 machines:
> > > > >
> > > > > cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> > > > > sx1                  Siemens SX1 (OMAP310) V2
> > > > > sx1-v1               Siemens SX1 (OMAP310) V1
> 
> > > > > OMAP2 machines:
> > > > >
> > > > > n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> > > > > n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> 
> > > > > The one SA1110 machine:
> > > > >
> > > > > collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> 
> > I am copying Arnd, the OMAP1 Linux kernel maintainers, PXA2 maintainers,
> > and the Linux omap mailing list for input. Sorry for the noise for those
> > who don't care, but I think it is useful to have your voices heard.
> 
> Thanks to everybody for your input on this thread. My
> proposal is to drop from QEMU:
>  * all the PXA2xx machines
>  * all the OMAP2 machines
>  * the cheetah OMAP1 machine
> 
> leaving (at least for now) sx1, sx1-v1, collie.
> 
> Rationale:
>  * for QEMU dropping individual machines is much less beneficial
>    than if we can drop support for an entire SoC
>  * the OMAP2 QEMU code in particular is large, old and unmaintained,
>    and none of the OMAP2 kernel maintainers said they were using
>    QEMU in any of their testing/development
>  * although Guenter is currently booting test kernels on some
>    of the PXA2xx machines, nobody seemed to be using them as part
>    of their active kernel development and my impression from the
>    thread is that PXA is the closest of all these SoC families to
>    being dropped from the kernel soon
>  * nobody said they were using cheetah, so it's entirely
>    untested and quite probably broken
>  * on the other hand the OMAP1 sx1 model does seem to be being
>    used as part of kernel development, and there was interest
>    in keeping collie around
> 
> I'm going to mark these as deprecated for the QEMU 9.0 release,
> which by our deprecate-and-drop policy means they will be
> still present in 9.0 (due out in April) and 9.1 (August-ish),
> and removed in 9.2 (December).
> 
> I'm potentially open to persuasion if anybody thinks I'm
> being too drastic here; persuasion that came attached to
> a desire to help modernise the QEMU code for the relevant
> machines would be the most effective :-)
> 

sgtm

Guenter

