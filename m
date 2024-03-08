Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC1EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricMH-0003om-4I; Fri, 08 Mar 2024 10:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricMF-0003oV-RH
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:42:04 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricMD-0002Mi-QU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:42:03 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so5990588a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709912520; x=1710517320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MuJCFhvqT3ZKlqVaY9a/O3yhRkZaw9B/8BBmGsdaLfI=;
 b=pCL8rl6r5IsO4H6RqgmZyPTd2veJp14/jZk+Y2cW5fHkLUdpxASccxdxUvE7cYaWVb
 JrJPdwQybghVhVfsswCCKPMwHmPAuUmSkTqS5UI/y6S1T4tHpDTgfeZ9FYjth0AGefva
 8P/pV2Kxuxr/cWKeRS11fwtCsyNS3+Jz9HnpmvQhUCBfzbBNGYbrDTbTt19TXLGpvNQQ
 YtxCjRRO3AOtcFa4awiiipQE80AyRlmuEFOuxM0fPTxFPdAsD4WCdiu5+r7MXD1kWLaA
 JnB7u7L6UzPJhjqmX1xLgpzOa8S6fKXCRXKdFJcwWJ0nqyjpps9UzkF4RUFf8WJaBylR
 roEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709912520; x=1710517320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MuJCFhvqT3ZKlqVaY9a/O3yhRkZaw9B/8BBmGsdaLfI=;
 b=onaj0/DAfQV8TjE6pEATge3vfOC4BOx3qhJwD0KRdsAm7NTerNMS0dY/ja30cHdKte
 cXJp31ILV2wUarwcCE6U5yo92/SNnFSGsewvo1jivXDYgArHT9uQQueDH6fq/qcKbv1l
 JQrZuUMmSmNFSikj8CbNYYA7Ay+o238oLxJBREBfCLB+ilddOhnPBHa+7qXp7Ce3B57w
 bOB/rYlcr9CtzZ0fzL6jOIWEw929CSmdVNRpnQVMUnmdMYu6kGN/kEB8mwmd67/QAazm
 m9h90WJUNuMz9fTMU4c3/7czjUyspn3erAbBJETEu7oJtXuhjsZSSk04Im23FSnZilta
 Sdxg==
X-Gm-Message-State: AOJu0Yz6K1N+XpjjSs+G5aed/5I6mJqt5w+B84cEo8AUxPJWSiYl0MDC
 JKRN1AS9l3gxFAiRLPLz2TKZruEmwWRKkDp3fMWIOiwepkpkbn66GY7DI25acqVfxH9krmrBs1f
 rHiy7qIM7gsEJjC2+ah1Rs8/TmnkO+8VZJnrjoQ==
X-Google-Smtp-Source: AGHT+IG2TebH+X8C70I+HEzlziFQiuRt9TuV9e/9a5ltxwwODUeTQlbvCO2831bYkGno2KtggkHpVeDVEgX+AX5HQ+s=
X-Received: by 2002:a50:9550:0:b0:565:9f59:b3b6 with SMTP id
 v16-20020a509550000000b005659f59b3b6mr674446eda.3.1709912519417; Fri, 08 Mar
 2024 07:41:59 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
In-Reply-To: <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 15:41:48 +0000
Message-ID: <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, 
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 13 Feb 2024 at 15:36, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
> > On Mon, 12 Feb 2024 at 14:36, Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 2/12/24 04:32, Peter Maydell wrote:
> > > > The machines I have in mind are:
> > > >
> > > > PXA2xx machines:
> > > >
> > > > akita                Sharp SL-C1000 (Akita) PDA (PXA270)
> > > > borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
> > > > connex               Gumstix Connex (PXA255)
> > > > mainstone            Mainstone II (PXA27x)
> > > > spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
> > > > terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
> > > > tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
> > > > verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
> > > > z2                   Zipit Z2 (PXA27x)

> > > > OMAP1 machines:
> > > >
> > > > cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> > > > sx1                  Siemens SX1 (OMAP310) V2
> > > > sx1-v1               Siemens SX1 (OMAP310) V1

> > > > OMAP2 machines:
> > > >
> > > > n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> > > > n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)

> > > > The one SA1110 machine:
> > > >
> > > > collie               Sharp SL-5500 (Collie) PDA (SA-1110)

> I am copying Arnd, the OMAP1 Linux kernel maintainers, PXA2 maintainers,
> and the Linux omap mailing list for input. Sorry for the noise for those
> who don't care, but I think it is useful to have your voices heard.

Thanks to everybody for your input on this thread. My
proposal is to drop from QEMU:
 * all the PXA2xx machines
 * all the OMAP2 machines
 * the cheetah OMAP1 machine

leaving (at least for now) sx1, sx1-v1, collie.

Rationale:
 * for QEMU dropping individual machines is much less beneficial
   than if we can drop support for an entire SoC
 * the OMAP2 QEMU code in particular is large, old and unmaintained,
   and none of the OMAP2 kernel maintainers said they were using
   QEMU in any of their testing/development
 * although Guenter is currently booting test kernels on some
   of the PXA2xx machines, nobody seemed to be using them as part
   of their active kernel development and my impression from the
   thread is that PXA is the closest of all these SoC families to
   being dropped from the kernel soon
 * nobody said they were using cheetah, so it's entirely
   untested and quite probably broken
 * on the other hand the OMAP1 sx1 model does seem to be being
   used as part of kernel development, and there was interest
   in keeping collie around

I'm going to mark these as deprecated for the QEMU 9.0 release,
which by our deprecate-and-drop policy means they will be
still present in 9.0 (due out in April) and 9.1 (August-ish),
and removed in 9.2 (December).

I'm potentially open to persuasion if anybody thinks I'm
being too drastic here; persuasion that came attached to
a desire to help modernise the QEMU code for the relevant
machines would be the most effective :-)

thanks
-- PMM

