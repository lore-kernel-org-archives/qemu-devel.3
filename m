Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B53C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZuqP-00032t-Hw; Tue, 13 Feb 2024 10:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rZuqE-0002uN-I7; Tue, 13 Feb 2024 10:37:02 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rZuqC-0002tk-Ky; Tue, 13 Feb 2024 10:37:02 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-218642337c9so2881841fac.3; 
 Tue, 13 Feb 2024 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707838616; x=1708443416; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=RIY5JGQ893Swhqnl00DbijJIsjOgVQf2gvslS8q3HrA=;
 b=basTNekECNmNMM0QJ/aQXZ4eGFteAHb7vspSkqxyhg4l8knApHll9xlJcFag0VoTBc
 ia4UELZdUxXViOWJ37Sxfo0f5oUNO3I71oHhx5ebuV4hTY6IxB3LaaoSIQWcaNqWLZya
 PDZPP4vbeVA7Fj3ctabj3uJ7VzBq6QXI+Cps+EYVpKsenG9I8lWtCcGSTvqIJOf1C9/s
 gQiIsrjkqRyrgFrtypYml75wGi+AIWuMEFsSA/cEJkawb8oKccIsGap6PXAWDsYVv0Ft
 N3ZYLnJZrKCGM7mYq34a3p6pghRdTIiVpfJY7XCScV4c1DpUT7MUldjF/uVyzViKFJEo
 +0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707838616; x=1708443416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIY5JGQ893Swhqnl00DbijJIsjOgVQf2gvslS8q3HrA=;
 b=S6/0C2k2eTXIc+CNBcKRxYnlUb9RE7wXJzdg3uZQnYu0yco8U2qZcI3E7K9WOQXuqz
 4gCEdqmVoEClrk73r3Lhuxqo+vMQORNkmdEuN3gMIQIeMgorjwXA4/qyGq8dbaVbdr6q
 rITdkTvkBFxxu+hihMMed5SCWfvZMwMkT/cSEUSheOKBGJiTs21bVE90hZJovyoCYqEg
 etJxcNITGEQYoPE+eaw6Ey6OWZXuoJvLB58xjqoeewZxzDlRvxMRV9wKloaQZi4e+Od8
 xypA3l8Qt8bIJzH4fPkIMlDjnkyzsagJtG5sbN4q1+YJKV1/pzW4gKX3rknuKfgk6+qk
 LPtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3xgh7hGp699oypC/drobi9REUq8r7WTw36pzHDCIRywTM4/kL4tsHGDOEiaiJOvgoHpyv/IFbn1geHrPBP6v+wzv1
X-Gm-Message-State: AOJu0YzccRvTiiVrHJdNXUpxJrRj0A2Pj4eB/PjCoU4dDsgiZRI2s58g
 EFX13zbG6HiOLx/q5CmzBDE7RrTUPkxT/F2fbTqBthhXVYynfOuR
X-Google-Smtp-Source: AGHT+IFa+472yvNq5+GsuFasZU+/8Xjw3xwsIsqaMKno0kfqU0uXpdB27vhvMQ8GxhAhSB0VSh8WFA==
X-Received: by 2002:a05:6870:b69f:b0:218:d3dc:67de with SMTP id
 cy31-20020a056870b69f00b00218d3dc67demr13812437oab.22.1707838616535; 
 Tue, 13 Feb 2024 07:36:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU9ryLT/C6nC6ffPkb6CJ6bWj8Rbc+ORhMU16wQBSF+23rZMNwXjnzmgdqkTdESikJ5AjwYG439ngcITIMu6aWxH8D8eRCiKfOeeEVFoYWQ0mtqaRu56mW6zJQdBcgH61gDyLeHq4bYqBL03BEpzd19jmlTjOJmnpSYLsT3WoLyDf3CSnK1q+bbCM5KpilpAZ6JHPoVvdBZ4kfknyi8IhPFk7rO3aDA6blEn75vxGY5IubWcZ8G//jyShPg4Qfgb9K4ALMH3sR6ww/SYN5gLH1K3j0mT2YnsvjrjTAFeZt9a6RjkRJ2jnsSYSNPnvsXc/JIae7k3FCHGRgFyILb6JKz3zlxZRSzlu2DpWF6dWG3
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a632705000000b005dc36279d6dsm2560973pgn.73.2024.02.13.07.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:36:56 -0800 (PST)
Date: Tue, 13 Feb 2024 07:36:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Message-ID: <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=groeck7@gmail.com; helo=mail-oa1-x30.google.com
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

On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
> On Mon, 12 Feb 2024 at 14:36, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 2/12/24 04:32, Peter Maydell wrote:
> > > The machines I have in mind are:
> > >
> > > PXA2xx machines:
> > >
> > > akita                Sharp SL-C1000 (Akita) PDA (PXA270)
> > > borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
> > > connex               Gumstix Connex (PXA255)
> > > mainstone            Mainstone II (PXA27x)
> > > spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
> > > terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
> > > tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
> > > verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
> > > z2                   Zipit Z2 (PXA27x)
> > >
> > I test akita, borzoi, spitz, and terrier. Upstream Linux removed support
> > for mainstone, tosa, and z2 from the Linux kernel as of version 6.0, so
> > I am no longer testing those.
> >
> > I never managed to boot connex or verdex.
> >
> > > OMAP1 machines:
> > >
> > > cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> > > sx1                  Siemens SX1 (OMAP310) V2
> > > sx1-v1               Siemens SX1 (OMAP310) V1
> > >
> > I test sx1. I don't think I ever tried cheetah, and I could not get sx1-v1
> > to work.
> >
> > > OMAP2 machines:
> > >
> > > n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> > > n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> > >
> > I never managed to get those to boot the Linux kernel.
> >
> > > The one SA1110 machine:
> > >
> > > collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> > >
> > I do test collie.
> >
> > All the ones I use still boot the latest Linux kernel.
> >
> > > Obviously if we can remove all the machines that used a given
> > > SoC, that's much more effective than if we just delete one or two.
> > >
> > > I don't have any test images for the SA1110 or OMAP1 machines,
> > > so those are the ones I am most keen to be able to drop.
> > > I do have test images for a few of the pxa2xx and the OMAP2 machines.
> > >
> > I don't mind dropping them, just listing what I use for testing the
> > Linux kernel. I suspect I may be the only "user" of those boards,
> > though, both in Linux and qemu.
> 
> Mmm; there's not much point in both QEMU and the kernel
> maintaining code that nobody's using. Are you considering
> dropping support for any of these SoC families from the kernel?
> 
Not me personally. Arnd is the one mostly involved in dropping
support of obsolete hardware from the kernel.

> It sounds like between the two of us we do have at least one
> test image per SoC type if we do keep any of these, but
> if it isn't going to inconvenience kernel testing I'm
> inclined to go ahead with deprecate-and-drop for the whole lot.
> (With QEMU's deprecate-and-drop policy, that would be "announce
> deprecation now for 9.0, keep in 9.1, remove before 9.2 release
> at the end of the year".) At a minimum I would like to drop
> the OMAP1 and OMAP2 boards, as that's the biggest code burden.
> 

I am copying Arnd, the OMAP1 Linux kernel maintainers, PXA2 maintainers,
and the Linux omap mailing list for input. Sorry for the noise for those
who don't care, but I think it is useful to have your voices heard.

Personally I think it very unlikely that anyone is using the latest Linux
kernel on any of the affected machines, but I may be wrong.

Thanks,
Guenter

