Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A941EC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdAMK-0008AL-3r; Thu, 22 Feb 2024 09:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdAMC-00089L-EU
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:47:31 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdAM8-0001ns-Hp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:47:26 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3ed9cae56fso189013266b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708613243; x=1709218043; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3k0V/5ByfnN7jzaqNQMhQH/46uxwtmhIfstnbZAkMgQ=;
 b=PZAMTPWoBMejaEyWDByc1LS3Kr+ROVma0KZJQQC4YJad/hhdgO813/ISSknCIi9W7o
 qrOyiuAd80cGXBgGEATH8tVj9Up9/N4L3CijChZ21lnZVW8wbQtobKm0sBKZisq2OLE4
 QcnQBWN9fzsYUfZ8dxWXD0mBBSswnitsrg5hHWddhBenU4EGfEvBDEP+HHv5ptOEa8FP
 pb3fxGKGWtd1+fVbMs0kcA6B5KURV2p6f5rwQaRS26O9ukjNTa3ptQshiai8jxD4MDcs
 aLUSBalNqUcOrlaWvPpNyKCFGJQGorbKwRVg4L9nHWgPbpXMB1x12Nd8YzzEQBN86uRc
 UzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708613243; x=1709218043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3k0V/5ByfnN7jzaqNQMhQH/46uxwtmhIfstnbZAkMgQ=;
 b=mzeLh9HUT9iYerKuriEXnEXde6psRqT3V2TjVvbgqochi8WssbL13y8W6ZpaPOXWvw
 3ivC4hpTZTxlVlPY/8+W7r9XeCGooEp5RvUDs9x1IGr+xQ2/FCl18AgWiDfSpa0b0o3T
 6j1FTbdF/P9ZjkGxjVVtifcfkgvAqsQBgG3aftYqIsB6iuYadCO6LJLWzomYKFHXoBYL
 yS/QU69FCFzRX7HhH9Z3Syevw54DlucGFpmWhh+FuEZqHYq+SowOJM502bc8W5tDAtyy
 t4Od/JVZGvPmSNKzkmG2XAr5k1lBkC/I3VqyCIwRU/81BWGpQ4BDub/9vAfaaL0o+I6i
 VHDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHqKBA0Bbgkodom34CqMG8RFItg3PaDgm+rkNeJXH0ZiTxznHw9PPIYeQcJwBHD3ng6uj1RRJC7Of/8Nv8nAXbiET6UDE=
X-Gm-Message-State: AOJu0Yxpewr9IXkOyW8WBxx3U+MzMEXhMkpqBqeG6A9nPQ1cXTJj8kG0
 n/MP+tX69UgfQJCUVz6y3HYHe7mP/x7R8HMqa4KQpIxYgp39BuNghYGK0x3MH+ZeTQRi7hNp7GB
 wp2OI22u9+xzHBhTiMCwlMuASHsx6fvW6NNhBCA==
X-Google-Smtp-Source: AGHT+IHJTBznKgIITQWvTpkLIu+niVt6zhWPI5ExJdOQFcyIIAUsdEQH3ksYjzruYCHB+Z1BhILAiTNNYepvkvLrX7o=
X-Received: by 2002:a17:906:f0c4:b0:a3e:719b:c049 with SMTP id
 dk4-20020a170906f0c400b00a3e719bc049mr2380954ejb.28.1708613242875; Thu, 22
 Feb 2024 06:47:22 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com>
 <87le8byg5f.fsf@pond.sub.org>
 <CAFEAcA-kTwM2U3VE0rX-hZt-5AAVPz7Vc-WEwwqndz+Liie=3Q@mail.gmail.com>
 <ZbciScVElxltEawe@zatzit>
In-Reply-To: <ZbciScVElxltEawe@zatzit>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 14:47:12 +0000
Message-ID: <CAFEAcA_EHCcxfMMT8nFJfxmtX6K8j2mVfWFgSdmLgjTU2Br+uw@mail.gmail.com>
Subject: Re: spapr watchdog vs watchdog_perform_action() / QMP
 watchdog-set-action
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc <qemu-ppc@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Jan 2024 at 04:02, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Sat, Jan 27, 2024 at 01:08:02PM +0000, Peter Maydell wrote:
> > On Fri, 26 Jan 2024 at 20:49, Markus Armbruster <armbru@redhat.com> wrote:
> > >
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > >
> > > > Hi; one of the "bitesized tasks" we have listed is to convert
> > > > watchdog timers which directly call qemu_system_reset_request() on
> > > > watchdog timeout to call watchdog_perform_action() instead. This
> > > > means they honour the QMP commands that let the user specifiy
> > > > the behaviour on watchdog expiry:
> > > > https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-141
> > > > https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-129
> > > > (choices include reset, power off the system, do nothing, etc).
> > > >
> > > > There are only a few remaining watchdogs that don't use the
> > > > watchdog_perform_action() function. In most cases the change
> > > > is obvious and easy: just make them do that instead of calling
> > > > qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).
> > > >
> > > > However, the hw/watchdog/spapr_watchdog.c case is trickier. As
> > > > far as I can tell from the sources, this is a watchdog set up via
> > > > a hypercall, and the guest makes a choice of "power off, restart,
> > > > or dump and restart" for its on-expiry action.
> > > >
> > > > What should this watchdog's interaction with the watchdog-set-action
> > > > QMP command be? If the user says "do X" and the guest says "do Y",
> > > > which do we do? (With the current code, we always honour what
> > > > the guest asks for and ignore what the user asks for.)
> > >
> > > Gut reaction: when the user says "do X", the guest should not get a say.
> > > But one of the values of X could be "whatever the guest says".
>
> That would also be my inclination.
>
> > Mmm. Slightly awkwardly, we don't currently distinguish between
> > "action is reset because the user never expressed a preference"
> > and "action is reset because the user specifically asked for that",
> > but I guess in theory we could make that distinction. (Conveniently
> > there is no QMP action for "query current watchdog-action state",
> > so we don't need to worry about reflecting that distinction in the
> > QMP interface if we make it.)
>
> I think that change is necessary in order to accomodate this sort of
> watchdog with guest-progammable behaviour (which is part of the PAPR
> spec, so we shouldn't just ignore it).

I've now filed https://gitlab.com/qemu-project/qemu/-/issues/2185
to track the spapr-watchdog vs watchdog-set-action missing feature
that we've discussed in this thread. (I haven't marked it as a
"bite-sized feature", though I think it probably could be one if
somebody familiar with at least one of spapr or QMP wanted to
flesh out the required changes a bit.)

-- PMM

