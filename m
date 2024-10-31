Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A3AE68974
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 11:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6TKD-0001N6-4U; Thu, 31 Oct 2024 07:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6TK8-0001Mk-Cf
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:26:44 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6TK4-0005aU-VQ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:26:43 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a5f555cfbso54477066b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730373998; x=1730978798; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JWnVP/zKgV5anlLtKlKjpjtCQBPMoRPfku0Dgugsdn0=;
 b=RM+FZt72V86rkkOgYHYtsn6QaRvTjvj6t0uYfopHjDOvbVRYP96NqAGv5advvccRic
 1EVGLL8cTKNiCp6x4/XuyVFb12ubT1ZdAiOgAqoS2lGbhsd9VMYAIrRb2JEn4Fn3AZln
 p1hF0vNtQX7YsXCY2QxZzK1E7muAJ8Ib1PSvcumwxNCgm3Jo7LkTmPNGcgubOopFB5pp
 IWZWKrSMgbS0BcpWevjn1/Zi1fz+dTQGCfhiA3vd6e9p9VlrlR9GDV+CBK6WtKhhBL5v
 6kyRctHq5PGjQB/3+SPJ7Vww9FI4iWOwJruzavdfSC+6b3qvVopdGUuZuWUhqrM3+VuC
 oTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730373998; x=1730978798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWnVP/zKgV5anlLtKlKjpjtCQBPMoRPfku0Dgugsdn0=;
 b=TiJRjx0TRx3QNzotRnbdNh5nHRMtQq/s48OL58UJIPl4WCgIIR33SW/YkZXvUSAOhG
 8dB8waJ9lAddDz+vfgNFk2a+TCpHYRiWVXuYP95VKLIDkzB59dn9EFNo5dze2mwoxVwf
 FSM8l8NXTk9vLhCdNt37NX58zzQp+Kpif4Dk8eEUS0RSuQzU41nz34NnfzF5vLqr+4VZ
 cA7kxBSzvmgBS3whLb0E5bPSyxk0W3w6hfecM/4lAYNc0398D4cjdMFPZn9O+pdRzARj
 JcsguBNaAGsOuRkHlI/TErUKt7jGi+wivq2k62ReS4EXszbqeY43dTqhUpVsa+p0cWQc
 4Qig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbKD6XY8ayxE58VLvVB4hhQlFWisWqXy93mhm4vDXFNeoNZtXVovMMInD0+XL1RDGqJ9kyuzxPGMkp@nongnu.org
X-Gm-Message-State: AOJu0Yz6y4VlY2M6FAj8WqeAgBYeSLMs1dHJrFtNFAS3f0Mz6b2waaNG
 LTdS92ahcu//YE9W+gP57651/gKOrJALpPJZdrOksijJFNkGvrT4Wd0OV8hMbFbQx82PHKxsm/c
 2LEfqLhCgvnI0E3d4HuMGewEljkPuv5g++DL17g==
X-Google-Smtp-Source: AGHT+IFjn2blNlMfpQACHivKsp9BQJZP9JW3FhAnDyjxf1eGfx5X38Wob8Qvh0daJtNTWXk/basa/cFFqdXDZJVE/hs=
X-Received: by 2002:a05:6402:26c9:b0:5cb:7318:aa2a with SMTP id
 4fb4d7f45d1cf-5cbbf8897c5mr19439818a12.7.1730373997823; Thu, 31 Oct 2024
 04:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241030140656.36540-1-abelova@astralinux.ru>
 <CAGCz3vuqRAkPtRRpqbPM+3z5iqVHOkr5fYotmva=6uqA7JnGcQ@mail.gmail.com>
 <ZyLPzbDy_0cI7HyD@gallifrey>
 <CAFEAcA8r-TtExvoxU7qDV+QpjU3fPFH2hexsog+kbpRo++V3gQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8r-TtExvoxU7qDV+QpjU3fPFH2hexsog+kbpRo++V3gQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 11:26:26 +0000
Message-ID: <CAFEAcA-3+jX3=TmM=yYq9D+4nh5yKZa2kRtw9qpxjBeFmMSYDQ@mail.gmail.com>
Subject: Re: [PATCH] monitor: fix cases in switch in memory_dump
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Phil Dennis-Jordan <lists@philjordan.eu>,
 Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org, 
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Thu, 31 Oct 2024 at 10:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 31 Oct 2024 at 00:32, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> >
> > * Phil Dennis-Jordan (lists@philjordan.eu) wrote:
> > > On Wed 30. Oct 2024 at 15:09, Anastasia Belova <abelova@astralinux.ru>
> > > wrote:
> > >
> > > > default case has no condition. So if it is placed
> > > > higher that other cases, they are unreachable.
> > > >
> > > > Move dafult case down.
> > > >
> > >
> > > The stylistic merits might be debatable, but: the order of cases in a
> > > switch block in C does not matter, the default case can appear anywhere.
> > > The other cases are still reachable. So at minimum, the commit message is
> > > incorrect.
> >
> > I'd agree;  the analysis is wrong - it works as intended.
> > As for style, I'd normally agree that 'default' at end makes sense,
> > but:
> >   a) I hate duplicating code
> >   b) in a way this reads nicely:
> >                  default:
> >                  case 1:
> >
> >       'default is the same as case 1'.
>
> Is it actually possible to get here with a wsize that
> isn't 1,2,4 or 8, though? This function is used only
> by the hmp 'x' and 'xp' commands. Those document that
> the valid size specifications are b, h, w or g (for
> 8, 16, 32 or 64 bits), and monitor_parse_arguments()
> doesn't seem to have any undocumented handling that
> would result in a different size value. And the
> code in memory_dump() doesn't do anything sensible
> with a wsize other than 1, 2, 4 or 8 -- if you hand
> it a wsize of 3, for instance, I think it will print
> every third byte.
>
> So I think that probably the default case here should
> be g_assert_not_reached().

...better still, we could replace the whole switch(wsize)
with "v = ldn_p(buf + i, wsize);".

-- PMM

